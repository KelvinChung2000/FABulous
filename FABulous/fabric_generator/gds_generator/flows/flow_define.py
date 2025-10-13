from librelane.steps import checker as Checker
from librelane.steps import klayout as KLayout
from librelane.steps import magic as Magic
from librelane.steps import misc as Misc
from librelane.steps import netgen as Netgen
from librelane.steps import odb as Odb
from librelane.steps import openroad as OpenROAD
from librelane.steps import pyosys as pyYosys
from librelane.steps import verilator as Verilator
from librelane.steps import yosys as Yosys
from librelane.steps.step import Step

from FABulous.fabric_generator.gds_generator.steps.condition_magic_drc import (
    ConditionalMagicDRC,
)

prep_steps: list[type[Step]] = [
    Verilator.Lint,
    Checker.LintTimingConstructs,
    Checker.LintErrors,
    Checker.LintWarnings,
    pyYosys.JsonHeader,
    pyYosys.Synthesis,
    Checker.YosysUnmappedCells,
    Checker.YosysSynthChecks,
    Checker.NetlistAssignStatements,
    OpenROAD.CheckSDCFiles,
    OpenROAD.CheckMacroInstances,
]

physical_steps: list[type[Step]] = [
    OpenROAD.STAPrePNR,
    OpenROAD.Floorplan,
    OpenROAD.DumpRCValues,
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
]

write_out_steps: list[type[Step]] = [
    Magic.StreamOut,
    KLayout.StreamOut,
    Magic.WriteLEF,
]

check_steps: list[type[Step]] = [
    Odb.CheckDesignAntennaProperties,
    KLayout.XOR,
    Checker.XOR,
    KLayout.DRC,
    ConditionalMagicDRC,
    Checker.KLayoutDRC,
    Checker.MagicDRC,
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
