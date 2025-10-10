"""Generate IO pin order configuration files for FABulous tiles and fabrics."""

from dataclasses import dataclass, field
from pathlib import Path
from typing import Self

import yaml

from FABulous.fabric_definition.define import PinSortMode, Side
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.SuperTile import SuperTile
from FABulous.fabric_definition.Tile import Tile


@dataclass
class PinOrderConfig:
    """Container describing pin ordering constraints for a segment."""

    min_distance: int | None = None
    max_distance: int | None = None
    pins: list[str | int] = field(default_factory=list)
    sort_mode: PinSortMode = PinSortMode.BUS_MAJOR
    reverse_result: bool = False

    def __call__(self, pins: list[str | int]) -> Self:
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
    """Serialize a single tile's ports for IO pin placement."""
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

    # Place BEL external ports on the specified side
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
    """Serialize SuperTile ports, processing only perimeter sides."""
    config_payload: dict[str, dict[str, list[dict]]] = {}
    ports_around = super_tile.getPortsAroundTile()

    for coord_key, port_lists in ports_around.items():
        if not port_lists:
            continue

        x, y = coord_key.split(",")
        tile_key = f"X{x}Y{y}"
        config_payload[tile_key] = {
            Side.NORTH.name: [],
            Side.EAST.name: [],
            Side.SOUTH.name: [],
            Side.WEST.name: [],
        }

        tile = super_tile.tileMap[int(y)][int(x)]
        if tile is None:
            continue

        tile_prefix = f"Tile_{tile_key}_{prefix}"
        perimeter_sides = set()
        for port_list in port_lists:
            if not port_list:
                continue

            side = port_list[0].sideOfTile
            perimeter_sides.add(side)

            for port in port_list:
                if regex := port.getPortRegex(indexed=True, prefix=tile_prefix):
                    config_payload[tile_key][side.name].append(
                        tile.pinOrderConfig[side]([regex]).to_dict()
                    )

            # Add frame signals based on side
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

        # Add BEL external ports
        if tile.bels:
            for bel in tile.bels:
                pin_regexes = [
                    f"{prefix}{name}" for name in bel.externalInput + bel.externalOutput
                ]
                if pin_regexes:
                    if external_port_sides and (int(x), int(y)) in external_port_sides:
                        external_side = external_port_sides[(int(x), int(y))]
                    elif perimeter_sides:
                        external_side = next(iter(perimeter_sides))
                    else:
                        external_side = Side.SOUTH

                    config_payload[tile_key][external_side.name].append(
                        tile.pinOrderConfig[external_side](pin_regexes).to_dict()
                    )

    return config_payload


def generate_IO_pin_order_config(
    fabric: Fabric,
    tile_or_super_tile: Tile | SuperTile,
    outfile: Path,
    prefix: str = "",
) -> None:
    """Generate IO pin order configuration for a tile or super tile.

    Parameters
    ----------
    fabric : Fabric
        The fabric containing the tile or super tile
    tile_or_super_tile : Tile | SuperTile
        The tile or super tile to generate configuration for
    outfile : Path
        Output YAML file path
    prefix : str
        Prefix to add to port names
    """
    positions = fabric.find_tile_positions(tile_or_super_tile)

    if isinstance(tile_or_super_tile, SuperTile):
        external_port_sides: dict[tuple[int, int], Side] = {}
        if positions:
            # For multi-entry config, find top-left position (min x, min y)
            if len(positions) == 1:
                base_x, base_y = positions[0]
            else:
                base_x = min(pos[0] for pos in positions)
                base_y = min(pos[1] for pos in positions)

            for st_y, row in enumerate(tile_or_super_tile.tileMap):
                for st_x, st_tile in enumerate(row):
                    if st_tile is None:
                        continue
                    fabric_x = base_x + st_x
                    fabric_y = base_y + st_y
                    border_side = fabric.determine_border_side(fabric_x, fabric_y)
                    if border_side:
                        external_port_sides[(st_x, st_y)] = border_side

        config_payload = _serialize_supertile_ports(
            tile_or_super_tile, prefix, external_port_sides
        )
    else:
        external_port_side = Side.SOUTH
        if positions:
            x, y = positions[0]
            if border_side := fabric.determine_border_side(x, y):
                external_port_side = border_side

        config_payload = {
            "X0Y0": _serialize_tile_ports(
                tile_or_super_tile, prefix, external_port_side
            )
        }

    with outfile.open("w") as file_descriptor:
        yaml.dump(config_payload, file_descriptor)


def generate_fabric_IO_pin_order_config(fabric: Fabric, outfile: Path) -> None:
    """Generate fabric-level IO pin order configuration.

    Treats the entire fabric as a single design (X0Y0) with all border IOs
    collected into one segment per side, ordered by tile position.

    Parameters
    ----------
    fabric : Fabric
        The fabric object containing the tile grid
    outfile : Path
        Output YAML file path for the fabric-level configuration
    """
    # Collect all pins for each fabric side (in order)
    config_payload = {}

    frame_data_counter = 0
    frame_strobe_counter = 0
    virtual_pin_count = 0

    # Iterate through all tiles and collect border pins
    for (x, y), tile in fabric:
        north_pins: list[str | int] = []
        south_pins: list[str | int] = []
        east_pins: list[str | int] = []
        west_pins: list[str | int] = []
        if tile is None:
            continue

        # Determine which sides are on the fabric perimeter
        is_north = y == 0
        is_south = y == fabric.numberOfRows - 1
        is_west = x == 0
        is_east = x == fabric.numberOfColumns - 1

        # Skip non-perimeter tiles
        if not (is_north or is_south or is_west or is_east):
            continue

        # FIXME: hardcoded special case for UserCLK
        if x == fabric.numberOfColumns // 2 and y == fabric.numberOfRows - 1:
            south_pins.append("UserCLK")

        prefix = f"Tile_X{x}Y{y}_"

        # Check which sides have neighbors (don't add pins to those sides)
        has_south_neighbor = (
            y < fabric.numberOfRows - 1 and fabric.tile[y + 1][x] is not None
        )
        has_west_neighbor = x > 0 and fabric.tile[y][x - 1] is not None
        has_east_neighbor = (
            x < fabric.numberOfColumns - 1 and fabric.tile[y][x + 1] is not None
        )

        if not has_east_neighbor or not has_west_neighbor:
            prefix = f"Tile_X{x}Y{y}_"
            if not has_south_neighbor:
                for _ in range(fabric.maxFramesPerCol):
                    south_pins.append(f"FrameStrobe\\[{frame_strobe_counter}\\]")
                    frame_strobe_counter += 1

            if not has_west_neighbor:
                pin_to_add = []
                for _ in range(fabric.frameBitsPerRow):
                    west_pins.append(f"FrameData\\[{frame_data_counter}\\]")
                    frame_data_counter += 1
                west_pins.extend(reversed(pin_to_add))
            if not has_east_neighbor:
                east_pins.append(fabric.frameBitsPerRow)

            if tile.bels:
                for bel in tile.bels:
                    pin_regexes = [
                        f"{prefix}{name}"
                        for name in bel.externalInput + bel.externalOutput
                    ]
                    for pin in pin_regexes:
                        if is_north:
                            north_pins.append(pin)
                        if is_south:
                            south_pins.append(pin)
                        if is_east:
                            east_pins.append(pin)
                        if is_west:
                            west_pins.append(pin)

        else:
            if tile.bels:
                for bel in tile.bels:
                    pin_regexes = [
                        f"{prefix}{name}"
                        for name in bel.externalInput + bel.externalOutput
                    ]
                    for pin in pin_regexes:
                        if is_north:
                            north_pins.append(pin)
                        if is_south:
                            south_pins.append(pin)
                        if is_east:
                            east_pins.append(pin)
                        if is_west:
                            west_pins.append(pin)

            if not has_south_neighbor:
                for _ in range(fabric.maxFramesPerCol):
                    south_pins.append(f"FrameStrobe\\[{frame_strobe_counter}\\]")
                    frame_strobe_counter += 1

            if not has_west_neighbor:
                for _ in range(fabric.frameBitsPerRow):
                    west_pins.append(f"FrameData\\[{frame_data_counter}\\]")
                    frame_data_counter -= 1

        config_payload[f"X{x}Y{y}"] = {
            Side.NORTH.name: (
                [PinOrderConfig()(north_pins).to_dict()] if north_pins else []
            ),
            Side.SOUTH.name: (
                [PinOrderConfig()(south_pins).to_dict()] if south_pins else []
            ),
            Side.EAST.name: (
                [PinOrderConfig()(east_pins).to_dict()] if east_pins else []
            ),
            Side.WEST.name: (
                [PinOrderConfig()(west_pins).to_dict()] if west_pins else []
            ),
        }

    # Create single X0Y0 config with all pins in one segment per side
    with outfile.open("w") as file_descriptor:
        yaml.dump(config_payload, file_descriptor)
