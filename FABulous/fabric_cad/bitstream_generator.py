from pathlib import Path
from FABulous.fabric_cad.define import FASMFeature, FeatureMap
from FABulous.file_parser.file_parser_fasm import parseFASM


def genBitstream(fasmFile: Path, featureMap: FeatureMap, dest: Path):
    fasm: list[FASMFeature] = parseFASM(fasmFile)
