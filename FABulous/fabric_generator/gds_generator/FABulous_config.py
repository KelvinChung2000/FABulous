from decimal import Decimal

from librelane.config.variable import Macro, Variable

from FABulous.fabric_definition.Fabric import Fabric

fabulous_fabric_flow_config = [
    Variable(
        "FABULOUS_FABRIC",
        Fabric,
        "The fabric configuration object.",
    ),
    Variable(
        "FABULOUS_MACROS_SETTINGS",
        dict[str, Macro],
        "A dictionary mapping tile names to their macro views (GDS, LEF, NL, SPEF).",
    ),
    Variable(
        "FABULOUS_TILE_SIZES",
        dict[str, tuple[Decimal, Decimal]],
        "A dictionary mapping tile names to their sizes (width, height).",
    ),
    Variable(
        "FABULOUS_TILE_SPACING",
        tuple[Decimal, Decimal],
        "The spacing between tiles. (x_spacing, y_spacing)",
        units="µm",
        default=(0, 0),
    ),
    Variable(
        "FABULOUS_HALO_SPACING",
        tuple[Decimal, Decimal, Decimal, Decimal],
        "The spacing around the fabric. [left, bottom, right, top]",
        units="µm",
        default=(100, 100, 100, 100),
    ),
    Variable(
        "FABULOUS_SPEF_CORNERS",
        list[str],
        "The SPEF corners to use for the tile macros.",
        default=["nom"],
    ),
]
