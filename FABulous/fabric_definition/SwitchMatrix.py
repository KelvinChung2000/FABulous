import threading
from collections import namedtuple
from dataclasses import dataclass, field
from itertools import zip_longest
from typing import Any, Iterable

from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Port import GenericPort, SlicedPort, TilePort

SliceRange = namedtuple("SliceRange", ["start", "end"])

# Track completed in-place operations to avoid double-processing
_COMPLETED_INPLACE_OPS = threading.local()
_COMPLETED_INPLACE_OPS.items = set()


@dataclass
class SlicedSignal:
    port: GenericPort
    sliceRange: SliceRange


class Mux:
    _output: GenericPort
    _inputs: list[GenericPort]
    _width: int

    def __init__(
        self, output: GenericPort, inputs: list[GenericPort], prefix: str = ""
    ):
        for p in inputs:
            if p.width != output.width:
                raise ValueError(
                    f"All inputs {inputs} and output {output} must have the same width"
                )

        self._name = f"{prefix}{output.name}"
        self._inputs = inputs
        self._output = output
        self._width = output.width

    def __repr__(self) -> str:
        if len(self.inputs) == 0:
            return f"Mux({self.output.name} <- [no inputs] (cfg: -))"
        else:
            input_names = [f"{i.name}" for i in self.inputs]
            return f"Mux({self.output.name} <- [{', '.join(input_names)}] (cfg: {self.configBits} bits))"

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
        if len(self.inputs) == 0:
            raise ValueError("Invalid Mux, no inputs")
        return (len(self.inputs) - 1).bit_length()

    def extendInputs(self, inputs: Iterable[GenericPort]):
        for i in inputs:
            if not isinstance(i, GenericPort):
                raise TypeError("Input must be a Port")

            if i.width != self.output.width:
                raise ValueError(
                    f"All inputs and output must have the same width input port {i} != output port {self.output}"
                )
            self._inputs.append(i)

    def getFlattenMux(self) -> list[tuple[str, tuple[str, ...]]]:
        """Get the flattened mux inputs and output.

        Returns
        -------
        tuple[str, list[str]]
            The first element is the output name, and the second element is a list of input names.
        """
        expandedInputLists = [inputPort.expand() for inputPort in self.inputs]

        # Group items by position using zip_longest
        groupedInputs: list[tuple[str, ...]] = []
        for group in zip_longest(*expandedInputLists):
            # Filter out None values that zip_longest adds for shorter lists
            groupedInputs.append(tuple([item for item in group if item is not None]))
        return list(zip(self.output.expand(), groupedInputs))


class MuxPack:
    port: list[Mux]
    ogPort: GenericPort
    _lastGet: "MuxPack"

    def __init__(self, port: GenericPort):
        self.port = []
        self.ogPort = port
        for i in range(port.width):
            self.port.append(Mux(SlicedPort(self.ogPort, (i, i)), []))

    def __getitem__(self, key: slice | int):
        if isinstance(key, slice):
            if key.step is not None:
                raise ValueError("Cannot slice with step")
            if key.start is None:
                raise ValueError(
                    "You must specify a start index. If you are trying to do sig[0:4] you should write sig[4:0]"
                )
            if key.start < key.stop:
                raise ValueError(
                    "Start index must be less than stop index, the slicing is following the Verilog convention"
                )
            if abs(key.start - key.stop) > self.ogPort.width:
                raise ValueError("Slice width is greater than bit width")
            self._lastGet = MuxPack(self.ogPort)
            self._lastGet.port = self.port[key.stop : key.start : -1]
            return self._lastGet
        elif isinstance(key, int):
            if key > self.ogPort.width:
                raise ValueError("Index out of range")
            self._lastGet = MuxPack(self.ogPort)
            self._lastGet.port = [self.port[key]]
            return self._lastGet
        else:
            raise ValueError("Invalid slicing for MuxPack")

    def __setitem__(self, key, value):
        if self._lastGet is value:
            return
        raise TypeError(
            "Cannot perform direct assignment on MuxPort. Use the //= operator for connecting ports"
        )

    def __ifloordiv__(self, other: Any):
        if isinstance(other, (list, tuple)):
            try:
                r = list(
                    zip(*[i.port for i in other if isinstance(i, MuxPack)], strict=True)
                )
            except ValueError:
                raise ValueError(
                    f"not all the object in the list have the same width {other}"
                )
            for o, i in zip(self.port, r):
                o.extendInputs([j.output for j in i])
        elif isinstance(other, MuxPack):
            for k, o in enumerate(self.port):
                o.extendInputs([other.port[k].output])
        else:
            raise ValueError("Invalid type for Mux construction")

        return self


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

    def __str__(self) -> str:
        """Return a formatted string representation of the switch matrix.

        Returns:
            str: A formatted string showing the switch matrix's multiplexers and their connections.
        """
        return self.__repr__()
