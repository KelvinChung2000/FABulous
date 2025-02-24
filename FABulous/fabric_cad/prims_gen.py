from itertools import product
import json
import os
from pathlib import Path
import stat
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


def genPrimsFromBel(filename: Path):
    if not filename.exists():
        raise ValueError(f"File {filename} not found.")

    Path(filename.parent / "metadata").mkdir(exist_ok=True)
    json_file = filename.parent / Path("metadata") / filename.with_suffix(".json").name
    port_file = filename.parent / Path("metadata") / f"stat_{filename.with_suffix(".txt").name}"

    yosys = check_if_application_exists(os.getenv("FAB_YOSYS_PATH", "yosys"))

    yosysCmd = [
        f"read_verilog -sv {filename}",
        "hierarchy -auto-top",
        "proc",
        "opt;;",
        f"write_json -compat-int {json_file}",
        f"tee -q -o {port_file} select -list a:CONTROL a:CONFIG_BIT ",
    ]

    runCmd = [
        f"{yosys}",
        "-qp",
        "; ".join(yosysCmd),
    ]

    try:
        subprocess.run(runCmd, check=True, text=True, capture_output=True)
    except subprocess.CalledProcessError as e:
        raise ValueError(f"Yosys command execution failed. {e.stderr}")

    with open(f"{json_file}", "r") as f:
        design_dict = json.load(f)

    with open(f"{port_file}", "r") as f:
        portList= [i.split("/")[-1].strip() for i in f.readlines()]

    modules = design_dict.get("modules", {})
    if len(modules) > 1:
        raise ValueError("Multiple modules found.")
    elif len(modules) == 0:
        raise ValueError("No modules found.")

    module: dict = modules[list(modules.keys())[0]]
    inputPortsSize: dict[str, int] = {}
    for p in portList:
        if pDict := module["ports"].get(p, None):
            if pDict["direction"] != "input":
                raise ValueError(f"Port {p} is not an input port.")
            inputPortsSize[p] = len(pDict["bits"])

    keys = list(inputPortsSize.keys())
    ranges = [range(value + 1) for value in inputPortsSize.values()]
    combinations = [tuple(zip(keys, values)) for values in product(*ranges)]

    for i, c in enumerate(combinations):
        primsFile = filename.parent / Path("metadata") / f"{i}_prims_{filename.with_suffix(".v").name}"
        yosysCmd = [
            f"read_verilog -sv {filename}",
            "proc",
            "opt;;",
            "; ".join([f"connect -set {cKey} {cValue}" for cKey, cValue in c]),
            "opt;;;",
            f"write_verilog -sv {primsFile}",
        ]
        print(yosysCmd)
        runCmd = [
            f"{yosys}",
            "-qp",
            "; ".join(yosysCmd),
        ]

        try:
            subprocess.run(runCmd, check=True, text=True, capture_output=True)
        except subprocess.CalledProcessError as e:
            raise ValueError(f"Yosys command execution failed. {e.stderr}")


if __name__ == "__main__":
    genPrimsFromBel(Path("/Users/kelvin/FABulous/myProject/Tile/PE/ALU.v"))
