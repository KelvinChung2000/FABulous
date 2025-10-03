from concurrent.futures import Future
from pathlib import Path

from librelane.config.config import Config
from librelane.config.variable import Variable
from librelane.flows.flow import Flow
from librelane.state.state import State
from librelane.steps.step import Step

from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.gds_generator.steps.tile_macro_gen import TileMarcoGen

configs = [
    Variable(
        "FABULOUS_PROJ_DIR",
        Path,
        description="Path to the FABulous project directory",
    ),
    Variable(
        "FABULOUS_FABRIC",
        Fabric,
        description="Path to the FABulous project directory",
    ),
    Variable(
        "FABULOUS_FABRIC_OPTIMISATION",
        Fabric,
        description="Path to the FABulous project directory",
    ),
    Variable(
        "FABULOUS_OPTIMISATION_TAGET_TILE",
        str,
        description="Target tile for optimisation. If 'auto', the most frequently used "
        "tile in the fabric is selected.",
        default="auto",
    ),
]


@Flow.factory.register()
class FABulousFabricGDS(Flow):
    Steps = [
        TileMarcoGen,
    ]

    def run(self, initial_state: State, **kwargs) -> tuple[State, list[Step]]:
        step_list: list[Step] = []

        self.start_stage("Tile Macro Generation")
        tile_marco_gen = TileMarcoGen(
            self.config, id="TileMarcoGen", staate_in=initial_state
        )
        self.start_step(tile_marco_gen)
        step_list.append(tile_marco_gen)
        self.end_stage()

        synthesis_futures: list[tuple[Config, Future[State]]] = []

        # self.start_stage("Fabric Assembly")
        # fabric_assembly = FabricAssembly(
        #     self.config, id="FabricAssembly", state_in=tile_marco_gen.state_out
        # )
        # self.start_step(fabric_assembly)
        # step_list.append(fabric_assembly)
        # self.end_stage()

        # if fabric_assembly.state_out is None:
        #     raise RuntimeError("Fabric assembly failed, no output state generated.")

        # return (fabric_assembly.state_out, step_list)
