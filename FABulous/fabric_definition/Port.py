from dataclasses import dataclass
from typing import Any

from FABulous.fabric_definition.define import IO, FeatureType, Side


@dataclass(frozen=True, eq=True)
class Port:
    name: str
    ioDirection: IO
    wireCount: int
    isBus: bool


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

    __order = {Side.NORTH: 0, Side.EAST: 1, Side.SOUTH: 2, Side.WEST: 3}
    __io = {IO.OUTPUT: 0, IO.INPUT: 1, IO.INOUT: 2}

    def __lt__(self, __o: Any) -> bool:
        if not isinstance(__o, TilePort):
            return False
        return (self.__order[self.sideOfTile], self.__io[self.ioDirection]) < (
            self.__order[__o.sideOfTile],
            self.__io[self.ioDirection],
        )

    def __le__(self, __o: Any) -> bool:
        if not isinstance(__o, TilePort):
            return False
        return (self.__order[self.sideOfTile], self.__io[self.ioDirection]) <= (
            self.__order[__o.sideOfTile],
            self.__io[self.ioDirection],
        )

    def __gt__(self, __o: Any) -> bool:
        if not isinstance(__o, TilePort):
            return False
        return (self.__order[self.sideOfTile], self.__io[self.ioDirection]) > (
            self.__order[__o.sideOfTile],
            self.__io[self.ioDirection],
        )

    def __ge__(self, __o: Any) -> bool:
        if not isinstance(__o, TilePort):
            return False
        return (self.__order[self.sideOfTile], self.__io[self.ioDirection]) >= (
            self.__order[__o.sideOfTile],
            self.__io[self.ioDirection],
        )


@dataclass(frozen=True, eq=True)
class ConfigPort(Port):
    feature: str = ""
    featureType: FeatureType = FeatureType.INIT


# @dataclass(frozen=True, eq=True)
# class Port:
#     """The port data class contains all the port information from the CSV file.
#     The `name`, `inOut` and `sideOfTile` are added attributes to aid the generation of the fabric.
#     The name and inOut are related. If the inOut is "INPUT" then the name is the source name of the port on the tile.
#     Otherwise the name is the destination name of the port on the tile.
#     The `sideOfTile` defines where the port is physically located on the tile, since for a north direction wire, the input will
#     be physically located on the south side of the tile. The `sideOfTile` will make determining where the port is located
#     much easier.

#     Attributes
#     ----------
#     wireDirection : Direction
#         The direction attribute in the CSV file
#     sourceName : str
#         The source_name attribute in the CSV file
#     xOffset : int
#         The X-offset attribute in the CSV file
#     yOffset : int
#         The Y-offset attribute in the CSV file
#     destinationName : str
#         The destination_name attribute in the CSV file
#     wireCount : int
#         The wires attribute in the CSV file
#     name : str
#         The name of the port
#     inOut : IO
#         The IO direction of the port
#     sideOfTile : Side
#         The side on which the port is physically located in the tile
#     isBus : bool
#         Define is the port is a bus or not. Default is False
#     """

#     wireDirection: Direction
#     sourceName: str
#     xOffset: int
#     yOffset: int
#     destinationName: str
#     wireCount: int
#     name: str
#     inOut: IO
#     sideOfTile: Side
#     isBus: bool = False

#     def __repr__(self) -> str:
#         return f"Port(Name={self.name}, IO={self.inOut.value}, XOffset={self.xOffset}, YOffset={self.yOffset}, WireCount={self.wireCount}, Side={self.sideOfTile.value})"

#     def expandPortInfoByName(self, indexed=False) -> list[str]:
#         if self.sourceName == "NULL" or self.destinationName == "NULL":
#             wireCount = (abs(self.xOffset) + abs(self.yOffset)) * self.wireCount
#         else:
#             wireCount = self.wireCount
#         if not indexed:
#             return [f"{self.name}{i}" for i in range(wireCount) if self.name != "NULL"]
#         else:
#             return [
#                 f"{self.name}[{i}]" for i in range(wireCount) if self.name != "NULL"
#             ]

#     def expandPortInfoByNameTop(self, indexed=False) -> list[str]:
#         if self.sourceName == "NULL" or self.destinationName == "NULL":
#             startIndex = 0
#         else:
#             startIndex = ((abs(self.xOffset) + abs(self.yOffset)) - 1) * self.wireCount

#         wireCount = (abs(self.xOffset) + abs(self.yOffset)) * self.wireCount

#         if not indexed:
#             return [
#                 f"{self.name}{i}"
#                 for i in range(startIndex, wireCount)
#                 if self.name != "NULL"
#             ]
#         else:
#             return [
#                 f"{self.name}[{i}]"
#                 for i in range(startIndex, wireCount)
#                 if self.name != "NULL"
#             ]

#     def expandPortInfo(self, mode="SwitchMatrix") -> tuple[list[str], list[str]]:
#         """Expanding the port information to the individual bit signal. If 'Indexed' is in the mode, then brackets are added to the signal name.

#         Args
#         ----
#         mode : str, optional
#             Mode for expansion. Defaults to "SwitchMatrix".
#             Possible modes are 'all', 'allIndexed', 'Top', 'TopIndexed', 'AutoTop',
#             'AutoTopIndexed', 'SwitchMatrix', 'SwitchMatrixIndexed', 'AutoSwitchMatrix',
#             'AutoSwitchMatrixIndexed'
#         Returns
#         -------
#         Tuple : [list[str], list[str]]
#             A tuple of two lists. The first list contains the source names of the ports
#             and the second list contains the destination names of the ports.
#         """
#         inputs, outputs = [], []
#         thisRange = 0
#         openIndex = ""
#         closeIndex = ""

#         if "Indexed" in mode:
#             openIndex = "("
#             closeIndex = ")"

#         # range (wires-1 downto 0) as connected to the switch matrix
#         if mode == "SwitchMatrix" or mode == "SwitchMatrixIndexed":
#             thisRange = self.wireCount
#         elif mode == "AutoSwitchMatrix" or mode == "AutoSwitchMatrixIndexed":
#             if self.sourceName == "NULL" or self.destinationName == "NULL":
#                 # the following line connects all wires to the switch matrix in the case one port is NULL (typically termination)
#                 thisRange = (abs(self.xOffset) + abs(self.yOffset)) * self.wireCount
#             else:
#                 # the following line connects all bottom wires to the switch matrix in the case begin and end ports are used
#                 thisRange = self.wireCount
#         # range ((wires*distance)-1 downto 0) as connected to the tile top
#         elif mode in [
#             "all",
#             "allIndexed",
#             "Top",
#             "TopIndexed",
#             "AutoTop",
#             "AutoTopIndexed",
#         ]:
#             thisRange = (abs(self.xOffset) + abs(self.yOffset)) * self.wireCount

#         # the following three lines are needed to get the top line[wires] that are actually the connection from a switch matrix to the routing fabric
#         startIndex = 0
#         if mode in ["Top", "TopIndexed"]:
#             startIndex = ((abs(self.xOffset) + abs(self.yOffset)) - 1) * self.wireCount

#         elif mode in ["AutoTop", "AutoTopIndexed"]:
#             if self.sourceName == "NULL" or self.destinationName == "NULL":
#                 # in case one port is NULL, then the all the other port wires get connected to the switch matrix.
#                 startIndex = 0
#             else:
#                 # "normal" case as for the CLBs
#                 startIndex = (
#                     (abs(self.xOffset) + abs(self.yOffset)) - 1
#                 ) * self.wireCount
#         if startIndex == thisRange:
#             thisRange = 1

#         for i in range(startIndex, thisRange):
#             if self.sourceName != "NULL":
#                 inputs.append(f"{self.sourceName}{openIndex}{str(i)}{closeIndex}")

#             if self.destinationName != "NULL":
#                 outputs.append(f"{self.destinationName}{openIndex}{str(i)}{closeIndex}")
#         return inputs, outputs
#         return inputs, outputs
