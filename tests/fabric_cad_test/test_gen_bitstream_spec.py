"""Tests for bitstream specification generation.

Two layers of coverage:

* Unit tests for :func:`border_rows_have_config_bits`, the border-row detection
  that drives the ``IncludeBorderRows`` archspec flag.
* Integration tests that run the real generator on a fully generated demo fabric
  and assert the whole specification is internally consistent.
"""

import pytest

from fabulous.fabric_cad.gen_bitstream_spec import (
    border_rows_have_config_bits,
    generateBitstreamSpec,
)
from fabulous.fabric_definition.fabric import Fabric
from fabulous.fabulous_cli.fabulous_cli import FABulous_CLI
from tests.conftest import make_empty_tile, make_fabric_from_grid, run_cmd


def _fabric_from_bits(grid: list[list[int | None]]) -> Fabric:
    """Build a real Fabric from a grid of per-tile config-bit counts.

    Parameters
    ----------
    grid : list[list[int | None]]
        Per-tile ``globalConfigBits``; ``None`` marks an empty (NULL) cell.

    Returns
    -------
    Fabric
        A real Fabric whose tiles report the requested config-bit counts.
    """
    tile_grid: list[list[object]] = [
        [
            None if bits is None else make_empty_tile(f"T{y}_{x}", config_bits=bits)
            for x, bits in enumerate(row)
        ]
        for y, row in enumerate(grid)
    ]
    return make_fabric_from_grid(tile_grid)


@pytest.mark.parametrize(
    ("grid", "expected"),
    [
        ([[0, 0], [127, 127], [0, 0]], False),  # config only in interior row
        ([[127, 0], [127, 127], [0, 0]], True),  # top row has config
        ([[0, 0], [127, 127], [0, 127]], True),  # bottom row has config
        ([[5, 5], [0, 0], [5, 5]], True),  # both border rows have config
        ([[None, None], [127, 127], [None, None]], False),  # border rows all NULL
        ([[0, None], [127, 127], [None, 42]], True),  # NULL mixed with config
        ([[127, 127]], True),  # single row counts as both borders
        ([[0, 0]], False),  # single zero-config row
        ([[1]], True),  # single tile, single bit
        ([[0], [0], [0]], False),  # tall single-column, no config
    ],
)
def test_border_rows_have_config_bits(
    grid: list[list[int | None]], expected: bool
) -> None:
    """Border-row detection flags config bits in the top or bottom row only."""
    fabric = _fabric_from_bits(grid)
    assert border_rows_have_config_bits(fabric) is expected


def test_border_rows_have_config_bits_empty_fabric() -> None:
    """An empty tile grid reports no border config bits."""
    fabric = make_fabric_from_grid([])
    assert border_rows_have_config_bits(fabric) is False


def test_border_rows_have_config_bits_interior_ignored() -> None:
    """Config bits confined to interior rows never flip the flag on."""
    grid = [[0, 0, 0]] + [[127, 127, 127]] * 5 + [[0, 0, 0]]
    fabric = _fabric_from_bits(grid)
    assert border_rows_have_config_bits(fabric) is False


@pytest.fixture
def generated_fabric(cli: FABulous_CLI) -> Fabric:
    """Return the fully generated demo fabric bound to the CLI fixture."""
    run_cmd(cli, "gen_fabric")
    return cli.fabulousAPI.fabric


def _all_tile_locations(fabric: Fabric) -> set[str]:
    """Return every ``XxYy`` location string in the fabric grid."""
    return {f"X{x}Y{y}" for y, row in enumerate(fabric.tile) for x, _ in enumerate(row)}


def test_spec_is_internally_consistent(generated_fabric: Fabric) -> None:
    """The spec for a real fabric is complete and self-consistent."""
    fabric = generated_fabric
    spec = generateBitstreamSpec(fabric)

    arch = spec["ArchSpecs"]
    assert arch["FrameBitsPerRow"] == fabric.frameBitsPerRow
    assert arch["MaxFramesPerCol"] == fabric.maxFramesPerCol
    assert arch["FrameSelectWidth"] == fabric.frameSelectWidth
    assert arch["DesyncBit"] == fabric.desync_flag
    # the flag must mirror the detector on the actual fabric
    assert arch["IncludeBorderRows"] == border_rows_have_config_bits(fabric)

    # TileMap covers the whole grid; NULL cells are mapped but carry no specs
    assert set(spec["TileMap"]) == _all_tile_locations(fabric)
    for loc, name in spec["TileMap"].items():
        if name == "NULL":
            assert loc not in spec["TileSpecs"]
        else:
            assert loc in spec["TileSpecs"]
            assert loc in spec["TileSpecs_No_Mask"]
            # masked and unmasked views describe the same features
            assert set(spec["TileSpecs"][loc]) == set(spec["TileSpecs_No_Mask"][loc])

    # FrameMap is keyed by the names of every placed (non-NULL) tile
    grid_names = {t.name for row in fabric.tile for t in row if t is not None}
    assert set(spec["FrameMap"]) == grid_names

    # every config bit resolves to a real frame position (no unassigned -1 leaks)
    max_bit = fabric.frameBitsPerRow * fabric.maxFramesPerCol
    for loc, features in spec["TileSpecs"].items():
        for feature, bits in features.items():
            for bit_index in bits:
                assert 0 <= bit_index < max_bit, (
                    f"{loc}.{feature} maps to invalid frame bit {bit_index}"
                )


def test_border_rows_excluded_for_demo_fabric(generated_fabric: Fabric) -> None:
    """The demo fabric terminates top/bottom rows, so the flag stays off."""
    spec = generateBitstreamSpec(generated_fabric)
    assert spec["ArchSpecs"]["IncludeBorderRows"] is False


def test_config_tile_in_border_row_sets_flag(generated_fabric: Fabric) -> None:
    """Placing a config-bearing tile in the top row turns the flag on."""
    fabric = generated_fabric
    config_tile = next(
        tile
        for row in fabric.tile
        for tile in row
        if tile is not None and tile.globalConfigBits > 0
    )
    # replace a placed cell in the top border row with the config-bearing tile
    top_row = fabric.tile[0]
    target_x = next(x for x, tile in enumerate(top_row) if tile is not None)
    top_row[target_x] = config_tile

    spec = generateBitstreamSpec(fabric)

    assert spec["ArchSpecs"]["IncludeBorderRows"] is True
    assert f"X{target_x}Y0" in spec["TileSpecs"]
