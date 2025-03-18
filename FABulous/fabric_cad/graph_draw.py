import re
from itertools import product
from pathlib import Path

import pydot
from loguru import logger

from FABulous.fabric_cad.chip_database.chip import Chip
from FABulous.fabric_cad.chip_database.define import PinType
from FABulous.fabric_definition.define import Loc
from FABulous.file_parser.file_parser_fasm import parseFASM


def genRoutingResourceGraph(
    chip: Chip, filePath: Path, expand=False, pairFilter: list[Loc] = []
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
            return re.sub(r"\[\d+\]$", "", i)

    pairs = list(
        product(range(chip.width), range(chip.height))
    )  # x, y order for easier grid layout
    globalPairs = set()
    if pairFilter:
        pairs = pairFilter

    rankX = []
    for i in range(chip.height):
        rankX.append(pydot.Subgraph(f"rankX_{i}", rankdir="LR"))

    logger.info("Adding tile subgraphs")
    for x, y in pairs:
        tileType = chip.tile_type_at(x, y)
        subgraph = pydot.Subgraph(
            f"cluster_{x}_{y}",
            label=f"tile_{x}_{y}_{tileType.name}",
            margin="15",
            style="rounded",
            rank="source",
        )

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
            added = set()
            for pin in bel.pins:
                pinWire = removeBit(tileType.wires[pin.wire].name.value)
                if pinWire in added:
                    continue
                added.add(pinWire)
                if pin.dir == PinType.INPUT:
                    belPin = removeBit(f"X{x}Y{y}.{bel.name.value}.{pin.name.value}")
                    belSupGraph.add_node(
                        pydot.Node(
                            belPin, label=removeBit(pin.name.value), shape="hexagon"
                        )
                    )
                    belSupGraph.add_node(pydot.Node(f"X{x}Y{y}.{pinWire}"))
                    belSupGraph.add_edge(
                        pydot.Edge(
                            f"X{x}Y{y}.{pinWire}",
                            belPin,
                        )
                    )
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
                    belSupGraph.add_edge(
                        pydot.Edge(f"X{x}Y{y}.bel_{bel.name.value}", belPin)
                    )
                    belSupGraph.add_node(pydot.Node(f"X{x}Y{y}.{pinWire}"))
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

        subgraph.add_node(
            pydot.Node(
                f"anchor_X{x}Y{y}",
                style="invis",
            )
        )
        rankX[x].add_subgraph(subgraph)
        # graph.add_subgraph(subgraph)

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

    for i in rankX:
        graph.add_subgraph(i)
    for x in range(chip.width):
        for y in range(chip.height):
            if x + 1 < chip.width:
                graph.add_edge(
                    pydot.Edge(
                        f"anchor_X{x}Y{y}",
                        f"anchor_X{x+1}Y{y}",
                        style="invis",
                        weight="10000",
                    )
                )

    for y in range(chip.height):
        for x in range(chip.width):
            if y + 1 < chip.height:
                graph.add_edge(
                    pydot.Edge(
                        f"anchor_X{x}Y{y}",
                        f"anchor_X{x}Y{y+1}",
                        style="invis",
                        rank="same",
                        weight="10000",
                    )
                )

    # Add neato layout engine hint
    graph.set("layout", "dot")

    # Write the output file
    outputPath = filePath / "routing_graph.dot"
    logger.info(f"Writing routing graph to {outputPath}")
    graph.write(str(outputPath))

    return graph


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

    return routingGraph


if __name__ == "__main__":
    genRoutedGraph(
        Path("/home/kelvin/FABulous_fork/myProject/.FABulous/routing_graph.dot"),
        Path("/home/kelvin/FABulous_fork/myProject/user_design/router_test.fasm"),
        Path("/home/kelvin/FABulous_fork/myProject/.FABulous/routed_graph.dot"),
    )
