from dataclasses import dataclass

from FABulous.fabric_generator.HDL_Construct.Region import Region


@dataclass
class ParameterRegion(Region):
    _container: list["_Parameter"]
    _indent: int

    def __init__(self, parameters: list["_Parameter"], indent: int):
        self._container = parameters
        self._indent = indent

    @property
    def container(self):
        return self._container

    @property
    def indent(self):
        return self._indent

    def __str__(self) -> str:
        return f"#(\n{",\n".join([f"{' '*self.indent}{str(i)}" for i in self.container])}\n)"

    @dataclass
    class _Parameter:
        name: str
        value: str | int

        def __str__(self) -> str:
            return f"parameter {self.name} = {self.value}"

    def Parameter(self, name: str, value: str | int):
        _o = self._Parameter(name, value)
        self.container.append(_o)
        return _o
