from dataclasses import dataclass
from enum import Enum


@dataclass(eq=True, order=True, frozen=True)
class IdString:
    index: int = 0
    value: str = ""


class PinType(Enum):
    INPUT = 0
    OUTPUT = 1
    INOUT = 2


class ClockEdge(Enum):
    RISING = 0
    FALLING = 1


# Pre deduplication (nodes flattened, absolute coords)
@dataclass
class NodeWire:
    x: int
    y: int
    wire: str
    wire: str
