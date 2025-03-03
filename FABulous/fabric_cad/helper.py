from pathlib import Path
from typing import Iterable


def mergeFiles(inputFiles: Iterable[Path], outputFile: Path):
    """Merge multiple files into one file.

    Parameters
    ----------
    inputFiles : list of str
        List of input file paths to be merged.
    outputFile : str
        Path of the output file.
    """
    with outputFile.open("w") as outfile:
        for file in inputFiles:
            inputPath = Path(file)
            if inputPath.is_file():
                with inputPath.open("r") as inFile:
                    content = inFile.read()
                    outfile.write(content)
                    outfile.write("\n")
                # inputPath.unlink()
