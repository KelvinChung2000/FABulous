"""Integration tests for end-to-end GDS generation from minimal fabric."""

import os
import shutil
from pathlib import Path
from subprocess import CompletedProcess, run

import pytest

from FABulous.fabric_generator.gds_generator.flows.full_fabric_flow import (
    FABulousFabricMacroFullFlow,
)
from FABulous.FABulous_settings import init_context


def _get_command_prefix() -> list[str]:
    """Get command prefix for running FABulous commands via uv.

    In CI (with prepare_FABulous_container), tools are available and use uv run.
    Locally, tools are available via Nix environment and use nix develop -c uv run.

    Returns:
        Command prefix list to run FABulous commands.
    """
    # Check if we're in CI environment (GitHub Actions)
    if os.environ.get("CI") == "true" or os.environ.get("GITHUB_ACTIONS") == "true":
        return ["uv", "run"]

    # Check if FABulous is available in PATH (already in Nix env or installed)
    result = run(["which", "FABulous"], capture_output=True, text=True, timeout=5)

    if result.returncode == 0:
        # FABulous is available, use uv run
        return ["uv", "run"]

    # Need to run via nix develop with uv
    return ["nix", "develop", "-c", "uv", "run"]


@pytest.mark.superslow
def test_minimal_fabric_gds_generation(tmp_path: Path) -> None:
    """Test complete GDS generation flow with minimal LUT4AB+DSP fabric.

    This test runs the full physical design flow:
    1. Creates a FABulous project with minimal fabric configuration
    2. Generates fabric Verilog
    3. Runs FABulousFabricMacroFullFlow to compile all tiles to GDS
    4. Stitches tiles into complete fabric GDS
    5. Verifies GDS, LEF, and LIB outputs

    Expected runtime: 4-8+ hours depending on hardware and PDK.

    Note: This test requires:
    - FABulous and EDA tools (Yosys, OpenROAD, Magic, etc.) available via Nix
    - PDK configured in FABulous environment
    - In CI, the prepare_FABulous_container action sets up the environment
    """
    cmd_prefix = _get_command_prefix()

    # Create project with minimal fabric
    project_dir = tmp_path / "minimal_gds_test"
    result: CompletedProcess = run(
        cmd_prefix + ["FABulous", "-c", str(project_dir)],
        capture_output=True,
        text=True,
        timeout=300,
    )

    assert result.returncode == 0, (
        f"Project creation failed:\nSTDOUT: {result.stdout}\nSTDERR: {result.stderr}"
    )

    # Copy minimal fabric CSV to project
    test_fixtures_dir = Path(__file__).parent.parent / "fixtures"
    minimal_fabric_csv = test_fixtures_dir / "minimal_fabric.csv"
    target_fabric_csv = project_dir / "fabric.csv"

    assert minimal_fabric_csv.exists(), (
        f"Minimal fabric fixture not found: {minimal_fabric_csv}"
    )

    shutil.copy(minimal_fabric_csv, target_fabric_csv)

    # Generate fabric Verilog
    result = run(
        cmd_prefix + ["FABulous", str(project_dir), "-p", "run_FABulous_fabric"],
        capture_output=True,
        text=True,
        timeout=1800,  # 30 minute timeout for Verilog generation
    )

    assert result.returncode == 0, (
        f"Fabric generation failed:\nSTDOUT: {result.stdout}\nSTDERR: {result.stderr}"
    )

    # Verify fabric Verilog was generated
    fabric_verilog = project_dir / "Fabric" / "fabric.v"
    assert fabric_verilog.exists(), "Fabric Verilog not generated"

    # Verify all required tile directories exist
    tile_dir = project_dir / "Tile"
    required_tiles = [
        "LUT4AB",
        "N_term_single",
        "S_term_single",
        "W_IO",
        "DSP_top",
        "DSP_bot",
        "N_term_DSP",
        "S_term_DSP",
        "DSP",
    ]

    for tile_name in required_tiles:
        tile_path = tile_dir / tile_name
        assert tile_path.exists(), f"Tile directory missing: {tile_name}"

    # Verify DSP supertile structure
    dsp_supertile_csv = tile_dir / "DSP" / "DSP.csv"
    assert dsp_supertile_csv.exists(), "DSP supertile definition missing"

    # Initialize FABulous context to access fabric and PDK configuration
    context = init_context(project_dir)

    # Check if PDK is configured
    if not hasattr(context, "pdk") or not context.pdk:
        pytest.skip(
            "PDK not configured - GDS generation requires PDK setup\n"
            "To install PDK locally: nix develop, then use 'ciel' CLI to install PDK"
        )

    if not hasattr(context, "pdk_root") or not context.pdk_root:
        pytest.skip(
            "PDK root not configured - GDS generation requires PDK root path\n"
            "To install PDK locally: nix develop, then use 'ciel' CLI to install PDK"
        )

    # Verify PDK root exists
    if not context.pdk_root.exists():
        pytest.skip(
            f"PDK root does not exist: {context.pdk_root}\n"
            "To install PDK locally: nix develop, then use 'ciel' CLI to install PDK"
        )

    # Load fabric definition
    fabric = context.fabric

    # Run full fabric GDS generation flow
    # This compiles all tiles to GDS and stitches them into complete fabric
    try:
        flow = FABulousFabricMacroFullFlow(
            fabric=fabric,
            proj_dir=project_dir,
            pdk=context.pdk,
            pdk_root=context.pdk_root.parent,
        )

        # Start the flow - this will take several hours
        final_state = flow.start()

        # Verify the flow completed successfully
        assert final_state is not None, "GDS flow returned None state"

    except Exception as e:
        pytest.fail(f"GDS generation flow failed: {e}")

    # Verify GDS outputs exist
    # Check for fabric-level outputs
    fabric_gds = project_dir / "Fabric" / "fabric.gds"
    fabric_lef = project_dir / "Fabric" / "fabric.lef"

    assert fabric_gds.exists(), "Fabric GDS file not generated"
    assert fabric_lef.exists(), "Fabric LEF file not generated"

    # Verify tile GDS outputs exist
    for tile_name in ["LUT4AB", "DSP"]:  # Check key tiles
        tile_gds = tile_dir / tile_name / f"{tile_name}.gds"
        tile_lef = tile_dir / tile_name / f"{tile_name}.lef"

        assert tile_gds.exists(), f"Tile GDS not generated for {tile_name}"
        assert tile_lef.exists(), f"Tile LEF not generated for {tile_name}"

    # Verify GDS files have non-zero size
    assert fabric_gds.stat().st_size > 0, "Fabric GDS file is empty"
    assert fabric_lef.stat().st_size > 0, "Fabric LEF file is empty"
