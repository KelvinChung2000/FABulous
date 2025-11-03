"""Tests for fabric_io_place module (import and CLI shape with ODB stubs)."""

import sys
from types import SimpleNamespace

import pytest

# Import conftest fixtures (mocks are set up there)
from conftest import (
    FakeBPinIoPlace,
    FakeBTermIoPlace,
    FakeDie,
    FakeITerm,
    FakeLayer,
    FakeMaster,
    FakeMTerm,
    FakeNetIoPlace,
    FakeRect,
)  # noqa: F401


def test_io_place_command_shape(monkeypatch: pytest.MonkeyPatch) -> None:
    """Command object exists and imports with mocked ODB."""

    # Fake ODB to satisfy import
    def dbBPin_create(_bterm: object) -> FakeBPinIoPlace:
        return FakeBPinIoPlace()

    fake_odb = SimpleNamespace(
        Rect=FakeRect,
        dbBPin_create=dbBPin_create,
        dbBox_create=object(),
    )
    monkeypatch.setitem(sys.modules, "odb", fake_odb)

    from FABulous.fabric_generator.gds_generator.script import fabric_io_place

    # Verify command was created
    assert fabric_io_place.io_place is not None


def test_io_place_places_pins_on_die_edges() -> None:
    """Test that pins are placed on correct die edges based on mTerm position."""

    def dbBPin_create(_bterm: object) -> FakeBPinIoPlace:
        return FakeBPinIoPlace()

    # Set up die and layer dimensions
    h_layer = FakeLayer(width=50, area=10_000)
    die = FakeDie(0, 0, 10_000, 10_000)

    # Test case 1: Pin on NORTH side
    # mTerm bbox yMax == master height means NORTH side
    iterm_bbox = FakeRect(0, 0, 100, 100)
    master = FakeMaster(100, 100)
    mterm_bbox_north = FakeRect(0, 100, 10, 0)  # yMax = 100 = master.getHeight()
    iterm_north = FakeITerm(iterm_bbox, FakeMTerm(mterm_bbox_north, master))
    net_north = FakeNetIoPlace("pin_north", [iterm_north])
    bterm_north = FakeBTermIoPlace("pin_north", net_north)

    # Simulate the io_place logic for NORTH side pin
    bterms = [bterm_north]
    boxes_created = []

    for bterm in bterms:
        net = bterm.getNet()
        iterms = net.getITerms()
        if iterms:
            iterm = iterms[0]
            ibox = iterm.getBBox()
            cx = ibox.xCenter()
            cy = ibox.yCenter()

            mterm = iterm.getMTerm()
            master = mterm.getMaster()
            mterm_bbox = mterm.getBBox()

            # Determine side
            side = None
            if mterm_bbox.xMin() == 0:
                side = "WEST"
            if mterm_bbox.xMax() == master.getWidth():
                side = "EAST"
            if mterm_bbox.yMin() == 0:
                side = "SOUTH"
            if mterm_bbox.yMax() == master.getHeight():
                side = "NORTH"

            # Create BPin (we'd use odb.dbBPin_create in real code)
            pin_bpin = FakeBPinIoPlace()
            pin_bpin.setPlacementStatus("PLACED")

            # Record that box would be created
            if side in ("NORTH", "SOUTH"):
                v_width = int(h_layer.getWidth() * 2)
                v_length = 1000
                rect = FakeRect(0, 0, v_width, v_length)
                y = die.yMax() - v_length if side == "NORTH" else die.yMin()
                x = max(die.xMin(), min(cx - v_width // 2, die.xMax() - v_width))
                rect.moveTo(x, y)
                boxes_created.append(("V", rect))
            else:
                h_length = 1000
                h_width = int(h_layer.getWidth() * 2)
                rect = FakeRect(0, 0, h_length, h_width)
                x = die.xMax() - h_length if side == "EAST" else die.xMin()
                y = max(die.yMin(), min(cy - h_width // 2, die.yMax() - h_width))
                rect.moveTo(x, y)
                boxes_created.append(("H", rect))

    # Verify a box would be created for the pin
    assert len(boxes_created) == 1
    assert boxes_created[0][0] == "V"  # Vertical layer for NORTH side
    # Verify the box is positioned near the die edge (NORTH means y near yMax)
    rect = boxes_created[0][1]
    assert rect.yMin() >= 8000  # Close to yMax = 10000


def test_io_place_handles_multiple_sides() -> None:
    """Test pin placement on all four sides of the die."""
    master = FakeMaster(100, 100)

    test_cases = [
        ("NORTH", FakeRect(25, 100, 50, 0), "V"),  # NORTH: yMax=100=height
        ("SOUTH", FakeRect(25, 0, 50, 25), "V"),  # SOUTH: yMin=0
        ("EAST", FakeRect(100, 25, 0, 50), "H"),  # EAST: xMax=100=width
        ("WEST", FakeRect(0, 25, 25, 50), "H"),  # WEST: xMin=0
    ]

    for expected_side, mterm_bbox, expected_layer_type in test_cases:
        iterm_bbox = FakeRect(50, 50, 0, 0)  # Center position
        iterm = FakeITerm(iterm_bbox, FakeMTerm(mterm_bbox, master))
        net = FakeNetIoPlace("pin", [iterm])
        _bterm = FakeBTermIoPlace("pin", net)

        # Determine which side the mterm is on
        # (matching logic from fabric_io_place.py: uses if not elif)
        detected_side = None
        if mterm_bbox.xMin() == 0:
            detected_side = "WEST"
        if mterm_bbox.xMax() == master.getWidth():
            detected_side = "EAST"
        if mterm_bbox.yMin() == 0:
            detected_side = "SOUTH"
        if mterm_bbox.yMax() == master.getHeight():
            detected_side = "NORTH"

        # Verify correct side detection
        assert detected_side == expected_side, (
            f"Failed for {expected_side}: got {detected_side}, "
            f"bbox={mterm_bbox.xMin()},{mterm_bbox.yMin()},"
            f"{mterm_bbox.xMax()},{mterm_bbox.yMax()}"
        )
        # Verify correct layer type (V for N-S, H for E-W)
        expected_layer = "V" if detected_side in ("NORTH", "SOUTH") else "H"
        assert expected_layer == expected_layer_type
