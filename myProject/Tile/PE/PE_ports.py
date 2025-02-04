from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port

class PE_ports:
    def __init__(self):
        # tile ports
        self.in0 = MuxPort(TilePort(name='in0', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in1 = MuxPort(TilePort(name='in1', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.EAST, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in2 = MuxPort(TilePort(name='in2', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in3 = MuxPort(TilePort(name='in3', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.WEST, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out0 = MuxPort(TilePort(name='out0', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out1 = MuxPort(TilePort(name='out1', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.EAST, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out2 = MuxPort(TilePort(name='out2', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out3 = MuxPort(TilePort(name='out3', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.WEST, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.spanIn = MuxPort(TilePort(name='spanIn', ioDirection=IO.OUTPUT, wireCount=2, isBus=False, sideOfTile=Side.EAST, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=2)
        self.spanOut = MuxPort(TilePort(name='spanOut', ioDirection=IO.OUTPUT, wireCount=2, isBus=False, sideOfTile=Side.WEST, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=2)

        # bel ports
        self.data_in1 = MuxPort(Port(name='data_in1', ioDirection=IO.INPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.data_in2 = MuxPort(Port(name='data_in2', ioDirection=IO.INPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.data_in3 = MuxPort(Port(name='data_in3', ioDirection=IO.INPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.data_out = MuxPort(Port(name='data_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.const_out = MuxPort(Port(name='const_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.RES_reg_in = MuxPort(Port(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.RES_reg_out = MuxPort(Port(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.N_reg_in = MuxPort(Port(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.N_reg_out = MuxPort(Port(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.E_reg_in = MuxPort(Port(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.E_reg_out = MuxPort(Port(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.S_reg_in = MuxPort(Port(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.S_reg_out = MuxPort(Port(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.W_reg_in = MuxPort(Port(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)
        self.W_reg_out = MuxPort(Port(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True), isBelPort=True, isBus=True, bitWidth=32)

    def NewWire(self, name: str, wireCount: int) -> MuxPort:
        port = MuxPort(Port(name=name, ioDirection=IO.INOUT, wireCount=wireCount, isBus=False), bitWidth=wireCount)
        setattr(self, name, port)
        return port

    def __getitem__(self, key: str) -> MuxPort:
        return getattr(self, key)

    def __setitem__(self, key: str, value: MuxPort):
        i = self[key]
        i //= value