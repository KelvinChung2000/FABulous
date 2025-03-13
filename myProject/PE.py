from subprocess import run

from FABulous.fabric_cad.chip_database_gen.chip import Chip
from FABulous.fabric_cad.chip_database_gen.database_timing import TimingValue
from FABulous.fabric_cad.chip_database_gen.define import NodeWire, PinType

ch = Chip("example", "example", 4, 4)
ch.strs.read_constids(".FABulous/baseConstIds.inc")
tt = ch.create_tile_type("PE")
alu = tt.create_bel("ADD", "add", z=0)
for i in range(32):
    tt.create_wire(f"srcA_{i}", "srcA")
    tt.create_wire(f"srcB_{i}", "srcB")
    tt.create_wire(f"out_{i}", "out")

    tt.add_bel_pin(alu, f"srcA[{i}]", f"srcA_{i}", PinType.INPUT)
    tt.add_bel_pin(alu, f"srcB[{i}]", f"srcB_{i}", PinType.INPUT)
    tt.add_bel_pin(alu, f"out[{i}]", f"out_{i}", PinType.OUTPUT)

for i in range(32):
    tt.create_wire(f"in0[{i}]", "in0")
    tt.create_wire(f"in1[{i}]", "in1")
    tt.create_wire(f"in2[{i}]", "in2")
    tt.create_wire(f"in3[{i}]", "in3")

    tt.create_wire(f"out0[{i}]", "out0")
    tt.create_wire(f"out1[{i}]", "out1")
    tt.create_wire(f"out2[{i}]", "out2")
    tt.create_wire(f"out3[{i}]", "out3")

for side in range(4):
    for i in range(32):
        tt.create_pip(f"in{side}[{i}]", f"srcA_{i}")
        tt.create_pip(f"in{side}[{i}]", f"srcB_{i}")
        tt.create_pip(f"out_{i}", f"out{side}[{i}]")

for sideA in range(4):
    for sideB in range(4):
        for i in range(32):
            tt.create_pip(f"in{sideA}[{i}]", f"out{sideB}[{i}]")

tt = ch.create_tile_type("IO")
for i in range(32):
    tt.create_wire(f"IO{i}_T", "IO_T")
    tt.create_wire(f"IO{i}_I", "IO_I")
    tt.create_wire(f"IO{i}_O", "IO_O")
    tt.create_wire(f"IO{i}_PAD", "IO_PAD")
for i in range(32):
    io = tt.create_bel(f"IO{i}", "IOB", z=i)
    tt.add_bel_pin(io, "I", f"IO{i}_I", PinType.INPUT)
    tt.add_bel_pin(io, "T", f"IO{i}_T", PinType.INPUT)
    tt.add_bel_pin(io, "O", f"IO{i}_O", PinType.OUTPUT)
    tt.add_bel_pin(io, "PAD", f"IO{i}_PAD", PinType.INOUT)

tt = ch.create_tile_type("NULL")

ch.set_tile_type(1, 1, "PE")
ch.set_tile_type(2, 1, "PE")
ch.set_tile_type(1, 2, "PE")
ch.set_tile_type(2, 2, "PE")

ch.set_tile_type(1, 0, "IO")
ch.set_tile_type(2, 0, "IO")
ch.set_tile_type(1, 3, "IO")
ch.set_tile_type(2, 3, "IO")
ch.set_tile_type(0, 1, "IO")
ch.set_tile_type(0, 2, "IO")
ch.set_tile_type(3, 1, "IO")
ch.set_tile_type(3, 2, "IO")

ch.set_tile_type(0, 0, "NULL")
ch.set_tile_type(3, 0, "NULL")
ch.set_tile_type(0, 3, "NULL")
ch.set_tile_type(3, 3, "NULL")

# conncecting the tiles
ch.add_node(
    [NodeWire(1, 1, f"out1[{i}]") for i in range(32)]
    + [NodeWire(2, 1, f"in3[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(1, 1, f"out2[{i}]") for i in range(32)]
    + [NodeWire(1, 2, f"in0[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(2, 1, f"out3[{i}]") for i in range(32)]
    + [NodeWire(1, 1, f"in1[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(2, 1, f"out2[{i}]") for i in range(32)]
    + [NodeWire(2, 2, f"in0[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(1, 2, f"out0[{i}]") for i in range(32)]
    + [NodeWire(1, 1, f"in2[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(1, 2, f"out1[{i}]") for i in range(32)]
    + [NodeWire(2, 2, f"in3[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(2, 2, f"out0[{i}]") for i in range(32)]
    + [NodeWire(2, 1, f"in2[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(2, 2, f"out3[{i}]") for i in range(32)]
    + [NodeWire(1, 2, f"in1[{i}]") for i in range(32)]
)

# connecting the IOs
# North
ch.add_node(
    [NodeWire(1, 0, f"IO{i}_I") for i in range(32)]
    + [NodeWire(1, 1, f"in0[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(1, 0, f"IO{i}_O") for i in range(32)]
    + [NodeWire(1, 1, f"out0[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(2, 0, f"IO{i}_I") for i in range(32)]
    + [NodeWire(2, 1, f"in0[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(2, 0, f"IO{i}_O") for i in range(32)]
    + [NodeWire(2, 1, f"out0[{i}]") for i in range(32)]
)

# West
ch.add_node(
    [NodeWire(0, 1, f"IO{i}_I") for i in range(32)]
    + [NodeWire(1, 1, f"in3[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(0, 1, f"IO{i}_O") for i in range(32)]
    + [NodeWire(1, 1, f"out3[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(0, 2, f"IO{i}_I") for i in range(32)]
    + [NodeWire(1, 2, f"in3[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(0, 2, f"IO{i}_O") for i in range(32)]
    + [NodeWire(1, 2, f"out3[{i}]") for i in range(32)]
)

# East
ch.add_node(
    [NodeWire(3, 1, f"IO{i}_I") for i in range(32)]
    + [NodeWire(2, 1, f"in1[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(3, 1, f"IO{i}_O") for i in range(32)]
    + [NodeWire(2, 1, f"out1[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(3, 2, f"IO{i}_I") for i in range(32)]
    + [NodeWire(2, 2, f"in1[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(3, 2, f"IO{i}_O") for i in range(32)]
    + [NodeWire(2, 2, f"out1[{i}]") for i in range(32)]
)


# South
ch.add_node(
    [NodeWire(1, 3, f"IO{i}_I") for i in range(32)]
    + [NodeWire(1, 2, f"in2[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(1, 3, f"IO{i}_O") for i in range(32)]
    + [NodeWire(1, 2, f"out2[{i}]") for i in range(32)]
)

ch.add_node(
    [NodeWire(2, 3, f"IO{i}_I") for i in range(32)]
    + [NodeWire(2, 2, f"in2[{i}]") for i in range(32)]
)
ch.add_node(
    [NodeWire(2, 3, f"IO{i}_O") for i in range(32)]
    + [NodeWire(2, 2, f"out2[{i}]") for i in range(32)]
)

speed = "DEFAULT"
tmg = ch.set_speed_grades([speed])
# --- Routing Delays ---
# Notes: A simpler timing model could just use intrinsic delay and ignore R and Cs.
# R and C values don't have to be physically realistic, just in agreement with themselves to provide
# a meaningful scaling of delay with fanout. Units are subject to change.
tmg.set_pip_class(
    grade=speed,
    name="SWINPUT",
    delay=TimingValue(80),  # 80ps intrinstic delaychipdb-example
    in_cap=TimingValue(5000),  # 5pF
    out_res=TimingValue(1000),  # 1ohm
)
tmg.set_pip_class(
    grade=speed,
    name="SWOUTPUT",
    delay=TimingValue(100),  # 100ps intrinstic delay
    in_cap=TimingValue(5000),  # 5pF
    out_res=TimingValue(800),  # 0.8ohm
)
tmg.set_pip_class(
    grade=speed,
    name="SWNEIGH",
    delay=TimingValue(120),  # 120ps intrinstic delay
    in_cap=TimingValue(7000),  # 7pF
    out_res=TimingValue(1200),  # 1.2ohm
)


ch.write_bba("./.FABulous/eFPGA.bba")
run(
    "bbasm --l ./.FABulous/chipdb-example.bba ./.FABulous/eFPGA.bit",
    shell=True,
)

# inputCrossBar = Bel(
#     src="software",
#     name="inputCrossBar",
#     prefix="inputCrossBar_",
#     internalPorts=[
#         InPort("in0", 32),
#         InPort("in1", 32),
#         InPort("in2", 32),
#         InPort("in3", 32),
#         OutPort("out0", 32),
#         OutPort("out1", 32),
#         OutPort("out2", 32),
#         OutPort("out3", 32),
#     ],
#     externalPorts=[],
#     configPort=["config"],
#     sharedPort=[],
#     configBit=8,
#     belMap={
#         "out0_0": {},
#         "out1_0": {},
#         "out2_0": {},
#         "out3_0": {},
#         "out0_1": {},
#         "out1_1": {},
#         "out2_1": {},
#         "out3_1": {},
#         "out0_2": {},
#         "out1_2": {},
#         "out2_2": {},
#         "out3_2": {},
#         "out0_3": {},
#         "out1_3": {},
#         "out2_3": {},
#         "out3_3": {},
#     },
#     userCLK=False,
# )

# outputCrossBar = Bel(
#     src="software",
#     name="outputCrossBar",
#     prefix="outputCrossBar_",
#     internalPorts=[
#         InPort("in0", 32),
#         InPort("in1", 32),
#         InPort("in2", 32),
#         OutPort("out0", 32),
#         OutPort("out1", 32),
#         OutPort("out2", 32),
#         OutPort("out3", 32),
#     ],
#     externalPorts=[],
#     configPort=["config"],
#     sharedPort=[],
#     configBit=8,
#     belMap={
#         "out0_0": {},
#         "out1_0": {},
#         "out2_0": {},
#         "out3_0": {},
#         "out0_1": {},
#         "out1_1": {},
#         "out2_1": {},
#         "out3_1": {},
#         "out0_2": {},
#         "out1_2": {},
#         "out2_2": {},
#         "out3_2": {},
#         "out0_3": {},
#         "out1_3": {},
#         "out2_3": {},
#         "out3_3": {},
#     },
#     userCLK=False,
# )

# alu = Bel(
#     src="software",
#     name="alu",
#     prefix="alu_",
#     internalPorts=[InPort("srcA", 32), InPort("srcB", 32), OutPort("out", 32)],
#     externalPorts=[],
#     configPort=["config"],
#     sharedPort=[],
#     configBit=12,
#     belMap={
#         "alu0": {},
#         "alu1": {},
#         "alu2": {},
#         "alu3": {},
#     },
#     userCLK=False,
# )


# t = Tile(
#     name="PE",
#     ports=[
#         Port(
#             wireDirection=Direction.NORTH,
#             name="out0",
#             sourceName="out0",
#             xOffset=0,
#             yOffset=1,
#             destinationName="in0",
#             wireCount=32,
#             inOut=IO.OUTPUT,
#             sideOfTile=Side.NORTH,
#         ),
#         Port(
#             wireDirection=Direction.EAST,
#             name="out1",
#             sourceName="out1",
#             xOffset=1,
#             yOffset=0,
#             destinationName="in1",
#             wireCount=32,
#             inOut=IO.OUTPUT,
#             sideOfTile=Side.EAST,
#         ),
#         Port(
#             wireDirection=Direction.SOUTH,
#             name="out2",
#             sourceName="out2",
#             xOffset=0,
#             yOffset=-1,
#             destinationName="in2",
#             wireCount=32,
#             inOut=IO.OUTPUT,
#             sideOfTile=Side.SOUTH,
#         ),
#         Port(
#             wireDirection=Direction.WEST,
#             name="out3",
#             sourceName="out3",
#             xOffset=-1,
#             yOffset=0,
#             destinationName="in3",
#             wireCount=32,
#             inOut=IO.OUTPUT,
#             sideOfTile=Side.WEST,
#         ),
#     ],
#     bels=[inputCrossBar, outputCrossBar, alu],
#     matrixDir="software",
#     userCLK=False,
#     configBit=0,
# )

# t.addInternalWire(InternalWire("in0", "inputCrossBar_in0"))
# t.addInternalWire(InternalWire("in1", "inputCrossBar_in1"))
# t.addInternalWire(InternalWire("in2", "inputCrossBar_in2"))
# t.addInternalWire(InternalWire("in3", "inputCrossBar_in3"))
# t.addInternalWire(InternalWire("inputCrossBar_out0", "alu_srcA"))
# t.addInternalWire(InternalWire("inputCrossBar_out1", "alu_srcB"))
# t.addInternalWire(InternalWire("inputCrossBar_out2", "outputCrossBar_in0"))
# t.addInternalWire(InternalWire("inputCrossBar_out3", "outputCrossBar_in1"))
# t.addInternalWire(InternalWire("alu_out", "outputCrossBar_in2"))
# t.addInternalWire(InternalWire("outputCrossBar_out0", "out0"))
# t.addInternalWire(InternalWire("outputCrossBar_out1", "out1"))
# t.addInternalWire(InternalWire("outputCrossBar_out2", "out2"))
# t.addInternalWire(InternalWire("outputCrossBar_out3", "out3"))

# f = Fabric(name="PEFabric", tile=[[t, t], [t, t]])

# npnrResult = genNextpnrModel(f)
# baseDir = "myProject/.FABulous"
# with open(f"{baseDir}/pips.txt", "w") as f:
#     f.write(npnrResult[0])

# with open(f"{baseDir}/bel.txt", "w") as f:
#     f.write(npnrResult[1])

# with open(f"{baseDir}/bel.v2.txt", "w") as f:
#     f.write(npnrResult[2])

# with open(f"{baseDir}/template.pcf", "w") as f:
#     f.write(npnrResult[3])
