from dataclasses import dataclass
from typing import Mapping

from FABulous.fabric_definition.define import Loc

FrameIdx = int
BitIdx = int


@dataclass(slots=True)
class FeatureValue:
    tileLoc: Loc
    bitPosition: list[tuple[FrameIdx, BitIdx] | tuple[None, None]]
    value: int


@dataclass
class FASMFeature:
    feature: str | None
    address: tuple[int, int] | None
    value: int | None
    annotation: dict[str, str] | None


FeatureMap = Mapping[str, FeatureValue]
