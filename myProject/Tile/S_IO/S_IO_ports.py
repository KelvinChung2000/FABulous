from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port

class S_IO_ports:
    def __init__(self):
        # tile ports
        self.out2 = MuxPort(TilePort(name='out2', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in2 = MuxPort(TilePort(name='in2', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in0 = MuxPort(TilePort(name='in0', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out0 = MuxPort(TilePort(name='out0', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)

        # bel ports
        self.S_from_fabric = MuxPort(Port(name='from_fabric', ioDirection=IO.INPUT, wireCount=1, isBus=True), isBelPort=True, isBus=True, bitWidth=1)
        self.S_to_fabric = MuxPort(Port(name='to_fabric', ioDirection=IO.OUTPUT, wireCount=1, isBus=True), isBelPort=True, isBus=True, bitWidth=1)

    def NewWire(self, name: str, wireCount: int) -> MuxPort:
        port = MuxPort(Port(name=name, ioDirection=IO.INOUT, wireCount=wireCount, isBus=False), bitWidth=wireCount)
        setattr(self, name, port)
        return port

    def __getitem__(self, key: str) -> MuxPort:
        return getattr(self, key)

    def __setitem__(self, key: str, value: MuxPort):
        i = self[key]
        i //= value