import shutil
from pathlib import Path

import ruamel.yaml
from cmd2 import Cmd, Cmd2ArgumentParser, with_argparser
from jinja2 import Environment, PackageLoader
from loguru import logger
from ruamel.yaml import YAML

singleStringParser = Cmd2ArgumentParser()
singleStringParser.add_argument("string")


@with_argparser(singleStringParser)
def do_add_tile(self, args):
    """Adds a new tile to the project.

    Parameters
    ----------
    args : Namespace
        Command line arguments containing the tile information.
    """
    tileName = args.string
    tilePath = Path(self.projectDir) / "Tile" / tileName

    if tilePath.exists():
        logger.error(f"Tile {tileName} already exists!")
        return

    tilePath.mkdir(parents=True)

    environment = Environment(loader=PackageLoader("FABulous"))
    template = environment.get_template("listFile.py.jinja")
    dirPath = str(tilePath.relative_to(self.projectDir.parent)).replace("/", ".")
    content = template.render(
        title=tileName,
        path=dirPath,
    )
    if not (tilePath / "list.py").exists():
        with open(tilePath / "list.py", "w") as f:
            f.write(content)

    Path(tilePath / "metadata").mkdir(exist_ok=True)

    with open(Path(tilePath / f"{tileName}.yaml"), "w") as f:
        f.write(f"TILE: {tileName}\n")
        f.write("INCLUDE:\n")
        f.write(
            "PORTS: [{side: None, name: None, inOut: None, wires: None, terminal: None},]\n"
        )
        f.write(
            "WIRES: [{source_name: None, X-offset: None, Y-offset: None, destination_name: None},]\n"
        )
        f.write("BELS: []\n")
        f.write("MATRIX: list.py\n")
        f.write("CONFIG_MEM: \n")

    logger.info(f"Tile {tileName} directory created successfully.")


addBelParser = Cmd2ArgumentParser()
addBelParser.add_argument("tileName")
addBelParser.add_argument(
    "file", type=Path, help="Path to the target file", completer=Cmd.path_complete
)
addBelParser.add_argument(
    "-belPrefix", nargs="?", default="", help="The bel prefix provided by the CSV file."
)


def seq(*l):
    s = ruamel.yaml.comments.CommentedSeq(l)
    s.fa.set_flow_style()
    return s


@with_argparser(addBelParser)
def do_add_bel_to_tile(self, args):
    if not Path(self.projectDir / "Tile" / args.tileName).exists():
        logger.error(f"Tile {args.tileName} does not exist!")
        return

    if not args.file.exists():
        logger.error(f"File {args.file} not found.")
        return

    yaml = YAML()
    yaml.indent(mapping=2, sequence=2)
    yaml.width = 120
    yamlPath = self.projectDir / "Tile" / args.tileName / f"{args.tileName}.yaml"
    with open(yamlPath, "r") as f:
        data = yaml.load(f)
    newPath = self.projectDir / "Tile" / args.tileName / args.file.name
    shutil.copy(args.file, newPath)

    data["BELS"].append({"BEL": str(newPath), "prefix": args.belPrefix})
    data["BELS"] = seq(*data["BELS"])
    with open(yamlPath, "w") as f:
        yaml.dump(data, f)
