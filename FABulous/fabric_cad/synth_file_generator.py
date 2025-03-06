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
from FABulous.fabric_generator.HDL_Construct.Value import Value


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


def genCellsAndMaps(bel: Bel):
    if not bel.src.exists():
        raise ValueError(f"File {bel.src} not found.")

    Path(bel.src.parent / "metadata").mkdir(exist_ok=True)
    filePath = bel.src.parent / "metadata"

    # Generate the mapping prims
    cg = CodeGenerator(Path(f"{filePath}/lib_{bel.name}.v"), WriterType.VERILOG)
    with cg.Module(f"{bel.name}", [cg.Attribute("blackbox")]) as m:
        with m.ParameterRegion() as pr:
            for i in bel.configPort:
                pr.Parameter(i.name, 0)

        with m.PortRegion() as pr:
            for i in bel.inputs + bel.externalInputs:
                pr.Port(i.name, IO.INPUT, i.wireCount)
            for i in bel.outputs + bel.externalOutputs:
                pr.Port(i.name, IO.OUTPUT, i.wireCount)
            if bel.userCLK:
                pr.Port(bel.userCLK.name, IO.INPUT, 1)

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
    runPass("select a:CONTROL a:CONFIG_BIT")
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
            if len(p.features) == 1:
                ranges.append(range(1))
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
            # runPass("select -none")
            # runPass("select c:* %x %n")
            # runPass("delete -port")
            # runPass("cd")
            runPass(f"write_rtlil {filePath / f"cell_{nameStr}.il"}")
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
                    # runPass("select -del a:USER_CLK")
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
    genCellsAndMaps(f.fabric.tileDict["PE"].bels[2])

    # f.gen_cellsAndTechmaps(Path("/home/kelvin/FABulous_fork/myProject/.FABulous"))
