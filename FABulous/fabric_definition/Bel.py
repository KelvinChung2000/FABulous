from dataclasses import dataclass
from pathlib import Path

from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Port import ConfigPort, Port, SharedPort


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
    prefix: str
    name: str
    inputs: list[Port]
    outputs: list[Port]
    externalInputs: list[Port]
    externalOutputs: list[Port]
    configPort: list[ConfigPort]
    sharedPort: list[SharedPort]
    configBit: int
    belFeatureMap: dict[str, int]
    userCLK: Port | None

    def __init__(
        self,
        src: Path,
        prefix: str,
        internal: list[Port],
        external: list[Port],
        configPort: list[ConfigPort],
        sharedPort: list[SharedPort],
        configBit: int,
        belFeatureMap: dict[str, int],
        userCLK: Port | None,
    ) -> None:
        self.src = src
        self.prefix = prefix
        self.name = src.stem
        self.inputs = [p for p in internal if p.ioDirection == IO.INPUT]
        self.outputs = [p for p in internal if p.ioDirection == IO.OUTPUT]
        self.externalInputs = [p for p in external if p.ioDirection == IO.INPUT]
        self.externalOutputs = [p for p in external if p.ioDirection == IO.OUTPUT]
        self.configPort = configPort
        self.sharedPort = sharedPort
        self.configBit = configBit
        self.belFeatureMap = belFeatureMap
        self.userCLK = userCLK

    def __hash__(self) -> int:
        return hash(f"{self.prefix}{self.name}({self.src})")
