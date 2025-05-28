import os
import sys
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

app = typer.Typer(rich_markup_mode="rich")


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
        "",
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
        "", "--createProject", "-c", help="[red][DEPRECATED][/red] use [bold]create[/bold] command directly"
    ),
    fabScript: Path = typer.Option(
        "",
        "--FABulousScript",
        "-fs",
        help="[red][DEPRECATED][/red] use [bold]run_fabulous_script[/bold] command directly",
        file_okay=True,
        dir_okay=False,
    ),
    tclScript: Path = typer.Option(
        "",
        "--TCLScript",
        "-ts",
        help="[red][DEPRECATED][/red] use [bold]run_tcl[/bold] command directly",
        file_okay=True,
        dir_okay=False,
    ),
    install_oss: Path = typer.Option(
        "",
        "--install-oss-cad-suite",
        "-iocs",
        help="[red][DEPRECATED][/red] use [bold]install_cad_suite[/bold] command directly",
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
    if context.log != Path():
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


def main():
    app()


if __name__ == "__main__":
    app()
