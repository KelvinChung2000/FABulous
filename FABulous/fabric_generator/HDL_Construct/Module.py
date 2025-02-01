from contextlib import contextmanager

from FABulous.fabric_generator.HDL_Construct.Logic_region import LogicRegion
from FABulous.fabric_generator.HDL_Construct.Parameter_region import ParameterRegion
from FABulous.fabric_generator.HDL_Construct.Port_region import PortRegion
from FABulous.fabric_generator.HDL_Construct.Region import Region


class Module(Region):
    _container: list[Region]
    _indent: int
    name: str
    attributes: list | None = None

    def __init__(
        self,
        name: str,
        container: list[Region],
        indent: int,
        attributes=None,
    ):
        self.name = name
        self.attributes = attributes
        self._container = container
        self._indent = indent
        # self._parameters = ParameterRegion([], self.indent)
        # self._ports = PortRegion([], self.indent)
        # self._logics = LogicRegion([], self.indent)

    @property
    def container(self):
        return self._container

    @property
    def indent(self):
        return self._indent

    def __str__(self) -> str:
        # self.container.append(self._parameters)
        # self.container.append(self._ports)
        # self.container.append(self._logics)
        return f"module {self.name} {''.join([str(i) for i in self.container])}\nendmodule\n"

    @contextmanager
    def ParameterRegion(self):
        pr = ParameterRegion([], self.indent + self.indentCount)
        try:
            yield pr
        finally:
            self.container.append(pr)

    @contextmanager
    def PortRegion(self):
        pr = PortRegion([], self.indent + self.indentCount)
        try:
            yield pr
        finally:
            self.container.append(pr)

    @contextmanager
    def LogicRegion(self):
        lr = LogicRegion([], self.indent)
        try:
            yield lr
        finally:
            self.container.append(lr)
