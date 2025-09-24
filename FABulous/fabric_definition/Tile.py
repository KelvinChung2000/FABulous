"""Store information about a tile."""

from dataclasses import dataclass, field
from pathlib import Path
from typing import Self

import yaml

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO, Direction, PinSortMode, Side
from FABulous.fabric_definition.Gen_IO import Gen_IO
from FABulous.fabric_definition.Port import Port
from FABulous.fabric_definition.Wire import Wire


@dataclass
class PinOrderConfig:
    min_distance: int | None
    max_distance: int | None
    pins: list[str]
    sort_mode: PinSortMode
    reverse_result: bool

    def __init__(
        self,
        min_distance: int | None = None,
        max_distance: int | None = None,
        sort_mode: PinSortMode = PinSortMode.BUS_MAJOR,
        reverse_result: bool = False,
    ) -> None:
        self.min_distance = min_distance
        self.max_distance = max_distance
        self.sort_mode = sort_mode
        self.reverse_result = reverse_result

    def __call__(self, pins: list[str]) -> Self:
        self.pins = pins
        return self

    def to_dict(self) -> dict:
        if self.pins is None:
            self.pins = []
        return {
            "min_distance": self.min_distance,
            "max_distance": self.max_distance,
            "pins": self.pins,
            "sort_mode": str(self.sort_mode),
            "reverse_result": self.reverse_result,
        }


@dataclass
class Tile:
    """Store information about a tile.

    Parameters
    ----------
    name : str
        The name of the tile
    ports : list[Port]
        List of ports for the tile
    bels : list[Bel]
        List of Basic Elements of Logic (BELs) in the tile
    tileDir : Path
        Directory path for the tile
    matrixDir : Path
        Directory path for the tile matrix
    gen_ios : list[Gen_IO]
        List of general I/O components
    userCLK : bool
        True if the tile uses a clk signal
    configBit : int, optional
        Number of configuration bits for the switch matrix. Default is 0.

    Attributes
    ----------
    name : str
        The name of the tile
    portsInfo : list[Port]
        The list of ports of the tile
    bels: list[Bel]
        The list of BELs of the tile
    matrixDir : Path
        The directory of the tile matrix
    matrixConfigBits : int
        The number of config bits the tile switch matrix has
    gen_ios : list[Gen_IO]
        The list of GEN_IOs of the tile
    withUserCLK : bool
        Whether the tile has a userCLK port. Default is False.
    wireList : list[Wire]
        The list of wires of the tile
    tileDir : Path
        The path to the tile folder
    partOfSuperTile : bool
        Whether the tile is part of a super tile. Default is False.
    """

    name: str
    portsInfo: list[Port]
    bels: list[Bel]
    matrixDir: Path
    matrixConfigBits: int
    gen_ios: list[Gen_IO]
    withUserCLK: bool = False
    wireList: list[Wire] = field(default_factory=list)
    tileDir: Path = Path()
    partOfSuperTile: bool = False

    def __init__(
        self,
        name: str,
        ports: list[Port],
        bels: list[Bel],
        tileDir: Path,
        matrixDir: Path,
        gen_ios: list[Gen_IO],
        userCLK: bool,
        configBit: int = 0,
        pinOrderConfig: dict[Side, PinOrderConfig] | None = None,
    ) -> None:
        self.name = name
        self.portsInfo = ports
        self.bels = bels
        self.gen_ios = gen_ios
        self.matrixDir = matrixDir
        self.withUserCLK = userCLK
        self.matrixConfigBits = configBit
        self.wireList = []
        self.tileDir = tileDir

        if pinOrderConfig is None:
            self.pinOrderConfig = {
                Side.NORTH: PinOrderConfig(sort_mode=PinSortMode.BUS_MAJOR),
                Side.EAST: PinOrderConfig(sort_mode=PinSortMode.BUS_MAJOR),
                Side.SOUTH: PinOrderConfig(sort_mode=PinSortMode.BUS_MAJOR),
                Side.WEST: PinOrderConfig(sort_mode=PinSortMode.BUS_MAJOR),
            }
        else:
            self.pinOrderConfig = pinOrderConfig

    def __eq__(self, __o: object, /) -> bool:
        """Check equality between tiles based on their name.

        Parameters
        ----------
        __o : object
            The object to compare with.

        Returns
        -------
        bool
            True if both tiles have the same name, False otherwise.
        """
        if __o is None or not isinstance(__o, Tile):
            return False
        return self.name == __o.name

    def getWestSidePorts(self) -> list[Port]:
        """Get all ports physically located on the west side of the tile.

        Returns
        -------
        list[Port]
            List of ports on the west side, excluding NULL ports.
        """
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.WEST and p.name != "NULL"
        ]

    def getEastSidePorts(self) -> list[Port]:
        """Get all ports physically located on the east side of the tile.

        Returns
        -------
        list[Port]
            List of ports on the east side, excluding NULL ports.
        """
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.EAST and p.name != "NULL"
        ]

    def getNorthSidePorts(self) -> list[Port]:
        """Get all ports physically located on the north side of the tile.

        Returns
        -------
        list[Port]
            List of ports on the north side, excluding NULL ports.
        """
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.NORTH and p.name != "NULL"
        ]

    def getSouthSidePorts(self) -> list[Port]:
        """Get all ports physically located on the south side of the tile.

        Returns
        -------
        list[Port]
            List of ports on the south side, excluding NULL ports.
        """
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.SOUTH and p.name != "NULL"
        ]

    def getNorthPorts(self, io: IO) -> list[Port]:
        """Get all ports with north wire direction filtered by I/O type.

        Parameters
        ----------
        io : IO
            The I/O direction to filter by (INPUT or OUTPUT).

        Returns
        -------
        list[Port]
            List of north-direction ports with specified I/O type, excluding NULL ports.
        """
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.NORTH and p.name != "NULL" and p.inOut == io
        ]

    def getSouthPorts(self, io: IO) -> list[Port]:
        """Get all ports with south wire direction filtered by I/O type.

        Parameters
        ----------
        io : IO
            The I/O direction to filter by (INPUT or OUTPUT).

        Returns
        -------
        list[Port]
            List of south-direction ports with specified I/O type, excluding NULL ports.
        """
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.SOUTH and p.name != "NULL" and p.inOut == io
        ]

    def getEastPorts(self, io: IO) -> list[Port]:
        """Get all ports with east wire direction filtered by I/O type.

        Parameters
        ----------
        io : IO
            The I/O direction to filter by (INPUT or OUTPUT).

        Returns
        -------
        list[Port]
            List of east-direction ports with specified I/O type, excluding NULL ports.
        """
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.EAST and p.name != "NULL" and p.inOut == io
        ]

    def getWestPorts(self, io: IO) -> list[Port]:
        """Get all ports with west wire direction filtered by I/O type.

        Parameters
        ----------
        io : IO
            The I/O direction to filter by (INPUT or OUTPUT).

        Returns
        -------
        list[Port]
            List of west-direction ports with specified I/O type, excluding NULL ports.
        """
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.WEST and p.name != "NULL" and p.inOut == io
        ]

    def getTileInputNames(self) -> list[str]:
        """Get all input port destination names for the tile.

        Returns
        -------
        list[str]
            List of destination names for input ports, excluding NULL and
            JUMP direction ports.
        """
        return [
            p.destinationName
            for p in self.portsInfo
            if p.destinationName != "NULL"
            and p.wireDirection != Direction.JUMP
            and p.inOut == IO.INPUT
        ]

    def getTileOutputNames(self) -> list[str]:
        """Get all output port source names for the tile.

        Returns
        -------
        list[str]
            List of source names for output ports, excluding NULL and
            JUMP direction ports.
        """
        return [
            p.sourceName
            for p in self.portsInfo
            if p.sourceName != "NULL"
            and p.wireDirection != Direction.JUMP
            and p.inOut == IO.OUTPUT
        ]

    @property
    def globalConfigBits(self) -> int:
        """Get the total number of global configuration bits.

        Calculates the sum of switch matrix configuration bits
        and all BEL configuration bits.

        Returns
        -------
        int
            Total number of global configuration bits for the tile.
        """
        ret = self.matrixConfigBits

        for b in self.bels:
            ret += b.configBit

        return ret

    def getUserCLK(self) -> bool:
        return self.withUserCLK

    def getPortPairs(self) -> list[str]:
        return [
            [p.sourceName, p.destinationName, p.wireCount, p.name]
            for p in self.portsInfo
            if p.wireDirection != Direction.JUMP
        ]

    def getExternalTileIONames(self) -> list[str]:
        return [p for p in self.bels if p.name != "NULL"]

    def portInfo(self) -> list[Bel]:
        return self.bels

    def generateIOPinOrderConfig(self, outfile: Path, prefix: str = "") -> None:
        """Generates the I/O pin order configuration for a given tile.

        Parameters
        ----------
        tile : Tile
            The tile for which to generate the I/O pin order configuration.
        outfile : Path
            The output file path where the configuration will be saved.
        """
        port_dict = {"N": [], "E": [], "S": [], "W": []}

        for p in self.getNorthSidePorts():
            if r := p.getPortRegex(indexed=True, prefix=prefix):
                port_dict["N"].append(self.pinOrderConfig[Side.NORTH]([r]).to_dict())
        port_dict["N"].append(PinOrderConfig()([f"{prefix}UserCLKo"]).to_dict())
        port_dict["N"].append(
            PinOrderConfig()([rf"{prefix}FrameStrobe_O\[\d+\]"]).to_dict()
        )

        for p in self.getEastSidePorts():
            if r := p.getPortRegex(indexed=True, prefix=prefix):
                port_dict["E"].append(self.pinOrderConfig[Side.EAST]([r]).to_dict())
        port_dict["E"].append(
            PinOrderConfig()([rf"{prefix}FrameData_O\[\d+\]"]).to_dict()
        )

        for p in self.getSouthSidePorts():
            if r := p.getPortRegex(indexed=True, prefix=prefix):
                port_dict["S"].append(self.pinOrderConfig[Side.SOUTH]([r]).to_dict())
        port_dict["S"].append(PinOrderConfig()([f"{prefix}UserCLK"]).to_dict())
        port_dict["S"].append(
            PinOrderConfig()([rf"{prefix}FrameStrobe\[\d+\]"]).to_dict()
        )

        for p in self.getWestSidePorts():
            if r := p.getPortRegex(indexed=True, prefix=prefix):
                port_dict["W"].append(self.pinOrderConfig[Side.WEST]([r]).to_dict())
        port_dict["W"].append(
            PinOrderConfig()([rf"{prefix}FrameData\[\d+\]"]).to_dict()
        )

        for b in self.bels:
            if r := [f"{prefix}{i}" for i in b.externalInput + b.externalOutput]:
                port_dict["S"].append(self.pinOrderConfig[Side.SOUTH](r).to_dict())

        with outfile.open("w") as f:
            yaml.dump(port_dict, f)
