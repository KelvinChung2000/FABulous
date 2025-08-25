from enum import StrEnum
from typing import NamedTuple


class IO(StrEnum):
    INPUT = "input"
    OUTPUT = "output"
    INOUT = "inout"
    NULL = "null"


class Direction(StrEnum):
    NORTH = "NORTH"
    SOUTH = "SOUTH"
    EAST = "EAST"
    WEST = "WEST"
    JUMP = "JUMP"


class Side(StrEnum):
    NORTH = "NORTH"
    SOUTH = "SOUTH"
    EAST = "EAST"
    WEST = "WEST"
    ANY = "ANY"


class MultiplexerStyle(StrEnum):
    CUSTOM = "CUSTOM"
    GENERIC = "GENERIC"


class ConfigBitMode(StrEnum):
    FRAME_BASED = "FRAME_BASED"
    FLIPFLOP_CHAIN = "FLIPFLOP_CHAIN"


class FeatureType(StrEnum):
    ENUMERATE = "ENUMERATE"
    INIT = "INIT"
    ONE_HOT = "ONE_HOT"
    FEATURE_MAP = "FEATURE_MAP"


class FeatureValue(NamedTuple):
    name: str
    value: int | None

    def value_as_bitstring(self) -> str:
        if self.value is None:
            return "x"
        if isinstance(self.value, int):
            return f"{self.value:01b}"
        raise ValueError(f"Invalid value type: {type(self.value)} for {self.name}")


Loc = tuple[int, int]
