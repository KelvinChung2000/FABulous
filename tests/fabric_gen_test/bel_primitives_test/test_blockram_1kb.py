"""RTL behavior validation for BlockRAM_1KB using cocotb."""

from collections.abc import Callable
from pathlib import Path
from typing import Any, Protocol

import cocotb
import pytest
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge


class BlockRAM1KBDUT(Protocol):
    """Protocol for BlockRAM_1KB DUT."""

    clk: Any
    rd_en: Any
    rd_addr: Any
    rd_data: Any
    wr_en: Any
    wr_addr: Any
    wr_data: Any
    C0: Any
    C1: Any
    C2: Any
    C3: Any
    C4: Any
    C5: Any


async def init_dut(dut: BlockRAM1KBDUT, wr_cfg: int = 0, rd_cfg: int = 0,
                   always_wr: int = 0, out_reg: int = 0) -> None:
    """Initialize DUT with given configuration and start clock."""
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    # Configuration bits
    dut.C0.value = (wr_cfg >> 1) & 1
    dut.C1.value = wr_cfg & 1
    dut.C2.value = (rd_cfg >> 1) & 1
    dut.C3.value = rd_cfg & 1
    dut.C4.value = always_wr
    dut.C5.value = out_reg

    # Default inactive
    dut.rd_en.value = 0
    dut.wr_en.value = 0
    dut.rd_addr.value = 0
    dut.wr_addr.value = 0
    dut.wr_data.value = 0

    # Wait for reset settling
    for _ in range(2):
        await RisingEdge(dut.clk)


async def write_word(dut: BlockRAM1KBDUT, addr: int, data: int) -> None:
    """Write data at addr on next clock edge."""
    dut.wr_en.value = 1
    dut.wr_addr.value = addr
    dut.wr_data.value = data
    await RisingEdge(dut.clk)
    dut.wr_en.value = 0


async def read_word(dut: BlockRAM1KBDUT, addr: int) -> int:
    """Read data from addr. Returns value after SRAM 1-cycle latency."""
    dut.rd_en.value = 1
    dut.rd_addr.value = addr
    await RisingEdge(dut.clk)  # SRAM captures address
    await RisingEdge(dut.clk)  # data available on dout1
    val = dut.rd_data.value.integer
    dut.rd_en.value = 0
    return val


@cocotb.test()
async def cocotb_test_32bit_write_read(dut: BlockRAM1KBDUT) -> None:
    """Test 32-bit write and read back."""
    await init_dut(dut, wr_cfg=0, rd_cfg=0)

    test_data = [0xDEADBEEF, 0x12345678, 0xCAFEBABE, 0x00000000, 0xFFFFFFFF]
    for i, data in enumerate(test_data):
        await write_word(dut, addr=i, data=data)

    for i, expected in enumerate(test_data):
        result = await read_word(dut, addr=i)
        assert result == expected, (
            f"Addr {i}: expected 0x{expected:08X}, got 0x{result:08X}"
        )


@cocotb.test()
async def cocotb_test_16bit_write_read(dut: BlockRAM1KBDUT) -> None:
    """Test 16-bit write and read back via addr[8] byte-lane select."""
    await init_dut(dut, wr_cfg=1, rd_cfg=1)

    # Write 0xAAAA to lower half of word 0 (addr[8]=0)
    await write_word(dut, addr=0x000, data=0x0000AAAA)
    # Write 0xBBBB to upper half of word 0 (addr[8]=1)
    await write_word(dut, addr=0x100, data=0x0000BBBB)

    # Read lower half (addr[8]=0)
    result = await read_word(dut, addr=0x000)
    assert (result & 0xFFFF) == 0xAAAA, (
        f"Lower half: expected 0xAAAA, got 0x{result & 0xFFFF:04X}"
    )

    # Read upper half (addr[8]=1)
    result = await read_word(dut, addr=0x100)
    assert (result & 0xFFFF) == 0xBBBB, (
        f"Upper half: expected 0xBBBB, got 0x{result & 0xFFFF:04X}"
    )

    # Verify upper bits are zero in 16-bit mode
    result = await read_word(dut, addr=0x000)
    assert (result >> 16) == 0, (
        f"Upper bits should be zero in 16-bit mode, got 0x{result >> 16:04X}"
    )


@cocotb.test()
async def cocotb_test_8bit_write_read(dut: BlockRAM1KBDUT) -> None:
    """Test 8-bit write and read back via addr[9:8] byte-lane select."""
    await init_dut(dut, wr_cfg=2, rd_cfg=2)

    # Write different bytes to each lane of word 0
    await write_word(dut, addr=0x000, data=0x11)  # byte 0
    await write_word(dut, addr=0x100, data=0x22)  # byte 1
    await write_word(dut, addr=0x200, data=0x33)  # byte 2
    await write_word(dut, addr=0x300, data=0x44)  # byte 3

    # Read back each byte lane
    expected = [(0x000, 0x11), (0x100, 0x22), (0x200, 0x33), (0x300, 0x44)]
    for addr, exp_byte in expected:
        result = await read_word(dut, addr=addr)
        assert (result & 0xFF) == exp_byte, (
            f"Addr 0x{addr:03X}: expected 0x{exp_byte:02X}, got 0x{result & 0xFF:02X}"
        )

    # Verify upper bits are zero in 8-bit mode
    result = await read_word(dut, addr=0x000)
    assert (result >> 8) == 0, (
        f"Upper bits should be zero in 8-bit mode, got 0x{result >> 8:06X}"
    )


@cocotb.test()
async def cocotb_test_read_enable(dut: BlockRAM1KBDUT) -> None:
    """Test that rd_en=0 prevents read data from updating."""
    await init_dut(dut, wr_cfg=0, rd_cfg=0)

    # Write a known value
    await write_word(dut, addr=0, data=0xDEADBEEF)

    # Read with rd_en=1 to get initial data
    result = await read_word(dut, addr=0)
    assert result == 0xDEADBEEF

    # Write a different value
    await write_word(dut, addr=0, data=0x12345678)

    # Try to read with rd_en=0 — SRAM should not update dout1
    dut.rd_en.value = 0
    dut.rd_addr.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)

    # Now read with rd_en=1 to get the new value
    result = await read_word(dut, addr=0)
    assert result == 0x12345678, (
        f"Expected 0x12345678 after re-enabling read, got 0x{result:08X}"
    )


@cocotb.test()
async def cocotb_test_write_enable(dut: BlockRAM1KBDUT) -> None:
    """Test that wr_en=0 prevents writes."""
    await init_dut(dut, wr_cfg=0, rd_cfg=0)

    # Write initial value
    await write_word(dut, addr=5, data=0xAAAAAAAA)
    result = await read_word(dut, addr=5)
    assert result == 0xAAAAAAAA

    # Attempt write with wr_en=0
    dut.wr_en.value = 0
    dut.wr_addr.value = 5
    dut.wr_data.value = 0x55555555
    await RisingEdge(dut.clk)

    # Read back — should still be original value
    result = await read_word(dut, addr=5)
    assert result == 0xAAAAAAAA, (
        f"Write with wr_en=0 should not change data, got 0x{result:08X}"
    )


@cocotb.test()
async def cocotb_test_always_write_enable(dut: BlockRAM1KBDUT) -> None:
    """Test that C4=1 (alwaysWriteEnable) overrides wr_en."""
    await init_dut(dut, wr_cfg=0, rd_cfg=0, always_wr=1)

    # Write with wr_en=0, but C4=1 should force write
    dut.wr_en.value = 0
    dut.wr_addr.value = 10
    dut.wr_data.value = 0xBEEFCAFE
    await RisingEdge(dut.clk)

    # Read back
    result = await read_word(dut, addr=10)
    assert result == 0xBEEFCAFE, (
        f"AlwaysWriteEnable should force write, got 0x{result:08X}"
    )


@cocotb.test()
async def cocotb_test_output_register(dut: BlockRAM1KBDUT) -> None:
    """Test that C5=1 adds one extra cycle of read latency."""
    await init_dut(dut, wr_cfg=0, rd_cfg=0, out_reg=1)

    # Write known value
    await write_word(dut, addr=0, data=0xABCD1234)

    # With output register, read needs one extra cycle
    dut.rd_en.value = 1
    dut.rd_addr.value = 0
    await RisingEdge(dut.clk)  # SRAM captures address
    await RisingEdge(dut.clk)  # SRAM outputs data, captured by output register
    await RisingEdge(dut.clk)  # output register data available on rd_data
    result = dut.rd_data.value.integer
    dut.rd_en.value = 0

    assert result == 0xABCD1234, (
        f"With output register, expected 0xABCD1234, got 0x{result:08X}"
    )


@cocotb.test()
async def cocotb_test_4bit_write_read(dut: BlockRAM1KBDUT) -> None:
    """Test 4-bit write and read back via addr[10:8] nibble select.

    NOTE: The SRAM has byte-level write masking, so writing a nibble zeros
    the adjacent nibble in the same byte. Each nibble is tested individually.
    """
    await init_dut(dut, wr_cfg=3, rd_cfg=3)

    # Test each nibble position independently (write + immediate read)
    # addr[10:8] = nibble index (0-7), addr[7:0] = word address
    for nib_idx in range(8):
        addr = (nib_idx << 8) | nib_idx  # use different word for each to avoid clobber
        test_val = (nib_idx + 5) & 0xF
        await write_word(dut, addr=addr, data=test_val)
        result = await read_word(dut, addr=addr)
        assert (result & 0xF) == test_val, (
            f"Nibble {nib_idx}: expected 0x{test_val:X}, got 0x{result & 0xF:X}"
        )

    # Verify upper bits are zero in 4-bit mode
    await write_word(dut, addr=0x000, data=0xF)
    result = await read_word(dut, addr=0x000)
    assert (result >> 4) == 0, (
        f"Upper bits should be zero in 4-bit mode, got 0x{result >> 4:07X}"
    )

    # Verify that writing one nibble clobbers the adjacent nibble in the same byte
    # Write low nibble of byte 0 at word 100
    await write_word(dut, addr=(0 << 8) | 100, data=0xA)
    # Write high nibble of byte 0 at word 100 — should zero the low nibble
    await write_word(dut, addr=(1 << 8) | 100, data=0xB)
    # Read back low nibble — should be 0 (clobbered)
    result = await read_word(dut, addr=(0 << 8) | 100)
    assert (result & 0xF) == 0x0, (
        f"Low nibble should be clobbered, got 0x{result & 0xF:X}"
    )
    # Read back high nibble — should be 0xB
    result = await read_word(dut, addr=(1 << 8) | 100)
    assert (result & 0xF) == 0xB, (
        f"High nibble: expected 0xB, got 0x{result & 0xF:X}"
    )


# --- Pytest entry point ---

BLOCKRAM_SRC = (
    Path(__file__).parents[3]
    / "fabulous"
    / "fabric_files"
    / "FABulous_project_template_verilog"
    / "Fabric"
    / "BlockRAM_1KB.v"
)

SRAM_MODEL_SRC = Path(__file__).parent / "sram_model.v"


def _strip_blackbox(src: Path, dst: Path) -> Path:
    """Copy BlockRAM_1KB.v but remove the blackbox sram module declaration.

    The behavioral model in sram_model.v provides the implementation instead.
    """
    text = src.read_text()
    # Remove everything from the blackbox attribute to the end of that module
    marker = "(* blackbox *)"
    idx = text.find(marker)
    if idx != -1:
        text = text[:idx]
    dst.write_text(text)
    return dst


def test_blockram_1kb_simulation(
    tmp_path: Path,
    cocotb_runner: Callable[..., Callable],
) -> None:
    """Run cocotb simulation for BlockRAM_1KB."""
    # Strip the blackbox declaration to avoid duplicate module with sram_model.v
    sim_src = _strip_blackbox(BLOCKRAM_SRC, tmp_path / "BlockRAM_1KB.v")

    cocotb_runner(
        sources=[sim_src, SRAM_MODEL_SRC],
        hdl_top_level="BlockRAM_1KB",
        test_module_path=Path(__file__),
    )
