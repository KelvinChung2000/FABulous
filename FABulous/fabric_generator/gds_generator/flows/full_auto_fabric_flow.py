from collections import Counter
from decimal import Decimal
from itertools import chain
from pathlib import Path as PathLib

import yaml
from librelane.common import Path
from librelane.config.variable import Macro, Variable
from librelane.flows.flow import Flow
from librelane.logging.logger import err, info, warn
from librelane.state.design_format import DesignFormat
from librelane.state.state import State
from librelane.steps.step import Step

from FABulous.fabric_cad.gen_io_pin_config_yaml import (
    generate_fabric_IO_pin_order_config,
    generate_IO_pin_order_config,
)
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.gds_generator.steps.extract_pdk_info import (
    ExtractPDKInfo,
)
from FABulous.fabric_generator.gds_generator.steps.fabric_macro_gen import (
    FabricMacroGen,
)
from FABulous.fabric_generator.gds_generator.steps.tile_macro_gen import TileMarcoGen
from FABulous.fabric_generator.gds_generator.steps.tile_optimisation import OptMode

configs = [
    Variable(
        "FABULOUS_PROJ_DIR",
        PathLib,
        description="Path to the FABulous project directory",
    ),
    Variable(
        "FABULOUS_FABRIC",
        Fabric,
        description="Fabric configuration object",
    ),
    Variable(
        "FABULOUS_OPTIMISATION_TARGET_TILE",
        str,
        description="Target tile for optimisation. If 'auto', the most frequently used "
        "tile in the fabric is selected.",
        default="auto",
    ),
    Variable(
        "FABULOUS_CONSTRAINT_STEP_COUNT",
        int,
        description="Number of placement sites to add when relaxing constraints",
        default=5,
    ),
    Variable(
        "FABULOUS_MAX_TILE_RETRIES",
        int,
        description="Maximum compilation retries per tile before failing",
        default=3,
    ),
    Variable(
        "FABULOUS_TILE_SPACING",
        Decimal,
        description="Spacing between tiles in database units",
        default=Decimal(0),
    ),
    Variable(
        "FABULOUS_HALO_SPACING",
        tuple[Decimal, Decimal, Decimal, Decimal],
        description="Halo spacing around fabric [left, bottom, right, top] in DBU",
        default=(Decimal(100), Decimal(100), Decimal(100), Decimal(100)),
    ),
]


# @Flow.factory.register()
class FABulousFabricMacroFullFlow(Flow):
    """Full automatic fabric flow with progressive tile compilation.

    This flow automatically:
    1. Extracts PDK site dimensions
    2. Finds most frequent tile and compiles it first
    3. Progressively compiles all tiles with row/column constraints
    4. Relaxes constraints when tiles fail to compile
    5. Stitches all tiles into final fabric
    """

    Steps = [ExtractPDKInfo]

    config_vars = configs

    def _get_tile_die_area_dbu(self, tile_dir: PathLib) -> tuple[int, int, int, int]:
        """Get tile die area from gds_config.yaml in DBU.

        Parameters
        ----------
        tile_dir : PathLib
            Path to tile directory

        Returns
        -------
        tuple[int, int, int, int]
            Die area as [llx, lly, urx, ury] in DBU
        """
        config_file = tile_dir / "gds_config.yaml"
        if not config_file.exists():
            raise FileNotFoundError(f"Config file not found: {config_file}")

        config_data = yaml.safe_load(config_file.open())

        die_area = config_data.get("DIE_AREA")
        if not die_area or len(die_area) != 4:
            raise ValueError(f"Invalid DIE_AREA in {config_file}: {die_area}")

        return (int(die_area[0]), int(die_area[1]), int(die_area[2]), int(die_area[3]))

    def _update_tile_config_die_area(
        self, tile_dir: PathLib, die_area_dbu: tuple[int, int, int, int]
    ) -> None:
        """Update tile's gds_config.yaml with new DIE_AREA.

        Parameters
        ----------
        tile_dir : PathLib
            Path to tile directory
        die_area_dbu : tuple[int, int, int, int]
            New die area [llx, lly, urx, ury] in DBU
        """
        config_file = tile_dir / "gds_config.yaml"

        if config_file.exists():
            with config_file.open() as f:
                config_data = yaml.safe_load(f)

            config_data["DIE_AREA"] = list(die_area_dbu)
        else:
            with config_file.open("w") as f:
                yaml.safe_dump(
                    {"DIE_AREA": list(die_area_dbu)}, f, default_flow_style=False
                )

        info(f"Updated {config_file} DIE_AREA to {list(die_area_dbu)}")

    def _compile_tile(
        self,
        tile: Tile,
        tile_dir: PathLib,
        initial_state: State,
        opt_mode: OptMode | None = None,
    ) -> tuple[State, Step]:
        """Compile a single tile with TileMarcoGen.

        Parameters
        ----------
        tile : Tile
            Tile to compile
        tile_dir : PathLib
            Path to tile directory
        initial_state : State
            Initial state for compilation
        opt_mode : OptMode | None
            Optimization mode to use. If None, defaults to BALANCED

        Returns
        -------
        tuple[State, Step]
            (output_state, step_instance)
        """
        fabric: Fabric = self.config["FABULOUS_FABRIC"]

        # Generate IO pin configuration
        out_file = tile_dir / "io_pin_order.yaml"
        generate_IO_pin_order_config(fabric, tile, out_file)

        # Default to BALANCED mode if not specified
        if opt_mode is None:
            opt_mode = OptMode.BALANCED

        # Create tile-specific configuration
        tile_config = self.config.copy(
            DESIGN_NAME=tile.name,
            IO_PIN_ORDER_CFG=out_file,
            FABULOUS_TILE_DIR=str(tile_dir),
            VERILOG_FILES=[
                str(f) for f in tile_dir.glob("**/*.v") if "macro" not in f.parts
            ],
            TILE_OPTIMISATION=True,  # Enable optimization
            FABULOUS_OPT_MODE=opt_mode,  # Set optimization mode
        )

        # Create and run step
        tile_step = TileMarcoGen(
            tile_config, id=f"TileMarcoGen_{tile.name}", state_in=initial_state
        )
        state_out = self.start_step(tile_step)

        return state_out, tile_step

    def _extract_tile_dimensions_from_state(self, state: State) -> tuple[int, int]:
        """Extract final tile dimensions from compiled state.

        Parameters
        ----------
        state : State
            Compiled tile state

        Returns
        -------
        tuple[int, int]
            (width_dbu, height_dbu) of compiled tile
        """
        # Get DIE_AREA from metrics if available
        die_area_metric = state.metrics.get("design__die__bbox")
        if die_area_metric:
            llx, lly, urx, ury = die_area_metric
            return int(urx - llx), int(ury - lly)

        # Fallback: try to read from DEF or config
        # This is a simplified version - may need enhancement
        warn("Could not extract die area from metrics, using config value")
        die_area_config = state.metrics.get("DIE_AREA")
        if die_area_config:
            llx, lly, urx, ury = die_area_config
            return int(urx - llx), int(ury - lly)

        raise ValueError("Could not extract tile dimensions from state")

    def _determine_optimization_mode(
        self,
        tile_width: int,
        tile_height: int,
        constraint_width: int,
        constraint_height: int,
    ) -> OptMode:
        """Determine the best optimization mode based on constraints.

        Parameters
        ----------
        tile_width : int
            Current tile width in DBU
        tile_height : int
            Current tile height in DBU
        constraint_width : int
            Required width constraint in DBU
        constraint_height : int
            Required height constraint in DBU

        Returns
        -------
        OptMode
            Optimization mode to use
        """
        # Calculate how much margin we have in each dimension
        width_margin = constraint_width - tile_width
        height_margin = constraint_height - tile_height

        # If tile is already larger than constraints, use aggressive optimization
        if width_margin <= 0 and height_margin <= 0:
            return OptMode.AGGRESSIVE

        # If width is tightly constrained, fix it and optimize height
        if width_margin < height_margin * 0.5:
            return OptMode.FIX_WIDTH

        # If height is tightly constrained, fix it and optimize width
        if height_margin < width_margin * 0.5:
            return OptMode.FIX_HEIGHT

        # Both dimensions have similar margins, use balanced approach
        return OptMode.BALANCED

    def _compilation_successful(self, state: State) -> bool:
        """Check if tile compilation was successful.

        Parameters
        ----------
        state : State
            Compiled tile state

        Returns
        -------
        bool
            True if compilation succeeded without critical errors
        """
        # Check for critical errors in metrics
        critical_metrics = [
            "route__drc_errors",
            "antenna__violating__nets",
            "antenna__violating__pins",
        ]

        for metric in critical_metrics:
            value = state.metrics.get(metric)
            if value is not None and int(value) > 0:
                warn(f"Tile compilation has {metric}={value}")
                return False

        # Check if required outputs exist
        if not state.get(DesignFormat.GDS) or not state.get(DesignFormat.LEF):
            err("Tile compilation missing required outputs (GDS or LEF)")
            return False

        return True

    def run(self, initial_state: State, **_kwargs: dict) -> tuple[State, list[Step]]:
        """Execute the full automatic fabric flow.

        Parameters
        ----------
        initial_state : State
            Initial state
        **kwargs : dict
            Additional keyword arguments

        Returns
        -------
        tuple[State, list[Step]]
            Final state and list of executed steps
        """
        step_list: list[Step] = []
        fabric: Fabric = self.config["FABULOUS_FABRIC"]
        proj_dir = PathLib(self.config["FABULOUS_PROJ_DIR"])

        # Step 1: Extract PDK site dimensions
        info("Extracting PDK site dimensions...")
        self.start_stage("PDK Site Extraction")
        extract_site_step = ExtractPDKInfo(self.config, state_in=initial_state)
        state = self.start_step(extract_site_step)
        step_list.append(extract_site_step)
        self.end_stage()

        site_width_dbu = int(state.metrics["pdk__site_width_dbu"])
        site_height_dbu = int(state.metrics["pdk__site_height_dbu"])
        site_name = state.metrics.get("pdk__site_name", "unknown")

        info(
            f"PDK site '{site_name}': {site_width_dbu} x {site_height_dbu} DBU "
            f"(step size: {self.config['FABULOUS_CONSTRAINT_STEP_COUNT']} sites)"
        )

        # Step 2: Find target tile
        if self.config["FABULOUS_OPTIMISATION_TARGET_TILE"] == "auto":
            # Count tile occurrences, excluding None
            tile_counts = Counter(
                tile for tile in chain.from_iterable(fabric.tile) if tile is not None
            )
            target_tile, count = tile_counts.most_common(1)[0]
            info(
                f"Auto-selected target tile: {target_tile.name} (appears {count} times)"
            )
        else:
            target_tile_name = self.config["FABULOUS_OPTIMISATION_TARGET_TILE"]
            target_tile = fabric.tileDic.get(target_tile_name)
            if not target_tile:
                raise ValueError(
                    f"Target tile '{target_tile_name}' not found in fabric"
                )
            info(f"Using configured target tile: {target_tile.name}")

        # Step 3: Get target tile initial die area
        target_tile_dir = proj_dir / "Tile" / target_tile.name
        target_die_area = self._get_tile_die_area_dbu(target_tile_dir)
        _, _, target_width, target_height = target_die_area

        info(
            f"Target tile {target_tile.name} initial die area: "
            f"{target_width} x {target_height} DBU"
        )

        # Step 4: Compile target tile first
        info(f"Compiling target tile {target_tile.name}...")
        self.start_stage(f"Target Tile: {target_tile.name}")

        # For target tile, use AGGRESSIVE mode to minimize area
        target_state, target_step = self._compile_tile(
            target_tile, target_tile_dir, initial_state, opt_mode=OptMode.AGGRESSIVE
        )
        step_list.append(target_step)
        self.end_stage()

        if not self._compilation_successful(target_state):
            raise RuntimeError(
                f"Target tile {target_tile.name} failed to compile successfully"
            )

        # Extract actual dimensions after optimization
        actual_target_width, actual_target_height = (
            self._extract_tile_dimensions_from_state(target_state)
        )
        info(
            f"Target tile {target_tile.name} compiled: "
            f"{actual_target_width} x {actual_target_height} DBU"
        )

        # Step 5: Initialize row/column constraints from target tile
        # NOTE: Constraints are tracked per tile TYPE (by name), not per instance
        # All instances of the same tile type will have the same dimensions
        row_heights: dict[int, int] = {}
        column_widths: dict[int, int] = {}

        target_rows, target_cols = fabric.get_tile_row_column_indices(target_tile.name)
        for row_idx in target_rows:
            row_heights[row_idx] = actual_target_height
        for col_idx in target_cols:
            column_widths[col_idx] = actual_target_width

        info("Initialized constraints from target tile:")
        info(f"  Tile type: {target_tile.name}")
        info(f"  Rows {sorted(target_rows)}: height = {actual_target_height} DBU")
        info(f"  Columns {sorted(target_cols)}: width = {actual_target_width} DBU")

        # Step 6: Progressive compilation of remaining tile types
        unique_tile_types = fabric.get_unique_tile_types()
        compiled_tile_types: set[str] = {target_tile.name}
        failed_tile_types: dict[str, int] = {}
        max_retries = self.config["FABULOUS_MAX_TILE_RETRIES"]
        tile_type_states: dict[str, State] = {target_tile.name: target_state}

        info(f"Total unique tile types to compile: {len(unique_tile_types)}")
        info(f"Remaining tile types: {len(unique_tile_types) - 1}")

        iteration = 0
        while len(compiled_tile_types) < len(unique_tile_types):
            iteration += 1
            info(f"\n--- Compilation Iteration {iteration} ---")
            made_progress = False

            for tile_type in unique_tile_types:
                if tile_type.name in compiled_tile_types:
                    continue

                tile_dir = proj_dir / "Tile" / tile_type.name
                tile_rows, tile_cols = fabric.get_tile_row_column_indices(
                    tile_type.name
                )

                # Get tile's initial die area
                initial_die_area = self._get_tile_die_area_dbu(tile_dir)
                _, _, current_width, current_height = initial_die_area

                # Get constraints from all rows/cols this tile appears in
                required_width = max(
                    (column_widths.get(c, 0) for c in tile_cols), default=0
                )
                required_height = max(
                    (row_heights.get(r, 0) for r in tile_rows), default=0
                )

                # Use tile's initial die area if no constraints set yet
                if required_width == 0 or required_height == 0:
                    required_width = max(required_width, current_width)
                    required_height = max(required_height, current_height)

                # Determine optimization mode based on constraints

                opt_mode = self._determine_optimization_mode(
                    current_width, current_height, required_width, required_height
                )

                info(
                    f"Compiling {tile_type.name} with constraints: "
                    f"{required_width} x {required_height} DBU (mode: {opt_mode.value})"
                )

                # Update tile's config with constrained die area
                self._update_tile_config_die_area(
                    tile_dir, (0, 0, required_width, required_height)
                )

                # Compile tile type (will apply to all instances)
                self.start_stage(f"Tile Type: {tile_type.name}")
                try:
                    tile_state, tile_step = self._compile_tile(
                        tile_type, tile_dir, initial_state, opt_mode=opt_mode
                    )
                    step_list.append(tile_step)
                    self.end_stage()

                    if self._compilation_successful(tile_state):
                        # Success!
                        actual_width, actual_height = (
                            self._extract_tile_dimensions_from_state(tile_state)
                        )

                        # Count how many instances of this tile type exist
                        positions = fabric.find_tile_positions(tile_type)
                        instance_count = len(positions) if positions else 0

                        info(
                            f"✓ {tile_type.name} compiled successfully: "
                            f"{actual_width} x {actual_height} DBU "
                            f"({instance_count} instances in fabric)"
                        )

                        # Update constraints if tile expanded
                        # All instances of this tile type will use these dimensions
                        for row_idx in tile_rows:
                            row_heights[row_idx] = max(
                                row_heights.get(row_idx, 0), actual_height
                            )
                        for col_idx in tile_cols:
                            column_widths[col_idx] = max(
                                column_widths.get(col_idx, 0), actual_width
                            )

                        compiled_tile_types.add(tile_type.name)
                        tile_type_states[tile_type.name] = tile_state
                        made_progress = True

                    else:
                        # Compilation had errors - relax constraints
                        failed_tile_types[tile_type.name] = (
                            failed_tile_types.get(tile_type.name, 0) + 1
                        )

                        if failed_tile_types[tile_type.name] >= max_retries:
                            raise RuntimeError(
                                f"Tile type {tile_type.name} failed after "
                                f"{max_retries} retries"
                            )

                        warn(
                            f"✗ {tile_type.name} failed "
                            "(attempt"
                            f"{failed_tile_types[tile_type.name]}/{max_retries})"
                        )
                        warn("  Relaxing constraints for all instances...")

                        # Relax constraints by N sites
                        step_count = self.config["FABULOUS_CONSTRAINT_STEP_COUNT"]
                        width_increase = site_width_dbu * step_count
                        height_increase = site_height_dbu * step_count

                        # Apply relaxed constraints to all rows/cols where this tile appears
                        for row_idx in tile_rows:
                            row_heights[row_idx] = (
                                row_heights.get(row_idx, required_height)
                                + height_increase
                            )
                        for col_idx in tile_cols:
                            column_widths[col_idx] = (
                                column_widths.get(col_idx, required_width)
                                + width_increase
                            )

                        info(
                            f"  New constraints: "
                            f"{column_widths[next(iter(tile_cols))]} x "
                            f"{row_heights[next(iter(tile_rows))]} DBU"
                        )

                        made_progress = True

                except Exception as e:
                    self.end_stage()
                    err(f"Exception while compiling {tile_type.name}: {e}")
                    raise

            if not made_progress:
                raise RuntimeError(
                    "No progress made in compilation loop - possible infinite loop"
                )

            info(
                f"Progress: {len(compiled_tile_types)}/{len(unique_tile_types)} "
                f"tile types compiled"
            )

        info("\n✓ All tile types compiled successfully!")

        # Step 7: Collect tile macros and dimensions for fabric stitching
        info("Preparing fabric stitching...")

        macros: dict[str, Macro] = {}
        tile_sizes: dict[str, tuple[Decimal, Decimal]] = {}

        # Note: We iterate over tile_type_states, which has one entry per tile TYPE
        # All instances of the same type will share these macro files
        for tile_type_name, tile_state in tile_type_states.items():
            width_dbu, height_dbu = self._extract_tile_dimensions_from_state(tile_state)

            tile_sizes[tile_type_name] = (Decimal(width_dbu), Decimal(height_dbu))

            # Get tile output files
            gds_file = tile_state.get(DesignFormat.GDS)
            lef_file = tile_state.get(DesignFormat.LEF)
            lib_files = tile_state.get(DesignFormat.LIB)

            # Build lib dict - Macro expects Dict[corner, list[Path]]
            lib_dict: dict[str, list[Path]] = {}
            if lib_files:
                if isinstance(lib_files, dict):
                    lib_dict = {
                        corner: [Path(str(f)) for f in files]
                        for corner, files in lib_files.items()
                    }
                elif isinstance(lib_files, list):
                    lib_dict = {"nom": [Path(str(f)) for f in lib_files]}
                else:
                    lib_dict = {"nom": [Path(str(lib_files))]}

            macros[tile_type_name] = Macro(
                gds=[Path(str(gds_file))] if gds_file else [],
                lef=[Path(str(lef_file))] if lef_file else [],
                lib=lib_dict,
                instances={},  # Will be populated by fabric flow
            )

        info(f"Collected {len(macros)} tile macros")

        # Step 8: Generate fabric-level IO pin configuration
        info("Generating fabric-level IO pin configuration...")
        fabric_io_config_path = proj_dir / "Fabric" / "fabric_io_pin_order.yaml"
        fabric_io_config_path.parent.mkdir(parents=True, exist_ok=True)
        generate_fabric_IO_pin_order_config(fabric, fabric_io_config_path)
        info(f"Fabric IO config saved to: {fabric_io_config_path}")

        # Step 9: Run fabric stitching
        self.start_stage("Fabric Stitching")

        fabric_config = self.config.copy(
            FABULOUS_MACROS_SETTINGS=macros,
            FABULOUS_TILE_SIZES=tile_sizes,
            FABULOUS_TILE_SPACING=self.config["FABULOUS_TILE_SPACING"],
            FABULOUS_HALO_SPACING=self.config["FABULOUS_HALO_SPACING"],
            FABULOUS_FABRIC_IO_PIN_ORDER_CFG=str(fabric_io_config_path),
        )

        # Use FabricMacroGen step instead of calling flow directly
        fabric_step = FabricMacroGen(
            fabric_config, id="FabricMacroGen", state_in=initial_state
        )
        final_state = self.start_step(fabric_step)
        step_list.append(fabric_step)

        self.end_stage()

        info("✓ Fabric stitching completed!")

        return final_state, step_list
