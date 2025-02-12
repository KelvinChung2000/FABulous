from functools import partial
from pathlib import Path
from typing import cast

from lark import Lark, Transformer, v_args

from FABulous.fabric_cad.define import FASMFeature

FASMGrammar = r"""
    start: fasm_line*

    fasm_line: [set_fasm_feature] [annotations] _NEW_LINE

    ?set_fasm_feature: feature [feature_address] ["=" verilog_value]

    feature: IDENTIFIER ("." IDENTIFIER)*
    IDENTIFIER: /[a-zA-Z][0-9a-zA-Z_]*/

    ?feature_address: "[" DEC [":" DEC] "]"

    verilog_value: (DEC? "'" ("h" HEX | "b" BINARY | "d" DEC | "o" OCTAL)) | DEC

    DEC: /[0-9_]+/
    HEX: /[0-9a-fA-F_]+/
    OCTAL: /[0-7_]+/
    BINARY: /[01_]+/

    annotations: "{" annotation ("," annotation)* "}"
    annotation: ANNOTATION_NAME "=" ESCAPED_STRING
    ANNOTATION_NAME: /[.a-zA-Z][_0-9a-zA-Z]*/

    SH_COMMENT: /#.*/
    _NEW_LINE: "\n"

    %import common.WS_INLINE
    %import common.ESCAPED_STRING
    %ignore WS_INLINE
    %ignore SH_COMMENT
"""


class FASMTransformer(Transformer):
    def start(self, items):
        return [i for i in items if i is not None]

    @v_args(inline=True)
    def fasm_line(self, set_feature, annotations):
        if set_feature is None and annotations is None:
            return None

        if set_feature is None:
            return FASMFeature(None, None, None, annotations)

        return FASMFeature(
            set_feature["feature"],
            set_feature["address"],
            set_feature["value"],
            annotations,
        )

    def feature(self, items):
        return ".".join(items)

    @v_args(inline=True)
    def set_fasm_feature(self, feature, address=None, value=None):
        if feature is not None and value is None:
            return {"feature": feature, "address": address, "value": 1}
        return {"feature": feature, "address": address, "value": value}

    def annotations(self, items):
        return {u: v for (u, v) in items}

    def feature_address(self, items):
        if items[1] is None:
            return (items[0], items[0])
        return tuple(items)

    @v_args(inline=True)
    def verilog_value(self, *items):
        return items[-1]

    DEC = int
    HEX = partial(int, base=16)
    BINARY = partial(int, base=2)
    OCTAL = partial(int, base=8)
    annotation = tuple
    ANNOTATION_NAME = str
    IDENTIFIER = str
    SH_COMMENT = None

    def ESCAPED_STRING(self, items):
        return items[1:-1]


FASMParser = Lark(
    FASMGrammar,
    parser="lalr",
    transformer=FASMTransformer(),
    maybe_placeholders=True,
)


def parseFASM(fasmFile: Path) -> list[FASMFeature]:
    with open(fasmFile, "r") as f:
        result = FASMParser.parse(f.read())
    return cast(list[FASMFeature], result)
