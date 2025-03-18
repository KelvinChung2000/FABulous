from collections import defaultdict, namedtuple
from dataclasses import dataclass, field
from pprint import pprint
from typing import Any, Iterable, Self

from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Port import GenericPort, TilePort

SliceRange = namedtuple("SliceRange", ["start", "end"])


@dataclass
class SlicedSignal:
    port: GenericPort
    sliceRange: SliceRange


@dataclass
class MuxPort:
    port: GenericPort
    inputs: list["MuxPort"] = field(default_factory=list)
    isTilePort: bool = False
    isBelPort: bool = False
    isSliced: bool = False
    isBus: bool = False
    isCreated: bool = False
    width: int = 1
    sliceRange: SliceRange = SliceRange(-1, -1)
    slicingAssignDict: dict[SliceRange, list[SlicedSignal]] = field(
        default_factory=lambda: defaultdict(list)
    )

    def __getitem__(self, key: slice | int):
        if isinstance(key, slice):
            if self.isBus:
                raise ValueError("Cannot slice a bus")
            if key.step is not None:
                raise ValueError("Cannot slice with step")
            if abs(key.start - key.stop) > self.width:
                raise ValueError("Slice width is greater than bit width")
            self.isSliced = True
            self.sliceRange = SliceRange(key.start, key.stop)
            return self
        elif isinstance(key, int):
            if self.isBus:
                raise ValueError("Cannot slice a bus")
            if key >= self.width:
                raise ValueError("Index out of range")
            self.isSliced = True
            self.sliceRange = SliceRange(key, key)
            return self
        else:
            raise ValueError("Invalid slicing for MuxPort")

    def __setitem__(self, key: slice | int, value: Self):
        pass
        # raise ValueError("Cannot perform set item, use the //= operator")

    def __ifloordiv__(self, other: Any):
        if self.isSliced:
            if isinstance(other, list):
                for i in other:
                    self.slicingAssignDict[self.sliceRange].append(
                        SlicedSignal(port=i.port, sliceRange=i.sliceRange)
                    )
            else:
                self.slicingAssignDict[self.sliceRange].append(
                    SlicedSignal(port=other.port, sliceRange=other.sliceRange)
                )
            return self
        else:
            if isinstance(other, MuxPort):
                self.inputs.append(other)
            elif isinstance(other, list):
                for i in other:
                    self.inputs.append(i)
            else:
                raise ValueError("Invalid type for MuxPort")

            return self

    # def __repr__(self) -> str:
    #     if self.isSliced:
    #         return f"MuxPort(port={self.port}, sliceDict={self.slicingAssignDict})"
    #     else:
    #         return f"MuxPort(port={self.port})"


class Mux:
    _name: str
    _inputs: list[GenericPort]
    _output: GenericPort
    _width: int

    def __init__(self, name: str, inputs: list[GenericPort], output: GenericPort):
        for p in inputs:
            if p.width != output.width:
                raise ValueError("All inputs and output must have the same width")

        self._name = name
        self._inputs = inputs
        self._output = output
        self._width = output.width

    def __repr__(self) -> str:
        return f"{self.output}<({self.name}({self.configBits}))-{list(self.inputs)}"

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
    def configBits(self):
        return (len(self.inputs) - 1).bit_length()

    def extendInputs(self, inputs: Iterable[GenericPort]):
        for i in inputs:
            if i.width != self.output.width:
                raise ValueError("All inputs and output must have the same width")
            self._inputs.append(i)


@dataclass
class SwitchMatrix:
    muxesDict: dict[GenericPort, Mux] = field(default_factory=dict)
    _uniqueOutput: set[GenericPort] = field(default_factory=set)
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

    def __repr__(self) -> str:
        return f"SwitchMatrix({list(self.muxesDict.values())}, configBits={self.configBits})"

    @property
    def muxes(self) -> list[Mux]:
        return list(self.muxesDict.values())

    @property
    def configBits(self) -> int:
        return sum(mux.configBits for mux in self.muxesDict.values())

    def __getitem__(self, key: GenericPort):
        if key in self.muxesDict:
            return self.muxesDict[key]
        else:
            raise KeyError(f"Output port {key} does not exist in the switch matrix")

    def addMux(self, mux: Mux):
        if len(mux.inputs) == 0:
            if isinstance(mux.output, TilePort) and mux.output.ioDirection == IO.OUTPUT:
                raise ValueError(f"A tile output port {mux.output} has no inputs")

        if mux.output in self._uniqueOutput:
            self.muxesDict[mux.output].extendInputs(mux.inputs)
        else:
            self.muxesDict[mux.output] = mux
            self._uniqueOutput.add(mux.output)

    def getOutputs(self) -> list[GenericPort]:
        return [mux.output for mux in self.muxesDict.values()]

    def getInputs(self) -> list[GenericPort]:
        deduplicatingInput: set[GenericPort] = set()

        resultList: list[GenericPort] = []
        for mux in self.muxesDict.values():
            for i in mux.inputs:
                if i not in deduplicatingInput:
                    deduplicatingInput.add(i)
                    resultList.append(i)
        return resultList

    def getPortUsers(self, port: GenericPort) -> list[GenericPort]:
        sinkList: set[GenericPort] = set()
        for mux in self.muxesDict.values():
            for i in mux.inputs:
                if i == port:
                    sinkList.add(mux.output)
        return list(sinkList)

    def getPortDrivers(self, port: GenericPort) -> list[GenericPort]:
        sourceList: set[GenericPort] = set()
        for mux in self.muxesDict.values():
            if mux.output == port:
                for i in mux.inputs:
                    sourceList.add(i)
        return list(sourceList)
