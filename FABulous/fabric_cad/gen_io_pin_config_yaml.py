"""Utilities for emitting I/O pin ordering configuration files."""

from dataclasses import dataclass, field
from pathlib import Path
from typing import Self

import yaml

from FABulous.fabric_definition.define import PinSortMode, Side
from FABulous.fabric_definition.SuperTile import SuperTile
from FABulous.fabric_definition.Tile import Tile


@dataclass
class PinOrderConfig:
    """Container describing pin ordering constraints for a segment."""

    min_distance: int | None = None
    max_distance: int | None = None
    pins: list[str] = field(default_factory=list)
    sort_mode: PinSortMode = PinSortMode.BUS_MAJOR
    reverse_result: bool = False

    def __call__(self, pins: list[str]) -> Self:
        """Bind a concrete pin list to this configuration instance."""
        self.pins = pins
        return self

    def to_dict(self) -> dict:
        """Return a serialisable dictionary representation."""
        pins = list(getattr(self, "pins", []) or [])
        return {
            "min_distance": self.min_distance,
            "max_distance": self.max_distance,
            "pins": pins,
            "sort_mode": str(self.sort_mode),
            "reverse_result": self.reverse_result,
        }


def _serialize_tile_ports(tile: Tile, prefix: str = "") -> dict[str, list[dict]]:
    port_dict = {"N": [], "E": [], "S": [], "W": []}

    for port in tile.getNorthSidePorts():
        if regex := port.getPortRegex(indexed=True, prefix=prefix):
            port_dict["N"].append(tile.pinOrderConfig[Side.NORTH]([regex]).to_dict())
    port_dict["N"].append(PinOrderConfig()([f"{prefix}UserCLKo"]).to_dict())
    port_dict["N"].append(
        PinOrderConfig()([rf"{prefix}FrameStrobe_O\[\d+\]"]).to_dict()
    )

    for port in tile.getEastSidePorts():
        if regex := port.getPortRegex(indexed=True, prefix=prefix):
            port_dict["E"].append(tile.pinOrderConfig[Side.EAST]([regex]).to_dict())
    port_dict["E"].append(PinOrderConfig()([rf"{prefix}FrameData_O\[\d+\]"]).to_dict())

    for port in tile.getSouthSidePorts():
        if regex := port.getPortRegex(indexed=True, prefix=prefix):
            port_dict["S"].append(tile.pinOrderConfig[Side.SOUTH]([regex]).to_dict())
    port_dict["S"].append(PinOrderConfig()([f"{prefix}UserCLK"]).to_dict())
    port_dict["S"].append(PinOrderConfig()([rf"{prefix}FrameStrobe\[\d+\]"]).to_dict())

    for port in tile.getWestSidePorts():
        if regex := port.getPortRegex(indexed=True, prefix=prefix):
            port_dict["W"].append(tile.pinOrderConfig[Side.WEST]([regex]).to_dict())
    port_dict["W"].append(PinOrderConfig()([rf"{prefix}FrameData\[\d+\]"]).to_dict())

    for bel in tile.bels:
        pin_regexes = [
            f"{prefix}{name}" for name in bel.externalInput + bel.externalOutput
        ]
        if pin_regexes:
            port_dict["S"].append(
                tile.pinOrderConfig[Side.SOUTH](pin_regexes).to_dict()
            )

    return port_dict


def generate_IO_pin_order_config(
    tile_or_super_tile: Tile | SuperTile,
    outfile: Path,
    prefix: str = "",
) -> None:
    """Generate I/O pin order configuration for a tile or super tile.

    The resulting YAML maps coordinate keys of the form ``X#Y#`` to side
    configuration dictionaries. Coordinates are enumerated from the top-left
    corner (``X0Y0``).
    """
    if isinstance(tile_or_super_tile, SuperTile):
        config_payload: dict[str, dict[str, list[dict]]] = {}
        for y, row in enumerate(tile_or_super_tile.tileMap):
            for x, sub_tile in enumerate(row):
                if sub_tile is None:
                    continue
                config_payload[f"X{x}Y{y}"] = _serialize_tile_ports(sub_tile, prefix)
    else:
        config_payload = {"X0Y0": _serialize_tile_ports(tile_or_super_tile, prefix)}

    if not config_payload:
        config_payload["X0Y0"] = {"N": [], "E": [], "S": [], "W": []}

    with outfile.open("w") as file_descriptor:
        yaml.dump(config_payload, file_descriptor)
