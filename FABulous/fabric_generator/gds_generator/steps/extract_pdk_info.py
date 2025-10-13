"""Extract PDK placement site dimensions step.

This step extracts standard cell placement site dimensions from the PDK technology LEF
using OpenROAD's ODB API. The dimensions are written to metrics for use by flows that
need to work with site-aligned dimensions.
"""

from importlib import resources

from librelane.steps.odb import OdbpyStep
from librelane.steps.step import Step


@Step.factory.register()
class ExtractPDKInfo(OdbpyStep):
    """Extract placement site dimensions from PDK technology LEF.

    This step runs an ODB Python script that extracts the primary CORE
    placement site dimensions (width and height in database units) from
    the loaded technology LEF file.

    Outputs
    -------
    Metrics:
        pdk__site_width_dbu : int
            Placement site width in database units
        pdk__site_height_dbu : int
            Placement site height in database units
        pdk__site_name : str
            Name of the placement site
    """

    id = "FABulous.ExtractPDKSite"
    name = "Extract PDK Site Dimensions"

    def get_script_path(self) -> str:
        """Return path to the ODB Python script."""
        return str(
            resources.files("FABulous.fabric_generator.gds_generator.script")
            / "extract_pdk_info.py"
        )
