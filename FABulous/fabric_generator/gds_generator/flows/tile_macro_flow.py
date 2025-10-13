from collections.abc import Iterable
from pathlib import Path
from typing import Any

from librelane.config.variable import Variable
from librelane.flows.classic import Classic
from librelane.flows.flow import Flow
from librelane.flows.sequential import SequentialFlow
from librelane.logging.logger import warn
from librelane.state.state import State
from librelane.steps import odb as Odb
from librelane.steps import openroad as OpenROAD
from librelane.steps.step import Step

from FABulous.fabric_generator.gds_generator.flows.flow_define import (
    check_steps,
    physical_steps,
    prep_steps,
    write_out_steps,
)
from FABulous.fabric_generator.gds_generator.helper import (
    get_routing_obstructions,
    round_die_area,
)
from FABulous.fabric_generator.gds_generator.steps.add_buffer import AddBuffers
from FABulous.fabric_generator.gds_generator.steps.custom_pdn import CustomGeneratePDN
from FABulous.fabric_generator.gds_generator.steps.tile_IO_placement import (
    FABulousTileIOPlacement,
)
from FABulous.fabric_generator.gds_generator.steps.tile_optimisation import (
    TileOptimisation,
)

subs = {
    # "OpenROAD.IOPlacement": FABulousTileIOPlacement,
    # Replace with FABulous IO Placement
    # "-OpenRoad.Floorplan": RoundDieArea,
    "OpenROAD.IOPlacement": None,
    "Odb.CustomIOPlacement": FABulousTileIOPlacement,
    "OpenROAD.GeneratePDN": CustomGeneratePDN,
    "OpenROAD.Resize*": None,
    "OpenROAD.RepairDesign*": None,
    "+OpenROAD.GlobalPlacement": AddBuffers,
    # Disable STA
    "OpenROAD.STAPrePNR*": None,
    "OpenROAD.STAMidPNR*": None,
    "OpenROAD.STAPostPNR*": None,
}

configs = Classic.config_vars + [
    Variable(
        "FABULOUS_TILE_DIR",
        Path,
        "Path to the tile directory where the CSV file is located.",
    ),
    Variable(
        "FABULOUS_TILE_LOGICAL_WIDTH", int, "The logical width of the tile.", default=1
    ),
    Variable(
        "FABULOUS_TILE_LOGICAL_HEIGHT",
        int,
        "The logical height of the tile.",
        default=1,
    ),
]


@Flow.factory.register()
class FABulousTileVerilogMarcoFlow(SequentialFlow):
    Steps = (
        prep_steps
        + [
            TileOptimisation,
            OpenROAD.FillInsertion,
            Odb.CellFrequencyTables,
            OpenROAD.RCX,
            OpenROAD.IRDropReport,
        ]
        + write_out_steps
        + check_steps
    )

    config_vars = configs

    gating_config_vars = {
        "OpenROAD.RepairDesignPostGPL": ["RUN_POST_GPL_DESIGN_REPAIR"],
        "OpenROAD.RepairDesignPostGRT": ["RUN_POST_GRT_DESIGN_REPAIR"],
        "OpenROAD.ResizerTimingPostCTS": ["RUN_POST_CTS_RESIZER_TIMING"],
        "OpenROAD.ResizerTimingPostGRT": ["RUN_POST_GRT_RESIZER_TIMING"],
        "OpenROAD.CTS": ["RUN_CTS"],
        "OpenROAD.RCX": ["RUN_SPEF_EXTRACTION"],
        "OpenROAD.TapEndcapInsertion": ["RUN_TAP_ENDCAP_INSERTION"],
        "Odb.HeuristicDiodeInsertion": ["RUN_HEURISTIC_DIODE_INSERTION"],
        "OpenROAD.RepairAntennas": ["RUN_ANTENNA_REPAIR"],
        "OpenROAD.DetailedRouting": ["RUN_DRT"],
        "OpenROAD.FillInsertion": ["RUN_FILL_INSERTION"],
        "OpenROAD.STAPostPNR": ["RUN_MCSTA"],
        "OpenROAD.IRDropReport": ["RUN_IRDROP_REPORT"],
        "Magic.StreamOut": ["RUN_MAGIC_STREAMOUT"],
        "KLayout.StreamOut": ["RUN_KLAYOUT_STREAMOUT"],
        "Magic.WriteLEF": ["RUN_MAGIC_WRITE_LEF"],
        "Magic.DRC": ["RUN_MAGIC_DRC"],
        "KLayout.DRC": ["RUN_KLAYOUT_DRC"],
        "KLayout.XOR": [
            "RUN_KLAYOUT_XOR",
            "RUN_MAGIC_STREAMOUT",
            "RUN_KLAYOUT_STREAMOUT",
        ],
        "Netgen.LVS": ["RUN_LVS"],
        "Checker.TrDRC": ["RUN_DRT"],
        "Checker.MagicDRC": ["RUN_MAGIC_DRC"],
        "Checker.XOR": [
            "RUN_KLAYOUT_XOR",
            "RUN_MAGIC_STREAMOUT",
            "RUN_KLAYOUT_STREAMOUT",
        ],
        "Checker.LVS": ["RUN_LVS"],
        "Checker.KLayoutDRC": ["RUN_KLAYOUT_DRC"],
        # Not in VHDLClassic
        "Yosys.EQY": ["RUN_EQY"],
        "Verilator.Lint": ["RUN_LINTER"],
        "Checker.LintErrors": ["RUN_LINTER"],
        "Checker.LintWarnings": ["RUN_LINTER"],
        "Checker.LintTimingConstructs": [
            "RUN_LINTER",
        ],
    }

    def run(
        self,
        initial_state: State,
        frm: str | None = None,
        to: str | None = None,
        skip: Iterable[str] | None = None,
        reproducible: str | None = None,
        **kwargs,
    ) -> tuple[State | list[Step]]:
        self.config = round_die_area(self.config)
        if (
            "ROUTING_OBSTRUCTIONS" not in self.config
            or self.config["ROUTING_OBSTRUCTIONS"] is None
        ):
            self.config = self.config.copy(
                ROUTING_OBSTRUCTIONS=get_routing_obstructions(self.config)
            )
        return super().run(initial_state, frm, to, skip, reproducible, **kwargs)


@Flow.factory.register()
class FABulousTileVerilogMarcoFlowClassic(SequentialFlow):
    Steps = prep_steps + physical_steps + write_out_steps + check_steps
    Substitutions = subs
    config_vars = configs

    def run(self, initial_state: State, **kwargs: Any) -> tuple[State, list[Step]]:  # noqa: ANN401
        self.config = round_die_area(self.config)
        if (
            "ROUTING_OBSTRUCTIONS" not in self.config
            or self.config["ROUTING_OBSTRUCTIONS"] is None
        ):
            self.config = self.config.copy(
                ROUTING_OBSTRUCTIONS=get_routing_obstructions(self.config)
            )
        return super().run(initial_state, **kwargs)


@Flow.factory.register()
class FABulousTileVHDLMarcoFlowClassic(SequentialFlow):
    Steps = prep_steps + physical_steps + write_out_steps + check_steps
    Substitutions = subs
    config_vars = configs

    def run(self, initial_state: State, **kwargs: Any) -> tuple[State, list[Step]]:  # noqa: ANN401
        warn("Linting and equivalence checking for VHDL files is disabled")
        round_die_area(self.config)
        if (
            "ROUTING_OBSTRUCTIONS" not in self.config
            or self.config["ROUTING_OBSTRUCTIONS"] is None
        ):
            self.config = self.config.copy(
                ROUTING_OBSTRUCTIONS=get_routing_obstructions(self.config)
            )
        return super().run(initial_state, **kwargs)
