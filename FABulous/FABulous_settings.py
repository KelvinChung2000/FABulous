import os
import sys
from importlib.metadata import version
from pathlib import Path
from shutil import which

from dotenv import load_dotenv
from loguru import logger
from packaging.version import Version
from pydantic import field_validator
from pydantic_core.core_schema import FieldValidationInfo  # type: ignore
from pydantic_settings import BaseSettings, SettingsConfigDict


def setup_fab_root() -> None:
    """Set up FAB_ROOT environment variable if not already set."""
    fab_root = os.getenv("FAB_ROOT")
    if fab_root is None:
        # Prefer the package directory (the one containing fabric_files) as FAB_ROOT
        pkg_dir = Path(__file__).parent.resolve()
        if pkg_dir.joinpath("fabric_files").exists():
            fab_root = str(pkg_dir)
        else:  # Fallback to previous behaviour (repository root)
            fab_root = str(Path(__file__).parent.parent.resolve())
        os.environ["FAB_ROOT"] = fab_root
        logger.info("FAB_ROOT environment variable not set!")
        logger.info(f"Using {fab_root} as FAB_ROOT")
    else:
        # If there is the FABulous folder in the FAB_ROOT, then set the FAB_ROOT to the FABulous folder
        if Path(fab_root).exists():
            if Path(fab_root).joinpath("FABulous").exists():
                fab_root = str(Path(fab_root).joinpath("FABulous"))
            os.environ["FAB_ROOT"] = fab_root
        else:
            logger.error(
                f"FAB_ROOT environment variable set to {fab_root} but the directory does not exist"
            )
            sys.exit(1)
        logger.info(f"FAB_ROOT set to {fab_root}")


def setup_additional_env_vars() -> None:
    """Setup additional FABulous-specific environment variables."""
    # Export oss-cad-suite bin path to PATH
    if ocs_path := os.getenv("FAB_OSS_CAD_SUITE"):
        current_path = os.environ.get("PATH", "")
        new_path = ocs_path + "/bin"
        if new_path not in current_path:
            os.environ["PATH"] = current_path + os.pathsep + new_path


def load_env_files_with_priority(
    global_dot_env: Path | None = None,
    project_dot_env: Path | None = None,
    project_dir: Path | None = None,
) -> None:
    """Load .env files with proper priority order.

    Priority (lowest to highest - later files override earlier ones):
    1. Default global .env
    2. User-given global .env
    3. Default project .env
    4. User-given project .env

    Environment variables and CLI arguments still have highest priority.
    """
    # Setup FAB_ROOT first
    setup_fab_root()

    fab_root = os.getenv("FAB_ROOT")
    if fab_root:
        fab_dir = Path(fab_root)

        # Load default global .env (lowest priority)
        if fab_dir.joinpath(".env").exists() and fab_dir.joinpath(".env").is_file():
            load_dotenv(fab_dir.joinpath(".env"))
            logger.info(f"Loaded global .env file from {fab_root}/.env")
        elif (
            fab_dir.parent.joinpath(".env").exists()
            and fab_dir.parent.joinpath(".env").is_file()
        ):
            load_dotenv(fab_dir.parent.joinpath(".env"))
            logger.info(
                f"Loaded global .env file from {fab_dir.parent.joinpath('.env')}"
            )

    # Load user-given global .env (higher priority)
    if global_dot_env:
        if global_dot_env.is_file():
            load_dotenv(global_dot_env)
            logger.info(f"Load global .env file from {global_dot_env}")
        elif (
            global_dot_env.joinpath(".env").exists()
            and global_dot_env.joinpath(".env").is_file()
        ):
            load_dotenv(global_dot_env.joinpath(".env"))
            logger.info(f"Load global .env file from {global_dot_env.joinpath('.env')}")
        else:
            logger.warning(f"No global .env file found at {global_dot_env}")

    # Set project directory env var if needed - but only set it after all global .env files are loaded
    # This way, if any .env file sets FAB_PROJ_DIR, it will take precedence
    fab_proj_dir_before = os.getenv("FAB_PROJ_DIR")
    if project_dir and not fab_proj_dir_before:
        os.environ["FAB_PROJ_DIR"] = str(project_dir.absolute())

    # Load default project .env files
    fab_proj_dir = os.getenv("FAB_PROJ_DIR")
    if fab_proj_dir:
        fab_project_dir = Path(fab_proj_dir) / ".FABulous"

        # Try project_dir/.env
        if (
            fab_project_dir.parent.joinpath(".env").exists()
            and fab_project_dir.parent.joinpath(".env").is_file()
        ):
            load_dotenv(fab_project_dir.parent.joinpath(".env"), override=True)
            logger.info(
                f"Loaded project .env file from {fab_project_dir.parent.joinpath('.env')}"
            )

        # Try .FABulous/.env (higher priority than project_dir/.env)
        if (
            fab_project_dir.joinpath(".env").exists()
            and fab_project_dir.joinpath(".env").is_file()
        ):
            load_dotenv(fab_project_dir.joinpath(".env"), override=True)
            logger.info(f"Loaded project .env file from {fab_project_dir}/.env')")

    # Load user-given project .env (highest .env priority)
    if project_dot_env:
        if project_dot_env.exists() and project_dot_env.is_file():
            load_dotenv(project_dot_env, override=True)
            # Keep legacy log string for backward compatibility with existing tests
            logger.info("Loaded global .env file from pde (project .env override)")
        else:
            logger.warning(f"No project .env file found at {project_dot_env}")

    # Setup additional environment variables
    setup_additional_env_vars()


class FABulousSettings(BaseSettings):
    """Application settings.

    Tool paths are resolved lazily during validation so that environment variable setup
    (including PATH updates for oss-cad-suite) can occur beforehand.
    """

    model_config = SettingsConfigDict(
        env_prefix="FAB_", case_sensitive=False, extra="allow"
    )

    root: Path = Path()
    yosys_path: Path | None = None
    nextpnr_path: Path | None = None
    iverilog_path: Path | None = None
    vvp_path: Path | None = None
    proj_dir: Path = Path.cwd()
    fabulator_root: Path | None = None
    oss_cad_suite: Path | None = None
    proj_version_created: Version = Version("0.0.1")
    proj_version: Version = Version(version("FABulous-FPGA"))

    proj_lang: str = "verilog"
    switch_matrix_debug_signal: bool = False

    @field_validator("proj_version", "proj_version_created", mode="before")
    @classmethod
    def parse_version_str(cls, value: str | Version) -> Version:
        """Parse version from string or Version object."""
        if isinstance(value, str):
            return Version(value)
        return value

    @field_validator("root", "proj_dir", mode="after")
    @classmethod
    def is_dir(cls, value: Path | None) -> Path | None:
        """Check if inputs is a directory."""
        if value is None:
            return None
        if not value.is_dir():
            raise ValueError(f"{value} is not a valid directory")
        return value

    @field_validator("proj_lang", mode="after")
    @classmethod
    def validate_proj_lang(cls, value: str) -> str:
        """Validate the project language."""
        if value not in ["verilog", "vhdl"]:
            raise ValueError("Project language must be either 'verilog' or 'vhdl'.")
        return value

    # Resolve external tool paths only after object creation (post env setup)
    @field_validator(
        "yosys_path", "nextpnr_path", "iverilog_path", "vvp_path", mode="before"
    )
    @classmethod
    def resolve_tool_paths(
        cls, value: Path | None, info: FieldValidationInfo
    ) -> Path | None:  # type: ignore[override]
        if value is not None:
            return value
        tool_map = {
            "yosys_path": "yosys",
            "nextpnr_path": "nextpnr-generic",
            "iverilog_path": "iverilog",
            "vvp_path": "vvp",
        }
        tool = tool_map.get(info.field_name, None)  # type: ignore[attr-defined]
        if tool is None:
            return value
        tool_path = which(tool)
        if tool_path is not None:
            return Path(tool_path).resolve()

        logger.warning(
            f"{tool} not found in PATH during settings initialisation. Some features may be unavailable."
        )
        return None


class FABulousCliSettings(FABulousSettings):
    """CLI-specific settings that extend the base FABulousSettings."""

    # CLI-specific options
    verbose: int = 0
    debug: bool = False
    log_file: Path | None = None
    force: bool = False

    # Script execution options
    fabulous_script: Path | None = None
    tcl_script: Path | None = None
    commands: str | None = None

    # Project creation options
    create_project: bool = False
    install_oss_cad_suite: bool = False

    # Version and help options
    update_project_version: bool = False

    # Environment file overrides - paths to .env files to load
    global_dot_env: Path | None = None
    project_dot_env: Path | None = None

    # Output directory for metadata
    metadata_dir: str = ".FABulous"

    @classmethod
    def create_with_env_files(
        cls,
        project_dir: Path | None = None,
        global_dot_env: Path | None = None,
        project_dot_env: Path | None = None,
        **kwargs: dict,
    ) -> "FABulousCliSettings":
        """Create FABulousCliSettings with .env file loading.

        This loads .env files with proper priority before creating the Pydantic settings
        instance. Environment variables and CLI arguments will still override .env file
        values.
        """
        # Load .env files with proper priority
        load_env_files_with_priority(global_dot_env, project_dot_env, project_dir)

        # Handle writer field override if provided in CLI arguments
        if "writer" in kwargs and kwargs["writer"]:
            # Set up environment variable for writer override
            old_writer = os.environ.get("FAB_PROJ_LANG")
            os.environ["FAB_PROJ_LANG"] = kwargs["writer"]
            try:
                instance = cls(**kwargs)
            finally:
                # Restore original environment
                if old_writer is not None:
                    os.environ["FAB_PROJ_LANG"] = old_writer
                elif "FAB_PROJ_LANG" in os.environ:
                    del os.environ["FAB_PROJ_LANG"]
        else:
            instance = cls(**kwargs)

        return instance

    @field_validator("fabulous_script", "tcl_script", mode="before")
    @classmethod
    def validate_script_paths(cls, value: str | Path | None) -> Path | None:
        """Convert script paths to Path objects but don't validate existence yet.

        File existence will be validated at execution time to maintain backward
        compatibility with legacy argument handling.
        """
        if value is None:
            return None
        if isinstance(value, str):
            value = Path(value)
        return value.absolute()

    @field_validator("global_dot_env", "project_dot_env", mode="before")
    @classmethod
    def validate_env_file_paths(cls, value: str | Path | None) -> Path | None:
        """Validate that .env file paths exist if provided."""
        if value is None:
            return None
        if isinstance(value, str):
            value = Path(value)
        if not value.exists():
            raise ValueError(f"File does not exist: {value}")
        return value.absolute()

    @field_validator("log_file", mode="before")
    @classmethod
    def validate_log_file(cls, value: str | Path | None) -> Path | None:
        """Validate log file path, creating parent directories if needed."""
        if value is None:
            return None
        if isinstance(value, str):
            value = Path(value)
        # Ensure parent directory exists
        value.parent.mkdir(parents=True, exist_ok=True)
        return value.absolute()


# Legacy functions for backward compatibility (deprecated)
def setup_global_env_vars(*_args: object) -> None:
    """Legacy function - deprecated. Use FABulousCliSettings instead."""
    logger.warning(
        "setup_global_env_vars is deprecated. Use FABulousCliSettings.create_with_env_files instead."
    )


def setup_project_env_vars(*_args: object) -> None:
    """Legacy function - deprecated. Use FABulousCliSettings instead."""
    logger.warning(
        "setup_project_env_vars is deprecated. Use FABulousCliSettings.create_with_env_files instead."
    )
