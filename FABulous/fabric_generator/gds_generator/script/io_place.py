# Copyright 2020-2022 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
import logging
import math
import os
import random
import re
import sys
from dataclasses import dataclass
from decimal import Decimal
from functools import partial
from pathlib import Path

import click
import ioplace_parser
import odb
import yaml
from reader import click_odb

logger = logging.getLogger(__name__)


def grid_to_tracks(origin, count, step):
    tracks = []
    pos = origin
    for _ in range(count):
        tracks.append(pos)
        pos += step
    assert len(tracks) > 0
    tracks.sort()

    return tracks


def equally_spaced_sequence(side: str, side_pin_placement, possible_locations):
    virtual_pin_count = 0
    actual_pin_count = len(side_pin_placement)
    total_pin_count = actual_pin_count + virtual_pin_count
    for i in range(len(side_pin_placement)):
        if isinstance(
            side_pin_placement[i], int
        ):  # This is an int value indicating virtual pins
            virtual_pin_count = virtual_pin_count + side_pin_placement[i]
            actual_pin_count = (
                actual_pin_count - 1
            )  # Decrement actual pin count, this value was only there to indicate virtual pin count
            total_pin_count = actual_pin_count + virtual_pin_count
    result = []
    tracks = len(possible_locations)

    if total_pin_count > tracks:
        logger.error(
            "The %s side of the floorplan doesn't have enough slots for all the pins: "
            "%d pins/%d slots.",
            side,
            total_pin_count,
            tracks,
        )
        logger.error(
            "Try re-assigning pins to other sides, enabling proportional allocation, or "
            "making the floorplan larger."
        )
        sys.exit(1)
    elif total_pin_count == tracks:
        return possible_locations, side_pin_placement  # All positions.
    elif total_pin_count == 0:
        return result, side_pin_placement

    # From this point, pin_count always < tracks.
    tracks_per_pin = math.floor(tracks / total_pin_count)  # >=1
    # O| | | O| | | O| | |
    # tracks_per_pin = 3
    # notice the last two tracks are unused
    # thus:
    used_tracks = tracks_per_pin * (total_pin_count - 1) + 1
    unused_tracks = tracks - used_tracks

    # Place the pins at those tracks...
    current_track = unused_tracks // 2  # So that the tracks used are centered
    starting_track_index = current_track
    if virtual_pin_count == 0:  # No virtual pins
        for _ in range(total_pin_count):
            result.append(possible_locations[current_track])
            current_track += tracks_per_pin
    else:  # There are virtual pins
        for i in range(len(side_pin_placement)):
            if not isinstance(side_pin_placement[i], int):  # We have an actual pin
                result.append(possible_locations[current_track])
                current_track += tracks_per_pin
            else:  # Virtual Pins, so just leave their needed spaces
                current_track += tracks_per_pin * side_pin_placement[i]
        side_pin_placement = [
            pin for pin in side_pin_placement if not isinstance(pin, int)
        ]  # Remove the virtual pins from the side_pin_placement list

    logger.debug(
        "Placement details %s | "
        "virtual=%d actual=%d total=%d tracks=%d "
        "tracks_per_pin=%d used=%d unused=%d start_idx=%d",
        side,
        virtual_pin_count,
        actual_pin_count,
        total_pin_count,
        len(possible_locations),
        tracks_per_pin,
        used_tracks,
        unused_tracks,
        starting_track_index,
    )

    VISUALIZE_PLACEMENT = False
    if VISUALIZE_PLACEMENT:
        logger.debug("Placement Map:")
        map_str = ["["]
        used_track_indices = []
        for i, location in enumerate(possible_locations):
            if location in result:
                map_str.append(f"*{location}, ")
                used_track_indices.append(i)
            else:
                map_str.append(f"{location}, ")
        map_str.append("]")
        logger.debug("".join(map_str))
        logger.debug("Used track indices: %s", used_track_indices)

    return result, side_pin_placement


identifiers = re.compile(r"\b[A-Za-z_][A-Za-z_0-9]*\b")
standalone_numbers = re.compile(r"\b\d+\b")
trash = re.compile(r"^[^\w\d]+$")


def sorter(bterm, order: ioplace_parser.Order):
    text: str = bterm.getName()
    keys = []
    priority_keys = []
    # tokenize and add to key
    while trash.match(text) is None:
        if match := identifiers.search(text):
            bus = match[0]
            start, end = match.span(0)
            if order == ioplace_parser.Order.busMajor:
                priority_keys.append(bus)
            else:
                keys.append(bus)
            text = text[:start] + text[end:]
        elif match := standalone_numbers.search(text):
            index = int(match[0])
            if order == ioplace_parser.Order.bitMajor:
                priority_keys.append(index)
            else:
                keys.append(index)
            text = text[: match.start()] + text[match.end() :]
        else:
            break
    return [priority_keys, keys]


@dataclass(slots=True)
class SegmentInfo:
    """Data for one YAML-defined segment on a side."""

    min_distance: float | None
    max_distance: float | None
    pins: list[str]
    sort_mode: ioplace_parser.Order
    reverse_result: bool


@click.command()
@click.option(
    "-u",
    "--unmatched-error",
    type=click.Choice(["none", "unmatched_design", "unmatched_cfg", "both"]),
    default="both",
    help="Treat unmatched pins as error",
)
@click.option(
    "-c",
    "--config",
    required=True,
    type=click.Path(
        exists=True,
        file_okay=True,
        dir_okay=False,
        readable=True,
        resolve_path=True,
    ),
    help="Input configuration file",
)
@click.option(
    "-v",
    "--ver-length",
    default=None,
    type=float,
    help="Length for pins with N/S orientations in microns.",
)
@click.option(
    "-h",
    "--hor-length",
    default=None,
    type=float,
    help="Length for pins with E/S orientations in microns.",
)
@click.option(
    "-V",
    "--ver-layer",
    required=True,
    help="Name of metal layer to place vertical pins on.",
)
@click.option(
    "-H",
    "--hor-layer",
    required=True,
    help="Name of metal layer to place horizontal pins on.",
)
@click.option(
    "--hor-extension",
    default=0,
    type=float,
    help="Extension for vertical pins in microns.",
)
@click.option(
    "--ver-extension",
    default=0,
    type=float,
    help="Extension for horizontal pins in microns.",
)
@click.option(
    "--ver-width-mult", default=2, type=float, help="Multiplier for vertical pins."
)
@click.option(
    "--hor-width-mult", default=2, type=float, help="Multiplier for horizontal pins."
)
@click.option(
    "--verbose/--no-verbose",
    default=False,
    help="Enable verbose (DEBUG) logging output.",
)
@click_odb
def io_place(
    reader,
    config: str,
    ver_layer: str,
    hor_layer: str,
    ver_width_mult: float,
    hor_width_mult: float,
    hor_length: float,
    ver_length: float,
    hor_extension: float,
    ver_extension: float,
    unmatched_error: bool,
    verbose: bool,
):
    """
    Places the IOs in an input def with an optional config file that supports regexes.

    Config format:
    #N|#S|#E|#W
    pin1_regex (low co-ordinates to high co-ordinates; e.g., bottom to top and left to right)
    pin2_regex
    ...

    #S|#N|#E|#W
    """
    logging.basicConfig(
        level=logging.DEBUG if verbose else logging.INFO,
        format="[%(levelname)s] %(message)s",
    )
    config_file_name = Path(config)
    micron_in_units = reader.dbunits

    H_EXTENSION = int(micron_in_units * hor_extension)
    V_EXTENSION = int(micron_in_units * ver_extension)

    if H_EXTENSION < 0:
        H_EXTENSION = 0

    if V_EXTENSION < 0:
        V_EXTENSION = 0

    H_LAYER = reader.tech.findLayer(hor_layer)
    V_LAYER = reader.tech.findLayer(ver_layer)

    H_WIDTH = int(Decimal(hor_width_mult) * H_LAYER.getWidth())
    V_WIDTH = int(Decimal(ver_width_mult) * V_LAYER.getWidth())

    if hor_length is not None:
        H_LENGTH = int(micron_in_units * hor_length)
    else:
        H_LENGTH = max(
            int(
                math.ceil(
                    H_LAYER.getArea() * micron_in_units * micron_in_units / H_WIDTH
                )
            ),
            H_WIDTH,
        )

    if ver_length is not None:
        V_LENGTH = int(micron_in_units * ver_length)
    else:
        V_LENGTH = max(
            int(
                math.ceil(
                    V_LAYER.getArea() * micron_in_units * micron_in_units / V_WIDTH
                )
            ),
            V_WIDTH,
        )

    with config_file_name.open(encoding="utf8") as file:
        config_data = yaml.safe_load(file)

    info_by_side = {side: [] for side in ("N", "E", "S", "W")}

    for side, segments in config_data.items():
        for segment in segments:
            sort_mode_str = segment.get("sort_mode", "bus_major")
            if sort_mode_str == "bus_major":
                sort_mode = ioplace_parser.Order.busMajor
            elif sort_mode_str == "bus_minor":
                sort_mode = ioplace_parser.Order.busMinor
            else:
                raise ValueError(f"Unknown sort mode {sort_mode_str}")
            info_by_side[side].append(
                SegmentInfo(
                    min_distance=segment.get("min_distance"),
                    max_distance=segment.get("max_distance"),
                    pins=segment.get("pins", []),
                    sort_mode=sort_mode,
                    reverse_result=segment.get("reverse_result", False),
                )
            )

    logger.debug("info_by_side: %s", info_by_side)
    logger.info("Top-level design name: %s", reader.name)

    bterms = [
        bterm
        for bterm in reader.block.getBTerms()
        if bterm.getSigType() not in ["POWER", "GROUND"]
    ]

    for side, segments in info_by_side.items():
        for side_info in segments:
            min_allowed = (
                (V_WIDTH + V_LAYER.getSpacing())
                if side in ["N", "S"]
                else (H_WIDTH + H_LAYER.getSpacing())
            ) / reader.dbunits
            if side_info.min_distance is None or side_info.min_distance < min_allowed:
                logger.debug(
                    "Adjusting min_distance for side %s segment (given=%s -> %s)",
                    side,
                    side_info.min_distance,
                    min_allowed,
                )
                side_info.min_distance = min_allowed

    # build a list of pins
    pin_placement = {s: [] for s in ("N", "E", "W", "S")}

    regex_by_bterm: dict = {}
    unmatched_regexes: set[str] = set()
    segment_pin_counts = {s: [] for s in ("N", "E", "S", "W")}
    for side, segments in info_by_side.items():
        for seg_idx, seg in enumerate(segments):
            collected_terms: list = []
            count_in_segment = 0
            for pattern in seg.pins:
                if isinstance(pattern, int):
                    pin_placement[side].append(pattern)
                    continue
                anchored = f"^{pattern}$"
                matched_terms = [b for b in bterms if re.match(anchored, b.getName())]
                if not matched_terms:
                    unmatched_regexes.add(pattern)
                    continue
                for b in matched_terms:
                    if b in regex_by_bterm:
                        raise SystemExit(
                            f"[ERROR] Multiple regexes matched {b.getName()}: {regex_by_bterm[b]} and {pattern}"
                        )
                    regex_by_bterm[b] = pattern
                matched_terms.sort(key=partial(sorter, order=seg.sort_mode))
                collected_terms.extend(matched_terms)
                count_in_segment += len(matched_terms)
            pin_placement[side].append(collected_terms)
            segment_pin_counts[side].append(count_in_segment)

    logger.debug("pin_placement (pre random fill): %s", pin_placement)

    # check for extra or missing pins
    not_in_design = unmatched_regexes
    not_in_config = {b.getName() for b in bterms if b not in regex_by_bterm}
    mismatches_found = False
    for is_in, not_in, pins in [
        ("config", "design", not_in_design),
        ("design", "config", not_in_config),
    ]:
        for name in pins:
            if (
                is_in == "config"
                and (unmatched_error in {"unmatched_cfg", "both"})
                or is_in == "design"
                and (unmatched_error in {"unmatched_design", "both"})
            ):
                mismatches_found = True
                logger.error("%s not found in %s but found in %s.", name, not_in, is_in)
            else:
                logger.warning(
                    "%s not found in %s but found in %s.", name, not_in, is_in
                )
    if mismatches_found:
        logger.error("Critical mismatches found.")
        raise SystemExit(os.EX_DATAERR)

    if not_in_config:
        logger.info("Assigning random sides to unmatched pins (no regex match)…")
        for bname in not_in_config:
            bterm = next(bt for bt in bterms if bt.getName() == bname)
            side_choice = random.choice(list(pin_placement.keys()))
            if not pin_placement[side_choice]:
                pin_placement[side_choice].append([])
                segment_pin_counts[side_choice].append(0)
                # Create corresponding entry in info_by_side with default values
                info_by_side[side_choice].append(
                    SegmentInfo(
                        min_distance=None,  # Will be adjusted later
                        max_distance=None,
                        pins=[],
                        sort_mode=ioplace_parser.Order.busMajor,
                        reverse_result=False,
                    )
                )
            seg_choice = random.randrange(len(pin_placement[side_choice]))
            if isinstance(pin_placement[side_choice][seg_choice], int):
                # If the chosen segment is a virtual pin count, create a new segment
                pin_placement[side_choice].append([bterm])
                segment_pin_counts[side_choice].append(1)
                info_by_side[side_choice].append(
                    SegmentInfo(
                        min_distance=None,  # Will be adjusted later
                        max_distance=None,
                        pins=[],
                        sort_mode=ioplace_parser.Order.busMajor,
                        reverse_result=False,
                    )
                )
            else:
                pin_placement[side_choice][seg_choice].append(bterm)
                segment_pin_counts[side_choice][seg_choice] += 1

    # generate slots
    DIE_AREA = reader.block.getDieArea()
    BLOCK_LL_X = DIE_AREA.xMin()
    BLOCK_LL_Y = DIE_AREA.yMin()
    BLOCK_UR_X = DIE_AREA.xMax()
    BLOCK_UR_Y = DIE_AREA.yMax()

    origin_h, count_h, h_step = reader.block.findTrackGrid(H_LAYER).getGridPatternY(0)
    origin_v, count_v, v_step = reader.block.findTrackGrid(V_LAYER).getGridPatternX(0)

    # Build track lists per side with either equal or proportional slices
    h_tracks_E = []
    h_tracks_W = []
    v_tracks_N = []
    v_tracks_S = []

    def build_tracks(count_total, step, origin, side_key, segment_counts):
        """Return list of track coordinate lists per segment.

        Uses proportional allocation (pin-count weighted). If all counts are zero,
        falls back to equal slices.
        """
        tracks_container = []
        segments = pin_placement[side_key]
        num_segments = len(segments)
        if num_segments == 0:
            return tracks_container
        counts = segment_counts[side_key]
        total = sum(counts) if counts else 0
        if total == 0:
            base = count_total // num_segments if num_segments else 0
            slices = [(i * base, base) for i in range(num_segments)]
        else:
            # proportional slices with rounding reconciliation
            fractional = [c / total * count_total for c in counts]
            sizes = [max(1, int(round(f))) for f in fractional]
            delta = count_total - sum(sizes)
            # Distribute remaining tracks using round-robin
            while delta > 0:
                for i in range(num_segments):
                    if delta > 0:
                        sizes[i] += 1
                        delta -= 1
            while delta < 0:
                for i in range(num_segments):
                    if delta < 0 and sizes[i] > 1:
                        sizes[i] -= 1
                        delta += 1
            start = 0
            slices = []
            for size in sizes:
                slices.append((start, size))
                start += size
        for start_idx, size in slices:
            start_coord = origin + start_idx * step
            tracks_container.append(grid_to_tracks(start_coord, size, step))
        return tracks_container

    h_tracks_E = build_tracks(count_h, h_step, origin_h, "E", segment_pin_counts)
    h_tracks_W = build_tracks(count_h, h_step, origin_h, "W", segment_pin_counts)
    v_tracks_N = build_tracks(count_v, v_step, origin_v, "N", segment_pin_counts)
    v_tracks_S = build_tracks(count_v, v_step, origin_v, "S", segment_pin_counts)

    pin_tracks = {"N": [], "E": [], "W": [], "S": []}
    for side, segments in pin_placement.items():
        for segment_n, _segment in enumerate(segments):
            min_distance = info_by_side[side][segment_n].min_distance * micron_in_units
            max_distance = info_by_side[side][segment_n].max_distance
            if max_distance is not None:
                max_distance = max_distance * micron_in_units
            if side == "N":
                raw_tracks = v_tracks_N[segment_n]
                step = v_step
            elif side == "S":
                raw_tracks = v_tracks_S[segment_n]
                step = v_step
            elif side == "E":
                raw_tracks = h_tracks_E[segment_n]
                step = h_step
            else:  # W
                raw_tracks = h_tracks_W[segment_n]
                step = h_step
            stride = max(1, math.ceil(min_distance / step))
            filtered = [raw_tracks[i] for i in range(0, len(raw_tracks), stride)]
            # Enforce max_distance: ensure distance between consecutive chosen tracks
            if max_distance is not None:
                max_stride = max(1, math.floor(max_distance / step))
                # If current stride causes larger gaps, insert intermediate tracks
                enforced = []
                last_index = None
                for idx in range(len(raw_tracks)):
                    if idx % stride == 0:
                        if last_index is None:
                            enforced.append(raw_tracks[idx])
                            last_index = idx
                        else:
                            if idx - last_index > max_stride:
                                # add intermediate indices to satisfy max_distance
                                interim = last_index + max_stride
                                while interim < idx:
                                    enforced.append(raw_tracks[interim])
                                    interim += max_stride
                            enforced.append(raw_tracks[idx])
                            last_index = idx
                filtered = enforced
            needed = sum(
                1 for p in pin_placement[side][segment_n] if not isinstance(p, int)
            )
            if needed > len(filtered):
                logger.error(
                    (
                        "Insufficient tracks: min_distance=%.3f µm side=%s seg=%d "
                        "needed=%d pins got=%d slots stride=%d raw=%d"
                    ),
                    info_by_side[side][segment_n].min_distance,
                    side,
                    segment_n,
                    needed,
                    len(filtered),
                    stride,
                    len(raw_tracks),
                )
                logger.error(
                    "Hint: reduce min_distance, enlarge die, or redistribute pins."
                )
                raise SystemExit(os.EX_DATAERR)
            pin_tracks[side].append(filtered)

    # reversals (including randomly-assigned pins, if needed)
    for side, segments in info_by_side.items():
        for segment_n, side_info in enumerate(segments):
            if side_info.reverse_result:
                pin_placement[side][segment_n].reverse()

    # create the pins
    for side, segments in pin_placement.items():
        for segment_n, _segment in enumerate(segments):
            logger.debug(
                "Placing side=%s seg=%d pins=%d slots=%d",
                side,
                segment_n,
                len(pin_placement[side][segment_n]),
                len(pin_tracks[side][segment_n]),
            )

            slots, pin_placement[side][segment_n] = equally_spaced_sequence(
                side, pin_placement[side][segment_n], pin_tracks[side][segment_n]
            )

            logger.debug(
                "Slots assigned = %d (pins=%d)",
                len(slots),
                len(pin_placement[side][segment_n]),
            )
            assert len(slots) == len(pin_placement[side][segment_n])

            for i in range(len(pin_placement[side][segment_n])):
                bterm = pin_placement[side][segment_n][i]
                slot = slots[i]
                pin_name = bterm.getName()
                logger.debug("%s -> %d", pin_name, slot)
                pins = bterm.getBPins()
                if len(pins) > 0:
                    logger.warning(
                        "%s already has shapes. Modifying existing shape.", pin_name
                    )
                    assert len(pins) == 1
                    pin_bpin = pins[0]
                else:
                    pin_bpin = odb.dbBPin_create(bterm)

                pin_bpin.setPlacementStatus("PLACED")

                if side in ["N", "S"]:
                    rect = odb.Rect(0, 0, V_WIDTH, V_LENGTH + V_EXTENSION)
                    if side == "N":
                        y = BLOCK_UR_Y - V_LENGTH
                    else:
                        y = BLOCK_LL_Y - V_EXTENSION
                    rect.moveTo(slot - V_WIDTH // 2, y)
                    odb.dbBox_create(pin_bpin, V_LAYER, *rect.ll(), *rect.ur())
                else:
                    rect = odb.Rect(0, 0, H_LENGTH + H_EXTENSION, H_WIDTH)
                    if side == "E":
                        x = BLOCK_UR_X - H_LENGTH
                    else:
                        x = BLOCK_LL_X - H_EXTENSION
                    rect.moveTo(x, slot - H_WIDTH // 2)
                    odb.dbBox_create(pin_bpin, H_LAYER, *rect.ll(), *rect.ur())


if __name__ == "__main__":
    io_place()
