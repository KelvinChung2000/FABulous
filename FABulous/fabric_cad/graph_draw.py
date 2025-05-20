import re
import subprocess as sp
from itertools import product
from pathlib import Path

import pydot
from loguru import logger

from FABulous.fabric_cad.chip_database.chip import Chip
from FABulous.fabric_cad.chip_database.define import PinType
from FABulous.fabric_definition.define import Loc
from FABulous.file_parser.file_parser_fasm import parseFASM


def genRoutingResourceGraph(
    chip: Chip, filePath: Path, expand=False, selectTile: list[Loc] = []
):
    """Generate a routing resource graph representation of the FPGA fabric.

    Parameters
    ----------
    chip : Chip
        The chip object containing the fabric definition
    filePath : Path
        Directory path where the output dot file will be written
    expand : bool, optional
        Whether to expand bit indices in wire names, by default False
    pairFilter : list[Loc], optional
        Filter to only include specific tile locations, by default []

    Returns
    -------
    None
        Writes the routing graph to a dot file
    """
    # Configure graph with forced grid layout settings
    graph = pydot.Dot(graph_type="digraph", rankdir="TB")

    if expand:

        def removeBit(i: str) -> str:
            return i

    else:

        def removeBit(i: str) -> str:
            return re.sub(r"\[\d+\]", "", i)

    pairs = list(
        product(range(chip.width), range(chip.height))
    )  # x, y order for easier grid layout
    globalPairs = set()
    if selectTile:
        pairs = selectTile

    logger.info("Adding tile subgraphs")
    sharedAdded = set()
    for x, y in pairs:
        tileType = chip.tile_type_at(x, y)
        subgraph = pydot.Subgraph(
            f"cluster_{x}_{y}",
            label=f"tile_{x}_{y}_{tileType.name}",
            margin="15",
            style="rounded",
            rank="source",
        )

        added = set()
        for bel in tileType.bels:
            belSupGraph = pydot.Subgraph(
                f"cluster_{x}_{y}_{bel.name.value}",
                label=f"{bel.name.value}",
            )
            belSupGraph.add_node(
                pydot.Node(
                    f"X{x}Y{y}.bel_{bel.name.value}",
                    label=f"bel_{bel.name.value}(z=0x{bel.z:04x})",
                    shape="box",
                )
            )
            for pin in bel.pins:
                pinWire = removeBit(tileType.wires[pin.wire].name.value)
                if "SHARE" in tileType.wires[pin.wire].wire_type.value:
                    if f"X{x}Y{y}.{pinWire}" not in sharedAdded:
                        sharedAdded.add(f"X{x}Y{y}.{pinWire}")
                        subgraph.add_node(pydot.Node(f"X{x}Y{y}.{pinWire}"))
                else:
                    belSupGraph.add_node(pydot.Node(f"X{x}Y{y}.{pinWire}"))
                if pin.dir == PinType.INPUT:
                    belPin = removeBit(f"X{x}Y{y}.{bel.name.value}.{pin.name.value}")
                    belSupGraph.add_node(
                        pydot.Node(
                            belPin, label=removeBit(pin.name.value), shape="hexagon"
                        )
                    )
                    if (f"X{x}Y{y}.{pinWire}", belPin) in added:
                        continue
                    added.add((f"X{x}Y{y}.{pinWire}", belPin))
                    belSupGraph.add_edge(
                        pydot.Edge(
                            f"X{x}Y{y}.{pinWire}",
                            belPin,
                        )
                    )
                    if (belPin, f"X{x}Y{y}.bel_{bel.name.value}") in added:
                        continue
                    added.add((belPin, f"X{x}Y{y}.bel_{bel.name.value}"))
                    belSupGraph.add_edge(
                        pydot.Edge(
                            belPin,
                            f"X{x}Y{y}.bel_{bel.name.value}",
                        )
                    )

                elif pin.dir == PinType.OUTPUT:
                    belPin = removeBit(f"X{x}Y{y}.{bel.name.value}.{pin.name.value}")
                    belSupGraph.add_node(
                        pydot.Node(
                            belPin, label=removeBit(pin.name.value), shape="hexagon"
                        )
                    )
                    if (belPin, f"X{x}Y{y}.{pinWire}") in added:
                        continue
                    added.add((belPin, f"X{x}Y{y}.{pinWire}"))
                    belSupGraph.add_edge(
                        pydot.Edge(f"X{x}Y{y}.bel_{bel.name.value}", belPin)
                    )
                    if (f"X{x}Y{y}.{pinWire}", belPin) in added:
                        continue
                    added.add((f"X{x}Y{y}.{pinWire}", belPin))
                    belSupGraph.add_edge(
                        pydot.Edge(
                            belPin,
                            f"X{x}Y{y}.{pinWire}",
                        )
                    )
            subgraph.add_subgraph(belSupGraph)

        addedPairs = set()
        for pip in tileType.pips:
            src, dst = tileType.get_wire_from_pip(pip)
            srcName = removeBit(src.name.value)
            dstName = removeBit(dst.name.value)
            if (srcName, dstName) in addedPairs:
                continue
            subgraph.add_edge(pydot.Edge(f"X{x}Y{y}.{srcName}", f"X{x}Y{y}.{dstName}"))
            addedPairs.add((srcName, dstName))

        graph.add_subgraph(subgraph)

        wires = chip.get_node_wires_from_tile(x, y)
        for shape in wires:
            x_src, y_src, name_src = shape[0]
            srcName = f"X{x_src}Y{y_src}.{removeBit(name_src)}"
            for x_dst, y_dst, name_dst in shape[1:]:
                dstName = f"X{x_dst}Y{y_dst}.{removeBit(name_dst)}"
                if (srcName, dstName) in globalPairs or (
                    dstName,
                    srcName,
                ) in globalPairs:
                    continue
                globalPairs.add((srcName, dstName))
                globalPairs.add((dstName, srcName))

                graph.add_edge(pydot.Edge(srcName, dstName, dir="none", color="blue"))

    # Add neato layout engine hint
    graph.set("layout", "dot")

    # Write the output file
    logger.info(f"Writing routing graph to {filePath}")
    graph.write(str(filePath))
    # # Generate PNG file from dot file
    # try:
    #     logger.info(f"Generating SVG from dot file {outputPath}")
    #     pngOutputPath = outputPath.with_suffix(".svg")
    #     sp.run(
    #         ["osage", "-Tsvg", str(outputPath), "-o", str(pngOutputPath)],
    #         check=True,
    #         capture_output=True,
    #     )
    #     logger.info(f"PNG file generated at {pngOutputPath}")
    # except sp.CalledProcessError as e:
    #     logger.error(f"Failed to generate SVG: {e}")
    #     logger.error(f"Error output: {e.stderr.decode()}")
    # except FileNotFoundError:
    #     logger.error("Could not find 'osage' command. Make sure Graphviz is installed.")


def genRoutedGraph(
    routingGraphPath: Path,
    fasmPath: Path,
    destFilePath: Path = Path(),
    expand: bool = False,
):
    if expand:

        def removeBit(i: str) -> str:
            return i

    else:

        def removeBit(i: str) -> str:
            return re.sub(r"__\d+$", "", i)

    # Read the routing graph from the dot file
    graphList = pydot.graph_from_dot_file(routingGraphPath)
    if not graphList:
        raise FileNotFoundError(f"Could not read routing graph from {routingGraphPath}")
    routingGraph = graphList[0]
    # print(routingGraph.obj_dict["edges"])
    print("FASM start")
    fasm = parseFASM(fasmPath)
    print("FASM end")
    dstSet = set()
    srcSet = set()
    for f in fasm:
        if f.feature is not None and (
            s := re.search(r"(X\d+Y\d+)\.(c\d+\.\w+)\.(c\d+\.\w+)", f.feature)
        ):
            loc, dst, src = s.groups()
            dst = f'"{loc}.{removeBit(dst)}"'
            src = f'"{loc}.{removeBit(src)}"'
            # print(dst, src)
            if f.value == 0:
                continue

            if dst in dstSet and src in srcSet:
                continue

            dstSet.add(dst)
            srcSet.add(src)

            # Check if the edge already exists in the graph and modify its color instead of adding a new one
            if existingEdges := routingGraph.get_edge(src, dst):
                for edge in existingEdges:
                    edge.set("color", "red")

            # Color the source and destination nodes
            srcNode = routingGraph.get_node(src)
            dstNode = routingGraph.get_node(dst)
            if srcNode:
                srcNode[0].set("color", "red")
                srcNode[0].set("style", "filled")
                srcNode[0].set("fillcolor", "lightpink")

            if dstNode:
                dstNode[0].set("color", "red")
                dstNode[0].set("style", "filled")
                dstNode[0].set("fillcolor", "lightpink")

    # Write the modified graph to the destination path
    outputPath = destFilePath if destFilePath != Path() else Path("routed_graph.dot")
    routingGraph.write(str(outputPath))

    try:
        logger.info(f"Generating SVG from dot file {outputPath}")
        pngOutputPath = outputPath.with_suffix(".svg")
        sp.run(
            ["osage", "-Tsvg", str(outputPath), "-o", str(pngOutputPath)],
            check=True,
            capture_output=True,
        )
        logger.info(f"PNG file generated at {pngOutputPath}")
    except sp.CalledProcessError as e:
        logger.error(f"Failed to generate SVG: {e}")
        logger.error(f"Error output: {e.stderr.decode()}")
    except FileNotFoundError:
        logger.error("Could not find 'osage' command. Make sure Graphviz is installed.")


if __name__ == "__main__":
    genRoutedGraph(
        Path("/home/kelvin/FABulous_fork/myProject/.FABulous/routing_graph.dot"),
        Path("/home/kelvin/FABulous_fork/myProject/user_design/router_test.fasm"),
        Path("/home/kelvin/FABulous_fork/myProject/.FABulous/routed_graph.dot"),
    )
