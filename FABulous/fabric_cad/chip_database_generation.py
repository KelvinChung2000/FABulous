import os
from pathlib import Path

from loguru import logger

from FABulous.fabric_cad.chip import Chip, PinType, TileType
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generation_Verilog import VerilogWriter
from FABulous.fabric_generator.file_parser import parseMatrixAsMux
from FABulous.FABulous_API import FABulous


def genSwitchMatrix(tile: Tile, tileType: TileType):
    muxDict = parseMatrixAsMux(
        Path("/home/kelvin/FABulous_fork/demo/Tile/LUT4AB/LUT4AB_switch_matrix.csv"),
        tile.name,
    )

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


def genChipDatabase(fabric: Fabric):
    ch = Chip("FABulous", fabric.name, fabric.numberOfRows, fabric.numberOfColumns)
    

    if p := os.getenv("FAB_PROJ_DIR"):
        ch.write_bba(str(Path(p) / f"{fabric.name}.bba"))
    else:
        logger.error("FAB_PROJ_DIR not set, cannot write bba file")
        return


if __name__ == "__main__":
    f = FABulous(VerilogWriter(), "/home/kelvin/FABulous_fork/demo/fabric.csv")
    f.setWriterOutputFile("/home/kelvin/FABulous_fork/test.v")
    f.bootstrapSwitchMatrix("LUT4AB", "/home/kelvin/FABulous_fork/tmp.csv")
    f.loadFabric("/home/kelvin/FABulous_fork/demo/fabric.csv")
    f.genFabric()
    ch = Chip(
        "FABulous", f.fabric.name, f.fabric.numberOfRows, f.fabric.numberOfColumns
    )
    genTile(f.fabric.tileDic["LUT4AB"], ch)
