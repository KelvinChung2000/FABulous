import os
from collections.abc import Generator
from pathlib import Path

import pytest
from _pytest.logging import LogCaptureFixture
from loguru import logger

from FABulous.FABulous_CLI.FABulous_CLI import FABulous_CLI
from FABulous.FABulous_CLI.helper import create_project, setup_logger


def normalize(block: str) -> list[str]:
    """Normalize a block of text to perform comparison.

    Strip newlines from the very beginning and very end, then split into separate lines and strip trailing whitespace
    from each line.
    """
    assert isinstance(block, str)
    block = block.strip("\n")
    return [line.rstrip() for line in block.splitlines()]


def run_cmd(app: FABulous_CLI, cmd: str) -> None:
    """Clear stdout, stdin and stderr buffers, run the command, and return stdout and stderr"""
    app.onecmd_plus_hooks(cmd)


def normalize_and_check_for_errors(caplog_text: str) -> list[str]:
    """Normalize a block of text and check for errors."""
    log = normalize(caplog_text)
    assert not any("ERROR" in line for line in log), "Error found in log messages"
    return log


TILE = "LUT4AB"


@pytest.fixture(autouse=True)
def env() -> Generator[None]:
    fabulousRoot = str(Path(__file__).resolve().parent.parent.parent / "FABulous")
    os.environ["FAB_ROOT"] = fabulousRoot
    os.environ["FABULOUS_TESTING"] = "TRUE"
    yield
    os.environ.pop("FAB_ROOT", None)
    os.environ.pop("FABULOUS_TESTING", None)


@pytest.fixture
def cli(tmp_path: Path) -> Generator[FABulous_CLI]:
    projectDir = tmp_path / "test_project"
    os.environ["FAB_PROJ_DIR"] = str(projectDir)
    create_project(projectDir)
    setup_logger(0, False)
    cli = FABulous_CLI(
        "verilog",
        projectDir=projectDir,
        force=False,
        interactive=False,
        verbose=False,
        debug=True,
    )
    run_cmd(cli, "load_fabric")
    yield cli
    os.environ.pop("FAB_ROOT", None)
    os.environ.pop("FAB_PROJ_DIR", None)


@pytest.fixture
def project(tmp_path: Path) -> Generator[Path]:
    project_dir = tmp_path / "test_project"
    os.environ["FAB_PROJ_DIR"] = str(project_dir)
    create_project(project_dir)
    yield project_dir
    os.environ.pop("FAB_PROJ_DIR", None)


@pytest.fixture(autouse=True)
def cleanup_logger() -> Generator[None]:
    """Ensure logger is properly cleaned up after each test to prevent
    'logging to closed file' errors when tests exit quickly"""
    yield
    # Remove all logger handlers to prevent logging to closed files
    logger.remove()


@pytest.fixture
def caplog(caplog: LogCaptureFixture) -> Generator[LogCaptureFixture]:
    handler_id = logger.add(
        caplog.handler,
        format="{message}",
        level=0,
        filter=lambda record: record["level"].no >= caplog.handler.level,
        enqueue=False,  # Set to 'True' if your test is spawning child processes.
    )
    yield caplog
    logger.remove(handler_id)


@pytest.fixture
def project_directories(tmp_path: Path) -> dict[str, Path]:
    """Fixture that creates test directories and .env files for project directory precedence tests."""
    # Create multiple project directories for testing
    user_provided_dir = tmp_path / "user_provided_project"
    env_var_dir = tmp_path / "env_var_project"
    project_dotenv_dir = tmp_path / "project_dotenv_project"
    global_dotenv_dir = tmp_path / "global_dotenv_project"
    default_dir = tmp_path / "default_project"

    # Create all directories with .FABulous folders
    for project_dir in [
        user_provided_dir,
        env_var_dir,
        project_dotenv_dir,
        global_dotenv_dir,
        default_dir,
    ]:
        project_dir.mkdir()
        (project_dir / ".FABulous").mkdir()
        env_file = project_dir / ".FABulous" / ".env"
        env_file.write_text("FAB_PROJ_LANG=verilog\nVERSION=1.0.0\n")

    # Create project-specific .env file for testing
    project_dotenv_file = tmp_path / "project_specific.env"
    project_dotenv_file.write_text(f"FAB_PROJ_DIR={str(project_dotenv_dir)}\n")

    # Create project-specific .env file that doesn't set FAB_PROJ_DIR (for fallback tests)
    project_dotenv_fallback_file = tmp_path / "project_fallback.env"
    project_dotenv_fallback_file.write_text("FAB_PROJ_LANG=verilog\n")

    # Create global .env file for testing
    global_dotenv_file = tmp_path / "global.env"
    global_dotenv_file.write_text(f"FAB_PROJ_DIR={str(global_dotenv_dir)}\n")

    return {
        "user_provided_dir": user_provided_dir,
        "env_var_dir": env_var_dir,
        "project_dotenv_dir": project_dotenv_dir,
        "global_dotenv_dir": global_dotenv_dir,
        "default_dir": default_dir,
        "project_dotenv_file": project_dotenv_file,
        "project_dotenv_fallback_file": project_dotenv_fallback_file,
        "global_dotenv_file": global_dotenv_file,
    }
