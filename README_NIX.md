# FABulous Development Environment

This directory contains a Nix flake that provides a comprehensive development environment for FABulous and related FPGA tools.

## Features

This environment includes:

- **EDA Tools**: yosys, nextpnr, iverilog, ghdl, verilator, gtkwave
- **Java Development**: OpenJDK 17, Maven (for FABulator)  
- **Node.js**: Node.js runtime and npm
- **Python Management**: uv for modern Python dependency management
- **Development Tools**: git, vim, various utilities

## Quick Start

### Using Nix Flakes (Recommended)

1. Enable flakes in your Nix configuration or set the experimental feature:
   ```bash
   export NIX_CONFIG="experimental-features = nix-command flakes"
   ```

2. Enter the development shell:
   ```bash
   nix develop
   ```

3. Test that tools are available:
   ```bash
   test-tools
   ```

### Using traditional nix-shell

If you prefer the traditional approach:
```bash
nix-shell
```

### Setting up the environment

Once in the shell, you can:

1. Set up Python environment:
   ```bash
   setup-python
   ```

2. Clone and run FABulator:
   ```bash
   clone-fabulator
   cd FABulator
   mvn javafx:run
   ```

## Available Commands

- `test-tools` - Check availability of all tools
- `setup-python` - Set up Python environment with uv
- `clone-fabulator` - Clone the FABulator repository
- `run-fabulator` - Run FABulator (if in a FABulator source directory)
- `build-fabulator` - Build FABulator (if in a FABulator source directory)
- `install-nvm` - Install Node Version Manager

## Tools Included

### EDA Tools
- **yosys** - Verilog synthesis 
- **nextpnr** - Place and route tool
- **iverilog** - Icarus Verilog simulator
- **ghdl** - VHDL simulator with GCC backend
- **verilator** - Fast Verilog simulator
- **gtkwave** - Waveform viewer

### Development Tools
- **OpenJDK 17** - Java runtime and development kit
- **Maven** - Java build tool
- **Node.js** - JavaScript runtime
- **uv** - Fast Python package manager
- **git** - Version control

## Python Development

This environment uses `uv` instead of traditional pip/conda for Python package management:

```bash
# Initialize a new Python project
uv init

# Add dependencies
uv add <package-name>

# Run Python commands
uv run python script.py

# Sync dependencies from pyproject.toml
uv sync
```

## FABulator Development

To work with FABulator:

1. Clone the repository:
   ```bash
   git clone https://github.com/FPGA-Research/FABulator.git
   cd FABulator
   ```

2. Build and run:
   ```bash
   mvn javafx:run
   ```

## Troubleshooting

### Flake Issues
If you encounter flake-related errors, ensure you have:
1. Nix 2.4+ installed
2. Experimental features enabled
3. Internet connection for downloading dependencies

### Tool Not Found
Run `test-tools` to verify all tools are in PATH. If some tools are missing, the environment may still be building.

### Java/Maven Issues
Ensure JAVA_HOME is set correctly:
```bash
echo $JAVA_HOME
# Should point to the Java installation
```