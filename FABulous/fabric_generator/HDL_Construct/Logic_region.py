from dataclasses import dataclass

from FABulous.fabric_generator.HDL_Construct.Region import Region
from FABulous.fabric_generator.HDL_Construct.Value import Value


class LogicRegion(Region):
    _container: list
    _indent: int

    def __init__(self, container: list, indent: int):
        self._container = container
        self._indent = indent

    def __str__(self) -> str:
        return f"\n{'\n'.join([str(i) for i in self.container])}"

    @property
    def container(self):
        return self._container

    @property
    def indent(self):
        return self._indent

    def ConnectPair(self, dst: str, src: Value | int):
        return self._ConnectPair(dst, src)

    def Signal(self, name: str, bits: int | Value = 1):
        _o = self._signal(name, bits)
        self.container.append(_o)
        return Value(name, bits)

    def Assign(self, dst: Value, src: Value):
        _o = self._Assign(dst, src)
        self.container.append(_o)
        return _o

    def Constant(self, name: str, value: int):
        _o = self._Constant(name, value)
        self.container.append(_o)
        return Value(name, value)

    def Concat(self, *args):
        return self._Concat(*args)

    def InitModule(
        self,
        module: str,
        initName: str,
        ports: list["LogicRegion._ConnectPair"],
        parameters: list["LogicRegion._ConnectPair"] = [],
    ):
        _o = self._InitModule(module, initName, parameters, ports, self.indent, self.indentCount)
        self.container.append(_o)
        return _o

    @dataclass
    class _ConnectPair:
        dst: str
        src: Value | int

        def __str__(self) -> str:
            if self.src:
                return f".{self.dst}({self.src})"
            else:
                return f".{self.dst}()"

    @dataclass
    class _InitModule:
        module: str
        initName: str
        parameter: list["LogicRegion._ConnectPair"]
        ports: list["LogicRegion._ConnectPair"]
        indent: int
        indentCount: int

        def __str__(self) -> str:
            if self.parameter:
                r = (
                    f"{' ' * self.indent}{self.module} #(\n"
                    f"{',\n'.join([f'{" " * (self.indent + self.indentCount)}{i}' for i in self.parameter])}\n"
                    f"{' ' * self.indent}) {self.initName} (\n"
                    f"{',\n'.join([f'{" " * (self.indent + self.indentCount)}{i}' for i in self.ports])}\n"
                    f"{' ' * self.indent});\n"
                )
            else:
                r = (
                    f"{' ' * self.indent}{self.module} #() {self.initName} (\n"
                    f"{',\n'.join([f'{" " * (self.indent + self.indentCount)}{i}' for i in self.ports])}\n"
                    f"{' ' * self.indent});\n"
                )

            return r

    @dataclass
    class _Assign:
        dst: Value
        src: Value

        def __str__(self) -> str:
            return f"assign {self.dst} = {self.src};"

    @dataclass
    class _signal:
        name: str
        bits: Value | int = 1

        def __str__(self) -> str:
            if self.bits == 1:
                return f"wire {self.name};"
            elif isinstance(self.bits, int):
                return f"wire [{self.bits - 1}:0] {self.name};"
            else:
                return f"wire [{self.bits}:0] {self.name};"

    @dataclass
    class _Constant:
        name: str
        value: int

        def __str__(self) -> str:
            return f"localparam reg {self.name} = {self.value};"

    @dataclass
    class _Concat(Value):
        item: list[str]

        def __init__(self, *args):
            if len(args) == 1:
                self.item = args[0]
            else:
                self.item = list(args)

        def __str__(self) -> str:
            return f"{{{', '.join(self.item)}}}"

        @property
        def value(self) -> str:
            return self.__str__()
