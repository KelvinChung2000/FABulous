"""RTL behavior validation for Frame_Data_Reg module using cocotb."""

from decimal import Decimal
from pathlib import Path

import cocotb
import pytest
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

from tests.fabric_construct_test.conftest import VERILOG_SOURCE_PATH


def test_Frame_Data_Reg_rtl(cocotb_runner):
    """Test the Frame_Data_Reg module with Verilog source."""
    cocotb_runner(
        sources=[VERILOG_SOURCE_PATH / "Fabric" / "Frame_Data_Reg.v"],
        hdl_top_level="Frame_Data_Reg",
        test_module_path=Path(__file__),
    )


@pytest.mark.skip(reason="Cocotb test - run by simulation, not pytest")
@cocotb.test
async def test_frame_data_reg_basic(dut):
    """Test basic functionality of Frame_Data_Reg."""
    # Start clock
    clock = Clock(dut.CLK, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Initialize inputs
    dut.FrameData_I.value = 0
    dut.RowSelect.value = 0

    # Wait for a few clock cycles to stabilize
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)

    # Test case 1: RowSelect matches the configured Row (default Row = 1)
    test_data = 0xA5A5A5A5  # Test pattern
    dut.FrameData_I.value = test_data
    dut.RowSelect.value = 1  # This should match the Row parameter (default = 1)

    await RisingEdge(dut.CLK)
    await Timer(Decimal(10), units="ps")  # Small delay to allow propagation

    # Check that FrameData_O matches FrameData_I when RowSelect == Row
    assert dut.FrameData_O.value == test_data, (
        f"Expected FrameData_O = 0x{test_data:08x}, got 0x{dut.FrameData_O.value:08x} "
        f"when RowSelect ({dut.RowSelect.value}) matches Row"
    )

    # Test case 2: RowSelect does not match the configured Row
    dut.RowSelect.value = 2  # This should NOT match the Row parameter (default = 1)
    new_test_data = 0x5A5A5A5A
    dut.FrameData_I.value = new_test_data

    await RisingEdge(dut.CLK)
    await Timer(Decimal(10), units="ps")

    # FrameData_O should remain the same (previous value) when RowSelect != Row
    assert dut.FrameData_O.value == test_data, (
        f"Expected FrameData_O to remain 0x{test_data:08x}, got 0x{dut.FrameData_O.value:08x} "
        f"when RowSelect ({dut.RowSelect.value}) does not match Row"
    )

    # Test case 3: Multiple row select changes
    for row_val in [0, 3, 4, 1, 5]:
        pattern = 0x12345678 + row_val
        dut.FrameData_I.value = pattern
        dut.RowSelect.value = row_val

        await RisingEdge(dut.CLK)
        await Timer(Decimal(10), units="ps")

        if row_val == 1:  # Matches the default Row parameter
            expected = pattern
        else:  # Does not match
            expected = dut.FrameData_O.value  # Should remain unchanged

        actual = dut.FrameData_O.value
        assert actual == expected, f"Row {row_val}: Expected FrameData_O = 0x{expected:08x}, got 0x{actual:08x}"


@pytest.mark.skip(reason="Cocotb test - run by simulation, not pytest")
@cocotb.test
async def test_frame_data_reg_edge_cases(dut):
    """Test edge cases and corner values for Frame_Data_Reg."""
    # Start clock
    clock = Clock(dut.CLK, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Initialize
    dut.FrameData_I.value = 0
    dut.RowSelect.value = 0
    await RisingEdge(dut.CLK)

    # Test with all zeros
    dut.FrameData_I.value = 0x00000000
    dut.RowSelect.value = 1
    await RisingEdge(dut.CLK)
    await Timer(Decimal(10), units="ps")
    assert dut.FrameData_O.value == 0x00000000, "Failed with all zeros pattern"

    # Test with all ones
    dut.FrameData_I.value = 0xFFFFFFFF
    dut.RowSelect.value = 1
    await RisingEdge(dut.CLK)
    await Timer(Decimal(10), units="ps")
    assert dut.FrameData_O.value == 0xFFFFFFFF, "Failed with all ones pattern"

    # Test alternating patterns
    patterns = [0xAAAAAAAA, 0x55555555, 0xF0F0F0F0, 0x0F0F0F0F]
    for pattern in patterns:
        dut.FrameData_I.value = pattern
        dut.RowSelect.value = 1
        await RisingEdge(dut.CLK)
        await Timer(Decimal(10), units="ps")
        assert dut.FrameData_O.value == pattern, f"Failed with pattern 0x{pattern:08x}"

    # Test row select at boundary values (assuming 5-bit RowSelectWidth)
    # Row 0
    dut.RowSelect.value = 0
    dut.FrameData_I.value = 0xDEADBEEF
    await RisingEdge(dut.CLK)
    await Timer(Decimal(10), units="ps")
    # Should not update since Row != 1
    assert dut.FrameData_O.value == patterns[-1], "Row 0 should not trigger update"

    # Row 31 (max for 5-bit)
    dut.RowSelect.value = 31
    dut.FrameData_I.value = 0xCAFEBABE
    await RisingEdge(dut.CLK)
    await Timer(Decimal(10), units="ps")
    # Should not update since Row != 1
    assert dut.FrameData_O.value == patterns[-1], "Row 31 should not trigger update"
