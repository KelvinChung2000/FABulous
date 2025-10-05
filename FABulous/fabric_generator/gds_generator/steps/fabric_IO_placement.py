from decimal import Decimal
from importlib import resources
from typing import Optional

from librelane.common.types import Path
from librelane.config.variable import Variable
from librelane.logging.logger import info
from librelane.state.state import State
from librelane.steps.common_variables import io_layer_variables
from librelane.steps.odb import OdbpyStep
from librelane.steps.openroad import OpenROADStep
from librelane.steps.step import MetricsUpdate, Step, ViewsUpdate


@Step.factory.register()
class FABulousManualIOPlacement(OpenROADStep):
    """
    Manually place I/O pins on a floor-planned ODB file using OpenROAD's built-in placer.
    """

    id = "OpenROAD.ManualIOPlacement"
    name = "Manual I/O Placement"

    config_vars = OpenROADStep.config_vars + [
        Variable(
            "FABULOUS_MANUAL_PINS",
            dict[str, tuple[str, Decimal, Decimal, Decimal, Decimal]],
            "Dict of pin name to [layer, x, y, width, height]",
            default={},
        ),
    ]

    def get_script_path(self) -> str:
        return str(
            resources.files("FABulous.fabric_generator.gds_generator.script")
            / "fabric_IO_placer.tcl"
        )


def _migrate_unmatched_io(x: object) -> str:
    return "unmatched_design" if x else "none"


@Step.factory.register()
class FABulousFabricIOPlacement(OdbpyStep):
    """Places fabric-level I/O pins using the custom io_place.py script.

    This step places IOs for the entire fabric, aligning them with the underlying
    tile IOs at the perimeter. Uses a pin order configuration file that maps
    fabric coordinates (X#Y#) to pin placement specifications.
    """

    id = "Odb.FABulousFabricIOPlacement"
    name = "FABulous Fabric I/O Placement"
    long_name = "FABulous Fabric-level I/O Pin Placement"

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
        Variable(
            "FABULOUS_FABRIC_IO_PIN_ORDER_CFG",
            Optional[Path],
            "Path to the fabric-level pin order configuration file (with X#Y# tile coordinates).",
        ),
        Variable(
            "ERRORS_ON_UNMATCHED_IO",
            str,
            "Controls whether to emit an error in: no situation, when pins exist in "
            "the design that do not exist in the config file, when pins exist in the "
            "config file that do not exist in the design, and both respectively. "
            "`both` is recommended, as the default is only for backwards compatibility.",
            default="unmatched_design",
            deprecated_names=[
                ("QUIT_ON_UNMATCHED_IO", _migrate_unmatched_io),
            ],
        ),
    ]

    def get_script_path(self) -> str:
        return str(
            resources.files("FABulous.fabric_generator.gds_generator.script")
            / "io_place.py"
        )

    def get_command(self) -> list[str]:
        length_args = []
        if self.config["IO_PIN_V_LENGTH"] is not None:
            length_args += ["--ver-length", str(self.config["IO_PIN_V_LENGTH"])]
        if self.config["IO_PIN_H_LENGTH"] is not None:
            length_args += ["--hor-length", str(self.config["IO_PIN_H_LENGTH"])]

        return (
            super().get_command()
            + [
                "--config",
                str(self.config["FABULOUS_FABRIC_IO_PIN_ORDER_CFG"]),
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
                "--unmatched-error",
                self.config["ERRORS_ON_UNMATCHED_IO"],
            ]
            + length_args
        )

    def run(self, state_in: State, **kwargs) -> tuple[ViewsUpdate, MetricsUpdate]:
        if self.config["FABULOUS_FABRIC_IO_PIN_ORDER_CFG"] is None:
            info("No fabric IO pin order config file configured, skipping…")
            return {}, {}
        return super().run(state_in, **kwargs)
