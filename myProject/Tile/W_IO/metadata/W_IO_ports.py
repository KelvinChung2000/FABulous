from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port, BelPort

class W_IO_ports:
    def __init__(self, tilePorts: list[TilePort], belInputs: list[BelPort], belOutputs: list[BelPort]):
        # tile ports
        self.in1 = MuxPort(tilePorts[0], isTilePort=True, isBus=False, bitWidth=32)
        self.out1 = MuxPort(tilePorts[1], isTilePort=True, isBus=False, bitWidth=32)

        # bel ports
        self.W_from_fabric = MuxPort(belInputs[0], isBelPort=True, isBus=True, bitWidth=32)
        self.W_to_fabric = MuxPort(belOutputs[0], isBelPort=True, isBus=True, bitWidth=32)


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