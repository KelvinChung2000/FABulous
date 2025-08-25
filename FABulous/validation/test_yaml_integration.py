"""Test suite for YAML integration with FABulous.

This module provides comprehensive testing for the YAML frontend and CSV-to-YAML
converter functionality.
"""

import tempfile
from pathlib import Path

import pytest
import yaml

from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.code_generator.code_generator_Verilog import (
    VerilogCodeGenerator,
)
from FABulous.FABulous_API import FABulous_API
from FABulous.file_parser.csv_to_yaml_converter import CSVToYAMLConverter
from FABulous.file_parser.file_parser_yaml import parseFabricYAML


class TestYAMLIntegration:
    """Test suite for YAML integration."""

    def test_basic_yaml_parsing(self) -> None:
        """Test basic YAML parsing functionality."""
        # Create minimal YAML fabric
        fabric_data = {
            "PARAM": {
                "Name": "TestFabric",
                "ConfigBitMode": "FRAME_BASED",
                "FrameBitsPerRow": 32,
                "MaxFramesPerCol": 32,
            },
            "TILES": [],
            "FABRIC": [["NULL"]],
        }

        with tempfile.NamedTemporaryFile(mode="w", suffix=".yaml", delete=False) as f:
            yaml.dump(fabric_data, f)
            yaml_path = Path(f.name)

        try:
            # Test parsing
            fabric = parseFabricYAML(yaml_path)

            # Validate fabric properties
            assert fabric.name == "TestFabric"
            assert fabric.width == 1
            assert fabric.height == 1
            assert fabric.frameBitsPerRow == 32
            assert fabric.maxFramesPerCol == 32

        finally:
            yaml_path.unlink()

    def test_fabulous_api_yaml_support(self) -> None:
        """Test FABulous_API with YAML files."""
        # Create minimal YAML fabric
        fabric_data = {
            "PARAM": {
                "Name": "APITestFabric",
                "ConfigBitMode": "FRAME_BASED",
                "FrameBitsPerRow": 32,
                "MaxFramesPerCol": 32,
            },
            "TILES": [],
            "FABRIC": [["NULL"]],
        }

        with tempfile.NamedTemporaryFile(mode="w", suffix=".yaml", delete=False) as f:
            yaml.dump(fabric_data, f)
            yaml_path = Path(f.name)

        try:
            # Test FABulous_API with YAML
            writer = VerilogCodeGenerator()
            api = FABulous_API(writer, str(yaml_path))

            # Validate API loaded fabric correctly
            assert api.fabric.name == "APITestFabric"
            assert api.fabric.width == 1
            assert api.fabric.height == 1

            # Test loadFabric method
            api2 = FABulous_API(writer)
            api2.loadFabric(yaml_path)
            assert api2.fabric.name == "APITestFabric"

        finally:
            yaml_path.unlink()

    def test_csv_to_yaml_converter(self) -> None:
        """Test CSV to YAML conversion functionality."""
        # Create minimal CSV file
        csv_content = """Name,TestConvertFabric
ConfigBitMode,FRAME_BASED
FrameBitsPerRow,32
MaxFramesPerCol,32

NULL"""

        with tempfile.NamedTemporaryFile(mode="w", suffix=".csv", delete=False) as f:
            f.write(csv_content)
            csv_path = Path(f.name)

        try:
            # Test conversion
            converter = CSVToYAMLConverter(csv_path)
            yaml_path = converter.convert_fabric()

            # Validate YAML file was created
            assert yaml_path.exists()
            assert yaml_path.suffix == ".yaml"

            # Load and validate YAML content
            with yaml_path.open() as f:
                yaml_data = yaml.safe_load(f)

            assert "PARAM" in yaml_data
            assert "TILES" in yaml_data
            assert "FABRIC" in yaml_data

            # Clean up
            yaml_path.unlink()

        finally:
            csv_path.unlink()

    def test_roundtrip_compatibility(self) -> None:
        """Test that CSV->YAML->Fabric produces valid results."""
        # Create CSV file
        csv_content = """Name,RoundtripFabric
ConfigBitMode,FRAME_BASED
FrameBitsPerRow,32
MaxFramesPerCol,32

NULL"""

        with tempfile.NamedTemporaryFile(mode="w", suffix=".csv", delete=False) as f:
            f.write(csv_content)
            csv_path = Path(f.name)

        try:
            # Convert CSV to YAML
            converter = CSVToYAMLConverter(csv_path)
            yaml_path = converter.convert_fabric()

            try:
                # Parse YAML to Fabric
                fabric = parseFabricYAML(yaml_path)

                # Validate fabric is functional
                assert isinstance(fabric, Fabric)
                assert fabric.width > 0
                assert fabric.height > 0
                assert fabric.frameBitsPerRow > 0
                assert fabric.maxFramesPerCol > 0

            finally:
                yaml_path.unlink()

        finally:
            csv_path.unlink()

    def test_error_handling(self) -> None:
        """Test error handling in YAML parsing."""
        # Test invalid YAML file
        invalid_yaml = "invalid: yaml: content: ["

        with tempfile.NamedTemporaryFile(mode="w", suffix=".yaml", delete=False) as f:
            f.write(invalid_yaml)
            yaml_path = Path(f.name)

        try:
            with pytest.raises((yaml.YAMLError, Exception)):
                parseFabricYAML(yaml_path)
        finally:
            yaml_path.unlink()

    def test_data_structure_compatibility(self) -> None:
        """Test that new data structures work with existing code."""
        from FABulous.fabric_definition.define import IO, Side
        from FABulous.fabric_definition.Port import TilePort

        # Test creating objects with new structures
        port = TilePort(
            name="test_port", ioDirection=IO.INPUT, width=1, sideOfTile=Side.NORTH
        )

        assert port.name == "test_port"
        assert port.ioDirection == IO.INPUT
        assert port.width == 1
        assert port.sideOfTile == Side.NORTH

        # Test legacy compatibility properties
        fabric_data = {
            "PARAM": {
                "Name": "CompatFabric",
                "ConfigBitMode": "FRAME_BASED",
                "FrameBitsPerRow": 32,
                "MaxFramesPerCol": 32,
            },
            "TILES": [],
            "FABRIC": [["NULL"], ["NULL"]],
        }

        with tempfile.NamedTemporaryFile(mode="w", suffix=".yaml", delete=False) as f:
            yaml.dump(fabric_data, f)
            yaml_path = Path(f.name)

        try:
            fabric = parseFabricYAML(yaml_path)

            # Test legacy properties work
            assert fabric.numberOfRows == fabric.height
            assert fabric.numberOfColumns == fabric.width
            assert fabric.tileDic == fabric.tileDict

        finally:
            yaml_path.unlink()
