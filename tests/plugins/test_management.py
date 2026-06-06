"""Management operations: list, info, and uv-backed install."""

import sys
import types
from pathlib import Path

import pytest
from pytest_mock import MockerFixture

from fabulous.plugins import PLUGIN_API_VERSION, hookimpl, management
from fabulous.plugins import manager as manager_module
from fabulous.plugins.manager import BuiltinPlugin, FABulousPluginManager
from fabulous.plugins.types import ParserProvider, PluginError


def _entry_point_module() -> types.SimpleNamespace:
    """An entry-point stub that loads a one-parser plugin module named 'ep_plugin'."""
    ep_module = types.ModuleType("ep_plugin")

    @hookimpl
    def fabulous_register_parsers() -> list[ParserProvider]:
        return [ParserProvider(".ep", lambda path: path, "ep")]

    ep_module.fabulous_register_parsers = fabulous_register_parsers
    ep_module.FABULOUS_PLUGIN_API = PLUGIN_API_VERSION
    return types.SimpleNamespace(name="ep_plugin", load=lambda: ep_module)


def _patch_management_context(mocker: MockerFixture, tmp_path: Path) -> None:
    """Point the manager's context at an empty (absent) plugin dir."""
    ctx = mocker.patch.object(manager_module, "get_context").return_value
    ctx.plugins.dir = tmp_path / "plugins"  # absent -> dir scan is a no-op
    ctx.proj_dir = tmp_path


def test_format_plugin_list_includes_builtins(mocker: MockerFixture) -> None:
    mocker.patch.object(manager_module, "get_context")
    manager = FABulousPluginManager.core_only()
    text = management.format_plugin_list(manager)
    for plugin in BuiltinPlugin:
        assert plugin.value in text


def test_for_management_lists_entry_point_plugins(
    tmp_path: Path, mocker: MockerFixture
) -> None:
    _patch_management_context(mocker, tmp_path)
    mocker.patch.object(
        manager_module.importlib_metadata,
        "entry_points",
        return_value=[_entry_point_module()],
    )

    manager = FABulousPluginManager.for_management()
    listing = management.format_plugin_list(manager)

    assert "ep_plugin" in listing  # the installed plugin is now visible
    for plugin in BuiltinPlugin:
        assert plugin.value in listing  # built-ins still listed
    assert "ep_plugin" in management.format_plugin_info(manager, "ep_plugin")


def test_install_invokes_uv(mocker: MockerFixture) -> None:
    mocker.patch.object(
        FABulousPluginManager, "_uv_executable", return_value="/usr/bin/uv"
    )
    run = mocker.patch.object(manager_module.subprocess, "run")
    FABulousPluginManager.install("some-package")
    args = run.call_args.args[0]
    assert args[0] == "/usr/bin/uv"
    assert args[1:4] == ["pip", "install", "--python"]
    assert args[-1] == "some-package"


def test_uninstall_invokes_uv(mocker: MockerFixture) -> None:
    mocker.patch.object(
        FABulousPluginManager, "_uv_executable", return_value="/usr/bin/uv"
    )
    run = mocker.patch.object(manager_module.subprocess, "run")
    FABulousPluginManager.uninstall("some-package")
    args = run.call_args.args[0]
    assert args[0] == "/usr/bin/uv"
    # uninstall must pin the same interpreter as install, else it targets the
    # wrong environment (e.g. VIRTUAL_ENV) and removes nothing.
    assert args[1:4] == ["pip", "uninstall", "--python"]
    assert args[4] == sys.executable
    assert args[-1] == "some-package"


def test_install_provisions_uv_when_missing(mocker: MockerFixture) -> None:
    mocker.patch.object(manager_module.shutil, "which", return_value=None)
    mocker.patch("importlib.util.find_spec", return_value=None)
    run = mocker.patch.object(manager_module.subprocess, "run")
    mocker.patch.object(
        FABulousPluginManager, "_uv_bin_from_package", return_value="/opt/uv"
    )
    FABulousPluginManager.install("some-pkg")
    calls = run.call_args_list
    assert calls[0].args[0][:5] == [sys.executable, "-m", "pip", "install", "uv"]
    assert calls[-1].args[0][0] == "/opt/uv"
    assert calls[-1].args[0][-1] == "some-pkg"


def test_provision_errors_when_pip_unavailable(mocker: MockerFixture) -> None:
    mocker.patch.object(manager_module.shutil, "which", return_value=None)
    mocker.patch("importlib.util.find_spec", return_value=None)
    mocker.patch.object(
        manager_module.subprocess,
        "run",
        side_effect=manager_module.subprocess.CalledProcessError(1, "pip"),
    )
    with pytest.raises(PluginError):
        FABulousPluginManager.install("some-pkg")


def test_install_reports_registered_plugin(mocker: MockerFixture) -> None:
    mocker.patch.object(
        FABulousPluginManager, "_uv_executable", return_value="/usr/bin/uv"
    )
    mocker.patch.object(manager_module.subprocess, "run")
    # uv adds a new entry point between the before/after snapshots.
    mocker.patch.object(
        FABulousPluginManager,
        "_plugin_entry_point_names",
        side_effect=[set(), {"newplug"}],
    )
    assert FABulousPluginManager.install("some-pkg") == ["newplug"]


def test_format_install_result_reports_added() -> None:
    assert "demo" in management.format_install_result(["demo"])


def test_format_install_result_warns_when_empty() -> None:
    assert "no 'fabulous.plugins'" in management.format_install_result([])


def test_notify_fabric_loaded_invokes_hook() -> None:
    manager = FABulousPluginManager.core_only()
    received = []
    module = types.ModuleType("after_load_plugin")

    @hookimpl
    def fabulous_after_fabric_loaded(api: object) -> None:
        received.append(api)

    module.fabulous_after_fabric_loaded = fabulous_after_fabric_loaded
    manager.pm.register(module, name="after_load")

    sentinel = object()
    manager.notify_fabric_loaded(sentinel)

    assert received == [sentinel]
