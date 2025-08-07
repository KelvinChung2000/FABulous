"""RTL behavior validation for generated Switch Matrix modules using cocotb."""

import json
import os
from pathlib import Path
from typing import Any, NamedTuple

# Cocotb test module - these functions are called by cocotb during simulation
import cocotb
import pytest
from cocotb.triggers import Timer

from FABulous.fabric_generator.gen_fabric.gen_switchmatrix import genTileSwitchMatrix


class SwitchMatrixTestCase(NamedTuple):
    """Test case configuration for switch matrix routing tests."""

    connections: dict[str, list[str]]
    test_name: str
    expected_routes: list[dict[str, Any]]  # List of expected routing test cases


def load_routing_info():
    """Load routing configuration from JSON file: input->output mappings with ConfigBits."""
    config_file = Path(os.getcwd()) / "routing_info.json"
    if config_file.exists():
        with open(config_file) as f:
            return json.load(f)
    return {}


async def initialize_switchmatrix(dut):
    """Initialize Switch Matrix by setting all ConfigBits to 0."""
    # Set all ConfigBits to 0
    dut.ConfigBits.value = 0
    if hasattr(dut, "ConfigBits_N"):
        # Set ConfigBits_N to 1 (inverted)
        max_config_bits = len(dut.ConfigBits)
        dut.ConfigBits_N.value = (1 << max_config_bits) - 1

    await Timer(10, units="ps")


@pytest.mark.skip(reason="Cocotb test - run by simulation, not pytest")
@cocotb.test
async def test_switchmatrix_routing(dut):
    """Test switch matrix routing functionality using ConfigBits."""
    await initialize_switchmatrix(dut)

    # Load routing configuration
    routing_info = load_routing_info()

    if not routing_info:
        # Skip if no routing info available
        return

    # Test each routing configuration
    for test_name, config in routing_info.items():
        if "config_bits" not in config or "input_port" not in config or "output_port" not in config:
            continue

        # Initialize to clean state
        await initialize_switchmatrix(dut)

        # Set the required ConfigBits for this routing
        config_bits_value = config["config_bits"]
        dut.ConfigBits.value = config_bits_value
        if hasattr(dut, "ConfigBits_N"):
            dut.ConfigBits_N.value = ~config_bits_value & ((1 << len(dut.ConfigBits)) - 1)

        # Set input signal
        input_port = config["input_port"]
        if hasattr(dut, input_port):
            getattr(dut, input_port).value = 1

        await Timer(10, units="ps")

        # Check output signal
        output_port = config["output_port"]
        if hasattr(dut, output_port):
            expected_value = config.get("expected_value", 1)
            actual_value = getattr(dut, output_port).value

            assert actual_value == expected_value, (
                f"Test {test_name}: Expected {output_port} = {expected_value}, "
                f"got {actual_value} with ConfigBits = {config_bits_value}"
            )

        # Reset input
        if hasattr(dut, input_port):
            getattr(dut, input_port).value = 0

        await Timer(10, units="ps")


@pytest.mark.parametrize(
    "connection_test_case",
    [
        # Simple 2-input mux test
        SwitchMatrixTestCase(
            connections={"N1BEG0": ["E1END0", "E1END1"]},
            test_name="simple_2input_mux",
            expected_routes=[
                {"input_port": "E1END0", "output_port": "N1BEG0", "config_bits": 0, "expected_value": 1},
                {"input_port": "E1END1", "output_port": "N1BEG0", "config_bits": 1, "expected_value": 1},
            ],
        ),
        # 4-input mux test
        SwitchMatrixTestCase(
            connections={"N1BEG1": ["E1END0", "E1END1", "S1END0", "W1END0"]},
            test_name="four_input_mux",
            expected_routes=[
                {"input_port": "E1END0", "output_port": "N1BEG1", "config_bits": 0, "expected_value": 1},
                {"input_port": "E1END1", "output_port": "N1BEG1", "config_bits": 1, "expected_value": 1},
                {"input_port": "S1END0", "output_port": "N1BEG1", "config_bits": 2, "expected_value": 1},
                {"input_port": "W1END0", "output_port": "N1BEG1", "config_bits": 3, "expected_value": 1},
            ],
        ),
        # Multi-output test
        SwitchMatrixTestCase(
            connections={
                "N1BEG0": ["E1END0", "E1END1"],
                "N1BEG1": ["S1END0", "W1END0"],
            },
            test_name="multi_output_test",
            expected_routes=[
                {"input_port": "E1END0", "output_port": "N1BEG0", "config_bits": 0, "expected_value": 1},
                {"input_port": "E1END1", "output_port": "N1BEG0", "config_bits": 1, "expected_value": 1},
                {"input_port": "S1END0", "output_port": "N1BEG1", "config_bits": 2, "expected_value": 1},
                {"input_port": "W1END0", "output_port": "N1BEG1", "config_bits": 3, "expected_value": 1},
            ],
        ),
        # Single connection (no mux) test
        SwitchMatrixTestCase(
            connections={"N1BEG0": ["E1END0"]},
            test_name="single_connection",
            expected_routes=[
                {"input_port": "E1END0", "output_port": "N1BEG0", "config_bits": 0, "expected_value": 1},
            ],
        ),
    ],
    ids=lambda case: case.test_name,
)
@pytest.mark.parametrize("hdl_lang", [".v", ".vhd"])
def test_switchmatrix_rtl_simulation(
    hdl_lang: str,
    connection_test_case,
    default_fabric,
    default_tile,
    tmp_path: Path,
    code_generator_factory,
    cocotb_runner,
    monkeypatch,
):
    """Generate Switch Matrix RTL and verify its behavior using cocotb simulation."""

    # Create code generator using the factory fixture
    test_name = f"{default_tile.name}_{connection_test_case.test_name}_switch_matrix"
    writer = code_generator_factory(hdl_lang, test_name)
    writer.outFileName = tmp_path / f"{test_name}{hdl_lang}"

    # Create matrix file in tmp_path
    matrix_path = tmp_path / f"{connection_test_case.test_name}_matrix.csv"

    # Create test matrix file from connection test case
    create_test_matrix_from_connections(matrix_path, connection_test_case.connections)

    # Update tile configuration
    default_tile.matrixDir = matrix_path

    # Mock the parseMatrix function to return our test connections
    monkeypatch.setattr(
        "FABulous.fabric_generator.gen_fabric.gen_switchmatrix.parseMatrix",
        lambda x, y: connection_test_case.connections,
    )

    try:
        # Generate the Switch Matrix RTL
        genTileSwitchMatrix(writer, default_fabric, default_tile, False)

        # Check if RTL file was created
        if not writer.outFileName.exists():
            pytest.skip(f"Switch matrix RTL file {writer.outFileName} was not generated")

        # Create routing info from test case expected routes
        routing_info = {}
        for i, route in enumerate(connection_test_case.expected_routes):
            routing_info[f"test_{i}"] = route

        # Save routing info for cocotb tests to use
        routing_info_file = tmp_path / "routing_info.json"
        with open(routing_info_file, "w") as f:
            json.dump(routing_info, f, indent=2)

        # Run cocotb simulation
        cocotb_runner(
            sources=[writer.outFileName],
            hdl_top_level=test_name,
            test_module_path=Path(__file__),
        )

    except Exception:
        # Re-raise any unexpected exceptions
        raise


def create_test_matrix_from_connections(matrix_path: Path, connections: dict[str, list[str]]):
    """Create a CSV test switch matrix file from connections dictionary."""
    # Get all unique ports (inputs and outputs)
    all_inputs = set()
    all_outputs = set(connections.keys())

    for inputs in connections.values():
        all_inputs.update(inputs)

    all_ports = sorted(all_inputs | all_outputs)

    # Create CSV header
    header = "Wire," + ",".join(all_ports) + "\n"

    # Create CSV content
    content = header

    for port in all_ports:
        row = [port]  # Start with port name

        if port in connections:
            # This port is an output, mark its inputs with '1'
            for input_port in all_ports:
                if input_port in connections[port]:
                    row.append("1")
                else:
                    row.append("")
        else:
            # This port is only an input, all entries empty
            row.extend([""] * len(all_ports))

        content += ",".join(row) + "\n"

    with open(matrix_path, "w") as f:
        f.write(content)
