from dataclasses import dataclass, field

from FABulous.fabric_cad.bba import BBAWriter
from FABulous.fabric_cad.chip_database_gen.BBAStruct import BBAStruct
from FABulous.fabric_cad.chip_database_gen.define import IdString, PinType


@dataclass
class BelPin(BBAStruct):
    name: IdString
    wire: int
    dir: PinType

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.name.index)
        bba.u32(self.wire)
        bba.u32(self.dir.value)


@dataclass
class BelExtraData(BBAStruct):
    context: int = 0

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.context)


@dataclass
class BelData(BBAStruct):
    index: int
    name: IdString
    bel_type: IdString
    z: int

    flags: int = 0
    site: int = 0
    checker_idx: int = 0

    pins: list[BelPin] = field(default_factory=list)
    extra_data: BelExtraData | None = None

    def serialise_lists(self, context: str, bba: BBAWriter):
        # sort pins for fast binary search lookups
        self.pins.sort(key=lambda p: p.name.index)
        # write pins array
        bba.label(f"{context}_pins")
        for i, pin in enumerate(self.pins):
            pin.serialise(f"{context}_pin{i}", bba)
        # extra data (optional)
        if self.extra_data is not None:
            self.extra_data.serialise_lists(f"{context}_extra_data", bba)
            bba.label(f"{context}_extra_data")
            self.extra_data.serialise(f"{context}_extra_data", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.name.index)
        bba.u32(self.bel_type.index)
        bba.u16(self.z)
        bba.u16(0)
        bba.u32(self.flags)
        bba.u32(self.site)
        bba.u32(self.checker_idx)
        bba.slice(f"{context}_pins", len(self.pins))
        if self.extra_data is not None:
            bba.ref(f"{context}_extra_data")
        else:
            bba.u32(0)

    def add_extra_data(self, extra_data: BelExtraData):
        self.extra_data = extra_data


@dataclass
class BelPinRef(BBAStruct):
    bel: int
    pin: IdString

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.bel)
        bba.u32(self.pin.index)
