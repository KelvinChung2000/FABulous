from dataclasses import dataclass

from FABulous.fabric_generator.HDL_Construct.Value import Value


class Mux:
    _name: str
    _inputs: list[Value]
    _output: Value
    _width: int
    _configBit: int = 0

    def __init__(self, name: str, inputs: list[Value], output: Value):
        self._name = name
        self._inputs = inputs
        self._output = output
        self._configBit = 2 ** (len(self.inputs) - 1).bit_length()

        uniqueSet = set()
        for i in inputs:
            uniqueSet.add(i.bitWidth)
        uniqueSet.add(output.bitWidth)
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

    def extendInputs(self, inputs: list[Value]):
        self._inputs.extend(inputs)
        self._configBit = 2 ** (len(self.inputs) - 1).bit_length()


@dataclass
class SwitchMatrix:
    muxes: dict[str, Mux]
    _uniqueOutput: set[str]
    muxTypeDict: dict[int, str] = {
        2: "cus_mux21",
        4: "cus_mux41_buf",
        8: "cus_mux81_buf",
        16: "cus_mux161_buf",
    }

    def __init__(self, muxList: list[Mux]):
        self.muxes = {}
        self._uniqueOutput = set()
        for mux in muxList:
            self.addMux(mux.name, list(mux.inputs), mux.output)

    def addMux(self, name: str, inputs: list[Value], output: Value) -> Mux:
        if output in self._uniqueOutput:
            self.muxes[output].extendInputs(inputs)
        else:
            self.muxes[output.value] = Mux(name, inputs, output)
            self._uniqueOutput.add(output.value)

        return self.muxes[output.value]

    def getOutputs(self) -> list[Value]:
        return [mux.output for mux in self.muxes.values()]

    def getInputs(self) -> list[Value]:
        deduplicatingInput: set[str] = set()

        resultList: list[Value] = []
        for mux in self.muxes.values():
            for i in mux.inputs:
                if i not in deduplicatingInput:
                    deduplicatingInput.add(i.value)
                    resultList.append(i)
        return resultList
