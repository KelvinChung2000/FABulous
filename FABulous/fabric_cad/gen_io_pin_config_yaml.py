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


def _serialize_supertile_ports(
    super_tile: SuperTile, prefix: str = ""
) -> dict[str, dict[str, list[dict]]]:
    """Serialize SuperTile ports, processing only the perimeter (external) sides.

    Parameters
    ----------
    super_tile : SuperTile
        The SuperTile to serialize
    prefix : str
        Prefix to add to port names

    Returns
    -------
    dict[str, dict[str, list[dict]]]
        Dictionary mapping coordinate keys "X#Y#" to side configuration dictionaries
    """
    config_payload: dict[str, dict[str, list[dict]]] = {}
    ports_around = super_tile.getPortsAroundTile()

    for coord_key, port_lists in ports_around.items():
        if not port_lists:
            continue

        x, y = coord_key.split(",")
        tile_key = f"X{x}Y{y}"
        config_payload[tile_key] = {"N": [], "E": [], "S": [], "W": []}

        # Get the actual tile to access its pin order config and bels
        tile = super_tile.tileMap[int(y)][int(x)]
        if tile is None:
            continue

        # Process each port list (each represents one side that's on the perimeter)
        tile_prefix = f"Tile_{tile_key}_{prefix}"
        for port_list in port_lists:
            if not port_list:
                continue

            # Determine which side this port list belongs to based on the first
            # port's sideOfTile
            side = port_list[0].sideOfTile
            side_key = side.value[0]  # Get "N", "E", "S", or "W"

            # Process ports for this side
            for port in port_list:
                if regex := port.getPortRegex(indexed=True, prefix=tile_prefix):
                    config_payload[tile_key][side_key].append(
                        tile.pinOrderConfig[side]([regex]).to_dict()
                    )

            # Add additional config pins based on side
            if side == Side.NORTH:
                config_payload[tile_key][side_key].append(
                    PinOrderConfig()([f"{tile_prefix}UserCLKo"]).to_dict()
                )
                config_payload[tile_key][side_key].append(
                    PinOrderConfig()([rf"{tile_prefix}FrameStrobe_O\[\d+\]"]).to_dict()
                )
            elif side == Side.EAST:
                config_payload[tile_key][side_key].append(
                    PinOrderConfig()([rf"{tile_prefix}FrameData_O\[\d+\]"]).to_dict()
                )
            elif side == Side.SOUTH:
                config_payload[tile_key][side_key].append(
                    PinOrderConfig()([f"{tile_prefix}UserCLK"]).to_dict()
                )
                config_payload[tile_key][side_key].append(
                    PinOrderConfig()([rf"{tile_prefix}FrameStrobe\[\d+\]"]).to_dict()
                )
            elif side == Side.WEST:
                config_payload[tile_key][side_key].append(
                    PinOrderConfig()([rf"{tile_prefix}FrameData\[\d+\]"]).to_dict()
                )

        # Add BEL external ports (only for tiles that have them)
        if tile.bels:
            for bel in tile.bels:
                pin_regexes = [
                    f"{prefix}{name}" for name in bel.externalInput + bel.externalOutput
                ]
                if pin_regexes:
                    # Add BEL ports to south side (following the original pattern)
                    config_payload[tile_key]["S"].append(
                        tile.pinOrderConfig[Side.SOUTH](pin_regexes).to_dict()
                    )

    return config_payload


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
        config_payload = _serialize_supertile_ports(tile_or_super_tile, prefix)
    else:
        config_payload = {"X0Y0": _serialize_tile_ports(tile_or_super_tile, prefix)}

    if not config_payload:
        config_payload["X0Y0"] = {"N": [], "E": [], "S": [], "W": []}

    with outfile.open("w") as file_descriptor:
        yaml.dump(config_payload, file_descriptor)
