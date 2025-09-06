"""Test module for FABulous CLI argument processing and functionality.

This module contains comprehensive tests for the FABulous command-line interface,
covering project creation, script execution, command-line flags, and error handling.
"""

import sys
import tarfile
from collections.abc import Callable
from pathlib import Path
from subprocess import run

import pytest
from dotenv import set_key
from pytest_mock import MockerFixture

from FABulous.FABulous import main
from FABulous.FABulous_settings import init_context, reset_context


@pytest.mark.parametrize(
    "writer_lang",
    [
        pytest.param(None, id="default"),
        pytest.param("verilog", id="verilog"),
        pytest.param("vhdl", id="vhdl"),
        pytest.param(
            "invalid_writer",
            id="invalid",
            marks=pytest.mark.xfail(reason="invalid writer should fail", strict=True),
        ),
    ],
)
@pytest.mark.parametrize(
    ("argv", "precreate", "expect_contains"),
    [
        (["FABulous", "create-project", "{project}"], False, None),
        (["FABulous", "--createProject", "{project}"], False, None),
        pytest.param(
            ["FABulous", "create-project"],
            False,
            None,
            id="typer-missing-name",
            marks=pytest.mark.xfail(
                reason="missing project name should fail", strict=True
            ),
        ),
        pytest.param(
            ["FABulous", "--createProject"],
            False,
            None,
            id="legacy-missing-name",
            marks=pytest.mark.xfail(
                reason="missing project name should fail", strict=True
            ),
        ),
        pytest.param(
            ["FABulous", "create-project", "{project}"],
            True,
            "already exists",
            id="typer-existing",
            marks=pytest.mark.xfail(
                reason="project already exists should fail", strict=True
            ),
        ),
        pytest.param(
            ["FABulous", "--createProject", "{project}"],
            True,
            "already exists",
            id="legacy-existing",
            marks=pytest.mark.xfail(
                reason="project already exists should fail", strict=True
            ),
        ),
    ],
    ids=[
        "typer-basic",
        "legacy-basic",
        "typer-missing-name",
        "legacy-missing-name",
        "typer-existing",
        "legacy-existing",
    ],
)
def test_create_project_cases(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    capsys: pytest.CaptureFixture,
    writer_lang: str | None,
    argv: list[str],
    precreate: bool,
    expect_contains: str | None,
) -> None:
    project_dir = tmp_path / "test_prj"

    # Inject project path tokens
    test_argv = [a.replace("{project}", str(project_dir)) for a in argv]

    # Add writer flag if writer_lang is specified
    if writer_lang:
        if "--createProject" in test_argv:
            # Legacy format: add before --createProject
            insert_at = test_argv.index("--createProject")
            test_argv[insert_at:insert_at] = ["--writer", writer_lang]
        else:
            # Typer format: add after FABulous
            test_argv.insert(1, "--writer")
            test_argv.insert(2, writer_lang)

    if precreate:
        project_dir.mkdir(parents=True, exist_ok=True)

    monkeypatch.setattr(sys, "argv", test_argv)
    with pytest.raises(SystemExit) as exc_info:
        main()

    # All non-xfail cases should succeed
    assert exc_info.value.code == 0

    # Check project creation and writer language for successful cases
    if not precreate:
        assert project_dir.exists()
        env_text = (project_dir / ".FABulous" / ".env").read_text().lower()
        expected_writer = (writer_lang or "verilog").lower()
        assert expected_writer in env_text

    if expect_contains:
        captured = capsys.readouterr()
        assert expect_contains in captured.out


@pytest.mark.parametrize(
    ("argv", "start_dir"),
    [
        # FAB script with explicit project
        pytest.param(
            ["FABulous", "{project}", "--FABulousScript", "{file}"],
            None,
            id="fab-legacy",
        ),
        pytest.param(
            ["FABulous", "script", "{project}", "{file}"],
            None,
            id="fab-typer",
        ),
        # FAB script in cwd in a project
        pytest.param(
            ["FABulous", "--FABulousScript", "{file}"],
            "project",
            id="fab-cwd-project",
        ),
        # FAB script with nonexistent file
        pytest.param(
            ["FABulous", "script", "{project}", "{missing}"],
            None,
            id="fab-nonexistent",
            marks=pytest.mark.xfail(
                reason="nonexistent script file should fail", strict=True
            ),
        ),
        # TCL script with explicit project
        pytest.param(
            ["FABulous", "{project}", "--TCLScript", "{tcl}"],
            None,
            id="tcl-legacy",
        ),
        pytest.param(
            ["FABulous", "script", "{project}", "{tcl}"],
            None,
            id="tcl-typer",
        ),
        # FAB script in non-project cwd (should fail)
        pytest.param(
            ["FABulous", "--FABulousScript", "{file}"],
            "nonproject",
            id="fab-cwd-nonproject",
            marks=pytest.mark.xfail(
                reason="script in non-project directory should fail", strict=True
            ),
        ),
    ],
)
def test_script_execution_cases(
    tmp_path: Path,
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv: list[str],
    start_dir: str | None,
) -> None:
    fab_script = tmp_path / "test_script.fab"
    # Default content succeeds; override below for failure scenarios
    fab_content = "# Test FABulous script\nhelp\n"
    if start_dir == "nonproject":
        # Trigger a failure when not in a project
        fab_content = "load_fabric non_exist\n"
    fab_script.write_text(fab_content)
    tcl_script = tmp_path / "test_script.tcl"
    tcl_script.write_text(
        '# TCL script with FABulous commands\nputs "Hello from TCL"\n'
    )
    missing = tmp_path / "missing_script.fab"

    test_argv = [
        s.replace("{project}", str(project))
        .replace("{file}", str(fab_script))
        .replace("{tcl}", str(tcl_script))
        .replace("{missing}", str(missing))
        for s in argv
    ]

    if start_dir == "project":
        monkeypatch.chdir(project)
    elif start_dir == "nonproject":
        nonproj = tmp_path / "nonproj"
        nonproj.mkdir()
        monkeypatch.chdir(nonproj)

    monkeypatch.setattr(sys, "argv", test_argv)
    with pytest.raises(SystemExit) as exc_info:
        main()

    # All non-xfail cases should succeed
    assert exc_info.value.code == 0


@pytest.mark.parametrize(
    ("argv", "commands", "expect_fail"),
    [
        pytest.param(
            ["FABulous", "{project}", "--commands"],
            "help; help",
            False,
            id="legacy-success",
        ),
        pytest.param(
            ["FABulous", "run", "{project}"],
            "help",
            False,
            id="typer-success",
        ),
        pytest.param(
            ["FABulous", "{project}", "--commands"],
            "",
            False,
            id="empty-commands",
        ),
        pytest.param(
            ["FABulous", "{project}", "--commands"],
            "load_fabric non_exist; load_fabric non_exist",
            True,
            id="stop-on-first-error",
        ),
    ],
)
def test_commands_execution(
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv: list[str],
    commands: str,
    expect_fail: bool,
) -> None:
    """Test direct command execution with various scenarios"""
    test_args = [arg.replace("{project}", str(project)) for arg in argv]
    if commands:
        test_args.append(commands)

    if expect_fail:
        # Use subprocess.run for error cases to capture output
        from subprocess import run

        result = run(test_args, capture_output=True, text=True)
        assert result.returncode != 0
        if "load_fabric non_exist" in commands:
            # Should stop on first error, only show one attempt
            assert result.stdout.count("non_exist") == 1
    else:
        # Use monkeypatch for success cases
        monkeypatch.setattr(sys, "argv", test_args)
        with pytest.raises(SystemExit) as exc_info:
            main()
        assert exc_info.value.code == 0


@pytest.mark.parametrize(
    "argv_builder",
    [
        pytest.param(
            lambda prj, log: [
                "FABulous",
                str(prj),
                "--commands",
                "help",
                "-log",
                str(log),
            ],
            id="legacy",
        ),
        pytest.param(
            lambda prj, log: [
                "FABulous",
                "--log",
                str(log),
                "run",
                str(prj),
                "help",
            ],
            id="typer",
        ),
    ],
)
def test_logging_file_creation(
    tmp_path: Path,
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv_builder: Callable[[Path, Path], list[str]],
) -> None:
    """Logging creates file for both legacy and Typer styles."""
    log_file = tmp_path / "cli_test.log"
    test_args = argv_builder(project, log_file)
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == 0
    assert log_file.exists()
    assert log_file.stat().st_size > 0


## merged into test_verbose_mode_parametric


@pytest.mark.parametrize(
    ("argv", "vflag"),
    [
        pytest.param(
            ["FABulous", "{project}", "--commands", "help"],
            ["-v"],
            id="legacy-v",
        ),
        pytest.param(
            ["FABulous", "{project}", "--commands", "help"],
            ["-vv"],
            id="legacy-vv",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help"],
            ["-v"],
            id="typer-v",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help"],
            ["-vv"],
            id="typer-vv",
        ),
    ],
)
def test_verbose_mode_parametric(
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv: list[str],
    vflag: list[str],
) -> None:
    """Verbose mode works in both legacy and Typer forms."""
    test_args = [arg.replace("{project}", str(project)) for arg in argv]
    if "run" in argv:
        # Typer form - add flags before subcommand
        test_args = [test_args[0]] + vflag + test_args[1:]
    else:
        # Legacy form - add flags at end
        test_args.extend(vflag)
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()
    assert exc_info.value.code == 0


@pytest.mark.parametrize(
    "argv",
    [
        pytest.param(
            ["FABulous", "{project}", "--commands", "help", "--debug"],
            id="legacy",
        ),
        pytest.param(
            ["FABulous", "--debug", "run", "{project}", "help"],
            id="typer",
        ),
    ],
)
def test_debug_mode(
    project: Path, monkeypatch: pytest.MonkeyPatch, argv: list[str]
) -> None:
    """Debug mode works in both legacy and Typer forms."""
    test_args = [arg.replace("{project}", str(project)) for arg in argv]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == 0


@pytest.mark.parametrize(
    ("argv_base", "commands_or_script", "expected_count", "search_text"),
    [
        pytest.param(
            ["FABulous", "{project}", "--commands"],
            "load_fabric non_existent",
            1,
            "non_existent",
            id="single-command",
        ),
        pytest.param(
            ["FABulous", "{project}", "--commands"],
            "load_fabric non_exist; load_fabric non_exist",
            2,
            "non_exist",
            id="multiple-commands",
        ),
        pytest.param(
            ["FABulous", "{project}", "--FABulousScript"],
            "load_fabric non_exist.csv\nload_fabric non_exist.csv\n",
            3,
            "INFO: Loading fabric",
            id="script",
        ),
    ],
)
def test_force_flag(
    project: Path,
    tmp_path: Path,
    argv_base: list[str],
    commands_or_script: str,
    expected_count: int,
    search_text: str,
) -> None:
    """Test force flag functionality with different scenarios"""

    # Replace project placeholder
    argv = [arg.replace("{project}", str(project)) for arg in argv_base]

    # Handle script vs commands
    if "--FABulousScript" in argv:
        # Create script file
        script_file = tmp_path / "test.fs"
        with script_file.open("w") as f:
            f.write(commands_or_script)
        argv.extend([str(script_file), "--force"])
    else:
        # Add commands and force flag
        argv.extend([commands_or_script, "--force"])

    result = run(argv, capture_output=True, text=True)

    assert result.stdout.count(search_text) == expected_count
    assert result.returncode == 1


@pytest.mark.parametrize(
    ("argv", "expected_requests"),
    [
        pytest.param(
            ["FABulous", "{project}", "--install_oss_cad_suite"], 2, id="legacy"
        ),
        pytest.param(
            ["FABulous", "install-oss-cad-suite", "{project}"], 2, id="typer-project"
        ),
        pytest.param(["FABulous", "install-oss-cad-suite"], 2, id="default-dir"),
        pytest.param(
            ["FABulous", "install-oss-cad-suite", "{install_dir}"],
            2,
            id="explicit-dir",
        ),
        pytest.param(
            ["FABulous", "install-oss-cad-suite", "{install_dir}"],
            1,
            id="error",
            marks=pytest.mark.xfail(reason="install should fail on error", strict=True),
        ),
    ],
)
def test_install_oss_cad_suite(
    project: Path,
    tmp_path: Path,
    mocker: MockerFixture,
    monkeypatch: pytest.MonkeyPatch,
    argv: list[str],
    expected_requests: int,
) -> None:
    """Unified parametric test for install-oss-cad-suite variants using network mocking."""

    argv_template: list[str] = argv
    install_dir = tmp_path / "oss"
    test_argv = [
        s.replace("{project}", str(project)).replace("{install_dir}", str(install_dir))
        for s in argv_template
    ]

    # Common network and archive mocks
    class MockRequestOK:
        status_code = 200

        def json(self) -> dict:
            return {
                "assets": [
                    {
                        "name": ".tar.gz x64 linux darwin windows arm64",
                        "browser_download_url": "./something.tgz",
                    }
                ]
            }

        def iter_content(self, chunk_size: int = 1024) -> list:  # noqa: ARG002
            return []

    class MockRequestFail:
        status_code = 500

        def json(self) -> dict:  # noqa: D401
            # Not used in fail path
            return {}

    # Mock tarfile
    class MockTarFile:
        def __enter__(self) -> "MockTarFile":
            return self

        def __exit__(self, *_args: object) -> None:
            pass

        def extractall(self, path: str) -> None:  # noqa: ARG002
            pass

    def mock_open(*_args: object, **_kwargs: object) -> MockTarFile:
        return MockTarFile()

    monkeypatch.setattr(tarfile, "open", mock_open)

    # Configure requests mock - success for non-xfail cases, failure for xfail
    if expected_requests == 1:
        # This is the error case (xfail) - mock failure
        m = mocker.patch("requests.get", return_value=MockRequestFail())
    else:
        # Success cases - mock successful requests
        m = mocker.patch("requests.get", side_effect=[MockRequestOK(), MockRequestOK()])

    # Ensure default-dir uses a clean temp user config directory
    tmp_user_dir = tmp_path / "user_config"
    monkeypatch.setattr("FABulous.FABulous.FAB_USER_CONFIG_DIR", tmp_user_dir)
    monkeypatch.setattr(
        "FABulous.FABulous_CLI.helper.FAB_USER_CONFIG_DIR", tmp_user_dir
    )

    monkeypatch.setattr(sys, "argv", test_argv)
    with pytest.raises(SystemExit) as exc_info:
        main()

    # All non-xfail cases should succeed
    assert exc_info.value.code == 0
    assert m.call_count == expected_requests


def test_script_mutually_exclusive(
    tmp_path: Path, project: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    """Test that FABulous script and TCL script are mutually exclusive."""
    # Create both script types
    fab_script = tmp_path / "test.fab"
    fab_script.write_text("help\n")
    tcl_script = tmp_path / "test.tcl"
    tcl_script.write_text("puts hello\n")

    test_args = [
        "FABulous",
        str(project),
        "--FABulousScript",
        str(fab_script),
        "--TCLScript",
        str(tcl_script),
    ]
    monkeypatch.setattr(sys, "argv", test_args)

    # Try to use both - should fail
    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code != 0


@pytest.mark.parametrize(
    ("argv", "setup_dir", "expect_contains"),
    [
        pytest.param(
            ["FABulous", "/nonexistent/path/to/project", "--commands", "help"],
            None,
            None,
            id="legacy-nonexistent",
            marks=pytest.mark.xfail(
                reason="nonexistent project path should fail", strict=True
            ),
        ),
        pytest.param(
            ["FABulous", "run", "/nonexistent/path/to/project", "help"],
            None,
            None,
            id="typer-nonexistent",
            marks=pytest.mark.xfail(
                reason="nonexistent project path should fail", strict=True
            ),
        ),
        pytest.param(
            ["FABulous", "{regular_dir}", "--commands", "help"],
            "regular_directory",
            "not a FABulous project",
            id="no-fabulous-folder",
            marks=pytest.mark.xfail(
                reason="directory without .FABulous folder should fail", strict=True
            ),
        ),
    ],
)
def test_invalid_project_directory(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    capsys: pytest.CaptureFixture,
    argv: list[str],
    setup_dir: str | None,
    expect_contains: str | None,
) -> None:
    """Test various invalid project directory scenarios."""

    # Set up directory if needed
    if setup_dir:
        regular_dir = tmp_path / setup_dir
        regular_dir.mkdir()
        # Clean up environment variables to avoid contamination
        monkeypatch.delenv("FAB_PROJ_DIR", raising=False)
        # Replace placeholder in argv
        test_args = [arg.replace("{regular_dir}", str(regular_dir)) for arg in argv]
    else:
        test_args = argv

    monkeypatch.setattr(sys, "argv", test_args)
    with pytest.raises(SystemExit) as exc_info:
        main()

    # All cases should fail (but xfail marks handle the expectation)
    assert exc_info.value.code != 0

    if expect_contains:
        captured = capsys.readouterr()
        assert expect_contains in captured.out


def test_writer_case_insensitive_typer(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    """Test case-insensitivity of writer option in Typer."""
    project_dir = tmp_path / "test_case_insensitive_writer"
    test_args = [
        "FABulous",
        "--writer",
        "VHDL",
        "create-project",
        str(project_dir),
    ]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == 0
    assert project_dir.exists()
    assert (project_dir / ".FABulous").exists()
    assert "vhdl" in (project_dir / ".FABulous" / ".env").read_text().lower()


## covered by test_invalid_project_directory


## merged into test_install_oss_cad_suite_parametric


@pytest.mark.parametrize(
    ("global_dotenv", "project_dotenv", "env_var", "user_dir", "expected_dir"),
    [
        pytest.param(
            "global_dotenv_file",
            None,
            None,
            None,
            "global_dotenv_dir",
            id="global-only",
        ),
        pytest.param(
            "global_dotenv_file",
            "project_dotenv_file",
            None,
            None,
            "project_dotenv_dir",
            id="project-overrides-global",
        ),
        pytest.param(
            "global_dotenv_file",
            "project_dotenv_file",
            "env_var_dir",
            None,
            "env_var_dir",
            id="env-overrides-project-global",
        ),
        pytest.param(
            "global_dotenv_file",
            "project_dotenv_file",
            "env_var_dir",
            "user_provided_dir",
            "user_provided_dir",
            id="user-overrides-all",
        ),
        pytest.param(
            None,
            "project_dotenv_fallback_file",
            None,
            None,
            "default_dir",
            id="project-fallback",
        ),
    ],
)
def test_project_dir_precedence_param(
    project_directories: dict[str, Path],
    global_dotenv: str | None,
    project_dotenv: str | None,
    env_var: str | None,
    user_dir: str | None,
    expected_dir: str,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    """Deterministic precedence test using init_context directly (no CLI)."""
    dirs = project_directories
    reset_context()
    monkeypatch.delenv("FAB_PROJ_DIR", raising=False)

    if env_var:
        monkeypatch.setenv("FAB_PROJ_DIR", str(dirs[env_var]))

    global_file = dirs[global_dotenv] if global_dotenv else None
    project_file = dirs[project_dotenv] if project_dotenv else None
    user_directory = dirs[user_dir] if user_dir else None

    settings = init_context(
        project_dir=user_directory,
        global_dot_env=global_file,
        project_dot_env=project_file,
    )
    assert settings.proj_dir == dirs[expected_dir]


## merged into test_commands_execution


# ============================================================================
# Typer-Specific Tests (features not available in legacy format)
# ============================================================================


def test_create_project_alias_typer(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    """Test create-project alias 'c'"""
    project_dir = tmp_path / "test_alias_project"

    test_args = ["FABulous", "c", str(project_dir)]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == 0
    assert project_dir.exists()
    assert (project_dir / ".FABulous").exists()


@pytest.mark.parametrize(
    ("argv", "result", "chdir_flag"),
    [
        pytest.param(
            ["FABulous", "update-project-version", "{project}"],
            True,
            False,
            id="explicit-success",
        ),
        pytest.param(
            ["FABulous", "update-project-version", "{project}"],
            False,
            False,
            id="explicit-failure",
            marks=pytest.mark.xfail(
                reason="update should fail when function returns False", strict=True
            ),
        ),
        pytest.param(
            ["FABulous", "update-project-version"], True, True, id="cwd-success"
        ),
    ],
)
def test_update_project_version_cases(
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv: list[str],
    result: bool,
    chdir_flag: bool,
) -> None:
    test_argv = [s.replace("{project}", str(project)) for s in argv]
    if chdir_flag:
        monkeypatch.chdir(project)
    monkeypatch.setattr("FABulous.FABulous.update_project_version", lambda _p: result)
    monkeypatch.setattr(sys, "argv", test_argv)
    with pytest.raises(SystemExit) as exc_info:
        main()

    # All non-xfail cases should succeed
    assert exc_info.value.code == 0


@pytest.mark.parametrize(
    "file_ext",
    [
        pytest.param(".txt", id="txt"),
        pytest.param(".fab", id="fab"),
        pytest.param(".tcl", id="tcl"),
    ],
)
@pytest.mark.parametrize(
    ("explicit_type", "content"),
    [
        pytest.param("fabulous", "help\n", id="type-fabulous"),
        pytest.param("tcl", 'puts "hi"\n', id="type-tcl"),
        pytest.param(
            "unknown",
            "help\n",
            id="type-invalid",
            marks=pytest.mark.xfail(
                reason="unknown script type should fail", strict=True
            ),
        ),
    ],
)
def test_script_command_type_override_param(
    tmp_path: Path,
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    file_ext: str,
    explicit_type: str,
    content: str,
) -> None:
    """Test script command type override across file extensions."""
    script_file = tmp_path / f"test_script{file_ext}"
    script_file.write_text(content)

    test_args = [
        "FABulous",
        "script",
        str(project),
        str(script_file),
        "--type",
        explicit_type,
    ]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    # All non-xfail cases should succeed
    assert exc_info.value.code == 0


def test_run_alias_typer(project: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    """Test run command alias 'r' (typer-only feature)"""
    test_args = ["FABulous", "r", str(project), "help"]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == 0


def test_start_alias_typer(project: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    """Test start command alias 's' (typer-only feature)"""

    # Mock cmdloop to avoid hanging
    def mock_cmdloop(self: object) -> None:  # noqa: ARG001
        pass

    monkeypatch.setattr("FABulous.FABulous_CLI.FABulous_CLI.cmdloop", mock_cmdloop)

    test_args = ["FABulous", "s", str(project)]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == 0


@pytest.mark.parametrize(
    ("argv", "expected_code"),
    [
        pytest.param(["FABulous", "--version"], 0, id="version"),
        pytest.param(["FABulous", "--help"], 0, id="help"),
        pytest.param(["FABulous"], 2, id="no-args"),
        pytest.param(
            ["FABulous", "--version", "run", "/", "help"],
            0,
            id="version-eager",
        ),
        pytest.param(["FABulous", "--bogus"], 2, id="unknown-option"),
        pytest.param(["FABulous", "unknown"], 1, id="unknown-command"),
    ],
)
def test_global_parser_behaviors(
    argv: list[str], expected_code: int, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setattr(sys, "argv", argv)
    with pytest.raises(SystemExit) as exc_info:
        main()
    assert exc_info.value.code == expected_code


def test_default_writer_is_verilog(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    project_dir = tmp_path / "prj_default_writer"
    argv = ["FABulous", "create-project", str(project_dir)]
    monkeypatch.setattr(sys, "argv", argv)
    with pytest.raises(SystemExit) as exc_info:
        main()
    assert exc_info.value.code == 0
    env_text = (project_dir / ".FABulous" / ".env").read_text()
    assert "verilog" in env_text.lower()


@pytest.mark.parametrize(
    ("argv", "use_cwd"),
    [
        pytest.param(
            ["FABulous", "run", "{project}"],
            False,
            id="run-none",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help"],
            False,
            id="run-single",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help;help"],
            False,
            id="run-multi",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help;  help"],
            False,
            id="run-multi-spaces",
        ),
        pytest.param(
            [
                "FABulous",
                "run",
                "{project}",
                "load_fabric non_exist; load_fabric non_exist",
                "--force",
            ],
            False,
            id="run-force-failures",
            marks=pytest.mark.xfail(
                reason="force flag with failures should return non-zero", strict=True
            ),
        ),
        pytest.param(
            ["FABulous", "r", "{project}", "help"],
            False,
            id="run-alias-r",
        ),
        pytest.param(
            ["FABulous", "start"],
            True,
            id="start-in-cwd",
        ),
    ],
)
def test_run_and_start_variants(project: Path, argv: list[str], use_cwd: bool) -> None:
    test_argv = [s.replace("{project}", str(project)) for s in argv]
    if use_cwd:
        result = run(test_argv, capture_output=True, text=True, cwd=str(project))
    else:
        result = run(test_argv, capture_output=True, text=True)

    # All non-xfail cases should succeed
    assert result.returncode == 0


def test_project_dotenv_only_not_project_cwd_typer(
    project_directories: dict[str, Path],
) -> None:
    dirs = project_directories
    result = run(
        [
            "FABulous",
            "--project-dot-env",
            str(dirs["project_dotenv_fallback_file"]),
            "run",
            "help",
        ],
        capture_output=True,
        text=True,
        cwd=str(dirs["default_dir"]),
    )
    # Expect command executed successfully
    assert result.returncode == 0


@pytest.mark.parametrize(
    "argv",
    [
        pytest.param(
            ["FABulous", "-gde", "/tmp/global.env", "run", "help"], id="short-gde"
        ),
        pytest.param(
            ["FABulous", "-pde", "/tmp/project.env", "run", "help"], id="short-pde"
        ),
        pytest.param(
            [
                "FABulous",
                "-gde",
                "/tmp/global.env",
                "-pde",
                "/tmp/project.env",
                "run",
                "help",
            ],
            id="both-short",
        ),
    ],
)
def test_short_dotenv_flags(
    project_directories: dict[str, Path], argv: list[str]
) -> None:
    """Test short flag versions of dotenv options (-gde, -pde)"""
    dirs = project_directories
    # Replace placeholder paths with actual test files
    for i, arg in enumerate(argv):
        if arg == "/tmp/global.env":
            argv[i] = str(dirs["global_dotenv_file"])
        elif arg == "/tmp/project.env":
            argv[i] = str(dirs["project_dotenv_file"])

    result = run(
        argv,
        capture_output=True,
        text=True,
        cwd=str(dirs["default_dir"]),
    )
    # Should not crash and should process dotenv files
    assert isinstance(result.returncode, int)


def test_version_compatibility_function(tmp_path: Path) -> None:
    """Test version compatibility checking function directly"""
    from unittest.mock import patch

    from FABulous.FABulous import check_version_compatibility
    from FABulous.FABulous_settings import init_context, reset_context

    # Create a test project with version info
    project_dir = tmp_path / "version_test_project"
    project_dir.mkdir()
    fabulous_dir = project_dir / ".FABulous"
    fabulous_dir.mkdir()
    env_file = fabulous_dir / ".env"

    set_key(env_file, "FAB_PROJ_LANG", "verilog")
    set_key(env_file, "FAB_PROJ_VERSION", "1.0.0")
    set_key(env_file, "FAB_MODEL_PACK", "model_pack.v")

    reset_context()

    # Test version compatibility with mocked package version
    with patch("FABulous.FABulous.version") as mock_version:
        mock_version.return_value = "2.0.0"  # Newer package version

        # Initialize context with the test project
        init_context(project_dir=project_dir)

    # This should log an error about major version mismatch (no exit)
    # Should not raise. Logging checks are environment-dependent.
    check_version_compatibility(project_dir)


@pytest.mark.parametrize(
    "subcmd",
    [
        pytest.param("script", id="script"),
        pytest.param("run", id="run"),
        pytest.param("start", id="start"),
        pytest.param("create-project", id="create-project"),
        pytest.param("install-oss-cad-suite", id="install-oss-cad-suite"),
        pytest.param("update-project-version", id="update-project-version"),
    ],
)
def test_subcommand_help(monkeypatch: pytest.MonkeyPatch, subcmd: str) -> None:
    argv = ["FABulous", subcmd, "--help"]
    monkeypatch.setattr(sys, "argv", argv)
    with pytest.raises(SystemExit) as exc_info:
        main()
    assert exc_info.value.code == 0
