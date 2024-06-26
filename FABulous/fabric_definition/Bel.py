from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Port import Port


class Bel:
    """
    Contains all the information about a single BEL. The information is parsed from the directory of the BEL in the CSV
    definition file. There are something to be noted.

    * The parsed name will contains the prefix of the bel.
    * The `sharedPort` attribute is a list of Tuples with name of the port and IO information which is not expanded out yet.
    * If a port is marked as both shared and external, the port is considered as shared. As a result signal like UserCLK will be in shared port list, but not in external port list.


    Attributes:
        src (str): The source directory of the BEL given in the CSV file.
        prefix (str): The prefix of the BEL given in the CSV file.
        name (str): The name of the BEL, extracted from the source directory.
        inputs (list[str]): All the normal input ports of the BEL.
        outputs (list[str]) : All the normal output ports of the BEL.
        externalInput (list[str]) : ALL the external input ports of the BEL.
        externalOutput: (list[str]) : All the external output ports of the BEL.
        configPort (list[str]) : All the config ports of the BEL.
        sharedPort (list[tuple[str, IO]]) : All the shared ports of the BEL.
        configBit (int) : The number of config bits of the BEL have.
        belFeatureMap (dict[str, dict]) : The feature map of the BEL.
        withUserCLK (bool) : Whether the BEL has userCLK port. Default is False.
    """

    def __init__(
        self,
        src: str,
        name: str,
        prefix: str,
        internalPorts: list[Port],
        externalPorts: list[Port],
        configPort: list[Port],
        sharedPort: list[Port],
        configBit: int,
        belMap: dict[str, dict],
        userCLK: bool,
    ) -> None:
        self.src = src
        self.name = name
        self.prefix = prefix
        self.inputs = [p.name for p in internalPorts if p.inOut == IO.INPUT]
        self.outputs = [p.name for p in internalPorts if p.inOut == IO.OUTPUT]
        self.externalInput = [p.name for p in externalPorts if p.inOut == IO.INPUT]
        self.externalOutput = [p.name for p in externalPorts if p.inOut == IO.OUTPUT]
        self.configPort = configPort
        self.sharedPort = sharedPort
        self.configBit = configBit
        self.belFeatureMap = belMap
        self.withUserCLK = userCLK

    def __repr__(self) -> str:
        return f"[{self.inputs}]{self.prefix}{self.name}[{self.outputs}]"
