from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port, BelPort

class PE_ports:
    def __init__(self):
        # tile ports
        self.in0 = MuxPort(TilePort(name='in0', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in1 = MuxPort(TilePort(name='in1', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.EAST, terminal=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in2 = MuxPort(TilePort(name='in2', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in3 = MuxPort(TilePort(name='in3', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.WEST, terminal=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out0 = MuxPort(TilePort(name='out0', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out1 = MuxPort(TilePort(name='out1', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.EAST, terminal=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out2 = MuxPort(TilePort(name='out2', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out3 = MuxPort(TilePort(name='out3', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.WEST, terminal=False), isTilePort=True, isBus=False, bitWidth=32)

        # bel ports
        self.data_in1 = MuxPort(BelPort(name='data_in1', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.data_in2 = MuxPort(BelPort(name='data_in2', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.data_in3 = MuxPort(BelPort(name='data_in3', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.data_out = MuxPort(BelPort(name='data_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.const_out = MuxPort(BelPort(name='const_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.RES_en = MuxPort(BelPort(name='RES_en', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='RES_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.RES_reg_in = MuxPort(BelPort(name='RES_reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='RES_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.RES_rst = MuxPort(BelPort(name='RES_rst', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='RES_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.RES_reg_out = MuxPort(BelPort(name='RES_reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='RES_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.N_en = MuxPort(BelPort(name='N_en', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='N_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.N_reg_in = MuxPort(BelPort(name='N_reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='N_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.N_rst = MuxPort(BelPort(name='N_rst', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='N_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.N_reg_out = MuxPort(BelPort(name='N_reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='N_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.E_en = MuxPort(BelPort(name='E_en', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='E_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.E_reg_in = MuxPort(BelPort(name='E_reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='E_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.E_rst = MuxPort(BelPort(name='E_rst', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='E_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.E_reg_out = MuxPort(BelPort(name='E_reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='E_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.S_en = MuxPort(BelPort(name='S_en', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='S_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.S_reg_in = MuxPort(BelPort(name='S_reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='S_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.S_rst = MuxPort(BelPort(name='S_rst', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='S_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.S_reg_out = MuxPort(BelPort(name='S_reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='S_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.W_en = MuxPort(BelPort(name='W_en', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='W_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.W_reg_in = MuxPort(BelPort(name='W_reg_in', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='W_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)
        self.W_rst = MuxPort(BelPort(name='W_rst', ioDirection=IO.INPUT, wireCount=1, isBus=False, prefix='W_', external=False, control='True'), isBelPort=True, isBus=False, bitWidth=1)
        self.W_reg_out = MuxPort(BelPort(name='W_reg_out', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='W_', external=False, control='False'), isBelPort=True, isBus=True, bitWidth=32)

        self.GND = MuxPort(Port(name="gnd", ioDirection=IO.OUTPUT, wireCount=1, isBus=False), bitWidth=1)
        self.VCC = MuxPort(Port(name="vcc", ioDirection=IO.OUTPUT, wireCount=1, isBus=False), bitWidth=1)

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