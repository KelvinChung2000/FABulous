from importlib import resources

from librelane.steps.common_variables import pdn_variables
from librelane.steps.odb import OdbpyStep
from librelane.steps.step import Step


@Step.factory.register()
class FABulousPower(OdbpyStep):
    id = "Odb.FABulousPower"
    name = "FABulous Power connections for the tiles"

    config_vars = pdn_variables

    def get_script_path(self) -> str:
        return str(
            resources.files("FABulous.fabric_generator.gds_generator.script")
            / "odb_power.py"
        )

    def get_command(self) -> list[str]:
        return super().get_command() + [
            "--metal-layer-name",
            self.config["PDN_VERTICAL_LAYER"],
        ]
