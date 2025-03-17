from dataclasses import dataclass, field

from FABulous.fabric_cad.bba import BBAWriter
from FABulous.fabric_cad.chip_database.BBAStruct import BBAStruct
from FABulous.fabric_cad.chip_database.define import IdString


@dataclass
class PipData(BBAStruct):
    index: int
    src_wire: int
    dst_wire: int
    pip_type: IdString = field(default_factory=IdString)
    flags: int = 0
    timing_idx: int = -1
    extra_data: object = None

    def __eq__(self, value: object) -> bool:
        if not isinstance(value, PipData):
            return False
        else:
            return (
                self.src_wire == value.src_wire
                and self.dst_wire == value.dst_wire
                and self.pip_type == value.pip_type
            )

    def serialise_lists(self, context: str, bba: BBAWriter):
        # extra data (optional)
        if self.extra_data is not None:
            self.extra_data.serialise_lists(f"{context}_extra_data", bba)
            bba.label(f"{context}_extra_data")
            self.extra_data.serialise(f"{context}_extra_data", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.src_wire)
        bba.u32(self.dst_wire)
        bba.u32(self.pip_type.index)
        bba.u32(self.flags)
        bba.u32(self.timing_idx)
        if self.extra_data is not None:
            bba.ref(f"{context}_extra_data")
        else:
            bba.u32(0)
