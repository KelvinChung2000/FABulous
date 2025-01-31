from dataclasses import dataclass
from pathlib import Path
from typing import Any, TextIO

from FABulous.fabric_definition.define import IO


class CodeGenerator:
    filePath: Path
    indentCount: int
    indent: int = 0
    f: TextIO

    def __init__(self, path: Path | str, indentCount: int = 4) -> None:
        self.filePath = Path(path)
        self.indentCount = indentCount
        self.f = self.filePath.open("w")

    def __del__(self) -> None:
        self.f.close()

    def Module(
        self,
        name: str,
        parameters: list["_Parameter | None"],
        ports: list["_Port"],
        attributes=None,
    ):
        return self._Module(self, name, parameters, ports, attributes)

    def Parameter(self, name: str, value: str | int):
        return self._Parameter(name, value)

    def Port(self, name: str, direction: IO, bits: int | str):
        return self._Port(name, direction, bits)

    def Attribute(self, name: str, value: str | None = None):
        return self._Attribute(name, value)

    def Generate(self):
        return self._Generate(self)

    def ConnectPair(self, dst: str, src: Any | None = None):
        return self._ConnectPair(dst, src)

    def IfDef(self, macro: str):
        return self._IfDef(self, macro)

    def Comment(self, comment: str):
        return self._Comment(self, comment)

    def Assign(self, dst: str, src: "str | _Concat"):
        return self._Assign(self, dst, src)

    def Constant(self, name: str, value: int):
        return self._Constant(self, name, value)

    def Signal(self, name: str, bits: int):
        return self._signal(self, name, bits)

    def Concat(self, *items):
        return self._Concat(items)

    def InitModule(
        self,
        module: str,
        initName: str,
        parameters: list["_ConnectPair"],
        ports: list["_ConnectPair"],
        attributes: list["_Attribute"] | None = None,
    ):
        return self._InitModule(self, module, initName, parameters, ports, attributes)

    @dataclass
    class _Parameter:
        name: str
        value: str | int

        def __str__(self) -> str:
            return f"parameter {self.name} = {self.value}"

    @dataclass
    class _Port:
        name: str
        direction: IO
        bits: int | str

        def __str__(self) -> str:
            if isinstance(self.bits, int):
                return f"{self.direction} [{self.bits - 1}:0] {self.name}"
            else:
                return f"{self.direction} [{self.bits}:0] {self.name}"

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

    @dataclass
    class _ConnectPair:
        dst: str
        src: str | None = None

        def __str__(self) -> str:
            if self.src:
                return f".{self.dst}({self.src})"
            else:
                return f".{self.dst}()"

    @dataclass
    class _IfDef:
        outer: "CodeGenerator"
        macro: str

        def __enter__(self):
            self.outer.f.write(f" `ifdef {self.macro}\n")
            self.outer.indent += self.outer.indentCount

        def __exit__(self, exc_type, exc_value, traceback):
            self.outer.indent -= self.outer.indentCount
            self.outer.f.write(" `endif\n")

    @dataclass
    class _Comment:
        outer: "CodeGenerator"
        comment: str

        def __init__(self, outer: "CodeGenerator", comment: str):
            self.outer.f.write(f"// {self.comment}\n")

    @dataclass
    class _Assign:
        outer: "CodeGenerator"
        dst: str
        src: "str | CodeGenerator._Concat"

        def __init__(
            self, outer: "CodeGenerator", dst: str, src: "str | CodeGenerator._Concat"
        ):
            self.outer.f.write(f"assign {dst} = {src};\n")

    @dataclass
    class _Constant:
        outer: "CodeGenerator"
        value: int

        def __init__(self, outer: "CodeGenerator", name: str, value: int):
            self.outer.f.write(f"localparam {name} = {value};\n")

    @dataclass
    class _signal:
        outer: "CodeGenerator"
        name: str
        bits: int

        def __init__(self, outer: "CodeGenerator", name: str, bits: int):
            self.outer.f.write(f"wire [{bits - 1}:0] {name};\n")

    @dataclass
    class _Concat:
        item: list[str]

        def __init__(self, *args):
            if len(args) == 1:
                self.item = args[0]
            else:
                self.item = list(args)

        def __str__(self) -> str:
            return f"{{{', '.join(self.item)}}}"

    class _InitModule:
        def __init__(
            self,
            outer,
            module: str,
            initName: str,
            parameters: list["CodeGenerator._ConnectPair"],
            ports: list["CodeGenerator._ConnectPair"],
            attributes: list["CodeGenerator._Attribute"] | None = None,
        ):
            self.outer = outer
            if attributes:
                self.outer.f.write(f"(* {', '.join([str(i) for i in attributes])} *)\n")
            self.outer.f.write(" " * self.outer.indent + f"{module} #(\n")
            self.outer.indent += self.outer.indentCount
            self.outer.f.write(
                ",\n".join([f"{' '* self.outer.indent}{i}" for i in parameters])
            )
            self.outer.indent -= self.outer.indentCount
            self.outer.f.write(f"\n{' '* self.outer.indent}) {initName} (\n")
            self.outer.indent += self.outer.indentCount
            self.outer.f.write(
                ",\n".join([f"{' '* self.outer.indent}{i}" for i in ports])
            )
            self.outer.indent -= self.outer.indentCount
            self.outer.f.write(f"\n{' '* self.outer.indent});\n")

    @dataclass
    class _Module:
        outer: "CodeGenerator"
        name: str
        parameters: list["CodeGenerator._Parameter | None"]
        ports: list["CodeGenerator._Port"]
        attributes: list["CodeGenerator._Attribute"] | None = None

        def __enter__(self):
            if self.attributes:
                self.outer.f.write(
                    f"(* {', '.join([str(i) for i in self.attributes])} *)\nmodule "
                    + self.name
                    + " #(\n"
                )
            else:
                self.outer.f.write("module " + self.name + " #(\n")

            self.outer.indent += self.outer.indentCount
            self.outer.f.write(
                ",\n".join(
                    [
                        f"{' '* self.outer.indent}{i}"
                        for i in self.parameters
                        if i is not None
                    ]
                )
            )
            self.outer.indent -= self.outer.indentCount
            self.outer.f.write("\n) (\n")
            self.outer.indent += self.outer.indentCount
            self.outer.f.write(
                ",\n".join([f"{' '* self.outer.indent}{i}" for i in self.ports])
            )
            self.outer.f.write("\n);\n")

        def __exit__(self, exc_type, exc_value, traceback):
            self.outer.f.write("endmodule\n")
            self.outer.indent -= self.outer.indentCount
