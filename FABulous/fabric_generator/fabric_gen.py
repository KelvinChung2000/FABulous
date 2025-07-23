# Copyright 2021 University of Manchester
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0


import csv
import math
import os
import re
import string
from collections import defaultdict
from pathlib import Path
from typing import TYPE_CHECKING

from loguru import logger

from FABulous.custom_exception import InvalidFileType
from FABulous.fabric_definition.define import (
    IO,
    ConfigBitMode,
    Direction,
    MultiplexerStyle,
)
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.SuperTile import SuperTile
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_generator.code_generation_Verilog import VerilogWriter
from FABulous.fabric_generator.code_generation_VHDL import VHDLWriter
from FABulous.fabric_generator.code_generator import codeGenerator
from FABulous.fabric_generator.file_parser import (
    parseBelFile,
    parseList,
    parseMatrix,
)
from FABulous.fabric_generator.parser.parse_configmem import parseConfigMem

if TYPE_CHECKING:
    from FABulous.fabric_definition.ConfigMem import ConfigMem


class FabricGenerator:
    """This class contains all the functionality required to generate the fabric as an
    RTL file from CSV files. To use the class, the information will need to be parsed
    first using the function from file_parser.py.

    Attributes
    ----------
    fabric : Fabric
        The fabric object parsed from CSV definition files
    writer : codeGenerator
        The code generator object to write the RTL files
    """

    fabric: Fabric
    writer: codeGenerator

    def __init__(self, fabric: Fabric, writer: codeGenerator) -> None:
        self.fabric = fabric
        self.writer = writer
        # check if switch matrix debug signals should be generated, defaults to True
        sm_dbg = os.getenv("FAB_SWITCH_MATRIX_DEBUG_SIGNAL", "True")
        self.switch_matrix_debug_signal = (
            False if sm_dbg.lower().strip() == "false" else True
        )
        logger.info(
            f"Generate switch matrix debug signals: {self.switch_matrix_debug_signal}"
        )

    @staticmethod
    def bootstrapSwitchMatrix(tile: Tile, outputDir: Path) -> None:
        """Generates a blank switch matrix CSV file for the given tile. The top left
        corner will contain the name of the tile. Columns are the source signals and
        rows are the destination signals.

        The order of the signal will be:
        - standard wire
        - BEL signal with prefix
        - GEN_IO signals with prefix
        - jump wire

        The order is important as this order will be used during switch matrix generation.

        Parameters
        ----------
        tile : Tile
            The tile to generate the switch matrix for
        outputDir : str
            The output directory to write the switch matrix to
        """
        logger.info(f"Generate matrix csv for {tile.name} # filename: {outputDir}")
        with open(outputDir, "w") as f:
            writer = csv.writer(f)
            sourceName, destName = [], []
            # normal wire
            for i in tile.portsInfo:
                if i.wireDirection != Direction.JUMP:
                    input, output = i.expandPortInfo("AutoSwitchMatrix")
                    sourceName += input
                    destName += output
            # bel wire
            for b in tile.bels:
                for p in b.inputs:
                    sourceName.append(f"{p}")
                for p in b.outputs + b.externalOutput:
                    destName.append(f"{p}")

            # jump wire
            for i in tile.portsInfo:
                if i.wireDirection == Direction.JUMP:
                    input, output = i.expandPortInfo("AutoSwitchMatrix")
                    sourceName += input
                    destName += output
            sourceName = list(dict.fromkeys(sourceName))
            destName = list(dict.fromkeys(destName))
            writer.writerow([tile.name] + destName)
            for p in sourceName:
                writer.writerow([p] + [0] * len(destName))

    @staticmethod
    def list2CSV(InFileName: Path, OutFileName: Path) -> None:
        """This function is used to export a given list description into its equivalent
        CSV switch matrix description. A comment will be appended to the end of the
        column and row of the matrix, which will indicate the number of signals in a
        given row.

        Parameters
        ----------
        InFileName : str
            The input file name of the list file
        OutFileName : str
            The directory of the CSV file to be written

        Raises
        ------
        ValueError
            If the list file contains signals that are not in the matrix file
        """

        logger.info(f"Adding {InFileName} to {OutFileName}")

        connectionPair = parseList(InFileName)

        with open(OutFileName) as f:
            file = f.read()
            file = re.sub(r"#.*", "", file)
            file = file.split("\n")

        col = len(file[0].split(","))
        rows = len(file)

        # create a 0 zero matrix as initialization
        matrix = [[0 for _ in range(col)] for _ in range(rows)]

        # load the data from the original csv into the matrix
        for i in range(1, len(file)):
            for j in range(1, len(file[i].split(","))):
                value = file[i].split(",")[j]
                if value == "":
                    continue
                matrix[i - 1][j - 1] = int(value)

        # get source and destination list in the csv
        destination = file[0].strip("\n").split(",")[1:]
        source = [file[i].split(",")[0] for i in range(1, len(file))]

        # set the matrix value with the provided connection pair
        for s, d in connectionPair:
            try:
                s_index = source.index(s)
            except ValueError:
                logger.critical(
                    f"{s} is not in the source column of the matrix csv file"
                )
                exit(-1)

            try:
                d_index = destination.index(d)
            except ValueError:
                logger.critical(
                    f"{d} is not in the destination row of the matrix csv file"
                )
                exit(-1)

            if matrix[s_index][d_index] != 0:
                logger.warning(
                    f"Connection ({s}, {d}) already exists in the original matrix"
                )
            matrix[s_index][d_index] = 1

        # writing the matrix back to the given out file
        with open(OutFileName, "w") as f:
            f.write(file[0] + "\n")
            for i in range(len(source)):
                f.write(f"{source[i]},")
                for j in range(len(destination)):
                    f.write(str(matrix[i][j]))
                    if j != len(destination) - 1:
                        f.write(",")
                    else:
                        f.write(f",#,{matrix[i].count(1)}")
                f.write("\n")
            colCount = []
            for j in range(col):
                count = 0
                for i in range(rows):
                    if matrix[i][j] == 1:
                        count += 1
                colCount.append(str(count))
            f.write(f"#,{','.join(colCount)}")

    @staticmethod
    def CSV2list(InFileName: str, OutFileName: str) -> None:
        """This function is used to export a given CSV switch matrix description into
        its equivalent list description.

        Parameters
        ----------
        InFileName : str
            The input file name of the CSV file
        OutFileName : str
            The directory of the list file to be written
        """
        InFile = [i.strip("\n").split(",") for i in open(InFileName)]
        with open(OutFileName, "w") as f:
            # get the number of tiles in horizontal direction
            cols = len(InFile[0])
            # top-left should be the name
            _ = f.write(f"# {InFile[0][0]}\n")
            # switch matrix inputs
            inputs = []
            for item in InFile[0][1:]:
                inputs.append(item)
            # beginning from the second line, write out the list
            for line in InFile[1:]:
                for i in range(1, cols):
                    if line[i] != "0":
                        # it is [i-1] because the beginning of the line is the destination port
                        _ = f.write(f"{line[0]},{inputs[i - 1]}")
        return

    def genTileSwitchMatrix(self, tile: Tile) -> None:
        """This function will generate the RTL code for the tile switch matrix of the
        given tile. The switch matrix generated will be based on the `matrixDir`
        attribute of the tile. If the given file format is CSV, it will be parsed as a
        switch matrix CSV file. If the given file format is `.list`, the tool will
        convert the `.list` file into a switch matrix with specific ordering first
        before progressing. If the given file format is Verilog or VHDL, then the
        function will not generate anything.

        Parameters
        ----------
        tile : Tile
            A tile object.

        Raises
        ------
        ValueError
            If `matrixDir` does not contain a valid file format.
        """

        # convert the matrix to a dictionary map and performs entry check
        connections: dict[str, list[str]] = {}
        if tile.matrixDir.suffix == ".csv":
            connections = parseMatrix(tile.matrixDir, tile.name)
        elif tile.matrixDir.suffix == ".list":
            logger.info(f"{tile.name} matrix is a list file")
            logger.info(
                f"Bootstrapping {tile.name} to matrix form and adding the list file to the matrix"
            )
            matrixDir = tile.matrixDir.with_suffix(".csv")
            self.bootstrapSwitchMatrix(tile, matrixDir)
            self.list2CSV(tile.matrixDir, matrixDir)
            logger.info(
                f"Update matrix directory to {matrixDir} for Fabric Tile Dictionary"
            )
            tile.matrixDir = matrixDir
            connections = parseMatrix(tile.matrixDir, tile.name)
        elif tile.matrixDir.suffix == ".v" or tile.matrixDir.suffix == ".vhdl":
            logger.info(
                f"A switch matrix file is provided in {tile.name}, will skip the matrix generation process"
            )
            return
        else:
            raise InvalidFileType("Invalid matrix file format.")

        noConfigBits = 0
        for port_name in connections:
            if not connections[port_name]:
                raise ValueError(f"{port_name} not connected to anything!")
            mux_size = len(connections[port_name])
            if mux_size >= 2:
                noConfigBits += (mux_size - 1).bit_length()

        # we pass the NumberOfConfigBits as a comment in the beginning of the file.
        # This simplifies it to generate the configuration port only if needed later when building the fabric where we are only working with the VHDL files

        # Generate header
        self.writer.addComment(f"NumberOfConfigBits: {noConfigBits}")
        self.writer.addHeader(f"{tile.name}_switch_matrix")
        if noConfigBits > 0:
            self.writer.addParameterStart(indentLevel=1)
            self.writer.addParameter(
                "NoConfigBits", "integer", noConfigBits, indentLevel=2
            )
            self.writer.addParameterEnd(indentLevel=1)
        self.writer.addPortStart(indentLevel=1)

        # normal wire input
        for i in tile.portsInfo:
            if i.wireDirection != Direction.JUMP and i.inOut == IO.INPUT:
                for p in i.expandPortInfoByName():
                    self.writer.addPortScalar(p, IO.INPUT, indentLevel=2)

        # bel wire input
        for b in tile.bels:
            for p in b.outputs:
                self.writer.addPortScalar(p, IO.INPUT, indentLevel=2)

        # jump wire input
        for i in tile.portsInfo:
            if i.wireDirection == Direction.JUMP and i.inOut == IO.INPUT:
                for p in i.expandPortInfoByName():
                    self.writer.addPortScalar(p, IO.INPUT, indentLevel=2)

        # normal wire output
        for i in tile.portsInfo:
            if i.wireDirection != Direction.JUMP and i.inOut == IO.OUTPUT:
                for p in i.expandPortInfoByName():
                    self.writer.addPortScalar(p, IO.OUTPUT, indentLevel=2)

        # bel wire output
        for b in tile.bels:
            for p in b.inputs:
                self.writer.addPortScalar(p, IO.OUTPUT, indentLevel=2)

        # jump wire output
        for i in tile.portsInfo:
            if i.wireDirection == Direction.JUMP and i.inOut == IO.OUTPUT:
                for p in i.expandPortInfoByName():
                    self.writer.addPortScalar(p, IO.OUTPUT, indentLevel=2)

        self.writer.addComment("global", onNewLine=True)
        if noConfigBits > 0:
            if self.fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
                self.writer.addPortScalar("MODE", IO.INPUT, indentLevel=2)
                self.writer.addComment("global signal 1: configuration, 0: operation")
                self.writer.addPortScalar("CONFin", IO.INPUT, indentLevel=2)
                self.writer.addPortScalar("CONFout", IO.OUTPUT, indentLevel=2)
                self.writer.addPortScalar("CLK", IO.INPUT, indentLevel=2)
            if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                self.writer.addPortVector(
                    "ConfigBits", IO.INPUT, "NoConfigBits-1", indentLevel=2
                )
                self.writer.addPortVector(
                    "ConfigBits_N", IO.INPUT, "NoConfigBits-1", indentLevel=2
                )
        self.writer.addPortEnd()
        self.writer.addHeaderEnd(f"{tile.name}_switch_matrix")
        self.writer.addDesignDescriptionStart(f"{tile.name}_switch_matrix")

        # constant declaration
        # we may use the following in the switch matrix for providing '0' and '1' to a mux input:
        if isinstance(self.writer, VHDLWriter):
            self.writer.addConstant("GND0", "0")
            self.writer.addConstant("GND", "0")
            self.writer.addConstant("VCC0", "1")
            self.writer.addConstant("VCC", "1")
            self.writer.addConstant("VDD0", "1")
            self.writer.addConstant("VDD", "1")
        else:
            self.writer.addConstant("GND0", "1'b0")
            self.writer.addConstant("GND", "1'b0")
            self.writer.addConstant("VCC0", "1'b1")
            self.writer.addConstant("VCC", "1'b1")
            self.writer.addConstant("VDD0", "1'b1")
            self.writer.addConstant("VDD", "1'b1")
        self.writer.addNewLine()

        # signal declaration
        for portName in connections:
            # ports with single connections are directly assigned
            if len(connections[portName]) > 1:
                self.writer.addConnectionVector(
                    f"{portName}_input", f"{len(connections[portName])}-1"
                )

        ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
        ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
        if self.switch_matrix_debug_signal:
            self.writer.addNewLine()
            for portName in connections:
                muxSize = len(connections[portName])
                if muxSize >= 2:
                    paddedMuxSize = 2 ** (muxSize - 1).bit_length() - 1
                    self.writer.addConnectionVector(
                        f"DEBUG_select_{portName}",
                        f"{paddedMuxSize.bit_length() - 1}",
                    )
        ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
        ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
        self.writer.addComment(
            "The configuration bits (if any) are just a long shift register",
            onNewLine=True,
        )
        self.writer.addComment(
            "This shift register is padded to an even number of flops/latches",
            onNewLine=True,
        )

        # we are only generate configuration bits, if we really need configurations bits
        # for example in terminating switch matrices at the fabric borders, we may just change direction without any switching
        if noConfigBits > 0:
            if self.fabric.configBitMode == "ff_chain":
                self.writer.addConnectionVector("ConfigBits", noConfigBits)
            if self.fabric.configBitMode == "FlipFlopChain":
                # we pad to an even number of bits: (int(math.ceil(ConfigBitCounter/2.0))*2)
                self.writer.addConnectionVector(
                    "ConfigBits", int(math.ceil(noConfigBits / 2.0)) * 2
                )
                self.writer.addConnectionVector(
                    "ConfigBitsInput", int(math.ceil(noConfigBits / 2.0)) * 2
                )

        # begin architecture
        self.writer.addLogicStart()

        # the configuration bits shift register
        # again, we add this only if needed
        # TODO Should ff_chain be the same as FlipFlopChain?
        if noConfigBits > 0:
            if self.fabric.configBitMode == "ff_chain":
                self.writer.addShiftRegister(noConfigBits)
            elif self.fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
                self.writer.addFlipFlopChain(noConfigBits)
            elif self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                pass

        # the switch matrix implementation
        # we use the following variable to count the configuration bits of a long shift register which actually holds the switch matrix configuration
        configBitstreamPosition = 0
        for portName in connections:
            muxSize = len(connections[portName])
            self.writer.addComment(
                f"switch matrix multiplexer {portName} MUX-{muxSize}", onNewLine=True
            )
            if muxSize == 0:
                logger.warning(
                    f"Input port {portName} of switch matrix in Tile {tile.name} is not used"
                )
                self.writer.addComment(
                    f"WARNING unused multiplexer MUX-{portName}", onNewLine=True
                )

            elif muxSize == 1:
                # just route through : can be used for auxiliary wires or diagonal routing (Manhattan, just go to a switch matrix when turning
                # can also be used to tap a wire. A double with a mid is nothing else as a single cascaded with another single where the second single has only one '1' to cascade from the first single
                if connections[portName][0] == "0":
                    self.writer.addAssignScalar(portName, 0)
                elif connections[portName][0] == "1":
                    self.writer.addAssignScalar(portName, 1)
                else:
                    self.writer.addAssignScalar(
                        portName,
                        connections[portName][0],
                        delay=self.fabric.generateDelayInSwitchMatrix,
                    )
                self.writer.addNewLine()
            elif muxSize >= 2:
                # this is the case for a configurable switch matrix multiplexer
                old_ConfigBitstreamPosition = configBitstreamPosition

                # Pad mux size to the next power of 2
                paddedMuxSize = 2 ** (muxSize - 1).bit_length()

                if paddedMuxSize == 2:
                    muxComponentName = f"cus_mux{paddedMuxSize}1"
                else:
                    muxComponentName = f"cus_mux{paddedMuxSize}1_buf"

                portsPairs = []
                start = 0
                for start in range(muxSize):
                    portsPairs.append((f"A{start}", f"{portName}_input[{start}]"))

                for end in range(start + 1, paddedMuxSize):
                    portsPairs.append((f"A{end}", "GND0"))

                if self.fabric.multiplexerStyle == MultiplexerStyle.CUSTOM:
                    if paddedMuxSize == 2:
                        portsPairs.append(
                            ("S", f"ConfigBits[{configBitstreamPosition}+0]")
                        )
                    else:
                        for i in range(paddedMuxSize.bit_length() - 1):
                            portsPairs.append(
                                (f"S{i}", f"ConfigBits[{configBitstreamPosition}+{i}]")
                            )
                            portsPairs.append(
                                (
                                    f"S{i}N",
                                    f"ConfigBits_N[{configBitstreamPosition}+{i}]",
                                )
                            )

                portsPairs.append(("X", f"{portName}"))

                if self.fabric.multiplexerStyle == MultiplexerStyle.CUSTOM:
                    # we add the input signal in reversed order
                    # Changed it such that the left-most entry is located at the end of the concatenated vector for the multiplexing
                    # This was done such that the index from left-to-right in the adjacency matrix corresponds with the multiplexer select input (index)
                    self.writer.addAssignScalar(
                        f"{portName}_input",
                        connections[portName][::-1],
                        delay=self.fabric.generateDelayInSwitchMatrix,
                    )
                    self.writer.addInstantiation(
                        compName=muxComponentName,
                        compInsName=f"inst_{muxComponentName}_{portName}",
                        portsPairs=portsPairs,
                    )
                    if muxSize != 2 and muxSize != 4 and muxSize != 8 and muxSize != 16:
                        logger.warning(
                            f"creating a MUX-{muxSize} for port {portName} using MUX-{muxSize} in switch matrix for tile {tile.name}"
                        )
                else:
                    # generic multiplexer
                    self.writer.addAssignScalar(
                        portName,
                        f"{portName}_input[ConfigBits[{configBitstreamPosition - 1}:{configBitstreamPosition}]]",
                    )

                # update the configuration bitstream position
                configBitstreamPosition += paddedMuxSize.bit_length() - 1

        ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
        ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
        if self.switch_matrix_debug_signal:
            logger.info(f"Generate debug signals for switch matrix in tile {tile.name}")
            self.writer.addNewLine()
            configBitstreamPosition = 0
            old_ConfigBitstreamPosition = 0
            for portName in connections:
                muxSize = len(connections[portName])
                if muxSize >= 2:
                    paddedMuxSize = 2 ** (muxSize - 1).bit_length()
                    configBitstreamPosition += paddedMuxSize.bit_length() - 1
                    self.writer.addAssignVector(
                        f"DEBUG_select_{portName:<15}",
                        "ConfigBits",
                        f"{configBitstreamPosition - 1}",
                        old_ConfigBitstreamPosition,
                    )
                    old_ConfigBitstreamPosition = configBitstreamPosition

        ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
        ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###

        # just the final end of architecture
        self.writer.addDesignDescriptionEnd()
        self.writer.writeToFile()

    def generateTile(self, tile: Tile) -> None:
        """Generate the RTL code for a tile given the tile object.

        Parameters
        ----------
        tile : Tile
            The tile object.
        """
        allJumpWireList = []

        # We first check if we need a configuration port
        # Currently we assume that each primitive needs a configuration port
        # However, a switch matrix can have no switch matrix multiplexers
        # (e.g., when only bouncing back in border termination tiles)
        # we can detect this as each switch matrix file contains a comment -- NumberOfConfigBits
        # NumberOfConfigBits:0 tells us that the switch matrix does not have a config port
        # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning

        self.writer.addHeader(f"{tile.name}")
        self.writer.addParameterStart(indentLevel=1)
        if isinstance(self.writer, VerilogWriter):  # emulation only in Verilog
            maxBits = self.fabric.frameBitsPerRow * self.fabric.maxFramesPerCol
            self.writer.addPreprocIfDef("EMULATION")
            self.writer.addParameter(
                "Emulate_Bitstream",
                f"[{maxBits - 1}:0]",
                f"{maxBits}'b0",
                indentLevel=2,
            )
            self.writer.addPreprocEndif()
        self.writer.addParameter(
            "MaxFramesPerCol", "integer", self.fabric.maxFramesPerCol, indentLevel=2
        )
        self.writer.addParameter(
            "FrameBitsPerRow", "integer", self.fabric.frameBitsPerRow, indentLevel=2
        )
        if tile.globalConfigBits > 0:
            self.writer.addParameter(
                "NoConfigBits", "integer", tile.globalConfigBits, indentLevel=2
            )

        self.writer.addParameterEnd(indentLevel=1)
        self.writer.addPortStart(indentLevel=1)

        # holder for each direction of port string
        portList = (
            tile.getNorthSidePorts()
            + tile.getEastSidePorts()
            + tile.getWestSidePorts()
            + tile.getSouthSidePorts()
        )

        side_of_port = None
        for port in portList:
            if side_of_port is not port.sideOfTile:
                side_of_port = port.sideOfTile
                self.writer.addComment(str(side_of_port), onNewLine=True)
            # destination port are input to the tile
            # source port are output of the tile
            wireSize = (abs(port.xOffset) + abs(port.yOffset)) * port.wireCount - 1
            self.writer.addPortVector(port.name, port.inOut, wireSize, indentLevel=2)
            self.writer.addComment(str(port), indentLevel=2, onNewLine=False)

        # now we have to scan all BELs if they use external pins, because they have to be exported to the tile entity
        externalPorts = []
        for i in tile.bels:
            for p in i.externalInput:
                self.writer.addPortScalar(p, IO.INPUT, indentLevel=2)
            for p in i.externalOutput:
                self.writer.addPortScalar(p, IO.OUTPUT, indentLevel=2)
            externalPorts += i.externalInput
            externalPorts += i.externalOutput

        # if we found BELs with top-level IO ports, we just pass them through
        sharedExternalPorts = set()
        for i in tile.bels:
            sharedExternalPorts.update(i.sharedPort)

        self.writer.addComment("Tile IO ports from BELs", onNewLine=True, indentLevel=1)

        self.writer.addPortScalar("UserCLK", IO.INPUT, indentLevel=2)
        self.writer.addPortScalar("UserCLKo", IO.OUTPUT, indentLevel=2)

        if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
            self.writer.addPortVector(
                "FrameData", IO.INPUT, "FrameBitsPerRow-1", indentLevel=2
            )
            self.writer.addComment("CONFIG_PORT", onNewLine=False, end="")
            self.writer.addPortVector(
                "FrameData_O", IO.OUTPUT, "FrameBitsPerRow-1", indentLevel=2
            )
            self.writer.addPortVector(
                "FrameStrobe", IO.INPUT, "MaxFramesPerCol-1", indentLevel=2
            )
            self.writer.addComment("CONFIG_PORT", onNewLine=False, end="")
            self.writer.addPortVector(
                "FrameStrobe_O", IO.OUTPUT, "MaxFramesPerCol-1", indentLevel=2
            )

        elif self.fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            self.writer.addPortScalar("MODE", IO.INPUT, indentLevel=2)
            self.writer.addPortScalar("CONFin", IO.INPUT, indentLevel=2)
            self.writer.addPortScalar("CONFout", IO.OUTPUT, indentLevel=2)
            self.writer.addPortScalar("CLK", IO.INPUT, indentLevel=2)

        self.writer.addComment("global", onNewLine=True, indentLevel=1)

        self.writer.addPortEnd()
        self.writer.addHeaderEnd(f"{tile.name}")
        self.writer.addDesignDescriptionStart(f"{tile.name}")

        # insert switch matrix and config_mem component declaration
        if isinstance(self.writer, VHDLWriter):
            # insert CLB, I/O (or whatever BEL) component declaration
            # specified in the fabric csv file after the 'BEL' key word
            # we use this list to check if we have seen a BEL description before so we only insert one component declaration
            BEL_VHDL_riles_processed = []
            for i in tile.bels:
                if i.src not in BEL_VHDL_riles_processed:
                    BEL_VHDL_riles_processed.append(i.src)
                    self.writer.addComponentDeclarationForFile(i.src)

            basePath = Path(self.writer.outFileName).parent

            if (basePath / f"{tile.name}_switch_matrix.vhdl").exists():
                self.writer.addComponentDeclarationForFile(
                    f"{basePath}/{tile.name}_switch_matrix.vhdl"
                )
            else:
                raise FileNotFoundError(
                    f"Could not find {tile.name}_switch_matrix.vhdl in {basePath} Need to run matrix generation first"
                )

            if tile.globalConfigBits > 0:
                if (basePath / f"{tile.name}_ConfigMem.vhdl").exists():
                    self.writer.addComponentDeclarationForFile(
                        f"{basePath}/{tile.name}_ConfigMem.vhdl"
                    )
                else:
                    raise FileNotFoundError(
                        f"Could not find {tile.name}_ConfigMem.vhdl in {basePath} config_mem generation first"
                    )

        # signal declarations
        self.writer.addComment("signal declarations", onNewLine=True)
        # BEL port wires
        self.writer.addComment("BEL ports (e.g., slices)", onNewLine=True)
        repeatDeclaration = set()
        for bel in tile.bels:
            for i in bel.inputs + bel.outputs:
                if f"{i}" not in repeatDeclaration:
                    self.writer.addConnectionScalar(i)
                    repeatDeclaration.add(f"{bel.prefix}{i}")

        # Jump wires
        self.writer.addComment("Jump wires", onNewLine=True)
        for p in tile.portsInfo:
            if p.wireDirection == Direction.JUMP:
                if (
                    p.sourceName != "NULL"
                    and p.destinationName != "NULL"
                    and p.inOut == IO.OUTPUT
                ):
                    self.writer.addConnectionVector(p.name, f"{p.wireCount}-1")

                for k in range(p.wireCount):
                    allJumpWireList.append(f"{p.name}( {k} )")

        # internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
        self.writer.addComment(
            "internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)",
            onNewLine=True,
        )

        # the signal has to be number of BELs+2 bits wide (Bel_counter+1 downto 0)
        # we chain switch matrices only to the configuration port, if they really contain configuration bits
        # i.e. switch matrices have a config port which is indicated by "NumberOfConfigBits:0 is false"

        # The following conditional as intended to only generate the config_data signal if really anything is actually configured
        # however, we leave it and just use this signal as conf_data(0 downto 0) for simply touting through CONFin to CONFout
        # maybe even useful if we want to add a buffer here

        # all the signal wire need to declare first for compatibility with VHDL
        if tile.globalConfigBits > 0:
            self.writer.addConnectionVector("ConfigBits", "NoConfigBits-1", 0)
            self.writer.addConnectionVector("ConfigBits_N", "NoConfigBits-1", 0)

        self.writer.addNewLine()
        self.writer.addComment("Connection for outgoing wires", onNewLine=True)
        self.writer.addConnectionVector("FrameData_i", "FrameBitsPerRow-1", 0)
        self.writer.addConnectionVector("FrameData_O_i", "FrameBitsPerRow-1", 0)
        self.writer.addConnectionVector("FrameStrobe_i", "MaxFramesPerCol-1", 0)
        self.writer.addConnectionVector("FrameStrobe_O_i", "MaxFramesPerCol-1", 0)

        added = set()
        for port in tile.portsInfo:
            span = abs(port.xOffset) + abs(port.yOffset)
            if (port.sourceName, port.destinationName) in added:
                continue
            if (
                span >= 2
                and port.sourceName != "NULL"
                and port.destinationName != "NULL"
            ):
                highBoundIndex = span * port.wireCount - 1
                self.writer.addConnectionVector(
                    f"{port.destinationName}_i", highBoundIndex
                )
                self.writer.addConnectionVector(
                    f"{port.sourceName}_i", highBoundIndex - port.wireCount
                )
                added.add((port.sourceName, port.destinationName))

        self.writer.addNewLine()
        self.writer.addLogicStart()

        # buffer FrameData signals
        self.writer.addAssignScalar("FrameData_O_i", "FrameData_i")
        self.writer.addNewLine()
        for i in range(self.fabric.frameBitsPerRow):
            self.writer.addInstantiation(
                "my_buf",
                f"data_inbuf_{i}",
                portsPairs=[("A", f"FrameData[{i}]"), ("X", f"FrameData_i[{i}]")],
            )
        for i in range(self.fabric.frameBitsPerRow):
            self.writer.addInstantiation(
                "my_buf",
                f"data_outbuf_{i}",
                portsPairs=[
                    ("A", f"FrameData_O_i[{i}]"),
                    ("X", f"FrameData_O[{i}]"),
                ],
            )

        # strobe is always added even when config bits are 0
        self.writer.addAssignScalar("FrameStrobe_O_i", "FrameStrobe_i")
        self.writer.addNewLine()
        for i in range(self.fabric.maxFramesPerCol):
            self.writer.addInstantiation(
                "my_buf",
                f"strobe_inbuf_{i}",
                portsPairs=[("A", f"FrameStrobe[{i}]"), ("X", f"FrameStrobe_i[{i}]")],
            )

        for i in range(self.fabric.maxFramesPerCol):
            self.writer.addInstantiation(
                "my_buf",
                f"strobe_outbuf_{i}",
                portsPairs=[
                    ("A", f"FrameStrobe_O_i[{i}]"),
                    ("X", f"FrameStrobe_O[{i}]"),
                ],
            )

        added = set()
        for port in tile.portsInfo:
            span = abs(port.xOffset) + abs(port.yOffset)
            if (port.sourceName, port.destinationName) in added:
                continue
            if (
                span >= 2
                and port.sourceName != "NULL"
                and port.destinationName != "NULL"
            ):
                highBoundIndex = span * port.wireCount - 1
                # using scalar assignment to connect the two vectors
                # could replace with assign as vector, but will lose the - wireCount readability
                self.writer.addAssignScalar(
                    f"{port.sourceName}_i[{highBoundIndex}-{port.wireCount}:0]",
                    f"{port.destinationName}_i[{highBoundIndex}:{port.wireCount}]",
                )
                self.writer.addNewLine()
                for i in range(highBoundIndex - port.wireCount + 1):
                    self.writer.addInstantiation(
                        "my_buf",
                        f"{port.destinationName}_inbuf_{i}",
                        portsPairs=[
                            ("A", f"{port.destinationName}[{i + port.wireCount}]"),
                            ("X", f"{port.destinationName}_i[{i + port.wireCount}]"),
                        ],
                    )
                for i in range(highBoundIndex - port.wireCount + 1):
                    self.writer.addInstantiation(
                        "my_buf",
                        f"{port.sourceName}_outbuf_{i}",
                        portsPairs=[
                            ("A", f"{port.sourceName}_i[{i}]"),
                            ("X", f"{port.sourceName}[{i}]"),
                        ],
                    )

                added.add((port.sourceName, port.destinationName))

        self.writer.addInstantiation(
            "clk_buf",
            "inst_clk_buf",
            portsPairs=[("A", "UserCLK"), ("X", "UserCLKo")],
        )

        self.writer.addNewLine()
        # top configuration data daisy chaining
        if self.fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            self.writer.addComment(
                "top configuration data daisy chaining", onNewLine=True
            )
            self.writer.addAssignScalar("conf_data(conf_data'low)", "CONFin")
            self.writer.addComment("conf_data'low=0 and CONFin is from tile entity")
            self.writer.addAssignScalar("conf_data(conf_data'high)", "CONFout")
            self.writer.addComment("CONFout is from tile entity")

        # the <entity>_ConfigMem module is only parametrized through generics, so we hard code its instantiation here
        if (
            self.fabric.configBitMode == ConfigBitMode.FRAME_BASED
            and tile.globalConfigBits > 0
        ):
            self.writer.addComment("configuration storage latches", onNewLine=True)
            self.writer.addInstantiation(
                compName=f"{tile.name}_ConfigMem",
                compInsName=f"Inst_{tile.name}_ConfigMem",
                portsPairs=[
                    ("FrameData", "FrameData"),
                    ("FrameStrobe", "FrameStrobe"),
                    ("ConfigBits", "ConfigBits"),
                    ("ConfigBits_N", "ConfigBits_N"),
                ],
                emulateParamPairs=[("Emulate_Bitstream", "Emulate_Bitstream")],
            )

        # BEL component instantiations
        if tile.bels:
            self.writer.addNewLine()
            self.writer.addComment("BEL component instantiations", onNewLine=True)

        belCounter = 0
        belConfigBitsCounter = 0
        for bel in tile.bels:
            port_dict = defaultdict(list)
            portsPairs = []
            portList = []
            signal = []
            userclk_pair = None

            # internal + external ports
            for port in (
                bel.inputs + bel.outputs + bel.externalInput + bel.externalOutput
            ):
                port_name = port.removeprefix(bel.prefix)
                if r := re.search(r"\d+$", port_name):
                    number = r.group()
                    portname = port_name.removesuffix(number)
                else:
                    portname = port_name
                    number = ""
                port_dict[portname].append((port, number))

            # Shared ports
            for port in bel.sharedPort:
                if port[0] == "UserCLK":
                    userclk_pair = (port[0], port[0])
                else:
                    portsPairs.append((port[0], port[0]))

            if bel.individually_declared:
                for portname, ports in port_dict.items():
                    for port, number in ports:
                        # If there's a number, include it in the port name.
                        if number:
                            portsPairs.append((f"{portname}{number}", port))
                        else:
                            portsPairs.append((portname, port))
            else:
                for portname, ports in port_dict.items():
                    if len(ports) > 1:
                        # Sort ports based on bit significance.
                        ports.sort(key=lambda x: int(x[1]) if x[1].isdigit() else -1)
                        # Concatenate the ports in the correct order.
                        concatenated_ports = ", ".join(port for port, _ in ports[::-1])
                        portsPairs.append((portname, f"{{{concatenated_ports}}}"))
                    else:
                        # Single port, no need for concatenation.
                        single_port = ports[0][0]
                        portsPairs.append((portname, single_port))

            # Makes sure UserCLK is after ports.
            if userclk_pair is not None:
                portsPairs.append(userclk_pair)

            if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                if bel.configBit > 0:
                    portsPairs.append(
                        (
                            "ConfigBits",
                            f"ConfigBits[{belConfigBitsCounter + bel.configBit}-1:{belConfigBitsCounter}]",
                        )
                    )
            elif self.fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
                portsPairs.append(("MODE", "Mode"))
                portsPairs.append(("CONFin", f"conf_data({belCounter})"))
                portsPairs.append(("CONFout", f"conf_data({belCounter + 1})"))
                portsPairs.append(("CLK", "CLK"))

            self.writer.addInstantiation(
                compName=bel.name,
                compInsName=f"Inst_{bel.prefix}{bel.name}",
                portsPairs=portsPairs,
            )

            # FIXME: Why is the belCounter increased here by 2 and afterwards by 1?
            belCounter += 2
            belConfigBitsCounter += bel.configBit

            # for the next BEL (if any) for cascading configuration chain
            # (this information is also needed for chaining the switch matrix)
            belCounter += 1

        # switch matrix component instantiation
        # important to know:
        # Each switch matrix entity is build up is a specific order:
        # 1.a) interconnect wire INPUTS (in the order defined by the fabric file,)
        # 2.a) BEL primitive INPUTS (in the order the BEL-VHDLs are listed in the fabric CSV)
        #      within each BEL, the order from the entity is maintained
        #      Note that INPUTS refers to the view of the switch matrix! Which corresponds to BEL outputs at the actual BEL
        # 3.a) JUMP wire INPUTS (in the order defined by the fabric file)
        # 1.b) interconnect wire OUTPUTS
        # 2.b) BEL primitive OUTPUTS
        #      Again: OUTPUTS refers to the view of the switch matrix which corresponds to BEL inputs at the actual BEL
        # 3.b) JUMP wire OUTPUTS
        # The switch matrix uses single bit ports (std_logic and not std_logic_vector)!!!

        portsPairs = []
        # normal input wire
        for i in tile.portsInfo:
            if i.wireDirection != Direction.JUMP and i.inOut == IO.INPUT:
                portsPairs += list(
                    zip(
                        i.expandPortInfoByName(),
                        i.expandPortInfoByName(indexed=True),
                        strict=False,
                    )
                )
        # bel input wire (bel output is input to switch matrix)
        for bel in tile.bels:
            for p in bel.outputs:
                portsPairs.append((p, p))

        # jump input wire
        port, signal = [], []
        for i in tile.portsInfo:
            if i.wireDirection == Direction.JUMP and i.inOut == IO.INPUT:
                port += i.expandPortInfoByName()
            if i.wireDirection == Direction.JUMP and i.inOut == IO.OUTPUT:
                signal += i.expandPortInfoByName(indexed=True)

        portsPairs += list(zip(port, signal, strict=False))

        # normal output wire
        for i in tile.portsInfo:
            if i.wireDirection != Direction.JUMP and i.inOut == IO.OUTPUT:
                portsPairs += list(
                    zip(
                        i.expandPortInfoByName(),
                        i.expandPortInfoByNameTop(indexed=True),
                        strict=False,
                    )
                )

        # bel output wire (bel input is input to switch matrix)
        for bel in tile.bels:
            for p in bel.inputs:
                portsPairs.append((p, p))

        # jump output wire
        port, signal = [], []
        for i in tile.portsInfo:
            if i.wireDirection == Direction.JUMP and i.inOut == IO.OUTPUT:
                port += i.expandPortInfoByName()
            if i.wireDirection == Direction.JUMP and i.inOut == IO.OUTPUT:
                signal += i.expandPortInfoByName(indexed=True)

        portsPairs += list(zip(port, signal, strict=False))

        if self.fabric.configBitMode == ConfigBitMode.FLIPFLOP_CHAIN:
            portsPairs.append(("MODE", "Mode"))
            portsPairs.append(("CONFin", f"conf_data({belCounter})"))
            portsPairs.append(("CONFout", f"conf_data({belCounter + 1})"))
            portsPairs.append(("CLK", "CLK"))

        if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
            if tile.globalConfigBits > 0:
                portsPairs.append(
                    (
                        "ConfigBits",
                        f"ConfigBits[{tile.globalConfigBits}-1:{belConfigBitsCounter}]",
                    )
                )
                portsPairs.append(
                    (
                        "ConfigBits_N",
                        f"ConfigBits_N[{tile.globalConfigBits}-1:{belConfigBitsCounter}]",
                    )
                )

        self.writer.addInstantiation(
            compName=f"{tile.name}_switch_matrix",
            compInsName=f"Inst_{tile.name}_switch_matrix",
            portsPairs=portsPairs,
        )

        self.writer.addDesignDescriptionEnd()
        self.writer.writeToFile()

    def generateSuperTile(self, superTile: SuperTile) -> None:
        """Generate a super tile wrapper for given super tile.

        Parameters
        ----------
        superTile : SuperTile
            Super tile object.
        """

        self.writer.addHeader(f"{superTile.name}")
        self.writer.addParameterStart(indentLevel=1)
        if isinstance(self.writer, VerilogWriter):
            self.writer.addPreprocIfDef("EMULATION")
            maxBits = self.fabric.frameBitsPerRow * self.fabric.maxFramesPerCol
            for y, row in enumerate(superTile.tileMap):
                for x, tile in enumerate(row):
                    if not tile:
                        continue
                    self.writer.addParameter(
                        f"Tile_X{x}Y{y}_Emulate_Bitstream",
                        f"[{maxBits - 1}:0]",
                        f"{maxBits}'b0",
                        indentLevel=2,
                    )
            self.writer.addPreprocEndif()
        self.writer.addParameter(
            "MaxFramesPerCol", "integer", self.fabric.maxFramesPerCol, indentLevel=2
        )
        self.writer.addParameter(
            "FrameBitsPerRow", "integer", self.fabric.frameBitsPerRow, indentLevel=2
        )

        self.writer.addParameterEnd(indentLevel=1)
        self.writer.addPortStart(indentLevel=1)

        portsAround = superTile.getPortsAroundTile()

        for k, v in portsAround.items():
            if not v:
                continue
            x, y = k.split(",")
            for pList in v:
                # Skip empty port lists
                if not pList:
                    continue

                self.writer.addComment(
                    f"Tile_X{x}Y{y}_{pList[0].wireDirection}",
                    onNewLine=True,
                    indentLevel=1,
                )
                for p in pList:
                    wire = (abs(p.xOffset) + abs(p.yOffset)) * p.wireCount - 1
                    self.writer.addPortVector(
                        f"Tile_X{x}Y{y}_{p.name}", p.inOut, wire, indentLevel=2
                    )
                    self.writer.addComment(str(p), onNewLine=False)

        # add tile external bel port
        self.writer.addComment("Tile IO ports from BELs", onNewLine=True, indentLevel=1)
        for i in superTile.tiles:
            for b in i.bels:
                for p in b.externalInput:
                    self.writer.addPortScalar(p, IO.INPUT, indentLevel=2)
                for p in b.externalOutput:
                    self.writer.addPortScalar(p, IO.OUTPUT, indentLevel=2)
                for p in b.sharedPort:
                    if p[0] == "UserCLK":
                        continue
                    self.writer.addPortScalar(p[0], p[1], indentLevel=2)

        # add config port
        if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
            for y, row in enumerate(superTile.tileMap):
                for x, _tile in enumerate(row):
                    if y - 1 < 0 or superTile.tileMap[y - 1][x] is None:
                        self.writer.addPortVector(
                            f"Tile_X{x}Y{y}_FrameStrobe_O",
                            IO.OUTPUT,
                            "MaxFramesPerCol-1",
                            indentLevel=2,
                        )
                        self.writer.addComment("CONFIG_PORT", onNewLine=False)
                    if x - 1 < 0 or superTile.tileMap[y][x - 1] is None:
                        self.writer.addPortVector(
                            f"Tile_X{x}Y{y}_FrameData",
                            IO.INPUT,
                            "FrameBitsPerRow-1",
                            indentLevel=2,
                        )
                        self.writer.addComment("CONFIG_PORT", onNewLine=False)
                    if (
                        y + 1 >= len(superTile.tileMap)
                        or superTile.tileMap[y + 1][x] is None
                    ):
                        self.writer.addPortVector(
                            f"Tile_X{x}Y{y}_FrameStrobe",
                            IO.INPUT,
                            "MaxFramesPerCol-1",
                            indentLevel=2,
                        )
                        self.writer.addComment("CONFIG_PORT", onNewLine=False)
                    if (
                        x + 1 >= len(superTile.tileMap[y])
                        or superTile.tileMap[y][x + 1] is None
                    ):
                        self.writer.addPortVector(
                            f"Tile_X{x}Y{y}_FrameData_O",
                            IO.OUTPUT,
                            "FrameBitsPerRow-1",
                            indentLevel=2,
                        )
                        self.writer.addComment("CONFIG_PORT", onNewLine=False)
        for y, row in enumerate(superTile.tileMap):
            for x, _tile in enumerate(row):
                if y - 1 < 0 or superTile.tileMap[y - 1][x] is None:
                    self.writer.addPortScalar(
                        f"Tile_X{x}Y{y}_UserCLKo", IO.OUTPUT, indentLevel=2
                    )
                if (
                    y + 1 >= len(superTile.tileMap)
                    or superTile.tileMap[y + 1][x] is None
                ):
                    self.writer.addPortScalar(
                        f"Tile_X{x}Y{y}_UserCLK", IO.INPUT, indentLevel=2
                    )
        self.writer.addPortEnd()
        self.writer.addHeaderEnd(f"{superTile.name}")
        self.writer.addDesignDescriptionStart(f"{superTile.name}")
        self.writer.addNewLine()

        if isinstance(self.writer, VHDLWriter):
            for t in superTile.tiles:
                # This is only relevant to VHDL code generation, will not affect Verilog code generation
                self.writer.addComponentDeclarationForFile(
                    f"{Path(self.writer.outFileName).parent}/{t.name}/{t.name}.vhdl"
                )

        # find all internal connections
        internalConnections = superTile.getInternalConnections()

        # declare internal connections
        self.writer.addComment("signal declarations", onNewLine=True)
        for i, x, y in internalConnections:
            if i:
                self.writer.addComment(
                    f"Tile_X{x}Y{y}_{i[0].wireDirection}", onNewLine=True
                )
                for p in i:
                    if p.inOut == IO.OUTPUT:
                        wire = (abs(p.xOffset) + abs(p.yOffset)) * p.wireCount - 1
                        self.writer.addConnectionVector(
                            f"Tile_X{x}Y{y}_{p.name}", wire, indentLevel=1
                        )
                        self.writer.addComment(str(p), onNewLine=False)

        # declare internal connections for frameData, frameStrobe, and UserCLK
        for y, row in enumerate(superTile.tileMap):
            for x, _tile in enumerate(row):
                if (
                    0 <= y - 1 < len(superTile.tileMap)
                    and superTile.tileMap[y - 1][x] is not None
                ):
                    self.writer.addConnectionVector(
                        f"Tile_X{x}Y{y}_FrameStrobe_O",
                        "MaxFramesPerCol-1",
                        indentLevel=1,
                    )
                    self.writer.addConnectionScalar(
                        f"Tile_X{x}Y{y}_UserCLKo", indentLevel=1
                    )
                if (
                    0 <= x - 1 < len(superTile.tileMap[y])
                    and superTile.tileMap[y][x - 1] is not None
                ):
                    self.writer.addConnectionVector(
                        f"Tile_X{x}Y{y}_FrameData_O", "FrameBitsPerRow-1", indentLevel=1
                    )

        self.writer.addNewLine()

        self.writer.addLogicStart()

        # pair up the connection for tile instantiation
        for y, row in enumerate(superTile.tileMap):
            for x, tile in enumerate(row):
                northInput, southInput, eastInput, westInput = [], [], [], []
                portsPairs = []
                if tile is None:
                    continue

                # north direction input connection
                northPort = [i.name for i in tile.getNorthPorts(IO.INPUT)]
                if (
                    0 <= y + 1 < len(superTile.tileMap)
                    and superTile.tileMap[y + 1][x] is not None
                ):
                    for p in superTile.tileMap[y + 1][x].getNorthPorts(IO.OUTPUT):
                        northInput.append(f"Tile_X{x}Y{y + 1}_{p.name}")
                else:
                    for p in tile.getNorthPorts(IO.INPUT):
                        northInput.append(f"Tile_X{x}Y{y}_{p.name}")

                portsPairs += list(zip(northPort, northInput, strict=False))
                # east direction input connection
                eastPort = [i.name for i in tile.getEastPorts(IO.INPUT)]
                if (
                    0 <= x - 1 < len(superTile.tileMap[0])
                    and superTile.tileMap[y][x - 1] is not None
                ):
                    for p in superTile.tileMap[y][x - 1].getEastPorts(IO.OUTPUT):
                        eastInput.append(f"Tile_X{x - 1}Y{y}_{p.name}")
                else:
                    for p in tile.getEastPorts(IO.INPUT):
                        eastInput.append(f"Tile_X{x}Y{y}_{p.name}")

                portsPairs += list(zip(eastPort, eastInput, strict=False))

                # south direction input connection
                southPort = [
                    i.name for i in tile.getSouthPorts(IO.INPUT) if i.inOut == IO.INPUT
                ]
                if (
                    0 <= y - 1 < len(superTile.tileMap)
                    and superTile.tileMap[y - 1][x] is not None
                ):
                    for p in superTile.tileMap[y - 1][x].getSouthPorts(IO.OUTPUT):
                        southInput.append(f"Tile_X{x}Y{y - 1}_{p.name}")
                else:
                    for p in tile.getSouthPorts(IO.INPUT):
                        southInput.append(f"Tile_X{x}Y{y}_{p.name}")

                portsPairs += list(zip(southPort, southInput, strict=False))

                # west direction input connection
                westPort = [
                    i.name for i in tile.getWestPorts(IO.INPUT) if i.inOut == IO.INPUT
                ]
                if (
                    0 <= x + 1 < len(superTile.tileMap[0])
                    and superTile.tileMap[y][x + 1] is not None
                ):
                    for p in superTile.tileMap[y][x + 1].getWestPorts(IO.OUTPUT):
                        westInput.append(f"Tile_X{x + 1}Y{y}_{p.name}")
                else:
                    for p in tile.getWestPorts(IO.INPUT):
                        westInput.append(f"Tile_X{x}Y{y}_{p.name}")

                portsPairs += list(zip(westPort, westInput, strict=False))

                for p in (
                    tile.getNorthPorts(IO.OUTPUT)
                    + tile.getEastPorts(IO.OUTPUT)
                    + tile.getSouthPorts(IO.OUTPUT)
                    + tile.getWestPorts(IO.OUTPUT)
                ):
                    portsPairs.append((p.name, f"Tile_X{x}Y{y}_{p.name}"))

                for b in tile.bels:
                    for p in b.externalInput:
                        portsPairs.append((p, p))

                    for p in b.externalOutput:
                        portsPairs.append((p, p))

                    for p in b.sharedPort:
                        if "UserCLK" not in p[0]:
                            portsPairs.append(("UserCLK", p[0]))

                # add clock to tile
                if (
                    0 <= y + 1 < len(superTile.tileMap)
                    and superTile.tileMap[y + 1][x] is not None
                ):
                    portsPairs.append(("UserCLK", f"Tile_X{x}Y{y + 1}_UserCLKo"))
                else:
                    portsPairs.append(("UserCLK", f"Tile_X{x}Y{y}_UserCLK"))
                portsPairs.append(("UserCLKo", f"Tile_X{x}Y{y}_UserCLKo"))
                if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                    # add connection for frameData, frameStrobe and UserCLK
                    if (
                        0 <= x - 1 < len(superTile.tileMap[0])
                        and superTile.tileMap[y][x - 1] is not None
                    ):
                        portsPairs.append(
                            ("FrameData", f"Tile_X{x - 1}Y{y}_FrameData_O")
                        )
                    else:
                        portsPairs.append(("FrameData", f"Tile_X{x}Y{y}_FrameData"))

                    portsPairs.append(("FrameData_O", f"Tile_X{x}Y{y}_FrameData_O"))

                    if (
                        0 <= y + 1 < len(superTile.tileMap)
                        and superTile.tileMap[y + 1][x] is not None
                    ):
                        portsPairs.append(
                            ("FrameStrobe", f"Tile_X{x}Y{y + 1}_FrameStrobe_O")
                        )
                    else:
                        portsPairs.append(("FrameStrobe", f"Tile_X{x}Y{y}_FrameStrobe"))

                    portsPairs.append(("FrameStrobe_O", f"Tile_X{x}Y{y}_FrameStrobe_O"))

                emulateParamPairs = [
                    ("Emulate_Bitstream", f"Tile_X{x}Y{y}_Emulate_Bitstream")
                ]

                self.writer.addInstantiation(
                    compName=tile.name,
                    compInsName=f"Tile_X{x}Y{y}_{tile.name}",
                    portsPairs=portsPairs,
                    emulateParamPairs=emulateParamPairs,
                )
        self.writer.addDesignDescriptionEnd()
        self.writer.writeToFile()

    def generateFabric(self) -> None:
        """Generate the fabric.

        The fabric description will be a flat description.
        """

        # There are of course many possibilities for generating the fabric.
        # I decided to generate a flat description as it may allow for a little easier debugging.
        # For larger fabrics, this may be an issue, but not for now.
        # We only have wires between two adjacent tiles in North, East, South, West direction.
        # So we use the output ports to generate wires.

        # we first scan all tiles if those have IOs that have to go to top
        # the order of this scan is later maintained when instantiating the actual tiles
        # header
        fabricName = "eFPGA"
        self.writer.addHeader(fabricName)
        self.writer.addParameterStart(indentLevel=1)
        self.writer.addParameter(
            "MaxFramesPerCol", "integer", self.fabric.maxFramesPerCol, indentLevel=2
        )
        self.writer.addParameter(
            "FrameBitsPerRow", "integer", self.fabric.frameBitsPerRow, indentLevel=2
        )
        self.writer.addParameterEnd(indentLevel=1)
        self.writer.addPortStart(indentLevel=1)
        for y, row in enumerate(self.fabric.tile):
            for x, tile in enumerate(row):
                if tile is not None:
                    for bel in tile.bels:
                        for i in bel.externalInput:
                            self.writer.addPortScalar(
                                f"Tile_X{x}Y{y}_{i}", IO.INPUT, indentLevel=2
                            )
                            self.writer.addComment("EXTERNAL", onNewLine=False)
                        for i in bel.externalOutput:
                            self.writer.addPortScalar(
                                f"Tile_X{x}Y{y}_{i}", IO.OUTPUT, indentLevel=2
                            )
                            self.writer.addComment("EXTERNAL", onNewLine=False)

        if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
            self.writer.addPortVector(
                "FrameData",
                IO.INPUT,
                f"(FrameBitsPerRow*{self.fabric.numberOfRows})-1",
                indentLevel=2,
            )
            self.writer.addComment("CONFIG_PORT", onNewLine=False)
            self.writer.addPortVector(
                "FrameStrobe",
                IO.INPUT,
                f"(MaxFramesPerCol*{self.fabric.numberOfColumns})-1",
                indentLevel=2,
            )
            self.writer.addComment("CONFIG_PORT", onNewLine=False)

        self.writer.addPortScalar("UserCLK", IO.INPUT, indentLevel=2)

        self.writer.addPortEnd()
        self.writer.addHeaderEnd(fabricName)
        self.writer.addDesignDescriptionStart(fabricName)
        self.writer.addNewLine()

        if isinstance(self.writer, VHDLWriter):
            added = set()
            for t in self.fabric.tileDic:
                name = t.split("_")[0]
                if name in added:
                    continue
                if name not in self.fabric.superTileDic.keys():
                    self.writer.addComponentDeclarationForFile(
                        f"{Path(self.writer.outFileName).parent.parent}/Tile/{t}/{t}.vhdl"
                    )
                    added.add(t)
                else:
                    self.writer.addComponentDeclarationForFile(
                        f"{Path(self.writer.outFileName).parent.parent}/Tile/{name}/{name}.vhdl"
                    )
                    added.add(name)

        # VHDL signal declarations
        self.writer.addComment("signal declarations", onNewLine=True, end="\n")

        for y, row in enumerate(self.fabric.tile):
            for x, _tile in enumerate(row):
                self.writer.addConnectionScalar(f"Tile_X{x}Y{y}_UserCLKo")

        self.writer.addComment(
            "configuration signal declarations", onNewLine=True, end="\n"
        )

        if self.fabric.configBitMode == "FlipFlopChain":
            tileCounter = 0
            for row in self.fabric.tile:
                for t in row:
                    if t is not None:
                        tileCounter += 1
            self.writer.addConnectionVector("conf_data", tileCounter)

        if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
            # FrameData       =>     Tile_Y3_FrameData,
            # FrameStrobe      =>     Tile_X1_FrameStrobe
            # MaxFramesPerCol : integer := 20;
            # FrameBitsPerRow : integer := 32;
            for y in range(self.fabric.numberOfRows):
                self.writer.addConnectionVector(
                    f"Row_Y{y}_FrameData", "FrameBitsPerRow -1"
                )

            for x in range(self.fabric.numberOfColumns):
                self.writer.addConnectionVector(
                    f"Column_X{x}_FrameStrobe", "MaxFramesPerCol - 1"
                )

            for y in range(self.fabric.numberOfRows):
                for x in range(self.fabric.numberOfColumns):
                    self.writer.addConnectionVector(
                        f"Tile_X{x}Y{y}_FrameData_O", "FrameBitsPerRow - 1"
                    )

            for y in range(self.fabric.numberOfRows + 1):
                for x in range(self.fabric.numberOfColumns):
                    self.writer.addConnectionVector(
                        f"Tile_X{x}Y{y}_FrameStrobe_O", "MaxFramesPerCol - 1"
                    )

        self.writer.addComment("tile-to-tile signal declarations", onNewLine=True)
        for y, row in enumerate(self.fabric.tile):
            for x, tile in enumerate(row):
                if tile is not None:
                    seenPorts = set()
                    for p in tile.portsInfo:
                        wireLength = (abs(p.xOffset) + abs(p.yOffset)) * p.wireCount - 1
                        if p.sourceName == "NULL" or p.wireDirection == Direction.JUMP:
                            continue
                        if p.sourceName in seenPorts:
                            continue
                        seenPorts.add(p.sourceName)
                        self.writer.addConnectionVector(
                            f"Tile_X{x}Y{y}_{p.sourceName}", wireLength
                        )
        self.writer.addNewLine()
        # VHDL architecture body
        self.writer.addLogicStart()

        # top configuration data daisy chaining
        # this is copy and paste from tile code generation (so we can modify this here without side effects
        if self.fabric.configBitMode == "FlipFlopChain":
            self.writer.addComment("configuration data daisy chaining", onNewLine=True)
            self.writer.addAssignScalar("conf_dat'low", "CONFin")
            self.writer.addComment("conf_data'low=0 and CONFin is from tile entity")
            self.writer.addAssignScalar("CONFout", "conf_data'high")
            self.writer.addComment("CONFout is from tile entity")

        if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
            for y in range(len(self.fabric.tile)):
                self.writer.addAssignVector(
                    f"Row_Y{y}_FrameData",
                    "FrameData",
                    f"FrameBitsPerRow*({y}+1)-1",
                    f"FrameBitsPerRow*{y}",
                )
            for x in range(len(self.fabric.tile[0])):
                self.writer.addAssignVector(
                    f"Column_X{x}_FrameStrobe",
                    "FrameStrobe",
                    f"MaxFramesPerCol*({x}+1)-1",
                    f"MaxFramesPerCol*{x}",
                )

        instantiatedPosition = []
        # Tile instantiations
        for y, row in enumerate(self.fabric.tile):
            for x, tile in enumerate(row):
                tileLocationOffset: list[tuple[int, int]] = []
                superTileLoc = []
                superTile = None
                if tile is None:
                    continue

                if (x, y) in instantiatedPosition:
                    continue

                # instantiate super tile when encountered
                # get all the ports of the tile. If is a super tile, we loop over the
                # tile map and find all the offset of the subtile, and all their related
                # ports.
                if tile.partOfSuperTile:
                    for k, v in self.fabric.superTileDic.items():
                        if tile.name in [i.name for i in v.tiles]:
                            superTile = self.fabric.superTileDic[k]
                            break

                if superTile:
                    portsAround = superTile.getPortsAroundTile()
                    cord = [
                        (i.split(",")[0], i.split(",")[1])
                        for i in list(portsAround.keys())
                    ]
                    for i, j in cord:
                        tileLocationOffset.append((int(i), int(j)))
                        instantiatedPosition.append((x + int(i), y + int(j)))
                        superTileLoc.append((x + int(i), y + int(j)))
                else:
                    tileLocationOffset.append((0, 0))

                portsPairs = []
                # use the offset to find all the related tile input, output signal
                # if is a normal tile then the offset is (0, 0)
                for i, j in tileLocationOffset:
                    # input connection from north side of the south tile
                    if (
                        0 <= y + 1 < len(self.fabric.tile)
                        and self.fabric.tile[y + j + 1][x + i] is not None
                        and (x + i, y + j + 1) not in superTileLoc
                    ):
                        if self.fabric.tile[y + j][x + i].partOfSuperTile:
                            northPorts = [
                                f"Tile_X{i}Y{j}_{p.name}"
                                for p in self.fabric.tile[y + j][x + i].getNorthPorts(
                                    IO.INPUT
                                )
                            ]
                        else:
                            northPorts = [
                                i.name
                                for i in self.fabric.tile[y + j][x + i].getNorthPorts(
                                    IO.INPUT
                                )
                            ]

                        northInput = [
                            f"Tile_X{x + i}Y{y + j + 1}_{p.name}"
                            for p in self.fabric.tile[y + j + 1][x + i].getNorthPorts(
                                IO.OUTPUT
                            )
                        ]
                        portsPairs += list(zip(northPorts, northInput, strict=False))

                    # input connection from east side of the west tile
                    if (
                        0 <= x - 1 < len(self.fabric.tile[0])
                        and self.fabric.tile[y + j][x + i - 1] is not None
                        and (x + i - 1, y + j) not in superTileLoc
                    ):
                        if self.fabric.tile[y + j][x + i].partOfSuperTile:
                            eastPorts = [
                                f"Tile_X{i}Y{j}_{p.name}"
                                for p in self.fabric.tile[y + j][x + i].getEastPorts(
                                    IO.INPUT
                                )
                            ]
                        else:
                            eastPorts = [
                                i.name
                                for i in self.fabric.tile[y + j][x + i].getEastPorts(
                                    IO.INPUT
                                )
                            ]

                        eastInput = [
                            f"Tile_X{x + i - 1}Y{y + j}_{p.name}"
                            for p in self.fabric.tile[y + j][x + i - 1].getEastPorts(
                                IO.OUTPUT
                            )
                        ]
                        portsPairs += list(zip(eastPorts, eastInput, strict=False))

                    # input connection from south side of the north tile
                    if (
                        0 <= y - 1 < len(self.fabric.tile)
                        and self.fabric.tile[y + j - 1][x + i] is not None
                        and (x + i, y + j - 1) not in superTileLoc
                    ):
                        if self.fabric.tile[y + j][x + i].partOfSuperTile:
                            southPorts = [
                                f"Tile_X{i}Y{j}_{p.name}"
                                for p in self.fabric.tile[y + j][x + i].getSouthPorts(
                                    IO.INPUT
                                )
                            ]
                        else:
                            southPorts = [
                                i.name
                                for i in self.fabric.tile[y + j][x + i].getSouthPorts(
                                    IO.INPUT
                                )
                            ]

                        southInput = [
                            f"Tile_X{x + i}Y{y + j - 1}_{p.name}"
                            for p in self.fabric.tile[y + j - 1][x + i].getSouthPorts(
                                IO.OUTPUT
                            )
                        ]
                        portsPairs += list(zip(southPorts, southInput, strict=False))

                    # input connection from west side of the east tile
                    if (
                        0 <= x + 1 < len(self.fabric.tile[0])
                        and self.fabric.tile[y + j][x + i + 1] is not None
                        and (x + i + 1, y + j) not in superTileLoc
                    ):
                        if self.fabric.tile[y + j][x + i].partOfSuperTile:
                            westPorts = [
                                f"Tile_X{i}Y{j}_{p.name}"
                                for p in self.fabric.tile[y + j][x + i].getWestPorts(
                                    IO.INPUT
                                )
                            ]
                        else:
                            westPorts = [
                                i.name
                                for i in self.fabric.tile[y + j][x + i].getWestPorts(
                                    IO.INPUT
                                )
                            ]

                        westInput = [
                            f"Tile_X{x + i + 1}Y{y + j}_{p.name}"
                            for p in self.fabric.tile[y + j][x + i + 1].getWestPorts(
                                IO.OUTPUT
                            )
                        ]
                        portsPairs += list(zip(westPorts, westInput, strict=False))

                # output signal name is same as the output port name
                if superTile:
                    portsAround = superTile.getPortsAroundTile()
                    cord = [
                        (i.split(",")[0], i.split(",")[1])
                        for i in list(portsAround.keys())
                    ]
                    cord = list(zip(cord, portsAround.values(), strict=False))
                    for (i, j), around in cord:
                        for ports in around:
                            for port in ports:
                                if port.inOut == IO.OUTPUT and port.name != "NULL":
                                    portsPairs.append(
                                        (
                                            f"Tile_X{int(i)}Y{int(j)}_{port.name}",
                                            f"Tile_X{x + int(i)}Y{y + int(j)}_{port.name}",
                                        )
                                    )
                else:
                    for i in tile.getTileOutputNames():
                        portsPairs.append((i, f"Tile_X{x}Y{y}_{i}"))

                self.writer.addNewLine()
                self.writer.addComment(
                    "tile IO port will get directly connected to top-level tile module",
                    onNewLine=True,
                    indentLevel=0,
                )
                for i, j in tileLocationOffset:
                    for b in self.fabric.tile[y + j][x + i].bels:
                        for p in b.externalInput:
                            portsPairs.append((p, f"Tile_X{x + i}Y{y + j}_{p}"))

                        for p in b.externalOutput:
                            portsPairs.append((p, f"Tile_X{x + i}Y{y + j}_{p}"))

                        for p in b.sharedPort:
                            if "UserCLK" not in p[0]:
                                portsPairs.append(("UserCLK", p[0]))

                if not superTile:
                    # for userCLK
                    if (
                        y + 1 < self.fabric.numberOfRows
                        and self.fabric.tile[y + 1][x] is not None
                    ):
                        portsPairs.append(("UserCLK", f"Tile_X{x}Y{y + 1}_UserCLKo"))
                    else:
                        portsPairs.append(("UserCLK", "UserCLK"))

                    # for userCLKo
                    portsPairs.append(("UserCLKo", f"Tile_X{x}Y{y}_UserCLKo"))
                else:
                    for i, j in tileLocationOffset:
                        # prefix for super tile port
                        if superTile:
                            pre = f"Tile_X{i}Y{j}_"
                        else:
                            pre = ""
                        # UserCLK signal
                        if y + 1 >= self.fabric.numberOfRows:
                            portsPairs.append((f"{pre}UserCLK", "UserCLK"))

                        elif (
                            y + 1 < self.fabric.numberOfRows
                            and self.fabric.tile[y + 1][x] is None
                        ):
                            portsPairs.append((f"{pre}UserCLK", "UserCLK"))

                        elif (x + i, y + j + 1) not in superTileLoc:
                            portsPairs.append(
                                (f"{pre}UserCLK", f"Tile_X{x + i}Y{y + j + 1}_UserCLKo")
                            )

                        # UserCLKo signal
                        if (x + i, y + j - 1) not in superTileLoc:
                            portsPairs.append(
                                (f"{pre}UserCLKo", f"Tile_X{x + i}Y{y + j}_UserCLKo")
                            )

                if self.fabric.configBitMode == ConfigBitMode.FRAME_BASED:
                    for i, j in tileLocationOffset:
                        # prefix for super tile port
                        if superTile:
                            pre = f"Tile_X{i}Y{j}_"
                        else:
                            pre = ""

                        supertile_x = x + i
                        supertile_y = y + j

                        # Connect the FrameData port to the previous tiles'
                        # (to the west of it) FrameData_O signals.
                        # If the previous tile is NULL, continue the search.
                        # If all previous tiles are NULL, connect to the fabrics
                        # Row_Y{y}_FrameData signals.

                        done = False

                        # Get all x-positions to the west of this tile
                        for search_x in range(supertile_x - 1, -1, -1):
                            # Previous tile is part of the same supertile.
                            # FrameData signals are connected internally.
                            # Stop the search and be done.
                            if (search_x, supertile_y) in superTileLoc:
                                done = True
                                break

                            # Previous tile is NULL, continue search
                            if self.fabric.tile[supertile_y][search_x] is None:
                                continue

                            # Found a non-NULL tile, connect FrameData
                            portsPairs.append(
                                (
                                    f"{pre}FrameData",
                                    f"Tile_X{search_x}Y{supertile_y}_FrameData_O",
                                )
                            )

                            done = True
                            break

                        # No non-NULL tile was found, and tile is not part of a supertile.
                        # Connect to the fabrics Row_Y{y}_FrameData signals.
                        if not done:
                            portsPairs.append(
                                (f"{pre}FrameData", f"Row_Y{supertile_y}_FrameData")
                            )

                        # Connecting FrameData_O is easier:
                        # Always connect FrameData_O, except the next tile (to the east of it)
                        # in the row is part of the supertile (already connected internally).
                        if (supertile_x + 1, supertile_y) not in superTileLoc:
                            portsPairs.append(
                                (
                                    f"{pre}FrameData_O",
                                    f"Tile_X{supertile_x}Y{supertile_y}_FrameData_O",
                                )
                            )

                        # Connect the FrameStrobe port to the previous tiles'
                        # (to the south of it) FrameStrobe_O signals.
                        # If the previous tile is NULL, continue the search.
                        # If all previous tiles are NULL, connect to the fabrics
                        # Column_X{x}_FrameStrobe signals.

                        done = False

                        # Get all y-positions to the south of this tile
                        # Note: the FrameStrobe signals come from the bottom of the
                        #       fabric, therefore count upwards
                        for search_y in range(
                            supertile_y + 1, self.fabric.numberOfRows
                        ):
                            # Previous tile is part of the same supertile.
                            # FrameStrobe signals are connected internally.
                            # Stop the search and be done.
                            if (supertile_x, search_y) in superTileLoc:
                                done = True
                                break

                            # Previous tile is NULL, continue search
                            if self.fabric.tile[search_y][supertile_x] is None:
                                continue

                            # Found a non-NULL tile, connect FrameStrobe
                            portsPairs.append(
                                (
                                    f"{pre}FrameStrobe",
                                    f"Tile_X{supertile_x}Y{search_y}_FrameStrobe_O",
                                )
                            )

                            done = True
                            break

                        # No non-NULL tile was found, and tile is not part of a supertile.
                        # Connect to the fabrics Column_X{x}_FrameStrobe signals.
                        if not done:
                            portsPairs.append(
                                (
                                    f"{pre}FrameStrobe",
                                    f"Column_X{supertile_x}_FrameStrobe",
                                )
                            )

                        # Connecting FrameStrobe_O is easier:
                        # Always connect FrameStrobe_O, except the next tile (to the north of it)
                        # in the column is part of the supertile (already connected internally).
                        if (supertile_x, supertile_y - 1) not in superTileLoc:
                            portsPairs.append(
                                (
                                    f"{pre}FrameStrobe_O",
                                    f"Tile_X{supertile_x}Y{supertile_y}_FrameStrobe_O",
                                )
                            )

                name = ""
                emulateParamPairs = []
                if superTile:
                    name = superTile.name
                    for i, j in tileLocationOffset:
                        if (y + j) not in (0, self.fabric.numberOfRows - 1):
                            emulateParamPairs.append(
                                (
                                    f"Tile_X{i}Y{j}_Emulate_Bitstream",
                                    f"`Tile_X{x + i}Y{y + j}_Emulate_Bitstream",
                                )
                            )
                else:
                    name = tile.name
                    if y not in (0, self.fabric.numberOfRows - 1):
                        emulateParamPairs.append(
                            ("Emulate_Bitstream", f"`Tile_X{x}Y{y}_Emulate_Bitstream")
                        )

                self.writer.addInstantiation(
                    compName=name,
                    compInsName=f"Tile_X{x}Y{y}_{name}",
                    portsPairs=portsPairs,
                    emulateParamPairs=emulateParamPairs,
                )
        self.writer.addDesignDescriptionEnd()
        self.writer.writeToFile()

    def generateTopWrapper(self) -> None:
        """Generate the top wrapper of the fabric including features that are not
        located inside the fabric such as BRAM."""

        def split_port(p):
            # split a port according to how we want to sort external ports:
            # ((y, x), (indices...), basename)
            # Tile_X9Y6_RAM2FAB_D1_I0 --> ((6, 9), (1, 0), "RAM2FAB_D_I")
            m = re.match(r"Tile_X(\d+)Y(\d+)_(.*)", p)
            x = int(m.group(1))
            y = int(m.group(2))
            port = m.group(3)

            basename = ""
            numbuf = ""
            indices = []
            got_split = False
            for ch in port:
                if ch.isnumeric() and got_split:
                    numbuf += ch
                else:
                    if ch == "_":
                        # this way we treat the 2 in RAM2FAB as part of the name, rather than an index
                        got_split = True
                    if numbuf != "":
                        indices.append(int(numbuf))
                    basename += ch

            if numbuf != "":
                indices.append(int(numbuf))

            # some backwards compat
            basename = basename.removesuffix("_bit")
            # top level IO has A and B parts combined and reverse order
            if len(basename) == 7 and basename[1:] in ("_I_top", "_O_top", "_T_top"):
                assert basename[0] in "ABCDEFGH"
                indices.append(-(ord(basename[0]) - ord("A")))
                basename = basename[2:]

            # Y is in reverse order
            return ((-y, x), tuple(indices), basename)

        # determine external ports so we can group them
        externalPorts = []
        portGroups = dict()
        for y, row in enumerate(self.fabric.tile):
            for x, tile in enumerate(row):
                if tile is not None:
                    for bel in tile.bels:
                        for i in bel.externalInput:
                            externalPorts.append((IO.INPUT, f"Tile_X{x}Y{y}_{i}"))
                        for i in bel.externalOutput:
                            externalPorts.append((IO.OUTPUT, f"Tile_X{x}Y{y}_{i}"))
        for iodir, name in externalPorts:
            _yx, _indices, port = split_port(name)
            if port not in portGroups:
                portGroups[port] = (iodir, [])
            portGroups[port][1].append(name)
        # sort port groups according to vectorisation order
        for _name, g in portGroups.items():
            g[1].sort(key=lambda x: split_port(x))

        # header
        numberOfRows = self.fabric.numberOfRows - 2
        numberOfColumns = self.fabric.numberOfColumns
        self.writer.addHeader(f"{self.fabric.name}_top")
        self.writer.addParameterStart(indentLevel=1)
        self.writer.addParameter("include_eFPGA", "integer", 1, indentLevel=2)
        self.writer.addParameter("NumberOfRows", "integer", numberOfRows, indentLevel=2)
        self.writer.addParameter(
            "NumberOfCols", "integer", self.fabric.numberOfColumns, indentLevel=2
        )
        self.writer.addParameter(
            "FrameBitsPerRow", "integer", self.fabric.frameBitsPerRow, indentLevel=2
        )
        self.writer.addParameter(
            "MaxFramesPerCol", "integer", self.fabric.maxFramesPerCol, indentLevel=2
        )
        self.writer.addParameter(
            "desync_flag", "integer", self.fabric.desync_flag, indentLevel=2
        )
        self.writer.addParameter(
            "FrameSelectWidth", "integer", self.fabric.frameSelectWidth, indentLevel=2
        )
        self.writer.addParameter(
            "RowSelectWidth", "integer", self.fabric.rowSelectWidth, indentLevel=2
        )
        self.writer.addParameterEnd(indentLevel=1)
        self.writer.addPortStart(indentLevel=1)

        self.writer.addComment("External IO port", onNewLine=True, indentLevel=2)
        for name, group in sorted(portGroups.items(), key=lambda x: x[0]):
            if self.fabric.numberOfBRAMs > 0 and (
                "RAM2FAB" in name or "FAB2RAM" in name
            ):
                continue
            self.writer.addPortVector(name, group[0], len(group[1]) - 1, indentLevel=2)
        self.writer.addComment("Config related ports", onNewLine=True, indentLevel=2)
        self.writer.addPortScalar("CLK", IO.INPUT, indentLevel=2)
        self.writer.addPortScalar("resetn", IO.INPUT, indentLevel=2)
        self.writer.addPortScalar("SelfWriteStrobe", IO.INPUT, indentLevel=2)
        self.writer.addPortVector(
            "SelfWriteData", IO.INPUT, self.fabric.frameBitsPerRow - 1, indentLevel=2
        )
        self.writer.addPortScalar("Rx", IO.INPUT, indentLevel=2)
        self.writer.addPortScalar("ComActive", IO.OUTPUT, indentLevel=2)
        self.writer.addPortScalar("ReceiveLED", IO.OUTPUT, indentLevel=2)
        self.writer.addPortScalar("s_clk", IO.INPUT, indentLevel=2)
        self.writer.addPortScalar("s_data", IO.INPUT, indentLevel=2)
        self.writer.addPortEnd()
        self.writer.addHeaderEnd(f"{self.fabric.name}_top")
        self.writer.addDesignDescriptionStart(f"{self.fabric.name}_top")

        # all the wires/connection with in the design
        if "RAM2FAB_D_I" in portGroups and self.fabric.numberOfBRAMs > 0:
            self.writer.addComment("BlockRAM ports", onNewLine=True)
            self.writer.addNewLine()
            self.writer.addConnectionVector("RAM2FAB_D_I", f"{numberOfRows * 4 * 4}-1")
            self.writer.addConnectionVector("FAB2RAM_D_O", f"{numberOfRows * 4 * 4}-1")
            self.writer.addConnectionVector("FAB2RAM_A_O", f"{numberOfRows * 4 * 2}-1")
            self.writer.addConnectionVector("FAB2RAM_C_O", f"{numberOfRows * 4}-1")

        self.writer.addNewLine()
        self.writer.addComment("Signal declarations", onNewLine=True)
        self.writer.addConnectionVector(
            "FrameRegister", "(NumberOfRows*FrameBitsPerRow)-1"
        )
        self.writer.addConnectionVector(
            "FrameSelect", "(MaxFramesPerCol*NumberOfCols)-1"
        )
        self.writer.addConnectionVector(
            "FrameData", "(FrameBitsPerRow*(NumberOfRows+2))-1"
        )
        self.writer.addConnectionVector("FrameAddressRegister", "FrameBitsPerRow-1")
        self.writer.addConnectionScalar("LongFrameStrobe")
        self.writer.addConnectionVector("LocalWriteData", 31)
        self.writer.addConnectionScalar("LocalWriteStrobe")
        self.writer.addConnectionVector("RowSelect", "RowSelectWidth-1")

        if isinstance(self.writer, VHDLWriter):
            basePath = Path(self.writer.outFileName).parent
            if not os.path.exists(f"{basePath}/Frame_Data_Reg.vhdl"):
                raise FileExistsError(
                    "Frame_Data_Reg.vhdl not found in the 'Fabric' directory."
                )
            if not os.path.exists(f"{basePath}/Frame_Select.vhdl"):
                raise FileExistsError(
                    "Frame_Select.vhdl not found in the 'Fabric' directory."
                )
            if not os.path.exists(f"{basePath}/eFPGA_Config.vhdl"):
                raise FileExistsError(
                    "Config.vhdl not found in the 'Fabric' directory."
                )
            if not os.path.exists(f"{basePath}/eFPGA.vhdl"):
                raise FileExistsError(
                    "eFPGA.vhdl not found in the 'Fabric' directory, need to generate the eFPGA first."
                )
            if not os.path.exists(f"{basePath}/BlockRAM_1KB.vhdl"):
                raise FileExistsError(
                    "BlockRAM_1KB.vhdl not found in the 'Fabric' directory."
                )
            self.writer.addComponentDeclarationForFile(
                f"{basePath}/Frame_Data_Reg.vhdl"
            )
            self.writer.addComponentDeclarationForFile(f"{basePath}/Frame_Select.vhdl")
            self.writer.addComponentDeclarationForFile(f"{basePath}/eFPGA_Config.vhdl")
            self.writer.addComponentDeclarationForFile(f"{basePath}/eFPGA.vhdl")
            self.writer.addComponentDeclarationForFile(f"{basePath}/BlockRAM_1KB.vhdl")

        self.writer.addLogicStart()

        if isinstance(self.writer, VerilogWriter):
            self.writer.addPreprocIfNotDef("EMULATION")

        # the config module
        self.writer.addNewLine()
        self.writer.addInstantiation(
            compName="eFPGA_Config",
            compInsName="eFPGA_Config_inst",
            portsPairs=[
                ("CLK", "CLK"),
                ("resetn", "resetn"),
                ("Rx", "Rx"),
                ("ComActive", "ComActive"),
                ("ReceiveLED", "ReceiveLED"),
                ("s_clk", "s_clk"),
                ("s_data", "s_data"),
                ("SelfWriteData", "SelfWriteData"),
                ("SelfWriteStrobe", "SelfWriteStrobe"),
                ("ConfigWriteData", "LocalWriteData"),
                ("ConfigWriteStrobe", "LocalWriteStrobe"),
                ("FrameAddressRegister", "FrameAddressRegister"),
                ("LongFrameStrobe", "LongFrameStrobe"),
                ("RowSelect", "RowSelect"),
            ],
            paramPairs=[
                ("RowSelectWidth", "RowSelectWidth"),
                ("NumberOfRows", "NumberOfRows"),
                ("desync_flag", "desync_flag"),
                ("FrameBitsPerRow", "FrameBitsPerRow"),
            ],
        )
        self.writer.addNewLine()

        # the frame data reg module
        for row in range(numberOfRows):
            self.writer.addInstantiation(
                compName="Frame_Data_Reg",
                compInsName=f"inst_Frame_Data_Reg_{row}",
                portsPairs=[
                    ("FrameData_I", "LocalWriteData"),
                    (
                        "FrameData_O",
                        f"FrameRegister[{row}*FrameBitsPerRow+FrameBitsPerRow-1:{row}*FrameBitsPerRow]",
                    ),
                    ("RowSelect", "RowSelect"),
                    ("CLK", "CLK"),
                ],
                paramPairs=[
                    ("FrameBitsPerRow", "FrameBitsPerRow"),
                    ("RowSelectWidth", "RowSelectWidth"),
                    ("Row", str(row + 1)),
                ],
            )
        self.writer.addNewLine()

        # the frame select module
        for col in range(numberOfColumns):
            self.writer.addInstantiation(
                compName="Frame_Select",
                compInsName=f"inst_Frame_Select_{col}",
                portsPairs=[
                    ("FrameStrobe_I", "FrameAddressRegister[MaxFramesPerCol-1:0]"),
                    (
                        "FrameStrobe_O",
                        f"FrameSelect[{col}*MaxFramesPerCol+MaxFramesPerCol-1:{col}*MaxFramesPerCol]",
                    ),
                    (
                        "FrameSelect",
                        "FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]",
                    ),
                    ("FrameStrobe", "LongFrameStrobe"),
                ],
                paramPairs=[
                    ("MaxFramesPerCol", "MaxFramesPerCol"),
                    ("FrameSelectWidth", "FrameSelectWidth"),
                    ("Col", str(col)),
                ],
            )
        self.writer.addNewLine()

        if isinstance(self.writer, VerilogWriter):
            self.writer.addPreprocEndif()

        # the fabric module
        portList = []
        signal = []

        # external ports (IO, config access, BRAM, etc)
        for name, group in sorted(portGroups.items(), key=lambda x: x[0]):
            for i, sig in enumerate(group[1]):
                portList.append(sig)
                signal.append(f"{name}[{i}]")

        portList.append("UserCLK")
        signal.append("CLK")

        portList.append("FrameData")
        signal.append("FrameData")

        portList.append("FrameStrobe")
        signal.append("FrameSelect")

        assert len(portList) == len(signal)
        self.writer.addInstantiation(
            compName=self.fabric.name,
            compInsName=f"{self.fabric.name}_inst",
            portsPairs=list(zip(portList, signal, strict=False)),
        )

        self.writer.addNewLine()

        # the BRAM module
        if "RAM2FAB_D_I" in portGroups and self.fabric.numberOfBRAMs > 0:
            data_cap = int((numberOfRows * 4 * 4) / (self.fabric.numberOfBRAMs - 1))
            addr_cap = int((numberOfRows * 4 * 2) / (self.fabric.numberOfBRAMs - 1))
            config_cap = int((numberOfRows * 4) / (self.fabric.numberOfBRAMs - 1))
            for i in range(self.fabric.numberOfBRAMs - 1):
                portsPairs = [
                    ("clk", "CLK"),
                    ("rd_addr", f"FAB2RAM_A_O[{addr_cap * i + 8 - 1}:{addr_cap * i}]"),
                    ("rd_data", f"RAM2FAB_D_I[{data_cap * i + 32 - 1}:{data_cap * i}]"),
                    (
                        "wr_addr",
                        f"FAB2RAM_A_O[{addr_cap * i + 16 - 1}:{addr_cap * i + 8}]",
                    ),
                    ("wr_data", f"FAB2RAM_D_O[{data_cap * i + 32 - 1}:{data_cap * i}]"),
                    ("C0", f"FAB2RAM_C_O[{config_cap * i}]"),
                    ("C1", f"FAB2RAM_C_O[{config_cap * i + 1}]"),
                    ("C2", f"FAB2RAM_C_O[{config_cap * i + 2}]"),
                    ("C3", f"FAB2RAM_C_O[{config_cap * i + 3}]"),
                    ("C4", f"FAB2RAM_C_O[{config_cap * i + 4}]"),
                    ("C5", f"FAB2RAM_C_O[{config_cap * i + 5}]"),
                ]
                self.writer.addInstantiation(
                    compName="BlockRAM_1KB",
                    compInsName=f"Inst_BlockRAM_{i}",
                    portsPairs=portsPairs,
                )
        if isinstance(self.writer, VHDLWriter):
            self.writer.addAssignScalar(
                "FrameData", ['X"12345678"', "FrameRegister", 'X"12345678"']
            )
        else:
            self.writer.addAssignScalar(
                "FrameData", ["32'h12345678", "FrameRegister", "32'h12345678"]
            )
        self.writer.addDesignDescriptionEnd()
        self.writer.writeToFile()

    def generateBitsStreamSpec(self) -> dict[str, dict]:
        """Generate the bitstream specification of the fabric. This is needed and will
        be further parsed by the bit_gen.py.

        Returns
        -------
        dict [str, dict]
            The bits stream specification of the fabric.
        """

        specData = {
            "TileMap": {},
            "TileSpecs": {},
            "TileSpecs_No_Mask": {},
            "FrameMap": {},
            "FrameMapEncode": {},
            "ArchSpecs": {
                "MaxFramesPerCol": self.fabric.maxFramesPerCol,
                "FrameBitsPerRow": self.fabric.frameBitsPerRow,
            },
        }

        tileMap = {}
        for y, row in enumerate(self.fabric.tile):
            for x, tile in enumerate(row):
                if tile is not None:
                    tileMap[f"X{x}Y{y}"] = tile.name
                else:
                    tileMap[f"X{x}Y{y}"] = "NULL"

        specData["TileMap"] = tileMap
        configMemList: list[ConfigMem] = []
        for y, row in enumerate(self.fabric.tile):
            for x, tile in enumerate(row):
                if tile is None:
                    continue
                if "fabric.csv" in str(tile.tileDir):
                    # backward compatibility for old project structure
                    # We need to take the matrixDir from the tile, since there
                    # is the actual path to the tile defined in the fabric.csv
                    if tile.matrixDir.is_file():
                        configMemPath = (
                            tile.matrixDir.parent / f"{tile.name}_ConfigMem.csv"
                        )
                    elif tile.matrixDir.is_dir():
                        configMemPath = tile.matrixDir / f"{tile.name}_ConfigMem.csv"
                    else:
                        configMemPath = (
                            Path(os.getenv("FAB_PROJ_DIR"))
                            / "Tile"
                            / tile.name
                            / f"{tile.name}_ConfigMem.csv"
                        )
                        logger.warning(
                            f"MatrixDir for {tile.name} is not a valid file or directory. Assuming default path: {configMemPath}"
                        )
                else:
                    configMemPath = tile.tileDir.parent.joinpath(
                        f"{tile.name}_ConfigMem.csv"
                    )
                logger.info(f"ConfigMemPath: {configMemPath}")

                if configMemPath.exists() and configMemPath.is_file():
                    configMemList = parseConfigMem(
                        configMemPath,
                        self.fabric.maxFramesPerCol,
                        self.fabric.frameBitsPerRow,
                        tile.globalConfigBits,
                    )
                elif tile.globalConfigBits > 0:
                    logger.critical(
                        f"No ConfigMem csv file found for {tile.name} which have config bits"
                    )
                    configMemList = []
                else:
                    logger.info(f"No config memory for {tile.name}.")
                    configMemList = []

                encodeDict = [-1] * (
                    self.fabric.maxFramesPerCol * self.fabric.frameBitsPerRow
                )
                maskDic = {}
                for cfm in configMemList:
                    maskDic[cfm.frameIndex] = cfm.usedBitMask
                    # matching the value in the configBitRanges with the reversedBitMask
                    # bit 0 in bit mask is the first value in the configBitRanges
                    for i, char in enumerate(cfm.usedBitMask):
                        if char == "1":
                            encodeDict[cfm.configBitRanges.pop(0)] = (
                                self.fabric.frameBitsPerRow - 1 - i
                            ) + self.fabric.frameBitsPerRow * cfm.frameIndex

                # filling the maskDic with the unused frames
                for i in range(self.fabric.maxFramesPerCol - len(configMemList)):
                    maskDic[len(configMemList) + i] = "0" * self.fabric.frameBitsPerRow

                specData["FrameMap"][tile.name] = maskDic
                if tile.globalConfigBits == 0:
                    logger.info(f"No config memory for X{x}Y{y}_{tile.name}.")
                    specData["FrameMap"][tile.name] = {}
                    specData["FrameMapEncode"][tile.name] = {}

                curBitOffset = 0
                curTileMap = {}
                curTileMapNoMask = {}

                for i, bel in enumerate(tile.bels):
                    for featureKey, keyDict in bel.belFeatureMap.items():
                        for entry in keyDict:
                            if isinstance(entry, int):
                                for v in keyDict[entry]:
                                    curTileMap[
                                        f"{string.ascii_uppercase[i]}.{featureKey}"
                                    ] = {
                                        encodeDict[curBitOffset + v]: keyDict[entry][v]
                                    }
                                    curTileMapNoMask[
                                        f"{string.ascii_uppercase[i]}.{featureKey}"
                                    ] = {
                                        encodeDict[curBitOffset + v]: keyDict[entry][v]
                                    }
                                curBitOffset += len(keyDict[entry])

                # All the generation will be working on the tile level with the tileDic
                # This is added to propagate the updated switch matrix to each of the tile in the fabric
                if tile.matrixDir.suffix == ".list":
                    tile.matrixDir = tile.matrixDir.with_suffix(".csv")

                result = parseMatrix(tile.matrixDir, tile.name)
                for source, sinkList in result.items():
                    controlWidth = 0
                    for i, sink in enumerate(reversed(sinkList)):
                        controlWidth = (len(sinkList) - 1).bit_length()
                        controlValue = f"{len(sinkList) - 1 - i:0{controlWidth}b}"
                        pip = f"{sink}.{source}"
                        if len(sinkList) < 2:
                            curTileMap[pip] = {}
                            curTileMapNoMask[pip] = {}
                            continue

                        for c, curChar in enumerate(controlValue[::-1]):
                            if pip not in curTileMap.keys():
                                curTileMap[pip] = {}
                                curTileMapNoMask[pip] = {}

                            curTileMap[pip][encodeDict[curBitOffset + c]] = curChar
                            curTileMapNoMask[pip][encodeDict[curBitOffset + c]] = (
                                curChar
                            )

                    curBitOffset += controlWidth

                # And now we add empty config bit mappings for immutable connections (i.e. wires), as nextpnr sees these the same as normal pips
                for wire in tile.wireList:
                    curTileMap[f"{wire.source}.{wire.destination}"] = {}
                    curTileMapNoMask[f"{wire.source}.{wire.destination}"] = {}

                specData["TileSpecs"][f"X{x}Y{y}"] = curTileMap
                specData["TileSpecs_No_Mask"][f"X{x}Y{y}"] = curTileMapNoMask

        return specData


def generateUserDesignTopWrapper(
    fabric: Fabric, user_design_path: Path, output: Path
) -> None:
    """Generate a top wrapper for the user design.

    Params
    ------
    fabric: Fabric
        Fabric object
    user_design_path: Path
        Path to the user design file
    output: Path
        Path to output the user design top wrapper

    Raises
    ------
    ValueError
        Output file is not a Verilog file or user design path is not a file
    """
    top_wrapper: list[str] = [""]

    if output.suffix != ".v":
        raise InvalidFileType(f"{output} is not a Verilog file")
    if not user_design_path.is_file():
        raise FileNotFoundError(f"{user_design_path} is not a file or does not exist")

    if output.exists():
        logger.warning(f"{output} already exists, overwriting")
        output.unlink()
    else:
        logger.info(f"Creating {output}")
    output.touch()

    if user_design_path.suffix in {".vhdl", ".vhd"}:
        user_design = parseBelFile(user_design_path, "", "vhdl")
    elif user_design_path.suffix in {".v", ".sv"}:
        user_design = parseBelFile(user_design_path, "", "verilog")
    else:
        raise InvalidFileType(
            f"Invalid file type in {user_design_path} only .vhdl and .v are supported."
        )

    top_wrapper.append("// Generated by FABulous")
    top_wrapper.append(f"// Top wrapper for user design {user_design_path}\n")

    top_wrapper.append("module top_wrapper;\n")

    top_wrapper.append("wire clk;")
    top_wrapper.append("(* keep *) Global_Clock clk_i (.CLK(clk));\n")

    bel_count: dict[str, int] = {}  # count how often a bel is instantiated
    bel_inputs: dict[str, list[str]] = {}
    bel_outputs: dict[str, list[str]] = {}

    # generate component instantioations
    # we walk backwards through the list, since there is something mixed up with the coordinate system
    for y in range(fabric.numberOfRows - 1, -1, -1):
        bels = fabric.getBelsByTileXY(0, y)
        if not bels:
            continue
        for i, bel in enumerate(
            reversed(bels)
        ):  # we walk backwards trough the bel list
            belstr = ""
            # we only add bels with external ports to the top wrapper.
            if not bel.externalInput and not bel.externalOutput:
                logger.info(
                    f"Skipping bel {bel.name} in tile X0Y{y} since it has no external ports"
                )
                continue
            if len(bel.inputs and bel.outputs) == 0:
                logger.info(
                    f"{bel.name} in tile X0Y{y} has no internal ports, only external ports, we just add a dummy to the user design top wrapper!"
                )
                belstr += "//"

            if bel.name not in bel_count:
                bel_count[bel.name] = 0
                bel_inputs[bel.name] = [
                    port.removeprefix(bel.prefix) for port in bel.inputs
                ]
                bel_outputs[bel.name] = [
                    port.removeprefix(bel.prefix) for port in bel.outputs
                ]
            else:
                # count number of times a BEL type is used
                bel_count[bel.name] += 1

            # This is done similar in the npnr model gen, to get the bel prefix
            # So we assume to get the same Bel prefix here.
            # convert number of bel i to character A,B,C ...
            # But we need to do this backwards, starting with the highest letter for a tile
            prefix = chr(ord("A") + len(bels) - 1 - i)
            belstr += (
                f'(* keep, BEL="X0Y{y}.{prefix}" *) {bel.name} bel_X0Y{y}_{prefix} ('
            )

            first = True
            for port in bel.inputs + bel.outputs:
                port_name = port.removeprefix(bel.prefix)
                if first:
                    first = False
                else:
                    belstr += ", "
                belstr += f".{port_name}({bel.name}_{port_name}[{bel_count[bel.name]}])"

            belstr += ");"
            top_wrapper.append(belstr)

    top_wrapper.append("\n")

    for belname in bel_count:
        count = bel_count[belname]
        if bel_inputs[belname]:
            top_wrapper.append(f"// bel {belname} input wires:")
            for port in bel_inputs[belname]:
                top_wrapper.append(f"wire [{count}:0]{belname}_{port};")
        if bel_outputs[belname]:
            top_wrapper.append(f"// bel {belname} output wires:")
            for port in bel_outputs[belname]:
                top_wrapper.append(f"wire [{count}:0]{belname}_{port};")

    top_wrapper.append("\n")

    top_wrapper.append("// instantiate user_design")

    if user_design.language == "vhdl":
        user_design_inst = f"{user_design.name} user_design_i ("
    else:
        user_design_inst = f"{user_design.module_name} user_design_i ("

    if (
        user_design.name == "sequential_16bit_en"
        and "IO_1_bidirectional_frame_config_pass" in bel_count
    ):
        # hardcoded for now
        logger.info(
            "Using default design, with sequential_16bit_en counter and IO_1_bidirectional_frame_config_pass"
        )

        user_design_inst += ".clk(clk), "
        user_design_inst += ".io_in(IO_1_bidirectional_frame_config_pass_O), "
        user_design_inst += ".io_out(IO_1_bidirectional_frame_config_pass_I), "
        user_design_inst += ".io_oeb(IO_1_bidirectional_frame_config_pass_T));"
    else:
        # if its not our default design, we are just instantiate it,
        # and the user needs to take connect the ports
        logger.warning(
            f"Custom design detected, please connect the ports manually in user design top wrapper {user_design_path}!"
        )

        if user_design.language == "vhdl":
            logger.warning(
                f"VHDL design detected, please check the generated top wrapper {top_wrapper} and check the user design module name, as well as the ports!"
            )
            first = True
            for port in user_design.inputs + user_design.outputs:
                if first:
                    first = False
                else:
                    user_design_inst += ", "

                if port in ["clk", "CLK"]:
                    user_design_inst += f".{port}(clk) "
                else:
                    user_design_inst += f".{port}() "
        else:  # verilog
            first = True
            for port in user_design.ports_vectors["internal"]:
                if first:
                    first = False
                else:
                    user_design_inst += ", "

                if port in ["clk", "CLK"]:
                    user_design_inst += f".{port}(clk)"
                else:
                    user_design_inst += f".{port}()"
        user_design_inst += ");"

    top_wrapper.append(user_design_inst)
    top_wrapper.append("\n")

    top_wrapper.append("endmodule //top_wrapper\n")

    # write file
    _ = output.write_text("\n".join(top_wrapper))

    logger.info(
        f"Generated user design top wrapper {output} with {len(top_wrapper)} lines"
    )
