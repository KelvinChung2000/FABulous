from contextlib import contextmanager
from dataclasses import dataclass
from pathlib import Path
from typing import TextIO

from FABulous.fabric_generator.HDL_Construct.Module import Module


class CodeGenerator:
    filePath: Path
    indentCount: int
    indent: int = 0
    f: TextIO

    def __init__(self, path: Path | str = Path(), indentCount: int = 4) -> None:
        self.filePath = Path(path)
        self.indentCount = indentCount
        self.f = self.filePath.open("w")

    def __del__(self) -> None:
        self.f.close()

    @contextmanager
    def Module(
        self,
        name: str,
        attributes=None,
    ):
        m = Module(name, [], self.indent, attributes)
        try:
            yield m
        finally:
            self.f.write(str(m))

    def Attribute(self, name: str, value: str | None = None):
        return self._Attribute(name, value)

    def Generate(self):
        return self._Generate(self)

    @dataclass
    class _Attribute:
        name: str
        value: str | None = None

        def __str__(self) -> str:
            if self.value is None:
                return f"{self.name}"
            else:
                return f"{self.name} = {self.value}"

    @dataclass
    class _Generate:
        outer: "CodeGenerator"

        def __enter__(self):
            self.outer.f.write(" " * self.outer.indent + "generate\n")
            self.outer.indent += self.outer.indentCount

        def __exit__(self, exc_type, exc_value, traceback):
            self.outer.indent -= self.outer.indentCount
            self.outer.f.write(" " * self.outer.indent + "endgenerate\n")
