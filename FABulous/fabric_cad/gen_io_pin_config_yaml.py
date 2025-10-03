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


def _serialize_tile_ports(
    tile: Tile, prefix: str = "", external_port_side: Side = Side.SOUTH
) -> dict[str, list[dict]]:
    # Use string keys for sides (Side.name) so YAML emits plain string keys
    port_dict = {
        Side.NORTH.name: [],
        Side.EAST.name: [],
        Side.SOUTH.name: [],
        Side.WEST.name: [],
    }

    for port in tile.getNorthSidePorts():
        if regex := port.getPortRegex(indexed=True, prefix=prefix):
            port_dict[Side.NORTH.name].append(
                tile.pinOrderConfig[Side.NORTH]([regex]).to_dict()
            )
    port_dict[Side.NORTH.name].append(PinOrderConfig()([f"{prefix}UserCLKo"]).to_dict())
    port_dict[Side.NORTH.name].append(
        PinOrderConfig()([rf"{prefix}FrameStrobe_O\[\d+\]"]).to_dict()
    )

    for port in tile.getEastSidePorts():
        if regex := port.getPortRegex(indexed=True, prefix=prefix):
            port_dict[Side.EAST.name].append(
                tile.pinOrderConfig[Side.EAST]([regex]).to_dict()
            )
    port_dict[Side.EAST.name].append(
        PinOrderConfig()([rf"{prefix}FrameData_O\[\d+\]"]).to_dict()
    )

    for port in tile.getSouthSidePorts():
        if regex := port.getPortRegex(indexed=True, prefix=prefix):
            port_dict[Side.SOUTH.name].append(
                tile.pinOrderConfig[Side.SOUTH]([regex]).to_dict()
            )
    port_dict[Side.SOUTH.name].append(PinOrderConfig()([f"{prefix}UserCLK"]).to_dict())
    port_dict[Side.SOUTH.name].append(
        PinOrderConfig()([rf"{prefix}FrameStrobe\[\d+\]"]).to_dict()
    )

    for port in tile.getWestSidePorts():
        if regex := port.getPortRegex(indexed=True, prefix=prefix):
            port_dict[Side.WEST.name].append(
                tile.pinOrderConfig[Side.WEST]([regex]).to_dict()
            )
    port_dict[Side.WEST.name].append(
        PinOrderConfig()([rf"{prefix}FrameData\[\d+\]"]).to_dict()
    )

    # Place BEL external ports on the specified side (string key)
    for bel in tile.bels:
        pin_regexes = [
            f"{prefix}{name}" for name in bel.externalInput + bel.externalOutput
        ]
        if pin_regexes:
            port_dict[external_port_side.name].append(
                tile.pinOrderConfig[external_port_side](pin_regexes).to_dict()
            )

    return port_dict


def _serialize_supertile_ports(
    super_tile: SuperTile,
    prefix: str = "",
    external_port_sides: dict[tuple[int, int], Side] | None = None,
) -> dict[str, dict[str, list[dict]]]:
    """Serialize SuperTile ports, processing only the perimeter (external) sides.

    Parameters
    ----------
    super_tile : SuperTile
        The SuperTile to serialize
    prefix : str
        Prefix to add to port names
    external_port_sides : dict[tuple[int, int], Side] | None
        Mapping from tile coordinates (x, y) to the side where external BEL ports
        should be placed. If None or if a coordinate is not in the dict, defaults to
        using the perimeter side(s) of that tile.

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
        # Use string keys for sides here
        config_payload[tile_key] = {
            Side.NORTH.name: [],
            Side.EAST.name: [],
            Side.SOUTH.name: [],
            Side.WEST.name: [],
        }

        # Get the actual tile to access its pin order config and bels
        tile = super_tile.tileMap[int(y)][int(x)]
        if tile is None:
            continue

        tile_prefix = f"Tile_{tile_key}_{prefix}"
        perimeter_sides = set()
        for port_list in port_lists:
            if not port_list:
                continue

            # Determine which side this port list belongs to based on the first
            # port's sideOfTile
            side = port_list[0].sideOfTile
            perimeter_sides.add(side)

            # Process ports for this side (append to string-keyed dict)
            for port in port_list:
                if regex := port.getPortRegex(indexed=True, prefix=tile_prefix):
                    config_payload[tile_key][side.name].append(
                        tile.pinOrderConfig[side]([regex]).to_dict()
                    )

            # Add additional config pins based on side
            if side == Side.NORTH:
                config_payload[tile_key][side.name].append(
                    PinOrderConfig()([f"{tile_prefix}UserCLKo"]).to_dict()
                )
                config_payload[tile_key][side.name].append(
                    PinOrderConfig()([rf"{tile_prefix}FrameStrobe_O\[\d+\]"]).to_dict()
                )
            elif side == Side.EAST:
                config_payload[tile_key][side.name].append(
                    PinOrderConfig()([rf"{tile_prefix}FrameData_O\[\d+\]"]).to_dict()
                )
            elif side == Side.SOUTH:
                config_payload[tile_key][side.name].append(
                    PinOrderConfig()([f"{tile_prefix}UserCLK"]).to_dict()
                )
                config_payload[tile_key][side.name].append(
                    PinOrderConfig()([rf"{tile_prefix}FrameStrobe\[\d+\]"]).to_dict()
                )
            elif side == Side.WEST:
                config_payload[tile_key][side.name].append(
                    PinOrderConfig()([rf"{tile_prefix}FrameData\[\d+\]"]).to_dict()
                )

        # Add BEL external ports (only for tiles that have them)
        if tile.bels:
            for bel in tile.bels:
                pin_regexes = [
                    f"{prefix}{name}" for name in bel.externalInput + bel.externalOutput
                ]
                if pin_regexes:
                    # Determine which side to place external ports
                    if external_port_sides and (int(x), int(y)) in external_port_sides:
                        external_side = external_port_sides[(int(x), int(y))]
                    elif perimeter_sides:
                        # Default to first perimeter side if available
                        external_side = next(iter(perimeter_sides))
                    else:
                        # Fallback to SOUTH if no perimeter sides
                        external_side = Side.SOUTH

                    # append under string-keyed side
                    config_payload[tile_key][external_side.name].append(
                        tile.pinOrderConfig[external_side](pin_regexes).to_dict()
                    )

    return config_payload


def generate_IO_pin_order_config(
    tile_or_super_tile: Tile | SuperTile,
    outfile: Path,
    prefix: str = "",
    external_port_side: Side = Side.SOUTH,
    external_port_sides: dict[tuple[int, int], Side] | None = None,
) -> None:
    """Generate I/O pin order configuration for a tile or super tile.

    The resulting YAML maps coordinate keys of the form ``X#Y#`` to side
    configuration dictionaries. Coordinates are enumerated from the top-left
    corner (``X0Y0``).

    Parameters
    ----------
    tile_or_super_tile : Tile | SuperTile
        The tile or super tile to generate configuration for
    outfile : Path
        Output YAML file path
    prefix : str
        Prefix to add to port names
    external_port_side : Side
        For a single Tile, which side to place external BEL ports on.
        Defaults to SOUTH for backward compatibility.
    external_port_sides : dict[tuple[int, int], Side] | None
        For a SuperTile, mapping from tile coordinates (x, y) to the side
        where external BEL ports should be placed. If None or if a coordinate
        is not in the dict, defaults to using the perimeter side(s) of that tile.
    """
    if isinstance(tile_or_super_tile, SuperTile):
        config_payload = _serialize_supertile_ports(
            tile_or_super_tile, prefix, external_port_sides
        )
    else:
        config_payload = {
            "X0Y0": _serialize_tile_ports(
                tile_or_super_tile, prefix, external_port_side
            )
        }

    with outfile.open("w") as file_descriptor:
        yaml.dump(config_payload, file_descriptor)
