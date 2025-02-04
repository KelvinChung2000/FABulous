from copy import deepcopy
from dataclasses import dataclass, field
from typing import Any, Iterable

from FABulous.fabric_definition.Port import Port, TilePort


@dataclass
class MuxPort:
    port: Port | TilePort
    inputs: list[Port | TilePort] = field(default_factory=list)
    isTilePort: bool = False
    isBelPort: bool = False
    isSliced: bool = False
    isBus: bool = False
    bitWidth: int = 1
    sliceRange: tuple[int, int] = (0, 0)

    def __getitem__(self, key: slice | int):
        if isinstance(key, slice):
            if self.isBus:
                raise ValueError("Cannot slice a bus")
            if self.isSliced:
                raise ValueError("Cannot slice a sliced port")
            if key.step is not None:
                raise ValueError("Cannot slice with step")
            if abs(key.start - key.stop) > self.bitWidth:
                raise ValueError("Slice width is greater than bit width")

            selfCopy = deepcopy(self)
            selfCopy.isSliced = True
            selfCopy.sliceRange = (key.start, key.stop)
            return selfCopy
        elif isinstance(key, int):
            if self.isBus:
                raise ValueError("Cannot slice a bus")
            if self.isSliced:
                raise ValueError("Cannot slice a sliced port")
            if key >= self.bitWidth:
                raise ValueError("Index out of range")

            selfCopy = deepcopy(self)
            selfCopy.isSliced = True
            selfCopy.sliceRange = (key, key)
            return selfCopy
        else:
            raise ValueError("Invalid slicing for MuxPort")

    def __setitem__(self, key: slice | int, value: Any):
        self.__add(value)

    def __ifloordiv__(self, other: Any):
        return self.__add(other)

    def __add(self, other: Any):
        if isinstance(other, MuxPort):
            self.inputs.append(other.port)
        elif isinstance(other, list):
            for i in other:
                self.inputs.append(i.port)
        else:
            raise ValueError("Invalid type for MuxPort")
        return self


GenericPort = Port | TilePort


class Mux:
    _name: str
    _inputs: list[GenericPort]
    _output: GenericPort
    _width: int
    _configBit: int = 0

    def __init__(self, name: str, inputs: list[GenericPort], output: GenericPort):
        self._name = name
        self._inputs = inputs
        self._output = output
        self._configBit = 2 ** (len(self.inputs) - 1).bit_length()

        uniqueSet = set()
        for i in inputs:
            uniqueSet.add(i.wireCount)
        uniqueSet.add(output.wireCount)
        if len(uniqueSet) != 1:
            raise ValueError("All inputs and output must have the same width")
        self._width = uniqueSet.pop()

    @property
    def name(self):
        return self._name

    @property
    def inputs(self):
        return tuple(self._inputs)

    @property
    def output(self):
        return self._output

    @property
    def width(self):
        return self._width

    @property
    def configBit(self):
        return self._configBit

    def extendInputs(self, inputs: Iterable[GenericPort]):
        uniqueInputs = set([i for i in self.inputs])

        for i in inputs:
            if i not in uniqueInputs:
                self._inputs.append(i)
                uniqueInputs.add(i)

        self._configBit = 2 ** (len(self.inputs) - 1).bit_length()


@dataclass
class SwitchMatrix:
    muxes: dict[GenericPort, Mux] = field(default_factory=dict)
    _uniqueOutput: set[GenericPort] = field(default_factory=set)
    configBits: int = 0
    # muxTypeDict: dict[int, str] = {
    #     2: "cus_mux21",
    #     4: "cus_mux41_buf",
    #     8: "cus_mux81_buf",
    #     16: "cus_mux161_buf",
    # }

    # def __init__(self, muxList: list[Mux]):
    #     self.muxes = {}
    #     self._uniqueOutput = set()
    #     for mux in muxList:
    #         self.addMux(mux.name, list(mux.inputs), mux.output)

    def addMux(self, mux: Mux):
        if mux.output in self._uniqueOutput:
            self.muxes[mux.output].extendInputs(mux.inputs)
        else:
            self.muxes[mux.output] = mux
            self._uniqueOutput.add(mux.output)

        self.configBits += mux.configBit

    def getOutputs(self) -> list[GenericPort]:
        return [mux.output for mux in self.muxes.values()]

    def getInputs(self) -> list[GenericPort]:
        deduplicatingInput: set[GenericPort] = set()

        resultList: list[GenericPort] = []
        for mux in self.muxes.values():
            for i in mux.inputs:
                if i not in deduplicatingInput:
                    deduplicatingInput.add(i)
                    resultList.append(i)
        return resultList
