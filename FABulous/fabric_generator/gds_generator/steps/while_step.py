from librelane.state.state import State
from librelane.steps.step import (
    MetricsUpdate,
    Step,
    ViewsUpdate,
)


class WhileStep(Step):
    """A step that runs a sub-step repeatedly while a condition is met."""

    id = "Librelane.While"
    name = "While Step"

    steps: list[Step]

    max_iterations: int = 10

    def condition(self, state: State) -> bool:
        """A callable that takes in a state and returns a boolean."""
        return True

    def pre_iteration_callback(self, pre_iteration: State) -> State:
        return pre_iteration

    def post_iteration_callback(self, post_iteration: State) -> tuple[State, bool]:
        return post_iteration, False

    def run(
        self,
        state_in: State,
        **kwargs,
    ) -> tuple[ViewsUpdate, MetricsUpdate]:
        kwargs, env = self.extract_env(kwargs)

        state = state_in
        total_views_update: ViewsUpdate = {}
        total_metrics_update: MetricsUpdate = {}

        for _ in range(self.max_iterations):
            if not self.condition(state):
                break

            state = self.pre_iteration_callback(state)

            for step in self.steps:
                views_update, metrics_update = step.run(state, **kwargs)
                state = views_update.state_out

                total_views_update.update(views_update)
                total_metrics_update.update(metrics_update)

            state, break_loop = self.post_iteration_callback(state)
            if break_loop:
                break

        return total_views_update, total_metrics_update
