from typing import Generator, Mapping

from FABulous.fabric_cad.define import FeatureMap, FeatureValue
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort


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

        for c in range(fabric.contextCount):
            for i, bel in enumerate(tile.bels):
                for config in bel.configPort:
                    if config.width == 1 and len(config.features) == 1:
                        featureToBitString[
                            f"X{x}Y{y}.c{c}.{bel.prefix}{bel.name}.{config.name}"
                        ] = FeatureValue((x, y), (next(indexCounter),), None)
                    else:
                        multiBitIndex = tuple(
                            [next(indexCounter) for _ in range(config.width)]
                        )
                        featureToBitString[
                            f"X{x}Y{y}.c{c}.{bel.prefix}{bel.name}.{config.name}"
                        ] = FeatureValue((x, y), multiBitIndex, None)
                for input in bel.inputs:
                    if not input.control:
                        continue

                    if input.width != 1:
                        raise NotImplementedError(
                            "Control input with width != 1 is not supported"
                        )

                    featureToBitString[
                        f"X{x}Y{y}.c{c}.{bel.prefix}{bel.name}.{input.name}"
                    ] = FeatureValue((x, y), (next(indexCounter),), None)

            for mux in tile.switchMatrix.muxes:
                if isinstance(mux.output, BelPort):
                    outputName = f"c{c}.{mux.output.prefix}{mux.output.name}"
                else:
                    outputName = f"c{c}.{mux.output.name}"

                inputNames = []
                for i in mux.inputs:
                    if isinstance(i, BelPort):
                        inputNames.append(f"c{c}.{i.prefix}{i.name}")
                    else:
                        inputNames.append(f"c{c}.{i.name}")

                if mux.width == 1:
                    if len(mux.inputs) == 1:
                        # This is a wire
                        featureToBitString[
                            f"X{x}Y{y}.{outputName}.{mux.inputs[0].name}"
                        ] = FeatureValue((x, y), ((None, None),), 0)
                        continue

                    multiBitIndex = tuple(
                        [
                            next(indexCounter)
                            for _ in range(len(mux.inputs).bit_length() - 1)
                        ]
                    )
                    for i, input in enumerate(reversed(inputNames)):
                        featureToBitString[f"X{x}Y{y}.c{c}.{outputName}.{input}"] = (
                            FeatureValue((x, y), multiBitIndex, i)
                        )
                else:
                    if len(mux.inputs) == 1:
                        # This is a wire
                        for w in range(mux.width):
                            featureToBitString[
                                f"X{x}Y{y}.{outputName}__{w}.{inputNames[0]}__{w}"
                            ] = FeatureValue((x, y), ((None, None),), 0)
                        continue

                    multiBitIndex = tuple(
                        [
                            next(indexCounter)
                            for _ in range(len(mux.inputs).bit_length() - 1)
                        ]
                    )
                    for i, input in enumerate(reversed(inputNames)):
                        for w in range(mux.width):
                            featureToBitString[
                                f"X{x}Y{y}.{outputName}__{w}.{input}__{w}"
                            ] = FeatureValue((x, y), multiBitIndex, i)

            for wire in tile.wireTypes:
                for i in range(wire.wireCount):
                    featureToBitString[
                        f"X{x}Y{y}.c{c}.{wire.sourcePort.name}__{i}.{wire.destinationPort.name}__{i}"
                    ] = FeatureValue((x, y), [(None, None)], 0)

    return featureToBitString
