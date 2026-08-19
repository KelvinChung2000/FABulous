"""Lightweight scan of an HDL file for the modules it declares.

A regex scan, not a front end. Yosys and GHDL elaborate a design, which needs
every module it instantiates to exist; this runs while the fabric is still
being parsed, before anything is generated, so elaboration is not an option.
What it buys is the cheap half of the check: whether a file declares the module
a caller is about to reference by name.
"""

from __future__ import annotations

import re
from typing import TYPE_CHECKING

from fabulous.fabric_definition.define import HDLType

if TYPE_CHECKING:
    from pathlib import Path

VERILOG_SUFFIXES = frozenset({".v", ".sv"})
VHDL_SUFFIXES = frozenset({".vhd", ".vhdl"})
HDL_SUFFIXES = VERILOG_SUFFIXES | VHDL_SUFFIXES


def hdl_suffixes(lang: HDLType) -> frozenset[str]:
    """Return the file suffixes a project language accepts.

    A Verilog project accepts SystemVerilog too, matching what the models pack
    already allows.

    Parameters
    ----------
    lang : HDLType
        The project language.

    Returns
    -------
    frozenset[str]
        The accepted suffixes, leading dot included.
    """
    if lang is HDLType.VHDL:
        return VHDL_SUFFIXES
    return VERILOG_SUFFIXES


def declared_modules(hdl_file: Path) -> set[str]:
    """Return the names of the modules an HDL file declares.

    Declarations inside comments do not count. VHDL identifiers are
    case-insensitive, so VHDL entity names come back lowercased; Verilog names
    come back as written.

    Parameters
    ----------
    hdl_file : Path
        The file to scan. Its suffix decides how it is read.

    Raises
    ------
    ValueError
        If the suffix belongs to no supported HDL.

    Returns
    -------
    set[str]
        Every declared module or entity name.
    """
    suffix = hdl_file.suffix
    content = hdl_file.read_text()

    if suffix in VERILOG_SUFFIXES:
        content = re.sub(r"/\*.*?\*/", "", content, flags=re.DOTALL)
        content = re.sub(r"//[^\n]*", "", content)
        return set(re.findall(r"^\s*module\s+(\w+)", content, re.MULTILINE))

    if suffix in VHDL_SUFFIXES:
        content = re.sub(r"--[^\n]*", "", content)
        return {
            match.lower()
            for match in re.findall(
                r"^\s*entity\s+(\w+)\s+is", content, re.MULTILINE | re.IGNORECASE
            )
        }

    raise ValueError(
        f"{hdl_file} is not an HDL file: {suffix!r} is none of "
        f"{', '.join(sorted(HDL_SUFFIXES))}."
    )
