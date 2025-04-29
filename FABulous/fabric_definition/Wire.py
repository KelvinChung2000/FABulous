from dataclasses import dataclass
from typing import Any

from FABulous.fabric_definition.Port import BelPort, Port, TilePort


@dataclass(frozen=True, eq=True)
class WireType:
    sourcePort: TilePort | BelPort
    destinationPort: TilePort | BelPort
    offsetX: int
    offsetY: int
    wireCount: int
    cascadeWireCount: int
    spanning: int = 0

    def __repr__(self) -> str:
        return f"{self.sourcePort.name}-X{self.offsetX}Y{self.offsetY}>{self.destinationPort.name}"

    def __eq__(self, __o: Any) -> bool:
        if __o is None or not isinstance(__o, WireType):
            return False
        return (
            self.sourcePort == __o.sourcePort
            and self.destinationPort == __o.destinationPort
        )


@dataclass(frozen=True, eq=True)
class Wire:
    """This class is for wire connections that span across multiple tiles. If working
    for connections between two adjacent tiles, the Port class should have all the
    required information. The main use of this class is to assist model generation,
    where information at individual wire level is needed.

    Attributes
    ----------
    source : str
        The source name of the wire
    xOffset : int
        The X-offset of the wire
    yOffset : int
        The Y-offset of the wire
    destination : str
        The destination name of the wire
    sourceTile : str
        The source tile name of the wire
    destinationTile : str
        The destination tile name of the wire
    """

    source: Port | TilePort
    xOffset: int
    yOffset: int
    destination: Port | TilePort
    sourceTile: str
    destinationTile: str
    wireCount: int

    def __repr__(self) -> str:
        return (
            f"{self.source.name}-X{self.xOffset}Y{self.yOffset}>{self.destination.name}"
        )
