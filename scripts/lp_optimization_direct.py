#!/usr/bin/env python3
"""NLP optimization with pre-compiled tile sizes using GlobalTileSizeOptimization step.

This script optimizes fabric layout using pre-compiled tile specifications:
1. Load tile specifications from JSON (width, height, area, modes)
2. Extract tile positions and ports from FABulous project directory
3. Load fabric from project
4. Prepare tile metrics and call GlobalTileSizeOptimization step
5. Display results and verify constraints

Usage:
    python3 scripts/lp_optimization_direct.py \
      --config tile_config.json \
      [--project /path/to/fabulous/project]

JSON Config Format:
    {
      "fabric_size": {"rows": 16, "cols": 10},
      "track_pitch": {"x": 0.34, "y": 0.40},
      "tiles": {
        "LUT4AB": {
          "positions": [[0, 0], [0, 1], [0, 2], ...],
          "ports": {"north": 32, "south": 32, "west": 24, "east": 24},
          "modes": [
            {"width": 215, "height": 215, "name": "balance"}
          ]
        }
      }
    }

Note:
- Tile positions must be provided as arrays of [row, col] coordinates
- Ports must include north, south, west, east counts
- Modes must include at least a "balance" mode
- If <3 modes provided and track_pitch available, min_width/min_height auto-calculated

Programmatic usage:
    from decimal import Decimal
    from pathlib import Path
    from scripts.lp_optimization_direct import optimize_fabric
    from FABulous.FABulous_API import FABulous_API
    from FABulous.fabric_generator.code_generator.code_generator_Verilog import \\
        VerilogCodeGenerator
    from FABulous.FABulous_settings import init_context

    # Load fabric
    project_path = Path("/path/to/project")
    init_context(project_path)
    api = FABulous_API(VerilogCodeGenerator(), str(project_path / "fabric.csv"))
    fabric = api.fabric

    # Run optimization
    optimal_widths, optimal_heights = optimize_fabric(
        fabric=fabric,
        tiles={
            "LUT4AB": {
                "positions": [(r, c) for r in range(16) for c in range(10)],
                "ports": {"north": 32, "south": 32, "west": 24, "east": 24},
                "width": 215, "height": 215, "area": 46225,
                "modes": [{"width": 215, "height": 215, "name": "balance"}]
            }
        },
        track_pitch=(Decimal("0.34"), Decimal("0.40")),
    )
"""

import argparse
import itertools
import json
import math
import sys
from decimal import Decimal
from pathlib import Path

# Add parent directory to path
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

# Import the NLP optimization problem class directly
from FABulous.fabric_generator.code_generator.code_generator_Verilog import (
    VerilogCodeGenerator,
)
from FABulous.fabric_generator.gds_generator.steps.global_tile_opitmisation import (
    NLPTileProblem,
)

# Import FABulous API for project parsing
from FABulous.FABulous_API import FABulous_API
from FABulous.FABulous_settings import init_context

# Check pymoo availability
try:
    from pymoo.algorithms.soo.nonconvex.de import DE
    from pymoo.optimize import minimize
    from pymoo.termination import get_termination
except ImportError:
    print("✗ pymoo not available - install with: pip install pymoo")
    sys.exit(1)


# ============================================================================
# PRECOMPILED TILE SPECIFICATION SUPPORT
# ============================================================================


def extract_tile_positions_from_project(
    project_dir: str,
) -> dict[str, list[tuple[int, int]]]:
    """Extract tile positions from a FABulous project directory.

    Args:
        project_dir: Path to FABulous project directory

    Returns
    -------
        Dict mapping tile_name to list of (row, col) positions
    """
    project_path = Path(project_dir)
    fabric_csv = project_path / "fabric.csv"

    # Initialize FABulous context and load fabric
    init_context(project_path)
    api = FABulous_API(VerilogCodeGenerator(), str(fabric_csv))
    fabric = api.fabric

    print(f"Parsing FABulous project from {project_dir}...")

    # Extract tile positions from fabric grid
    tile_positions: dict[str, list[tuple[int, int]]] = {}

    for row in range(len(fabric.tile)):
        for col in range(len(fabric.tile[row])):
            cell = fabric.tile[row][col]
            if cell:
                tile_type = cell.name
                if tile_type not in tile_positions:
                    tile_positions[tile_type] = []
                tile_positions[tile_type].append((row, col))

    print(f"✓ Extracted positions for {len(tile_positions)} tile types:")
    for tile_type, positions in tile_positions.items():
        print(f"  {tile_type}: {len(positions)} instances")

    return tile_positions


def extract_tile_ports_from_project(
    project_dir: str,
) -> dict[str, dict[str, int]]:
    """Extract tile port counts from a FABulous project directory.

    Args:
        project_dir: Path to FABulous project directory

    Returns
    -------
        Dict mapping tile_name to port_counts
    """
    project_path = Path(project_dir)
    fabric_csv = project_path / "fabric.csv"

    # Initialize FABulous context and load fabric
    init_context(project_path)
    api = FABulous_API(VerilogCodeGenerator(), str(fabric_csv))
    fabric = api.fabric

    tile_ports: dict[str, dict[str, int]] = {}

    # Extract port information from tile definitions
    for tile_name, tile_obj in fabric.tileDic.items():
        # Use the Tile API to count ports on each side. Fall back to 0 if
        # methods/attributes are missing.

        north = (
            sum(
                [
                    len(list(itertools.chain.from_iterable(i.expandPortInfo())))
                    for i in tile_obj.getNorthSidePorts()
                ]
            )
            + fabric.frameSelectWidth
        )
        south = (
            sum(
                [
                    len(list(itertools.chain.from_iterable(i.expandPortInfo())))
                    for i in tile_obj.getSouthSidePorts()
                ]
            )
            + fabric.frameSelectWidth
        )

        west = (
            sum(
                [
                    len(list(itertools.chain.from_iterable(i.expandPortInfo())))
                    for i in tile_obj.getWestSidePorts()
                ]
            )
            + fabric.frameBitsPerRow
        )

        east = (
            sum(
                [
                    len(list(itertools.chain.from_iterable(i.expandPortInfo())))
                    for i in tile_obj.getEastSidePorts()
                ]
            )
            + fabric.frameBitsPerRow
        )

        ports = {"north": north, "south": south, "west": west, "east": east}

        # Always include an entry (possibly zeros) so downstream IO min dims
        # can be computed without special-casing missing tiles.
        tile_ports[tile_name] = ports

    print(f"✓ Extracted ports for {len(tile_ports)} tile types:")
    for tile_type, ports in tile_ports.items():
        print(
            f"  {tile_type}: N={ports['north']} S={ports['south']} "
            f"W={ports['west']} E={ports['east']} sum={ports['north'] + ports['south'] + ports['west'] + ports['east']}"
        )

    return tile_ports


def load_precompiled_tiles_from_json(config_path: str) -> dict:
    """Load pre-compiled tile specifications from JSON file.

    Expected JSON format:
    {
        "fabric_size": {"rows": 16, "cols": 10},
        "track_pitch": {"x": 0.34, "y": 0.40},
        "tiles": {
            "LUT4AB": {
                "positions": [[0, 0], [0, 1], ...],
                "ports": {"north": 32, "south": 32, "west": 24, "east": 24},
                "width": 200,
                "height": 200,
                "area": 40000,
                "modes": [{"width": 200, "height": 200, "name": "balance"}]
            }
        }
    }
    """
    with Path(config_path).open() as f:
        data = json.load(f)

    # Convert track_pitch to Decimal
    data["track_pitch"]["x"] = Decimal(str(data["track_pitch"]["x"]))
    data["track_pitch"]["y"] = Decimal(str(data["track_pitch"]["y"]))

    # Convert positions back to tuples if present
    for tile_name, tile_data in data["tiles"].items():
        if "positions" in tile_data and tile_data["positions"]:
            tile_data["positions"] = [tuple(pos) for pos in tile_data["positions"]]

    return data


def create_scenario_from_precompiled(
    fabric_size: tuple[int, int],
    tiles: dict,
    track_pitch: tuple[Decimal, Decimal],
    name: str = "Custom Precompiled Scenario",
    description: str = "",
) -> dict:
    """Create a scenario dict from pre-compiled tile specifications.

    Args:
        fabric_size: (rows, cols) tuple
        tiles: Dict mapping tile_name to tile_spec:
            {
                "tile_name": {
                    "positions": [(r, c), ...],
                    "ports": {"north": N, "south": S, "west": W, "east": E},
                    "precompiled_size": {
                        "width": W,
                        "height": H,
                        "area": A,
                        "min_balance_area": optional
                    }
                }
            }
        track_pitch: (x_pitch, y_pitch) as Decimal
        name: Scenario name
        description: Scenario description

    Returns
    -------
        Scenario dict compatible with test_scenario()
    """
    scenario_tiles = {}

    for tile_name, tile_spec in tiles.items():
        scenario_tiles[tile_name] = {
            "positions": tile_spec["positions"],
            "ports": tile_spec["ports"],
            "precompiled_size": tile_spec.get("precompiled_size", {}),
        }

    return {
        "name": name,
        "description": description,
        "fabric_size": {"rows": fabric_size[0], "cols": fabric_size[1]},
        "track_pitch": {"x": track_pitch[0], "y": track_pitch[1]},
        "tiles": scenario_tiles,
    }


# ============================================================================
# NLP SOLVER WRAPPER - Calls GlobalTileSizeOptimization step
# ============================================================================


def solve_nlp_optimization(
    fabric,
    tile_metrics: dict,
    time_limit: int = 300,
) -> tuple[dict[str, int], dict[str, int]] | None:
    """Solve NLP optimization using NLPTileProblem directly (bypass LibreLane Step).

    Parameters
    ----------
    fabric : Fabric
        FABulous fabric object with tile grid
    tile_metrics : dict
        Dictionary of tile metrics including min dimensions and mode options
    time_limit : int
        Time limit in seconds for NLP solver

    Returns
    -------
    tuple[dict[str, int], dict[str, int]] | None
        (optimal_widths, optimal_heights) or None if failed
    """
    print("\n" + "=" * 80)
    print("Solving NLP optimization using NLPTileProblem")
    print("=" * 80 + "\n")

    try:
        # Build fabric structure
        num_rows = len(fabric.tile)
        num_cols = len(fabric.tile[0]) if num_rows > 0 else 0

        row_to_types: dict[int, set[str]] = {}
        col_to_types: dict[int, set[str]] = {}
        type_to_positions: dict[str, list[tuple[int, int]]] = {}
        supertile_positions: list[tuple[str, int, int]] = []

        for r in range(num_rows):
            for c in range(num_cols):
                tile = fabric.tile[r][c]
                if tile is None:
                    continue
                tname = tile.name
                row_to_types.setdefault(r, set()).add(tname)
                col_to_types.setdefault(c, set()).add(tname)
                type_to_positions.setdefault(tname, []).append((r, c))
                if tname in fabric.superTileDic:
                    supertile_positions.append((tname, r, c))

        print(
            f"Fabric: {num_rows}x{num_cols}, {len(type_to_positions)} tile types, {len(supertile_positions)} supertile instances"
        )

        # Create NLP problem
        problem = NLPTileProblem(
            fabric,
            tile_metrics,
            row_to_types,
            col_to_types,
            supertile_positions,
            num_rows,
            num_cols,
        )

        # Solve with DE algorithm
        algorithm = DE(
            pop_size=len(problem.var_names) * 10
            if len(problem.var_names) < 50
            else 100,
            variant="DE/rand/1/bin",
            CR=0.9,
            F=0.8,
        )

        # Time limit via termination
        termination = get_termination("time", time_limit * 1000)  # in ms

        print(f"Running DE algorithm with {len(problem.var_names)} variables...")
        res = minimize(problem, algorithm, termination, verbose=True)

        if not res.success:
            print(f"✗ NLP optimization did not converge: {res}")
            # Continue anyway with best found solution

        # Extract results
        x_opt = res.X

        # Map back to dimensions
        optimal_row_h = {}
        optimal_col_w = {}

        for i, name in enumerate(problem.var_names):
            if name.startswith("row_h_"):
                r = int(name.split("_")[2])
                optimal_row_h[r] = x_opt[i]
            elif name.startswith("col_w_"):
                c = int(name.split("_")[2])
                optimal_col_w[c] = x_opt[i]

        # Tile dimensions from row/col
        optimal_widths_int = {}
        optimal_heights_int = {}

        for tname in type_to_positions:
            positions = type_to_positions[tname]
            if tname in fabric.superTileDic:
                # Supertile dimensions from specific instances
                for (tn, r, c), (h_idx, w_idx) in problem.super_var_map.items():
                    if tn == tname:
                        optimal_heights_int[tn] = int(x_opt[h_idx])
                        optimal_widths_int[tn] = int(x_opt[w_idx])
                        break
            else:
                # Regular tile: use row/col dimensions
                r, c = positions[0]
                min_tile_widths = tile_metrics.get("tile_min_widths", {})
                min_tile_heights = tile_metrics.get("tile_min_heights", {})
                optimal_heights_int[tname] = int(
                    optimal_row_h.get(r, min_tile_heights.get(tname, 1))
                )
                optimal_widths_int[tname] = int(
                    optimal_col_w.get(c, min_tile_widths.get(tname, 1))
                )

        total_area = int(res.F[0])
        print("\n✓ NLP solver completed")
        print(f"  Total fabric area: {total_area}")
        print(f"  Status: {'Optimal' if res.success else 'Feasible'}\n")

        return optimal_widths_int, optimal_heights_int

    except Exception as e:
        print(f"✗ NLP solver failed with exception: {e}")
        import traceback

        traceback.print_exc()
        return None


# ============================================================================
# HELPER FUNCTIONS
# ============================================================================


def compute_io_min_dimensions(
    tiles: dict, x_pitch: Decimal, y_pitch: Decimal
) -> dict[str, tuple[Decimal, Decimal]]:
    """Compute IO minimum dimensions based on port counts and track pitch."""
    io_min_dims = {}

    for tile_name, tile_data in tiles.items():
        ports = tile_data["ports"]
        north_ports = ports["north"]
        south_ports = ports["south"]
        west_ports = ports["west"]
        east_ports = ports["east"]

        min_width_io = Decimal(max(north_ports, south_ports)) * x_pitch
        min_height_io = Decimal(max(west_ports, east_ports)) * y_pitch

        io_min_dims[tile_name] = (min_width_io, min_height_io)

    return io_min_dims


def build_fabric_maps(scenario: dict) -> tuple:
    """Build the data structures needed for LP solver."""
    tiles = scenario["tiles"]

    # Build type_to_positions
    type_to_positions = {}
    for tile_name, tile_data in tiles.items():
        type_to_positions[tile_name] = tile_data["positions"]

    # Build row_to_types and col_to_types
    row_to_types = {}
    col_to_types = {}

    for tile_name, positions in type_to_positions.items():
        for row, col in positions:
            if row not in row_to_types:
                row_to_types[row] = set()
            row_to_types[row].add(tile_name)

            if col not in col_to_types:
                col_to_types[col] = set()
            col_to_types[col].add(tile_name)

    return type_to_positions, row_to_types, col_to_types


def create_tile_bounds(
    tiles: dict, track_pitch: tuple[Decimal, Decimal] | None = None
) -> tuple:
    """Create min bounds for tiles from pre-compiled sizes.

    Returns tile_mode_options with 3 modes per tile.
    Each mode is (width, height, mode_name) as required by LP solver.
    Modes are supplied from the JSON config. If min_width or min_height modes are missing,
    they are auto-calculated based on track pitch and IO constraints.

    Auto-calculation:
    - min_width = max(io_south, io_north) * track_pitch_y * 1.1
    - min_height = balance_area * 2 / min_width
    """
    min_tile_widths = {}
    min_tile_heights = {}
    tile_mode_options = {}

    for tile_name, tile_data in tiles.items():
        # Get 3 mode options from config
        # Each mode must be a dict with 'width', 'height', and 'name' keys
        modes = tile_data.get("modes", [])

        if not modes:
            raise ValueError(
                f"Tile {tile_name} missing 'modes': requires list of mode dicts"
            )

        # Get width/height from area and balance mode
        area = tile_data.get("area")
        balance_mode = None

        # Find balance mode (mode 0)
        for mode in modes:
            if mode.get("name") == "balance":
                balance_mode = mode
                break

        if not balance_mode and len(modes) > 0:
            balance_mode = modes[0]

        if not balance_mode:
            raise ValueError(f"Tile {tile_name} must have a balance mode")

        width = balance_mode.get("width")
        height = balance_mode.get("height")

        if width is None or height is None:
            raise ValueError(f"Tile {tile_name} balance mode missing width or height")

        if len(modes) < 3:
            # Auto-calculate missing modes
            if track_pitch is None:
                raise ValueError(
                    f"Tile {tile_name} has {len(modes)} mode(s) but needs 3. "
                    f"Provide all 3 modes or provide track_pitch for auto-calculation."
                )

            # Auto-calculate min_width and min_height modes if missing
            ports = tile_data.get(
                "ports", {"north": 0, "south": 0, "west": 0, "east": 0}
            )
            io_count_north = ports.get("north", 0)
            io_count_south = ports.get("south", 0)
            io_count_east = ports.get("east", 0)
            io_count_west = ports.get("west", 0)

            x_pitch, y_pitch = track_pitch

            # Use IO-based minimums derived from track pitch
            # min_width_io is based on north/south pin counts × x_pitch
            min_width_io = Decimal(max(io_count_north, io_count_south)) * Decimal(
                x_pitch
            )
            calc_min_width = min_width_io * Decimal("1.1")

            # Balance area (use Decimal for precision)
            balance_area = Decimal(str(width)) * Decimal(str(height))

            # min_height computed from balance_area * 2 / min_width
            calc_min_height = (balance_area * Decimal(2)) / calc_min_width

            # Debug: show the computed IO-based minima before rounding
            try:
                print(
                    f"  [auto-calc] {tile_name}: calc_min_width={float(calc_min_width):.4f}, calc_min_height={float(calc_min_height):.4f}, balance_area={float(balance_area):.2f}"
                )
            except Exception:
                pass

            # Build modes list
            validated_modes = []

            # Mode 0: balance (round up to next integer)
            validated_modes.append(
                (
                    math.ceil(float(width)),
                    math.ceil(float(height)),
                    balance_mode.get("name", "balance"),
                )
            )

            # Mode 1: min_width (auto-calculated if not provided)
            if len(modes) > 1 and modes[1].get("name") == "min_width":
                min_width_mode = modes[1]
                validated_modes.append(
                    (
                        math.ceil(float(min_width_mode.get("width"))),
                        math.ceil(float(min_width_mode.get("height"))),
                        "min_width",
                    )
                )
            else:
                validated_modes.append(
                    (
                        math.ceil(float(calc_min_width)),
                        math.ceil(float(calc_min_height)),
                        "min_width",
                    )
                )

            # Mode 2: min_height (auto-calculated if not provided)
            if len(modes) > 2 and modes[2].get("name") == "min_height":
                min_height_mode = modes[2]
                validated_modes.append(
                    (
                        math.ceil(float(min_height_mode.get("width"))),
                        math.ceil(float(min_height_mode.get("height"))),
                        "min_height",
                    )
                )
            else:
                # min_height mode: use IO-based height (east/west × y_pitch) × 1.1
                min_height_io = Decimal(max(io_count_east, io_count_west)) * Decimal(
                    y_pitch
                )
                calc_min_height_for_mode = min_height_io * Decimal("1.1")
                calc_min_width_for_mode = (
                    balance_area * Decimal(2)
                ) / calc_min_height_for_mode
                validated_modes.append(
                    (
                        math.ceil(float(calc_min_width_for_mode)),
                        math.ceil(float(calc_min_height_for_mode)),
                        "min_height",
                    )
                )
        else:
            # All 3 modes provided in config
            validated_modes = []
            for i, mode in enumerate(modes):
                if not isinstance(mode, dict):
                    raise TypeError(
                        f"Tile {tile_name} mode {i}: must be a dict with 'width', 'height', 'name'"
                    )

                mode_width = mode.get("width")
                mode_height = mode.get("height")
                mode_name = mode.get("name", f"mode_{i}")

                if mode_width is None or mode_height is None:
                    raise ValueError(
                        f"Tile {tile_name} mode {i}: missing 'width' or 'height' in {mode}"
                    )

                validated_modes.append(
                    (
                        math.ceil(float(mode_width)),
                        math.ceil(float(mode_height)),
                        mode_name,
                    )
                )

        tile_mode_options[tile_name] = validated_modes

        # Update min_tile_widths/min_tile_heights to use IO constraints as minimum bounds
        # The minimum bounds should be the maximum of:
        # 1. IO constraints (to ensure routing works)
        # 2. sqrt(area) constraint (to ensure tile functionality)
        # Not the minimum of available modes, since modes are sizing options

        # Get IO constraints
        ports = tile_data.get("ports", {"north": 0, "south": 0, "west": 0, "east": 0})
        if track_pitch is not None:
            x_pitch, y_pitch = track_pitch
            io_min_width = float(
                Decimal(max(ports["north"], ports["south"])) * Decimal(x_pitch)
            )
            io_min_height = float(
                Decimal(max(ports["west"], ports["east"])) * Decimal(y_pitch)
            )
        else:
            io_min_width = 0
            io_min_height = 0

        # Use IO constraints as minimum bounds
        chosen_min_w = math.ceil(max(io_min_width, 1))  # At least 1
        chosen_min_h = math.ceil(max(io_min_height, 1))  # At least 1

        # Also enforce sqrt(area) constraint for tile functionality
        try:
            balance_area_val = float(width) * float(height)
            sqrt_area = math.ceil(math.sqrt(balance_area_val))
            chosen_min_w = max(chosen_min_w, sqrt_area)
            chosen_min_h = max(chosen_min_h, sqrt_area)
        except Exception:
            pass

        min_tile_widths[tile_name] = chosen_min_w
        min_tile_heights[tile_name] = chosen_min_h

        # Debug: report chosen minima for clarity
        try:
            print(
                f"  [chosen-min] {tile_name}: min_width={chosen_min_w} µm, min_height={chosen_min_h} µm"
            )
        except Exception:
            pass

    return min_tile_widths, min_tile_heights, tile_mode_options


# ============================================================================
# TEST FUNCTION
# ============================================================================


def optimize_fabric(
    fabric,
    tiles: dict,
    track_pitch: tuple[Decimal, Decimal],
    tile_mappings: dict | None = None,
) -> tuple[dict[str, int], dict[str, int]]:
    """Optimize fabric dimensions using NLP solver with pre-compiled tile sizes.

    Args:
        fabric: FABulous Fabric object
        tiles: Dict mapping tile_name to tile_spec with required fields:
            - positions: [(r, c), ...] list of tile locations
            - ports: {"north": N, "south": S, "west": W, "east": E}
            - width: pre-computed tile width in µm
            - height: pre-computed tile height in µm
            - area: pre-computed tile area (width × height)
            - modes: list of mode dicts with width, height, name
        track_pitch: (x_pitch, y_pitch) as Decimal
        tile_mappings: Optional dict mapping sub-tiles to parent tiles (e.g., DSP_top -> DSP)

    Returns
    -------
        (optimal_widths, optimal_heights) dicts
    """
    if tile_mappings is None:
        tile_mappings = {}
    num_rows = len(fabric.tile)
    num_cols = len(fabric.tile[0]) if num_rows > 0 else 0
    x_pitch, y_pitch = track_pitch

    print("\n" + "=" * 80)
    print("NLP OPTIMIZATION WITH PRE-COMPILED TILES")
    print("=" * 80)
    print(f"\nFabric: {num_rows} rows × {num_cols} cols")
    print(f"Track pitch: X={x_pitch} µm, Y={y_pitch} µm")
    print(f"Tile types: {len(tiles)}")

    # Build type to positions map
    type_to_positions = {}
    for tile_name, tile_data in tiles.items():
        type_to_positions[tile_name] = tile_data["positions"]

    # Compute IO constraints
    print("\nComputing IO constraints...")
    io_min_dims = {}
    for tile_name, tile_data in tiles.items():
        ports = tile_data["ports"]
        min_width_io = Decimal(max(ports["north"], ports["south"])) * x_pitch
        min_height_io = Decimal(max(ports["west"], ports["east"])) * y_pitch
        io_min_dims[tile_name] = (min_width_io, min_height_io)
        print(
            f"  {tile_name}: IO minimum {float(min_width_io):.2f} × {float(min_height_io):.2f} µm"
        )

    # Create tile bounds and mode options
    min_tile_widths, min_tile_heights, tile_mode_options = create_tile_bounds(
        tiles, track_pitch
    )

    print("\nInput to NLP solver:")
    print(f"  min_tile_widths: {min_tile_widths}")
    print(f"  min_tile_heights: {min_tile_heights}")

    # Prepare tile metrics for the NLP step
    # The step expects metrics with tile dimension data
    tile_metrics = {
        "tile_min_widths": min_tile_widths,
        "tile_min_heights": min_tile_heights,
        "tile_dimension_options": tile_mode_options,
    }

    # Add per-tile metrics in the format expected by NLPTileProblem
    for tile_name, tile_data in tiles.items():
        width = tile_data["width"]
        height = tile_data["height"]
        area = tile_data.get("area", width * height)

        tile_metrics[tile_name] = {
            "design__die__bbox": f"0.0 0.0 {width} {height}",
            "design__instance__area__stdcell": area,
        }

    # Handle tile mappings (e.g., DSP_top/DSP_bot -> DSP)
    # This allows sub-tiles in the fabric grid to use the parent tile's constraints
    for sub_tile, parent_tile in tile_mappings.items():
        if sub_tile == "comment":  # Skip comment field
            continue
        if parent_tile in tile_metrics:
            # Sub-tiles inherit parent tile's metrics
            tile_metrics[sub_tile] = tile_metrics[parent_tile].copy()

    # Call NLP solver
    print("\n" + "=" * 80)
    print("RUNNING NLP SOLVER")
    print("=" * 80 + "\n")

    result = solve_nlp_optimization(fabric, tile_metrics)
    if result is None:
        raise RuntimeError("NLP solver failed")

    optimal_widths, optimal_heights = result

    # Display results
    print("\n" + "=" * 80)
    print("RESULTS")
    print("=" * 80)

    total_area = 0
    for tile_name in sorted(optimal_widths.keys()):
        width = int(optimal_widths[tile_name])
        height = int(optimal_heights[tile_name])
        area = width * height
        num_instances = len(type_to_positions[tile_name])
        total_area += area * num_instances

        min_width_io, min_height_io = io_min_dims[tile_name]

        print(f"\n{tile_name}:")
        print(f"  Optimal: {width} × {height} µm (area: {area} µm²)")
        print(f"  Instances: {num_instances}, Total: {area * num_instances} µm²")
        print(
            f"  IO minimum: {float(min_width_io):.2f} × {float(min_height_io):.2f} µm"
        )

        # Verify constraints (convert to Decimal for comparison)
        width_decimal = Decimal(width)
        height_decimal = Decimal(height)
        width_ok = width_decimal >= min_width_io
        height_ok = height_decimal >= min_height_io

        if width_ok and height_ok:
            print("  ✓ Constraints satisfied")
        else:
            print("  ✗ CONSTRAINT VIOLATION!")
            if not width_ok:
                print(f"     Width {width} < IO minimum {float(min_width_io):.2f}")
            if not height_ok:
                print(f"     Height {height} < IO minimum {float(min_height_io):.2f}")

    print(f"\nTotal fabric area: {total_area} µm²")
    print("=" * 80 + "\n")

    return optimal_widths, optimal_heights


# ============================================================================
# MAIN
# ============================================================================


def main():
    """Run optimization from JSON config with optional project directory."""
    parser = argparse.ArgumentParser(
        description="Optimize fabric layout with pre-compiled tile sizes"
    )
    parser.add_argument(
        "--config",
        required=True,
        help="Path to JSON file with tile specifications (width, height, area, ports, positions)",
        type=str,
    )
    parser.add_argument(
        "--project",
        required=False,
        help="FABulous project directory to extract tile positions from (optional if positions provided in JSON)",
        type=str,
    )

    args = parser.parse_args()

    # Load config
    print(f"Loading configuration from {args.config}...")
    config = load_precompiled_tiles_from_json(args.config)

    # If project is provided, extract positions and ports from project
    if args.project:
        print(f"\nExtracting tile information from project: {args.project}")
        try:
            project_positions = extract_tile_positions_from_project(args.project)
            project_ports = extract_tile_ports_from_project(args.project)
        except Exception as e:
            print(f"✗ Could not extract positions from project: {e}")
            return 1

        # Merge project positions into config
        for tile_name, positions in project_positions.items():
            # Direct match in config
            if tile_name in config["tiles"]:
                config["tiles"][tile_name]["positions"] = positions
                print(
                    f"  ✓ Loaded positions for {tile_name}: {len(positions)} instances"
                )
                continue

            # Special-case: project uses sub-tiles (e.g. DSP_top, DSP_bot) while config
            # lists the parent supertile (e.g. DSP). Map sub-tiles into parent if present.
            if "_" in tile_name:
                base = tile_name.split("_")[0]
                if base in config["tiles"]:
                    # Merge positions into base tile positions list
                    existing = config["tiles"][base].get("positions", [])
                    existing.extend(positions)
                    config["tiles"][base]["positions"] = existing
                    print(
                        f"  ✓ Mapped positions for {tile_name} into base tile {base}: {len(positions)} instances"
                    )
                    continue

            # No mapping found -> error
            print(
                f"  ✗ ERROR: Tile type {tile_name} found in project but NOT defined in config!"
            )
            print(
                f"     Please add '{tile_name}' to your config file with modes or add a mapping to an existing tile type"
            )
            return 1

        # Merge project ports into config (if not already specified in JSON)
        for tile_name, ports in project_ports.items():
            if tile_name in config["tiles"]:
                # Use ports from JSON if provided, otherwise use extracted ports
                if (
                    "ports" not in config["tiles"][tile_name]
                    or not config["tiles"][tile_name]["ports"]
                ):
                    config["tiles"][tile_name]["ports"] = ports
                    print(
                        f"  ✓ Loaded ports for {tile_name} from project: "
                        f"N={ports['north']} S={ports['south']} "
                        f"W={ports['west']} E={ports['east']}"
                    )
                continue

            # If the project uses sub-tiles (e.g. DSP_top), map ports into base tile
            if "_" in tile_name:
                base = tile_name.split("_")[0]
                if base in config["tiles"]:
                    existing = config["tiles"][base].get(
                        "ports", {"north": 0, "south": 0, "west": 0, "east": 0}
                    )
                    # sum ports component-wise
                    existing["north"] = existing.get("north", 0) + ports.get("north", 0)
                    existing["south"] = existing.get("south", 0) + ports.get("south", 0)
                    existing["west"] = existing.get("west", 0) + ports.get("west", 0)
                    existing["east"] = existing.get("east", 0) + ports.get("east", 0)
                    config["tiles"][base]["ports"] = existing
                    print(
                        f"  ✓ Mapped ports for {tile_name} into base tile {base}: "
                        f"N={existing['north']} S={existing['south']} "
                        f"W={existing['west']} E={existing['east']}"
                    )
                    continue

        # Validate that all tiles in config are found in the project
        print("\nValidating tile configuration...")
        project_tile_bases = set()
        for t in project_positions.keys():
            project_tile_bases.add(t)
            if "_" in t:
                project_tile_bases.add(t.split("_")[0])

        missing_in_project = []
        for tile_name in config["tiles"]:
            if tile_name not in project_tile_bases:
                missing_in_project.append(tile_name)

        if missing_in_project:
            print(
                "✗ ERROR: The following tiles are defined in config but NOT found in project:"
            )
            for tile_name in missing_in_project:
                print(f"  - {tile_name}")
            print(
                "   Please remove them from config or ensure they exist in the project fabric"
            )
            return 1

    # Validate that all tiles have positions (required)
    missing_positions = []
    for tile_name, tile_spec in config["tiles"].items():
        if "positions" not in tile_spec or not tile_spec["positions"]:
            missing_positions.append(tile_name)

    if missing_positions:
        print("✗ The following tiles are missing positions:")
        for tile_name in missing_positions:
            print(f"  - {tile_name}")
        print(
            "  Please provide positions in the JSON config or use --project to extract them"
        )
        return 1

    # Validate that all tiles have ports (required)
    missing_ports = []
    for tile_name, tile_spec in config["tiles"].items():
        if "ports" not in tile_spec or not tile_spec["ports"]:
            missing_ports.append(tile_name)

    if missing_ports:
        print("✗ The following tiles are missing ports:")
        for tile_name in missing_ports:
            print(f"  - {tile_name}")
        print(
            "  Please provide ports in the JSON config or use --project to extract them"
        )
        return 1

    print("✓ All tiles have valid positions and ports\n")

    # Convert to proper types
    fabric_size = (config["fabric_size"]["rows"], config["fabric_size"]["cols"])
    track_pitch = (config["track_pitch"]["x"], config["track_pitch"]["y"])

    # Convert positions to tuples and build tiles dict
    tiles = {}
    for tile_name, tile_spec in config["tiles"].items():
        # Use ports from JSON (now required)
        ports = tile_spec["ports"]

        # Derive balance mode width/height from modes (modes must include a balance entry)
        modes = tile_spec.get("modes", [])
        if not modes:
            raise ValueError(
                f"Tile {tile_name} must include at least one mode (balance)"
            )

        balance_mode = None
        for m in modes:
            if m.get("name") == "balance":
                balance_mode = m
                break
        if not balance_mode:
            balance_mode = modes[0]

        bw = balance_mode.get("width")
        bh = balance_mode.get("height")
        if bw is None or bh is None:
            raise ValueError(
                f"Tile {tile_name} balance mode must include width and height"
            )

        area = tile_spec.get("area")
        if area is None:
            try:
                area = int(bw) * int(bh)
            except Exception:
                area = None

        tiles[tile_name] = {
            "positions": [
                tuple(pos) if isinstance(pos, (list, tuple)) else pos
                for pos in tile_spec["positions"]
            ],
            "ports": ports,
            # store balance dimensions and area for downstream use
            "width": int(bw),
            "height": int(bh),
            "area": area,
            "modes": modes,
        }

    # Create a minimal fabric object for optimization
    # We need to create a fabric structure that matches what the NLP solver expects
    print("\nCreating fabric structure for optimization...")
    try:
        # Import the Fabric class
        from FABulous.fabric_definition.Fabric import Fabric

        # Create a minimal fabric with the tile grid
        fabric = Fabric()
        fabric.tile = []

        # Initialize the tile grid
        for r in range(fabric_size[0]):
            row = []
            for c in range(fabric_size[1]):
                # Find which tile belongs at this position
                tile_name = None
                for t_name, t_data in tiles.items():
                    if (r, c) in t_data["positions"]:
                        tile_name = t_name
                        break

                if tile_name:
                    # Create a minimal tile object
                    tile_obj = type("Tile", (), {"name": tile_name})()
                    row.append(tile_obj)
                else:
                    row.append(None)
            fabric.tile.append(row)

        # Initialize superTileDic if needed
        fabric.superTileDic = {}
        tile_mappings = config.get("tile_mappings", {})
        for sub_tile, parent_tile in tile_mappings.items():
            if sub_tile == "comment":  # Skip comment field
                continue
            if parent_tile in tiles:
                # Create a minimal supertile object
                class MockSuperTile:
                    def maxHeight(self):
                        return 2  # Assume 2 rows for DSP

                    def maxWidth(self):
                        return 1  # Assume 1 column

                supertile = MockSuperTile()
                fabric.superTileDic[parent_tile] = supertile

        # Set frame parameters (minimal defaults)
        fabric.frameSelectWidth = 1
        fabric.frameBitsPerRow = 1

        print(f"✓ Created fabric with {fabric_size[0]} rows × {fabric_size[1]} cols")
    except Exception as e:
        print(f"✗ Could not create fabric structure: {e}")
        return 1

    # Run optimization
    try:
        tile_mappings = config.get("tile_mappings", {})
        optimal_widths, optimal_heights = optimize_fabric(
            fabric, tiles, track_pitch, tile_mappings
        )
        return 0
    except Exception as e:
        print(f"✗ Optimization failed: {e}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
