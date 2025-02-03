from pathlib import Path

from FABulous.fabric_generator.TileSwitchMatrix_generator import generateTileSwitchMatrix
from FABulous.file_parser.file_parser_yaml import parseFabricYAML

fabric = parseFabricYAML(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))

print(fabric)
# generateConfigMem(fabric, Path("./test.v"))
generateTileSwitchMatrix(fabric, fabric.tileDict["PE"], Path("./test.v"))
# generateTile(fabric, fabric.tileDict["PE"], Path("./test.v"))
