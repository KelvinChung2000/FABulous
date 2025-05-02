from pprint import pprint
import re
from collections import defaultdict
from pathlib import Path
from typing import Generator, Mapping

import yaml
from loguru import logger

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import (
    IO,
    ConfigBitMode,
    Loc,
    MultiplexerStyle,
    Side,
)
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort, TilePort
from FABulous.fabric_definition.SwitchMatrix import Mux, SwitchMatrix
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.Wire import Wire, WireType
from FABulous.fabric_generator.ConfigMem_genenrator import generateConfigMemInit
from FABulous.file_parser.file_parser_csv import parseConfigMem, parseList, parseMatrix
from FABulous.file_parser.file_parser_HDL import parseBelFile
from FABulous.file_parser.parse_py_mux import genSwitchMatrix, setupPortData

oppositeDic = {
    "NORTH": "SOUTH",
    "SOUTH": "NORTH",
    "EAST": "WEST",
    "WEST": "EAST",
    "JUMP": "ANY",
}

WireInfo = list[dict]
MainTileName = str
SubTileName = str


def parseFabricYAML(fileName: Path) -> Fabric:
    fileName = Path(fileName)
    if fileName.suffix != ".yaml":
        logger.error("File must be a csv file")
        raise ValueError

    if not fileName.exists():
        logger.error(f"File {fileName} does not exist.")
        raise ValueError

    with open(fileName, "r") as f:
        data = yaml.safe_load(f)

    filePath = fileName.parent

    # parse the parameters
    param = data["PARAM"]
    height = 0
    width = 0
    name = param.get("Name", "eFPGA")
    configBitMode = ConfigBitMode[param.get("ConfigBitMode", "FRAME_BASED").upper()]
    frameBitsPerRow = int(param.get("FrameBitsPerRow", 32))
    maxFramesPerCol = int(param.get("MaxFramesPerCol", 32))
    contextCount = int(param.get("ContextCount", 1))
    package = param.get("Package", "use work.my_package.all;")
    generateDelayInSwitchMatrix = int(param.get("GenerateDelayInSwitchMatrix", 80))
    multiplexerStyle = MultiplexerStyle[param.get("MultiplexerStyle", "CUSTOM").upper()]
    superTileEnable = param.get("SuperTileEnable", True)

    tileDict: dict[str, Tile] = {}
    wireDictUnprocessed: dict[MainTileName, dict[SubTileName, WireInfo]] = {}

    tileNameMap: Mapping[str, str] = {}

    for mainTile in data["TILES"]:
        newTile, wireInfo = parseTileYAML(
            filePath.joinpath(mainTile), frameBitsPerRow, maxFramesPerCol
        )
        for subTile in newTile.getSubTiles():
            tileDict[newTile.name] = newTile
            tileNameMap[subTile] = newTile.name
            wireDictUnprocessed.update(wireInfo)

    usedTile = set()
    fabricTiles: list[list[str | None]] = []
    for row in data["FABRIC"]:
        fabricLine = []
        for i in row:
            if i in tileDict:
                fabricLine.append(i)
                usedTile.add(i)
            elif i == "Null" or i == "NULL" or i == "None":
                fabricLine.append(None)
            elif any([t.partOfTile(i) for t in tileDict.values()]):
                fabricLine.append(i)
            else:
                logger.opt(exception=ValueError()).error(f"Unknown tile {i}.")

        fabricTiles.append(fabricLine)

    height = len(fabricTiles)
    width = len(fabricTiles[0])

    def tileIter() -> Generator[tuple[Loc, str], None, None]:
        for y, row in enumerate(reversed(fabricTiles)):
            for x, tileName in enumerate(row):
                if tileName is not None:
                    yield (x, y), tileName

    wireDict: dict[Loc, list[Wire]] = defaultdict(list)
    for (x, y), subTileName in tileIter():
        # TODO add empty tile that have contains crossing wires
        if subTileName is None:
            continue
        tileName = tileNameMap.get(subTileName, subTileName)
        wireEntries = wireDictUnprocessed[tileName][subTileName]
        for wireEntry in wireEntries:
            tx = int(wireEntry["X-offset"])
            ty = int(wireEntry["Y-offset"])

            if tx == ty == 0:
                continue

            sourcePort: TilePort | BelPort = tileDict[tileName].findPortByName(
                wireEntry["source_name"]
            )

            xCord = max(0, min(x + tx, width - 1))
            yCord = (height - 1) - max(0, min(y + ty, height - 1))
            targetTileName = fabricTiles[yCord][xCord]
            if targetTileName is None:
                continue
            targetTileName = tileNameMap.get(targetTileName, targetTileName)
            destinationPort: TilePort | BelPort = tileDict[
                targetTileName
            ].findPortByName(wireEntry["destination_name"])

            if tx != 0 and ty != 0 and tx != ty and not wireEntry.get("super", False):
                logger.error(
                    f"Invalid wire offset detected: source port '{sourcePort.name}' to destination port '{destinationPort.name}' "
                    f"has an offset of X={tx}, Y={ty}. The offset must be either only in the X direction, only in the Y direction, "
                    "or both X and Y must be the same for diagonal."
                )
                raise ValueError
            if sourcePort.width != destinationPort.width:
                logger.error(
                    f"Source port {sourcePort.name} and destination {destinationPort.name} must have the same wire count."
                )
                raise ValueError

            spanning = 0
            if abs(tx) + abs(ty) > 1 and tx != ty:
                wireCount = sourcePort.width * (abs(tx) + abs(ty))
                spanning = abs(tx) + abs(ty)
            elif tx == ty:
                wireCount = sourcePort.width * abs(tx)
                spanning = abs(tx)
            else:
                wireCount = sourcePort.width
                spanning = 0
            wireDict[(x, y)].append(
                Wire(
                    source=sourcePort,
                    xOffset=tx,
                    yOffset=ty,
                    destination=destinationPort,
                    sourceTile=f"X{x}Y{y}",
                    destinationTile=f"X{x + tx}Y{y + ty}",
                    wireCount=wireCount,
                )
            )

            tileDict[tileName].addWireType(
                subTileName,
                WireType(
                    sourcePort=sourcePort,
                    destinationPort=destinationPort,
                    offsetX=tx,
                    offsetY=ty,
                    wireCount=sourcePort.width,
                    cascadeWireCount=wireCount,
                    spanning=spanning,
                ),
            )
    logger.info("Fabric YAML parsed successfully.")
    return Fabric(
        name=name,
        fabricDir=fileName,
        tiles=fabricTiles,
        width=width,
        height=height,
        configBitMode=configBitMode,
        frameBitsPerRow=frameBitsPerRow,
        maxFramesPerCol=maxFramesPerCol,
        frameSelectWidth=maxFramesPerCol.bit_length(),
        rowSelectWidth=height.bit_length(),
        contextCount=contextCount,
        package=package,
        generateDelayInSwitchMatrix=generateDelayInSwitchMatrix,
        multiplexerStyle=multiplexerStyle,
        numberOfBRAMs=int(height / 2),
        superTileEnable=superTileEnable,
        tileDict=tileDict,
        wireDict=wireDict,
    )


def parseMatrixAsMux(fileName: Path, tileName: str) -> dict[str, Mux]:
    connectionsDic = {}
    with open(fileName, "r") as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)
        file = file.split("\n")

    if file[0].split(",")[0] != tileName:
        logger.error(f"{fileName} {file[0].split(',')} {tileName}")
        logger.error(
            "Tile name (top left element) in csv file does not match tile name in tile object"
        )
        raise ValueError
    destList = file[0].split(",")[1:]

    for i in file[1:]:
        i = i.split(",")
        portName, connections = i[0], i[1:]
        if portName == "":
            continue
        indices = [k for k, v in enumerate(connections) if v == "1"]
        connectionsDic[portName] = Mux(
            f"{tileName}_{portName}", [destList[j] for j in indices], portName
        )
    return connectionsDic


def parseTileYAML(
    fileName: Path, frameBitsPerRow: int, maxFramePerCol: int
) -> tuple[Tile, dict[str, dict[str, WireInfo]]]:
    """Parses a yaml tile configuration file and returns all tile objects.

    Args:
        fileName (Path):
            The path to the yaml file
    """

    logger.info(f"Reading tile configuration: {fileName}")

    if fileName.suffix != ".yaml":
        logger.error("File must be a YAML file.")
        raise ValueError

    if not fileName.exists():
        logger.error(f"File {fileName} does not exist.")
        raise ValueError

    filePathParent = fileName.parent

    with open(fileName, "r") as f:
        data = yaml.safe_load(f)

    tileName = data.get("TILE", "")
    portsDict: dict[SubTileName, list[TilePort]] = defaultdict(list)
    bels: list[Bel] = []
    matrixDir: Path | None = None
    withUserCLK = False
    configBit = 0
    wires: dict[MainTileName, dict[SubTileName, WireInfo]] = defaultdict(
        lambda: defaultdict(list)
    )

    tileMap: list[list[str]] = []
    for i in data.get("SUB_TILE_MAP", [[tileName]]):
        row = []
        for j in i:
            if j in ["None", "NULL", None]:
                row.append(None)
            else:
                row.append(j)
        tileMap.append(row)

    if tileMap[-1][0] is None:
        raise ValueError(
            "The bottom left corner of the tile map must be filled with a tile."
        )

    # Flatten the tileMap and count the number of items
    flatTileMap = [item for row in tileMap for item in row if item is not None]
    if len(data.get("PORTS", {})) != len(flatTileMap) and len(flatTileMap) != 1:
        logger.opt(exception=ValueError()).error(
            f"Tile map for {tileName} does not match the number of ports. "
            f"Expected {len(portsDict)} but got {len(flatTileMap)}."
        )

    if p := data.get("INCLUDE", None):
        if isinstance(p, str):
            p = [p]
        for i in p:
            iTile, iWireInfo = parseTileYAML(
                filePathParent.joinpath(i), frameBitsPerRow, maxFramePerCol
            )
            for ports, item in iTile.ports.items():
                for fm in flatTileMap:
                    portsDict[fm].extend(item)
            for bel in iTile.bels:
                bels.append(bel)

            for tName in flatTileMap:
                for iTileName, subTiles in iWireInfo.items():
                    for iSubTileName, wireInfos in subTiles.items():
                        wires[tileName][tName].extend(wireInfos)

    if len(flatTileMap) == 1:
        portsDict[tileName] = []
        for portEntry in data.get("PORTS", []):
            portsDict[tileName].append(
                TilePort(
                    width=int(portEntry["wires"]),
                    name=portEntry["name"],
                    ioDirection=IO[portEntry["inOut"].upper()],
                    sideOfTile=Side[portEntry["side"].upper()],
                    isBus=portEntry.get("isBus", False),
                    terminal=portEntry.get("terminal", False),
                    tileType=tileName,
                )
            )
    else:
        for tName in flatTileMap:
            for portEntry in data.get("PORTS", {})[tName]:
                portsDict[tName].append(
                    TilePort(
                        width=int(portEntry["wires"]),
                        name=f"{portEntry['name']}",
                        ioDirection=IO[portEntry["inOut"].upper()],
                        sideOfTile=Side[portEntry["side"].upper()],
                        isBus=portEntry.get("isBus", False),
                        terminal=portEntry.get("terminal", False),
                        tileType=tileName,
                    )
                )

    bels = []
    for z, belEntry in enumerate(data.get("BELS", [])):
        belFilePath = filePathParent.joinpath(belEntry["BEL"])
        if belEntry["prefix"] is None:
            belEntry["prefix"] = ""

        bel = parseBelFile(belFilePath, belEntry["prefix"])
        bel.z = z
        bels.append(bel)

    withUserCLK = any(bel.userCLK for bel in bels)
    for b in bels:
        configBit += b.configBits

    if mPath := data.get("MATRIX", None):
        matrixDir = fileName.parent.joinpath(mPath)
        match matrixDir.suffix:
            case ".list":
                sm = SwitchMatrix()
                for mux in parseList(matrixDir):
                    sm.addMux(mux)
                configBit += sm.configBits
            case ".py":
                setupPortData(tileName, matrixDir, portsDict, bels)
                sm = genSwitchMatrix(tileName, matrixDir, portsDict, bels)
                configBit += sm.configBits
            case "_matrix.csv":
                for _, v in parseMatrix(matrixDir, tileName).items():
                    muxSize = len(v)
                    if muxSize >= 2:
                        configBit += muxSize.bit_length() - 1
            case ".vhdl" | ".v":
                with open(matrixDir, "r") as f:
                    f = f.read()
                    if configBit := re.search(r"NumberOfConfigBits: (\d+)", f):
                        configBit = int(configBit.group(1))
                    else:
                        configBit = 0
                        logger.warning(
                            f"Cannot find NumberOfConfigBits in {matrixDir} assume 0 config bits."
                        )
            case _:
                logger.error(
                    f"Unknown file extension '{matrixDir.suffix}' for tile {tileName} switch matrix."
                )
                raise ValueError(
                    f"Unknown file extension '{matrixDir.suffix}' for tile {tileName} switch matrix."
                )
    else:
        sm = SwitchMatrix()

    if p := data.get("CONFIG_MEM", None):
        configMems = parseConfigMem(
            fileName.parent.joinpath(p),
            frameBitsPerRow=frameBitsPerRow,
            maxFramePerCol=maxFramePerCol,
            configBit=configBit,
        )
    else:
        dstPath = fileName.parent.joinpath(f"{tileName}_configMem.csv")
        generateConfigMemInit(dstPath, configBit, frameBitsPerRow, maxFramePerCol)
        configMems = parseConfigMem(
            dstPath,
            frameBitsPerRow=frameBitsPerRow,
            maxFramePerCol=maxFramePerCol,
            configBit=configBit,
        )

    if len(flatTileMap) == 1:
        wires[tileName][tileName].extend(data.get("WIRES", []))
    else:
        for tName in flatTileMap:
            wires[tileName][tName].extend(data.get("WIRES", {}).get(tName, []))

    for y, row in enumerate(reversed(tileMap)):
        for x, st in enumerate(row):
            if st is None:
                continue
            if (x, y) == (0, 0):
                continue
            for bel in bels:
                for p in bel.inputs + bel.outputs:
                    wires[tileName][tileMap[-1][0]].append(
                        {
                            "X-offset": x,
                            "Y-offset": y,
                            "source_name": p.name,
                            "destination_name": p.name,
                            "super": True,
                        }
                    )
    return (
        Tile(
            name=tileName,
            ports=portsDict,
            bels=bels,
            switchMatrix=sm,
            configMems=configMems,
            withUserCLK=withUserCLK,
            tileDir=fileName,
            tileMap=tileMap,
        ),
        wires,
    )
