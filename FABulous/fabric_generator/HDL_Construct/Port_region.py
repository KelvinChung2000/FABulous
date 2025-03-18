from dataclasses import dataclass

from FABulous.fabric_definition.define import IO
from FABulous.fabric_generator.HDL_Construct.Region import Region
from FABulous.fabric_generator.HDL_Construct.Value import Value
from FABulous.fabric_generator.HDL_Construct._Comment import _Comment
from FABulous.fabric_generator.define import WriterType


class PortRegion(Region):
    _container: list["_Port | _Comment"]
    _indent: int
    _writer: WriterType

    def __init__(
        self, container: list["_Port | _Comment"], writer: WriterType, indent: int
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
            lines = []

            for idx, item in enumerate(self.container):
                if isinstance(item, _Comment):
                    lines.append(f"{' ' * self.indent}{str(item)}")
                else:
                    if idx == len(self.container) - 1:
                        lines.append(f"{' ' * self.indent}{str(item)}")
                    else:
                        lines.append(f"{' ' * self.indent}{str(item)},")

            return f"(\n{''.join([f'{line}\n' for line in lines])});\n"
        else:
            return f"port(\n{';\n'.join([f'{" " * self.indent}{str(i)}' for i in self.container])}\n);\n"

    @dataclass
    class _Port:
        name: str
        direction: IO
        width: int | Value
        writer: WriterType

        def __str__(self) -> str:
            if self.writer == WriterType.VERILOG:
                if isinstance(self.width, int) and self.width == 1:
                    return f"{self.direction} {self.name}"
                elif isinstance(self.width, int):
                    return f"{self.direction} [{self.width - 1}:0] {self.name}"
                else:
                    return f"{self.direction} [{self.width}:0] {self.name}"
            else:
                io: str
                if self.direction == IO.INPUT:
                    io = "in"
                else:
                    io = "out"

                if isinstance(self.width, int) and self.width == 1:
                    return f"{self.name}: {io} std_logic"
                elif isinstance(self.width, int):
                    return (
                        f"{self.name}: {io} std_logic_vector({self.width - 1} downto 0)"
                    )
                else:
                    return f"{self.name}: {io} std_logic_vector({self.width} downto 0)"

    def Port(self, name: str, direction: IO, width: int | Value = 1):
        _o = self._Port(name, direction, width, self._writer)
        self.container.append(_o)
        return Value(name, width, isSignal=True)
