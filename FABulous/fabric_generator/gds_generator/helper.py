"""Helper utilities for GDS generation: die area rounding and pitch parsing.

This module exposes utilities used by the GDS generator flows.
"""

from decimal import Decimal
from pathlib import Path

from librelane.config.config import Config
from librelane.logging.logger import info


def get_pitch(config: Config) -> tuple[Decimal, Decimal]:
    """Read the FP_TRACKS_INFO file and return min pitches for X and Y.

    Returns a tuple (x_pitch, y_pitch) where x_pitch is the
    minimum pitch along X-axis (FP_IO_VLAYER X direction) and
    y_pitch is minimum pitch along Y-axis (FP_IO_HLAYER Y direction).
    The cardinal field in FP_TRACKS_INFO is expected
    to be 'X' or 'Y' (case-insensitive).
    """
    with Path(config["FP_TRACKS_INFO"]).open() as f:
        lines = f.readlines()

    layers: dict[str, dict[str, tuple[Decimal, Decimal]]] = {}
    for line in lines:
        if line.strip() == "":
            continue
        layer, cardinal, offset, pitch = line.split()
        layers[layer] = layers.get(layer) or {}
        layers[layer][cardinal] = (Decimal(offset), Decimal(pitch))

    x_pitch = layers[config["FP_IO_VLAYER"]]["X"][1]
    y_pitch = layers[config["FP_IO_HLAYER"]]["Y"][1]

    return x_pitch, y_pitch


def round_die_area(config: Config) -> Config:
    """Round the DIE_AREA to multiples of the minimum pitch.

    This reads the minimum pitch from FP_TRACKS_INFO and updates the
    config DIE_AREA to start at (0,0) with width/height rounded up to
    the next multiple of that pitch.
    """
    x_pitch, y_pitch = get_pitch(config)

    die_area = config.get("DIE_AREA")
    if die_area is None:
        raise ValueError("DIE_AREA metric not found in state.")
    _, _, width, height = die_area

    # Convert to Decimal for precise arithmetic
    width = Decimal(str(width))
    height = Decimal(str(height))

    # Round width (X) and height (Y) to the next multiple of the
    # respective minimum pitches using pure Decimal arithmetic
    def round_up_decimal(value: Decimal, pitch: Decimal) -> Decimal:
        if pitch == 0:
            return value
        quotient = value // pitch

        remainder = value % pitch
        if remainder > 0:
            quotient += 1
        return quotient * pitch

    width_rounded = round_up_decimal(width, x_pitch)
    height_rounded = round_up_decimal(height, y_pitch)

    info(
        f"Rounding DIE_AREA from ({width}, {height}) to "
        f"({width_rounded}, {height_rounded}) "
        f"(pitch_x={x_pitch}, pitch_y={y_pitch})"
    )
    return config.copy(DIE_AREA=(0, 0, width_rounded, height_rounded))
