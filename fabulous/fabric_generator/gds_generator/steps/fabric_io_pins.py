"""Step for placing fabric I/O pins based on macro tile pin locations."""

from importlib import resources

from librelane.steps import (
    OdbpyStep,
    Step,
)
from librelane.steps.common_variables import pdn_variables


@Step.factory.register()
class FabricIOPins(OdbpyStep):
    """Place fabric I/O pins based on macro tile pin locations."""

    id = "Odb.FabricIOPins"
    name = "Fabric I/O pin placement based on macro tiles"

    config_vars = pdn_variables

    def get_script_path(self) -> str:
        """Get the path to the I/O pin placement script."""
        return str(
            resources.files("fabulous.fabric_generator.gds_generator.script")
            / "fabric_io_place.py"
        )
