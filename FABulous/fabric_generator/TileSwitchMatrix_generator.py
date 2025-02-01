from pathlib import Path

from loguru import logger

from FABulous.fabric_definition.define import IO, ConfigBitMode, MultiplexerStyle
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator
from FABulous.file_parser.file_parser_yaml import parseMatrixAsMux


def generateTileSwitchMatrix(fabric: Fabric, tile: Tile, dest: Path):
    if isinstance(tile.switchMatrix, Path):
        tile.switchMatrix = list(
            parseMatrixAsMux(tile.switchMatrix, tile.name).values()
        )

    cg = CodeGenerator(dest)

    with cg.Module(f"{tile.name}_switch_matrix") as module:
        with module.ParameterRegion() as pr:
            pr.Parameter("NoConfigBits", sum([i.configBit for i in tile.switchMatrix]))

        noConfigBits = sum([i.configBit for i in tile.switchMatrix])

        with module.PortRegion() as pr:
            for mux in tile.switchMatrix:
                pr.Port(mux.output, IO.OUTPUT, mux.width)
                for i in mux.inputs:
                    pr.Port(i, IO.INPUT, mux.width)

            if noConfigBits > 0:
                if fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
                    pr.Port("MODE", IO.INPUT)
                    pr.Port("CONFin", IO.INPUT)
                    pr.Port("CONFout", IO.OUTPUT)
                    pr.Port("CLK", IO.INPUT)
                else:
                    pr.Port("ConfigBits", IO.INPUT, "NoConfigBits-1")
                    pr.Port("ConfigBits_N", IO.INPUT, "NoConfigBits-1")

        with module.LogicRegion() as lr:
            lr.Constant("GND0", 0)
            lr.Constant("GND", 0)
            lr.Constant("VCC0", 1)
            lr.Constant("VCC", 1)
            lr.Constant("VDD0", 1)
            lr.Constant("VDD", 1)

            configBitstreamPosition = 0
            for mux in tile.switchMatrix:
                inputCount = len(mux.inputs)
                lr.Comment(f"switch matrix multiplexer {mux.output} MUX-{inputCount}")
                if inputCount == 0:
                    logger.warning(f"Multiplexer {mux.output} has no inputs")
                    logger.warning(f"Skipping {mux.output}")
                    lr.Comment(f"WARNING unused multiplexer MUX-{mux.output}")

                elif inputCount == 1:
                    lr.Assign(f"{mux.output}", f"{mux.inputs[0]}")
                else:
                    # this is the case for a configurable switch matrix multiplexer
                    old_ConfigBitstreamPosition = configBitstreamPosition

                    if fabric.multiplexerStyle == MultiplexerStyle.CUSTOM:
                        # Pad mux size to the next power of 2
                        paddedMuxSize = 2 ** (inputCount - 1).bit_length()

                        if paddedMuxSize == 2:
                            muxComponentName = f"cus_mux{paddedMuxSize}1"
                        else:
                            muxComponentName = f"cus_mux{paddedMuxSize}1_buf"

                        connection = []
                        start = 0
                        for start in range(inputCount):
                            connection.append(
                                lr.ConnectPair(
                                    f"A{start}", f"{mux.output}_input[{start}]"
                                )
                            )
                        for end in range(start + 1, paddedMuxSize):
                            connection.append(lr.ConnectPair(f"A{end}", "GND0"))

                        if paddedMuxSize == 2:
                            connection.append(
                                lr.ConnectPair(
                                    "S", f"ConfigBits[{configBitstreamPosition}+0]"
                                )
                            )
                        else:
                            for i in range(paddedMuxSize.bit_length() - 1):
                                connection.append(
                                    lr.ConnectPair(
                                        f"S{i}",
                                        f"ConfigBits[{configBitstreamPosition}+{i}]",
                                    )
                                )
                                connection.append(
                                    lr.ConnectPair(
                                        f"S{i}N",
                                        f"ConfigBits_N[{configBitstreamPosition}+{i}]",
                                    )
                                )

                        connection.append(("X", f"{mux.output}"))
                        # we add the input signal in reversed order
                        # Changed it such that the left-most entry is located at the end of the concatenated vector for the multiplexing
                        # This was done such that the index from left-to-right in the adjacency matrix corresponds with the multiplexer select input (index)
                        lr.Assign(f"{mux.output}_input", lr.Concat(mux.inputs[::-1]))
                        lr.InitModule(
                            muxComponentName,
                            f"inst_{muxComponentName}_{mux.output}",
                            connection,
                        )
                        if (inputCount & inputCount - 1) != 0:
                            logger.warning(
                                f"creating a MUX-{inputCount} for port {mux.output} using MUX-{inputCount} in switch matrix for tile {tile.name}"
                            )
                    else:
                        # generic multiplexer
                        lr.Assign(
                            mux.output,
                            f"{mux.output}_input[ConfigBits[{configBitstreamPosition-1}:{configBitstreamPosition}]]",
                        )

                    configBitstreamPosition += inputCount.bit_length() - 1
