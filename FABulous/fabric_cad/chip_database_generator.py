from pathlib import Path
from subprocess import run
from typing import Mapping

from loguru import logger

from FABulous.fabric_cad import prims_gen
from FABulous.fabric_cad.chip_database_gen.Bel import BelExtraData, TileExtraData
from FABulous.fabric_cad.chip_database_gen.chip import (
    Chip,
    ChipExtraData,
    TileType,
    TimingValue,
)
from FABulous.fabric_cad.chip_database_gen.define import NodeWire, PinType
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.SwitchMatrix import SwitchMatrix
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generation_Verilog import VerilogWriter


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

        # for i, w in enumerate(tile.wireTypes):
        #     for wc in range(w.destinationPort.wireCount):
        #         tileType.create_wire(f"{c}_{w.destinationPort.name}[{wc}]", "dst", z=i)

        #     for wc in range(w.sourcePort.wireCount):
        #         tileType.create_wire(f"{c}_{w.sourcePort.name}[{wc}]", "src", z=i)
        #         if w.sourcePort in outPorts:
        #             for wc in range(w.sourcePort.wireCount):
        #                 tileType.create_wire(
        #                     f"{c}_{w.sourcePort.name}_internal[{wc}]",
        #                     "src_internal",
        #                     z=i,
        #                 )

        for mux in tile.switchMatrix.muxes:
            for wc in range(mux.output.wireCount):
                outTarget = outputMapping.get(
                    f"{c}_{mux.output.name}[{wc}]", f"{c}_{mux.output.name}[{wc}]"
                )
                for i in mux.inputs:
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


def genBel(bels: list[Bel], tile: TileType, context=1):
    count = 0
    for c in range(context):
        for z, bel in enumerate(bels):
            for i in bel.externalInputs + bel.inputs:
                for wc in range(i.wireCount):
                    tile.create_wire(
                        f"{c}_{i.prefix}{i.name}[{wc}]", f"{bel.name}_{i.name}"
                    )

            for i in bel.externalOutputs + bel.outputs:
                for wc in range(i.wireCount):
                    tile.create_wire(
                        f"{c}_{i.prefix}{i.name}[{wc}]", f"{bel.name}_{i.name}"
                    )

            if bel.userCLK:
                tile.create_wire(f"{c}_{bel.prefix}{bel.name}_{bel.userCLK.name}")
            for feature in bel.belFeatureMap:
                # create the bel itself
                belData = tile.create_bel(
                    f"{c}_{bel.prefix}{bel.name}.{feature}", bel.name, count
                )

                for i in bel.inputs + bel.externalInputs:
                    for wc in range(i.wireCount):
                        tile.add_bel_pin(
                            belData,
                            f"{bel.prefix}{i.name}[{wc}]",
                            f"{c}_{bel.prefix}{i.name}[{wc}]",
                            PinType.INPUT,
                        )
                for i in bel.outputs + bel.externalOutputs:
                    for wc in range(i.wireCount):
                        tile.add_bel_pin(
                            belData,
                            f"{bel.prefix}{i.name}[{wc}]",
                            f"{c}_{bel.prefix}{i.name}[{wc}]",
                            PinType.OUTPUT,
                        )

                if bel.userCLK:
                    tile.add_bel_pin(
                        belData,
                        bel.userCLK.name,
                        f"{c}_{bel.prefix}{bel.name}_{bel.userCLK.name}",
                        PinType.INPUT,
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


def generateChipDatabase(fabric: Fabric, filePath: Path, baseConstIdsPath: Path):
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


if __name__ == "__main__":
    f = FABulous_API(VerilogWriter(), str(Path.cwd() / "myProject" / "fabric.yaml"))
    f.setWriterOutputFile("/home/kelvin/FABulous_fork/test.v")
    # f.bootstrapSwitchMatrix("LUT4AB", "/home/kelvin/FABulous_fork/tmp.csv")
    ch = Chip(
        "FABulous", f.fabric.name, f.fabric.numberOfRows, f.fabric.numberOfColumns
    )
    generateChipDatabase(
        f.fabric,
        Path(Path.cwd() / "myProject/.FABulous"),
        Path(Path.cwd() / "myProject/.FABulous" / "baseConstIds.inc"),
    )
    prims_gen.prims_gen(Path(Path.cwd() / "myProject/.FABulous" / "prims.v"), f.fabric)
    prims_gen.prims_gen(Path(Path.cwd() / "myProject/.FABulous" / "prims.v"), f.fabric)
