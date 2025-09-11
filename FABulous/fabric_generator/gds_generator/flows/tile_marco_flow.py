from pathlib import Path
from typing import Optional

from librelane.config.variable import Variable
from librelane.flows.classic import Classic, VHDLClassic
from librelane.flows.flow import Flow
from librelane.logging.logger import info, warn
from librelane.state.state import State
from librelane.steps.step import Step

from FABulous.fabric_generator.gds_generator.steps.IO_placement import (
    FABulousIOPlacement,
)

subs = [
    # Replace with FABulous IO Placement
    ("Odb.CustomIOPlacement", FABulousIOPlacement),
    # Disable STA
    ("OpenROAD.STAPrePNR", None),
    ("OpenROAD.STAMidPNR", None),
    ("OpenROAD.STAMidPNR", None),
    ("OpenROAD.STAMidPNR", None),
    ("OpenROAD.STAMidPNR", None),
    ("OpenROAD.STAPostPNR", None),
]

configs = Classic.config_vars + [
    Variable(
        "FABULOUS_TILE_PIN_CONFIG",
        Path,
        """
            The side of the macro at which the external pins are placed.
            """,
    ),
    Variable(
        "FABULOUS_TILE_DIR",
        Path,
        """
            Path to the tile directory where the CSV file is located.
            """,
    ),
    Variable(
        "FABULOUS_SUPERTILE",
        Optional[bool],
        """
            Is the tile a supertile?
            """,
        default=False,
    ),
]


@Flow.factory.register()
class FABulousTileVerilog(Classic):
    Substitutions = subs
    config_vars = configs

    def run(self, initial_state: State, **kwargs) -> tuple[State, list[Step]]:
        verilog_files = Path(self.config["FABULOUS_TILE_DIR"]).rglob("*.v")

        info(verilog_files)

        # Overwrite VERILOG_FILES config variable with our Verilog files
        self.config = self.config.copy(VERILOG_FILES=verilog_files)

        (final_state, steps) = super().run(initial_state, **kwargs)

        final_views_path = (
            Path(self.config["FABULOUS_TILE_DIR"]) / "macro" / self.config["PDK"]
        )

        info(f"Saving final views for FABulous to {final_views_path}")

        final_state.save_snapshot(final_views_path)

        return (final_state, steps)


@Flow.factory.register()
class FABulousTile(VHDLClassic):
    Substitutions = subs
    config_vars = configs

    def run(self, initial_state: State, **kwargs) -> tuple[State, list[Step]]:
        warn("Linting and equivalence checking for VHDL files is disabled")

        vhdl_files = Path(self.config["FABULOUS_TILE_DIR"]).rglob("*.vhdl")

        info(vhdl_files)

        # Overwrite VHDL_FILES config variable with our VHDL files
        self.config = self.config.copy(VHDL_FILES=vhdl_files)

        (final_state, steps) = super().run(initial_state, **kwargs)

        final_views_path = (
            Path(self.config["FABULOUS_TILE_DIR"]) / "macro" / self.config["PDK"]
        )

        info(f"Saving final views for FABulous to {final_views_path}")

        final_state.save_snapshot(final_views_path)

        return (final_state, steps)
