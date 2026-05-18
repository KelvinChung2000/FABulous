"""FABulous GDS Generator - ODB Power Connection Step."""

from importlib import resources

from librelane.config.flow import option_variables, pdk_variables
from librelane.steps.common_variables import pdn_variables
from librelane.steps.odb import OdbpyStep
from librelane.steps.step import Step


@Step.factory.register()
class FABulousPDN(OdbpyStep):
    """Connect power rails for the tiles using a custom script."""

    id = "Odb.FABulousPDN"
    name = "FABulous PDN connections for the tiles"

    # pdk_variables provides VDD_PIN/GND_PIN, used as the power/ground pin
    # fallback when VDD_NETS/GND_NETS are unset (e.g. VPWR/VGND on sky130A,
    # VDD/VSS on gf180mcuD and ihp-sg13g2).
    config_vars = pdn_variables + option_variables + pdk_variables

    def get_script_path(self) -> str:
        """Get the path to the power connection script."""
        return str(
            resources.files("fabulous.fabric_generator.gds_generator.script")
            / "odb_power.py"
        )

    def get_command(self) -> list[str]:
        """Get the command to run the power connection script."""
        # Fall back to the PDK power/ground pin names when VDD_NETS/GND_NETS are
        # unset. The tile macros expose exactly these pins, so hardcoding
        # VPWR/VGND silently leaves them disconnected on PDKs that use VDD/VSS.
        vdd_nets = self.config["VDD_NETS"] or [self.config["VDD_PIN"]]
        gnd_nets = self.config["GND_NETS"] or [self.config["GND_PIN"]]

        vdd_pins = []
        for power_net in vdd_nets:
            vdd_pins.append("--power-names")
            vdd_pins.append(power_net)

        gnd_pins = []
        for ground_net in gnd_nets:
            gnd_pins.append("--ground-names")
            gnd_pins.append(ground_net)

        return super().get_command() + vdd_pins + gnd_pins
