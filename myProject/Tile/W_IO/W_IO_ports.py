from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port, BelPort

class W_IO_ports:
    def __init__(self):
        # tile ports
        self.out3 = MuxPort(TilePort(name='out3', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.WEST, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in3 = MuxPort(TilePort(name='in3', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.WEST, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in1 = MuxPort(TilePort(name='in1', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.EAST, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out1 = MuxPort(TilePort(name='out1', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.EAST, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)

        # bel ports
        self.W_from_fabric = MuxPort(BelPort(name='W_from_fabric', ioDirection=IO.INPUT, wireCount=1, isBus=True, prefix='W_', external=False), isBelPort=True, isBus=True, bitWidth=1)
        self.W_to_fabric = MuxPort(BelPort(name='W_to_fabric', ioDirection=IO.OUTPUT, wireCount=1, isBus=True, prefix='W_', external=False), isBelPort=True, isBus=True, bitWidth=1)

    def NewWire(self, srcName: str, dstName: str, wireCount: int) -> (MuxPort, MuxPort):
        portSrc = MuxPort(Port(name=srcName, ioDirection=IO.INPUT, wireCount=wireCount, isBus=False), bitWidth=wireCount, isCreated=True)
        setattr(self, srcName, portSrc)
        portDst = MuxPort(Port(name=dstName, ioDirection=IO.OUTPUT, wireCount=wireCount, isBus=False), bitWidth=wireCount, isCreated=True)
        setattr(self, dstName, portDst)
        return portSrc, portDst

    def __getitem__(self, key: str) -> MuxPort:
        return getattr(self, key)

    def __setitem__(self, key: str, value: MuxPort):
        pass