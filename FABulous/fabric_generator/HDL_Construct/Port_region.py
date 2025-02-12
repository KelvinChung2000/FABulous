from dataclasses import dataclass

from FABulous.fabric_definition.define import IO
from FABulous.fabric_generator.HDL_Construct.Region import Region
from FABulous.fabric_generator.HDL_Construct.Value import Value
from FABulous.fabric_generator.define import WriterType


class PortRegion(Region):
    _container: list["_Port"]
    _indent: int
    _writer: WriterType

    def __init__(
        self, container: list["_Port"], writer: WriterType, indent: int
    ) -> None:
        self._container = container
        self._writer = writer
        self._indent = indent

    @property
    def container(self):
        return self._container

    @property
    def indent(self):
        return self._indent

    def __str__(self) -> str:
        if self._writer == WriterType.VERILOG:
            return f"(\n{',\n'.join([f'{" " * self.indent}{str(i)}' for i in self.container])}\n);\n"
        else:
            return f"port(\n{';\n'.join([f'{" " * self.indent}{str(i)}' for i in self.container])}\n);\n"

    @dataclass
    class _Port:
        name: str
        direction: IO
        bits: int | Value
        writer: WriterType

        def __str__(self) -> str:
            if self.writer == WriterType.VERILOG:
                if isinstance(self.bits, int) and self.bits == 1:
                    return f"{self.direction} {self.name}"
                elif isinstance(self.bits, int):
                    return f"{self.direction} [{self.bits - 1}:0] {self.name}"
                else:
                    return f"{self.direction} [{self.bits}:0] {self.name}"
            else:
                io: str
                if self.direction == IO.INPUT:
                    io = "in"
                else:
                    io = "out"

                if isinstance(self.bits, int) and self.bits == 1:
                    return f"{self.name}: {io} std_logic"
                elif isinstance(self.bits, int):
                    return (
                        f"{self.name}: {io} std_logic_vector({self.bits - 1} downto 0)"
                    )
                else:
                    return f"{self.name}: {io} std_logic_vector({self.bits} downto 0)"

    def Port(self, name: str, direction: IO, bits: int | Value = 1):
        _o = self._Port(name, direction, bits, self._writer)
        self.container.append(_o)
        return Value(name, bits, isSignal=True)
