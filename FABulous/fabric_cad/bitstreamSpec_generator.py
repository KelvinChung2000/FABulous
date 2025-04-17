from typing import Generator, Mapping

from FABulous.fabric_cad.define import FeatureMap, FeatureValue
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.Port import BelPort
from FABulous.fabric_definition.Tile import Tile


def generateBitsStreamSpec(fabric: Fabric) -> FeatureMap:
    featureToBitString: Mapping[str, FeatureValue] = {}
    for (x, y), tile in fabric:
        if tile is None:
            continue

        if tile.configBits == 0:
            continue

        def frameIndexGetter(tile: Tile) -> Generator[tuple[int, int], None, None]:
            cfgNumber = 0
            while True:
                yield tile.configMems[cfgNumber]
                cfgNumber += 1

        indexCounter = frameIndexGetter(tile)
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

                if len(mux.inputs) == 1:
                    continue
                if mux.width == 1:
                    multiBitIndex = tuple(
                        [next(indexCounter) for _ in range(mux.configBits)]
                    )
                    for i, input in enumerate(reversed(inputNames)):
                        featureToBitString[f"X{x}Y{y}.c{c}.{outputName}.{input}"] = (
                            FeatureValue((x, y), multiBitIndex, i)
                        )
                else:
                    multiBitIndex = tuple(
                        [next(indexCounter) for _ in range(mux.configBits)]
                    )
                    for i, input in enumerate(reversed(inputNames)):
                        for w in range(mux.width):
                            featureToBitString[
                                f"X{x}Y{y}.{outputName}__{w}.{input}__{w}"
                            ] = FeatureValue((x, y), multiBitIndex, i)

            for subTile in tile.wireTypes:
                for wire in tile.wireTypes[subTile]:
                    for i in range(wire.wireCount):
                        featureToBitString[
                            f"X{x}Y{y}.c{c}.{wire.sourcePort.name}__{i}.{wire.destinationPort.name}__{i}"
                        ] = FeatureValue((x, y), ((None, None),), 0)

    for key, i in featureToBitString.items():
        if i.value is not None:
            assert i.value < (
                2 ** len(i.bitPosition)
            ), f"feature {key} has value {i.value} which is larger than the bit position {i.bitPosition}"

    return featureToBitString
