from collections.abc import Callable
from enum import StrEnum
from typing import cast

from librelane.config.variable import Variable
from librelane.state.design_format import DesignFormat
from librelane.state.state import State
from librelane.steps import checker as Checker
from librelane.steps import klayout as KLayout
from librelane.steps import magic as Magic
from librelane.steps import misc as Misc
from librelane.steps import netgen as Netgen
from librelane.steps import odb as Odb
from librelane.steps import openroad as OpenROAD
from librelane.steps.step import Step

from FABulous.fabric_generator.gds_generator.steps.add_buffer import AddBuffers
from FABulous.fabric_generator.gds_generator.steps.custom_pdn import CustomGeneratePDN
from FABulous.fabric_generator.gds_generator.steps.IO_placement import (
    FABulousIOPlacement,
)
from FABulous.fabric_generator.gds_generator.steps.round_die_area import (
    RoundDieArea,
)
from FABulous.fabric_generator.gds_generator.steps.while_step import WhileStep


class OptMode(StrEnum):
    FIX_HEIGHT = "fix_height"
    FIX_WIDTH = "fix_width"
    BALANCED = "balanced"
    AGGRESSIVE = "aggressive"
    CUSTOM = "custom"


var = [
    Variable(
        "FABULOUS_OPTIMISATION_STEP_COUNT",
        int,
        "The number of placement sites by which the tile size reduces in each iteration. "
        "The actual reduction in DBU is this count multiplied by the PDK site dimensions.",
        default=5,
    ),
    Variable(
        "FABULOUS_OPT_MODE",
        OptMode,
        "Optimisation mode to use. Options are: "
        " - 'fix_height': default, keeps height constant and reduces width. "
        " - 'fix_width': keeps width constant and reduces height. "
        " - 'balanced': alternate width and height reduction. "
        " - 'aggressive': reduces both height and width at the same time."
        " - 'custom': user defined function by supplying FABULOUS_CUSTOM_OPT_FUNC.",
        default=OptMode.FIX_HEIGHT,
    ),
    # Variable(
    #     "FABULOUS_CUSTOM_OPT_FUNC",
    #     Callable,
    #     "A custom python function that takes in the current width and height "
    #     "and returns the new width and height. "
    #     "Only used when FABULOUS_OPT_MODE is 'custom'.",
    #     default="",
    # ),
]


@Step.factory.register()
class TileOptimisation(WhileStep):
    id = "FABulous.TileOptimisation"
    name = "Tile Optimisation"

    inputs = [DesignFormat.NETLIST]

    Steps = [
        OpenROAD.CheckSDCFiles,
        OpenROAD.CheckMacroInstances,
        RoundDieArea,
        OpenROAD.Floorplan,
        OpenROAD.DumpRCValues,
        Odb.CheckMacroAntennaProperties,
        Odb.SetPowerConnections,
        Odb.ManualMacroPlacement,
        OpenROAD.CutRows,
        OpenROAD.TapEndcapInsertion,
        Odb.AddPDNObstructions,
        CustomGeneratePDN,  # Custom PDN default pdn_cfg.tcl
        Odb.RemovePDNObstructions,
        Odb.AddRoutingObstructions,
        OpenROAD.GlobalPlacementSkipIO,
        OpenROAD.IOPlacement,
        FABulousIOPlacement,  # Replace with FABulous IO Placement
        Odb.ApplyDEFTemplate,
        OpenROAD.GlobalPlacement,
        AddBuffers,  # Add Buffers after Global Placement
        Odb.WriteVerilogHeader,
        Checker.PowerGridViolations,
        Odb.ManualGlobalPlacement,
        OpenROAD.DetailedPlacement,
        OpenROAD.CTS,
        OpenROAD.GlobalRouting,
        OpenROAD.CheckAntennas,
        Odb.DiodesOnPorts,
        Odb.HeuristicDiodeInsertion,
        OpenROAD.RepairAntennas,
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
        OpenROAD.IRDropReport,
        Magic.StreamOut,
        KLayout.StreamOut,
        Magic.WriteLEF,
        Magic.SpiceExtraction,
        Odb.CheckDesignAntennaProperties,
        KLayout.XOR,
        KLayout.DRC,
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

    config_vars = var

    max_iterations = 5

    last_working_state: State | None = None

    def condition(self, state: State) -> bool:
        """Loop condition."""
        for i in [
            "antenna__violating__pins",
            "antenna__violating__nets",
            "route__antenna_violation__count",
            "route__drc_errors",
        ]:
            if v := state.metrics.get(i):
                if cast("int", v) > 0:
                    return False
            else:
                return True

        return True

    def post_iteration_callback(
        self, post_iteration: State, full_iter_completed: bool
    ) -> State:
        if full_iter_completed:
            self.last_working_state = post_iteration.copy()
        return post_iteration

    def pre_iteration_callback(self, pre_iteration: State) -> State:
        """Pre iteration callback."""
        die_area_raw: tuple[int, int, int, int] = self.config.get("DIE_AREA", None)
        _, _, width, height = die_area_raw
        die_area = (width, height)
        if die_area is None:
            raise ValueError("DIE_AREA metric not found in state.")

        # Get PDK site dimensions from metrics (if available)
        site_width_dbu = int(pre_iteration.metrics.get("pdk__site_width_dbu", 1))
        site_height_dbu = int(pre_iteration.metrics.get("pdk__site_height_dbu", 1))

        # Calculate step size based on PDK site dimensions
        step_count = self.config["FABULOUS_OPTIMISATION_STEP_COUNT"]
        width_step = site_width_dbu * step_count
        height_step = site_height_dbu * step_count

        match self.config["FABULOUS_OPT_MODE"]:
            case OptMode.FIX_HEIGHT:
                die_area = (
                    0,
                    0,
                    width - width_step,
                    height,
                )
            case OptMode.FIX_WIDTH:
                die_area = (
                    0,
                    0,
                    width,
                    height - height_step,
                )
            case OptMode.BALANCED:
                if (
                    width > height  # Reduce the larger dimension first
                ):
                    die_area = (
                        0,
                        0,
                        width - width_step,
                        height,
                    )
                else:
                    die_area = (
                        0,
                        0,
                        width,
                        height - height_step,
                    )
            case OptMode.AGGRESSIVE:
                die_area = (
                    0,
                    0,
                    width - width_step,
                    height - height_step,
                )
            case OptMode.CUSTOM:
                func = self.config["FABULOUS_CUSTOM_OPT_FUNC"]
                if func == "":
                    raise ValueError(
                        "FABULOUS_CUSTOM_OPT_FUNC is not set but "
                        "FABULOUS_OPT_MODE is 'custom'."
                    )
                if not isinstance(func, Callable):
                    raise TypeError("FABULOUS_CUSTOM_OPT_FUNC is not a callable.")
                new_width, new_height = func(die_area[0], die_area[1])
                if not isinstance(new_width, int) or not isinstance(new_height, int):
                    raise TypeError(
                        "FABULOUS_CUSTOM_OPT_FUNC must return two integers."
                    )
                die_area = (0, 0, new_width, new_height)
            case _:
                raise ValueError(
                    f"Unknown FABULOUS_OPT_MODE: {self.config['FABULOUS_OPT_MODE']}"
                )
        self.config = self.config.copy(DIE_AREA=die_area)

        return pre_iteration

    def post_loop_callback(self, state: State) -> State:  # noqa: ARG002
        """Post loop callback."""
        if self.last_working_state is not None:
            return self.last_working_state
        raise RuntimeError("No working state found after tile optimisation.")

    def mid_iteration_break(self, state: State, step: type[Step]) -> bool:
        """Mid iteration callback."""
        if isinstance(step, Checker.TrDRC):
            return (cast("int", state.metrics.get("antenna__violating__nets")) > 0) or (
                cast("int", state.metrics.get("antenna__violating__pins")) > 0
                or cast("int", state.metrics.get("route__drc_errors")) > 0
            )

        return False
