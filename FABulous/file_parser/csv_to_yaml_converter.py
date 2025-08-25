"""CSV to YAML Converter for FABulous Fabric Definitions.

This module provides functionality to convert existing CSV-based fabric definitions to
the new YAML format while maintaining compatibility and providing a smooth migration
path.
"""

import csv
import re
from pathlib import Path
from typing import Any

import yaml
from loguru import logger

from FABulous.fabric_definition.define import ConfigBitMode, MultiplexerStyle


class CSVToYAMLConverter:
    """Converts CSV fabric definitions to YAML format."""

    def __init__(self, csv_fabric_path: Path) -> None:
        """Initialize the converter with a CSV fabric file path.

        Args:
            csv_fabric_path: Path to the main fabric.csv file
        """
        self.csv_fabric_path = Path(csv_fabric_path)
        self.fabric_dir = self.csv_fabric_path.parent

    def convert_fabric(self, output_path: Path | None = None) -> Path:
        """Convert entire fabric CSV to YAML format.

        Args:
            output_path: Optional output path for YAML file

        Returns:
            Path to the generated YAML file
        """
        if output_path is None:
            output_path = self.csv_fabric_path.with_suffix(".yaml")

        fabric_config = self._parse_fabric_csv()

        # Write YAML file
        with open(output_path, "w") as f:
            yaml.dump(fabric_config, f, default_flow_style=False, sort_keys=False)

        logger.info(f"Converted fabric from {self.csv_fabric_path} to {output_path}")
        return output_path

    def _parse_fabric_csv(self) -> dict[str, Any]:
        """Parse the main fabric CSV file and extract configuration.

        Returns:
            Dictionary containing fabric configuration in YAML format
        """
        fabric_config = {"PARAM": {}, "TILES": [], "FABRIC": []}

        with open(self.csv_fabric_path) as f:
            reader = csv.reader(f)
            rows = list(reader)

        # Extract parameters from CSV
        param_section = True
        fabric_rows = []

        for row in rows:
            if not row or len(row) == 0:
                continue

            # Check if we're in fabric layout section
            if row[0] in ["NULL", "Null"] or any(
                self._looks_like_tile_name(cell) for cell in row
            ):
                param_section = False
                fabric_rows.append(row)
                continue

            # Check if it's a tile definition
            if param_section and len(row) >= 2:
                key, value = row[0], row[1]
                fabric_config["PARAM"][key] = self._convert_param_value(key, value)

        # Parse fabric layout
        if fabric_rows:
            # Find tiles referenced in fabric
            referenced_tiles = set()
            for row in fabric_rows:
                for cell in row:
                    if cell and cell not in ["NULL", "Null", ""]:
                        referenced_tiles.add(cell)

            # Add tile files
            for tile_name in referenced_tiles:
                tile_csv_path = (
                    self.fabric_dir / "Tile" / tile_name / f"{tile_name}.csv"
                )
                if tile_csv_path.exists():
                    fabric_config["TILES"].append(
                        str(tile_csv_path.relative_to(self.fabric_dir))
                    )

            fabric_config["FABRIC"] = fabric_rows

        return fabric_config

    def _looks_like_tile_name(self, cell: str) -> bool:
        """Check if a cell looks like a tile name."""
        if not cell or cell in ["NULL", "Null", ""]:
            return False
        # Simple heuristic: tile names are usually alphanumeric with underscores
        return bool(re.match(r"^[A-Za-z][A-Za-z0-9_]*$", cell))

    def _convert_param_value(self, key: str, value: str) -> Any:
        """Convert parameter values to appropriate types."""
        # Handle special cases
        if key in ["ConfigBitMode"]:
            try:
                return ConfigBitMode[value.upper()].value
            except (KeyError, AttributeError):
                return value

        if key in ["MultiplexerStyle"]:
            try:
                return MultiplexerStyle[value.upper()].value
            except (KeyError, AttributeError):
                return value

        if key in ["SuperTileEnable"]:
            return value.lower() in ["true", "1", "yes", "on"]

        # Try to convert to int
        try:
            return int(value)
        except ValueError:
            pass

        # Try to convert to float
        try:
            return float(value)
        except ValueError:
            pass

        # Return as string
        return value

    def convert_tile_csv_to_yaml(
        self, tile_csv_path: Path, output_path: Path | None = None
    ) -> Path:
        """Convert a tile CSV file to YAML format.

        Args:
            tile_csv_path: Path to tile CSV file
            output_path: Optional output path for YAML file

        Returns:
            Path to the generated YAML tile file
        """
        if output_path is None:
            output_path = tile_csv_path.with_suffix(".yaml")

        tile_config = self._parse_tile_csv(tile_csv_path)

        with open(output_path, "w") as f:
            yaml.dump(tile_config, f, default_flow_style=False, sort_keys=False)

        logger.info(f"Converted tile from {tile_csv_path} to {output_path}")
        return output_path

    def _parse_tile_csv(self, tile_csv_path: Path) -> dict[str, Any]:
        """Parse a tile CSV file and extract configuration.

        Args:
            tile_csv_path: Path to the tile CSV file

        Returns:
            Dictionary containing tile configuration in YAML format
        """
        tile_config = {"TILE": tile_csv_path.stem, "PORTS": [], "BELS": [], "WIRES": []}

        # This is a simplified implementation - in a real converter you'd need
        # to parse the CSV structure more carefully
        with open(tile_csv_path) as f:
            reader = csv.reader(f)
            rows = list(reader)

        # Simple port extraction (adapt based on actual CSV format)
        for row in rows:
            if not row or len(row) < 4:
                continue

            # Assuming CSV format: direction, source_name, X-offset, Y-offset, destination_name, wires
            if len(row) >= 6 and row[0] in ["NORTH", "SOUTH", "EAST", "WEST"]:
                port_entry = {
                    "name": row[1] if row[1] != "NULL" else row[4],
                    "inOut": "INPUT" if row[1] == "NULL" else "OUTPUT",
                    "side": row[0],
                    "wires": int(row[5]) if row[5].isdigit() else 1,
                }
                tile_config["PORTS"].append(port_entry)

                # Add wire information
                if (
                    int(row[2]) != 0 or int(row[3]) != 0
                ):  # X-offset or Y-offset non-zero
                    wire_entry = {
                        "X-offset": int(row[2]),
                        "Y-offset": int(row[3]),
                        "source_name": row[1],
                        "destination_name": row[4],
                    }
                    tile_config["WIRES"].append(wire_entry)

        return tile_config

    def batch_convert(self, output_dir: Path | None = None) -> list[Path]:
        """Convert all CSV files in the fabric directory to YAML.

        Args:
            output_dir: Optional output directory for YAML files

        Returns:
            List of paths to generated YAML files
        """
        if output_dir is None:
            output_dir = self.fabric_dir / "yaml_converted"

        output_dir.mkdir(exist_ok=True)
        converted_files = []

        # Convert main fabric file
        fabric_yaml = self.convert_fabric(output_dir / "fabric.yaml")
        converted_files.append(fabric_yaml)

        # Convert tile files
        tiles_dir = self.fabric_dir / "Tile"
        if tiles_dir.exists():
            for tile_dir in tiles_dir.iterdir():
                if tile_dir.is_dir():
                    tile_csv = tile_dir / f"{tile_dir.name}.csv"
                    if tile_csv.exists():
                        tile_yaml = self.convert_tile_csv_to_yaml(
                            tile_csv,
                            output_dir
                            / "Tile"
                            / tile_dir.name
                            / f"{tile_dir.name}.yaml",
                        )
                        # Make sure output directory exists
                        tile_yaml.parent.mkdir(parents=True, exist_ok=True)
                        tile_yaml = self.convert_tile_csv_to_yaml(tile_csv, tile_yaml)
                        converted_files.append(tile_yaml)

        logger.info(
            f"Batch conversion complete. {len(converted_files)} files converted."
        )
        return converted_files


def main() -> None:
    """Command-line interface for the converter."""
    import argparse

    parser = argparse.ArgumentParser(
        description="Convert CSV fabric definitions to YAML"
    )
    parser.add_argument("csv_path", type=Path, help="Path to CSV fabric file")
    parser.add_argument("-o", "--output", type=Path, help="Output YAML file path")
    parser.add_argument(
        "--batch", action="store_true", help="Convert all CSV files in directory"
    )

    args = parser.parse_args()

    converter = CSVToYAMLConverter(args.csv_path)

    if args.batch:
        converter.batch_convert(args.output)
    else:
        converter.convert_fabric(args.output)


if __name__ == "__main__":
    main()
