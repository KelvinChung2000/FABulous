import contextlib
import itertools
import sys
from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path

from jinja2 import Environment, PackageLoader

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Port import BelPort, Port, SlicedPort, TilePort
from FABulous.fabric_definition.SwitchMatrix import Mux, MuxPack, SwitchMatrix

GenericPort = Port | TilePort


@contextlib.contextmanager
def addPythonPath(pathToAdd: Path):
    """Temporarily add a directory to the Python path.

    Parameters
    ----------
    pathToAdd : Path
        Directory to add to Python path

    Yields
    ------
    None
    """
    oldPath = sys.path.copy()
    sys.path.insert(0, str(pathToAdd))
    try:
        yield
    finally:
        sys.path = oldPath


def setupPortData(
    tileName: str, tileDir: Path, tilePorts: dict[str, list[TilePort]], bels: list[Bel]
):
    environment = Environment(loader=PackageLoader("FABulous"))
    template = environment.get_template("portData.py.jinja")
    belInputs = []
    belOutputs = []
    belShared = []
    for bel in bels:
        for port in bel.inputs:
            belInputs.append(port)
        for port in bel.outputs:
            belOutputs.append(port)
        for port in bel.sharedPort:
            if port not in belShared:
                belShared.append(port)

    ports = list(itertools.chain([(k, j) for k, v in tilePorts.items() for j in v]))
    content = template.render(
        tileName=tileName,
        subTileCount=len(tilePorts),
        tilePorts=ports,
        belInputs=belInputs,
        belOutputs=belOutputs,
        belShared=belShared,
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
    tileName: str,
    tileDir: Path,
    ports: dict[str, list[TilePort]],
    bels: list[Bel],
    fabricDir: Path,
) -> SwitchMatrix:
    with addPythonPath(fabricDir.parent.absolute().resolve()):
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
        belShared = []
        for bel in bels:
            for port in bel.inputs:
                belInputs.append(port)
            for port in bel.outputs:
                belOutputs.append(port)
            for port in bel.sharedPort:
                if port not in belShared:
                    belShared.append(port)
        muxList = listModule.MuxList(
            list(itertools.chain.from_iterable([i for i in ports.values()])),
            belInputs,
            belOutputs,
            belShared,
        )
        muxList.construct()
    sm = SwitchMatrix()
    for i in muxList.__dict__.values():
        if not isinstance(i, MuxPack):
            continue

        if isinstance(i.ogPort, TilePort) and i.ogPort.ioDirection == IO.INPUT:
            continue

        if isinstance(i.ogPort, BelPort) and i.ogPort.ioDirection == IO.OUTPUT:
            continue

        if all([len(i.port[0].inputs) == len(m.inputs) for m in i.port[1:]]):
            r = [p.originalPort for p in i.port[0].inputs if isinstance(p, SlicedPort)]
            if (
                isinstance(i.ogPort, BelPort)
                and i.ogPort.ioDirection == IO.INPUT
                and len(r) == 0
            ):
                raise ValueError(
                    f"{i.ogPort} have no input, which should never happen (at: {tileDir.parent / 'list.py'})"
                )

            if len(r) == 0:
                continue
            sm.addMux(Mux(i.ogPort, r))
        else:
            for j in i.port:
                if (
                    isinstance(j, BelPort)
                    and i.ogPort.ioDirection == IO.INPUT
                    and len(j.inputs) == 0
                ):
                    raise ValueError(
                        f"{j} have no input, which should never happen (at: {tileDir.parent / 'list.py'})"
                    )
                if len(j.inputs) == 0:
                    continue
                sm.addMux(j)

    return sm


# if __name__ == "__main__":
#     fabric = parseFabricYAML(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))
#     for tile in fabric.tileDict.values():
#         initPortHinting(fabric, tile)
#         # print(f"Generated port hinting for tile {tile.name}")
#     sm = genSwitchMatrix(fabric.tileDict["PE"])
#     fabric.tileDict["PE"].switchMatrix = sm

#     generateTileSwitchMatrix(fabric, fabric.tileDict["PE"], Path("../test_sm.v"))
