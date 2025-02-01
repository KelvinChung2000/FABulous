from abc import ABC, abstractmethod
from contextlib import contextmanager
from dataclasses import dataclass


class Region(ABC):
    _indentCount: int = 4

    @property
    @abstractmethod
    def container(self) -> list: ...

    @property
    @abstractmethod
    def indent(self) -> int: ...

    @abstractmethod
    def __str__(self) -> str: ...

    @property
    def indentCount(self):
        return self._indentCount

    @indentCount.setter
    def indentCount(self, value):
        self._indentCount = value

    def Comment(self, comment: str):
        _o = self._Comment(comment)
        self.container.append(_o)
        return _o

    @contextmanager
    def IfDef(self, marco: str):
        from FABulous.fabric_generator.HDL_Construct.IfDef_region import IfDefRegion

        r = IfDefRegion(marco, [], self.indent + self.indentCount)
        try:
            yield r
        finally:
            self.container.append(r)

    @dataclass
    class _Comment:
        comment: str

        def __str__(self):
            return f"// {self.comment}"
