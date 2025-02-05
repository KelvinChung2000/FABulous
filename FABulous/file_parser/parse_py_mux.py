import sys
from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path

from jinja2 import Environment, PackageLoader

from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import Port, SlicedPort, TilePort
from FABulous.fabric_definition.SwitchMatrix import Mux, MuxPort, SwitchMatrix
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.TileSwitchMatrix_generator import (
    generateTileSwitchMatrix,
)
from FABulous.file_parser.file_parser_yaml import parseFabricYAML

GenericPort = Port | TilePort


def initPortHinting(fabric: Fabric, tile: Tile):
    environment = Environment(loader=PackageLoader("FABulous"))
    template = environment.get_template("muxPortHint.py.jinja")
    content = template.render(tile=tile)
    with open(tile.tileDir.parent / f"{tile.name}_ports.py", "w") as f:
        f.write(content)

    template = environment.get_template("listFile.py.jinja")
    dirPath = str(
        tile.tileDir.relative_to(fabric.fabricDir.parent.parent).parent
    ).replace("/", ".")
    content = template.render(
        title=tile.name,
        path=dirPath,
    )
    if not (tile.tileDir.parent / "list.py").exists():
        with open(tile.tileDir.parent / "list.py", "w") as f:
            f.write(content)


def genSwitchMatrix(tile: Tile) -> SwitchMatrix:
    if not (tile.tileDir.parent / "list.py").exists():
        raise FileNotFoundError("list.py not found, please run initPortHinting first")

    if listModuleSpec := spec_from_file_location("PE", tile.tileDir.parent / "list.py"):
        listModule = module_from_spec(listModuleSpec)
        sys.modules["PE"] = listModule
        if loader := listModuleSpec.loader:
            loader.exec_module(listModule)
        else:
            raise ValueError("No loader found")
    else:
        raise ValueError("File loading failed")

    muxList = listModule.MuxList()
    muxList.construct()
    sm = SwitchMatrix()
    slicedPort: list[MuxPort] = []
    for i in muxList.__dict__.values():
        if not isinstance(i, MuxPort):
            continue

        if i.isSliced:
            slicedPort.append(i)
            continue

        if i.isTilePort and i.port.ioDirection == IO.INPUT:
            continue

        if i.isBelPort and i.port.ioDirection == IO.OUTPUT:
            continue

        m = Mux(i.port.name, [p.port for p in i.inputs], i.port)
        sm.addMux(m)

    for sPort in slicedPort:
        if not sPort.slicingAssignDict.keys():
            continue

        combinedAssignWidth = 0
        for targetRange in sPort.slicingAssignDict.keys():
            combinedAssignWidth += (targetRange.start - targetRange.end) + 1

        if combinedAssignWidth != sPort.port.wireCount:
            print(combinedAssignWidth, sPort.port.wireCount)
            raise ValueError("not all the signal of the original port is assigned")

        for test_range in sPort.slicingAssignDict.keys():
            for range in sPort.slicingAssignDict.keys():
                if test_range == range:
                    continue
                if test_range.start >= range.start and test_range.end <= range.end:
                    raise ValueError(
                        "Sliced signals overlap, please check the slicing assignment"
                    )

        for targetRange, slicedSignals in sPort.slicingAssignDict.items():
            uniqueSWidth = set()
            for signal in slicedSignals:
                if signal.sliceRange == (-1, -1):
                    uniqueSWidth.add(signal.port.wireCount)
                else:
                    uniqueSWidth.add(
                        signal.sliceRange.start - signal.sliceRange.end + 1
                    )

            if len(uniqueSWidth) != 1:
                raise ValueError("Not all the slice signals have the same width")
            if uniqueSWidth.pop() != targetRange.start - targetRange.end + 1:
                raise ValueError("Sliced signals do not match target range")

            start, end = targetRange
            for signal in slicedSignals:
                newTargetPort = SlicedPort(
                    name=f"{sPort.port.name}_{start}_{end}",
                    ioDirection=sPort.port.ioDirection,
                    wireCount=start - end + 1,
                    isBus=False,
                    originalPort=signal.port,
                )
                newInputPortList = []

                for i in slicedSignals:
                    if i.sliceRange == (-1, -1):
                        newInputPortList.append(i.port)
                    else:
                        newInputPortList.append(
                            SlicedPort(
                                name=f"{i.port.name}_{i.sliceRange.start}_{i.sliceRange.end}",
                                ioDirection=i.port.ioDirection,
                                wireCount=i.sliceRange.start - i.sliceRange.end + 1,
                                isBus=False,
                                originalPort=i.port,
                            )
                        )

                m = Mux(
                    f"{sPort.port.name}_{start}_{end}",
                    newInputPortList,
                    newTargetPort,
                )
                sm.addMux(m)
    return sm


if __name__ == "__main__":
    fabric = parseFabricYAML(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))
    for tile in fabric.tileDict.values():
        initPortHinting(fabric, tile)
        # print(f"Generated port hinting for tile {tile.name}")
    sm = genSwitchMatrix(fabric.tileDict["PE"])
    fabric.tileDict["PE"].switchMatrix = sm

    generateTileSwitchMatrix(fabric, fabric.tileDict["PE"], Path("../test_sm.v"))
