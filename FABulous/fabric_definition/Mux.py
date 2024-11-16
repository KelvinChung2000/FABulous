from dataclasses import dataclass


@dataclass
class Mux:
    name: str
    inputs: list[str]
    output: str
    width: int
