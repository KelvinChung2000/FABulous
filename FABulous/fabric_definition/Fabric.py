from collections import defaultdict
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Generator, Iterable

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import ConfigBitMode, Loc, MultiplexerStyle
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

    name: str
    fabricDir: Path
    height: int
    width: int
    frameBitsPerRow: int
    maxFramesPerCol: int
    contextCount: int = 1
    configBitMode: ConfigBitMode = ConfigBitMode.FRAME_BASED
    multiplexerStyle: MultiplexerStyle = MultiplexerStyle.CUSTOM
    package: str = "use work.my_package.all"
    generateDelayInSwitchMatrix: int = 80
    frameSelectWidth: int = 5
    rowSelectWidth: int = 5
    desync_flag: int = 20
    numberOfBRAMs: int = 10
    superTileEnable: bool = True

    tiles: list[list[str | None]] = field(default_factory=list)
    tileDict: dict[str, Tile] = field(default_factory=dict)
    superTileDict: dict[str, SuperTile] = field(default_factory=dict)
    wireDict: dict[Loc, list[Wire]] = field(default_factory=dict)

    def __getitem__(self, index: Any) -> Tile | SuperTile | None:
        if isinstance(index, tuple):
            if t := self.tiles[index[1]][index[0]]:
                return self.tileDict[t]
            return None
        if isinstance(index, str):
            if index in self.tileDict:
                return self.tileDict[index]
            elif index in self.superTileDict:
                return self.superTileDict[index]
            else:
                raise ValueError(f"Cannot find '{index}' in Fabric")
        else:
            raise ValueError("Invalid index for Fabric")

    def __repr__(self) -> str:
        fabric = ""
        for i in range(self.height):
            for j in range(self.width):
                if self.tiles[i][j] is None:
                    fabric += "Null".ljust(15) + "\t"
                else:
                    fabric += f"{str(self.tiles[i][j]).ljust(15)}\t"
            fabric += "\n"

        fabric += (
            "\n"
            f"numberOfColumns: {self.width}\n"
            f"numberOfRows: {self.height}\n"
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

    def getTileByName(self, name: str) -> Tile:
        for i in self.tileDict.values():
            for j in i.getSubTiles():
                if j == name:
                    return i
        raise ValueError(f"Cannot find tile '{name}' in Fabric")

    def getSuperTileByName(self, name: str) -> SuperTile | None:
        return self.superTileDict.get(name)

    def getAllUniqueBels(self) -> Iterable[Bel]:
        bels = list()
        belSet = set()
        for tile in self.tileDict.values():
            for i in tile.bels:
                if i.name not in belSet:
                    bels.append(i)
                    belSet.add(i.name)
        return bels

    def getTotalBelCount(self) -> int:
        tileCountDict = defaultdict(int)
        for row in self.tiles:
            for tile in row:
                if tile is not None:
                    tileCountDict[tile] += 1

        return sum(
            len(self.getTileByName(tile).bels) * count
            for tile, count in tileCountDict.items()
        )

    def __iter__(self) -> Generator[tuple[Loc, Tile | None], None, None]:
        for y, row in enumerate(reversed(self.tiles)):
            for x, tile in enumerate(row):
                loc = (x, y)
                if tile is not None:
                    t: Tile
                    for i in self.tileDict.values():
                        if i.partOfTile(tile):
                            t = i
                            break
                    else:
                        raise ValueError(f"Cannot find tile {tile} in Fabric")
                    yield (loc, t)

                else:
                    yield (loc, None)

    def tileNames_iter(self) -> Generator[tuple[Loc, str | None], None, None]:
        for y, row in enumerate(self.tiles):
            for x, tile in enumerate(row):
                loc = (x, self.height - y - 1)
                yield (loc, tile)

    # def getFlattenFabric(self) -> Generator[tuple[Loc, Tile | None], None, None]:
    #     for y, row in enumerate(self.tiles):
    #         for x, tile in enumerate(row):
    #             if tile is not None:
    #                 yield ((x, y), self.tileDict.get(tile, None))
    #             else:
    #                 yield ((x, y), None)
