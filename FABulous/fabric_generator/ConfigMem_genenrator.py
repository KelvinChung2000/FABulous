import csv
from pathlib import Path

from loguru import logger

from FABulous.fabric_definition.ConfigMem import ConfigMem
from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.file_parser.file_parser_csv import parseConfigMem


def generateConfigMemInit(
    fabric: Fabric, file: Path, globalConfigBitsCounter: int
) -> None:
    """This function is used to generate the config memory initialization file for a
    given amount of configuration bits. The amount of configuration bits is determined
    by the `frameBitsPerRow` attribute of the fabric. The function will pack the
    configuration bit from the highest to the lowest bit in the config memory. I. e. if
    there are 100 configuration bits, with 32 frame bits per row, the function will pack
    from bit 99 starting from bit 31 of frame 0 to bit 28 of frame 3.

    Parameters
    ----------
    file : str
        The output file of the config memory initialization file.
    globalConfigBitsCounter : int
        The number of global config bits of the tile.
    """
    bitsLeftToPackInFrames = globalConfigBitsCounter

    fieldName = [
        "frame_name",
        "frame_index",
        "bits_used_in_frame",
        "used_bits_mask",
        "ConfigBits_ranges",
    ]

    frameBitPerRow = fabric.frameBitsPerRow
    with open(file, "w") as f:
        writer = csv.writer(f)
        writer.writerow(fieldName)
        for k in range(fabric.maxFramesPerCol):
            entry = []
            # frame0, frame1, ...
            entry.append(f"frame{k}")
            # and the index (0, 1, 2, ...), in case we need
            entry.append(str(k))
            # size of the frame in bits
            if bitsLeftToPackInFrames >= frameBitPerRow:
                entry.append(str(frameBitPerRow))
                # generate a string encoding a '1' for each flop used
                frameBitsMask = f"{2**frameBitPerRow-1:_b}"
                entry.append(frameBitsMask)
                entry.append(
                    f"{bitsLeftToPackInFrames-1}:{bitsLeftToPackInFrames-frameBitPerRow}"
                )
                bitsLeftToPackInFrames -= frameBitPerRow
            else:
                entry.append(str(bitsLeftToPackInFrames))
                # generate a string encoding a '1' for each flop used
                # this will allow us to kick out flops in the middle (e.g. for alignment padding)
                frameBitsMask = (2**frameBitPerRow - 1) - (
                    2 ** (frameBitPerRow - bitsLeftToPackInFrames) - 1
                )
                frameBitsMask = f"{frameBitsMask:0{frameBitPerRow+7}_b}"
                entry.append(frameBitsMask)
                if bitsLeftToPackInFrames > 0:
                    entry.append(f"{bitsLeftToPackInFrames-1}:0")
                else:
                    entry.append("# NULL")
                # will have to be 0 if already 0 or if we just allocate the last bits
                bitsLeftToPackInFrames = 0
            # The mapping into frames is described as a list of index ranges applied to the ConfigBits vector
            # use '2' for a single bit; '5:0' for a downto range; multiple ranges can be specified in optional consecutive comma separated fields get concatenated)
            # default is counting top down

            # write the entry to the file
            writer.writerow(entry)


def generateConfigMem(
    codeGen: CodeGenerator, fabric: Fabric, tile: Tile, configMemCSV: Path
):
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
            fabric.maxFramesPerCol,
            fabric.frameBitsPerRow,
            tile.globalConfigBits,
        )
    elif tile.globalConfigBits > 0:
        logger.info(f"{tile.name}_configMem.csv does not exist")
        logger.info(f"Generating a default configMem for {tile.name}")
        generateConfigMemInit(fabric, configMemCSV, tile.globalConfigBits)
        logger.info(f"Parsing {tile.name}_configMem.csv")
        configMemList = parseConfigMem(
            configMemCSV,
            fabric.maxFramesPerCol,
            fabric.frameBitsPerRow,
            tile.globalConfigBits,
        )
    else:
        logger.info(
            f"No config bits defined and no bitstream mapping file provided for tile {tile.name}"
        )
        return

    with codeGen.Module(
        f"{tile.name}_ConfigMem",
    ) as module:
        with module.ParameterRegion() as pr:
            if fabric.maxFramesPerCol > 0:
                maxFramePerCol = pr.Parameter("MaxFramesPerCol", fabric.maxFramesPerCol)
            if fabric.frameBitsPerRow > 0:
                framBitPerRow = pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)
            if tile.globalConfigBits > 0:
                noConfigBits = pr.Parameter("NoConfigBits", tile.globalConfigBits)

        with module.PortRegion() as pr:
            frameData = pr.Port("FrameData", IO.INPUT, framBitPerRow - 1)
            frameStrobe = pr.Port("FrameStrobe", IO.INPUT, maxFramePerCol - 1)
            configBits = pr.Port("ConfigBits", IO.OUTPUT, noConfigBits - 1)
            configBitsN = pr.Port("ConfigBits_N", IO.OUTPUT, noConfigBits - 1)

        with module.LogicRegion() as lr:

            # with lr.IfDef("EMULATION") as lrIfDef:
            #     for i in configMemList:
            #         counter = 0
            #         for k in range(fabric.frameBitsPerRow):
            #             if i.usedBitMask[k] == "1":
            #                 lrIfDef.Assign(
            #                     configBits[i.configBitRanges[counter]],
            #                     src=f"Emulate_Bitstream[{i.frameIndex*self.fabric.frameBitsPerRow + (self.fabric.frameBitsPerRow-1-k)}]",
            #                 )
            #             counter += 1

            lr.Comment("instantiate frame latches")

            for i in configMemList:
                counter = 0
                for k in range(fabric.frameBitsPerRow):
                    if i.usedBitMask[k] == "1":
                        lr.InitModule(
                            module="LHQD1",
                            initName=f"Inst_{i.frameName}_bit{fabric.frameBitsPerRow-1-k}",
                            ports=[
                                lr.ConnectPair(
                                    "D", frameData[fabric.frameBitsPerRow - 1 - k]
                                ),
                                lr.ConnectPair("E", frameStrobe[i.frameIndex]),
                                lr.ConnectPair(
                                    "Q", configBits[i.configBitRanges[counter]]
                                ),
                                lr.ConnectPair(
                                    "QN", configBitsN[i.configBitRanges[counter]]
                                ),
                            ],
                        )
                        counter += 1
