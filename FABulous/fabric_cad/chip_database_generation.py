from pathlib import Path
from subprocess import run

from loguru import logger

from FABulous.fabric_cad.chip import Chip, NodeWire, PinType, TileType, TimingValue
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import Direction
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generation_Verilog import VerilogWriter
from FABulous.fabric_generator.fabric_gen import FabricGenerator
from FABulous.fabric_generator.file_parser_list import parseMux
from FABulous.fabric_generator.file_parser_yaml import parseMatrixAsMux
from FABulous.FABulous_API import FABulous


def genSwitchMatrix(tile: Tile, tileType: TileType):
    if tile.matrixDir.suffix == ".csv":
        muxDict = parseMatrixAsMux(tile.matrixDir, tile.name)
    elif tile.matrixDir.suffix == ".list":
        logger.info(f"{tile.name} matrix is a list file")
        logger.info(
            f"Bootstrapping {tile.name} to matrix form and adding the list file to the matrix"
        )
        matrixDir = tile.matrixDir.with_suffix(".csv")
        FabricGenerator.bootstrapSwitchMatrix(tile, matrixDir)
        FabricGenerator.list2CSV(tile.matrixDir, matrixDir)
        logger.info(
            f"Update matrix directory to {matrixDir} for Fabric Tile Dictionary"
        )
        tile.matrixDir = matrixDir
        muxDict = parseMatrixAsMux(tile.matrixDir, tile.name)
    elif tile.matrixDir.suffix == ".v" or tile.matrixDir.suffix == ".vhdl":
        logger.info(
            f"A switch matrix file is provided in {tile.name}, will skip the matrix generation process"
        )
        return
    elif tile.matrixDir.suffix == ".mux":
        logger.info(f"{tile.name} matrix is a mux file")
        muxList = parseMux(tile.matrixDir)
        muxDict = {i.name: i for i in muxList}
    else:
        logger.error("Invalid matrix file format.")
        raise ValueError

    wires = set()

    for i in tile.ports:
        if i.wireDirection == Direction.JUMP:
            continue
        tileType.create_wire(i.name, f"NEBR_{tile.name}")
        wires.add(i.name)

    for mux in muxDict.values():
        for i in mux.inputs:
            if i not in wires:
                tileType.create_wire(i, f"SWITCH_{tile.name}")
        if mux.output not in wires:
            tileType.create_wire(mux.output, f"SWITCH_{tile.name}")

    for mux in muxDict.values():
        for s in mux.inputs:
            tileType.create_pip(s, mux.output)


def genBel(bels: list[Bel], tile: TileType):
    for z, bel in enumerate(bels):

        # create the bel itself
        belData = tile.create_bel(f"{bel.prefix}{bel.name}", bel.name, z)

        for i in bel.externalInput:
            tile.create_wire(i.name, f"{bel.name}_{i}")

        for i in bel.externalOutput:
            tile.create_wire(i.name, f"{bel.name}_{i}")

        if bel.userCLK:
            tile.create_wire(f"{bel.name}_{bel.userCLK.name}")

        for i in bel.inputs + bel.externalInput:
            tile.add_bel_pin(
                belData,
                f"{i.name}",
                i.name,
                PinType.INPUT,
            )
        for i in bel.outputs + bel.externalOutput:
            tile.add_bel_pin(
                belData,
                f"{i.name}",
                i.name,
                PinType.OUTPUT,
            )

        if bel.userCLK:
            tile.add_bel_pin(
                belData,
                bel.userCLK.name,
                f"{bel.name}_{bel.userCLK.name}",
                PinType.INPUT,
            )


def genTile(tile: Tile, chip: Chip) -> TileType:
    tt = chip.create_tile_type(tile.name)
    genSwitchMatrix(tile, tt)
    genBel(tile.bels, tt)
    return tt


def genFabric(fabric: Fabric, chip: Chip):
    for (x, y), wires in fabric.wireDict.items():
        if not wires:
            continue
        localNode = []
        for wire in wires:
            localNode.append(
                NodeWire(
                    x,
                    y,
                    wire.source.name,
                )
            )
            localNode.append(
                NodeWire(
                    x + wire.xOffset,
                    y + wire.yOffset,
                    wire.destination.name,
                )
            )

        chip.add_node(localNode)

    # for i in range(fabric.numberOfRows):
    #     for j in range(fabric.numberOfColumns):
    #         if fabric.tile[i][j] is None:
    #             continue

    #         localNode = []

    #         for port in fabric.tile[i][j].ports:
    #             if port.destinationName is not None and port.inOut == IO.OUTPUT:
    #                 localNode.append(
    #                     NodeWire(
    #                         j + port.xOffset, i + port.yOffset, port.destinationName
    #                     )
    #                 )

    #         if localNode:
    #             chip.add_node(localNode)

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


def genChipDatabase(fabric: Fabric, filePath: Path, baseConstIdsPath: Path):
    ch = Chip("FABulous", fabric.name, fabric.numberOfColumns, fabric.numberOfRows)

    ch.strs.read_constids(str(baseConstIdsPath))
    for tile in fabric.tileDict.values():
        genTile(tile, ch)

    logger.info("Generating the chip database")
    ch.create_tile_type("NULL")

    for i in range(fabric.numberOfRows):
        for j in range(fabric.numberOfColumns):
            if fabric.tile[i][j] is not None:
                ch.set_tile_type(j, i, fabric.tile[i][j].name)
            else:
                ch.set_tile_type(j, i, "NULL")

    genFabric(fabric, ch)
    logger.info(f"Writing the chip database to {filePath / f'{fabric.name}.bba'}")
    ch.write_bba(str(filePath / f"{fabric.name}.bba"))
    logger.info(
        f"Writing Constant String IDs to {filePath / f'{fabric.name}_constids.inc'}"
    )
    ch.strs.toConstStringId(str(filePath / f"{fabric.name}_constids.inc"))

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
    f = FABulous(VerilogWriter(), str(Path.cwd() / "myProject" / "fabric.yaml"))
    f.setWriterOutputFile("/home/kelvin/FABulous_fork/test.v")
    # f.bootstrapSwitchMatrix("LUT4AB", "/home/kelvin/FABulous_fork/tmp.csv")
    ch = Chip(
        "FABulous", f.fabric.name, f.fabric.numberOfRows, f.fabric.numberOfColumns
    )
    genChipDatabase(
        f.fabric,
        Path(Path.cwd() / "myProject/.FABulous"),
        Path(Path.cwd() / "myProject/.FABulous" / "baseConstIds.inc"),
    )
