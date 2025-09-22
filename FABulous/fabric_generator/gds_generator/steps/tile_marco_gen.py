"""
FABulous GDS Generator - Tile to Macro Conversion Step

This module contains a LibreLane step that converts FABulous tiles into macros.
It prepares the tile configuration and either uses the Classic flow or runs
essential steps to generate GDS, LEF, LIB, and DEF files for macro integration.
"""

from pathlib import Path

from librelane.config.variable import Variable
from librelane.state.design_format import DesignFormat
from librelane.state.state import State
from librelane.steps.step import MetricsUpdate, Step, ViewsUpdate

from FABulous.fabric_generator.gds_generator.flows.tile_marco_flow import (
    FABulousTileVerilogMarcoFlow,
)


@Step.factory.register()
class TileMarcoGen(Step):
    """LibreLane step for converting FABulous tiles into macros.

    This step prepares tile-specific configuration and state, then delegates the actual
    processing to a classic flow or simplified processing chain. The goal is to generate
    macro files (GDS, LEF) suitable for hierarchical integration.
    """

    # Get the Classic flow class from the Flow factory at runtime.
    # Use assignment instead of subclassing with a call expression.

    id = "FABulous.TileMarcoGen"
    name = "FABulous Tile to Macro Conversion"

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
        # views_updates: ViewsUpdate = {}

        flow = FABulousTileVerilogMarcoFlow(state_in, **kwargs)
        final_state, steps = flow.run(state_in, **kwargs)

        return (final_state, {})
