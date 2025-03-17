from dataclasses import dataclass, field
from typing import Optional

from FABulous.fabric_cad.bba import BBAWriter
from FABulous.fabric_cad.chip_database.BBAStruct import BBAStruct
from FABulous.fabric_cad.chip_database.define import ClockEdge
from FABulous.fabric_cad.chip_database.StringPool import StringPool


class TimingValue(BBAStruct):
    def __init__(self, fast_min=0, fast_max=None, slow_min=None, slow_max=None):
        self.fast_min = fast_min
        self.fast_max = fast_max or fast_min
        self.slow_min = slow_min or self.fast_min
        self.slow_max = slow_max or self.fast_max

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.fast_min)
        bba.u32(self.fast_max)
        bba.u32(self.slow_min)
        bba.u32(self.slow_max)


@dataclass
class CellPinCombArc(BBAStruct):
    from_pin: int
    delay: TimingValue = field(default_factory=TimingValue)

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.from_pin.index)
        self.delay.serialise(context, bba)


@dataclass
class CellPinRegArc(BBAStruct):
    clock: int
    edge: ClockEdge
    setup: TimingValue = field(default_factory=TimingValue)  # setup time in ps
    hold: TimingValue = field(default_factory=TimingValue)  # hold time in ps
    clk_q: TimingValue = field(
        default_factory=TimingValue
    )  # clock to output time in ps

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.clock.index)
        bba.u32(self.edge.value)
        self.setup.serialise(context, bba)
        self.hold.serialise(context, bba)
        self.clk_q.serialise(context, bba)


@dataclass
class CellPinTiming(BBAStruct):
    pin: int
    flags: int = 0
    comb_arcs: list[CellPinCombArc] = field(
        default_factory=list
    )  # sorted by from_pin ID index
    reg_arcs: list[CellPinRegArc] = field(
        default_factory=list
    )  # sorted by clock ID index

    def set_clock(self):
        self.flags |= 1

    def finalise(self):
        self.comb_arcs.sort(key=lambda a: a.from_pin)
        self.reg_arcs.sort(key=lambda a: a.clock)

    def serialise_lists(self, context: str, bba: BBAWriter):
        bba.label(f"{context}_comb")
        for i, a in enumerate(self.comb_arcs):
            a.serialise(f"{context}_comb{i}", bba)
        bba.label(f"{context}_reg")
        for i, a in enumerate(self.reg_arcs):
            a.serialise(f"{context}_reg{i}", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.pin.index)  # pin idstring
        bba.u32(self.flags)
        bba.slice(f"{context}_comb", len(self.comb_arcs))
        bba.slice(f"{context}_reg", len(self.reg_arcs))


class CellTiming(BBAStruct):
    def __init__(self, strs: StringPool, type_variant: str):
        self.strs = strs
        self.type_variant = strs.id(type_variant)
        self.pin_data = {}

    # combinational timing through a cell (like a LUT delay)
    def add_comb_arc(self, from_pin: str, to_pin: str, delay: TimingValue):
        if to_pin not in self.pin_data:
            self.pin_data[to_pin] = CellPinTiming(pin=self.strs.id(to_pin))
        self.pin_data[to_pin].comb_arcs.append(
            CellPinCombArc(from_pin=self.strs.id(from_pin), delay=delay)
        )

    # register input style timing (like a DFF input)
    def add_setup_hold(
        self,
        clock: str,
        input_pin: str,
        edge: ClockEdge,
        setup: TimingValue,
        hold: TimingValue,
    ):
        if input_pin not in self.pin_data:
            self.pin_data[input_pin] = CellPinTiming(pin=self.strs.id(input_pin))
        if clock not in self.pin_data:
            self.pin_data[clock] = CellPinTiming(pin=self.strs.id(clock))
        self.pin_data[input_pin].reg_arcs.append(
            CellPinRegArc(clock=self.strs.id(clock), edge=edge, setup=setup, hold=hold)
        )
        self.pin_data[clock].set_clock()

    # register output style timing (like a DFF output)
    def add_clock_out(
        self, clock: str, output_pin: str, edge: ClockEdge, delay: TimingValue
    ):
        if output_pin not in self.pin_data:
            self.pin_data[output_pin] = CellPinTiming(pin=self.strs.id(output_pin))
        if clock not in self.pin_data:
            self.pin_data[clock] = CellPinTiming(pin=self.strs.id(clock))
        self.pin_data[output_pin].reg_arcs.append(
            CellPinRegArc(clock=self.strs.id(clock), edge=edge, clk_q=delay)
        )
        self.pin_data[clock].set_clock()

    def finalise(self):
        self.pins = list(self.pin_data.values())
        self.pins.sort(key=lambda p: p.pin)
        for pin in self.pins:
            pin.finalise()

    def serialise_lists(self, context: str, bba: BBAWriter):
        for i, p in enumerate(self.pins):
            p.serialise_lists(f"{context}_pin{i}", bba)
        bba.label(f"{context}_pins")
        for i, p in enumerate(self.pins):
            p.serialise(f"{context}_pin{i}", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.type_variant.index)  # type idstring
        bba.slice(f"{context}_pins", len(self.pins))


@dataclass
class NodeTiming(BBAStruct):
    res: TimingValue = field(
        default_factory=TimingValue
    )  # wire resistance in notional milliohms
    cap: TimingValue = field(
        default_factory=TimingValue
    )  # wire capacitance in notional femtofarads
    delay: TimingValue = field(default_factory=TimingValue)  # fixed wire delay in ps

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        self.res.serialise(context, bba)
        self.cap.serialise(context, bba)
        self.delay.serialise(context, bba)


@dataclass
class PipTiming(BBAStruct):
    int_delay: TimingValue = field(
        default_factory=TimingValue
    )  # internal fixed delay in ps
    in_cap: TimingValue = field(
        default_factory=TimingValue
    )  # internal capacitance in notional femtofarads
    out_res: TimingValue = field(
        default_factory=TimingValue
    )  # drive/output resistance in notional milliohms
    flags: int = 0  # is_buffered etc

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        self.int_delay.serialise(context, bba)
        self.in_cap.serialise(context, bba)
        self.out_res.serialise(context, bba)
        bba.u32(self.flags)


@dataclass
class SpeedGrade(BBAStruct):
    name: int
    pip_classes: list[Optional[PipTiming]] = field(default_factory=list)
    node_classes: list[Optional[NodeTiming]] = field(default_factory=list)
    cell_types: list[CellTiming] = field(
        default_factory=list
    )  # sorted by (cell_type, variant) ID tuple

    def finalise(self):
        self.cell_types.sort(key=lambda ty: ty.type_variant)
        for ty in self.cell_types:
            ty.finalise()

    def serialise_lists(self, context: str, bba: BBAWriter):
        for i, t in enumerate(self.cell_types):
            t.serialise_lists(f"{context}_cellty{i}", bba)
        bba.label(f"{context}_pip_classes")
        for i, p in enumerate(self.pip_classes):
            p.serialise(f"{context}_pipc{i}", bba)
        bba.label(f"{context}_node_classes")
        for i, n in enumerate(self.node_classes):
            n.serialise(f"{context}_nodec{i}", bba)
        bba.label(f"{context}_cell_types")
        for i, t in enumerate(self.cell_types):
            t.serialise(f"{context}_cellty{i}", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.name.index)  # speed grade idstring
        bba.slice(f"{context}_pip_classes", len(self.pip_classes))
        bba.slice(f"{context}_node_classes", len(self.node_classes))
        bba.slice(f"{context}_cell_types", len(self.cell_types))


class TimingPool(BBAStruct):
    def __init__(self, strs: StringPool):
        self.strs = strs
        self.speed_grades = []
        self.speed_grade_idx = {}
        self.pip_classes = {}
        self.node_classes = {}

    def set_speed_grades(self, speed_grades: list):
        assert len(self.speed_grades) == 0
        self.speed_grades = [SpeedGrade(name=self.strs.id(g)) for g in speed_grades]
        self.speed_grade_idx = {g: i for i, g in enumerate(speed_grades)}

    def pip_class_idx(self, name: str):
        if name == "":
            return -1
        elif name in self.pip_classes:
            return self.pip_classes[name]
        else:
            idx = len(self.pip_classes)
            self.pip_classes[name] = idx
            return idx

    def node_class_idx(self, name: str):
        if name == "":
            return -1
        elif name in self.node_classes:
            return self.node_classes[name]
        else:
            idx = len(self.node_classes)
            self.node_classes[name] = idx
            return idx

    def set_pip_class(
        self,
        grade: str,
        name: str,
        delay: TimingValue,
        in_cap: Optional[TimingValue] = None,
        out_res: Optional[TimingValue] = None,
        is_buffered=True,
    ):
        idx = self.pip_class_idx(name)
        sg = self.speed_grades[self.speed_grade_idx[grade]]
        if idx >= len(sg.pip_classes):
            sg.pip_classes += [None for i in range(1 + idx - len(sg.pip_classes))]
        assert (
            sg.pip_classes[idx] is None
        ), f"attempting to set pip class {name} in speed grade {grade} twice"
        sg.pip_classes[idx] = PipTiming(
            int_delay=delay,
            in_cap=in_cap or TimingValue(),
            out_res=out_res or TimingValue(),
            flags=(1 if is_buffered else 0),
        )

    def set_bel_pin_class(
        self,
        grade: str,
        name: str,
        delay: TimingValue,
        in_cap: Optional[TimingValue] = None,
        out_res: Optional[TimingValue] = None,
    ):
        # bel pin classes are shared with pip classes, but this alias adds a bit of extra clarity
        self.set_pip_class(grade, name, delay, in_cap, out_res, is_buffered=True)

    def set_node_class(
        self,
        grade: str,
        name: str,
        delay: TimingValue,
        res: Optional[TimingValue] = None,
        cap: Optional[TimingValue] = None,
    ):
        idx = self.node_class_idx(name)
        sg = self.speed_grades[self.speed_grade_idx[grade]]
        if idx >= len(sg.node_classes):
            sg.node_classes += [None for i in range(1 + idx - len(sg.node_classes))]
        assert (
            sg.node_classes[idx] is None
        ), f"attempting to set node class {name} in speed grade {grade} twice"
        sg.node_classes[idx] = NodeTiming(
            delay=delay, res=res or TimingValue(), cap=cap or TimingValue()
        )

    def add_cell_variant(self, speed_grade: str, name: str):
        cell = CellTiming(self.strs, name)
        self.speed_grades[self.speed_grade_idx[speed_grade]].cell_types.append(cell)
        return cell

    def finalise(self):
        for sg in self.speed_grades:
            sg.finalise()
            sg.finalise()
