"""The built-in code-generator plugin registers Verilog and VHDL."""

from fabulous.fabric_definition.define import HDLType
from fabulous.fabric_generator.code_generator import plugin
from fabulous.plugins.manager import FABulousPluginManager


def test_builtin_codegen_registers_verilog_and_vhdl() -> None:
    manager = FABulousPluginManager()
    manager.pm.register(plugin, name="builtin_codegen")
    manager.build_registries()
    assert manager.make_writer(HDLType.VERILOG).fileExtension == ".v"
    assert manager.make_writer(HDLType.VHDL).fileExtension == ".vhdl"
