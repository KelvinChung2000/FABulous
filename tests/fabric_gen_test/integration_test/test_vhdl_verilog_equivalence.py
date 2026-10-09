"""Equivalence of the VHDL and Verilog fabric RTL generated from one fabric."""

from collections.abc import Callable
from pathlib import Path

import pytest

from fabulous.fabric_definition.define import HDLType
from fabulous.fabulous_repl.fabulous_repl import FABulousREPL
from fabulous.fabulous_settings import get_context, init_context, reset_context
from tests.conftest import run_cmd
from tests.fabric_gen_test.integration_test.conftest import set_multiplexer_style
from tests.reference_test.equivalence import check_vhdl_verilog_equivalence


def _generate(
    project_factory: Callable[..., Path], lang: HDLType, mux_style: str
) -> tuple[Path, Path]:
    """Generate the fabric RTL of a new `lang` project, returning it and its pack."""
    project_dir = project_factory(lang=lang, name=f"{lang.value}_project")
    set_multiplexer_style(project_dir, mux_style)
    reset_context()
    init_context(project_dir)
    cli = FABulousREPL(
        lang.value, force=False, interactive=False, verbose=False, debug=True
    )
    for command in (
        "load_fabric",
        "gen_io_fabric",
        "gen_fabric",
        "gen_bitStream_spec",
        "gen_top_wrapper",
    ):
        run_cmd(cli, command)
        assert cli.exit_code == 0, f"{command} failed for the {lang.value} project"
    models_pack = get_context().models_pack
    assert models_pack is not None, f"No models pack configured for {project_dir}"
    return project_dir, models_pack


@pytest.mark.parametrize("mux_style", ["custom", "generic"])
@pytest.mark.slow
def test_vhdl_matches_verilog(
    mux_style: str, project_factory: Callable[..., Path], tmp_path: Path
) -> None:
    """The VHDL fabric of the template project is equivalent to its Verilog one."""
    verilog_project, verilog_pack = _generate(
        project_factory, HDLType.VERILOG, mux_style
    )
    vhdl_project, vhdl_pack = _generate(project_factory, HDLType.VHDL, mux_style)

    failures = check_vhdl_verilog_equivalence(
        verilog_project=verilog_project,
        vhdl_project=vhdl_project,
        verilog_models_pack=verilog_pack,
        vhdl_models_pack=vhdl_pack,
        work_dir=tmp_path / "equivalence",
    )
    if failures:
        report = "\n".join(
            f"  {f.module}: {f.reason}" + (f": {f.detail}" if f.detail else "")
            for f in failures
        )
        pytest.fail(
            f"VHDL fabric is not equivalent to the Verilog fabric in "
            f"{len(failures)} places:\n{report}"
        )
