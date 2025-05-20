from collections import defaultdict
from functools import partial
from pathlib import Path
import re

import schemdraw.elements as elm
from schemdraw import Drawing

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO, YosysJson
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.FABulous_API import FABulous_API

tHeight = 30
tWidth = 30
xPadding = 5
yPadding = 5


def drawBel(
    d: Drawing, bel: Bel, belCount: int, c: int, colour: str = "black"
) -> elm.Element:
    bElement = elm.Ic((6, 3)).color(colour).label(f"{bel.prefix}{bel.name}", loc="top")
    for port in reversed(bel.inputs):
        n = port.name.removeprefix(bel.prefix)
        bElement.pin(name=n, side="left", anchorname=n)

    for port in reversed(bel.outputs):
        n = port.name.removeprefix(bel.prefix)
        bElement.pin(name=n, side="right", anchorname=n)

    for port in reversed(bel.sharedPort):
        n = port.name.removeprefix(bel.prefix)
        bElement.pin(name=n, side="bottom", anchorname=n)
    d.add(bElement)
    return bElement


def drawTile(
    d: Drawing, tile: Tile | None, x: int, y: int, c: int, placeColouring: list[str]
) -> tuple[elm.Element, dict[str, elm.Element]] | None:
    if tile is None:
        return None

    tElement = elm.Ic(size=(tWidth, tHeight)).label(
        f"{tile.name} ({x}, {y})", loc="top"
    )
    for p in tile.getNorthPorts(IO.INPUT) + tile.getNorthPorts(IO.OUTPUT):
        tElement.pin(name=p.name, side="top", anchorname=p.name)

    for p in tile.getEastPorts(IO.INPUT) + tile.getEastPorts(IO.OUTPUT):
        tElement.pin(name=p.name, side="right", anchorname=p.name)

    for p in tile.getSouthPorts(IO.INPUT) + tile.getSouthPorts(IO.OUTPUT):
        tElement.pin(name=p.name, side="bottom", anchorname=p.name)

    for p in tile.getWestPorts(IO.INPUT) + tile.getWestPorts(IO.OUTPUT):
        tElement.pin(name=p.name, side="left", anchorname=p.name)

    d.add(tElement)
    d.move_from(tElement.xy, tHeight / 10, tWidth / 10)
    bElements = {}
    for bel in tile.bels:
        if f"{bel.prefix}{bel.name}" in placeColouring:
            bElement = drawBel(d, bel, len(list(tile.getUniqueBelType())), c, "red")
            bElements[f"{bel.prefix}{bel.name}"] = bElement
            d.move(0, 5)

    return tElement, bElements


def drawFabric(d: Drawing, fabric: Fabric, yosysJson: YosysJson):
    module = yosysJson.getTopModule()

    colouringDict = defaultdict(list)
    cellBelMap = {}
    for cName, details in module.cells.items():
        if r := re.search(
            r"X(\d+)Y(\d+)/c(\d+)\.(\w+)", str(details.attributes["NEXTPNR_BEL"])
        ):
            colouringDict[(int(r.group(1)), int(r.group(2)))].append(r.group(4))
            cellBelMap[cName] = str(details.attributes["NEXTPNR_BEL"])

    tElements: dict[tuple[int, int], tuple[elm.Element, dict[str, elm.Element]]] = {}
    for (x, y), tile in fabric:
        d.push()
        if r := drawTile(d, tile, x, y, fabric.contextCount, colouringDict[(x, y)]):
            tElements[(x, y)] = r
        d.pop()
        if x == fabric.width - 1:
            d.move(-((tWidth + xPadding) * (fabric.width - 1)), tHeight + yPadding)
        else:
            d.move(tWidth + xPadding, 0)

    connectDict: dict[tuple[str, str], set[tuple[str, str]]] = defaultdict(set)
    for neName, netDetails in module.netnames.items():
        for b in netDetails.bits:
            if isinstance(b, int):
                if not yosysJson.isTopModuleNet(b) and yosysJson.isNetUsed(b):
                    src, sink = yosysJson.getNetPortSrcSinks(b)
                    if src[1] == "z":
                        continue
                    for i, j in sink:
                        connectDict[cellBelMap[src[0]], src[1]].add((cellBelMap[i], j))

    for src, sink in connectDict.items():
        srcBel, srcPort = src
        srcBelElm: elm.Element
        srcX, srcY = 0, 0
        if r := re.search(r"X(\d+)Y(\d+)/c(\d+)\.(\w+)", str(srcBel)):
            srcX, srcY = int(r.group(1)), int(r.group(2))
            srcBelElm = tElements[(srcX, srcY)][1][r.group(4)]

        for sinkBel, sinkPort in sink:
            if r := re.search(r"X(\d+)Y(\d+)/c(\d+)\.(\w+)", str(sinkBel)):
                x, y = int(r.group(1)), int(r.group(2))
                sinkBelElm = tElements[(x, y)][1][r.group(4)]
                if srcX == x and srcY == y:
                    d.add(
                        elm.Wire("-")
                        .at((srcBelElm, srcPort))
                        .to((sinkBelElm.absanchors[sinkPort]))
                        .color("red")
                    )
                elif abs(srcX - x) == 1 and abs(srcY - y) == 1:
                    d.add(
                        elm.Wire("-", arrow="->")
                        .at((srcBelElm, srcPort))
                        .to((sinkBelElm.absanchors[sinkPort]))
                        .color("orange")
                    )
                elif abs(srcX - x) == 1 and abs(srcY - y) <= 1:
                    d.add(
                        elm.Wire("-", arrow="->")
                        .at((srcBelElm, srcPort))
                        .to((sinkBelElm.absanchors[sinkPort]))
                        .color("green")
                    )
                elif abs(srcX - x) <= 1 and abs(srcY - y) == 1:
                    d.add(
                        elm.Wire("-", arrow="->")
                        .at((srcBelElm, srcPort))
                        .to((sinkBelElm.absanchors[sinkPort]))
                        .color("green")
                    )
                elif abs(srcX - x) >= 1 and abs(srcY - y) == 0:
                    d.add(
                        elm.Wire("-", k=5, arrow="->")
                        .at((srcBelElm, srcPort))
                        .to((sinkBelElm.absanchors[sinkPort]))
                        .color("blue")
                    )
                elif abs(srcX - x) == 0 and abs(srcY - y) >= 1:
                    d.add(
                        elm.Wire("-", k=5, arrow="->")
                        .at((srcBelElm, srcPort))
                        .to((sinkBelElm.absanchors[sinkPort]))
                        .color("blue")
                    )
                else:
                    d.add(
                        elm.Wire("-", arrow="->")
                        .at((srcBelElm, srcPort))
                        .to((sinkBelElm.absanchors[sinkPort]))
                        .color("purple")
                    )


def draw(fabric: Fabric, path: Path, yosysJson: Path):
    d = Drawing()
    # design = ys.Design()
    # runPass = partial(lambda design, cmd: ys.run_pass(cmd, design), design)
    # runPass(f"read_verilog -lib {fabric.fabricDir.parent / ".FABulous/libs.v"}")
    # runPass(f"read_json {yosysJson}")
    # runPass("hierarchy -auto-top")
    ys = YosysJson(yosysJson)
    drawFabric(d, fabric, ys)
    # d.draw()
    d.save(str(path), transparent=False)


if __name__ == "__main__":
    # Example usage
    f = FABulous_API(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))
    draw(
        f.fabric,
        Path("/home/kelvin/FABulous_fork/myProject/drawing.svg"),
        Path("/home/kelvin/FABulous_fork/myProject/user_design/router_test.json"),
    )
