from collections import Counter, namedtuple
from pathlib import Path

from lark import Lark, Transformer, v_args

from FABulous.fabric_definition.SwitchMatrix import Mux

muxGrammar = r"""
    start: (mux | COMMENT)+
    mux: value  ":" value [("," value)*]
    value: CNAME [slice | iter]
    
    iter: "{" INT ".." INT [".." INT] "}"
    slice: "[" INT "]" 
         | "[" INT ":" INT "]"
    
    COMMENT: C_COMMENT | SH_COMMENT | CPP_COMMENT 

    %import common.CNAME
    %import common.INT
    %import common.C_COMMENT
    %import common.SH_COMMENT
    %import common.CPP_COMMENT
    %import common.WS
    %ignore WS

"""

Slice = namedtuple("Slice", ["start", "end"])
Iter = namedtuple("Iter", ["start", "end", "step"])


class MuxTransformer(Transformer):
    @v_args(inline=True)
    def start(self, *items) -> list[Mux]:
        muxes = []
        for item in items:
            if isinstance(item, list):
                muxes.extend(item)
            else:
                muxes.append(item)

        return mergeMux([muxes for muxes in muxes if isinstance(muxes, Mux)])

    @v_args(inline=True)
    def mux(self, dest, *source) -> list[Mux]:
        sourceList = [item for sublist in source for item in sublist]
        muxList: list[Mux] = []
        for i in dest:
            muxList.append(Mux(name=i, inputs=sourceList, output=i))
        return muxList

    @v_args(inline=True)
    def value(self, value, modifier):
        if modifier is None:
            return [value]
        elif isinstance(modifier, Slice):
            return [f"{value}[{i}]" for i in range(modifier.end, modifier.start)]
        elif isinstance(modifier, Iter):
            return [
                f"{value}{i}"
                for i in range(modifier.start, modifier.end + 1, modifier.step)
            ]
        else:
            raise ValueError(f"Unknown modifier {modifier}")

    @v_args(inline=True)
    def slice(self, start, end) -> Slice:
        return Slice(start=start, end=end)

    @v_args(inline=True)
    def iter(self, start, end, step) -> Iter:
        if step is None:
            step = 1
        return Iter(start=start, end=end, step=step)

    INT = int
    CNAME = str
    COMMENT = str


def parseMux(fileName: Path) -> list[Mux]:
    parser = Lark(muxGrammar, parser="lalr", transformer=MuxTransformer())

    with open(fileName, "r") as f:
        return parser.parse(f.read())


def mergeMux(muxList: list[Mux]) -> list[Mux]:
    outputDict: dict[str, Mux] = {}

    for mux in muxList:
        if mux.output in outputDict:
            outputDict[mux.output].inputs.extend(mux.inputs)
            c = Counter(outputDict[mux.output].inputs)
            outputDict[mux.output].inputs = list(c.keys())
            outputDict[mux.output]._update()
        else:
            outputDict[mux.output] = mux

    return list(outputDict.values())


if __name__ == "__main__":
    with open("/home/kelvin/FABulous_fork/myProject/Tile/PE/PE.list", "r") as f:
        print(parseMux.parse(f.read()))
