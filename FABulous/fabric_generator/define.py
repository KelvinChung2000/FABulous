from enum import StrEnum


class WriterType(StrEnum):
    """Different writer type for code generation."""

    VERILOG = "verilog"
    VHDL = "vhdl"
