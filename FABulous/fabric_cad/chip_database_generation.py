from pathlib import Path
from subprocess import run

from loguru import logger

from FABulous.fabric_cad.chip import Chip, NodeWire, PinType, TileType
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO, Direction
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

    for i in tile.portsInfo:
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
    for i in range(fabric.numberOfRows):
        for j in range(fabric.numberOfColumns):
            if fabric.tile[i][j] is None:
                continue

            localNode = []
            for port in fabric.tile[i][j].portsInfo:
                if port.destinationName is not None and port.inOut == IO.OUTPUT:
                    localNode.append(
                        NodeWire(
                            j + port.xOffset, i + port.yOffset, port.destinationName
                        )
                    )

            if localNode:
                chip.add_node(localNode)


def genChipDatabase(fabric: Fabric, filePath: Path):
    ch = Chip("FABulous", fabric.name, fabric.numberOfColumns, fabric.numberOfRows)
    for tile in fabric.tileDic.values():
        genTile(tile, ch)

    ch.create_tile_type("NULL")

    for i in range(fabric.numberOfRows):
        for j in range(fabric.numberOfColumns):
            if fabric.tile[i][j] is not None:
                ch.set_tile_type(j, i, fabric.tile[i][j].name)
            else:
                ch.set_tile_type(j, i, "NULL")

    genFabric(fabric, ch)
    ch.write_bba(str(filePath / f"{fabric.name}.bba"))

    try:
        run(
            [
                "bbasm",
                "--l",
                str(filePath / f"{fabric.name}.bba"),
                "-o",
                str(filePath / f"{fabric.name}.bit"),
            ]
        )
    except Exception as e:
        logger.error(e)
        logger.error("Failed to compile the bba file to bit file.")
        raise e


if __name__ == "__main__":
    f = FABulous(VerilogWriter(), "/home/kelvin/FABulous_fork/myProject/fabric.yaml")
    f.setWriterOutputFile("/home/kelvin/FABulous_fork/test.v")
    # f.bootstrapSwitchMatrix("LUT4AB", "/home/kelvin/FABulous_fork/tmp.csv")
    ch = Chip(
        "FABulous", f.fabric.name, f.fabric.numberOfRows, f.fabric.numberOfColumns
    )
    genChipDatabase(f.fabric, Path("/home/kelvin/FABulous_fork/myProject/.FABulous"))
