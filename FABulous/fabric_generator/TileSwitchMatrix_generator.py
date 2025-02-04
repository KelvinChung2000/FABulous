from itertools import zip_longest
from pathlib import Path

from loguru import logger

from FABulous.fabric_definition.define import IO, ConfigBitMode, MultiplexerStyle
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generator_2 import CodeGenerator


def generateTileSwitchMatrix(fabric: Fabric, tile: Tile, dest: Path):

    sm = tile.switchMatrix
    cg = CodeGenerator(dest)

    with cg.Module(f"{tile.name}_switch_matrix") as module:
        with module.ParameterRegion() as pr:
            noConfigBitsParam = pr.Parameter(
                "NoConfigBits", tile.switchMatrix.configBits
            )

        with module.PortRegion() as pr:
            for output in sm.getOutputs():
                pr.Port(output.value, IO.OUTPUT, output.bitWidth)
            for i in sm.getInputs():
                pr.Port(i.value, IO.INPUT, i.bitWidth)

            if tile.switchMatrix.configBits > 0:
                if fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
                    pr.Port("MODE", IO.INPUT)
                    pr.Port("CONFin", IO.INPUT)
                    pr.Port("CONFout", IO.OUTPUT)
                    pr.Port("CLK", IO.INPUT)
                else:
                    configBitsPort = pr.Port(
                        "ConfigBits", IO.INPUT, noConfigBitsParam - 1
                    )
                    configBitsNPort = pr.Port(
                        "ConfigBits_N", IO.INPUT, noConfigBitsParam - 1
                    )

        with module.LogicRegion() as lr:
            gnd = lr.Constant("GND0", 0)
            lr.Constant("GND", 0)
            lr.Constant("VCC0", 1)
            lr.Constant("VCC", 1)
            lr.Constant("VDD0", 1)
            lr.Constant("VDD", 1)
            lr.NewLine()

            configBitstreamPosition = 0
            for mux in sm.muxes.values():
                inputCount = len(mux.inputs)
                lr.Comment(f"switch matrix multiplexer {mux.output} MUX-{inputCount}")
                if inputCount == 0:
                    logger.warning(f"Multiplexer {mux.output} has no inputs")
                    logger.warning(f"Skipping {mux.output}")
                    lr.Comment(f"WARNING unused multiplexer MUX-{mux.output}")

                elif inputCount == 1:
                    lr.Assign(mux.output, mux.inputs[0])
                else:
                    # this is the case for a configurable switch matrix multiplexer
                    old_ConfigBitstreamPosition = configBitstreamPosition

                    if fabric.multiplexerStyle == MultiplexerStyle.CUSTOM:
                        # Pad mux size to the next power of 2
                        paddedMuxSize = 2 ** (inputCount - 1).bit_length()

                        if paddedMuxSize == 2:
                            muxComponentName = f"cus_mux{paddedMuxSize}1_pack"
                        else:
                            muxComponentName = f"cus_mux{paddedMuxSize}1_buf_pack"

                        connection = []

                        if paddedMuxSize == 2:
                            connection.append(
                                lr.ConnectPair(
                                    "S", configBitsPort[configBitstreamPosition]
                                )
                            )
                        else:
                            for i in range(paddedMuxSize.bit_length() - 1):
                                connection.append(
                                    lr.ConnectPair(
                                        f"S{i}",
                                        configBitsPort[configBitstreamPosition + i],
                                    )
                                )
                                connection.append(
                                    lr.ConnectPair(
                                        f"S{i}N",
                                        configBitsNPort[configBitstreamPosition + i],
                                    )
                                )

                        connection.append(lr.ConnectPair("X", mux.output))
                        # we add the input signal in reversed order
                        # Changed it such that the left-most entry is located at the end of the concatenated vector for the multiplexing
                        # This was done such that the index from left-to-right in the adjacency matrix corresponds with the multiplexer select input (index)
                        lr.InitModule(
                            muxComponentName,
                            f"inst_{muxComponentName}_{mux.output}",
                            [
                                lr.ConnectPair(f"A{index}", input_signal)
                                for index, input_signal in zip_longest(
                                    range(0, paddedMuxSize),
                                    mux.inputs[::-1],
                                    fillvalue=gnd,
                                )
                            ]
                            + connection,
                            [lr.ConnectPair("WIDTH", mux.width)],
                        )
                        if (inputCount & inputCount - 1) != 0:
                            logger.warning(
                                f"creating a MUX-{inputCount} for port {mux.output} using MUX-{inputCount} in switch matrix for tile {tile.name}"
                            )
                    else:
                        # generic multiplexer
                        lr.Assign(
                            mux.output,
                            f"{mux.output}_input[ConfigBits[{configBitstreamPosition - 1}:{configBitstreamPosition}]]",
                        )

                    configBitstreamPosition += paddedMuxSize.bit_length() - 1
