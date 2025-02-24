import json
import os
from pathlib import Path
import subprocess

from FABulous.FABulous_CLI.helper import check_if_application_exists
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.Fabric import Fabric


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


def genPrimsFromBel(filename: Path, bel:  Bel):
    if not filename.exists():
        raise ValueError(f"File {filename} not found.")

    Path(filename.parent / "metadata").mkdir(exist_ok=True)
    json_file = filename.parent / Path("metadata") / filename.with_suffix(".json").name

    yosys = check_if_application_exists(os.getenv("FAB_YOSYS_PATH", "yosys"))
    runCmd = [
        f"{yosys}",
        "-qp",
        f"read_verilog {filename}; proc -noopt; write_json -compat-int {json_file}",
    ]

    try:
        subprocess.run(runCmd, check=True, text=True, capture_output=True)
    except subprocess.CalledProcessError as e:
        raise ValueError(f"Yosys command execution failed. {e.stderr}")

    with open(f"{json_file}", "r") as f:
        data_dict = json.load(f)

    modules = data_dict.get("modules", {})
    if len(modules) > 1:
        raise ValueError("Multiple modules found.")
    elif len(modules) == 0:
        raise ValueError("No modules found.")

    module: dict = modules[list(modules.keys())[0]]
    inputPorts: dict[str, dict] = {}
    for port_name, port_info in module["ports"].items():
        if port_info["direction"] == "input":
            inputPorts[port_name] = port_info

    print(inputPorts)
