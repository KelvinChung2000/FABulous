"""Stitching flow to assemble FABulous tile macros into a complete fabric."""

import re
from dataclasses import dataclass, field
from decimal import Decimal
from pathlib import Path
from typing import NamedTuple

from librelane.config.variable import Variable
from librelane.flows.classic import Classic
from librelane.flows.flow import Flow
from librelane.logging.logger import err, info
from librelane.state.state import State
from librelane.steps.step import Step

from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.gds_generator.steps.add_power import FABulousPower
from FABulous.fabric_generator.gds_generator.steps.fabric_IO_placement import (
    FABulousManualIOPlacement,
)


@dataclass
class MacroInstance:
    """Represents a single instance of a macro with its placement information."""

    location: tuple[Decimal, Decimal]
    orientation: str = "N"


@dataclass
class MacroSettings:
    """Represents a macro definition with its files and instances."""

    size: tuple[Decimal, Decimal]
    gds: str
    lef: str
    nl: str
    spef: dict[str, list[str]]
    instances: dict[str, MacroInstance] = field(default_factory=dict)


# Add namedtuple for tile sizes
class TileSize(NamedTuple):
    width: Decimal
    height: Decimal


subs = {
    # Disable STA
    "OpenROAD.STAPrePNR": None,
    "OpenROAD.STAMidPNR": None,
    "OpenROAD.STAPostPNR": None,
    # Custom PDN generation script
    "OpenROAD.GeneratePDN": FABulousPower,
    # Script to manually place single IOs
    "+OpenROAD.GlobalPlacementSkipIO": FABulousManualIOPlacement,
}

configs = Classic.config_vars + [
    Variable(
        "FABULOUS_FABRIC",
        Fabric,
        "The fabric configuration file.",
    ),
    Variable(
        "FABULOUS_MACRO_SETTINGS",
        dict[str, MacroSettings],
        "A dictionary mapping tile names to their macro views (GDS, LEF, NL, SPEF).",
    ),
    Variable(
        "FABULOUS_TILE_SPACING",
        Decimal,
        "The spacing between tiles.",
    ),
    Variable(
        "FABULOUS_HALO_SPACING",
        tuple[Decimal, Decimal, Decimal, Decimal] | None,
        "The spacing around the fabric. [left, bottom, right, top]",
        units="µm",
        default=[100, 100, 100, 100],
    ),
    Variable(
        "FABULOUS_SPEF_CORNERS",
        list[str] | None,
        "The SPEF corners to use for the tile macros.",
        default=["nom"],
    ),
]


@Flow.factory.register()
class FABulousFabricStitchingFlow(Classic):
    """Flow for stitching together individual tile macros into a complete fabric.

    This flow handles the placement and interconnection of pre-generated tile macros
    to create the final fabric layout, including power distribution and IO placement.
    """

    Substitutions = subs
    config_vars = configs

    def _compute_row_and_column_sizes(
        self,
        fabric: Fabric,
        tile_sizes: dict[str, TileSize],
    ) -> tuple[list[Decimal], list[Decimal]]:
        """Compute row heights and column widths in a single pass.

        Parameters
        ----------
        fabric : Fabric
            The fabric object with tile grid and dimensions.
        tile_sizes : dict[str, TileSize]
            Mapping from tile name to (width, height).

        Returns
        -------
        tuple[list[Decimal], list[Decimal]]
            Row heights (len = numberOfRows) and column widths (len = numberOfColumns).
        """
        rows = fabric.numberOfRows
        cols = fabric.numberOfColumns

        row_heights_map: dict[int, Decimal] = {}
        col_widths_map: dict[int, Decimal] = {}

        # Single pass through the grid; capture the first non-null in each row/col
        for y in range(rows):
            for x in range(cols):
                t = fabric.tile[y][x]
                if t is None:
                    continue
                if y not in row_heights_map:
                    row_heights_map[y] = tile_sizes[t.name].height
                if x not in col_widths_map:
                    col_widths_map[x] = tile_sizes[t.name].width

        # Build ordered lists and validate completeness
        row_heights: list[Decimal] = []
        for y in range(rows):
            h = row_heights_map.get(y)
            if h is None:
                err(f"Missing height for row {y} (no non-null tiles)")
                h = Decimal(0)
            row_heights.append(h)

        column_widths: list[Decimal] = []
        for x in range(cols):
            w = col_widths_map.get(x)
            if w is None:
                err(f"Missing width for column {x} (no non-null tiles)")
                w = Decimal(0)
            column_widths.append(w)

        return row_heights, column_widths

    def _compute_die_area(
        self,
        row_heights: list[Decimal],
        column_widths: list[Decimal],
        halo_spacing: tuple[Decimal, Decimal, Decimal, Decimal],
        tile_spacing: Decimal,
    ) -> tuple[Decimal, Decimal]:
        """Compute overall fabric width and height from per-row/column sizes.

        Returns
        -------
        tuple[Decimal, Decimal]
            (fabric_width, fabric_height)
        """
        cols = len(column_widths)
        rows = len(row_heights)

        (halo_left, halo_bottom, halo_right, halo_top) = halo_spacing

        fabric_width = (
            halo_left
            + halo_right
            + sum(column_widths)
            + (tile_spacing * (cols - 1) if cols > 0 else Decimal(0))
        )
        fabric_height = (
            halo_bottom
            + halo_top
            + sum(row_heights)
            + (tile_spacing * (rows - 1) if rows > 0 else Decimal(0))
        )

        return fabric_width, fabric_height

    def _extract_size_from_lef(self, lef_path: Path) -> TileSize:
        """Extract tile size from LEF file.

        Parameters
        ----------
        lef_path : Path
            Path to the LEF file

        Returns
        -------
        TileSize
            Tile dimensions (width, height) extracted from LEF

        Raises
        ------
        FileNotFoundError
            If LEF file doesn't exist
        ValueError
            If SIZE information cannot be found or parsed
        """
        if not lef_path.exists():
            raise FileNotFoundError(f"LEF file not found: {lef_path}")

        # Regex pattern to match SIZE directive: "SIZE 500.000 BY 500.000 ;"
        size_pattern = re.compile(r"SIZE\s+(\d+(?:\.\d+)?)\s+BY\s+(\d+(?:\.\d+)?)\s*;")

        try:
            with lef_path.open() as f:
                content = f.read()

            match = size_pattern.search(content)
            if not match:
                raise ValueError(f"SIZE directive not found in LEF file: {lef_path}")

            width = Decimal(match.group(1))
            height = Decimal(match.group(2))

            return TileSize(width, height)

        except Exception as e:
            if isinstance(e, (FileNotFoundError, ValueError)):
                raise
            raise ValueError(f"Error parsing LEF file {lef_path}: {e}") from e

    def run(self, initial_state: State, **kwargs: dict) -> tuple[State, list[Step]]:
        """Execute the fabric stitching flow.

        Args
        ----
        initial_state : State
            Initial state for the flow
        **kwargs : dict
            Additional keyword arguments

        Returns
        -------
        tuple[State, list[Step]]
            Tuple of final state and list of executed steps
        """
        fabric: Fabric = self.config["FABULOUS_FABRIC"]

        # Get macro configurations from config
        macros: dict[str, MacroSettings] = self.config["FABULOUS_MACRO_SETTINGS"]

        # Tile Placement
        tile_spacing: Decimal = self.config["FABULOUS_TILE_SPACING"]
        halo_spacing: tuple[Decimal, Decimal, Decimal, Decimal] = self.config[
            "FABULOUS_HALO_SPACING"
        ]
        (halo_left, halo_bottom, _, _) = halo_spacing

        tile_sizes = {}

        # Get the tile sizes for each individual tile by reading from LEF files
        for tile_name in fabric.tileDic:
            if tile_name not in macros:
                err(f"Could not find {tile_name} in macros")
                continue

            lef_path = Path(macros[tile_name].lef)

            try:
                tile_size = self._extract_size_from_lef(lef_path)
                tile_sizes[tile_name] = tile_size
                info(
                    f"Extracted size for {tile_name}: "
                    f"{tile_size.width} x {tile_size.height}"
                )
            except (FileNotFoundError, ValueError) as e:
                err(f"Failed to extract size for {tile_name} from {lef_path}: {e}")
                # Use a default size to prevent complete failure
                tile_sizes[tile_name] = TileSize(Decimal(0), Decimal(0))

        info(f"Tile sizes: {tile_sizes}")

        # Compute per-row and per-column sizes once, then derive DIE_AREA
        row_heights, column_widths = self._compute_row_and_column_sizes(
            fabric, tile_sizes
        )
        info(f"row_heights: {row_heights}")
        if len(row_heights) != fabric.numberOfRows:
            err(f"Expected {fabric.numberOfRows} row heights, got {len(row_heights)}")

        info(f"column_widths: {column_widths}")
        if len(column_widths) != fabric.numberOfColumns:
            err(
                f"Expected {fabric.numberOfColumns} column widths, got "
                f"{len(column_widths)}"
            )

        fabric_width, fabric_height = self._compute_die_area(
            row_heights,
            column_widths,
            halo_spacing,
            tile_spacing,
        )
        info(f"FABRIC_WIDTH: {fabric_width}")
        info(f"FABRIC_HEIGHT: {fabric_height}")
        self.config = self.config.copy(DIE_AREA=[0, 0, fabric_width, fabric_height])

        # Place macros
        cur_y = 0
        for y, row in enumerate(reversed(fabric.tile)):
            cur_x = 0
            flipped_y = fabric.numberOfRows - 1 - y

            for x, tile in enumerate(row):
                tile_name = tile.name if tile is not None else None
                prefix = f"Tile_X{x}Y{flipped_y}_"

                for supertile_name, supertile in fabric.superTileDic.items():
                    subtiles = [tile.name for tile in supertile.tiles]

                    # Get the anchor of the supertile (bottom left)
                    anchor = supertile.tileMap[-1][0]

                    if tile_name in subtiles:
                        if tile_name == anchor.name:
                            tile_name = supertile_name

                            # While the physical anchor is at the bottom left,
                            # the anchor in FABulous is at the top left
                            prefix = (
                                f"Tile_X{x}Y{flipped_y - (len(supertile.tileMap) - 1)}_"
                            )
                        else:
                            tile_name = None

                if tile_name is None:
                    info(f"Skipping {tile_name}")
                else:
                    if tile_name not in macros:
                        err(f"Could not find {tile_name} in macros")

                    macros[tile_name].instances[f"{prefix}{tile_name}"] = MacroInstance(
                        location=(
                            halo_left + cur_x,
                            halo_bottom + cur_y,
                        ),
                        orientation="N",
                    )

                cur_x += column_widths[x]

            cur_y += row_heights[flipped_y]

        # Set DIE_AREA and FP_SIZING
        self.config = self.config.copy(FP_SIZING="absolute")

        info(f"Setting DIE_AREA to {self.config['DIE_AREA']}")
        info(f"Setting FP_SIZING to {self.config['FP_SIZING']}")

        # Set MACROS
        self.config = self.config.copy(MACROS=macros)

        info(f"Setting MACROS to {self.config['MACROS']}")

        info(f"Setting VERILOG_FILES to {self.config['VERILOG_FILES']}")

        info(f"Complete configuration: {self.config}")

        (final_state, steps) = super().run(initial_state, **kwargs)

        final_views_path = (Path() / "macro" / self.config["PDK"]).resolve()
        info(f"Saving final views for FABulous to {final_views_path}")
        final_state.save_snapshot(final_views_path)

        info("Copying FABulous related files.")

        return (final_state, steps)
