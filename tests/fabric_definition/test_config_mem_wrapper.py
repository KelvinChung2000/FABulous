"""Tests for the ConfigMem wrapper model, its path resolver, and `None` consumers.

The resolver is the single authority for `<tile>_ConfigMem.csv`, so these tests
pin down each layout it has to serve — in particular the legacy
`fabric.csv`-embedded layout, which `tests/reference_test` exercises end to end
but which cannot be run without cloning an external repo.

`config_mem_csv is None` (a tile CSV's `CONFIGMEM,NULL`) is the other half: the
parser rejects it on a tile that has configuration bits, and the generators must
still let a genuinely zero-config-bit tile through instead of dereferencing the
missing path.

A wrapper never suppresses generation. `<tile>_ConfigMem` is emitted whether or
not a wrapper sits around it, because the wrapper instantiates it.
"""

from pathlib import Path

import pytest

from fabulous.fabric_cad.gen_bitstream_spec import generateBitstreamSpec
from fabulous.fabric_definition.config_mem_wrapper import (
    ConfigMemPort,
    ConfigMemWrapper,
    conventional_config_mem_csv,
    resolve_config_mem_csv,
)
from fabulous.fabric_definition.define import IO
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


def _tile(tile_dir: Path, config_mem_csv: Path | None = None) -> Tile:
    """Build a bare tile carrying only the fields the config-mem path needs."""
    return Tile(
        name="LUT4AB",
        ports=[],
        bels=[],
        tileDir=tile_dir,
        switch_matrix=SwitchMatrix(matrix_file=Path(), connections={}),
        gen_ios=[],
        userCLK=False,
        config_mem_csv=config_mem_csv,
    )


def test_convention_sits_next_to_the_tile_csv() -> None:
    """The mapping file is named after the tile and lives beside its CSV."""
    assert (
        conventional_config_mem_csv("LUT4AB", PROJ / "Tile/LUT4AB/LUT4AB.csv")
        == PROJ / "Tile/LUT4AB/LUT4AB_ConfigMem.csv"
    )


def test_modern_layout_ignores_the_switch_matrix_file(tmp_path: Path) -> None:
    """A tile with its own CSV resolves relative to that CSV, not the matrix."""
    matrix = tmp_path / "elsewhere.csv"
    matrix.touch()
    assert (
        resolve_config_mem_csv(
            "LUT4AB", PROJ / "Tile/LUT4AB/LUT4AB.csv", PROJ, switch_matrix_file=matrix
        )
        == PROJ / "Tile/LUT4AB/LUT4AB_ConfigMem.csv"
    )


def test_legacy_layout_follows_the_switch_matrix_file(tmp_path: Path) -> None:
    """A tile declared inline in fabric.csv is located via its matrix file."""
    tile_dir = tmp_path / "Tile" / "LUT4AB"
    tile_dir.mkdir(parents=True)
    matrix = tile_dir / "LUT4AB_switch_matrix.csv"
    matrix.touch()
    assert (
        resolve_config_mem_csv(
            "LUT4AB", PROJ / "fabric.csv", PROJ, switch_matrix_file=matrix
        )
        == tile_dir / "LUT4AB_ConfigMem.csv"
    )


def test_a_tile_dir_merely_containing_fabric_csv_is_not_the_legacy_layout() -> None:
    """Only a tile CSV actually named `fabric.csv` takes the legacy path."""
    tile_csv = PROJ / "fabric.csv.d" / "LUT4AB.csv"
    assert (
        resolve_config_mem_csv("LUT4AB", tile_csv, PROJ)
        == PROJ / "fabric.csv.d" / "LUT4AB_ConfigMem.csv"
    )


@pytest.mark.parametrize(
    "switch_matrix_file",
    [None, PROJ / "does_not_exist.csv"],
    ids=["no-matrix-file", "matrix-file-missing"],
)
def test_legacy_layout_falls_back_to_project_tile_dir(
    switch_matrix_file: Path | None, caplog: pytest.LogCaptureFixture
) -> None:
    """Without a usable matrix file the legacy layout warns and assumes a default."""
    assert (
        resolve_config_mem_csv(
            "LUT4AB", PROJ / "fabric.csv", PROJ, switch_matrix_file=switch_matrix_file
        )
        == PROJ / "Tile/LUT4AB/LUT4AB_ConfigMem.csv"
    )
    assert "is not a valid file or directory" in caplog.text


def test_tile_keeps_the_mapping_it_was_given() -> None:
    """The tile stores the path the parser resolved, with no second guess."""
    mapping = PROJ / "shared/LUT4AB_ConfigMem.csv"
    assert _tile(PROJ / "Tile/LUT4AB/LUT4AB.csv", mapping).config_mem_csv == mapping


def test_tile_without_config_memory_keeps_none() -> None:
    """`None` survives construction: it means CONFIGMEM,NULL, not 'unset'."""
    assert _tile(PROJ / "Tile/LUT4AB/LUT4AB.csv", None).config_mem_csv is None


def test_supertile_derives_the_conventional_location() -> None:
    """A supertile resolves its own mapping file, not the master tile's."""
    super_tile = SuperTile(
        name="DSP", tileDir=PROJ / "Tile/DSP/DSP.csv", tiles=[], tileMap=[]
    )
    assert super_tile.config_mem_csv == PROJ / "Tile/DSP/DSP_ConfigMem.csv"


@pytest.mark.parametrize(
    "module",
    ["ecc_guard", "_private", "Guard2", "a"],
    ids=["plain", "leading-underscore", "mixed-case", "single-letter"],
)
def test_any_hdl_identifier_may_name_the_wrapper(module: str) -> None:
    """The module is the user's to name; nothing derives it from the tile."""
    assert ConfigMemWrapper(hdl_file=Path("w.v"), module=module).module == module


@pytest.mark.parametrize(
    "module",
    ["", "9lives", "ecc guard", "ecc-guard", "./ecc_guard.v"],
    ids=["empty", "leading-digit", "space", "dash", "path"],
)
def test_a_module_name_that_is_not_an_identifier_is_rejected(module: str) -> None:
    with pytest.raises(ValueError, match="not an HDL identifier"):
        ConfigMemWrapper(hdl_file=Path("w.v"), module=module)


class TestWrapperPortValidation:
    """A declared port that cannot be wired is rejected where it is declared."""

    @pytest.mark.parametrize(
        ("name", "io", "width", "match"),
        [
            ("", IO.OUTPUT, 1, "empty port name"),
            ("FrameData", IO.INPUT, 32, "collides with a standard"),
            ("ConfigBits_N", IO.OUTPUT, 8, "collides with a standard"),
            ("crc_error", IO.OUTPUT, 0, "at least one bit"),
            ("crc_error", IO.OUTPUT, -4, "at least one bit"),
            ("crc_error", IO.INOUT, 1, "INPUT or OUTPUT"),
        ],
        ids=[
            "empty-name",
            "collides-framedata",
            "collides-configbits-n",
            "zero-width",
            "negative-width",
            "inout-direction",
        ],
    )
    def test_invalid_port_is_rejected(
        self, name: str, io: IO, width: int, match: str
    ) -> None:
        with pytest.raises(ValueError, match=match):
            ConfigMemPort(name=name, io=io, width=width)

    def test_duplicate_port_names_are_rejected(self, tmp_path: Path) -> None:
        port = ConfigMemPort(name="crc_error", io=IO.OUTPUT, width=1)
        with pytest.raises(ValueError, match="declared more than once"):
            ConfigMemWrapper(
                hdl_file=tmp_path / "w.v", module="ecc_guard", ports=(port, port)
            )

    def test_user_clk_is_not_an_external_port(self, tmp_path: Path) -> None:
        """`UserCLK` binds to the tile clock, so it never leaves the tile."""
        wrapper = ConfigMemWrapper(
            hdl_file=tmp_path / "w.v",
            module="ecc_guard",
            ports=(
                ConfigMemPort(name="UserCLK", io=IO.INPUT, width=1),
                ConfigMemPort(name="crc_error", io=IO.OUTPUT, width=1),
            ),
        )

        assert wrapper.wants_user_clk
        assert [p.name for p in wrapper.external_ports] == ["crc_error"]

    def test_a_wrapper_without_user_clk_says_so(self, tmp_path: Path) -> None:
        wrapper = ConfigMemWrapper(hdl_file=tmp_path / "w.v", module="ecc_guard")
        assert not wrapper.wants_user_clk
        assert wrapper.external_ports == ()


class TestGeneratorsHonourNoConfigMem:
    """`config_mem_csv is None` must reach a decision, never a dereference.

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
        tile.config_mem_csv = None

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


class TestAWrapperNeverSuppressesGeneration:
    """The wrapper instantiates `<tile>_ConfigMem`, so it must still be generated.

    This is the whole point of wrapping rather than overriding: the frame-latch
    array stays FABulous's, and user logic sits around it.
    """

    def test_rtl_is_written_for_a_wrapped_tile(self, tmp_path: Path) -> None:
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "LUT4AB_ConfigMem.v"

        generateConfigMem(writer, "LUT4AB", 8, tmp_path / "LUT4AB_ConfigMem.csv")

        assert writer.outFileName.is_file()

    def test_the_mapping_is_still_checked_against_the_bit_count(
        self, tmp_path: Path
    ) -> None:
        """A stale mapping is caught regardless of what wraps the module."""
        writer = VerilogCodeGenerator()
        writer.outFileName = tmp_path / "LUT4AB_ConfigMem.v"
        mapping = tmp_path / "LUT4AB_ConfigMem.csv"
        generateConfigMemInit(mapping, 8)

        with pytest.raises(ValueError, match="bitmask mismatch"):
            generateConfigMem(writer, "LUT4AB", 4, mapping)

    def test_bitstream_spec_is_blind_to_the_wrapper(self, tmp_path: Path) -> None:
        """The bitstream reads the mapping whoever wraps the module."""
        mapping = tmp_path / "LUT4AB_ConfigMem.csv"
        generateConfigMemInit(mapping, 8)
        tile = make_empty_tile("LUT4AB", config_bits=8)
        tile.config_mem_csv = mapping
        tile.config_mem_wrapper = ConfigMemWrapper(
            hdl_file=tmp_path / "wrap.v", module="ecc_guard"
        )

        spec = generateBitstreamSpec(make_fabric_from_grid([[tile]]))

        assert spec["FrameMap"]["LUT4AB"] != {}


class TestUserClkPortShape:
    """`UserCLK` binds to the tile clock, so only one shape makes sense."""

    @pytest.mark.parametrize(
        ("io", "width"),
        [(IO.OUTPUT, 1), (IO.INPUT, 8)],
        ids=["output-direction", "multi-bit"],
    )
    def test_a_misshapen_user_clk_is_rejected(self, io: IO, width: int) -> None:
        with pytest.raises(ValueError, match="UserCLK"):
            ConfigMemPort(name="UserCLK", io=io, width=width)

    def test_a_scalar_input_user_clk_is_accepted(self) -> None:
        assert ConfigMemPort(name="UserCLK", io=IO.INPUT, width=1).width == 1
