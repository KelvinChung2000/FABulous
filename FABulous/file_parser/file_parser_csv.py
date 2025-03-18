import csv
import re
from collections import defaultdict
from copy import deepcopy
from pathlib import Path

from loguru import logger

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.ConfigMem import (
    ConfigBitMapping,
    ConfigMem,
    ConfigurationMemory,
)
from FABulous.fabric_definition.define import (
    IO,
    ConfigBitMode,
    Loc,
    MultiplexerStyle,
    Side,
)
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import Port, TilePort
from FABulous.fabric_definition.SuperTile import SuperTile
from FABulous.fabric_definition.SwitchMatrix import Mux, SwitchMatrix
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.Wire import Wire, WireType
from FABulous.fabric_generator.utilities import expandListPorts
from FABulous.file_parser.file_parser_HDL import parseBelFile

oppositeDic = {
    "NORTH": "SOUTH",
    "SOUTH": "NORTH",
    "EAST": "WEST",
    "WEST": "EAST",
    "JUMP": "ANY",
}


def parseFabricCSV(fileName: Path) -> Fabric:
    """Parses a CSV file and returns a fabric object.

    Parameters
    ----------
    fileName : Path
        Directory of the CSV file.

    Raises
    ------
    ValueError
        - File provided is not a CSV file.
        - CSV file does not exist.
        - FabricBegin and FabricEnd regions cannot be found.
        - ParametersBegin and ParametersEnd regions cannot be found.
        - Bel entry extension is not ".v" or ".vhdl".
        - Matrix entry extension is not ".list", ".csv", ".v", or ".vhdl".
        - Unknown tile description entry is found in the CSV file.
        - Unknown tile is found in the fabric entry in the CSV file.
        - Unknown super tile is found in the super tile entry in the CSV file.
        - Invalid ConfigBitMode is found in the parameter entry in the CSV file.
        - Invalid MultiplexerStyle is found in the parameter entry in the CSV file.
        - Invalid parameter entry is found in the CSV file.

    Returns
    -------
    Fabric
        The fabric object.
    """

    fName = Path(fileName)
    if fName.suffix != ".csv":
        logger.error("File must be a csv file")
        raise ValueError

    if not fName.exists():
        logger.error(f"File {fName} does not exist.")
        raise ValueError

    filePath = fName.parent

    with open(fName, "r") as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)

    # read in the csv file and part them
    if fabricDescription := re.search(
        r"FabricBegin(.*?)FabricEnd", file, re.MULTILINE | re.DOTALL
    ):
        fabricDescription = fabricDescription.group(1)
    else:
        logger.error("Cannot find FabricBegin and FabricEnd in csv file.")
        raise ValueError

    if parameters := re.search(
        r"ParametersBegin(.*?)ParametersEnd", file, re.MULTILINE | re.DOTALL
    ):
        parameters = parameters.group(1)
    else:
        logger.error("Cannot find ParametersBegin and ParametersEnd in csv file.")
        raise ValueError

    fabricDescription = fabricDescription.split("\n")
    parameters = parameters.split("\n")

    # Lists for tiles
    tileTypes = []
    tileDefs = []
    commonWirePair: list[tuple[str, str]] = []

    fabricTiles = []
    tileDict = {}

    # list for supertiles
    superTileDic = {}

    new_supertiles = parseSupertiles(fName, tileDict)
    for new_supertile in new_supertiles:
        superTileDic[new_supertile.name] = new_supertile

    # parse the parameters
    height = 0
    width = 0
    configBitMode = ConfigBitMode.FRAME_BASED
    frameBitsPerRow = 32
    maxFramesPerCol = 20
    package = "use work.my_package.all;"
    generateDelayInSwitchMatrix = 80
    multiplexerStyle = MultiplexerStyle.CUSTOM
    superTileEnable = True
    name = "eFPGA"

    for i in parameters:
        i = i.split(",")
        i = [j for j in i if j != ""]
        if not i:
            continue
        if len(i) == 1:
            raise ValueError(f"Invalid parameter {i} in parameters.")
        key, value = i

        match key:
            case "Name":
                name = value
            case "Tile":
                newTile, wireInfo = parseTiles(filePath.joinpath(i[1]))
                tileDict[newTile.name] = newTile
                wireDictUnprocessed[newTile.name] = wireInfo
            case "ConfigBitMode":
                try:
                    configBitMode = ConfigBitMode[value.upper()]
                except KeyError:
                    logger.error(
                        f"Invalid config bit mode {value} in parameters. Valid options are frame_based and FlipFlop_Chain."
                    )
                    raise ValueError
            case "FrameBitsPerRow":
                frameBitsPerRow = int(value)
            case "MaxFramesPerCol":
                maxFramesPerCol = int(value)
            case "Package":
                package = value
            case "GenerateDelayInSwitchMatrix":
                generateDelayInSwitchMatrix = int(value)
            case "MultiplexerStyle":
                try:
                    multiplexerStyle = MultiplexerStyle[value.upper()]
                except KeyError:
                    logger.error(
                        f"Invalid multiplexer style {value} in parameters. Valid options are custom and generic."
                    )
                    raise ValueError
            case "SuperTileEnable":
                superTileEnable = value == "TRUE"
            case "Supertile":
                continue
            case _:
                logger.error(f"Invalid parameter {key} in parameters.")
                raise ValueError(f"Invalid parameter {key} in parameters.")

    # form the fabric data structure
    usedTile = set()
    for f in fabricDescription:
        fabricLineTmp = f.split(",")
        fabricLineTmp = [i for i in fabricLineTmp if i != ""]
        if not fabricLineTmp:
            continue
        fabricLine = []
        for i in fabricLineTmp:
            if i in tileDict:
                fabricLine.append(i)
                usedTile.add(i)
            elif i == "Null" or i == "NULL" or i == "None":
                fabricLine.append(None)
            else:
                logger.error(f"Unknown tile {i}.")
                raise ValueError
        fabricTiles.append(fabricLine)

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

                sourcePort: TilePort = tileDict[tileName].findPortByName(
                    wireEntry["source_name"]
                )
                destinationPort: TilePort = tileDict[
                    fabricTiles[y + ty][x + tx]
                ].findPortByName(wireEntry["destination_name"])

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

                spanning = False
                if abs(x) + abs(y) > 1 and x != y:
                    wireCount = sourcePort.width * (abs(x) + abs(y))
                    spanning = True
                elif x == y:
                    wireCount = sourcePort.width * abs(x)
                    spanning = True
                else:
                    wireCount = sourcePort.width

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
                        offsetX=wireEntry["X-offset"],
                        offsetY=wireEntry["Y-offset"],
                        wireCount=sourcePort.width,
                        cascadeWireCount=wireCount,
                        spanning=spanning,
                    )
                )

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
        contextCount=1,
        package=package,
        generateDelayInSwitchMatrix=generateDelayInSwitchMatrix,
        multiplexerStyle=multiplexerStyle,
        numberOfBRAMs=int(height / 2),
        superTileEnable=superTileEnable,
        tileDict=tileDict,
        superTileDict=superTileDic,
        wireDict=wireDict,
    )


def parseMatrix(fileName: Path, tileName: str) -> dict[str, list[str]]:
    """Parse the matrix CSV into a dictionary from destination to source.

    Parameters
    ----------
    fileName : Path
        Directory of the matrix CSV file.
    tileName : str
        Name of the tile needed to be parsed.

    Raises
    ------
    ValueError
        Non matching matrix file content and tile name

    Returns
    -------
    dict : [str, list[str]]
        Dictionary from destination to a list of sources.
    """

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
        connectionsDic[portName] = [destList[j] for j in indices]
    return connectionsDic


def parseList(filePath: Path) -> list[Mux]:
    """Parse a list file and expand the list file information into a list of tuples.

    Parameters
    ----------
    fileName : Path
        ""
    collect : (Literal["", "source", "sink"], optional)
        Collect value by source, sink or just as pair. Defaults to "pair".

    Raises
    ------
    ValueError
        The file does not exist.
    ValueError
        Invalid format in the list file.

    Returns
    -------
    Union : [list[tuple[str, str]], dict[str, list[str]]]
        Return either a list of connection pairs or a dictionary of lists which is collected by the specified option, source or sink.
    """
    if not filePath.exists():
        logger.error(f"The file {filePath} does not exist.")
        raise ValueError

    muxList: list[Mux] = []
    resultList: list = []
    with open(filePath, "r") as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)
    file = file.split("\n")
    for i, line in enumerate(file):
        line = line.replace(" ", "").replace("\t", "").split(",")
        line = [i for i in line if i != ""]
        if not line:
            continue
        if len(line) != 2:
            logger.error(f"Invalid list formatting in file: {filePath} at line {i}")
            logger.error(f"Line: {line}")
            raise ValueError
        left, right = line[0], line[1]

        if left == "INCLUDE":
            muxList.extend(parseList(filePath.parent.joinpath(right)))
            continue

        leftList = []
        rightList = []
        expandListPorts(left, leftList)
        expandListPorts(right, rightList)
        if len(leftList) != len(rightList):
            raise ValueError(
                f"List file {filePath} does not have the same number of source and sink ports."
            )
        resultList += list(zip(leftList, rightList))

    result: list[tuple[str, str]] = list(dict.fromkeys(resultList))

    def wrapDigit(s: str):
        index = len(s) - 1
        while index > 0 and s[index].isdigit():
            index -= 1
        index += 1
        if index != len(s):
            return f"{s[:index]}[{s[index:]}]"
        return f"{s}[0]"

    resultDic = {}
    for k, v in result:
        if k not in resultDic:
            resultDic[k] = []
        resultDic[k].append(v)

    for k, v in resultDic.items():
        inputs = [Port(i, IO.INPUT, 1, False) for i in v]
        output = Port(k, IO.OUTPUT, 1, False)
        muxList.append(Mux(k, inputs, output))

    return muxList


def parsePortLine(line: str) -> tuple[list[TilePort], WireType]:
    temp: list[str] = line.split(",")

    terminal = temp[1] == "NULL" or temp[4] == "NULL"
    sideOfTile = Side[temp[0].upper()] if temp[0] != "JUMP" else Side.ANY
    tilePorts: list[TilePort] = []
    tilePorts.append(
        TilePort(
            width=int(temp[5]),
            name=f"{temp[1]}",
            ioDirection=IO.OUTPUT,
            sideOfTile=sideOfTile,
            isBus=False,
            terminal=terminal,
        )
    )
    tilePorts.append(
        TilePort(
            width=int(temp[5]),
            name=f"{temp[4]}",
            ioDirection=IO.INPUT,
            sideOfTile=sideOfTile,
            isBus=False,
            terminal=terminal,
        )
    )

    sourcePort = deepcopy(tilePorts[0])
    destPort = deepcopy(tilePorts[1])
    x = int(temp[2])
    y = int(temp[3])

    spanning = False
    if abs(x) + abs(y) > 1 and x != y:
        wireCount = sourcePort.width * (abs(x) + abs(y))
        spanning = True
    elif x == y:
        wireCount = sourcePort.width * abs(x)
        spanning = True
    else:
        wireCount = sourcePort.width
    wire = WireType(
        sourcePort=sourcePort,
        destinationPort=destPort,
        offsetX=x,
        offsetY=y,
        wireCount=sourcePort.width,
        cascadeWireCount=wireCount,
        spanning=spanning,
    )
    return (tilePorts, wire)


def parseTiles(fileName: Path) -> list[Tile]:
    """Parses a CSV tile configuration file and returns all tile objects.

    Parameters
    ----------
    fileName : str
        The path to the CSV file.

    Returns
    -------
    Tuple[List[Tile], List[Tuple[str, str]]]
        A tuple containing a list of Tile objects and a list of common wire pairs.
    """
    logger.info(f"Reading tile configuration: {fileName}")

    if fileName.suffix != ".csv":
        logger.error("File must be a CSV file.")
        raise ValueError

    if not fileName.exists():
        logger.error(f"File {fileName} does not exist.")
        raise ValueError

    filePathParent = fileName.parent

    with open(fileName, "r") as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)

    tilesData = re.findall(r"TILE(.*?)EndTILE", file, re.MULTILINE | re.DOTALL)

    new_tiles = []

    # Parse each tile config
    for t in tilesData:
        t = t.split("\n")
        tileName = t[0].split(",")[1]
        ports: list[TilePort] = []
        bels: list[Bel] = []
        matrixDir: Path | None = None
        wires: list[WireType] = []
        withUserCLK = False
        configMems: ConfigurationMemory | None = None
        configBit = 0
        sm = SwitchMatrix()
        for item in t:
            temp: list[str] = item.split(",")
            if not temp or temp[0] == "":
                continue

            match temp[0]:
                case "NORTH" | "SOUTH" | "EAST" | "WEST" | "JUMP":
                    port, wire = parsePortLine(item)
                    ports.extend(port)
                    wires.append(wire)
                case "BEL":
                    belFilePath = filePathParent.joinpath(temp[1])
                    bels.append(parseBelFile(belFilePath, temp[2]))
                case "MATRIX":
                    matrixDir = fileName.parent.joinpath(temp[1])
                    for i in parseList(matrixDir):
                        sm.addMux(i)
                    configBit = 0
                case "INCLUDE":
                    p = fileName.parent.joinpath(temp[1])
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
                        port, wire = parsePortLine(line)
                        ports.extend(port)
                        wires.append(wire)
                case "CONFIG_MEM":
                    configMems = parseConfigMem(fileName.parent.joinpath(temp[1]))
                case _:
                    logger.error(f"Unknown tile description {temp[0]} in CSV file.")

        if configMems is None:
            configMems = ConfigurationMemory([], [])
        new_tiles.append(
            Tile(
                name=tileName,
                ports=ports,
                bels=bels,
                wireTypes=wires,
                switchMatrix=sm,
                configMems=configMems,
                configBits=configBit,
                withUserCLK=withUserCLK,
                tileDir=fileName,
            )
        )

    return new_tiles


def parseSupertiles(fileName: Path, tileDic: dict[str, Tile]) -> list[SuperTile]:
    """Parses a CSV supertile configuration file and returns all SuperTile objects.

    Parameters
    ----------
    fileName : str
        The path to the CSV file.
    tileDic : Dict[str, Tile]
        Dict of tiles.

    Returns
    -------
    List[SuperTile]
        List of SuperTile objects.
    """
    logger.info(f"Reading supertile configuration: {fileName}")

    if not fileName.suffix == ".csv":
        logger.error("File must be a csv file.")
        raise ValueError

    if not fileName.exists():
        logger.error(f"File {fileName} does not exist.")
        raise ValueError

    filePath = fileName.parent

    with open(fileName, "r") as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)

    superTilesData = re.findall(
        r"SuperTILE(.*?)EndSuperTILE", file, re.MULTILINE | re.DOTALL
    )

    new_supertiles = []

    # Parse each supertile config
    for t in superTilesData:
        description = t.split("\n")
        name = description[0].split(",")[1]
        tileMap = []
        tiles = []
        bels = []
        withUserCLK = False
        for i in description[1:-1]:
            line = i.split(",")
            line = [i for i in line if i != "" and i != " "]
            row = []

            if line[0] == "BEL":
                belFilePath = filePath.joinpath(line[1])
                bels.append(parseBelFile(belFilePath, line[2]))

            for j in line:
                if j in tileDic:
                    # mark the tile as part of super tile
                    tileDic[j].partOfSuperTile = True
                    t = deepcopy(tileDic[j])
                    row.append(t)
                    if t not in tiles:
                        tiles.append(t)
                elif j == "Null" or j == "NULL" or j == "None":
                    row.append(None)
                else:
                    logger.error(
                        f"The super tile {name} contains definitions that are not tiles or Null."
                    )
                    raise ValueError
            tileMap.append(row)

        withUserCLK = any(bel.withUserCLK for bel in bels)
        new_supertiles.append(SuperTile(name, tiles, tileMap, bels, withUserCLK))

    return new_supertiles


# def parseBelFile(
#     filename: Path,
#     belPrefix: str = "",
#     filetype: Literal["verilog", "vhdl"] = "",
# ) -> Bel:
#     """Parse a Verilog or VHDL bel file and return all the related information of the
#     bel. The tuple returned for relating to ports will be a list of (belName, IO) pair.

#     The function will also parse and record all the FABulous attribute which all starts with ::

#         (* FABulous, <type>, ... *)

#     The <type> can be one the following:

#     * **BelMap**
#     * **EXTERNAL**
#     * **SHARED_PORT**
#     * **GLOBAL**
#     * **CONFIG_PORT**

#     The **BelMap** attribute will specify the bel mapping for the bel. This attribute should be placed before the start of
#     the module The bel mapping is then used for generating the bitstream specification. Each of the entry in the attribute will have the following format::

#     <name> = <value>

#     ``<name>`` is the name of the feature and ``<value>`` will be the bit position of the feature. ie. ``INIT=0`` will specify that the feature ``INIT`` is located at bit 0.
#     Since a single feature can be mapped to multiple bits, this is currently done by specifying multiple entries for the same feature. This will be changed in the future.
#     The bit specification is done in the following way::

#         INIT_a_1=1, INIT_a_2=2, ...

#     The name of the feature will be converted to ``INIT_a[1]``, ``INIT_a[2]`` for the above example. This is necessary
#     because  Verilog does not allow square brackets as part of the attribute name.

#     **EXTERNAL** attribute will notify FABulous to put the pin in the top module during the fabric generation.

#     **SHARED_PORT** attribute will notify FABulous this the pin is shared between multiple bels. Attribute need to go with
#     the **EXTERNAL** attribute.

#     **GLOBAL** attribute will notify FABulous to stop parsing any pin after this attribute.

#     **CONFIG_PORT** attribute will notify FABulous the port is for configuration.

#     Example
#     -------
#     Verilog
#     ::

#         (* FABulous, BelMap,
#         single_bit_feature=0, //single bit feature, single_bit_feature=0
#         multiple_bits_0=1, //multiple bit feature bit0, multiple_bits[0]=1
#         multiple_bits_1=2 //multiple bit feature bit1, multiple_bits[1]=2
#         *)
#         module exampleModule (externalPin, normalPin1, normalPin2, sharedPin, globalPin);
#             (* FABulous, EXTERNAL *) input externalPin;
#             input normalPin;
#             (* FABulous, EXTERNAL, SHARED_PORT *) input sharedPin;
#             (* FABulous, GLOBAL) input globalPin;
#             output normalPin2; //do not get parsed
#             ...

#     Parameters
#     ----------
#         filename : str
#             The filename of the bel file.
#         belPrefix : str, optional)
#             The bel prefix provided by the CSV file. Defaults to "".

#     Returns
#     -------
#     Tuple containing
#         - List of Bel Internal ports (belName, IO).
#         - List of Bel External ports (belName, IO).
#         - List of Bel Config ports (belName, IO).
#         - List of Bel Shared ports (belName, IO).
#         - Number of configuration bits in the bel.
#         - Whether the bel has UserCLK.
#         - Bel config bit mapping as a dict {port_name: bit_number}.

#     Raises
#     ------
#     ValueError
#         File not found
#     ValueError
#         No permission to access the file
#     """
#     internal: list[tuple[str, IO]] = []
#     external: list[tuple[str, IO]] = []
#     config: list[tuple[str, IO]] = []
#     shared: list[tuple[str, IO]] = []
#     isExternal = False
#     isConfig = False
#     isShared = False
#     userClk = False
#     individually_declared = False
#     noConfigBits = 0

#     try:
#         with open(filename, "r") as f:
#             file = f.read()
#     except FileNotFoundError:
#         logger.critical(f"File {filename} not found.")
#         exit(-1)
#     except PermissionError:
#         logger.critical(f"Permission denied to file {filename}.")
#         exit(-1)

#     if filetype == "vhdl":
#         belMapDic = vhdl_belMapProcessing(file, filename)
#         if result := re.search(r"NoConfigBits.*?=.*?(\d+)", file, re.IGNORECASE):
#             noConfigBits = int(result.group(1))
#         else:
#             logger.warning(f"Cannot find NoConfigBits in {filename}")
#             logger.warning("Assume the number of configBits is 0")
#             noConfigBits = 0
#         if len(belMapDic) != noConfigBits:
#             logger.error(
#                 f"NoConfigBits does not match with the BEL map in file {filename}, length of BelMap is {len(belMapDic)}, but with {noConfigBits} config bits"
#             )
#             raise ValueError

#         # FIXME: This is a temporary fix for the issue, that our vhdl parser can't handle vectors
#         portmatch = file.split("-- GLOBAL")[0].lower()
#         portmatch = portmatch[portmatch.find("port") :]  # trim everything before port
#         if any(
#             s in portmatch
#             for s in ["std_logic_vector", "bit_vector", "integer", "signed", "unsigned"]
#         ):
#             raise ValueError(
#                 f"Unsupported port type in {filename}. \
#                  Currtently only std_logic ports are supported for VHDL bels."
#             )

#         if result := re.search(
#             r"port.*?\((.*?)\);", file, re.MULTILINE | re.DOTALL | re.IGNORECASE
#         ):
#             file, _ = result.group(1).split("-- GLOBAL")
#         else:
#             raise ValueError(f"Could not find port section in file {filename}")

#         for line in file.split("\n"):
#             result = line
#             result = re.sub(r"STD_LOGIC.*|;.*|--*", "", result, flags=re.IGNORECASE)
#             result = result.replace(" ", "").replace("\t", "").replace(";", "")
#             portName = ""
#             direction = None
#             if "IMPORTANT" in line:
#                 continue
#             if result := re.search(r"(.*):(.*)", result):
#                 portName = f"{belPrefix}{result.group(1)}"
#                 if result.group(2).upper() == "IN":
#                     direction = IO["INPUT"]
#                 elif result.group(2).upper() == "OUT":
#                     direction = IO["OUTPUT"]
#                 elif result.group(2).upper() == "INOUT":
#                     direction = IO["INOUT"]
#                 else:
#                     logger.error(
#                         f"Invalid or Unknown port direction {result.group(2).upper()} in line {line}."
#                     )
#                     raise ValueError
#             else:
#                 continue
#             if line:
#                 if "EXTERNAL" in line:
#                     isExternal = True
#                 if "CONFIG" in line:
#                     isConfig = True
#                 if "SHARED_PORT" in line:
#                     isShared = True
#                 if "GLOBAL" in line:
#                     break

#             if portName == "" or direction is None:
#                 logger.warning(f"Invalid port definition in line {line}.")
#                 continue
#             elif isExternal and not isShared:
#                 external.append((portName, direction))
#             elif isConfig:
#                 config.append((portName, direction))
#             elif isShared:
#                 # shared port do not have a prefix
#                 shared.append((portName.removeprefix(belPrefix), direction))
#             else:
#                 internal.append((portName, direction))

#             # FIXME: This is a temporary fix for the issue, that our vhdl parser can't handle vectors
#             if portName[-1].isdigit():
#                 individually_declared = True

#             if "UserCLK" in portName:
#                 userClk = True

#             isExternal = False
#             isConfig = False
#             isShared = False

#     if filetype == "verilog":
#         # Runs yosys on verilog file, creates netlist, saves to json in same directory.
#         json_file = filename.with_suffix(".json")
#         runCmd = [
#             "yosys",
#             "-qp"
#             f"read_verilog -sv {filename}; proc -noopt; write_json -compat-int {json_file}",
#         ]
#         try:
#             subprocess.run(runCmd, check=True)
#         except subprocess.CalledProcessError as e:
#             logger.error(f"Failed to run yosys command: {e}")
#             raise ValueError

#         with open(f"{json_file}", "r") as f:
#             data_dict = json.load(f)

#         modules = data_dict.get("modules", {})
#         filtered_ports: dict[str, IO] = {}
#         # Gathers port name and direction, filters out configbits as they show in ports.
#         for module_name, module_info in modules.items():
#             ports = module_info["ports"]
#             for port_name, details in ports.items():
#                 if "ConfigBits" in port_name:
#                     continue
#                 if "UserCLK" in port_name:
#                     userClk = True
#                 if port_name[-1].isdigit():
#                     # FIXME:  This is a temporary fix for the issue where the ports are individually declared
#                     #         Check for the last charcter in portname is not really reliable and sould be handeled more rubust in the future.
#                     individually_declared = True
#                 direction = IO[details["direction"].upper()]
#                 bits = details.get("bits", [])
#                 filtered_ports[port_name] = (direction, bits)

#         param_defaults = module_info.get("parameter_default_values")
#         if param_defaults and "NoConfigBits" in param_defaults:
#             noConfigBits = param_defaults["NoConfigBits"]
#         # Passed attributes dont show in port list, checks for attributes in netnames.
#         # (If passed attributes missing, may need to expand to check other lists e.g "memories".)
#         netnames = module_info.get("netnames", {})
#         for item, details in netnames.items():
#             if item in filtered_ports:
#                 direction, bits = filtered_ports[item]
#                 attributes = details.get("attributes", {})
#                 for index in range(len(bits)):
#                     new_port_name = (
#                         f"{item}{index}" if len(bits) > 1 else item
#                     )  # Multi-bit ports get index
#                     if "EXTERNAL" in attributes and "SHARED_PORT" not in attributes:
#                         external.append((f"{belPrefix}{new_port_name}", direction))
#                     elif "CONFIG" in attributes:
#                         config.append((f"{belPrefix}{new_port_name}", direction))
#                     elif "SHARED_PORT" in attributes:
#                         shared.append((new_port_name, direction))
#                     else:
#                         internal.append((f"{belPrefix}{new_port_name}", direction))
#         belMapDic = verilog_belMapProcessing(module_info)
#         if len(belMapDic) != noConfigBits:
#             raise ValueError(
#                 f"NoConfigBits does not match with the BEL map in file {filename}, length of BelMap is {len(belMapDic)}, but with {noConfigBits} config bits"
#             )

#     if individually_declared and filetype == "verilog":
#         logger.warning(
#             f"Ports in {filename} have been individually declared rather than as a vector."
#         )
#         logger.warning("Ports will not be concatenated during fabric generation.")

#     return Bel(
#         src=filename,
#         prefix=belPrefix,
#         internal=internal,
#         external=external,
#         configPort=config,
#         sharedPort=shared,
#         configBit=noConfigBits,
#         belMap=belMapDic,
#         userCLK=userClk,
#         individually_declared=individually_declared,
#     )


def verilog_belMapProcessing(module_info):
    """Extracts and transforms BEL mapping attributes in the JSON created from a Verilog
    module.

    Parameters
    ----------
    module_info : dict
        A dictionary containing the module's attributes, including
        potential BEL mapping information.

    Returns
    -------
    dic
        Dictionary containing the parsed bel mapping information.
    """
    belMapDic = {}
    attributes = module_info.get("attributes", {})
    # if BelMap not present defaults belMapDic to {}
    if "BelMap" not in attributes:
        return belMapDic
    # Passed attributes that dont need appending. (May need refining.)
    exclude_attributes = {
        "BelMap",
        "FABulous",
        "dynports",
        "cells_not_processed",
        "src",
    }
    # match case for INIT. (may need modifying for other naming conventions.)
    for key, value in attributes.items():
        if key in exclude_attributes:
            continue
        match key:
            case key if key.startswith("INIT_") and key[5:].isdigit():
                index = key[5:]
                new_key = f"INIT[{index}]"
            case "INIT":
                new_key = "INIT"
            case key if key.isupper() and "_" not in key:
                new_key = key
            case _:
                new_key = key

        belMapDic[new_key] = {0: {0: "1"}}

    # yosys reverses belmap, reverse back to keep original belmap.
    belMapDic = dict(reversed(list(belMapDic.items())))

    return belMapDic


def vhdl_belMapProcessing(file: str, filename: str) -> dict:
    """Processes bel mapping information from file contents.

    Parameters
    ----------
    file : str
        Conent of the file as a string
    filename : str
        Name of the file being processed
    syntax : Literal['vhdl']
        Syntax type of the file.

    Returns
    -------
    dict
        Dictionary containing the parsed bel mapping information.

    Raises
    ------
    ValueError
        If invalid enum is encounted in the file.
    """
    pre = "--.*?"

    belEnumsDic = {}
    if belEnums := re.findall(
        pre + r"\(\*.*?FABulous,.*?BelEnum,(.*?)\*\)", file, re.DOTALL | re.MULTILINE
    ):
        for enums in belEnums:
            enums = enums.replace("\n", "").replace(" ", "").replace("\t", "")
            enums = enums.split(",")
            enums = [i for i in enums if i != "" and i != " "]
            if enumParse := re.search(r"(.*?)\[(\d+):(\d+)\]", enums[0]):
                name = enumParse.group(1)
                start = int(enumParse.group(2))
                end = int(enumParse.group(3))
            else:
                logger.error(f"Invalid enum {enums[0]} in file {filename}")
                raise ValueError
            belEnumsDic[name] = {}
            for i in enums[1:]:
                key, value = i.split("=")
                belEnumsDic[name][key] = {}
                bitValue = list(value)
                if start > end:
                    for j in range(start, end - 1, -1):
                        belEnumsDic[name][key][j] = bitValue.pop(0)
                else:
                    for j in range(start, end + 1):
                        belEnumsDic[name][key][j] = bitValue.pop(0)

    belMapDic = {}
    if belMap := re.search(
        pre + r"\(\*.*FABulous,.*?BelMap,(.*?)\*\)", file, re.DOTALL | re.MULTILINE
    ):
        belMap = belMap.group(1)
        belMap = belMap.replace("\n", "").replace(" ", "").replace("\t", "")
        belMap = belMap.split(",")
        belMap = [i for i in belMap if i != "" and i != " "]
        for bel in belMap:
            bel = bel.split("=")
            belNameTemp = bel[0].rsplit("_", 1)
            # process scalar
            if len(belNameTemp) > 1 and belNameTemp[1].isnumeric():
                bel[0] = f"{belNameTemp[0]}[{belNameTemp[1]}]"
            belMapDic[bel[0]] = {}
            if bel == [""]:
                continue
            # process enum data type
            if bel[0] in list(belEnumsDic.keys()):
                belMapDic[bel[0]] = belEnumsDic[bel[0]]
            # process vector input
            elif ":" in bel[1]:
                start, end = bel[1].split(":")
                start, end = int(start), int(end)
                if start > end:
                    length = start - end + 1
                    for i in range(2**length - 1, -1, -1):
                        belMapDic[bel[0]][i] = {}
                        bitMap = list(f"{i:0{length.bit_length()}b}")
                        for v in range(len(bitMap) - 1, -1, -1):
                            belMapDic[bel[0]][i][v] = bitMap.pop(0)
                else:
                    length = end - start + 1
                    for i in range(0, 2**length):
                        belMapDic[bel[0]][i] = {}
                        bitMap = list(f"{2**length - i - 1:0{length.bit_length()}b}")
                        for v in range(len(bitMap) - 1, -1, -1):
                            belMapDic[bel[0]][i][v] = bitMap.pop(0)
            else:
                belMapDic[bel[0]][0] = {0: "1"}
    return belMapDic


def parseConfigMem(
    fileName: Path, maxFramePerCol: int, frameBitsPerRow: int, configBit: int
) -> ConfigurationMemory:
    """Parse the config memory CSV file into a list of ConfigMem objects.

    Parameters
    ----------
    fileName : str
        Directory of the config memory CSV file
    maxFramePerCol : int
        Maximum number of frames per column
    frameBitPerRow : int
        Number of bits per row
    globalConfigBits : int
        Number of global config bits for the config memory

    Raises
    ------
    ValueError
        - Invalid amount of frame entries in the config memory CSV file
        - Too many values in bit mask
        - Length of bit mask does not match the number of frame bits per row
        - Bit mask does not have enough values matching the number of the given config bits
        - Repeated config bit entry in ':' separated format in config bit range
        - Repeated config bit entry in list format in config bit range
        - Invalid range entry in config bit range

    Returns
    -------
    list[ConfigMem]
        List of ConfigMem objects parsed from the config memory CSV file.
    """
    if not fileName.exists():
        logger.error(f"The file {fileName} does not exist.")
        raise ValueError

    with open(fileName) as f:
        mappingFile = list(csv.DictReader(f))

        # remove the pretty print from used_bits_mask
        for i, _ in enumerate(mappingFile):
            mappingFile[i]["used_bits_mask"] = mappingFile[i]["used_bits_mask"].replace(
                "_", ""
            )

        # # we should have as many lines as we have frames (=framePerCol)
        # if len(mappingFile) != maxFramePerCol:
        #     logger.error(
        #         f"The bitstream mapping file {fileName} has {len(mappingFile)} entries which do not match MaxFramesPerCol of {maxFramePerCol}."
        #     )
        #     raise ValueError

        # # we also check used_bits_mask (is a vector that is as long as a frame and contains a '1' for a bit used and a '0' if not used (padded)
        # usedBitsCounter = 0
        # for entry in mappingFile:
        #     if entry["used_bits_mask"].count("1") > frameBitPerRow:
        #         logger.error(
        #             f"bitstream mapping file {fileName} has to many 1-elements in bitmask for frame : {entry['frame_name']}"
        #         )
        #         raise ValueError
        #     if len(entry["used_bits_mask"]) != frameBitPerRow:
        #         logger.error(
        #             f"bitstream mapping file {fileName} has has a too long or short bitmask for frame : {entry['frame_name']}"
        #         )
        #         raise ValueError
        #     usedBitsCounter += entry["used_bits_mask"].count("1")

        # if usedBitsCounter != globalConfigBits:
        #     logger.error(
        #         f"bitstream mapping file {fileName} has a bitmask mismatch; bitmask has in total {usedBitsCounter} 1-values for {globalConfigBits} bits."
        #     )
        #     raise ValueError

        allConfigBitsOrder = []
        configMemEntry = []
        for entry in mappingFile:
            configBitsOrder = []
            entry["ConfigBits_ranges"] = (
                entry["ConfigBits_ranges"].replace(" ", "").replace("\t", "")
            )

            if ":" in entry["ConfigBits_ranges"]:
                left, right = re.split(":", entry["ConfigBits_ranges"])
                # check the order of the number, if right is smaller than left, then we swap them
                left, right = int(left), int(right)
                if right < left:
                    left, right = right, left
                    numList = list(reversed(range(left, right + 1)))
                else:
                    numList = list(range(left, right + 1))

                for i in numList:
                    if i in allConfigBitsOrder:
                        logger.error(
                            f"Configuration bit index {i} already allocated in {fileName}, {entry['frame_name']}."
                        )
                        raise ValueError
                    configBitsOrder.append(i)

            elif ";" in entry["ConfigBits_ranges"]:
                for item in entry["ConfigBits_ranges"].split(";"):
                    if int(item) in allConfigBitsOrder:
                        logger.error(
                            f"Configuration bit index {item} already allocated in {fileName}, {entry['frame_name']}."
                        )
                        raise ValueError
                    configBitsOrder.append(int(item))

            elif "NULL" in entry["ConfigBits_ranges"]:
                configBitsOrder = []
            else:
                logger.error(
                    f"Range {entry['ConfigBits_ranges']} is not a valid format. It should be in the form [int]:[int] or [int]. If there are multiple ranges it should be separated by ';'."
                )
                raise ValueError

            allConfigBitsOrder += configBitsOrder

            configMemEntry.append(
                ConfigMem(
                    frameName=entry["frame_name"],
                    frameIndex=int(entry["frame_index"]),
                    bitsUsedInFrame=entry["used_bits_mask"].count("1"),
                    usedBitMask=entry["used_bits_mask"],
                    configBitRanges=configBitsOrder,
                )
            )

    configMemMappings: list[ConfigBitMapping] = []

    # mapping config bit to the location in the frame
    # If we only have 1 frame for example:
    # bit mask = 1111_1111_1110_0000_0000_0000_0000_0000
    # ConfigBits_range = 10:0
    # Then encodeDict[10] = 31, encodeDict[9] = 30
    # This means the 10th bit in the config memory is the 31st bit in the 1st frame
    # and 30th bit in the 1nd frame
    for i in configMemEntry:
        configBitRangeCopy = deepcopy(i.configBitRanges)
        for bitIndex in range(31, -1, -1):
            used_bit_mask_reversed = list(reversed(str(i.usedBitMask)))
            if used_bit_mask_reversed[bitIndex] == "1":
                configMemMappings.append(
                    ConfigBitMapping(configBitRangeCopy.pop(0), i.frameIndex, bitIndex)
                )
            else:
                configMemMappings.append(ConfigBitMapping(None, i.frameIndex, bitIndex))

    return ConfigurationMemory(
        configMappings=configMemMappings,
        configMemEntries=configMemEntry,
    )
