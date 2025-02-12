from typing import Generator, Mapping

from loguru import logger

from FABulous.fabric_cad.define import FeatureMap, FeatureValue
from FABulous.fabric_definition.Fabric import Fabric


def generateBitsStreamSpec(fabric: Fabric) -> FeatureMap:
    """Generate the bitstream specification of the fabric. This is needed and will be
    further parsed by the bit_gen.py.

    Returns
    -------
    dict [str, dict]
        The bits stream specification of the fabric.
    """

    featureToBitString: Mapping[str, FeatureValue] = {}
    for (x, y), tile in fabric.getFlattenFabric():
        if tile is None:
            continue

        if tile.globalConfigBits > 0 and len(tile.configMems) == 0:
            logger.critical(f"No global configuration bits found for tile {tile.name}")

        def frameIndexCounter() -> Generator[tuple[int, int]]:
            value: list[int] = [0, 0]
            while True:
                yield (value[0], value[1])
                value[1] += 1
                if value[1] == 31:
                    value[1] = 0
                    value[0] += 1

        indexCounter = frameIndexCounter()

        # TODO: Need to support multi-bit features
        for i, bel in enumerate(tile.bels):
            for config in bel.configPort:
                if config.wireCount == 1:
                    featureToBitString[f"X{x}Y{y}.{bel.prefix}{config.feature}"] = (
                        FeatureValue((x, y), [next(indexCounter)], config.value)
                    )
                else:
                    raise NotImplementedError(
                        "Multi-bit features are not supported yet"
                    )
                # else:
                #     multiBitIndex: list[tuple[int, int] | tuple[None, None]] = [
                #         next(indexCounter) for _ in range(config.wireCount)
                #     ]
                #     for i, index in enumerate(multiBitIndex):
                #         featureToBitString[f"X{x}Y{y}.{bel.prefix}{config.feature}[{i}]"] = FeatureValue(
                #             (x, y), multiBitIndex, config.value
                #         )

        for mux in tile.switchMatrix.muxes:
            if len(mux.inputs) == 1:
                featureToBitString[
                    f"X{x}Y{y}.{mux.inputs[0].name}.{mux.output.name}"
                ] = FeatureValue((x, y), [(None, None)], 0)
                continue

            multiBitIndex: list[tuple[int, int] | tuple[None, None]] = [
                next(indexCounter) for _ in range(len(mux.inputs))
            ]
            for i, input in reversed(list(enumerate(mux.inputs))):
                featureToBitString[f"X{x}Y{y}.{input.name}.{mux.output.name}"] = (
                    FeatureValue((x, y), multiBitIndex, i)
                )

        # And now we add empty config bit mappings for immutable connections (i.e. wires), as nextpnr sees these the same as normal pips
        for wire in tile.wireTypes:
            featureToBitString[
                f"X{x}Y{y}.{wire.sourcePort.name}.{wire.destinationPort.name}"
            ] = FeatureValue((x, y), [(None, None)], 0)

    return featureToBitString
