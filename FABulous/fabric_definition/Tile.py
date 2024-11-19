import pathlib
from dataclasses import dataclass
from typing import Any

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO, Direction, Side
from FABulous.fabric_definition.Port import TilePort
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
    ports: list[TilePort]
    bels: list[Bel]
    wireTypes: list[WireType]
    matrixDir: pathlib.Path
    globalConfigBits: int = 0
    withUserCLK: bool = False
    tileDir: pathlib.Path = pathlib.Path(".")
    partOfSuperTile = False

    def __eq__(self, __o: Any) -> bool:
        if __o is None or not isinstance(__o, Tile):
            return False
        return self.name == __o.name

    def getWestSidePorts(self) -> list[TilePort]:
        return [p for p in self.ports if p.sideOfTile == Side.WEST and not p.terminal]

    def getEastSidePorts(self) -> list[TilePort]:
        return [p for p in self.ports if p.sideOfTile == Side.EAST and not p.terminal]

    def getNorthSidePorts(self) -> list[TilePort]:
        return [p for p in self.ports if p.sideOfTile == Side.NORTH and not p.terminal]

    def getSouthSidePorts(self) -> list[TilePort]:
        return [p for p in self.ports if p.sideOfTile == Side.SOUTH and not p.terminal]

    def getNorthPorts(self, io: IO) -> list[TilePort]:
        return [
            p
            for p in self.ports
            if p.wireDirection == Direction.NORTH and p.name != "NULL" and p.inOut == io
        ]

    def getSouthPorts(self, io: IO) -> list[TilePort]:
        return [
            p
            for p in self.ports
            if p.wireDirection == Direction.SOUTH and p.name != "NULL" and p.inOut == io
        ]

    def getEastPorts(self, io: IO) -> list[TilePort]:
        return [
            p
            for p in self.ports
            if p.wireDirection == Direction.EAST and p.name != "NULL" and p.inOut == io
        ]

    def getWestPorts(self, io: IO) -> list[TilePort]:
        return [
            p
            for p in self.ports
            if p.wireDirection == Direction.WEST and p.name != "NULL" and p.inOut == io
        ]

    def getTileInputNames(self) -> list[str]:
        return [p.name for p in self.ports if p.inOut == IO.INPUT]

    def getTileOutputNames(self) -> list[str]:
        return [p.name for p in self.ports if p.inOut == IO.OUTPUT]
