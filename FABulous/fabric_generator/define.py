from enum import StrEnum
from pickle import REDUCE


class WriterType(StrEnum):
    VERILOG = "verilog"
    SYSTEM_VERILOG = "sv"
    VHDL = "vhdl"


class PossibleUnaryType(StrEnum):
    NOT = "$not"
    POS = "$pos"
    NEG = "$neg"
    REDUCE_AND = "$reduce_and"
    REDUCE_OR = "$reduce_or"
    REDUCE_XOR = "$reduce_xor"
    REDUCE_XNOR = "$reduce_xnor"
    REDUCE_bool = "$reduce_bool"
    LOGIC_NOT = "$logic_not"


class PossibleBinaryType(StrEnum):
    AND = "$and"
    OR = "$or"
    XOR = "$xor"
    XNOR = "$xnor"
    SHL = "$shl"
    SHR = "$shr"
    SSHL = "$sshl"
    SSHR = "$sshr"
    LOGIC_AND = "$logic_and"
    LOGIC_OR = "$logic_or"
    EQX = "$eqx"
    NEX = "$nex"
    POW = "$pow"
    ADD = "$add"
    SUB = "$sub"
    MUL = "$mul"
    DIV = "$div"
    MOD = "$mod"
    SHIFT = "$shift"
    SHIFTX = "$shiftx"
    DIVFLOOR = "$divfloor"
    MODFLOOR = "$modfloor"
