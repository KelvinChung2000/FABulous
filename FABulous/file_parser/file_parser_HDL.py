import re
import subprocess
from pathlib import Path
from pprint import pprint

from loguru import logger

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import (
    IO,
    BelType,
    FABulousPortType,
    FeatureType,
    FeatureValue,
    YosysJson,
    YosysModule,
)
from FABulous.fabric_definition.Port import BelPort, ConfigPort, Port, SharedPort


def parseBelFile(
    filename: Path,
    belPrefix: str = "",
    paramOverride: dict[str, str] = {},
) -> Bel:
    """Parse a Verilog or VHDL bel file and return all the related information of the
    bel. The tuple returned for relating to ports will be a list of (belName, IO) pair.

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
    externalPort: list[BelPort] = []
    configPort: list[ConfigPort] = []
    sharedPort: list[SharedPort] = []
    internalPort: list[BelPort] = []
    userClk: Port | None = None

    if not filename.exists():
        logger.error(f"File {filename} not found.")
        raise ValueError

    Path(filename.parent / "metadata").mkdir(exist_ok=True)
    jsonFile: Path

    with open(filename, "r") as f:
        fileContent = f.read()
        if (
            moduleName := re.search(r"module\s+(\w+)", fileContent)
        ) and moduleName.group(1) != filename.stem:
            logger.error(
                f"Module name {moduleName.group(1)} does not match file name {filename.stem}."
            )
            raise ValueError

    if filename.suffix == ".v":
        # Runs yosys on verilog file, creates netlist, saves to json in same directory.
        if len(paramOverride) == 0:
            nName = f"{filename.stem}"
        else:
            nName = f"{filename.stem}_{'__'.join([f'{k}_{v}' for k, v in paramOverride.items()])}"
        jsonFile = filename.parent / Path("metadata") / Path(f"{nName}.json")
        runCmd = [
            "yosys",
            "-qp",
            f"read_verilog -defer -sv {filename}; "
            + " ".join([f"chparam -set {u} {v};" for u, v in paramOverride.items()])
            + f" hierarchy -top {filename.stem}; rename -top {nName}; proc -noopt;  write_json -compat-int {jsonFile}",
        ]
    elif filename.suffix == ".vhdl":
        jsonFile = filename.parent / Path("metadata") / Path(f"{filename.stem}.json")
        runCmd = [
            "yosys",
            "-m ghdl",
            "-qp",
            f"ghdl {filename}; proc -noopt; write_json -compat-int {jsonFile}",
        ]

    try:
        logger.info(f"Parsing bel file: {filename}")
        subprocess.run(runCmd, check=True, text=True, capture_output=True)
    except subprocess.CalledProcessError as e:
        logger.error(f"Failed to run yosys command: {' '.join(runCmd)}\n{e.stderr}")
        raise ValueError

    yosysObj = YosysJson(jsonFile)

    if len(yosysObj.modules) > 1:
        logger.error(
            f"Multiple modules found in {filename}. Only one module per file is allowed."
        )
        raise ValueError
    elif len(yosysObj.modules) == 0:
        logger.error(f"No modules found in {filename}.")
        raise ValueError

    module: YosysModule = yosysObj.getTopModule()

    ports: dict[str, IO] = {}

    for port_name, port_info in module.ports.items():
        ports[port_name] = IO[port_info.direction.upper()]

    # Passed attributes dont show in port list, checks for attributes in netnames.
    for net, details in module.netnames.items():
        if net not in ports:
            continue

        netBitWidth = len(details.bits)
        attributes = set(details.attributes)

        port = BelPort(
            name=f"{net}",
            ioDirection=ports[net],
            width=netBitWidth,
            prefix=belPrefix,
            external=FABulousPortType.EXTERNAL in attributes,
            control=FABulousPortType.CONTROL in attributes,
        )
        if FABulousPortType.EXTERNAL in attributes:
            externalPort.append(port)
        elif FABulousPortType.CONFIG_BIT in attributes:
            features = details.attributes.get("FEATURE", "")
            features = list(filter(lambda x: x != "", features.split(";")))
            if details.attributes.get("FEATURE_TYPE", "ENUMERATE") not in FeatureType:
                raise ValueError(
                    f"FEATURE_TYPE {details.attributes.get('FEATURE_TYPE', '')} in file {filename} is not a valid FeatureType."
                )
            featureType = FeatureType[
                details.attributes.get("FEATURE_TYPE", "ENUMERATE")
            ]
            if len(features) == 0:
                raise ValueError(
                    f"CONFIG_BIT port and {net} in file {filename} must have at least one feature."
                )
            if ports[net] != IO.INPUT:
                raise ValueError(
                    f"CONFIG_BIT port {net} in file {filename} must be an input port."
                )
            featureList: list[FeatureValue] = []
            match featureType:
                case FeatureType.INIT:
                    if len(features) > 1:
                        raise ValueError(
                            f"In file {filename}, the INIT feature type can only have one feature, but found {len(features)} features."
                        )
                    featureList.append(FeatureValue(name=features[0], value=None))
                case FeatureType.ONE_HOT:
                    if len(features) != netBitWidth:
                        raise ValueError(
                            f"In file {filename}, the ONE_HOT feature type must have the same number of features as the port width, but found {len(features)} features and port width is {netBitWidth}."
                        )
                    for i, name in enumerate(features):
                        featureList.append(FeatureValue(name=name, value=(1 << i)))
                case FeatureType.ENUMERATE:
                    if netBitWidth == 1 and len(features) == 1:
                        featureList.append(
                            FeatureValue(name=f"{features[0]}_off", value=0)
                        )
                        featureList.append(
                            FeatureValue(name=f"{features[0]}_on", value=1)
                        )
                    elif 1 <= netBitWidth < 8:
                        maxFeatureValue = 2**netBitWidth
                        if len(features) > maxFeatureValue:
                            raise ValueError(
                                f"In file {filename}, the ENUMERATE feature type can only have {maxFeatureValue} features, but found {len(features)} features."
                            )
                        for i, name in enumerate(features):
                            featureList.append(FeatureValue(name=name, value=i))
                    else:
                        raise ValueError(
                            f"In file {filename}, the ENUMERATE feature type must have a port width between 1 and 7 "
                            f"but found {netBitWidth}. You are trying to set more than 256 features,"
                            "are you missing the FEATURE_TYPE=INIT attribute?"
                        )

            configPort.append(
                ConfigPort(
                    name=f"{net}",
                    ioDirection=IO.INPUT,
                    width=netBitWidth,
                    features=featureList,
                    featureType=featureType,
                )
            )
        elif FABulousPortType.USER_CLK in attributes:
            userClk = port
        elif FABulousPortType.SHARED in attributes:
            sharedPort.append(
                SharedPort(
                    name=f"{belPrefix}{net}",
                    ioDirection=ports[net],
                    width=netBitWidth,
                    sharedWith=details.attributes.get("SHARED", ""),
                )
            )
        elif FABulousPortType.CONTROL in attributes:
            if port.width != 1:
                raise ValueError(
                    f"Control port {net} in file {filename} must have a width of 1."
                )
            internalPort.append(port)
        else:
            internalPort.append(port)

    attList = []
    moduleAttributes = module.attributes
    for a in moduleAttributes:
        if a.upper() in BelType:
            attList.append(a)

    if len(attList) > 1:
        logger.opt(exception=ValueError()).error(
            f"Multiple BelType attributes found in {filename}. Only one BelType attribute per file is allowed."
        )

    if len(attList) == 0:
        logger.opt(exception=ValueError()).error(
            f"No BelType attribute found in {filename}. At least one BelType attribute is required."
        )

    inputs = [p for p in internalPort if p.ioDirection == IO.INPUT]
    outputs = [p for p in internalPort if p.ioDirection == IO.OUTPUT]
    externalInputs = [p for p in externalPort if p.ioDirection == IO.INPUT]
    externalOutputs = [p for p in externalPort if p.ioDirection == IO.OUTPUT]
    return Bel(
        src=filename,
        jsonPath=jsonFile,
        prefix=belPrefix,
        name=filename.stem,
        belType=attList[0],
        inputs=inputs,
        outputs=outputs,
        externalInputs=externalInputs,
        externalOutputs=externalOutputs,
        configPort=configPort,
        sharedPort=sharedPort,
        userCLK=userClk,
        paramOverride=paramOverride,
    )


if __name__ == "__main__":
    pprint(parseBelFile(Path("/home/kelvin/FABulous_fork/myProject/Tile/PE/ALU.v")))
