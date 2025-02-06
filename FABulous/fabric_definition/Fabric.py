from collections import defaultdict
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import ConfigBitMode, MultiplexerStyle
from FABulous.fabric_definition.SuperTile import SuperTile
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.Wire import Wire


@dataclass
class Fabric:
    """This class is for storing the information and hyperparameters of the fabric. All
    the information is parsed from the CSV file.

    Attributes
    ----------
    tile : list[list[Tile]]
        The tile map of the fabric
    name : str
        The name of the fabric
    numberOfRow : int
        The number of rows of the fabric
    numberOfColumn : int
        The number of columns of the fabric
    configMitMode : ConfigBitMode
        The configuration bit mode of the fabric. Currently supports frame based or ff chain
    frameBitsPerRow : int
        The number of frame bits per row of the fabric
    maxFramesPerCol : int
        The maximum number of frames per column of the fabric
    package : str
        The extra package used by the fabric. Only useful for VHDL output.
    generateDelayInSwitchMatrix : int
        The amount of delay in a switch matrix.
    multiplexerStyle : MultiplexerStyle
        The style of the multiplexer used in the fabric. Currently supports custom or generic
    frameSelectWidth : int
        The width of the frame select signal.
    rowSelectWidth : int
        The width of the row select signal.
    desync_flag : int
        The flag indicating desynchronization status, used to manage timing issues within the fabric.
    numberOfBRAMs : int
        The number of BRAMs in the fabric.
    superTileEnable : bool
        Whether the fabric has super tile.
    tileDic : dict[str, Tile]
        A dictionary of tiles used in the fabric. The key is the name of the tile and the value is the tile.
    superTileDic : dict[str, SuperTile]
        A dictionary of super tiles used in the fabric. The key is the name of the super tile and the value is the super tile.
    """

    tile: list[list[Tile]] = field(default_factory=list)

    name: str = "eFPGA"
    fabricDir: Path = Path()
    numberOfRows: int = 15
    numberOfColumns: int = 15
    configBitMode: ConfigBitMode = ConfigBitMode.FRAME_BASED
    frameBitsPerRow: int = 32
    maxFramesPerCol: int = 20
    contextCount: int = 1
    package: str = "use work.my_package.all"
    generateDelayInSwitchMatrix: int = 80
    multiplexerStyle: MultiplexerStyle = MultiplexerStyle.CUSTOM
    frameSelectWidth: int = 5
    rowSelectWidth: int = 5
    desync_flag: int = 20
    numberOfBRAMs: int = 10
    superTileEnable: bool = True

    tileDict: dict[str, Tile] = field(default_factory=dict)
    superTileDict: dict[str, SuperTile] = field(default_factory=dict)
    wireDict: dict[tuple[int, int], list[Wire]] = field(default_factory=dict)

    def __getitem__(self, index: Any) -> Tile | SuperTile | None:
        if isinstance(index, tuple):
            return self.tile[index[1]][index[0]]
        if isinstance(index, str):
            if index in self.tileDict:
                return self.tileDict[index]
            elif index in self.superTileDict:
                return self.superTileDict[index]
        else:
            raise ValueError("Invalid index for Fabric")

    def __repr__(self) -> str:
        fabric = ""
        for i in range(self.numberOfRows):
            for j in range(self.numberOfColumns):
                if self.tile[i][j] is None:
                    fabric += "Null".ljust(15) + "\t"
                else:
                    fabric += f"{str(self.tile[i][j].name).ljust(15)}\t"
            fabric += "\n"

        fabric += (
            "\n"
            f"numberOfColumns: {self.numberOfColumns}\n"
            f"numberOfRows: {self.numberOfRows}\n"
            f"configBitMode: {self.configBitMode}\n"
            f"frameBitsPerRow: {self.frameBitsPerRow}\n"
            f"maxFramesPerCol: {self.maxFramesPerCol}\n"
            f"package: {self.package}\n"
            f"generateDelayInSwitchMatrix: {self.generateDelayInSwitchMatrix}\n"
            f"multiplexerStyle: {self.multiplexerStyle}\n"
            f"superTileEnable: {self.superTileEnable}\n"
            f"tileDic: {list(self.tileDict.keys())}\n"
        )

        return fabric

    def getTileByName(self, name: str) -> Tile | None:
        return self.tileDict.get(name)

    def getSuperTileByName(self, name: str) -> SuperTile | None:
        return self.superTileDict.get(name)

    def getAllUniqueBels(self) -> list[Bel]:
        bels = list()
        for tile in self.tileDict.values():
            bels.extend(tile.bels)
        return bels

    def getTotalBelCount(self) -> int:
        tileCountDict = defaultdict(int)
        for row in self.tile:
            for tile in row:
                if tile is not None:
                    tileCountDict[tile.name] += 1

        return sum(
            len(self.getTileByName(tile).bels) * count
            for tile, count in tileCountDict.items()
        )
