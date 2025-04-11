import csv
from pathlib import Path

from bitarray import bitarray
from hdlgen.code_gen import CodeGenerator

from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile


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
        bits = bitarray(frameBitsPerRow * maxFramesPerCol)
        bits[:totalConfigBits] = 1
        totalConfigBits -= 1
        count = 0
        for k in range(maxFramesPerCol):
            entry = {}
            # frame0, frame1, ...
            entry["frame_name"] = f"frame{k}"
            # and the index (0, 1, 2, ...), in case we need
            entry["frame_index"] = str(k)
            slice = bits[count : count + frameBitsPerRow]
            entry["bits_used_in_frame"] = slice.count(1)
            entry["used_bits_mask"] = slice.to01()
            if slice.count(1) == 0:
                entry["ConfigBits_ranges"] = "# NULL"
            else:
                entry["ConfigBits_ranges"] = (
                    f"{totalConfigBits}:{max(totalConfigBits-frameBitsPerRow+1, 0)}"
                )
            count += frameBitsPerRow
            totalConfigBits -= frameBitsPerRow

            writer.writerow([entry[field] for field in fieldName])


def generateConfigMem(codeGen: CodeGenerator, fabric: Fabric, tile: Tile):
    with codeGen.Module(f"{tile.name}_ConfigMem") as module:
        with module.ParameterRegion() as pr:
            if fabric.maxFramesPerCol > 0:
                maxFramePerCol = pr.Parameter("MaxFramesPerCol", fabric.maxFramesPerCol)
            if fabric.frameBitsPerRow > 0:
                frameBitPerRow = pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)
            noConfigBits = pr.Parameter("NoConfigBits", tile.configBits)
            pr.Comment("Emulation parameter")
            emuEn = pr.Parameter("EMULATION_ENABLE", 0)
            emuCfg = pr.Parameter("EMULATION_CONFIG", 0)
            xCord = pr.Parameter("X_CORD", -1)
            yCord = pr.Parameter("Y_CORD", -1)

        with module.PortRegion() as pr:
            frameData = pr.Port("FrameData", IO.INPUT, frameBitPerRow - 1)
            frameStrobe = pr.Port("FrameStrobe", IO.INPUT, maxFramePerCol - 1)
            configBits = pr.Port("ConfigBits", IO.OUTPUT, noConfigBits - 1)
            configBitsN = pr.Port("ConfigBits_N", IO.OUTPUT, noConfigBits - 1)

        if tile.configBits == 0:
            return
        with module.LogicRegion() as lr:
            lr.NewLine()
            with lr.Generate() as lrGen:
                with lrGen.IfElse(emuEn) as ifElse:
                    with ifElse.TrueRegion() as t:
                        totalBitAvailable = (
                            fabric.frameBitsPerRow * fabric.maxFramesPerCol
                        )
                        cfg = t.ReadMem(
                            emuCfg,
                            "cfg",
                            totalBitAvailable,
                            fabric.height * fabric.width,
                        )
                        tileConf = t.Signal("tileConf", totalBitAvailable)
                        t.Assign(tileConf, cfg[yCord * fabric.width + xCord])
                        for i in range(tile.configBits):
                            frameIdx, bitIdx = tile.configMems[i]
                            t.Comment(
                                f"config bit {i} at frame {frameIdx} bit {bitIdx}"
                            )
                            bitIdx = fabric.frameBitsPerRow - bitIdx - 1
                            addr = (
                                totalBitAvailable
                                - (frameIdx * fabric.maxFramesPerCol + bitIdx)
                                - 1
                            )
                            t.Assign(configBits[i], tileConf[addr])
                            t.Assign(configBitsN[i], ~tileConf[addr])
                    with ifElse.FalseRegion() as f:
                        f.Comment("instantiate frame latches")
                        for i in range(tile.configBits):
                            frameIdx, bitIdx = tile.configMems[i]
                            frameName = tile.configMems.configMemEntries[
                                frameIdx
                            ].frameName
                            f.InitModule(
                                module="LHQD1",
                                initName=f"Inst_{frameName}_bit{bitIdx}",
                                ports=[
                                    f.ConnectPair(
                                        "D",
                                        frameData[bitIdx],
                                    ),
                                    f.ConnectPair("E", frameStrobe[frameIdx]),
                                    f.ConnectPair(
                                        "Q",
                                        configBits[i],
                                    ),
                                    f.ConnectPair(
                                        "QN",
                                        configBitsN[i],
                                    ),
                                ],
                            )
