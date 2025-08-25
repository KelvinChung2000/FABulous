# YAML Migration Guide for FABulous

This guide explains how to migrate from CSV-based fabric definitions to the new YAML format, providing improved expressiveness and maintainability.

## Overview

The new YAML frontend for FABulous provides:
- **Better structure** with hierarchical organization
- **Advanced features** like sub-tiles, complex port hierarchies, and sophisticated wire management
- **Backward compatibility** through legacy property support
- **Easy migration** with automated conversion tools

## Quick Start

### Using YAML Files

You can now use YAML files directly with FABulous API:

```python
from FABulous.FABulous_API import FABulous_API
from FABulous.fabric_generator.code_generator.code_generator_Verilog import VerilogCodeGenerator

# Create writer
writer = VerilogCodeGenerator()

# Load YAML fabric directly
api = FABulous_API(writer, "path/to/fabric.yaml")

# Or load after initialization
api = FABulous_API(writer)
api.loadFabric(Path("path/to/fabric.yaml"))
```

### Basic YAML Structure

```yaml
PARAM:
  Name: "MyFPGAFabric"
  ConfigBitMode: "FRAME_BASED"
  FrameBitsPerRow: 32
  MaxFramesPerCol: 32
  MultiplexerStyle: "CUSTOM"
  SuperTileEnable: true

TILES:
  - "Tile/LUT4AB/LUT4AB.yaml"
  - "Tile/DSP/DSP.yaml"

FABRIC:
  - ["LUT4AB", "LUT4AB", "DSP"]
  - ["LUT4AB", "LUT4AB", "NULL"]
```

## Migration Process

### Automatic Conversion

Use the built-in converter to migrate existing CSV files:

```python
from FABulous.file_parser.csv_to_yaml_converter import CSVToYAMLConverter
from pathlib import Path

# Convert single fabric file
converter = CSVToYAMLConverter(Path("fabric.csv"))
yaml_path = converter.convert_fabric("fabric.yaml")

# Batch convert entire directory
converted_files = converter.batch_convert(Path("output_directory"))
```

### Command Line Usage

```bash
python -m FABulous.file_parser.csv_to_yaml_converter fabric.csv -o fabric.yaml
python -m FABulous.file_parser.csv_to_yaml_converter fabric.csv --batch
```

## YAML Format Specification

### Fabric-Level Configuration

```yaml
PARAM:
  Name: "FabricName"                    # Fabric name
  ConfigBitMode: "FRAME_BASED"         # or "FLIPFLOP_CHAIN"
  FrameBitsPerRow: 32                  # Frame bits per row
  MaxFramesPerCol: 32                  # Max frames per column
  ContextCount: 1                      # Context count for multi-context
  MultiplexerStyle: "CUSTOM"           # or "GENERIC"
  Package: "use work.my_package.all"   # VHDL package (optional)
  GenerateDelayInSwitchMatrix: 80      # Delay in switch matrix
  FrameSelectWidth: 5                  # Frame select signal width
  RowSelectWidth: 5                    # Row select signal width
  SuperTileEnable: true                # Enable super tiles
```

### Tile Definitions

```yaml
TILE: "LUT4AB"

SUB_TILE_MAP:
  - ["LUT4AB_top"]
  - ["LUT4AB_bot"]

PORTS:
  LUT4AB_top:
    - name: "N1BEG0"
      inOut: "OUTPUT"
      side: "NORTH"
      wires: 4
    - name: "S1END0"
      inOut: "INPUT"
      side: "SOUTH"
      wires: 4

BELS:
  logic:
    - BEL: "LUT4c_frame_config_dffesr.v"
      prefix: "Inst_"
      param:
        MaxFramesPerCol: 32

WIRES:
  - X-offset: 0
    Y-offset: 1
    source_name: "N1BEG0"
    destination_name: "S1END0"

MATRIX: "LUT4AB_switch_matrix.list"
CONFIG_MEM: "LUT4AB_ConfigMem.csv"
```

## Advanced Features

### Sub-Tiles and Port Hierarchies

The new system supports complex tile structures:

```yaml
SUB_TILE_MAP:
  - ["DSP_top",    null]
  - ["DSP_shared", "DSP_bot"]

PORTS:
  DSP_top:
    - name: "CLK"
      inOut: "INPUT"
      side: "WEST"
      wires: 1
      terminal: true
  DSP_shared:
    - name: "DATA_BUS"
      inOut: "INOUT"
      side: "ANY"
      wires: 32
```

### Advanced Port Types

Different port types for specialized functionality:

```python
from FABulous.fabric_definition.Port import TilePort, BelPort, ConfigPort

# Tile ports with location and terminal information
tile_port = TilePort(
    name="CLK_IN",
    ioDirection=IO.INPUT,
    width=1,
    sideOfTile=Side.WEST,
    terminal=True
)

# BEL ports with prefixes and control signals
bel_port = BelPort(
    name="DATA",
    ioDirection=IO.INPUT,
    width=8,
    prefix="Inst_",
    external=False,
    control=True
)
```

### Enhanced Switch Matrix

Support for sophisticated routing structures:

```yaml
MATRIX: "switch_matrix.py"  # Python-based matrix generation
# or
MATRIX: "switch_matrix.list"  # Traditional list format
```

## Backward Compatibility

### Legacy Properties

The new system maintains compatibility with existing code:

```python
# These properties still work
fabric.numberOfRows    # -> fabric.height
fabric.numberOfColumns # -> fabric.width
fabric.tileDic         # -> fabric.tileDict
tile.portsInfo        # -> flattened tile.ports
tile.globalConfigBits # -> tile.configBits
```

### Gradual Migration

You can migrate incrementally:

1. **Start**: Convert fabric.csv to fabric.yaml
2. **Enhance**: Add advanced features to YAML files
3. **Optimize**: Leverage new data structures
4. **Complete**: Phase out CSV support

## Best Practices

### File Organization

```
MyFabric/
├── fabric.yaml              # Main fabric definition
├── Tile/
│   ├── LUT4AB/
│   │   ├── LUT4AB.yaml      # Tile definition
│   │   ├── LUT4AB.v         # BEL implementations
│   │   └── matrix.list      # Switch matrix
│   └── DSP/
│       ├── DSP.yaml
│       └── MULADD.v
```

### YAML Structure

- Use consistent indentation (2 spaces recommended)
- Group related configurations together
- Comment complex configurations
- Validate YAML syntax before use

### Performance Considerations

- YAML parsing is slightly slower than CSV but more expressive
- Use caching for frequently accessed fabric definitions
- Consider binary serialization for production systems

## Troubleshooting

### Common Issues

**Import Errors**: Ensure all modules are properly installed
```bash
pip install pyyaml loguru
```

**YAML Syntax Errors**: Validate your YAML files
```bash
python -c "import yaml; yaml.safe_load(open('fabric.yaml'))"
```

**Conversion Issues**: Check CSV format compatibility
```python
# Debug converter issues
from FABulous.file_parser.csv_to_yaml_converter import CSVToYAMLConverter
converter = CSVToYAMLConverter("fabric.csv")
# Check intermediate results
```

### Migration Checklist

- [ ] Test basic YAML parsing with minimal fabric
- [ ] Convert existing CSV files to YAML
- [ ] Validate converted files load correctly
- [ ] Update build scripts to use YAML files
- [ ] Test fabric generation with new format
- [ ] Update documentation and examples

## Future Enhancements

The YAML system provides a foundation for:
- **Schema validation** with formal YAML schemas
- **IDE support** with syntax highlighting and completion
- **Advanced features** like conditional compilation
- **Integration** with modern CAD flows

## Examples

See the `examples/` directory for complete YAML fabric definitions and migration examples.

## Support

For questions and issues:
- Check existing documentation
- Review test cases in `validation/`
- Submit issues to the project repository
