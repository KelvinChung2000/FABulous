from dataclasses import dataclass, field
from pathlib import Path
import pprint

from FABulous.fabric_definition.define import IO, BelType
from FABulous.fabric_definition.Port import (
    BelPort,
    ConfigPort,
    GenericPort,
    Port,
    SharedPort,
)


@dataclass
class Bel:
    """Contains all the information about a single BEL. The information is parsed from
    the directory of the BEL in the CSV definition file. There are some things to be
    noted.

    - The parsed name will contain the prefix of the bel.
    - The `sharedPort` attribute is a list of Tuples with the name of the port and IO information, which is not expanded out yet.
    - If a port is marked as both shared and external, the port is considered as shared,
    as a result, signals like UserCLK will be in the shared port list, but not in the external port list.


    Attributes
    ----------
    src : pathlib.Path
        The source directory of the BEL given in the CSV file.
    prefix : str
        The prefix of the BEL given in the CSV file.
    name : str
        The name of the BEL, extracted from the source directory.
    inputs : list[Port]
        All the normal input ports of the BEL.
    outputs : list[Port]
        All the normal output ports of the BEL.
    externalInput : list[Port]
        All the external input ports of the BEL.
    externalOutput : list[Port]
        All the external output ports of the BEL.
    configPort : list[Port]
        All the config ports of the BEL.
    sharedPort : list[tuple[Port, IO]]
        All the shared ports of the BEL.
    configBit : int
        The number of config bits of the BEL.
    belFeatureMap : dict[str, dict]
        The feature map of the BEL.
    userCLK : Port | None
        The user clock port of the BEL. Default is None.
    individually_declared : bool
        Indicates if ports are individually declared. Default is False.
    """

    src: Path
    jsonPath: Path
    prefix: str
    _name: str
    belType: BelType
    inputs: list[BelPort]
    outputs: list[BelPort]
    externalInputs: list[BelPort]
    externalOutputs: list[BelPort]
    configPort: list[ConfigPort]
    sharedPort: list[SharedPort]
    userCLK: Port | None
    z: int = 0
    baseBel: bool = False
    paramOverride: dict[str, str] = field(default_factory=dict)

    def __init__(
        self,
        src: Path,
        jsonPath: Path,
        prefix: str,
        name: str,
        belType: BelType,
        inputs: list[BelPort],
        outputs: list[BelPort],
        externalInputs: list[BelPort],
        externalOutputs: list[BelPort],
        configPort: list[ConfigPort],
        sharedPort: list[SharedPort],
        userCLK: Port | None = None,
        z: int = 0,
        paramOverride: dict[str, str] = {},
    ):
        self.src = src
        self.jsonPath = jsonPath
        self.prefix = prefix
        self._name = name
        self.belType = belType
        self.inputs = inputs
        self.outputs = outputs
        self.externalInputs = externalInputs
        self.externalOutputs = externalOutputs
        self.configPort = configPort
        self.sharedPort = sharedPort
        self.userCLK = userCLK
        self.z = z
        self.paramOverride = paramOverride

    @property
    def name(self) -> str:
        if len(self.paramOverride) == 0:
            return f"{self._name}"
        else:
            return f"{self._name}_{'__'.join([f'{k}_{v}' for k, v in self.paramOverride.items()])}"

    @property
    def configBits(self) -> int:
        return sum([i.width for i in self.configPort])

    @property
    def constantBel(self) -> bool:
        return len(self.externalInputs) + len(self.inputs) == 0

    def __post_init__(self):
        if self.belType == BelType.IO:
            if len(self.externalInputs) > 1:
                raise ValueError(
                    f"IO Bel {self.name} have at most one external input port"
                )
            if len(self.externalOutputs) > 1:
                raise ValueError(
                    f"IO Bel {self.name} have at most one external output port"
                )
        for i in self.sharedPort:
            if not isinstance(i, SharedPort):
                raise TypeError(
                    f"Shared port {i} in {self.name} is not a SharedPort object"
                )
            if i.ioDirection == IO.OUTPUT:
                raise ValueError(
                    f"Shared port {i} in {self.name} is an output port, which is not allowed"
                )

        for i in self.configPort:
            if not isinstance(i, ConfigPort):
                raise TypeError(
                    f"Config port {i} in {self.name} is not a ConfigPort object"
                )
            if i.ioDirection == IO.OUTPUT:
                raise ValueError(
                    f"Config port {i} in {self.name} is an output port, which is not allowed"
                )

    def __hash__(self) -> int:
        return hash(f"{self.prefix}{self.name}({self.src})")

    def findPortByName(self, name: str) -> GenericPort:
        for p in (
            self.inputs
            + self.outputs
            + self.externalInputs
            + self.externalOutputs
            + self.configPort
            + self.sharedPort
        ):
            if p.name == name:
                return p
        raise ValueError(f"Port {name} not found in {self.name}")

    def __str__(self) -> str:
        """Return a formatted string representation of the Bel.

        Returns
        -------
        str
            A well-formatted string representation of the Bel.
        """
        # Create a dictionary of all attributes for cleaner formatting
        data = {
            "src": self.src,
            "jsonPath": self.jsonPath,
            "prefix": self.prefix,
            "name": self._name,
            "belType": self.belType,
            "inputs": self.inputs,
            "outputs": self.outputs,
            "externalInputs": self.externalInputs,
            "externalOutputs": self.externalOutputs,
            "configPort": self.configPort,
            "sharedPort": self.sharedPort,
            "paramOverride": self.paramOverride,
            "configBits": self.configBits,
            "userCLK": self.userCLK,
            "constantBel": self.constantBel,
            "z": self.z,
        }

        # Use pprint to format the dictionary nicely
        formatted_data = pprint.pformat(data, width=80, indent=2)

        # Replace the outer braces with Bel() constructor syntax
        formatted_data = formatted_data.replace("{", "Bel(", 1)
        formatted_data = formatted_data.rsplit("}", 1)[0] + ")"

        return formatted_data
