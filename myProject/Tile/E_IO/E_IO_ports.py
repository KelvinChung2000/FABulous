from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port

class E_IO_ports:
    def __init__(self):
        # tile ports
        self.out1 = MuxPort(TilePort(name='out1', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.EAST, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in1 = MuxPort(TilePort(name='in1', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.EAST, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.in3 = MuxPort(TilePort(name='in3', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.WEST, terminal=True, spanning=False), isTilePort=True, isBus=False, bitWidth=32)
        self.out3 = MuxPort(TilePort(name='out3', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.WEST, terminal=False, spanning=False), isTilePort=True, isBus=False, bitWidth=32)

        # bel ports
        self.E_from_fabric = MuxPort(Port(name='from_fabric', ioDirection=IO.INPUT, wireCount=1, isBus=True), isBelPort=True, isBus=True, bitWidth=1)
        self.E_to_fabric = MuxPort(Port(name='to_fabric', ioDirection=IO.OUTPUT, wireCount=1, isBus=True), isBelPort=True, isBus=True, bitWidth=1)

    def NewWire(self, name: str, wireCount: int) -> MuxPort:
        port = MuxPort(Port(name=name, ioDirection=IO.INOUT, wireCount=wireCount, isBus=False), bitWidth=wireCount)
        setattr(self, name, port)
        return port

    def __getitem__(self, key: str) -> MuxPort:
        return getattr(self, key)

    def __setitem__(self, key: str, value: MuxPort):
        i = self[key]
        i //= value