import os
from enum import Enum
from dataclasses import dataclass, field
from FABulous.fabric_definition.define import IO, Direction, Side
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.Port import Port
from FABulous.fabric_definition.Wire import Wire
from FABulous.fabric_generator.utilities import parseMatrix, parseList
from typing import Any


class Tile:
    """
    This class is for storing the information about a tile.

    attributes:
        name (str) : The name of the tile
        portsInfo (list[Port]) : The list of ports of the tile
        matrixDir (str) : The directory of the tile matrix
        globalConfigBits (int) : The number of config bits the tile have
        withUserCLK (bool) : Whether the tile has userCLK port. Default is False.
        wireList (list[Wire]) : The list of wires of the tile
        filePath (str) : The path of the matrix file
    """

    def __init__(
        self,
        name: str,
        ports: list[Port],
        bels: list[Bel],
        matrixDir: str,
        userCLK: bool,
        configBit: int = 0,
    ) -> None:
        self._name = name
        self._portsInfo = ports
        self._bels = bels
        self._matrixDir = matrixDir
        self._withUserCLK = userCLK
        self._globalConfigBits = configBit
        self._externalWireList = []
        self._internalWireList = []
        self._filePath = os.path.split(matrixDir)[0]
        self._partOfSuperTile = False
        self._X = 0
        self._Y = 0

        for b in self._bels:
            self._globalConfigBits += b.configBit

        if self._matrixDir.endswith(".csv"):
            connection = parseMatrix(self._matrixDir, self._name)
            for source, sinkList in connection.items():
                for sink in sinkList:
                    self._internalWireList.append(
                        Wire(
                            direction=Direction.JUMP,
                            source=sink,
                            xOffset=0,
                            yOffset=0,
                            destination=source,
                            sourceTile=sink,
                            destinationTile=source,
                        )
                    )
        elif self._matrixDir.endswith(".list"):
            connection = parseList(self._matrixDir)
            for sink, source in connection:
                self._internalWireList.append(
                    Wire(
                        direction=Direction.JUMP,
                        source=source,
                        xOffset=0,
                        yOffset=0,
                        destination=sink,
                        sourceTile=source,
                        destinationTile=sink,
                    )
                )
        else:
            raise ValueError(
                f"For model generation {self._matrixDir} need to a csv or list file"
            )

    @property
    def name(self) -> str:
        return self._name

    @property
    def portsInfo(self) -> list[Port]:
        return self._portsInfo

    @property
    def bels(self) -> list[Bel]:
        return self._bels

    @property
    def matrixDir(self) -> str:
        return self._matrixDir

    @matrixDir.setter
    def matrixDir(self, matrixDir: str) -> None:
        self._matrixDir = matrixDir

    @property
    def globalConfigBits(self) -> int:
        return self._globalConfigBits

    @property
    def withUserCLK(self) -> bool:
        return self._withUserCLK

    @property
    def externalWireList(self) -> list[Wire]:
        return self._externalWireList

    @externalWireList.setter
    def externalWireList(self, externalWireList: list[Wire]) -> None:
        self._externalWireList = externalWireList

    @property
    def internalWireList(self) -> list[Wire]:
        return self._internalWireList

    @property
    def filePath(self) -> str:
        return self._filePath

    @property
    def partOfSuperTile(self) -> bool:
        return self._partOfSuperTile

    @partOfSuperTile.setter
    def partOfSuperTile(self, partOfSuperTile: bool) -> None:
        self._partOfSuperTile = partOfSuperTile

    @property
    def X(self) -> int:
        return self._X

    @property
    def Y(self) -> int:
        return self._Y

    @X.setter
    def X(self, x: int) -> None:
        self._X = x

    @Y.setter
    def Y(self, y: int) -> None:
        self._Y = y

    def __eq__(self, __o: Any) -> bool:
        if __o is None or not isinstance(__o, Tile):
            return False
        return self.name == __o.name

    def getWestSidePorts(self) -> list[Port]:
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.WEST and p.name != "NULL"
        ]

    def getEastSidePorts(self) -> list[Port]:
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.EAST and p.name != "NULL"
        ]

    def getNorthSidePorts(self) -> list[Port]:
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.NORTH and p.name != "NULL"
        ]

    def getSouthSidePorts(self) -> list[Port]:
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.SOUTH and p.name != "NULL"
        ]

    def getNorthPorts(self, io: IO) -> list[Port]:
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.NORTH and p.name != "NULL" and p.inOut == io
        ]

    def getSouthPorts(self, io: IO) -> list[Port]:
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.SOUTH and p.name != "NULL" and p.inOut == io
        ]

    def getEastPorts(self, io: IO) -> list[Port]:
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.EAST and p.name != "NULL" and p.inOut == io
        ]

    def getWestPorts(self, io: IO) -> list[Port]:
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.WEST and p.name != "NULL" and p.inOut == io
        ]

    def getTileInputNames(self) -> list[str]:
        return [
            p.destinationName
            for p in self.portsInfo
            if p.destinationName != "NULL"
            and p.wireDirection != Direction.JUMP
            and p.inOut == IO.INPUT
        ]

    def getTileOutputNames(self) -> list[str]:
        return [
            p.sourceName
            for p in self.portsInfo
            if p.sourceName != "NULL"
            and p.wireDirection != Direction.JUMP
            and p.inOut == IO.OUTPUT
        ]

    def addInternalWire(self, wire: Wire) -> None:
        self._internalWireList.append(wire)

    def addBel(self, bel: Bel) -> None:
        self._bels.append(bel)

    def addPort(self, port: Port) -> None:
        self._portsInfo.append(port)
