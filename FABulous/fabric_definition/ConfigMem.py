from collections import namedtuple
from dataclasses import dataclass, field

ConfigBitMapping = namedtuple(
    "ConfigBitMapping", ["configBitNumber", "frameIndex", "frameBitIndex"]
)


@dataclass
class ConfigMem:
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

    frameName: str
    frameIndex: int
    bitsUsedInFrame: int
    usedBitMask: str
    configBitRanges: list[int] = field(default_factory=list)


@dataclass
class ConfigurationMemory:
    configMappings: list[ConfigBitMapping] = field(default_factory=list)
    configMemEntries: list[ConfigMem] = field(default_factory=list)

    def __getitems__(self, key) -> int:
        if isinstance(key, tuple):
            for i in self.configMappings:
                if i.configBitNumber == key[0] and i.frameIndex == key[1]:
                    return i.frameBitIndex
            raise KeyError(f"Key {key} does not exist in the configuration memory")
        else:
            raise KeyError(f"Key {key} is not a tuple")
