from collections import defaultdict
import json
from functools import partial
from itertools import product
from pathlib import Path
from typing import Mapping

from hdlgen.code_gen import CodeGenerator
from hdlgen.define import WriterType as codeGenWriterType
from hdlgen.HDL_Construct.Value import Value
from jinja2 import Environment, PackageLoader
from pyosys import libyosys as ys

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO, BelType
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import ConfigPort


def genPrims(bel: Bel, filePath: Path):
    cg = CodeGenerator(filePath, codeGenWriterType.VERILOG)
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


def genWrapMap(cell, filename, belName, wrapping=True):
    cg = CodeGenerator(filename, codeGenWriterType.VERILOG, "a")
    cellType = cell["type"].replace("$", "_")

    if wrapping:
        srcCell, targetCell = f"\\{cell['type']}", f"\\$_{cellType}_wrapper"
    else:
        srcCell, targetCell = f"\\$_{cellType}_wrapper", f"\\{cell['type']}"

    with cg.Module(
        f"wrap_{belName}_{cellType}" if wrapping else f"unwrap_{belName}_{cellType}",
        [cg.Attribute("techmap_celltype", srcCell)],
    ) as m:

        params: Mapping[str, Value] = {}
        with m.ParameterRegion() as pr:
            for i in cell["parameters"]:
                params[i] = pr.Parameter(i, 0)

        ports: Mapping[str, Value] = {}
        with m.PortRegion() as pr:
            for i, direction in cell["port_directions"].items():
                width = len(cell["connections"][i])
                if wrapping:
                    ports[i] = pr.Port(
                        i,
                        IO[direction.upper()],
                        params.get(f"{i}_WIDTH", params.get("WIDTH", width + 1)) - 1,
                    )
                else:
                    ports[i] = pr.Port(i, IO[direction.upper()], width)

        sigMapping: Mapping[str, Value] = {}
        with m.LogicRegion() as lr:
            for i in cell["port_directions"]:
                width = len(cell["connections"][i])
                if wrapping:
                    sigMapping[i] = lr.Signal(f"{i}_{width}", width)
                else:
                    sigMapping[i] = lr.Signal(
                        f"{i}_orig",
                        params.get(f"{i}_WIDTH", params.get("WIDTH", width + 1)) - 1,
                    )

            for i, direction in cell["port_directions"].items():
                if i not in sigMapping:
                    continue
                if IO[direction.upper()] == IO.INPUT:
                    lr.Assign(sigMapping[i], ports[i])
                else:
                    lr.Assign(ports[i], sigMapping[i])

            lr.InitModule(
                targetCell,
                "_TECHMAP_REPLACE_",
                [
                    lr.ConnectPair(i, sigMapping.get(i, ports[i]))
                    for i in cell["port_directions"]
                ],
                [lr.ConnectPair(i, params[i]) for i in cell["parameters"]],
            )


def genWrappingMapPair(bel: Bel, filePrefix: Path) -> list[str]:
    metaPath = bel.src.parent / "metadata"
    wrapperInfos = []
    repeatSet = set()

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

        for cName, cell in module["cells"].items():
            cellType = cell["type"].replace("$", "_")
            if cellType in repeatSet:
                continue

            outPort = []
            for i, v in cell["port_directions"].items():
                if v == "output":
                    outPort.append(i)

            outWidthPair = []
            for i in outPort:
                if f"{i}_WIDTH" in cell["parameters"]:
                    outWidthPair.append((i, f"{i}_WIDTH"))
                else:
                    outWidthPair.append((i, "WIDTH"))

            repeatSet.add(cellType)

            genWrapMap(cell, wrapFilename, bel.name, True)
            genWrapMap(cell, unwrapFilename, bel.name, False)
            wrapperInfos.append((f"\\$_{cellType}_wrapper", outWidthPair))

    return wrapperInfos


def genMemMap(paths: list[Path], dest: Path):
    with open(dest, "w") as f:
        pass

    for c in paths:
        with open(c) as f:
            jsonData = json.load(f)

        module: dict = jsonData["modules"][next(iter(jsonData["modules"].keys()))]
        for i in module["cells"].values():
            if i["type"] != "$mem_v2":
                continue

            parameters: dict[str, str] = i["parameters"]
            connections: dict[str, list[str]] = i["connections"]

            addressBits: int = int(parameters["ABITS"], 2)
            dataWidth: int = int(parameters["WIDTH"], 2)
            initValueRaw: str = parameters["INIT"]
            readPorts: int = int(parameters["RD_PORTS"], 2)
            writePorts: int = int(parameters["WR_PORTS"], 2)

            if initValueRaw == "x" * (2**addressBits):
                initValue = "none"
            elif initValueRaw == "0" * (2**addressBits):
                initValue = "zero"
            else:
                initValue = "any"

            def groupList(d, n):
                return [d[i : i + n] for i in range(0, len(d), n)]

            def getClockEdge(polarityBit: str) -> str:
                return "posedge" if polarityBit == "1" else "negedge"

            def getMemValueString(
                value: str, dataWidth: int, initValue: str | None = None
            ) -> str:
                # Check for 'init' only if initValue is provided and matches
                if initValue is not None and value == initValue:
                    return "init"
                if value == "x" * dataWidth:
                    return "none"
                if value == "0" * dataWidth:
                    return "zero"
                # Otherwise, it's 'any' non-zero/non-x value or doesn't match init
                return "any"

            def buildReadPortConfig(rdIdx: int, dataWidth: int) -> list[str]:
                config = []
                # Safely access parameters using .get() and check index bounds
                rdClkPolarity = parameters.get("RD_CLK_POLARITY", "")
                if rdIdx < len(rdClkPolarity) and connections["RD_CLK"][rdIdx] != "x":
                    config.append(f"clock {getClockEdge(rdClkPolarity[rdIdx])}")

                rdClkEn = parameters.get("RD_CLK_EN", "")
                if rdIdx < len(rdClkEn) and rdClkEn[rdIdx] == "1":
                    config.append("rden")

                initVal = parameters.get("RD_INIT_VALUE")
                if initVal is not None:
                    config.append(
                        f"rdinit {getMemValueString(initVal, dataWidth)}"
                    )  # No initValue comparison needed here

                arstVal = parameters.get("RD_ARST_VALUE")
                if arstVal is not None and initVal is not None:
                    config.append(
                        f"rdarst {getMemValueString(arstVal, dataWidth, initVal)}"
                    )

                srstVal = parameters.get("RD_SRST_VALUE")
                if srstVal is not None and initVal is not None:
                    config.append(
                        f"rdsrst {getMemValueString(srstVal, dataWidth, initVal)}"
                    )

                return config

            def buildWritePortConfig(wrIdx: int) -> list[str]:
                config = []
                # Safely access parameters using .get() and check index bounds
                wrClkPolarity = parameters.get("WR_CLK_POLARITY", "")
                if wrIdx < len(wrClkPolarity):
                    config.append(f"clock {getClockEdge(wrClkPolarity[wrIdx])}")

                wrClkEn = parameters.get("WR_CLK_EN", "")
                if wrIdx < len(wrClkEn) and wrClkEn[wrIdx] == "1":
                    config.append("clken")  # Yosys uses 'clken' for write enable

                return config

            readAddrSignals = connections.get("RD_ADDR", [])
            writeAddrSignals = connections.get("WR_ADDR", [])
            readPortList = (
                groupList(readAddrSignals, addressBits)
                if readPorts > 0 and addressBits > 0
                else []
            )
            writePortList = (
                groupList(writeAddrSignals, addressBits)
                if writePorts > 0 and addressBits > 0
                else []
            )

            rdPortSet = set(tuple(item) for item in readPortList if item)
            wrPortSet = set(tuple(item) for item in writePortList if item)

            # Identify port types based on address signal usage
            commonPorts = rdPortSet.intersection(wrPortSet)
            readOnlyPorts = rdPortSet.difference(wrPortSet)
            writeOnlyPorts = wrPortSet.difference(rdPortSet)

            ports: dict[str, list[str]] = defaultdict(list)

            # Process common ports (Read-Write)
            for i, portTuple in enumerate(commonPorts):
                portAddr = list(portTuple)
                rdIdx = readPortList.index(portAddr)
                wrIdx = writePortList.index(portAddr)

                # Determine read type prefix (asynchronous 'ar' or synchronous 'sr')
                # Check if RD_CLK exists and is all 'x' (indicating asynchronous)
                isAsyncRead = (
                    connections.get("RD_CLK", [""])[0] == "x"
                )  # Simplified check
                portPrefix = "ar" if isAsyncRead else "sr"
                portName = f'{portPrefix}sw "RW{i}"'  # Combined Read/Write port

                # Build config: Start with write part, then add read part
                portConfig = buildWritePortConfig(wrIdx)
                portConfig.extend(buildReadPortConfig(rdIdx, dataWidth))

                # Remove potential duplicate 'clock' entries if polarities match
                portConfig = list(dict.fromkeys(portConfig))

                ports[portName].extend(portConfig)

            # Process read-only ports
            for i, portTuple in enumerate(readOnlyPorts):
                portAddr = list(portTuple)
                rdIdx = readPortList.index(portAddr)

                isAsyncRead = connections.get("RD_CLK", [""])[0] == "x"
                portPrefix = "ar" if isAsyncRead else "sr"
                portName = f'{portPrefix} "R{i}"'  # Read-Only port

                ports[portName].extend(buildReadPortConfig(rdIdx, dataWidth))

            # Process write-only ports
            for i, portTuple in enumerate(writeOnlyPorts):
                portAddr = list(portTuple)
                wrIdx = writePortList.index(portAddr)

                portName = f'sw "W{i}"'
                ports[portName].extend(buildWritePortConfig(wrIdx))

            environment = Environment(
                loader=PackageLoader("FABulous")
            )  # Assuming FABulous is the package
            template = environment.get_template(
                "memory_mapping.txt.jinja"
            )  # Create a template file

            # Render the template with the extracted data
            memoryDefinition = template.render(
                moduleName=f"{c.stem}",
                addressBits=addressBits,
                dataWidth=dataWidth,
                initValue=initValue,
                ports=ports,
                connections=connections,
            )

            with open(dest, "a") as f:
                f.write(memoryDefinition)


def genSynthScript(fabric: Fabric, filename: Path):
    environment = Environment(loader=PackageLoader("FABulous"))
    template = environment.get_template("arch_synth.tcl.jinja")
    wrappers = []
    for bel in fabric.getAllUniqueBels():
        if bel.constantBel:
            continue
        path = bel.src.parent / "metadata"
        if bel.belType == BelType.MEM:
            genMemMap(
                list(path.glob(f"cell_{bel.name}*.json")),
                fabric.fabricDir.parent / ".FABulous/memory_map.txt",
            )
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

    Path(bel.src.parent / "metadata").mkdir(exist_ok=True)
    filePath = bel.src.parent / "metadata"

    # generate cells
    design = ys.Design()
    runPass = partial(lambda design, cmd: ys.run_pass(cmd, design), design)

    runPass("read_verilog -sv " + str(bel.src))
    runPass("hierarchy -auto-top")
    runPass("flatten")
    runPass("proc")
    runPass("memory -nomap")
    runPass("opt")
    # runPass("clean -purge")
    runPass("setattr -unset src")
    runPass("design -save base")

    runPass("select -none")
    runPass("select A:CELL")
    if len(design.selected_modules()) > 0:
        runPass("proc; opt -full;;;")
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
            [f"{cKey.removeprefix('\\')}_{cValue}" for cKey, cValue in c]
        )
        for cKey, cValue in c:
            if cValue != "z":
                runPass(f"connect -set {cKey} {cValue}")
        runPass("opt -full;")
        runPass("clean -purge")
        module = design.top_module()
        runPass("select c:*")
        if len(module.selected_cells()) >= 1:
            runPass(f"rename -top {nameStr}")
            runPass("proc; memory; opt -full;;;")
            runPass(f"write_json {filePath / f'cell_{nameStr}.json'}")
            cellDict[nameStr] = c
        runPass("design -load base")

    module = design.top_module()
    cg = CodeGenerator(Path(f"{filePath}/map_{bel.name}.v"), codeGenWriterType.VERILOG)
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

    # f = FABulous_API(
    #     Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"), WriterType.VERILOG
    # )
    # genCellsAndMaps(f.fabric.tileDict["PE"].bels[2])
    # genWrappingMap(f.fabric.tileDict["PE"].bels[0], Path("/home/kelvin/FABulous_fork/myProject/.FABulous/test_wrap_map.v"))
    # f.gen_cellsAndTechmaps(Path("/home/kelvin/FABulous_fork/myProject/.FABulous"))

    # genSynthScript(
    #     f.fabric, Path("/home/kelvin/FABulous_fork/myProject/.FABulous/arch_synth.tcl")
    # )
    s = genMemMap(
        [Path("/home/kelvin/FABulous_fork/myProject/Tile/E_Mem/metadata/cell_Mem.json")]
    )
    print(s)
