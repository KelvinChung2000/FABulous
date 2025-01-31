from dataclasses import dataclass


@dataclass
class Mux:
    name: str
    inputs: list[str]
    output: str
    width: int
    configBit: int = 0

    def __post_init__(self):
        self.configBit = 2 ** (len(self.inputs) - 1).bit_length()

