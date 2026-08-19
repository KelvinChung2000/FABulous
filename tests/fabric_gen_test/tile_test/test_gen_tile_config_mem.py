"""Tests for how `generateTile` treats a tile's configuration memory.

FABulous always generates `<tile>_ConfigMem`. When the tile CSV names a wrapper
the tile instantiates the module the user named instead, and that module is
what instantiates the generated one, so user logic can sit before or after the
configuration bits.
"""

from collections.abc import Callable
from pathlib import Path

import pytest

from fabulous.fabric_definition.config_mem_wrapper import (
    ConfigMemPort,
    ConfigMemWrapper,
)
from fabulous.fabric_definition.define import IO
from fabulous.fabric_generator.code_generator.code_generator import CodeGenerator
from fabulous.fabric_generator.gen_fabric.gen_tile import generateTile
from tests.conftest import make_empty_tile

TILE_NAME = "LUT4AB"
# Unrelated to TILE_NAME on purpose: the tile has to instantiate the name the
# user gave, not one it could have reconstructed.
WRAPPER_MODULE = "ecc_guard"


def _stub_entity(path: Path, name: str) -> None:
    """Write a minimal VHDL entity so `addComponentDeclarationForFile` can read it."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(f"entity {name} is\nend entity {name};\n")


@pytest.fixture
def vhdl_writer(
    code_generator_factory: Callable[[str, str], CodeGenerator],
) -> CodeGenerator:
    """A VHDL generator writing next to the tile's switch-matrix stub."""
    writer = code_generator_factory(".vhd", TILE_NAME)
    _stub_entity(
        Path(writer.outFileName).parent / f"{TILE_NAME}_switch_matrix.vhdl",
        f"{TILE_NAME}_switch_matrix",
    )
    return writer


@pytest.fixture
def verilog_writer(
    code_generator_factory: Callable[[str, str], CodeGenerator],
) -> CodeGenerator:
    """A Verilog generator for the tile under test."""
    return code_generator_factory(".v", TILE_NAME)


def _wrapper(tmp_path: Path, *ports: ConfigMemPort) -> ConfigMemWrapper:
    """A wrapper whose HDL file exists, with the given extra ports."""
    hdl = tmp_path / f"{WRAPPER_MODULE}.v"
    hdl.write_text("")
    return ConfigMemWrapper(hdl_file=hdl, module=WRAPPER_MODULE, ports=ports)


class TestInstantiation:
    """The tile instantiates the wrapper when it has one, the module otherwise."""

    def test_an_unwrapped_tile_instantiates_the_generated_module(
        self, verilog_writer: CodeGenerator
    ) -> None:
        tile = make_empty_tile(TILE_NAME, config_bits=4)

        generateTile(verilog_writer, tile)

        rtl = verilog_writer.outFileName.read_text()
        assert f"\n{TILE_NAME}_ConfigMem\n" in rtl
        assert f"Inst_{TILE_NAME}_ConfigMem" in rtl

    def test_a_wrapped_tile_instantiates_the_wrapper(
        self, verilog_writer: CodeGenerator, tmp_path: Path
    ) -> None:
        tile = make_empty_tile(TILE_NAME, config_bits=4)
        tile.config_mem_wrapper = _wrapper(tmp_path)

        generateTile(verilog_writer, tile)

        rtl = verilog_writer.outFileName.read_text()
        assert f"\n{WRAPPER_MODULE}\n" in rtl
        assert f"Inst_{TILE_NAME}_ConfigMem" in rtl


class TestWrapperPortsLeaveTheTile:
    """A declared wrapper port becomes a tile port and is wired to the instance."""

    def test_an_external_port_is_declared_on_the_tile(
        self, verilog_writer: CodeGenerator, tmp_path: Path
    ) -> None:
        tile = make_empty_tile(TILE_NAME, config_bits=4)
        tile.config_mem_wrapper = _wrapper(
            tmp_path, ConfigMemPort(name="crc_error", io=IO.OUTPUT, width=1)
        )

        generateTile(verilog_writer, tile)

        assert "crc_error" in verilog_writer.outFileName.read_text()

    def test_a_multi_bit_port_keeps_its_width(
        self, verilog_writer: CodeGenerator, tmp_path: Path
    ) -> None:
        tile = make_empty_tile(TILE_NAME, config_bits=4)
        tile.config_mem_wrapper = _wrapper(
            tmp_path, ConfigMemPort(name="syndrome", io=IO.OUTPUT, width=8)
        )

        generateTile(verilog_writer, tile)

        rtl = verilog_writer.outFileName.read_text()
        assert "syndrome" in rtl
        assert "[8-1:0]" in rtl


class TestVhdlComponentDeclarations:
    """VHDL needs a component declaration for everything the tile instantiates."""

    def test_vhdl_declares_the_generated_config_mem(
        self, vhdl_writer: CodeGenerator, tmp_path: Path
    ) -> None:
        """Without a wrapper the declaration comes from the generated file."""
        _stub_entity(tmp_path / f"{TILE_NAME}_ConfigMem.vhdl", f"{TILE_NAME}_ConfigMem")
        tile = make_empty_tile(TILE_NAME, config_bits=4)

        generateTile(vhdl_writer, tile)

        assert (
            f"component {TILE_NAME}_ConfigMem is" in vhdl_writer.outFileName.read_text()
        )

    def test_vhdl_declares_both_the_wrapper_and_the_generated_module(
        self, vhdl_writer: CodeGenerator, tmp_path: Path
    ) -> None:
        """The wrapper is instantiated by the tile, the module by the wrapper."""
        _stub_entity(tmp_path / f"{TILE_NAME}_ConfigMem.vhdl", f"{TILE_NAME}_ConfigMem")
        wrapper_hdl = tmp_path / "hand" / "my_wrapper.vhdl"
        _stub_entity(wrapper_hdl, WRAPPER_MODULE)
        tile = make_empty_tile(TILE_NAME, config_bits=4)
        tile.config_mem_wrapper = ConfigMemWrapper(
            hdl_file=wrapper_hdl, module=WRAPPER_MODULE
        )

        generateTile(vhdl_writer, tile)

        rtl = vhdl_writer.outFileName.read_text()
        assert f"component {WRAPPER_MODULE} is" in rtl
        assert f"component {TILE_NAME}_ConfigMem is" in rtl

    def test_vhdl_reports_a_missing_config_mem_file(
        self, vhdl_writer: CodeGenerator
    ) -> None:
        """The error names the file that was looked for."""
        tile = make_empty_tile(TILE_NAME, config_bits=4)

        with pytest.raises(FileNotFoundError, match=f"{TILE_NAME}_ConfigMem.vhdl"):
            generateTile(vhdl_writer, tile)
