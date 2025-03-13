from dataclasses import dataclass, field

from loguru import logger

from FABulous.fabric_cad.bba import BBAWriter
from FABulous.fabric_cad.chip_database_gen.BBAStruct import BBAStruct
from FABulous.fabric_cad.chip_database_gen.database_bel import (
    BelData,
    BelPin,
    BelPinRef,
    TileExtraData,
)
from FABulous.fabric_cad.chip_database_gen.database_group import GroupData
from FABulous.fabric_cad.chip_database_gen.database_pip import PipData
from FABulous.fabric_cad.chip_database_gen.define import IdString, PinType
from FABulous.fabric_cad.chip_database_gen.StringPool import StringPool
from FABulous.fabric_cad.chip_database_gen.database_timing import TimingPool


@dataclass
class TileWireData:
    index: int
    name: IdString
    wire_type: IdString
    gfx_wire_id: int
    const_value: IdString = field(default_factory=IdString)
    flags: int = 0
    timing_idx: int = -1

    # these crossreferences will be updated by finalise(), no need to manually update
    pips_uphill: list[int] = field(default_factory=list)
    pips_downhill: list[int] = field(default_factory=list)
    bel_pins: list[BelPinRef] = field(default_factory=list)

    def serialise_lists(self, context: str, bba: BBAWriter):
        bba.label(f"{context}_pips_uh")
        for pip_idx in self.pips_uphill:
            bba.u32(pip_idx)
        bba.label(f"{context}_pips_dh")
        for pip_idx in self.pips_downhill:
            bba.u32(pip_idx)
        bba.label(f"{context}_bel_pins")
        for i, bel_pin in enumerate(self.bel_pins):
            bel_pin.serialise(f"{context}_bp{i}", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.name.index)
        bba.u32(self.wire_type.index)
        bba.u32(self.gfx_wire_id)
        bba.u32(self.const_value.index)
        bba.u32(self.flags)
        bba.u32(self.timing_idx)
        bba.slice(f"{context}_pips_uh", len(self.pips_uphill))
        bba.slice(f"{context}_pips_dh", len(self.pips_downhill))
        bba.slice(f"{context}_bel_pins", len(self.bel_pins))


@dataclass
class TileType(BBAStruct):
    strs: StringPool
    gfx_wire_ids: dict
    tmg: "TimingPool"
    type_name: IdString
    bels: list[BelData] = field(default_factory=list)
    pips: list[PipData] = field(default_factory=list)
    wires: list[TileWireData] = field(default_factory=list)
    groups: list[GroupData] = field(default_factory=list)

    _wire2idx: dict[IdString, int] = field(default_factory=dict)
    _group2idx: dict[IdString, int] = field(default_factory=dict)

    extra_data: object = None

    def create_bel(self, name: str, type: str, z: int):
        # Create a new bel of a given name, type and z (index within the tile) in the tile type
        bel = BelData(
            index=len(self.bels),
            name=self.strs.id(name),
            bel_type=self.strs.id(type),
            z=z,
        )
        self.bels.append(bel)
        return bel

    def add_bel_pin(self, bel: BelData, pin: str, wire: str, dir: PinType):
        # Add a pin with associated wire to a bel. The wire should exist already.
        pin_id = self.strs.id(pin)
        if self.strs.id(wire) not in self._wire2idx:
            raise ValueError(f"Wire {wire} not found")
        wire_idx = self._wire2idx[self.strs.id(wire)]
        bel.pins.append(BelPin(pin_id, wire_idx, dir))
        self.wires[wire_idx].bel_pins.append(BelPinRef(bel.index, pin_id))

    def create_wire(self, name: str, type: str = "", const_value: str = "", z: int = 0):
        # Create a new tile wire of a given name and type (optional) in the tile type
        if self.has_wire(name):
            return self.wires[self._wire2idx[self.strs.id(name)]]

        gfx_wire_id = 0
        if name in self.gfx_wire_ids:
            gfx_wire_id = self.gfx_wire_ids[name]

            if z == gfx_wire_id:
                logger.error(f"repeat declare wire z={z}, gfx_wire_id={gfx_wire_id}")
                raise
        gfx_wire_id = z

        wire = TileWireData(
            index=len(self.wires),
            name=self.strs.id(name),
            wire_type=self.strs.id(type),
            gfx_wire_id=gfx_wire_id,
            const_value=self.strs.id(const_value),
        )
        self._wire2idx[wire.name] = wire.index
        self.wires.append(wire)
        return wire

    def create_group(self, name: str, type: str):
        # Create a new group of a given name and type in the tile type
        group = GroupData(
            index=len(self.groups),
            name=self.strs.id(name),
            group_type=self.strs.id(type),
        )
        self._group2idx[group.name] = group.index
        self.groups.append(group)
        return group

    def add_bel_to_group(self, bel: BelData, group: str):
        group_idx = self._group2idx[self.strs.id(group)]
        self.groups[group_idx].group_bels.append(bel.index)

    def add_wire_to_group(self, wire: TileWireData, group: str):
        group_idx = self._group2idx[self.strs.id(group)]
        self.groups[group_idx].group_wires.append(wire.index)

    def add_pip_to_group(self, pip: PipData, group: str):
        group_idx = self._group2idx[self.strs.id(group)]
        self.groups[group_idx].group_pips.append(pip.index)

    def add_group_to_group(self, sub_group: GroupData, group: str):
        group_idx = self._group2idx[self.strs.id(group)]
        self.groups[group_idx].group_groups.append(sub_group.index)

    def create_pip(self, src: str, dst: str, timing_class: str = ""):
        # Create a pip between two tile wires in the tile type. Both wires should exist already.
        if self.strs.id(src) not in self._wire2idx:
            raise ValueError(f"Source wire {src} not found")
        if self.strs.id(dst) not in self._wire2idx:
            raise ValueError(f"Destination wire {dst} not found")

        src_idx = self._wire2idx[self.strs.id(src)]
        dst_idx = self._wire2idx[self.strs.id(dst)]
        pip = PipData(
            index=len(self.pips),
            src_wire=src_idx,
            dst_wire=dst_idx,
            timing_idx=self.tmg.pip_class_idx(timing_class),
        )

        if pip not in self.pips:
            self.wires[src_idx].pips_downhill.append(pip.index)
            self.wires[dst_idx].pips_uphill.append(pip.index)
            self.pips.append(pip)
        return pip

    def has_wire(self, wire: str):
        # Check if a wire has already been created
        return self.strs.id(wire) in self._wire2idx

    def set_wire_type(self, wire: str, type: str):
        # wire type change
        self.wires[self._wire2idx[self.strs.id(wire)]].wire_type = self.strs.id(type)

    def serialise_lists(self, context: str, bba: BBAWriter):
        # list children of members
        for i, bel in enumerate(self.bels):
            bel.serialise_lists(f"{context}_bel{i}", bba)
        for i, wire in enumerate(self.wires):
            wire.serialise_lists(f"{context}_wire{i}", bba)
        for i, pip in enumerate(self.pips):
            pip.serialise_lists(f"{context}_pip{i}", bba)
        for i, group in enumerate(self.groups):
            group.serialise_lists(f"{context}_group{i}", bba)
        # lists of members
        bba.label(f"{context}_bels")
        for i, bel in enumerate(self.bels):
            bel.serialise(f"{context}_bel{i}", bba)
        bba.label(f"{context}_wires")
        for i, wire in enumerate(self.wires):
            wire.serialise(f"{context}_wire{i}", bba)
        bba.label(f"{context}_pips")
        for i, pip in enumerate(self.pips):
            pip.serialise(f"{context}_pip{i}", bba)
        bba.label(f"{context}_groups")
        for i, group in enumerate(self.groups):
            group.serialise(f"{context}_group{i}", bba)
        # extra data (optional)
        if self.extra_data is not None:
            self.extra_data.serialise_lists(f"{context}_extra_data", bba)
            bba.label(f"{context}_extra_data")
            self.extra_data.serialise(f"{context}_extra_data", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.type_name.index)
        bba.slice(f"{context}_bels", len(self.bels))
        bba.slice(f"{context}_wires", len(self.wires))
        bba.slice(f"{context}_pips", len(self.pips))
        bba.slice(f"{context}_groups", len(self.groups))
        if self.extra_data is not None:
            bba.ref(f"{context}_extra_data")
        else:
            bba.u32(0)

    @property
    def name(self):
        return self.strs[self.type_name]

    def add_extraData(self, extra_data: TileExtraData):
        self.extra_data = extra_data

    def get_wire_from_pip(self, pip: PipData) -> tuple[TileWireData, TileWireData]:
        return (self.wires[pip.src_wire], self.wires[pip.dst_wire])
