from pathlib import Path

from FABulous.fabric_definition.define import IO, ConfigBitMode
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator


def generateTile(fabric: Fabric, tile: Tile, dest: Path):
    cg = CodeGenerator(dest)

    with cg.Module(tile.name) as module:
        with module.ParameterRegion() as pr:
            pr.Parameter(
                "MaxFramesPerCol",
                fabric.maxFramesPerCol,
            )
            pr.Parameter("FrameBitsPerRow", fabric.frameBitsPerRow)

            if tile.globalConfigBits > 0:
                pr.Parameter("NoConfigBits", tile.globalConfigBits)

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

            pr.Port("UserCLK", IO.INPUT)
            pr.Port("UserCLKo", IO.OUTPUT)

            if fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                if tile.globalConfigBits > 0:
                    pr.Port("FrameData", IO.INPUT, "FrameBitsPerRow - 1")
                    pr.Port("FrameData_O", IO.OUTPUT, "FrameBitsPerRow - 1")
                pr.Port("FrameStrobe", IO.INPUT, "MaxFramePerCol - 1")
                pr.Port("FrameStrobe_O", IO.OUTPUT, "MaxFramePerCol - 1")

            else:
                pr.Port("MODE", IO.INPUT)
                pr.Port("CONFin", IO.INPUT)
                pr.Port("CONFout", IO.OUTPUT)
                pr.Port("CLK", IO.INPUT)

        with module.LogicRegion() as lr:
            lr.Comment("Signal Creation")

            repeatSet = set()
            for bel in tile.bels:
                for port in (
                    bel.inputs + bel.outputs + bel.externalInputs + bel.externalOutputs
                ):
                    sig = f"{bel.prefix}{port.name}"
                    if sig in repeatSet:
                        raise ValueError(
                            f"Detected repeat naming of port in tile {tile.name} for bel {bel.name} for port {sig}"
                        )
                    lr.Signal(sig)
                    repeatSet.add(sig)
            sharePortSet = set()
            for bel in tile.bels:
                for port in bel.sharedPort:
                    sharePortSet.add(f"{port.name}_{port.sharedWith}")

            for port in sharePortSet:
                lr.Signal(port)

            if tile.globalConfigBits > 0:
                lr.Comment("ConfigBits Wires")
                lr.Signal("ConfigBits", "NoConfigBits - 1")
                lr.Signal("ConfigBits_N", "NoConfigBits - 1")

            lr.Comment("Buffering incoming and out outgoing wires")
            if tile.globalConfigBits > 0:
                lr.Signal("FrameData_O_i", "FrameBitsPerRow-1")
                lr.Signal("FrameData_i", "FrameBitsPerRow-1")
                lr.Comment("FrameData Buffer")
                lr.InitModule(
                    "my_buf_pack",
                    "data_inbuf",
                    [
                        lr.ConnectPair("A", "FrameData"),
                        lr.ConnectPair("X", "FrameData_i"),
                    ],
                    [
                        lr.ConnectPair("WIDTH", "FrameBitsPerRow"),
                    ],
                )
                lr.Assign("FrameData_O_i", "FrameData_i")
                lr.InitModule(
                    "my_buf_pack",
                    "data_outbuf",
                    [
                        lr.ConnectPair("A", "FrameData_O_i"),
                        lr.ConnectPair("X", "FrameData_O"),
                    ],
                    [
                        lr.ConnectPair("WIDTH", "FrameBitsPerRow"),
                    ],
                )

            lr.Comment("FrameStrobe Buffer")
            lr.Signal("FrameStrobe_i", "MaxFramesPerCol-1")
            lr.Signal("FrameStrobe_O_i", "MaxFramesPerCol-1")
            lr.InitModule(
                "my_buf_pack",
                "strobe_inbuf",
                [
                    lr.ConnectPair("A", "FrameStrobe"),
                    lr.ConnectPair("X", "FrameStrobe_i"),
                ],
                [
                    lr.ConnectPair("WIDTH", "MaxFramesPerCol"),
                ],
            )

            lr.Assign("FrameStrobe_O_i", "FrameStrobe_i")
            lr.InitModule(
                "my_buf_pack",
                "strobe_outbuf",
                [
                    lr.ConnectPair("A", "FrameStrobe_O_i"),
                    lr.ConnectPair("X", "FrameStrobe_O"),
                ],
                [
                    lr.ConnectPair("WIDTH", "MaxFramesPerCol"),
                ],
            )

            lr.InitModule(
                "clk_buf",
                "inst_clk_buf",
                [
                    lr.ConnectPair("A", "UserCLK"),
                    lr.ConnectPair("X", "UserCLKo"),
                ],
            )

            for inPort in tile.getTileInputPorts():
                if not inPort.spanning:
                    continue
                c = tile.getCascadeWireCount(inPort)
                lr.Signal(f"{inPort.name}_i", c - inPort.wireCount)
                lr.Assign(
                    f"{inPort.name}_i[{c}-1:{inPort.wireCount}]",
                    f"{inPort.name}[{inPort.wireCount-1}:0]",
                )
                lr.InitModule(
                    "my_buf_pack",
                    f"{inPort.name}_inbuf",
                    [
                        lr.ConnectPair(
                            "A",
                            f"{inPort.name}[{inPort.wireCount-1}:{inPort.wireCount-1}]",
                        ),
                        lr.ConnectPair("X", f"{inPort.name}_i"),
                    ],
                    [lr.ConnectPair("WIDTH", c - inPort.wireCount)],
                )
                outPort = tile.getEndPointPort(inPort)
                lr.Signal(f"{outPort.name}_i", c - outPort.wireCount)
                lr.Assign(
                    f"{outPort.name}_i[{c}-1:{outPort.wireCount}]",
                    f"{inPort.name}_i[{c}-1:{inPort.wireCount}]",
                )
                lr.InitModule(
                    "my_buf_pack",
                    f"{outPort.name}_outbuf",
                    [
                        lr.ConnectPair("A", f"{outPort.name}_i"),
                        lr.ConnectPair("X", f"{outPort.name}"),
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
            if (
                fabric.configBitMode == ConfigBitMode.FRAME_BASED
                and tile.globalConfigBits > 0
            ):
                lr.Comment("Init Configuration storage latches")
                lr.InitModule(
                    f"{tile.name}_ConfigMem",
                    f"Inst_{tile.name}_ConfigMem",
                    [
                        lr.ConnectPair("FrameData", "FrameData"),
                        lr.ConnectPair("FrameStrobe", "FrameStrobe"),
                        lr.ConnectPair("ConfigBits", "ConfigBits"),
                        lr.ConnectPair("ConfigBits_N", "ConfigBits_N"),
                    ],
                )

            # init bels
            belConfigBitCounter = 0
            for bel in tile.bels:
                lr.Comment(f"Instantiate BEL {bel.name}")

                connectPairs = []

                # basic ports
                for port in (
                    bel.inputs + bel.outputs + bel.externalInputs + bel.externalOutputs
                ):
                    connectPairs.append(
                        lr.ConnectPair(port.name, f"{bel.prefix}{port.name}")
                    )

                # user clock
                if bel.userCLK:
                    connectPairs.append(lr.ConnectPair(bel.userCLK.name, "UserCLK"))

                # shared ports
                for port in bel.sharedPort:
                    connectPairs.append(
                        lr.ConnectPair(
                            port.name,
                            f"{port.name}_{port.sharedWith}",
                        )
                    )

                # config ports
                for port in bel.configPort:
                    connectPairs.append(
                        lr.ConnectPair(
                            port.name,
                            f"ConfigBits[{belConfigBitCounter+port.wireCount}-1:{belConfigBitCounter}]",
                        )
                    )
                    belConfigBitCounter += port.wireCount

                lr.InitModule(
                    bel.name,
                    f"Inst_{bel.prefix}{bel.name}",
                    [
                        lr.ConnectPair(p.name, f"{bel.prefix}{p.name}")
                        for p in bel.inputs
                        + bel.outputs
                        + bel.externalInputs
                        + bel.externalOutputs
                    ],
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
