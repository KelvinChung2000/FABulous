"""Configuration-memory source description for a tile or supertile.

A tile's configuration memory is described by a `<tile>_ConfigMem.csv` mapping
file that records which configuration bit lands in which frame and bit position.
That mapping is the contract between the generated RTL and the bitstream, so
every consumer must agree on where it lives — hence this object, which owns the
location and nothing else.

A tile CSV may override that location with a `CONFIGMEM,<path>.csv` line, or
state that the tile has no configuration memory at all with `CONFIGMEM,NULL`.
The latter is recorded as `mapping_csv is None` — the spec object always exists,
so consumers ask it rather than guessing from a missing file.

A `CONFIGMEM,<path>.v` line names hand-written HDL instead: the user's file
provides `<tile>_ConfigMem` and FABulous generates no RTL for that tile, exactly
as a hand-written `MATRIX` file suppresses switch-matrix generation. The mapping
CSV is unaffected by that choice — it stays the bitstream's contract either
way — so the two fields are independent.

Unlike `SwitchMatrix`, this class has no eager `from_file`: the mapping file is
optional and generated on demand (`generateConfigMem` writes a default
enumerated mapping when the file is absent), so the location is recorded here
and reading is left to `fabulous.fabric_generator.parser.parse_configmem`.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

from loguru import logger

if TYPE_CHECKING:
    from pathlib import Path


@dataclass(frozen=True)
class ConfigMemSpec:
    """Where a tile's configuration-memory mapping is described.

    Attributes
    ----------
    mapping_csv : Path | None
        The tile's `<tile>_ConfigMem.csv` frame-to-bit mapping file. The file
        need not exist yet: `generateConfigMem` writes a default enumerated
        mapping there when it is missing. `None` means the tile has no
        configuration memory at all, which a tile CSV states as
        `CONFIGMEM,NULL`.
    hdl_file : Path | None
        Hand-written HDL providing `<tile>_ConfigMem`, which a tile CSV states
        as `CONFIGMEM,<file>.v` (or `.sv`/`.vhd`/`.vhdl`). When set, FABulous
        generates no ConfigMem RTL for the tile and the file must already
        exist. `None` means FABulous generates the module, which is the
        default.
    """

    mapping_csv: Path | None
    hdl_file: Path | None = None

    @classmethod
    def by_convention(cls, tile_name: str, tile_dir: Path) -> ConfigMemSpec:
        """Return the spec for the conventional mapping-file location.

        The mapping file sits next to the tile's own CSV and is named after the
        tile.

        Parameters
        ----------
        tile_name : str
            Name of the tile or supertile.
        tile_dir : Path
            The tile's CSV file path (`Tile.tileDir` / `SuperTile.tileDir`),
            which is a file, not a directory.

        Returns
        -------
        ConfigMemSpec
            Spec pointing at `<tile_dir>.parent/<tile_name>_ConfigMem.csv`.
        """
        return cls(mapping_csv=tile_dir.parent / f"{tile_name}_ConfigMem.csv")


def resolve_config_mem_spec(
    tile_name: str,
    tile_dir: Path,
    proj_dir: Path,
    switch_matrix_file: Path | None = None,
) -> ConfigMemSpec:
    """Locate a tile's configuration-memory mapping CSV.

    For a modern project layout (`Tile/<tile>/<tile>.csv`) the mapping file sits
    next to the tile CSV. In the legacy layout the tile is declared inline in
    `fabric.csv`, so `tile_dir` points at `fabric.csv` and carries no
    information about where the tile actually lives; the switch-matrix file path
    is used instead, falling back to `<proj_dir>/Tile/<tile>/` when that path is
    not a real file.

    Parameters
    ----------
    tile_name : str
        Name of the tile or supertile.
    tile_dir : Path
        The tile's CSV file path (`Tile.tileDir`), which is a file, not a
        directory.
    proj_dir : Path
        Project root, used only by the legacy-layout fallback.
    switch_matrix_file : Path | None, optional
        The tile's switch-matrix file (`SwitchMatrix.matrix_file`), used only by
        the legacy layout to recover the tile's real directory.

    Returns
    -------
    ConfigMemSpec
        Spec pointing at the tile's `<tile>_ConfigMem.csv`.
    """
    if "fabric.csv" not in str(tile_dir):
        return ConfigMemSpec.by_convention(tile_name, tile_dir)

    # Backward compat: in the old fabric.csv-embedded layout the tile's real
    # location comes from its switch-matrix file path.
    if switch_matrix_file is not None and switch_matrix_file.is_file():
        return ConfigMemSpec.by_convention(tile_name, switch_matrix_file)

    mapping_csv = proj_dir / "Tile" / tile_name / f"{tile_name}_ConfigMem.csv"
    logger.warning(
        f"MatrixDir for {tile_name} is not a valid file or directory. "
        f"Assuming default path: {mapping_csv}"
    )
    return ConfigMemSpec(mapping_csv=mapping_csv)
