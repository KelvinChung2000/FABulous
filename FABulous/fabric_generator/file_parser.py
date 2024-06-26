import csv
import os
import re
from copy import deepcopy

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.Port import Port
from FABulous.fabric_definition.Wire import Wire
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.Port import InPort, OutPort
from FABulous.fabric_definition.SuperTile import SuperTile
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.ConfigMem import ConfigMem
from FABulous.utilities.utilities import parseList, parseMatrix
from typing import Literal
from FABulous.fabric_definition.define import (
    IO,
    Direction,
    Side,
    ConfigBitMode,
    MultiplexerStyle,
)


# from fabric import Fabric, Port, Bel, Tile, SuperTile, ConfigMem
# from fabric import IO, Direction, Side, MultiplexerStyle, ConfigBitMode


oppositeDic = {"NORTH": "SOUTH", "SOUTH": "NORTH", "EAST": "WEST", "WEST": "EAST"}


def parseFabricCSV(fileName: str) -> Fabric:
    """
    Parses a csv file and returns a fabric object.

    Args:
        fileName (str): the directory of the csv file.

    Raises:
        ValueError: File provide need to be a csv file.
        ValueError: The csv file does not exist.
        ValueError: Cannot find the FabricBegin and FabricEnd region.
        ValueError: Cannot find the ParametersBegin and ParametersEnd region.
        ValueError: The bel entry extension can only be ".v" or ".vhdl".
        ValueError: The matrix entry extension can only be ".list", ".csv", ".v" or ".vhdl".
        ValueError: Unknown tile description entry in csv file.
        ValueError: Unknown tile in the fabric entry in csv file.
        ValueError: Unknown super tile in the super tile entry in csv file.
        ValueError: Invalid ConfigBitMode in parameter entry in csv file.
        ValueError: Invalid MultiplexerStyle in parameter entry in csv file.
        ValueError: Invalid parameter entry in csv file.

    Returns:
        Fabric: The fabric object.
    """
    if not fileName.endswith(".csv"):
        raise ValueError("File must be a csv file")

    if not os.path.exists(fileName):
        raise ValueError(f"File {fileName} does not exist")

    filePath, _ = os.path.split(os.path.abspath(fileName))

    with open(fileName, "r") as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)

    # read in the csv file and part them
    if fabricDescription := re.search(
        r"FabricBegin(.*?)FabricEnd", file, re.MULTILINE | re.DOTALL
    ):
        fabricDescription = fabricDescription.group(1)
    else:
        raise ValueError("Cannot find FabricBegin and FabricEnd in csv file")

    if parameters := re.search(
        r"ParametersBegin(.*?)ParametersEnd", file, re.MULTILINE | re.DOTALL
    ):
        parameters = parameters.group(1)
    else:
        raise ValueError("Cannot find ParametersBegin and ParametersEnd in csv file")

    fabricDescription = fabricDescription.split("\n")
    parameters = parameters.split("\n")

    # Lists for tiles
    tileTypes = []
    tileDefs = []
    commonWirePair: list[tuple[str, str]] = []

    fabricTiles = []
    tileDic = {}

    # list for supertiles
    superTileDic = {}

    # For backwards compatibility parse tiles in fabric config
    new_tiles, new_commonWirePair = parseTiles(fileName)
    tileTypes += [new_tile.name for new_tile in new_tiles]
    tileDefs += new_tiles
    commonWirePair += new_commonWirePair
    tileDic = dict(zip(tileTypes, tileDefs))

    newSuperTiles = parseSuperTiles(fileName, tileDic)
    for newSuperTile in newSuperTiles:
        superTileDic[newSuperTile.name] = newSuperTile

    if new_tiles or newSuperTiles:
        print(f"Deprecation warning: {fileName} should not contain tile descriptions.")

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

    for i in parameters:
        i = i.split(",")
        i = [j for j in i if j != ""]
        if not i:
            continue
        if i[0].startswith("Tile"):
            new_tiles, new_commonWirePair = parseTiles(
                os.path.abspath(os.path.join(filePath, i[1]))
            )
            tileTypes += [new_tile.name for new_tile in new_tiles]
            tileDefs += new_tiles
            commonWirePair += new_commonWirePair
            tileDic = dict(zip(tileTypes, tileDefs))
        elif i[0].startswith("Supertile"):
            newSuperTiles = parseSuperTiles(
                os.path.abspath(os.path.join(filePath, i[1])), tileDic
            )
            for newSuperTile in newSuperTiles:
                superTileDic[newSuperTile.name] = newSuperTile
        elif i[0].startswith("ConfigBitMode"):
            if i[1] == "frame_based":
                configBitMode = ConfigBitMode.FRAME_BASED
            elif i[1] == "FlipFlopChain":
                configBitMode = ConfigBitMode.FLIPFLOP_CHAIN
            else:
                raise ValueError(
                    f"Invalid config bit mode {i[1]} in parameters. Valid options are frame_based and FlipFlopChain"
                )
        elif i[0].startswith("FrameBitsPerRow"):
            frameBitsPerRow = int(i[1])
        elif i[0].startswith("MaxFramesPerCol"):
            maxFramesPerCol = int(i[1])
        elif i[0].startswith("Package"):
            package = i[1]
        elif i[0].startswith("GenerateDelayInSwitchMatrix"):
            generateDelayInSwitchMatrix = int(i[1])
        elif i[0].startswith("MultiplexerStyle"):
            if i[1] == "custom":
                multiplexerStyle = MultiplexerStyle.CUSTOM
            elif i[1] == "generic":
                multiplexerStyle = MultiplexerStyle.GENERIC
            else:
                raise ValueError(
                    f"Invalid multiplexer style {i[1]} in parameters. Valid options are custom and generic"
                )
        elif i[0].startswith("SuperTileEnable"):
            superTileEnable = i[1] == "TRUE"
        else:
            raise ValueError(f"The following parameter is not valid: {i}")

    # form the fabric data structure
    x, y = 0, 0
    usedTile = set()
    for f in fabricDescription:
        fabricLineTmp = f.split(",")
        fabricLineTmp = [i for i in fabricLineTmp if i != ""]
        if not fabricLineTmp:
            continue
        fabricLine = []
        for i in fabricLineTmp:
            x += 1
            if i in tileDic:
                t = deepcopy(tileDic[i])
                fabricLine.append(t)
                t.X = x
                t.Y = y
                usedTile.add(i)
            elif i == "Null" or i == "NULL" or i == "None":
                fabricLine.append(None)
            else:
                raise ValueError(f"Unknown tile {i}")
        fabricTiles.append(fabricLine)
        y += 1

    for i in list(tileDic.keys()):
        if i not in usedTile:
            print(f"Tile {i} is not used in the fabric. Removing from tile dictionary.")
            del tileDic[i]
    for i in list(superTileDic.keys()):
        if any(j.name not in usedTile for j in superTileDic[i].tiles):
            print(
                f"Supertile {i} is not used in the fabric. Removing from tile dictionary."
            )
            del superTileDic[i]

    height = len(fabricTiles)
    width = len(fabricTiles[0])

    commonWirePair = list(dict.fromkeys(commonWirePair))
    commonWirePair = [
        (i, j) for (i, j) in commonWirePair if "NULL" not in i and "NULL" not in j
    ]

    return Fabric(
        tile=fabricTiles,
        numberOfColumns=width,
        numberOfRows=height,
        configBitMode=configBitMode,
        frameBitsPerRow=frameBitsPerRow,
        maxFramesPerCol=maxFramesPerCol,
        package=package,
        generateDelayInSwitchMatrix=generateDelayInSwitchMatrix,
        multiplexerStyle=multiplexerStyle,
        numberOfBRAMs=int(height / 2),
        superTileEnable=superTileEnable,
        tileDic=tileDic,
        superTileDic=superTileDic,
        commonWirePair=commonWirePair,
    )


def parseTiles(fileName: str) -> tuple[list[Tile], list[tuple[str, str]]]:
    """
    Parses a csv tile configuration file and returns all tile objects.

    Args:
        fileName (str): the path to the csv file.

    Returns:
        ([Tile], [(str, str)] : tuple of tile objects and common wire pairs.
    """

    print(f"Reading tile configuration: {fileName}")

    if not fileName.endswith(".csv"):
        raise ValueError("File must be a csv file")

    if not os.path.exists(fileName):
        raise ValueError(f"File {fileName} does not exist")

    filePath, _ = os.path.split(os.path.abspath(fileName))

    with open(fileName, "r") as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)

    tilesData = re.findall(r"TILE(.*?)EndTILE", file, re.MULTILINE | re.DOTALL)

    new_tiles = []
    commonWirePair = []

    # Parse each tile config
    for t in tilesData:
        t = t.split("\n")
        tileName = t[0].split(",")[1]
        ports: list[Port] = []
        bels: list[Bel] = []
        matrixDir = ""
        withUserCLK = False
        configBit = 0
        for item in t:
            temp: list[str] = item.split(",")
            if not temp or temp[0] == "":
                continue
            if temp[0] in ["NORTH", "SOUTH", "EAST", "WEST"]:
                ports.append(
                    Port(
                        wireDirection=Direction[temp[0]],
                        sourceName=temp[1],
                        xOffset=int(temp[2]),
                        yOffset=int(temp[3]),
                        destinationName=temp[4],
                        wireCount=int(temp[5]),
                        name=temp[1],
                        inOut=IO.OUTPUT,
                        sideOfTile=Side[temp[0]],
                    )
                )

                ports.append(
                    Port(
                        wireDirection=Direction[temp[0]],
                        sourceName=temp[1],
                        xOffset=int(temp[2]),
                        yOffset=int(temp[3]),
                        destinationName=temp[4],
                        wireCount=int(temp[5]),
                        name=temp[4],
                        inOut=IO.INPUT,
                        sideOfTile=Side[oppositeDic[temp[0]].upper()],
                    )
                )
                # wireCount = (abs(int(temp[2])) +
                #              abs(int(temp[3])))*int(temp[5])
                # for i in range(wireCount):
                commonWirePair.append((f"{temp[1]}", f"{temp[4]}"))

            elif temp[0] == "JUMP":
                ports.append(
                    Port(
                        wireDirection=Direction.JUMP,
                        sourceName=temp[1],
                        xOffset=int(temp[2]),
                        yOffset=int(temp[3]),
                        destinationName=temp[4],
                        wireCount=int(temp[5]),
                        name=temp[1],
                        inOut=IO.OUTPUT,
                        sideOfTile=Side.ANY,
                    )
                )
                ports.append(
                    Port(
                        wireDirection=Direction.JUMP,
                        sourceName=temp[1],
                        xOffset=int(temp[2]),
                        yOffset=int(temp[3]),
                        destinationName=temp[4],
                        wireCount=int(temp[5]),
                        name=temp[4],
                        inOut=IO.INPUT,
                        sideOfTile=Side.ANY,
                    )
                )
            elif temp[0] == "BEL":
                belFilePath = os.path.join(filePath, temp[1])
                if temp[1].endswith(".vhdl"):
                    result = parseFileVHDL(belFilePath, temp[2])
                elif temp[1].endswith(".v"):
                    result = parseFileVerilog(belFilePath, temp[2])
                else:
                    raise ValueError(
                        "Invalid file type, only .vhdl and .v are supported"
                    )
                bels.append(result)
                withUserCLK |= result.withUserCLK
            elif temp[0] == "MATRIX":
                matrixDir = os.path.join(filePath, temp[1])
                configBit = 0
                if temp[1].endswith(".list"):
                    for _, v in parseList(matrixDir, "source").items():
                        muxSize = len(v)
                        if muxSize >= 2:
                            configBit += muxSize.bit_length() - 1
                elif temp[1].endswith("_matrix.csv"):
                    for _, v in parseMatrix(matrixDir, tileName).items():
                        muxSize = len(v)
                        if muxSize >= 2:
                            configBit += muxSize.bit_length() - 1
                elif temp[1].endswith(".vhdl") or temp[1].endswith(".v"):
                    with open(matrixDir, "r") as f:
                        f = f.read()
                        if configBit := re.search(r"NumberOfConfigBits: (\d+)", f):
                            configBit = int(configBit.group(1))
                        else:
                            configBit = 0
                            print(
                                f"Cannot find NumberOfConfigBits in {matrixDir} assume 0 config bits"
                            )

                else:
                    raise ValueError("Unknown file extension for matrix")
            else:
                raise ValueError(f"Unknown tile description {temp[0]} in tile {t}")

        new_tiles.append(Tile(tileName, ports, bels, matrixDir, withUserCLK, configBit))

    return (new_tiles, commonWirePair)


def parseSuperTiles(fileName: str, tileDic: dict[str, Tile]) -> list[SuperTile]:
    """
    Parses a csv supertile configuration file and returns all SuperTile objects.

    Args:
        fileName (str): the path to the csv file.
        tileDic ({str: Tile}): dict of tiles.

    Returns:
        [SuperTile]: list of supertile objects.
    """

    print(f"Reading supertile configuration: {fileName}")

    if not fileName.endswith(".csv"):
        raise ValueError("File must be a csv file")

    if not os.path.exists(fileName):
        raise ValueError(f"File {fileName} does not exist")

    filePath, _ = os.path.split(os.path.abspath(fileName))

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
                belFilePath = os.path.join(filePath, line[1])
                if line[0].endswith("VHDL"):
                    result = parseFileVHDL(belFilePath, line[2])
                else:
                    result = parseFileVerilog(belFilePath, line[2])
                bels.append(result)
                withUserCLK |= result.withUserCLK
                continue

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
                    raise ValueError(
                        f"The super tile {name} contains definitions that are not tiles or Null."
                    )
            tileMap.append(row)

        new_supertiles.append(SuperTile(name, tiles, tileMap, bels, withUserCLK))

    return new_supertiles


def parseFileVHDL(filename: str, belPrefix: str = "") -> Bel:
    """
    Parse a VHDL bel file and return all the related information of the bel. The tuple returned for relating to ports will
    be a list of (belName, IO) pair.

    For further example of bel mapping please look at parseFileVerilog

    Args:
        filename (str): The input file name.
        belPrefix (str, optional): The bel prefix provided by the CSV file. Defaults to "".

    Raises:
        ValueError: File not found
        ValueError: No permission to access the file
        ValueError: Cannot find the port section in the file which defines the bel ports.

    Returns:
        tuple[list[tuple[str, IO]], list[tuple[str, IO]], list[tuple[str, IO]], list[tuple[str, IO]], int, bool, dict[str, int]]:
        Bel internal ports, bel external ports, bel config ports, bel shared ports, number of configuration bit in the bel,
        whether the bel have UserCLK, and the bel config bit mapping.
    """
    internal: list[tuple[str, IO]] = []
    external: list[tuple[str, IO]] = []
    config: list[tuple[str, IO]] = []
    shared: list[tuple[str, IO]] = []
    isExternal = False
    isConfig = False
    isShared = False
    userClk = False

    try:
        with open(filename, "r") as f:
            file = f.read()
    except FileNotFoundError:
        print(f"File {filename} not found.")
        exit(-1)
    except PermissionError:
        print(f"Permission denied to file {filename}.")
        exit(-1)

    belMapDic = _belMapProcessing(file, filename, "vhdl")
    moduleName = re.search(r"entity\s+(\w+)\s+is", file, re.IGNORECASE).group(1)

    if result := re.search(r"NoConfigBits.*?=.*?(\d+)", file, re.IGNORECASE):
        noConfigBits = int(result.group(1))
    else:
        print(f"Cannot find NoConfigBits in {filename}")
        print("Assume the number of configBits is 0")
        noConfigBits = 0

    if len(belMapDic) != noConfigBits:
        raise ValueError(
            f"NoConfigBits does not match with the BEL map in file {filename}, length of BelMap is {len(belMapDic)}, but with {noConfigBits} config bits"
        )

    portSection = ""
    if result := re.search(
        r"port.*?\((.*?)\);", file, re.MULTILINE | re.DOTALL | re.IGNORECASE
    ):
        portSection = result.group(1)
    else:
        raise ValueError(f"Could not find port section in file {filename}")

    preGlobal, postGlobal = portSection.split("-- GLOBAL")

    for line in preGlobal.split("\n"):
        if "IMPORTANT" in line:
            continue
        if "EXTERNAL" in line:
            isExternal = True
        if "CONFIG" in line:
            isConfig = True
        if "SHARED_PORT" in line:
            isShared = True

        line = re.sub(r"STD_LOGIC.*", "", line, flags=re.IGNORECASE)
        line = re.sub(r";.*", "", line, flags=re.IGNORECASE)
        line = re.sub(r"--*", "", line, flags=re.IGNORECASE)
        line = line.replace(" ", "").replace("\t", "").replace(";", "")
        result = re.search(r"(.*):(.*)", line)
        if not result:
            continue
        portName = f"{belPrefix}{result.group(1)}"

        if isExternal and not isShared:
            if result.group(2).lower() == "in":
                external.append(InPort(portName, 1))
            elif result.group(2).lower() == "out":
                external.append(OutPort(portName, 1))
        elif isConfig:
            if result.group(2).lower() == "in":
                config.append(InPort(portName, 1))
            elif result.group(2).lower() == "out":
                config.append(OutPort(portName, 1))
        elif isShared:
            # shared port do not have a prefix
            if result.group(2).lower() == "in":
                shared.append(InPort(portName, 1))
            elif result.group(2).lower() == "out":
                shared.append(OutPort(portName, 1))
            else:
                raise ValueError(
                    f"Invalid port type {result.group(2)} in file {filename}"
                )
        else:
            if result.group(2).lower() == "in":
                internal.append(InPort(portName, 1))
            elif result.group(2).lower() == "out":
                internal.append(OutPort(portName, 1))
            else:
                raise ValueError(
                    f"Invalid port type {result.group(2)} in file {filename}"
                )

        if "UserCLK" in portName:
            userClk = True

        isExternal = False
        isConfig = False
        isShared = False

    result = re.search(
        r"NoConfigBits\s*:\s*integer\s*:=\s*(\w+)", file, re.IGNORECASE | re.DOTALL
    )
    if result:
        try:
            noConfigBits = int(result.group(1))
        except ValueError:
            print(f"NoConfigBits is not an integer: {result.group(1)}")
            print("Assume the number of configBits is 0")
            noConfigBits = 0
    else:
        print(f"Cannot find NoConfigBits in {filename}")
        print("Assume the number of configBits is 0")
        noConfigBits = 0

    return Bel(
        src=filename,
        name=moduleName,
        prefix=belPrefix,
        internalPorts=internal,
        externalPorts=external,
        configPort=config,
        sharedPort=shared,
        configBit=noConfigBits,
        belMap=belMapDic,
        userCLK=userClk,
    )


def parseFileVerilog(filename: str, belPrefix: str = "") -> Bel:
    """
    Parse a Verilog bel file and return all the related information of the bel. The tuple returned for relating to ports
    will be a list of (belName, IO) pair.

    The function will also parse and record all the FABulous attribute which all starts with ::

        (* FABulous, <type>, ... *)

    The <type> can be one the following:

    * **BelMap**
    * **EXTERNAL**
    * **SHARED_PORT**
    * **GLOBAL**
    * **CONFIG_PORT**

    The **BelMap** attribute will specify the bel mapping for the bel. This attribute should be placed before the start of
    the module The bel mapping is then used for generating the bitstream specification. Each of the entry in the attribute will have the following format::

    <name> = <value>

    ``<name>`` is the name of the feature and ``<value>`` will be the bit position of the feature. ie. ``INIT=0`` will specify that the feature ``INIT`` is located at bit 0.
    Since a single feature can be mapped to multiple bits, this is currently done by specifying multiple entries for the same feature. This will be changed in the future.
    The bit specification is done in the following way::

        INIT_a_1=1, INIT_a_2=2, ...

    The name of the feature will be converted to ``INIT_a[1]``, ``INIT_a[2]`` for the above example. This is necessary
    because  Verilog does not allow square brackets as part of the attribute name.

    **EXTERNAL** attribute will notify FABulous to put the pin in the top module during the fabric generation.

    **SHARED_PORT** attribute will notify FABulous this the pin is shared between multiple bels. Attribute need to go with
    the **EXTERNAL** attribute.

    **GLOBAL** attribute will notify FABulous to stop parsing any pin after this attribute.

    **CONFIG_PORT** attribute will notify FABulous the port is for configuration.

    Example:
        .. code-block :: verilog

            (* FABulous, BelMap,
            single_bit_feature=0, //single bit feature, single_bit_feature=0
            multiple_bits_0=1, //multiple bit feature bit0, multiple_bits[0]=1
            multiple_bits_1=2 //multiple bit feature bit1, multiple_bits[1]=2
            *)
            module exampleModule (externalPin, normalPin1, normalPin2, sharedPin, globalPin);
                (* FABulous, EXTERNAL *) input externalPin;
                input normalPin;
                (* FABulous, EXTERNAL, SHARED_PORT *) input sharedPin;
                (* FABulous, GLOBAL) input globalPin;
                output normalPin2; //do not get parsed
                ...

    Args:
        filename (str): The filename of the bel file.
        belPrefix (str, optional): The bel prefix provided by the CSV file. Defaults to "".

    Raises:
        ValueError: File not found
        ValueError: No permission to access the file

    Returns:
        tuple[list[tuple[str, IO]], list[tuple[str, IO]], list[tuple[str, IO]], list[tuple[str, IO]], int, bool, dict[str, dict]]:
        Bel internal ports, bel external ports, bel config ports, bel shared ports, number of configuration bit in the bel,
        whether the bel have UserCLK, and the bel config bit mapping.
    """
    internal: list[tuple[str, IO]] = []
    external: list[tuple[str, IO]] = []
    config: list[tuple[str, IO]] = []
    shared: list[tuple[str, IO]] = []
    isExternal = False
    isConfig = False
    isShared = False
    userClk = False
    noConfigBits = 0

    try:
        with open(filename, "r") as f:
            file = f.read()
    except FileNotFoundError:
        print(f"File {filename} not found.")
        exit(-1)
    except PermissionError:
        print(f"Permission denied to file {filename}.")
        exit(-1)

    belMapDic = _belMapProcessing(file, filename, "verilog")

    if result := re.search(r"NoConfigBits.*?=.*?(\d+)", file, re.IGNORECASE):
        noConfigBits = int(result.group(1))
    else:
        print(f"Cannot find NoConfigBits in {filename}")
        print("Assume the number of configBits is 0")
        noConfigBits = 0

    if len(belMapDic) != noConfigBits:
        raise ValueError(
            f"NoConfigBits does not match with the BEL map in file {filename}, length of BelMap is {len(belMapDic)}, but with {noConfigBits} config bits"
        )

    moduleName = re.search(r"module\s+(\w+)\s*\(", file, re.IGNORECASE).group(1)

    file = file.split("\n")

    for line in file:
        if result := re.search(
            r".*(input|output|inout)\s*(\[.*\])?\s*(\w+);", line, re.IGNORECASE
        ):
            cleanedLine = line.replace(" ", "")
            if attribute := re.search(r"\(\*FABulous,(.*)\*\)", cleanedLine):
                if "EXTERNAL" in attribute.group(1):
                    isExternal = True

                if "CONFIG" in attribute.group(1):
                    isConfig = True

                if "SHARED_PORT" in attribute.group(1):
                    isShared = True

                if "GLOBAL" in attribute.group(1):
                    break

            portName = f"{belPrefix}{result.group(3)}"
            wireCount = 1
            if result.group(2):
                tmp = result.group(2).replace("[", "").replace("]", "")
                wireCount = int(tmp.split(":")[0]) - int(tmp.split(":")[1]) + 1

            if IO[result.group(1).upper()] == IO.INPUT:
                portType = InPort
            else:
                portType = OutPort

            if isExternal and not isShared:
                external.append(portType(portName, wireCount=wireCount))
            elif isConfig:
                config.append(portType(portName, 1))
            elif isShared:
                # shared port do not have a prefix
                shared.append(portType(result.group(3), wireCount=wireCount))
            else:
                internal.append(portType(portName, wireCount=wireCount))

            if "UserCLK" in portName:
                userClk = True

            isExternal = False
            isConfig = False
            isShared = False

    return Bel(
        src=filename,
        name=moduleName,
        prefix=belPrefix,
        internalPorts=internal,
        externalPorts=external,
        configPort=config,
        sharedPort=shared,
        configBit=noConfigBits,
        belMap=belMapDic,
        userCLK=userClk,
    )


def _belMapProcessing(
    file: str, filename: str, syntax: Literal["vhdl", "verilog"]
) -> dict:
    pre = ""
    if syntax == "vhdl":
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
                raise ValueError(f"Invalid enum {enums[0]} in file {filename}")
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
                        bitMap = list(f"{2**length-i-1:0{length.bit_length()}b}")
                        for v in range(len(bitMap) - 1, -1, -1):
                            belMapDic[bel[0]][i][v] = bitMap.pop(0)
            else:
                belMapDic[bel[0]][0] = {0: "1"}
    return belMapDic


def parseConfigMem(
    fileName: str, maxFramePerCol: int, frameBitPerRow: int, globalConfigBits: int
) -> list[ConfigMem]:
    """
    Parse the config memory csv file into a list of ConfigMem objects

    Args:
        fileName (str): directory of the config memory csv file
        maxFramePerCol (int): maximum number of frames per column
        frameBitPerRow (int): number of bits per row
        globalConfigBits (int): number of global config bits for the config memory

    Raises:
        ValueError: Invalid amount of frame entries in the config memory csv file
        ValueError: Too many value in bit mask
        ValueError: Length of bit mask does not match with the number of frame bits per row
        ValueError: Bit mast does not have enough value matching the number of the given config bits
        ValueError: repeated config bit entry in ':' separated format in config bit range
        ValueError: repeated config bit entry in list format in config bit range
        ValueError: Invalid range entry in config bit range

    Returns:
        list[ConfigMem]: _description_
    """
    with open(fileName) as f:
        mappingFile = list(csv.DictReader(f))

        # remove the pretty print from used_bits_mask
        for i, _ in enumerate(mappingFile):
            mappingFile[i]["used_bits_mask"] = mappingFile[i]["used_bits_mask"].replace(
                "_", ""
            )

        # we should have as many lines as we have frames (=framePerCol)
        if len(mappingFile) != maxFramePerCol:
            raise ValueError(
                f"WARNING: the bitstream mapping file has only {len(mappingFile)} entries but MaxFramesPerCol is {maxFramePerCol}"
            )

        # we also check used_bits_mask (is a vector that is as long as a frame and contains a '1' for a bit used and a '0' if not used (padded)
        usedBitsCounter = 0
        for entry in mappingFile:
            if entry["used_bits_mask"].count("1") > frameBitPerRow:
                raise ValueError(
                    f"bitstream mapping file {fileName} has to many 1-elements in bitmask for frame : {entry['frame_name']}"
                )
            if len(entry["used_bits_mask"]) != frameBitPerRow:
                raise ValueError(
                    f"bitstream mapping file {fileName} has has a too long or short bitmask for frame : {entry['frame_name']}"
                )
            usedBitsCounter += entry["used_bits_mask"].count("1")

        if usedBitsCounter != globalConfigBits:
            raise ValueError(
                f"bitstream mapping file {fileName} has a bitmask miss match; bitmask has in total {usedBitsCounter} 1-values for {globalConfigBits} bits"
            )

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
                        raise ValueError(
                            f"Configuration bit index {i} already allocated in {fileName}, {entry['frame_name']}"
                        )
                    configBitsOrder.append(i)

            elif ";" in entry["ConfigBits_ranges"]:
                for item in entry["ConfigBits_ranges"].split(";"):
                    if int(item) in allConfigBitsOrder:
                        raise ValueError(
                            f"Configuration bit index {item} already allocated in {fileName}, {entry['frame_name']}"
                        )
                    configBitsOrder.append(int(item))

            elif "NULL" in entry["ConfigBits_ranges"]:
                continue

            else:
                raise ValueError(
                    f"Range {entry['ConfigBits_ranges']} is not a valid format. It should be in the form [int]:[int] or [int]. If there are multiple ranges it should be separated by ';'"
                )

            allConfigBitsOrder += configBitsOrder

            if entry["used_bits_mask"].count("1") > 0:
                configMemEntry.append(
                    ConfigMem(
                        frameName=entry["frame_name"],
                        frameIndex=int(entry["frame_index"]),
                        bitsUsedInFrame=entry["used_bits_mask"].count("1"),
                        usedBitMask=entry["used_bits_mask"],
                        configBitRanges=configBitsOrder,
                    )
                )

    return configMemEntry


if __name__ == "__main__":
    # result = parseFabricCSV('fabric.csv')
    # result1 = parseList('RegFile_switch_matrix.list', collect="source")
    # result = parseFileVerilog('./LUT4c_frame_config_dffesr.v')

    result2 = parseFileVerilog("./test.txt")
    # print(result[0])
    # print(result[1])
    # print(result[2])
    # print(result[3])

    # print(result.tileDic["W_IO"].portsInfo)
