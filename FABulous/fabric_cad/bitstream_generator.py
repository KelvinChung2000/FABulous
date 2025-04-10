import csv
import pprint
from pathlib import Path

from FABulous.fabric_cad.bitstreamSpec_generator import generateBitsStreamSpec
from FABulous.fabric_cad.define import FASMFeature, FeatureMap
from FABulous.fabric_definition.define import Loc
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.file_parser.file_parser_csv import parseFabricCSV
from FABulous.file_parser.file_parser_fasm import parseFASM


def intToBytes(n: int) -> bytes:
    return n.to_bytes((n.bit_length() + 7) // 8, "big")


def intToBitString(n: int, length: int) -> str:
    return bin(n)[2:].zfill(length)


def bitstringToBytes(s):
    return int(s, 2).to_bytes((len(s) + 7) // 8, byteorder="big")


def genBitstream(fabric: Fabric, fasmFile: Path, featureMap: FeatureMap, dest: Path):
    fasm: list[FASMFeature] = parseFASM(fasmFile)
    bitstream: dict[Loc, list] = {}
    for (x, y), _ in fabric.getFlattenFabric():
        bitstream[(x, y)] = [
            b"" for _ in range(fabric.maxFramesPerCol * fabric.frameBitsPerRow)
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
                # print(fasmFeature.feature)
                # print(featureValue.tileLoc)
                # print(frameIdx * fabric.frameBitsPerRow + bitIdx)
                # print(frameIdx, bitIdx)
                bitstream[featureValue.tileLoc][
                    frameIdx * fabric.frameBitsPerRow + bitIdx
                ] = bitValue

    # output the bitstream
    bitStr = bytes.fromhex("00AAFF01000000010000000000000000FAB0FAB1")
    for i in range(fabric.width):
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

    with open(dest, "wb") as f:
        f.write(bitStr)

    sorted_bitstream_keys = sorted(bitstream.keys(), key=lambda loc: (loc[0], -loc[1]))
    sorted_bitstream = {key: bitstream[key] for key in sorted_bitstream_keys}

    with open(dest.with_suffix(".csv"), "w", newline="") as csvfile:
        csvWriter = csv.writer(csvfile)
        for loc, bits in sorted_bitstream.items():
            csvWriter.writerow([loc[0], loc[1]])
            partitioned_bits = [
                "".join(bits[i : i + fabric.frameBitsPerRow])
                for i in range(0, len(bits), fabric.frameBitsPerRow)
            ]
            for index, partition in enumerate(partitioned_bits):
                csvWriter.writerow([index, partition])


if __name__ == "__main__":
    fabric = parseFabricCSV(Path("/home/kelvin/FABulous_fork/demo/fabric.csv"))
    spec = generateBitsStreamSpec(fabric)
    with open(Path("./bitstreamTest/test.txt"), "w") as f:
        f.write("Generated Specification:\n")
        pp = pprint.PrettyPrinter(indent=4)
        f.write(pp.pformat(spec))
    genBitstream(
        fabric,
        Path("/home/kelvin/FABulous_fork/demo/Test/build/sequential_16bit_en.fasm"),
        spec,
        Path("./bitstreamTest/test.bin"),
    )
