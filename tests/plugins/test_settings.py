"""Plugin settings: framework config, env parsing, and typed plugin settings."""

import types
from pathlib import Path

import pytest
from pydantic_settings import SettingsConfigDict

from fabulous.fabulous_settings import (
    PluginSettings,
    PluginSystemSettings,
    add_var_to_project_env,
    get_context,
    init_context,
)
from fabulous.plugins import hookspecs
from fabulous.plugins.manager import FABulousPluginManager
from fabulous.plugins.types import PluginError


def test_plugin_system_settings_defaults() -> None:
    settings = PluginSystemSettings()
    assert settings.skip_broken is False
    assert settings.dir == Path("plugins")


def test_plugin_system_settings_nested_env(
    project: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setenv("FAB_PLUGINS__SKIP_BROKEN", "true")
    init_context(project)
    plugins = get_context().plugins
    assert plugins.skip_broken is True


def test_add_var_to_project_env_writes_key(project: Path) -> None:
    init_context(project)
    add_var_to_project_env("FAB_PLUGINS__SKIP_BROKEN", "true")
    env_file = project / ".FABulous" / ".env"
    assert env_file.exists()
    assert "FAB_PLUGINS__SKIP_BROKEN" in env_file.read_text()


class _DemoSettings(PluginSettings):
    group = "demo"
    model_config = SettingsConfigDict(env_prefix="FAB_DEMO__")
    jobs: int = 1


def test_plugin_settings_from_context_reads_singleton(
    project: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setenv("FAB_DEMO__JOBS", "7")
    init_context(project)

    module = types.ModuleType("demo_settings_plugin")

    @hookspecs.hookimpl
    def fabulous_register_settings() -> type[PluginSettings]:
        return _DemoSettings

    module.fabulous_register_settings = fabulous_register_settings

    manager = FABulousPluginManager()
    manager.pm.register(module, name="demo_settings")
    manager.build_registries()

    assert get_context().plugin_settings["demo"].jobs == 7
    assert _DemoSettings.from_context().jobs == 7


def test_plugin_settings_from_context_unregistered_raises(project: Path) -> None:
    init_context(project)

    class _Missing(PluginSettings):
        group = "missing"

    with pytest.raises(PluginError):
        _Missing.from_context()


def test_build_registries_replaces_prior_plugin_settings(project: Path) -> None:
    init_context(project)

    first = types.ModuleType("first_settings_plugin")

    @hookspecs.hookimpl
    def fabulous_register_settings() -> type[PluginSettings]:
        return _DemoSettings

    first.fabulous_register_settings = fabulous_register_settings
    mgr_a = FABulousPluginManager()
    mgr_a.pm.register(first, name="first")
    mgr_a.build_registries()
    assert "demo" in get_context().plugin_settings

    # A second manager that contributes no settings becomes the authority and
    # clears the prior manager's published settings, so none can leak through.
    FABulousPluginManager().build_registries()
    assert "demo" not in get_context().plugin_settings
