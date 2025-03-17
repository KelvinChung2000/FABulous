import re
from itertools import product
from pathlib import Path

import pydot
from pyparsing import srange

from FABulous.fabric_cad.chip_database.chip import Chip
from FABulous.fabric_cad.chip_database.define import PinType
from FABulous.fabric_definition.define import Loc
from FABulous.file_parser.file_parser_fasm import parseFASM


def genRoutingResourceGraph(
    chip: Chip, filePath: Path, expand=False, pairFilter: list[Loc] = []
):
    graph = pydot.Dot(graph_type="digraph")

    if expand:

        def removeBit(i: str) -> str:
            return i

    else:

        def removeBit(i: str) -> str:
            return re.sub(r"\[\d+\]$", "", i)

    pairs = list(product(range(chip.height), range(chip.width)))
    globalPairs = set()
    if pairFilter:
        pairs = pairFilter

    for x, y in pairs:
        tileType = chip.tile_type_at(x, y)
        subgraph = pydot.Subgraph(
            f"cluster_{x}_{y}", label=f"tile_{x}_{y}_{tileType.name}"
        )
        for bel in tileType.bels:
            # if "INBUF" in bel.name.value:
            #     continue
            # if "OUTBUF" in bel.name.value:
            #     continue
            # if "DRV" in bel.name.value:
            #     continue

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
                    belPin = removeBit(f"X{x}Y{y}.{bel.name.value}{pin.name.value}")
                    belSupGraph.add_node(
                        pydot.Node(
                            belPin, label=removeBit(pin.name.value), shape="hexagon"
                        )
                    )
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
                    belPin = removeBit(f"X{x}Y{y}.{bel.name.value}{pin.name.value}")
                    belSupGraph.add_node(
                        pydot.Node(
                            belPin, label=removeBit(pin.name.value), shape="hexagon"
                        )
                    )
                    belSupGraph.add_edge(
                        pydot.Edge(f"X{x}Y{y}.bel_{bel.name.value}", belPin)
                    )
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

        # subgraph.add_node(pydot.Node(f"tile_{x}_{y}"))
        graph.add_subgraph(subgraph)
        wires = chip.get_node_wires_from_tile(x, y)
        for shape in wires:
            x, y, name = shape[0]
            srcName = f"X{x}Y{y}.{removeBit(name)}"
            for x, y, name in shape[1:]:
                dstName = f"X{x}Y{y}.{removeBit(name)}"
                if (srcName, dstName) in globalPairs or (
                    dstName,
                    srcName,
                ) in globalPairs:
                    continue
                globalPairs.add((srcName, dstName))
                globalPairs.add((dstName, srcName))

                graph.add_edge(pydot.Edge(srcName, dstName, dir="none", color="blue"))

    graph.write(str(filePath / "routing_graph.dot"))


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

    fasm = parseFASM(fasmPath)
    for f in fasm:
        if f.feature is not None and (
            s := re.search(r"(X\d+Y\d+)\.(c\d+\.\w+)\.(c\d+\.\w+)", f.feature)
        ):
            loc, dst, src = s.groups()
            dst = f"{loc}.{removeBit(dst)}"
            src = f"{loc}.{removeBit(src)}"
            if f.value == 0:
                continue
            # Check if the edge already exists in the graph and modify its color instead of adding a new one
            if existingEdges := routingGraph.get_edge(src, dst):
                for edge in existingEdges:
                    edge.set_color("red")
            else:
                routingGraph.add_edge(pydot.Edge(src, dst, color="red"))

            # Color the source and destination nodes
            srcNode = routingGraph.get_node(src)
            dstNode = routingGraph.get_node(dst)

            if srcNode:
                srcNode[0].set_color("red")
                srcNode[0].set_style("filled")
                srcNode[0].set_fillcolor("lightpink")

            if dstNode:
                dstNode[0].set_color("red")
                dstNode[0].set_style("filled")
                dstNode[0].set_fillcolor("lightpink")

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
