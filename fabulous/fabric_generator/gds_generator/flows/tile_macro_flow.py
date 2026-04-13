"""Tile optimisation flows for FABulous fabric generation."""

from decimal import Decimal
from pathlib import Path

from librelane.config.variable import Variable
from librelane.flows.classic import Classic
from librelane.flows.flow import Flow, FlowException
from librelane.logging.logger import err
from librelane.steps import odb as Odb
from librelane.steps import openroad as OpenROAD
from librelane.steps import pyosys as pyYosys
from librelane.steps import verilator as Verilator

from fabulous.fabric_definition.supertile import SuperTile
from fabulous.fabric_definition.tile import Tile
from fabulous.fabric_generator.gds_generator.flows.fabulous_sequential_flow import (
    FABulousSequentialFlow,
)
from fabulous.fabric_generator.gds_generator.flows.flow_define import (
    check_steps,
    classic_gating_config_vars,
    prep_steps,
    write_out_steps,
)
from fabulous.fabric_generator.gds_generator.helper import (
    get_offset,
    get_pitch,
    get_routing_obstructions,
    merge_config_mappings,
    round_die_area,
)
from fabulous.fabric_generator.gds_generator.steps.tile_optimisation import (
    OptMode,
    TileOptimisation,
)
from fabulous.fabric_generator.gds_generator.substitution import Remove, Replace
from fabulous.fabulous_settings import get_context

configs = Classic.config_vars + [
    Variable(
        "FABULOUS_IGNORE_DEFAULT_DIE_AREA",
        bool,
        "When is true will ignore the provided die area and "
        "use the default one instead.",
        default=False,
    ),
]


@Flow.factory.register()
class FABulousTileMacroFlow(FABulousSequentialFlow):
    """Base tile optimisation flow for FABulous fabric generation."""

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

    gating_config_vars = classic_gating_config_vars
    source_config_key = "VERILOG_FILES"
    source_globs = ("**/*.v",)

    def __init__(
        self,
        tile_type: Tile | SuperTile,
        io_pin_config: Path,
        opt_mode: OptMode,
        pdk: str,
        pdk_root: Path,
        base_config_path: Path | None = None,
        override_config_path: Path | None = None,
        design_dir: Path | None = None,
        **custom_config_overrides: dict,
    ) -> None:
        # Determine logical dimensions
        if isinstance(tile_type, SuperTile):
            logical_width = tile_type.max_width
            logical_height = tile_type.max_height
        else:
            logical_width = 1
            logical_height = 1

        # casting opt_mode
        opt_mode = OptMode(opt_mode)

        # Build tile configuration
        tile_config_dict = {
            "DESIGN_NAME": tile_type.name,
            "FABULOUS_IO_PIN_ORDER_CFG": str(io_pin_config),
            self.source_config_key: self._collect_source_files(tile_type),
            "FABULOUS_OPT_MODE": opt_mode,
        }

        config_paths: list[Path] = []
        if base_config_path is not None and base_config_path.exists():
            config_paths.append(base_config_path)
        if override_config_path is not None and override_config_path.exists():
            config_paths.append(override_config_path)
        tile_config_dict = merge_config_mappings(
            tile_config_dict, *config_paths, **custom_config_overrides
        )
        if "FABULOUS_OPT_MODE" in tile_config_dict:
            tile_config_dict["FABULOUS_OPT_MODE"] = OptMode(
                tile_config_dict["FABULOUS_OPT_MODE"]
            )

        default_design_dir = tile_type.tileDir.parent / "macro" / opt_mode.value
        default_design_dir.mkdir(parents=True, exist_ok=True)
        final_dir: str
        if design_dir is None:
            final_dir = str(default_design_dir.resolve())
        else:
            final_dir = str(design_dir)
        super().__init__(
            tile_config_dict,
            name=tile_type.name,
            design_dir=final_dir,
            pdk=pdk,
            pdk_root=str(pdk_root.resolve()),
        )
        self.config = self.config.copy(
            FABULOUS_TILE_LOGICAL_WIDTH=logical_width,
            FABULOUS_TILE_LOGICAL_HEIGHT=logical_height,
        )
        x_pitch, y_pitch = get_pitch(self.config)
        x_spacing, y_spacing = get_offset(self.config)
        min_x, min_y = tile_type.get_min_die_area(
            x_pitch,
            y_pitch,
            self.config.get("IO_PIN_V_THINKNESS_MULT", Decimal(1)),
            self.config.get("IO_PIN_H_THINKNESS_MULT", Decimal(1)),
            x_pitch,
            y_pitch,
        )
        if opt_mode != OptMode.NO_OPT:
            if (
                self.config["FABULOUS_IGNORE_DEFAULT_DIE_AREA"]
                or self.config.get("DIE_AREA") is None
            ):
                self.config = self.config.copy(DIE_AREA=(0, 0, min_x, min_y))
            else:
                die_area = self.config.get("DIE_AREA")
                if die_area is None:
                    raise ValueError("DIE_AREA metric not found in state.")
                _, _, width, height = die_area
                width = Decimal(width)
                height = Decimal(height)
                if width < min_x or height < min_y:
                    raise FlowException(
                        f"DIE_AREA ({width}, {height}) is smaller than the "
                        f"minimum required area ({min_x}, {min_y}) for the "
                        f"tile {tile_type.name}. Please update the DIE_AREA "
                    )
        else:
            if not self.config.get("DIE_AREA"):
                err("If not using any optimisatin, DIE_AREA must be set.")
                raise FlowException("Invalid DIE_AREA configuration.")

        self.config = round_die_area(self.config)
        if (
            "ROUTING_OBSTRUCTIONS" not in self.config
            or self.config["ROUTING_OBSTRUCTIONS"] is None
        ) and self.config["ROUTING_OBSTRUCTIONS"] is not False:
            self.config = self.config.copy(
                ROUTING_OBSTRUCTIONS=get_routing_obstructions(self.config)
            )

    @classmethod
    def _collect_source_files(cls, tile_type: Tile | SuperTile) -> list[str]:
        """Collect tile RTL sources for this flow variant."""
        source_files: list[str] = []
        seen: set[Path] = set()
        for pattern in cls.source_globs:
            for source in tile_type.tileDir.parent.glob(pattern):
                if "macro" in source.parts or source in seen:
                    continue
                source_files.append(str(source))
                seen.add(source)
        if models_pack := get_context().models_pack:
            source_files.append(str(models_pack.resolve()))
        return source_files


FABulousTileFlow = FABulousTileMacroFlow
FABulousTileFlowVerilog = FABulousTileFlow
FABulousTileVerilogMacroFlow = FABulousTileFlowVerilog


@Flow.factory.register()
class FABulousTileFlowVHDL(FABulousTileMacroFlow):
    """Tile optimisation flow for FABulous fabric generation from VHDL."""

    Substitutions = [
        Remove(match=Verilator.Lint),
        Remove(match=r"Checker\.Lint.*"),
        Remove(match=pyYosys.JsonHeader),
        Replace(match=pyYosys.Synthesis, with_step=pyYosys.VHDLSynthesis),
        Remove(match=Odb.SetPowerConnections),
        Remove(match=Odb.WriteVerilogHeader),
    ]
    source_config_key = "VHDL_FILES"
    source_globs = ("**/*.vhd", "**/*.vhdl")


FABulousTileVHDLMacroFlowClassic = FABulousTileFlowVHDL
