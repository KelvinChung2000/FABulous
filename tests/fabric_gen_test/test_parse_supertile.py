"""Tests for `parseSupertilesCSV` tileMap normalization.

A supertile CSV lists one row of tile names per grid row, and `parseSupertilesCSV`
strips empty cells, so rows with different tile counts (or trailing empty cells)
would yield a _ragged_ `tileMap`. Downstream generation indexes neighbours
assuming a rectangular grid, so the parser pads every row to a common width with
`None`. These tests pin that the model handed out is always rectangular.
"""

from pathlib import Path

from fabulous.fabric_generator.parser.parse_csv import parseSupertilesCSV
from tests.fabric_definition.conftest import make_empty_tile


def _write_supertile_csv(tmp_path: Path, body: str) -> Path:
    """Write a `SuperTILE`/`EndSuperTILE` block to a CSV file and return its path."""
    path = tmp_path / "supertile.csv"
    path.write_text(body)
    return path


def test_jagged_rows_are_padded_to_rectangle(tmp_path: Path) -> None:
    # Row 0 has 3 tiles, row 1 has 1 tile: a ragged layout once empties are
    # stripped. The parser must pad row 1 with None to match row 0's width.
    tileDic = {name: make_empty_tile(name) for name in ("A", "B", "C", "D")}
    csv = _write_supertile_csv(
        tmp_path,
        "SuperTILE,JAG,,,,\nA,B,C,,\nD,,,,\nEndSuperTILE,,,,\n",
    )

    (st,) = parseSupertilesCSV(csv, tileDic)

    # Every row is the same length (rectangular bounding box).
    assert {len(row) for row in st.tileMap} == {3}
    # Real tiles keep their position; the stripped trailing cells become holes.
    assert [t.name if t else None for t in st.tileMap[0]] == ["A", "B", "C"]
    assert [t.name if t else None for t in st.tileMap[1]] == ["D", None, None]

    # The rectangular model is now safe for the neighbour-indexing query that
    # raised IndexError on a ragged tileMap (issue #875 follow-up).
    assert st.getPortsAroundTile()


def test_explicit_null_holes_survive_normalization(tmp_path: Path) -> None:
    # Interior `Null` holes must stay holes, and a short trailing row is still
    # padded so both rows match width.
    tileDic = {name: make_empty_tile(name) for name in ("A", "B")}
    csv = _write_supertile_csv(
        tmp_path,
        "SuperTILE,RING,,,\nA,Null,B,,\nA,,,,\nEndSuperTILE,,,\n",
    )

    (st,) = parseSupertilesCSV(csv, tileDic)

    assert {len(row) for row in st.tileMap} == {3}
    assert [t.name if t else None for t in st.tileMap[0]] == ["A", None, "B"]
    assert [t.name if t else None for t in st.tileMap[1]] == ["A", None, None]
