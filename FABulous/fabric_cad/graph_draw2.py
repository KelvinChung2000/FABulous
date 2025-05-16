from pathlib import Path
import schemdraw.elements as elm
from schemdraw import Drawing

from FABulous.FABulous_API import FABulous_API
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.define import IO

tHeight = 10
tWidth = 10
xPadding = 5
yPadding = 5


def drawBel(d: Drawing, bel: Bel):
    bElement = elm.Ic(size=(10, 4)).label(f"{bel.prefix}{bel.name}")
    for port in bel.inputs:
        n = port.name.removeprefix(bel.prefix)
        bElement.pin(name=n, side="left", anchorname=n)

    for port in bel.outputs:
        n = port.name.removeprefix(bel.prefix)
        bElement.pin(name=n, side="right", anchorname=n)
    d.add(bElement)


def drawTile(d: Drawing, tile: Tile | None, x: int, y: int):
    if tile is None:
        return

    tElement = elm.Ic(size=(tWidth, tHeight)).label(f"{tile.name} ({x}, {y})")
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
    for bel in tile.bels:
        drawBel(d, bel)
        d.move(0, (tHeight / len(tile.bels)) - 1)


def drawFabric(d: Drawing, fabric: Fabric):
    for (x, y), tile in fabric:
        d.push()
        drawTile(d, tile, x, y)
        d.pop()
        if x == fabric.width - 1:
            d.move(-((tWidth + xPadding) * (fabric.width - 1)), tHeight + yPadding)
        else:
            d.move(tWidth + xPadding, 0)


def draw(fabric: Fabric, path: Path):
    d = Drawing()
    drawFabric(d, fabric)
    # d.draw()
    d.save(str(path), transparent=False)


if __name__ == "__main__":
    # Example usage
    f = FABulous_API(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))
    draw(f.fabric, Path("/home/kelvin/FABulous_fork/myProject/drawing.svg"))
