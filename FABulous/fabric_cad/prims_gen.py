from functools import partial
from itertools import product
from pathlib import Path

from pyosys import libyosys as ys

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import ConfigPort
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.fabric_generator.define import WriterType
from FABulous.file_parser.file_parser_HDL import parseBelFile


def prims_gen(filename: Path, fabric: Fabric):
    belList = {}

    for name, tile in fabric.tileDict.items():
        for bel in tile.bels:
            with open(bel.src, "r") as f:
                belList[bel.name] = f.read()

    with open(filename, "w") as f:
        for bel in belList.values():
            f.write(bel)
            f.write("\n")


def mergeFiles(inputFiles: list[Path], outputFile: Path):
    """Merge multiple files into one file.

    Parameters
    ----------
    inputFiles : list of str
        List of input file paths to be merged.
    outputFile : str
        Path of the output file.
    """
    outputPath = Path(outputFile)
    with outputPath.open("w") as outfile:
        for file in inputFiles:
            inputPath = Path(file)
            if inputPath.is_file():
                with inputPath.open("r") as inFile:
                    content = inFile.read()
                    outfile.write(content)
                    outfile.write("\n")
            inputPath.unlink()


def genPrimsFromBelHDL(bel: Bel):
    if not bel.src.exists():
        raise ValueError(f"File {bel.src} not found.")

    Path(bel.src.parent / "metadata").mkdir(exist_ok=True)

    design = ys.Design()
    runPass = partial(lambda design, cmd: ys.run_pass(cmd, design), design)

    runPass("read_verilog -sv " + str(bel.src))
    runPass("hierarchy -auto-top")
    runPass("proc")
    runPass("opt;;;")
    runPass("select a:CONTROL a:CONFIG_BIT")
    runPass("select -del a:INIT")

    inputPortsSize: dict[str, int] = {}

    if len(design.selected_modules()) > 1:
        raise ValueError("Multiple modules found.")
    elif len(design.selected_modules()) == 0:
        raise ValueError("No modules found.")

    module = design.top_module()
    featureWireMap = {}
    for wire in module.selected_wires():
        p = bel.findPortByName(wire.name.str()[1:])
        if isinstance(p, ConfigPort):
            if len(p.features) == 1:
                inputPortsSize[wire.name.str()] = 1
                featureWireMap[wire.name.str()] = [("", 0)] + p.features
            else:
                inputPortsSize[wire.name.str()] = len(p.features) - 1
                featureWireMap[wire.name.str()] = p.features
        else:
            inputPortsSize[wire.name.str()] = 1
            featureWireMap[wire.name.str()] = [
                ("", 0),
                (wire.name.str(), 1),
            ]

    keys = list(inputPortsSize.keys())
    ranges = [range(value + 1) for value in inputPortsSize.values()]
    combinations = [tuple(zip(keys, values)) for values in product(*ranges)]

    runPass("cd")
    runPass("setattr -unset src")
    runPass("design -save base")

    filePath = bel.src.parent / "metadata"

    cellDict = {}
    files: list[Path] = []
    for c in combinations:
        nameStr = f"{bel.name}_" + "_".join(
            [f"{cKey.removeprefix("\\")}_{cValue}" for cKey, cValue in c]
        )
        for cKey, cValue in c:
            runPass(f"connect -set {cKey} {cValue}")
        runPass("opt;")
        runPass("clean -purge")
        module = design.top_module()
        runPass("select c:*")
        if len(module.selected_cells()) >= 1:
            runPass(f"rename -top {nameStr}")
            runPass(f"write_verilog -noattr -sv {filePath / f"{nameStr}.v"}")
            files.append(filePath / f"{nameStr}.v")
            cellDict[nameStr] = c
        runPass("design -load base")

    mergeFiles(files, filePath / f"{bel.name}cells.v")

    module = design.top_module()
    cg = CodeGenerator(Path(f"{filePath}/{bel.name}_maps.v"), WriterType.VERILOG)
    for name, c in cellDict.items():
        with cg.Module(f"map_{name}", [cg.Attribute("techmap_celltype", name)]) as m:
            with m.PortRegion() as pr:
                runPass("select i:*")
                for port in module.selected_wires():
                    pr.Port(port.name.str().removeprefix("\\"), IO.INPUT, port.width)
                runPass("select o:*")
                for port in module.selected_wires():
                    pr.Port(port.name.str().removeprefix("\\"), IO.OUTPUT, port.width)

            with m.LogicRegion() as lr:
                with lr.Generate() as g:
                    runPass("select x:*")
                    runPass("select -del a:CONFIG_BIT")
                    runPass("select -del a:USER_CLK")
                    connect = [
                        i.name.str().removeprefix("\\") for i in module.selected_wires()
                    ]
                    g.InitModule(
                        bel.name,
                        "_TECHMAP_REPLACE_",
                        [g.ConnectPair(i, i) for i in connect],
                        [g.ConnectPair(i.removeprefix("\\"), j) for i, j in c],
                    )


if __name__ == "__main__":
    # genPrimsFromBelHDL(Path("./myProject/Tile/PE/ALU.v"))
    genPrimsFromBelHDL(parseBelFile(Path("./myProject/Tile/PE/ALU.v")))
