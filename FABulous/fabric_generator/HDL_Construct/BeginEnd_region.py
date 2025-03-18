from dataclasses import dataclass

from FABulous.fabric_generator.HDL_Construct.Logic_region import LogicRegion
from FABulous.fabric_generator.HDL_Construct.Region import Region
from FABulous.fabric_generator.define import WriterType


@dataclass
class BeginEndRegion(LogicRegion, Region):
    _container: list[Region]
    _writer: WriterType
    _indent: int

    def __init__(self, container: list[Region], writer: WriterType, indent: int):
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
        return f"begin\n{"\n".join([f"{str(i)}" for i in self.container])}\nend"
