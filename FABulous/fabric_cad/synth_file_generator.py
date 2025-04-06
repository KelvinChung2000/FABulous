import json
from functools import partial
from itertools import product
from pathlib import Path
from pprint import pprint
from typing import Mapping

from jinja2 import Environment, PackageLoader
from pyosys import libyosys as ys

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import ConfigPort
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.fabric_generator.define import (
    PossibleBinaryType,
    PossibleRegType,
    WriterType,
)
from FABulous.fabric_generator.HDL_Construct.Value import Value


def genPrims(bel: Bel, filePath: Path):
    cg = CodeGenerator(filePath, WriterType.VERILOG)
    with cg.Module(f"{bel.name}", [cg.Attribute("blackbox")]) as m:
        with m.ParameterRegion() as pr:
            for i in bel.configPort:
                pr.Parameter(i.name, 0)

        with m.PortRegion() as pr:
            for i in bel.inputs + bel.externalInputs:
                pr.Port(i.name, IO.INPUT, i.width)
            for i in bel.outputs + bel.externalOutputs:
                pr.Port(i.name, IO.OUTPUT, i.width)
            if bel.userCLK:
                pr.Port(bel.userCLK.name, IO.INPUT, 1)


def genBinaryWrapMap(cell, filename, belName, wrapping=True):
    cg = CodeGenerator(filename, WriterType.VERILOG, "a")
    cellType = cell["type"].replace("$", "_")

    if wrapping:
        srcCell, targetCell = f"\\{cell["type"]}", f"\\$_{cellType}_wrapper"
    else:
        srcCell, targetCell = f"\\$_{cellType}_wrapper", f"\\{cell["type"]}"

    with cg.Module(
        f"wrap_{belName}_{cellType}" if wrapping else f"unwrap_{belName}_{cellType}",
        [cg.Attribute("techmap_celltype", srcCell)],
    ) as m:
        with m.ParameterRegion() as pr:
            aWidthParam = pr.Parameter("A_WIDTH", 1)
            aSignedParam = pr.Parameter("A_SIGNED", 0)
            bWidthParam = pr.Parameter("B_WIDTH", 1)
            bSignedParam = pr.Parameter("B_SIGNED", 0)
            yWidthParam = pr.Parameter("Y_WIDTH", 1)

        with m.PortRegion() as pr:
            portA = pr.Port("A", IO.INPUT, aWidthParam)
            portB = pr.Port("B", IO.INPUT, bWidthParam)
            portY = pr.Port("Y", IO.OUTPUT, yWidthParam)

        with m.LogicRegion() as lr:
            if wrapping:
                sigA = lr.Signal(
                    f"A_{int(cell["parameters"]["A_WIDTH"], 2)}",
                    int(cell["parameters"]["A_WIDTH"], 2),
                )
                sigB = lr.Signal(
                    f"B_{int(cell["parameters"]["B_WIDTH"], 2)}",
                    int(cell["parameters"]["B_WIDTH"], 2),
                )
                sigY = lr.Signal(
                    f"Y_{int(cell["parameters"]["Y_WIDTH"], 2)}",
                    int(cell["parameters"]["Y_WIDTH"], 2),
                )
            else:
                sigA = lr.Signal("A_ORIG", int(cell["parameters"]["A_WIDTH"], 2))
                sigB = lr.Signal("B_ORIG", int(cell["parameters"]["B_WIDTH"], 2))
                sigY = lr.Signal("Y_ORIG", int(cell["parameters"]["Y_WIDTH"], 2))

            lr.Assign(sigA, portA)
            lr.Assign(sigB, portB)
            lr.Assign(portY, sigY)

            lr.InitModule(
                targetCell,
                "_TECHMAP_REPLACE_",
                [
                    lr.ConnectPair("A", sigA),
                    lr.ConnectPair("B", sigB),
                    lr.ConnectPair("Y", sigY),
                ],
                [
                    lr.ConnectPair("A_WIDTH", aWidthParam),
                    lr.ConnectPair("A_SIGNED", aSignedParam),
                    lr.ConnectPair("B_WIDTH", bWidthParam),
                    lr.ConnectPair("B_SIGNED", bSignedParam),
                    lr.ConnectPair("Y_WIDTH", yWidthParam),
                ],
            )


def genRegWrapMap(cell, filename, belName, wrapping=True):
    cg = CodeGenerator(filename, WriterType.VERILOG, "a")
    cellType = cell["type"].replace("$", "_")

    if wrapping:
        srcCell, targetCell = f"\\{cell["type"]}", f"\\$_{cellType}_wrapper"
    else:
        srcCell, targetCell = f"\\$_{cellType}_wrapper", f"\\{cell["type"]}"

    with cg.Module(
        f"wrap_{belName}_{cellType}" if wrapping else f"unwrap_{belName}_{cellType}",
        [cg.Attribute("techmap_celltype", srcCell)],
    ) as m:
        with m.ParameterRegion() as pr:
            widthParam = pr.Parameter("WIDTH", 1)
            clkPolarity = pr.Parameter("CLK_POLARITY", 1)
            params: Mapping[str, Value] = {}

            if cell["type"].startswith("$s"):
                params["SRST_POLARITY"] = pr.Parameter("SRST_POLARITY", 1)
                params["SRST_VALUE"] = pr.Parameter("SRST_VALUE", 0)

            if cell["type"].startswith("$a"):
                params["ARST_POLARITY"] = pr.Parameter("ARST_POLARITY", 1)
                params["ARST_VALUE"] = pr.Parameter("ARST_VALUE", 0)

            if cell["type"].endswith("e"):
                params["EN_POLARITY"] = pr.Parameter("EN_POLARITY", 1)

            if cell["type"].endswith("sr") or cell["type"].endswith("sre"):
                params["SET_POLARITY"] = pr.Parameter("SET_POLARITY", 1)
                params["CLR_POLARITY"] = pr.Parameter("CLR_POLARITY", 1)

        with m.PortRegion() as pr:
            portD = pr.Port("D", IO.INPUT, widthParam)
            portCLK = pr.Port("CLK", IO.INPUT, 1)
            portQ = pr.Port("Q", IO.OUTPUT, widthParam)

            ports: Mapping[str, Value] = {}

            if cell["type"].startswith("$s"):
                ports["SRST"] = pr.Port("SRST", IO.INPUT, 1)

            if cell["type"].startswith("$a"):
                ports["ARST"] = pr.Port("ARST", IO.INPUT, 1)

            if cell["type"].endswith("e"):
                ports["EN"] = pr.Port("EN", IO.INPUT, 1)

            if cell["type"].endswith("sr") or cell["type"].endswith("sre"):
                ports["SET"] = pr.Port("SET", IO.INPUT, 1)
                ports["CLR"] = pr.Port("CLR", IO.INPUT, 1)

        with m.LogicRegion() as lr:
            width = int(cell["parameters"]["WIDTH"], 2)
            if wrapping:
                sigD = lr.Signal(
                    f"D_{width}",
                    width,
                )
                sigQ = lr.Signal(f"Q_{width}", width)
            else:
                sigD = lr.Signal("D_ORIG", width)
                sigQ = lr.Signal("Q_ORIG", width)

            lr.Assign(sigD, portD)
            lr.Assign(sigQ, portQ)

            lr.InitModule(
                targetCell,
                "_TECHMAP_REPLACE_",
                [
                    lr.ConnectPair("D", sigD),
                    lr.ConnectPair("Q", sigQ),
                    lr.ConnectPair("CLK", portCLK),
                ]
                + [lr.ConnectPair(k, p) for k, p in ports.items()],
                [
                    lr.ConnectPair("WIDTH", widthParam),
                    lr.ConnectPair("CLK_POLARITY", clkPolarity),
                ]
                + [lr.ConnectPair(k, p) for k, p in params.items()],
            )


def genWrappingMapPair(bel: Bel, filePrefix: Path) -> list[str]:
    metaPath = bel.src.parent / "metadata"
    wrapperInfos = []

    # empty the file
    wrapFilename = filePrefix / f"wrap_map_{bel.name}.v"
    unwrapFilename = filePrefix / f"unwrap_map_{bel.name}.v"
    with open(wrapFilename, "w"):
        pass
    with open(unwrapFilename, "w"):
        pass

    for cellPath in filePrefix.glob(f"cell_{bel.name}*.json"):

        with open(cellPath, "r") as f:
            jsonData = json.load(f)

        modules: dict = jsonData["modules"]
        if len(modules) == 0:
            raise ValueError(f"File {metaPath} is empty.")
        if len(modules) > 1:
            raise ValueError(f"File {metaPath} have multiple modules.")

        moduleKey = next(iter(modules))
        module = modules[moduleKey]

        repeatSet = set()
        for cName, cell in module["cells"].items():
            if cell["type"] in repeatSet:
                continue

            cellType = cell["type"].replace("$", "_")
            if cell["type"] in PossibleBinaryType:
                if int(cell["parameters"]["Y_WIDTH"], 2) == 1:
                    continue
                repeatSet.add(cellType)

                genBinaryWrapMap(cell, wrapFilename, bel.name, True)
                genBinaryWrapMap(cell, unwrapFilename, bel.name, False)
                wrapperInfos.append((f"\\$_{cellType}_wrapper", "Y", "Y_WIDTH"))

            elif cell["type"] in PossibleRegType:
                if int(cell["parameters"]["WIDTH"], 2) == 1:
                    continue
                repeatSet.add(cellType)
                genRegWrapMap(cell, wrapFilename, bel.name, True)
                genRegWrapMap(cell, unwrapFilename, bel.name, False)
                wrapperInfos.append((f"\\$_{cellType}_wrapper", "D", "WIDTH"))

    return wrapperInfos


def genSynthScript(fabric: Fabric, filename: Path):
    environment = Environment(loader=PackageLoader("FABulous"))
    template = environment.get_template("arch_synth.tcl.jinja")
    wrappers = []
    for bel in fabric.getAllUniqueBels():
        if bel.constantBel:
            continue
        path = bel.src.parent / "metadata"
        cellsPath = list(path.glob(f"cell_{bel.name}*.json"))
        wrapperInfos = genWrappingMapPair(bel, path)
        wrappers.append(
            (
                path / f"wrap_map_{bel.name}.v",
                path / f"unwrap_map_{bel.name}.v",
                wrapperInfos,
                cellsPath,
            )
        )

    content = template.render(wrappers=wrappers)
    with open(filename, "w") as f:
        f.write(content)


def genCellsAndMaps(bel: Bel):
    if not bel.src.exists():
        raise ValueError(f"File {bel.src} not found.")

    Path(bel.src.parent / "metadata").mkdir(exist_ok=True)
    filePath = bel.src.parent / "metadata"

    # generate cells
    design = ys.Design()
    runPass = partial(lambda design, cmd: ys.run_pass(cmd, design), design)

    runPass("read_verilog -sv " + str(bel.src))
    runPass("hierarchy -auto-top")
    runPass("proc")
    runPass("opt;;;")
    runPass("setattr -unset src")
    runPass("design -save base")

    runPass("select -none")
    runPass("select A:CELL")
    if len(design.selected_modules()) > 0:
        runPass(f"write_rtlil {filePath / f"cell_{bel.prefix}{bel.name}.il"}")
        return

    runPass("select -none")
    runPass("select a:CONFIG_BIT")
    runPass("select -del a:INIT")
    runPass("select -del a:USER_CLK")

    if len(design.selected_modules()) > 1:
        raise ValueError(f"Multiple modules found for bel: {bel.src}")
    elif len(design.selected_modules()) == 0:
        raise ValueError(
            f"Bel {bel.src} have no CONTROL or CONFIG_BIT but not marked as CELL."
        )

    module = design.top_module()
    ranges = []
    for wire in module.selected_wires():
        p = bel.findPortByName(wire.name.str()[1:])
        if isinstance(p, ConfigPort):
            print(p.features)
            if len(p.features) == 1:
                ranges.append(range(2))
            else:
                ranges.append(range(len(p.features)))
        else:
            ranges.append(list(range(wire.width + 1)) + ["z"])

    keys = [i.name.str().removeprefix("\\") for i in module.selected_wires()]
    combinations = [tuple(zip(keys, values)) for values in product(*ranges)]

    runPass("cd")

    cellDict = {}

    runPass("select t:*")
    if len(module.selected_cells()) == 0:
        raise ValueError(
            f"{bel.name} ({bel.src}) have no logic but do not have the CELL attribute."
        )

    runPass("cd")

    for c in combinations:
        nameStr = f"{bel.name}_" + "_".join(
            [f"{cKey.removeprefix("\\")}_{cValue}" for cKey, cValue in c]
        )
        for cKey, cValue in c:
            if cValue != "z":
                runPass(f"connect -set {cKey} {cValue}")
        runPass("opt;")
        runPass("clean -purge")
        module = design.top_module()
        runPass("select c:*")
        if len(module.selected_cells()) >= 1:
            runPass(f"rename -top {nameStr}")
            runPass(f"write_json {filePath / f"cell_{nameStr}.json"}")
            cellDict[nameStr] = c
        runPass("design -load base")

    module = design.top_module()
    cg = CodeGenerator(Path(f"{filePath}/map_{bel.name}.v"), WriterType.VERILOG)
    for name, c in cellDict.items():
        with cg.Module(f"map_{name}", [cg.Attribute("techmap_celltype", name)]) as m:
            with m.ParameterRegion() as pr:
                runPass("select a:DATA")
                for port in module.selected_wires():
                    pr.Parameter(
                        f"_TECHMAP_CONSTVAL_{port.name.str().removeprefix("\\")}_",
                        Value(f"{port.width}'bx", None, False),
                    )

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
                    wires = [
                        i.name.str().removeprefix("\\") for i in module.selected_wires()
                    ]
                    tDict = {i: i for i in wires}
                    for i, j in c:
                        if i in tDict and j != "z":
                            tDict[i] = j

                    portConnect = []
                    for i, j in tDict.items():
                        portConnect.append(g.ConnectPair(i, j))

                    runPass("select a:CONFIG_BIT")
                    wires = [
                        i.name.str().removeprefix("\\") for i in module.selected_wires()
                    ]
                    tDict = {i: i for i in wires}
                    for i, j in c:
                        if i in tDict:
                            tDict[i] = j

                    paramConnect = []
                    for i, j in tDict.items():
                        paramConnect.append(g.ConnectPair(i, j))
                    g.InitModule(
                        bel.name,
                        "_TECHMAP_REPLACE_",
                        portConnect,
                        paramConnect,
                    )


if __name__ == "__main__":
    from FABulous.fabric_generator.define import WriterType
    from FABulous.FABulous_API import FABulous_API

    f = FABulous_API(
        Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"), WriterType.VERILOG
    )
    # genCellsAndMaps(f.fabric.tileDict["PE"].bels[2])
    # genWrappingMap(f.fabric.tileDict["PE"].bels[0], Path("/home/kelvin/FABulous_fork/myProject/.FABulous/test_wrap_map.v"))
    # f.gen_cellsAndTechmaps(Path("/home/kelvin/FABulous_fork/myProject/.FABulous"))

    genSynthScript(
        f.fabric, Path("/home/kelvin/FABulous_fork/myProject/.FABulous/arch_synth.tcl")
    )
