import hashlib
import struct
from dataclasses import dataclass, field
from enum import IntEnum
from typing import Optional

from loguru import logger

from FABulous.fabric_cad.bba import BBAWriter
from FABulous.fabric_cad.chip_database_gen.BBAStruct import BBAStruct
from FABulous.fabric_cad.chip_database_gen.database_tile import TileType
from FABulous.fabric_cad.chip_database_gen.database_timing import TimingPool
from FABulous.fabric_cad.chip_database_gen.define import IdString, NodeWire
from FABulous.fabric_cad.chip_database_gen.StringPool import StringPool

"""
This provides a semi-flattened routing graph that is built into a deduplicated one.

There are two key elements:
 - Tile Types:
      these represent a unique kind of grid location in terms of its contents:
       - bels (logic functionality like LUTs, FFs, IOs, IP, etc)
       - internal wires (excluding connectivity to other tiles)
       - pips that switch internal wires
 - Nodes
      these merge tile-internal wires across wires to create inter-tile connectivity
      so, for example, a length-4 wire might connect (x, y, "E4AI") and (x+3, y, "E4AO")
"""


BEL_FLAG_GLOBAL = 0x01
BEL_FLAG_HIDDEN = 0x02


@dataclass
class NodeShape(BBAStruct):
    wires: list[int] = field(default_factory=list)
    timing_index: int = -1

    def key(self):
        m = hashlib.md5()
        m.update(struct.pack("h" * len(self.wires), *self.wires))
        m.update(struct.pack("i", self.timing_index))
        return m.digest()

    def serialise_lists(self, context: str, bba: BBAWriter):
        bba.label(f"{context}_wires")
        for w in self.wires:
            bba.u16(w)
        if len(self.wires) % 2 != 0:
            bba.u16(0)  # alignment

    def serialise(self, context: str, bba: BBAWriter):
        bba.slice(f"{context}_wires", len(self.wires) // 3)
        bba.u32(self.timing_index)  # timing index (not yet used)


class MODE(IntEnum):
    MODE_TILE_WIRE = 0x7000
    MODE_IS_ROOT = 0x7001
    MODE_ROW_CONST = 0x7002
    MODE_GLB_CONST = 0x7003


@dataclass
class RelNodeRef(BBAStruct):
    dx_mode: int = MODE.MODE_TILE_WIRE
    dy: int = 0
    wire: int = 0

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        bba.u16(self.dx_mode)
        bba.u16(self.dy)
        bba.u16(self.wire)


@dataclass
class TileRoutingShape(BBAStruct):
    wire_to_node: list[int] = field(default_factory=list)

    def key(self):
        m = hashlib.md5()
        m.update(struct.pack("h" * len(self.wire_to_node), *self.wire_to_node))
        return m.digest()

    def serialise_lists(self, context: str, bba: BBAWriter):
        bba.label(f"{context}_w2n")
        for x in self.wire_to_node:
            bba.u16(x)
        if len(self.wire_to_node) % 2 != 0:
            bba.u16(0)  # alignment

    def serialise(self, context: str, bba: BBAWriter):
        bba.slice(f"{context}_w2n", len(self.wire_to_node) // 3)
        bba.u32(-1)  # timing index


@dataclass
class TileInst(BBAStruct):
    x: int
    y: int
    type_idx: Optional[int] = None
    name_prefix: IdString = field(default_factory=IdString)
    loc_type: int = 0
    shape: TileRoutingShape = field(default_factory=TileRoutingShape)
    shape_idx: int = -1
    extra_data: object = None

    def serialise_lists(self, context: str, bba: BBAWriter):
        if self.extra_data is not None:
            self.extra_data.serialise_lists(f"{context}_extra_data", bba)
            bba.label(f"{context}_extra_data")
            self.extra_data.serialise(f"{context}_extra_data", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.name_prefix.index)
        bba.u32(self.type_idx)
        bba.u32(self.shape_idx)
        if self.extra_data is not None:
            bba.ref(f"{context}_extra_data")
        else:
            bba.u32(0)


@dataclass
class PadInfo(BBAStruct):
    # package pin name
    package_pin: IdString
    # reference to corresponding bel
    tile: IdString
    bel: IdString
    # function name
    pad_function: IdString
    # index of pin bank
    pad_bank: int
    # extra pad flags
    flags: int
    extra_data: object = None

    def serialise_lists(self, context: str, bba: BBAWriter):
        if self.extra_data is not None:
            self.extra_data.serialise_lists(f"{context}_extra_data", bba)
            bba.label(f"{context}_extra_data")
            self.extra_data.serialise(f"{context}_extra_data", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.package_pin.index)
        bba.u32(self.tile.index)
        bba.u32(self.bel.index)
        bba.u32(self.pad_function.index)
        bba.u32(self.pad_bank)
        bba.u32(self.flags)
        if self.extra_data is not None:
            bba.ref(f"{context}_extra_data")
        else:
            bba.u32(0)


@dataclass
class PackageInfo(BBAStruct):
    strs: StringPool
    name: IdString
    pads: list[PadInfo] = field(default_factory=list)
    extra_data: object = None

    def create_pad(
        self,
        package_pin: str,
        tile: str,
        bel: str,
        pad_function: str,
        pad_bank: int,
        flags: int = 0,
    ):
        pad = PadInfo(
            package_pin=self.strs.id(package_pin),
            tile=self.strs.id(tile),
            bel=self.strs.id(bel),
            pad_function=self.strs.id(pad_function),
            pad_bank=pad_bank,
            flags=flags,
        )
        self.pads.append(pad)
        return pad

    def serialise_lists(self, context: str, bba: BBAWriter):
        for i, pad in enumerate(self.pads):
            pad.serialise_lists(f"{context}_pad{i}", bba)
        bba.label(f"{context}_pads")
        for i, pad in enumerate(self.pads):
            pad.serialise(f"{context}_pad{i}", bba)
        if self.extra_data is not None:
            self.extra_data.serialise_lists(f"{context}_extra_data", bba)
            bba.label(f"{context}_extra_data")
            self.extra_data.serialise(f"{context}_extra_data", bba)

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.name.index)
        bba.slice(f"{context}_pads", len(self.pads))
        if self.extra_data is not None:
            bba.ref(f"{context}_extra_data")
        else:
            bba.u32(0)


@dataclass(frozen=True)
class ChipExtraData(BBAStruct):
    context: int
    belCount: int

    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.context)
        bba.u32(self.belCount)


class Chip:
    def __init__(self, uarch: str, name: str, width: int, height: int):
        self.strs = StringPool()
        self.uarch = uarch
        self.name = name
        self.width = width
        self.height = height
        self.tile_types: list[TileType] = []
        self.tiles = [[TileInst(x, y) for x in range(width)] for y in range(height)]
        self.tile_type_idx = dict()
        self.node_shapes: list[NodeShape] = []
        self.node_shape_idx = dict()
        self.tile_shapes = []
        self.tile_shapes_idx = dict()
        self.packages = []
        self.extra_data = None
        self.timing = TimingPool(self.strs)
        self.gfx_wire_ids = dict()

    def create_tile_type(self, name: str):
        tt = TileType(self.strs, self.gfx_wire_ids, self.timing, self.strs.id(name))
        self.tile_type_idx[name] = len(self.tile_types)
        self.tile_types.append(tt)
        return tt

    def set_tile_type(self, x: int, y: int, type: str):
        self.tiles[y][x].type_idx = self.tile_type_idx[type]
        return self.tiles[y][x]

    def tile_type_at(self, x: int, y: int) -> TileType:
        assert (
            self.tiles[y][x].type_idx is not None
        ), f"tile type at ({x}, {y}) must be set"
        return self.tile_types[self.tiles[y][x].type_idx]

    def set_speed_grades(self, speed_grades: list):
        self.timing.set_speed_grades(speed_grades)
        return self.timing

    def add_node(self, wires: list[NodeWire], timing_class=""):
        # encode a 0..65535 unsigned value into -32768..32767 signed value so struct.pack doesn't complain
        # (we use the same field as signed and unsigned in different modes)
        def _twos(x):
            if x & 0x8000:
                x = x - 0x10000
            return x

        # add a node - joining between multiple tile wires into a single connection (from nextpnr's point of view)
        # all the tile wires must exist, and the tile types must be set, first
        x0 = wires[0].x
        y0 = wires[0].y
        # compute node shape
        shape = NodeShape(timing_index=self.timing.node_class_idx(timing_class))
        for w in wires:
            if isinstance(w.wire, int):
                wire_index = w.wire
            else:
                wire_id = w.wire if w.wire is IdString else self.strs.id(w.wire)
                if wire_id not in self.tile_type_at(w.x, w.y)._wire2idx:
                    raise ValueError(
                        f"Wire {w.wire} not found in tile type {self.tile_type_at(w.x, w.y).name}"
                    )
                wire_index = self.tile_type_at(w.x, w.y)._wire2idx[wire_id]
            shape.wires += [w.x - x0, w.y - y0, wire_index]
        # deduplicate node shapes
        key = shape.key()
        if key in self.node_shape_idx:
            shape_idx = self.node_shape_idx[key]
        else:
            shape_idx = len(self.node_shapes)
            self.node_shape_idx[key] = shape_idx
            self.node_shapes.append(shape)
        # update tile wire to node ref

        for i, w in enumerate(wires):
            inst = self.tiles[w.y][w.x]
            wire_idx = shape.wires[i * 3 + 2]
            # make sure there's actually enough space; first
            while 3 * wire_idx >= len(inst.shape.wire_to_node):
                inst.shape.wire_to_node += [MODE.MODE_TILE_WIRE, 0, 0]
            if i == 0:
                # root of the node. we don't need to back-reference anything because the node is based here
                # so we re-use the structure to store the index of the node shape, instead
                assert (
                    inst.shape.wire_to_node[3 * wire_idx + 0] == MODE.MODE_TILE_WIRE
                ), f"attempting to add wire {w} to multiple nodes!"
                inst.shape.wire_to_node[3 * wire_idx + 0] = MODE.MODE_IS_ROOT
                inst.shape.wire_to_node[3 * wire_idx + 1] = _twos(shape_idx & 0xFFFF)
                inst.shape.wire_to_node[3 * wire_idx + 2] = (shape_idx >> 16) & 0xFFFF
            else:
                # back-reference to the root of the node
                dx = x0 - w.x
                dy = y0 - w.y
                assert (
                    dx < MODE.MODE_TILE_WIRE
                ), "dx range causes overlap with magic values!"
                assert (
                    inst.shape.wire_to_node[3 * wire_idx + 0] == MODE.MODE_TILE_WIRE
                ), f"attempting to add wire {w} to multiple nodes!"
                inst.shape.wire_to_node[3 * wire_idx + 0] = dx
                inst.shape.wire_to_node[3 * wire_idx + 1] = dy
                inst.shape.wire_to_node[3 * wire_idx + 2] = shape.wires[0 * 3 + 2]

    def flatten_tile_shapes(self):
        logger.info("Deduplicating tile shapes...")
        for row in self.tiles:
            for tile in row:
                key = tile.shape.key()
                if key in self.tile_shapes_idx:
                    tile.shape_idx = self.tile_shapes_idx[key]
                else:
                    tile.shape_idx = len(self.tile_shapes)
                    self.tile_shapes.append(tile.shape)
                    self.tile_shapes_idx[key] = tile.shape_idx
        logger.info(f"{len(self.tile_shapes)} unique tile routing shapes")

    def create_package(self, name: str):
        pkg = PackageInfo(self.strs, self.strs.id(name))
        self.packages.append(pkg)
        return pkg

    def serialise(self, bba: BBAWriter):
        self.flatten_tile_shapes()
        # TODO: preface, etc
        # Lists that make up the database
        for i, tt in enumerate(self.tile_types):
            tt.serialise_lists(f"tt{i}", bba)
        for i, shp in enumerate(self.node_shapes):
            shp.serialise_lists(f"nshp{i}", bba)
        for i, tsh in enumerate(self.tile_shapes):
            tsh.serialise_lists(f"tshp{i}", bba)
        for i, pkg in enumerate(self.packages):
            pkg.serialise_lists(f"pkg{i}", bba)
        for y, row in enumerate(self.tiles):
            for x, tinst in enumerate(row):
                tinst.serialise_lists(f"tinst_{x}_{y}", bba)
        for i, sg in enumerate(self.timing.speed_grades):
            sg.serialise_lists(f"sg{i}", bba)
        self.strs.serialise_lists("constids", bba)
        if self.extra_data is not None:
            self.extra_data.serialise_lists("extra_data", bba)
            bba.label("extra_data")
            self.extra_data.serialise("extra_data", bba)

        bba.label("tile_types")
        for i, tt in enumerate(self.tile_types):
            tt.serialise(f"tt{i}", bba)
        bba.label("node_shapes")
        for i, shp in enumerate(self.node_shapes):
            shp.serialise(f"nshp{i}", bba)
        bba.label("tile_shapes")
        for i, tsh in enumerate(self.tile_shapes):
            tsh.serialise(f"tshp{i}", bba)
        bba.label("packages")
        for i, pkg in enumerate(self.packages):
            pkg.serialise(f"pkg{i}", bba)
        bba.label("tile_insts")
        for y, row in enumerate(self.tiles):
            for x, tinst in enumerate(row):
                tinst.serialise(f"tinst_{x}_{y}", bba)
        bba.label("speed_grades")
        for i, sg in enumerate(self.timing.speed_grades):
            sg.serialise(f"sg{i}", bba)
        bba.label("constids")
        self.strs.serialise("constids", bba)

        bba.label("chip_info")
        bba.u32(0x00CA7CA7)  # magic
        bba.u32(6)  # version
        bba.u32(self.width)
        bba.u32(self.height)

        bba.str(self.uarch)
        bba.str(self.name)
        bba.str("python_dbgen")  # generator

        bba.slice("tile_types", len(self.tile_types))
        bba.slice("tile_insts", self.width * self.height)
        bba.slice("node_shapes", len(self.node_shapes))
        bba.slice("tile_shapes", len(self.tile_shapes))
        # packages
        bba.slice("packages", len(self.packages))
        # speed grades: not yet used
        bba.slice("speed_grades", len(self.timing.speed_grades))
        # db-defined constids
        bba.ref("constids")
        # extra data
        if self.extra_data is not None:
            bba.ref("extra_data")
        else:
            bba.u32(0)

    def write_bba(self, filename):
        self.timing.finalise()
        with open(filename, "w") as f:
            bba = BBAWriter(f)
            bba.pre('#include "nextpnr.h"')
            bba.pre("NEXTPNR_NAMESPACE_BEGIN")
            bba.post("NEXTPNR_NAMESPACE_END")
            bba.push("chipdb_blob")
            bba.ref("chip_info")
            self.serialise(bba)
            bba.pop()

    def read_gfxids(self, filename):
        idx = 1
        with open(filename) as f:
            for line in f:
                l = line.strip()
                if not l.startswith("X("):
                    continue
                l = l[2:]
                assert l.endswith(")"), l
                l = l[:-1].strip()
                self.gfx_wire_ids[l] = idx
                idx += 1

    def set_chip_extra_data(self, ChipExtraData):
        self.extra_data = ChipExtraData

    def get_tile_type(self, tileX, tileY: int):
        """Get the tile type of the specified tile.

        Parameters
        ----------
        tileX : int
            X coordinate of the tile
        tileY : int
            Y coordinate of the tile

        Returns
        -------
        TileType
            Tile type of the specified tile
        """
        # Validate coordinates
        if tileX < 0 or tileX >= self.width or tileY < 0 or tileY >= self.height:
            logger.error(f"Invalid tile coordinates: ({tileX}, {tileY})")
            return None

        # Get tile instance
        tileInst = self.tiles[tileY][tileX]

        # If tile has no type, return None
        if tileInst.type_idx is None:
            logger.error(f"Tile at ({tileX}, {tileY}) has no type assigned")
            return None

        return self.tile_types[tileInst.type_idx]

    def get_node_wires_from_tile(self, tileX: int, tileY: int):
        """Get all wires that are part of nodes in the specified tile.

        Parameters
        ----------
        tileX : int
            X coordinate of the tile
        tileY : int
            Y coordinate of the tile

        Returns
        -------
        dict
            Dictionary mapping wire name to list of (x, y, wire_name) tuples
            representing all wires in the node
        """
        # Validate coordinates
        if tileX < 0 or tileX >= self.width or tileY < 0 or tileY >= self.height:
            logger.error(f"Invalid tile coordinates: ({tileX}, {tileY})")
            return {}

        # Get tile instance
        tileInst = self.tiles[tileY][tileX]

        # If tile has no type, it can't have wires
        if tileInst.type_idx is None:
            logger.error(f"Tile at ({tileX}, {tileY}) has no type assigned")
            return {}

        tileType = self.tile_types[tileInst.type_idx]

        # Result dictionary: wire name -> list of connections
        nodeWires = []

        # Check all wires in the tile
        for wireName, wireIndex in tileType._wire2idx.items():
            # Skip if wire index is outside the shape's range
            if 3 * wireIndex >= len(tileInst.shape.wire_to_node):
                continue

            # Get node shape index and root info
            mode = tileInst.shape.wire_to_node[3 * wireIndex]

            # If this is a regular tile wire with no node connectivity
            if mode == MODE.MODE_TILE_WIRE:
                # wireNameStr = self.strs[wireName]
                # nodeWireMap[wireNameStr] = [(tileX, tileY, wireNameStr)]
                continue

            # If this wire is a root of a node
            if mode == MODE.MODE_IS_ROOT:
                shapeIdx = (tileInst.shape.wire_to_node[3 * wireIndex + 1] & 0xFFFF) | (
                    (tileInst.shape.wire_to_node[3 * wireIndex + 2] & 0xFFFF) << 16
                )
                # Use existing method to get all wires from this shape
                shape = self.node_shapes[shapeIdx]
                w = []
                for i in range(0, len(shape.wires), 3):
                    dx = shape.wires[i]
                    dy = shape.wires[i + 1]
                    wireIndex = shape.wires[i + 2]
                    targetTileType = self.get_tile_type(tileX + dx, tileY + dy)
                    if targetTileType is None:
                        continue
                    for wireName, wireIdx in targetTileType._wire2idx.items():
                        if wireIdx == wireIndex:
                            w.append((tileX + dx, tileY + dy, self.strs[wireName]))
                            break
                    else:
                        logger.error(
                            f"Wire index {wireIndex} not found in tile type {tileType.name}"
                        )
                nodeWires.append(w)

        return nodeWires
