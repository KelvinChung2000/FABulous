from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port, BelPort

class N_IO_ports:
    def __init__(self):
        # tile ports
        self.out0 = MuxPort(TilePort(name='out0', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in0 = MuxPort(TilePort(name='in0', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in2 = MuxPort(TilePort(name='in2', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out2 = MuxPort(TilePort(name='out2', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)

        # bel ports
        self.N_from_fabric = MuxPort(BelPort(name='from_fabric', ioDirection=IO.INPUT, wireCount=1, isBus=True, prefix='N_', external=False), isBelPort=True, isBus=True, bitWidth=1)
        self.N_to_fabric = MuxPort(BelPort(name='to_fabric', ioDirection=IO.OUTPUT, wireCount=1, isBus=True, prefix='N_', external=False), isBelPort=True, isBus=True, bitWidth=1)

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