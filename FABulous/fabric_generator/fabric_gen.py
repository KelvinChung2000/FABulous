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


import os
import re
import string
from pathlib import Path
from typing import TYPE_CHECKING

from loguru import logger

from FABulous.custom_exception import InvalidFileType
from FABulous.fabric_definition.define import (
    IO,
)
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.code_generation_Verilog import VerilogWriter
from FABulous.fabric_generator.code_generation_VHDL import VHDLWriter
from FABulous.fabric_generator.code_generator import codeGenerator
from FABulous.fabric_generator.parser.parse_configmem import parseConfigMem
from FABulous.fabric_generator.parser.parse_hdl import parseBelFile
from FABulous.fabric_generator.parser.parse_switchmatrix import (
    parseMatrix,
)

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
