from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port, BelPort

class mux_ports:
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

        # bel ports
        self.data_in1 = MuxPort(BelPort(name='data_in1', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.data_in2 = MuxPort(BelPort(name='data_in2', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.data_in3 = MuxPort(BelPort(name='data_in3', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.data_out = MuxPort(BelPort(name='data_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.const_out = MuxPort(BelPort(name='const_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.RES_reg_in = MuxPort(BelPort(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='RES_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.RES_reg_out = MuxPort(BelPort(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='RES_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.N_reg_in = MuxPort(BelPort(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='N_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.N_reg_out = MuxPort(BelPort(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='N_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.E_reg_in = MuxPort(BelPort(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='E_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.E_reg_out = MuxPort(BelPort(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='E_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.S_reg_in = MuxPort(BelPort(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='S_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.S_reg_out = MuxPort(BelPort(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='S_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.W_reg_in = MuxPort(BelPort(name='reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='W_', external=False), isBelPort=True, isBus=True, bitWidth=32)
        self.W_reg_out = MuxPort(BelPort(name='reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='W_', external=False), isBelPort=True, isBus=True, bitWidth=32)

    def NewWire(self, srcName: str, dstName: str, wireCount: int) -> tuple[MuxPort, MuxPort]:
        portSrc = MuxPort(Port(name=srcName, ioDirection=IO.INPUT, wireCount=wireCount, isBus=False), bitWidth=wireCount, isCreated=True)
        setattr(self, srcName, portSrc)
        portDst = MuxPort(Port(name=dstName, ioDirection=IO.OUTPUT, wireCount=wireCount, isBus=False), bitWidth=wireCount, isCreated=True)
        setattr(self, dstName, portDst)
        return portSrc, portDst

    def __getitem__(self, key: str) -> MuxPort:
        return getattr(self, key)

    def __setitem__(self, key: str, value: MuxPort):
        pass