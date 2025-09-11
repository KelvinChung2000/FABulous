"""
FABulous GDS Generator - Pydantic Configuration Settings

This module implements modern Pydantic-based configuration following FABulous Settings pattern.
Provides robust validation, type checking, and environment variable support.
"""

from pathlib import Path
from typing import Any

from pydantic import BaseSettings, Field, root_validator, validator


class FABulousFlowSettings(BaseSettings):
    """Pydantic-based configuration settings for FABulous GDS generation flow.

    This follows the FABulous Settings pattern using Pydantic BaseSettings for automatic
    validation, type checking, and environment variable support.
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

        env_prefix = "FABULOUS_"  # Environment variables: FABULOUS_DESIGN_NAME, etc.
        case_sensitive = False
        allow_population_by_field_name = True
        validate_assignment = True
        arbitrary_types_allowed = True  # For fabulous_fabric_gen object

    @validator("fabric_csv_path")
    def validate_fabric_csv_path(cls, v):
        """Validate that fabric CSV file exists and is readable."""
        if not v.exists():
            raise ValueError(f"Fabric CSV file not found: {v}")
        if not v.is_file():
            raise ValueError(f"Fabric CSV path is not a file: {v}")
        try:
            with open(v) as f:
                content = f.read(100)  # Read first 100 chars to check readability
        except PermissionError:
            raise ValueError(f"Cannot read fabric CSV file (permission denied): {v}")
        except Exception as e:
            raise ValueError(f"Error accessing fabric CSV file {v}: {e}")
        return v

    @validator("openlane_root")
    def validate_openlane_root(cls, v):
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

    @validator("output_dir", "temp_dir")
    def validate_directory_paths(cls, v):
        """Validate and create output directories if they don't exist."""
        try:
            v.mkdir(parents=True, exist_ok=True)
        except PermissionError:
            raise ValueError(f"Cannot create directory (permission denied): {v}")
        except Exception as e:
            raise ValueError(f"Error creating directory {v}: {e}")
        return v

    @validator("user_design_files")
    def validate_user_design_files(cls, v):
        """Validate that user design files exist."""
        for file_path in v:
            if not file_path.exists():
                raise ValueError(f"User design file not found: {file_path}")
            if not file_path.is_file():
                raise ValueError(f"User design path is not a file: {file_path}")
        return v

    @validator("pdk_path")
    def validate_pdk_path(cls, v):
        """Validate PDK path if provided."""
        if v is not None:
            if not v.exists():
                raise ValueError(f"PDK path not found: {v}")
            if not v.is_dir():
                raise ValueError(f"PDK path is not a directory: {v}")
        return v

    @root_validator
    def validate_tool_dependencies(cls, values):
        """Validate that required tools are available (optional check)"""
        # Only validate tools that have absolute paths
        tool_paths = {
            "magic_path": values.get("magic_path"),
            "klayout_path": values.get("klayout_path"),
            "openroad_path": values.get("openroad_path"),
        }

        warnings = []
        for tool_name, tool_path in tool_paths.items():
            if tool_path and tool_path.is_absolute():
                # For absolute paths, check if file exists
                if not tool_path.exists():
                    warnings.append(f"{tool_name}: {tool_path}")

        # For now, just store warnings - could be logged later
        if warnings:
            values["_tool_warnings"] = warnings

        return values

    @root_validator
    def validate_parallel_settings(cls, values):
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
        """Convert Pydantic settings to LibreLane configuration dictionary.

        This bridges the Pydantic settings to the LibreLane Variable system.
        """
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
        """Create settings instance from dictionary with key mapping.

        Maps between different naming conventions (snake_case vs UPPER_CASE).
        """
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
