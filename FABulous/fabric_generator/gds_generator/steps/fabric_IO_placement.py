from decimal import Decimal
from importlib import resources
from typing import Optional

from librelane.config.variable import Variable
from librelane.state.state import State
from librelane.steps.common_variables import (
    io_layer_variables,
)
from librelane.steps.odb import OdbpyStep
from librelane.steps.step import (
    MetricsUpdate,
    Step,
    ViewsUpdate,
)


def _migrate_unmatched_io(x: object) -> str:
    return "unmatched_design" if x else "none"


@Step.factory.register()
class FABulousFabricIOPlacement(OdbpyStep):
    id = "Odb.FABulousFabricIOPlacement"
    name = "FABulous I/O Placement"
    long_name = "FABulous I/O Pin Placement Script"

    config_vars = io_layer_variables + [
        Variable(
            "IO_PIN_V_LENGTH",
            Optional[Decimal],
            """
            The length of the pins with a north or south orientation. If unspecified by
            a PDK, the script will use whichever is higher of the following two values:
                * The pin width
                * The minimum value satisfying the minimum area constraint given the
                  pin width
            """,
            units="µm",
            pdk=True,
        ),
        Variable(
            "IO_PIN_H_LENGTH",
            Optional[Decimal],
            """
            The length of the pins with an east or west orientation. If unspecified by
            a PDK, the script will use whichever is higher of the following two values:
                * The pin width
                * The minimum value satisfying the minimum area constraint given the
                  pin width
            """,
            units="µm",
            pdk=True,
        ),
    ]

    def get_script_path(self) -> str:
        return str(
            resources.files("FABulous.fabric_generator.gds_generator.script")
            / "fabric_io_place.py"
        )

    def get_command(self) -> list[str]:
        length_args = []
        if self.config["IO_PIN_V_LENGTH"] is not None:
            length_args += ["--ver-length", self.config["IO_PIN_V_LENGTH"]]
        if self.config["IO_PIN_H_LENGTH"] is not None:
            length_args += ["--hor-length", self.config["IO_PIN_H_LENGTH"]]

        return (
            super().get_command()
            + [
                "--hor-layer",
                self.config["FP_IO_HLAYER"],
                "--ver-layer",
                self.config["FP_IO_VLAYER"],
                "--hor-width-mult",
                str(self.config["IO_PIN_V_THICKNESS_MULT"]),
                "--ver-width-mult",
                str(self.config["IO_PIN_H_THICKNESS_MULT"]),
                "--hor-extension",
                str(self.config["IO_PIN_H_EXTENSION"]),
                "--ver-extension",
                str(self.config["IO_PIN_V_EXTENSION"]),
            ]
            + length_args
        )

    def run(self, state_in: State, **kwargs) -> tuple[ViewsUpdate, MetricsUpdate]:
        return super().run(state_in, **kwargs)
