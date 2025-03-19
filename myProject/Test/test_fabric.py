import os
from pprint import pprint
import random
import sys
from pathlib import Path

import cocotb
from cocotb.triggers import Timer
from cocotb.runner import get_runner

from FABulous.fabric_cad.bit_gen import Fabric
from FABulous.fabric_cad.bitstreamSpec_generator import generateBitsStreamSpec
from FABulous.fabric_cad.define import FASMFeature, FeatureValue
from FABulous.fabric_generator.define import WriterType
from FABulous.file_parser.file_parser_fasm import parseFASM
from FABulous.file_parser.file_parser_yaml import parseFabricYAML


@cocotb.test
async def adder_basic_test(dut):
    """Test for 5 + 10"""

    A = 5
    B = 10

    dut.A.value = A
    dut.B.value = B

    await Timer(2, units="ns")

    assert dut.X.value == adder_model(
        A, B
    ), f"Adder result is incorrect: {dut.X.value} != 15"


def test_tile_runner():
    """Simulate the adder example using the Python runner.

    This file can be run directly or via pytest discovery.
    """
    projectLang = WriterType[os.getenv("FAB_PROJ_LANG", "verilog").upper()]
    sim = os.getenv("SIMULATOR", "icarus")
    projectPath = Path(os.getenv("my_FAB_PROJECT", ".")) / "myProject"

    match projectLang:
        case WriterType.VERILOG:
            sources = list(projectPath.glob("Tile/PE/*.v"))
            sources.extend(list(projectPath.glob("Fabric/*.v")))
        case WriterType.VHDL:
            sources = list(projectPath.glob("Tile/**/*.vhdl"))
            sources.extend(list(projectPath.glob("Fabric/*.vhdl")))
        case WriterType.SYSTEM_VERILOG:
            sources = list(projectPath.glob("Tile/**/*.sv"))
            sources.extend(list(projectPath.glob("Fabric/*.sv")))
        case _:
            raise ValueError(f"Unknown project language: {projectLang}")
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
            print(f.feature)
            continue
        featVal = spec[f.feature]
        if featVal.value is None:
            featureSet.add(FeatureValue(featVal.tileLoc, featVal.bitPosition, f.value))
        else:
            featureSet.add(spec[f.feature])

    pprint(featureSet)

    # runner.build(
    #     sources=sources,
    #     hdl_toplevel="hycube",
    #     always=True,
    #     build_dir=Path(os.getenv("my_FAB_PROJECT", ".")) / "myProject/Test",
    # )
    # runner.test(
    #     hdl_toplevel="hycube", test_module="test_fabric"
    # )

if __name__ == "__main__":
    test_tile_runner()
