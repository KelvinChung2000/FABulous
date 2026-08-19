"""User-supplied wrapper around a tile's generated configuration memory.

FABulous always generates `<tile>_ConfigMem`, the frame-latch array that turns
frame data into configuration bits. A tile CSV may additionally name an HDL
file and a module inside it with `CONFIGMEM,<file>.v,<module>`; the tile
instantiates that module in place of the generated one, and the module
instantiates the generated one itself. Everything the wrapper does around that
instance -- checking a frame before it is latched, scrubbing configuration bits
after -- is the user's, and FABulous does not constrain it, down to what the
module is called.

The wrapper's extra ports are declared in the tile CSV with `CONFIGMEM_PORT`
rows rather than read from the HDL. The file itself is scanned only far enough
to confirm it is in the project language and declares the named module; a
wrapper instantiates the not-yet-generated `<tile>_ConfigMem`, so it cannot be
elaborated while the fabric is still being parsed. The declaration and the
port list of the HDL can therefore still disagree, and that mismatch surfaces
at synthesis, not at parse time.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from enum import Enum, auto
from typing import TYPE_CHECKING

from loguru import logger

from fabulous.fabric_definition.define import IO

if TYPE_CHECKING:
    from pathlib import Path

# An HDL identifier: what a wrapper module may be called in both Verilog and
# VHDL. Checked so a path or a stray CSV field is rejected where it is written.
MODULE_NAME = re.compile(r"[A-Za-z_][A-Za-z0-9_]*\Z")

# The ports every ConfigMem exposes. A wrapper stands in for the generated
# module, so it must expose these too and may not redeclare them as extras.
CONFIG_MEM_STANDARD_PORTS = frozenset(
    {"FrameData", "FrameStrobe", "ConfigBits", "ConfigBits_N"}
)

# Connected to the tile's clock instead of becoming an external port, matching
# how a BEL's UserCLK port is treated.
USER_CLK_PORT = "UserCLK"


@dataclass(frozen=True)
class ConfigMemPort:
    """An extra port on a tile's ConfigMem wrapper.

    Attributes
    ----------
    name : str
        Port name, as written in the wrapper's HDL.
    io : IO
        Port direction.
    width : int
        Port width in bits; 1 for a scalar.
    """

    name: str
    io: IO
    width: int

    def __post_init__(self) -> None:
        """Reject ports that cannot be wired.

        Raises
        ------
        ValueError
            If the name is empty, the name collides with a standard ConfigMem
            port, or the width is not positive.
        """
        if not self.name:
            raise ValueError("CONFIGMEM_PORT has an empty port name.")
        if self.name in CONFIG_MEM_STANDARD_PORTS:
            raise ValueError(
                f"CONFIGMEM_PORT {self.name!r} collides with a standard ConfigMem "
                f"port. FABulous wires {', '.join(sorted(CONFIG_MEM_STANDARD_PORTS))} "
                "itself; declare only the wrapper's extra ports."
            )
        if self.width < 1:
            raise ValueError(
                f"CONFIGMEM_PORT {self.name!r} has width {self.width}. "
                "A port is at least one bit wide."
            )
        if self.io not in (IO.INPUT, IO.OUTPUT):
            raise ValueError(
                f"CONFIGMEM_PORT {self.name!r} has direction {self.io.name}. "
                "A wrapper port is INPUT or OUTPUT."
            )
        if self.name == USER_CLK_PORT and (self.io is not IO.INPUT or self.width != 1):
            raise ValueError(
                f"CONFIGMEM_PORT {USER_CLK_PORT} is bound to the tile's clock, "
                f"so it must be declared INPUT with width 1, not "
                f"{self.io.name} with width {self.width}."
            )


@dataclass(frozen=True)
class ConfigMemWrapper:
    """A tile's hand-written wrapper around its generated ConfigMem.

    Attributes
    ----------
    hdl_file : Path
        The file supplying the wrapper. It must exist: nothing generates it on
        demand.
    module : str
        The module the tile instantiates. Named by the user, so it carries no
        convention FABulous can reconstruct.
    ports : tuple[ConfigMemPort, ...]
        Extra ports beyond the standard ConfigMem four, in declaration order.
    """

    hdl_file: Path
    module: str
    ports: tuple[ConfigMemPort, ...] = ()

    def __post_init__(self) -> None:
        """Reject a wrapper that cannot be instantiated or wired.

        Raises
        ------
        ValueError
            If the module name is not an HDL identifier, or two ports share a
            name.
        """
        if not MODULE_NAME.match(self.module):
            raise ValueError(
                f"CONFIGMEM module name {self.module!r} is not an HDL "
                "identifier. Give the name of the module the tile is to "
                "instantiate, as CONFIGMEM,<file>,<module>."
            )

        seen: set[str] = set()
        for port in self.ports:
            if port.name in seen:
                raise ValueError(
                    f"CONFIGMEM_PORT {port.name!r} is declared more than once."
                )
            seen.add(port.name)

    @property
    def wants_user_clk(self) -> bool:
        """Whether the wrapper takes the tile's clock."""
        return any(p.name == USER_CLK_PORT for p in self.ports)

    @property
    def external_ports(self) -> tuple[ConfigMemPort, ...]:
        """The ports that leave the tile, i.e. everything but `UserCLK`."""
        return tuple(p for p in self.ports if p.name != USER_CLK_PORT)


def conventional_config_mem_csv(tile_name: str, tile_dir: Path) -> Path:
    """Return the conventional mapping-file location for a tile.

    The mapping file sits next to the tile's own CSV and is named after the
    tile.

    Parameters
    ----------
    tile_name : str
        Name of the tile or supertile.
    tile_dir : Path
        The tile's CSV file path (`Tile.tileDir`), which is a file, not a
        directory.

    Returns
    -------
    Path
        `<tile_dir>.parent/<tile_name>_ConfigMem.csv`.
    """
    return tile_dir.parent / f"{tile_name}_ConfigMem.csv"


class ConfigMemMode(Enum):
    """What a tile CSV's `CONFIGMEM` line declares."""

    NULL = auto()
    """`CONFIGMEM,NULL`: the tile has no configuration memory."""

    MAPPING = auto()
    """`CONFIGMEM,<file>.csv`: the mapping file lives somewhere else."""

    WRAPPER = auto()
    """`CONFIGMEM,<file>,<module>`: the tile wraps its generated ConfigMem."""


def resolve_config_mem_csv(
    tile_name: str,
    tile_dir: Path,
    proj_dir: Path,
    switch_matrix_file: Path | None = None,
) -> Path:
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
    Path
        The tile's `<tile_name>_ConfigMem.csv`.
    """
    if tile_dir.name != "fabric.csv":
        return conventional_config_mem_csv(tile_name, tile_dir)

    # Backward compat: in the old fabric.csv-embedded layout the tile's real
    # location comes from its switch-matrix file path.
    if switch_matrix_file is not None and switch_matrix_file.is_file():
        return conventional_config_mem_csv(tile_name, switch_matrix_file)

    mapping_csv = proj_dir / "Tile" / tile_name / f"{tile_name}_ConfigMem.csv"
    logger.warning(
        f"MatrixDir for {tile_name} is not a valid file or directory. "
        f"Assuming default path: {mapping_csv}"
    )
    return mapping_csv
