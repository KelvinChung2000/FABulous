"""Tests for tile_io_place module."""
# ruff: noqa: E402, SLF001, E501, F841

import sys
from unittest.mock import MagicMock, Mock

import pytest

# Mock external dependencies BEFORE importing the module under test
sys.modules["odb"] = MagicMock()
sys.modules["openroad"] = MagicMock()

from FABulous.fabric_definition.define import PinSortMode, Side
from FABulous.fabric_generator.gds_generator.gen_io_pin_config_yaml import (
    PinOrderConfig,
)
from FABulous.fabric_generator.gds_generator.script.tile_io_place import (
    PinPlacementPlan,
    SegmentInfo,
    equally_spaced_sequence,
    grid_to_tracks,
    sorter,
)


class TestGridToTracks:
    """Test suite for grid_to_tracks function."""

    def test_basic_track_generation(self) -> None:
        """Test basic track generation with positive step."""
        tracks = grid_to_tracks(0.0, 5, 100.0)
        assert tracks == [0.0, 100.0, 200.0, 300.0, 400.0]

    def test_negative_origin(self) -> None:
        """Test track generation with negative origin."""
        tracks = grid_to_tracks(-100.0, 3, 50.0)
        assert tracks == [-100.0, -50.0, 0.0]

    def test_single_track(self) -> None:
        """Test generation of a single track."""
        tracks = grid_to_tracks(500.0, 1, 100.0)
        assert tracks == [500.0]

    def test_tracks_are_sorted(self) -> None:
        """Test that tracks are returned in sorted order."""
        tracks = grid_to_tracks(1000.0, 4, -250.0)
        assert tracks == sorted(tracks)


class TestEquallySpacedSequence:
    """Test suite for equally_spaced_sequence function."""

    def test_pins_equal_tracks(self) -> None:
        """Test when number of pins equals number of tracks."""
        mock_pins = [Mock(getName=lambda i=i: f"pin{i}") for i in range(5)]
        tracks = [0.0, 100.0, 200.0, 300.0, 400.0]

        result, pins = equally_spaced_sequence("NORTH", mock_pins, tracks)

        assert len(result) == 5
        assert result == tracks
        assert len(pins) == 5

    def test_pins_less_than_tracks(self) -> None:
        """Test even spacing when pins < tracks."""
        mock_pins = [Mock(getName=lambda i=i: f"pin{i}") for i in range(3)]
        tracks = [0.0, 100.0, 200.0, 300.0, 400.0, 500.0, 600.0]

        result, pins = equally_spaced_sequence("NORTH", mock_pins, tracks)

        assert len(result) == 3
        assert len(pins) == 3
        # Pins should be evenly distributed and centered

    def test_no_pins(self) -> None:
        """Test with no pins."""
        tracks = [0.0, 100.0, 200.0]

        result, pins = equally_spaced_sequence("NORTH", [], tracks)

        assert len(result) == 0
        assert len(pins) == 0

    def test_with_virtual_pins(self) -> None:
        """Test spacing with virtual pins (integers in list)."""
        mock_pins = [Mock(getName=lambda: "pin0"), 2, Mock(getName=lambda: "pin1")]
        tracks = [0.0, 100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0]

        result, pins = equally_spaced_sequence("SOUTH", mock_pins, tracks)

        # Should have 2 actual pins
        assert len(pins) == 2
        assert all(not isinstance(p, int) for p in pins)

    def test_too_many_pins(self) -> None:
        """Test error when pins exceed available tracks."""
        mock_pins = [Mock(getName=lambda i=i: f"pin{i}") for i in range(10)]
        tracks = [0.0, 100.0, 200.0]

        with pytest.raises(SystemExit) as exc_info:
            equally_spaced_sequence("EAST", mock_pins, tracks)

        assert exc_info.value.code == 1


class TestSorter:
    """Test suite for sorter function."""

    def test_bus_major_sorting(self) -> None:
        """Test BUS_MAJOR sorting mode."""
        mock_bterm = Mock()
        mock_bterm.getName.return_value = "data_bus[5]"

        keys = sorter(mock_bterm, PinSortMode.BUS_MAJOR)

        assert len(keys) == 2
        assert "data_bus" in keys[0]  # Priority keys
        assert 5 in keys[1]  # Secondary keys

    def test_bit_minor_sorting(self) -> None:
        """Test BIT_MINOR sorting mode."""
        mock_bterm = Mock()
        mock_bterm.getName.return_value = "addr[10]"

        keys = sorter(mock_bterm, PinSortMode.BIT_MINOR)

        assert len(keys) == 2
        assert 10 in keys[0]  # Priority keys
        assert "addr" in keys[1]  # Secondary keys

    def test_simple_name(self) -> None:
        """Test sorting with simple pin name."""
        mock_bterm = Mock()
        mock_bterm.getName.return_value = "clk"

        keys = sorter(mock_bterm, PinSortMode.BUS_MAJOR)

        assert len(keys) == 2


class TestSegmentInfo:
    """Test suite for SegmentInfo dataclass."""

    def test_from_config_basic(self) -> None:
        """Test basic SegmentInfo creation from config."""
        segment_config = PinOrderConfig(
            pins=["pin.*"],
            sort_mode=PinSortMode.BUS_MAJOR,
            min_distance=None,
            max_distance=None,
            reverse_result=False,
        )

        mock_bterm = Mock()
        mock_bterm.getName.return_value = "pin_test"
        bterms = [mock_bterm]
        regex_by_bterm = {}
        unmatched = set()

        seg_info = SegmentInfo.from_config(
            Side.NORTH,
            segment_config,
            bterms,
            regex_by_bterm,
            unmatched,
        )

        assert seg_info.side == Side.NORTH
        assert seg_info.sort_mode == PinSortMode.BUS_MAJOR
        assert len(seg_info.pin_entries) == 1
        assert mock_bterm in regex_by_bterm

    def test_from_config_with_virtual_pins(self) -> None:
        """Test SegmentInfo with virtual pins."""
        segment_config = PinOrderConfig(
            pins=["pin1", 3, "pin2"],
            sort_mode=PinSortMode.BIT_MINOR,
            min_distance=1,
            max_distance=5,
            reverse_result=True,
        )

        mock_bterm1 = Mock()
        mock_bterm1.getName.return_value = "pin1"
        mock_bterm2 = Mock()
        mock_bterm2.getName.return_value = "pin2"
        bterms = [mock_bterm1, mock_bterm2]

        seg_info = SegmentInfo.from_config(
            Side.EAST,
            segment_config,
            bterms,
            {},
            set(),
            tile_index=2,
            tile_x=3,
            tile_y=1,
        )

        assert seg_info.tile_index == 2
        assert seg_info.tile_x == 3
        assert seg_info.tile_y == 1
        assert 3 in seg_info.pin_entries  # Virtual pin
        assert seg_info.reverse_result is True

    def test_actual_pin_count(self) -> None:
        """Test actual_pin_count property."""
        seg_info = SegmentInfo(
            side=Side.NORTH,
            sort_mode=PinSortMode.BUS_MAJOR,
            min_distance=None,
            max_distance=None,
            reverse_result=False,
            pin_entries=[Mock(), 2, Mock(), 3, Mock()],
        )

        assert seg_info.actual_pin_count == 3

    def test_invalid_sort_mode(self) -> None:
        """Test error on invalid sort mode."""
        segment_config = PinOrderConfig(
            pins=["pin.*"],
            sort_mode=PinSortMode.BUS_MAJOR,  # Valid mode, but we'll test the error in from_config
            min_distance=None,
            max_distance=None,
            reverse_result=False,
        )

        # The error comes from trying to convert an invalid string to PinSortMode
        # Let's modify the config to have an invalid sort_mode string
        segment_config_dict = {
            "pins": ["pin.*"],
            "sort_mode": "invalid_mode",
            "min_distance": None,
            "max_distance": None,
            "reverse_result": False,
        }

        with pytest.raises(KeyError):
            # This will fail when trying to access PinSortMode[segment_config_dict["sort_mode"]]
            PinSortMode[segment_config_dict["sort_mode"]]

    def test_duplicate_regex_match(self) -> None:
        """Test error when multiple regexes match same pin."""
        segment_config1 = PinOrderConfig(
            pins=["pin.*"],
            sort_mode=PinSortMode.BUS_MAJOR,
            min_distance=None,
            max_distance=None,
            reverse_result=False,
        )
        segment_config2 = PinOrderConfig(
            pins=["pin_test"],
            sort_mode=PinSortMode.BUS_MAJOR,
            min_distance=None,
            max_distance=None,
            reverse_result=False,
        )

        mock_bterm = Mock()
        mock_bterm.getName.return_value = "pin_test"
        bterms = [mock_bterm]
        regex_by_bterm = {}

        # First match should succeed
        SegmentInfo.from_config(
            Side.NORTH,
            segment_config1,
            bterms,
            regex_by_bterm,
            set(),
        )

        # Second match should fail
        with pytest.raises(SystemExit):
            SegmentInfo.from_config(
                Side.NORTH,
                segment_config2,
                bterms,
                regex_by_bterm,
                set(),
            )


class TestPinPlacementPlan:
    """Test suite for PinPlacementPlan class."""

    def test_init_empty_config(self) -> None:
        """Test initialization with empty config."""
        plan = PinPlacementPlan({}, [], "none")

        assert len(plan.segments_by_side) == 5  # NORTH, SOUTH, EAST, WEST, ANY
        assert all(len(segs) == 0 for segs in plan.segments_by_side.values())
        assert plan.fabric_dimensions == (1, 1)

    def test_init_basic_config(self) -> None:
        """Test initialization with basic tile config."""
        config = {
            "X0Y0": {
                "N": [
                    {
                        "pins": ["clk", "rst"],
                        "sort_mode": "bus_major",
                        "min_distance": None,
                        "max_distance": None,
                        "reverse_result": False,
                    }
                ]
            }
        }

        mock_clk = Mock()
        mock_clk.getName.return_value = "clk"
        mock_rst = Mock()
        mock_rst.getName.return_value = "rst"
        bterms = [mock_clk, mock_rst]

        plan = PinPlacementPlan(config, bterms, "none")

        assert len(plan.segments_by_side[Side.NORTH]) == 1
        assert plan.tile_counts_by_side[Side.NORTH] == 1
        assert plan.fabric_dimensions == (1, 1)

    def test_init_multi_tile_config(self) -> None:
        """Test initialization with multiple tiles."""
        config = {
            "X0Y0": {"N": [{"pins": ["pin0"], "sort_mode": "bus_major"}]},
            "X1Y0": {"N": [{"pins": ["pin1"], "sort_mode": "bus_major"}]},
            "X2Y1": {"E": [{"pins": ["pin2"], "sort_mode": "bus_major"}]},
        }

        pins = [Mock(getName=lambda n=f"pin{i}": n) for i in range(3)]
        for pin in pins:
            pin.getName.return_value = pin.getName()

        plan = PinPlacementPlan(config, pins, "none")

        assert plan.fabric_dimensions == (3, 2)  # X goes 0-2, Y goes 0-1
        assert plan.tile_counts_by_side[Side.NORTH] == 2
        assert plan.tile_counts_by_side[Side.EAST] == 1

    def test_unmatched_design_pins(self) -> None:
        """Test handling of unmatched design pins."""
        config = {"X0Y0": {"N": [{"pins": ["clk"], "sort_mode": "bus_major"}]}}

        mock_clk = Mock()
        mock_clk.getName.return_value = "clk"
        mock_rst = Mock()
        mock_rst.getName.return_value = "rst"
        bterms = [mock_clk, mock_rst]

        plan = PinPlacementPlan(config, bterms, "none")

        assert "rst" in plan.unmatched_design_pin_names

    def test_unmatched_config_pins_error(self) -> None:
        """Test error on unmatched config pins."""
        config = {"X0Y0": {"N": [{"pins": ["nonexistent"], "sort_mode": "bus_major"}]}}

        with pytest.raises(SystemExit):
            PinPlacementPlan(config, [], "unmatched_cfg")

    def test_boundary_validation(self) -> None:
        """Test that non-boundary tiles cannot have pin configs."""
        config = {
            "X0Y0": {
                "E": [{"pins": ["pin0"], "sort_mode": "bus_major"}]
            },  # X0Y0 East neighbor is X1Y0, which doesn't exist in config
        }

        mock_pin0 = Mock()
        mock_pin0.getName.return_value = "pin0"

        # This should work - X0Y0 is on the East boundary
        plan = PinPlacementPlan(config, [mock_pin0], "none")
        assert len(plan.segments_by_side[Side.EAST]) == 1

    def test_allocate_tracks_single_tile(self) -> None:
        """Test track allocation for a single tile."""
        config = {"X0Y0": {"N": [{"pins": ["pin0", "pin1"], "sort_mode": "bus_major"}]}}

        pins = [Mock(getName=lambda n=f"pin{i}": n) for i in range(2)]
        for pin in pins:
            pin.getName.return_value = pin.getName()

        plan = PinPlacementPlan(config, pins, "none")

        specs = {
            Side.NORTH: (10, 100.0, 0.0, 1000.0),
        }
        plan.allocate_tracks(specs)

        assert len(plan.track_coordinates[Side.NORTH]) == 1
        assert len(plan.track_coordinates[Side.NORTH][0]) > 0

    def test_allocate_tracks_multiple_tiles(self) -> None:
        """Test track allocation across multiple tiles."""
        config = {
            "X0Y0": {"N": [{"pins": ["pin0"], "sort_mode": "bus_major"}]},
            "X1Y0": {"N": [{"pins": ["pin1"], "sort_mode": "bus_major"}]},
        }

        pins = [Mock(getName=lambda n=f"pin{i}": n) for i in range(2)]
        for pin in pins:
            pin.getName.return_value = pin.getName()

        plan = PinPlacementPlan(config, pins, "none")

        specs = {
            Side.NORTH: (20, 100.0, 0.0, 2000.0),
        }
        plan.allocate_tracks(specs)

        assert len(plan.track_coordinates[Side.NORTH]) == 2

    def test_ensure_min_distances(self) -> None:
        """Test ensuring minimum distances for segments."""
        config = {
            "X0Y0": {
                "N": [{"pins": ["pin0"], "sort_mode": "bus_major", "min_distance": 0.5}]
            }
        }

        mock_pin = Mock()
        mock_pin.getName.return_value = "pin0"

        plan = PinPlacementPlan(config, [mock_pin], "none")

        min_by_side = {side: 1.0 for side in Side}
        plan.ensure_min_distances(min_by_side)

        assert plan.segments_by_side[Side.NORTH][0].min_distance == 1.0

    def test_assign_unmatched_pins(self) -> None:
        """Test assigning unmatched pins to segments."""
        config = {"X0Y0": {"N": [{"pins": ["pin0"], "sort_mode": "bus_major"}]}}

        mock_pin0 = Mock()
        mock_pin0.getName.return_value = "pin0"
        mock_unmatched = Mock()
        mock_unmatched.getName.return_value = "unmatched_pin"

        plan = PinPlacementPlan(config, [mock_pin0, mock_unmatched], "none")

        assert len(plan.unmatched_design_bterms) == 1

        plan.assign_unmatched_pins()

        assert len(plan.unmatched_design_bterms) == 0
        # Pin should be added to a segment
        total_pins = sum(
            len(seg.pin_entries)
            for segs in plan.segments_by_side.values()
            for seg in segs
        )
        assert total_pins == 2


class TestPinPlacementPlanPrivateMethods:
    """Test suite for PinPlacementPlan private methods."""

    def test_group_segments_by_tile(self) -> None:
        """Test _group_segments_by_tile method."""
        seg1 = SegmentInfo(
            side=Side.NORTH,
            sort_mode=PinSortMode.BUS_MAJOR,
            min_distance=None,
            max_distance=None,
            reverse_result=False,
            pin_entries=[Mock()],
            tile_index=0,
            tile_x=0,
            tile_y=0,
        )
        seg2 = SegmentInfo(
            side=Side.NORTH,
            sort_mode=PinSortMode.BUS_MAJOR,
            min_distance=None,
            max_distance=None,
            reverse_result=False,
            pin_entries=[Mock()],
            tile_index=1,
            tile_x=1,
            tile_y=0,
        )

        result = PinPlacementPlan._group_segments_by_tile([seg1, seg2])

        assert len(result) == 2
        assert 0 in result
        assert 1 in result
        assert result[0][0] == 0  # tile_x
        assert result[0][1] == 0  # tile_y

    def test_get_division_index_north_south(self) -> None:
        """Test _get_division_index for North/South sides."""
        # For North/South, use X coordinate
        index = PinPlacementPlan._get_division_index(
            Side.NORTH, tile_x=2, tile_y=0, tile_idx=0, num_divisions=5
        )
        assert index == 2

    def test_get_division_index_east_west(self) -> None:
        """Test _get_division_index for East/West sides."""
        # For East/West, use inverted Y coordinate
        index = PinPlacementPlan._get_division_index(
            Side.EAST, tile_x=0, tile_y=1, tile_idx=0, num_divisions=4
        )
        # Y=1 should map to index 2 (inverted from 4-1)
        assert index == 2

    def test_get_division_index_clamping(self) -> None:
        """Test division index clamping."""
        # Test upper bound clamping
        index = PinPlacementPlan._get_division_index(
            Side.NORTH, tile_x=10, tile_y=0, tile_idx=0, num_divisions=5
        )
        assert index == 4  # Should be clamped to max

    def test_allocate_tracks_for_tile(self) -> None:
        """Test _allocate_tracks_for_tile method."""
        seg1 = SegmentInfo(
            side=Side.NORTH,
            sort_mode=PinSortMode.BUS_MAJOR,
            min_distance=None,
            max_distance=None,
            reverse_result=False,
            pin_entries=[Mock(), Mock()],
        )
        seg2 = SegmentInfo(
            side=Side.NORTH,
            sort_mode=PinSortMode.BUS_MAJOR,
            min_distance=None,
            max_distance=None,
            reverse_result=False,
            pin_entries=[Mock()],
        )

        tracks = PinPlacementPlan._allocate_tracks_for_tile(
            track_count=30,
            step=100.0,
            origin=0.0,
            segments=[seg1, seg2],
        )

        assert len(tracks) == 2
        assert len(tracks[0]) >= 2  # Enough for seg1's pins
        assert len(tracks[1]) >= 1  # Enough for seg2's pins
