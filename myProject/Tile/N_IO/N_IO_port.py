from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port

class N_IO_ports:
    def __init__(self):
        # tile ports
        self.out0 = MuxPort(TilePort(name='out0', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=True, spanning=False), isTilePort=True, isBus=False)
        self.in0 = MuxPort(TilePort(name='in0', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.NORTH, terminal=True, spanning=False), isTilePort=True, isBus=False)
        self.in2 = MuxPort(TilePort(name='in2', ioDirection=IO.INPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=True, spanning=False), isTilePort=True, isBus=False)
        self.out2 = MuxPort(TilePort(name='out2', ioDirection=IO.OUTPUT, wireCount=32, isBus=False, sideOfTile=Side.SOUTH, terminal=False, spanning=False), isTilePort=True, isBus=False)

        # bel ports
        self.N_from_fabric = MuxPort(Port(name='from_fabric', ioDirection=IO.INPUT, wireCount=1, isBus=True), isBelPort=True, isBus=True)
        self.N_to_fabric = MuxPort(Port(name='to_fabric', ioDirection=IO.OUTPUT, wireCount=1, isBus=True), isBelPort=True, isBus=True)

    def addWire(self, name: str, wireCount: int):
        port = MuxPort(Port(name=name, ioDirection=IO.INOUT, wireCount=wireCount, isBus=False))
        self.__dict__[name] = port
        return port

