from pathlib import Path

from loguru import logger

from FABulous.fabric_definition.ConfigMem import ConfigMem
from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.file_parser.file_parser_csv import parseConfigMem


def generateConfigMem(self, fabric: Fabric, tile: Tile, configMemCSV: Path, dest: Path):
    configMemList: list[ConfigMem] = []

    if configMemCSV.exists():
        if tile.globalConfigBits <= 0:
            logger.warning(
                f"Found bitstram mapping file {tile.name}_configMem.csv for tile {tile.name}, but no global config bits are defined"
            )
        else:
            logger.info(
                f"Found bitstream mapping file {tile.name}_configMem.csv for tile {tile.name}"
            )
        logger.info(f"Parsing {tile.name}_configMem.csv")
        configMemList = parseConfigMem(
            configMemCSV,
            self.fabric.maxFramesPerCol,
            self.fabric.frameBitsPerRow,
            tile.globalConfigBits,
        )
    elif tile.globalConfigBits > 0:
        logger.info(f"{tile.name}_configMem.csv does not exist")
        logger.info(f"Generating a default configMem for {tile.name}")
        self.generateConfigMemInit(configMemCSV, tile.globalConfigBits)
        logger.info(f"Parsing {tile.name}_configMem.csv")
        configMemList = parseConfigMem(
            configMemCSV,
            self.fabric.maxFramesPerCol,
            self.fabric.frameBitsPerRow,
            tile.globalConfigBits,
        )
    else:
        logger.info(
            f"No config bits defined and no bitstream mapping file provided for tile {tile.name}"
        )
        return

    cg = CodeGenerator(dest)

    with cg.Module(
        f"{tile.name}_ConfigMem",
    ) as module:
        with module.ParameterRegion() as pr:
            if self.fabric.maxFramesPerCol > 0:
                pr.Parameter("MaxFramesPerCol", self.fabric.maxFramesPerCol)
            if self.fabric.frameBitsPerRow > 0:
                pr.Parameter("FrameBitsPerRow", self.fabric.frameBitsPerRow)

        with module.PortRegion() as pr:
            pr.Port("FrameData", IO.INPUT, f"{self.fabric.frameBitsPerRow} - 1")
            pr.Port("FrameStrobe", IO.INPUT, f"{self.fabric.maxFramesPerCol} - 1")
            pr.Port("ConfigBits", IO.OUTPUT, "NoConfigBits - 1")
            pr.Port("ConfigBits_N", IO.OUTPUT, "NoConfigBits - 1")

        with module.LogicRegion() as lr:

            with lr.IfDef("EMULATION") as lrIfDef:
                for i in configMemList:
                    counter = 0
                    for k in range(self.fabric.frameBitsPerRow):
                        if i.usedBitMask[k] == "1":
                            lrIfDef.Assign(
                                dst=f"ConfigBits[{i.configBitRanges[counter]}]",
                                src=f"Emulate_Bitstream[{i.frameIndex*self.fabric.frameBitsPerRow + (self.fabric.frameBitsPerRow-1-k)}]",
                            )
                        counter += 1

            lr.Comment("instantiate frame latches")

            for i in configMemList:
                counter = 0
                for k in range(self.fabric.frameBitsPerRow):
                    if i.usedBitMask[k] == "1":
                        lr.InitModule(
                            module="LHQD1",
                            initName=f"Inst_{i.frameName}_bit{self.fabric.frameBitsPerRow-1-k}",
                            ports=[
                                lr.ConnectPair(
                                    "D", f"FrameData[{self.fabric.frameBitsPerRow-1-k}]"
                                ),
                                lr.ConnectPair("E", f"FrameStrobe[{i.frameIndex}]"),
                                lr.ConnectPair(
                                    "Q", f"ConfigBits[{i.configBitRanges[counter]}]"
                                ),
                                lr.ConnectPair(
                                    "QN", f"ConfigBits_N[{i.configBitRanges[counter]}]"
                                ),
                            ],
                        )
                        counter += 1
