from pathlib import Path

from FABulous.fabric_definition.define import IO, ConfigBitMode
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator


def generateTile(fabric: Fabric, tile: Tile, dest: Path):

    cg = CodeGenerator(dest)

    parameters = [
        cg.Parameter("MaxFramesPerCol", fabric.maxFramesPerCol),
        cg.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow),
        (
            cg.Parameter("NoConfigBits", tile.globalConfigBits)
            if tile.globalConfigBits > 0
            else None
        ),
    ]

    ports = []
    for p in tile.getTileOutputPorts():
        ports.append(cg.Port(p.name, IO.OUTPUT, tile.getCascadeWireCount(p)))
    for p in tile.getTileInputPorts():
        ports.append(cg.Port(p.name, IO.INPUT, tile.getCascadeWireCount(p)))

    for bel in tile.bels:
        for p in bel.externalInput:
            ports.append(cg.Port(p.name, p.ioDirection, p.wireCount))
        for p in bel.externalOutput:
            ports.append(cg.Port(p.name, p.ioDirection, p.wireCount))

    ports.append(cg.Port("UserCLK", IO.INPUT))
    ports.append(cg.Port("UserCLKo", IO.OUTPUT))

    if fabric.configBitMode == ConfigBitMode.FRAME_BASED:
        if tile.globalConfigBits > 0:
            ports.append(cg.Port("FrameData", IO.INPUT, "FrameBitsPerRow - 1"))
            ports.append(cg.Port("FrameData_O", IO.OUTPUT, "FrameBitsPerRow - 1"))
        ports.append(cg.Port("FrameStrobe", IO.INPUT, "MaxFramePerCol - 1"))
        ports.append(cg.Port("FrameStrobe_O", IO.OUTPUT, "MaxFramePerCol - 1"))

    else:
        ports.append(cg.Port("MODE", IO.INPUT))
        ports.append(cg.Port("CONFin", IO.INPUT))
        ports.append(cg.Port("CONFout", IO.OUTPUT))
        ports.append(cg.Port("CLK", IO.INPUT))

    with cg.Module(tile.name, parameters, ports):
        cg.Comment("Signal Creation")

        repeatSet = set()
        for bel in tile.bels:
            for port in (
                bel.inputs + bel.outputs + bel.externalInput + bel.externalOutput
            ):
                sig = f"{bel.prefix}{port.name}"
                if sig in repeatSet:
                    raise ValueError(
                        f"Detected repeat naming of port in tile {tile.name} for bel {bel.name} for port {sig}"
                    )
                cg.Signal(sig)
                repeatSet.add(sig)

        if tile.globalConfigBits > 0:
            cg.Signal("ConfigBits", "NoConfigBits - 1")
