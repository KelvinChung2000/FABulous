# TODO correct config bitsize CELL_NUM logic
import csv
import datetime
import logging
import re
from pathlib import Path
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from matplotlib.axes import Axes

import matplotlib.pyplot as plt
import numpy as np
from ortools.linear_solver import pywraplp

logger = logging.getLogger(__name__)
logging.basicConfig(
    format="[%(levelname)s]-%(asctime)s - %(message)s", level=logging.INFO
)


# calalate the distance between 2 point
def distanceCal(x1: int, y1: int, x2: int, y2: int) -> int:
    return abs(x1 - x2) + abs(y1 - y2)


# toggle the kth bit of n
def toggleBit(n: int, k: int) -> int:
    return n ^ (1 << k)


# find the angle between the two vectors
def angleBetween(v1: np.ndarray, v2: np.ndarray) -> float:
    uv1 = v1 / np.linalg.norm(v1)
    uv2 = v2 / np.linalg.norm(v2)
    dot_product = np.dot(uv1, uv2)
    return np.arccos(dot_product)


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


class netListRearrange:
    TARGET_COMP = "sky130_fd_sc_hd__dlxtp_1"  # "sky130_fd_sc_hd__dlxbp_1"
    TARGET_MODULE = ""
    FRAME_DATA_SIZE = 0
    FRAME_STROBE_SIZE = 0
    SINGAL = []
    synthesisFile = ""
    defFile = ""
    placement = {}
    connect = {}
    connectPort = {}

    def __init__(
        self, defFile: str, synthesisFile: str, fabTileConfigMemPath: str
    ) -> None:
        self.defFile = defFile
        self.synthesisFile = synthesisFile
        self.TARGET_MODULE = fabTileConfigMemPath
        with Path(self.defFile).open() as f:
            temp = f.readlines()

        for line in temp:
            # get the coordinate from the phrase, PLACED ( X Y )
            match = re.search(r"PLACED \( (\d+) (\d+) \)", line)
            if self.TARGET_COMP in line and match:
                placeCod = match
                memUnit = {}
                memUnit["X"] = int(placeCod.group(1))
                memUnit["Y"] = int(placeCod.group(2))
                # getting the last back slash item as the name of the item
                name_match = re.search(rf"- (.*) {self.TARGET_COMP}", line)
                if name_match:
                    self.placement[name_match.group(1)] = memUnit

        # reset reader
        with Path(self.defFile).open() as f:
            data = f.read()
        # finding the parameter in the .def file
        # get the max digit from the phrase, FrameData[X], FrameStrobe[X]
        # and ConfigBits[X], and X+1 will be the corresponding
        # to the size of that variable
        self.FRAME_DATA_SIZE = (
            int(max(re.findall(r"FrameData\[(\d+)\]", data), key=lambda x: int(x))) + 1
        )
        self.FRAME_STROBE_SIZE = (
            int(max(re.findall(r"FrameStrobe\[(\d+)\]", data), key=lambda x: int(x)))
            + 1
        )

        name = list(self.placement.keys())[0]
        # using one of the name in the
        self.SINGAL = re.findall(rf"[\(\*] {name} (\w+) [\)\*]", data)
        logger.info("Frame Data size: %s", self.FRAME_DATA_SIZE)
        logger.info("Frame Strobe size: %s", self.FRAME_STROBE_SIZE)

        with Path(self.synthesisFile).open() as f:
            data = f.read()
        # gather data from the from the synthesis file
        for e in self.placement:
            # find the code block that contains the information
            # the amount of line get is the same as the amount of
            # input identify from the def file
            s = e + ".*" + "\n\\s*(.*)," * (len(self.SINGAL) - 1) + "\n\\s*(.*)"
            result = re.search(re.compile(s), data)
            if result:
                connetData = {}
                # matching the result with the SINGAL and put data
                # into dictionary
                for i in range(1, len(self.SINGAL) + 1):
                    for j in self.SINGAL:
                        if str(result.group(i)).startswith("." + j + "("):
                            idx_match = re.search(r"\[(\d+)\]", str(result.group(i)))
                            if idx_match:
                                connetData[j] = int(idx_match.group(1))
        for i in self.SINGAL:
            # search the for the pattern .SINGAL(X[d]) to determine
            # the connection pair
            result = re.search(rf"\.{i}\((.*)\[.*\]\s*\)", data)
            if result:
                self.connectPort[str(result.group(1))] = i
                self.connectPort[i] = str(result.group(1))
            else:
                pass

    def reset(self) -> None:
        self.TARGET_COMP = "sky130_fd_sc_hd__dlxtp_1"  # "sky130_fd_sc_hd__dlxbp_1"
        self.SINGAL.clear()
        self.placement.clear()
        self.connect.clear()
        self.connectPort.clear()

    # the ploting is inaccurate and this is just a rough approximation
    # since finding the shortest path to connect all the node is NP-hard
    # this is approximated by connecting wire with the least different in X
    def plotFrameData(self, ax: "Axes") -> None:
        # plot all the node on to the graph
        x = [int(x["X"]) / 1000 for _, x in self.placement.items()]
        y = [int(y["Y"]) / 1000 for _, y in self.placement.items()]

        ax.scatter(x, y, color="k", marker=".")

        # group the node together that share the same wire
        values = set(
            map(lambda x: x[1][self.connectPort["FrameData"]], self.connect.items())
        )
        wires = [
            [
                y[0]
                for y in self.connect.items()
                if y[1][self.connectPort["FrameData"]] == x
            ]
            for x in values
        ]
        for _i in wires:
            x = []
            y = []
            # for each of the wire sort them in the x diredtion
            pointList = sorted(
                [(self.placement[p]["X"], self.placement[p]["Y"]) for p in _i],
                key=lambda x: x[0],
            )
            # and plot the point
            for px, py in pointList:
                x.append(px / 1000)
                y.append(py / 1000)
            ax.plot(x, y, linewidth=0.7)

    # for the same reason this is approximated by connecting wire with
    # the least difference in Y
    def plotFrameStrobe(self, ax: "Axes") -> None:
        # plot all the node on to the graph
        x = [int(x[1]["X"]) / 1000 for x in self.placement.items()]
        y = [int(y[1]["Y"]) / 1000 for y in self.placement.items()]

        ax.scatter(x, y, color="k", marker=".")

        # group the node together that share the same wire
        values = set(
            map(lambda x: x[1][self.connectPort["FrameStrobe"]], self.connect.items())
        )
        wires = [
            [
                y[0]
                for y in self.connect.items()
                if y[1][self.connectPort["FrameStrobe"]] == x
            ]
            for x in values
        ]
        for _i in wires:
            x = []
            y = []
            # for each of the wire sort them in the y diredtion
            pointList = sorted(
                [(self.placement[p]["X"], self.placement[p]["Y"]) for p in _i],
                key=lambda x: x[1],
            )
            # and plot the point
            for px, py in pointList:
                x.append(px / 1000)
                y.append(py / 1000)
            ax.plot(x, y, linewidth=0.7)

    # the calculation of the length of the wire is approximated
    # the following method is just calculate the wire length with minmal difference
    # in x for the D wire and in y for the GATE wire
    def wireLength(self) -> None:
        # group the node together that share the same wire (FrameData)
        valuesD = set(
            map(lambda x: x[1][self.connectPort["FrameData"]], self.connect.items())
        )
        wiresD = [
            (
                x,
                [
                    y[0]
                    for y in self.connect.items()
                    if y[1][self.connectPort["FrameData"]] == x
                ],
            )
            for x in valuesD
        ]

        total_lenD = 0
        for _i, data in wiresD:
            leng = 0
            # sort the node in respect to the Y coordinate
            pointList = sorted(
                [(self.placement[p]["X"], self.placement[p]["Y"]) for p in data],
                key=lambda x: x[1],
            )

            # calculate the length of the wire
            for point in range(len(pointList) - 1):
                leng += distanceCal(
                    pointList[point][0],
                    pointList[point][1],
                    pointList[point + 1][0],
                    pointList[point + 1][1],
                )
            total_lenD += leng

        # group the node together that share the same wire (FrameStrobe)
        valuesGATE = set(
            map(lambda x: x[1][self.connectPort["FrameStrobe"]], self.connect.items())
        )
        wiresGATE = [
            (
                x,
                [
                    y[0]
                    for y in self.connect.items()
                    if y[1][self.connectPort["FrameStrobe"]] == x
                ],
            )
            for x in valuesGATE
        ]
        total_lenGATE = 0
        for _i, data in wiresGATE:
            leng = 0
            # sort the node in respect to the X coordinate
            pointList = sorted(
                [(self.placement[p]["X"], self.placement[p]["Y"]) for p in data],
                key=lambda x: x[0],
            )

            # calculate the length of the wire
            for point in range(len(pointList) - 1):
                leng += distanceCal(
                    pointList[point][0],
                    pointList[point][1],
                    pointList[point + 1][0],
                    pointList[point + 1][1],
                )
            total_lenGATE += leng

        logger.info("%s total length: %s", self.connectPort["FrameData"], total_lenD)
        logger.info(
            "%s total length: %s", self.connectPort["FrameStrobe"], total_lenGATE
        )

    # the following is copping the tutorial of the google OR tools to do the implementation
    # https://developers.google.com/optimization/assignment/assignment_example
    # minor modification is made so that it apply to the situation
    # the cost matrix is the distance of how far each node is away from a grid point
    def ConfigBitoptimizationWithAssignment(self) -> None:
        # it first find the max width and the height of the placement
        XValues = [v["X"] for _, v in self.placement.items()]
        minX = min(XValues)
        maxX = max(XValues)
        YValues = [v["Y"] for _, v in self.placement.items()]
        minY = min(YValues)
        maxY = max(YValues)

        # calculate the distrbution of the frame data wire and the frame strobe wire
        spacingX = int((maxX - minX) / self.FRAME_STROBE_SIZE)
        spacingY = int((maxY - minY) / self.FRAME_DATA_SIZE)

        costs = []
        for x in range(minX, maxX, spacingX):
            for y in range(minY, maxY, spacingY):
                n = []
                for _, v in self.placement.items():
                    n.append(distanceCal(v["X"], v["Y"], x, y))
                costs.append(n)
        num_node = len(costs[0])
        num_coordinate = len(costs)

        # Solver
        # Create the mip solver with the SCIP backend.
        solver = pywraplp.Solver.CreateSolver("SCIP")

        # Variables
        # x[i, j] is an array of 0-1 variables, which will be 1
        # if coordinate i is assigned to node j.
        x = {}
        for i in range(num_coordinate):
            for j in range(num_node):
                x[i, j] = solver.IntVar(0, 1, "")

        # Constraints
        # Each coordinate is assigned to at most 1 node.
        for i in range(num_coordinate):
            solver.Add(solver.Sum([x[i, j] for j in range(num_node)]) <= 1)

        # Each node is assigned to exactly one coordinate.
        for j in range(num_node):
            solver.Add(solver.Sum([x[i, j] for i in range(num_coordinate)]) == 1)

        # Objective
        objective_terms = []
        for i in range(num_coordinate):
            for j in range(num_node):
                objective_terms.append(costs[i][j] * x[i, j])
        solver.Minimize(solver.Sum(objective_terms))

        # Solve
        status = solver.Solve()

        wireTable = np.array(
            [
                [None for _ in range(self.FRAME_DATA_SIZE)]
                for _ in range(self.FRAME_STROBE_SIZE)
            ]
        )
        numberedNode = list(self.placement.items())

        # put data into wire table
        if status == pywraplp.Solver.OPTIMAL or status == pywraplp.Solver.FEASIBLE:
            for i in range(num_coordinate):
                for j in range(num_node):
                    # Test if x[i,j] is 1 (with tolerance for floating point arithmetic).
                    if x[i, j].solution_value() > 0.5:
                        strobe = int(i / self.FRAME_DATA_SIZE) - 1
                        data = i % self.FRAME_DATA_SIZE
                        wireTable[strobe, data] = numberedNode[j][0]

        # transfer the allocation data into the connect variable
        for i, v in enumerate(wireTable):
            for j, v2 in enumerate(v):
                if v2 is not None:
                    self.connect[v2][self.connectPort["FrameStrobe"]] = i
                    self.connect[v2][self.connectPort["FrameData"]] = j

        # testing to ensure the allocation is correct
        assert (
            len(
                set(
                    map(
                        lambda x: x[1][self.connectPort["FrameData"]],
                        self.connect.items(),
                    )
                )
            )
            <= self.FRAME_DATA_SIZE
        )
        assert (
            len(
                set(
                    map(
                        lambda x: x[1][self.connectPort["FrameStrobe"]],
                        self.connect.items(),
                    )
                )
            )
            <= self.FRAME_STROBE_SIZE
        )

    # rewriting the synthesized configured file
    def rewire_tile_netlist(self) -> None:
        # set up the reader and writer
        with Path(self.synthesisFile).open() as f:
            data = f.readlines()

        out_path = (
            Path(f"{self.synthesisFile[:-2]}.opt{self.synthesisFile[-2:]}")
            if "opt" not in self.synthesisFile
            else Path(self.synthesisFile)
        )
        with out_path.open("w") as writer:
            # add a timestemp for reference
            writer.write(f"/* Optimized on {datetime.datetime.now()} */\n")

            # find out what are lines that I need to change
            lineToChange = []
            for i, line in enumerate(data):
                if self.TARGET_COMP in line:
                    lineToChange.append(i)
                    lineToChange.append(i + 1)
                    lineToChange.append(i + 2)

            TARGET_COMP = ""
            found = False
            for i in range(len(data)):
                # if the line no need to change skip it
                if "Optimized on" in data[i]:
                    continue
                if i not in lineToChange:
                    writer.write(data[i])
                    continue
                # get the name of the item that need to be change
                if self.TARGET_COMP in data[i]:
                    TARGET_COMP = data[i].split(" ")[3]
                    if "." in TARGET_COMP:
                        TARGET_COMP = TARGET_COMP.split(".")[-1]
                    writer.write(data[i])
                    found = True
                    continue
                # update the field according to the information in connect
                if f".{self.connectPort['FrameData']}(" in data[i] and found:
                    s = str(self.connect[TARGET_COMP][self.connectPort["FrameData"]])
                    result = re.sub(r"\((.*?)\)", f"(FrameData[{s}])", data[i])
                    writer.write(result)
                    continue
                if f".{self.connectPort['FrameStrobe']}(" in data[i] and found:
                    s = str(self.connect[TARGET_COMP][self.connectPort["FrameStrobe"]])
                    result = re.sub(r"\((.*?)\)", f"(FrameStrobe[{s}])", data[i])
                    writer.write(result)
                    continue
                found = False

    def rewire_FABulous_model(self) -> None:
        header = [
            "#frame_name",
            "frame_index",
            "bits_used_in_frame",
            "used_bits_mask",
            "ConfigBits_ranges",
        ]
        CombineData = []
        # grouping the node together by the strobe wire
        values = set(
            map(lambda x: x[1][self.connectPort["FrameStrobe"]], self.connect.items())
        )
        strobeWire = [
            [
                y
                for y in self.connect.items()
                if y[1][self.connectPort["FrameStrobe"]] == x
            ]
            for x in values
        ]

        for wire in strobeWire:
            entry = []
            # get the name and the index of the strobe wire
            frame_name = f"Frame{wire[0][1][self.connectPort['FrameStrobe']]}"
            frame_index = wire[0][1][self.connectPort["FrameStrobe"]]

            ConfigBits_ranges = []
            bits_used_in_frame = 0
            # toggle each of the connection point in the bits_used_in_frame
            for _, data in wire:
                ConfigBits_ranges.append(str(data["Q"]))
                bits_used_in_frame = toggleBit(
                    bits_used_in_frame, data[self.connectPort["FrameData"]]
                )

            # adding the data as a single entry
            # set frame_name
            entry.append(frame_name)
            # set frame_index
            entry.append(frame_index)
            # set bits_used_in_frame
            line = format(bits_used_in_frame, "032b")
            line = [line[i : i + 4] for i in range(0, len(line), 4)]
            entry.append("_".join(line))
            # set used_bits_mask
            entry.append("32:0")
            # set ConfigBits_ranges
            for c in ConfigBits_ranges:
                entry.append(c)

            # add to data set
            CombineData.append(entry)

        # check is the output correct
        count = 0
        for i in CombineData:
            count += i[2].count("1")

        # write the result to csv
        with Path(f"{self.TARGET_MODULE}.opt.csv").open(
            "w", encoding="UTF8", newline=""
        ) as f:
            writer = csv.writer(f)
            writer.writerow(header)
            writer.writerows(CombineData)

    def plotIteration(self, plotPath: str) -> None:
        fig, axs = plt.subplots(2, 2, constrained_layout=True)
        axs[0][0].set_title("Frame Data")
        self.plotFrameData(axs[0][0])
        axs[0][1].set_title("Frame Strobe")
        self.plotFrameStrobe(axs[0][1])
        plt.savefig(f"{plotPath}.pdf", format="pdf", dpi=300)

    def run(self) -> None:
        # before
        fig, axs = plt.subplots(2, 2, constrained_layout=True)
        axs[0, 0].set_title("Frame Data Before")
        self.plotFrameData(axs[0, 0])
        axs[1, 0].set_title("Frame Strobe Before")
        self.plotFrameStrobe(axs[1, 0])

        self.ConfigBitoptimizationWithAssignment()

        # after
        axs[0, 1].set_title("Frame Data After")
        self.plotFrameData(axs[0, 1])
        axs[1, 1].set_title("Frame Strobe After")
        self.plotFrameStrobe(axs[1, 1])

        self.wireLength()

        plt.savefig("netlist_optimize_effect.pdf", format="pdf", dpi=300)
        plt.show()
