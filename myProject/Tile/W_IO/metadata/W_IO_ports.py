from FABulous.fabric_definition.SwitchMatrix import MuxPort
from FABulous.fabric_definition.define import IO, Side
from FABulous.fabric_definition.Port import TilePort, Port, BelPort

class W_IO_ports:
    def __init__(self, tilePorts: list[TilePort], belInputs: list[BelPort], belOutputs: list[BelPort]):
        # tile ports
        self.in1 = MuxPort(tilePorts[0], isTilePort=True, isBus=False, width=32)
        self.out1 = MuxPort(tilePorts[1], isTilePort=True, isBus=False, width=32)

        # bel ports
        self.W_from_fabric = MuxPort(belInputs[0], isBelPort=True, isBus=True, width=32)
        self.W_to_fabric = MuxPort(belOutputs[0], isBelPort=True, isBus=True, width=32)


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