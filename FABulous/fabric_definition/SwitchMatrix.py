from dataclasses import dataclass, field
from FABulous.fabric_definition.Mux import Mux

@dataclass
class SwitchMatrix:
    muxes: list[Mux] = field(default_factory=list)
    wires: list[str] = field(default_factory=list)



