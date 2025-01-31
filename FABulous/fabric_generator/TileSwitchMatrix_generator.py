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

    noConfigBits = sum([i.configBit for i in tile.switchMatrix])

    ports = []
    for mux in tile.switchMatrix:
        ports.append(cg.Port(mux.output, IO.OUTPUT, mux.width))

    for mux in tile.switchMatrix:
        for i in mux.inputs:
            ports.append(cg.Port(i, IO.INPUT, mux.width))

    if noConfigBits > 0:
        if fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            ports.append(cg.Port("MODE", IO.INPUT))
            ports.append(cg.Port("CONFin", IO.INPUT))
            ports.append(cg.Port("CONFout", IO.OUTPUT))
            ports.append(cg.Port("CLK", IO.INPUT))
        else:
            ports.append(cg.Port("ConfigBits", IO.INPUT, "NoConfigBits-1"))
            ports.append(cg.Port("ConfigBits_N", IO.INPUT, "NoConfigBits-1"))

    with cg.Module(
        f"{tile.name}_switch_matrix",
        [cg.Parameter("NoConfigBits", noConfigBits)],
        ports,
    ):
        cg.Constant("GND0", 0)
        cg.Constant("GND", 0)
        cg.Constant("VCC0", 1)
        cg.Constant("VCC", 1)
        cg.Constant("VDD0", 1)
        cg.Constant("VDD", 1)

        for mux in tile.switchMatrix:
            cg.Signal(f"{mux.output}_input", len(mux.inputs))

        configBitstreamPosition = 0
        for mux in tile.switchMatrix:
            inputCount = len(mux.inputs)
            cg.Comment(f"switch matrix multiplexer {mux.output} MUX-{inputCount}")
            if inputCount == 0:
                logger.warning(f"Multiplexer {mux.output} has no inputs")
                logger.warning(f"Skipping {mux.output}")
                cg.Comment(f"WARNING unused multiplexer MUX-{mux.output}")

            elif inputCount == 1:
                cg.Assign(f"{mux.output}", f"{mux.inputs[0]}")
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
                            cg.ConnectPair(f"A{start}", f"{mux.output}_input[{start}]")
                        )
                    for end in range(start + 1, paddedMuxSize):
                        connection.append(cg.ConnectPair(f"A{end}", "GND0"))

                    if paddedMuxSize == 2:
                        connection.append(
                            cg.ConnectPair(
                                "S", f"ConfigBits[{configBitstreamPosition}+0]"
                            )
                        )
                    else:
                        for i in range(paddedMuxSize.bit_length() - 1):
                            connection.append(
                                cg.ConnectPair(
                                    f"S{i}",
                                    f"ConfigBits[{configBitstreamPosition}+{i}]",
                                )
                            )
                            connection.append(
                                cg.ConnectPair(
                                    f"S{i}N",
                                    f"ConfigBits_N[{configBitstreamPosition}+{i}]",
                                )
                            )

                    connection.append(("X", f"{mux.output}"))
                    # we add the input signal in reversed order
                    # Changed it such that the left-most entry is located at the end of the concatenated vector for the multiplexing
                    # This was done such that the index from left-to-right in the adjacency matrix corresponds with the multiplexer select input (index)
                    cg.Assign(f"{mux.output}_input", cg.Concat(mux.inputs[::-1]))
                    cg.InitModule(
                        muxComponentName,
                        f"inst_{muxComponentName}_{mux.output}",
                        [],
                        connection,
                    )
                    if (inputCount & inputCount - 1) != 0:
                        logger.warning(
                            f"creating a MUX-{inputCount} for port {mux.output} using MUX-{inputCount} in switch matrix for tile {tile.name}"
                        )
                else:
                    # generic multiplexer
                    cg.Assign(
                        mux.output,
                        f"{mux.output}_input[ConfigBits[{configBitstreamPosition-1}:{configBitstreamPosition}]]",
                    )

                configBitstreamPosition += inputCount.bit_length() - 1
