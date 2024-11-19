from dataclasses import dataclass
from FABulous.fabric_definition.Port import Port, TilePort
from typing import Any

@dataclass(frozen=True, eq=True)
class WireType:
    sourcePort: Port | TilePort
    destinationPort: Port | TilePort
    offsetX: int
    offsetY: int

@dataclass(frozen=True, eq=True)
class Wire:
    """This class is for wire connections that span across multiple tiles.
    If working for connections between two adjacent tiles, the Port class should have all the required information.
    The main use of this class is to assist model generation, where information at individual wire level is needed.

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

    def __repr__(self) -> str:
        return f"{self.source.name}-X{self.xOffset}Y{self.yOffset}>{self.destination.name}"

    def __eq__(self, __o: Any) -> bool:
        if __o is None or not isinstance(__o, Wire):
            return False
        return self.source == __o.source and self.destination == __o.destination
