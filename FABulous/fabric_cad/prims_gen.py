from pathlib import Path

from loguru import logger

from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.code_generation_Verilog import VerilogWriter
from FABulous.FABulous_API import FABulous


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

    logger.info(f"Writing primitive to {filename}")


if __name__ == "__main__":
    f = FABulous(VerilogWriter(), str(Path.cwd() / "myProject" / "fabric.yaml"))
    f.setWriterOutputFile("/home/kelvin/FABulous_fork/test.v")
    prims_gen(Path.cwd() / "myProject" / ".FABulous" / "prims.v", f.fabric)
