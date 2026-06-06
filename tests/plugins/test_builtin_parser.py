"""The built-in parser plugin registers the CSV fabric parser."""

from pathlib import Path

from fabulous.fabric_generator.parser import plugin
from fabulous.fabric_generator.parser.parse_csv import parseFabricCSV
from fabulous.plugins.manager import FABulousPluginManager


def test_builtin_parser_registers_csv() -> None:
    manager = FABulousPluginManager()
    manager.pm.register(plugin, name="builtin_parser")
    manager.build_registries()
    assert manager.make_parser(Path("fabric.csv")) is parseFabricCSV
