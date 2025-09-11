"""
FABulous GDS Generator - Custom LibreLane Flow

This module contains the custom LibreLane flow for FABulous GDS generation.
"""

from librelane.flows import Flow
from librelane.state import State
from librelane.steps import (
    Checker,
    KLayout,
    Magic,
    Misc,
    Netgen,
    Odb,
    OpenROAD,
    Verilator,
    Yosys,
)

from ..variables import ALL_FABULOUS_VARIABLES


@Flow.factory.register()
class FABulousGDSFlow(Flow):
    """Custom LibreLane flow for FABulous GDS generation.

    This flow orchestrates the complete FABulous GDS generation process, from fabric
    configuration parsing through individual tile processing to final fabric assembly.
    """

    flow_name = "FABulous GDS Generation"
    flow_description = (
        "Complete flow for generating GDS files from FABulous fabric descriptions"
    )

    config_vars = ALL_FABULOUS_VARIABLES

    # Define the flow steps and their dependencies
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
        OpenROAD.STAPrePNR,
        OpenROAD.Floorplan,
        Odb.CheckMacroAntennaProperties,
        Odb.SetPowerConnections,
        Odb.ManualMacroPlacement,
        OpenROAD.CutRows,
        OpenROAD.TapEndcapInsertion,
        Odb.AddPDNObstructions,
        OpenROAD.GeneratePDN,
        Odb.RemovePDNObstructions,
        Odb.AddRoutingObstructions,
        OpenROAD.GlobalPlacementSkipIO,
        OpenROAD.IOPlacement,
        Odb.CustomIOPlacement,
        Odb.ApplyDEFTemplate,
        OpenROAD.GlobalPlacement,
        Odb.WriteVerilogHeader,
        Checker.PowerGridViolations,
        OpenROAD.STAMidPNR,
        OpenROAD.RepairDesignPostGPL,
        Odb.ManualGlobalPlacement,
        OpenROAD.DetailedPlacement,
        OpenROAD.CTS,
        OpenROAD.STAMidPNR,
        OpenROAD.ResizerTimingPostCTS,
        OpenROAD.STAMidPNR,
        OpenROAD.GlobalRouting,
        OpenROAD.CheckAntennas,
        OpenROAD.RepairDesignPostGRT,
        Odb.DiodesOnPorts,
        Odb.HeuristicDiodeInsertion,
        OpenROAD.RepairAntennas,
        OpenROAD.ResizerTimingPostGRT,
        OpenROAD.STAMidPNR,
        OpenROAD.DetailedRouting,
        Odb.RemoveRoutingObstructions,
        OpenROAD.CheckAntennas,
        Checker.TrDRC,
        Odb.ReportDisconnectedPins,
        Checker.DisconnectedPins,
        Odb.ReportWireLength,
        Checker.WireLength,
        OpenROAD.FillInsertion,
        Odb.CellFrequencyTables,
        OpenROAD.RCX,
        OpenROAD.STAPostPNR,
        OpenROAD.IRDropReport,
        Magic.StreamOut,
        KLayout.StreamOut,
        Magic.WriteLEF,
        Odb.CheckDesignAntennaProperties,
        KLayout.XOR,
        Checker.XOR,
        Magic.DRC,
        KLayout.DRC,
        Checker.MagicDRC,
        Checker.KLayoutDRC,
        Magic.SpiceExtraction,
        Checker.IllegalOverlap,
        Netgen.LVS,
        Checker.LVS,
        Yosys.EQY,
        Checker.SetupViolations,
        Checker.HoldViolations,
        Checker.MaxSlewViolations,
        Checker.MaxCapViolations,
        Misc.ReportManufacturability,
    ]

    def run(
        self,
        initial_state: State,
        **kwargs,
    ) -> tuple[State, list[Step]]:
        pass
