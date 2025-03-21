from typing import Mapping

from FABulous.fabric_definition.define import IO, ConfigBitMode
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort, Port, SlicedPort, TilePort
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.fabric_generator.HDL_Construct.Value import Value


def generateTile(codeGen: CodeGenerator, fabric: Fabric, tile: Tile):
    with codeGen.Module(tile.name) as module:
        with module.ParameterRegion() as pr:
            maxFramePerCol = pr.Parameter(
                "MaxFramesPerCol",
                fabric.maxFramesPerCol,
            )
            frameBitsPerRow = pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)
            if tile.configBits > 0:
                NoConfigBitsParam = pr.Parameter("NoConfigBits", tile.configBits)
            pr.Comment("Emulation Parameters")
            emuEn = pr.Parameter("EMULATION_ENABLE", 0)
            emuCfg = pr.Parameter("EMULATION_CONFIG", 0)
            xCord = pr.Parameter("X_CORD", -1)
            yCord = pr.Parameter("Y_CORD", -1)

        portMapping: Mapping[TilePort | Port, Value] = {}
        externalBelPortMapping: Mapping[BelPort, Value] = {}
        with module.PortRegion() as pr:
            for side, ports in tile.getTilePortGrouped().items():
                pr.Comment(f"{side.name}")

                for p in ports:
                    portMapping[p] = pr.Port(
                        p.name, p.ioDirection, tile.getCascadeWireCount(p)
                    )

            for bel in tile.bels:
                for p in bel.externalInputs:
                    externalBelPortMapping[p] = pr.Port(
                        f"{p.prefix}{p.name}", p.ioDirection, p.width
                    )
                for p in bel.externalOutputs:
                    externalBelPortMapping[p] = pr.Port(
                        f"{p.prefix}{p.name}", p.ioDirection, p.width
                    )

            userClkIn = pr.Port("UserCLK", IO.INPUT)
            userClkOut = pr.Port("UserCLK_o", IO.OUTPUT)

            if fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                frameData = pr.Port("FrameData", IO.INPUT, frameBitsPerRow - 1)
                frameDataOut = pr.Port("FrameData_o", IO.OUTPUT, frameBitsPerRow - 1)
                frameStrobe = pr.Port("FrameStrobe", IO.INPUT, maxFramePerCol - 1)
                frameStrobeOut = pr.Port("FrameStrobe_o", IO.OUTPUT, maxFramePerCol - 1)

            else:
                pr.Port("MODE", IO.INPUT)
                pr.Port("CONFin", IO.INPUT)
                pr.Port("CONFout", IO.OUTPUT)
                pr.Port("CLK", IO.INPUT)

        with module.LogicRegion() as lr:
            lr.Comment("Signal Creation")

            belPortMapping: Mapping[BelPort, Value] = {}
            repeatSet = set()
            for bel in tile.bels:
                for port in bel.inputs + bel.outputs:
                    sig = f"{bel.prefix}{port.name}"
                    if sig in repeatSet:
                        raise ValueError(
                            f"Detected repeat naming of port in tile {tile.name} for bel {bel.name} for port {sig}"
                        )
                    sigValue = lr.Signal(sig, port.width)
                    repeatSet.add(sig)
                    belPortMapping[port] = sigValue

                for port in bel.externalInputs + bel.externalOutputs:
                    sig = f"{port.prefix}{port.name}"
                    if sig in repeatSet:
                        raise ValueError(
                            f"Detected repeat naming of port in tile {tile.name} for bel {bel.name} for port {sig}"
                        )
                    repeatSet.add(sig)
                    belPortMapping[port] = externalBelPortMapping[port]

            sharePortDict: Mapping[str, Value] = {}
            for bel in tile.bels:
                for port in bel.sharedPort:
                    sharePortDict[port.sharedWith] = lr.Signal(port.name)

            if tile.configBits > 0:
                lr.NewLine()
                lr.Comment("ConfigBits Wires")
                configBitsSignal = lr.Signal("ConfigBits", NoConfigBitsParam - 1)
                configBitsNSignal = lr.Signal("ConfigBits_N", NoConfigBitsParam - 1)

            lr.NewLine()
            lr.Comment("Buffering incoming and out outgoing wires")
            if tile.configBits > 0:
                lr.Comment("FrameData Buffer")
                frameDataOutToIn = lr.Signal("FrameData_internal", frameBitsPerRow - 1)
                lr.NewLine()
                lr.InitModule(
                    "my_buf_pack",
                    "data_inbuf",
                    [
                        lr.ConnectPair("A", frameData),
                        lr.ConnectPair("X", frameDataOutToIn),
                    ],
                    [
                        lr.ConnectPair("WIDTH", frameBitsPerRow),
                    ],
                )
                lr.InitModule(
                    "my_buf_pack",
                    "data_outbuf",
                    [
                        lr.ConnectPair("A", frameDataOutToIn),
                        lr.ConnectPair("X", frameDataOut),
                    ],
                    [
                        lr.ConnectPair("WIDTH", frameBitsPerRow),
                    ],
                )

            lr.Comment("FrameStrobe Buffer")
            frameBufferOutToIn = lr.Signal("FrameStrobe_internal", maxFramePerCol - 1)
            lr.NewLine()
            lr.InitModule(
                "my_buf_pack",
                "strobe_inbuf",
                [
                    lr.ConnectPair("A", frameStrobe),
                    lr.ConnectPair("X", frameBufferOutToIn),
                ],
                [
                    lr.ConnectPair("WIDTH", maxFramePerCol),
                ],
            )

            lr.InitModule(
                "my_buf_pack",
                "strobe_outbuf",
                [
                    lr.ConnectPair("A", frameBufferOutToIn),
                    lr.ConnectPair("X", frameStrobeOut),
                ],
                [
                    lr.ConnectPair("WIDTH", maxFramePerCol),
                ],
            )

            lr.Comment("User Clock Buffer")
            lr.InitModule(
                "clk_buf",
                "inst_clk_buf",
                [
                    lr.ConnectPair("A", userClkIn),
                    lr.ConnectPair("X", userClkOut),
                ],
            )
            for wire in tile.wireTypes:
                if not wire.spanning:
                    continue
                lr.Comment(
                    f"Buffer spanning wire: {wire.destinationPort.name}->{wire.sourcePort.name}"
                )
                bufferOutToIn = lr.Signal(
                    f"{wire.destinationPort.name}_to_{wire.sourcePort.name}",
                    wire.cascadeWireCount - wire.wireCount,
                )
                lr.InitModule(
                    "my_buf_pack",
                    f"{wire.destinationPort.name}_inbuf",
                    [
                        lr.ConnectPair(
                            "A", portMapping[wire.destinationPort][: wire.wireCount]
                        ),
                        lr.ConnectPair("X", bufferOutToIn),
                    ],
                    [lr.ConnectPair("WIDTH", wire.cascadeWireCount - wire.wireCount)],
                )
                lr.InitModule(
                    "my_buf_pack",
                    f"{wire.sourcePort.name}_outbuf",
                    [
                        lr.ConnectPair("A", bufferOutToIn),
                        lr.ConnectPair(
                            "X",
                            portMapping[wire.sourcePort][
                                wire.cascadeWireCount - wire.wireCount - 1 :
                            ],
                        ),
                    ],
                    [lr.ConnectPair("WIDTH", wire.cascadeWireCount - wire.wireCount)],
                )

            # if fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            #     lr.Comment("top configuration data daisy chaining")
            #     self.writer.addAssignScalar("conf_data(conf_data'low)", "CONFin")
            #     self.writer.addComment("conf_data'low=0 and CONFin is from tile entity")
            #     self.writer.addAssignScalar("conf_data(conf_data'high)", "CONFout")
            #     self.writer.addComment("CONFout is from tile entity")

            # init config memory
            if (
                fabric.configBitMode == ConfigBitMode.FRAME_BASED
                and tile.configBits > 0
            ):
                lr.Comment("Init Configuration storage latches\n")
                lr.InitModule(
                    f"{tile.name}_ConfigMem",
                    f"Inst_{tile.name}_ConfigMem",
                    [
                        lr.ConnectPair("FrameData", frameData),
                        lr.ConnectPair("FrameStrobe", frameStrobe),
                        lr.ConnectPair("ConfigBits", configBitsSignal),
                        lr.ConnectPair("ConfigBits_N", configBitsNSignal),
                    ],
                    [
                        lr.ConnectPair("EMULATION_ENABLE", emuEn),
                        lr.ConnectPair("EMULATION_CONFIG", emuCfg),
                        lr.ConnectPair("X_CORD", xCord),
                        lr.ConnectPair("Y_CORD", yCord),
                    ],
                )

            # init bels
            belConfigBitCounter = 0
            for bel in tile.bels:
                lr.Comment(f"Instantiate BEL {bel.prefix}{bel.name}")

                connectPairs = []

                # basic ports
                for port in (
                    bel.inputs + bel.outputs + bel.externalInputs + bel.externalOutputs
                ):
                    connectPairs.append(lr.ConnectPair(port.name, belPortMapping[port]))

                # user clock
                if bel.userCLK:
                    connectPairs.append(lr.ConnectPair(bel.userCLK.name, userClkIn))

                # shared ports
                for port in bel.sharedPort:
                    connectPairs.append(
                        lr.ConnectPair(
                            port.name,
                            sharePortDict[port.sharedWith],
                        )
                    )

                # config ports
                for port in bel.configPort:
                    connectPairs.append(
                        lr.ConnectPair(
                            port.name,
                            configBitsSignal[
                                belConfigBitCounter
                                + port.width
                                - 1 : belConfigBitCounter
                            ],
                        )
                    )
                    belConfigBitCounter += port.width

                lr.InitModule(
                    bel.name,
                    f"Inst_{bel.prefix}{bel.name}",
                    connectPairs,
                )

            # init switch matrix
            connectPairs = []
            repeatSet = set()
            for output in tile.switchMatrix.getOutputs():
                repeatSet.add(output)
                if isinstance(output, TilePort):
                    connectPairs.append(
                        lr.ConnectPair(output.name, portMapping[output])
                    )
                elif isinstance(output, BelPort):
                    connectPairs.append(
                        lr.ConnectPair(
                            f"{output.prefix}{output.name}", belPortMapping[output]
                        )
                    )
                elif isinstance(output, SlicedPort):
                    connectPairs.append(
                        lr.ConnectPair(
                            output.name,
                            portMapping[output.originalPort][
                                output.sliceRange[0] : output.sliceRange[1]
                            ],
                        )
                    )
                else:
                    raise ValueError("Invalid port type")

            for input in tile.switchMatrix.getInputs():
                if input in repeatSet:
                    continue
                if isinstance(input, TilePort):
                    connectPairs.append(lr.ConnectPair(input.name, portMapping[input]))
                elif isinstance(input, BelPort):
                    connectPairs.append(
                        lr.ConnectPair(
                            f"{input.prefix}{input.name}", belPortMapping[input]
                        )
                    )

                elif isinstance(input, SlicedPort):
                    connectPairs.append(
                        lr.ConnectPair(
                            input.name,
                            portMapping[input.originalPort][
                                input.sliceRange[0] : input.sliceRange[1]
                            ],
                        )
                    )

            # for input in tile.switchMatrix.getInputs():
            #     connectPairs.append(lr.ConnectPair(input.value, input))

            # if fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            #     connectPairs.append(("MODE", "Mode"))
            #     connectPairs.append(("CONFin", f"conf_data({belCounter})"))
            #     connectPairs.append(("CONFout", f"conf_data({belCounter+1})"))
            #     connectPairs.append(("CLK", "CLK"))

            if fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                if tile.configBits > 0:
                    connectPairs.append(
                        lr.ConnectPair(
                            "ConfigBits",
                            configBitsSignal[tile.configBits - 1 : belConfigBitCounter],
                        )
                    )
                    connectPairs.append(
                        lr.ConnectPair(
                            "ConfigBits_N",
                            configBitsNSignal[
                                tile.configBits - 1 : belConfigBitCounter
                            ],
                        )
                    )
            lr.Comment("Init Switch Matrix")
            lr.InitModule(
                f"{tile.name}_switch_matrix",
                f"Inst_{tile.name}_switch_matrix",
                connectPairs,
            )
