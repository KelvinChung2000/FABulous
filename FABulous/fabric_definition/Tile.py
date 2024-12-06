from dataclasses import dataclass
from pathlib import Path
from typing import Any

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Mux import Mux
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
    switchMatrix: list[Mux] | Path
    globalConfigBits: int = 0
    withUserCLK: bool = False
    tileDir: Path = Path(".")
    partOfSuperTile = False

    def __eq__(self, __o: Any) -> bool:
        if __o is None or not isinstance(__o, Tile):
            return False
        return self.name == __o.name

    def getWestPorts(self, io: IO | None = None) -> list[TilePort]:
        """
        Retrieve the list of ports located on the west side of the tile.

        Args:
            io (IO | None, optional): The direction of the port (input/output).
                                      If None, all ports on the west side are returned.
                                      Defaults to None.

        Returns:
            list[TilePort]: A list of TilePort objects located on the west side of the tile.
        """
        if io is None:
            return [p for p in self.ports if p.sideOfTile == Side.WEST]
        else:
            return [
                p for p in self.ports if p.sideOfTile == Side.WEST and p.inOut == io
            ]

    def getSouthPorts(self, io: IO | None = None) -> list[TilePort]:
        """
        Retrieve the list of ports located on the south side of the tile.

        Args:
            io (IO | None, optional): The direction of the port (input/output).
                                      If None, all ports on the south side are returned.
                                      Defaults to None.

        Returns:
           list[TilePort]: A list of TilePort objects located on the south side of the tile. If `io` is specified, only ports matching the IO type are returned.
        """
        if io is None:
            return [p for p in self.ports if p.sideOfTile == Side.SOUTH]
        else:
            return [
                p for p in self.ports if p.sideOfTile == Side.SOUTH and p.inOut == io
            ]

    def getEastPorts(self, io: IO | None = None) -> list[TilePort]:
        """
        Retrieve the list of ports located on the east side of the tile.

        Args:
            io (IO | None, optional): The direction of the port (input/output).
                                      If None, all ports on the east side are returned.
                                      Defaults to None.

        Returns:
           list[TilePort]: A list of TilePort objects located on the south side of the tile. If `io` is specified, only ports matching the IO type are returned.
        """
        if io is None:
            return [p for p in self.ports if p.sideOfTile == Side.EAST]
        else:
            return [
                p for p in self.ports if p.sideOfTile == Side.EAST and p.inOut == io
            ]

    def getNorthPorts(self, io: IO | None = None) -> list[TilePort]:
        """
        Retrieve the list of ports located on the north side of the tile.

        Args:
            io (IO | None, optional): The direction of the port (input/output).
                                      If None, all ports on the north side are returned.
                                      Defaults to None.

        Returns:
           list[TilePort]: A list of TilePort objects located on the south side of the tile. If `io` is specified, only ports matching the IO type are returned.
        """
        if io is None:
            return [p for p in self.ports if p.sideOfTile == Side.NORTH]
        else:
            return [
                p for p in self.ports if p.sideOfTile == Side.NORTH and p.inOut == io
            ]

    def getTileInputNames(self) -> list[str]:
        return [p.name for p in self.ports if p.inOut == IO.INPUT]

    def getTileOutputNames(self) -> list[str]:
        return [p.name for p in self.ports if p.inOut == IO.OUTPUT]

    def getTileInputPorts(self) -> list[TilePort]:
        return sorted([p for p in self.ports if p.inOut == IO.INPUT])

    def getTileOutputPorts(self) -> list[TilePort]:
        return sorted([p for p in self.ports if p.inOut == IO.OUTPUT])
