import re
from itertools import islice, product
from pathlib import Path
from subprocess import run
from typing import Iterable, Mapping, cast

import pydot
from loguru import logger

from FABulous.fabric_cad.chip_database_gen.chip import Chip, ChipExtraData
from FABulous.fabric_cad.chip_database_gen.database_bel import (
    BelExtraData,
    TileExtraData,
)
from FABulous.fabric_cad.chip_database_gen.database_tile import TileType
from FABulous.fabric_cad.chip_database_gen.database_timing import TimingValue
from FABulous.fabric_cad.chip_database_gen.define import NodeWire, PinType
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort, TilePort
from FABulous.fabric_definition.SwitchMatrix import SwitchMatrix
from FABulous.fabric_definition.Tile import Tile

CONTROL_GND_OFFSET = 0x2000
CONTROL_VCC_OFFSET = 0x4000
TILE_CLK = 0xFFFF


def genSwitchMatrix(tile: Tile, tileType: TileType, context=1):
    if not isinstance(tile.switchMatrix, SwitchMatrix):
        raise ValueError("Switch matrix is not a SwitchMatrix object")

    zIn = 0
    zOut = 0
    for c in range(context):
        outputMapping: Mapping[str, str] = {}

        for p in tile.getTileInputPorts():
            if p.terminal:
                for wtc in range(tile.getWireType(p).spanning):
                    for wc in range(p.wireCount):
                        tileType.create_wire(f"{c}_{p.name}[{wc}]_{wtc}", "src", z=zIn)
            else:
                for wc in range(p.wireCount):
                    tileType.create_wire(f"{c}_{p.name}[{wc}]", "src", z=zIn)
            zIn += 1
        for p in tile.getTileOutputPorts():
            if p.terminal:
                for wtc in range(tile.getWireType(p).spanning):
                    for wc in range(p.wireCount):
                        tileType.create_wire(
                            f"{c}_{p.name}_internal[{wc}]_{wtc}", "dst", z=zOut
                        )
                        tileType.create_wire(f"{c}_{p.name}[{wc}]_{wtc}", "dst", z=zOut)
                        tileType.create_pip(
                            f"{c}_{p.name}_internal[{wc}]_{wtc}",
                            f"{c}_{p.name}[{wc}]_{wtc}",
                        )
                        outputMapping[f"{c}_{p.name}[{wc}]_{wtc}"] = (
                            f"{c}_{p.name}_internal[{wc}]_{wtc}"
                        )
            else:
                for wc in range(p.wireCount):
                    tileType.create_wire(f"{c}_{p.name}_internal[{wc}]", "dst", z=zOut)
                    tileType.create_wire(f"{c}_{p.name}[{wc}]", "dst", z=zOut)
                    tileType.create_pip(
                        f"{c}_{p.name}_internal[{wc}]", f"{c}_{p.name}[{wc}]"
                    )
                    outputMapping[f"{c}_{p.name}[{wc}]"] = (
                        f"{c}_{p.name}_internal[{wc}]"
                    )
            zOut += 1

        for mux in tile.switchMatrix.muxes:
            for wc in range(mux.output.wireCount):
                if isinstance(mux.output, BelPort):
                    outTarget = outputMapping.get(
                        f"{c}_{mux.output.prefix}{mux.output.name}[{wc}]",
                        f"{c}_{mux.output.prefix}{mux.output.name}[{wc}]",
                    )
                else:
                    outTarget = outputMapping.get(
                        f"{c}_{mux.output.name}[{wc}]", f"{c}_{mux.output.name}[{wc}]"
                    )
                for i in mux.inputs:
                    if isinstance(i, BelPort):
                        tileType.create_pip(
                            f"{c}_{i.prefix}{i.name}[{wc}]",
                            outTarget,
                        )
                    else:
                        tileType.create_pip(
                            f"{c}_{i.name}[{wc}]",
                            outTarget,
                        )

    zOut = 0
    for c in range(context - 1):
        for i, p in enumerate(sorted(tile.getTileOutputPorts())):
            for wc in range(p.wireCount):
                tileType.create_wire(
                    f"{p.name}_{c}_to_{c+1}_NextCycle[{wc}]", "NextCycle", z=zOut
                )
            zOut += 1

    for c in range(context - 1):
        for mux in tile.switchMatrix.muxes:
            for wc in range(mux.output.wireCount):
                tileType.create_pip(
                    outputMapping.get(
                        f"{c}_{mux.output.name}[{wc}]", f"{c}_{mux.output.name}[{wc}]"
                    ),
                    f"{mux.output.name}_{c}_to_{c+1}_NextCycle[{wc}]",
                )
                tileType.create_pip(
                    f"{mux.output.name}_{c}_to_{c+1}_NextCycle[{wc}]",
                    f"{c+1}_{mux.output.name}[{wc}]",
                )

    for c in range(context - 2):
        for i, p in enumerate(sorted(tile.getTileOutputPorts())):
            for wc in range(p.wireCount):
                tileType.create_pip(
                    f"{p.name}_{c}_to_{c+1}_NextCycle[{wc}]",
                    f"{p.name}_{c+1}_to_{c+2}_NextCycle[{wc}]",
                )


def genBel(bels: Iterable[Bel], tile: TileType, context=1):
    count = len(list(bels))
    useClk = any([i.userCLK for i in bels])
    if useClk:
        clkDRV = tile.create_bel("CLK_DRV", "CLK_DRV", z=TILE_CLK)
        tile.create_wire("user_clk_o", "CLK")
        tile.add_bel_pin(clkDRV, "CLK_O", "user_clk_o", PinType.OUTPUT)
        count += 1
    for c in range(context):
        for z, bel in enumerate(bels):
            for i in bel.externalInputs + bel.inputs:
                if i.wireCount == 1:
                    tile.create_wire(f"{c}_{i.prefix}{i.name}", f"{bel.name}_{i.name}")
                else:
                    for wc in range(i.wireCount):
                        tile.create_wire(
                            f"{c}_{i.prefix}{i.name}[{wc}]", f"{bel.name}_{i.name}"
                        )

            for i in bel.externalOutputs + bel.outputs:
                for wc in range(i.wireCount):
                    tile.create_wire(
                        f"{c}_{i.prefix}{i.name}[{wc}]", f"{bel.name}_{i.name}"
                    )

            # create the bel itself
            belData = tile.create_bel(
                f"{c}_{bel.prefix}{bel.name}",
                f"{bel.name}",
                bel.z,
            )

            for i in bel.inputs + bel.externalInputs:
                if i.wireCount == 1:
                    tile.add_bel_pin(
                        belData,
                        f"{i.name}",
                        f"{c}_{bel.prefix}{i.name}",
                        PinType.INPUT,
                    )
                else:
                    for wc in range(i.wireCount):
                        tile.add_bel_pin(
                            belData,
                            f"{i.name}[{wc}]",
                            f"{c}_{bel.prefix}{i.name}[{wc}]",
                            PinType.INPUT,
                        )

            for i in bel.outputs + bel.externalOutputs:
                for wc in range(i.wireCount):
                    tile.create_wire(f"{c}_{bel.prefix}I[{wc}]", "OUTBUF")
                    tile.add_bel_pin(
                        belData,
                        f"{i.name}[{wc}]",
                        f"{c}_{bel.prefix}{i.name}[{wc}]",
                        PinType.OUTPUT,
                    )

            # for z, i in enumerate(bel.inputs):
            #     if i.control:
            #         if i.wireCount != 1:
            #             raise ValueError("Control wire count must be 1")
            #         gnd = tile.create_bel(
            #             f"{c}_{bel.prefix}{i.name}_GND_DRV",
            #             "GND_DRV",
            #             z=bel.z | CONTROL_GND_OFFSET | (z << 8),
            #         )
            #         tile.create_wire(
            #             f"{c}_{bel.prefix}{i.name}_GND",
            #             "GND",
            #             const_value="GND",
            #         )
            #         tile.add_bel_pin(
            #             gnd,
            #             "GND",
            #             f"{c}_{bel.prefix}{i.name}_GND",
            #             PinType.OUTPUT,
            #         )
            #         tile.create_pip(
            #             f"{c}_{bel.prefix}{i.name}_GND",
            #             f"{c}_{bel.prefix}{i.name}",
            #         )

            #         vcc = tile.create_bel(
            #             f"{c}_{bel.prefix}{i.name}_VCC_DRV",
            #             "VCC_DRV",
            #             z=bel.z | CONTROL_VCC_OFFSET | (z << 8),
            #         )
            #         tile.create_wire(
            #             f"{c}_{bel.prefix}{i.name}_VCC",
            #             "VCC",
            #             const_value="VCC",
            #         )
            #         tile.add_bel_pin(
            #             vcc,
            #             "VCC",
            #             f"{c}_{bel.prefix}{i.name}_VCC",
            #             PinType.OUTPUT,
            #         )
            #         tile.create_pip(
            #             f"{c}_{bel.prefix}{i.name}_VCC",
            #             f"{c}_{bel.prefix}{i.name}",
            #         )

            if bel.userCLK:
                tile.create_wire(f"{c}_{bel.prefix}{bel.name}_clk_i", "CLK")
                tile.add_bel_pin(
                    belData,
                    bel.userCLK.name,
                    f"{c}_{bel.prefix}{bel.name}_clk_i",
                    PinType.INPUT,
                )
                tile.create_pip(
                    "user_clk_o",
                    f"{c}_{bel.prefix}{bel.name}_clk_i",
                )
            belData.add_extra_data(BelExtraData(context=c))
            count += 1


def genTile(tile: Tile, chip: Chip, context=1) -> TileType:
    tt = chip.create_tile_type(tile.name)
    genBel(tile.bels, tt, context=context)
    genSwitchMatrix(tile, tt, context=context)
    tt.add_extraData(
        TileExtraData(
            uniqueBelCount=len(tile.bels),
            northPortCount=len(tile.getNorthPorts()),
            eastPortCount=len(tile.getEastPorts()),
            southPortCount=len(tile.getSouthPorts()),
            westPortCount=len(tile.getWestPorts()),
        )
    )
    return tt


# change to base on wire type
def genFabric(fabric: Fabric, chip: Chip, context=1):
    def clipX(value):
        return max(0, min(value, fabric.numberOfColumns - 1))

    def clipY(value):
        return max(0, min(value, fabric.numberOfRows - 1))

    # TODO fix terminal ports
    for (x, y), wires in fabric.wireDict.items():
        if not wires:
            continue
        for c in range(context):
            for wire in wires:
                for i in range(wire.source.wireCount):
                    node = [
                        NodeWire(
                            clipX(x),
                            clipY(fabric.numberOfRows - y - 1),
                            f"{c}_{wire.source.name}[{i}]",
                        ),
                        NodeWire(
                            clipX(x + wire.xOffset),
                            clipY(fabric.numberOfRows - y - 1 - wire.yOffset),
                            f"{c}_{wire.destination.name}[{i}]",
                        ),
                    ]
                    chip.add_node(node)
    setTiming(chip)


def setTiming(chip: Chip):
    speed = "DEFAULT"
    tmg = chip.set_speed_grades([speed])
    # --- Routing Delays ---
    # Notes: A simpler timing model could just use intrinsic delay and ignore R and Cs.
    # R and C values don't have to be physically realistic, just in agreement with themselves to provide
    # a meaningful scaling of delay with fanout. Units are subject to change.
    tmg.set_pip_class(
        grade=speed,
        name="SWINPUT",
        delay=TimingValue(80),  # 80ps intrinstic delay
        in_cap=TimingValue(5000),  # 5pF
        out_res=TimingValue(1000),  # 1ohm
    )
    tmg.set_pip_class(
        grade=speed,
        name="SWOUTPUT",
        delay=TimingValue(100),  # 100ps intrinstic delay
        in_cap=TimingValue(5000),  # 5pF
        out_res=TimingValue(800),  # 0.8ohm
    )
    tmg.set_pip_class(
        grade=speed,
        name="SWNEIGH",
        delay=TimingValue(120),  # 120ps intrinstic delay
        in_cap=TimingValue(7000),  # 7pF
        out_res=TimingValue(1200),  # 1.2ohm
    )
    tmg.set_pip_class(
        grade=speed,
        name="NEXT_CYCLE",
        delay=TimingValue(1000),  # 1000ps intrinstic delay
        in_cap=TimingValue(50000),
        out_res=TimingValue(8000),
    )


def generateConstrainPair(fabric: Fabric, dest: Path):
    with open(dest, "w") as f:
        # for bel in fabric.getAllUniqueBels():
        #     f.write(f"#{bel.name}\n")
        #     for idx, i in enumerate(bel.inputs):
        #         if i.control:
        #             dz = (idx << 8) | CONTROL_GND_OFFSET
        #             f.write(f"{bel.name}:{i.name} 1 GND_DRV:GND 1  {dz}\n")
        #             dz = (idx << 8) | CONTROL_VCC_OFFSET
        #             f.write(f"{bel.name}:{i.name} 1 VCC_DRV:VCC 1 {dz}\n")

        #     f.write("\n")

        for t in fabric.tileDict.values():
            for bel in t.bels:
                for i in bel.inputs:
                    portDriver = t.switchMatrix.getPortDrivers(i)
                    if all([isinstance(i, BelPort) for i in portDriver]):
                        f.write(f"#{bel.prefix}{bel.name}:{i.name}\n")
                        for d in portDriver:
                            d = cast(BelPort, d)
                            tBel = t.getBelByBelPort(d)
                            if bel == tBel:
                                continue

                            if tBel.z < bel.z:
                                f.write(
                                    f"{tBel.name}:{d.name} {d.wireCount} {bel.name}:{i.name} {i.wireCount} {bel.z - tBel.z} \n"
                                )
                            else:
                                f.write(
                                    f"{bel.name}:{i.name} {i.wireCount} {tBel.name}:{d.name} {d.wireCount} {tBel.z - bel.z} \n"
                                )
                        f.write("\n")


def generateChipDatabase(
    fabric: Fabric, filePath: Path, baseConstIdsPath: Path, dotDir: Path
):
    ch = Chip("FABulous", fabric.name, fabric.numberOfColumns, fabric.numberOfRows)

    ch.strs.read_constids(str(baseConstIdsPath))
    for tile in fabric.tileDict.values():
        genTile(tile, ch, fabric.contextCount)

    logger.info("Generating the chip database")
    ch.create_tile_type("NULL")

    for (x, y), tile in fabric:
        if tile is not None:
            ch.set_tile_type(x, fabric.numberOfRows - y - 1, tile.name)
        else:
            ch.set_tile_type(x, fabric.numberOfRows - y - 1, "NULL")

    # for i in range(fabric.numberOfRows):
    #     for j in range(fabric.numberOfColumns):
    #         if fabric.tiles[i][j] is not None:
    #             ch.set_tile_type(
    #                 j, fabric.numberOfRows - i - 1, fabric.tiles[i][j].name
    #             )
    #         else:
    #             ch.set_tile_type(j, fabric.numberOfRows - i - 1, "NULL")

    genFabric(fabric, ch, context=fabric.contextCount)

    ch.extra_data = ChipExtraData(fabric.contextCount, fabric.getTotalBelCount())
    logger.info(f"Context Count: {fabric.contextCount}")
    logger.info(
        f"Total BEL Count: {fabric.getTotalBelCount()}",
    )
    ch.strs.toConstStringId(str(filePath / f"{fabric.name}_constids.inc"))
    ch.read_gfxids(str(filePath / f"{fabric.name}_constids.inc"))

    logger.info(f"Writing the chip database to {filePath / f'{fabric.name}.bba'}")
    ch.write_bba(str(filePath / f"{fabric.name}.bba"))
    logger.info(
        f"Writing Constant String IDs to {filePath / f'{fabric.name}_constids.inc'}"
    )

    try:
        logger.info("Compiling the bba file to bit file")
        run(
            [
                "bbasm",
                "-l",
                str(filePath / f"{fabric.name}.bba"),
                str(filePath / f"{fabric.name}.bit"),
            ]
        )
        logger.info(f"Writing the bit file to {filePath / fabric.name}.bit")
    except Exception as e:
        logger.error(e)
        logger.error("Failed to compile the bba file to bit file.")
        raise e

    logger.info(
        f"Writing the constrain pair file to {filePath / fabric.name}_constrain_pair.inc"
    )
    generateConstrainPair(fabric, filePath / f"{fabric.name}_constrain_pair.inc")

    if dotDir is not Path():
        genRoutingDotGraph(ch, filePath, False)


def groupByThree(inputList: list) -> list:
    iterator = iter(inputList)
    result = []

    while chunk := list(islice(iterator, 3)):
        result.append(chunk)

    return result


def genRoutingDotGraph(chip: Chip, filePath: Path, expand=False):
    graph = pydot.Dot(graph_type="digraph")

    if expand:

        def removeBit(i: str) -> str:
            return i

    else:

        def removeBit(i: str) -> str:
            return re.sub(r"\[\d+\]$", "", i)

    pairs = list(product(range(chip.height), range(chip.width)))
    globalPairs = set()
    pairs = [(1, 1), (2, 1)]
    for x, y in pairs:
        tileType = chip.tile_type_at(x, y)
        subgraph = pydot.Subgraph(
            f"cluster_{x}_{y}", label=f"tile_{x}_{y}_{tileType.name}"
        )
        for bel in tileType.bels:
            # if "INBUF" in bel.name.value:
            #     continue
            # if "OUTBUF" in bel.name.value:
            #     continue
            # if "DRV" in bel.name.value:
            #     continue

            belSupGraph = pydot.Subgraph(
                f"cluster_{x}_{y}_{bel.name.value}",
                label=f"{bel.name.value}",
            )
            belSupGraph.add_node(
                pydot.Node(
                    f"X{x}Y{y}_bel_{bel.name.value}",
                    label=f"bel_{bel.name.value}(z=0x{bel.z:04x})",
                    shape="box",
                )
            )
            added = set()
            for pin in bel.pins:
                pinWire = removeBit(tileType.wires[pin.wire].name.value)
                if pinWire in added:
                    continue
                added.add(pinWire)
                if pin.dir == PinType.INPUT:
                    belPin = f"X{x}Y{y}_{bel.name.value}{pin.name.value}"
                    belSupGraph.add_node(
                        pydot.Node(belPin, label=pin.name.value, shape="hexagon")
                    )
                    belSupGraph.add_edge(
                        pydot.Edge(
                            f"X{x}Y{y}_{pinWire}",
                            belPin,
                        )
                    )
                    belSupGraph.add_edge(
                        pydot.Edge(
                            belPin,
                            f"X{x}Y{y}_bel_{bel.name.value}",
                        )
                    )
                elif pin.dir == PinType.OUTPUT:
                    belPin = f"X{x}Y{y}_{bel.name.value}{pin.name.value}"
                    belSupGraph.add_node(
                        pydot.Node(belPin, label=pin.name.value, shape="hexagon")
                    )
                    belSupGraph.add_edge(
                        pydot.Edge(f"X{x}Y{y}_bel_{bel.name.value}", belPin)
                    )
                    belSupGraph.add_edge(
                        pydot.Edge(
                            belPin,
                            f"X{x}Y{y}_{pinWire}",
                        )
                    )
            subgraph.add_subgraph(belSupGraph)
        addedPairs = set()
        for pip in tileType.pips:
            src, dst = tileType.get_wire_from_pip(pip)
            srcName = removeBit(src.name.value)
            dstName = removeBit(dst.name.value)
            if (srcName, dstName) in addedPairs:
                continue
            subgraph.add_edge(pydot.Edge(f"X{x}Y{y}_{srcName}", f"X{x}Y{y}_{dstName}"))
            addedPairs.add((srcName, dstName))

        # subgraph.add_node(pydot.Node(f"tile_{x}_{y}"))
        graph.add_subgraph(subgraph)
        wires = chip.get_node_wires_from_tile(x, y)
        for shape in wires:
            x, y, name = shape[0]
            srcName = f"X{x}Y{y}_{removeBit(name)}"
            for x, y, name in shape[1:]:
                dstName = f"X{x}Y{y}_{removeBit(name)}"
                if (srcName, dstName) in globalPairs or (
                    dstName,
                    srcName,
                ) in globalPairs:
                    continue
                globalPairs.add((srcName, dstName))
                globalPairs.add((dstName, srcName))

                graph.add_edge(pydot.Edge(srcName, dstName, dir="none", color="blue"))

    graph.write(str(filePath / "routing_graph.dot"))


# if __name__ == "__main__":
#     f = FABulous_API(VerilogWriter(), str(Path.cwd() / "myProject" / "fabric.yaml"))
#     f.setWriterOutputFile("/home/kelvin/FABulous_fork/test.v")
#     # f.bootstrapSwitchMatrix("LUT4AB", "/home/kelvin/FABulous_fork/tmp.csv")
#     ch = Chip(
#         "FABulous", f.fabric.name, f.fabric.numberOfRows, f.fabric.numberOfColumns
#     )
#     generateChipDatabase(
#         f.fabric,
#         Path(Path.cwd() / "myProject/.FABulous"),
#         Path(Path.cwd() / "myProject/.FABulous" / "baseConstIds.inc"),
#     )
#     synth_file_generator.prims_gen(Path(Path.cwd() / "myProject/.FABulous" / "prims.v"), f.fabric)
#     synth_file_generator.prims_gen(Path(Path.cwd() / "myProject/.FABulous" / "prims.v"), f.fabric)
