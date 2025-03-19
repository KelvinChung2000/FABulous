from dataclasses import dataclass
from typing import Mapping

from FABulous.fabric_definition.define import Loc

FrameIdx = int
BitIdx = int


@dataclass(slots=True, frozen=True)
class FeatureValue:
    tileLoc: Loc
    bitPosition: tuple[tuple[FrameIdx, BitIdx], ...] | tuple[tuple[None, None]]
    value: int | None


@dataclass
class FASMFeature:
    feature: str | None
    address: tuple[int, int] | None
    value: int | None
    annotation: dict[str, str] | None


FeatureMap = Mapping[str, FeatureValue]
