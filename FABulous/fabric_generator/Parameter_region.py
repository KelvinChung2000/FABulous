from dataclasses import dataclass

from FABulous.fabric_generator.code_generator_2 import CodeGenerator


@dataclass
class _ParameterRegion:
    outer: "CodeGenerator._Module"

    @dataclass
    class _Parameter:
        name: str
        value: str | int

        def __str__(self) -> str:
            return f"parameter {self.name} = {self.value}"

    def Parameter(self, name: str, value: str | int):
        _o = self._Parameter(name, value)
        self.outer.parameters.append(_o)
        return _o
