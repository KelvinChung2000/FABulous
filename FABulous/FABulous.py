import argparse
from dataclasses import dataclass
import os
from contextlib import redirect_stdout
from pathlib import Path
from typing import Literal
from loguru import logger
import typer

from FABulous.FABulous_CLI.FABulous_CLI import FABulous_CLI
from FABulous.FABulous_CLI.helper import (
    create_project,
    setup_global_env_vars,
    setup_logger,
    setup_project_env_vars,
    install_oss_cad_suite,
)


main = typer.Typer()

@dataclass
class GlobalOptions:
    writer: Literal["verilog", "vhdl"] = "verilog"
    log: str = ""
    verbose: bool = False
    debug: bool = False
    global_dot_env: str = ""
    project_dot_env: str = ""


context = GlobalOptions()


def setupCLI(projectDir: Path) -> FABulous_CLI:
    setup_global_env_vars(context.global_dot_env, projectDir)
    setup_project_env_vars(context.project_dot_env, projectDir)
    return FABulous_CLI(
            os.getenv("FAB_PROJ_LANG"),
            projectDir,
            Path().cwd(),
            debug=context.debug
            verbose=context.verbose,
        )


@main.callback()
def setup(writer: Literal["verilog", "vhdl"] = "verilog", log: str = "", verbose: bool = False,
          debug: bool = False, global_dot_env: str = "",
          project_dot_env: str = ""):
    context.writer = writer
    context.log = log
    context.verbose = verbose
    context.debug = debug
    context.global_dot_env = global_dot_env
    context.project_dot_env = project_dot_env
    setup_logger(verbose)



@main.command()
def create(projectDir: str):
    create_project(
        project_dir=Path(os.getenv("FAB_PROJ_DIR", projectDir)).absolute(),
        lang=context.writer
    )

@main.command()
def run_tcl(projectDir: Path, tclScript: Path):
    cli = setupCLI(projectDir)
    cli.onecmd_plus_hooks("run_tcl " + str(tclScript))

@main.command()
def run_fabulous_script(projectDir: Path, fabulousScript: Path):
    cli = setupCLI(projectDir)
    cli.onecmd_plus_hooks("run_fabulous_script " + str(fabulousScript))


@main.command()
def run(projectDir: Path, cmds: str):
    for i in cmds.split(";"):
        if i.strip():
            cli = setupCLI(projectDir)
            cli.onecmd_plus_hooks(i.strip())
    


@main.command()
def start(projectDir: Path):
    if not projectDir.exists():
        logger.error(f"The directory provided does not exist: {projectDir}")
        raise typer.Exit(code=1)
    
    if not (projectDir / ".FABulous").exists():
        logger.error(
            "The directory provided is not a FABulous project as it does not have a .FABulous folder"
        )
        raise typer.Exit(code=1)
    
    cli = setupCLI(projectDir)
    if context.log:
        with open(context.log, "w") as log:
            with redirect_stdout(log):
                logger.info("Logging to file: " + context.log)
                logger.info(f"Setting current working directory to: {projectDir}")
                os.chdir(projectDir)
                cli.cmdloop()
    else:
        logger.info(f"Setting current working directory to: {projectDir}")
        os.chdir(projectDir)
        cli.cmdloop()


@main.command()
def install_cad_suite(installDir: Path = Path(), update: bool = True):
    """Install the oss-cad-suite in the given directory."""
    install_oss_cad_suite(
        destination_folder=installDir,
        update=update,
    )

# def main():
#     """Main function to start the command line interface of FABulous, sets up argument
#     parsing, initialises required components and handles start the FABulous CLI.

#     Also logs terminal output and if .FABulous folder is missing.

#     Command line arguments
#     ----------------------
#     project_dir : str
#         Directory path to project folder.
#     -c, --createProject :  bool
#         Flag to create new project.
#     -fs, --FABulousScript: str, optional
#         Run FABulous with a FABulous script.
#     -ts, --TCLscript: str, optional
#         Run FABulous with a TCL script.
#     -log : str, optional
#         Log all the output from the terminal.
#     -w, --writer : <'verilog', 'vhdl'>, optional
#         Set type of HDL code generated. Currently supports .V and .VHDL (Default .V)
#     -md, --metaDataDir : str, optional
#         Set output directory for metadata files, e.g. pip.txt, bel.txt
#     -v, --verbose : bool, optional
#         Show detailed log information including function and line number.
#     -gde, --globalDotEnv : str, optional
#         Set global .env file path. Default is $FAB_ROOT/.env
#     -pde, --projectDotEnv : str, optional
#         Set project .env file path. Default is $FAB_PROJ_DIR/.env
#     -iocd, --install_oss_cad_suite : str, optional
#         Install the oss-cad-suite in the project directory.
#     """
#     parser = argparse.ArgumentParser(
#         description="The command line interface for FABulous"
#     )

#     parser.add_argument(
#         "project_dir",
#         help="The directory to the project folder",
#     )

#     parser.add_argument(
#         "-c",
#         "--createProject",
#         default=False,
#         action="store_true",
#         help="Create a new project",
#     )

#     parser.add_argument(
#         "-fs",
#         "--FABulousScript",
#         default="",
#         help="Run FABulous with a FABulous script. A FABulous script is a text file containing only FABulous commands"
#         "This will automatically exit the CLI once the command finish execution, and the exit will always happen gracefully.",
#         type=Path,
#     )
#     parser.add_argument(
#         "-ts",
#         "--TCLScript",
#         default="",
#         help="Run FABulous with a TCL script. A TCL script is a text file containing a mix of TCL commands and FABulous commands."
#         "This will automatically exit the CLI once the command finish execution, and the exit will always happen gracefully.",
#         type=Path,
#     )

    

#     parser.add_argument(
#         "-iocs",
#         "--install_oss_cad_suite",
#         help="Install the oss-cad-suite in the directory."
#         "This will create a new directory called oss-cad-suite in the provided"
#         "directory and install the oss-cad-suite there."
#         "If there is already a directory called oss-cad-suite, it will be removed and replaced with a new one."
#         "This will also automatically add the FAB_OSS_CAD_SUITE env var in the global FABulous .env file. ",
#         action="store_true",
#         default=False,
#     )

#     parser.add_argument("--debug", action="store_true", help="Enable debug mode")

#     args = parser.parse_args()

#     setup_logger(args.verbose)

#     setup_global_env_vars(args)

#     projectDir = Path(os.getenv("FAB_PROJ_DIR", args.project_dir)).absolute()

#     args.top = projectDir.stem

#     if args.createProject and args.install_oss_cad_suite:
#         logger.error(
#             f"You cannot create a new project and install the oss-cad-suite at the same time."
#         )
#         exit(1)

#     if args.createProject:
#         create_project(projectDir, args.writer)
#         exit(0)

#     if not projectDir.exists():
#         logger.error(f"The directory provided does not exist: {projectDir}")
#         exit(1)

#     if args.install_oss_cad_suite:
#         install_oss_cad_suite(projectDir, True)
#         exit(0)

#     if not (projectDir / ".FABulous").exists():
#         logger.error(
#             "The directory provided is not a FABulous project as it does not have a .FABulous folder"
#         )
#         exit(1)
#     else:
#         setup_project_env_vars(args)

#         fab_CLI = FABulous_CLI(
#             os.getenv("FAB_PROJ_LANG"),
#             projectDir,
#             Path().cwd(),
#             FABulousScript=args.FABulousScript,
#             TCLScript=args.TCLScript,
#         )
#         fab_CLI.debug = args.debug

#         if args.verbose == 2:
#             fab_CLI.verbose = True
#         if args.metaDataDir:
#             if Path(args.metaDataDir).exists():
#                 metaDataDir = args.metaDataDir

#         if args.log:
#             with open(args.log, "w") as log:
#                 with redirect_stdout(log):
#                     logger.info("Logging to file: " + args.log)
#                     logger.info(f"Setting current working directory to: {projectDir}")
#                     os.chdir(projectDir)
#                     fab_CLI.cmdloop()
#         else:
#             logger.info(f"Setting current working directory to: {projectDir}")
#             os.chdir(projectDir)
#             fab_CLI.cmdloop()


if __name__ == "__main__":
    main()
