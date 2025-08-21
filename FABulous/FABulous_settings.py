import os
from importlib.metadata import version
from pathlib import Path
from shutil import which

from loguru import logger
from packaging.version import Version
from pydantic import ValidationInfo, field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class FABulousSettings(BaseSettings):
    """FABulous settings.

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
        cls, value: Path | None, info: ValidationInfo
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


# Module-level singleton pattern for settings management
_context_instance: FABulousSettings | None = None


def init_context(
    project_dir: Path | None,
    global_dot_env: Path | None = None,
    project_dot_env: Path | None = None,
) -> FABulousSettings:
    """Initialize the global FABulous context with settings.

    This should be called once at application startup to configure the global settings.
    Subsequent calls will override the existing context.

    This will also resolve the project directory and environment variables.

    Args:
        project_dir: Project directory path
        global_dot_env: Global .env file path
        project_dot_env: Project .env file path

    Returns:
        The initialized FABulousSettings instance
    """
    global _context_instance
    # Resolve .env files in priority order
    env_files: list[Path] = []

    fab_root = (
        Path(r) if (r := os.getenv("FAB_ROOT")) else Path(__file__).parent.resolve()
    )

    # Check FABulous directory first
    if fab_root.joinpath(".env").exists():
        env_files.append(fab_root.joinpath(".env"))

    # 2. User-provided global .env file
    if global_dot_env and global_dot_env.exists():
        env_files.append(global_dot_env)
    else:
        if global_dot_env is not None and not global_dot_env.exists():
            logger.warning(
                f"Global .env file not found: {global_dot_env} this is ignored"
            )

    # 3. Default project .env files
    fab_proj_dir = os.getenv("FAB_PROJ_DIR")
    if fab_proj_dir:
        fab_project_dir = Path(fab_proj_dir) / ".FABulous" / ".env"

        # .FABulous/.env (higher priority)
        if fab_project_dir.exists():
            env_files.append(fab_project_dir)

    if project_dir and (project_dir / ".FABulous" / ".env").exists():
        env_files.append(project_dir / ".FABulous" / ".env")
    else:
        if project_dir is not None and (project_dir / ".FABulous" / ".env").exists():
            logger.warning(
                f"Project directory not found: {project_dir} this is ignored"
            )

    # 4. User-provided project .env file (highest .env priority)
    if project_dot_env and project_dot_env.exists():
        env_files.append(project_dot_env)
    else:
        if project_dot_env is None:
            logger.warning(
                f"Project .env file not found: {project_dot_env} this is ignored"
            )

    if project_dir:
        _context_instance = FABulousSettings(
            _env_file=tuple(env_files), root=fab_root, proj_dir=project_dir
        )
    else:
        _context_instance = FABulousSettings(_env_file=tuple(env_files), root=fab_root)

    logger.debug("FABulous context initialized")
    return _context_instance


def get_context() -> FABulousSettings:
    """Get the global FABulous context.

    Returns:
        The current FABulousSettings instance

    Raises:
        RuntimeError: If context has not been initialized with init_context()
    """
    global _context_instance

    if _context_instance is None:
        raise RuntimeError(
            "FABulous context not initialized. Call init_context() first."
        )

    return _context_instance


def reset_context() -> None:
    """Reset the global context (primarily for testing)."""
    global _context_instance
    _context_instance = None
    logger.debug("FABulous context reset")
