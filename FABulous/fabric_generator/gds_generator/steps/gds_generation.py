"""
FABulous GDS Generator - Main GDS Generation Step

This module contains the main LibreLane step for FABulous GDS generation.
"""

from pathlib import Path
from typing import Any

from librelane.state import State
from librelane.steps import Step

from ..variables import ALL_FABULOUS_VARIABLES


class FABulousGDSGenerator(Step):
    """Main FABulous GDS Generator step that orchestrates the entire GDS generation
    process.

    This step replaces the monolithic gdsGenerator class with a proper LibreLane step
    that handles configuration, subprocess management, and state transitions.

    ## Configuration Variables

    ### Required Variables:
    - **DESIGN_NAME** (str): Name of the FABulous design
    - **FABRIC_CSV_PATH** (Path): Path to the fabric CSV configuration file
    - **OPENLANE_ROOT** (Path): Path to OpenLane installation directory

    ### Optional Variables:
    - **OUTPUT_DIR** (Path): Output directory for generated files (default: ./output)
    - **TEMP_DIR** (Path): Temporary directory for intermediate files (default: ./temp)
    - **FRAME_BITS_PER_ROW** (int): Configuration bits per frame row (default: 32)
    - **MAX_FRAMES_PER_COL** (int): Maximum frames per column (default: 20)

    ## Step Workflow

    1. **Parse Fabric Configuration**: Reads and parses the fabric CSV file
    2. **Create Directory Structure**: Sets up output directories
    3. **Generate Tiles**: Coordinates tile processing (delegated to TileProcessing step)
    4. **Assemble Fabric**: Coordinates fabric assembly (delegated to FabricAssembly step)
    5. **Generate Reports**: Creates comprehensive generation reports

    ## Inputs and Outputs

    **Inputs**: fabric_csv, tile_definitions, user_design_files
    **Outputs**: gds_files, lef_files, lib_files, def_files, generation_report

    ## Error Handling

    - Validates fabric CSV format and structure
    - Checks for required configuration parameters
    - Provides detailed error messages for configuration issues
    - Supports continuing on tile processing errors when configured

    ## Metrics Generated

    - fabric_tiles_count: Number of tiles in the fabric
    - fabric_width/height: Fabric dimensions in tiles
    - frame_bits_per_row: Configuration frame parameters
    - generation_time_seconds: Total generation time
    """

    inputs = ["fabric_csv", "tile_definitions", "user_design_files"]

    outputs = ["gds_files", "lef_files", "lib_files", "def_files", "generation_report"]

    config_vars = ALL_FABULOUS_VARIABLES

    def run(
        self, state_in: State, *args, **kwargs
    ) -> tuple[dict[str, Any], dict[str, Any]]:
        """Execute the FABulous GDS generation process.

        Args:
            state_in: Input state containing fabric configuration and design files

        Returns
        -------
            Tuple of (ViewsUpdate, MetricsUpdate)
        """
        self.info("Starting FABulous GDS generation process")

        # Initialize configuration
        design_name = self.config["DESIGN_NAME"]
        fabric_csv_path = self.config["FABRIC_CSV_PATH"]
        output_dir = self.config["OUTPUT_DIR"]

        self.info(f"Processing design: {design_name}")
        self.info(f"Fabric configuration: {fabric_csv_path}")
        self.info(f"Output directory: {output_dir}")

        # Create output directories
        self._create_output_directories(output_dir)

        # Process fabric configuration
        fabric_config = self._parse_fabric_configuration(fabric_csv_path)

        # Generate tiles
        tile_results = self._generate_tiles(fabric_config, state_in)

        # Assemble fabric
        fabric_results = self._assemble_fabric(tile_results, fabric_config)

        # Create reports and metrics
        self._generate_reports(fabric_results, tile_results)

        # Prepare return values
        views_update = {
            "gds_files": fabric_results.get("gds_files", []),
            "lef_files": fabric_results.get("lef_files", []),
            "lib_files": fabric_results.get("lib_files", []),
            "def_files": fabric_results.get("def_files", []),
            "generation_report": self.step_dir / "generation_report.txt",
        }

        metrics_update = {
            "total_tiles_generated": len(tile_results),
            "fabric_width_um": fabric_config.get("total_width", 0),
            "fabric_height_um": fabric_config.get("total_height", 0),
            "generation_time_seconds": self._get_generation_time(),
            "gds_file_count": len(fabric_results.get("gds_files", [])),
        }

        self.info("FABulous GDS generation completed successfully")
        return views_update, metrics_update

    def _create_output_directories(self, output_dir: Path) -> None:
        """Create necessary output directory structure."""
        self.info("Creating output directory structure")

        directories = [
            output_dir / "gds",
            output_dir / "lef",
            output_dir / "lib",
            output_dir / "def",
            output_dir / "reports",
        ]

        for directory in directories:
            directory.mkdir(parents=True, exist_ok=True)
            self.info(f"Created directory: {directory}")

    def _parse_fabric_configuration(self, fabric_csv_path: Path) -> dict[str, Any]:
        """Parse the fabric CSV configuration file using FABulous API.

        This method leverages the existing FABulous fabric parsing logic rather than
        reimplementing the CSV parsing from scratch.
        """
        self.info(
            f"Parsing fabric configuration using FABulous API from {fabric_csv_path}"
        )

        try:
            # Access the FABulous fabric object from state if available
            fabricGen = self.config.get("FABULOUS_FABRIC_GEN")
            if fabricGen and hasattr(fabricGen, "fabric"):
                fabric_obj = fabricGen.fabric
                self.info("Using existing FABulous fabric object")

                # Extract fabric information from FABulous API
                fabric_tiles = []

                # Get all tiles from the fabric
                if hasattr(fabric_obj, "tile") and fabric_obj.tile:
                    for tile in fabric_obj.tile:
                        fabric_tiles.append(
                            {
                                "name": tile.name,
                                "row": getattr(tile, "row", 0),
                                "col": getattr(tile, "col", 0),
                                "position": (
                                    getattr(tile, "col", 0),
                                    getattr(tile, "row", 0),
                                ),
                                "width": getattr(
                                    tile, "width", self.config.get("TILE_WIDTH", 100.0)
                                ),
                                "height": getattr(
                                    tile,
                                    "height",
                                    self.config.get("TILE_HEIGHT", 100.0),
                                ),
                                "tile_object": tile,  # Keep reference to original tile object
                            }
                        )

                # Get fabric dimensions
                fabric_width = getattr(fabric_obj, "width", 0)
                fabric_height = getattr(fabric_obj, "height", 0)
                frame_bits_per_row = getattr(
                    fabric_obj,
                    "frameBitsPerRow",
                    self.config.get("FRAME_BITS_PER_ROW", 32),
                )
                max_frames_per_col = getattr(
                    fabric_obj,
                    "maxFramesPerCol",
                    self.config.get("MAX_FRAMES_PER_COL", 20),
                )

                self.info(
                    f"Extracted from FABulous: {fabric_width}x{fabric_height} fabric"
                )
                self.info(
                    f"Found {len(fabric_tiles)} tiles from FABulous fabric object"
                )

            else:
                # Fallback: Parse CSV directly if FABulous object not available
                self.warn("FABulous fabric object not available, parsing CSV directly")
                return self._parse_fabric_csv_fallback(fabric_csv_path)

        except Exception as e:
            self.warn(f"Error accessing FABulous fabric object: {e}")
            self.info("Falling back to direct CSV parsing")
            return self._parse_fabric_csv_fallback(fabric_csv_path)

        # Validate extracted data
        if len(fabric_tiles) == 0:
            raise ValueError("No tiles found in FABulous fabric object")

        if fabric_width == 0 or fabric_height == 0:
            self.warn(
                f"Invalid fabric dimensions from FABulous: {fabric_width}x{fabric_height}"
            )
            # Try to calculate from tile positions
            if fabric_tiles:
                max_col = max(tile["col"] for tile in fabric_tiles)
                max_row = max(tile["row"] for tile in fabric_tiles)
                fabric_width = max_col + 1
                fabric_height = max_row + 1
                self.info(
                    f"Calculated dimensions from tiles: {fabric_width}x{fabric_height}"
                )

        fabric_config = {
            "tiles": fabric_tiles,
            "dimensions": {
                "width": fabric_width,
                "height": fabric_height,
                "total_tiles": len(fabric_tiles),
            },
            "frame_bits_per_row": frame_bits_per_row,
            "max_frames_per_col": max_frames_per_col,
            "fabulous_fabric_object": fabric_obj,  # Keep reference to original object
        }

        # Add metrics
        print(f"%OL_METRIC fabric_tiles_count {len(fabric_tiles)}")
        print(f"%OL_METRIC fabric_width {fabric_width}")
        print(f"%OL_METRIC fabric_height {fabric_height}")
        print(f"%OL_METRIC frame_bits_per_row {frame_bits_per_row}")
        print(f"%OL_METRIC max_frames_per_col {max_frames_per_col}")

        return fabric_config

    def _parse_fabric_csv_fallback(self, fabric_csv_path: Path) -> dict[str, Any]:
        """Fallback CSV parsing when FABulous fabric object is not available.

        This is a simplified version that extracts basic information from the CSV.
        """
        import re

        self.info(f"Fallback: parsing CSV directly from {fabric_csv_path}")

        try:
            with open(fabric_csv_path) as f:
                file_content = f.read()
                file_content = re.sub(r"#", "", file_content)
        except FileNotFoundError:
            raise ValueError(f"Fabric CSV file not found: {fabric_csv_path}")
        except Exception as e:
            raise ValueError(f"Error reading fabric CSV file: {e}")

        if fabric_match := re.search(
            r"FabricBegin(.*?)FabricEnd", file_content, re.MULTILINE | re.DOTALL
        ):
            fabric_description = fabric_match.group(1)
        else:
            raise ValueError("Cannot find FabricBegin and FabricEnd in csv file")

        # Basic parsing - extract tile names and positions
        fabric_tiles = []
        lines = [
            line.strip()
            for line in fabric_description.strip().split("\n")
            if line.strip()
        ]

        for row, line in enumerate(lines):
            tiles_in_row = [tile.strip() for tile in line.split(",") if tile.strip()]
            for col, tile_name in enumerate(tiles_in_row):
                if tile_name and tile_name.upper() != "NULL":
                    fabric_tiles.append(
                        {
                            "name": tile_name,
                            "row": row,
                            "col": col,
                            "position": (col, row),
                            "width": self.config.get("TILE_WIDTH", 100.0),
                            "height": self.config.get("TILE_HEIGHT", 100.0),
                        }
                    )

        fabric_width = len(lines[0].split(",")) if lines else 0
        fabric_height = len(lines)

        return {
            "tiles": fabric_tiles,
            "dimensions": {
                "width": fabric_width,
                "height": fabric_height,
                "total_tiles": len(fabric_tiles),
            },
            "frame_bits_per_row": self.config.get("FRAME_BITS_PER_ROW", 32),
            "max_frames_per_col": self.config.get("MAX_FRAMES_PER_COL", 20),
        }

    def _generate_tiles(
        self, fabric_config: dict[str, Any], state_in: State
    ) -> dict[str, Any]:
        """Generate individual tiles using OpenLane flow.

        This method handles the tile-by-tile generation process that was previously
        handled in the monolithic gdsGenerator class.
        """
        self.info("Starting tile generation process")

        tile_results = {"successful_tiles": [], "failed_tiles": [], "tile_files": {}}

        # TODO: Implement tile generation logic
        # This will replace the tile processing loop from gds_generator.py

        for tile in fabric_config["tiles"]:
            self.info(f"Processing tile: {tile}")
            # Tile processing will be delegated to TileProcessing step

        print(f"%OL_METRIC successful_tiles {len(tile_results['successful_tiles'])}")
        print(f"%OL_METRIC failed_tiles {len(tile_results['failed_tiles'])}")

        return tile_results

    def _assemble_fabric(
        self, tile_results: dict[str, Any], fabric_config: dict[str, Any]
    ) -> dict[str, Any]:
        """Assemble individual tiles into complete fabric.

        This method handles macro placement and fabric assembly that was previously
        handled in the monolithic implementation.
        """
        self.info("Starting fabric assembly process")

        fabric_results = {
            "gds_files": [],
            "lef_files": [],
            "lib_files": [],
            "def_files": [],
        }

        # TODO: Implement fabric assembly logic
        # This will replace the macro placement and assembly logic

        return fabric_results

    def _generate_reports(
        self, fabric_results: dict[str, Any], tile_results: dict[str, Any]
    ) -> None:
        """Generate comprehensive reports for the GDS generation process."""
        self.info("Generating reports")

        report_file = self.step_dir / "generation_report.txt"

        with open(report_file, "w") as f:
            f.write("FABulous GDS Generation Report\n")
            f.write("=" * 40 + "\n\n")
            f.write(f"Design Name: {self.config['DESIGN_NAME']}\n")
            f.write(f"Total Tiles: {len(tile_results.get('successful_tiles', []))}\n")
            f.write(f"Failed Tiles: {len(tile_results.get('failed_tiles', []))}\n")
            f.write(
                f"GDS Files Generated: {len(fabric_results.get('gds_files', []))}\n"
            )
            f.write(f"Output Directory: {self.config['OUTPUT_DIR']}\n")

        print(f"%OL_CREATE_REPORT {report_file.name}")
        self.info(f"Report generated: {report_file}")

    def _get_generation_time(self) -> float:
        """Calculate total generation time (placeholder)."""
        # TODO: Implement actual timing measurement
        return 0.0
