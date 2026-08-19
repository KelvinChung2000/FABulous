"""Tests for parsing tile port lines from CSV fabric definitions."""

from pathlib import Path

import pytest

from fabulous.custom_exception import (
    InvalidPortType,
    InvalidSupertileDefinition,
    InvalidTileDefinition,
)
from fabulous.fabric_definition.config_mem_wrapper import (
    ConfigMemPort,
    ConfigMemWrapper,
    wrapper_module_name,
)
from fabulous.fabric_definition.define import IO, Direction, Side
from fabulous.fabric_definition.fabric import Fabric
from fabulous.fabric_definition.tile import Tile
from fabulous.fabric_generator.parser.parse_csv import (
    parse_port_line,
    parseSupertilesCSV,
    parseTilesCSV,
)
from fabulous.fabulous_settings import init_context
from tests.conftest import make_empty_tile

# (kind, physical side of the OUTPUT/start port, physical side of the INPUT/end port)
DIRECTIONAL_CASES = [
    ("NORTH", Side.NORTH, Side.SOUTH),
    ("SOUTH", Side.SOUTH, Side.NORTH),
    ("EAST", Side.EAST, Side.WEST),
    ("WEST", Side.WEST, Side.EAST),
]


class TestDirectionalPorts:
    """NORTH/SOUTH/EAST/WEST lines produce an OUTPUT/INPUT port pair."""

    @pytest.mark.parametrize(("kind", "startSide", "endSide"), DIRECTIONAL_CASES)
    def test_two_ports_with_expected_io_and_sides(
        self, kind: str, startSide: Side, endSide: Side
    ) -> None:
        ports, commonWirePair = parse_port_line(f"{kind},N1BEG,0,-1,N1END,4")

        assert len(ports) == 2
        output, input_ = ports

        assert output.io_direction is IO.OUTPUT
        assert output.name == "N1BEG"
        assert output.side_of_tile is startSide

        assert input_.io_direction is IO.INPUT
        assert input_.name == "N1END"
        assert input_.side_of_tile is endSide

        assert commonWirePair == ("N1BEG", "N1END")

    @pytest.mark.parametrize("kind", [c[0] for c in DIRECTIONAL_CASES])
    def test_shared_attributes_carry_through(self, kind: str) -> None:
        ports, _ = parse_port_line(f"{kind},N2BEG,0,-2,N2END,8")

        for port in ports:
            assert port.wire_direction is Direction[kind]
            assert port.source_name == "N2BEG"
            assert port.destination_name == "N2END"
            assert port.x_offset == 0
            assert port.y_offset == -2
            assert port.wire_count == 8

    def test_null_destination_keeps_name_and_pairs(self) -> None:
        ports, commonWirePair = parse_port_line("SOUTH,S4BEG,0,4,NULL,4")

        assert ports[1].name == "NULL"
        assert commonWirePair == ("S4BEG", "NULL")


class TestJumpPorts:
    """JUMP lines stay within a tile, so both ports sit on Side.ANY."""

    def test_two_ports_on_any_side(self) -> None:
        ports, _ = parse_port_line("JUMP,J_SR_BEG,0,0,J_SR_END,1")

        assert len(ports) == 2
        output, input_ = ports

        assert output.io_direction is IO.OUTPUT
        assert output.name == "J_SR_BEG"
        assert input_.io_direction is IO.INPUT
        assert input_.name == "J_SR_END"

        assert all(p.wire_direction is Direction.JUMP for p in ports)
        assert all(p.side_of_tile is Side.ANY for p in ports)

    def test_no_common_wire_pair(self) -> None:
        _, commonWirePair = parse_port_line("JUMP,J_SR_BEG,0,0,J_SR_END,1")

        assert commonWirePair is None


class TestUnknownPortType:
    """Lines that are not a known wire direction are rejected."""

    @pytest.mark.parametrize("kind", ["BEL", "MATRIX", "north", "FOO"])
    def test_raises_invalid_port_type(self, kind: str) -> None:
        with pytest.raises(InvalidPortType, match="Unknown port type"):
            parse_port_line(f"{kind},SRC_BEG,0,0,DST_END,1")


class TestPortNameTrailingDigit:
    """A declared port name must not end in a digit.

    Trailing digits are reserved for the index that wire expansion appends
    (``N1BEG`` -> `N1BEG0`, `N1BEG1` ...). A declared name that already
    ends in a digit (e.g. ``X0_Y4_2_X0_Y3``) becomes ambiguous once the index
    is appended, because downstream the trailing digits are read back as a bit
    index. Reject such names at the parsing boundary.
    """

    @pytest.mark.parametrize("kind", ["NORTH", "SOUTH", "EAST", "WEST", "JUMP"])
    def test_source_name_ending_in_digit_raises(self, kind: str) -> None:
        line = f"{kind},X0_Y4_2_X0_Y3,0,0,DST_END,1"
        with pytest.raises(InvalidPortType, match="digit"):
            parse_port_line(line)

    @pytest.mark.parametrize("kind", ["NORTH", "SOUTH", "EAST", "WEST", "JUMP"])
    def test_destination_name_ending_in_digit_raises(self, kind: str) -> None:
        line = f"{kind},SRC_BEG,0,0,X0_Y4_2_X0_Y3,1"
        with pytest.raises(InvalidPortType, match="digit"):
            parse_port_line(line)

    def test_single_trailing_digit_raises(self) -> None:
        with pytest.raises(InvalidPortType, match="digit"):
            parse_port_line("JUMP,BUS3,0,0,J_END,1")

    @pytest.mark.parametrize(
        "line",
        [
            "JUMP,J_SR_BEG,0,0,J_SR_END,1",
            "NORTH,N1BEG,0,-1,N1END,4",
            "SOUTH,S4BEG,0,4,NULL,4",
            "NORTH,NULL,0,-1,N1END,4",
        ],
    )
    def test_valid_names_do_not_raise(self, line: str) -> None:
        ports, _ = parse_port_line(line)
        assert ports


class TestConfigMemWiring:
    """`parseTilesCSV` is the sole producer of a tile's config-memory path.

    The mapping CSV path used to be rebuilt by convention in every consumer.
    These tests pin the parser as the one place that decides it, for both the
    modern per-tile-directory layout and the legacy `fabric.csv`-embedded one
    that `tests/reference_test` covers end to end.
    """

    def test_modern_layout_resolves_next_to_the_tile_csv(
        self, parsed_default_fabric: Fabric
    ) -> None:
        for tile in parsed_default_fabric.tileDic.values():
            assert (
                tile.config_mem_csv
                == tile.tileDir.parent / f"{tile.name}_ConfigMem.csv"
            )

    def test_supertile_resolves_its_own_not_the_master_tiles(
        self, parsed_default_fabric: Fabric
    ) -> None:
        assert parsed_default_fabric.superTileDic, "fixture must contain a supertile"
        for super_tile in parsed_default_fabric.superTileDic.values():
            assert (
                super_tile.config_mem_csv
                == super_tile.tileDir.parent / f"{super_tile.name}_ConfigMem.csv"
            )
            for sub_tile in super_tile.tiles:
                assert sub_tile.config_mem_csv != super_tile.config_mem_csv

    def test_legacy_inline_layout_follows_the_switch_matrix_file(
        self, tmp_path: Path
    ) -> None:
        """A tile declared inline in fabric.csv is located via its matrix file.

        `tileDir` is then fabric.csv itself and says nothing about where the
        tile lives, so the switch-matrix path is the only usable anchor. The
        matrix deliberately sits outside `Tile/LUT4AB/` so that following it is
        distinguishable from the `<proj>/Tile/<name>/` fallback.
        """
        matrix_dir = tmp_path / "legacy_tiles"
        matrix_dir.mkdir()
        (matrix_dir / "LUT4AB_switch_matrix.list").write_text("")

        fabric_csv = tmp_path / "fabric.csv"
        # Rows need a trailing comma run: parseTilesCSV indexes temp[6].
        fabric_csv.write_text(
            "TILE,LUT4AB,,,,,,\n"
            "NORTH,N1BEG,0,-1,N1END,4,,\n"
            "MATRIX,./legacy_tiles/LUT4AB_switch_matrix.list,,,,,,\n"
            "EndTILE,,,,,,,\n"
        )

        (tmp_path / ".FABulous").mkdir(exist_ok=True)
        init_context(tmp_path)
        tiles, _ = parseTilesCSV(fabric_csv)

        assert len(tiles) == 1
        assert tiles[0].tileDir == fabric_csv
        assert tiles[0].config_mem_csv == matrix_dir / "LUT4AB_ConfigMem.csv"


TILE_NAME = "LUT4AB"

# One mux with three inputs: (3 - 1).bit_length() == 2 select bits.
MATRIX_WITH_TWO_CONFIG_BITS = "N1BEG0,N1END0\nN1BEG0,N1END1\nN1BEG0,N1END2\n"


def write_tile_csv(proj_dir: Path, *extra_rows: str, matrix: str = "") -> Path:
    """Write a minimal `Tile/LUT4AB/LUT4AB.csv` plus its switch matrix file.

    Rows carry a trailing comma run because `parseTilesCSV` indexes `temp[6]`.

    Parameters
    ----------
    proj_dir : Path
        Project root the tile directory is created under.
    *extra_rows : str
        Extra CSV rows (without the trailing comma run) placed after MATRIX.
    matrix : str, optional
        Contents of the tile's `.list` switch matrix. Empty (the default) gives
        a tile with zero configuration bits; a mux with two or more inputs makes
        the tile report config bits.

    Returns
    -------
    Path
        The tile CSV that was written.
    """
    tile_dir = proj_dir / "Tile" / TILE_NAME
    tile_dir.mkdir(parents=True, exist_ok=True)
    (tile_dir / f"{TILE_NAME}_switch_matrix.list").write_text(matrix)

    rows = [
        f"TILE,{TILE_NAME}",
        "NORTH,N1BEG,0,-1,N1END,4",
        f"MATRIX,./{TILE_NAME}_switch_matrix.list",
        *extra_rows,
        "EndTILE",
    ]
    tile_csv = tile_dir / f"{TILE_NAME}.csv"
    tile_csv.write_text("".join(f"{row},,,,,,,\n" for row in rows))
    return tile_csv


# Wrapper suffixes paired with a project language that accepts them. Verilog and
# SystemVerilog projects take either Verilog suffix, matching the models pack.
WRAPPER_LANGUAGE_CASES = [
    (".v", "verilog"),
    (".sv", "verilog"),
    (".v", "system_verilog"),
    (".sv", "system_verilog"),
    (".vhd", "vhdl"),
    (".vhdl", "vhdl"),
]


def write_config_mem_hdl(
    proj_dir: Path, suffix: str, module: str | None = None
) -> Path:
    """Write a hand-written ConfigMem wrapper HDL into the tile directory.

    Only the module declaration matters: the parser checks that the file
    declares the wrapper module, and never looks at its body.

    Parameters
    ----------
    proj_dir : Path
        Project root the tile directory is created under.
    suffix : str
        HDL suffix, one of `.v`, `.sv`, `.vhd`, `.vhdl`.
    module : str | None, optional
        Name to declare, defaulting to the wrapper module the tile expects.

    Returns
    -------
    Path
        The HDL file that was written.
    """
    name = wrapper_module_name(TILE_NAME) if module is None else module
    if suffix in (".v", ".sv"):
        source = f"module {name};\nendmodule\n"
    else:
        source = f"entity {name} is\nend entity;\n"

    hdl = proj_dir / "Tile" / TILE_NAME / f"{TILE_NAME}_ConfigMem{suffix}"
    hdl.parent.mkdir(parents=True, exist_ok=True)
    hdl.write_text(source)
    return hdl


def parse_single_tile(proj_dir: Path, *extra_rows: str, matrix: str = "") -> Tile:
    """Parse a synthetic one-tile CSV and return the tile.

    Parameters
    ----------
    proj_dir : Path
        Project root; also becomes the settings context.
    *extra_rows : str
        Extra CSV rows passed through to `write_tile_csv`.
    matrix : str, optional
        Switch matrix `.list` contents passed through to `write_tile_csv`.

    Returns
    -------
    Tile
        The single parsed tile.
    """
    tile_csv = write_tile_csv(proj_dir, *extra_rows, matrix=matrix)
    (proj_dir / ".FABulous").mkdir(exist_ok=True)
    init_context(proj_dir)
    tiles, _ = parseTilesCSV(tile_csv)
    assert len(tiles) == 1
    return tiles[0]


class TestConfigMemKeyword:
    """The optional `CONFIGMEM` tile-CSV line says where config memory comes from.

    A `.csv` entry overrides the mapping-file path. An HDL entry names a
    wrapper around the generated `<tile>_ConfigMem`, and leaves the mapping CSV
    where convention puts it — the bitstream reads it either way.
    """

    def test_absent_line_keeps_the_convention_default(self, tmp_path: Path) -> None:
        """No `CONFIGMEM` line must behave exactly as before the keyword existed."""
        tile = parse_single_tile(tmp_path)

        assert (
            tile.config_mem_csv
            == tmp_path / "Tile" / TILE_NAME / f"{TILE_NAME}_ConfigMem.csv"
        )

    @pytest.mark.parametrize(
        ("entry", "expected_parts"),
        [
            ("custom_ConfigMem.csv", ("Tile", TILE_NAME, "custom_ConfigMem.csv")),
            ("./custom_ConfigMem.csv", ("Tile", TILE_NAME, "custom_ConfigMem.csv")),
            ("./mapping/custom.csv", ("Tile", TILE_NAME, "mapping", "custom.csv")),
            ("../shared_ConfigMem.csv", ("Tile", "shared_ConfigMem.csv")),
        ],
    )
    def test_csv_entry_resolves_against_the_tile_csv_directory(
        self, tmp_path: Path, entry: str, expected_parts: tuple[str, ...]
    ) -> None:
        tile = parse_single_tile(tmp_path, f"CONFIGMEM,{entry}")

        assert (
            tile.config_mem_csv.resolve()
            == tmp_path.joinpath(*expected_parts).resolve()
        )

    def test_csv_entry_need_not_exist(self, tmp_path: Path) -> None:
        """`generateConfigMem` writes the mapping on demand, so absence is fine."""
        tile = parse_single_tile(tmp_path, "CONFIGMEM,./not_written_yet.csv")

        assert not tile.config_mem_csv.exists()
        assert tile.config_mem_csv.name == "not_written_yet.csv"

    def test_null_means_no_configuration_memory(self, tmp_path: Path) -> None:
        tile = parse_single_tile(tmp_path, "CONFIGMEM,NULL")

        assert tile.config_mem_csv is None
        assert tile.config_mem_wrapper is None
        assert tile.globalConfigBits == 0

    def test_null_on_a_tile_with_config_bits_is_rejected(self, tmp_path: Path) -> None:
        """A tile that needs config bits cannot also say it has no config memory.

        `globalConfigBits` is only known once the switch matrix is read, so this
        contradiction has to be caught after the `Tile` is built rather than on
        the `CONFIGMEM` line itself.
        """
        with pytest.raises(InvalidTileDefinition) as excinfo:
            parse_single_tile(
                tmp_path,
                "CONFIGMEM,NULL",
                matrix=MATRIX_WITH_TWO_CONFIG_BITS,
            )

        message = str(excinfo.value)
        assert TILE_NAME in message
        assert "2 configuration bits" in message
        assert "CONFIGMEM,NULL" in message

    def test_config_bits_are_fine_without_the_null_token(self, tmp_path: Path) -> None:
        """The rejection is about `NULL` specifically, not about having bits."""
        tile = parse_single_tile(tmp_path, matrix=MATRIX_WITH_TWO_CONFIG_BITS)

        assert tile.globalConfigBits == 2
        assert tile.config_mem_csv is not None

    @pytest.mark.parametrize(("suffix", "lang"), WRAPPER_LANGUAGE_CASES)
    def test_hdl_entry_is_recorded_for_every_suffix(
        self, tmp_path: Path, monkeypatch: pytest.MonkeyPatch, suffix: str, lang: str
    ) -> None:
        monkeypatch.setenv("FAB_PROJ_LANG", lang)
        hdl = write_config_mem_hdl(tmp_path, suffix)

        tile = parse_single_tile(tmp_path, f"CONFIGMEM,./{hdl.name}")

        assert tile.config_mem_wrapper is not None
        assert tile.config_mem_wrapper.hdl_file == hdl

    @pytest.mark.parametrize(("suffix", "lang"), WRAPPER_LANGUAGE_CASES)
    def test_hdl_entry_keeps_the_conventional_mapping_csv(
        self, tmp_path: Path, monkeypatch: pytest.MonkeyPatch, suffix: str, lang: str
    ) -> None:
        """Wrapping the module does not move the bitstream's mapping file."""
        monkeypatch.setenv("FAB_PROJ_LANG", lang)
        hdl = write_config_mem_hdl(tmp_path, suffix)

        tile = parse_single_tile(tmp_path, f"CONFIGMEM,./{hdl.name}")

        assert (
            tile.config_mem_csv
            == tmp_path / "Tile" / TILE_NAME / f"{TILE_NAME}_ConfigMem.csv"
        )

    def test_hdl_entry_survives_a_tile_with_config_bits(self, tmp_path: Path) -> None:
        """A wrapped tile is not a `CONFIGMEM,NULL` tile, so bits are fine."""
        hdl = write_config_mem_hdl(tmp_path, ".v")

        tile = parse_single_tile(
            tmp_path,
            f"CONFIGMEM,./{hdl.name}",
            matrix=MATRIX_WITH_TWO_CONFIG_BITS,
        )

        assert tile.globalConfigBits == 2
        assert tile.config_mem_wrapper is not None
        assert tile.config_mem_wrapper.hdl_file == hdl
        assert tile.config_mem_csv is not None

    def test_missing_hdl_file_is_rejected(self, tmp_path: Path) -> None:
        """Nothing writes the HDL on demand, so a missing file is an error."""
        with pytest.raises(InvalidTileDefinition, match="does not exist"):
            parse_single_tile(tmp_path, f"CONFIGMEM,./{TILE_NAME}_ConfigMem.v")

    @pytest.mark.parametrize(
        "entry", ["./mapping.txt", "./mapping.list", "./mapping.yaml", "./mapping"]
    )
    def test_unknown_suffix_is_rejected(self, tmp_path: Path, entry: str) -> None:
        with pytest.raises(InvalidTileDefinition, match="unsupported suffix"):
            parse_single_tile(tmp_path, f"CONFIGMEM,{entry}")

    def test_empty_entry_is_rejected(self, tmp_path: Path) -> None:
        with pytest.raises(InvalidTileDefinition, match="has no value"):
            parse_single_tile(tmp_path, "CONFIGMEM")

    def test_duplicate_line_is_rejected(self, tmp_path: Path) -> None:
        with pytest.raises(InvalidTileDefinition, match="more than one CONFIGMEM"):
            parse_single_tile(
                tmp_path, "CONFIGMEM,./first.csv", "CONFIGMEM,./second.csv"
            )

    def test_unknown_keyword_error_advertises_configmem(self, tmp_path: Path) -> None:
        with pytest.raises(InvalidTileDefinition, match="MATRIX, CONFIGMEM, and"):
            parse_single_tile(tmp_path, "CONFIGMEMORY,./mapping.csv")


class TestConfigMemWrapper:
    """`CONFIGMEM,<file>.v` wraps the generated ConfigMem, it does not replace it.

    FABulous still generates `<tile>_ConfigMem`. The named HDL supplies
    `<tile>_ConfigMem_wrapper`, which the tile instantiates in its place and
    which instantiates the generated module itself, so user logic can sit
    before or after the configuration bits. Extra wrapper ports are declared
    with `CONFIGMEM_PORT` rows and leave the tile as external ports.
    """

    def test_wrapper_ports_are_parsed_into_typed_ports(self, tmp_path: Path) -> None:
        """A CONFIGMEM_PORT row becomes a typed port on the tile's wrapper."""
        write_config_mem_hdl(tmp_path, ".v")
        tile = parse_single_tile(
            tmp_path,
            f"CONFIGMEM,./{TILE_NAME}_ConfigMem.v",
            "CONFIGMEM_PORT,crc_error,OUTPUT,1",
            matrix=MATRIX_WITH_TWO_CONFIG_BITS,
        )

        assert tile.config_mem_wrapper is not None
        assert tile.config_mem_wrapper.ports == (
            ConfigMemPort(name="crc_error", io=IO.OUTPUT, width=1),
        )

    def test_ports_are_kept_in_declaration_order(self, tmp_path: Path) -> None:
        """Order is the user's, because it is the wrapper's port order."""
        write_config_mem_hdl(tmp_path, ".v")
        tile = parse_single_tile(
            tmp_path,
            f"CONFIGMEM,./{TILE_NAME}_ConfigMem.v",
            "CONFIGMEM_PORT,scrub_en,INPUT,1",
            "CONFIGMEM_PORT,syndrome,OUTPUT,8",
            "CONFIGMEM_PORT,crc_error,OUTPUT,1",
            matrix=MATRIX_WITH_TWO_CONFIG_BITS,
        )

        assert tile.config_mem_wrapper is not None
        assert [p.name for p in tile.config_mem_wrapper.ports] == [
            "scrub_en",
            "syndrome",
            "crc_error",
        ]

    def test_a_tile_without_ports_has_an_empty_port_list(self, tmp_path: Path) -> None:
        """A bare wrapper is legal: it just wraps, adding no ports."""
        write_config_mem_hdl(tmp_path, ".v")
        tile = parse_single_tile(tmp_path, f"CONFIGMEM,./{TILE_NAME}_ConfigMem.v")

        assert tile.config_mem_wrapper is not None
        assert tile.config_mem_wrapper.ports == ()

    @pytest.mark.parametrize(
        "config_mem_row",
        [None, "CONFIGMEM,NULL", "CONFIGMEM,./mapping.csv"],
        ids=["no-configmem-line", "null", "mapping-csv"],
    )
    def test_ports_without_a_wrapper_are_rejected(
        self, tmp_path: Path, config_mem_row: str | None
    ) -> None:
        """`CONFIGMEM_PORT` describes a wrapper, so there has to be one."""
        rows = [] if config_mem_row is None else [config_mem_row]
        rows.append("CONFIGMEM_PORT,crc_error,OUTPUT,1")

        with pytest.raises(InvalidTileDefinition, match="no wrapper"):
            parse_single_tile(tmp_path, *rows)

    @pytest.mark.parametrize(
        ("row", "match"),
        [
            ("CONFIGMEM_PORT,crc_error,SIDEWAYS,1", "Give INPUT or OUTPUT"),
            ("CONFIGMEM_PORT,crc_error,OUTPUT,wide", "not an integer"),
            ("CONFIGMEM_PORT,crc_error,OUTPUT", "needs a name, a direction"),
            ("CONFIGMEM_PORT,crc_error", "needs a name, a direction"),
            ("CONFIGMEM_PORT,FrameData,INPUT,32", "collides with a standard"),
            ("CONFIGMEM_PORT,crc_error,OUTPUT,0", "at least one bit"),
        ],
        ids=[
            "bad-direction",
            "non-integer-width",
            "missing-width",
            "missing-direction",
            "standard-port-name",
            "zero-width",
        ],
    )
    def test_malformed_port_row_is_rejected(
        self, tmp_path: Path, row: str, match: str
    ) -> None:
        write_config_mem_hdl(tmp_path, ".v")

        with pytest.raises(InvalidTileDefinition, match=match):
            parse_single_tile(tmp_path, f"CONFIGMEM,./{TILE_NAME}_ConfigMem.v", row)

    def test_duplicate_port_names_are_rejected(self, tmp_path: Path) -> None:
        write_config_mem_hdl(tmp_path, ".v")

        with pytest.raises(InvalidTileDefinition, match="declared more than once"):
            parse_single_tile(
                tmp_path,
                f"CONFIGMEM,./{TILE_NAME}_ConfigMem.v",
                "CONFIGMEM_PORT,crc_error,OUTPUT,1",
                "CONFIGMEM_PORT,crc_error,OUTPUT,1",
            )


class TestConfigMemWrapperHdlIsChecked:
    """The wrapper file must be in the project's language and declare the module.

    FABulous never reads what the wrapper does, but two mistakes are cheap to
    catch from the file itself: handing a VHDL project a Verilog wrapper, and
    naming a file whose module is called something else. Left unchecked both
    surface as a synthesis error a long way from the tile CSV that caused them.
    """

    @pytest.mark.parametrize(
        ("suffix", "lang"),
        [
            (".vhd", "verilog"),
            (".vhdl", "verilog"),
            (".vhd", "system_verilog"),
            (".v", "vhdl"),
            (".sv", "vhdl"),
        ],
    )
    def test_a_wrapper_in_another_language_is_rejected(
        self, tmp_path: Path, monkeypatch: pytest.MonkeyPatch, suffix: str, lang: str
    ) -> None:
        monkeypatch.setenv("FAB_PROJ_LANG", lang)
        hdl = write_config_mem_hdl(tmp_path, suffix)

        with pytest.raises(InvalidTileDefinition, match="project language"):
            parse_single_tile(tmp_path, f"CONFIGMEM,./{hdl.name}")

    @pytest.mark.parametrize(
        ("suffix", "lang"),
        [(".v", "verilog"), (".vhd", "vhdl")],
        ids=["verilog", "vhdl"],
    )
    def test_a_file_missing_the_wrapper_module_is_rejected(
        self, tmp_path: Path, monkeypatch: pytest.MonkeyPatch, suffix: str, lang: str
    ) -> None:
        """The error names the module the tile is going to instantiate."""
        monkeypatch.setenv("FAB_PROJ_LANG", lang)
        hdl = write_config_mem_hdl(tmp_path, suffix, module="some_other_module")

        with pytest.raises(InvalidTileDefinition, match=wrapper_module_name(TILE_NAME)):
            parse_single_tile(tmp_path, f"CONFIGMEM,./{hdl.name}")

    @pytest.mark.parametrize(
        ("suffix", "lang", "source"),
        [
            (".v", "verilog", "// module {module};\n"),
            (".v", "verilog", "/* module {module};\nendmodule */\n"),
            (".vhd", "vhdl", "-- entity {module} is\n"),
        ],
        ids=["line-comment", "block-comment", "vhdl-comment"],
    )
    def test_a_commented_out_declaration_does_not_satisfy_the_check(
        self,
        tmp_path: Path,
        monkeypatch: pytest.MonkeyPatch,
        suffix: str,
        lang: str,
        source: str,
    ) -> None:
        monkeypatch.setenv("FAB_PROJ_LANG", lang)
        hdl = write_config_mem_hdl(tmp_path, suffix)
        hdl.write_text(source.format(module=wrapper_module_name(TILE_NAME)))

        with pytest.raises(InvalidTileDefinition, match=wrapper_module_name(TILE_NAME)):
            parse_single_tile(tmp_path, f"CONFIGMEM,./{hdl.name}")

    def test_a_vhdl_entity_matches_regardless_of_case(
        self, tmp_path: Path, monkeypatch: pytest.MonkeyPatch
    ) -> None:
        """VHDL identifiers are case-insensitive, so the check must be too."""
        monkeypatch.setenv("FAB_PROJ_LANG", "vhdl")
        hdl = write_config_mem_hdl(
            tmp_path, ".vhd", module=wrapper_module_name(TILE_NAME).upper()
        )

        tile = parse_single_tile(tmp_path, f"CONFIGMEM,./{hdl.name}")

        assert tile.config_mem_wrapper is not None

    def test_a_verilog_module_does_not_match_on_case_alone(
        self, tmp_path: Path, monkeypatch: pytest.MonkeyPatch
    ) -> None:
        """Verilog identifiers are case-sensitive, so a near miss is a miss."""
        monkeypatch.setenv("FAB_PROJ_LANG", "verilog")
        hdl = write_config_mem_hdl(
            tmp_path, ".v", module=wrapper_module_name(TILE_NAME).upper()
        )

        with pytest.raises(InvalidTileDefinition, match=wrapper_module_name(TILE_NAME)):
            parse_single_tile(tmp_path, f"CONFIGMEM,./{hdl.name}")


class TestConfigMemIsTileOnly:
    """`CONFIGMEM` is a tile-CSV keyword; a supertile cannot declare one."""

    @pytest.mark.parametrize(
        "row", ["CONFIGMEM,./wrapper.v", "CONFIGMEM_PORT,crc_error,OUTPUT,1"]
    )
    def test_config_mem_in_a_supertile_names_itself_in_the_error(
        self, tmp_path: Path, row: str
    ) -> None:
        """The error says CONFIGMEM, not the generic 'not tiles or Null'."""
        super_csv = tmp_path / "super.csv"
        super_csv.write_text(f"SuperTILE,DSP\n{row}\nLUT4AB\nEndSuperTILE\n")
        tile_dic = {TILE_NAME: make_empty_tile(TILE_NAME)}

        with pytest.raises(InvalidSupertileDefinition, match="CONFIGMEM"):
            parseSupertilesCSV(super_csv, tile_dic)

    def test_a_wrapped_tile_cannot_be_used_in_a_supertile(self, tmp_path: Path) -> None:
        """A subtile's wrapper ports have no path out of the supertile wrapper.

        The supertile wrapper module would have to declare and forward them,
        which it does not, so the fabric would reference ports that do not
        exist. Rejected by name rather than left to fail at synthesis.
        """
        hdl = tmp_path / "wrapper.v"
        hdl.write_text("")
        tile = make_empty_tile(TILE_NAME)
        tile.config_mem_wrapper = ConfigMemWrapper(hdl_file=hdl)
        super_csv = tmp_path / "super.csv"
        super_csv.write_text(f"SuperTILE,DSP\n{TILE_NAME}\nEndSuperTILE\n")

        with pytest.raises(InvalidSupertileDefinition, match=TILE_NAME):
            parseSupertilesCSV(super_csv, {TILE_NAME: tile})
