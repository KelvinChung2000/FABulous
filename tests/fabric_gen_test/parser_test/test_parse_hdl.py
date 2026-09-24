"""Tests for parsing BEL HDL files."""

import shutil
from collections.abc import Callable
from pathlib import Path

import pytest

from fabulous.custom_exception import InvalidBelDefinition
from fabulous.fabric_definition.define import FABulousAttribute, HDLType, Status
from fabulous.fabric_generator.parser.parse_hdl import parseBelFile
from fabulous.fabulous_settings import get_context, init_context


def write_bel(
    directory: Path,
    lang: HDLType,
    *,
    bel_map: bool,
    markers: tuple[FABulousAttribute, ...],
) -> Path:
    """Write a one-port BEL, optionally with a one-bit BelMap and status markers."""
    if lang is HDLType.VERILOG:
        attributes = ["FABulous", *markers]
        if bel_map:
            attributes += ["BelMap", "INIT=0"]
        config_port = ", input wire [0:0] ConfigBits" if bel_map else ""
        bel = directory / "dep_bel.v"
        bel.write_text(
            f"(* {', '.join(attributes)} *)\n"
            f"module dep_bel (input wire I, output wire O{config_port});\n"
            "  assign O = I;\n"
            "endmodule\n"
        )
        return bel

    specs = ['attribute FABulous of dep_bel : entity is "TRUE";']
    specs += [
        f'attribute {marker} of dep_bel : entity is "TRUE";' for marker in markers
    ]
    if bel_map:
        specs += [
            'attribute BelMap of dep_bel : entity is "TRUE";',
            "attribute INIT of dep_bel : entity is 0;",
        ]
    config_port = (
        ";\n    ConfigBits : in std_logic_vector(0 downto 0)" if bel_map else ""
    )
    spec_block = "".join(f"  {spec}\n" for spec in specs)
    bel = directory / "dep_bel.vhdl"
    bel.write_text(
        "package dep_bel_attrs is\n"
        "  attribute FABulous : string;\n"
        "  attribute DEPRECATED : string;\n"
        "  attribute EXPERIMENTAL : string;\n"
        "  attribute BelMap : string;\n"
        "  attribute INIT : integer;\n"
        "end package dep_bel_attrs;\n"
        "library IEEE;\n"
        "use IEEE.STD_LOGIC_1164.all;\n"
        "use work.dep_bel_attrs.all;\n"
        "entity dep_bel is\n"
        "  port (\n"
        "    I : in std_logic;\n"
        f"    O : out std_logic{config_port}\n"
        "  );\n"
        f"{spec_block}"
        "end entity dep_bel;\n"
        "architecture rtl of dep_bel is\n"
        "begin\n"
        "  O <= I;\n"
        "end architecture rtl;\n"
    )
    return bel


@pytest.fixture(params=[HDLType.VERILOG, HDLType.VHDL], ids=["verilog", "vhdl"])
def bel_lang(
    request: pytest.FixtureRequest, project_factory: Callable[..., Path]
) -> HDLType:
    """Initialise a project in each HDL, skipping when its toolchain is absent."""
    lang: HDLType = request.param
    init_context(project_factory(lang=lang))
    tools = [get_context().yosys_path]
    if lang is HDLType.VHDL:
        tools.append(get_context().ghdl_path)
    for tool in tools:
        if shutil.which(str(tool)) is None:
            pytest.skip(f"{tool} not on PATH; BEL parsing needs the Nix toolchain")
    return lang


STATUS_CASES = [
    pytest.param((FABulousAttribute.DEPRECATED,), Status.DEPRECATED, id="deprecated"),
    pytest.param(
        (FABulousAttribute.EXPERIMENTAL,), Status.EXPERIMENTAL, id="experimental"
    ),
    pytest.param((), Status.STABLE, id="stable"),
]


@pytest.mark.parametrize("bel_map", [True, False], ids=["belmap", "no_belmap"])
@pytest.mark.parametrize(("markers", "status"), STATUS_CASES)
def test_status_attribute_sets_status(
    tmp_path: Path,
    bel_lang: HDLType,
    bel_map: bool,
    markers: tuple[FABulousAttribute, ...],
    status: Status,
) -> None:
    bel_file = write_bel(tmp_path, bel_lang, bel_map=bel_map, markers=markers)

    bel = parseBelFile(bel_file)

    assert bel.status is status
    assert bel.configBit == int(bel_map)


@pytest.mark.parametrize(("markers", "status"), STATUS_CASES)
def test_non_stable_bel_logs_warning(
    tmp_path: Path,
    bel_lang: HDLType,
    markers: tuple[FABulousAttribute, ...],
    status: Status,
    caplog: pytest.LogCaptureFixture,
) -> None:
    bel_file = write_bel(tmp_path, bel_lang, bel_map=True, markers=markers)

    parseBelFile(bel_file)

    warned = [
        r
        for r in caplog.records
        if r.levelname == "WARNING" and status in r.getMessage()
    ]
    assert len(warned) == int(status is not Status.STABLE)
    assert all(str(bel_file) in r.getMessage() for r in warned)


@pytest.mark.parametrize("bel_map", [True, False], ids=["belmap", "no_belmap"])
def test_both_status_attributes_raise(
    tmp_path: Path, bel_lang: HDLType, bel_map: bool
) -> None:
    markers = (FABulousAttribute.DEPRECATED, FABulousAttribute.EXPERIMENTAL)
    bel_file = write_bel(tmp_path, bel_lang, bel_map=bel_map, markers=markers)

    with pytest.raises(InvalidBelDefinition, match="both"):
        parseBelFile(bel_file)
