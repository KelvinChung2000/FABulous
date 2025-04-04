from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port, BelPort

class PE_ports:
    def __init__(self, tilePorts: list[TilePort], belInputs: list[BelPort], belOutputs: list[BelPort]):
        # tile ports
        self.in0 = MuxPort(tilePorts[0], isTilePort=True, isBus=False, width=32)
        self.in1 = MuxPort(tilePorts[1], isTilePort=True, isBus=False, width=32)
        self.in2 = MuxPort(tilePorts[2], isTilePort=True, isBus=False, width=32)
        self.in3 = MuxPort(tilePorts[3], isTilePort=True, isBus=False, width=32)
        self.out0 = MuxPort(tilePorts[4], isTilePort=True, isBus=False, width=32)
        self.out1 = MuxPort(tilePorts[5], isTilePort=True, isBus=False, width=32)
        self.out2 = MuxPort(tilePorts[6], isTilePort=True, isBus=False, width=32)
        self.out3 = MuxPort(tilePorts[7], isTilePort=True, isBus=False, width=32)

        # bel ports
        self.data_in1 = MuxPort(belInputs[0], isBelPort=True, isBus=True, width=32)
        self.data_in2 = MuxPort(belInputs[1], isBelPort=True, isBus=True, width=32)
        self.data_in3 = MuxPort(belInputs[2], isBelPort=True, isBus=True, width=32)
        self.A = MuxPort(belInputs[3], isBelPort=True, isBus=True, width=32)
        self.B = MuxPort(belInputs[4], isBelPort=True, isBus=True, width=32)
        self.RES_en = MuxPort(belInputs[5], isBelPort=True, isBus=False, width=1)
        self.RES_reg_in = MuxPort(belInputs[6], isBelPort=True, isBus=True, width=32)
        self.RES_rst = MuxPort(belInputs[7], isBelPort=True, isBus=False, width=1)
        self.N_en = MuxPort(belInputs[8], isBelPort=True, isBus=False, width=1)
        self.N_reg_in = MuxPort(belInputs[9], isBelPort=True, isBus=True, width=32)
        self.N_rst = MuxPort(belInputs[10], isBelPort=True, isBus=False, width=1)
        self.E_en = MuxPort(belInputs[11], isBelPort=True, isBus=False, width=1)
        self.E_reg_in = MuxPort(belInputs[12], isBelPort=True, isBus=True, width=32)
        self.E_rst = MuxPort(belInputs[13], isBelPort=True, isBus=False, width=1)
        self.S_en = MuxPort(belInputs[14], isBelPort=True, isBus=False, width=1)
        self.S_reg_in = MuxPort(belInputs[15], isBelPort=True, isBus=True, width=32)
        self.S_rst = MuxPort(belInputs[16], isBelPort=True, isBus=False, width=1)
        self.W_en = MuxPort(belInputs[17], isBelPort=True, isBus=False, width=1)
        self.W_reg_in = MuxPort(belInputs[18], isBelPort=True, isBus=True, width=32)
        self.W_rst = MuxPort(belInputs[19], isBelPort=True, isBus=False, width=1)
        self.data_out = MuxPort(belOutputs[0], isBelPort=True, isBus=True, width=32)
        self.Y = MuxPort(belOutputs[1], isBelPort=True, isBus=True, width=32)
        self.const_out = MuxPort(belOutputs[2], isBelPort=True, isBus=True, width=32)
        self.RES_reg_out = MuxPort(belOutputs[3], isBelPort=True, isBus=True, width=32)
        self.N_reg_out = MuxPort(belOutputs[4], isBelPort=True, isBus=True, width=32)
        self.E_reg_out = MuxPort(belOutputs[5], isBelPort=True, isBus=True, width=32)
        self.S_reg_out = MuxPort(belOutputs[6], isBelPort=True, isBus=True, width=32)
        self.W_reg_out = MuxPort(belOutputs[7], isBelPort=True, isBus=True, width=32)


        self.GND = MuxPort(Port(name="gnd", ioDirection=IO.OUTPUT, width=1, isBus=False), width=1)
        self.VCC = MuxPort(Port(name="vcc", ioDirection=IO.OUTPUT, width=1, isBus=False), width=1)

    def NewWire(self, srcName: str, dstName: str, width: int) -> tuple[MuxPort, MuxPort]:
        portSrc = MuxPort(Port(name=srcName, ioDirection=IO.INPUT, width=width, isBus=False), width=width, isCreated=True)
        setattr(self, srcName, portSrc)
        portDst = MuxPort(Port(name=dstName, ioDirection=IO.OUTPUT, width=width, isBus=False), width=width, isCreated=True)
        setattr(self, dstName, portDst)
        return portSrc, portDst

    def __getitem__(self, key: str) -> MuxPort:
        return getattr(self, key)

    def __setitem__(self, key: str, value: MuxPort):
        pass