import os
from pathlib import Path
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
    dut.Tile_X3Y1_E_in.value = 10
    dut.Tile_X0Y1_W_in.value = 20
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
    print(dut.Tile_X1Y1_out0.value)
    print(dut.Tile_X1Y1_out1.value)
    print(dut.Tile_X1Y1_out2.value)
    print(dut.Tile_X1Y1_out3.value)
    print()
    print("X1Y0 data out")
    print(dut.Tile_X1Y0_S_out.value)



def test_tile_runner():
    """Simulate the adder example using the Python runner.

    This file can be run directly or via pytest discovery.
    """
    projectLang = WriterType[os.getenv("FAB_PROJ_LANG", "verilog").upper()]
    sim = os.getenv("SIMULATOR", "icarus")
    # projectPath = Path(os.getenv("my_FAB_PROJECT", ".")) / "myProject"
    projectPath = Path("/home/kelvin/FABulous_fork/myProject")
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
    fasm: list[FASMFeature] = parseFASM(
        Path("/home/kelvin/FABulous_fork/myProject/user_design/router_test.fasm")
    )

    fabric = parseFabricYAML(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))
    spec = generateBitsStreamSpec(fabric)
    featureSet = set()
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

    bitStreamMap: Mapping[Loc, list[bitarray]] = {}
    for (x, y), _ in fabric:
        bitStreamMap[(x, y)] = [
            bitarray(fabric.frameBitsPerRow) for _ in range(fabric.maxFramesPerCol)
        ]

    for f in featureSet:
        value = int2ba(f.value, len(f.bitPosition))
        for i in range(len(f.bitPosition)):
            frameIdx, bitIdx = f.bitPosition[i]
            if frameIdx is None or bitIdx is None:
                continue
            bitStreamMap[f.tileLoc][frameIdx][bitIdx] = value[i]

    bitStreamLocMap = {}
    for i in bitStreamMap:
        tmp = bitarray()
        for j in bitStreamMap[i]:
            tmp += j
        bitStreamLocMap[i] = tmp

    bitstream = bitarray()
    for x in range(fabric.numberOfRows):
        for y in range(fabric.numberOfColumns):
            bitstream += bitStreamLocMap[(x, y)]

    # buildDir = Path(os.getenv("my_FAB_PROJECT", ".")) / "myProject/Test"
    buildDir = projectPath / "Test"

    with open(buildDir / "bitstream.hex", "w") as f:
        for x in range(fabric.numberOfRows):
            for y in range(fabric.numberOfColumns):
                f.write(f"{ba2hex(bitStreamLocMap[(x, y)])} //X{x}Y{y}\n")

    parameters = {
        "EMULATION_ENABLE": 1,
        "EMULATION_CONFIG": f"\"{str(buildDir / "bitstream.hex")}\"",
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
