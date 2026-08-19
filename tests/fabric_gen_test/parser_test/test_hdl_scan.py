"""Tests for the lightweight scan of module declarations in an HDL file."""

from pathlib import Path

import pytest

from fabulous.fabric_definition.define import HDLType
from fabulous.fabric_generator.parser.hdl_scan import declared_modules, hdl_suffixes

VERILOG_TWO_MODULES = """
module Foo (input a, output b);
endmodule

module Bar;
endmodule
"""

VHDL_TWO_ENTITIES = """
entity Foo is
end entity Foo;

ENTITY Bar IS
END Bar;
"""


class TestDeclaredModules:
    """The scan reports what a file declares, without an HDL front end."""

    @pytest.mark.parametrize(
        ("suffix", "source", "expected"),
        [
            (".v", VERILOG_TWO_MODULES, {"Foo", "Bar"}),
            (".sv", VERILOG_TWO_MODULES, {"Foo", "Bar"}),
            (".vhd", VHDL_TWO_ENTITIES, {"foo", "bar"}),
            (".vhdl", VHDL_TWO_ENTITIES, {"foo", "bar"}),
        ],
        ids=["verilog", "system-verilog", "vhd", "vhdl"],
    )
    def test_every_declaration_is_found(
        self, tmp_path: Path, suffix: str, source: str, expected: set[str]
    ) -> None:
        """VHDL identifiers are case-insensitive, so they come back lowercased."""
        hdl = tmp_path / f"design{suffix}"
        hdl.write_text(source)

        assert declared_modules(hdl) == expected

    @pytest.mark.parametrize(
        ("suffix", "source"),
        [
            (".v", "// module Foo;\n"),
            (".v", "/* module Foo;\n   endmodule */\n"),
            (".sv", "/*\nmodule Foo;\nendmodule\n*/\n"),
            (".vhd", "-- entity Foo is\n"),
            (".vhdl", "  --entity Foo is\n"),
        ],
        ids=[
            "verilog-line-comment",
            "verilog-block-comment",
            "system-verilog-block-comment",
            "vhdl-comment",
            "vhdl-indented-comment",
        ],
    )
    def test_commented_out_declarations_do_not_count(
        self, tmp_path: Path, suffix: str, source: str
    ) -> None:
        """A commented-out module is not a module, or the check is worthless."""
        hdl = tmp_path / f"design{suffix}"
        hdl.write_text(source)

        assert declared_modules(hdl) == set()

    def test_an_empty_file_declares_nothing(self, tmp_path: Path) -> None:
        hdl = tmp_path / "design.v"
        hdl.write_text("")

        assert declared_modules(hdl) == set()

    def test_an_unknown_suffix_is_rejected(self, tmp_path: Path) -> None:
        """Guessing a language from an unknown suffix would silently pass."""
        hdl = tmp_path / "design.txt"
        hdl.write_text("module Foo;\nendmodule\n")

        with pytest.raises(ValueError, match="not an HDL file"):
            declared_modules(hdl)


class TestHdlSuffixes:
    """Which file suffixes a project language accepts."""

    @pytest.mark.parametrize(
        ("lang", "expected"),
        [
            (HDLType.VERILOG, {".v", ".sv"}),
            (HDLType.SYSTEM_VERILOG, {".v", ".sv"}),
            (HDLType.VHDL, {".vhd", ".vhdl"}),
        ],
    )
    def test_suffixes_per_language(self, lang: HDLType, expected: set[str]) -> None:
        """Matches what the models pack already accepts, aliases included."""
        assert set(hdl_suffixes(lang)) == expected
