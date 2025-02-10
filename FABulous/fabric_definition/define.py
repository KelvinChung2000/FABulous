from enum import StrEnum


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


class FABulousPortType(StrEnum):
    EXTERNAL = "EXTERNAL"
    CONFIG_BIT = "CONFIG_BIT"
    USER_CLK = "USER_CLK"
    GLOBAL = "GLOBAL"
    BUS = "BUS"
    SHARED = "SHARED"


class FeatureType(StrEnum):
    ENUMERATE = "ENUMERATE"
    INIT = "INIT"
    ONE_HOT = "ONE_HOT"
    FEATURE_MAP = "FEATURE_MAP"


Loc = tuple[int, int]