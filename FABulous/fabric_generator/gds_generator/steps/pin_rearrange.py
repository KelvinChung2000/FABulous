import re
import sys
from pathlib import Path

import numpy as np


# calalate the distance between 2 point
def distanceCal(x1: int, y1: int, x2: int, y2: int) -> int:
    return abs(x1 - x2) + abs(y1 - y2)


def orientation(p: tuple[int, int], q: tuple[int, int], r: tuple[int, int]) -> int:
    # return 0/1/-1 for colinear/clockwise/counterclockwise
    val = ((q[1] - p[1]) * (r[0] - q[0])) - ((q[0] - p[0]) * (r[1] - q[1]))
    if val == 0:
        return 0
    return 1 if val > 0 else -1


def intersects(
    p1: tuple[int, int], q1: tuple[int, int], p2: tuple[int, int], q2: tuple[int, int]
) -> bool:
    # find all orientations
    o1 = orientation(p1, q1, p2)
    o2 = orientation(p1, q1, q2)
    o3 = orientation(p2, q2, p1)
    o4 = orientation(p2, q2, q1)
    # check general case
    return bool(o1 != o2 and o3 != o4)


# find the angle between the two vectors
def angleBetween(v1: np.ndarray, v2: np.ndarray) -> float:
    uv1 = v1 / np.linalg.norm(v1)
    uv2 = v2 / np.linalg.norm(v2)
    dot_product = np.dot(uv1, uv2)
    return np.arccos(dot_product)


class placementRearrange:
    defFile = ""
    synthesisFile = ""
    openLaneDir = ""
    allBuffer = []
    allitemsDict = {}
    allNets = {}
    allPin = {}
    connetPair = {}

    def __init__(
        self,
        defFile: str,
        synthesisFile: str,
        openlaneDir: str,
        test: dict[str, str],
        pairPin: dict[str, str],
    ) -> None:
        self.defFile = defFile
        self.synthesisFile = synthesisFile
        self.openLaneDir = openlaneDir
        self.connetPair = pairPin
        with Path(self.defFile).open() as f:
            temp = f.readlines()

        for line in temp:
            # find all the line with patten "- [name] ... PLACED ( [X] [Y] )"
            if "PLACED" in line and (
                re.search(r"- (.*) \w+ \+ PLACED \( (\d+) (\d+) \)", line)
            ):
                data = re.search(r"- (.*) \w+ \+ PLACED \( (\d+) (\d+) \)", line)
                item = {}
                item["X"] = int(data.group(2))
                item["Y"] = int(data.group(3))
                if "+" in data.group(1):
                    self.allitemsDict[str(data.group(1).split(" ")[0])] = item
                else:
                    self.allitemsDict[data.group(1)] = item
            # look for the cordinate of the pin by looking at the FIXED keyword
            # and store the name of the item and the coordinate of it to the dictionary
            if "FIXED" in line and (
                re.search(r"- (.*) \w+ \+ FIXED \( (\d+) (\d+) \)", line)
            ):
                data = re.search(r"- (.*) \w+ \+ FIXED \( (\d+) (\d+) \)", line)
                item = {}
                item["X"] = int(data.group(2))
                item["Y"] = int(data.group(3))
                if "+" in data.group(1):
                    self.allitemsDict[str(data.group(1).split(" ")[0])] = item
                else:
                    self.allitemsDict[data.group(1)] = item
        # reset reader
        with Path(self.defFile).open() as f:
            data = f.read()
        # find the line with patten "- ... + ROUTED ;"
        nets = re.findall(r"- (.*?)  \+ ROUTED", data, re.DOTALL)[1:]
        nets.pop(0)  # TODO here because vssd1
        for i in nets:
            item = i.split("\n")
            name = re.search(r"(\S+)", item[0]).group(0)
            item = re.findall(r"\( (\S+ \S+) \)", item[0])
            self.allNets[name] = []
            for line in item:
                # get the name of the module
                if "PIN" in line:
                    self.allNets[name].append(f"{name}")
                elif re.search(r"\S+", line):
                    self.allNets[name].append(re.search(r"(\S+)", line).group(0))
        # reset reader
        with Path(self.defFile).open() as f:
            data = f.read()
        # find all the item with patterm "- name ... \n ... ( X Y )"
        # and store all the pin data
        pinsPlacement = re.findall(
            r"- (\w+\[*\d*\]*).*?\n.*?\n.*?\n *\+ .*?\( (\d+) (\d+) \) .*? ;", data
        )

        for name, x, y in pinsPlacement:
            if name != "vssd1":
                item = {}
                item["X"] = int(x)
                item["Y"] = int(y)
                self.allPin[name] = item

        # classify which side the pin should be located
        for pin in self.allPin:
            name = re.sub(r"\[\d+\]", "", pin)
            self.allPin[pin]["side"] = test[name]

        # read the synthesisFile for placing buffer, but not in use right now
        # this is still needed for update the target netlist
        with Path(self.synthesisFile).open() as f:
            for line in f:
                if "sky130_fd_sc_hd__buf" in line and (
                    re.search(r".*sky130_fd_sc_hd__buf.* (\w+)", line)
                ):  # sky130_fd_sc_hd__buf_1 aswell?
                    buf = re.search(r".*sky130_fd_sc_hd__buf.* (\w+)", line)
                    if buf:
                        self.allBuffer.append(buf.group(1))

    def reset(self) -> None:
        self.allBuffer.clear()
        self.allitemsDict.clear()
        self.allNets.clear()
        self.allPin.clear()
        self.connetPair.clear()

    def arrangePinPlacement(self, noConnection: set[str]) -> list[tuple[str, str, str]]:
        # get all the nets that connect to a pin
        netsToPin = [n for n in self.allNets.items() if n[0] in self.allPin]
        connectionCord = {}
        for p, items in netsToPin:
            cod = []
            for i in items:
                if i not in self.allPin:
                    cod.append((self.allitemsDict[i]["X"], self.allitemsDict[i]["Y"]))
            connectionCord[p] = cod
        # sort the connection pin by the coordinate of the pin
        # for pin at top/bottom is sort by x and pin on the side are sort by y
        for i in connectionCord:
            if self.allPin[i]["side"] == "Top" or self.allPin[i]["side"] == "Bottom":
                connectionCord[i] = sorted(connectionCord[i], key=lambda x: x[0])
            else:
                connectionCord[i] = sorted(connectionCord[i], key=lambda x: x[1])

        swapTable = []
        # for each of the pin find the distace between the pin and all other possible connections
        for p in self.allPin:
            if p not in {"UserCLK", "UserCLKo", "NULL"} and p not in noConnection:
                pairPin = self.connetPair[p]
                if pairPin == "NULL":
                    continue
                minDist = sys.maxsize
                minPair = None
                for i in connectionCord:
                    # if the pin is the same pin, the pin do not share the same side or the pin is the UserCLK continue the loop
                    if (
                        i in {"UserCLK", "UserCLKo", "NULL"}
                        or self.allPin[i]["side"] != self.allPin[p]["side"]
                        or i in noConnection
                    ):
                        continue
                    if p == i:
                        continue
                    # since pin need to move in pair so the distance of the pin itself as well as it pair pin distance need to be calculate
                    d1 = distanceCal(
                        connectionCord[i][0][0],
                        connectionCord[i][0][1],
                        self.allPin[p]["X"],
                        self.allPin[p]["Y"],
                    )
                    d2 = distanceCal(
                        connectionCord[self.connetPair[i]][0][0],
                        connectionCord[self.connetPair[i]][0][1],
                        self.allPin[pairPin]["X"],
                        self.allPin[pairPin]["Y"],
                    )
                    # if the sum of the distances is less than the current best replace it with the current best
                    if d1 + d2 < minDist:
                        minDist = d1 + d2
                        minPair = (p, i, self.allPin[p]["side"])

                # update the information in the connectionCord after all min pair found
                if minPair is not None:
                    temp = connectionCord[minPair[0]]
                    connectionCord[minPair[0]] = connectionCord[minPair[1]]
                    connectionCord[minPair[1]] = temp

                    temp = connectionCord[self.connetPair[minPair[0]]]
                    connectionCord[self.connetPair[minPair[0]]] = connectionCord[
                        self.connetPair[minPair[1]]
                    ]
                    connectionCord[self.connetPair[minPair[1]]] = temp

                    swapTable.append(minPair)
                    swapTable.append(
                        (
                            self.connetPair[minPair[0]],
                            self.connetPair[minPair[1]],
                            self.allPin[self.connetPair[minPair[1]]]["side"],
                        )
                    )
        return swapTable

    def arrangePinLayer(
        self, swapTable: list[tuple[str, str, str]]
    ) -> dict[int, list[str]]:
        # setting up the dictionary for arrange the pin pair
        pinOnLayer = {}
        connetOnLayer = {}
        for i in range(2, 4):  # TODO implement for multiple layers
            pinOnLayer[i] = []
            connetOnLayer[i] = []

        # apply the pin swap before assinging pin
        swapped = dict(self.allPin)
        for a, b, _ in swapTable:
            temp = swapped[a]
            swapped[a] = swapped[b]
            swapped[b] = temp

        # gather all the item that is connected to the pin and record the coordinate of those item
        # TODO implement for multiple layers (currently problems assigning multiple layers to IO layers for sky130)
        for p in swapped:
            if swapped[p]["side"] in ["Top", "Bottom"]:
                pinOnLayer[2].append(p)
            elif swapped[p]["side"] in ["Right", "Left"]:
                pinOnLayer[3].append(p)
        return pinOnLayer
