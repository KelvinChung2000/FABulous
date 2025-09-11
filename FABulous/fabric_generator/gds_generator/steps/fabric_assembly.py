"""
FABulous GDS Generator - Fabric Assembly Step

This module contains the LibreLane step for assembling individual tiles into complete fabric.
"""

from pathlib import Path
from typing import Any

from librelane.common import run_subprocess
from librelane.state import State
from librelane.steps import Step

from ..variables import ALL_FABULOUS_VARIABLES


class FabricAssembly(Step):
    """LibreLane step for assembling individual FABulous tiles into complete fabric.

    This step handles macro placement, fabric assembly, and final GDS generation.
    """

    inputs = [
        "tile_gds_files",
        "tile_lef_files",
        "tile_lib_files",
        "fabric_configuration",
        "placement_constraints",
    ]

    outputs = [
        "fabric_gds",
        "fabric_lef",
        "fabric_lib",
        "fabric_def",
        "assembly_report",
    ]

    config_vars = ALL_FABULOUS_VARIABLES

    def run(
        self, state_in: State, *args, **kwargs
    ) -> tuple[dict[str, Any], dict[str, Any]]:
        """Execute fabric assembly process.

        Args:
            state_in: Input state containing tile files and fabric configuration

        Returns
        -------
            Tuple of (ViewsUpdate, MetricsUpdate)
        """
        self.info("Starting fabric assembly process")

        design_name = self.config["DESIGN_NAME"]
        output_dir = self.config["OUTPUT_DIR"]

        # Setup assembly workspace
        assembly_dir = self.step_dir / "assembly"
        assembly_dir.mkdir(parents=True, exist_ok=True)

        # Parse fabric configuration and tile information
        fabric_config = self._parse_fabric_configuration(state_in)
        tile_info = self._collect_tile_information(state_in)

        # Generate placement constraints
        placement_def = self._generate_placement_def(fabric_config, tile_info)

        # Create fabric-level DEF file
        fabric_def = self._create_fabric_def(fabric_config, tile_info, placement_def)

        # Generate fabric LEF
        fabric_lef = self._generate_fabric_lef(fabric_config, tile_info)

        # Generate fabric LIB
        fabric_lib = self._generate_fabric_lib(fabric_config, tile_info)

        # Assemble final GDS
        fabric_gds = self._assemble_fabric_gds(fabric_config, tile_info, fabric_def)

        # Generate assembly reports
        self._generate_assembly_reports(
            fabric_config,
            tile_info,
            {
                "gds": fabric_gds,
                "lef": fabric_lef,
                "lib": fabric_lib,
                "def": fabric_def,
            },
        )

        # Copy files to output directory
        final_files = self._copy_to_output_directory(
            output_dir,
            {
                "gds": fabric_gds,
                "lef": fabric_lef,
                "lib": fabric_lib,
                "def": fabric_def,
            },
        )

        # Calculate fabric metrics
        fabric_metrics = self._calculate_fabric_metrics(fabric_config, tile_info)

        # Prepare return values
        views_update = {
            "fabric_gds": final_files["gds"],
            "fabric_lef": final_files["lef"],
            "fabric_lib": final_files["lib"],
            "fabric_def": final_files["def"],
            "assembly_report": self.step_dir / "assembly_report.txt",
        }

        metrics_update = {
            "fabric_total_area_um2": fabric_metrics["total_area"],
            "fabric_width_um": fabric_metrics["width"],
            "fabric_height_um": fabric_metrics["height"],
            "fabric_tile_count": fabric_metrics["tile_count"],
            "fabric_utilization_pct": fabric_metrics["utilization"],
            "assembly_time_sec": fabric_metrics["assembly_time"],
        }

        self.info("Fabric assembly completed successfully")
        return views_update, metrics_update

    def _parse_fabric_configuration(self, state_in: State) -> dict[str, Any]:
        """Parse fabric configuration for assembly."""
        self.info("Parsing fabric configuration for assembly")

        # TODO: Extract actual fabric configuration from state_in
        fabric_config = {
            "fabric_dimensions": {"width": 0, "height": 0, "tiles_x": 0, "tiles_y": 0},
            "tile_positions": {},
            "routing_resources": {},
            "frame_configuration": {
                "bits_per_row": self.config["FRAME_BITS_PER_ROW"],
                "max_frames_per_col": self.config["MAX_FRAMES_PER_COL"],
            },
        }

        return fabric_config

    def _collect_tile_information(self, state_in: State) -> dict[str, Any]:
        """Collect information about all processed tiles."""
        self.info("Collecting tile information for assembly")

        tile_gds_files = state_in.get("tile_gds_files", {})
        tile_lef_files = state_in.get("tile_lef_files", {})
        tile_lib_files = state_in.get("tile_lib_files", {})

        tile_info = {}

        for tile_name in tile_gds_files.keys():
            tile_info[tile_name] = {
                "gds_file": tile_gds_files.get(tile_name),
                "lef_file": tile_lef_files.get(tile_name),
                "lib_file": tile_lib_files.get(tile_name),
                "dimensions": self._extract_tile_dimensions(
                    tile_name, tile_lef_files.get(tile_name)
                ),
                "pins": self._extract_tile_pins(
                    tile_name, tile_lef_files.get(tile_name)
                ),
            }

        self.info(f"Collected information for {len(tile_info)} tiles")
        return tile_info

    def _extract_tile_dimensions(
        self, tile_name: str, lef_file: Path
    ) -> dict[str, float]:
        """Extract tile dimensions from LEF file."""
        if not lef_file or not lef_file.exists():
            self.warn(
                f"LEF file not found for tile {tile_name}, using default dimensions"
            )
            return {
                "width": self.config.get("TILE_WIDTH", 100.0),
                "height": self.config.get("TILE_HEIGHT", 100.0),
            }

        # TODO: Parse actual LEF file for dimensions
        # For now, return configured default dimensions
        return {
            "width": self.config.get("TILE_WIDTH", 100.0),
            "height": self.config.get("TILE_HEIGHT", 100.0),
        }

    def _extract_tile_pins(self, tile_name: str, lef_file: Path) -> dict[str, Any]:
        """Extract tile pin information from LEF file."""
        if not lef_file or not lef_file.exists():
            self.warn(f"LEF file not found for tile {tile_name}, using empty pin list")
            return {}

        # TODO: Parse actual LEF file for pin information
        # This will replace the pin parsing logic from general.py
        return {}

    def _generate_placement_def(
        self, fabric_config: dict[str, Any], tile_info: dict[str, Any]
    ) -> Path:
        """Generate placement DEF file for fabric assembly."""
        self.info("Generating placement DEF file")

        placement_def = self.step_dir / "fabric_placement.def"

        with open(placement_def, "w") as f:
            f.write("VERSION 5.8 ;\n")
            f.write('DIVIDERCHAR "/" ;\n')
            f.write('BUSBITCHARS "[]" ;\n\n')

            f.write(f"DESIGN {self.config['DESIGN_NAME']}_fabric ;\n\n")

            # TODO: Write actual placement information
            # This will implement the macro placement logic from the original implementation

            f.write("END DESIGN\n")

        return placement_def

    def _create_fabric_def(
        self,
        fabric_config: dict[str, Any],
        tile_info: dict[str, Any],
        placement_def: Path,
    ) -> Path:
        """Create comprehensive fabric DEF file."""
        self.info("Creating fabric DEF file")

        fabric_def = self.step_dir / "fabric.def"

        # TODO: Implement fabric DEF generation
        # This will replace the DEF generation logic from the original implementation

        return fabric_def

    def _generate_fabric_lef(
        self, fabric_config: dict[str, Any], tile_info: dict[str, Any]
    ) -> Path:
        """Generate fabric-level LEF file."""
        self.info("Generating fabric LEF file")

        fabric_lef = self.step_dir / "fabric.lef"

        with open(fabric_lef, "w") as f:
            f.write("VERSION 5.8 ;\n")
            f.write('BUSBITCHARS "[]" ;\n')
            f.write('DIVIDERCHAR "/" ;\n\n')

            # TODO: Write fabric LEF content
            # This will implement the LEF generation logic

        return fabric_lef

    def _generate_fabric_lib(
        self, fabric_config: dict[str, Any], tile_info: dict[str, Any]
    ) -> Path:
        """Generate fabric-level LIB file."""
        self.info("Generating fabric LIB file")

        fabric_lib = self.step_dir / "fabric.lib"

        with open(fabric_lib, "w") as f:
            f.write(f"library({self.config['DESIGN_NAME']}_fabric) {{\n")

            # TODO: Write fabric LIB content
            # This will implement the LIB generation logic

            f.write("}\n")

        return fabric_lib

    def _assemble_fabric_gds(
        self, fabric_config: dict[str, Any], tile_info: dict[str, Any], fabric_def: Path
    ) -> Path:
        """Assemble final fabric GDS file using Magic or KLayout."""
        self.info("Assembling fabric GDS file")

        fabric_gds = self.step_dir / "fabric.gds"

        # Use Magic for GDS assembly
        magic_path = self.config["MAGIC_PATH"]

        # Create Magic script for GDS assembly
        magic_script = self.step_dir / "assemble_gds.tcl"

        with open(magic_script, "w") as f:
            f.write("# Magic script for fabric GDS assembly\n")

            # TODO: Write Magic commands for GDS assembly
            # This will implement the GDS assembly logic

            f.write(f"gds write {fabric_gds}\n")
            f.write("quit\n")

        # Run Magic
        run_subprocess(
            [
                str(magic_path),
                "-T",
                "sky130A",  # TODO: Make technology configurable
                "-noc",
                "-dnull",
                str(magic_script),
            ],
            log_to=self.step_dir / "magic_assembly.log",
        )

        return fabric_gds

    def _generate_assembly_reports(
        self,
        fabric_config: dict[str, Any],
        tile_info: dict[str, Any],
        output_files: dict[str, Path],
    ) -> None:
        """Generate comprehensive assembly reports."""
        self.info("Generating assembly reports")

        report_file = self.step_dir / "assembly_report.txt"

        with open(report_file, "w") as f:
            f.write("FABulous Fabric Assembly Report\n")
            f.write("=" * 50 + "\n\n")

            f.write(f"Design Name: {self.config['DESIGN_NAME']}\n")
            f.write(f"Total Tiles: {len(tile_info)}\n")

            # TODO: Add detailed assembly statistics

            f.write("\nOutput Files:\n")
            f.writelines(
                f"  {file_type.upper()}: {file_path}\n"
                for file_type, file_path in output_files.items()
            )

        print(f"%OL_CREATE_REPORT {report_file.name}")

    def _copy_to_output_directory(
        self, output_dir: Path, files: dict[str, Path]
    ) -> dict[str, Path]:
        """Copy assembled files to output directory."""
        self.info(f"Copying files to output directory: {output_dir}")

        final_files = {}

        for file_type, source_path in files.items():
            if source_path and source_path.exists():
                dest_dir = output_dir / file_type
                dest_dir.mkdir(parents=True, exist_ok=True)

                dest_path = dest_dir / source_path.name
                dest_path.write_bytes(source_path.read_bytes())

                final_files[file_type] = dest_path
                self.info(f"Copied {file_type.upper()} file to: {dest_path}")
            else:
                self.warn(f"Source file not found for {file_type}: {source_path}")

        return final_files

    def _calculate_fabric_metrics(
        self, fabric_config: dict[str, Any], tile_info: dict[str, Any]
    ) -> dict[str, Any]:
        """Calculate fabric-level metrics."""
        self.info("Calculating fabric metrics")

        # TODO: Calculate actual fabric metrics
        fabric_metrics = {
            "total_area": 0.0,
            "width": 0.0,
            "height": 0.0,
            "tile_count": len(tile_info),
            "utilization": 0.0,
            "assembly_time": 0.0,  # TODO: Measure actual assembly time
        }

        # Add metrics
        for metric_name, metric_value in fabric_metrics.items():
            print(f"%OL_METRIC fabric_{metric_name} {metric_value}")

        return fabric_metrics
