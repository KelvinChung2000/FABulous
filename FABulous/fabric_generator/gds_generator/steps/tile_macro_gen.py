"""
FABulous GDS Generator - Tile to Macro Conversion Step

This module contains a LibreLane step that converts FABulous tiles into macros.
It prepares the tile configuration and either uses the Classic flow or runs
essential steps to generate GDS, LEF, LIB, and DEF files for macro integration.
"""

from librelane.config.variable import Variable
from librelane.state.design_format import DesignFormat
from librelane.state.state import State
from librelane.steps.step import MetricsUpdate, Step, ViewsUpdate

from FABulous.fabric_generator.gds_generator.flows.tile_macro_flow import (
    FABulousTileVerilogMarcoFlow,
    FABulousTileVerilogMarcoFlowClassic,
)


@Step.factory.register()
class TileMarcoGen(Step):
    """LibreLane step for converting FABulous tiles into macros.

    This step prepares tile-specific configuration and state, then delegates the actual
    processing to a classic flow or simplified processing chain. The goal is to generate
    macro files (GDS, LEF) suitable for hierarchical integration.
    """

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
            "TILE_CONFIG",
            dict,
            description="The full tile configuration dictionary.",
        ),
        Variable(
            "TILE_OPTIMISATION",
            bool,
            description="Enable tile optimisation",
            default=True,
        ),
    ]

    def run(self, state_in: State, **kwargs) -> tuple[ViewsUpdate, MetricsUpdate]:
        views_updates: ViewsUpdate = {}
        metrics_updates: MetricsUpdate = {}

        tile_config = self.config["TILE_CONFIG"]
        if self.config["TILE_OPTIMISATION"]:
            flow = FABulousTileVerilogMarcoFlowClassic(state_in, **kwargs)
        else:
            flow = FABulousTileVerilogMarcoFlow(state_in, **kwargs)

        final_state = flow.start(state_in)
        metrics_updates.update({tile_config["DESIGN_NAME"]: final_state.metrics})

        return (views_updates, metrics_updates)
