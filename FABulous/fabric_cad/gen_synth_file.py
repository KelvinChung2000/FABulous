import json
from functools import partial
from itertools import product
from pathlib import Path

from hdlgen.code_gen import CodeGenerator
from hdlgen.define import WriterType as codeGenWriterType
from hdlgen.HDL_Construct.Value import Value
from jinja2 import Environment, PackageLoader
from pyosys import libyosys as ys

from FABulous.fabric_cad.synth_file_generator.gen_arith_map import genWrappingMapPair
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import (
    IO,
    BelType,
    FeatureType,
    YosysJson,
    YosysModule,
)
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import ConfigPort
from FABulous.fabric_cad.synth_file_generator.gen_mem_map import genMemMap


def genIOMap(bel: Bel):
    filePath = bel.src.parent / "metadata"
    with open(Path(f"{filePath}/map_{bel.name}.v"), "w"):
        pass

    paths = list(filePath.glob(f"cell_{bel.name}*.json"))

    for c in paths:
        yosysJson = YosysJson(c)
        module: YosysModule = yosysJson.modules[next(iter(yosysJson.modules))]

        cg = CodeGenerator(
            Path(f"{filePath}/map_{bel.name}.v"),
            codeGenWriterType.VERILOG,
            writeMode="a",
        )
        with cg.Module("$__external") as m:
            with m.ParameterRegion() as pr:
                width = pr.Parameter("WIDTH", module.parameter_default_values["WIDTH"])

            with m.PortRegion() as pr:
                pr.InputPort("from_fabric", width)

            # with m.LogicRegion() as lr:
            #     for i in bel.externalInputs:
            #         lr.InitModule(bel.name, "_TECHMAP_REPLACE_", connect)


# def genConstMap():
#     filePath


def genSynthScript(fabric: Fabric, filename: Path):
    environment = Environment(loader=PackageLoader("FABulous"))
    template = environment.get_template("arch_synth.tcl.jinja")
    wrappers = []
    for bel in sorted(
        fabric.getAllUniqueBels(), key=lambda x: x.paramOverride.get("WIDTH", 128)
    ):
        if bel.constantBel:
            continue
        path = bel.src.parent / "metadata" / bel.name
        if bel.belType == BelType.MEM:
            genMemMap(
                bel,
                fabric.fabricDir.parent / ".FABulous/memory_map.txt",
            )
            continue

        if bel.belType == BelType.IO:
            continue

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

    if not bel.jsonPath.exists():
        raise ValueError(f"File {bel.jsonPath} not found.")

    filePath = bel.src.parent / "metadata" / bel.name
    filePath.mkdir(exist_ok=True)

    # generate cells
    design = ys.Design()
    runPass = partial(lambda design, cmd: ys.run_pass(cmd, design), design)

    runPass(f"read_json {bel.jsonPath}")
    runPass("select A:blackbox")
    if len(design.selected_modules()) > 0:
        runPass(f"write_json {filePath / f'{bel.jsonPath}'}")
        return
    runPass("cd")
    runPass(f"hierarchy -top {bel.name}")
    runPass("flatten")
    runPass("proc")
    runPass("opt")
    runPass("check -assert")
    # runPass("clean -purge")
    runPass("setattr -unset src")
    runPass("design -save base")

    runPass("select -none")
    runPass("select A:CELL")
    if len(design.selected_modules()) > 0:
        runPass("proc; memory -nomap; opt -full;;;")
        runPass(f"write_json {filePath / f'cell_{bel.prefix}{bel.name}.json'}")
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
            if p.featureType == FeatureType.INIT:
                continue
            ranges.append([i.value for i in p.features])
        else:
            raise ValueError(
                f"Port {wire.name.str()} in {bel.name} is not a ConfigPort, but a {type(p)}."
            )

    keys = [i.name.str().removeprefix("\\") for i in module.selected_wires()]
    combinations = [tuple(zip(keys, values)) for values in product(*ranges)]
    print(bel)
    print(keys)
    print(ranges)
    print(combinations)
    if bel.name == "Mem":
        raise
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
            [f"{cKey.removeprefix('\\')}_{cValue}" for cKey, cValue in c]
        )
        for cKey, cValue in c:
            if cValue != "z":
                runPass(f"connect -set {cKey} {cValue}")
        runPass("opt -full;")
        # runPass("clean -purge")
        module = design.top_module()
        runPass("select c:*")
        if len(module.selected_cells()) >= 1:
            runPass("cd")
            runPass(f"rename -top {nameStr}")
            runPass("proc; opt -full; memory -nomap;;;")
            runPass(f"write_json {filePath / f'cell_{nameStr}.json'}")
            cellDict[nameStr] = c
        runPass("design -load base")

    if bel.belType == BelType.MEM:
        return
    if bel.belType == BelType.IO:
        return

    genArithTechmap(bel, filePath, design, runPass, cellDict)


def genArithTechmap(bel: Bel, destFilePath: Path, design, runPass, cellDict):
    module = design.top_module()
    cg = CodeGenerator(
        Path(f"{destFilePath}/map_{bel.name}.v"), codeGenWriterType.VERILOG
    )
    for name, c in cellDict.items():
        with cg.Module(f"map_{name}", [cg.Attribute("techmap_celltype", name)]) as m:
            with m.ParameterRegion() as pr:
                runPass("select a:DATA")
                for port in module.selected_wires():
                    pr.Parameter(
                        f"_TECHMAP_CONSTVAL_{port.name.str().removeprefix('\\')}_",
                        Value(f"{port.width}'bx", None, False),
                    )

            with m.PortRegion() as pr:
                runPass("select i:*")
                for port in module.selected_wires():
                    pr.InputPort(port.name.str().removeprefix("\\"), port.width)
                runPass("select o:*")
                for port in module.selected_wires():
                    pr.OutputPort(port.name.str().removeprefix("\\"), port.width)

            with m.LogicRegion() as lr:
                with lr.Generate() as g:
                    runPass("select x:*")
                    runPass("select -del a:CONFIG_BIT")
                    runPass("select -del a:USER_CLK")
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

                    # if bel.userCLK:
                    #     usrClk = g.Signal(bel.userCLK.name, 1)
                    #     g.InitModule(
                    #         "CLK_DRV",
                    #         "CLK",
                    #         [g.ConnectPair("CLK_O", usrClk)],
                    #         [],
                    #     )
                    #     portConnect.append(g.ConnectPair(bel.userCLK.name.removeprefix(bel.prefix), usrClk))

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
