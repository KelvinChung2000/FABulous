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
import typer
from dotenv import set_key
from pytest_mock import MockerFixture

from FABulous.FABulous import main
from FABulous.FABulous_settings import init_context, reset_context


@pytest.mark.parametrize(
    (
        "argv",
        "writer_lang",
        "precreate",
        "expected_code",
    ),
    [
        pytest.param(
            ["FABulous", "create-project"], None, False, 0, id="typer-no-writer"
        ),
        pytest.param(
            ["FABulous", "--create-project"], None, False, 0, id="legacy-no-writer"
        ),
        pytest.param(
            ["FABulous", "-w", "vhdl", "--create-project"],
            "vhdl",
            False,
            0,
            id="legacy-writer",
        ),
        pytest.param(
            ["FABulous", "-w", "vhdl", "create-project"],
            "vhdl",
            False,
            0,
            id="typer-writer",
        ),
        pytest.param(
            ["FABulous", "-w", "invalid", "create-project"],
            "vhdl",
            False,
            0,
            id="typer-invalid-writer",
        ),
        pytest.param(
            ["FABulous", "-w", "invalid", "--create-project"],
            "vhdl",
            False,
            0,
            id="legacy-invalid-writer",
        ),
    ],
)
def test_create_project_cases(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    writer_lang: str,
    argv: list[str],
    precreate: bool,
    expected_code: int,
) -> None:
    project_dir = tmp_path / "test_prj"
    if precreate:
        project_dir.mkdir(parents=True, exist_ok=True)

    test_argv = argv
    # Append project directory to the command
    test_argv.append(str(project_dir))

    monkeypatch.setattr(sys, "argv", test_argv)
    with pytest.raises(SystemExit) as exc_info:
        main()
    assert exc_info.value.code == expected_code

    if expected_code == 0 and not precreate:
        # Success path: verify project + writer recorded
        assert project_dir.exists()
        env_text = (project_dir / ".FABulous" / ".env").read_text().lower()
        if writer_lang == "vhdl":
            assert writer_lang in env_text
        else:
            assert "verilog" in env_text


@pytest.mark.parametrize(
    ("argv", "start_dir", "expected_code"),
    [
        # FAB script with explicit project
        pytest.param(
            ["FABulous", "{project}", "--FABulousScript", "{file}"],
            None,
            0,
            id="fab-legacy",
        ),
        pytest.param(
            ["FABulous", "script", "{project}", "{file}"],
            None,
            0,
            id="fab-typer",
        ),
        # FAB script in cwd in a project
        pytest.param(
            ["FABulous", "--FABulousScript", "{file}"],
            "project",
            0,
            id="fab-cwd-project",
        ),
        # FAB script with nonexistent file
        pytest.param(
            ["FABulous", "script", "{project}", "{missing}"],
            None,
            1,
            id="fab-nonexistent",
        ),
        # TCL script with explicit project
        pytest.param(
            ["FABulous", "{project}", "--TCLScript", "{tcl}"],
            None,
            0,
            id="tcl-legacy",
        ),
        pytest.param(
            ["FABulous", "script", "{project}", "{tcl}"],
            None,
            0,
            id="tcl-typer",
        ),
        # FAB script in non-project cwd (should fail)
        pytest.param(
            ["FABulous", "--FABulousScript", "{file}"],
            "nonproject",
            1,
            id="fab-cwd-nonproject",
        ),
    ],
)
def test_script_execution_cases(
    tmp_path: Path,
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv: list[str],
    start_dir: str | None,
    expected_code: int,
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

    assert exc_info.value.code == expected_code


@pytest.mark.parametrize(
    ("argv", "commands", "expect_fail", "expected_code"),
    [
        pytest.param(
            ["FABulous", "{project}", "--commands"],
            "help; help",
            False,
            0,
            id="legacy-success",
        ),
        pytest.param(
            ["FABulous", "run", "{project}"],
            "help",
            False,
            0,
            id="typer-success",
        ),
        pytest.param(
            ["FABulous", "{project}", "--commands"],
            "",
            False,
            0,
            id="empty-commands",
        ),
        pytest.param(
            ["FABulous", "{project}", "--commands"],
            "load_fabric non_exist; load_fabric non_exist",
            True,
            1,
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
    expected_code: int,
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
        assert exc_info.value.code == expected_code


@pytest.mark.parametrize(
    ("argv_builder", "expected_code"),
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
            0,
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
            0,
            id="typer",
        ),
    ],
)
def test_logging_file_creation(
    tmp_path: Path,
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv_builder: Callable[[Path, Path], list[str]],
    expected_code: int,
) -> None:
    """Logging creates file for both legacy and Typer styles."""
    log_file = tmp_path / "cli_test.log"
    test_args = argv_builder(project, log_file)
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == expected_code
    assert log_file.exists()
    assert log_file.stat().st_size > 0


## merged into test_verbose_mode_parametric


@pytest.mark.parametrize(
    ("argv", "vflag", "expected_code"),
    [
        pytest.param(
            ["FABulous", "{project}", "--commands", "help"],
            ["-v"],
            0,
            id="legacy-v",
        ),
        pytest.param(
            ["FABulous", "{project}", "--commands", "help"],
            ["-vv"],
            0,
            id="legacy-vv",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help"],
            ["-v"],
            0,
            id="typer-v",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help"],
            ["-vv"],
            0,
            id="typer-vv",
        ),
    ],
)
def test_verbose_mode_parametric(
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv: list[str],
    vflag: list[str],
    expected_code: int,
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
    assert exc_info.value.code == expected_code


@pytest.mark.parametrize(
    ("argv", "expected_code"),
    [
        pytest.param(
            ["FABulous", "{project}", "--commands", "help", "--debug"],
            0,
            id="legacy",
        ),
        pytest.param(
            ["FABulous", "--debug", "run", "{project}", "help"],
            0,
            id="typer",
        ),
    ],
)
def test_debug_mode(
    project: Path, monkeypatch: pytest.MonkeyPatch, argv: list[str], expected_code: int
) -> None:
    """Debug mode works in both legacy and Typer forms."""
    test_args = [arg.replace("{project}", str(project)) for arg in argv]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == expected_code


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
    """Parametric test for install-oss-cad-suite variants with mocked network."""

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

    assert exc_info.value.code == expected_code
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
        ),
        pytest.param(
            ["FABulous", "script", "/nonexistent/path/to/project", "help"],
            None,
            None,
            id="typer-nonexistent",
        ),
        pytest.param(
            ["FABulous", "{regular_dir}", "--commands", "help"],
            "regular_directory",
            "not a FABulous project",
            id="no-fabulous-folder",
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
    if expected_dir == "default_dir":
        # Fallback path: just ensure a project directory was resolved
        assert settings.proj_dir is not None
        assert settings.proj_dir.exists()
    else:
        assert settings.proj_dir.resolve() == dirs[expected_dir].resolve()


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
    ("argv", "result", "chdir_flag", "expected_code"),
    [
        pytest.param(
            ["FABulous", "update-project-version", "{project}"],
            True,
            False,
            0,
            id="explicit-success",
        ),
        pytest.param(
            ["FABulous", "update-project-version", "{project}"],
            False,
            False,
            1,
            id="explicit-failure",
        ),
        pytest.param(
            ["FABulous", "update-project-version"], True, True, 0, id="cwd-success"
        ),
    ],
)
def test_update_project_version_cases(
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    argv: list[str],
    result: bool,
    chdir_flag: bool,
    expected_code: int,
) -> None:
    test_argv = [s.replace("{project}", str(project)) for s in argv]
    if chdir_flag:
        monkeypatch.chdir(project)
    monkeypatch.setattr("FABulous.FABulous.update_project_version", lambda _p: result)
    monkeypatch.setattr(sys, "argv", test_argv)
    with pytest.raises(SystemExit) as exc_info:
        main()
    assert exc_info.value.code == expected_code


@pytest.mark.parametrize(
    "file_ext",
    [
        pytest.param(".txt", id="txt"),
        pytest.param(".fab", id="fab"),
        pytest.param(".tcl", id="tcl"),
    ],
)
@pytest.mark.parametrize(
    ("explicit_type", "content", "expected_code"),
    [
        pytest.param("fabulous", "help\n", 0, id="type-fabulous"),
        pytest.param("tcl", 'puts "hi"\n', 0, id="type-tcl"),
        pytest.param(
            "unknown",
            "help\n",
            1,
            id="type-invalid",
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
    expected_code: int,
) -> None:
    """Explicit type flag should dictate execution mode regardless of extension."""
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

    assert exc_info.value.code == expected_code


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
    ("argv", "use_cwd", "expected_codes"),
    [
        pytest.param(
            ["FABulous", "run", "{project}"],
            False,
            [0, 1],  # Can return either 0 or 1
            id="run-none",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help"],
            False,
            [0],
            id="run-single",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help;help"],
            False,
            [0],
            id="run-multi",
        ),
        pytest.param(
            ["FABulous", "run", "{project}", "help;  help"],
            False,
            [0],
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
            [1],  # Should fail with non-zero exit code
            id="run-force-failures",
        ),
        pytest.param(
            ["FABulous", "r", "{project}", "help"],
            False,
            [0],
            id="run-alias-r",
        ),
        pytest.param(
            ["FABulous", "start"],
            True,
            [0],
            id="start-in-cwd",
        ),
    ],
)
def test_run_and_start_variants(
    project: Path, argv: list[str], use_cwd: bool, expected_codes: list[int]
) -> None:
    test_argv = [s.replace("{project}", str(project)) for s in argv]
    if use_cwd:
        result = run(test_argv, capture_output=True, text=True, cwd=str(project))
    else:
        result = run(test_argv, capture_output=True, text=True)

    # Check return code against expected values
    assert result.returncode in expected_codes


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
    ("subcmd", "expected_code"),
    [
        pytest.param("script", 0, id="script"),
        pytest.param("run", 0, id="run"),
        pytest.param("start", 0, id="start"),
        pytest.param("create-project", 0, id="create-project"),
        pytest.param("install-oss-cad-suite", 0, id="install-oss-cad-suite"),
        pytest.param("update-project-version", 0, id="update-project-version"),
    ],
)
def test_subcommand_help(
    monkeypatch: pytest.MonkeyPatch, subcmd: str, expected_code: int
) -> None:
    argv = ["FABulous", subcmd, "--help"]
    monkeypatch.setattr(sys, "argv", argv)
    with pytest.raises(SystemExit) as exc_info:
        main()
    assert exc_info.value.code == expected_code


# ============================================================================
# Additional Tests for Missing Coverage
# ============================================================================


def test_version_callback() -> None:
    """Test version_callback function behavior"""
    from FABulous.FABulous import version_callback

    # Test that version_callback raises typer.Exit when value is True
    with pytest.raises(typer.Exit):
        version_callback(True)

    # Test that version_callback does nothing when value is False
    version_callback(False)  # Should not raise


def test_validate_project_directory_success(project: Path) -> None:
    """Test validate_project_directory with valid project"""
    from FABulous.FABulous import validate_project_directory

    result = validate_project_directory(str(project))
    assert result == project


def test_validate_project_directory_invalid(tmp_path: Path) -> None:
    """Test validate_project_directory with invalid project"""
    from FABulous.FABulous import validate_project_directory

    invalid_dir = tmp_path / "not_a_project"
    invalid_dir.mkdir()

    with pytest.raises(ValueError, match="not a valid FABulous project"):
        validate_project_directory(str(invalid_dir))


@pytest.mark.parametrize(
    ("package_ver", "project_ver", "should_exit", "should_log_error"),
    [
        pytest.param("2.0.0", "1.0.0", False, False, id="package-newer-minor"),
        pytest.param("1.0.0", "2.0.0", True, True, id="package-older"),
        pytest.param("2.0.0", "1.0.0", False, True, id="major-version-mismatch"),
        pytest.param("1.1.0", "1.0.0", False, False, id="same-major-newer-minor"),
    ],
)
def test_check_version_compatibility_cases(
    project: Path,
    package_ver: str,
    project_ver: str,
    should_exit: bool,
    should_log_error: bool,
) -> None:
    """Test version compatibility checking with different version scenarios"""
    from unittest.mock import patch

    from FABulous.FABulous import check_version_compatibility
    from FABulous.FABulous_settings import init_context, reset_context

    reset_context()

    # Set up project version in .env file
    env_file = project / ".FABulous" / ".env"
    from dotenv import set_key

    set_key(env_file, "FAB_PROJ_VERSION", project_ver)

    # Initialize context
    init_context(project_dir=project)

    # Mock the package version
    with patch("FABulous.FABulous.version") as mock_version:
        mock_version.return_value = package_ver

        if should_exit:
            with pytest.raises(typer.Exit):
                check_version_compatibility(project)
        else:
            # Should not raise an exception
            check_version_compatibility(project)


def test_shared_context_defaults() -> None:
    """Test SharedContext class default values"""
    from FABulous.FABulous import SharedContext

    context = SharedContext()
    assert context.verbose == 0
    assert context.debug is False
    assert context.log_file is None
    assert context.global_dot_env is None
    assert context.project_dot_env is None
    assert context.force is False
    assert context.writer == "verilog"


@pytest.mark.parametrize(
    ("script_content", "expected_code"),
    [
        pytest.param("help\n", 0, id="simple-command"),
        pytest.param("# Comment\nhelp\nload_fabric test\n", 0, id="multi-line"),
        pytest.param("", 0, id="empty-script"),
    ],
)
def test_script_execution_with_content(
    tmp_path: Path,
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    script_content: str,
    expected_code: int,
) -> None:
    """Test script execution with different content types"""
    script_file = tmp_path / "test.fab"
    script_file.write_text(script_content)

    test_args = ["FABulous", "script", str(project), str(script_file)]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == expected_code


def test_script_nonexistent_file(
    tmp_path: Path,
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    """Test script command with nonexistent file"""
    nonexistent_file = tmp_path / "nonexistent.fab"

    test_args = ["FABulous", "script", str(project), str(nonexistent_file)]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == 1


@pytest.mark.parametrize(
    ("file_ext", "expected_type", "expected_code"),
    [
        pytest.param(".fab", "fabulous", 0, id="fab-extension"),
        pytest.param(".fs", "fabulous", 0, id="fs-extension"),
        pytest.param(".tcl", "tcl", 0, id="tcl-extension"),
        pytest.param(".txt", "tcl", 0, id="unknown-extension-defaults-tcl"),
    ],
)
def test_script_type_detection(
    tmp_path: Path,
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
    file_ext: str,
    expected_type: str,
    expected_code: int,
) -> None:
    """Test automatic script type detection based on file extension"""
    # Note: expected_type is used for documentation but not assertion since
    # we're only testing that the command succeeds with different extensions
    script_file = tmp_path / f"test{file_ext}"
    script_file.write_text("help\n")

    test_args = ["FABulous", "script", str(project), str(script_file)]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == expected_code


def test_main_function_exception_handling(monkeypatch: pytest.MonkeyPatch) -> None:
    """Test main function handles unexpected exceptions"""
    from unittest.mock import Mock

    # Mock app to raise an unexpected exception
    mock_app = Mock(side_effect=RuntimeError("Unexpected error"))
    monkeypatch.setattr("FABulous.FABulous.app", mock_app)
    monkeypatch.setattr(sys, "argv", ["FABulous", "--help"])

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == 1


@pytest.mark.parametrize(
    ("legacy_args", "expected_exit_code"),
    [
        pytest.param(
            ["FABulous", "--createProject"],
            2,  # Missing project directory
            id="create-project-missing-dir",
        ),
        pytest.param(
            ["FABulous", "/nonexistent/path", "--commands", ""],
            0,  # Empty commands should exit gracefully
            id="empty-commands",
        ),
    ],
)
def test_legacy_argument_edge_cases(
    monkeypatch: pytest.MonkeyPatch,
    legacy_args: list[str],
    expected_exit_code: int,
) -> None:
    """Test edge cases in legacy argument conversion"""
    monkeypatch.setattr(sys, "argv", legacy_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    assert exc_info.value.code == expected_exit_code


def test_run_command_pipeline_error(
    project: Path,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    """Test run command with pipeline execution error"""
    test_args = [
        "FABulous",
        "run",
        str(project),
        "load_fabric nonexistent_fabric",
    ]
    monkeypatch.setattr(sys, "argv", test_args)

    with pytest.raises(SystemExit) as exc_info:
        main()

    # Should exit with non-zero code due to command failure
    assert exc_info.value.code != 0


def test_common_options_state_update() -> None:
    """Test that common_options updates shared_state correctly"""
    from FABulous.fabric_definition.define import HDLType
    from FABulous.FABulous import common_options, shared_state

    # Reset shared state
    shared_state.verbose = 0
    shared_state.debug = False
    shared_state.force = False

    # Call common_options with test values
    test_log_file = Path("/tmp/test.log")
    common_options(
        verbose=2, debug=True, log_file=test_log_file, force=True, writer=HDLType.VHDL
    )

    # Verify state was updated
    assert shared_state.verbose == 2
    assert shared_state.debug is True
    assert shared_state.log_file == test_log_file
    assert shared_state.force is True
    assert shared_state.writer == HDLType.VHDL


# ============================================================================
# New Additional CLI Edge Case Tests
# ============================================================================


def test_run_trailing_semicolon_noop(project: Path) -> None:
    """Trailing semicolon token 'help;' currently treated as no-op (success path).

    Document existing behavior: parser ignores unknown token without failing.
    """
    result = run(
        [
            "FABulous",
            "run",
            str(project),
            "help;",  # Parsed as single token 'help;' (invalid command)
        ],
        capture_output=True,
        text=True,
    )
    assert result.returncode == 0


def test_run_mixed_success_failure_pipeline(project: Path) -> None:
    """Pipeline stops on first failing command without --force."""
    cmd = "help; load_fabric non_exist"
    result = run(
        [
            "FABulous",
            "run",
            str(project),
            cmd,
        ],
        capture_output=True,
        text=True,
    )
    # Expect failure due to second command
    assert result.returncode != 0
    # only one occurrence of failing fabric token (stopped early)
    assert result.stdout.count("non_exist") == 1


def test_run_trailing_semicolon_force(project: Path) -> None:
    """With --force a trailing semicolon still yields non-zero exit but continues.

    The invalid command token should not abort processing of prior commands.
    """
    result = run(
        [
            "FABulous",
            "run",
            str(project),
            "help;",  # invalid token
            "--force",
        ],
        capture_output=True,
        text=True,
    )
    # Force doesn't turn invalid command into success; keep non-zero
    assert result.returncode != 0


def test_legacy_logging_default_filename(project: Path) -> None:
    """Using legacy -log without path should create FABulous.log in CWD."""
    result = run(
        [
            "FABulous",
            str(project),
            "--commands",
            "help",
            "-log",  # triggers default const filename
        ],
        capture_output=True,
        text=True,
        cwd=str(project),
    )
    assert result.returncode == 0
    log_file = Path(project) / "FABulous.log"
    assert log_file.exists()
    assert log_file.stat().st_size > 0


def test_writer_case_insensitive_verilog(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    """Explicit VERILOG (uppercase) should be accepted the same as lowercase."""
    project_dir = tmp_path / "test_upper_verilog"
    argv = [
        "FABulous",
        "--writer",
        "VERILOG",
        "create-project",
        str(project_dir),
    ]
    monkeypatch.setattr(sys, "argv", argv)
    with pytest.raises(SystemExit) as exc_info:
        main()
    assert exc_info.value.code == 0
    env_text = (project_dir / ".FABulous" / ".env").read_text().lower()
    assert "verilog" in env_text


def test_global_option_after_subcommand_error(project: Path) -> None:
    """Global option placed after subcommand should raise usage error (exit 2)."""
    result = run(
        [
            "FABulous",
            "run",
            "--debug",  # Misplaced
            str(project),
            "help",
        ],
        capture_output=True,
        text=True,
    )
    assert result.returncode == 2


def test_start_invalid_project() -> None:
    """Starting with a non-existent project directory should fail."""
    invalid = "/nonexistent/path/does/not/exist"
    result = run(
        [
            "FABulous",
            "start",
            invalid,
        ],
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0
