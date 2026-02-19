"""FABulous GDS Generator - NLP Optimization Step using pymoo."""

import json
from collections import defaultdict
from decimal import Decimal
from pathlib import Path
from typing import Any, Optional

import numpy as np
from librelane.config.variable import Variable
from librelane.flows.flow import FlowException
from librelane.logging.logger import info, warn
from librelane.state.design_format import DesignFormat
from librelane.state.state import State
from librelane.steps.step import MetricsUpdate, Step, ViewsUpdate
from pymoo.algorithms.soo.nonconvex.isres import ISRES
from pymoo.core.problem import ElementwiseProblem
from pymoo.core.repair import Repair
from pymoo.optimize import minimize
from pymoo.termination.max_gen import MaximumGenerationTermination

from fabulous.fabric_definition.fabric import Fabric
from fabulous.fabric_generator.gds_generator.helper import round_up_decimal
from fabulous.fabric_generator.gds_generator.steps.tile_optimisation import OptMode


class NLPTileProblem(ElementwiseProblem):
    """NLP problem for tile size optimization using row/column variables.

    Variables are row heights h[r] and column widths w[c], so that uniformity
    within each row and column is inherent in the formulation rather than
    enforced through soft equality constraints.

    Rows that share a tile type are linked into equivalence classes so they
    get a single shared height variable. Columns are linked similarly.
    """

    def __init__(
        self,
        fabric: Fabric,
        tile_metrics: dict[OptMode, dict],
        all_tile_metrics: dict[OptMode, dict] | None = None,
    ) -> None:
        self.fabric = fabric
        self.tile_metrics = tile_metrics
        # all_tile_metrics includes failed explorations for lower bounds
        self._all_tile_metrics = all_tile_metrics or tile_metrics

        self.tile_row_set: dict[str, set[int]] = defaultdict(set)
        self.tile_column_set: dict[str, set[int]] = defaultdict(set)
        self.position_map: dict[tuple[int, int], str] = {}

        for (x, y), tile in fabric:
            if tile is None:
                continue
            self.tile_row_set[tile.name].add(y)
            self.tile_column_set[tile.name].add(x)
            self.position_map[(x, y)] = tile.name

        # Rows sharing a tile type must have the same height, and likewise
        # for columns. Union-find groups enforce this.
        self.row_groups: dict[int, int] = {}
        self._compute_equivalence_classes(self.tile_row_set, self.row_groups)

        self.col_groups: dict[int, int] = {}
        self._compute_equivalence_classes(self.tile_column_set, self.col_groups)

        unique_row_groups = sorted(set(self.row_groups.values()))
        unique_col_groups = sorted(set(self.col_groups.values()))
        self.row_group_to_var: dict[int, int] = {
            g: i for i, g in enumerate(unique_row_groups)
        }
        n_row_vars = len(unique_row_groups)
        self.col_group_to_var: dict[int, int] = {
            g: n_row_vars + i for i, g in enumerate(unique_col_groups)
        }
        n_vars = n_row_vars + len(unique_col_groups)

        info(
            f"NLP variables: {n_row_vars} row groups, "
            f"{len(unique_col_groups)} column groups = {n_vars} total"
        )

        tile_min: dict[str, tuple[float, float]] = {}
        for tile in fabric.tileDic.values():
            if tile.partOfSuperTile:
                continue
            tile_min[tile.name] = self._min_dimensions_from_metrics(tile.name)

        # SuperTile components derive bounds from the SuperTile minimum
        # and from row/column neighbors
        for supertile in fabric.superTileDic.values():
            st_min_w, st_min_h = self._min_dimensions_from_metrics(supertile.name)
            n_cols = sum(1 for t in supertile.tileMap[0] if t is not None)
            n_rows = sum(1 for row in supertile.tileMap if row and row[0] is not None)

            for row in supertile.tileMap:
                for component_tile in row:
                    if component_tile is None:
                        continue
                    name = component_tile.name
                    neighbors = self._find_sharing_tiles(name, self.tile_row_set)
                    neighbor_h = max(
                        (tile_min[n][1] for n in neighbors if n in tile_min),
                        default=1.0,
                    )
                    tile_min.setdefault(name, (1.0, 1.0))
                    tile_min[name] = (
                        tile_min[name][0],
                        max(neighbor_h, st_min_h / n_rows),
                    )

            for col_idx in range(supertile.max_width):
                for row in supertile.tileMap:
                    if col_idx >= len(row) or row[col_idx] is None:
                        continue
                    name = row[col_idx].name
                    neighbors = self._find_sharing_tiles(name, self.tile_column_set)
                    neighbor_w = max(
                        (tile_min[n][0] for n in neighbors if n in tile_min),
                        default=1.0,
                    )
                    tile_min[name] = (
                        max(neighbor_w, st_min_w / n_cols),
                        tile_min[name][1],
                    )

        xl = np.zeros(n_vars)

        for tile_name, (_, min_h) in tile_min.items():
            for row_idx in self.tile_row_set[tile_name]:
                var_idx = self.row_group_to_var[self.row_groups[row_idx]]
                xl[var_idx] = max(xl[var_idx], min_h)

        for tile_name, (min_w, _) in tile_min.items():
            for col_idx in self.tile_column_set[tile_name]:
                var_idx = self.col_group_to_var[self.col_groups[col_idx]]
                xl[var_idx] = max(xl[var_idx], min_w)

        xu = xl * 4

        # Verify every tile/supertile has at least one successful compilation.
        self._verify_all_tiles_have_metrics()

        self._tile_constraints = self._build_tile_constraints()
        self._supertile_constraints = self._build_supertile_constraints()
        n_constr = len(self._tile_constraints) + len(self._supertile_constraints)

        info(f"NLP constraints: {n_constr} area constraints")

        super().__init__(
            n_var=n_vars,
            n_obj=1,
            n_ieq_constr=n_constr,
            xl=xl,
            xu=xu,
        )

    @staticmethod
    def _compute_equivalence_classes(
        tile_positions: dict[str, set[int]],
        groups: dict[int, int],
    ) -> None:
        """Compute equivalence classes for rows or columns.

        Two indices must be in the same group if any tile type appears in both.
        Uses union-find logic to compute transitive closure.
        """
        parent: dict[int, int] = {}

        def find(x: int) -> int:
            while parent.get(x, x) != x:
                parent[x] = parent.get(parent[x], parent[x])
                x = parent[x]
            return x

        def union(a: int, b: int) -> None:
            ra, rb = find(a), find(b)
            if ra != rb:
                parent[ra] = rb

        all_indices: set[int] = set()
        for indices in tile_positions.values():
            all_indices |= indices

        for idx in all_indices:
            parent[idx] = idx

        for indices in tile_positions.values():
            idx_list = sorted(indices)
            for i in range(1, len(idx_list)):
                union(idx_list[0], idx_list[i])

        for idx in all_indices:
            groups[idx] = find(idx)

    def _min_dimensions_from_metrics(self, name: str) -> tuple[float, float]:
        """Return (min_width, min_height) across all compilation modes.

        The minimum width and height may come from different modes. Falls back
        to 1.0 if no metrics exist for the given tile.
        """
        widths: list[float] = []
        heights: list[float] = []
        for mode_metrics in self._all_tile_metrics.values():
            if name not in mode_metrics:
                continue
            x0, y0, x1, y1 = mode_metrics[name]["design__die__bbox"]
            widths.append(x1 - x0)
            heights.append(y1 - y0)
        return (
            min(widths) if widths else 1.0,
            min(heights) if heights else 1.0,
        )

    @staticmethod
    def _find_sharing_tiles(
        tile_name: str,
        tile_positions: dict[str, set[int]],
    ) -> set[str]:
        """Find tiles sharing at least one row or column with the given tile."""
        positions = tile_positions[tile_name]
        return {
            other
            for other, other_pos in tile_positions.items()
            if other != tile_name and positions & other_pos
        }

    def _verify_all_tiles_have_metrics(self) -> None:
        """Verify every tile and supertile has at least one successful compilation.

        Raises ``RuntimeError`` listing the names of any tiles that failed
        all exploration modes.  This catches configuration or sizing issues
        early rather than letting the NLP produce unconstrained results.
        """
        all_valid_names = {
            name for mode_metrics in self.tile_metrics.values() for name in mode_metrics
        }

        missing: list[str] = []
        for tile in self.fabric.tileDic.values():
            if tile.partOfSuperTile:
                continue
            if tile.name not in all_valid_names:
                missing.append(tile.name)

        for supertile in self.fabric.superTileDic.values():
            if supertile.name not in all_valid_names:
                missing.append(supertile.name)

        if missing:
            raise RuntimeError(
                f"Tile(s) {missing} failed all exploration modes and have no "
                f"successful compilation. The NLP cannot determine feasible "
                f"dimensions without at least one working compilation per tile."
            )

    def get_row_height(self, x: np.ndarray, row_idx: int) -> float:
        """Get the height variable for a given row index."""
        return x[self.row_group_to_var[self.row_groups[row_idx]]]

    def get_col_width(self, x: np.ndarray, col_idx: int) -> float:
        """Get the width variable for a given column index."""
        return x[self.col_group_to_var[self.col_groups[col_idx]]]

    def _build_tile_constraints(self) -> list[tuple[str, int, int]]:
        """Build (tile_name, col, row) tuples for regular tile constraints.

        One representative position per tile type suffices because all
        positions in the same row/col group share identical dimensions.
        """
        constraints = []
        for tile in self.fabric.tileDic.values():
            if tile.partOfSuperTile:
                continue
            rows = sorted(self.tile_row_set[tile.name])
            cols = sorted(self.tile_column_set[tile.name])
            if rows and cols:
                constraints.append((tile.name, cols[0], rows[0]))
        return constraints

    def _build_supertile_constraints(
        self,
    ) -> list[tuple[str, list[int], list[int]]]:
        """Build (st_name, col_indices, row_indices) for SuperTile constraints."""
        constraints = []
        for supertile in self.fabric.superTileDic.values():
            st_cols = []
            if supertile.tileMap:
                for tile in supertile.tileMap[0]:
                    if tile is not None:
                        st_cols.append(sorted(self.tile_column_set[tile.name])[0])

            st_rows = []
            for row in supertile.tileMap:
                if row and row[0] is not None:
                    st_rows.append(sorted(self.tile_row_set[row[0].name])[0])

            constraints.append((supertile.name, st_cols, st_rows))
        return constraints

    def _evaluate(self, x: np.ndarray, out: dict) -> None:
        """Pymoo evaluation: compute objective and constraints."""
        out["F"] = self._compute_objective(x)
        out["G"] = np.array(self._eval_constraints(x), dtype=float)

    def _compute_objective(self, x: np.ndarray) -> float:
        """Minimize total fabric area = sum over all grid positions of w*h."""
        total_area = 0.0
        for col, row in self.position_map:
            total_area += self.get_col_width(x, col) * self.get_row_height(x, row)
        return total_area

    def _best_mode_violation(self, name: str, alloc_w: float, alloc_h: float) -> float:
        """Return the best (minimum) dimensional violation across all modes.

        For each mode, the violation is
          max(w_mode - alloc_w, h_mode - alloc_h).
        A non-positive result means at least one mode fits the allocation.
        Returns inf if the tile has no metrics in any mode.
        """
        violations = []
        for mode_metrics in self.tile_metrics.values():
            if name not in mode_metrics:
                continue
            x0, y0, x1, y1 = mode_metrics[name]["design__die__bbox"]
            violations.append(max((x1 - x0) - alloc_w, (y1 - y0) - alloc_h))
        return min(violations) if violations else float("inf")

    def _eval_constraints(self, x: np.ndarray) -> list[float]:
        """Evaluate dimensional feasibility constraints.

        For each tile/supertile, at least one exploration mode must fit:
          min over modes of max(w_mode - w_alloc, h_mode - h_alloc) <= 0
        """
        result: list[float] = []

        for tile_name, col, row in self._tile_constraints:
            alloc_w = self.get_col_width(x, col)
            alloc_h = self.get_row_height(x, row)
            result.append(self._best_mode_violation(tile_name, alloc_w, alloc_h))

        for st_name, st_cols, st_rows in self._supertile_constraints:
            total_w = sum(self.get_col_width(x, c) for c in st_cols)
            total_h = sum(self.get_row_height(x, r) for r in st_rows)
            result.append(self._best_mode_violation(st_name, total_w, total_h))

        return result


@Step.factory.register()
class GlobalTileSizeOptimization(Step):
    """LibreLane step for NLP optimization of tile dimensions.

    Formulates and solves a Non-Linear Program using pymoo to minimize total
    fabric area. Variables are row heights and column widths, ensuring
    uniformity within each row/column by construction.
    """

    id = "FABulous.GlobalTileSizeOptimization"
    name = "FABulous Global Tile Size Optimization"

    config_vars = [
        Variable(
            "TILE_OPT_INFO",
            Optional[Path],  # noqa: UP045 librelane issue
            description="Tile optimization information dictionary or path to JSON file",
            default=None,
        ),
        Variable(
            "FABULOUS_FABRIC",
            Fabric,
            description="Fabric configuration object",
        ),
        Variable(
            "FABULOUS_PROJ_DIR",
            Path,
            description="Path to the FABulous project directory",
        ),
    ]

    inputs = []
    outputs = [
        DesignFormat.GDS,
        DesignFormat.LEF,
        DesignFormat.LIB,
        DesignFormat.DEF,
    ]

    @staticmethod
    def _parse_bbox_fields(data: dict) -> dict[str, list[float]]:
        """Parse die and core bbox strings into float lists."""

        def parse(key: str) -> list[float]:
            return [float(v) for v in data[key].split()]

        return {
            "design__die__bbox": parse("design__die__bbox"),
            "design__core__bbox": parse("design__core__bbox"),
        }

    @classmethod
    def _load_tile_metrics_from_json(
        cls,
        path: Path,
    ) -> tuple[dict[OptMode, dict], dict[OptMode, dict]]:
        """Load tile metrics from a JSON file.

        Returns two dicts: (valid_metrics, all_metrics).
        valid_metrics excludes tiles whose exploration never found a
        working state (used for feasibility constraints).
        all_metrics includes everything with a bbox (used for lower bounds).
        """
        tile_data_raw = json.loads(path.resolve().read_text())
        valid_data: dict[OptMode, dict] = {}
        all_data: dict[OptMode, dict] = {}

        for mode, tile_info in tile_data_raw.items():
            valid_dict: dict[str, dict[str, list[float]]] = {}
            all_dict: dict[str, dict[str, list[float]]] = {}

            for tile_name, data in tile_info.items():
                if "design__die__bbox" not in data:
                    if "error" in data:
                        warn(
                            f"Tile {tile_name} in mode {mode} has error "
                            f"and no bbox: {data['error']}"
                        )
                    continue

                parsed = cls._parse_bbox_fields(data)
                all_dict[tile_name] = parsed

                if "No working state found" in data.get("error_traceback", ""):
                    warn(
                        f"Tile {tile_name} in mode {mode} never compiled "
                        f"successfully, excluding from constraints"
                    )
                else:
                    valid_dict[tile_name] = parsed

            valid_data[OptMode(mode)] = valid_dict
            all_data[OptMode(mode)] = all_dict

        return valid_data, all_data

    def run(self, state_in: State, **_kwargs: str) -> tuple[ViewsUpdate, MetricsUpdate]:
        """Solve NLP problem for optimal tile dimensions."""
        info("Formulating NLP problem using pymoo...")
        if self.config["TILE_OPT_INFO"] is None:
            raise FlowException(
                "Values of TILE_OPT_INFO should have been set when calling this step."
            )
        fabric: Fabric = self.config["FABULOUS_FABRIC"]

        if isinstance(self.config["TILE_OPT_INFO"], Path):
            valid_metrics, all_metrics = self._load_tile_metrics_from_json(
                self.config["TILE_OPT_INFO"]
            )
        else:
            valid_metrics = self.config["TILE_OPT_INFO"]
            all_metrics = valid_metrics

        problem = NLPTileProblem(fabric, valid_metrics, all_metrics)

        x_pitch = Decimal(state_in.metrics.get("pdk__site_width", 0.5))
        y_pitch = Decimal(state_in.metrics.get("pdk__site_height", 0.5))

        n_row_vars = len(set(problem.row_groups.values()))

        class RoundRepair(Repair):
            def _do(self, _problem: Any, X: np.ndarray, **_kwargs: Any) -> np.ndarray:  # noqa: ANN401
                """Round variables to nearest grid pitch."""
                for j in range(X.shape[0]):
                    for i in range(X.shape[1]):
                        if i < n_row_vars:  # row height variables
                            X[j][i] = float(round_up_decimal(Decimal(X[j][i]), y_pitch))
                        else:  # column width variables
                            X[j][i] = float(round_up_decimal(Decimal(X[j][i]), x_pitch))
                return X

        algorithm = ISRES(repair=RoundRepair())

        n_gen = 500
        info(f"Running optimization for {n_gen} generations")
        termination = MaximumGenerationTermination(n_gen)

        res = minimize(problem, algorithm, termination, verbose=True)

        if res.X is None:
            if hasattr(res, "pop") and res.pop is not None and len(res.pop) > 0:
                info("No single best solution found, using best from population")
                pop_sorted = sorted(
                    res.pop,
                    key=lambda ind: (
                        ind.CV[0]
                        if hasattr(ind, "CV") and ind.CV is not None
                        else float("inf"),
                        ind.F[0],
                    ),
                )
                best_ind = pop_sorted[0]
                res.X = best_ind.X
                res.F = best_ind.F
                res.CV = best_ind.CV if hasattr(best_ind, "CV") else None
            else:
                raise RuntimeError("NLP optimization failed to find any solution")

        if hasattr(res, "CV") and res.CV is not None:
            if res.CV[0] > 1e-6:
                warn(f"Solution has constraint violation of {res.CV[0]}")
            else:
                info(f"Found feasible solution with CV={res.CV[0]}")
        else:
            info("Found solution (constraint violation not available)")

        info(f"Optimization terminated with objective={res.F[0]}")

        quant = Decimal(".01")
        zero = Decimal(0)
        result_dict: dict[str, tuple[Decimal, ...]] = {}

        def quantized_width(tile_name: str) -> Decimal:
            col = sorted(problem.tile_column_set[tile_name])[0]
            return Decimal(problem.get_col_width(res.X, col)).quantize(quant)

        def quantized_height(tile_name: str) -> Decimal:
            row = sorted(problem.tile_row_set[tile_name])[0]
            return Decimal(problem.get_row_height(res.X, row)).quantize(quant)

        for tile in fabric.tileDic.values():
            if tile.partOfSuperTile:
                continue
            result_dict[tile.name] = (
                zero,
                zero,
                quantized_width(tile.name),
                quantized_height(tile.name),
            )

        for supertile in fabric.superTileDic.values():
            total_w = zero
            if supertile.tileMap:
                for tile in supertile.tileMap[0]:
                    if tile is not None:
                        total_w += quantized_width(tile.name)

            total_h = zero
            for row_tiles in supertile.tileMap:
                if row_tiles and row_tiles[0] is not None:
                    total_h += quantized_height(row_tiles[0].name)

            result_dict[supertile.name] = (zero, zero, total_w, total_h)

        total_area = int(res.F[0])
        info(f"  Total fabric area: {total_area}")
        info(f"  Optimal tile dimensions: {result_dict}")

        return {}, {
            "nlp__tile__area": result_dict,
            "nlp__total__area": total_area,
        }
