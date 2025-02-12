from pathlib import Path

from FABulous.fabric_cad.define import FASMFeature, FeatureMap
from FABulous.fabric_definition.define import Loc
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.file_parser.file_parser_fasm import parseFASM


def intToBytes(n: int) -> bytes:
    return n.to_bytes((n.bit_length() + 7) // 8, "big")


def intToBitString(n: int, length: int) -> str:
    return bin(n)[2:].zfill(length)


def bitstringToBytes(s):
    return int(s, 2).to_bytes((len(s) + 7) // 8, byteorder="big")


def genBitstream(fabric: Fabric, fasmFile: Path, featureMap: FeatureMap, dest: Path):
    fasm: list[FASMFeature] = parseFASM(fasmFile)

    bitStr = bytes.fromhex("00AAFF01000000010000000000000000FAB0FAB1")

    bitstream: dict[Loc, list] = {}

    for (x, y), _ in fabric.getFlattenFabric():
        bitstream[(x, y)] = [
            b"" for i in range(fabric.maxFramesPerCol * fabric.frameBitsPerRow)
        ]

    for fasmFeature in fasm:
        if fasmFeature.feature is None:
            continue

        if fasmFeature.feature not in featureMap:
            raise ValueError(f"Feature {fasmFeature.feature} not found in feature map")

        featureValue = featureMap[fasmFeature.feature]
        for (frameIdx, bitIdx), bitValue in zip(
            featureValue.bitPosition,
            intToBitString(featureValue.value, len(featureValue.bitPosition)),
            strict=True,
        ):
            if frameIdx is not None and bitIdx is not None:
                bitstream[featureValue.tileLoc][
                    frameIdx * fabric.frameBitsPerRow + bitIdx
                ] = bitValue
            else:
                raise ValueError("Invalid bit position")

        bitstream[featureValue.tileLoc]

    for i in range(fabric.numberOfColumns):
        for j in range(fabric.maxFramesPerCol):
            binTemp = f"{i:0{fabric.frameSelectWidth}b}"[::-1]
            frameSelect = ["0" for _ in range(fabric.frameBitsPerRow)]

            for k in range(-fabric.frameSelectWidth, 0, 1):
                frameSelect[k] = binTemp[k]
            frameSelect[j] = "1"
            frameSelect = "".join(frameSelect)[::-1]
            bitStr += bitstringToBytes(frameSelect)

            # this is likely not correct and the bitStr only consider the column count
            for (x, y), bits in bitstream.items():
                bitStr += bitstringToBytes(
                    bits[j * fabric.frameBitsPerRow : (j + 1) * fabric.frameBitsPerRow]
                )
