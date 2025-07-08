import json
import re
from dataclasses import dataclass
from enum import StrEnum
from pathlib import Path
from typing import Literal


class IO(StrEnum):
    INPUT = "input"
    OUTPUT = "output"
    INOUT = "inout"
    NULL = "null"


class Direction(StrEnum):
    NORTH = "NORTH"
    SOUTH = "SOUTH"
    EAST = "EAST"
    WEST = "WEST"
    JUMP = "JUMP"


class Side(StrEnum):
    NORTH = "NORTH"
    SOUTH = "SOUTH"
    EAST = "EAST"
    WEST = "WEST"
    ANY = "ANY"


class BelType(StrEnum):
    ARITH = "ARITH"
    LOGIC = "LOGIC"
    REG = "REG"
    MEM = "MEM"
    CTRL = "CTRL"
    IO = "IO"


class MultiplexerStyle(StrEnum):
    CUSTOM = "CUSTOM"
    GENERIC = "GENERIC"


class ConfigBitMode(StrEnum):
    FRAME_BASED = "FRAME_BASED"
    FLIPFLOP_CHAIN = "FLIPFLOP_CHAIN"


class FABulousPortType(StrEnum):
    EXTERNAL = "EXTERNAL"
    CONFIG_BIT = "CONFIG_BIT"
    USER_CLK = "USER_CLK"
    GLOBAL = "GLOBAL"
    BUS = "BUS"
    SHARED = "SHARED"
    CONTROL = "CONTROL"
    DATA = "DATA"


class FeatureType(StrEnum):
    ENUMERATE = "ENUMERATE"
    INIT = "INIT"
    ONE_HOT = "ONE_HOT"
    FEATURE_MAP = "FEATURE_MAP"


Loc = tuple[int, int]

BitVector = list[int | Literal["0", "1", "x", "z"]]


@dataclass
class YosysPortDetails:
    direction: Literal["input", "output", "inout"]
    bits: BitVector
    offset: int = 0
    upto: int = 0
    signed: int = 0


@dataclass
class YosysCellDetails:
    hide_name: Literal[1, 0]
    type: str
    parameters: dict[str, str]
    attributes: dict[str, str | int]
    port_directions: dict[str, Literal["input", "output", "inout"]]
    connections: dict[str, BitVector]
    model: str = ""


@dataclass
class YosysMemoryDetails:
    hide_name: Literal[1, 0]
    attributes: dict[str, str]
    width: int
    start_offset: int
    size: int


@dataclass
class YosysNetDetails:
    hide_name: Literal[1, 0]
    bits: BitVector
    attributes: dict[str, str]
    offset: int = 0
    upto: int = 0
    signed: int = 0


@dataclass
class YosysModule:
    attributes: dict[str, str | int]
    parameter_default_values: dict[str, str | int]
    ports: dict[str, YosysPortDetails]
    cells: dict[str, YosysCellDetails]
    memories: dict[str, YosysMemoryDetails]
    netnames: dict[str, YosysNetDetails]

    def __init__(
        self, *, attributes, parameter_default_values, ports, cells, memories, netnames
    ):
        self.attributes = attributes
        self.parameter_default_values = parameter_default_values
        self.ports = {k: YosysPortDetails(**v) for k, v in ports.items()}
        self.cells = {k: YosysCellDetails(**v) for k, v in cells.items()}
        self.memories = {k: YosysMemoryDetails(**v) for k, v in memories.items()}
        self.netnames = {k: YosysNetDetails(**v) for k, v in netnames.items()}


@dataclass
class YosysJson:
    srcPath: Path
    creator: str
    modules: dict[str, YosysModule]
    models: dict

    def __init__(self, path: Path):
        self.srcPath = path
        with open(path, "r") as f:
            o = json.load(f)
        self.creator = o.get("creator", "")  # Use .get() for safety
        # Provide default empty dicts for potentially missing keys in module data
        self.modules = {
            k: YosysModule(
                attributes=v.get("attributes", {}),
                parameter_default_values=v.get("parameter_default_values", {}),
                ports=v.get("ports", {}),
                cells=v.get("cells", {}),
                memories=v.get("memories", {}),  # Provide default for memories
                netnames=v.get("netnames", {}),  # Provide default for netnames
            )
            for k, v in o.get("modules", {}).items()  # Use .get() for safety
        }
        self.models = o.get("models", {})  # Use .get() for safety

    def getTopModule(self) -> YosysModule:
        for module in self.modules.values():
            if "top" in module.attributes:
                return module
        raise ValueError("No top module found in Yosys JSON")

    def isTopModuleNet(self, net: int) -> bool:
        for module in self.modules.values():
            for pDetail in module.ports.values():
                if net in pDetail.bits:
                    return True
        return False

    def isNetUsed(self, net: int) -> bool:
        for module in self.modules.values():
            for net_name, net_details in module.netnames.items():
                if net in net_details.bits and "unused_bits" in net_details.attributes:
                    if r := re.search(r"\w+\[(\d+)\]", net_name):
                        if int(r.group(1)) in [
                            int(i)
                            for i in net_details.attributes["unused_bits"].split(" ")
                        ]:
                            return False

                    else:
                        if "0 " in net_details.attributes["unused_bits"]:
                            return False
        return True

    def getNetPortSrcSinks(
        self, net: int
    ) -> tuple[tuple[str, str], list[tuple[str, str]]]:
        src: list[tuple[str, str]] = []
        sinks: list[tuple[str, str]] = []
        for module in self.modules.values():
            for cell_name, cell_details in module.cells.items():
                for conn_name, conn_details in cell_details.connections.items():
                    if net in conn_details:
                        if cell_details.port_directions[conn_name] == "output":
                            src.append((cell_name, conn_name))
                        else:
                            sinks.append((cell_name, conn_name))

        if len(sinks) == 0:
            raise ValueError(
                f"Net {net} not found in Yosys JSON or is a top module port output"
            )

        if len(src) == 0:
            src.append(("", "z"))

        if len(src) > 1:
            raise ValueError(f"Multiple driver found for net {net}: {src}")

        return src[0], sinks

    def findNetWithAttribute(self, attribute: str) -> list[str] | None:
        """Find the first net with the specified attribute in the Yosys JSON.

        Returns the net name if found, otherwise raises ValueError.
        """
        nets_with_attribute = []
        for module in self.modules.values():
            for net_name, net_details in module.netnames.items():
                if attribute in net_details.attributes:
                    nets_with_attribute.append(net_name)

        return nets_with_attribute if nets_with_attribute else None
