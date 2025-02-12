from dataclasses import dataclass


@dataclass(slots=True)
class FeatureValue:
    bitPosition: tuple[int, int]
    value: int


@dataclass
class FASMFeature:
    feature: str | None
    address: tuple[int, int] | None
    value: int | None
    annotation: dict[str, str] | None
