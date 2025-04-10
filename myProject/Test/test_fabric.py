import os
from pathlib import Path
from pprint import pprint
from typing import Mapping

import cocotb
from bitarray import bitarray
from bitarray.util import ba2hex, int2ba
from cocotb.runner import get_runner
from cocotb.triggers import Timer

from FABulous.fabric_cad.bitstreamSpec_generator import generateBitsStreamSpec
from FABulous.fabric_cad.define import FASMFeature, FeatureValue
from FABulous.fabric_definition.define import Loc
from FABulous.fabric_generator.define import WriterType
from FABulous.file_parser.file_parser_fasm import parseFASM
from FABulous.file_parser.file_parser_yaml import parseFabricYAML


@cocotb.test
async def adder_basic_test(dut):
    await Timer(1)
    dut.Tile_X3Y1_E_in.value = 16
    dut.Tile_X0Y1_W_in.value = 8
    await Timer(1)
    await Timer(1)
    print("X1Y1 data in")
    print(dut.PE_Tile_X1Y1.in0.value)
    print(dut.PE_Tile_X1Y1.in1.value)
    print(dut.PE_Tile_X1Y1.in2.value)
    print(dut.PE_Tile_X1Y1.in3.value)
    print()
    print("X1Y1 config bits")
    print(dut.PE_Tile_X1Y1.ConfigBits.value)
    print("X1Y1 ALU")
    print(dut.PE_Tile_X1Y1.data_in1.value)
    print(dut.PE_Tile_X1Y1.data_in2.value)
    print(dut.PE_Tile_X1Y1.data_out.value)
    print()
    print("X1Y1 data out")
    print(dut.PE_Tile_X1Y1.out0.value)
    print(dut.PE_Tile_X1Y1.out1.value)
    print(dut.PE_Tile_X1Y1.out2.value)
    print(dut.PE_Tile_X1Y1.out3.value)
    print()
    print(dut.PE_Tile_X1Y1.Inst_PE_switch_matrix.in2.value)
    print(dut.PE_Tile_X1Y1.Inst_PE_switch_matrix.RES_reg_out.value)
    print(dut.PE_Tile_X1Y1.Inst_PE_switch_matrix.data_out.value)
    print(dut.PE_Tile_X1Y1.Inst_PE_switch_matrix.ConfigBits.value)
    print(dut.PE_Tile_X1Y1.Inst_PE_switch_matrix.out0.value)
    print()
    print("X1Y3 data out")
    print(dut.Tile_X1Y0_S_out.value)


def test_tile_runner():
    """Simulate the adder example using the Python runner.

    This file can be run directly or via pytest discovery.
    """
    projectLang = WriterType[os.getenv("FAB_PROJ_LANG", "verilog").upper()]
    sim = os.getenv("SIMULATOR", "icarus")
    # projectPath = Path(os.getenv("my_FAB_PROJECT", ".")) / "myProject"
    projectPath = Path(os.getenv("my_FAB_ROOT", ".")) / "myProject"
    match projectLang:
        case WriterType.VERILOG:
            sources = list(projectPath.glob("Tile/*/*.v"))
            sources.extend(list(projectPath.glob("Fabric/*.v")))
        case WriterType.VHDL:
            sources = list(projectPath.glob("Tile/*/*.vhdl"))
            sources.extend(list(projectPath.glob("Fabric/*.vhdl")))
        case WriterType.SYSTEM_VERILOG:
            sources = list(projectPath.glob("Tile/*/*.sv"))
            sources.extend(list(projectPath.glob("Fabric/*.sv")))
        case _:
            raise ValueError(f"Unknown project language: {projectLang}")
    sources = list(set(sources))
    runner = get_runner(sim)
    fasm: list[FASMFeature] = parseFASM(projectPath / "user_design/router_test.fasm")

    fabric = parseFabricYAML(projectPath / "fabric.yaml")
    spec = generateBitsStreamSpec(fabric)
    with open(projectPath / ".FABulous/spec.txt", "w") as f:
        # Write the bitstream specification in a human-readable format
        for feature, featureValue in spec.items():
            tileLoc = featureValue.tileLoc
            bitPosition = featureValue.bitPosition
            value = featureValue.value
            f.write(f"Feature: {feature}\n")
            f.write(f"  Location: X{tileLoc[0]}Y{tileLoc[1]}\n")
            f.write(f"  Bit positions: {bitPosition}\n")
            f.write(f"  Value: {value}\n")
            f.write("\n")
    featureSet = set()
    # TODO Missing internal connection pip
    for f in fasm:
        if f.feature is None:
            continue
        if f.feature not in spec:
            continue
        featVal = spec[f.feature]
        if featVal.value is None:
            featureSet.add(FeatureValue(featVal.tileLoc, featVal.bitPosition, f.value))
        else:
            featureSet.add(spec[f.feature])

    bitStreamFrameBitIdxMap: Mapping[Loc, list[bitarray]] = {}
    for (x, y), _ in fabric:
        bitStreamFrameBitIdxMap[(x, y)] = [
            bitarray(fabric.frameBitsPerRow) for _ in range(fabric.maxFramesPerCol)
        ]

    for f in featureSet:
        value = int2ba(f.value, len(f.bitPosition))
        value.reverse()
        print(f, value)
        for i in range(len(f.bitPosition)):
            frameIdx, bitIdx = f.bitPosition[i]
            bitIdx = fabric.frameBitsPerRow - bitIdx - 1
            if frameIdx is None or bitIdx is None:
                continue
            bitStreamFrameBitIdxMap[f.tileLoc][frameIdx][bitIdx] = value[i]
    pprint(bitStreamFrameBitIdxMap[(1, 1)])
    bitStreamLocMap = {}
    for i in bitStreamFrameBitIdxMap:
        tmp = bitarray()
        for j in bitStreamFrameBitIdxMap[i]:
            tmp += j
        bitStreamLocMap[i] = tmp

    bitstream = bitarray()
    for x in range(fabric.height):
        for y in range(fabric.width):
            bitstream += bitStreamLocMap[(x, y)]

    # buildDir = Path(os.getenv("my_FAB_PROJECT", ".")) / "myProject/Test"
    buildDir = projectPath / "Test"

    with open(buildDir / "bitstream.hex", "w") as f:
        for x in range(fabric.height):
            for y in range(fabric.width):
                f.write(f"{ba2hex(bitStreamLocMap[(x, y)])} //X{x}Y{y}\n")

    parameters = {
        "EMULATION_ENABLE": 1,
        "EMULATION_CONFIG": f'"{str(buildDir / "bitstream.hex")}"',
    }

    runner.build(
        sources=sources,
        hdl_toplevel="hycube",
        always=True,
        build_dir=buildDir,
        parameters=parameters,
    )
    runner.test(
        hdl_toplevel="hycube",
        test_module="test_fabric",
        parameters=parameters,
    )


if __name__ == "__main__":
    test_tile_runner()
