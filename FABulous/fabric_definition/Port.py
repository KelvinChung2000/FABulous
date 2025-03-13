from dataclasses import dataclass, field
from typing import Any

from FABulous.fabric_definition.define import IO, FeatureType, Side


@dataclass(frozen=True, eq=True)
class Port:
    name: str
    ioDirection: IO
    wireCount: int
    isBus: bool

    def __repr__(self) -> str:
        return f"Port({self.ioDirection.value} {self.name}[{self.wireCount-1}:0])"

    def createSelf(self) -> str:
        return (
            f"Port(name='{self.name}', ioDirection=IO.{self.ioDirection.upper()}, "
            f"wireCount={self.wireCount}, isBus={self.isBus})"
        )


@dataclass(frozen=True, eq=True)
class TilePort(Port):
    """TilePort is a subclass of Port that represents a port on a tile with a specific
    side and terminal status. It is an immutable and comparable dataclass. When sorting
    a list of TilePort instances, the order is determined first by the side of the tile
    in order of [north, east, south, west] then by the IO type in the order of [output,
    input, inout].

    Attributes:
        sideOfTile (Side): The side of the tile where the port is located.
        terminal (bool): Indicates if the port is a terminal port. Defaults to False.

    Class Attributes:
        __order (dict): A dictionary mapping each Side to an integer for comparison purposes.
        __io (dict): A dictionary mapping each IO type to an integer for comparison purposes.

    Methods:
        __lt__(__o: Any) -> bool:
            Compares if the current TilePort instance is less than another TilePort instance.

        __le__(__o: Any) -> bool:
            Compares if the current TilePort instance is less than or equal to another TilePort instance.

        __gt__(__o: Any) -> bool:
            Compares if the current TilePort instance is greater than another TilePort instance.

        __ge__(__o: Any) -> bool:
            Compares if the current TilePort instance is greater than or equal to another TilePort instance.
    """

    sideOfTile: Side
    terminal: bool = False

    __order = {Side.NORTH: 0, Side.EAST: 1, Side.SOUTH: 2, Side.WEST: 3, Side.ANY: 4}
    __io = {IO.OUTPUT: 0, IO.INPUT: 1, IO.INOUT: 2}

    def __repr__(self) -> str:
        return f"TilePort({{{self.sideOfTile}}} {self.ioDirection.value} {self.name}[{self.wireCount-1}:0])"

    def createSelf(self) -> str:
        return (
            f"TilePort(name='{self.name}', ioDirection=IO.{self.ioDirection.upper()}, "
            f"wireCount={self.wireCount}, isBus={self.isBus}, sideOfTile=Side.{self.sideOfTile}, "
            f"terminal={self.terminal})"
        )

    def __lt__(self, __o: Any) -> bool:
        if not isinstance(__o, TilePort):
            raise ValueError(f"Cannot compare {self} with {__o}")
        return (self.__order[self.sideOfTile], self.__io[self.ioDirection]) < (
            self.__order[__o.sideOfTile],
            self.__io[__o.ioDirection],
        )

    def __le__(self, __o: Any) -> bool:
        if not isinstance(__o, TilePort):
            raise ValueError(f"Cannot compare {self} with {__o}")
        return (self.__order[self.sideOfTile], self.__io[self.ioDirection]) <= (
            self.__order[__o.sideOfTile],
            self.__io[__o.ioDirection],
        )

    def __gt__(self, __o: Any) -> bool:
        if not isinstance(__o, TilePort):
            raise ValueError(f"Cannot compare {self} with {__o}")
        return (self.__order[self.sideOfTile], self.__io[self.ioDirection]) > (
            self.__order[__o.sideOfTile],
            self.__io[__o.ioDirection],
        )

    def __ge__(self, __o: Any) -> bool:
        if not isinstance(__o, TilePort):
            raise ValueError(f"Cannot compare {self} with {__o}")
        return (self.__order[self.sideOfTile], self.__io[self.ioDirection]) >= (
            self.__order[__o.sideOfTile],
            self.__io[__o.ioDirection],
        )


@dataclass(frozen=True, eq=True)
class SlicedPort(Port):
    sliceRange: tuple[int, int]
    originalPort: Port


@dataclass(frozen=True, eq=True)
class BelPort(Port):
    prefix: str
    external: bool
    control: bool

    def __repr__(self) -> str:
        return f"BelPort({self.ioDirection.value} {self.prefix}{self.name}[{self.wireCount-1}:0])"

    def createSelf(self) -> str:
        return (
            f"BelPort(name='{self.name}', ioDirection=IO.{self.ioDirection.upper()}, "
            f"wireCount={self.wireCount}, isBus={self.isBus}, prefix='{self.prefix}', "
            f"external={self.external}, control={self.control})"
        )


@dataclass(frozen=True, eq=True)
class ConfigPort(Port):
    features: list[tuple[str, int]] = field(default_factory=list)
    featureType: FeatureType = FeatureType.INIT

    def __repr__(self) -> str:
        return f"ConfigPort({self.ioDirection.value} {self.name}[{self.wireCount-1}:0])"


@dataclass(frozen=True, eq=True)
class SharedPort(Port):
    sharedWith: str = ""


GenericPort = Port | TilePort | SlicedPort | BelPort | ConfigPort | SharedPort
