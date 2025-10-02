from importlib import resources

from librelane.config.variable import Variable
from librelane.steps.odb import OdbpyStep
from librelane.steps.step import (
    Step,
)


@Step.factory.register()
class ExtractPDKInfo(OdbpyStep):
    """Extracts PDK information from a LEF file and writes it to the metrics or config."""

    id = "ODB.ExtractPDKInfo"
    name = "Extract PDK Info"

    config_vars = [
        Variable(
            "EXTRACT_PDK_INFO_TO_METRICS",
            bool,
            "Path to the LEF file for the target PDK.",
            default=resources.files("FABulous.pdk").joinpath("sky130A.lef"),
        ),
    ]

    def get_script_path(self) -> str:
        return str(
            resources.files("FABulous.fabric_generator.gds_generator.steps")
            / "extract_pdk_info.py"
        )
