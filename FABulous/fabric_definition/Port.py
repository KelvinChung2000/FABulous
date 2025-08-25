from typing import Any

from FABulous.fabric_definition.define import IO, FeatureType, FeatureValue, Side


class Port:
    _name: str
    _ioDirection: IO
    _width: int

    __slots__ = ("_name", "_ioDirection", "_width")

    def __init__(self, name: str, ioDirection: IO, width: int) -> None:
        self._name = name
        self._ioDirection = ioDirection
        self._width = width

        if self.width <= 0:
            raise ValueError(f"Width must be greater than 0, got {self.width}")
        if not isinstance(self.ioDirection, IO):
            raise TypeError(
                f"ioDirection must be an instance of IO, got {type(self.ioDirection)}"
            )
        if not isinstance(self._name, str):
            raise TypeError(f"name must be a string, got {type(self._name)}")

    def __repr__(self) -> str:
        return f"Port({self.ioDirection.value} {self.name}[{self.width - 1}:0])"

    @property
    def name(self):
        return self._name

    @property
    def ioDirection(self):
        return self._ioDirection

    @property
    def width(self):
        return self._width

    def expand(self) -> list[str]:
        """Expand the port name into a generator of strings based on the width.

        Yields:
            Iterator[str]: A generator that yields the expanded port names.
        """
        if self.width == 1:
            return [f"{self.name}"]
        return [f"{self.name}[{i}]" for i in range(self.width)]

    def __eq__(self, __o: object) -> bool:
        if __o is None or not isinstance(__o, Port):
            return False
        return self is __o

    def __hash__(self) -> int:
        return id(self)

    def serialize(self) -> dict:
        """Serialize the port to a dictionary."""
        return {
            "name": self.name,
            "ioDirection": self.ioDirection.value,
            "width": self.width,
        }


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

    _sideOfTile: Side
    _terminal: bool
    _tileType: str

    __slots__ = ("_sideOfTile", "_terminal", "_tileType")

    def __init__(
        self,
        name: str,
        ioDirection: IO,
        width: int,
        sideOfTile: Side,
        terminal: bool = False,
        tileType: str = "",
    ) -> None:
        super().__init__(name, ioDirection, width)
        self._sideOfTile = sideOfTile
        self._terminal = terminal
        self._tileType = tileType

    __order = {Side.NORTH: 0, Side.EAST: 1, Side.SOUTH: 2, Side.WEST: 3, Side.ANY: 4}
    __io = {IO.OUTPUT: 0, IO.INPUT: 1, IO.INOUT: 2}

    @property
    def sideOfTile(self) -> Side:
        return self._sideOfTile

    @property
    def terminal(self) -> bool:
        return self._terminal

    @property
    def tileType(self) -> str:
        return self._tileType

    def __repr__(self) -> str:
        return f"TilePort({{{self.sideOfTile}}} {self.ioDirection.value} {self.name}[{self.width - 1}:0])"

    def __hash__(self) -> int:
        return super().__hash__()

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

    def serialize(self) -> dict:
        return super().serialize() | {
            "sideOfTile": self.sideOfTile.value,
            "terminal": self.terminal,
            "tileType": self.tileType,
        }


class SlicedPort(Port):
    _sliceRange: tuple[int, int]
    _originalPort: Port

    __slots__ = ("_slicedWidth", "_sliceRange", "_originalPort")

    def __init__(
        self,
        originalPort: Port,
        sliceRange: tuple[int, int] = (-1, -1),
    ) -> None:
        super().__init__(
            originalPort.name,
            originalPort.ioDirection,
            sliceRange[0] - sliceRange[1] + 1,
        )
        self._originalPort = originalPort
        self._sliceRange = sliceRange

    @property
    def originalPort(self) -> Port:
        return self._originalPort

    @property
    def sliceRange(self) -> tuple[int, int]:
        return self._sliceRange

    def expand(self) -> list[str]:
        if isinstance(self.originalPort, BelPort | TilePort):
            return [
                f"{self.originalPort.name}[{i}]"
                for i in range(self.sliceRange[0], self.sliceRange[1] + 1)
            ]
        if isinstance(self.originalPort, SlicedPort):
            r = self.originalPort.expand()
            return [r[i] for i in range(self.sliceRange[0], self.sliceRange[1] + 1)]
        raise ValueError(f"type {type(self.originalPort)} not supported for slicing")

    def __hash__(self) -> int:
        return super().__hash__()

    def __repr__(self) -> str:
        return f"SlicedPort({self.ioDirection.value} {self.name}[{self.sliceRange[0]}:{self.sliceRange[1]}] from {self.originalPort.name})"

    def serialize(self) -> dict:
        return super().serialize() | {
            "sliceRange": self.sliceRange,
            "originalPort": self.originalPort.name,
        }


class BelPort(Port):
    _prefix: str
    _external: bool
    _control: bool

    __slots__ = ("_prefix", "_external", "_control")

    def __init__(
        self,
        name: str,
        ioDirection: IO,
        width: int,
        prefix: str = "",
        external: bool = False,
        control: bool = False,
    ) -> None:
        super().__init__(name, ioDirection, width)
        self._prefix = prefix
        self._external = external
        self._control = control

    @property
    def prefix(self) -> str:
        return self._prefix

    @property
    def external(self) -> bool:
        return self._external

    @property
    def control(self) -> bool:
        return self._control

    def __repr__(self) -> str:
        return f"BelPort({self.ioDirection.value} {self.name}[{self.width - 1}:0])"

    @property
    def name(self) -> str:
        return f"{self.prefix}{self._name}"

    def expand(self) -> list[str]:
        """Expand the port name into a generator of strings based on the width.

        Yields:
            Iterator[str]: A generator that yields the expanded port names.
        """
        if self.width == 1:
            return [f"{self.name}"]
        return [f"{self.name}[{i}]" for i in range(self.width)]

    def __hash__(self) -> int:
        return super().__hash__()

    def serialize(self) -> dict:
        return super().serialize() | {
            "prefix": self.prefix,
            "external": self.external,
            "control": self.control,
        }


class ConfigPort(Port):
    _features: list[FeatureValue]
    _featureType: FeatureType

    __slots__ = ("_features", "_featureType")

    def __init__(
        self,
        name: str,
        ioDirection: IO,
        width: int,
        features: list[FeatureValue] = None,
        featureType: FeatureType = FeatureType.ENUMERATE,
    ) -> None:
        if features is None:
            features = []
        super().__init__(name, ioDirection, width)
        self._features = features
        self._featureType = featureType

    @property
    def features(self) -> list[FeatureValue]:
        return self._features

    @property
    def featureType(self) -> FeatureType:
        return self._featureType

    def __repr__(self) -> str:
        return f"ConfigPort({self.ioDirection.value} {self.name}[{self.width - 1}:0], features={self.features})"

    def __hash__(self) -> int:
        return super().__hash__()

    def serialize(self) -> dict:
        return super().serialize() | {
            "features": self.features,
            "featureType": self.featureType.value,
        }


class SharedPort(Port):
    _sharedWith: str

    __slots__ = ("_sharedWith",)

    def __init__(
        self,
        name: str,
        ioDirection: IO,
        width: int,
        sharedWith: str = "",
    ) -> None:
        super().__init__(name, ioDirection, width)
        self._sharedWith = sharedWith

    @property
    def sharedWith(self) -> str:
        return self._sharedWith

    def shareExpand(self) -> list[str]:
        """Expand the port name into a generator of strings based on the width.

        Yields:
            Iterator[str]: A generator that yields the expanded port names.
        """
        expand = []
        if self.width == 1:
            expand.append(f"{self.sharedWith}")
        else:
            for i in range(self.width):
                expand.append(f"{self.sharedWith}[{i}]")

        return expand

    def __hash__(self) -> int:
        return super().__hash__()

    def serialize(self) -> dict:
        return super().serialize() | {"sharedWith": self.sharedWith}


GenericPort = Port | TilePort | SlicedPort | BelPort | ConfigPort | SharedPort
