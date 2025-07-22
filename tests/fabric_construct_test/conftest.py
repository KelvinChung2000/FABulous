import shutil
from pathlib import Path

import pytest
from cocotb.runner import get_runner

VERILOG_SOURCE_PATH = (
    Path(__file__).parent.parent.parent / "FABulous" / "fabric_files" / "FABulous_project_template_verilog"
)


@pytest.fixture
def cocotb_runner(tmp_path: Path):
    """Factory fixture to create cocotb runners for RTL simulation."""

    def _create_runner(sources: list[Path], hdl_top_level, test_module_path):
        lang = set([i.suffix for i in sources])

        if len(lang) > 1:
            raise ValueError("All source files must have the same HDL language suffix")

        hdl_toplevel_lang = lang.pop()  # Get the single language suffix
        if hdl_toplevel_lang not in {".v", ".vhd"}:
            raise ValueError(f"Unsupported HDL language: {hdl_toplevel_lang}")

        if hdl_toplevel_lang == ".v":
            sim = "icarus"
        elif hdl_toplevel_lang == ".vhd":
            sim = "ghdl"
        runner = get_runner(sim)

        sources.insert(0, Path(__file__).parent / "testdata" / f"models{hdl_toplevel_lang}")
        # Copy test module and models to temp directory for cocotb
        test_dir = tmp_path / "tests"
        test_dir.mkdir(exist_ok=True)

        # Copy this test file to the test directory so cocotb can find it
        shutil.copy(test_module_path, test_dir / test_module_path.name)

        # Build directory
        build_dir = tmp_path / "cocotb_build"

        # Configure sources based on HDL language
        if hdl_toplevel_lang == ".v":
            runner.build(verilog_sources=sources, hdl_toplevel=hdl_top_level, always=True, build_dir=build_dir)
        elif hdl_toplevel_lang == ".vhd":
            # GHDL converts identifiers to lowercase for elaboration and execution
            hdl_top_level = hdl_top_level.lower()
            runner.build(vhdl_sources=sources, hdl_toplevel=hdl_top_level, always=True, build_dir=build_dir)

            # Copy all files from build_dir to test_dir
            for file in build_dir.iterdir():
                if file.is_file():
                    shutil.copy(file, test_dir / file.name)

        runner.test(
            hdl_toplevel=hdl_top_level,
            test_module=test_module_path.stem,
            build_dir=build_dir,
            test_dir=test_dir,
        )

    return _create_runner
