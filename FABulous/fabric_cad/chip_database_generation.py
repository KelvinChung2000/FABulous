from pathlib import Path
from subprocess import run

from loguru import logger

from FABulous.fabric_cad import prims_gen
from FABulous.fabric_cad.chip_database_gen.Bel import BelExtraData
from FABulous.fabric_cad.chip_database_gen.chip import (
    Chip,
    ChipExtraData,
    TileType,
    TimingValue,
)
from FABulous.fabric_cad.chip_database_gen.define import NodeWire, PinType
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import Direction
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generation_Verilog import VerilogWriter
from FABulous.FABulous_API import FABulous


def genSwitchMatrix(tile: Tile, tileType: TileType, context=1):
    for c in range(context):
        muxList = tile.switchMatrix
        muxDict = {i.name: i for i in muxList}
        createdWire = set()

        # cross tile wires
        for i in tile.ports:
            if i.wireDirection == Direction.JUMP:
                continue
            tileType.create_wire(f"{c}_{i.name}")
            createdWire.add(f"{c}_{i.name}")
            for cn in range(c, context):
                tileType.create_wire(f"{cn}_{i.name}")
                createdWire.add(f"{cn}_{i.name}")

        for mux in muxDict.values():
            for i in mux.inputs:
                if i not in createdWire:
                    tileType.create_wire(f"{c}_{i}")
            if mux.output not in createdWire:
                tileType.create_wire(f"{c}_{mux.output}")

        for mux in muxDict.values():
            for s in mux.inputs:
                tileType.create_pip(f"{c}_{s}", f"{c}_{mux.output}")

        # cross cycle pip
        for cn in range(c + 1, context):
            tileType.create_wire(f"{c}_to_{cn}_NextCycle")
            for mux in muxDict.values():
                if mux.output in createdWire:
                    for s in mux.inputs:
                        tileType.create_pip(f"{c}_{s}", f"{c}_to_{cn}_NextCycle")
                        tileType.create_pip(
                            f"{c}_to_{cn}_NextCycle", f"{cn}_{mux.output}"
                        )
        for cn in range(c + 1, context - 1):
            tileType.create_pip(f"{c}_to_{cn}_NextCycle", f"{c+1}_to_{cn+1}_NextCycle")


def genBel(bels: list[Bel], tile: TileType, context=1):
    for c in range(context):
        for z, bel in enumerate(bels):
            # create the bel itself
            belData = tile.create_bel(f"{c}_{bel.prefix}{bel.name}", bel.name, c * z)

            for i in bel.externalInput:
                tile.create_wire(f"{c}_{i.name}", f"{bel.name}_{i}")

            for i in bel.externalOutput:
                tile.create_wire(f"{c}_{i.name}", f"{bel.name}_{i}")

            if bel.userCLK:
                tile.create_wire(f"{c}_{bel.name}_{bel.userCLK.name}")

            for i in bel.inputs + bel.externalInput:
                tile.add_bel_pin(
                    belData,
                    f"{i.name}",
                    f"{c}_{i.name}",
                    PinType.INPUT,
                )
            for i in bel.outputs + bel.externalOutput:
                tile.add_bel_pin(
                    belData,
                    f"{i.name}",
                    f"{c}_{i.name}",
                    PinType.OUTPUT,
                )

            if bel.userCLK:
                tile.add_bel_pin(
                    belData,
                    bel.userCLK.name,
                    f"{c}_{bel.name}_{bel.userCLK.name}",
                    PinType.INPUT,
                )
            belData.add_extra_data(BelExtraData(context=c))


def genTile(tile: Tile, chip: Chip, context=1) -> TileType:
    tt = chip.create_tile_type(tile.name)
    genSwitchMatrix(tile, tt, context=context)
    genBel(tile.bels, tt, context=context)
    return tt


def genFabric(fabric: Fabric, chip: Chip, context=1):
    for (x, y), wires in fabric.wireDict.items():
        if not wires:
            continue
        localNode = []
        for wire in wires:
            for c in range(context):
                localNode.append(
                    NodeWire(
                        x,
                        y,
                        f"{c}_{wire.source.name}",
                    )
                )
                localNode.append(
                    NodeWire(
                        x + wire.xOffset,
                        y + wire.yOffset,
                        f"{c}_{wire.destination.name}",
                    )
                )
        for c in range(context):
            for cn in range(c + 1, context):
                localNode.append(NodeWire(x, y, f"{c}_to_{cn}_NextCycle"))

        # print(localNode)
        # chip.add_node(localNode)
        # print()
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


def genChipDatabase(fabric: Fabric, filePath: Path, baseConstIdsPath: Path):
    ch = Chip("FABulous", fabric.name, fabric.numberOfColumns, fabric.numberOfRows)

    ch.strs.read_constids(str(baseConstIdsPath))
    for tile in fabric.tileDict.values():
        genTile(tile, ch, fabric.contextCount)

    logger.info("Generating the chip database")
    ch.create_tile_type("NULL")

    for i in range(fabric.numberOfRows):
        for j in range(fabric.numberOfColumns):
            if fabric.tile[i][j] is not None:
                ch.set_tile_type(j, i, fabric.tile[i][j].name)
            else:
                ch.set_tile_type(j, i, "NULL")

    genFabric(fabric, ch, context=fabric.contextCount)

    ch.extra_data = ChipExtraData(fabric.contextCount, fabric.getTotalBelCount())
    logger.info(f"Context Count: {fabric.contextCount}")
    logger.info(
        f"Total BEL Count: {fabric.getTotalBelCount()}",
    )
    ch.strs.toConstStringId(str(filePath / f"{fabric.name}_constids.inc"))
    ch.read_gfxids(str(filePath / f"{fabric.name}_constids.inc"))_PAD

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
    prims_gen.prims_gen(Path(Path.cwd() / "myProject/.FABulous" / "prims.v"), f.fabric)
