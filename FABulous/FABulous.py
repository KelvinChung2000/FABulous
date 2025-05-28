import os
from contextlib import redirect_stdout
from dataclasses import dataclass
from pathlib import Path

import typer
from loguru import logger

from FABulous.fabric_generator.define import WriterType
from FABulous.FABulous_CLI.FABulous_CLI import FABulous_CLI
from FABulous.FABulous_CLI.helper import (
    create_project,
    install_oss_cad_suite,
    setup_global_env_vars,
    setup_logger,
    setup_project_env_vars,
)

app = typer.Typer()


@dataclass
class GlobalOptions:
    writer: WriterType = WriterType.VERILOG
    log: Path = Path()
    verbose: bool = False
    debug: bool = False
    global_dot_env: str = ""
    project_dot_env: str = ""


context = GlobalOptions()


def setupCLI(projectDir: Path) -> FABulous_CLI:
    setup_global_env_vars(context.global_dot_env, projectDir)
    setup_project_env_vars(context.project_dot_env, context.writer)
    return FABulous_CLI(
        os.getenv("FAB_PROJ_LANG"),
        projectDir,
        Path().cwd(),
        debug=context.debug,
        verbose=context.verbose,
    )


@app.callback(invoke_without_command=True)
def setup(
    writer: WriterType = typer.Option(
        WriterType.VERILOG,
        "--writer",
        "-w",
        help="Set the type of HDL code generated. Currently supports 'verilog' and 'vhdl'.",
    ),
    log: Path = typer.Option(
        "stdout",
        "--log",
        "-l",
        help="Path to the log file where terminal output will be logged.",
    ),
    verbose: bool = typer.Option(
        False,
        "--verbose",
        "-v",
        is_flag=True,
        help="Enable verbose logging. This will show detailed log information including function and line number.",
    ),
    debug: bool = typer.Option(
        False,
        "--debug",
        is_flag=True,
        help="Enable debug logging. This will show even more detailed log information.",
    ),
    global_dot_env: str = typer.Option(
        "$FAB_ROOT/.env",
        "--global-dot-env",
        "-gde",
        help="Path to the global .env file.",
        exists=True,
        file_okay=True,
        dir_okay=False,
        resolve_path=True,
    ),
    project_dot_env: str = typer.Option(
        "$FAB_PROJ_DIR/.env",
        "--project-dot-env",
        "-pde",
        help="Path to the project .env file.",
        exists=True,
        file_okay=True,
        dir_okay=False,
        resolve_path=True,
    ),
    createProject: Path = typer.Option(
        "", "--createProject", "-c", help="[red][DEPRECATED][/red], use create directly"
    ),
    fabScript: Path = typer.Option(
        "",
        "--FABulousScript",
        "-fs",
        help="[red][DEPRECATED][/red], use run_fabulous_script directly",
        file_okay=True,
        dir_okay=False,
    ),
    tclScript: Path = typer.Option(
        "",
        "--TCLScript",
        "-ts",
        help="[red][DEPRECATED][/red], use run_tcl directly",
        file_okay=True,
        dir_okay=False,
    ),
    install_oss: Path = typer.Option(
        "",
        "--install-oss-cad-suite",
        "-iocs",
        help="[red][DEPRECATED][/red], use install_cad_suite directly",
        file_okay=False,
        dir_okay=True,
    ),
):
    context.writer = writer
    context.log = log
    context.verbose = verbose
    context.debug = debug
    context.global_dot_env = global_dot_env
    context.project_dot_env = project_dot_env
    setup_logger(verbose)

    if createProject != Path():
        logger.warning("The -c/--createProject option is deprecated. Use the 'create' command instead.")
        setup_global_env_vars(context.global_dot_env, createProject)
        create_project(
            project_dir=createProject,
            lang=context.writer,
        )
        raise typer.Exit()

    if fabScript != Path():
        logger.warning("The -fs/--FABulousScript option is deprecated. Use the 'run_fabulous_script' command instead.")
        cli = setupCLI(Path(os.getenv("FAB_PROJ_DIR", Path.cwd())).absolute())
        cli.onecmd_plus_hooks("run_fabulous_script " + str(fabScript))
        raise typer.Exit()

    if tclScript != Path():
        logger.warning("The -ts/--TCLScript option is deprecated. Use the 'run_tcl' command instead.")
        cli = setupCLI(Path(os.getenv("FAB_PROJ_DIR", Path.cwd())).absolute())
        cli.onecmd_plus_hooks("run_tcl " + str(tclScript))
        raise typer.Exit()
    
    if install_oss != Path():
        logger.warning("The -iocd/--install-oss-cad-suite option is deprecated. Use the 'install_cad_suite' command instead.")
        install_oss_cad_suite(
            destination_folder=install_oss,
            update=True,
        )
        raise typer.Exit()


@app.command()
def create(project_dir: Path):
    """Create a new FABulous project in the specified directory."""
    setup_global_env_vars(context.global_dot_env, project_dir)
    create_project(
        project_dir=project_dir,
        lang=context.writer,
    )


@app.command("run_tcl")
def run_tcl(project_dir: Path, tcl_script: Path):
    """
    Run a TCL script in the FABulous CLI.
    This will automatically exit the CLI once the command finishes execution.
    """
    cli = setupCLI(project_dir)
    cli.onecmd_plus_hooks("run_tcl " + str(tcl_script))


@app.command("run_fabulous_script")
def run_fabulous_script(project_dir: Path, fabulous_script: Path):
    """
    Run a FABulous script in the FABulous CLI.
    A FABulous script is a text file containing only FABulous commands.
    This will automatically exit the CLI once the command finishes execution.
    """
    cli = setupCLI(project_dir)
    cli.onecmd_plus_hooks("run_fabulous_script " + str(fabulous_script))


@app.command()
def run(project_dir: Path, cmds: str):
    """
    Run a series of FABulous commands in the FABulous CLI.
    This will automatically exit the CLI once the commands finish execution.
    Each command should be separated by a semicolon.
    Example: 'run cmd1; cmd2; cmd3'
    """
    cli = setupCLI(project_dir)
    for i in cmds.split(";"):
        if i.strip():
            cli.onecmd_plus_hooks(i.strip())


@app.command()
def start(project_dir: Path):
    """Start the FABulous CLI in the specified project directory."""
    if not project_dir.exists():
        logger.error(f"The directory provided does not exist: {project_dir}")
        raise typer.Exit(code=1)

    if not (project_dir / ".FABulous").exists():
        logger.error("The directory provided is not a FABulous project as it does not have a .FABulous folder")
        raise typer.Exit(code=1)

    cli = setupCLI(project_dir)
    if context.log:
        with open(context.log, "w") as log:
            with redirect_stdout(log):
                logger.info("Logging to file: " + str(context.log))
                logger.info(f"Setting current working directory to: {project_dir}")
                os.chdir(project_dir)
                cli.cmdloop()
    else:
        logger.info(f"Setting current working directory to: {project_dir}")
        os.chdir(project_dir)
        cli.cmdloop()


@app.command()
def install_cad_suite(install_dir: Path = Path(), update: bool = True):
    """Install the oss-cad-suite in the given directory."""
    install_oss_cad_suite(
        destination_folder=install_dir,
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


def main():
    app()


if __name__ == "__main__":
    app()
