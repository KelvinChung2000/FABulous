import json
import subprocess as sp
from pathlib import Path
from typing import cast

from lark import Lark, Transformer, v_args

from FABulous.fabric_definition.define import IO
from FABulous.fabric_generator.code_generator_2 import CodeGenerator

cgraPrims = Path("/home/kelvin/FABulous_fork/myProject/Tile/PE/ALU.v")

hlsPrims = Path("/home/kelvin/FABulous_fork/myProject/PnR/prims/binary_operators.sv")

sp.run(
    [
        "yosys",
        "-qp",
        f"read_verilog -sv {cgraPrims}; proc -noopt; write_json -compat-int {cgraPrims.with_suffix('.json')}",
    ]
)

sp.run(
    [
        "yosys",
        "-qp",
        f"read_verilog -sv {hlsPrims}; proc -noopt; write_json -compat-int {hlsPrims.with_suffix('.json')}",
    ]
)

grammer = r"""
    featurelist: feature+
    feature: CNAME "(" pairs ");"
    pairs: pair ("," pair)*
    pair : (CNAME | INT) "=>" CNAME

    %import common.CNAME
    %import common.WS
    %import common.NEWLINE
    %import common.INT
    %import common.ESCAPED_STRING -> COND
    %ignore WS
    %ignore NEWLINE

"""


with open(hlsPrims.with_suffix(".json")) as f:
    hlsPrimsDict = json.load(f)

with open(cgraPrims.with_suffix(".json")) as f:
    fabricPrimsDict = json.load(f)


class PortMapTransformer(Transformer):
    CNAME = str
    INT = int
    COND = str

    def featurelist(self, items):
        return dict(items)

    @v_args(inline=True)
    def feature(self, name, pairs):
        return (name, pairs)

    def pairs(self, items):
        return dict(items)

    @v_args(inline=True)
    def pair(self, source, dest):
        return (source, dest)


portMapParser = Lark(
    grammer,
    start="featurelist",
    parser="lalr",
    transformer=PortMapTransformer(),
)

portMaps: dict = {}

for module, data in fabricPrimsDict["modules"].items():
    for netname, net in data["netnames"].items():
        if attr := net["attributes"].get("FEATURE_MAP", None):
            portMaps[module] = cast(dict, portMapParser.parse(attr))

cg = CodeGenerator("techmap.v")

for cgraModule, maps in portMaps.items():
    fabricPortsJson = fabricPrimsDict["modules"][cgraModule]["ports"]
    fabricParametersJson = fabricPrimsDict["modules"][cgraModule][
        "parameter_default_values"
    ]
    for name, portsMapping in maps.items():
        if data := hlsPrimsDict["modules"].get(name, None):
            hlsPortsJson = data["ports"]
            hlsParametersJson = data["parameter_default_values"]

            hlsPrimsPorts = []
            for pName, data in hlsPortsJson.items():
                hlsPrimsPorts.append(
                    cg.Port(pName, IO[data["direction"].upper()], len(data["bits"]))
                )

            hlsPrimsParameters = []
            for pName, value in hlsParametersJson.items():
                hlsPrimsParameters.append(cg.Parameter(pName, value))

            # Check if the ports mapping exists in the both hls prims cgra prims
            for src, dst in portsMapping.items():
                if src not in hlsPortsJson and not isinstance(src, int):
                    raise ValueError(f"Port {src} not found in HLS prims")

                if dst not in fabricPrimsDict["modules"][cgraModule]["ports"]:
                    raise ValueError(f"Port {dst} not found in fabric prims")
            paramConPair = []
            for pName, value in fabricParametersJson.items():
                paramConPair.append(cg.ConnectPair(pName, value))

            portConPair = []
            flipPair = {v: k for k, v in portsMapping.items()}
            for dstPort in fabricPortsJson:
                if dstPort in flipPair:
                    portConPair.append(cg.ConnectPair(dstPort, flipPair[dstPort]))
                else:
                    portConPair.append(cg.ConnectPair(dstPort))

            with cg.Module(
                f"{name}_techmap",
                hlsPrimsParameters,
                hlsPrimsPorts,
                [cg.Attribute("techmap_celltype", f'"{name}"')],
            ):
                with cg.Generate():
                    cg.InitModule(
                        cgraModule,
                        "__TECHMAP_REPLACE__",
                        paramConPair,
                        portConPair,
                    )


# with cg.Module(
#     "ALU",
#     [
#         cg.Parameter("WIDTH", 16),
#         cg.Parameter("OPCODE", 4),
#     ],
#     [
#         cg.Port("clk", IO.INPUT, 1),
#         cg.Port("rst", IO.INPUT, 1),
#         cg.Port("a", IO.INPUT, 16),
#         cg.Port("b", IO.INPUT, 16),
#         cg.Port("c", IO.INPUT, 16),
#     ],
#     [
#         cg.Attribute("techmap_celltype", "alu"),
#     ],
# ):
#     with cg.Generator():
#         cg.InitModule(
#             "ALU",
#             "__TECHMAP_REPLACE__",
#             [cg.ConnectPair("NoConfigBits", 3)],
#             [
#                 cg.ConnectPair("rst"),
#                 cg.ConnectPair("clk"),
#                 cg.ConnectPair("a"),
#                 cg.ConnectPair("b"),
#                 cg.ConnectPair("c"),
#             ],
#         )
