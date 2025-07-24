import re
from pathlib import Path
from typing import Literal, overload

from FABulous.custom_exception import (
    InvalidListFileDefinition,
    InvalidPortType,
    InvalidSwitchMatrixDefinition,
)
from FABulous.fabric_definition.define import IO, Direction, Side
from FABulous.fabric_definition.Port import Port
from FABulous.fabric_generator.utilities import expandListPorts

oppositeDic = {"NORTH": "SOUTH", "SOUTH": "NORTH", "EAST": "WEST", "WEST": "EAST"}


def parseMatrix(fileName: Path, tileName: str) -> dict[str, list[str]]:
    """Parse the matrix CSV into a dictionary from destination to source.

    Parameters
    ----------
    fileName : Path
        Directory of the matrix CSV file.
    tileName : str
        Name of the tile needed to be parsed.

    Raises
    ------
    ValueError
        Non matching matrix file content and tile name

    Returns
    -------
    dict : [str, list[str]]
        Dictionary from destination to a list of sources.
    """

    connectionsDic = {}
    with open(fileName) as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)
        file = file.split("\n")

    if file[0].split(",")[0] != tileName:
        raise InvalidSwitchMatrixDefinition(
            f"{fileName} {file[0].split(',')} {tileName}\n"
            f"Tile name (top left element) in csv file does not match tile name in tile object"
        )
    destList = file[0].split(",")[1:]

    for i in file[1:]:
        i = i.split(",")
        portName, connections = i[0], i[1:]
        if portName == "":
            continue
        indices = [k for k, v in enumerate(connections) if v == "1"]
        connectionsDic[portName] = [destList[j] for j in indices]
    return connectionsDic


@overload
def parseList(
    filePath: Path, collect: Literal["pair"] = "pair", prefix: str = ""
) -> list[tuple[str, str]]:
    pass


@overload
def parseList(
    filePath: Path, collect: Literal["source", "sink"], prefix: str = ""
) -> dict[str, list[str]]:
    pass


def parseList(
    filePath: Path,
    collect: Literal["pair", "source", "sink"] = "pair",
    prefix: str = "",
) -> list[tuple[str, str]] | dict[str, list[str]]:
    """Parse a list file and expand the list file information into a list of tuples.

    Parameters
    ----------
    fileName : Path
        ""
    collect : (Literal["", "source", "sink"], optional)
        Collect value by source, sink or just as pair. Defaults to "pair".

    Raises
    ------
    ValueError
        The file does not exist.
    ValueError
        Invalid format in the list file.

    Returns
    -------
    Union : [list[tuple[str, str]], dict[str, list[str]]]
        Return either a list of connection pairs or a dictionary of lists which is collected by the specified option, source or sink.
    """
    if not filePath.exists():
        raise FileNotFoundError(f"The file {filePath} does not exist.")

    resultList = []
    with open(filePath) as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)
    file = file.split("\n")
    for i, line in enumerate(file):
        line = line.replace(" ", "").replace("\t", "").split(",")
        line = [i for i in line if i != ""]
        if not line:
            continue
        if len(line) != 2:
            raise InvalidListFileDefinition(
                f"Invalid list formatting in file: {filePath} at line {i}: {line}"
            )
        left, right = line[0], line[1]

        if left == "INCLUDE":
            resultList.extend(parseList(filePath.parent.joinpath(right), "pair"))
            continue

        leftList = []
        rightList = []
        expandListPorts(left, leftList)
        expandListPorts(right, rightList)
        if len(leftList) != len(rightList):
            raise InvalidListFileDefinition(
                f"List file {filePath} does not have the same number of source and sink ports at line {i}: {line}"
            )
        resultList += list(zip(leftList, rightList, strict=False))

    result = list(dict.fromkeys(resultList))
    resultDic = {}
    if collect == "source":
        for k, v in result:
            if k not in resultDic:
                resultDic[k] = []
            resultDic[k].append(v)
        return resultDic

    if collect == "sink":
        for k, v in result:
            for i in v:
                if i not in resultDic:
                    resultDic[i] = []
                resultDic[i].append(k)
        return resultDic

    return result


def parsePortLine(line: str) -> tuple[list[Port], tuple[str, str] | None]:
    ports = []
    commonWirePair: tuple[str, str] | None
    temp: list[str] = line.split(",")
    if temp[0] in ["NORTH", "SOUTH", "EAST", "WEST"]:
        ports.append(
            Port(
                Direction[temp[0]],
                temp[1],
                int(temp[2]),
                int(temp[3]),
                temp[4],
                int(temp[5]),
                temp[1],
                IO.OUTPUT,
                Side[temp[0]],
            )
        )

        ports.append(
            Port(
                Direction[temp[0]],
                temp[1],
                int(temp[2]),
                int(temp[3]),
                temp[4],
                int(temp[5]),
                temp[4],
                IO.INPUT,
                Side[oppositeDic[temp[0]].upper()],
            )
        )
        commonWirePair = (f"{temp[1]}", f"{temp[4]}")

    elif temp[0] == "JUMP":
        ports.append(
            Port(
                Direction.JUMP,
                temp[1],
                int(temp[2]),
                int(temp[3]),
                temp[4],
                int(temp[5]),
                temp[1],
                IO.OUTPUT,
                Side.ANY,
            )
        )
        ports.append(
            Port(
                Direction.JUMP,
                temp[1],
                int(temp[2]),
                int(temp[3]),
                temp[4],
                int(temp[5]),
                temp[4],
                IO.INPUT,
                Side.ANY,
            )
        )
        commonWirePair = None
    else:
        raise InvalidPortType(f"Unknown port type: {temp[0]}")
    return (ports, commonWirePair)
