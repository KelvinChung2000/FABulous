from collections import defaultdict
from email.policy import default
import sys
from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path

from jinja2 import Environment, PackageLoader

from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import Port, TilePort
from FABulous.fabric_definition.SwitchMatrix import Mux, MuxPort, SwitchMatrix
from FABulous.fabric_definition.Tile import Tile
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
    slicingPortDict: dict[GenericPort, list[MuxPort]] = defaultdict(list)
    for i in muxList.__dict__.values():
        if not isinstance(i, MuxPort):
            continue
        
        if i.isSliced:
            slicingPortDict[i.port].append(i)
            continue

        m = Mux(i.port.name, i.inputs, i.port)
        sm.addMux(m)

    return sm



if __name__ == "__main__":
    fabric = parseFabricYAML(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))
    for tile in fabric.tileDict.values():
        initPortHinting(fabric, tile)
        # print(f"Generated port hinting for tile {tile.name}")
    genSwitchMatrix(fabric.tileDict["PE"])
