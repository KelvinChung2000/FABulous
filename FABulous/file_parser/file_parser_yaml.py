import re
from collections import defaultdict
from pathlib import Path

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
from FABulous.fabric_definition.Port import TilePort
from FABulous.fabric_definition.SwitchMatrix import Mux, SwitchMatrix
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.Wire import Wire, WireType
from FABulous.file_parser.file_parser_csv import parseList, parseMatrix
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

    tileDict: dict[str, Tile] = {}
    wireDictUnprocessed: dict[str, WireInfo] = {}

    for i in data["TILES"]:
        newTile, wireInfo = parseTileYAML(filePath.joinpath(i))
        tileDict[newTile.name] = newTile
        wireDictUnprocessed[newTile.name] = wireInfo

    # TODO: parse supertiles
    superTileDict = {}
    # new_supertiles = parseSupertiles(fName, tileDic)
    # for new_supertile in new_supertiles:
    #     superTileDic[new_supertile.name] = new_supertile

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
            else:
                logger.error(f"Unknown tile {i}.")
                raise ValueError
        fabricTiles.append(fabricLine)

    for i in list(tileDict.keys()):
        if i not in usedTile:
            logger.info(
                f"Tile {i} is not used in the fabric. Removing from tile dictionary."
            )
            del tileDict[i]
    for i in list(superTileDict.keys()):
        if any(j.name not in usedTile for j in superTileDict[i].tiles):
            logger.info(
                f"Supertile {i} is not used in the fabric. Removing from tile dictionary."
            )
            del superTileDict[i]

    height = len(fabricTiles)
    width = len(fabricTiles[0])

    wireDict: dict[Loc, list[Wire]] = defaultdict(list)
    for y, row in enumerate(fabricTiles):
        for x, tileName in enumerate(row):
            # TODO add empty tile that have contains crossing wires
            if tileName is None:
                continue

            for wireEntry in wireDictUnprocessed[tileName]:
                tx = int(wireEntry["X-offset"])
                ty = int(wireEntry["Y-offset"])

                if tx == ty == 0:
                    continue

                sourcePort: TilePort = tileDict[tileName].findPortByName(
                    wireEntry["source_name"]
                )

                xCord = max(0, min(x + tx, width - 1))
                yCord = max(0, min(y + ty, height - 1))
                targetTileName = fabricTiles[yCord][xCord]
                if targetTileName is None:
                    continue
                destinationPort: TilePort = tileDict[targetTileName].findPortByName(
                    wireEntry["destination_name"]
                )

                if tx != 0 and ty != 0 and tx != ty:
                    logger.error(
                        f"Invalid wire offset detected: source port '{sourcePort.name}' to destination port '{destinationPort.name}' "
                        f"has an offset of X={tx}, Y={ty}. The offset must be either only in the X direction, only in the Y direction, "
                        "or both X and Y must be the same for diagonal."
                    )
                    raise ValueError
                if sourcePort.width != destinationPort.width:
                    logger.error(
                        f"Port {sourcePort.name} and {destinationPort.name} must have the same wire count."
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
                    WireType(
                        sourcePort=sourcePort,
                        destinationPort=destinationPort,
                        offsetX=tx,
                        offsetY=ty,
                        wireCount=sourcePort.width,
                        cascadeWireCount=wireCount,
                        spanning=spanning,
                    )
                )

    logger.info("Fabric YAML parsed successfully.")

    return Fabric(
        name=name,
        fabricDir=fileName,
        tiles=fabricTiles,
        numberOfColumns=width,
        numberOfRows=height,
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
        superTileDict=superTileDict,
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
            f"{tileName}_{portName}", [destList[j] for j in indices], portName, 1
        )
    return connectionsDic


def parseTileYAML(fileName: Path) -> tuple[Tile, WireInfo]:
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

    tileName = data.get("TILE", None)
    portsDict: dict[str, TilePort] = {}
    bels: list[Bel] = []
    matrixDir: Path | None = None
    withUserCLK = False
    configBit = 0
    wires: WireInfo = []

    if p := data.get("INCLUDE", None):
        if isinstance(p, str):
            p = [p]
        for i in p:
            iTile, iWireInfo = parseTileYAML(filePathParent.joinpath(i))
            for ports in iTile.ports:
                portsDict[ports.name] = ports
            for bel in iTile.bels:
                bels.append(bel)
            wires.extend(iWireInfo)

    for portEntry in data.get("PORTS", []):
        portsDict[f"{portEntry["name"]}"] = TilePort(
            width=int(portEntry["wires"]),
            name=portEntry["name"],
            ioDirection=IO[portEntry["inOut"].upper()],
            sideOfTile=Side[portEntry["side"].upper()],
            isBus=portEntry.get("isBus", False),
            terminal=portEntry.get("terminal", False),
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
        configBit += b.configBit

    if mPath := data.get("MATRIX", None):
        matrixDir = fileName.parent.joinpath(mPath)
        configBit = 0
        match matrixDir.suffix:
            case ".list":
                sm = SwitchMatrix()
                for mux in parseList(matrixDir):
                    sm.addMux(mux)
                configBit += sm.configBits
            case ".py":
                setupPortData(tileName, matrixDir, list(portsDict.values()), bels)
                sm = genSwitchMatrix(
                    tileName, matrixDir, list(portsDict.values()), bels
                )
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
            32,
            32,
            configBit,
        )
    else:
        configMems = []
    wires.extend(data.get("WIRES", {}))
    return (
        Tile(
            name=tileName,
            ports=list(portsDict.values()),
            bels=bels,
            switchMatrix=sm,
            configMems=configMems,
            globalConfigBits=configBit,
            withUserCLK=withUserCLK,
            tileDir=fileName,
        ),
        wires,
    )


def parseConfigMem(
    fileName: Path, maxFramePerCol: int, frameBitPerRow: int, configBitCount: int
):
    pass
