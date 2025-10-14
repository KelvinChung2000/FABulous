"""Full automatic fabric flow with progressive tile compilation.

This is an experimental flow for fully automatic fabric generation from tiles.

This flow automatically:
1. Extracts PDK site dimensions
2. Finds most frequent tile and compiles it first
3. Progressively compiles all tiles with row/column constraints
4. Relaxes constraints when tiles fail to compile
5. Stitches all tiles into final fabric
"""

from collections import Counter
from decimal import Decimal
from itertools import chain
from pathlib import Path

import yaml
from librelane.config.variable import Macro, Variable
from librelane.flows.classic import Classic
from librelane.flows.flow import Flow
from librelane.logging.logger import err, info, warn
from librelane.state.design_format import DesignFormat
from librelane.state.state import State
from librelane.steps.step import Step

from FABulous.fabric_cad.gen_io_pin_config_yaml import (
    generate_IO_pin_order_config,
)
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.SuperTile import SuperTile
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.gds_generator.flows.flow_define import (
    check_steps,
    physical_steps,
    write_out_steps,
)
from FABulous.fabric_generator.gds_generator.steps.fabric_macro_gen import (
    FabricMacroGen,
)
from FABulous.fabric_generator.gds_generator.steps.tile_macro_gen import TileMarcoGen
from FABulous.fabric_generator.gds_generator.steps.tile_optimisation import OptMode
from FABulous.FABulous_settings import get_context

configs = Classic.config_vars + [
    Variable(
        "FABULOUS_PROJ_DIR",
        Path,
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


@Flow.factory.register()
class FABulousFabricMacroFullFlow(Flow):
    """Full automatic fabric flow with progressive tile compilation.

    This flow automatically:
    1. Extracts PDK site dimensions
    2. Finds most frequent tile and compiles it first
    3. Progressively compiles all tiles with row/column constraints
    4. Relaxes constraints when tiles fail to compile
    5. Stitches all tiles into final fabric
    """

    Steps = (
        physical_steps + write_out_steps + check_steps + [TileMarcoGen, FabricMacroGen]
    )

    config_vars = configs

    def _get_unique_tile_and_supertile_types(
        self, fabric: Fabric
    ) -> list[Tile | SuperTile]:
        """Get list of unique tile and SuperTile types used in the fabric.

        Parameters
        ----------
        fabric : Fabric
            Fabric object

        Returns
        -------
        list[Tile | SuperTile]
            Combined list of regular tiles and SuperTiles from fabric dictionaries
        """
        result: list[Tile | SuperTile] = []

        # Add all regular tiles from tileDic
        result.extend(fabric.tileDic.values())

        # Add all SuperTiles from superTileDic
        result.extend(fabric.superTileDic.values())

        return result

    def _get_tile_die_area_dbu(self, tile_dir: Path) -> tuple[int, int, int, int]:
        """Get tile die area from gds_config.yaml in DBU.

        Parameters
        ----------
        tile_dir : Path
            Path to tile directory

        Returns
        -------
        tuple[int, int, int, int]
            Die area as [llx, lly, urx, ury] in DBU

        Raises
        ------
        FileNotFoundError
            If the config file is not found
        ValueError
            If the DIE_AREA is invalid
        """
        config_file = tile_dir / "gds_config.yaml"
        if not config_file.exists():
            raise FileNotFoundError(f"Config file not found: {config_file}")

        config_data = yaml.safe_load(config_file.open())

        die_area = config_data.get("DIE_AREA")
        if not die_area or len(die_area) != 4:
            raise ValueError(f"Invalid DIE_AREA in {config_file}: {die_area}")

        return (int(die_area[0]), int(die_area[1]), int(die_area[2]), int(die_area[3]))

    def _compile_tile(
        self,
        tile: Tile | SuperTile,
        tile_dir: Path,
        initial_state: State,
        opt_mode: OptMode = OptMode.BALANCED,
        die_area: tuple[int, int, int, int] | None = None,
        opt_relax: bool = False,
    ) -> tuple[State, Step]:
        """Compile a single tile with TileMarcoGen.

        Parameters
        ----------
        tile : Tile | SuperTile
            Tile to compile
        tile_dir : Path
            Path to tile directory
        initial_state : State
            Initial state for compilation
        opt_mode : OptMode
            Optimization mode to use. If None, defaults to BALANCED
        die_area : tuple[int, int, int, int] | None
            Die area constraint (llx, lly, urx, ury).
            If None, uses tile's gds_config.yaml
        opt_relax : bool
            If True, optimization increases dimensions (relaxation mode).
            If False, optimization reduces dimensions (minimization mode).

        Returns
        -------
        tuple[State, Step]
            (output_state, step_instance)
        """
        fabric: Fabric = self.config["FABULOUS_FABRIC"]

        # Generate IO pin configuration
        out_file = tile_dir / "io_pin_order.yaml"
        generate_IO_pin_order_config(fabric, tile, out_file)

        # Build file list for tile compilation
        file_list = [str(f) for f in tile_dir.glob("**/*.v") if "macro" not in f.parts]

        # Add models_pack from context if available
        if models_pack := get_context().models_pack:
            file_list.append(str(models_pack.resolve()))

        # Load base config from tile's gds_config.yaml if it exists
        tile_config_overrides = {}
        gds_config_file = tile_dir / "gds_config.yaml"
        if gds_config_file.exists():
            tile_config_overrides.update(
                yaml.safe_load(gds_config_file.read_text(encoding="utf-8"))
            )

        # Set die area constraint if provided
        if die_area is not None:
            tile_config_overrides["DIE_AREA"] = list(die_area)

        # Determine logical dimensions based on tile type
        if isinstance(tile, SuperTile):
            logical_width = tile.maxWidth()
            logical_height = tile.maxHeight()
        else:
            logical_width = 1
            logical_height = 1

        # Create tile-specific configuration
        tile_config = self.config.copy(
            DESIGN_NAME=tile.name,
            IO_PIN_ORDER_CFG=out_file,
            FABULOUS_TILE_DIR=str(tile_dir),
            VERILOG_FILES=file_list,
            FABULOUS_TILE_LOGICAL_WIDTH=logical_width,
            FABULOUS_TILE_LOGICAL_HEIGHT=logical_height,
            TILE_OPTIMISATION=True,  # Enable optimization
            FABULOUS_OPT_MODE=opt_mode,  # Set optimization mode
            FABULOUS_OPT_RELAX=opt_relax,  # Set relaxation mode
            **tile_config_overrides,
        )

        # Create and run step
        tile_step = TileMarcoGen(
            tile_config,
            id=f"TileMarcoGen_{tile.name}",
            state_in=initial_state,
            _no_filter_conf=True,
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

        Raises
        ------
        ValueError
            If tile dimensions cannot be determined
        """
        # Get DIE_AREA from metrics if available
        die_area_metric = state.metrics.get("design__die__bbox")
        if die_area_metric:
            llx, lly, urx, ury = die_area_metric
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

    def _validate_project_dir(self, proj_dir: Path, fabric: Fabric) -> None:
        # Validate project directory structure
        info("Validating project directory structure...")
        if not proj_dir.exists():
            raise FileNotFoundError(f"Project directory not found: {proj_dir}")
        if not proj_dir.is_dir():
            raise NotADirectoryError(f"Project path is not a directory: {proj_dir}")

        tile_dir_base = proj_dir / "Tile"
        if not tile_dir_base.exists():
            raise FileNotFoundError(
                f"Tile directory not found: {tile_dir_base}. "
                "Expected structure: <proj_dir>/Tile/<tile_name>/"
            )

        # Validate all tile directories exist
        # Check both regular tiles and SuperTiles from their dictionaries
        missing_tiles: list[str] = []
        found_regular_tiles = 0
        found_supertiles = 0

        # Build set of all sub-tile names that are part of SuperTiles
        # Sub-tiles don't need their own directories
        subtile_names: set[str] = set()
        for supertile in fabric.superTileDic.values():
            for subtile in supertile.tiles:
                subtile_names.add(subtile.name)

        # Validate regular tile directories
        # Skip tiles that are sub-components of SuperTiles
        for tile_name in fabric.tileDic:
            if tile_name in subtile_names:
                # This tile is part of a SuperTile, skip directory check
                continue
            tile_dir = tile_dir_base / tile_name
            if not tile_dir.exists():
                missing_tiles.append(f"{tile_name} (regular tile)")
            else:
                found_regular_tiles += 1

        # Validate SuperTile directories
        # Note: SuperTiles should have their own directories with compiled output
        for supertile_name in fabric.superTileDic:
            supertile_dir = tile_dir_base / supertile_name
            if not supertile_dir.exists():
                missing_tiles.append(f"{supertile_name} (SuperTile)")
            else:
                found_supertiles += 1

        if missing_tiles:
            raise FileNotFoundError(
                f"Missing tile directories in {tile_dir_base}:\n"
                + "\n".join(f"  - {tile}" for tile in missing_tiles)
            )

        total_types = found_regular_tiles + found_supertiles
        if subtile_names:
            info(
                f"✓ Project structure validated: {total_types} tile types found "
                f"({found_regular_tiles} regular tiles, {found_supertiles} SuperTiles, "
                f"{len(subtile_names)} sub-tiles within SuperTiles)"
            )
        else:
            info(
                f"✓ Project structure validated: {total_types} tile types found "
                f"({found_regular_tiles} regular tiles, {found_supertiles} SuperTiles)"
            )

    def run(self, initial_state: State, **_kwargs: dict) -> tuple[State, list[Step]]:
        """Execute the full automatic fabric flow.

        Parameters
        ----------
        initial_state : State
            Initial state
        **_kwargs : dict
            Additional keyword arguments

        Returns
        -------
        tuple[State, list[Step]]
            Final state and list of executed steps

        Raises
        ------
        RuntimeError
            If any tile fails to compile after maximum retries
        """
        step_list: list[Step] = []
        fabric: Fabric = self.config["FABULOUS_FABRIC"]
        proj_dir = Path(self.config["FABULOUS_PROJ_DIR"])
        self.progress_bar.set_max_stage_count(3)

        self._validate_project_dir(proj_dir, fabric)

        # Step 1: Find target tile
        if self.config["FABULOUS_OPTIMISATION_TARGET_TILE"] == "auto":
            # Count tile/SuperTile occurrences by name (not by object reference)
            # This ensures we count properly even if the same tile type appears
            # multiple times in the fabric grid
            tile_name_counts = Counter(
                tile.name
                for tile in chain.from_iterable(fabric.tile)
                if tile is not None
            )

            target_tile_name, count = tile_name_counts.most_common(1)[0]
            target_tile = fabric.getTileByName(target_tile_name)
            info(
                f"Auto-selected target tile: {target_tile.name} (appears {count} times)"
            )
        else:
            target_tile_name = self.config["FABULOUS_OPTIMISATION_TARGET_TILE"]
            target_tile = fabric.getTileByName(target_tile_name)
            info(f"Using configured target tile: {target_tile.name}")

        # Step 2: Compile target tile first
        target_tile_dir = proj_dir / "Tile" / target_tile.name
        target_die_area = self._get_tile_die_area_dbu(target_tile_dir)
        _, _, target_width, target_height = target_die_area

        info(
            f"Target tile {target_tile.name} initial die area: "
            f"{target_width} x {target_height} DBU"
        )

        info(f"Compiling target tile {target_tile.name}...")
        self.progress_bar.start_stage(f"Target Tile: {target_tile.name}")

        # For target tile, use AGGRESSIVE mode to minimize area
        target_state, target_step = self._compile_tile(
            target_tile, target_tile_dir, initial_state, opt_mode=OptMode.AGGRESSIVE
        )
        step_list.append(target_step)
        self.progress_bar.end_stage()

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
        # Get both regular tiles and SuperTiles
        unique_tile_types = self._get_unique_tile_and_supertile_types(fabric)
        compiled_tile_types: set[str] = {target_tile.name}
        failed_tile_types: dict[str, int] = {}
        max_retries = self.config["FABULOUS_MAX_TILE_RETRIES"]
        tile_type_states: dict[str, State] = {target_tile.name: target_state}

        info(f"Total unique tile/SuperTile types to compile: {len(unique_tile_types)}")
        info(f"Remaining types: {len(unique_tile_types) - 1}")

        iteration = 0
        while len(compiled_tile_types) < len(unique_tile_types):
            iteration += 1
            info(f"\n--- Compilation Iteration {iteration} ---")
            made_progress = False

            for tile_type in unique_tile_types:
                if tile_type.name in compiled_tile_types:
                    continue

                tile_dir = proj_dir / "Tile" / tile_type.name
                # For SuperTiles, this returns all rows/cols spanned by the SuperTile
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

                # Check if this is a retry attempt
                is_retry = tile_type.name in failed_tile_types

                # Compile tile type with constrained die area
                # Use opt_relax=True for retries to let optimization loop
                # increase dimensions
                self.start_stage(f"Tile Type: {tile_type.name}")
                tile_state, tile_step = self._compile_tile(
                    tile_type,
                    tile_dir,
                    initial_state,
                    opt_mode=opt_mode,
                    die_area=(0, 0, required_width, required_height),
                    opt_relax=is_retry,  # Enable relaxation mode for retries
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
                    constraints_updated = False
                    for row_idx in tile_rows:
                        old_height = row_heights.get(row_idx, 0)
                        new_height = max(old_height, actual_height)
                        if new_height > old_height:
                            row_heights[row_idx] = new_height
                            constraints_updated = True
                            info(
                                f"  Updated row {row_idx} height: "
                                f"{old_height} → {new_height} DBU"
                            )
                    for col_idx in tile_cols:
                        old_width = column_widths.get(col_idx, 0)
                        new_width = max(old_width, actual_width)
                        if new_width > old_width:
                            column_widths[col_idx] = new_width
                            constraints_updated = True
                            info(
                                f"  Updated column {col_idx} width: "
                                f"{old_width} → {new_width} DBU"
                            )

                    if not constraints_updated:
                        info("  No constraint updates needed")

                    compiled_tile_types.add(tile_type.name)
                    tile_type_states[tile_type.name] = tile_state
                    made_progress = True

                else:
                    # Compilation had errors - retry with relaxation mode
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
                        f"(attempt {failed_tile_types[tile_type.name]}/{max_retries})"
                    )
                    warn(
                        "Will retry with FABULOUS_OPT_RELAX=True to increase dimensions"
                    )

                    made_progress = True

            if not made_progress:
                raise RuntimeError(
                    "No progress made in compilation loop - possible infinite loop"
                )

            info(
                f"Progress: {len(compiled_tile_types)}/{len(unique_tile_types)} "
                f"tile types compiled"
            )

        info("\n✓ All tile types compiled successfully!")

        # Validate that all unique tiles were compiled
        if len(compiled_tile_types) != len(unique_tile_types):
            missing_types = [
                t.name for t in unique_tile_types if t.name not in compiled_tile_types
            ]
            raise RuntimeError(
                f"Not all tiles were compiled. Missing: {', '.join(missing_types)}"
            )

        # Step 7: Collect tile macros and dimensions for fabric stitching
        info("Preparing fabric stitching...")
        info(f"  Compiled tile types: {sorted(compiled_tile_types)}")

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
