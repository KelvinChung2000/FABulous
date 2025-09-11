"""
FABulous GDS Generator - Pydantic-Based Flow Configuration

This module provides the primary configuration system using Pydantic BaseSettings,
following FABulous Settings patterns for robust validation and type checking.
"""

from pathlib import Path
from typing import Any

from pydantic import Field, field_validator
from pydantic_settings import BaseSettings


class FABulousFlowSettings(BaseSettings):
    """Primary configuration settings for FABulous GDS generation flow.

    Uses Pydantic BaseSettings for automatic validation, type checking, environment
    variable support, and robust error handling.
    """

    # Core design settings
    design_name: str = Field(
        default="fabulous_design",
        description="Name of the FABulous design",
        min_length=1,
        max_length=100,
        regex=r"^[a-zA-Z][a-zA-Z0-9_]*$",
    )

    fabric_csv_path: Path = Field(
        ...,  # Required field
        description="Path to the fabric CSV configuration file",
    )

    openlane_root: Path = Field(
        ...,  # Required field
        description="Path to OpenLane installation directory",
    )

    # Directory settings
    output_dir: Path = Field(
        default=Path("./output"), description="Output directory for generated files"
    )

    temp_dir: Path = Field(
        default=Path("./temp"), description="Temporary directory for intermediate files"
    )

    # Processing settings
    parallel_tile_processing: bool = Field(
        default=True, description="Enable parallel processing of tiles"
    )

    max_parallel_jobs: int = Field(
        default=4,
        description="Maximum number of parallel tile processing jobs",
        ge=1,
        le=32,
    )

    interrupt_flow_on_error: bool = Field(
        default=True, description="Whether to interrupt flow on sizing errors"
    )

    auto_resize_tiles: bool = Field(
        default=False, description="Automatically resize tiles when area is too small"
    )

    # Fabric configuration
    tile_width: float = Field(
        default=100.0,
        description="Default tile width in micrometers",
        gt=0.0,
        le=10000.0,
    )

    tile_height: float = Field(
        default=100.0,
        description="Default tile height in micrometers",
        gt=0.0,
        le=10000.0,
    )

    frame_bits_per_row: int = Field(
        default=32,
        description="Number of configuration bits per frame row",
        ge=1,
        le=1024,
    )

    max_frames_per_col: int = Field(
        default=20, description="Maximum number of frames per column", ge=1, le=256
    )

    # OpenLane settings
    openlane_nix_shell: str = Field(
        default="nix-shell --run", description="OpenLane nix shell command"
    )

    openlane_run_tag: str = Field(
        default="RUN_1",
        description="OpenLane run tag for this execution",
        regex=r"^[a-zA-Z0-9_]+$",
    )

    # Tool paths
    magic_path: Path = Field(
        default=Path("magic"), description="Path to Magic VLSI tool executable"
    )

    klayout_path: Path = Field(
        default=Path("klayout"), description="Path to KLayout executable"
    )

    openroad_path: Path = Field(
        default=Path("openroad"), description="Path to OpenROAD executable"
    )

    # PDK settings
    pdk_path: Path | None = Field(default=None, description="Path to PDK installation")

    pdk_name: str = Field(
        default="sky130A", description="PDK name (e.g., sky130A, gf180mcuC)"
    )

    # Optional FABulous integration
    fabulous_fabric_gen: object | None = Field(
        default=None,
        description="FABulous fabric generator object (for reusing existing parsing)",
    )

    # Optional user design files
    user_design_files: list[Path] = Field(
        default_factory=list, description="Additional user design files"
    )

    class Config:
        """Pydantic configuration."""

        env_prefix = "FABULOUS_"
        case_sensitive = False
        allow_population_by_field_name = True
        validate_assignment = True
        arbitrary_types_allowed = True

    @field_validator("fabric_csv_path")
    def validate_fabric_csv_path(cls, v: Path) -> Path:
        """Validate that fabric CSV file exists and is readable."""
        if not v.exists():
            raise ValueError(f"Fabric CSV file not found: {v}")
        if not v.is_file():
            raise ValueError(f"Fabric CSV path is not a file: {v}")
        try:
            with v.open() as f:
                f.read(100)  # Read first 100 chars to check readability
        except PermissionError:
            raise ValueError(f"Cannot read fabric CSV file (permission denied): {v}")
        except Exception as e:
            raise ValueError(f"Error accessing fabric CSV file {v}: {e}") from e
        return v

    @field_validator("openlane_root")
    def validate_openlane_root(cls, v: Path) -> Path:
        """Validate OpenLane installation path."""
        if not v.exists():
            raise ValueError(f"OpenLane root directory not found: {v}")
        if not v.is_dir():
            raise ValueError(f"OpenLane root path is not a directory: {v}")

        # Check for key OpenLane files/directories
        expected_paths = ["scripts", "designs"]
        missing_paths = [p for p in expected_paths if not (v / p).exists()]
        if missing_paths:
            raise ValueError(
                f"OpenLane installation appears incomplete. Missing: {missing_paths}. "
                f"Please verify OpenLane installation at {v}"
            )
        return v

    @field_validator("output_dir", "temp_dir")
    def validate_directory_paths(cls, v: Path) -> Path:
        """Validate and create output directories if they don't exist."""
        try:
            v.mkdir(parents=True, exist_ok=True)
        except PermissionError:
            raise ValueError(
                f"Cannot create directory (permission denied): {v}"
            ) from None
        except Exception as e:
            raise ValueError(f"Error creating directory {v}: {e}") from e
        return v

    @field_validator("user_design_files")
    def validate_user_design_files(cls, v: list[Path]) -> list[Path]:
        """Validate that user design files exist."""
        for file_path in v:
            if not file_path.exists():
                raise ValueError(f"User design file not found: {file_path}")
            if not file_path.is_file():
                raise ValueError(f"User design path is not a file: {file_path}")
        return v

    @field_validator("pdk_path")
    def validate_pdk_path(cls, v: Path | None) -> Path | None:
        """Validate PDK path if provided."""
        if v is not None:
            if not v.exists():
                raise ValueError(f"PDK path not found: {v}")
            if not v.is_dir():
                raise ValueError(f"PDK path is not a directory: {v}")
        return v

    @field_validator("max_parallel_jobs", mode="before")
    def validate_parallel_settings(cls, values: dict[str, Any]) -> dict[str, Any]:
        """Validate parallel processing settings."""
        parallel_processing = values.get("parallel_tile_processing")
        max_jobs = values.get("max_parallel_jobs")

        if parallel_processing and max_jobs:
            # Adjust max jobs based on system capabilities
            import os

            cpu_count = os.cpu_count() or 4
            if max_jobs > cpu_count * 2:
                values["max_parallel_jobs"] = cpu_count * 2

        return values

    def to_librelane_config(self) -> dict[str, Any]:
        """Convert Pydantic settings to LibreLane configuration dictionary."""
        return {
            "DESIGN_NAME": self.design_name,
            "FABRIC_CSV_PATH": self.fabric_csv_path,
            "OPENLANE_ROOT": self.openlane_root,
            "OUTPUT_DIR": self.output_dir,
            "TEMP_DIR": self.temp_dir,
            "PARALLEL_TILE_PROCESSING": self.parallel_tile_processing,
            "MAX_PARALLEL_JOBS": self.max_parallel_jobs,
            "INTERRUPT_FLOW_ON_ERROR": self.interrupt_flow_on_error,
            "AUTO_RESIZE_TILES": self.auto_resize_tiles,
            "TILE_WIDTH": self.tile_width,
            "TILE_HEIGHT": self.tile_height,
            "FRAME_BITS_PER_ROW": self.frame_bits_per_row,
            "MAX_FRAMES_PER_COL": self.max_frames_per_col,
            "OPENLANE_NIX_SHELL": self.openlane_nix_shell,
            "OPENLANE_RUN_TAG": self.openlane_run_tag,
            "MAGIC_PATH": self.magic_path,
            "KLAYOUT_PATH": self.klayout_path,
            "OPENROAD_PATH": self.openroad_path,
            "PDK_PATH": self.pdk_path,
            "PDK_NAME": self.pdk_name,
            "FABULOUS_FABRIC_GEN": self.fabulous_fabric_gen,
            "USER_DESIGN_FILES": self.user_design_files,
        }

    @classmethod
    def from_dict(cls, config_dict: dict[str, Any]) -> "FABulousFlowSettings":
        """Create settings instance from dictionary with key mapping."""
        # Map keys from UPPER_CASE to snake_case
        key_mapping = {
            "DESIGN_NAME": "design_name",
            "FABRIC_CSV_PATH": "fabric_csv_path",
            "OPENLANE_ROOT": "openlane_root",
            "OUTPUT_DIR": "output_dir",
            "TEMP_DIR": "temp_dir",
            "PARALLEL_TILE_PROCESSING": "parallel_tile_processing",
            "MAX_PARALLEL_JOBS": "max_parallel_jobs",
            "INTERRUPT_FLOW_ON_ERROR": "interrupt_flow_on_error",
            "AUTO_RESIZE_TILES": "auto_resize_tiles",
            "TILE_WIDTH": "tile_width",
            "TILE_HEIGHT": "tile_height",
            "FRAME_BITS_PER_ROW": "frame_bits_per_row",
            "MAX_FRAMES_PER_COL": "max_frames_per_col",
            "OPENLANE_NIX_SHELL": "openlane_nix_shell",
            "OPENLANE_RUN_TAG": "openlane_run_tag",
            "MAGIC_PATH": "magic_path",
            "KLAYOUT_PATH": "klayout_path",
            "OPENROAD_PATH": "openroad_path",
            "PDK_PATH": "pdk_path",
            "PDK_NAME": "pdk_name",
            "FABULOUS_FABRIC_GEN": "fabulous_fabric_gen",
            "USER_DESIGN_FILES": "user_design_files",
        }

        mapped_config = {}
        for key, value in config_dict.items():
            mapped_key = key_mapping.get(key, key.lower())
            mapped_config[mapped_key] = value

        return cls(**mapped_config)

    @classmethod
    def create_example(cls) -> "FABulousFlowSettings":
        """Create an example configuration for testing and documentation."""
        return cls(
            design_name="example_fabric",
            fabric_csv_path=Path("./examples/fabric.csv"),
            openlane_root=Path("/opt/OpenLane"),
            output_dir=Path("./output/example_fabric"),
            temp_dir=Path("./temp/example_fabric"),
            parallel_tile_processing=True,
            max_parallel_jobs=4,
            interrupt_flow_on_error=True,
            auto_resize_tiles=False,
            tile_width=120.0,
            tile_height=120.0,
            frame_bits_per_row=32,
            max_frames_per_col=20,
            user_design_files=[Path("./examples/user_module.v")],
        )


# Backward compatibility aliases and legacy interface
FABulousFlowConfig = FABulousFlowSettings


def create_default_config() -> dict[str, Any]:
    """Create a default configuration dictionary (legacy interface)."""
    settings = FABulousFlowSettings.create_example()
    return settings.to_librelane_config()


def validate_config(config: dict[str, Any]) -> dict[str, str]:
    """Validate a configuration dictionary (legacy interface)."""
    try:
        FABulousFlowSettings.from_dict(config)
        return {}  # No errors if validation passes
    except Exception as e:
        return {"validation_error": str(e)}


def create_example_config() -> dict[str, Any]:
    """Create an example configuration for testing and documentation (legacy
    interface).
    """
    settings = FABulousFlowSettings.create_example()
    return settings.to_librelane_config()


# Additional utility methods for the FABulousFlowSettings class
def merge_configs(
    base_config: dict[str, Any], override_config: dict[str, Any]
) -> dict[str, Any]:
    """Merge configuration dictionaries with override precedence.

    Args:
        base_config: Base configuration dictionary
        override_config: Override configuration dictionary

    Returns
    -------
        Merged configuration dictionary
    """
    merged = base_config.copy()
    merged.update(override_config)
    return merged


def create_config_template(output_file: Path) -> None:
    """Create a configuration template file.

    Args:
        output_file: Path to write the configuration template
    """
    template_content = """# FABulous GDS Generation Flow Configuration Template
#
# This file contains all configurable parameters for the FABulous GDS generation flow.
# Copy this file and modify the values as needed for your design.

# === Required Configuration ===

# Design name (used for output file naming)
DESIGN_NAME = "my_fabulous_design"

# Path to the fabric CSV configuration file
FABRIC_CSV_PATH = "/path/to/fabric.csv"

# Path to OpenLane installation directory
OPENLANE_ROOT = "/path/to/OpenLane"

# === Output Configuration ===

# Output directory for generated files
OUTPUT_DIR = "./output"

# Temporary directory for intermediate files
TEMP_DIR = "./temp"

# === Processing Options ===

# Enable parallel tile processing
PARALLEL_TILE_PROCESSING = True

# Maximum number of parallel tile processing jobs
MAX_PARALLEL_JOBS = 4

# Whether to interrupt flow on sizing errors
INTERRUPT_FLOW_ON_ERROR = True

# Automatically resize tiles when area is too small
AUTO_RESIZE_TILES = False

# === Fabric Configuration ===

# Default tile dimensions in micrometers
TILE_WIDTH = 100.0
TILE_HEIGHT = 100.0

# Frame configuration (extracted from fabric CSV)
FRAME_BITS_PER_ROW = 32
MAX_FRAMES_PER_COL = 20

# === Tool Configuration ===

# OpenLane nix shell command
OPENLANE_NIX_SHELL = "nix-shell --run"

# OpenLane run tag for this execution
OPENLANE_RUN_TAG = "RUN_1"

# Tool executable paths (use full paths if not in PATH)
MAGIC_PATH = "magic"
KLAYOUT_PATH = "klayout"
OPENROAD_PATH = "openroad"

# === Advanced Options ===

# User design files (optional)
USER_DESIGN_FILES = []

# Additional processing options
# (Add more options here as needed)
"""

    with output_file.open("w") as f:
        f.write(template_content)


def load_config_from_file(config_file: Path) -> dict[str, Any]:
    """Load configuration from a Python file.

    Args:
        config_file: Path to the configuration file

    Returns
    -------
        Configuration dictionary loaded from file
    """
    import importlib.util

    spec = importlib.util.spec_from_file_location("config", config_file)
    if spec is None:
        raise ValueError(f"Cannot create module spec for {config_file}")

    config_module = importlib.util.module_from_spec(spec)
    if spec.loader is None:
        raise ValueError(f"No loader available for {config_file}")

    spec.loader.exec_module(config_module)

    # Extract configuration variables (uppercase names only)
    config = {}
    for name in dir(config_module):
        if name.isupper() and not name.startswith("_"):
            config[name] = getattr(config_module, name)

    return config
