import platform
import shutil
import subprocess
from pathlib import Path
from unittest.mock import Mock, patch

import pytest

from FABulous.FABulous_CLI.helper import create_project, install_librelane, update_project_version


def test_create_project(tmp_path: Path) -> None:
    # Test Verilog project creation
    project_dir = tmp_path / "test_project_verilog"
    create_project(project_dir)

    # Check if directories exist
    assert project_dir.exists()
    assert (project_dir / ".FABulous").exists()

    # Check if .env file exists and contains correct content
    env_file = project_dir / ".FABulous" / ".env"
    assert env_file.exists()
    assert "FAB_PROJ_LANG='verilog'" in env_file.read_text()
    assert "VERSION=" in env_file.read_text()
    assert "FAB_PROJ_VERSION=" in env_file.read_text()
    assert "FAB_PROJ_VERSION_CREATED=" in env_file.read_text()

    # Check if template files were copied
    assert any(project_dir.glob("**/*.v")), (
        "No Verilog files found in project directory"
    )


def test_create_project_vhdl(tmp_path: Path) -> None:
    # Test VHDL project creation
    project_dir = tmp_path / "test_project_vhdl"
    create_project(project_dir, lang="vhdl")

    # Check if directories exist
    assert project_dir.exists()
    assert (project_dir / ".FABulous").exists()

    # Check if .env file exists and contains correct content
    env_file = project_dir / ".FABulous" / ".env"
    assert env_file.exists()
    assert "FAB_PROJ_LANG='vhdl'" in env_file.read_text()
    assert "FAB_PROJ_VERSION=" in env_file.read_text()
    assert "FAB_PROJ_VERSION_CREATED=" in env_file.read_text()

    # Check if template files were copied
    assert any(project_dir.glob("**/*.vhdl")), (
        "No VHDL files found in project directory"
    )


def test_create_project_existing_dir(tmp_path: Path) -> None:
    # Test creating project in existing directory
    project_dir = tmp_path / "existing_dir"
    project_dir.mkdir()

    with pytest.raises(SystemExit):
        create_project(project_dir)


def test_update_project_version_success(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    env_dir = tmp_path / "proj" / ".FABulous"
    env_dir.mkdir(parents=True)
    env_file = env_dir / ".env"
    env_file.write_text("FAB_PROJ_VERSION=1.2.3\n")

    # Patch version() to return compatible version
    monkeypatch.setattr("FABulous.FABulous_CLI.helper.version", lambda _: "1.2.4")

    assert update_project_version(tmp_path / "proj") is True
    assert "FAB_PROJ_VERSION='1.2.4'" in env_file.read_text()


def test_update_project_version_missing_version(tmp_path: Path) -> None:
    env_dir = tmp_path / "proj" / ".FABulous"
    env_dir.mkdir(parents=True)
    env_file = env_dir / ".env"
    env_file.write_text("FAB_PROJ_LANG=verilog\n")

    assert update_project_version(tmp_path / "proj") is False


def test_update_project_version_major_mismatch(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    env_dir = tmp_path / "proj" / ".FABulous"
    env_dir.mkdir(parents=True)
    env_file = env_dir / ".env"
    env_file.write_text("FAB_PROJ_VERSION=1.2.3\n")

    monkeypatch.setattr("FABulous.FABulous_CLI.helper.version", lambda _: "2.0.0")

    assert update_project_version(tmp_path / "proj") is False


class TestInstallLibrelane:
    """Test suite for install_librelane function."""

    @patch("FABulous.FABulous_CLI.helper.platform.system")
    def test_install_librelane_windows_error(self, mock_system: Mock, tmp_path: Path) -> None:
        """Test that Windows platform raises ValueError."""
        mock_system.return_value = "Windows"
        
        with pytest.raises(ValueError, match="LibreLane installation on Windows requires WSL2"):
            install_librelane(tmp_path)

    @patch("FABulous.FABulous_CLI.helper.platform.system")
    def test_install_librelane_unsupported_platform(self, mock_system: Mock, tmp_path: Path) -> None:
        """Test that unsupported platforms raise ValueError."""
        mock_system.return_value = "FreeBSD"
        
        with pytest.raises(ValueError, match="Unsupported operating system freebsd"):
            install_librelane(tmp_path)

    @patch("FABulous.FABulous_CLI.helper.init_context")
    @patch("FABulous.FABulous_CLI.helper.get_context")
    @patch("FABulous.FABulous_CLI.helper.shutil.which")
    @patch("FABulous.FABulous_CLI.helper.subprocess.run")
    @patch("FABulous.FABulous_CLI.helper.set_key")
    @patch("FABulous.FABulous_CLI.helper._configure_existing_nix")
    @patch("FABulous.FABulous_CLI.helper.platform.system")
    def test_install_librelane_with_existing_nix(
        self,
        mock_system: Mock,
        mock_configure_nix: Mock,
        mock_set_key: Mock,
        mock_subprocess: Mock,
        mock_which: Mock,
        mock_get_context: Mock,
        mock_init_context: Mock,
        tmp_path: Path,
    ) -> None:
        """Test installation with existing Nix installation."""
        # Setup mocks
        mock_system.return_value = "Linux"
        mock_which.return_value = "/usr/bin/nix"
        mock_context = Mock()
        mock_context.user_config_dir = tmp_path / "config"
        mock_get_context.return_value = mock_context
        
        # Mock successful git clone
        mock_subprocess.return_value = Mock(returncode=0)
        
        # Run the function
        install_librelane(tmp_path)
        
        # Verify behavior
        mock_init_context.assert_called_once_with(None)
        mock_which.assert_called_once_with("nix")
        mock_configure_nix.assert_called_once()
        
        # Verify git clone was called
        git_clone_call = None
        for call in mock_subprocess.call_args_list:
            if call[0] and len(call[0]) > 0 and "git" in str(call[0][0]):
                git_clone_call = call
                break
        
        assert git_clone_call is not None
        args = git_clone_call[0][0]
        assert args[0] == "git"
        assert args[1] == "clone"
        assert args[2] == "https://github.com/librelane/librelane"
        assert str(tmp_path / "librelane") in args[3]
        
        # Verify environment file setup
        assert (tmp_path / "config").exists()
        mock_set_key.assert_called_once()

    @patch("FABulous.FABulous_CLI.helper.init_context")
    @patch("FABulous.FABulous_CLI.helper.get_context")
    @patch("FABulous.FABulous_CLI.helper.shutil.which")
    @patch("FABulous.FABulous_CLI.helper.subprocess.run")
    @patch("FABulous.FABulous_CLI.helper.set_key")
    @patch("FABulous.FABulous_CLI.helper._install_nix_with_cache")
    @patch("FABulous.FABulous_CLI.helper.platform.system")
    def test_install_librelane_without_nix(
        self,
        mock_system: Mock,
        mock_install_nix: Mock,
        mock_set_key: Mock,
        mock_subprocess: Mock,
        mock_which: Mock,
        mock_get_context: Mock,
        mock_init_context: Mock,
        tmp_path: Path,
    ) -> None:
        """Test installation without existing Nix installation."""
        # Setup mocks
        mock_system.return_value = "Darwin"
        mock_which.return_value = None  # Nix not found
        mock_context = Mock()
        mock_context.user_config_dir = tmp_path / "config"
        mock_get_context.return_value = mock_context
        
        # Mock successful git clone
        mock_subprocess.return_value = Mock(returncode=0)
        
        # Run the function
        install_librelane(tmp_path)
        
        # Verify behavior
        mock_init_context.assert_called_once_with(None)
        mock_which.assert_called_once_with("nix")
        mock_install_nix.assert_called_once()

    @patch("FABulous.FABulous_CLI.helper.init_context")
    @patch("FABulous.FABulous_CLI.helper.get_context")
    @patch("FABulous.FABulous_CLI.helper.shutil.which")
    @patch("FABulous.FABulous_CLI.helper.subprocess.run")
    @patch("FABulous.FABulous_CLI.helper.platform.system")
    def test_install_librelane_git_clone_failure(
        self,
        mock_system: Mock,
        mock_subprocess: Mock,
        mock_which: Mock,
        mock_get_context: Mock,
        mock_init_context: Mock,
        tmp_path: Path,
    ) -> None:
        """Test that git clone failure raises ConnectionError."""
        # Setup mocks
        mock_system.return_value = "Linux"
        mock_which.return_value = "/usr/bin/nix"
        mock_context = Mock()
        mock_context.user_config_dir = tmp_path / "config"
        mock_get_context.return_value = mock_context
        
        # Mock git clone failure for the clone command specifically
        def mock_run_side_effect(*args, **kwargs):
            # Check if this is the git clone command
            if args and len(args[0]) > 0 and args[0][0] == "git" and args[0][1] == "clone":
                raise subprocess.CalledProcessError(1, args[0], "Clone failed")
            # For other subprocess calls (like pkill), return success
            return Mock(returncode=0)
        
        mock_subprocess.side_effect = mock_run_side_effect
        
        # Run the function and expect ConnectionError
        with pytest.raises(ConnectionError, match="Failed to clone LibreLane repository"):
            install_librelane(tmp_path)

    @patch("FABulous.FABulous_CLI.helper.init_context")
    @patch("FABulous.FABulous_CLI.helper.get_context")
    @patch("FABulous.FABulous_CLI.helper.shutil.which")
    @patch("FABulous.FABulous_CLI.helper.subprocess.run")
    @patch("FABulous.FABulous_CLI.helper.set_key")
    @patch("FABulous.FABulous_CLI.helper.shutil.rmtree")
    @patch("FABulous.FABulous_CLI.helper.platform.system")
    def test_install_librelane_existing_directory_removal(
        self,
        mock_system: Mock,
        mock_rmtree: Mock,
        mock_set_key: Mock,
        mock_subprocess: Mock,
        mock_which: Mock,
        mock_get_context: Mock,
        mock_init_context: Mock,
        tmp_path: Path,
    ) -> None:
        """Test that existing LibreLane directory is removed before installation."""
        # Setup mocks
        mock_system.return_value = "Linux"
        mock_which.return_value = "/usr/bin/nix"
        mock_context = Mock()
        mock_context.user_config_dir = tmp_path / "config"
        mock_get_context.return_value = mock_context
        
        # Create existing librelane directory
        existing_librelane = tmp_path / "librelane"
        existing_librelane.mkdir()
        
        # Mock successful git clone
        mock_subprocess.return_value = Mock(returncode=0)
        
        # Run the function
        install_librelane(tmp_path)
        
        # Verify that rmtree was called to remove existing directory
        mock_rmtree.assert_called_once_with(existing_librelane)

    @patch("FABulous.FABulous_CLI.helper.init_context")
    @patch("FABulous.FABulous_CLI.helper.get_context")
    @patch("FABulous.FABulous_CLI.helper.shutil.which")
    @patch("FABulous.FABulous_CLI.helper.subprocess.run")
    @patch("FABulous.FABulous_CLI.helper.set_key")
    @patch("FABulous.FABulous_CLI.helper.platform.system")
    def test_install_librelane_creates_destination_folder(
        self,
        mock_system: Mock,
        mock_set_key: Mock,
        mock_subprocess: Mock,
        mock_which: Mock,
        mock_get_context: Mock,
        mock_init_context: Mock,
        tmp_path: Path,
    ) -> None:
        """Test that destination folder is created if it doesn't exist."""
        # Setup mocks
        mock_system.return_value = "Linux"
        mock_which.return_value = "/usr/bin/nix"
        mock_context = Mock()
        mock_context.user_config_dir = tmp_path / "config"
        mock_get_context.return_value = mock_context
        
        # Mock successful git clone
        mock_subprocess.return_value = Mock(returncode=0)
        
        # Use non-existent destination folder
        non_existent_dest = tmp_path / "non_existent_folder"
        assert not non_existent_dest.exists()
        
        # Run the function
        install_librelane(non_existent_dest)
        
        # Verify destination folder was created
        assert non_existent_dest.exists()

    @patch("FABulous.FABulous_CLI.helper.init_context")
    @patch("FABulous.FABulous_CLI.helper.get_context")  
    @patch("FABulous.FABulous_CLI.helper.shutil.which")
    @patch("FABulous.FABulous_CLI.helper.subprocess.run")
    @patch("FABulous.FABulous_CLI.helper.set_key")
    @patch("FABulous.FABulous_CLI.helper.platform.system")
    def test_install_librelane_env_file_creation(
        self,
        mock_system: Mock,
        mock_set_key: Mock,
        mock_subprocess: Mock,
        mock_which: Mock,
        mock_get_context: Mock,
        mock_init_context: Mock,
        tmp_path: Path,
    ) -> None:
        """Test that environment file is created and configured correctly."""
        # Setup mocks
        mock_system.return_value = "Linux"
        mock_which.return_value = "/usr/bin/nix"
        
        config_dir = tmp_path / "config"
        mock_context = Mock()
        mock_context.user_config_dir = config_dir
        mock_get_context.return_value = mock_context
        
        # Mock successful git clone
        mock_subprocess.return_value = Mock(returncode=0)
        
        # Run the function
        dest_path = tmp_path / "install_dir"
        install_librelane(dest_path)
        
        # Verify config directory and env file creation
        assert config_dir.exists()
        env_file = config_dir / ".env"
        assert env_file.exists()
        
        # Verify set_key was called with correct parameters
        expected_librelane_path = str((dest_path / "librelane").absolute())
        mock_set_key.assert_called_once_with(env_file, "FAB_LIBRELANE_PATH", expected_librelane_path)
