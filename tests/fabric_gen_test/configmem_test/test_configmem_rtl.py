"""RTL behavior validation for generated ConfigMem modules using cocotb."""

import json
import os
from pathlib import Path

# Cocotb test module - these functions are called by cocotb during simulation
import cocotb
import pytest
from cocotb.triggers import Timer

from FABulous.fabric_generator.gen_fabric.gen_configmem import generateConfigMem

# Use parseConfigMem function to get accurate bit mapping
from FABulous.fabric_generator.parser.parse_configmem import parseConfigMem


def load_bit_mapping():
    """Load direct bit mapping from JSON file: (frame,framedata_bit) -> config_bit."""
    config_file = Path(os.getcwd()) / "config_info.json"
    if config_file.exists():
        with open(config_file) as f:
            return json.load(f)
    return {}


def create_test_pattern(config_info, frame_index, pattern_type="ones"):
    """Create a test pattern that sets the appropriate bits for the given frame."""
    if str(frame_index) not in config_info:
        return 0

    used_bits = config_info[str(frame_index)]["used_bits"]
    if not used_bits:
        return 0

    pattern = 0
    if pattern_type == "ones":
        # Set all used bits to 1
        for bit in used_bits:
            pattern |= 1 << bit
    elif pattern_type == "alternating":
        # Set every other used bit
        for i, bit in enumerate(used_bits):
            if i % 2 == 0:
                pattern |= 1 << bit

    return pattern


async def initialize_configmem(dut):
    """Initialize ConfigMem by setting all bits to 0 using frame strobing."""
    # Set FrameData to 0
    dut.FrameData.value = 0

    # Strobe all available frames to initialize ConfigBits to 0
    max_frames = len(dut.FrameStrobe)
    for frame_idx in range(max_frames):
        frame_strobe_val = 1 << frame_idx
        dut.FrameStrobe.value = frame_strobe_val
        await Timer(10, units="ps")

    # Deassert all strobes
    dut.FrameStrobe.value = 0
    await Timer(10, units="ps")


@pytest.mark.skip(reason="Cocotb test - run by simulation, not pytest")
@cocotb.test
async def test_configmem_settings(dut):
    """Test exact bit mapping from FrameData to ConfigBits using direct mapping."""
    await initialize_configmem(dut)

    # Load direct bit mapping: "(frame,framedata_bit)" -> config_bit
    bit_mapping = load_bit_mapping()

    max_frames = len(dut.FrameStrobe)
    framedata_width = len(dut.FrameData)
    configbits_width = len(dut.ConfigBits)

    # Get valid FrameData bits from the bit mapping
    valid_framedata_bits = set()
    for key in bit_mapping.keys():
        frame_str, bit_str = key.split(", ")
        valid_framedata_bits.add(int(bit_str))

    # Test each frame and FrameData bit combination
    for frame_idx in range(max_frames):
        # Test valid mapped bits
        for framedata_bit_idx in sorted(valid_framedata_bits):
            # Initialize to all zeros
            await initialize_configmem(dut)

            # Set only one FrameData bit directly
            dut.FrameData[framedata_bit_idx].value = 1
            dut.FrameStrobe[frame_idx].value = 1
            await Timer(10, units="ps")

            # Check if this (frame, framedata_bit) combination has a mapping
            mapping_key = f"{frame_idx}, {framedata_bit_idx}"

            if mapping_key in bit_mapping:
                # This FrameData bit should map to a specific ConfigBit
                expected_config_bit = bit_mapping[mapping_key]

                assert dut.ConfigBits[expected_config_bit].value == 1, (
                    f"Frame {frame_idx}, FrameData bit {framedata_bit_idx}: "
                    f"Expected ConfigBits[{expected_config_bit}] to be 1, "
                    f"but got {dut.ConfigBits[expected_config_bit].value}"
                )

                assert dut.ConfigBits_N[expected_config_bit].value == 0, (
                    f"Frame {frame_idx}, FrameData bit {framedata_bit_idx}: "
                    f"Expected ConfigBits_N[{expected_config_bit}] to be 0, "
                    f"but got {dut.ConfigBits_N[expected_config_bit].value}"
                )

                # Check that no other ConfigBits are set
                for config_bit_idx in range(configbits_width):
                    if config_bit_idx != expected_config_bit:
                        assert dut.ConfigBits[config_bit_idx].value == 0, (
                            f"Frame {frame_idx}, FrameData bit {framedata_bit_idx}: "
                            f"Unexpected ConfigBits[{config_bit_idx}] is set"
                        )

                # Test latch behavior - deassert strobe and verify value is maintained
                dut.FrameStrobe[frame_idx].value = 0
                await Timer(10, units="ps")

                assert dut.ConfigBits[expected_config_bit].value == 1, (
                    f"Frame {frame_idx}, FrameData bit {framedata_bit_idx}: "
                    f"ConfigBits[{expected_config_bit}] should maintain value when strobe deasserted"
                )
            else:
                assert dut.ConfigBits.value == 0, (
                    f"Frame {frame_idx}, FrameData bit {framedata_bit_idx}: "
                    "No mapping found, all ConfigBits should be 0"
                )


@pytest.mark.parametrize("hdl_lang", [".v", ".vhd"])
def test_configmem_rtl_with_generated_configmem_simulation(
    hdl_lang: str,
    fabric_config,
    tile_config,
    tmp_path: Path,
    code_generator_factory,
    cocotb_runner,
):
    """Generate ConfigMem RTL and verify its behavior using cocotb simulation."""

    # Skip impossible configurations where fabric capacity < tile requirements
    fabric_capacity = fabric_config.frameBitsPerRow * fabric_config.maxFramesPerCol
    tile_requirements = tile_config.globalConfigBits
    if fabric_capacity < tile_requirements and tile_requirements > 0:
        pytest.skip(
            f"Impossible configuration: fabric capacity ({fabric_capacity}) < tile requirements ({tile_requirements})"
        )

    # Create code generator using the factory fixture, but with tmp_path output
    writer = code_generator_factory(hdl_lang, f"{tile_config.name}_ConfigMem")
    # Override the output path to use tmp_path
    writer.outFileName = tmp_path / f"{tile_config.name}_ConfigMem{hdl_lang}"

    # Create CSV file in tmp_path
    csv_path = tmp_path / f"{tile_config.name}_configMem.csv"

    # Generate the ConfigMem RTL
    generateConfigMem(writer, fabric_config, tile_config, csv_path)

    # Check if RTL file was created - skip if no config bits were generated
    if tile_config.globalConfigBits != 0:
        assert writer.outFileName.exists(), (
            f"ConfigMem RTL file {writer.outFileName} was not generated."
        )
    else:
        return

    bit_mapping = {}  # Key: "frame,framedata_bit", Value: config_bit_index
    config_mem_entries = parseConfigMem(
        csv_path,
        fabric_config.maxFramesPerCol,
        fabric_config.frameBitsPerRow,
        tile_config.globalConfigBits,
    )

    # Create direct mapping using the parsed ConfigMem objects
    for config_mem in config_mem_entries:
        frame_index = config_mem.frameIndex
        config_bit_ranges = config_mem.configBitRanges
        used_bit_mask = config_mem.usedBitMask

        # Find which FrameData bits are used (positions of '1' in mask)
        # The usedBitMask is interpreted right-to-left (little endian)
        used_framedata_bits = [
            len(used_bit_mask) - 1 - i
            for i, bit in enumerate(reversed(used_bit_mask))
            if bit == "1"
        ]

        # Map each used FrameData bit to its corresponding ConfigBit
        for framedata_bit_idx, config_bit_idx in zip(
            used_framedata_bits, config_bit_ranges, strict=True
        ):
            key = f"{frame_index}, {framedata_bit_idx}"
            bit_mapping[key] = config_bit_idx

    # Save bit mapping for cocotb tests to use
    config_info_file = tmp_path / "config_info.json"
    with open(config_info_file, "w") as f:
        json.dump(bit_mapping, f, indent=2)

    cocotb_runner(
        sources=[writer.outFileName],
        hdl_top_level=f"{tile_config.name}_ConfigMem",
        test_module_path=Path(__file__),
    )


@pytest.mark.parametrize("hdl_lang", [".v", ".vhdl"])
def test_configmem_rtl_with_custom_configmem_simulation(
    hdl_lang: str,
    tmp_path: Path,
    default_fabric,
    default_tile,
    configmem_list,
    code_generator_factory,
    cocotb_runner,
    mocker,
):
    """Generate ConfigMem RTL and verify its behavior using cocotb simulation."""

    # Skip impossible configurations where fabric capacity < tile requirements
    fabric_capacity = default_fabric.frameBitsPerRow * default_fabric.maxFramesPerCol
    tile_requirements = default_tile.globalConfigBits
    if fabric_capacity < tile_requirements and tile_requirements > 0:
        pytest.skip(
            f"Impossible configuration: fabric capacity ({fabric_capacity}) < tile requirements ({tile_requirements})"
        )

    # Create code generator using the factory fixture, but with tmp_path output
    writer = code_generator_factory(
        hdl_lang,
        f"{default_tile.name}_ConfigMem",
    )
    # Override the output path to use tmp_path
    writer.outFileName = tmp_path / f"{default_tile.name}_ConfigMem{hdl_lang}"
    writer.outFileName.touch()

    # Create CSV file in tmp_path
    csv_path = tmp_path / f"{default_tile.name}_configMem.csv"
    configmem_list_data = configmem_list(default_fabric, default_tile)

    # Mock parseConfigMem to return our configmem_list fixture
    mock_parse = mocker.patch(
        "FABulous.fabric_generator.gen_fabric.gen_configmem.parseConfigMem",
        return_value=configmem_list,
    )
    mock_parse.return_value = configmem_list_data

    # Generate the ConfigMem RTL
    generateConfigMem(writer, default_fabric, default_tile, csv_path)

    bit_mapping = {}  # Key: "frame,framedata_bit", Value: config_bit_index

    # Create direct mapping using the parsed ConfigMem objects
    for config_mem in configmem_list_data:
        frame_index = config_mem.frameIndex
        config_bit_ranges = config_mem.configBitRanges
        used_bit_mask = config_mem.usedBitMask

        # Find which FrameData bits are used (positions of '1' in mask)
        # The usedBitMask is interpreted right-to-left (little endian)
        used_framedata_bits = [
            len(used_bit_mask) - 1 - i
            for i, bit in enumerate(reversed(used_bit_mask))
            if bit == "1"
        ]

        # Map each used FrameData bit to its corresponding ConfigBit
        for framedata_bit_idx, config_bit_idx in zip(
            used_framedata_bits, config_bit_ranges, strict=True
        ):
            key = f"{frame_index}, {framedata_bit_idx}"
            bit_mapping[key] = config_bit_idx

    # Save bit mapping for cocotb tests to use
    config_info_file = tmp_path / "config_info.json"
    with open(config_info_file, "w") as f:
        json.dump(bit_mapping, f, indent=2)

    # Set up cocotb simulation and run using the factory fixture
    cocotb_runner(
        sources=[writer.outFileName],
        hdl_top_level=f"{default_tile.name}_ConfigMem",
        test_module_path=Path(__file__),
    )
