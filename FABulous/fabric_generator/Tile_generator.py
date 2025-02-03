from pathlib import Path
from typing import Mapping

from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import IO, ConfigBitMode
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.fabric_generator.HDL_Construct.Value import Value


def generateTile(fabric: Fabric, tile: Tile, dest: Path):
    cg = CodeGenerator(dest)

    with cg.Module(tile.name) as module:
        with module.ParameterRegion() as pr:
            maxFramePerCol = pr.Parameter(
                "MaxFramesPerCol",
                fabric.maxFramesPerCol,
            )
            frameBitsPerRow = pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)

            if tile.globalConfigBits > 0:
                NoConfigBitsParam = pr.Parameter("NoConfigBits", tile.globalConfigBits)

        with module.PortRegion() as pr:
            for p in tile.getTileOutputPorts():
                pr.Port(p.name, IO.OUTPUT, tile.getCascadeWireCount(p))
            for p in tile.getTileInputPorts():
                pr.Port(p.name, IO.INPUT, tile.getCascadeWireCount(p))

            for bel in tile.bels:
                for p in bel.externalInputs:
                    pr.Port(p.name, p.ioDirection, p.wireCount)
                for p in bel.externalOutputs:
                    pr.Port(p.name, p.ioDirection, p.wireCount)

            userClkIn = pr.Port("UserCLK", IO.INPUT)
            userClkOut = pr.Port("UserCLKo", IO.OUTPUT)

            if fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                if tile.globalConfigBits > 0:
                    frameData = pr.Port("FrameData", IO.INPUT, frameBitsPerRow - 1)
                    frameDataOut = pr.Port("FrameData_O", IO.OUTPUT, frameBitsPerRow - 1)
                frameStrobe = pr.Port("FrameStrobe", IO.INPUT, maxFramePerCol - 1)
                frameStrobeOut = pr.Port("FrameStrobe_O", IO.OUTPUT, maxFramePerCol - 1)

            else:
                pr.Port("MODE", IO.INPUT)
                pr.Port("CONFin", IO.INPUT)
                pr.Port("CONFout", IO.OUTPUT)
                pr.Port("CLK", IO.INPUT)

        with module.LogicRegion() as lr:
            lr.Comment("Signal Creation")

            belPortValueMap: Mapping[Bel, list[Value]] = {}
            repeatSet = set()
            for bel in tile.bels:
                valueList = []
                for port in bel.inputs + bel.outputs + bel.externalInputs + bel.externalOutputs:
                    sig = f"{bel.prefix}{port.name}"
                    if sig in repeatSet:
                        raise ValueError(
                            f"Detected repeat naming of port in tile {tile.name} for bel {bel.name} for port {sig}"
                        )
                    valueList.append(lr.Signal(sig))
                    repeatSet.add(sig)
                belPortValueMap[bel] = valueList

            sharePortDict: Mapping[str, Value] = {}
            for bel in tile.bels:
                for port in bel.sharedPort:
                    sharePortDict[port.sharedWith] = lr.Signal(port.name)

            if tile.globalConfigBits > 0:
                lr.Comment("ConfigBits Wires")
                configBitsSignal = lr.Signal("ConfigBits", NoConfigBitsParam - 1)
                configBitsNSignal = lr.Signal("ConfigBits_N", NoConfigBitsParam - 1)

            lr.Comment("Buffering incoming and out outgoing wires")
            if tile.globalConfigBits > 0:
                inputFrameDataBufferOut = lr.Signal("FrameData_i", frameBitsPerRow - 1)
                outputFrameDataBufferIn = lr.Signal("FrameData_O_i", frameBitsPerRow - 1)
                lr.Comment("FrameData Buffer")
                lr.InitModule(
                    "my_buf_pack",
                    "data_inbuf",
                    [
                        lr.ConnectPair("A", frameData),
                        lr.ConnectPair("X", inputFrameDataBufferOut),
                    ],
                    [
                        lr.ConnectPair("WIDTH", frameBitsPerRow),
                    ],
                )
                lr.Assign(outputFrameDataBufferIn, inputFrameDataBufferOut)
                lr.InitModule(
                    "my_buf_pack",
                    "data_outbuf",
                    [
                        lr.ConnectPair("A", outputFrameDataBufferIn),
                        lr.ConnectPair("X", frameDataOut),
                    ],
                    [
                        lr.ConnectPair("WIDTH", frameBitsPerRow),
                    ],
                )

            lr.Comment("FrameStrobe Buffer")
            inputFrameStrobeBufferOut = lr.Signal("FrameStrobe_i", maxFramePerCol - 1)
            outputFrameStrobeBufferIn = lr.Signal("FrameStrobe_O_i", maxFramePerCol - 1)
            lr.InitModule(
                "my_buf_pack",
                "strobe_inbuf",
                [
                    lr.ConnectPair("A", frameStrobe),
                    lr.ConnectPair("X", inputFrameStrobeBufferOut),
                ],
                [
                    lr.ConnectPair("WIDTH", maxFramePerCol),
                ],
            )

            lr.Assign(outputFrameStrobeBufferIn, inputFrameStrobeBufferOut)
            lr.InitModule(
                "my_buf_pack",
                "strobe_outbuf",
                [
                    lr.ConnectPair("A", outputFrameStrobeBufferIn),
                    lr.ConnectPair("X", frameStrobeOut),
                ],
                [
                    lr.ConnectPair("WIDTH", maxFramePerCol),
                ],
            )

            lr.InitModule(
                "clk_buf",
                "inst_clk_buf",
                [
                    lr.ConnectPair("A", userClkIn),
                    lr.ConnectPair("X", userClkOut),
                ],
            )

            for inPort in tile.getTileInputPorts():
                if not inPort.spanning:
                    continue
                c = tile.getCascadeWireCount(inPort)
                inPortSignal = lr.Signal(f"{inPort.name}_i", c - inPort.wireCount)
                lr.Assign(
                    inPortSignal[c - 1 : inPort.wireCount],
                    inPortSignal[inPort.wireCount : 0],
                )
                lr.InitModule(
                    "my_buf_pack",
                    f"{inPort.name}_inbuf",
                    [
                        lr.ConnectPair(
                            "A",
                            inPortSignal[c : inPort.wireCount],
                        ),
                        lr.ConnectPair("X", inPortSignal),
                    ],
                    [lr.ConnectPair("WIDTH", c - inPort.wireCount)],
                )
                outPort = tile.getEndPointPort(inPort)
                outPortSignal = lr.Signal(f"{outPort.name}_i", c - outPort.wireCount)
                lr.Assign(
                    outPortSignal[c - 1 : outPort.wireCount],
                    inPortSignal[c - 1 : inPort.wireCount],
                )
                lr.InitModule(
                    "my_buf_pack",
                    f"{outPort.name}_outbuf",
                    [
                        lr.ConnectPair("A", outPortSignal),
                        lr.ConnectPair("X", "outPortSignal"),
                    ],
                    [lr.ConnectPair("WIDTH", c - inPort.wireCount)],
                )

            # if fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            #     lr.Comment("top configuration data daisy chaining")
            #     self.writer.addAssignScalar("conf_data(conf_data'low)", "CONFin")
            #     self.writer.addComment("conf_data'low=0 and CONFin is from tile entity")
            #     self.writer.addAssignScalar("conf_data(conf_data'high)", "CONFout")
            #     self.writer.addComment("CONFout is from tile entity")

            # init config memory
            if fabric.configBitMode == ConfigBitMode.FRAME_BASED and tile.globalConfigBits > 0:
                lr.Comment("Init Configuration storage latches")
                lr.InitModule(
                    f"{tile.name}_ConfigMem",
                    f"Inst_{tile.name}_ConfigMem",
                    [
                        lr.ConnectPair("FrameData", frameData),
                        lr.ConnectPair("FrameStrobe", frameStrobe),
                        lr.ConnectPair("ConfigBits", configBitsSignal),
                        lr.ConnectPair("ConfigBits_N", configBitsNSignal),
                    ],
                )

            # init bels
            belConfigBitCounter = 0
            for bel in tile.bels:
                lr.Comment(f"Instantiate BEL {bel.name}")

                connectPairs = []

                # basic ports

                for port, value in zip(
                    bel.inputs + bel.outputs + bel.externalInputs + bel.externalOutputs, belPortValueMap[bel]
                ):
                    connectPairs.append(lr.ConnectPair(port.name, value))

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
                            configBitsSignal[belConfigBitCounter + port.wireCount - 1 : belConfigBitCounter],
                        )
                    )
                    belConfigBitCounter += port.wireCount

                lr.InitModule(
                    bel.name,
                    f"Inst_{bel.prefix}{bel.name}",
                    connectPairs,
                )

            # init switch matrix
            connectPairs = []
            for mux in tile.switchMatrix:
                connectPairs.append(lr.ConnectPair(mux.output, mux.output))
                for i in mux.inputs:
                    connectPairs.append(lr.ConnectPair(i, i))

            # if fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            #     connectPairs.append(("MODE", "Mode"))
            #     connectPairs.append(("CONFin", f"conf_data({belCounter})"))
            #     connectPairs.append(("CONFout", f"conf_data({belCounter+1})"))
            #     connectPairs.append(("CLK", "CLK"))

            if fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                if tile.globalConfigBits > 0:
                    connectPairs.append(
                        lr.ConnectPair(
                            "ConfigBits",
                            f"ConfigBits[{tile.globalConfigBits}-1:{belConfigBitCounter}]",
                        )
                    )
                    connectPairs.append(
                        lr.ConnectPair(
                            "ConfigBits_N",
                            f"ConfigBits_N[{tile.globalConfigBits}-1:{belConfigBitCounter}]",
                        )
                    )
            lr.Comment("Init Switch Matrix")
            lr.InitModule(
                f"{tile.name}_SwitchMatrix",
                f"Inst_{tile.name}_SwitchMatrix",
                connectPairs,
            )
