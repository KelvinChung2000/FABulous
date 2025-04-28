from itertools import islice
from pathlib import Path
from subprocess import run
from typing import Iterable, Mapping, cast

from loguru import logger

from FABulous.fabric_cad.chip_database.chip import Chip, ChipExtraData
from FABulous.fabric_cad.chip_database.database_bel import BelExtraData, TileExtraData
from FABulous.fabric_cad.chip_database.database_tile import TileType
from FABulous.fabric_cad.chip_database.database_timing import TimingValue
from FABulous.fabric_cad.chip_database.define import NodeWire, PinType
from FABulous.fabric_cad.graph_draw import genRoutingResourceGraph
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort
from FABulous.fabric_definition.SwitchMatrix import SwitchMatrix
from FABulous.fabric_definition.Tile import Tile

CONTROL_GND_OFFSET = 0x2000
CONTROL_VCC_OFFSET = 0x4000
TILE_CLK = 0xFFFF

NORMAL = 0
PSEUDO_PIP_START = 1
PSEUDO_PIP_MID = 2
PSEUDO_PIP_END = 3


def genSwitchMatrix(tile: Tile, subTile: str, tileType: TileType, context=1):
    if not isinstance(tile.switchMatrix, SwitchMatrix):
        raise ValueError("Switch matrix is not a SwitchMatrix object")
    zIn = 0
    zOut = 0
    for c in [ f"c{i}" for i in range(context)]:
        outputMapping: Mapping[str, str] = {}

        for p in tile.getTileInputPorts(subTile):
            if p.terminal and p.ioDirection == IO.OUTPUT:
                for wtc in range(tile.getWireType(p).spanning):
                    for pName in p.expand():
                        tileType.create_wire(f"{c}.{pName}_{wtc}", "src", z=zIn)
            else:
                for pName in p.expand():
                    tileType.create_wire(f"{c}.{pName}", "src", z=zIn)
            zIn += 1
        for p in tile.getTileOutputPorts(subTile):
            if p.terminal:
                for wtc in range(tile.getWireType(p).spanning):
                    for pName in p.expand():
                        tileType.create_wire(
                            f"{c}.{pName}_internal_{wtc}", "dst", z=zOut
                        )
                        tileType.create_wire(
                            f"{c}.{pName}_{wtc}", "dst", z=zOut
                        )
                        tileType.create_pip(
                            f"{c}.{pName}_internal_{wtc}",
                            f"{c}.{pName}_{wtc}",
                        )
                        outputMapping[f"c{c}.{pName}_{wtc}"] = (
                            f"{c}.{pName}_internal_{wtc}"
                        )
            else:
                for pName in p.expand():
                    tileType.create_wire(f"{c}.{pName}_internal", "dst", z=zOut)
                    tileType.create_wire(f"{c}.{pName}", "dst", z=zOut)
                    tileType.create_pip(
                        f"{c}.{pName}_internal",
                        f"{c}.{pName}",
                        flags=PSEUDO_PIP_END,
                    )
                    outputMapping[f"{c}.{pName}"] = (
                        f"{c}.{pName}_internal"
                    )
            zOut += 1

        for mux in tile.switchMatrix.muxes:
            for pName in mux.output.expand():
                outTarget = outputMapping.get(
                    f"{c}.{pName}", f"{c}.{pName}"
                )
                for i in mux.inputs:
                    for pName in i.expand():
                        tileType.create_pip(
                            f"{c}.{pName}",
                            outTarget,
                            flags=(
                                NORMAL
                                if "internal" not in outTarget
                                else PSEUDO_PIP_START
                            ),
                        )

    zOut = 0
    for c in range(context - 1):
        for i, p in enumerate(sorted(tile.getTileOutputPorts())):
            for wc in range(p.width):
                tileType.create_wire(
                    f"{p.name}_{c}_to_{c+1}_NextCycle[{wc}]", "NextCycle", z=zOut
                )
            zOut += 1

    for c in range(context - 1):
        for mux in tile.switchMatrix.muxes:
            for pName in mux.output.expand():
                output = outputMapping.get(
                    f"c{c}.{pName}", f"c{c}.{pName}"
                )
                tileType.create_pip(
                    output,
                    f"{mux.output.name}_{c}_to_{c+1}_NextCycle[{wc}]",
                    flags=(
                        PSEUDO_PIP_MID if "internal" not in output else PSEUDO_PIP_START
                    ),
                )
                tileType.create_pip(
                    f"{mux.output.name}_{c}_to_{c+1}_NextCycle[{wc}]",
                    f"c{c+1}.{pName}",
                    flags=PSEUDO_PIP_END,
                )

    for c in range(context - 2):
        for i, p in enumerate(sorted(tile.getTileOutputPorts())):
            for wc in range(p.width):
                tileType.create_pip(
                    f"{p.name}_{c}_to_{c+1}_NextCycle[{wc}]",
                    f"{p.name}_{c+1}_to_{c+2}_NextCycle[{wc}]",
                    flags=PSEUDO_PIP_MID,
                )


def genBel(bels: Iterable[Bel], tile: TileType, context=1):
    count = len(list(bels))
    useClk = any([i.userCLK for i in bels])
    if useClk:
        clkDRV = tile.create_bel("CLK_DRV", "CLK_DRV", z=TILE_CLK)
        tile.create_wire("user_clk_o", "CLK")
        tile.add_bel_pin(clkDRV, "CLK_O", "user_clk_o", PinType.OUTPUT)
        count += 1
    for c in [f"c{i}" for i in range(context)]:
        for z, bel in enumerate(bels):
            for i in bel.externalInputs + bel.inputs:
                for pName in i.expand():
                    tile.create_wire(f"{c}.{pName}", f"{bel.name}_{i.name}")

            for i in bel.externalOutputs + bel.outputs:
                for pName in i.expand():
                    tile.create_wire(
                        f"{c}.{pName}", f"{bel.name}_{i.name}"
                    )

            # create the bel itself
            belData = tile.create_bel(
                f"{c}.{bel.prefix}{bel.name}",
                f"{bel.name}",
                bel.z,
            )

            for i in bel.inputs + bel.externalInputs:
                for pName in i.expand():
                    tile.add_bel_pin(
                        belData,
                        f"{i.name}",
                        f"{c}.{pName}",
                        PinType.INPUT,
                    )

            for i in bel.outputs + bel.externalOutputs:
                for pName in i.expand():
                    tile.add_bel_pin(
                        belData,
                        f"{i.name}",
                        f"{c}.{pName}",
                        PinType.OUTPUT,
                    )

            if bel.userCLK:
                tile.create_wire(f"{c}.{bel.prefix}{bel.name}_clk_i", "CLK")
                tile.add_bel_pin(
                    belData,
                    bel.userCLK.name,
                    f"{c}.{bel.prefix}{bel.name}_clk_i",
                    PinType.INPUT,
                )
                tile.create_pip(
                    "user_clk_o",
                    f"{c}.{bel.prefix}{bel.name}_clk_i",
                )
            belData.add_extra_data(BelExtraData(context=c))
            count += 1


def genTile(tile: Tile, subTile: str, chip: Chip, context=1) -> TileType:
    tt = chip.create_tile_type(subTile)
    if tile.getSubTileOffset(subTile) == (0, 0):
        genBel(tile.bels, tt, context=context)
    genSwitchMatrix(tile, subTile, tt, context=context)
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
        return max(0, min(value, fabric.width - 1))

    def clipY(value):
        return max(0, min(value, fabric.height - 1))

    # TODO fix terminal ports
    for (x, y), wires in fabric.wireDict.items():
        if not wires:
            continue
        for c in range(context):
            for wire in wires:
                for i in range(wire.source.width):
                    node = [
                        NodeWire(
                            clipX(x),
                            clipY(y),
                            f"c{c}.{wire.source.name}[{i}]",
                        ),
                        NodeWire(
                            clipX(x + wire.xOffset),
                            clipY(y - wire.yOffset),
                            f"c{c}.{wire.destination.name}[{i}]",
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
                                    f"{tBel.name}:{d.name} {d.width} {bel.name}:{i.name} {i.width} {bel.z - tBel.z} \n"
                                )
                            else:
                                f.write(
                                    f"{bel.name}:{i.name} {i.width} {tBel.name}:{d.name} {d.width} {tBel.z - bel.z} \n"
                                )
                        f.write("\n")


def generateChipDatabase(
    fabric: Fabric, filePath: Path, baseConstIdsPath: Path, dotDir: Path
):
    ch = Chip("FABulous", fabric.name, fabric.width, fabric.height)

    ch.strs.read_constids(str(baseConstIdsPath))
    for tile in fabric.tileDict.values():
        for subTile in tile.getSubTiles():
            genTile(tile, subTile, ch, fabric.contextCount)

    logger.info("Generating the chip database")
    ch.create_tile_type("NULL")

    for (x, y), tile in fabric.tileNames_iter():
        if tile is not None:
            ch.set_tile_type(x, y, tile)
        else:
            ch.set_tile_type(x, y, "NULL")

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
        genRoutingResourceGraph(ch, filePath, False)


def groupByThree(inputList: list) -> list:
    iterator = iter(inputList)
    result = []

    while chunk := list(islice(iterator, 3)):
        result.append(chunk)

    return result


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
