"""Conftest file providing fixtures for fabric generator tests."""

import csv
import shutil
from pathlib import Path
from typing import NamedTuple

import pytest
from cocotb.runner import get_runner

from FABulous.fabric_definition.ConfigMem import ConfigMem
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile


class FabricConfig(NamedTuple):
    """Configuration parameters for fabric testing."""

    name: str
    frame_bits_per_row: int
    max_frames_per_col: int


class TileConfig(NamedTuple):
    """Configuration parameters for tile testing."""

    name: str
    global_config_bits: int


@pytest.fixture
def default_fabric(mocker) -> Fabric:
    """Helper function to create a Fabric instance with given parameters."""
    fabric = mocker.create_autospec(Fabric, spec_set=False)
    fabric.frameBitsPerRow = 32
    fabric.maxFramesPerCol = 20
    fabric.name = "DefaultFabric"
    return fabric


@pytest.fixture
def default_tile(mocker) -> Tile:
    """Helper function to create a Tile instance with given parameters."""
    tile = mocker.create_autospec(Tile, spec_set=False)
    tile.name = "DefaultTile"
    tile.globalConfigBits = 127
    return tile


@pytest.fixture(
    params=[
        # Standard configurations
        FabricConfig(frame_bits_per_row=32, max_frames_per_col=20, name="StandardFabric"),
        FabricConfig(frame_bits_per_row=8, max_frames_per_col=5, name="SmallFabric"),
        # Boundary conditions
        FabricConfig(frame_bits_per_row=1, max_frames_per_col=1, name="MinimalFabric"),
        FabricConfig(frame_bits_per_row=1, max_frames_per_col=64, name="ThinFabric"),
        FabricConfig(frame_bits_per_row=64, max_frames_per_col=1, name="WideFabric"),
        # Non-power-of-2 configurations
        FabricConfig(frame_bits_per_row=5, max_frames_per_col=7, name="IrregularSmall"),
        FabricConfig(frame_bits_per_row=33, max_frames_per_col=21, name="IrregularLarge"),
        FabricConfig(frame_bits_per_row=7, max_frames_per_col=13, name="PrimeFabric"),
        # Large-scale configurations
        FabricConfig(frame_bits_per_row=256, max_frames_per_col=100, name="VeryLargeFabric"),
    ],
    ids=lambda config: config.name,
)
def fabric_config(request, mocker):
    """Comprehensive parametric fabric configurations for testing different scenarios."""
    config = request.param
    fabric = mocker.create_autospec(Fabric, spec_set=False)
    fabric.frameBitsPerRow = config.frame_bits_per_row
    fabric.maxFramesPerCol = config.max_frames_per_col
    fabric.name = config.name
    return fabric


@pytest.fixture(
    params=[
        # Boundary conditions
        TileConfig("StandardTile", 16),
        TileConfig("EmptyTile", 0),
        TileConfig("MinimalTile", 1),
        TileConfig("MaxTile", 256),
        # Non-power-of-2 configurations
        TileConfig("Irregular7Tile", 7),
        TileConfig("Irregular33Tile", 33),
    ],
    ids=lambda config: config.name,
)
def tile_config(request, mocker):
    """Comprehensive parametric tile configurations covering various component types."""
    config = request.param
    tile = mocker.create_autospec(Tile, spec_set=False)
    tile.name = config.name
    tile.globalConfigBits = config.global_config_bits
    return tile


def create_config_csv(file_path: Path, data: list[dict]) -> None:
    """Helper function to create config memory CSV files from dictionary data.

    Parameters
    ----------
    file_path : Path
        The path where the CSV file should be created
    data : list[dict]
        List of dictionaries containing the CSV row data
    """
    with open(file_path, "w", newline="") as f:
        if data:
            writer = csv.DictWriter(f, fieldnames=data[0].keys())
            writer.writeheader()
            writer.writerows(data)


def verify_csv_content(file_path: Path, expected_rows: int | None = None) -> list[dict]:
    """Helper function to verify CSV content and return parsed data.

    Parameters
    ----------
    file_path : Path
        The path to the CSV file to verify
    expected_rows : int, optional
        Expected number of rows in the CSV

    Returns
    -------
    list[dict]
        The parsed CSV data as a list of dictionaries
    """
    assert file_path.exists(), f"CSV file {file_path} does not exist"

    with open(file_path) as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    assert rows[0].keys() == {
        "frame_name",
        "frame_index",
        "bits_used_in_frame",
        "used_bits_mask",
        "ConfigBits_ranges",
    }, f"CSV file {file_path} has unexpected headers"

    if expected_rows is not None:
        assert len(rows) == expected_rows, f"Expected {expected_rows} rows, got {len(rows)}"

    return rows


class ConfigMemConfig(NamedTuple):
    """Configuration for ConfigMem test scenarios."""

    name: str
    scenario: str


@pytest.fixture(params=[1, 2, 3, 4, 5], ids=lambda param: f"ConfigMemPattern{param}")
def configmem_list(request):
    """Parameterized fixture returning various ConfigMem object lists."""

    def _create(fabric: Fabric, tile: Tile):
        import itertools
        import random
        from random import shuffle

        random.seed(request.param)

        # Generate all possible (frame_index, bits_used) combinations
        poss = list(itertools.product(range(fabric.maxFramesPerCol), range(fabric.frameBitsPerRow + 1)))
        shuffle(poss)
        config_final = poss[: tile.globalConfigBits]

        # Helper function to generate random bit mask
        def generate_mask(bits_used, total_bits):
            if bits_used == 0:
                return "0" * total_bits
            if bits_used >= total_bits:
                return "1" * total_bits

            # Create a list with the right number of 1s and 0s
            mask_bits = ["1"] * bits_used + ["0"] * (total_bits - bits_used)
            # Randomly shuffle the bits to create a random pattern
            shuffle(mask_bits)

            return "".join(mask_bits)

        # Generate ConfigMem objects based on config_final
        configmems = []
        total_bits_assigned = 0

        # Group config_final by frame_index to consolidate bits per frame
        frame_groups = {}
        for frame_index, bits_in_frame in config_final:
            if frame_index not in frame_groups:
                frame_groups[frame_index] = []
            frame_groups[frame_index].append(bits_in_frame)

        # Create ConfigMem objects for each frame
        for frame_index in range(fabric.maxFramesPerCol):
            if frame_index not in frame_groups:
                configmems.append(
                    ConfigMem(
                        frameName=f"frame{frame_index}",
                        frameIndex=frame_index,
                        bitsUsedInFrame=0,
                        usedBitMask=generate_mask(0, fabric.frameBitsPerRow),
                        configBitRanges=[],
                    )
                )
                continue
            bits_list = frame_groups[frame_index]
            total_bits_in_frame = len(bits_list)

            # Ensure we don't exceed frame capacity
            bits_used = min(total_bits_in_frame, fabric.frameBitsPerRow)

            if bits_used > 0:
                bit_ranges = list(range(total_bits_assigned, total_bits_assigned + bits_used))
                random.shuffle(bit_ranges)
                configmems.append(
                    ConfigMem(
                        frameName=f"frame{frame_index}",
                        frameIndex=frame_index,
                        bitsUsedInFrame=bits_used,
                        usedBitMask=generate_mask(bits_used, fabric.frameBitsPerRow),
                        configBitRanges=bit_ranges,
                    )
                )
                total_bits_assigned += bits_used
        return configmems

    return _create


@pytest.fixture
def code_generator_factory(tmp_path: Path):
    """Factory fixture to create code generators with temporary output files."""

    def _create_generator(extension: str, name="test_output"):
        from FABulous.fabric_generator.code_generator.code_generator_Verilog import VerilogCodeGenerator
        from FABulous.fabric_generator.code_generator.code_generator_VHDL import VHDLCodeGenerator

        output_file = tmp_path / f"{name}{extension}"

        if extension == ".v":
            writer = VerilogCodeGenerator()
            writer.outFileName = output_file
            return writer
        if extension == ".vhd":
            writer = VHDLCodeGenerator()
            writer.outFileName = output_file
            return writer
        raise ValueError(f"Unsupported extension: {extension}")

    return _create_generator

