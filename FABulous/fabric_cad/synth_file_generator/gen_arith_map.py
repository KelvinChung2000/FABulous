from pathlib import Path

from hdlgen.code_gen import CodeGenerator
from hdlgen.define import WriterType as codeGenWriterType
from hdlgen.HDL_Construct.Value import Value

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import (
    IO,
    YosysCellDetails,
    YosysJson,
)


def genWrapMap(cell: YosysCellDetails, filename, belName, wrapping=True):
    cg = CodeGenerator(filename, codeGenWriterType.VERILOG, "a")
    cellType = cell.type.replace("$", "_")

    if wrapping:
        srcCell, targetCell = f"\\{cell.type}", f"\\$_{cellType}_wrapper"
    else:
        srcCell, targetCell = f"\\$_{cellType}_wrapper", f"\\{cell.type}"

    with cg.Module(
        f"wrap_{belName}_{cellType}" if wrapping else f"unwrap_{belName}_{cellType}",
        [cg.Attribute("techmap_celltype", srcCell)],
    ) as m:
        params: dict[str, Value] = {}
        with m.ParameterRegion() as pr:
            for i in cell.parameters:
                params[i] = pr.Parameter(i, 0)

        ports: dict[str, Value] = {}
        with m.PortRegion() as pr:
            for i, direction in cell.port_directions.items():
                width = len(cell.connections[i])
                if wrapping:
                    ports[i] = pr.Port(
                        i,
                        IO[direction.upper()],
                        params.get(f"{i}_WIDTH", params.get("WIDTH", width + 1)) - 1,
                    )
                else:
                    ports[i] = pr.Port(i, IO[direction.upper()], width)

        sigMapping: dict[str, Value] = {}
        with m.LogicRegion() as lr:
            with lr.Generate() as g:
                for i in cell.port_directions:
                    width = len(cell.connections[i])
                    if wrapping:
                        sigMapping[i] = g.Signal(f"{i}_{width}", width)
                    else:
                        sigMapping[i] = g.Signal(
                            f"{i}_orig",
                            params.get(f"{i}_WIDTH", params.get("WIDTH", width + 1))
                            - 1,
                        )

                for i, direction in cell.port_directions.items():
                    if i not in sigMapping:
                        continue
                    if IO[direction.upper()] == IO.INPUT:
                        g.Assign(sigMapping[i], ports[i])
                    else:
                        g.Assign(ports[i], sigMapping[i])

                maxWidth = max([len(cell.connections[i]) for i in cell.port_directions])
                with g.IfElse(params.get("WIDTH", 0) <= maxWidth) as tf:
                    with tf.TrueRegion() as t:
                        t.InitModule(
                            targetCell,
                            "_TECHMAP_REPLACE_",
                            [
                                t.ConnectPair(i, sigMapping.get(i, ports[i]))
                                for i in cell.port_directions
                            ],
                            [t.ConnectPair(i, params[i]) for i in cell.parameters],
                        )
                    with tf.FalseRegion() as f:
                        f.Signal_default("_TECHMAP_FAIL_", 1, 1)


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
        modules = YosysJson(cellPath).modules

        if len(modules) == 0:
            raise ValueError(f"File {metaPath} is empty.")
        if len(modules) > 1:
            raise ValueError(f"File {metaPath} have multiple modules.")

        moduleKey = next(iter(modules))
        module = modules[moduleKey]

        for cName, cell in module.cells.items():
            cellType = cell.type.replace("$", "_")
            if cellType in repeatSet:
                continue

            outPort = []
            for i, v in cell.port_directions.items():
                if v == "output":
                    outPort.append(i)

            outWidthPair = []
            for i in outPort:
                if f"{i}_WIDTH" in cell.parameters:
                    outWidthPair.append((i, f"{i}_WIDTH"))
                else:
                    outWidthPair.append((i, "WIDTH"))

            repeatSet.add(cellType)

            genWrapMap(cell, wrapFilename, bel.name, True)
            genWrapMap(cell, unwrapFilename, bel.name, False)
            wrapperInfos.append((f"\\$_{cellType}_wrapper", outWidthPair))

    return wrapperInfos
