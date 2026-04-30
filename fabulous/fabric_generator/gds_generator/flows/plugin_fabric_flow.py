"""Config-driven LibreLane plugin adapter for the FABulous fabric flow."""

import os
import tempfile
from pathlib import Path

import yaml
from librelane.config.variable import Variable
from librelane.flows.flow import Flow, FlowException

from fabulous.fabric_generator.code_generator.code_generator_Verilog import (
    VerilogCodeGenerator,
)
from fabulous.fabric_generator.gds_generator.flows.fabric_macro_flow import (
    FABulousFabricMacroFlow,
    _build_macros,
    _collect_fabric_verilog,
)
from fabulous.fabric_generator.gen_fabric.gen_fabric import generateFabric
from fabulous.fabric_generator.parser.parse_csv import parseFabricCSV


def _coerce_legacy_spacing(config: object) -> object:
    """Pre-process config files to coerce scalar spacing values to lists.

    Older fabric configs (e.g. tt-fabulous-ihp-26a) write
    ``FABULOUS_TILE_SPACING: 0`` as a scalar. Our flow's variable type is
    ``tuple[Decimal, Decimal]``, which librelane rejects scalars for. Rewrite
    the offending YAML files to a temp copy with the scalars expanded.
    """
    if not isinstance(config, list | tuple):
        return config
    paths: list[str] = []
    rewrites_dir: str | None = None
    for entry in config:
        if not isinstance(entry, str | Path) or not str(entry).endswith(
            (".yaml", ".yml")
        ):
            paths.append(entry)
            continue
        text = Path(entry).read_text()
        try:
            doc = yaml.safe_load(text)
        except Exception:
            paths.append(entry)
            continue
        if not isinstance(doc, dict):
            paths.append(entry)
            continue
        changed = False
        ts = doc.get("FABULOUS_TILE_SPACING")
        if ts is not None and not isinstance(ts, list | tuple):
            doc["FABULOUS_TILE_SPACING"] = [ts, ts]
            changed = True
        hs = doc.get("FABULOUS_HALO_SPACING")
        if hs is not None and not isinstance(hs, list | tuple):
            doc["FABULOUS_HALO_SPACING"] = [hs, hs, hs, hs]
            changed = True
        if not changed:
            paths.append(entry)
            continue
        if rewrites_dir is None:
            rewrites_dir = tempfile.mkdtemp(prefix="fabulous_cfg_")
        new_path = os.path.join(rewrites_dir, os.path.basename(str(entry)))
        Path(new_path).write_text(yaml.safe_dump(doc, sort_keys=False))
        paths.append(new_path)
    return paths


@Flow.factory.register()
class FABulousFabric(FABulousFabricMacroFlow):
    """Drop-in replacement for ``librelane_plugin_fabulous.FABulousFabric``."""

    config_vars = FABulousFabricMacroFlow.config_vars + [
        Variable(
            "FABULOUS_FABRIC_CONFIG",
            list[Path],
            "Path to the fabric CSV describing the tile map, parameters, and "
            "per-tile CSV locations.",
        ),
        Variable(
            "FABULOUS_TILE_LIBRARY",
            list[Path],
            "List of paths to the tile library roots.",
        ),
        Variable(
            "FABULOUS_TILE_MACROS",
            dict[str, Path],
            "Mapping of tile name to a previously-hardened macro output "
            "directory (containing ``metrics.json``, ``gds/``, ``lef/``, "
            "``vh/``, ``nl/``, ``pnl/``, ``spef/``). Each entry is turned into "
            "a LibreLane ``Macro`` and referenced by the stitching flow.",
        ),
    ]

    def __init__(
        self,
        config: object = None,
        *,
        name: str | None = None,
        design_dir: str | None = None,
        pdk: str | None = None,
        pdk_root: str | None = None,
        **kwargs: object,
    ) -> None:
        # Skip FABulousFabricMacroFlow.__init__: plugin invocations receive a
        # plain LibreLane config and prepare fabric/macros here.
        config = _coerce_legacy_spacing(config)
        super(FABulousFabricMacroFlow, self).__init__(
            config,
            name=name,
            design_dir=design_dir,
            pdk=pdk,
            pdk_root=pdk_root,
            **kwargs,
        )

        fabric_csv_entries = self.config["FABULOUS_FABRIC_CONFIG"]
        if not fabric_csv_entries:
            raise FlowException("FABULOUS_FABRIC_CONFIG is empty")
        fabric_csv = Path(fabric_csv_entries[0])
        if not fabric_csv.is_file():
            raise FlowException(f"FABULOUS_FABRIC_CONFIG={fabric_csv} does not exist")
        self.fabric = parseFabricCSV(fabric_csv)
        design_name = self.config.get("DESIGN_NAME")
        if design_name is not None:
            self.fabric.name = design_name

        writer = VerilogCodeGenerator()
        writer.outFileName = fabric_csv.parent / "fabric.v"
        generateFabric(writer, self.fabric)

        tile_macro_dirs: dict[str, Path] = {
            name: Path(path)
            for name, path in dict(self.config["FABULOUS_TILE_MACROS"]).items()
        }
        if not tile_macro_dirs:
            raise FlowException(
                "FABULOUS_TILE_MACROS is empty. Provide a mapping of each "
                "fabric tile name to its pre-hardened macro directory."
            )

        self.macros, self.tile_sizes = _build_macros(tile_macro_dirs)

        if self.config.get("DESIGN_NAME") is None:
            self.config = self.config.copy(DESIGN_NAME=self.fabric.name)

        if "VERILOG_FILES" not in self.config or not self.config["VERILOG_FILES"]:
            fabric_verilog = _collect_fabric_verilog(
                fabric_csv.parent, self.fabric.name
            )
            self.config = self.config.copy(
                VERILOG_FILES=[str(p) for p in fabric_verilog]
            )
