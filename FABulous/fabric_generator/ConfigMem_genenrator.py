import csv
from pathlib import Path

from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator


def generateConfigMemInit(
    dst: Path, totalConfigBits: int, frameBitsPerRow: int, maxFramesPerCol: int
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
    bitsLeftToPackInFrames = totalConfigBits

    fieldName = [
        "frame_name",
        "frame_index",
        "bits_used_in_frame",
        "used_bits_mask",
        "ConfigBits_ranges",
    ]

    with open(dst, "w") as f:
        writer = csv.writer(f)
        writer.writerow(fieldName)
        for k in range(maxFramesPerCol):
            entry = []
            # frame0, frame1, ...
            entry.append(f"frame{k}")
            # and the index (0, 1, 2, ...), in case we need
            entry.append(str(k))
            # size of the frame in bits
            if bitsLeftToPackInFrames >= frameBitsPerRow:
                entry.append(str(frameBitsPerRow))
                # generate a string encoding a '1' for each flop used
                frameBitsMask = f"{2**frameBitsPerRow-1:_b}"
                entry.append(frameBitsMask)
                entry.append(
                    f"{bitsLeftToPackInFrames-1}:{bitsLeftToPackInFrames-frameBitsPerRow}"
                )
                bitsLeftToPackInFrames -= frameBitsPerRow
            else:
                entry.append(str(bitsLeftToPackInFrames))
                # generate a string encoding a '1' for each flop used
                # this will allow us to kick out flops in the middle (e.g. for alignment padding)
                frameBitsMask = (2**frameBitsPerRow - 1) - (
                    2 ** (frameBitsPerRow - bitsLeftToPackInFrames) - 1
                )
                frameBitsMask = f"{frameBitsMask:0{frameBitsPerRow+7}_b}"
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


def generateConfigMem(codeGen: CodeGenerator, fabric: Fabric, tile: Tile):
    with codeGen.Module(f"{tile.name}_ConfigMem") as module:
        with module.ParameterRegion() as pr:
            if fabric.maxFramesPerCol > 0:
                maxFramePerCol = pr.Parameter("MaxFramesPerCol", fabric.maxFramesPerCol)
            if fabric.frameBitsPerRow > 0:
                framBitPerRow = pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)
            noConfigBits = pr.Parameter("NoConfigBits", tile.configBits)
            pr.Comment("Emulation parameter")
            emuEn = pr.Parameter("EMULATION_ENABLE", 0)
            emuCfg = pr.Parameter("EMULATION_CONFIG", 0)

        with module.PortRegion() as pr:
            frameData = pr.Port("FrameData", IO.INPUT, framBitPerRow - 1)
            frameStrobe = pr.Port("FrameStrobe", IO.INPUT, maxFramePerCol - 1)
            configBits = pr.Port("ConfigBits", IO.OUTPUT, noConfigBits - 1)
            configBitsN = pr.Port("ConfigBits_N", IO.OUTPUT, noConfigBits - 1)

        totalCount = 0
        with module.LogicRegion() as lr:
            with lr.Generate() as lrGen:
                with lrGen.IfElse(emuEn.eq(0)) as ifElse:
                    with ifElse.TrueRegion() as t:
                        t.Comment("instantiate frame latches")
                        for i in tile.configMems.configMemEntries:
                            counter = 0
                            for k in range(fabric.frameBitsPerRow):
                                if i.usedBitMask[k] == "1":
                                    t.InitModule(
                                        module="LHQD1",
                                        initName=f"Inst_{i.frameName}_bit{fabric.frameBitsPerRow-1-k}",
                                        ports=[
                                            t.ConnectPair(
                                                "D",
                                                frameData[
                                                    fabric.frameBitsPerRow - 1 - k
                                                ],
                                            ),
                                            t.ConnectPair(
                                                "E", frameStrobe[i.frameIndex]
                                            ),
                                            t.ConnectPair(
                                                "Q",
                                                configBits[i.configBitRanges[counter]],
                                            ),
                                            t.ConnectPair(
                                                "QN",
                                                configBitsN[i.configBitRanges[counter]],
                                            ),
                                        ],
                                    )
                                    counter += 1
                                    totalCount += 1
                    with ifElse.FalseRegion() as f:
                        f.Assign(configBits, emuCfg)
                        f.Assign(configBitsN, ~emuCfg)

    assert totalCount == tile.configBits, "Not all config bits are assigned"
