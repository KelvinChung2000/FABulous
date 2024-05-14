from enum import Enum, IntEnum


class IO(Enum):
    INPUT = "INPUT"
    OUTPUT = "OUTPUT"
    INOUT = "INOUT"
    NULL = "NULL"


class Direction(Enum):
    NORTH = (1, 0)
    SOUTH = (-1, 0)
    EAST = (1, 0)
    WEST = (-1, 0)
    JUMP = (0, 0)


class Side(Enum):
    NORTH = (1, 0)
    SOUTH = (-1, 0)
    EAST = (1, 0)
    WEST = (-1, 0)
    ANY = (0, 0)


class MultiplexerStyle(Enum):
    CUSTOM = "CUSTOM"
    GENERIC = "GENERIC"


class ConfigBitMode(Enum):
    FRAME_BASED = "FRAME_BASED"
    FLIPFLOP_CHAIN = "FLIPFLOP_CHAIN"
