from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port, BelPort

class N_IO_ports:
    def __init__(self):
        # tile ports
        self.in2 = MuxPort(TilePort(name='in2', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out2 = MuxPort(TilePort(name='out2', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=False), isTilePort=True, isBus=False, bitWidth=32)

        # bel ports
        self.N_from_fabric = MuxPort(BelPort(name='N_from_fabric', ioDirection=IO.INPUT, wireCount=32, isBus=True, prefix='N_', external=False, control=False), isBelPort=True, isBus=True, bitWidth=32)
        self.N_to_fabric = MuxPort(BelPort(name='N_to_fabric', ioDirection=IO.OUTPUT, wireCount=32, isBus=True, prefix='N_', external=False, control=False), isBelPort=True, isBus=True, bitWidth=32)

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