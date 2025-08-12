from collections import defaultdict
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Iterable, cast

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.ConfigMem import ConfigurationMemory
from FABulous.fabric_definition.define import IO, Loc, Side
from FABulous.fabric_definition.Port import BelPort, GenericPort, SharedPort, TilePort
from FABulous.fabric_definition.SwitchMatrix import SwitchMatrix
from FABulous.fabric_definition.Wire import WireType


@dataclass
class Tile:
    """This class is for storing the information about a tile.

    Attributes
    ----------
    name : str
        The name of the tile
    portsInfo : list[Port]
        The list of ports of the tile
    matrixDir : str
        The directory of the tile matrix
    globalConfigBits : int
        The number of config bits the tile has
    withUserCLK : bool
        Whether the tile has a userCLK port. Default is False.
    wireList : list[Wire]
        The list of wires of the tile
    tileDir : str
        The path to the tile folder
    """

    name: str
    ports: dict[str, list[TilePort]]
    belGroups: dict[str, list[Bel]]
    switchMatrix: SwitchMatrix
    configMems: ConfigurationMemory
    tileMap: list[list[str]]
    wireTypes: dict[str, list[WireType]] = field(
        default_factory=lambda: defaultdict(list)
    )
    withUserCLK: bool = False
    tileDir: Path = Path(".")

    def __eq__(self, __o: Any) -> bool:
        if __o is None or not isinstance(__o, Tile):
            return False
        return self.name == __o.name

    @property
    def bels(self):
        """Retrieve all BELs in the tile."""
        return [bel for group in self.belGroups.values() for bel in group]

    @property
    def configBits(self):
        return sum(bel.configBits for bel in self.bels) + self.switchMatrix.configBits

    def getWestPorts(self, io: IO | None = None) -> list[TilePort]:
        """Retrieve the list of ports located on the west side of the tile.

        Args:
            io (IO | None, optional): The direction of the port (input/output).
                                      If None, all ports on the west side are returned.
                                      Defaults to None.

        Returns:
            list[TilePort]: A list of TilePort objects located on the west side of the tile.
        """
        if io is None:
            return [
                p
                for st in [i[-1] for i in self.tileMap]
                for p in self.ports[st]
                if p.sideOfTile == Side.WEST
            ]
        else:
            return [
                p
                for st in [i[-1] for i in self.tileMap]
                for p in self.ports[st]
                if p.sideOfTile == Side.WEST and p.ioDirection == io
            ]

    def getSouthPorts(self, io: IO | None = None) -> list[TilePort]:
        """Retrieve the list of ports located on the south side of the tile.

        Args:
            io (IO | None, optional): The direction of the port (input/output).
                                      If None, all ports on the south side are returned.
                                      Defaults to None.

        Returns:
           list[TilePort]: A list of TilePort objects located on the south side of the tile. If `io` is specified, only ports matching the IO type are returned.
        """
        if io is None:
            return [
                p
                for st in self.tileMap[-1]
                for p in self.ports[st]
                if p.sideOfTile == Side.SOUTH
            ]
        else:
            return [
                p
                for st in self.tileMap[-1]
                for p in self.ports[st]
                if p.sideOfTile == Side.SOUTH and p.ioDirection == io
            ]

    def getEastPorts(self, io: IO | None = None) -> list[TilePort]:
        """Retrieve the list of ports located on the east side of the tile.

        Args:
            io (IO | None, optional): The direction of the port (input/output).
                                      If None, all ports on the east side are returned.
                                      Defaults to None.

        Returns:
           list[TilePort]: A list of TilePort objects located on the south side of the tile. If `io` is specified, only ports matching the IO type are returned.
        """
        if io is None:
            return [
                p
                for st in [i[0] for i in self.tileMap]
                for p in self.ports[st]
                if p.sideOfTile == Side.EAST
            ]
        else:
            return [
                p
                for st in [i[0] for i in self.tileMap]
                for p in self.ports[st]
                if p.sideOfTile == Side.EAST and p.ioDirection == io
            ]

    def getNorthPorts(self, io: IO | None = None) -> list[TilePort]:
        """Retrieve the list of ports located on the north side of the tile.

        Args:
            io (IO | None, optional): The direction of the port (input/output).
                                      If None, all ports on the north side are returned.
                                      Defaults to None.

        Returns:
           list[TilePort]: A list of TilePort objects located on the south side of the tile. If `io` is specified, only ports matching the IO type are returned.
        """
        if io is None:
            return [
                p
                for st in self.tileMap[0]
                for p in self.ports[st]
                if p.sideOfTile == Side.NORTH
            ]
        else:
            return [
                p
                for st in self.tileMap[0]
                for p in self.ports[st]
                if p.sideOfTile == Side.NORTH and p.ioDirection == io
            ]

    def getTileInputNames(self) -> list[str]:
        return sorted(
            [
                p.name
                for st in self.getSubTiles()
                for p in self.ports[st]
                if p.ioDirection == IO.INPUT
            ]
        )

    def getTileOutputNames(self) -> list[str]:
        return sorted(
            [
                p.name
                for st in self.getSubTiles()
                for p in self.ports[st]
                if p.ioDirection == IO.OUTPUT
            ]
        )

    def getTileInputPorts(self, subTile: str = "") -> list[TilePort]:
        if subTile:
            return sorted([p for p in self.ports[subTile] if p.ioDirection == IO.INPUT])
        else:
            return sorted(
                [
                    p
                    for st in self.getSubTiles()
                    for p in self.ports[st]
                    if p.ioDirection == IO.INPUT
                ]
            )

    def getTileOutputPorts(self, subTile: str = "") -> list[TilePort]:
        if subTile:
            return sorted(
                [p for p in self.ports[subTile] if p.ioDirection == IO.OUTPUT]
            )
        else:
            return sorted(
                [
                    p
                    for st in self.getSubTiles()
                    for p in self.ports[st]
                    if p.ioDirection == IO.OUTPUT
                ]
            )

    def getTilePortGrouped(self, io: IO | None = None) -> dict[Side, list[TilePort]]:
        return {
            Side.NORTH: self.getNorthPorts(io),
            Side.EAST: self.getEastPorts(io),
            Side.SOUTH: self.getSouthPorts(io),
            Side.WEST: self.getWestPorts(io),
        }

    def getWireType(self, port: TilePort) -> WireType:
        for subTile in self.wireTypes:
            for i in self.wireTypes[subTile]:
                if i.sourcePort == port or i.destinationPort == port:
                    return i
        else:
            raise ValueError(
                f"The given port {port} does not exist in tile {self.name}"
            )

    def getCascadeWireCount(self, port: TilePort) -> int:
        for subTile in self.wireTypes:
            for i in self.wireTypes[subTile]:
                if i.sourcePort == port or i.destinationPort == port:
                    return port.width * (abs(i.offsetX) + abs(i.offsetY))
        else:
            return port.width

    def getEndPointPort(self, port: TilePort) -> TilePort:
        if port.ioDirection == IO.OUTPUT:
            raise ValueError(
                "The given port is an output port. Please provide an input port."
            )
        for subTile in self.wireTypes:
            for i in self.wireTypes[subTile]:
                if i.sourcePort == port or i.destinationPort == port:
                    return cast(TilePort, i.destinationPort)
        else:
            raise ValueError(
                f"The given port {port} does not exist in tile {self.name}"
            )

    def getStartPointPort(self, port: TilePort) -> TilePort:
        if port.ioDirection == IO.INPUT:
            raise ValueError(
                "The given port is an input port. Please provide an output port."
            )
        for subTile in self.wireTypes:
            for i in self.wireTypes[subTile]:
                if i.destinationPort.name == port.name:
                    return cast(TilePort, i.sourcePort)
        else:
            raise ValueError(
                f"The given port {port} does not exist in tile {self.name}"
            )

    def isPortInTile(self, port: GenericPort) -> bool:
        for portList in self.ports.values():
            if port in portList:
                return True

        for bel in self.bels:
            if port in bel.inputs or port in bel.outputs:
                return True
        return False

    def findPortByName(self, portName: str) -> TilePort | BelPort:
        for portList in self.ports.values():
            for i in portList:
                if i.name == portName:
                    return i

        for bel in self.bels:
            for i in bel.inputs + bel.outputs:
                if i.name == portName:
                    return i

        raise ValueError(f"The port {portName} does not exist in tile {self.name}")

    def addWireType(self, subTileName: str, wireType: WireType) -> None:
        if wireType not in self.wireTypes[subTileName]:
            self.wireTypes[subTileName].append(wireType)

    def getUniqueBelType(self) -> Iterable[Bel]:
        belSet = set()
        for i in self.bels:
            if i.name not in belSet:
                belSet.add(i.name)
        return list(belSet)

    def getBelByBelPort(self, belPort: BelPort) -> Bel:
        for i in self.bels:
            if belPort in i.inputs or belPort in i.outputs:
                return i
        else:
            raise ValueError(
                f"The given port {belPort} does not exist in tile {self.name}"
            )

    def partOfTile(self, name: str) -> bool:
        """Check if the given name is part of the tile.

        Args:
            name (str): The name to check.

        Returns:
            bool: True if the name is part of the tile, False otherwise.
        """
        return any(name in row for row in self.tileMap)

    def getSubTiles(self) -> list[str]:
        """Get the subtiles of the tile.

        Returns:
            list[str]: A list of subtiles.
        """
        return [name for row in self.tileMap for name in row if name is not None]

    def getSubTileOffset(self, subTile: str) -> Loc:
        for y, row in enumerate(reversed(self.tileMap)):
            for x, name in enumerate(row):
                if name == subTile:
                    return (x, y)
        else:
            raise ValueError(
                f"The given subTile {subTile} does not exist in tile {self.name}"
            )

    def isRootTile(self, name: str) -> bool:
        """Check if the given name is the root tile.

        Args:
            name (str): The name to check.

        Returns:
            bool: True if the name is the root tile, False otherwise.
        """
        return self.tileMap[-1][0] == name

    def getBelSharedPort(self) -> list[SharedPort]:
        shared = []
        for i in self.bels:
            for p in i.sharedPort:
                if p not in shared:
                    shared.append(p)
        return shared

    def __str__(self) -> str:
        """Return a formatted string representation of the tile.

        Returns:
            str: A formatted string showing the tile's key information.
        """
        lines = [
            f"Tile: {self.name}",
            "Ports:",
        ]

        # Add ports grouped by side
        for side, ports in self.getTilePortGrouped().items():
            if ports:
                lines.append(f"  {side.name}:")
                for port in ports:
                    lines.append(f"    {port}")

        # Add Bels
        lines.append("Bels:")
        for groupName, belList in self.belGroups.items():
            lines.append(f"  Group: {groupName}")
            for bel in belList:
                lines.append(f"    {bel.prefix}{bel.name} (z={bel.z})")

        # Add Switch Matrix info
        lines.append(f"Switch Matrix: {self.switchMatrix}")

        # Add Config Bits
        lines.append(f"Config Bits: {self.configBits}")

        # Add User CLK status
        lines.append(f"User CLK: {self.withUserCLK}")

        # Draw sub-tile map
        lines.append("Sub-tile Map:")
        # Use a fixed width for each cell for alignment
        cellWidth = max(
            (
                len(str(name))
                for row in self.tileMap
                for name in row
                if name is not None
            ),
            default=3,
        )
        for row in self.tileMap:
            rowStr = " | ".join(
                f"{(name if name is not None else '---'):^{cellWidth}}" for name in row
            )
            lines.append(f"  {rowStr}")

        return "\n".join(lines)

    def serialize(self) -> dict:
        return {
            "name": self.name,
            "ports": {
                name: [port.serialize() for port in ports]
                for name, ports in self.ports.items()
            },
            "bels": [bel.serialize() for bel in self.bels],
            "switchMatrix": self.switchMatrix.serialize(),
            "configBits": self.configBits,
            "withUserCLK": self.withUserCLK,
            "tileMap": self.tileMap,
        }
