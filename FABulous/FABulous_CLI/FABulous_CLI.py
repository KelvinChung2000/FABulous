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

import argparse
import os
import pprint
import subprocess as sp
import sys
import tkinter as tk
from pathlib import Path
from typing import Literal

from cmd2 import (
    Cmd,
    Cmd2ArgumentParser,
    Settable,
    categorize,
    with_argparser,
    with_category,
)
from loguru import logger

from FABulous.fabric_generator.define import WriterType
from FABulous.FABulous_API import FABulous_API
from FABulous.FABulous_CLI import cmd_helper, cmd_pnr, cmd_synthesis
from FABulous.FABulous_CLI.define import (
    CMD_FABRIC_FLOW,
    CMD_GUI,
    CMD_HELPER,
    CMD_OTHER,
    CMD_SCRIPT,
    CMD_SETUP,
    META_DATA_DIR,
)
from FABulous.FABulous_CLI.helper import (
    allow_blank,
    check_if_application_exists,
    copy_verilog_files,
    make_hex,
    remove_dir,
    wrap_with_except_handling,
)

INTO_STRING = rf"""
     ______      ____        __
    |  ____/\   |  _ \      | |
    | |__ /  \  | |_) |_   _| | ___  _   _ ___
    |  __/ /\ \ |  _ <| | | | |/ _ \| | | / __|
    | | / ____ \| |_) | |_| | | (_) | |_| \__ \
    |_|/_/    \_\____/ \__,_|_|\___/ \__,_|___/


Welcome to FABulous shell
You have started the FABulous shell with following options:
{" ".join(sys.argv[1:])}

Type help or ? to list commands
To see documentation for a command type:
    help <command>
or
    ?<command>

To execute a shell command type:
    shell <command>
or
    !<command>

The shell support tab completion for commands and files

To run the complete FABulous flow with the default project, run the following command:
    load_fabric
    run_FABulous_fabric
    run_FABulous_bitstream ./user_design/sequential_16bit_en.v
    run_simulation fst ./user_design/sequential_16bit_en.bin
"""


class FABulous_CLI(Cmd):
    intro: str = INTO_STRING
    prompt: str = "FABulous> "
    fabulousAPI: FABulous_API
    projectDir: Path
    fabricFilePath: Path
    extension: Literal[".v", ".sv", ".vhdl"] = ".v"
    script: str = ""

    def __init__(
        self,
        writerType: WriterType,
        projectDir: Path,
        FABulousScript: Path = Path(),
        TCLScript: Path = Path(),
    ):
        """Initialises the FABulous shell instance.

        Determines file extension based on the type of writer used in 'fab'
        and sets fabricLoaded to true if 'fab' has 'fabric' attribute.

        Parameters
        ----------
        writerType : str
            The writer type to use for generating fabric.
        projectDir : Path
            Path to the project directory.
        script : str, optional
            Path to optional Tcl script to be executed, by default ""
        """
        super().__init__(
            persistent_history_file=f"{os.getenv('FAB_PROJ_DIR')}/{META_DATA_DIR}/.fabulous_history",
            allow_cli_args=False,
            startup_script=str(FABulousScript) if not FABulousScript.is_dir() else "",
        )

        self.projectDir = projectDir.absolute()
        self.add_settable(
            Settable("projectDir", Path, "The directory of the project", self)
        )

        self.tiles = []
        self.superTiles = []

        if Path(projectDir / "fabric.csv").exists():
            logger.info("Found fabric.csv in the project directory")
            self.fabricFilePath = Path(projectDir / "fabric.csv")
            logger.info(
                f"Setting environment variable fabricFilePath to {self.fabricFilePath}"
            )
        elif Path(projectDir / "fabric.yaml").exists():
            logger.info("Found fabric.yaml in the project directory")
            self.fabricFilePath = Path(projectDir / "fabric.yaml")
            logger.info(
                f"Setting environment variable fabricFilePath to {self.fabricFilePath}"
            )
        else:
            logger.info(
                "Cannot find fabric.csv or fabric.yaml in the project directory, will not set default path for load_fabric"
            )

        self.add_settable(
            Settable(
                "fabricFilePath",
                Path,
                "The fabric file ",
                self,
                completer=Cmd.path_complete,
            )
        )

        self.fabulousAPI = FABulous_API(writeType=writerType)

        self.verbose = False
        self.add_settable(Settable("verbose", bool, "verbose output", self))

        if writerType is WriterType.VERILOG:
            self.extension = ".v"
        elif writerType is WriterType.SYSTEM_VERILOG:
            self.extension = ".sv"
        elif writerType is WriterType.VHDL:
            self.extension = ".vhdl"

        categorize(self.do_alias, CMD_OTHER)
        categorize(self.do_edit, CMD_OTHER)
        categorize(self.do_shell, CMD_OTHER)
        categorize(self.do_exit, CMD_OTHER)
        categorize(self.do_quit, CMD_OTHER)
        categorize(self.do_set, CMD_OTHER)
        categorize(self.do_history, CMD_OTHER)
        categorize(self.do_shortcuts, CMD_OTHER)
        categorize(self.do_help, CMD_OTHER)
        categorize(self.do_macro, CMD_OTHER)

        categorize(self.do_run_script, CMD_SCRIPT)
        categorize(self.do_run_tcl, CMD_SCRIPT)
        categorize(self.do_run_pyscript, CMD_SCRIPT)

        self.tcl = tk.Tcl()
        for fun in dir(self.__class__):
            f = getattr(self, fun)
            if fun.startswith("do_") and callable(f):
                name = fun.strip("do_")
                self.tcl.createcommand(name, wrap_with_except_handling(f))

        self.disable_category(
            CMD_FABRIC_FLOW, "Fabric Flow commands are disabled until fabric is loaded"
        )
        self.disable_category(
            CMD_GUI, "GUI commands are disabled until gen_gen_geometry is run"
        )
        self.disable_category(
            CMD_HELPER, "Helper commands are disabled until fabric is loaded"
        )

        if not TCLScript.is_dir() and TCLScript.exists():
            self._startup_commands.append(f"run_tcl {TCLScript}")
            self._startup_commands.append("exit")
        elif not TCLScript.is_dir() and not TCLScript.exists():
            logger.error(f"Cannot find {TCLScript}")
            exit(1)

        if not FABulousScript.is_dir() and FABulousScript.exists():
            self._startup_commands.append(f"run_script {FABulousScript}")
            self._startup_commands.append("exit")
        elif not FABulousScript.is_dir() and not FABulousScript.exists():
            logger.error(f"Cannot find {FABulousScript}")
            exit(1)

    def do_exit(self, *ignored):
        """Exits the FABulous shell and logs info message."""
        logger.info("Exiting FABulous shell")
        return True

    do_quit = do_exit
    do_add_tile = cmd_helper.do_add_tile
    do_add_bel_to_tile = cmd_helper.do_add_bel_to_tile

    filePathOptionalParser = Cmd2ArgumentParser()
    filePathOptionalParser.add_argument(
        "file",
        type=Path,
        help="Path to the target file",
        default="",
        nargs=argparse.OPTIONAL,
        completer=Cmd.path_complete,
    )

    filePathRequireParser = Cmd2ArgumentParser()
    filePathRequireParser.add_argument(
        "file", type=Path, help="Path to the target file", completer=Cmd.path_complete
    )

    tile_list_parser = Cmd2ArgumentParser()
    tile_list_parser.add_argument(
        "tiles",
        type=str,
        help="A list of tile",
        nargs="+",
        completer=lambda self: self.fab.getTiles(),
    )

    tile_single_parser = Cmd2ArgumentParser()
    tile_single_parser.add_argument(
        "tile",
        type=str,
        help="A tile",
        completer=lambda self: self.fab.getTiles(),
    )

    @with_category(CMD_SETUP)
    @allow_blank
    @with_argparser(filePathOptionalParser)
    def do_load_fabric(self, args):
        """Loads 'fabric.csv' file and generates an internal representation of the
        fabric. Does this by parsing input arguments, sets an internal state to indicate
        that fabric is loaded and determines the available tiles by comparing
        directories in the project with tiles defined by fabric.

        Logs error if no CSV file is found.
        """

        # if no argument is given will use the one set by set_fabric_csv
        # else use the argument
        logger.info("Loading fabric")
        if args.file.is_dir():
            if self.fabricFilePath.exists():
                logger.info(
                    f"Found {self.fabricFilePath.name} in the project directory loading that file as the definition of the fabric"
                )
                self.fabulousAPI.loadFabric(self.fabricFilePath)
            else:
                logger.error(
                    "No argument is given and the csv file is set or the file does not exist"
                )
                return
        else:
            self.fabulousAPI.loadFabric(args.file)
            self.fabricFilePath = args.file

        self.fabricLoaded = True

        self.enable_category(CMD_FABRIC_FLOW)
        logger.info("Complete")

    @with_category(CMD_HELPER)
    def do_print_bel(self, args):
        """Prints a Bel object to the console."""
        if len(args) != 1:
            logger.error("Please provide a Bel name")
            return

        if not self.fabricLoaded:
            logger.error("Need to load fabric first")
            return

        bels = self.fabulousAPI.getBels()
        for i in bels:
            if i.name == args[0]:
                logger.info(f"\n{pprint.pformat(i, width=200)}")
                return
        logger.error("Bel not found")

    @with_category(CMD_HELPER)
    @with_argparser(tile_single_parser)
    def do_print_tile(self, args):
        """Prints a tile object to the console."""

        if not self.fabricLoaded:
            logger.error("Need to load fabric first")
            return

        if tile := self.fabulousAPI.getTile(args.tile):
            logger.info(f"\n{pprint.pformat(tile, width=200)}")
        elif tile := self.fabulousAPI.getSuperTile(args[0]):
            logger.info(f"\n{pprint.pformat(tile, width=200)}")
        else:
            logger.error("Tile not found")

    @with_category(CMD_FABRIC_FLOW)
    @with_argparser(tile_list_parser)
    def do_gen_config_mem(self, args):
        """Generates configuration memory of the given tile by by parsing input
        arguments and calling 'genConfigMem'.

        Logs generation processes for each specified tile.
        """
        logger.info(f"Generating Config Memory for {' '.join(args.tiles)}")
        for i in args.tiles:
            logger.info(f"Generating configMem for {i}")
            self.fabulousAPI.genConfigMem(
                i,
                self.projectDir / f"Tile/{i}/{i}_ConfigMem.csv",
                self.projectDir / f"Tile/{i}/{i}_ConfigMem.{self.extension}",
            )
        logger.info("Generating configMem complete")

    @with_category(CMD_FABRIC_FLOW)
    @with_argparser(tile_list_parser)
    def do_gen_switch_matrix(self, args):
        """Generates switch matrix of given tile by parsing input arguments and calling
        'genSwitchMatrix'.

        Also logs generation process for each specified tile.
        """
        logger.info(f"Generating switch matrix for {' '.join(args.tiles)}")
        for i in args.tiles:
            logger.info(f"Generating switch matrix for {i}")
            self.fabulousAPI.genSwitchMatrix(
                i, self.projectDir / f"Tile/{i}/{i}_switch_matrix.{self.extension}"
            )
        logger.info("Switch matrix generation complete")

    @with_category(CMD_FABRIC_FLOW)
    @with_argparser(tile_list_parser)
    def do_gen_tile(self, args):
        """Generates given tile with switch matrix and configuration memory by parsing
        input arguments, calls functions such as 'genSwitchMatrix' and 'genConfigmem'.
        Handles both regular tiles and super tiles with sub-tiles.

        Also logs generation process for each specified tile and sub-tile.
        """

        logger.info(f"Generating tile {' '.join(args.tiles)}")
        for t in args.tiles:
            if (self.projectDir / f"Tile/{t}/metadata/superTile").exists():
                with open((self.projectDir / f"Tile/{t}/metadata/superTile"), "r") as f:
                    subTiles = f.readlines()
                logger.info(
                    f"{t} is a super tile, generating {t} with sub tiles {' '.join(subTiles)}"
                )
                for st in subTiles:
                    # Gen switch matrix
                    logger.info(f"Generating switch matrix for tile {t}")
                    logger.info(f"Generating switch matrix for {st}")
                    self.fabulousAPI.genSwitchMatrix(
                        st,
                        Path(
                            f"{self.projectDir}/Tile/{t}/{st}/{st}_switch_matrix.{self.extension}"
                        ),
                    )
                    logger.info(f"Generated switch matrix for {st}")

                    # Gen config mem
                    logger.info(f"Generating configMem for tile {t}")
                    logger.info(f"Generating ConfigMem for {st}")
                    self.fabulousAPI.genConfigMem(
                        st,
                        self.projectDir / f"Tile/{t}/{st}/{st}_ConfigMem.csv",
                        Path(
                            f"{self.projectDir}/Tile/{t}/{st}/{st}_ConfigMem.{self.extension}"
                        ),
                    )
                    logger.info(f"Generated configMem for {st}")

                    # Gen tile
                    logger.info(f"Generating subtile for tile {t}")
                    logger.info(f"Generating subtile {st}")
                    self.fabulousAPI.genTile(
                        st,
                        Path(f"{self.projectDir}/Tile/{t}/{st}/{st}.{self.extension}"),
                    )
                    logger.info(f"Generated subtile {st}")

                # Gen super tile
                logger.info(f"Generating super tile {t}")
                self.fabulousAPI.genSuperTile(
                    t, Path(f"{self.projectDir}/Tile/{t}/{t}.{self.extension}")
                )
                logger.info(f"Generated super tile {t}")
                continue

            # Gen switch matrix
            self.do_gen_switch_matrix(t)

            # Gen config mem
            self.do_gen_config_mem(t)

            logger.info(f"Generating tile {t}")
            # Gen tile
            self.fabulousAPI.genTile(
                t, Path(f"{self.projectDir}/Tile/{t}/{t}.{self.extension}")
            )
            logger.info(f"Generated tile {t}")

        logger.info("Tile generation complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_all_tile(self, *ignored):
        """Generates all tiles by calling 'do_gen_tile'."""
        logger.info("Generating all tiles")
        self.do_gen_tile(" ".join(list(self.fabulousAPI.getTilesNames())))
        logger.info("Generated all tiles")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_fabric(self, *ignored):
        """Generates fabric based on the loaded fabric by calling 'do_gen_all_tile' and
        'genFabric'.

        Logs start and completion of fabric generation process.
        """
        logger.info(f"Generating fabric {self.fabulousAPI.fabric.name}")
        self.do_gen_all_tile()
        self.fabulousAPI.genFabric(
            Path(
                f"{self.projectDir}/Fabric/{self.fabulousAPI.fabric.name}{self.extension}"
            )
        )
        logger.info("Fabric generation complete")

    geometryParser = Cmd2ArgumentParser()
    geometryParser.add_argument(
        "padding",
        type=int,
        help="Padding value for geometry generation",
        choices=range(4, 33),
        metavar="[4-32]",
        nargs="?",
        default=8,
    )

    @with_category(CMD_FABRIC_FLOW)
    @allow_blank
    @with_argparser(geometryParser)
    def do_gen_geometry(self, args):
        """Generates geometry of fabric for FABulator by checking if fabric is loaded,
        and calling 'genGeometry' and passing on padding value. Default padding is '8'.

        Also logs geometry generation, the used padding value and any warning about
        faulty padding arguments, as well as errors if the fabric is not loaded or the
        padding is not within the valid range of 4 to 32.
        """
        logger.info(f"Generating geometry for {self.fabulousAPI.fabric.name}")
        geomFile = f"{self.projectDir}/{self.fabulousAPI.fabric.name}_geometry.csv"
        self.fabulousAPI.setWriterOutputFile(geomFile)

        self.fabulousAPI.genGeometry(args.padding)
        logger.info("Geometry generation complete")
        logger.info(f"{geomFile} can now be imported into FABulator")

    @with_category(CMD_GUI)
    def do_start_FABulator(self, *ignored):
        """Starts FABulator if an installation can be found.

        If no installation can be found, a warning is produced.
        """
        logger.info("Checking for FABulator installation")
        fabulatorRoot = os.getenv("FABULATOR_ROOT")

        if fabulatorRoot is None:
            logger.warning("FABULATOR_ROOT environment variable not set.")
            logger.warning(
                "Install FABulator (https://github.com/FPGA-Research-Manchester/FABulator) "
                "and set the FABULATOR_ROOT environment variable to the root directory to use this feature."
            )
            return

        if not os.path.exists(fabulatorRoot):
            logger.error(
                f"FABULATOR_ROOT environment variable set to {fabulatorRoot} but the directory does not exist."
            )
            return

        logger.info(f"Found FABulator installation at {fabulatorRoot}")
        logger.info("Trying to start FABulator...")

        startupCmd = ["mvn", "-f", f"{fabulatorRoot}/pom.xml", "javafx:run"]
        try:
            if self.verbose:
                # log FABulator output to the FABulous shell
                sp.Popen(startupCmd)
            else:
                # discard FABulator output
                sp.Popen(startupCmd, stdout=sp.DEVNULL, stderr=sp.DEVNULL)

        except sp.SubprocessError:
            logger.error("Startup of FABulator failed.")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_bitStream_spec(self, *ignored):
        """Generates bitstream specification of the fabric by calling 'genBitStreamspec'
        and saving the specification to a binary and CSV file.

        Also logs the paths of the output files.
        """
        logger.info("Generating bitstream specification")
        specObject = self.fabulousAPI.genBitStreamSpec()

        logger.info(
            f"output file: {self.projectDir}/{META_DATA_DIR}/bitStreamSpec.yaml"
        )
        with open(
            f"{self.projectDir}/{META_DATA_DIR}/bitStreamSpec.txt", "w"
        ) as outFile:
            outFile.write(pprint.pformat(specObject, width=200))
        logger.info("Generated bitstream specification")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_top_wrapper(self, *ignored):
        """Generates top wrapper of the fabric by calling 'genTopWrapper'."""
        logger.info("Generating top wrapper")
        self.fabulousAPI.genTopWrapper(
            Path(
                f"{self.projectDir}/Fabric/{self.fabulousAPI.fabric.name}_top.{self.extension}"
            )
        )
        logger.info("Generated top wrapper")

    @with_category(CMD_FABRIC_FLOW)
    @allow_blank
    def do_run_FABulous_fabric(self, *ignored):
        """Generates the fabric based on the CSV file, creates bitstream specification
        of the fabric, top wrapper of the fabric, Nextpnr model of the fabric and
        geometry information of the fabric.

        Does this by calling the respective functions 'do_gen_[function]'.
        """
        logger.info("Running FABulous")
        # self.fabulousAPI.gen_port_data()
        self.do_gen_fabric()
        self.do_gen_primitive_library(str(self.projectDir / META_DATA_DIR / "prims.v"))
        self.do_gen_chipdb()
        self.do_gen_bitStream_spec()
        self.do_gen_top_wrapper()
        # self.do_gen_model_npnr()
        # self.do_gen_geometry()
        logger.info("FABulous fabric flow complete")
        return

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_model_npnr(self, *ignored):
        """Generates Nextpnr model of fabric by parsing various required files for place
        and route such as 'pips.txt', 'bel.txt', 'bel.v2.txt' and 'templace.pcf'. Output
        files are written to the directory specified by 'metaDataDir' within
        'projectDir'.

        Logs output file directories.
        """
        logger.info("Generating npnr model")
        npnrModel = self.fabulousAPI.genRoutingModel()
        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/pips.txt")
        with open(f"{self.projectDir}/{META_DATA_DIR}/pips.txt", "w") as f:
            f.write(npnrModel[0])

        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/bel.txt")
        with open(f"{self.projectDir}/{META_DATA_DIR}/bel.txt", "w") as f:
            f.write(npnrModel[1])

        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/bel.v2.txt")
        with open(f"{self.projectDir}/{META_DATA_DIR}/bel.v2.txt", "w") as f:
            f.write(npnrModel[2])

        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/template.pcf")
        with open(f"{self.projectDir}/{META_DATA_DIR}/template.pcf", "w") as f:
            f.write(npnrModel[3])

        logger.info("Generated npnr model")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_chipdb(self, *ignored):
        """Generates chip database by calling 'genChipDB'."""
        logger.info("Generating chip database")
        logger.info(
            f"Writing to {self.projectDir}/{META_DATA_DIR}/{self.fabulousAPI.fabric.name}.bin"
        )
        self.fabulousAPI.genChipDatabase(
            self.projectDir / META_DATA_DIR,
            self.projectDir / META_DATA_DIR / "baseConstIds.inc",
        )
        logger.info("Generated chip database")

    @with_argparser(filePathOptionalParser)
    def do_gen_primitive_library(self, args):
        """Generates primitive library by calling 'genPrimitiveLibrary'."""
        logger.info("Generating primitive library")
        if args.file.is_dir():
            logger.info(f"Writing to {self.projectDir}/{META_DATA_DIR}/prims.v")
            self.fabulousAPI.genPrimsLib(self.projectDir / META_DATA_DIR / "prims.v")
        else:
            logger.info(f"Writing to {args.file}")
            self.fabulousAPI.genPrimsLib(args.file)

        logger.info("Generated primitive library")

    do_synthesis = cmd_synthesis.do_synthesis

    do_place_and_route = cmd_pnr.do_place_and_route

    @with_category(CMD_FABRIC_FLOW)
    @with_argparser(filePathRequireParser)
    def do_gen_bitStream_binary(self, args):
        """Generates bitstream of a given design using FASM file and pre-generated
        bitstream specification file 'bitStreamSpec.bin'. Requires bitstream
        specification before use by running 'gen_bitStream_spec' and place and route
        file generated by running 'place_and_route'.

        Also logs output file directory, Bitstream generation error and file not found
        error.
        """
        parent = args.file.parent
        fasm_file = args.file.name
        top_module_name = args.file.stem

        if args.file.suffix != ".fasm":
            logger.error(
                """
                No fasm file provided.
                Usage: gen_bitStream_binary <fasm_file>
                """
            )
            return

        bitstream_file = top_module_name + ".bin"

        if not (self.projectDir / ".FABulous/bitStreamSpec.bin").exists():
            logger.error(
                "Cannot find bitStreamSpec.bin file, which is generated by running gen_bitStream_spec"
            )
            return

        if not (self.projectDir / f"{parent}/{fasm_file}").exists():
            logger.error(
                f"Cannot find {self.projectDir}/{parent}/{fasm_file} file which is generated by running place_and_route. Potentially Place and Route Failed."
            )
            return

        logger.info(f"Generating Bitstream for design {self.projectDir}/{args.file}")
        logger.info(f"Outputting to {self.projectDir}/{parent}/{bitstream_file}")
        runCmd = [
            "bit_gen",
            "-genBitstream",
            f"{self.projectDir}/{parent}/{fasm_file}",
            f"{self.projectDir}/.FABulous/bitStreamSpec.bin",
            f"{self.projectDir}/{parent}/{bitstream_file}",
        ]
        try:
            sp.run(runCmd, check=True)
        except sp.CalledProcessError:
            logger.error("Bitstream generation failed")

        logger.info("Bitstream generated")

    simulation_parser = Cmd2ArgumentParser()
    simulation_parser.add_argument(
        "format",
        choices=["vcd", "fst"],
        default="fst",
        help="Output format of the simulation",
    )
    simulation_parser.add_argument(
        "file",
        type=Path,
        completer=Cmd.path_complete,
        help="Path to the bitstream file",
    )

    @with_category(CMD_FABRIC_FLOW)
    @with_argparser(simulation_parser)
    def do_run_simulation(self, args):
        """Simulate given FPGA design using Icarus Verilog (iverilog).

        If <fst> is specified, waveform files in FST format will generate, <vcd> with
        generate VCD format. The bitstream_file argument should be a binary file
        generated by 'gen_bitStream_binary'. Verilog files from 'Tile' and 'Fabric'
        directories are copied to the temporary directory 'tmp', 'tmp' is deleted on
        simulation end.

        Also logs simulation error and file not found error and value error.
        """
        if not args.file.is_relative_to(self.projectDir):
            bitstreamPath = self.projectDir / Path(args.file)
        else:
            bitstreamPath = args.file
        topModule = bitstreamPath.stem
        if bitstreamPath.suffix != ".bin":
            logger.error("No bitstream file specified.")
            return
        if not bitstreamPath.exists():
            logger.error(
                f"Cannot find {bitstreamPath} file which is generated by running gen_bitStream_binary. Potentially the bitstream generation failed."
            )
            return

        waveform_format = args.format
        defined_option = f"CREATE_{waveform_format.upper()}"

        designFile = topModule + ".v"
        topModuleTB = topModule + "_tb"
        testBench = topModuleTB + ".v"
        vvpFile = topModuleTB + ".vvp"

        logger.info(f"Running simulation for {designFile}")

        testPath = Path(self.projectDir / "Test")
        buildDir = testPath / "build"
        fabricFilesDir = buildDir / "fabric_files"

        buildDir.mkdir(exist_ok=True)
        fabricFilesDir.mkdir(exist_ok=True)

        copy_verilog_files(self.projectDir / "Tile", fabricFilesDir)
        copy_verilog_files(self.projectDir / "Fabric", fabricFilesDir)
        file_list = [str(i) for i in fabricFilesDir.glob("*.v")]

        iverilog = check_if_application_exists(
            os.getenv("FAB_IVERILOG_PATH", "iverilog")
        )
        try:
            runCmd = [
                f"{iverilog}",
                "-D",
                f"{defined_option}",
                "-s",
                f"{topModuleTB}",
                "-o",
                f"{buildDir}/{vvpFile}",
                *file_list,
                f"{bitstreamPath.parent}/{designFile}",
                f"{testPath}/{testBench}",
            ]
            if self.verbose or self.debug:
                logger.info(f"Running simulation with {args.format} format")
                logger.info(f"Running command: {' '.join(runCmd)}")
            sp.run(runCmd, check=True)

        except sp.CalledProcessError:
            logger.error("Simulation failed")
            remove_dir(buildDir)
            return

        # bitstream hex file is used for simulation so it'll be created in the test directory
        bitstreamHexPath = (buildDir.parent / bitstreamPath.stem).with_suffix(".hex")
        if self.verbose or self.debug:
            logger.info(f"Make hex file {bitstreamHexPath}")
        make_hex(bitstreamPath, bitstreamHexPath)
        vvp = check_if_application_exists(os.getenv("FAB_VVP_PATH", "vvp"))

        # $plusargs is used to pass the bitstream hex and waveform path to the testbench
        vvpArgs = [
            f"+output_waveform={testPath / topModule}.{waveform_format}",
            f"+bitstream_hex={bitstreamHexPath}",
        ]
        if waveform_format == "fst":
            vvpArgs.append("-fst")

        try:
            runCmd = [f"{vvp}", f"{buildDir}/{vvpFile}"]
            runCmd.extend(vvpArgs)
            if self.verbose or self.debug:
                logger.info(f"Running command: {' '.join(runCmd)}")
            sp.run(runCmd, check=True)
        except sp.CalledProcessError:
            logger.error("Simulation failed")
            return

        remove_dir(buildDir)
        logger.info("Simulation finished")

    @with_category(CMD_FABRIC_FLOW)
    @with_argparser(filePathRequireParser)
    def do_run_FABulous_bitstream(self, args):
        """Runs FABulous to generate bitstream on a given design starting from
        synthesis.

        Does this by calling synthesis, place and route, bitstream generation functions.
        Requires Verilog file specified by <top_module_file>.

        Also logs usage error and file not found error.
        """

        file_path_no_suffix = args.file.parent / args.file.stem

        if args.file.suffix != ".v":
            logger.error(
                """
                No verilog file provided.
                Usage: run_FABulous_bitstream <top_module_file>
                """
            )
            return

        json_file_path = file_path_no_suffix.with_suffix(".json")
        fasm_file_path = file_path_no_suffix.with_suffix(".fasm")

        self.do_synthesis(str(args.file))
        self.do_place_and_route(str(json_file_path))
        self.do_gen_bitStream_binary(str(fasm_file_path))

    @with_category(CMD_SCRIPT)
    @with_argparser(filePathRequireParser)
    def do_run_tcl(self, args):
        """Executes TCL script relative to the project directory, specified by
        <tcl_scripts>. Uses the 'tk' module to create TCL commands.

        Also logs usage errors and file not found errors.
        """
        if not args.file.exists():
            logger.error(f"Cannot find {args.file}")
            return

        logger.info(f"Execute TCL script {args.file}")

        with open(args.file, "r") as f:
            script = f.read()
        self.tcl.eval(script)

        logger.info("TCL script executed")

        if "exit" in script:
            return True
