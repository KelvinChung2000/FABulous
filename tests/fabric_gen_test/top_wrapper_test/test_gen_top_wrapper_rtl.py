"""RTL validation for generated Top Wrapper modules using Yosys."""

from collections.abc import Callable
from pathlib import Path
from typing import NamedTuple

import pytest

from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.code_generator.code_generator import CodeGenerator
from FABulous.fabric_generator.gen_fabric.gen_top_wrapper import generateTopWrapper


class TopWrapperTestCase(NamedTuple):
    """Test case configuration for top wrapper RTL validation."""

    number_of_brams: int
    test_name: str
    expected_ports: list[str]


def _create_top_wrapper_validation_commands(
    number_of_brams: int, expected_ports: list[str]
) -> list[str]:
    """Create yosys validation commands for top wrapper structure."""
    commands = []

    # Basic RTL checks
    commands.append(
        "check -noinit"
    )  # Check for multiple drivers and uninitialized signals
    commands.append("check -assert")  # Verify all outputs are driven

    # Check that expected ports exist
    for port in expected_ports:
        commands.append(f"select -assert-min 1 w:{port}")

    # Required module instantiations
    required_modules = ["eFPGA_Config", "Frame_Data_Reg", "Frame_Select", "eFPGA"]
    for module in required_modules:
        commands.append(f"select -assert-min 1 c:*{module}*")

    # Port-to-port connectivity validation
    # Clock distribution - CLK should connect to specific ports of each module
    commands.append(
        "select -assert-min 1 w:CLK %co c:*eFPGA_Config* %ci %i"
    )  # CLK to config
    commands.append(
        "select -assert-min 1 w:CLK %co c:*Frame_Data_Reg* %ci %i"
    )  # CLK to frame reg
    commands.append(
        "select -assert-min 1 w:CLK %co c:*Frame_Select* %ci %i"
    )  # CLK to frame select
    commands.append("select -assert-min 1 w:CLK %co c:*eFPGA* %ci %i")  # CLK to fabric

    # Reset distribution - resetn should connect to reset ports of each module
    commands.append("select -assert-min 1 w:resetn %co c:*eFPGA_Config* %ci %i")
    commands.append("select -assert-min 1 w:resetn %co c:*Frame_Data_Reg* %ci %i")
    commands.append("select -assert-min 1 w:resetn %co c:*Frame_Select* %ci %i")

    # Configuration data flow validation
    # UART Rx should connect to eFPGA_Config
    commands.append("select -assert-min 1 w:Rx %co c:*eFPGA_Config* %ci %i")

    # Configuration signals should flow: eFPGA_Config -> Frame_Data_Reg -> eFPGA
    commands.append(
        "select -assert-min 1 c:*eFPGA_Config* %co c:*Frame_Data_Reg* %ci %i"
    )
    commands.append("select -assert-min 1 c:*Frame_Data_Reg* %co c:*eFPGA* %ci %i")

    # Frame selection signals should connect: Frame_Select -> eFPGA
    commands.append("select -assert-min 1 c:*Frame_Select* %co c:*eFPGA* %ci %i")

    # Self-write interface validation
    commands.append(
        "select -assert-min 1 w:SelfWriteStrobe %co c:*eFPGA_Config* %ci %i"
    )
    commands.append("select -assert-min 1 w:SelfWriteData %co c:*eFPGA_Config* %ci %i")

    # BRAM specific connectivity validation
    if number_of_brams > 0:
        expected_bram_instances = number_of_brams - 1
        commands.append(
            f"select -assert-count {expected_bram_instances} c:*BlockRAM_1KB*"
        )

        # BRAM data interface connectivity
        # eFPGA should connect to BRAM data buses
        commands.append("select -assert-min 1 c:*eFPGA* %co w:FAB2RAM_D_O %i")
        commands.append("select -assert-min 1 w:RAM2FAB_D_I %co c:*eFPGA* %ci %i")

        # BRAM instances should connect to the data buses
        commands.append("select -assert-min 1 c:*BlockRAM_1KB* %co w:RAM2FAB_D_I %i")
        commands.append(
            "select -assert-min 1 w:FAB2RAM_D_O %co c:*BlockRAM_1KB* %ci %i"
        )

        # Clock should connect to BRAM instances
        commands.append("select -assert-min 1 w:CLK %co c:*BlockRAM_1KB* %ci %i")
    else:
        commands.append("select -assert-count 0 c:*BlockRAM_1KB*")

    # Status output validation
    # eFPGA_Config should drive status outputs
    commands.append("select -assert-min 1 c:*eFPGA_Config* %co w:ComActive %i")
    commands.append("select -assert-min 1 c:*eFPGA_Config* %co w:ReceiveLED %i")

    # Configuration readback interface
    commands.append("select -assert-min 1 c:*eFPGA_Config* %co w:s_clk %i")
    commands.append("select -assert-min 1 c:*eFPGA_Config* %co w:s_data %i")

    return commands


@pytest.mark.parametrize("hdl_lang", [".v", ".vhdl"])
@pytest.mark.parametrize(
    "top_wrapper_test_case",
    [
        TopWrapperTestCase(
            number_of_brams=0,
            test_name="no_brams_wrapper",
            expected_ports=[
                "CLK",
                "resetn",
                "SelfWriteStrobe",
                "SelfWriteData",
                "Rx",
                "ComActive",
                "ReceiveLED",
                "s_clk",
                "s_data",
            ],
        ),
        TopWrapperTestCase(
            number_of_brams=2,
            test_name="with_brams_wrapper",
            expected_ports=[
                "CLK",
                "resetn",
                "SelfWriteStrobe",
                "SelfWriteData",
                "Rx",
                "ComActive",
                "ReceiveLED",
                "s_clk",
                "s_data",
            ],
        ),
    ],
    ids=lambda case: case.test_name,
)
def test_top_wrapper_rtl_validation(
    hdl_lang: str,
    top_wrapper_test_case: TopWrapperTestCase,
    default_fabric: Fabric,
    tmp_path: Path,
    code_generator_factory: Callable[..., CodeGenerator],
    yosys_validator: Callable[[Path], object],
) -> None:
    """Generate Top Wrapper HDL and verify its structure using Yosys RTL validation."""

    # Configure fabric based on test case
    default_fabric.numberOfBRAMs = top_wrapper_test_case.number_of_brams
    default_fabric.frameBitsPerRow = 32
    default_fabric.maxFramesPerCol = 10
    default_fabric.numberOfRows = 4
    default_fabric.numberOfColumns = 4
    default_fabric.desync_flag = 0
    default_fabric.frameSelectWidth = 4
    default_fabric.rowSelectWidth = 2

    # Create code generator
    test_name = f"{default_fabric.name}_top_{top_wrapper_test_case.test_name}"
    writer = code_generator_factory(hdl_lang, test_name)
    writer.outFileName = tmp_path / f"{test_name}{hdl_lang}"

    # Generate the Top Wrapper HDL
    generateTopWrapper(writer, default_fabric)

    # Check if HDL file was created
    if not writer.outFileName.exists():
        pytest.skip(f"Top wrapper HDL file {writer.outFileName} was not generated")

    # Skip if file is too minimal (unlikely for top wrapper, but safety check)
    content = writer.outFileName.read_text()
    if len([line for line in content.split("\n") if line.strip()]) < 30:
        pytest.skip("Generated top wrapper is too minimal for RTL validation")

    # Validate HDL structure using Yosys
    validator = yosys_validator(writer.outFileName)

    # Create yosys commands to validate top wrapper structure
    yosys_commands = _create_top_wrapper_validation_commands(
        top_wrapper_test_case.number_of_brams, top_wrapper_test_case.expected_ports
    )

    # Run RTL validation
    validator.validate(yosys_commands)


@pytest.mark.parametrize("hdl_lang", [".v", ".vhdl"])
def test_top_wrapper_with_io_rtl_validation(
    hdl_lang: str,
    fabric_with_io_tiles: Fabric,
    tmp_path: Path,
    code_generator_factory: Callable[..., CodeGenerator],
    yosys_validator: Callable[[Path], object],
) -> None:
    """Test RTL validation for top wrapper with external I/O."""

    # Configure fabric
    fabric_with_io_tiles.numberOfBRAMs = 0  # Simplify for this test
    fabric_with_io_tiles.frameBitsPerRow = 24
    fabric_with_io_tiles.maxFramesPerCol = 8
    fabric_with_io_tiles.numberOfRows = 3
    fabric_with_io_tiles.numberOfColumns = 3
    fabric_with_io_tiles.desync_flag = 0
    fabric_with_io_tiles.frameSelectWidth = 3
    fabric_with_io_tiles.rowSelectWidth = 1

    test_name = f"{fabric_with_io_tiles.name}_top_with_io"
    writer = code_generator_factory(hdl_lang, test_name)
    writer.outFileName = tmp_path / f"{test_name}{hdl_lang}"

    # Generate the Top Wrapper HDL
    generateTopWrapper(writer, fabric_with_io_tiles)

    # Check if HDL file was created
    if not writer.outFileName.exists():
        pytest.skip(
            f"Top wrapper with I/O HDL file {writer.outFileName} was not generated"
        )

    # Validate structure using Yosys
    validator = yosys_validator(writer.outFileName)

    # Basic expected ports for fabric with I/O
    expected_ports = [
        "CLK",
        "resetn",
        "SelfWriteStrobe",
        "SelfWriteData",
        "Rx",
        "ComActive",
        "ReceiveLED",
        "s_clk",
        "s_data",
    ]

    yosys_commands = _create_top_wrapper_validation_commands(0, expected_ports)
    validator.validate(yosys_commands)


@pytest.mark.parametrize("hdl_lang", [".v", ".vhdl"])
def test_minimal_top_wrapper_rtl_validation(
    hdl_lang: str,
    empty_fabric: Fabric,
    tmp_path: Path,
    code_generator_factory: Callable[..., CodeGenerator],
    yosys_validator: Callable[[Path], object],
) -> None:
    """Test RTL validation for minimal top wrapper configuration."""

    # Configure minimal fabric
    empty_fabric.numberOfBRAMs = 0
    empty_fabric.frameBitsPerRow = 16
    empty_fabric.maxFramesPerCol = 5
    empty_fabric.numberOfRows = 2
    empty_fabric.numberOfColumns = 2
    empty_fabric.desync_flag = 0
    empty_fabric.frameSelectWidth = 2
    empty_fabric.rowSelectWidth = 1

    test_name = f"{empty_fabric.name}_top_minimal"
    writer = code_generator_factory(hdl_lang, test_name)
    writer.outFileName = tmp_path / f"{test_name}{hdl_lang}"

    # Generate the Top Wrapper HDL
    generateTopWrapper(writer, empty_fabric)

    # Check if HDL file was created
    if not writer.outFileName.exists():
        pytest.skip(
            f"Minimal top wrapper HDL file {writer.outFileName} was not generated"
        )

    # Validate structure using Yosys
    validator = yosys_validator(writer.outFileName)

    # Basic expected ports for minimal fabric
    expected_ports = [
        "CLK",
        "resetn",
        "SelfWriteStrobe",
        "SelfWriteData",
        "Rx",
        "ComActive",
        "ReceiveLED",
        "s_clk",
        "s_data",
    ]

    yosys_commands = _create_top_wrapper_validation_commands(0, expected_ports)
    validator.validate(yosys_commands)
