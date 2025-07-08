from pathlib import Path

from hdlgen.code_gen import CodeGenerator
from hdlgen.define import WriterType as codeGenWriterType

from FABulous.fabric_definition.Bel import Bel


def genPrims(bel: Bel, filePath: Path):
    cg = CodeGenerator(filePath, codeGenWriterType.VERILOG)
    with cg.Module(f"{bel.name}", [cg.Attribute("blackbox")]) as m:
        with m.ParameterRegion() as pr:
            for i in bel.configPort:
                pr.Parameter(i.name, 0)

        with m.PortRegion() as pr:
            for i in bel.inputs + bel.externalInputs:
                pr.InputPort(i.name.removeprefix(bel.prefix), i.width)
            for i in bel.outputs + bel.externalOutputs:
                pr.OutputPort(i.name.removeprefix(bel.prefix), i.width)
            for i in bel.sharedPort:
                pr.InputPort(i.name.removeprefix(bel.prefix), i.width)

            # if bel.userCLK:
            #     pr.Port(bel.userCLK.name.removeprefix(bel.prefix), IO.INPUT, 1)
