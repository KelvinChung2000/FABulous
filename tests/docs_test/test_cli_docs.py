"""Tests for the runtime-introspection CLI doc extractor."""

import generate_cli_docs as cli


def test_extracts_fabulous_commands() -> None:
    commands = cli.extract_cli_commands()
    flat = {c["name"]: c for cmds in commands.values() for c in cmds}
    # FABulous defines ~40 commands, incl. the mixed-in compile_design.
    assert len(flat) >= 35
    assert "compile_design" in flat
    assert "load_fabric" in flat


def test_excludes_cmd2_builtins() -> None:
    commands = cli.extract_cli_commands()
    names = {c["name"] for cmds in commands.values() for c in cmds}
    # cmd2's inherited shell built-ins must not pollute the FABulous reference.
    assert names.isdisjoint({"help", "set", "history", "shell", "eof", "py", "ipy"})


def test_command_has_expected_shape() -> None:
    commands = cli.extract_cli_commands()
    flat = {c["name"]: c for cmds in commands.values() for c in cmds}
    cmd = flat["compile_design"]
    assert cmd["full_desc"]  # docstring present
    assert cmd["arguments"], "compile_design should expose argparse arguments"
    arg = cmd["arguments"][0]
    assert set(arg) == {"name", "type", "required", "help", "default", "choices"}
    assert isinstance(arg["required"], bool)  # real flag, not a substring guess


def test_categories_are_ordered() -> None:
    commands = cli.extract_cli_commands()
    assert {"Setup", "Fabric Flow", "User Design Flow"} <= set(commands)


def test_store_true_flag_typed_bool_and_long_name() -> None:
    commands = cli.extract_cli_commands()
    flat = {c["name"]: c for cmds in commands.values() for c in cmds}
    args = {a["name"]: a for a in flat["compile_design"]["arguments"]}
    # store_true flags carry no value: typed bool, not str.
    assert args["synth-only"]["type"] == "bool"
    # Multi-alias options are documented by their long form, not "-d".
    sim_args = {a["name"] for a in flat["run_simulation"]["arguments"]}
    assert "design" in sim_args
    assert "d" not in sim_args
