from typing import Self


class Value:
    _value: str
    _bitWidth: int | Self
    isSignal: bool

    def __init__(self, name: str, bitWidth: int | Self, isSignal: bool = True):
        self._value = name
        self._bitWidth = bitWidth
        self.isSignal = isSignal

    @property
    def value(self):
        return self._value

    @property
    def bitWidth(self):
        return self._bitWidth

    def __bool__(self):
        return True

    def __str__(self):
        return self.value

    def __getitem__(self, key: slice):
        if key.step is not None:
            raise ValueError("Cannot slice with step")
        if self.isSignal:
            return Value(f"{self.value}[{key.start}:{key.stop}]", self.bitWidth)
        else:
            raise ValueError("Cannot only index port and signal type")

    def __add__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} + {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} + {other}", self.bitWidth)

    def __sub__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} - {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} - {other}", self.bitWidth)

    def __mul__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} * {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} * {other}", self.bitWidth)

    def __truediv__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} / {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} / {other}", self.bitWidth)

    def __floordiv__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} // {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} // {other}", self.bitWidth)

    def __mod__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} % {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} % {other}", self.bitWidth)

    def __pow__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} ** {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} ** {other}", self.bitWidth)

    def __lshift__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} << {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} << {other}", self.bitWidth)

    def __rshift__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} >> {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} >> {other}", self.bitWidth)

    def __and__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} & {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} & {other}", self.bitWidth)

    def __xor__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} ^ {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} ^ {other}", self.bitWidth)

    def __or__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} | {other.value}", self.bitWidth)
        else:
            return Value(f"{self.value} | {other}", self.bitWidth)

    def __neg__(self):
        return Value(f"-{self.value}", self.bitWidth)

    def __pos__(self):
        return Value(f"+{self.value}", self.bitWidth)

    def __abs__(self):
        raise NotImplementedError("Absolute value is not supported")

    def __invert__(self):
        return Value(f"~{self.value}", self.bitWidth)

    def __lt__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} < {other.value}", 1)
        else:
            return Value(f"{self.value} < {other}", 1)

    def __le__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} <= {other.value}", 1)
        else:
            return Value(f"{self.value} <= {other}", 1)

    def __eq__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} == {other.value}", 1)
        else:
            return Value(f"{self.value} == {other}", 1)

    def __ne__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} != {other.value}", 1)
        else:
            return Value(f"{self.value} != {other}", 1)

    def __gt__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} > {other.value}", 1)
        else:
            return Value(f"{self.value} > {other}", 1)

    def __ge__(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} >= {other.value}", 1)
        else:
            return Value(f"{self.value} >= {other}", 1)

    def __len__(self):
        return self.bitWidth

    def logical_and(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} && {other.value}", 1)
        else:
            return Value(f"{self.value} && {other}", 1)

    def logical_or(self, other):
        if isinstance(other, Value):
            return Value(f"{self.value} || {other.value}", 1)
        else:
            return Value(f"{self.value} || {other}", 1)

    def logical_not(self):
        return Value(f"!{self.value}", 1)

    def __radd__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} + {self.value}", self.bitWidth)
        else:
            return Value(f"{other} + {self.value}", self.bitWidth)

    def __rsub__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} - {self.value}", self.bitWidth)
        else:
            return Value(f"{other} - {self.value}", self.bitWidth)

    def __rmul__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} * {self.value}", self.bitWidth)
        else:
            return Value(f"{other} * {self.value}", self.bitWidth)

    def __rtruediv__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} / {self.value}", self.bitWidth)
        else:
            return Value(f"{other} / {self.value}", self.bitWidth)

    def __rfloordiv__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} // {self.value}", self.bitWidth)
        else:
            return Value(f"{other} // {self.value}", self.bitWidth)

    def __rmod__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} % {self.value}", self.bitWidth)
        else:
            return Value(f"{other} % {self.value}", self.bitWidth)

    def __rlshift__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} << {self.value}", self.bitWidth)
        else:
            return Value(f"{other} << {self.value}", self.bitWidth)

    def __rrshift__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} >> {self.value}", self.bitWidth)
        else:
            return Value(f"{other} >> {self.value}", self.bitWidth)

    def __rand__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} & {self.value}", self.bitWidth)
        else:
            return Value(f"{other} & {self.value}", self.bitWidth)

    def __rxor__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} ^ {self.value}", self.bitWidth)
        else:
            return Value(f"{other} ^ {self.value}", self.bitWidth)

    def __ror__(self, other):
        if isinstance(other, Value):
            return Value(f"{other.value} | {self.value}", self.bitWidth)
        else:
            return Value(f"{other} | {self.value}", self.bitWidth)
