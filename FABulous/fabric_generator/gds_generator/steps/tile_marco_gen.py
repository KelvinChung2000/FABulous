"""
FABulous GDS Generator - Tile to Macro Conversion Step

This module contains a LibreLane step that converts FABulous tiles into macros.
It prepares the tile configuration and either uses the Classic flow or runs
essential steps to generate GDS, LEF, LIB, and DEF files for macro integration.
"""

import time
from pathlib import Path
from typing import Any, cast

from librelane.common.types import Path as LibrelanePath
from librelane.config.variable import Variable
from librelane.logging.logger import info, warn
from librelane.state.design_format import DesignFormat
from librelane.state.state import State
from librelane.steps.step import MetricsUpdate, Step, ViewsUpdate


@Step.factory.register()
class TileMarcoGen(Step):
    """LibreLane step for converting FABulous tiles into macros.

    This step prepares tile-specific configuration and state, then delegates the actual
    processing to a classic flow or simplified processing chain. The goal is to generate
    macro files (GDS, LEF) suitable for hierarchical integration.
    """

    # Get the Classic flow class from the Flow factory at runtime.
    # Use assignment instead of subclassing with a call expression.

    inputs = []
    outputs = [
        DesignFormat.GDS,
        DesignFormat.LEF,
        DesignFormat.LIB,
        DesignFormat.DEF,
    ]

    config_vars = [
        Variable(
            "TILE_DIR",
            Path,
            description="Path to the tile directory containing Verilog sources",
        ),
        Variable(
            "TILE_NAME", str, description="Name of the tile to process", default="tile"
        ),
        Variable(
            "TARGET_UTILIZATION",
            float,
            description="Target utilization percentage for placement",
            default=70.0,
            units="%",
        ),
        Variable(
            "CLOCK_PERIOD",
            float,
            description="Target clock period for timing constraints",
            default=10.0,
            units="ns",
        ),
    ]

    def run(self, state_in: State, **kwargs) -> tuple[ViewsUpdate, MetricsUpdate]:
        """Execute tile to macro conversion by preparing the environment and running
        processing steps.

        Args:
            state_in: Input state containing Verilog sources
            **kwargs: Additional arguments

        Returns:
            Tuple of (ViewsUpdate, MetricsUpdate) following LibreLane patterns
        """
        start_time = time.time()

        # Get configuration
        tile_name = self.config["TILE_NAME"]
        tile_dir = self.config["TILE_DIR"]
        fabric_gen = self.config.get("FABULOUS_FABRIC_GEN")

        info(f"Starting tile to macro conversion for: {tile_name}")

        # Validate inputs
        self._validate_configuration(tile_name, tile_dir, fabric_gen)

        # Setup working directory
        work_dir = Path(self.step_dir) / tile_name
        work_dir.mkdir(parents=True, exist_ok=True)

        try:
            result_files, metrics = self._run_classic_flow_script(
                tile_name, tile_dir, work_dir
            )

            # Validate outputs
            success = self._validate_outputs(tile_name, result_files)

            end_time = time.time()
            runtime = end_time - start_time

            # Create proper LibreLane ViewsUpdate using DesignFormat keys
            views_update: ViewsUpdate = {}
            if "gds" in result_files and result_files["gds"]:
                views_update[cast("DesignFormat", DesignFormat.GDS)] = LibrelanePath(
                    result_files["gds"]
                )
            if "lef" in result_files and result_files["lef"]:
                views_update[cast("DesignFormat", DesignFormat.LEF)] = LibrelanePath(
                    result_files["lef"]
                )
            if "lib" in result_files and result_files["lib"]:
                views_update[cast("DesignFormat", DesignFormat.LIB)] = LibrelanePath(
                    result_files["lib"]
                )
            if "def" in result_files and result_files["def"]:
                views_update[cast("DesignFormat", DesignFormat.DEF)] = LibrelanePath(
                    result_files["def"]
                )

            # Create metrics update
            metrics_update: MetricsUpdate = {
                f"tile_{tile_name}_runtime_sec": runtime,
                f"tile_{tile_name}_success": success,
                **metrics,
            }

            # Generate report
            self._generate_tile_report(
                tile_name, runtime, success, result_files, metrics
            )

            if success:
                info(
                    f"Successfully converted tile {tile_name} to macro in {runtime:.1f}s"
                )
            else:
                warn(f"Tile conversion completed with issues for {tile_name}")

            return views_update, metrics_update

        except Exception as e:
            end_time = time.time()
            runtime = end_time - start_time

            self.err(f"Tile to macro conversion failed for {tile_name}: {e}")

            # Return empty views but record failure in metrics
            metrics_update: MetricsUpdate = {
                f"tile_{tile_name}_runtime_sec": runtime,
                f"tile_{tile_name}_success": False,
                f"tile_{tile_name}_error": str(e),
            }

            return {}, metrics_update

    def _validate_configuration(
        self, tile_name: str, tile_dir: Path, fabric_gen: Any
    ) -> None:
        """Validate input configuration and dependencies."""
        info(f"Validating configuration for {tile_name}")

        if not tile_dir or not Path(tile_dir).exists():
            raise ValueError(f"Tile directory does not exist: {tile_dir}")

        if fabric_gen is None:
            warn("FABULOUS_FABRIC_GEN not provided - will use directory-based approach")

    def _prepare_tile_state(
        self, tile_name: str, tile_dir: Path, state_in: State
    ) -> State:
        """Prepare the state for tile processing with Verilog sources."""
        info(f"Preparing state for {tile_name}")

        # Create new state
        tile_state = State()

        # Collect Verilog files from tile directory
        verilog_files = []
        tile_dir_path = Path(tile_dir)
        if tile_dir_path.exists():
            verilog_files.extend(list(tile_dir_path.glob("*.v")))
            verilog_files.extend(list(tile_dir_path.glob("*.sv")))

        # Add files from input state
        if DesignFormat.VERILOG in state_in:
            verilog_inputs = state_in[DesignFormat.VERILOG]
            if isinstance(verilog_inputs, list):
                verilog_files.extend(verilog_inputs)
            else:
                verilog_files.append(verilog_inputs)

        if not verilog_files:
            raise ValueError(f"No Verilog files found for {tile_name}")

        # Set Verilog files in state (convert to LibreLane Path objects)
        tile_state[DesignFormat.VERILOG] = [LibrelanePath(f) for f in verilog_files]

        # Copy other relevant inputs from original state
        for format_name in [DesignFormat.SDC, DesignFormat.SPEF]:
            if format_name in state_in:
                tile_state[format_name] = state_in[format_name]

        return tile_state

    def _run_classic_flow_script(
        self, tile_name: str, tile_dir: Path, work_dir: Path
    ) -> tuple[dict[str, Path], dict[str, Any]]:
        """Run classic flow using direct LibreLane flow instantiation."""
        info(f"Running marco generation for {tile_name}")

        flow = TileMarcoGen()
        final_state, steps = flow.start()

        return final_state, step

    def _collect_output_files_from_directory(
        self, tile_name: str, work_dir: Path
    ) -> dict[str, Path]:
        """Collect output files from the working directory after flow execution."""
        self.info(f"Collecting output files for {tile_name}")

        result_files = {}

        # Look for standard LibreLane output locations
        possible_locations = [
            work_dir / "final" / "gds" / f"{tile_name}.gds",
            work_dir / "final" / "lef" / f"{tile_name}.lef",
            work_dir / "final" / "lib" / f"{tile_name}.lib",
            work_dir / "final" / "def" / f"{tile_name}.def",
            # Also check root level
            work_dir / f"{tile_name}.gds",
            work_dir / f"{tile_name}.lef",
            work_dir / f"{tile_name}.lib",
            work_dir / f"{tile_name}.def",
        ]

        for file_path in possible_locations:
            if file_path.exists() and file_path.stat().st_size > 0:
                suffix = file_path.suffix.lower().lstrip(".")
                if suffix not in result_files:  # Take first valid file of each type
                    result_files[suffix] = file_path

        # Also do a broader search
        for pattern in ["*.gds", "*.lef", "*.lib", "*.def"]:
            for file_path in work_dir.rglob(pattern):
                if file_path.is_file() and file_path.stat().st_size > 0:
                    suffix = file_path.suffix.lower().lstrip(".")
                    if suffix not in result_files:
                        result_files[suffix] = file_path

        return result_files

    def _validate_outputs(self, tile_name: str, result_files: dict[str, Path]) -> bool:
        """Validate that required output files were generated."""
        required_files = ["gds", "lef"]  # Minimum required for macro

        success = True
        for file_type in required_files:
            if file_type not in result_files:
                self.err(f"Missing required output file: {file_type}")
                success = False
            elif not result_files[file_type].exists():
                self.err(f"Output file does not exist: {result_files[file_type]}")
                success = False
            elif result_files[file_type].stat().st_size == 0:
                self.err(f"Output file is empty: {result_files[file_type]}")
                success = False

        return success

    def _generate_tile_report(
        self,
        tile_name: str,
        runtime: float,
        success: bool,
        result_files: dict[str, Path],
        metrics: dict[str, Any],
    ) -> None:
        """Generate comprehensive report for tile processing."""
        report_file = Path(self.step_dir) / f"{tile_name}_macro_report.txt"

        with report_file.open("w") as f:
            f.write(f"FABulous Tile to Macro Conversion Report: {tile_name}\n")
            f.write("=" * 60 + "\n\n")

            f.write("Configuration:\n")
            f.write(f"  Tile Name: {tile_name}\n")
            f.write(f"  Tile Directory: {self.config.get('TILE_DIR')}\n")
            f.write(
                f"  Target Utilization: {self.config.get('TARGET_UTILIZATION', 70.0)}%\n"
            )
            f.write(f"  Clock Period: {self.config.get('CLOCK_PERIOD', 10.0)}ns\n")
            f.write(
                f"  Flow Type: {metrics.get(f'tile_{tile_name}_flow_type', 'unknown')}\n\n"
            )

            f.write("Processing Results:\n")
            f.write(f"  Overall Success: {'✓' if success else '✗'}\n")
            f.write(f"  Total Runtime: {runtime:.2f} seconds\n\n")

            f.write("Generated Files:\n")
            for file_type, file_path in result_files.items():
                status = "✓" if file_path.exists() else "✗"
                size = file_path.stat().st_size if file_path.exists() else 0
                f.write(
                    f"  {status} {file_type.upper()}: {file_path.name} ({size} bytes)\n"
                )

            if not result_files:
                f.write("  No output files generated\n")

        # Use LibreLane reporting markers
        print(f"%OL_CREATE_REPORT {report_file.name}")

        # Add LibreLane metrics
        print(f"%OL_METRIC tile_{tile_name}_macro_success {1 if success else 0}")
        print(f"%OL_METRIC tile_{tile_name}_macro_runtime {runtime}")
        for key, value in metrics.items():
            if isinstance(value, (int, float, bool)):
                print(
                    f"%OL_METRIC {key} {int(value) if isinstance(value, bool) else value}"
                )
