from pathlib import Path

from FABulous.fabric_definition.define import IO, ConfigBitMode
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.file_parser.file_parser_yaml import parseMatrixAsMux


def generateTileSwitchMatrix(fabric: Fabric, tile: Tile, dest: Path):
    if isinstance(tile.switchMatrix, Path):
        tile.switchMatrix = list(
            parseMatrixAsMux(tile.switchMatrix, tile.name).values()
        )

    cg = CodeGenerator(dest)

    noConfigBits = sum([i.configBit for i in tile.switchMatrix])

    ports = []
    for mux in tile.switchMatrix:
        ports.append(cg.Port(mux.output, IO.OUTPUT, mux.width))

    for mux in tile.switchMatrix:
        for i in mux.inputs:
            ports.append(cg.Port(i, IO.INPUT, mux.width))

    if noConfigBits > 0:
        if fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            ports.append(cg.Port("MODE", IO.INPUT, 1))
            ports.append(cg.Port("CONFin", IO.INPUT, 1))
            ports.append(cg.Port("CONFout", IO.OUTPUT, 1))
            ports.append(cg.Port("CLK", IO.INPUT, 1))
        else:
            ports.append(cg.Port("ConfigBits", IO.INPUT, "NoConfigBits-1"))
            ports.append(cg.Port("ConfigBits_N", IO.INPUT, "NoConfigBits-1"))

    with cg.Module(
        f"{tile.name}_switch_matrix",
        [cg.Parameter("NoConfigBits", noConfigBits)],
        ports,
    ):
        cg.Constant("GND0", 0)
        cg.Constant("GND", 0)
        cg.Constant("VCC0", 1)
        cg.Constant("VCC", 1)
        cg.Constant("VDD0", 1)
        cg.Constant("VDD", 1)

        
