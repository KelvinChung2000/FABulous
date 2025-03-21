from collections import namedtuple
from dataclasses import dataclass, field
from typing import Mapping

ConfigBitMapping = namedtuple(
    "ConfigBitMapping", ["configBitNumber", "frameIndex", "frameBitIndex"]
)


@dataclass(order=True)
class ConfigMemFrame:
    """Data structure to store the information about a config memory. Each structure
    represents a row of entries in the config memory CSV file.

    Attributes
    ----------
    frameName : str
        The name of the frame
    frameIndex : int
        The index of the frame
    bitUsedInFrame : int
        The number of bits used in the frame
    usedBitMask : int
        The bit mask of the bits used in the frame
    configBitRanges : List[int]
        A list of config bit mapping values
    """

    frameIndex: int
    frameName: str
    bitsUsedInFrame: int
    usedBitMask: str
    configBitRanges: list[int] = field(default_factory=list)


@dataclass
class ConfigurationMemory:
    configMappings: Mapping[int, tuple[int, int]] = field(default_factory=dict)
    configMemEntries: list[ConfigMemFrame] = field(default_factory=list)

    def __post_init__(self):
        self.configMemEntries.sort()

    def __getitem__(self, key) -> tuple[int, int]:
        if isinstance(key, int):
            if key in self.configMappings:
                return self.configMappings[key]
            else:
                raise KeyError(f"Key {key} does not exist in the configuration memory")
        else:
            raise KeyError(f"Key {key} is not an int")
