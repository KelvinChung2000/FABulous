from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.code_generator_2 import CodeGenerator


def generateFabricTopWrapper(codeGen: CodeGenerator, fabric: Fabric):
    with codeGen.Module(f"{fabric.name}_wrapper") as module:
        with module.ParameterRegion() as pr:
            pr.Parameter("include_eFPGA", 1)
            pr.Parameter("NumberOfCols", fabric.numberOfColumns)
            pr.Parameter("NumberOfRows", fabric.numberOfRows)
            pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)
            pr.Parameter("MaxFramePerCol", fabric.maxFramesPerCol)
            pr.Parameter("FrameSelectWidth", fabric.frameSelectWidth)
            pr.Parameter("RowSelectWidth", fabric.rowSelectWidth)
            pr.Parameter("desync_flag", fabric.desync_flag)

        with module.PortRegion() as pr:
            pass

        with module.LogicRegion() as lr:
            pass
