from librelane.config.variable import Variable
from librelane.state.state import State

from FABulous.fabric_generator.gds_generator.steps.while_step import WhileStep

var = [
    Variable(
        "FABULOUS_OPTIMISATION_STEP_SIZE",
        int,
        "The size of which the tile size reduces by in each iteration.",
        default=5,
    ),
    Variable(),
]


class TileOptimisation(WhileStep):
    id = "FABulous.TileOptimisation"
    name = "Tile Optimisation"

    steps = []

    max_iterations = 20

    last_working_state: State | None = None

    def condition(self, state: State) -> bool:
        if self.last_working_state is None:
            return True

    def pre_iteration_callback(self, pre_iteration: State) -> State:
        self.last_working_state = pre_iteration
        return pre_iteration

    def post_iteration_callback(self, post_iteration: State) -> tuple[State, bool]:
        needs_optimisation = post_iteration.get(
            "FABULOUS_TILE_NEEDS_OPTIMISATION", False
        )
        return post_iteration, not needs_optimisation
