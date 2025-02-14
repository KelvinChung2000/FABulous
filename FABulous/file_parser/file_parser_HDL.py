import json
import subprocess
from pathlib import Path
from pprint import pprint

from loguru import logger

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO, FABulousPortType, FeatureType
from FABulous.fabric_definition.Port import BelPort, ConfigPort, Port, SharedPort


def parseBelFile(
    filename: Path,
    belPrefix: str = "",
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
    belFeatureMap: dict[str, int] = {}
    userClk: Port | None = None

    if not filename.exists():
        logger.error(f"File {filename} not found.")
        raise ValueError

    Path(filename.parent / "metadata").mkdir(exist_ok=True)
    json_file = filename.parent / Path("metadata") / filename.with_suffix(".json").name
    if filename.suffix == ".v":
        # Runs yosys on verilog file, creates netlist, saves to json in same directory.
        runCmd = [
            "yosys",
            "-qp",
            f"read_verilog {filename}; proc -noopt; write_json -compat-int {json_file}",
        ]
    elif filename.suffix == ".vhdl":
        runCmd = [
            "yosys",
            "-m ghdl",
            "-qp",
            f"ghdl {filename}; proc -noopt; write_json -compat-int {json_file}",
        ]

    try:
        logger.info(f"Parsing bel file: {filename}")
        subprocess.run(runCmd, check=True, text=True, capture_output=True)
    except subprocess.CalledProcessError as e:
        logger.error(f"Failed to run yosys command: {' '.join(runCmd)}")
        logger.error(e.stderr)
        raise ValueError

    with open(f"{json_file}", "r") as f:
        data_dict = json.load(f)

    modules = data_dict.get("modules", {})
    if len(modules) > 1:
        logger.error(
            f"Multiple modules found in {filename}. Only one module per file is allowed."
        )
        raise ValueError
    elif len(modules) == 0:
        logger.error(f"No modules found in {filename}.")
        raise ValueError

    module: dict = modules[list(modules.keys())[0]]

    ports: dict[str, IO] = {}

    for port_name, port_info in module["ports"].items():
        ports[port_name] = IO[port_info["direction"].upper()]

    # Passed attributes dont show in port list, checks for attributes in netnames.
    netnames = module.get("netnames", {})
    for net, details in netnames.items():
        if net not in ports:
            continue

        netBitWidth = len(details.get("bits", [1]))
        attributes = set(details.get("attributes", {}).keys())
        if "FABulous" not in attributes:
            continue

        port = BelPort(
            name=f"{net}",
            ioDirection=ports[net],
            wireCount=netBitWidth,
            isBus=FABulousPortType.BUS in attributes,
            prefix=belPrefix,
            external=FABulousPortType.EXTERNAL in attributes,
        )

        if FABulousPortType.EXTERNAL in attributes:
            externalPort.append(port)
        elif FABulousPortType.CONFIG_BIT in attributes:
            features = details.get("attributes", {}).get("FEATURE", "")
            features = features.split(";")
            featureType = attributes - set(["FABulous", "CONFIG_BIT", "src", "FEATURE"])
            if len(features) == 0:
                raise ValueError(
                    f"CONFIG_BIT port and {net} in file {filename} must have at least one feature."
                )
            # if len(featureType) != 1:
            #     raise ValueError(
            #         f"CONFIG_BIT port and {net} in file {filename} must have exactly one feature type."
            #     )
            if ports[net] != IO.INPUT:
                raise ValueError(
                    f"CONFIG_BIT port {net} in file {filename} must be an input port."
                )

            for i, feature in enumerate(features):
                belFeatureMap[feature] = i

            configPort.append(
                ConfigPort(
                    name=f"{net}",
                    ioDirection=IO.INPUT,
                    wireCount=netBitWidth,
                    isBus=FABulousPortType.BUS in attributes,
                    features=[(feature, i) for i, feature in enumerate(features)],
                    featureType=FeatureType.INIT,
                )
            )
        elif FABulousPortType.USER_CLK in attributes:
            userClk = port
        elif FABulousPortType.SHARED in attributes:
            sharedPort.append(
                SharedPort(
                    name=f"{belPrefix}{net}",
                    ioDirection=ports[net],
                    wireCount=netBitWidth,
                    isBus=FABulousPortType.BUS in attributes,
                    sharedWith=details.get("attributes", {}).get("SHARED_WITH", ""),
                )
            )

        else:
            internalPort.append(port)

    return Bel(
        src=filename,
        prefix=belPrefix,
        internal=internalPort,
        external=externalPort,
        configPort=configPort,
        sharedPort=sharedPort,
        configBit=sum([i.wireCount for i in configPort]),
        belFeatureMap=belFeatureMap,
        userCLK=userClk,
    )


if __name__ == "__main__":
    pprint(parseBelFile(Path("/home/kelvin/FABulous_fork/myProject/Tile/PE/ALU.v")))
