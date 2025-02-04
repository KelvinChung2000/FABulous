from dataclasses import dataclass

from FABulous.fabric_definition.define import IO
from FABulous.fabric_generator.HDL_Construct.Region import Region
from FABulous.fabric_generator.HDL_Construct.Value import Value


class PortRegion(Region):
    _container: list["_Port"]
    _indent: int

    def __init__(self, container: list["_Port"], indent: int) -> None:
        self._container = container
        self._indent = indent

    @property
    def container(self):
        return self._container

    @property
    def indent(self):
        return self._indent

    def __str__(self) -> str:
        return f"(\n{',\n'.join([f'{" " * self.indent}{str(i)}' for i in self.container])}\n);\n"

    @dataclass
    class _Port:
        name: str
        direction: IO
        bits: int | Value

        def __str__(self) -> str:
            if isinstance(self.bits, int) and self.bits == 1:
                return f"{self.direction} {self.name}"
            elif isinstance(self.bits, int):
                return f"{self.direction} [{self.bits - 1}:0] {self.name}"
            else:
                return f"{self.direction} [{self.bits}:0] {self.name}"

    def Port(self, name: str, direction: IO, bits: int | Value = 1):
        _o = self._Port(name, direction, bits)
        self.container.append(_o)
        return Value(name, bits, isSignal=True)
