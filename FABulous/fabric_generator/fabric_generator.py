from collections import defaultdict
from pathlib import Path
from typing import Mapping

from FABulous.fabric_definition.define import IO, ConfigBitMode, Loc, Side
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.fabric_generator.HDL_Construct.Value import Value
from FABulous.file_parser.file_parser_yaml import parseFabricYAML


def generateFabric(codeGen: CodeGenerator, fabric: Fabric):
    with codeGen.Module(fabric.name) as m:
        with m.ParameterRegion() as pr:
            maxFramePerCol = pr.Parameter("MaxFramePerCol", fabric.maxFramesPerCol)
            frameBitsPerRow = pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)

        externalSignalMapping: Mapping[Loc, Mapping[BelPort, Value]] = {}
        with m.PortRegion() as pr:
            for (x, y), tile in fabric:
                if tile is None:
                    continue

                mapping = {}
                for bel in tile.bels:
                    for externalInput in bel.externalInputs:
                        mapping[externalInput] = pr.Port(
                            f"Tile_X{x}Y{y}_{bel.prefix}{externalInput.name}",
                            externalInput.ioDirection,
                            externalInput.width,
                        )
                    for externalOutput in bel.externalOutputs:
                        mapping[externalOutput] = pr.Port(
                            f"Tile_X{x}Y{y}_{bel.prefix}{externalOutput.name}",
                            externalOutput.ioDirection,
                            externalOutput.width,
                        )
                    externalSignalMapping[(x, y)] = mapping

            if fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                frameData = pr.Port(
                    "FrameData", IO.INPUT, frameBitsPerRow * fabric.numberOfRows - 1
                )
                frameStrobe = pr.Port(
                    "FrameStrobe", IO.INPUT, maxFramePerCol * fabric.numberOfColumns - 1
                )

            userClk = pr.Port("UserCLK", IO.INPUT)

        with m.LogicRegion() as lr:
            clkWireInMapping: Mapping[Loc, Value] = {}
            clkWireOutMapping: Mapping[Loc, Value] = {}
            lr.Comment("User Clock wire")
            for (x, y), tile in fabric:
                if y == fabric.numberOfColumns - 1:
                    clkWireInMapping[(x, y)] = userClk
                else:
                    clkWireInMapping[(x, y)] = lr.Signal(f"Tile_X{x}Y{y + 1}_UserCLK")
                clkWireOutMapping[(x, y)] = lr.Signal(f"Tile_X{x}Y{y}_UserCLK_o")

            frameDataInMapping: Mapping[Loc, Value] = {}
            frameDataOutMapping: Mapping[Loc, Value] = {}
            lr.NewLine()
            lr.Comment("Frame Data wire")
            for (x, y), tile in fabric:
                frameDataOutMapping[(x, y)] = lr.Signal(
                    f"Tile_X{x}Y{y}_FrameData", frameBitsPerRow - 1
                )
            for (x, y), tile in fabric:
                if x == 0:
                    frameDataInMapping[(x, y)] = lr.Signal(
                        f"Row{y}_FrameData", frameBitsPerRow - 1
                    )
                else:
                    frameDataInMapping[(x, y)] = frameDataOutMapping[(x - 1, y)]

            frameStrobeInMapping: Mapping[Loc, Value] = {}
            frameStrobeOutMapping: Mapping[Loc, Value] = {}
            lr.NewLine()
            lr.Comment("Frame Strobe wire")
            for (x, y), tile in fabric:
                frameStrobeOutMapping[(x, y)] = lr.Signal(
                    f"Tile_X{x}Y{y}_FrameStrobe", maxFramePerCol - 1
                )
            for (x, y), tile in fabric:
                if y == fabric.numberOfColumns - 1:
                    frameStrobeInMapping[(x, y)] = lr.Signal(
                        f"Col{x}_FrameStrobe", maxFramePerCol - 1
                    )
                else:
                    frameStrobeInMapping[(x, y)] = frameStrobeOutMapping[(x, y + 1)]

            tileToTileInMapping: Mapping[Loc, Mapping[Side, list[Value]]] = defaultdict(
                dict
            )
            tileToTileOutMapping: Mapping[Loc, Mapping[Side, list[Value]]] = (
                defaultdict(dict)
            )
            lr.NewLine()
            lr.Comment("Tile to Tile wire")
            for (x, y), tile in fabric:
                if tile is None:
                    continue

                outputOnSide: Mapping[Side, list[Value]] = defaultdict(list)
                for port in tile.getTileOutputPorts():
                    outputOnSide[port.sideOfTile].append(
                        lr.Signal(f"Tile_X{x}Y{y}_{port.name}", port.width)
                    )
                tileToTileOutMapping[(x, y)] = outputOnSide

            for (x, y), tile in fabric:
                if tile is None:
                    continue

                inputOnSide: Mapping[Side, list[Value]] = defaultdict(list)
                for port in tile.getTileInputPorts():
                    match port.sideOfTile:
                        case Side.NORTH:
                            if y - 1 < 0:
                                continue
                            if fabric[(x, y - 1)] is None:
                                continue
                            inputOnSide[Side.NORTH].extend(
                                tileToTileOutMapping[(x, y - 1)][Side.SOUTH]
                            )
                        case Side.EAST:
                            if x + 1 >= fabric.numberOfColumns:
                                continue
                            if fabric[(x + 1, y)] is None:
                                continue
                            inputOnSide[Side.EAST].extend(
                                tileToTileOutMapping[(x + 1, y)][Side.WEST]
                            )

                        case Side.SOUTH:
                            if y + 1 >= fabric.numberOfRows:
                                continue
                            if fabric[(x, y + 1)] is None:
                                continue
                            inputOnSide[Side.SOUTH].extend(
                                tileToTileOutMapping[(x, y + 1)][Side.NORTH]
                            )
                        case Side.WEST:
                            if x - 1 < 0:
                                continue
                            if fabric[(x - 1, y)] is None:
                                continue
                            inputOnSide[Side.WEST].extend(
                                tileToTileOutMapping[(x - 1, y)][Side.EAST]
                            )
                tileToTileInMapping[(x, y)] = inputOnSide

            lr.NewLine()
            lr.Comment("Frame Data connection")
            for (x, y), tile in fabric:
                if x == 0:
                    lr.Assign(
                        frameDataInMapping[(x, y)],
                        frameData[
                            (frameBitsPerRow * (y + 1)) - 1 : frameBitsPerRow * y
                        ],
                    )

            lr.NewLine()
            lr.Comment("Frame Strobe connection")
            for (x, y), tile in fabric:
                if y == fabric.numberOfColumns - 1:
                    lr.Assign(
                        frameStrobeInMapping[(x, y)],
                        frameStrobe[
                            (maxFramePerCol * (x + 1)) - 1 : maxFramePerCol * x
                        ],
                    )

            lr.Comment("Create Tiles")
            for (x, y), tile in fabric:
                if tile is None:
                    lr.InitModule(
                        "EmptyTile",
                        f"EmptyTile_Tile_X{x}Y{y}",
                        [
                            lr.ConnectPair("UserCLK", clkWireInMapping[(x, y)]),
                            lr.ConnectPair("UserCLK_o", clkWireOutMapping[(x, y)]),
                            lr.ConnectPair("FrameData", frameDataInMapping[(x, y)]),
                            lr.ConnectPair("FrameData_o", frameDataOutMapping[(x, y)]),
                            lr.ConnectPair("FrameStrobe", frameStrobeInMapping[(x, y)]),
                            lr.ConnectPair(
                                "FrameStrobe_o", frameStrobeOutMapping[(x, y)]
                            ),
                        ],
                        [
                            lr.ConnectPair("MaxFramePerCol", maxFramePerCol),
                            lr.ConnectPair("FrameBitsPerRow", frameBitsPerRow),
                        ],
                    )
                else:
                    connection = []
                    for side, ports in tile.getTilePortGrouped(IO.OUTPUT).items():
                        connection.extend(
                            [
                                lr.ConnectPair(f"{port.name}", signal)
                                for port, signal in zip(
                                    ports,
                                    tileToTileOutMapping[(x, y)][side],
                                )
                            ]
                        )
                    for side, ports in tile.getTilePortGrouped(IO.INPUT).items():
                        # print(tile.name)
                        # print(tileToTileInMapping[(x, y)][side])
                        # print(ports)
                        connection.extend(
                            [
                                lr.ConnectPair(f"{port.name}", signal)
                                for port, signal in zip(
                                    ports,
                                    tileToTileInMapping[(x, y)][side],
                                )
                            ]
                        )
                    for bel in tile.bels:
                        for port in bel.externalInputs + bel.externalOutputs:
                            connection.append(
                                lr.ConnectPair(
                                    f"{port.prefix}{port.name}",
                                    externalSignalMapping[(x, y)][port],
                                )
                            )

                    lr.InitModule(
                        tile.name,
                        f"{tile.name}_Tile_X{x}Y{y}",
                        connection
                        + [
                            lr.ConnectPair("UserCLK", clkWireInMapping[(x, y)]),
                            lr.ConnectPair("UserCLK_o", clkWireOutMapping[(x, y)]),
                            lr.ConnectPair("FrameData", frameDataInMapping[(x, y)]),
                            lr.ConnectPair("FrameData_o", frameDataOutMapping[(x, y)]),
                            lr.ConnectPair("FrameStrobe", frameStrobeInMapping[(x, y)]),
                            lr.ConnectPair(
                                "FrameStrobe_o", frameStrobeOutMapping[(x, y)]
                            ),
                        ],
                        [
                            lr.ConnectPair("MaxFramePerCol", maxFramePerCol),
                            lr.ConnectPair("FrameBitsPerRow", frameBitsPerRow),
                            lr.ConnectPair("NoConfigBits", tile.configBits),
                        ],
                    )


if __name__ == "__main__":
    fabric = parseFabricYAML(Path("/home/kelvin/FABulous_fork/myProject/fabric.yaml"))
    generateFabric(fabric, Path("./test_fabric.v"))
