import os
import random
import sys
from pathlib import Path

import cocotb
from cocotb.triggers import Timer
from cocotb.runner import get_runner

from FABulous.fabric_cad.bit_gen import Fabric
from FABulous.fabric_generator.define import WriterType



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


@cocotb.test
async def adder_randomised_test(dut):
    """Test for adding 2 random numbers multiple times"""

    for i in range(10):
        A = random.randint(0, 15)
        await Timer(2, units="ns")

        dut.A.value = A
        dut.B.value = B

        await Timer(2, unit="ns")

        assert dut.X.value == adder_model(
            A, B
        ), f"Randomised test failed with: {dut.A.value} + {dut.B.value} = {dut.X.value}"


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
        case WriterType.VHDL:
            sources = list(projectPath.glob("Tile/**/*.vhdl"))
        case WriterType.SYSTEM_VERILOG:
            sources = list(projectPath.glob("Tile/**/*.sv"))
        case _:
            raise ValueError(f"Unknown project language: {projectLang}")
    sources.append(Path("/home/kelvin/FABulous_fork/myProject/Fabric/models_pack.v"))
    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel="PE",
        always=True,
        build_dir=Path(os.getenv("my_FAB_PROJECT", ".")) / "myProject/Test",
    )
    runner.test(
        hdl_toplevel="PE", test_module="test_tile"
    )

if __name__ == "__main__":
    test_tile_runner()
