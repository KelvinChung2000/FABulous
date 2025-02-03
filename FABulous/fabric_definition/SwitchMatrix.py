from dataclasses import dataclass


class Mux:
    _name: str
    _inputs: list[str]
    _output: str
    _width: int
    _configBit: int = 0

    def __init__(self, name: str, inputs: list[str], output: str, width: int):
        self._name = name
        self._inputs = inputs
        self._output = output
        self._width = width
        self._configBit = 2 ** (len(self.inputs) - 1).bit_length()

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

    def extendInputs(self, inputs: list[str]):
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
            self.addMux(mux.name, list(mux.inputs), mux.output, mux.width)

    def addMux(self, name: str, inputs: list[str], output: str, width: int) -> Mux:
        if output in self._uniqueOutput:
            self.muxes[output].extendInputs(inputs)
        else:
            self.muxes[output] = Mux(name, inputs, output, width)
            self._uniqueOutput.add(output)

        return self.muxes[output]

    def getOutputs(self) -> list[(str, int)]:
        return list(self.muxes.keys())

    def getInputs(self) -> list[str]:
        deduplicatingInput: set[str] = set()

        resultList: list[str] = []
        for mux in self.muxes.values():
            for i in mux.inputs:
                if i not in deduplicatingInput:
                    deduplicatingInput.add(i)
                    resultList.append(i)
        return resultList
