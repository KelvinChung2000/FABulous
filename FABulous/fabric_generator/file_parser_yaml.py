import re
from copy import deepcopy
from pathlib import Path

import yaml
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import (
    IO,
    ConfigBitMode,
    MultiplexerStyle,
    Side,
)
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Mux import Mux
from FABulous.fabric_definition.Port import TilePort
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.Wire import Wire, WireType
from FABulous.fabric_generator.file_parser_csv import parseList, parseMatrix
from FABulous.fabric_generator.file_parser_HDL import parseBelFile
from FABulous.fabric_generator.file_parser_list import parseMux
from loguru import logger

oppositeDic = {
    "NORTH": "SOUTH",
    "SOUTH": "NORTH",
    "EAST": "WEST",
    "WEST": "EAST",
    "JUMP": "ANY",
}


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

    tileTypes = []
    tileDefs = []

    for i in data["TILES"]:
        new_tile = parseTileYAML(filePath.joinpath(i))
        tileTypes.append(new_tile.name)
        tileDefs.append(new_tile)

    tileDic = dict(zip(tileTypes, tileDefs))

    # TODO: parse supertiles
    superTileDic = {}
    # new_supertiles = parseSupertiles(fName, tileDic)
    # for new_supertile in new_supertiles:
    #     superTileDic[new_supertile.name] = new_supertile

    # parse the parameters
    param = data["PARAM"]
    height = 0
    width = 0
    configBitMode = ConfigBitMode[param.get("ConfigBitMode", "FRAME_BASED").upper()]
    frameBitsPerRow = int(param.get("FrameBitsPerRow", 32))
    maxFramesPerCol = int(param.get("MaxFramesPerCol", 32))
    contextCount = int(param.get("ContextCount", 1))
    package = param.get("Package", "use work.my_package.all;")
    generateDelayInSwitchMatrix = int(param.get("GenerateDelayInSwitchMatrix", 80))
    multiplexerStyle = MultiplexerStyle[param.get("MultiplexerStyle", "CUSTOM").upper()]
    superTileEnable = param.get("SuperTileEnable", True)

    usedTile = set()
    fabricTiles: list[list[Tile]] = []
    for row in data["FABRIC"]:
        fabricLine = []
        for i in row:
            if i in tileDic:
                fabricLine.append(deepcopy(tileDic[i]))
                usedTile.add(i)
            elif i == "Null" or i == "NULL" or i == "None":
                fabricLine.append(None)
            else:
                logger.error(f"Unknown tile {i}.")
                raise ValueError
        fabricTiles.append(fabricLine)

    for i in list(tileDic.keys()):
        if i not in usedTile:
            logger.info(f"Tile {i} is not used in the fabric. Removing from tile dictionary.")
            del tileDic[i]
    for i in list(superTileDic.keys()):
        if any(j.name not in usedTile for j in superTileDic[i].tiles):
            logger.info(f"Supertile {i} is not used in the fabric. Removing from tile dictionary.")
            del superTileDic[i]

    height = len(fabricTiles)
    width = len(fabricTiles[0])

    wireDict = {}
    for y, row in enumerate(fabricTiles):
        for x, tile in enumerate(row):
            wires = []
            if tile is None:
                continue
            for wireType in tile.wireTypes:
                if wireType.sourcePort.inOut != IO.OUTPUT and wireType.destinationPort.inOut != IO.INPUT:
                    logger.error(
                        f"Wire {wireType} must be an output port as source_name and input port as destination_name ."
                    )
                    raise ValueError

                wires.append(
                    Wire(
                        source=wireType.sourcePort,
                        destination=wireType.destinationPort,
                        xOffset=wireType.offsetX,
                        yOffset=wireType.offsetY,
                        sourceTile=f"X{x}Y{y}",
                        destinationTile=f"X{x+wireType.offsetX}Y{y+wireType.offsetY}",
                    )
                )
            wireDict[(x, y)] = wires

    return Fabric(
        tile=fabricTiles,
        numberOfColumns=width,
        numberOfRows=height,
        configBitMode=configBitMode,
        frameBitsPerRow=frameBitsPerRow,
        maxFramesPerCol=maxFramesPerCol,
        contextCount=contextCount,
        package=package,
        generateDelayInSwitchMatrix=generateDelayInSwitchMatrix,
        multiplexerStyle=multiplexerStyle,
        numberOfBRAMs=int(height / 2),
        superTileEnable=superTileEnable,
        tileDict=tileDic,
        superTileDict=superTileDic,
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
        logger.error("Tile name (top left element) in csv file does not match tile name in tile object")
        raise ValueError
    destList = file[0].split(",")[1:]

    for i in file[1:]:
        i = i.split(",")
        portName, connections = i[0], i[1:]
        if portName == "":
            continue
        indices = [k for k, v in enumerate(connections) if v == "1"]
        connectionsDic[portName] = Mux(f"{tileName}_{portName}", [destList[j] for j in indices], portName, 1)
    return connectionsDic


def parseTileYAML(fileName: Path) -> Tile:
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

    tileName = data["TILE"]
    portsDict: dict[str, TilePort] = {}
    bels: list[Bel] = []
    wires: list[WireType] = []
    matrixDir: Path | None = None
    withUserCLK = False
    configBit = 0

    normalPorts = set()

    for portEntry in data["PORTS"]:
        portsDict[portEntry["name"]] = TilePort(
            wireCount=int(portEntry["wires"]),
            name=portEntry["name"],
            inOut=IO[portEntry["inOut"].upper()],
            sideOfTile=Side[portEntry["side"].upper()],
            isBus=portEntry.get("isBus", False),
            terminal=portEntry.get("terminal", False),
        )

        if not portEntry.get("terminal", False):
            normalPorts.add(portEntry["name"])

    for wireEntry in data.get("WIRES", {}):
        sourcePort = portsDict[wireEntry["source_name"]]
        destinationPort = portsDict[wireEntry["destination_name"]]
        wires.append(
            WireType(
                sourcePort=sourcePort,
                destinationPort=destinationPort,
                offsetX=wireEntry["X-offset"],
                offsetY=wireEntry["Y-offset"],
            )
        )
        normalPorts.discard(wireEntry["source_name"])
        normalPorts.discard(wireEntry["destination_name"])

    if normalPorts:
        logger.error(f"Port {normalPorts} does not have a connection, when defined as non terminal.")
        raise ValueError

    bels = []
    for belEntry in data["BELS"]:
        belFilePath = filePathParent.joinpath(belEntry["BEL"])
        if belEntry["prefix"] is None:
            belEntry["prefix"] = ""
        if belEntry["BEL"].endswith(".vhdl"):
            bels.append(parseBelFile(belFilePath, belEntry["prefix"], "vhdl"))
        elif belEntry["BEL"].endswith(".v"):
            bels.append(parseBelFile(belFilePath, belEntry["prefix"], "verilog"))
        else:
            raise ValueError(f"Invalid file type in {belFilePath} only .vhdl and .v are supported.")

    matrixDir = fileName.parent.joinpath(data["MATRIX"])
    configBit = 0
    match matrixDir.suffix:
        case ".list":
            for _, v in parseList(matrixDir, "source").items():
                muxSize = len(v)
                if muxSize >= 2:
                    configBit += muxSize.bit_length() - 1
        case ".mux":
            for i in parseMux(matrixDir):
                muxSize = len(i.inputs)
                if muxSize >= 2:
                    configBit += muxSize.bit_length() - 1
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
                    logger.warning(f"Cannot find NumberOfConfigBits in {matrixDir} assume 0 config bits.")
        case _:
            logger.error("Unknown file extension for matrix.")
            raise ValueError("Unknown file extension for matrix.")

    muxList = parseMux(matrixDir)

    if p := data["INCLUDE"]:
        p = fileName.parent.joinpath(p)
        if not p.exists():
            logger.error(f"Cannot find {str(p)} in tile {tileName}")
            raise ValueError
        with open(p) as f:
            iFile = f.read()
            iFile = re.sub(r"#.*", "", iFile)
        for line in iFile.split("\n"):
            lineItem = line.split(",")
            if not lineItem[0]:
                continue

            port, commonWirePair = parsePortLine(line)
            ports.extend(port)
            if commonWirePair:
                commonWirePairs.append(commonWirePair)

    withUserCLK = any(bel.userCLK for bel in bels)
    for b in bels:
        configBit += b.configBit

    return Tile(
        name=tileName,
        ports=list(portsDict.values()),
        bels=bels,
        wireTypes=wires,
        switchMatrix=muxList,
        globalConfigBits=configBit,
        withUserCLK=withUserCLK,
        tileDir=fileName,
    )
