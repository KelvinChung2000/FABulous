from typing import Generator

from loguru import logger

from FABulous.fabric_cad.define import FeatureValue
from FABulous.fabric_definition.Fabric import Fabric


def generateBitsStreamSpec(fabric: Fabric) -> dict[str, dict]:
    """Generate the bitstream specification of the fabric. This is needed and will be
    further parsed by the bit_gen.py.

    Returns
    -------
    dict [str, dict]
        The bits stream specification of the fabric.
    """

    specData = {
        "TileMap": {},
        "TileSpecs": {},
        "TileSpecs_No_Mask": {},
        "FrameMap": {},
        "FrameMapEncode": {},
        "ArchSpecs": {
            "MaxFramesPerCol": fabric.maxFramesPerCol,
            "FrameBitsPerRow": fabric.frameBitsPerRow,
        },
    }

    tileMap = {}
    for y, row in enumerate(fabric.tile):
        for x, tile in enumerate(row):
            if tile is not None:
                tileMap[f"X{x}Y{y}"] = tile.name
            else:
                tileMap[f"X{x}Y{y}"] = "NULL"

    specData["TileMap"] = tileMap
    for y, row in enumerate(fabric.tile):
        for x, tile in enumerate(row):
            if tile is None:
                continue

            if tile.globalConfigBits > 0 and len(tile.configMems) == 0:
                logger.critical(
                    f"No global configuration bits found for tile {tile.name}"
                )

            featureToBitString = {}

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
                    featureToBitString[f"{bel.prefix}{config.feature}"] = FeatureValue(
                        next(indexCounter), config.value
                    )

            for mux in tile.switchMatrix.muxes:
                if len(mux.inputs) == 1:
                    featureToBitString[f"{mux.inputs[0].name}.{mux.output.name}"] = (
                        FeatureValue((None, None), 0)
                    )
                    continue

                for i, input in reversed(list(enumerate(mux.inputs))):
                    featureToBitString[f"{input.name}.{mux.output.name}"] = (
                        FeatureValue(next(indexCounter), i)
                    )

            # And now we add empty config bit mappings for immutable connections (i.e. wires), as nextpnr sees these the same as normal pips
            for wire in tile.wireTypes:
                featureToBitString[
                    f"{wire.sourcePort.name}.{wire.destinationPort.name}"
                ] = {}

            specData["TileSpecs"][f"X{x}Y{y}"] = featureToBitString

    return specData
