from collections import defaultdict
from typing import Mapping

from FABulous.fabric_definition.define import IO, ConfigBitMode, Loc, Side
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort
from hdlgen.code_gen import CodeGenerator
from hdlgen.HDL_Construct.Value import Value


def generateFabric(codeGen: CodeGenerator, fabric: Fabric):
    with codeGen.Module(fabric.name) as m:
        with m.ParameterRegion() as pr:
            maxFramePerCol = pr.Parameter("MaxFramesPerCol", fabric.maxFramesPerCol)
            frameBitsPerRow = pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)
            pr.Comment("Emulation parameter")
            emuEn = pr.Parameter("EMULATION_ENABLE", 0)
            emuCfg = pr.Parameter("EMULATION_CONFIG", Value('""', 1, False))

        externalSignalMapping: Mapping[Loc, Mapping[BelPort, Value]] = {}
        with m.PortRegion() as pr:
            for (x, y), tile in fabric:
                if tile is None:
                    continue

                mapping = {}
                for bel in tile.bels:
                    for externalInput in bel.externalInputs:
                        mapping[externalInput] = pr.InputPort(
                            f"Tile_X{x}Y{y}_{bel.prefix}{externalInput.name}",
                            externalInput.width,
                        )
                    for externalOutput in bel.externalOutputs:
                        mapping[externalOutput] = pr.OutputPort(
                            f"Tile_X{x}Y{y}_{bel.prefix}{externalOutput.name}",
                            externalOutput.width,
                        )
                    externalSignalMapping[(x, y)] = mapping

            if fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                frameData = pr.InputPort(
                    "FrameData", frameBitsPerRow * fabric.height - 1
                )
                frameStrobe = pr.InputPort(
                    "FrameStrobe", maxFramePerCol * fabric.width - 1
                )

            userClk = pr.InputPort("UserCLK")

        with m.LogicRegion() as lr:
            clkWireInMapping: Mapping[Loc, Value] = {}
            clkWireOutMapping: Mapping[Loc, Value] = {}
            lr.Comment("User Clock wire")
            for (x, y), tile in fabric:
                if y == fabric.width - 1:
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
                if y == fabric.height - 1:
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
                            if y + 1 >= fabric.height:
                                continue
                            if fabric[(x, y + 1)] is None:
                                continue
                            inputOnSide[Side.NORTH].extend(
                                tileToTileOutMapping[(x, y + 1)][Side.SOUTH]
                            )
                        case Side.EAST:
                            if x + 1 >= fabric.width:
                                continue
                            if fabric[(x + 1, y)] is None:
                                continue
                            inputOnSide[Side.EAST].extend(
                                tileToTileOutMapping[(x + 1, y)][Side.WEST]
                            )

                        case Side.SOUTH:
                            if y - 1 > 0:
                                continue
                            if fabric[(x, y - 1)] is None:
                                continue
                            inputOnSide[Side.SOUTH].extend(
                                tileToTileOutMapping[(x, y - 1)][Side.NORTH]
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
                if y == fabric.width - 1:
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
                            lr.ConnectPair("MaxFramesPerCol", maxFramePerCol),
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
                            lr.ConnectPair("MaxFramesPerCol", maxFramePerCol),
                            lr.ConnectPair("FrameBitsPerRow", frameBitsPerRow),
                            lr.ConnectPair("EMULATION_ENABLE", emuEn),
                            lr.ConnectPair("EMULATION_CONFIG", emuCfg),
                            lr.ConnectPair("X_CORD", x),
                            lr.ConnectPair("Y_CORD", y),
                        ],
                    )
