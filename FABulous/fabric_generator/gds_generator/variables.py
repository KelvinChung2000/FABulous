"""
FABulous GDS Generator - LibreLane Configuration Variables

Centralized variable definitions for FABulous GDS generation custom steps.
"""

from librelane.common import Path
from librelane.config import Variable

# Core design variables
FABULOUS_VARIABLES = [
    Variable("DESIGN_NAME", str, description="Name of the FABulous design"),
    Variable(
        "FABRIC_CSV_PATH", Path, description="Path to the fabric CSV configuration file"
    ),
    Variable("OUTPUT_DIR", Path, description="Output directory for generated files"),
    Variable(
        "TEMP_DIR", Path, description="Temporary directory for intermediate files"
    ),
    Variable(
        "FABULOUS_FABRIC_GEN",
        object,
        description="FABulous fabric generator object (for reusing existing parsing)",
        default=None,
    ),
]

# OpenLane integration variables
OPENLANE_VARIABLES = [
    Variable(
        "OPENLANE_ROOT", Path, description="Path to OpenLane installation directory"
    ),
    Variable(
        "OPENLANE_NIX_SHELL",
        str,
        description="OpenLane nix shell command",
        default="nix-shell --run",
    ),
    Variable(
        "OPENLANE_RUN_TAG",
        str,
        description="OpenLane run tag for this execution",
        default="RUN_1",
    ),
]

# Fabric configuration variables
FABRIC_VARIABLES = [
    Variable(
        "FRAME_BITS_PER_ROW",
        int,
        description="Number of configuration bits per frame row",
    ),
    Variable(
        "MAX_FRAMES_PER_COL", int, description="Maximum number of frames per column"
    ),
    Variable(
        "TILE_WIDTH", float, description="Default tile width in micrometers", units="um"
    ),
    Variable(
        "TILE_HEIGHT",
        float,
        description="Default tile height in micrometers",
        units="um",
    ),
]

# Processing options
PROCESSING_VARIABLES = [
    Variable(
        "INTERRUPT_FLOW_ON_ERROR",
        bool,
        description="Whether to interrupt flow on sizing errors",
        default=True,
    ),
    Variable(
        "AUTO_RESIZE_TILES",
        bool,
        description="Automatically resize tiles when area is too small",
        default=False,
    ),
    Variable(
        "PARALLEL_TILE_PROCESSING",
        bool,
        description="Enable parallel processing of tiles",
        default=True,
    ),
    Variable(
        "MAX_PARALLEL_JOBS",
        int,
        description="Maximum number of parallel tile processing jobs",
        default=4,
    ),
]
