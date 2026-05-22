"""Tests for the AutoAPI markdown-docstring normalizer in ``docs/source/_ext``."""

import sys
from pathlib import Path

import pytest

_EXT_DIR = Path(__file__).resolve().parents[2] / "docs" / "source" / "_ext"
if _EXT_DIR.as_posix() not in sys.path:
    sys.path.insert(0, _EXT_DIR.as_posix())

from docstring_renderer import normalize_docstring_for_rst  # noqa: E402


def _indent(line: str) -> int:
    return len(line) - len(line.lstrip(" "))


def test_inline_backtick_becomes_rest_literal() -> None:
    out = normalize_docstring_for_rst("Use `foo` and `bar` here.")
    assert "``foo``" in out
    assert "``bar``" in out


def test_existing_double_backticks_are_left_untouched() -> None:
    out = normalize_docstring_for_rst("Already ``literal`` text.")
    assert "``literal``" in out
    assert "````" not in out


@pytest.mark.parametrize(
    ("alias", "expected"),
    [("py", "python"), ("python", "python"), ("sv", "systemverilog"), ("sh", "shell")],
)
def test_fence_language_aliases_map_to_pygments_lexers(alias: str, expected: str) -> None:
    out = normalize_docstring_for_rst(f"```{alias}\nx = 1\n```\n")
    assert f".. code-block:: {expected}" in out


def test_fence_without_language_becomes_literal_block() -> None:
    out = normalize_docstring_for_rst("```\nplain text\n```\n")
    assert "::" in out
    assert ".. code-block::" not in out


def test_fenced_block_preserves_relative_indentation() -> None:
    """Nested code/YAML inside a fence must keep its structure, not be flattened."""
    doc = "Summary.\n\n```verilog\nmodule m (\n    a,\n    b);\n```\n"

    out = normalize_docstring_for_rst(doc)
    lines = out.splitlines()

    assert ".. code-block:: verilog" in out
    module_line = next(line for line in lines if "module m (" in line)
    nested_line = next(line for line in lines if line.strip() == "a,")
    # ``a,`` is indented four spaces under ``module m (`` in the source and must
    # stay four spaces deeper after conversion.
    assert _indent(nested_line) == _indent(module_line) + 4


def test_fenced_yaml_keeps_nesting() -> None:
    doc = "Config:\n\n```yaml\nX0Y0:\n  N: [pin1]\n```\n"

    out = normalize_docstring_for_rst(doc)
    lines = out.splitlines()

    parent = next(line for line in lines if line.strip() == "X0Y0:")
    child = next(line for line in lines if line.strip() == "N: [pin1]")
    assert _indent(child) == _indent(parent) + 2
