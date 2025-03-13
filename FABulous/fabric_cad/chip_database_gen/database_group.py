from dataclasses import field

from FABulous.fabric_cad.bba import BBAWriter
from FABulous.fabric_cad.chip_database_gen.BBAStruct import BBAStruct
from FABulous.fabric_cad.chip_database_gen.define import IdString


class GroupData(BBAStruct):
    index: int
    name: IdString
    group_type: IdString = field(default_factory=IdString)
    group_bels: list[int] = field(default_factory=list)
    group_wires: list[int] = field(default_factory=list)
    group_pips: list[int] = field(default_factory=list)
    group_groups: list[int] = field(default_factory=list)
    extra_data: object = None

    def serialise_lists(self, context: str, bba: BBAWriter):
        bba.label(f"{context}_group_bels")
        for idx in self.group_bels:
            bba.u32(idx)
        bba.label(f"{context}_group_wires")
        for idx in self.group_wires:
            bba.u32(idx)
        bba.label(f"{context}_group_pips")
        for idx in self.group_pips:
            bba.u32(idx)
        bba.label(f"{context}_group_groups")
        for idx in self.group_groups:
            bba.u32(idx)
        # extra data (optional)
        if self.extra_data is not None:
            self.extra_data.serialise_lists(f"{context}_extra_data", bba)
            bba.label(f"{context}_extra_data")
            self.extra_data.serialise(f"{context}_extra_data", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.name.index)
        bba.u32(self.group_type.index)
        bba.slice(f"{context}_group_bels", len(self.group_bels))
        bba.slice(f"{context}_group_wires", len(self.group_wires))
        bba.slice(f"{context}_group_pips", len(self.group_pips))
        bba.slice(f"{context}_group_groups", len(self.group_groups))
        if self.extra_data is not None:
            bba.ref(f"{context}_extra_data")
        else:
            bba.u32(0)
