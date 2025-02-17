from typing import Generator, Mapping

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

        def frameIndexCounter() -> Generator[tuple[int, int], None, None]:
            value: list[int] = [0, 0]
            while True:
                yield (value[0], value[1])
                value[1] += 1
                if value[1] == fabric.frameBitsPerRow:
                    value[1] = 0
                    value[0] += 1

        indexCounter = frameIndexCounter()

        for i, bel in enumerate(tile.bels):
            for config in bel.configPort:
                if config.wireCount == 1 and len(config.features) == 1:
                    featureToBitString[
                        f"X{x}Y{y}.{bel.prefix}{bel.name}.{config.features[0]}"
                    ] = FeatureValue((x, y), [next(indexCounter)], 1)
                else:
                    multiBitIndex: list[tuple[int, int] | tuple[None, None]] = [
                        next(indexCounter) for _ in range(config.wireCount)
                    ]
                    for i, (feature, value) in enumerate(config.features):
                        featureToBitString[
                            f"X{x}Y{y}.{bel.prefix}{bel.name}.{feature}[{i}]"
                        ] = FeatureValue((x, y), multiBitIndex, value)

        for mux in tile.switchMatrix.muxes:
            if len(mux.inputs) == 1:
                # This is a wire
                featureToBitString[
                    f"X{x}Y{y}.{mux.inputs[0].name}.{mux.output.name}"
                ] = FeatureValue((x, y), [(None, None)], 0)
                continue

            multiBitIndex: list[tuple[int, int] | tuple[None, None]] = [
                next(indexCounter) for _ in range(len(mux.inputs).bit_length() - 1)
            ]
            for i, input in enumerate(reversed(mux.inputs)):
                featureToBitString[f"X{x}Y{y}.{input.name}.{mux.output.name}"] = (
                    FeatureValue((x, y), multiBitIndex, i)
                )

        # And now we add empty config bit mappings for immutable connections (i.e. wires), as nextpnr sees these the same as normal pips
        for wire in tile.wireTypes:
            for i in range(wire.wireCount):
                featureToBitString[
                    f"X{x}Y{y}.{wire.sourcePort.name}{i}.{wire.destinationPort.name}{i}"
                ] = FeatureValue((x, y), [(None, None)], 0)

    return featureToBitString
