from dataclasses import dataclass, field
from decimal import Decimal
from typing import Optional

from click import Tuple
from librelane.config.variable import Variable
from librelane.flows.classic import Classic
from librelane.flows.flow import Flow
from librelane.logging.logger import info
from librelane.state.state import State
from librelane.steps.step import Step

from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.gds_generator.steps.add_power import FABulousPower
from FABulous.fabric_generator.gds_generator.steps.fabric_IO_placement import (
    FABulousManualIOPlacement,
)


@dataclass
class MacroInstances:
    location: list[tuple[Decimal, Decimal]] = field(default_factory=list)
    orientation: str = "N"


@dataclass
class MacroSettings:
    name: str
    gds: str
    lef: str
    nl: str
    spef: dict[str, list[str]]
    instances: dict[str, MacroInstances] = field(default_factory=dict)


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
        MacroSettings,
        "A dictionary mapping tile names to their macro views (GDS, LEF, NL, SPEF).",
    ),
    Variable(
        "FABULOUS_TILE_SPACING",
        Decimal,
        "The spacing between tiles.",
    ),
    Variable(
        "FABULOUS_HALO_SPACING",
        Optional[Tuple[Decimal, Decimal, Decimal, Decimal]],
        "The spacing around the fabric. [left, bottom, right, top]",
        units="µm",
        default=[100, 100, 100, 100],
    ),
    Variable(
        "FABULOUS_SPEF_CORNERS",
        Optional[list[str]],
        "The SPEF corners to use for the tile macros.",
        default=["nom"],
    ),
]


@Flow.factory.register()
class FABulousFabricStitchingFlow(Classic):
    Substitutions = subs
    config_vars = configs

    def run(self, initial_state: State, **kwargs) -> tuple[State, list[Step]]:
        # Create macro configurations
        macros = {}

        for macro_name in tiles:
            for supertile_name, supertile in self.fabric.superTileDic.items():
                subtiles = [tile.name for tile in supertile.tiles]

                # Get the anchor of the supertile (bottom left)
                anchor = supertile.tileMap[-1][0]

                if macro_name in subtiles:
                    if macro_name == anchor.name:
                        macro_name = supertile_name
                    else:
                        macro_name = None

            if macro_name == None:
                continue

            macros[macro_name] = {
                "gds": [
                    os.path.join(
                        self.config["FABULOUS_TILE_LIBRARY"],
                        macro_name,
                        "macro",
                        self.config["PDK"],
                        "gds",
                        f"{macro_name}.gds",
                    )
                ],
                "lef": [
                    os.path.join(
                        self.config["FABULOUS_TILE_LIBRARY"],
                        macro_name,
                        "macro",
                        self.config["PDK"],
                        "lef",
                        f"{macro_name}.lef",
                    )
                ],
                "nl": [
                    os.path.join(
                        self.config["FABULOUS_TILE_LIBRARY"],
                        macro_name,
                        "macro",
                        self.config["PDK"],
                        "nl",
                        f"{macro_name}.nl.v",
                    )
                ],
                "spef": {},
                "instances": {},
            }

            for corner in self.config["FABULOUS_SPEF_CORNERS"]:
                macros[macro_name]["spef"][f"{corner}_*"] = [
                    os.path.join(
                        self.config["FABULOUS_TILE_LIBRARY"],
                        macro_name,
                        "macro",
                        self.config["PDK"],
                        "spef",
                        corner,
                        f"{macro_name}.{corner}.spef",
                    )
                ]

        # Tile Placement
        TILE_SPACING = self.config["FABULOUS_TILE_SPACING"]
        HALO_SPACING = self.config["FABULOUS_HALO_SPACING"]
        (halo_left, halo_bottom, halo_right, halo_top) = (
            HALO_SPACING[0],
            HALO_SPACING[1],
            HALO_SPACING[2],
            HALO_SPACING[3],
        )

        info(f"FABULOUS_TILE_SIZES: {self.config['FABULOUS_TILE_SIZES']}")

        tile_sizes = {}

        # Get the tile sizes for each individual tile
        for tile_name in self.fabric.tileDic:
            tile_size = None
            for pattern in self.config["FABULOUS_TILE_SIZES"]:
                if fnmatch.fnmatch(tile_name, pattern):
                    tile_size = self.config["FABULOUS_TILE_SIZES"][pattern]
                    break

            if tile_size == None:
                err(f"Could not match {tile_name} with FABULOUS_TILE_SIZES")
            tile_sizes[tile_name] = tile_size

        info(f"Tile sizes: {tile_sizes}")

        # Calculate width and height of the fabric
        # from the sizes of the individual tiles

        FABRIC_NUM_TILES_X = self.fabric.numberOfColumns
        FABRIC_NUM_TILES_Y = self.fabric.numberOfRows

        # FABRIC_WIDTH
        FABRIC_WIDTH = halo_left + halo_right

        for i in range(FABRIC_NUM_TILES_X):
            # Find a non-NULL tile
            for row in self.fabric.tile:
                if row[i] != None:
                    # Append tile width
                    FABRIC_WIDTH += tile_sizes[row[i].name][0] + TILE_SPACING
                    break

        FABRIC_WIDTH -= TILE_SPACING
        info(f"FABRIC_WIDTH: {FABRIC_WIDTH}")

        # FABRIC_HEIGHT
        FABRIC_HEIGHT = halo_bottom + halo_top

        for i in range(FABRIC_NUM_TILES_Y):
            # Find a non-NULL tile
            for tile in self.fabric.tile[i]:
                if tile != None:
                    # Append tile height
                    FABRIC_HEIGHT += tile_sizes[tile.name][1] + TILE_SPACING
                    break

        FABRIC_HEIGHT -= TILE_SPACING
        info(f"FABRIC_HEIGHT: {FABRIC_HEIGHT}")

        # Calculate the height of each row
        row_heights = []
        for i in range(FABRIC_NUM_TILES_Y):
            # Find a non-NULL tile
            for tile in self.fabric.tile[i]:
                if tile != None:
                    # Append tile height
                    row_heights.append(tile_sizes[tile.name][1])
                    break
        info(f"row_heights: {row_heights}")
        assert len(row_heights) == FABRIC_NUM_TILES_Y

        # Calculate the width of each column
        column_widths = []
        for i in range(FABRIC_NUM_TILES_X):
            # Find a non-NULL tile
            for row in self.fabric.tile:
                if row[i] != None:
                    # Append tile width
                    column_widths.append(tile_sizes[row[i].name][0])
                    break
        info(f"column_widths: {column_widths}")
        assert len(column_widths) == FABRIC_NUM_TILES_X

        # Place macros
        cur_y = 0
        for y, row in enumerate(reversed(self.fabric.tile)):
            cur_x = 0
            flipped_y = FABRIC_NUM_TILES_Y - 1 - y

            for x, tile in enumerate(row):
                tile_name = tile.name if tile is not None else None
                prefix = f"Tile_X{x}Y{flipped_y}_"

                for supertile_name, supertile in self.fabric.superTileDic.items():
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

                if tile_name == None:
                    info(f"Skipping {tile_name}")
                else:
                    if tile_name not in macros:
                        err(f"Could not find {tile_name} in macros")

                    macros[tile_name]["instances"][f"{prefix}{tile_name}"] = {
                        "location": [
                            halo_left + cur_x,
                            halo_bottom
                            + cur_y,  # (TILE_HEIGHT + TILE_SPACING) * (FABRIC_NUM_TILES_Y-1-y)
                        ],
                        "orientation": "N",
                    }

                cur_x += column_widths[x]

            cur_y += row_heights[flipped_y]

        # Set DIE_AREA and FP_SIZING
        self.config = self.config.copy(DIE_AREA=[0, 0, FABRIC_WIDTH, FABRIC_HEIGHT])
        self.config = self.config.copy(FP_SIZING="absolute")

        info(f"Setting DIE_AREA to {self.config['DIE_AREA']}")
        info(f"Setting FP_SIZING to {self.config['FP_SIZING']}")

        # Set MACROS
        self.config = self.config.copy(MACROS=macros)

        info(f"Setting MACROS to {self.config['MACROS']}")

        info(verilog_files)

        # Overwrite VERILOG_FILES config variable with our Verilog files
        self.config = self.config.copy(VERILOG_FILES=verilog_files)

        info(f"Setting VERILOG_FILES to {self.config['VERILOG_FILES']}")

        print(self.config)

        (final_state, steps) = super().run(initial_state, **kwargs)

        final_views_path = os.path.abspath(
            os.path.join(".", "macro", self.config["PDK"])
        )
        info(f"Saving final views for FABulous to {final_views_path}")
        final_state.save_snapshot(final_views_path)

        info("Copying FABulous related files.")
        fabulous_path = os.path.abspath(
            os.path.join(".", "macro", self.config["PDK"], "fabulous")
        )
        fabulous_hidden_path = os.path.join(fabulous_path, ".FABulous")

        return (final_state, steps)
