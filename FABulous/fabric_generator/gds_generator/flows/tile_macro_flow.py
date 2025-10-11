from collections.abc import Iterable
from pathlib import Path
from typing import Any

from librelane.config.variable import Variable
from librelane.flows.classic import Classic, VHDLClassic
from librelane.flows.flow import Flow
from librelane.flows.sequential import SequentialFlow
from librelane.logging.logger import warn
from librelane.state.state import State
from librelane.steps import checker as Checker
from librelane.steps import klayout as KLayout
from librelane.steps import magic as Magic
from librelane.steps import misc as Misc
from librelane.steps import netgen as Netgen
from librelane.steps import odb as Odb
from librelane.steps import openroad as OpenROAD
from librelane.steps import pyosys as Yosys
from librelane.steps import verilator as Verilator
from librelane.steps.step import Step

from FABulous.fabric_generator.gds_generator.helper import (
    get_routing_obstructions,
    round_die_area,
)
from FABulous.fabric_generator.gds_generator.steps.add_buffer import AddBuffers
from FABulous.fabric_generator.gds_generator.steps.condition_magic_drc import (
    ConditionalMagicDRC,
)
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
    "Magic.DRC": ConditionalMagicDRC,
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
    Steps = [
        Verilator.Lint,
        Checker.LintTimingConstructs,
        Checker.LintErrors,
        Checker.LintWarnings,
        Yosys.JsonHeader,
        Yosys.Synthesis,
        Checker.YosysUnmappedCells,
        Checker.YosysSynthChecks,
        Checker.NetlistAssignStatements,
        OpenROAD.CheckSDCFiles,
        OpenROAD.CheckMacroInstances,
        TileOptimisation,
        OpenROAD.FillInsertion,
        Odb.CellFrequencyTables,
        OpenROAD.RCX,
        OpenROAD.IRDropReport,
        Magic.StreamOut,
        KLayout.StreamOut,
        Magic.WriteLEF,
        Magic.SpiceExtraction,
        Odb.CheckDesignAntennaProperties,
        KLayout.XOR,
        KLayout.DRC,
        ConditionalMagicDRC,
        Checker.KLayoutDRC,
        Checker.IllegalOverlap,
        Netgen.LVS,
        Checker.LVS,
        Checker.SetupViolations,
        Checker.HoldViolations,
        Checker.MaxSlewViolations,
        Checker.MaxCapViolations,
        Misc.ReportManufacturability,
    ]

    config_vars = [
        Variable(
            "RUN_TAP_ENDCAP_INSERTION",
            bool,
            "Enables the OpenROAD.TapEndcapInsertion step.",
            default=True,
            deprecated_names=["TAP_DECAP_INSERTION", "RUN_TAP_DECAP_INSERTION"],
        ),
        Variable(
            "RUN_POST_GPL_DESIGN_REPAIR",
            bool,
            "Enables resizer design repair after global placement using the OpenROAD."
            "RepairDesignPostGPL step.",
            default=True,
            deprecated_names=["PL_RESIZER_DESIGN_OPTIMIZATIONS", "RUN_REPAIR_DESIGN"],
        ),
        Variable(
            "RUN_POST_GRT_DESIGN_REPAIR",
            bool,
            "Enables resizer design repair after global placement using the OpenROAD."
            "RepairDesignPostGPL step. This is experimental and may result in hangs "
            "and/or extended run times.",
            default=False,
        ),
        Variable(
            "RUN_CTS",
            bool,
            "Enables clock tree synthesis using the OpenROAD.CTS step.",
            default=True,
            deprecated_names=["CLOCK_TREE_SYNTH"],
        ),
        Variable(
            "RUN_POST_CTS_RESIZER_TIMING",
            bool,
            "Enables resizer timing optimizations after clock tree synthesis using the "
            "OpenROAD.ResizerTimingPostCTS step.",
            default=True,
            deprecated_names=["PL_RESIZER_TIMING_OPTIMIZATIONS"],
        ),
        Variable(
            "RUN_POST_GRT_RESIZER_TIMING",
            bool,
            "Enables resizer timing optimizations after global routing using the "
            "OpenROAD.ResizerTimingPostGRT step. This is experimental and may result "
            "in hangs and/or extended run times.",
            default=False,
            deprecated_names=["GLB_RESIZER_TIMING_OPTIMIZATIONS"],
        ),
        Variable(
            "RUN_HEURISTIC_DIODE_INSERTION",
            bool,
            "Enables the Odb.HeuristicDiodeInsertion step.",
            default=False,  # For compatibility with OL1
        ),
        Variable(
            "RUN_ANTENNA_REPAIR",
            bool,
            "Enables the OpenROAD.RepairAntennas step.",
            default=True,
            deprecated_names=["GRT_REPAIR_ANTENNAS"],
        ),
        Variable(
            "RUN_DRT",
            bool,
            "Enables the OpenROAD.DetailedRouting step.",
            default=True,
        ),
        Variable(
            "RUN_FILL_INSERTION",
            bool,
            "Enables the OpenROAD.FillInsertion step.",
            default=True,
        ),
        Variable(
            "RUN_MCSTA",
            bool,
            "Enables multi-corner static timing analysis using the "
            "OpenROAD.STAPostPNR step.",
            default=True,
            deprecated_names=["RUN_SPEF_STA"],
        ),
        Variable(
            "RUN_SPEF_EXTRACTION",
            bool,
            "Enables parasitics extraction using the OpenROAD.RCX step.",
            default=True,
        ),
        Variable(
            "RUN_IRDROP_REPORT",
            bool,
            "Enables generation of an IR Drop report using the "
            "OpenROAD.IRDropReport step.",
            default=True,
        ),
        Variable(
            "RUN_LVS",
            bool,
            "Enables the Netgen.LVS step.",
            default=True,
        ),
        Variable(
            "RUN_MAGIC_STREAMOUT",
            bool,
            "Enables the Magic.StreamOut step to generate GDSII.",
            default=True,
            deprecated_names=["RUN_MAGIC"],
        ),
        Variable(
            "RUN_KLAYOUT_STREAMOUT",
            bool,
            "Enables the KLayout.StreamOut step to generate GDSII.",
            default=True,
            deprecated_names=["RUN_KLAYOUT"],
        ),
        Variable(
            "RUN_MAGIC_WRITE_LEF",
            bool,
            "Enables the Magic.WriteLEF step.",
            default=True,
            deprecated_names=["MAGIC_GENERATE_LEF"],
        ),
        Variable(
            "RUN_KLAYOUT_XOR",
            bool,
            "Enables running the KLayout.XOR step on the two GDSII files generated by "
            "Magic and Klayout. Stream-outs for both KLayout and Magic should have "
            "already run, and the PDK must support both signoff tools.",
            default=True,
        ),
        Variable(
            "RUN_MAGIC_DRC",
            bool,
            "Enables the Magic.DRC step.",
            default=True,
        ),
        Variable(
            "RUN_KLAYOUT_DRC",
            bool,
            "Enables the KLayout.DRC step.",
            default=True,
        ),
        Variable(
            "RUN_EQY",
            bool,
            "Enables the Yosys.EQY step. Not valid for VHDLClassic.",
            default=False,
        ),
        Variable(
            "RUN_LINTER",
            bool,
            "Enables the Verilator.Lint step and associated checker steps. "
            "Not valid for VHDLClassic.",
            default=True,
            deprecated_names=["RUN_VERILATOR"],
        ),
    ] + configs

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
class FABulousTileVerilogMarcoFlowClassic(Classic):
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
class FABulousTileVHDLMarcoFlowClassic(VHDLClassic):
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
