from pathlib import Path

from librelane.config.variable import Variable
from librelane.flows.flow import Flow
from librelane.logging.logger import info
from librelane.state.state import State
from librelane.steps.step import Step

from FABulous.fabric_generator.gds_generator.steps.tile_marco_gen import TileMarcoGen

configs = [
    Variable(
        "FABULOUS_PROJ_DIR",
        Path,
        description="Path to the FABulous project directory",
    )
]


@Flow.factory.register()
class FABulousFabricGDS(Flow):
    def run(self, initial_state: State, **kwargs) -> tuple[State, list[Step]]:
        step_list: list[Step] = []

        final_views_path = (
            Path(self.config["FABULOUS_TILE_DIR"]) / "macro" / self.config["PDK"]
        )

        info(f"Saving final views for FABulous to {final_views_path}")

        self.start_stage("Tile Macro Generation")
        tile_marco_gen = TileMarcoGen(
            self.config, id="TileMarcoGen", state_in=initial_state
        )
        self.start_step(tile_marco_gen)
        step_list.append(tile_marco_gen)
        self.end_stage()

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
