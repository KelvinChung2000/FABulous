import json
import re
import subprocess
from pathlib import Path
from typing import Literal

from loguru import logger

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO


def verilog_belMapProcessing(module_info):
    """Extracts and transforms BEL mapping attributes in the JSON created from a Verilog module.

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
                        bitMap = list(f"{2**length-i-1:0{length.bit_length()}b}")
                        for v in range(len(bitMap) - 1, -1, -1):
                            belMapDic[bel[0]][i][v] = bitMap.pop(0)
            else:
                belMapDic[bel[0]][0] = {0: "1"}
    return belMapDic


def parseBelFile(
    filename: Path,
    belPrefix: str = "",
    filetype: Literal["verilog", "vhdl"] = "",
) -> Bel:
    """
    Parse a Verilog or VHDL bel file and return all the related information of the bel.
    The tuple returned for relating to ports will be a list of (belName, IO) pair.

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

    Example
    -------
    Verilog
    ::

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

    Parameters
    ----------
        filename : str
            The filename of the bel file.
        belPrefix : str, optional)
            The bel prefix provided by the CSV file. Defaults to "".

    Returns
    -------
    Tuple containing
        - List of Bel Internal ports (belName, IO).
        - List of Bel External ports (belName, IO).
        - List of Bel Config ports (belName, IO).
        - List of Bel Shared ports (belName, IO).
        - Number of configuration bits in the bel.
        - Whether the bel has UserCLK.
        - Bel config bit mapping as a dict {port_name: bit_number}.

    Raises
    ------
    ValueError
        File not found
    ValueError
        No permission to access the file
    """
    internal: list[tuple[str, IO]] = []
    external: list[tuple[str, IO]] = []
    config: list[tuple[str, IO]] = []
    shared: list[tuple[str, IO]] = []
    isExternal = False
    isConfig = False
    isShared = False
    userClk = False
    individually_declared = False
    noConfigBits = 0

    try:
        with open(filename, "r") as f:
            file = f.read()
    except FileNotFoundError:
        logger.critical(f"File {filename} not found.")
        exit(-1)
    except PermissionError:
        logger.critical(f"Permission denied to file {filename}.")
        exit(-1)

    if filetype == "vhdl":
        belMapDic = vhdl_belMapProcessing(file, filename)
        if result := re.search(r"NoConfigBits.*?=.*?(\d+)", file, re.IGNORECASE):
            noConfigBits = int(result.group(1))
        else:
            logger.warning(f"Cannot find NoConfigBits in {filename}")
            logger.warning("Assume the number of configBits is 0")
            noConfigBits = 0
        if len(belMapDic) != noConfigBits:
            logger.error(
                f"NoConfigBits does not match with the BEL map in file {filename}, length of BelMap is {len(belMapDic)}, but with {noConfigBits} config bits"
            )
            raise ValueError
        if result := re.search(
            r"port.*?\((.*?)\);", file, re.MULTILINE | re.DOTALL | re.IGNORECASE
        ):
            file, _ = result.group(1).split("-- GLOBAL")
        else:
            raise ValueError(f"Could not find port section in file {filename}")

        for line in file.split("\n"):
            result = line
            result = re.sub(r"STD_LOGIC.*|;.*|--*", "", result, flags=re.IGNORECASE)
            result = result.replace(" ", "").replace("\t", "").replace(";", "")
            portName = ""
            direction = None
            if "IMPORTANT" in line:
                continue
            if result := re.search(r"(.*):(.*)", result):
                portName = f"{belPrefix}{result.group(1)}"
                if result.group(2).upper() == "IN":
                    direction = IO["INPUT"]
                elif result.group(2).upper() == "OUT":
                    direction = IO["OUTPUT"]
                elif result.group(2).upper() == "INOUT":
                    direction = IO["INOUT"]
                else:
                    logger.error(
                        f"Invalid or Unknown port direction {result.group(2).upper()} in line {line}."
                    )
                    raise ValueError
            else:
                continue
            if line:
                if "EXTERNAL" in line:
                    isExternal = True
                if "CONFIG" in line:
                    isConfig = True
                if "SHARED_PORT" in line:
                    isShared = True
                if "GLOBAL" in line:
                    break

            if portName == "" or direction is None:
                logger.warning(f"Invalid port definition in line {line}.")
                continue
            elif isExternal and not isShared:
                external.append((portName, direction))
            elif isConfig:
                config.append((portName, direction))
            elif isShared:
                # shared port do not have a prefix
                shared.append((portName.removeprefix(belPrefix), direction))
            else:
                internal.append((portName, direction))

            if "UserCLK" in portName:
                userClk = True

            isExternal = False
            isConfig = False
            isShared = False

    if filetype == "verilog":
        # Runs yosys on verilog file, creates netlist, saves to json in same directory.
        json_file = filename.with_suffix(".json")
        runCmd = [
            "yosys",
            "-qp"
            f"read_verilog {filename}; proc -noopt; write_json -compat-int {json_file}",
        ]
        try:
            subprocess.run(runCmd, check=True)
        except subprocess.CalledProcessError as e:
            logger.error(f"Failed to run yosys command: {e}")
            raise ValueError

        with open(f"{json_file}", "r") as f:
            data_dict = json.load(f)

        modules = data_dict.get("modules", {})
        filtered_ports: dict[str, IO] = {}
        # Gathers port name and direction, filters out configbits as they show in ports.
        for module_name, module_info in modules.items():
            ports = module_info["ports"]
            for port_name, details in ports.items():
                if "ConfigBits" in port_name:
                    continue
                if "UserCLK" in port_name:
                    userClk = True
                if port_name[-1].isdigit():
                    individually_declared = True
                direction = IO[details["direction"].upper()]
                bits = details.get("bits", [])
                filtered_ports[port_name] = (direction, bits)

        if individually_declared:
            logger.warning(
                f"Ports in {filename} have been individually declared rather than as a vector."
            )
            logger.warning("Ports will not be concatenated during fabric generation.")

        param_defaults = module_info.get("parameter_default_values")
        if param_defaults and "NoConfigBits" in param_defaults:
            noConfigBits = param_defaults["NoConfigBits"]
        # Passed attributes dont show in port list, checks for attributes in netnames.
        # (If passed attributes missing, may need to expand to check other lists e.g "memories".)
        netnames = module_info.get("netnames", {})
        for item, details in netnames.items():
            if item in filtered_ports:
                direction, bits = filtered_ports[item]
                attributes = details.get("attributes", {})
                for index in range(len(bits)):
                    new_port_name = (
                        f"{item}{index}" if len(bits) > 1 else item
                    )  # Multi-bit ports get index
                    if "EXTERNAL" in attributes and "SHARED_PORT" not in attributes:
                        external.append((f"{belPrefix}{new_port_name}", direction))
                    elif "CONFIG" in attributes:
                        config.append((f"{belPrefix}{new_port_name}", direction))
                    elif "SHARED_PORT" in attributes:
                        shared.append((new_port_name, direction))
                    else:
                        internal.append((f"{belPrefix}{new_port_name}", direction))
        belMapDic = verilog_belMapProcessing(module_info)
        if len(belMapDic) != noConfigBits:
            raise ValueError(
                f"NoConfigBits does not match with the BEL map in file {filename}, length of BelMap is {len(belMapDic)}, but with {noConfigBits} config bits"
            )

    return Bel(
        src=filename,
        prefix=belPrefix,
        internal=internal,
        external=external,
        configPort=config,
        sharedPort=shared,
        configBit=noConfigBits,
        belMap=belMapDic,
        userCLK=userClk,
        individually_declared=individually_declared,
    )
