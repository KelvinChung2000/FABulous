from decimal import Decimal
from importlib import resources

from librelane.config.variable import Variable
from librelane.steps.openroad import OpenROADStep
from librelane.steps.step import Step


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
