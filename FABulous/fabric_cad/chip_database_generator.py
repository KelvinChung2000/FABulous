from collections import defaultdict
from itertools import islice
from pathlib import Path
from subprocess import run
from typing import cast

from loguru import logger

from FABulous.fabric_cad.chip_database.chip import Chip
from FABulous.fabric_cad.chip_database.database_bel import TileExtraData
from FABulous.fabric_cad.chip_database.database_tile import TileType
from FABulous.fabric_cad.chip_database.database_timing import TimingValue
from FABulous.fabric_cad.chip_database.define import NodeWire, PinType
from FABulous.fabric_cad.graph_draw import genRoutingResourceGraph
from FABulous.fabric_definition.define import IO, Loc
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort, TilePort
from FABulous.fabric_definition.SwitchMatrix import SwitchMatrix
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.Wire import WireType

CONTROL_GND_OFFSET = 0x2000
CONTROL_VCC_OFFSET = 0x4000
TILE_CLK = 0xFFFF
TILE_GND = 0xFFFE
TILE_VCC = 0xFFFD

NORMAL = 0
PSEUDO_PIP_START = 1
PSEUDO_PIP_MID = 2
PSEUDO_PIP_END = 3

BEL_PIN_FULLY_INTERNAL = 1
BEL_PIN_SHARED = 2


def genSwitchMatrix(tile: Tile, subTile: str, tileType: TileType, context=1):
    if not isinstance(tile.switchMatrix, SwitchMatrix):
        raise ValueError("Switch matrix is not a SwitchMatrix object")
    zIn = 0
    zOut = 0
    outputMapping: dict[str, str] = {}
    for c in range(context):
        for p in tile.getTileInputPorts(subTile):
            if p.terminal and p.ioDirection == IO.OUTPUT:
                for wtc in range(tile.getWireType(p).spanning):
                    for pName in p.expand():
                        tileType.create_wire(
                            f"c{c}.{pName}_{wtc}", "src", z=zIn, flags=c + 1
                        )
            else:
                for pName in p.expand():
                    tileType.create_wire(f"c{c}.{pName}", "src", z=zIn, flags=c + 1)
            zIn += 1
        for p in tile.getTileOutputPorts(subTile):
            if p.terminal:
                for wtc in range(tile.getWireType(p).spanning):
                    for pName in p.expand():
                        tileType.create_wire(
                            f"c{c}.{pName}_internal_{wtc}", "dst", z=zOut, flags=c + 1
                        )
                        tileType.create_wire(
                            f"c{c}.{pName}_{wtc}", "dst", z=zOut, flags=c + 1
                        )
                        tileType.create_pip(
                            f"c{c}.{pName}_internal_{wtc}",
                            f"c{c}.{pName}_{wtc}",
                            timing_class="SWNEIGH",
                        )
                        outputMapping[f"c{c}.{pName}_{wtc}"] = (
                            f"c{c}.{pName}_internal_{wtc}"
                        )
            else:
                for pName in p.expand():
                    tileType.create_wire(
                        f"c{c}.{pName}_internal", "dst", z=zOut, flags=c + 1
                    )
                    tileType.create_wire(f"c{c}.{pName}", "dst", z=zOut, flags=c + 1)
                    tileType.create_pip(
                        f"c{c}.{pName}_internal",
                        f"c{c}.{pName}",
                        flags=PSEUDO_PIP_END,
                        timing_class="SWNEIGH",
                    )
                    outputMapping[f"c{c}.{pName}"] = f"c{c}.{pName}_internal"
            zOut += 1

        for mux in tile.switchMatrix.muxes:
            for pOut, pIns in mux.getFlattenMux():
                outTarget = outputMapping.get(f"c{c}.{pOut}", f"c{c}.{pOut}")
                for i in pIns:
                    tileType.create_pip(
                        f"c{c}.{i}",
                        outTarget,
                        timing_class=f"CONTEXT_{c}",
                        flags=(
                            NORMAL if "internal" not in outTarget else PSEUDO_PIP_START
                        ),
                    )
    for c in range(context - 1):
        for i, p in enumerate(sorted(tile.getTileOutputPorts())):
            for wc in range(p.width):
                tileType.create_wire(
                    f"{p.name}_{c}_to_{c + 1}_NextCycle[{wc}]",
                    "NEXT_CYCLE",
                    z=zOut,
                    flags=c + 1,
                )
            zOut += 1

    for c in range(context - 1):
        for mux in tile.switchMatrix.muxes:
            if not isinstance(mux.output, TilePort):
                continue
            for wc, pName in enumerate(mux.output.expand()):
                output = outputMapping.get(f"c{c}.{pName}", f"c{c}.{pName}")
                tileType.create_pip(
                    output,
                    f"{mux.output.name}_{c}_to_{c + 1}_NextCycle[{wc}]",
                    timing_class="NEXT_CYCLE",
                    flags=(
                        PSEUDO_PIP_MID if "internal" not in output else PSEUDO_PIP_START
                    ),
                )
                tileType.create_pip(
                    f"{mux.output.name}_{c}_to_{c + 1}_NextCycle[{wc}]",
                    f"c{c + 1}.{pName}",
                    timing_class="NEXT_CYCLE",
                    flags=PSEUDO_PIP_END,
                )

    for c in range(context - 2):
        for i, p in enumerate(sorted(tile.getTileOutputPorts())):
            for wc in range(p.width):
                tileType.create_pip(
                    f"{p.name}_{c}_to_{c + 1}_NextCycle[{wc}]",
                    f"{p.name}_{c + 1}_to_{c + 2}_NextCycle[{wc}]",
                    timing_class="NEXT_CYCLE",
                    flags=PSEUDO_PIP_MID,
                )


def genBel(t: Tile, tile: TileType, wireOnly: bool, context=1):
    bels = t.bels
    useClk = any([i.userCLK for i in bels])
    if useClk:
        clkDRV = tile.create_bel("CLK_DRV", "CLK_DRV", z=TILE_CLK)
        tile.create_wire("user_clk_o", "CLK")
        tile.add_bel_pin(clkDRV, "CLK_O", "user_clk_o", PinType.OUTPUT)
    gnd = tile.create_bel("GND_DRV", "GND_DRV", z=TILE_GND)
    tile.create_wire("gnd", "GND", "0")
    tile.add_bel_pin(gnd, "O", "gnd", PinType.OUTPUT)
    vcc = tile.create_bel("VCC_DRV", "VCC_DRV", z=TILE_VCC)
    tile.create_wire("vcc", "VCC", "1")
    tile.add_bel_pin(vcc, "O", "vcc", PinType.OUTPUT)

    for c in range(context):
        baseZ = c * len(list(bels))
        tile.create_wire(f"c{c}.gnd", "GND", flags=c + 1)
        tile.create_wire(f"c{c}.vcc", "VCC", flags=c + 1)
        tile.create_pip("vcc", f"c{c}.vcc")
        tile.create_pip("gnd", f"c{c}.gnd")

        for i in t.getBelSharedPort():
            for pName in i.shareExpand():
                tile.create_wire(f"c{c}.{pName}", f"SHARED_{i.sharedWith}", flags=c + 1)

        for z, bel in enumerate(bels):
            for i in bel.externalInputs + bel.inputs:
                for pName in i.expand():
                    tile.create_wire(
                        f"c{c}.{pName}", f"{bel.name}_{i.name}", flags=c + 1
                    )

            for i in bel.externalOutputs + bel.outputs:
                for pName in i.expand():
                    tile.create_wire(
                        f"c{c}.{pName}", f"{bel.name}_{i.name}", flags=c + 1
                    )

            if wireOnly:
                continue

            # create the bel itself
            belData = tile.create_bel(
                f"c{c}.{bel.prefix}{bel.name}",
                f"{bel.name}",
                bel.z + baseZ,
            )

            for i in bel.inputs:
                portDrivers = t.switchMatrix.getPortDrivers(i)
                if all([isinstance(i, BelPort) for i in portDrivers]):
                    for pName in i.expand():
                        tile.add_bel_pin(
                            belData,
                            f"{pName}".removeprefix(bel.prefix),
                            f"c{c}.{pName}",
                            PinType.INPUT,
                            flags=BEL_PIN_FULLY_INTERNAL,
                        )

                else:
                    for pName in i.expand():
                        tile.add_bel_pin(
                            belData,
                            f"{pName}".removeprefix(bel.prefix),
                            f"c{c}.{pName}",
                            PinType.INPUT,
                        )

            for i in bel.externalInputs:
                for pName in i.expand():
                    tile.add_bel_pin(
                        belData,
                        f"{pName}".removeprefix(bel.prefix),
                        f"c{c}.{pName}",
                        PinType.INPUT,
                    )

            for i in bel.outputs + bel.externalOutputs:
                for pName in i.expand():
                    tile.add_bel_pin(
                        belData,
                        f"{pName}".removeprefix(bel.prefix),
                        f"c{c}.{pName}",
                        PinType.OUTPUT,
                    )

            for i in bel.sharedPort:
                for pName, sName in zip(i.expand(), i.shareExpand()):
                    tile.add_bel_pin(
                        belData,
                        f"{pName}".removeprefix(bel.prefix),
                        f"c{c}.{sName}",
                        PinType.INPUT,
                        flags=BEL_PIN_SHARED,
                    )

            if bel.userCLK:
                tile.create_wire(
                    f"c{c}.{bel.prefix}{bel.name}_clk_i", "CLK", flags=c + 1
                )
                tile.add_bel_pin(
                    belData,
                    bel.userCLK.name,
                    f"c{c}.{bel.prefix}{bel.name}_clk_i",
                    PinType.INPUT,
                )
                tile.create_pip(
                    "user_clk_o",
                    f"c{c}.{bel.prefix}{bel.name}_clk_i",
                )
            belData.extra_data.context = c


def genTile(tile: Tile, subTile: str, chip: Chip, context=1) -> TileType:
    tt = chip.create_tile_type(subTile)

    genBel(
        tile,
        tt,
        context=context,
        wireOnly=tile.getSubTileOffset(subTile) != (0, 0),
    )
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


# TODO: fix for terminal ports
def genFabric(fabric: Fabric, chip: Chip, context=1):
    def clipX(value):
        return max(0, min(value, fabric.width - 1))

    def clipY(value):
        return max(0, min(value, fabric.height - 1))

    for (x, y), tileName in fabric.tileNames_iter():
        if tileName is None:
            continue

        tile = fabric.getTileByName(tileName)
        shareDest: dict[TilePort | BelPort, list[WireType]] = defaultdict(list)
        for wireType in tile.wireTypes[tileName]:
            assert wireType.destinationPort.width == wireType.sourcePort.width
            shareDest[wireType.sourcePort].append(wireType)

        for src, destList in shareDest.items():
            for c in range(context):
                nodes = []
                for n in src.expand():
                    nodes.append(
                        [
                            NodeWire(
                                clipX(x),
                                clipY(y),
                                f"c{c}.{n}",
                            )
                        ]
                    )
                for dest in destList:
                    for i, n in enumerate(dest.destinationPort.expand()):
                        nodes[i].append(
                            NodeWire(
                                clipX(x + dest.offsetX),
                                clipY(y + dest.offsetY),
                                f"c{c}.{n}",
                            )
                        )
                for node in nodes:
                    chip.add_node(node, "DEFAULT")
    setTiming(fabric, chip)


def setTiming(fabric: Fabric, chip: Chip):
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
        delay=TimingValue(200),  # 120ps intrinstic delay
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

    tmg.set_node_class(
        grade=speed,
        name="DEFAULT",
        delay=TimingValue(100),  # 100ps intrinstic delay
        cap=TimingValue(5000),  # 5pF
        res=TimingValue(1000),  # 1ohm
    )

    for i in range(fabric.contextCount):
        tmg.set_bel_pin_class(
            grade=speed,
            name=f"CONTEXT_{i}",
            delay=TimingValue(900 * (i + 1)),  # 100ps intrinstic delay
            in_cap=TimingValue(5000 * (i + 1)),  # 5pF
            out_res=TimingValue(1000 * (i + 1)),  # 1ohm
        )


def setPackage(chip: Chip, fabric: Fabric):
    pkg = chip.create_package("FABulous")
    with open(fabric.fabricDir.parent / ".FABulous/pinout.csv", "w") as f:
        # Add CSV header
        f.write("pad_name,tile_loc,bel_name,pad_function,pad_bank\n")

        for (x, y), tile in fabric:
            if tile is None:
                continue

            for bel in tile.bels:
                for port in bel.externalInputs + bel.externalOutputs:
                    for c in range(fabric.contextCount):
                        for pName in port.expand():
                            pad_name = f"X{x}Y{y}.{pName}"
                            tile_name = f"X{x}Y{y}"
                            bel_name = f"c{c}.{bel.prefix}{bel.name}"
                            # Create the pad in the package
                            pkg.create_pad(
                                pad_name,
                                tile_name,
                                bel_name,
                                "",
                                0,
                            )
                            # Write the pad information to the CSV file
                            f.write(f"{pad_name},{tile_name},{bel_name},{''},{0}\n")


def generateConstrainPair(fabric: Fabric, dest: Path):
    # for bel in fabric.getAllUniqueBels():
    #     f.write(f"#{bel.name}\n")
    #     for idx, i in enumerate(bel.inputs):
    #         if i.control:
    #             dz = (idx << 8) | CONTROL_GND_OFFSET
    #             f.write(f"{bel.name}:{i.name} 1 GND_DRV:GND 1  {dz}\n")
    #             dz = (idx << 8) | CONTROL_VCC_OFFSET
    #             f.write(f"{bel.name}:{i.name} 1 VCC_DRV:VCC 1 {dz}\n")

    #     f.write("\n")
    with open(dest, "w") as f:
        for t in fabric.tileDict.values():
            for bel in t.bels:
                for i in bel.inputs:
                    portDrivers = t.switchMatrix.getPortDrivers(i)
                    if all([isinstance(i, BelPort) for i in portDrivers]):
                        f.write(f"#{bel.prefix}{bel.name}:{i.name}\n")
                        for d in portDrivers:
                            d = cast(BelPort, d)
                            tBel = t.getBelByBelPort(d)
                            if bel == tBel:
                                continue

                            source = f"{bel.name}:{i.name.removeprefix(bel.prefix)} {i.width}"
                            target = f"{tBel.name}:{d.name.removeprefix(tBel.prefix)} {d.width}"
                            if tBel.z < bel.z:
                                f.write(f"{target} {source} {bel.z - tBel.z} \n")
                            else:
                                f.write(f"{source} {target} {tBel.z - bel.z} \n")
                        f.write("\n")
                for i in bel.outputs:
                    portUsers = t.switchMatrix.getPortUsers(i)
                    if all([isinstance(i, BelPort) for i in portUsers]):
                        f.write(f"#{bel.prefix}{bel.name}:{i.name}\n")
                        for u in portUsers:
                            u = cast(BelPort, u)
                            tBel = t.getBelByBelPort(u)
                            if bel == tBel:
                                continue

                            source = f"{bel.name}:{i.name.removeprefix(bel.prefix)} {i.width}"
                            target = f"{tBel.name}:{u.name.removeprefix(tBel.prefix)} {u.width}"
                            if tBel.z < bel.z:
                                f.write(f"{target} {source} {bel.z - tBel.z} \n")
                            else:
                                f.write(f"{source} {target} {tBel.z - bel.z} \n")
                        f.write("\n")

                # if bel.userCLK:
                #     f.write(f"{bel.name}:{bel.userCLK.name.rep} 1 CLK_DRV:CLK_O 1 {TILE_CLK-bel.z} \n")


def addPackingRule(chip: Chip, fabric: Fabric):
    for group, bels in fabric.getAllBelGroups():
        for belIndex, userBel in enumerate(bels):
            for userPort in userBel.inputs:
                for driverPort in fabric.getPortDrivers(userPort):
                    if not isinstance(driverPort, BelPort):
                        continue

                    driverPort = cast(BelPort, driverPort)
                    driverBel = fabric.getBelByBelPort(driverPort)

                    if userBel == driverBel:
                        continue

                    if driverBel not in bels:
                        continue

                    assert userPort.width == driverPort.width

                    if userBel.z > driverBel.z:
                        continue

                    chip.add_packing_rule(
                        driver_bel=driverBel.name,
                        driver_port=driverPort.name.removeprefix(driverBel.prefix),
                        user_bel=userBel.name,
                        user_port=userPort.name.removeprefix(userBel.prefix),
                        base_z=userBel.z,
                        width=userPort.width,
                        rel_x=0,
                        rel_y=0,
                        rel_z=driverBel.z - userBel.z,
                        base_rule=belIndex == 0,
                    )

                # print(f"Current BEL: {bel.prefix}{bel.name}")
                # for i in bel.outputs:
                #     portUsers = t.switchMatrix.getPortUsers(i)
                #     for u in portUsers:
                #         u = cast(BelPort, u)
                #         if not isinstance(u, BelPort):
                #             continue
                #         tBel = t.getBelByBelPort(u)
                #         print(f"{tBel.prefix}{tBel.name}")
                #         if bel == tBel:
                #             continue
                #         if bel not in t.belGroups[group]:
                #             logger.info(f"{tBel.name} not in group {group}")
                #             continue
                #         assert i.width == u.width
                #         if bel.z > tBel.z:
                #             continue

                #         print(f"Adding packing rule for {bel.name}:{i.name}({bel.z}) <= {tBel.name}:{u.name}({tBel.z})")
                #         chip.add_packing_rule(
                #             bel.name,
                #             i.name.removeprefix(bel.prefix),
                #             tBel.name,
                #             u.name.removeprefix(tBel.prefix),
                #             i.width,
                #             0,
                #             0,
                #             tBel.z - bel.z,
                #             c == 0,
                #         )


def generateChipDatabase(
    fabric: Fabric,
    filePath: Path,
    baseConstIdsPath: Path,
    dotDir: Path,
    selectTile: list[Loc] = [],
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
    setPackage(ch, fabric)
    addPackingRule(ch, fabric)
    ch.extra_data.context = fabric.contextCount
    ch.extra_data.belCount = fabric.getTotalBelCount()

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
    # generateConstrainPair(fabric, filePath / f"{fabric.name}_constrain_pair.inc")

    if dotDir != Path():
        genRoutingResourceGraph(ch, dotDir, False, selectTile)


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
