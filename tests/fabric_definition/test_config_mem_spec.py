"""Tests for `ConfigMemSpec`, its path resolver, and the consumers of `None`.

The resolver is the single authority for `<tile>_ConfigMem.csv`, so these tests
pin down each layout it has to serve — in particular the legacy
`fabric.csv`-embedded layout, which `tests/reference_test` exercises end to end
but which cannot be run without cloning an external repo.

`mapping_csv is None` (a tile CSV's `CONFIGMEM,NULL`) is the other half: the
parser rejects it on a tile that has configuration bits, and the generators must
still let a genuinely zero-config-bit tile through instead of dereferencing the
missing path.
"""

from pathlib import Path

import pytest

from fabulous.fabric_cad.gen_bitstream_spec import generateBitstreamSpec
from fabulous.fabric_definition.config_mem_spec import (
    ConfigMemSpec,
    resolve_config_mem_spec,
)
from fabulous.fabric_definition.supertile import SuperTile
from fabulous.fabric_definition.switch_matrix import SwitchMatrix
from fabulous.fabric_definition.tile import Tile
from fabulous.fabric_generator.code_generator.code_generator_Verilog import (
    VerilogCodeGenerator,
)
from fabulous.fabric_generator.gen_fabric.gen_configmem import (
    generate_super_tile_config_mem,
    generateConfigMem,
    generateConfigMemInit,
)
from tests.conftest import make_empty_tile, make_fabric_from_grid

PROJ = Path("/proj")

NO_CONFIG_MEM = ConfigMemSpec(mapping_csv=None)


def _tile(tile_dir: Path, config_mem: ConfigMemSpec | None = None) -> Tile:
    """Build a bare tile carrying only the fields the config-mem path needs."""
    return Tile(
        name="LUT4AB",
        ports=[],
        bels=[],
        tileDir=tile_dir,
        switch_matrix=SwitchMatrix(matrix_file=Path(), connections={}),
        gen_ios=[],
        userCLK=False,
        config_mem=config_mem,
    )


def test_by_convention_sits_next_to_the_tile_csv() -> None:
    """The mapping file is named after the tile and lives beside its CSV."""
    spec = ConfigMemSpec.by_convention("LUT4AB", PROJ / "Tile/LUT4AB/LUT4AB.csv")
    assert spec.mapping_csv == PROJ / "Tile/LUT4AB/LUT4AB_ConfigMem.csv"


def test_modern_layout_ignores_the_switch_matrix_file(tmp_path: Path) -> None:
    """A tile with its own CSV resolves relative to that CSV, not the matrix."""
    matrix = tmp_path / "elsewhere.csv"
    matrix.touch()
    spec = resolve_config_mem_spec(
        "LUT4AB",
        PROJ / "Tile/LUT4AB/LUT4AB.csv",
        PROJ,
        switch_matrix_file=matrix,
    )
    assert spec.mapping_csv == PROJ / "Tile/LUT4AB/LUT4AB_ConfigMem.csv"


def test_legacy_layout_follows_the_switch_matrix_file(tmp_path: Path) -> None:
    """A tile declared inline in fabric.csv is located via its matrix file."""
    tile_dir = tmp_path / "Tile" / "LUT4AB"
    tile_dir.mkdir(parents=True)
    matrix = tile_dir / "LUT4AB_switch_matrix.csv"
    matrix.touch()
    spec = resolve_config_mem_spec(
        "LUT4AB", PROJ / "fabric.csv", PROJ, switch_matrix_file=matrix
    )
    assert spec.mapping_csv == tile_dir / "LUT4AB_ConfigMem.csv"


@pytest.mark.parametrize(
    "switch_matrix_file",
    [None, PROJ / "does_not_exist.csv"],
    ids=["no-matrix-file", "matrix-file-missing"],
)
def test_legacy_layout_falls_back_to_project_tile_dir(
    switch_matrix_file: Path | None, caplog: pytest.LogCaptureFixture
) -> None:
    """Without a usable matrix file the legacy layout warns and assumes a default."""
    spec = resolve_config_mem_spec(
        "LUT4AB", PROJ / "fabric.csv", PROJ, switch_matrix_file=switch_matrix_file
    )
    assert spec.mapping_csv == PROJ / "Tile/LUT4AB/LUT4AB_ConfigMem.csv"
    assert "is not a valid file or directory" in caplog.text


def test_tile_defaults_to_the_conventional_location() -> None:
    """A tile built without a spec still exposes the conventional path."""
    tile = _tile(PROJ / "Tile/LUT4AB/LUT4AB.csv")
    assert tile.config_mem.mapping_csv == PROJ / "Tile/LUT4AB/LUT4AB_ConfigMem.csv"


def test_tile_keeps_an_explicit_spec() -> None:
    """An explicitly supplied spec wins over the convention."""
    spec = ConfigMemSpec(mapping_csv=PROJ / "shared/LUT4AB_ConfigMem.csv")
    assert _tile(PROJ / "Tile/LUT4AB/LUT4AB.csv", config_mem=spec).config_mem is spec


def test_supertile_defaults_to_the_conventional_location() -> None:
    """A supertile resolves its own mapping file, not the master tile's."""
    super_tile = SuperTile(
        name="DSP",
        tileDir=PROJ / "Tile/DSP/DSP.csv",
        tiles=[],
        tileMap=[],
    )
    assert super_tile.config_mem.mapping_csv == PROJ / "Tile/DSP/DSP_ConfigMem.csv"


class TestGeneratorsHonourNoConfigMem:
    """`mapping_csv is None` must reach a decision, never a dereference.

    A zero-config-bit tile with `CONFIGMEM,NULL` is legitimate and has to flow
    through generation untouched. The contradictory combination — no mapping
    file but configuration bits to place — is what the parser rejects, and each
    generator repeats the check because it takes the count and the path as
    independent arguments.
    """

    def test_bitstream_spec_skips_a_tile_without_config_memory(
        self, caplog: pytest.LogCaptureFixture
    ) -> None:
        """A NULL zero-bit tile yields an empty frame map, not a crash."""
        tile = make_empty_tile("EMPTY", config_bits=0)
        tile.config_mem = NO_CONFIG_MEM

        spec = generateBitstreamSpec(make_fabric_from_grid([[tile]]))

        assert spec["FrameMap"]["EMPTY"] == {}
        assert spec["FrameMapEncode"]["EMPTY"] == {}
        assert "No config memory for EMPTY." in caplog.text

    def test_config_mem_rtl_is_not_generated_without_config_memory(
        self, tmp_path: Path
    ) -> None:
        """`generateConfigMem` writes nothing for a NULL zero-bit tile."""
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "EMPTY_ConfigMem.v"

        generateConfigMem(writer, "EMPTY", 0, None)

        assert not writer.outFileName.exists()

    def test_config_mem_rtl_rejects_config_bits_without_config_memory(
        self, tmp_path: Path
    ) -> None:
        """Bits with nowhere to go is an error naming the tile and the count."""
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "LUT4AB_ConfigMem.v"

        with pytest.raises(ValueError, match="LUT4AB declares no configuration"):
            generateConfigMem(writer, "LUT4AB", 42, None)

    def test_super_tile_config_mem_needs_no_master_mapping_when_it_has_no_bits(
        self, tmp_path: Path
    ) -> None:
        """A supertile with no config bits never looks at the master mapping."""
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "DSP_ConfigMem.v"
        super_tile = SuperTile(
            name="DSP", tileDir=tmp_path / "DSP.csv", tiles=[], tileMap=[]
        )

        generate_super_tile_config_mem(writer, super_tile, None)

        assert not writer.outFileName.exists()

    def test_super_tile_config_mem_rejects_a_master_without_config_memory(
        self, tmp_path: Path
    ) -> None:
        """Supertile bits live in the master's frames, so the master needs a map."""
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "DSP_ConfigMem.v"
        super_tile = SuperTile(
            name="DSP",
            tileDir=tmp_path / "DSP.csv",
            tiles=[],
            tileMap=[],
            switch_matrix=SwitchMatrix(
                matrix_file=Path(), connections={}, hdl_config_bits=4
            ),
        )

        with pytest.raises(ValueError, match="master tile declares no configuration"):
            generate_super_tile_config_mem(writer, super_tile, None)


class TestGeneratorsSkipHandWrittenConfigMem:
    """`hdl_file` suppresses the RTL and nothing else.

    A tile whose CSV names HDL owns the `<tile>_ConfigMem` module, so the
    generator must not write one. The mapping CSV is a separate contract - the
    bitstream reads it whoever wrote the RTL - so it is still created when
    missing and still checked against the tile's configuration-bit count.
    """

    def test_rtl_is_not_written_but_the_mapping_is(self, tmp_path: Path) -> None:
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "LUT4AB_ConfigMem.v"
        hdl = tmp_path / "LUT4AB_ConfigMem_hand_written.v"
        hdl.write_text("")
        mapping = tmp_path / "LUT4AB_ConfigMem.csv"

        generateConfigMem(writer, "LUT4AB", 8, mapping, hdl_file=hdl)

        assert mapping.is_file()
        assert not writer.outFileName.exists()

    def test_rtl_is_written_without_hand_written_hdl(self, tmp_path: Path) -> None:
        """The same call without `hdl_file` still emits the module."""
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "LUT4AB_ConfigMem.v"

        generateConfigMem(writer, "LUT4AB", 8, tmp_path / "LUT4AB_ConfigMem.csv")

        assert writer.outFileName.is_file()

    def test_mapping_is_still_checked_against_the_bit_count(
        self, tmp_path: Path
    ) -> None:
        """A stale mapping is caught even though no RTL is generated from it."""
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "LUT4AB_ConfigMem.v"
        hdl = tmp_path / "LUT4AB_ConfigMem_hand_written.v"
        hdl.write_text("")
        mapping = tmp_path / "LUT4AB_ConfigMem.csv"
        generateConfigMemInit(mapping, 8)

        with pytest.raises(ValueError, match="bitmask mismatch"):
            generateConfigMem(writer, "LUT4AB", 4, mapping, hdl_file=hdl)

    def test_bitstream_spec_reads_the_mapping_of_a_hand_written_tile(
        self, tmp_path: Path
    ) -> None:
        """`hdl_file` is invisible to the bitstream spec."""
        mapping = tmp_path / "LUT4AB_ConfigMem.csv"
        generateConfigMemInit(mapping, 8)
        tile = make_empty_tile("LUT4AB", config_bits=8)
        tile.config_mem = ConfigMemSpec(
            mapping_csv=mapping, hdl_file=tmp_path / "LUT4AB_ConfigMem_hand.v"
        )

        spec = generateBitstreamSpec(make_fabric_from_grid([[tile]]))

        assert spec["FrameMap"]["LUT4AB"] != {}
