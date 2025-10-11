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
"""FABulous command-line interface module.

This module provides the main command-line interface for the FABulous FPGA framework. It
includes interactive and batch mode support for fabric generation, bitstream creation,
simulation, and project management.
"""

import csv
import pickle
import pprint
import shutil
import subprocess as sp
import sys
import tkinter as tk
import traceback
from pathlib import Path
from typing import Annotated

import typer
from cmd2 import (
    Cmd,
    Settable,
    categorize,
    with_category,
)
from loguru import logger

from FABulous.custom_exception import CommandError, EnvironmentNotSet, InvalidFileType
from FABulous.fabric_cad.bit_gen import genBitstream
from FABulous.fabric_definition.define import WaveType
from FABulous.fabric_generator.code_generator.code_generator_Verilog import (
    VerilogCodeGenerator,
)
from FABulous.fabric_generator.code_generator.code_generator_VHDL import (
    VHDLCodeGenerator,
)
from FABulous.fabric_generator.gen_fabric.fabric_automation import (
    generateCustomTileConfig,
)
from FABulous.fabric_generator.parser.parse_csv import parseTilesCSV
from FABulous.FABulous_API import FABulous_API
from FABulous.FABulous_CLI.cmd2_plugin import (
    Cmd2TyperPlugin,
    CompleterSpec,
)
from FABulous.FABulous_CLI.helper import (
    CommandPipeline,
    copy_verilog_files,
    install_fabulator,
    install_oss_cad_suite,
    make_hex,
    remove_dir,
    wrap_with_except_handling,
)
from FABulous.FABulous_settings import get_context, init_context

META_DATA_DIR = ".FABulous"

CMD_SETUP = "Setup"
CMD_FABRIC_FLOW = "Fabric Flow"
CMD_USER_DESIGN_FLOW = "User Design Flow"
CMD_HELPER = "Helper"
CMD_OTHER = "Other"
CMD_GUI = "GUI"
CMD_SCRIPT = "Script"
CMD_TOOLS = "Tools"


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
    run_FABulous_fabric
    run_FABulous_bitstream ./user_design/sequential_16bit_en.v
    run_simulation fst ./user_design/sequential_16bit_en.bin
"""


def tile_completer(
    cls: "FABulous_CLI", text: str, _line: str, _begidx: int, _endidx: int
) -> list[str]:
    """Completer for tile names."""
    return [tile for tile in cls.allTile if tile.startswith(text)]


def bel_completer(
    cls: "FABulous_CLI", text: str, _line: str, _begidx: int, _endidx: int
) -> list[str]:
    """Completer for BEL names."""
    return [bel.name for bel in cls.fabulousAPI.getBels() if bel.name.startswith(text)]


class FABulous_CLI(Cmd2TyperPlugin, Cmd):
    """FABulous command-line interface for FPGA fabric generation and management.

    This class provides an interactive and non-interactive command-line interface
    for the FABulous FPGA framework. It supports fabric generation, bitstream creation,
    project management, and various utilities for FPGA development workflow.

    Parameters
    ----------
    writerType : str | None
        The writer type to use for generating fabric.
    force : bool
        If True, force operations without confirmation, by default False
    interactive : bool
        If True, run in interactive CLI mode, by default False
    verbose : bool
        If True, enable verbose logging, by default False
    debug : bool
        If True, enable debug logging, by default False

    Attributes
    ----------
    intro : str
        Introduction message displayed when CLI starts
    prompt : str
        Command prompt string displayed to users
    fabulousAPI : FABulous_API
        Instance of the FABulous API for fabric operations
    projectDir : pathlib.Path
        Current project directory path
    top : str
        Top-level module name for synthesis
    allTile : list[str]
        List of all tile names in the current fabric
    csvFile : pathlib.Path
        Path to the fabric CSV definition file
    extension : str
        File extension for HDL files ("v" for Verilog, "vhd" for VHDL)
    script : str
        Batch script commands to execute
    force : bool
        If true, force operations without confirmation
    interactive : bool
        If true, run in interactive CLI mode

    Notes
    -----
    This CLI extends the cmd.Cmd class to provide command completion, help system,
    and command history. It supports both interactive mode and batch script execution.
    """

    intro: str = INTO_STRING
    prompt: str = "FABulous> "
    fabulousAPI: FABulous_API
    projectDir: Path
    top: str
    allTile: list[str]
    csvFile: Path
    extension: str = "v"
    script: str = ""
    force: bool = False
    interactive: bool = True

    def __init__(
        self,
        writerType: str | None,
        force: bool = False,
        interactive: bool = False,
        verbose: bool = False,
        debug: bool = False,
    ) -> None:
        try:
            get_context()
        except RuntimeError:
            init_context()

        super().__init__(
            persistent_history_file=f"{get_context().proj_dir}/{META_DATA_DIR}/.fabulous_history",
            allow_cli_args=False,
        )
        logger.info(f"Running at: {get_context().proj_dir}")

        if writerType == "verilog":
            self.fabulousAPI = FABulous_API(VerilogCodeGenerator())
        elif writerType == "vhdl":
            self.fabulousAPI = FABulous_API(VHDLCodeGenerator())
        else:
            logger.critical(
                f"Invalid writer type: {writerType}\n"
                "Valid options are 'verilog' or 'vhdl'"
            )
            sys.exit(1)

        self.projectDir = get_context().proj_dir
        self.add_settable(
            Settable("projectDir", Path, "The directory of the project", self)
        )

        self.tiles = []
        self.superTiles = []
        self.allTile = []
        self._bel_names: list[str] = []
        self.fabricLoaded = False

        self.csvFile = Path(self.projectDir / "fabric.csv").resolve()
        self.add_settable(
            Settable(
                "csvFile",
                Path,
                "The fabric file ",
                self,
                completer=Cmd.path_complete,  # type: ignore[arg-type]
            )
        )

        self.verbose = verbose
        self.add_settable(Settable("verbose", bool, "verbose output", self))

        self.force = force
        self.add_settable(Settable("force", bool, "force execution", self))

        self.interactive = interactive
        self.debug = debug

        if isinstance(self.fabulousAPI.writer, VHDLCodeGenerator):
            self.extension = "vhdl"
        else:
            self.extension = "v"

        categorize(self.do_alias, CMD_OTHER)
        categorize(self.do_edit, CMD_OTHER)
        categorize(self.do_shell, CMD_OTHER)
        categorize(self.do_exit, CMD_OTHER)
        categorize(self.do_quit, CMD_OTHER)
        categorize(self.do_q, CMD_OTHER)
        categorize(self.do_set, CMD_OTHER)
        categorize(self.do_history, CMD_OTHER)
        categorize(self.do_shortcuts, CMD_OTHER)
        categorize(self.do_help, CMD_OTHER)
        categorize(self.do_macro, CMD_OTHER)
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
            CMD_USER_DESIGN_FLOW,
            "User Design Flow commands are disabled until fabric is loaded",
        )
        self.disable_category(
            CMD_GUI, "GUI commands are disabled until gen_gen_geometry is run"
        )
        self.disable_category(
            CMD_HELPER, "Helper commands are disabled until fabric is loaded"
        )

    def onecmd_plus_hooks(
        self,
        line: str,
        *,
        add_to_history: bool = True,
        raise_keyboard_interrupt: bool = False,
        py_bridge_call: bool = False,
        orig_rl_history_length: int | None = None,
    ) -> bool:
        """Override the onecmd method to handle exceptions."""
        try:
            return super().onecmd_plus_hooks(
                line,
                add_to_history=add_to_history,
                raise_keyboard_interrupt=raise_keyboard_interrupt,
                py_bridge_call=py_bridge_call,
                orig_rl_history_length=orig_rl_history_length,
            )
        except Exception as e:  # noqa: BLE001 - Catching all exceptions is ok here
            logger.debug(traceback.format_exc())
            logger.opt(exception=e).error(str(e).replace("<", r"\<"))
            self.exit_code = 1
            if self.interactive:
                return False
            return not self.force

    def do_exit(self, *_ignored: str) -> bool:
        """Exit the FABulous shell and log info message."""
        logger.info("Exiting FABulous shell")
        return True

    def do_quit(self, *_ignored: str) -> None:
        """Exit the FABulous shell and log info message."""
        self.onecmd_plus_hooks("exit")

    def do_q(self, *_ignored: str) -> None:
        """Exit the FABulous shell and log info message."""
        self.onecmd_plus_hooks("exit")

    # # Import do_synthesis from cmd_synthesis
    # def do_synthesis(self, args: argparse.Namespace) -> None:
    #     """Run synthesis on the specified design."""
    #     cmd_synthesis.do_synthesis(self, args)

    @with_category(CMD_SETUP)
    def do_install_oss_cad_suite(
        self,
        destination_folder: Annotated[
            Path | None,
            typer.Argument(
                help="Destination folder for the installation",
            ),
        ] = None,
        update_existing: Annotated[
            bool,
            typer.Option(
                "--update-existing",
                "--update",
                help="Update or override an existing installation if present.",
            ),
        ] = False,
    ) -> None:
        """Download and extract the latest OSS CAD Suite."""
        dest_dir = destination_folder or get_context().proj_dir
        install_oss_cad_suite(dest_dir, update_existing)

    @with_category(CMD_SETUP)
    def do_install_FABulator(
        self,
        destination_folder: Annotated[
            Path | None,
            typer.Argument(
                help="Destination folder for the installation",
            ),
        ] = None,
    ) -> None:
        """Download and install the latest version of FABulator."""
        dest_dir = destination_folder or get_context().proj_dir
        install_fabulator(dest_dir)
        logger.info("FABulator successfully installed")

    @with_category(CMD_SETUP)
    def do_load_fabric(
        self,
        file: Annotated[
            Path | None,
            typer.Argument(
                help="Path to the fabric CSV definition file",
            ),
        ] = None,
    ) -> None:
        """Load `fabric.csv` and generate the internal fabric representation."""
        logger.info("Loading fabric")
        target_file = file or self.csvFile

        if not target_file.exists():
            # Mark an error state compatible with command pipeline expectations
            self.exit_code = 1
            raise FileNotFoundError(
                f"Fabric definition file {target_file} does not exist"
            )

        self.fabulousAPI.loadFabric(target_file)
        self.csvFile = target_file

        self.fabricLoaded = True
        tileByPath = [
            f.stem for f in (self.projectDir / "Tile/").iterdir() if f.is_dir()
        ]
        tileByFabric = list(self.fabulousAPI.fabric.tileDic.keys())
        superTileByFabric = list(self.fabulousAPI.fabric.superTileDic.keys())
        self.allTile = sorted(set(tileByPath) & set(tileByFabric + superTileByFabric))
        try:
            bels = {bel.name for bel in self.fabulousAPI.getBels()}
        except AttributeError:
            bels = set()
        self._bel_names = sorted(bels)

        proj_dir = get_context().proj_dir
        if (proj_dir / "eFPGA_geometry.csv").exists():
            self.enable_category(CMD_GUI)

        self.enable_category(CMD_FABRIC_FLOW)
        self.enable_category(CMD_USER_DESIGN_FLOW)
        self.enable_category(CMD_HELPER)

        logger.info("Complete")

    @with_category(CMD_HELPER)
    def do_print_bel(
        self,
        bel: Annotated[
            str,
            CompleterSpec(completer=bel_completer),
            typer.Argument(help="Name of the BEL to display"),
        ],
    ) -> None:
        """Print a BEL object to the console."""
        if not self.fabricLoaded:
            raise CommandError("Need to load fabric first")

        for bel_obj in self.fabulousAPI.getBels():
            if bel_obj.name == bel:
                logger.info("\n{}", pprint.pformat(bel_obj, width=200))
                return
        raise CommandError(f"Bel {bel} not found in fabric")

    @with_category(CMD_HELPER)
    def do_print_tile(
        self,
        tile: Annotated[
            str,
            CompleterSpec(completer=tile_completer),
            typer.Argument(help="Name of the tile to display"),
        ],
    ) -> None:
        """Print a tile object to the console."""
        if not self.fabricLoaded:
            raise CommandError("Need to load fabric first")

        tile_obj = self.fabulousAPI.getTile(tile) or self.fabulousAPI.getSuperTile(tile)
        if tile_obj is None:
            raise CommandError(f"Tile {tile} not found in fabric")

        logger.info("\n{}", pprint.pformat(tile_obj, width=200))

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_config_mem(
        self,
        tiles: Annotated[
            list[str],
            CompleterSpec(completer=tile_completer),
            typer.Argument(
                ...,
                metavar="TILE...",
                help="Tiles to process",
            ),
        ],
    ) -> None:
        """Generate configuration memory of the given tile.

        Parsing input arguments and calling `genConfigMem`.

        Logs generation processes for each specified tile.
        """
        logger.info(f"Generating Config Memory for {' '.join(tiles)}")
        for i in tiles:
            logger.info(f"Generating configMem for {i}")
            self.fabulousAPI.setWriterOutputFile(
                self.projectDir / "Tile" / i / f"{i}_ConfigMem.{self.extension}"
            )
            self.fabulousAPI.genConfigMem(
                i, self.projectDir / "Tile" / i / f"{i}_ConfigMem.csv"
            )
        logger.info("ConfigMem generation complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_switch_matrix(
        self,
        tiles: Annotated[
            list[str],
            CompleterSpec(completer=tile_completer),
            typer.Argument(
                ...,
                metavar="TILE...",
                help="Tiles to process",
            ),
        ],
    ) -> None:
        """Generate switch matrix of given tile.

        Parsing input arguments and calling `genSwitchMatrix`.

        Also logs generation process for each specified tile.
        """
        logger.info(f"Generating switch matrix for {' '.join(tiles)}")
        for i in tiles:
            logger.info(f"Generating switch matrix for {i}")
            self.fabulousAPI.setWriterOutputFile(
                self.projectDir / "Tile" / i / f"{i}_switch_matrix.{self.extension}"
            )
            self.fabulousAPI.genSwitchMatrix(i)
        logger.info("Switch matrix generation complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_tile(
        self,
        tiles: Annotated[
            list[str],
            CompleterSpec(completer=tile_completer),
            typer.Argument(metavar="TILE...", help="Tiles to generate"),
        ],
    ) -> None:
        """Generate given tile with switch matrix and configuration memory.

        Parsing input arguments, call functions such as `genSwitchMatrix` and
        `genConfigMem`. Handle both regular tiles and super tiles with sub-tiles.

        Also logs generation process for each specified tile and sub-tile.
        """
        logger.info(f"Generating tile {' '.join(tiles)}")
        for t in tiles:
            if subTiles := [
                f.stem for f in (self.projectDir / f"Tile/{t}").iterdir() if f.is_dir()
            ]:
                logger.info(
                    f"{t} is a super tile, generating {t} with sub tiles "
                    f"{' '.join(subTiles)}"
                )
                for st in subTiles:
                    # Gen switch matrix
                    logger.info(f"Generating switch matrix for tile {t}")
                    logger.info(f"Generating switch matrix for {st}")
                    self.fabulousAPI.setWriterOutputFile(
                        self.projectDir
                        / "Tile"
                        / t
                        / st
                        / f"{st}_switch_matrix.{self.extension}"
                    )
                    self.fabulousAPI.genSwitchMatrix(st)
                    logger.info(f"Generated switch matrix for {st}")

                    # Gen config mem
                    logger.info(f"Generating configMem for tile {t}")
                    logger.info(f"Generating ConfigMem for {st}")
                    self.fabulousAPI.setWriterOutputFile(
                        self.projectDir
                        / "Tile"
                        / t
                        / st
                        / f"{st}_ConfigMem.{self.extension}"
                    )
                    self.fabulousAPI.genConfigMem(
                        st,
                        self.projectDir / "Tile" / t / st / f"{st}_ConfigMem.csv",
                    )
                    logger.info(f"Generated configMem for {st}")

                    # Gen tile
                    logger.info(f"Generating subtile for tile {t}")
                    logger.info(f"Generating subtile {st}")
                    self.fabulousAPI.setWriterOutputFile(
                        self.projectDir / "Tile" / t / st / f"{st}.{self.extension}"
                    )
                    self.fabulousAPI.genTile(st)
                    logger.info(f"Generated subtile {st}")

                # Gen super tile
                logger.info(f"Generating super tile {t}")
                self.fabulousAPI.setWriterOutputFile(
                    self.projectDir / "Tile" / t / f"{t}.{self.extension}"
                )
                self.fabulousAPI.genSuperTile(t)
                logger.info(f"Generated super tile {t}")
                continue

            # Gen switch matrix
            self.do_gen_switch_matrix([t])

            # Gen config mem
            self.do_gen_config_mem([t])

            logger.info(f"Generating tile {t}")
            # Gen tile
            self.fabulousAPI.setWriterOutputFile(
                self.projectDir / "Tile" / t / f"{t}.{self.extension}"
            )
            self.fabulousAPI.genTile(t)
            logger.info(f"Generated tile {t}")

        logger.info("Tile generation complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_all_tile(self) -> None:
        """Generate all tiles by calling `do_gen_tile`."""
        logger.info("Generating all tiles")
        self.do_gen_tile(self.allTile)
        logger.info("All tiles generation complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_fabric(self) -> None:
        """Generate fabric based on the loaded fabric.

        Calling `gen_all_tile` and `genFabric`.

        Logs start and completion of fabric generation process.
        """
        logger.info(f"Generating fabric {self.fabulousAPI.fabric.name}")
        self.onecmd_plus_hooks("gen_all_tile")
        if self.exit_code != 0:
            raise CommandError("Tile generation failed")
        self.fabulousAPI.setWriterOutputFile(
            self.projectDir
            / "Fabric"
            / f"{self.fabulousAPI.fabric.name}.{self.extension}"
        )
        self.fabulousAPI.genFabric()
        logger.info("Fabric generation complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_geometry(
        self,
        padding: Annotated[
            int,
            typer.Argument(
                min=4,
                max=32,
                metavar="[4-32]",
                help="Padding value for geometry generation",
            ),
        ] = 8,
    ) -> None:
        """Generate geometry of fabric for FABulator.

        Checking if fabric is loaded, and calling 'genGeometry' and passing on padding
        value. Default padding is '8'.

        Also logs geometry generation, the used padding value and any warning about
        faulty padding arguments, as well as errors if the fabric is not loaded or the
        padding is not within the valid range of 4 to 32.
        """
        logger.info(f"Generating geometry for {self.fabulousAPI.fabric.name}")
        geom_file = self.projectDir / f"{self.fabulousAPI.fabric.name}_geometry.csv"
        self.fabulousAPI.setWriterOutputFile(geom_file)

        self.fabulousAPI.genGeometry(padding)
        logger.info("Geometry generation complete")
        logger.info(f"{geom_file} can now be imported into FABulator")

    @with_category(CMD_GUI)
    def do_start_FABulator(self) -> None:
        """Start FABulator if an installation can be found.

        If no installation can be found, a warning is produced.
        """
        logger.info("Checking for FABulator installation")
        fabulatorRoot = get_context().fabulator_root
        if shutil.which("mvn") is None:
            raise FileNotFoundError(
                "Application mvn (Java Maven) not found in PATH",
                " please install it to use FABulator",
            )

        if fabulatorRoot is None:
            logger.warning("FABULATOR_ROOT environment variable not set.")
            logger.warning(
                "Install FABulator (https://github.com/FPGA-Research-Manchester/FABulator)"
                " and set the FABULATOR_ROOT environment variable to the root directory"
                " to use this feature."
            )
            return

        if not Path(fabulatorRoot).exists():
            raise EnvironmentNotSet(
                f"FABULATOR_ROOT environment variable set to {fabulatorRoot} "
                "but the directory does not exist."
            )

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

        except sp.SubprocessError as e:
            raise CommandError(
                "Failed to start FABulator. Please ensure that the FABULATOR_ROOT "
                "environment variable is set correctly and that FABulator is installed."
            ) from e

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_bitStream_spec(self) -> None:
        """Generate bitstream specification of the fabric.

        By calling `genBitStreamSpec` and saving the specification to a binary and CSV
        file.

        Also logs the paths of the output files.
        """
        logger.info("Generating bitstream specification")
        specObject = self.fabulousAPI.genBitStreamSpec()

        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/bitStreamSpec.bin")
        with Path(f"{self.projectDir}/{META_DATA_DIR}/bitStreamSpec.bin").open(
            "wb"
        ) as outFile:
            pickle.dump(specObject, outFile)

        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/bitStreamSpec.csv")
        with Path(f"{self.projectDir}/{META_DATA_DIR}/bitStreamSpec.csv").open(
            "w", encoding="utf-8", newline="\n"
        ) as f:
            w = csv.writer(f)
            for key1 in specObject["TileSpecs"]:
                w.writerow([key1])
                for key2, val in specObject["TileSpecs"][key1].items():
                    w.writerow([key2, val])
        logger.info("Bitstream specification generation complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_top_wrapper(self) -> None:
        """Generate top wrapper of the fabric by calling `genTopWrapper`."""
        logger.info("Generating top wrapper")
        self.fabulousAPI.setWriterOutputFile(
            self.projectDir
            / "Fabric"
            / f"{self.fabulousAPI.fabric.name}_top.{self.extension}"
        )
        self.fabulousAPI.genTopWrapper()
        logger.info("Top wrapper generation complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_run_FABulous_fabric(self) -> None:
        """Generate the fabric based on the CSV file.

        Create bitstream specification of the fabric, top wrapper of the fabric, Nextpnr
        model of the fabric and geometry information of the fabric.
        """
        logger.info("Running FABulous")

        success = (
            CommandPipeline(self)
            .add_step("gen_io_fabric")
            .add_step("gen_fabric", "Fabric generation failed")
            .add_step("gen_bitStream_spec", "Bitstream specification generation failed")
            .add_step("gen_top_wrapper", "Top wrapper generation failed")
            .add_step("gen_model_npnr", "Nextpnr model generation failed")
            .add_step("gen_geometry", "Geometry generation failed")
            .execute()
        )

        if success:
            logger.info("FABulous fabric flow complete")

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_model_npnr(self) -> None:
        """Generate Nextpnr model of fabric.

        By parsing various required files for place and route such as `pips.txt`,
        `bel.txt`, `bel.v2.txt` and `template.pcf`. Output files are written to the
        directory specified by `metaDataDir` within `projectDir`.

        Logs output file directories.
        """
        logger.info("Generating npnr model")
        npnrModel = self.fabulousAPI.genRoutingModel()
        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/pips.txt")
        with Path(f"{self.projectDir}/{META_DATA_DIR}/pips.txt").open("w") as f:
            f.write(npnrModel[0])

        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/bel.txt")
        with Path(f"{self.projectDir}/{META_DATA_DIR}/bel.txt").open("w") as f:
            f.write(npnrModel[1])

        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/bel.v2.txt")
        with Path(f"{self.projectDir}/{META_DATA_DIR}/bel.v2.txt").open("w") as f:
            f.write(npnrModel[2])

        logger.info(f"output file: {self.projectDir}/{META_DATA_DIR}/template.pcf")
        with Path(f"{self.projectDir}/{META_DATA_DIR}/template.pcf").open("w") as f:
            f.write(npnrModel[3])

        logger.info("Generated npnr model")

    @with_category(CMD_USER_DESIGN_FLOW)
    def do_place_and_route(
        self,
        file: Annotated[
            Path,
            typer.Argument(help="Path to the Nextpnr JSON file"),
        ],
    ) -> None:
        """Run place and route with Nextpnr for a given JSON file.

        Generated by Yosys, which requires a Nextpnr model and JSON file first,
        generated by `synthesis`.

        Also logs place and route error, file not found error and type error.
        """
        logger.info(f"Running Placement and Routing with Nextpnr for design {file}")
        path = file
        parent = path.parent
        json_file = path.name
        top_module_name = path.stem

        if path.suffix != ".json":
            raise InvalidFileType(
                "No json file provided. Usage: place_and_route <json_file>"
            )

        fasm_file = top_module_name + ".fasm"
        log_file = top_module_name + "_npnr_log.txt"

        if (
            not Path(f"{self.projectDir}/.FABulous/pips.txt").exists()
            or not Path(f"{self.projectDir}/.FABulous/bel.txt").exists()
        ):
            raise FileNotFoundError(
                "Pips and Bel files are not found, please run model_gen_npnr first"
            )

        target_dir = self.projectDir / parent
        if target_dir.exists():
            # TODO rewriting the fab_arch script so no need to copy file for work around
            npnr = get_context().nextpnr_path
            if (target_dir / json_file).exists():
                runCmd = [
                    f"FAB_ROOT={self.projectDir}",
                    f"{npnr!s}",
                    "--uarch",
                    "fabulous",
                    "--json",
                    f"{target_dir / json_file}",
                    "-o",
                    f"fasm={target_dir / fasm_file}",
                    "--verbose",
                    "--log",
                    f"{target_dir / log_file}",
                ]
                result = sp.run(
                    " ".join(runCmd),
                    stdout=sys.stdout,
                    stderr=sp.STDOUT,
                    check=True,
                    shell=True,
                )
                if result.returncode != 0:
                    raise CommandError("Nextpnr failed with non-zero exit code")

            else:
                raise FileNotFoundError(
                    f'Cannot find file "{json_file}" in path '
                    f'"{target_dir}". '
                    "This file is generated by running Yosys with Nextpnr backend "
                    "(e.g. synthesis)."
                )

            logger.info("Placement and Routing completed")
        else:
            raise FileNotFoundError(
                f"Directory {target_dir} does not exist. "
                "Please check the path and try again."
            )

    @with_category(CMD_USER_DESIGN_FLOW)
    def do_gen_bitStream_binary(
        self,
        file: Annotated[
            Path,
            typer.Argument(help="Path to the FASM file"),
        ],
    ) -> None:
        """Generate bitstream of a given design.

        Using FASM file and pre-generated bitstream specification file
        `bitStreamSpec.bin`. Requires bitstream specification before use by running
        `gen_bitStream_spec` and place and route file generated by running
        `place_and_route`.

        Also logs output file directory, Bitstream generation error and file not found
        error.
        """
        parent = file.parent
        fasm_file = file.name
        top_module_name = file.stem

        if file.suffix != ".fasm":
            raise InvalidFileType(
                "No fasm file provided. Usage: gen_bitStream_binary <fasm_file>"
            )

        bitstream_file = top_module_name + ".bin"

        if not (self.projectDir / ".FABulous/bitStreamSpec.bin").exists():
            raise FileNotFoundError(
                "Cannot find bitStreamSpec.bin file, which is generated by running "
                "gen_bitStream_spec"
            )

        if not (self.projectDir / f"{parent}/{fasm_file}").exists():
            raise FileNotFoundError(
                f"Cannot find {self.projectDir}/{parent}/{fasm_file} file which is "
                "generated by running place_and_route. "
                "Potentially Place and Route Failed."
            )

        logger.info(f"Generating Bitstream for design {self.projectDir}/{file}")
        logger.info(f"Outputting to {self.projectDir}/{parent}/{bitstream_file}")

        try:
            genBitstream(
                f"{self.projectDir}/{parent}/{fasm_file}",
                f"{self.projectDir}/.FABulous/bitStreamSpec.bin",
                f"{self.projectDir}/{parent}/{bitstream_file}",
            )

        except Exception as e:  # noqa: BLE001
            raise CommandError(
                f"Bitstream generation failed for "
                f"{self.projectDir}/{parent}/{fasm_file}. "
                "Please check the logs for more details."
            ) from e

        logger.info("Bitstream generated")

    @with_category(CMD_USER_DESIGN_FLOW)
    def do_run_simulation(
        self,
        waveform_format: Annotated[
            WaveType,
            CompleterSpec(
                completer=lambda _self, text, _line, _begidx, _endidx: [
                    option for option in ["vcd", "fst"] if option.startswith(text)
                ]
            ),
            typer.Argument(
                help="Output format of the simulation",
            ),
        ],
        bitstream: Annotated[
            Path,
            CompleterSpec(completer=Cmd.path_complete),
            typer.Argument(help="Path to the bitstream file"),
        ],
    ) -> None:
        """Simulate given FPGA design using Icarus Verilog (iverilog).

        If <fst> is specified, waveform files in FST format will generate, <vcd> with
        generate VCD format. The bitstream_file argument should be a binary file
        generated by 'gen_bitStream_binary'. Verilog files from 'Tile' and 'Fabric'
        directories are copied to the temporary directory 'tmp', 'tmp' is deleted on
        simulation end.

        Also logs simulation error and file not found error and value error.
        """
        logger.debug(
            f"run_simulation parsed args: file={bitstream}, format={waveform_format!s}",
        )

        if not bitstream.is_relative_to(self.projectDir):
            bitstreamPath = self.projectDir / Path(bitstream)
        else:
            bitstreamPath = bitstream
        topModule = bitstreamPath.stem

        if bitstreamPath.suffix != ".bin":
            raise InvalidFileType(
                "No bitstream file specified. "
                "Usage: run_simulation <format> <bitstream_file>"
            )

        if not bitstreamPath.exists():
            raise FileNotFoundError(
                f"Cannot find {bitstreamPath} file which is generated by running "
                "gen_bitStream_binary. Potentially the bitstream generation failed."
            )

        defined_option = f"CREATE_{str(waveform_format).upper()}"

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

        iverilog = get_context().iverilog_path
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
            logger.info(f"Running simulation with {waveform_format!s} format")
            logger.info(f"Running command: {' '.join(runCmd)}")

        result = sp.run(runCmd, check=True)
        if result.returncode != 0:
            raise CommandError(
                f"Simulation failed for {designFile}. "
                "Please check the logs for more details."
            )

        # bitstream hex file is used for simulation so it'll be created in the
        # test directory
        bitstreamHexPath = (buildDir.parent / bitstreamPath.stem).with_suffix(".hex")
        if self.verbose or self.debug:
            logger.info(f"Make hex file {bitstreamHexPath}")
        make_hex(bitstreamPath, bitstreamHexPath)
        vvp = get_context().vvp_path

        # $plusargs is used to pass the bitstream hex and waveform path to the testbench
        vvpArgs = [
            f"+output_waveform={testPath / topModule}.{waveform_format}",
            f"+bitstream_hex={bitstreamHexPath}",
        ]
        if waveform_format == "fst":
            vvpArgs.append("-fst")

        runCmd = [f"{vvp!s}", f"{buildDir}/{vvpFile}"]
        runCmd.extend(vvpArgs)
        if self.verbose or self.debug:
            logger.info(f"Running command: {' '.join(runCmd)}")

        result = sp.run(runCmd, check=True)
        remove_dir(buildDir)
        if result.returncode != 0:
            raise CommandError(
                f"Simulation failed for {designFile}. "
                "Please check the logs for more details."
            )

        logger.info("Simulation finished")

    @with_category(CMD_USER_DESIGN_FLOW)
    def do_run_FABulous_bitstream(
        self,
        file: Annotated[
            Path,
            typer.Argument(help="Path to the top-level Verilog module"),
        ],
    ) -> None:
        """Run FABulous to generate bitstream on a given design.

        Does this by calling synthesis, place and route, bitstream generation functions.
        Requires Verilog file specified by <top_module_file>.

        Also logs usage error and file not found error.
        """
        file_path_no_suffix = file.parent / file.stem

        if file.suffix != ".v":
            raise InvalidFileType(
                "No verilog file provided. "
                "Usage: run_FABulous_bitstream <top_module_file>"
            )

        json_file_path = file_path_no_suffix.with_suffix(".json")
        fasm_file_path = file_path_no_suffix.with_suffix(".fasm")

        do_synth_args = str(file)

        primsLib = f"{self.projectDir}/user_design/custom_prims.v"
        if Path(primsLib).exists():
            do_synth_args += f" -extra-plib {primsLib}"
        else:
            logger.info("No external primsLib found.")

        success = (
            CommandPipeline(self)
            .add_step(f"synthesis {do_synth_args}")
            .add_step(f"place_and_route {json_file_path}")
            .add_step(f"gen_bitStream_binary {fasm_file_path}")
            .execute()
        )
        if success:
            logger.info("FABulous bitstream generation complete")

    @with_category(CMD_SCRIPT)
    def do_run_tcl(
        self,
        file: Annotated[
            Path,
            typer.Argument(help="Path to the TCL script"),
        ],
    ) -> None:
        """Execute TCL script relative to the project directory.

        Specified by <tcl_scripts>. Use the 'tk' module to create TCL commands.

        Also logs usage errors and file not found errors.
        """
        if not file.exists():
            raise FileNotFoundError(
                f"Cannot find {file} file, please check the path and try again."
            )

        if self.force:
            logger.warning(
                "TCL script does not work with force mode, TCL will stop on first error"
            )

        logger.info(f"Execute TCL script {file}")

        with file.open() as f:
            script = f.read()
        self.tcl.eval(script)

        logger.info("TCL script executed")

    @with_category(CMD_SCRIPT)
    def do_run_script(
        self,
        file: Annotated[
            Path,
            typer.Argument(help="Path to the CLI script"),
        ],
    ) -> None:
        """Execute script."""
        if not file.exists():
            raise FileNotFoundError(
                f"Cannot find {file} file, please check the path and try again."
            )

        logger.info(f"Execute script {file}")

        with file.open() as f:
            for i in f:
                if i.startswith("#"):
                    continue
                self.onecmd_plus_hooks(i.strip())
                if self.exit_code != 0:
                    if not self.force:
                        raise CommandError(
                            f"Script execution failed at line: {i.strip()}"
                        )
                    logger.error(
                        f"Script execution failed at line: {i.strip()} "
                        "but continuing due to force mode"
                    )

        logger.info("Script executed")

    @with_category(CMD_USER_DESIGN_FLOW)
    def do_gen_user_design_wrapper(
        self,
        user_design: Annotated[
            Path,
            typer.Argument(help="Path to the user design file"),
        ],
        user_design_top_wrapper: Annotated[
            Path,
            typer.Argument(help="Output path for the generated wrapper"),
        ],
    ) -> None:
        """Generate a user design wrapper for the specified user design.

        This command creates a wrapper module that interfaces the user design
        with the FPGA fabric, handling signal connections and naming conventions.

        Parameters
        ----------
        args : argparse.Namespace
            Command arguments containing:
            - user_design: Path to the user design file
            - user_design_top_wrapper: Path for the generated wrapper file

        Raises
        ------
        CommandError
            If the fabric has not been loaded yet.
        """
        if not self.fabricLoaded:
            raise CommandError("Need to load fabric first")

        self.fabulousAPI.generateUserDesignTopWrapper(
            user_design, user_design_top_wrapper
        )

    @with_category(CMD_TOOLS)
    def do_generate_custom_tile_config(
        self,
        tile_path: Annotated[
            Path,
            typer.Argument(help="Path to the target tile directory"),
        ],
        no_switch_matrix: Annotated[
            bool,
            typer.Option(
                "--no-switch-matrix",
                "-nosm",
                help="Do not generate a Tile switch matrix",
            ),
        ] = False,
    ) -> None:
        """Generate a custom tile configuration for a given tile folder.

        Or path to bel folder. A tile `.csv` file and a switch matrix `.list` file will
        be generated.

        The provided path may contain bel files, which will be included in the generated
        tile .csv file as well as the generated switch matrix .list file.
        """
        if not tile_path.is_dir():
            logger.error(f"{tile_path} is not a directory or does not exist")
            return

        tile_csv = generateCustomTileConfig(tile_path)

        if not no_switch_matrix:
            parseTilesCSV(tile_csv)

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_io_tiles(
        self,
        tiles: Annotated[
            list[str],
            CompleterSpec(completer=tile_completer),
            typer.Argument(metavar="TILE...", help="Tiles to add I/O BELs"),
        ],
    ) -> None:
        """Generate I/O BELs for specified tiles.

        This command generates Input/Output Basic Elements of Logic (BELs) for the
        specified tiles, enabling external connectivity for the FPGA fabric.

        Parameters
        ----------
        args : argparse.Namespace
            Command arguments containing:
            - tiles: List of tile names to generate I/O BELs for
        """
        for tile in tiles:
            self.fabulousAPI.genIOBelForTile(tile)

    @with_category(CMD_FABRIC_FLOW)
    def do_gen_io_fabric(self) -> None:
        """Generate I/O BELs for the entire fabric.

        This command generates Input/Output Basic Elements of Logic (BELs) for all
        applicable tiles in the fabric, providing external connectivity across the
        entire FPGA design.
        """
        self.fabulousAPI.genFabricIOBels()
