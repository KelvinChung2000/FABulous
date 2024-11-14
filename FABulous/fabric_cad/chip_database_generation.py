from loguru import logger

from FABulous.fabric_cad.chip import Chip, NodeWire, PinType, TileType
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import Direction
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generation_Verilog import VerilogWriter
from FABulous.fabric_generator.fabric_gen import FabricGenerator
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
    else:
        logger.error("Invalid matrix file format.")
        raise ValueError

    for mux in muxDict.values():
        for i in mux.inputs:
            tileType.create_wire(i, f"SWITCH_{tile.name}")
        tileType.create_wire(mux.output, f"SWITCH_{tile.name}")

    for mux in muxDict.values():
        for s in mux.inputs:
            tileType.create_pip(s, mux.output, timing_class="SWINPUT")


def genBel(bels: list[Bel], tile: TileType):
    for z, bel in enumerate(bels):
        if bel.withUserCLK:
            tile.create_wire("UserCLK", f"{bel.name}_UserCLK")

        # create the bel itself
        belData = tile.create_bel(f"{bel.prefix}{bel.name}", bel.name, z)

        for i in bel.externalInput:
            tile.create_wire(i, f"{bel.name}_{i}")

        for i in bel.externalOutput:
            tile.create_wire(i, f"{bel.name}_{i}")

        for i in bel.inputs + bel.externalInput:
            tile.add_bel_pin(
                belData,
                f"{i.removeprefix(bel.prefix)}",
                i,
                PinType.INPUT,
            )
        for i in bel.outputs + bel.externalOutput:
            tile.add_bel_pin(
                belData,
                f"{i.removeprefix(bel.prefix)}",
                i,
                PinType.OUTPUT,
            )

        # if bel.withUserCLK:
        #     tile.add_bel_pin(
        #         belData,
        #         "UserCLK",
        #         f"{bel.name}_UserCLK",
        #         PinType.INPUT,
        #     )


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
                if (
                    port.wireDirection != Direction.JUMP
                    and port.sourceName != "NULL"
                    and port.destinationName != "NULL"
                    and chip.tile_type_at(j + port.xOffset, i + port.yOffset).name
                    != "NULL"
                ):
                    for w in range(port.wireCount):
                        localNode.append(
                            NodeWire(
                                j + port.xOffset,
                                i + port.yOffset,
                                f"{port.sourceName}{w}",
                            )
                        )
                        localNode.append(NodeWire(j, i, f"{port.destinationName}{w}"))

                    chip.add_node(localNode)


def genChipDatabase(fabric: Fabric):
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
    ch.write_bba(str(f"{fabric.name}.bba"))
    # if p := os.getenv("FAB_PROJ_DIR"):
    #     ch.write_bba(str(Path(p) / f"{fabric.name}.bba"))
    # else:
    #     logger.error("FAB_PROJ_DIR not set, cannot write bba file")
    #     return


if __name__ == "__main__":
    f = FABulous(VerilogWriter(), "/home/kelvin/FABulous_fork/demo/fabric.csv")
    f.setWriterOutputFile("/home/kelvin/FABulous_fork/test.v")
    # f.bootstrapSwitchMatrix("LUT4AB", "/home/kelvin/FABulous_fork/tmp.csv")
    f.loadFabric("/home/kelvin/FABulous_fork/demo/fabric.csv")
    f.genFabric()
    ch = Chip(
        "FABulous", f.fabric.name, f.fabric.numberOfRows, f.fabric.numberOfColumns
    )
    genChipDatabase(f.fabric)
