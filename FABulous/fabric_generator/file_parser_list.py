from collections import namedtuple
from pathlib import Path

from lark import Lark, Transformer, v_args

from FABulous.fabric_definition.Mux import Mux

muxGrammar = r"""
    start: (mux | COMMENT)+
    mux: value  ":" value
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
        return [muxes for muxes in muxes if isinstance(muxes, Mux)]

    @v_args(inline=True)
    def mux(self, dest, source) -> list[Mux]:

        destList = []
        if dest[1] is None:
            destList.append(dest[0])
        elif isinstance(dest[1], Slice):
            for i in range(dest[1].start, dest[1].end):
                destList.append(f"{dest[0]}[{i}]")
        elif isinstance(dest[1], Iter):
            if dest[1].step is None:
                for i in range(dest[1].start, dest[1].end + 1, 1):
                    destList.append(f"{dest[0]}{i}")
            else:
                for i in range(dest[1].start, dest[1].end + 1, dest[1].step):
                    destList.append(f"{dest[0]}{i}")

        sourceList = []
        if source[1] is None:
            sourceList.append(source[0])
        elif isinstance(source[1], Slice):
            for i in range(source[1].start, source[1].end):
                sourceList.append(f"{source[0]}[{i}]")
        elif isinstance(source[1], Iter):
            if source[1].step is None:
                for i in range(source[1].start, source[1].end + 1, 1):
                    sourceList.append(f"{source[0]}{i}")
            else:
                for i in range(source[1].start, source[1].end + 1, source[1].step):
                    sourceList.append(f"{source[0]}{i}")

        muxList: list[Mux] = []
        if len(destList) == 1:
            muxList.append(
                Mux(name=destList[0], inputs=sourceList, output=destList[0], width=1)
            )
        else:
            if len(destList) != len(sourceList):
                raise ValueError(
                    f"Number of dest and source for {dest} and {source} do not match"
                )
            else:
                for source, dest in zip(sourceList, destList):
                    muxList.append(
                        Mux(name=dest, inputs=[source], output=dest, width=1)
                    )
        return muxList

    @v_args(inline=True)
    def value(self, value, modifier):
        return (value, modifier)

    @v_args(inline=True)
    def slice(self, start, end) -> Slice:
        return Slice(start=start, end=end)

    @v_args(inline=True)
    def iter(self, start, end, step) -> Iter:
        return Iter(start=start, end=end, step=step)

    INT = int
    CNAME = str
    COMMENT = str


def parseMux(fileName: Path) -> list[Mux]:
    parser = Lark(muxGrammar, parser="lalr", transformer=MuxTransformer())

    with open(fileName, "r") as f:
        return parser.parse(f.read())


if __name__ == "__main__":
    with open("/home/kelvin/FABulous_fork/myProject/Tile/PE/PE.list", "r") as f:
        print(parseMux.parse(f.read()))
