"""Tests for how `generateTile` treats a tile's configuration memory."""

from collections.abc import Callable
from pathlib import Path

import pytest

from fabulous.fabric_definition.config_mem_spec import ConfigMemSpec
from fabulous.fabric_generator.code_generator.code_generator import CodeGenerator
from fabulous.fabric_generator.gen_fabric.gen_tile import generateTile
from tests.conftest import make_empty_tile

TILE_NAME = "LUT4AB"


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


def test_vhdl_declares_the_generated_config_mem(
    vhdl_writer: CodeGenerator, tmp_path: Path
) -> None:
    """Without hand-written HDL the declaration comes from the generated file."""
    _stub_entity(tmp_path / f"{TILE_NAME}_ConfigMem.vhdl", f"{TILE_NAME}_ConfigMem")
    tile = make_empty_tile(TILE_NAME, config_bits=4)

    generateTile(vhdl_writer, tile)

    assert f"component {TILE_NAME}_ConfigMem" in vhdl_writer.outFileName.read_text()


def test_vhdl_declares_a_hand_written_config_mem(
    vhdl_writer: CodeGenerator, tmp_path: Path
) -> None:
    """Nothing is generated for a hand-written ConfigMem, so read the user's file.

    The declaration has to follow `hdl_file`, which is named by the tile CSV and
    need not match the `<tile>_ConfigMem.vhdl` name generation would have used.
    """
    hand_written = tmp_path / "hand" / "my_config_mem.vhdl"
    _stub_entity(hand_written, f"{TILE_NAME}_ConfigMem")
    tile = make_empty_tile(TILE_NAME, config_bits=4)
    tile.config_mem = ConfigMemSpec(
        mapping_csv=tmp_path / f"{TILE_NAME}_ConfigMem.csv", hdl_file=hand_written
    )

    generateTile(vhdl_writer, tile)

    assert f"component {TILE_NAME}_ConfigMem" in vhdl_writer.outFileName.read_text()


def test_vhdl_reports_a_missing_config_mem_file(vhdl_writer: CodeGenerator) -> None:
    """The error names the file that was looked for, generated or not."""
    tile = make_empty_tile(TILE_NAME, config_bits=4)

    with pytest.raises(FileNotFoundError, match=f"{TILE_NAME}_ConfigMem.vhdl"):
        generateTile(vhdl_writer, tile)
