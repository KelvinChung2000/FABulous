# Testing Guide for FABulous

This comprehensive guide explains how to write and understand tests for the FABulous project using [pytest](https://docs.pytest.org/en/stable/) and [cocotb](https://docs.cocotb.org/en/stable/).

## Prerequisites

Here we assume all the development dependencies required by FABulous are already installed.

## Running Tests

To run all tests, use the following command at the top level directory:

```sh
pytest
```

To run a test file, use the following command at the top level directory:

```sh
pytest <path_to_test_file>
```

To run a specific test case use the following command at the top level directory:

```sh
pytest -k <name_of_test_case>
```

To run tests with verbose output:

```sh
pytest -v
```

For more details on what options can be used please check the pytest documentation.

## Test Structure Overview

The FABulous testing framework is organized into four main categories:

### 1. CLI Tests (`CLI_test/`)

Tests for the command-line interface functionality, including argument parsing and command execution.

### 2. Fabric Construction Tests (`fabric_construct_test/`)

RTL-level tests that validate individual hardware components like LUTs, RAMs, and multiplexers using cocotb simulation.

### 3. Fabric Generation Tests (`fabric_gen_test/`)

Unit and integration tests for the fabric generation system, including:

- Configuration memory generation (`configmem_test/`)
- Switch matrix generation (`switchmatrix_test/`)
- Tile generation (`tile_test/`)
- Top wrapper generation (`top_wrapper_test/`)
- Fabric integration (`fabric_test/`)

### 4. Utility Tests (`utils_test/`)

Tests for utility functions and helper modules.

## Testing Infrastructure

We use `pytest` as our primary testing framework with sophisticated fixture management and parametric testing capabilities.

### Key Testing Components

#### Core Fixtures

##### `tmp_path` Fixture

`tmp_path` is a built-in pytest fixture that provides a temporary directory unique to each test function. It's essential for file-based testing.

Example usage:

```python
def test_example(tmp_path: Path):
    project_dir = tmp_path / "my_test_project"
    # Your test code here
```

##### `cli` Fixture

The `cli` fixture provides a pre-configured instance of `FABulous_CLI` for testing. It:

- Creates a new project in a temporary directory
- Sets up the FABulous environment
- Loads the fabric configuration
- Returns a ready-to-use CLI instance

##### `run_cmd` Function

The `run_cmd` function executes CLI commands and captures their output:

```python
def test_cli_command(cli, caplog):
    run_cmd(cli, "your_command_here")
    log = normalize(caplog.text)
    
    # Check if "something" is in first line of log
    assert "something" in log[0] 
    
    # Or can do 
    assert "something" in caplog.text
```

### Reference Tests

A pytest-based framework for testing FABulous against reference projects with regression testing capabilities.

It automatically downloads reference projects from a GitHub repository,
runs specified FABulous commands, and compares the outputs against expected results using git-style diffs.

The default reference projects are hosted in the
[FABulous-demo-projects repo](https://github.com/FPGA-Research/FABulous-demo-projects)

For more information, please check the [reference_tests README](./reference_tests/README.md)



#### RTL Testing Fixtures

##### `cocotb_runner` Fixture

Factory fixture for creating cocotb runners for RTL simulation. Supports both Verilog and VHDL:

```python
def test_my_rtl_module(cocotb_runner):
    cocotb_runner(
        sources=[VERILOG_SOURCE_PATH / "my_module.v"],
        hdl_top_level="my_module",
        test_module_path=Path(__file__),
    )
```

#### Advanced Fixtures for Fabric Generation

##### `default_fabric` and `fabric_config`

Provides mock fabric objects for testing:

```python
def test_fabric_generation(default_fabric):
    # Use default_fabric with pre-configured parameters
    assert default_fabric.frameBitsPerRow == 32
```

##### `code_generator_factory`

Factory for creating code generators:

```python
def test_code_generation(code_generator_factory):
    generator = code_generator_factory(".v", "test_module")
    # Use generator for testing
```

## Test Types and Patterns

### 1. CLI Testing

CLI tests validate command execution and output:

```python
def test_load_fabric(cli: FABulous_CLI, caplog: pytest.LogCaptureFixture) -> None:
    """Test loading fabric from CSV file"""
    run_cmd(cli, "load_fabric")
    log = normalize_and_check_for_errors(caplog.text)
    assert "Loading fabric" in log[0]
    assert "Complete" in log[-1]
```

**Key patterns:**

- Use `run_cmd()` to execute commands
- Use `normalize_and_check_for_errors()` to process log output
- Validate both command success and expected log messages

### 2. RTL Testing with Cocotb

RTL tests simulate hardware behavior:

```python
def test_LUT4c_verilog_rtl(cocotb_runner: Callable[..., None]) -> None:
    """Test the LUT4c module with Verilog source."""
    cocotb_runner(
        sources=[VERILOG_SOURCE_PATH / "Tile" / "LUT4AB" / "LUT4c.v"],
        hdl_top_level="LUT4c_frame_config_dffesr",
        test_module_path=Path(__file__),
    )

# Cocotb test functions (called during simulation)
@cocotb.test()
async def test_basic_lut_functionality(dut):
    """Test basic LUT functionality."""
    # Set inputs
    dut.I.value = 0b1010
    dut.ConfigBits.value = 0xFFFF
    
    # Wait for propagation
    await Timer(10, units="ps")
    
    # Check output
    assert dut.O.value == expected_output
```

**Key patterns:**

- Separate test setup (using `cocotb_runner`) from cocotb test functions
- Use `@cocotb.test()` decorator for simulation test functions
- Handle both Verilog (`.v`) and VHDL (`.vhdl`) sources
- Use async/await for simulation timing

### 3. Unit Testing with Mocks

Unit tests validate individual components using mocks:

```python
def test_config_mem_generation(default_fabric, default_tile):
    """Test configuration memory generation."""
    config_mems = generateConfigMem(default_fabric, default_tile)
    
    assert len(config_mems) > 0
    assert all(isinstance(cm, ConfigMem) for cm in config_mems)
```

**Key patterns:**

- Use mock objects to isolate components
- Test both success cases and error conditions
- Validate return types and values

### 4. Parametric Testing

Parametric tests run the same test with different configurations:

```python
@pytest.fixture(params=[
    FabricConfig("StandardFabric", 32, 20),
    FabricConfig("SmallFabric", 8, 5),
    FabricConfig("MinimalFabric", 1, 1),
], ids=lambda config: config.name)
def fabric_config(request):
    return request.param

def test_fabric_with_various_configs(fabric_config):
    """Test fabric generation with different configurations."""
    # Test runs once for each parameter
    assert fabric_config.frame_bits_per_row > 0
```

## Writing New Tests

### Step 1: Choose the Right Test Category

- **CLI functionality** → `CLI_test/`
- **Individual hardware components** → `fabric_construct_test/`
- **Generation algorithms** → `fabric_gen_test/`
- **Utility functions** → `utils_test/`

### Step 2: Set Up Your Test File

```python
"""Test module docstring explaining what is being tested."""

from pathlib import Path
import pytest
from your.module.under.test import YourClass

def test_your_functionality():
    """Test function docstring."""
    # Your test implementation
    pass
```

### Step 3: Use Appropriate Fixtures

For CLI testing:

```python
def test_cli_command(cli, caplog):
    run_cmd(cli, "your_command")
    log = normalize_and_check_for_errors(caplog.text)
    assert "expected_output" in log[0]
```

For RTL testing:

```python
def test_rtl_module(cocotb_runner):
    cocotb_runner(
        sources=[PATH_TO_SOURCE / "module.v"],
        hdl_top_level="module_name",
        test_module_path=Path(__file__),
    )

@cocotb.test()
async def test_module_behavior(dut):
    # Simulation test implementation
    pass
```

For unit testing:

```python
def test_unit_function(tmp_path):
    # Create test files in tmp_path
    test_file = tmp_path / "test.txt"
    test_file.write_text("test content")
    
    # Test your function
    result = your_function(test_file)
    assert result == expected_value
```

### Step 4: Add Parametric Testing (Optional)

```python
@pytest.mark.parametrize("input_val,expected", [
    (1, 2),
    (2, 4),
    (3, 6),
])
def test_doubling_function(input_val, expected):
    assert double(input_val) == expected
```

## Best Practices

### 1. Test Naming

- Use descriptive names that explain what is being tested
- Follow pattern: `test_<functionality>_<scenario>`
- Example: `test_config_mem_generation_with_empty_tile`

### 2. Test Documentation

- Always include docstrings explaining the test purpose
- Document any complex setup or assertions
- Use clear, descriptive assertion messages

### 3. Fixture Usage

- Use appropriate fixtures for your test type
- Create custom fixtures for repeated setup
- Keep fixtures focused and reusable

### 4. Error Testing

- Test both success and failure cases
- Use `pytest.raises()` for expected exceptions:

  ```python
  def test_invalid_input_raises_error():
      with pytest.raises(ValueError, match="Invalid input"):
          function_with_invalid_input()
  ```

### 5. File-Based Testing

- Always use `tmp_path` for temporary files
- Clean up is automatic with `tmp_path`
- Use `Path` objects instead of strings for file paths

### 6. RTL Testing Specifics

- Test both Verilog and VHDL versions when available
- Use appropriate timing (`await Timer()`) for signal propagation
- Validate both functional behavior and edge cases
- Use protocols to define DUT interfaces for type safety

## Advanced Testing Concepts

### Mock Object Creation

Create sophisticated mock objects for complex testing:

```python
@pytest.fixture
def mock_tile(mocker):
    tile = mocker.create_autospec(Tile, spec_set=False)
    tile.name = "TestTile"
    tile.globalConfigBits = 64
    # Configure mock as needed
    return tile
```

### Factory Fixtures

Use factory patterns for flexible test data creation:

```python
@pytest.fixture
def config_factory():
    def _create_config(name, bits):
        return Configuration(name=name, bits=bits)
    return _create_config

def test_with_factory(config_factory):
    config = config_factory("test", 32)
    # Use config in test
```

### CSV Data Testing

Create and verify CSV files for configuration testing:

```python
def create_config_csv(file_path: Path, data: list[dict]) -> None:
    """Helper to create CSV files from dictionary data."""
    with file_path.open("w", newline="") as f:
        if data:
            writer = csv.DictWriter(f, fieldnames=data[0].keys())
            writer.writeheader()
            writer.writerows(data)

def verify_csv_content(file_path: Path, expected_rows: int = None) -> list[dict]:
    """Helper to verify and parse CSV content."""
    assert file_path.exists()
    # Verification logic...
```

## Integration with Development Workflow

### Running Tests During Development

```sh
# Run specific test category
pytest tests/CLI_test/

# Run only failed tests from last run  
pytest --lf
```

### Debugging Tests

```sh
# Run with Python debugger
pytest --pdb

# Show print statements
pytest -s

# Very verbose output
pytest -vv
```

This testing framework provides comprehensive coverage for all aspects of FPGA fabric generation and validation. The combination of pytest's flexibility with cocotb's hardware simulation capabilities creates a robust testing environment for both software and hardware components.
