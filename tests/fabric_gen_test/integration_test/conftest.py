"""Shared fixtures and cocotb-time helpers for FABulous integration tests.

The module bundles two things that integration tests need:

* the :class:`PCF` class and the :func:`upload_bitstream` / :func:`zero_bitstream`
  coroutines that drive a generated fabric DUT inside a cocotb simulation, and
* pytest fixtures that orchestrate the end-to-end flow (generate a demo
  project, run FABulous, hand the resulting bitstream + sources off to the
  ``cocotb_runner`` fixture defined one level up).

The cocotb-time helpers are ported from
``mole99/tt-fabulous-ihp-26a/tb/testcases/common.py`` (Apache-2.0,
© 2026 FABulous Contributors / Leo Moser) and reworked to follow FABulous
coding taste: ``loguru`` for logging, ``pathlib`` paths, explicit type hints,
NumPy-style docstrings.

Cocotb test modules under ``tests/fabric_gen_test/integration_test/`` import
the helpers via ``from conftest import PCF, upload_bitstream, zero_bitstream``;
when the orchestration fixture invokes ``cocotb_runner`` it copies this file
next to the test module so the simulator-side ``import conftest`` resolves.
"""

# cspell:words tilex tiley netlist Gtkw gtkw cocotb noqa hdl pnr bitgen

import re
import subprocess
from pathlib import Path
from typing import Protocol

import cocotb
import pytest
from cocotb.handle import HierarchyObject, LogicObject
from cocotb.triggers import Timer
from cocotb.types import Logic, LogicArray
from dotenv import unset_key
from loguru import logger


@pytest.fixture(autouse=True)
def _disable_pdk_download(monkeypatch: pytest.MonkeyPatch, tmp_path: Path) -> None:
    monkeypatch.delenv("FAB_PDK", raising=False)
    monkeypatch.delenv("FAB_PDK_ROOT", raising=False)

    real_run = subprocess.run

    def scrubbing_run(*args: object, **kwargs: object) -> subprocess.CompletedProcess:
        result = real_run(*args, **kwargs)
        for env_file in tmp_path.rglob(".FABulous/.env"):
            unset_key(env_file, "FAB_PDK")
            unset_key(env_file, "FAB_PDK_ROOT")
        return result

    monkeypatch.setattr(subprocess, "run", scrubbing_run)


# --------------------------------------------------------------------------- #
# Bitstream protocol constants                                                #
# --------------------------------------------------------------------------- #

FRAME_BITS_PER_ROW: int = 32
MAX_FRAMES_PER_COL: int = 20
FRAME_SELECT_WIDTH: int = 5  # hardcoded, derived from FABRIC_NUM_COLUMNS

BITSTREAM_START: int = 0xFAB0FAB1
DESYNC_FLAG: int = 20


class FabricConfigDUT(Protocol):
    """Structural protocol for a fabric DUT that exposes config-frame pins."""

    FrameData: LogicObject
    FrameStrobe: LogicObject


class FabricClockedDUT(FabricConfigDUT, Protocol):
    """Fabric DUT that also exposes the top-level ``UserCLK`` input."""

    UserCLK: LogicObject


# --------------------------------------------------------------------------- #
# PCF parsing and DUT signal resolution                                       #
# --------------------------------------------------------------------------- #

# set_io <signal>[<index>] X<tile_x>Y<tile_y>/<bel>
_PCF_LINE_RE = re.compile(
    r"\s*set_io\s+(?P<signal>\w+)(\[(?P<index>\d+)?\])?\s+"
    r"X(?P<tilex>\d+)Y(?P<tiley>\d+)\/(?P<bel>\w+)"
)

# Tile_X<tile_x>Y<tile_y>_<bel>_<port>_top[<bit_index>]
#
# FABulous's W_IO/IO_1_bidirectional_frame_config_pass bel exposes three top-level
# ports per instance:
#
#   I_top  — fabric drives this OUT to the external pad   (testbench reads it)
#   O_top  — external pad drives this IN to the fabric    (testbench writes it)
#   T_top  — tristate enable, fabric drives
#
# Upstream mole99's naming is testbench-centric ("IN" means the testbench's
# read direction, which is the fabric's output side). Map accordingly so a
# PCF written for the upstream convention works against vanilla FABulous.
_PORT_NAME_RE = re.compile(
    r"^Tile_X(?P<tilex>\d+)Y(?P<tiley>\d+)_(?P<bel>\w)_"
    r"(?P<port>I|O|T)_top(?P<bit>\d*)$",
    re.IGNORECASE,
)

# PCF semantic direction → FABulous bel top-port letter.
_USE_TO_PORT: dict[str, str] = {"IN": "I", "OUT": "O", "EN": "T"}


class PCF:
    """Resolve user-design signals on a generated FABulous fabric DUT.

    A FABulous ``.pcf`` file maps a user-design signal name to a fabric
    location::

        set_io a[3]       X1Y2/A
        set_io clk        X3Y0/B

    `PCF` parses such a file, then walks the cocotb top-level handle
    to bind each ``<signal>[<index>]`` to the matching
    `Tile_X#Y#_<bel>_<use>_top` ports for `IN` (drive into fabric),
    `OUT`` (read from fabric) and ``EN`` (output-enable) directions. Tests
    can then drive or sample signals **by user name** instead of touching
    tile-relative ports, which keeps the test code portable across fabric
    layouts.

    FABulous bit-indexes external ports as `..._top<bit_index>` (e.g.
    `Tile_X1Y2_A_IN_top0`). The mole99 implementation expected a plain
    `..._top` suffix; this port handles both forms so it works against
    vanilla FABulous output and against the IHP-26A fabric variant.

    Parameters
    ----------
    dut : HierarchyObject
        cocotb top-level handle for the fabric netlist (e.g. `eFPGA`).
    file : Path
        Path to a FABulous `.pcf` constraint file produced by the design
        flow (typically `<design>.pcf` or `.FABulous/template.pcf`).

    Attributes
    ----------
    top : str
        Name of the DUT top-level module (used by `write_gtkw`).
    signals : dict[str, dict[int, dict[str, LogicObject]]]
        `{signal_name: {bit_index: {"IN": handle, "OUT": handle,
        "EN": handle}}}`.
    """

    def __init__(self, dut: HierarchyObject, file: Path) -> None:
        file = Path(file)
        # cocotb exposes `_name` as the canonical handle identifier;
        # the leading underscore avoids clashes with HDL signal names.
        self.top: str = dut._name  # noqa: SLF001
        self.signals: dict[str, dict[int, dict[str, LogicObject]]] = {}

        self._port_index: dict[tuple[str, str, str, str], LogicObject] = {}
        for element in dut:
            match = _PORT_NAME_RE.match(element._name)  # noqa: SLF001
            if match is None:
                continue
            key = (
                match.group("tilex"),
                match.group("tiley"),
                match.group("bel").lower(),
                match.group("port").lower(),
            )
            self._port_index[key] = element

        logger.info(f"Reading PCF file: {file}")
        with file.open("r") as pcf_file:
            for line in pcf_file:
                match = _PCF_LINE_RE.match(line)
                if match is None:
                    continue
                self._bind_line(match)

    def _bind_line(self, match: re.Match[str]) -> None:
        """Bind a single ``set_io`` line to the matching DUT ports."""
        signal = match.group("signal")
        index = int(match.group("index")) if match.group("index") is not None else 0
        tile_x = match.group("tilex")
        tile_y = match.group("tiley")
        bel = match.group("bel")

        dut_in = self._find_signal(tile_x, tile_y, bel, use="IN")
        dut_out = self._find_signal(tile_x, tile_y, bel, use="OUT")
        dut_en = self._find_signal(tile_x, tile_y, bel, use="EN")
        if dut_in is None or dut_out is None or dut_en is None:
            raise ValueError(
                f"PCF line maps {signal}[{index}] to X{tile_x}Y{tile_y}/{bel} "
                "but no matching IN/OUT/EN port was found on the DUT"
            )

        entry = {"IN": dut_in, "OUT": dut_out, "EN": dut_en}
        self.signals.setdefault(signal, {})[index] = entry
        # Keep deterministic ordering so iteration matches the bit order users
        # expect when reading multi-bit signals.
        self.signals[signal] = dict(sorted(self.signals[signal].items()))

    def _find_signal(
        self,
        tile_x: str,
        tile_y: str,
        bel: str,
        use: str,
    ) -> LogicObject | None:
        """Look up an indexed port by tile coordinates, bel letter and use."""
        key = (tile_x, tile_y, bel.lower(), _USE_TO_PORT[use].lower())
        return self._port_index.get(key)

    def get(self, signal: str, index: int | None = None) -> LogicArray | Logic:
        """Read the current ``IN`` value of ``signal``.

        Parameters
        ----------
        signal : str
            User-design signal name as it appears in the PCF.
        index : int, optional
            If ``None`` (default), the whole bus is returned as a
            :class:`LogicArray`. Otherwise a single bit as a :class:`Logic`.
        """
        if index is None:
            bits = "".join(
                str(bit["IN"].value) for bit in reversed(self.signals[signal].values())
            )
            return LogicArray(bits)
        return Logic(self.signals[signal][index]["IN"].value)

    def set(
        self,
        signal: str,
        value: LogicArray | Logic,
        index: int | None = None,
    ) -> None:
        """Drive ``value`` onto the ``OUT`` (fabric-input) pins of ``signal``.

        Parameters
        ----------
        signal : str
            User-design signal name as it appears in the PCF.
        value : LogicArray or Logic
            New value. Must be a :class:`LogicArray` of matching width when
            ``index`` is ``None``, otherwise a single :class:`Logic`.
        index : int, optional
            If given, only this bit is updated.
        """
        if index is None:
            for bit_index, bit in enumerate(reversed(value)):
                self.signals[signal][bit_index]["OUT"].value = bit
        else:
            self.signals[signal][index]["OUT"].value = value

    def get_raw(self, signal: str, use: str, index: int = 0) -> LogicObject:
        """Return the raw cocotb handle for a signal pin.

        Use this when you need a handle for triggers (e.g. ``RisingEdge``) or
        for clocking a generated clock onto a routed input.

        Parameters
        ----------
        signal : str
            User-design signal name.
        use : str
            ``"IN"``, ``"OUT"`` or ``"EN"``.
        index : int, optional
            Bit index. Default ``0``.
        """
        return self.signals[signal][index][use]


# --------------------------------------------------------------------------- #
# Cocotb-time helpers (bitstream upload)                                      #
# --------------------------------------------------------------------------- #


async def zero_bitstream(dut: FabricConfigDUT, delay_ns: int = 10) -> None:
    """Drive an all-zeros frame across every column to clear configuration.

    Useful before loading a new user design to scrub any latched config bits
    from a previous test, which can otherwise leave combinational loops in
    the routing fabric.

    Parameters
    ----------
    dut : FabricConfigDUT
        cocotb top-level handle exposing ``FrameData`` and ``FrameStrobe``.
    delay_ns : int, optional
        Duration each phase is held, in nanoseconds. Default ``10``.
    """
    dut.FrameData.value = 0
    dut.FrameStrobe.value = (1 << len(dut.FrameStrobe)) - 1
    await Timer(delay_ns, unit="ns")

    dut.FrameStrobe.value = 0
    await Timer(delay_ns, unit="ns")


async def upload_bitstream(
    dut: FabricConfigDUT,
    bitstream_path: Path,
    delay_ns: int = 10,
    num_data_rows: int | None = None,
) -> None:
    """Stream a `.bin` bitstream file into the fabric configuration ports.

    Parameters
    ----------
    dut : FabricConfigDUT
        cocotb top-level handle exposing `FrameData` and `FrameStrobe`.
    bitstream_path : Path
        Path to a FABulous `.bin` bitstream.
    delay_ns : int, optional
        Duration each strobe is held high (and then low) per row, in
        nanoseconds. Default `10`.
    num_data_rows : int, optional
        Number of 32-bit row words per frame in the bitstream payload.

    Raises
    ------
    FileNotFoundError
        If ``bitstream_path`` does not exist.
    ValueError
        If the file ends before the sync word is found.
    """
    bitstream_path = Path(bitstream_path)
    logger.info(f"Uploading bitstream: {bitstream_path}")

    framedata_bits = len(dut.FrameData)
    framestrobe_bits = len(dut.FrameStrobe)
    rows_per_frame = (
        num_data_rows
        if num_data_rows is not None
        else framedata_bits // FRAME_BITS_PER_ROW
    )

    with bitstream_path.open("rb") as f:
        # Skip header words until the sync marker is seen.
        synced = False
        while data := f.read(4):
            if int.from_bytes(data, "big") == BITSTREAM_START:
                logger.debug("Detected bitstream start marker")
                synced = True
                break
        if not synced:
            raise ValueError(
                f"Sync word 0x{BITSTREAM_START:08X} not found in {bitstream_path}"
            )

        # Stream frame payload until a desync header arrives or the file ends.
        while True:
            data = f.read(4)
            if not data:
                logger.warning(
                    f"Bitstream {bitstream_path} ended without a DESYNC header"
                )
                break

            header = int.from_bytes(data, "big")
            column_select = (header >> 27) & 0x1F  # bits [31:27]
            sync_bit = (header >> DESYNC_FLAG) & 0x1  # bit 20
            frame_strobe = header & 0xFFFFF  # bits [19:0]

            if sync_bit:
                logger.debug("Detected DESYNC flag, ending upload")
                break

            all_row_data = 0
            for _ in range(rows_per_frame):
                row_word = int.from_bytes(f.read(4), "big")
                all_row_data = (all_row_data << FRAME_BITS_PER_ROW) | row_word

            dut.FrameData.value = all_row_data << FRAME_BITS_PER_ROW
            dut.FrameStrobe.value = frame_strobe << (MAX_FRAMES_PER_COL * column_select)
            await Timer(delay_ns, unit="ns")

            dut.FrameStrobe.value = 0
            await Timer(delay_ns, unit="ns")

        logger.info(f"Bitstream upload completed ({framestrobe_bits} strobe bits)")

        # Park the config ports.
        dut.FrameData.value = 0
        dut.FrameStrobe.value = 0
        await Timer(delay_ns, unit="ns")


async def setup_fabric(dut: FabricConfigDUT, settle_ns: int = 10) -> PCF:
    """Bring up the fabric DUT and return a parsed PCF.

    Reads the PCF / bitstream / row-count paths the pytest fixture handed
    over via `cocotb.plusargs` (`FAB_PCF`, `FAB_BIT`,
    `FAB_NUM_DATA_ROWS`), zeros the configuration, streams the bitstream
    in, and waits `settle_ns` between each phase so combinational paths
    propagate.

    Returns the :class:`PCF` so tests can drive/sample by user-design
    signal name without repeating the boilerplate.

    Parameters
    ----------
    dut : FabricConfigDUT
        cocotb top-level handle.
    settle_ns : int, optional
        Per-phase settling delay in ns. Default ``10``.
    """
    pcf = PCF(dut, Path(cocotb.plusargs["FAB_PCF"]))
    await zero_bitstream(dut)
    await Timer(settle_ns, unit="ns")
    await upload_bitstream(
        dut,
        Path(cocotb.plusargs["FAB_BIT"]),
        num_data_rows=int(cocotb.plusargs["FAB_NUM_DATA_ROWS"]),
    )
    await Timer(settle_ns, unit="ns")
    return pcf


# --------------------------------------------------------------------------- #
# Pytest orchestration: shared constants and source collection                #
# --------------------------------------------------------------------------- #


def _collect_fabric_sources(project_dir: Path, suffix: str) -> list[Path]:
    """Return every HDL source emitted under ``Fabric/`` and ``Tile/``.

    FABulous emits the same module (e.g. ``Config_access.v``) under multiple
    tile directories with identical content. The reference iverilog flow
    deduplicates by basename via ``cp -n`` (no-clobber); this function does
    the same so the simulator sees one definition per module name.
    """
    # NVC analyzes files in command-line order and rejects forward references,
    # so the FABulous-wide `models_pack` package must come first.
    fabric_paths = sorted((project_dir / "Fabric").glob(f"*{suffix}"))
    package_paths = [p for p in fabric_paths if p.stem == "models_pack"]
    other_fabric_paths = [p for p in fabric_paths if p.stem != "models_pack"]

    sources: list[Path] = []
    seen_names: set[str] = set()
    for path in (
        *package_paths,
        *sorted((project_dir / "Tile").rglob(f"*{suffix}")),
        *other_fabric_paths,
    ):
        if path.name in seen_names:
            logger.debug(f"Skipping duplicate-named fabric source: {path}")
            continue
        seen_names.add(path.name)
        sources.append(path)
    return sources


_USER_DESIGNS_DIR = Path(__file__).resolve().parent / "user_designs"
_USER_DESIGNS_PCF = _USER_DESIGNS_DIR / "constraints.pcf"
