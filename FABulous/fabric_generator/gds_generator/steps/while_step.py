from pathlib import Path

from librelane.common.misc import slugify
from librelane.config.variable import Variable
from librelane.flows.flow import FlowProgressBar
from librelane.logging.logger import warn
from librelane.state.design_format import DesignFormat
from librelane.state.state import State
from librelane.steps.step import MetricsUpdate, Step, ViewsUpdate


class WhileStep(Step):
    """A step that runs a sub-step repeatedly while a condition is met."""

    Steps: list[type[Step]]

    max_iterations: int = 10

    break_on_failure: bool = True

    def __init_subclass__(Self):
        super().__init_subclass__()
        available_inputs = set()

        input_set: set[DesignFormat] = set()
        output_set: set[DesignFormat] = set()
        config_var_dict: dict[str, Variable] = {}
        for step in Self.Steps:
            for input in step.inputs:
                if input not in available_inputs:
                    input_set.add(input)
                    available_inputs.add(input)
            for output in step.outputs:
                available_inputs.add(output)
                output_set.add(output)
            for cvar in step.config_vars:
                if existing := config_var_dict.get(cvar.name):
                    if existing != cvar:
                        raise TypeError(
                            "Internal error: composite step has mismatching "
                            f"config_vars: {cvar.name} contradicts an "
                            "earlier declaration"
                        )
                else:
                    config_var_dict[cvar.name] = cvar
        Self.inputs = list(input_set)
        if Self.outputs == NotImplemented:  # Allow for setting explicit outputs
            Self.outputs = list(output_set)
        if Self.config_vars:
            config_var_dict.update({v.name: v for v in Self.config_vars})
        Self.config_vars = list(config_var_dict.values())

    def condition(self, state: State) -> bool:
        """A callable that takes in a state and returns a boolean."""
        return True

    def mid_iteration_break(self, state: State, step: type[Step]) -> bool:
        """Callback that takes in a state and returns a boolean.
        If True, breaks the current iteration and starts the next iteration.
        Breaking mid-iteration will not trigger the post_iteration_callback.
        """
        return False

    def post_loop_callback(self, state: State) -> State:
        return state

    def pre_iteration_callback(self, pre_iteration: State) -> State:
        return pre_iteration

    def post_iteration_callback(self, post_iteration: State) -> State:
        return post_iteration

    def run(
        self,
        state_in: State,
        **kwargs,
    ) -> tuple[ViewsUpdate, MetricsUpdate]:
        current_state = state_in
        total_views_update: ViewsUpdate = {}
        total_metrics_update: MetricsUpdate = {}
        progress_bar = FlowProgressBar(self.name)

        ordinal_length = len(str(len(self.Steps) - 1))
        start_state = state_in.copy()
        progress_bar.start()
        progress_bar.set_max_stage_count(self.max_iterations)
        for i in range(self.max_iterations):
            progress_bar.start_stage(f"Iteration {i + 1}/{self.max_iterations}")
            if not self.condition(current_state):
                break
            current_state = start_state.copy()
            current_state = self.pre_iteration_callback(current_state)

            # loop body
            for si, cStep in enumerate(self.Steps):
                step = cStep(self.config, current_state)
                try:
                    current_state = step.start(
                        toolbox=self.toolbox,
                        step_dir=str(
                            Path(self.step_dir)
                            / f"iter_{i}"
                            / f"{si:0{ordinal_length}d}-{slugify(step.id)}"
                        ),
                        _no_rule=True,
                    )
                    if self.mid_iteration_break(current_state, step):
                        break
                except Exception as e:
                    if self.break_on_failure:
                        raise e from None
                    warn(
                        f"Step {step.name} failed with exception {e}, "
                        "but continuing as break_on_failure is False."
                    )

            current_state = self.post_iteration_callback(current_state)
            progress_bar.end_stage()

        current_state = self.post_loop_callback(current_state)
        for key in current_state:
            if (
                state_in.get(key) != current_state.get(key)
                and DesignFormat.factory.get(key) in self.outputs
            ):
                total_metrics_update[key] = current_state[key]
        for key in current_state.metrics:
            if state_in.metrics.get(key) != current_state.metrics.get(key):
                total_metrics_update[key] = current_state.metrics[key]
        progress_bar.end()
        return total_views_update, total_metrics_update
