import sys
from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path

from jinja2 import Environment, PackageLoader

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Port import BelPort, Port, SlicedPort, TilePort
from FABulous.fabric_definition.SwitchMatrix import Mux, MuxPort, SwitchMatrix

GenericPort = Port | TilePort


def setupPortData(
    tileName: str, tileDir: Path, tilePorts: list[TilePort], bels: list[Bel]
):
    environment = Environment(loader=PackageLoader("FABulous"))
    template = environment.get_template("portData.py.jinja")
    belInputs = []
    belOutputs = []
    for bel in bels:
        for port in bel.inputs:
            belInputs.append(port)
        for port in bel.outputs:
            belOutputs.append(port)

    content = template.render(
        tileName=tileName,
        tilePorts=tilePorts,
        belInputs=belInputs,
        belOutputs=belOutputs,
    )
    with open(tileDir.parent / f"metadata/{tileName}_ports.py", "w") as f:
        f.write(content)
    template = environment.get_template("listFile.py.jinja")
    dirPath = str(tileDir.parent).replace("/", ".")
    content = template.render(
        title=tileName,
        path=dirPath,
    )

    if not (tileDir.parent / "list.py").exists():
        with open(tileDir.parent / "list.py", "w") as f:
            f.write(content)


def genSwitchMatrix(
    tileName: str, tileDir: Path, ports: list[TilePort], bels: list[Bel]
) -> SwitchMatrix:
    if listModuleSpec := spec_from_file_location(
        tileDir.parent.name, tileDir.parent / "list.py"
    ):
        listModule = module_from_spec(listModuleSpec)
        sys.modules[tileName] = listModule
        if loader := listModuleSpec.loader:
            loader.exec_module(listModule)
        else:
            raise ValueError("No loader found")
    else:
        raise ValueError("File loading failed")
    belInputs = []
    belOutputs = []
    for bel in bels:
        for port in bel.inputs:
            belInputs.append(port)
        for port in bel.outputs:
            belOutputs.append(port)
    muxList = listModule.MuxList(ports, belInputs, belOutputs)
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

        if not i.inputs:
            continue

        if i.isBelPort:
            assert isinstance(i.port, BelPort)
            m = Mux(f"{i.port.prefix}{i.port.name}", [p.port for p in i.inputs], i.port)
        else:
            m = Mux(i.port.name, [p.port for p in i.inputs], i.port)

        sm.addMux(m)

    for sPort in slicedPort:
        if not sPort.slicingAssignDict.keys():
            continue

        combinedAssignWidth = 0
        for targetRange in sPort.slicingAssignDict.keys():
            combinedAssignWidth += (targetRange.start - targetRange.end) + 1

        if combinedAssignWidth != sPort.port.width:
            print(combinedAssignWidth, sPort.port.width)
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
                    uniqueSWidth.add(signal.port.width)
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
                    width=start - end + 1,
                    isBus=False,
                    originalPort=sPort.port,
                    sliceRange=targetRange,
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
                                width=i.sliceRange.start - i.sliceRange.end + 1,
                                isBus=False,
                                originalPort=i.port,
                                sliceRange=i.sliceRange,
                            )
                        )

                m = Mux(
                    f"{sPort.port.name}_{start}_{end}",
                    newInputPortList,
                    newTargetPort,
                )
                sm.addMux(m)
    return sm


# if __name__ == "__main__":
#     fabric = parseFabricYAML(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))
#     for tile in fabric.tileDict.values():
#         initPortHinting(fabric, tile)
#         # print(f"Generated port hinting for tile {tile.name}")
#     sm = genSwitchMatrix(fabric.tileDict["PE"])
#     fabric.tileDict["PE"].switchMatrix = sm

#     generateTileSwitchMatrix(fabric, fabric.tileDict["PE"], Path("../test_sm.v"))
