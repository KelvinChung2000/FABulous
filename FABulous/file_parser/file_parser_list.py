from collections import namedtuple
from pathlib import Path
from typing import cast

from lark import Lark, Transformer, v_args

from FABulous.fabric_definition.SwitchMatrix import Mux, SwitchMatrix
from FABulous.fabric_generator.HDL_Construct.Value import Value

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
    def start(self, *items) -> SwitchMatrix:
        muxes = []
        for item in items:
            if isinstance(item, list):
                muxes.extend(item)
            else:
                muxes.append(item)
        sm = SwitchMatrix()

        for mux in muxes:
            if isinstance(mux, Mux):
                sm.addMux(mux)

        return sm

    @v_args(inline=True)
    def mux(self, dest, *source) -> list[Mux]:
        sourceList = [
            Value(item, 1, isSignal=True) for sublist in source for item in sublist
        ]
        muxList: list[Mux] = []
        for i in dest:
            muxList.append(
                Mux(name=i, inputs=sourceList, output=Value(i, 1, isSignal=True))
            )
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


def parseMux(fileName: Path) -> SwitchMatrix:
    parser = Lark(muxGrammar, parser="lalr", transformer=MuxTransformer())

    with open(fileName, "r") as f:
        return cast(SwitchMatrix, parser.parse(f.read()))


def mergeMux(muxList: list[Mux]) -> list[Mux]:
    outputDict: dict[str, Mux] = {}

    for mux in muxList:
        if mux.output in outputDict:
            outputDict[mux.output.value].extendInputs(mux.inputs)
        else:
            outputDict[mux.output.value] = mux
    return list(outputDict.values())


if __name__ == "__main__":
    with open("/home/kelvin/FABulous_fork/myProject/Tile/PE/PE.list", "r") as f:
        print(parseMux.parse(f.read()))
