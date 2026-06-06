"""The FABulous plugin manager: discovery authority, registries, and operations.

The manager is the single authority over plugins. It discovers and registers
them, folds their contributions into typed registries, builds writers and
parsers through factory methods, and owns the plugin-management operations
(list/info/install/uninstall). Plugin management is therefore *not*
itself a plugin.
"""

import importlib
import importlib.metadata as importlib_metadata
import importlib.util
import shutil
import subprocess
import sys
from collections.abc import Callable
from enum import StrEnum
from functools import partial
from pathlib import Path
from typing import TYPE_CHECKING, Self

import pluggy
from loguru import logger

from fabulous.fabric_definition.define import HDLType
from fabulous.fabric_definition.fabric import Fabric
from fabulous.fabric_generator.code_generator.code_generator import CodeGenerator
from fabulous.fabulous_settings import (
    PluginSettings,
    get_context,
)
from fabulous.plugins import hookspecs
from fabulous.plugins.hookspecs import PLUGIN_API_VERSION
from fabulous.plugins.types import (
    CodeGeneratorProvider,
    ParserProvider,
    PluginError,
    PluginStatus,
)

if TYPE_CHECKING:
    from fabulous.fabulous_api import FABulous_API


class BuiltinPlugin(StrEnum):
    """Dotted module paths of the essential built-in provider plugins.

    Each value is a real importable module exposing ``@hookimpl`` functions.
    Built-ins are always registered.
    """

    CODE_GENERATORS = "fabulous.fabric_generator.code_generator.plugin"
    PARSERS = "fabulous.fabric_generator.parser.plugin"


ESSENTIAL_PLUGINS = frozenset(BuiltinPlugin)


class FABulousPluginManager:
    """Owns plugin discovery, lifecycle, the provider registries, and operations."""

    def __init__(self) -> None:
        self.pm = pluggy.PluginManager("fabulous")
        self.pm.add_hookspecs(hookspecs)
        self._code_generators: dict[HDLType, CodeGeneratorProvider] = {}
        self._parsers: dict[str, ParserProvider] = {}

    # -- Registry construction ------------------------------------------------

    def build_registries(self) -> None:
        """Fold the aggregating hooks into keyed registries and settings.

        Raises
        ------
        PluginError
            If two providers claim the same HDL type or file suffix, or if two
            plugins register settings under the same group.
        """
        self._code_generators.clear()
        for providers in self.pm.hook.fabulous_register_code_generators():
            for provider in providers:
                existing = self._code_generators.get(provider.hdl_type)
                if existing is not None:
                    raise PluginError(
                        f"HDLType {provider.hdl_type.name} registered by both "
                        f"'{existing.name}' and '{provider.name}'"
                    )
                self._code_generators[provider.hdl_type] = provider

        self._parsers.clear()
        for providers in self.pm.hook.fabulous_register_parsers():
            for provider in providers:
                existing = self._parsers.get(provider.suffix)
                if existing is not None:
                    raise PluginError(
                        f"Parser suffix '{provider.suffix}' registered by both "
                        f"'{existing.name}' and '{provider.name}'"
                    )
                self._parsers[provider.suffix] = provider

        self._build_settings()

    def _build_settings(self) -> None:
        """Instantiate plugin settings models and publish them on the singleton.

        Each model self-loads its own environment prefix. The instances live on
        ``get_context().plugin_settings`` so ``PluginSettings.from_context``
        returns them anywhere with full typing.

        Building the registries makes this manager the authority over
        plugin-contributed settings, so the store is replaced wholesale: stale
        settings from a previous build (or another manager built earlier in the
        same process) never leak through.

        Raises
        ------
        PluginError
            If two plugins register settings under the same group.
        """
        new_settings: dict[str, PluginSettings] = {}
        for model in self.pm.hook.fabulous_register_settings():
            if model is None:
                continue
            if model.group in new_settings:
                raise PluginError(
                    f"Settings group '{model.group}' registered more than once"
                )
            new_settings[model.group] = model()

        store = get_context().plugin_settings
        store.clear()
        store.update(new_settings)

    # -- Factory methods (the only resolution surface consumers touch) --------

    def make_writer(self, hdl_type: HDLType) -> CodeGenerator:
        """Build a fresh code generator for ``hdl_type``.

        This is the single resolution point for writers: it selects the
        registered provider and constructs the generator. A provider needing
        configuration reads it from its own ``PluginSettings.from_context()``,
        so callers never thread options through here.

        Parameters
        ----------
        hdl_type : HDLType
            The HDL language to build a generator for.

        Returns
        -------
        CodeGenerator
            A fresh generator instance.

        Raises
        ------
        PluginError
            If no provider is registered for ``hdl_type``.
        """
        provider = self._code_generators.get(hdl_type)
        if provider is None:
            available = ", ".join(sorted(h.value for h in self._code_generators))
            raise PluginError(
                f"No code generator registered for '{hdl_type.value}'. "
                f"Available: {available or '(none)'}"
            )
        return provider.factory()

    def make_parser(self, path: Path) -> Callable[[Path], Fabric]:
        """Return the parse callable that handles ``path`` by its suffix.

        Parameters
        ----------
        path : Path
            The fabric file whose suffix selects the parser.

        Returns
        -------
        Callable[[Path], Fabric]
            The parse callable from the registered provider.

        Raises
        ------
        PluginError
            If no parser is registered for the file's suffix.
        """
        provider = self._parsers.get(path.suffix)
        if provider is None:
            available = ", ".join(sorted(self._parsers))
            raise PluginError(
                f"No parser registered for suffix '{path.suffix}'. "
                f"Available: {available or '(none)'}"
            )
        return provider.parse

    # -- Lifecycle ------------------------------------------------------------

    def notify_fabric_loaded(self, api: "FABulous_API") -> None:
        """Fire the post-load lifecycle hook for a freshly loaded fabric.

        Centralising the firing here keeps the manager the sole authority over
        hook dispatch, so callers never reach into the pluggy hook relay. Unlike
        ``fabulous_startup`` (fired once per full session built by
        :meth:`create`), this fires on every fabric load.

        Parameters
        ----------
        api : FABulous_API
            The API whose fabric was just loaded.
        """
        self.pm.hook.fabulous_after_fabric_loaded(api=api)

    # -- Plugin management (owned by the manager, not a plugin) ---------------

    def tier_of(self, name: str) -> str:
        """Return the tier label for ``name``.

        Parameters
        ----------
        name : str
            The plugin name.

        Returns
        -------
        str
            ``"core"`` for an essential built-in, otherwise ``"plugin"``.
        """
        return "core" if name in ESSENTIAL_PLUGINS else "plugin"

    def is_registered(self, name: str) -> bool:
        """Return whether a plugin named ``name`` is registered.

        Parameters
        ----------
        name : str
            The plugin name.

        Returns
        -------
        bool
            ``True`` if the plugin is registered.
        """
        return self.pm.get_plugin(name) is not None

    def status(self) -> list[PluginStatus]:
        """Return the discovery state of every registered plugin, sorted by name.

        Returns
        -------
        list[PluginStatus]
            One entry per registered plugin.
        """
        return [
            PluginStatus(name, self.tier_of(name))
            for name, _ in sorted(self.pm.list_name_plugin(), key=lambda kv: kv[0])
        ]

    def settings_summary(self, name: str) -> str | None:
        """Return a one-line summary of a plugin's settings, or ``None``.

        Parameters
        ----------
        name : str
            The plugin name.

        Returns
        -------
        str | None
            ``"<group> (env prefix <prefix>)"`` if the plugin registers
            settings, otherwise ``None``.
        """
        plugin = self.pm.get_plugin(name)
        register = getattr(plugin, "fabulous_register_settings", None)
        if register is None:
            return None
        model = register()
        if model is None:
            return None
        prefix = model.model_config.get("env_prefix", "")
        return f"{model.group} (env prefix {prefix})"

    @staticmethod
    def _uv_bin_from_package() -> str:
        """Return the uv binary bundled with the installed ``uv`` package.

        Returns
        -------
        str
            Path to the bundled uv executable.
        """
        from uv import find_uv_bin

        return find_uv_bin()

    @staticmethod
    def _uv_executable() -> str:
        """Return a uv executable, provisioning the ``uv`` package if absent.

        Resolution order: a system ``uv`` on ``PATH``, then the binary bundled
        with the optional ``uv`` package. If neither is present the ``uv``
        package is installed into the running interpreter, so plugin management
        always goes through uv.

        Returns
        -------
        str
            Path to the uv executable.

        Raises
        ------
        PluginError
            If uv is absent and the ``uv`` package cannot be installed.
        """
        system = shutil.which("uv")
        if system is not None:
            return system
        if importlib.util.find_spec("uv") is None:
            logger.info("uv not found; installing the 'uv' package to manage plugins.")
            try:
                subprocess.run(
                    [sys.executable, "-m", "pip", "install", "uv"], check=True
                )
            except (OSError, subprocess.CalledProcessError) as exc:
                raise PluginError(
                    "uv is required to manage plugins but is not installed and "
                    "could not be installed automatically. Install it with "
                    "'pip install uv', or reinstall FABulous with the 'plugins' "
                    "extra."
                ) from exc
            importlib.invalidate_caches()
        return FABulousPluginManager._uv_bin_from_package()

    @staticmethod
    def _plugin_entry_point_names() -> set[str]:
        """Return the names of the installed ``fabulous.plugins`` entry points.

        Returns
        -------
        set[str]
            Entry-point names currently registered in the ``fabulous.plugins``
            group for the running interpreter.
        """
        return {
            ep.name for ep in importlib_metadata.entry_points(group="fabulous.plugins")
        }

    @staticmethod
    def install(spec: str) -> list[str]:
        """Install a plugin package into the running environment via uv.

        Parameters
        ----------
        spec : str
            A uv/pip install specifier (package name, git URL, or local path).

        Returns
        -------
        list[str]
            The ``fabulous.plugins`` entry points the package added, sorted. An
            empty list means the package contributes no FABulous plugin and the
            caller should warn the user.
        """
        before = FABulousPluginManager._plugin_entry_point_names()
        uv = FABulousPluginManager._uv_executable()
        subprocess.run(
            [uv, "pip", "install", "--python", sys.executable, spec], check=True
        )
        importlib.invalidate_caches()
        after = FABulousPluginManager._plugin_entry_point_names()
        return sorted(after - before)

    @staticmethod
    def uninstall(name: str) -> list[str]:
        """Uninstall a plugin package via uv.

        Parameters
        ----------
        name : str
            The package name to uninstall.

        Returns
        -------
        list[str]
            The ``fabulous.plugins`` entry points the package removed, sorted.
        """
        before = FABulousPluginManager._plugin_entry_point_names()
        uv = FABulousPluginManager._uv_executable()
        subprocess.run(
            [uv, "pip", "uninstall", "--python", sys.executable, name], check=True
        )
        importlib.invalidate_caches()
        after = FABulousPluginManager._plugin_entry_point_names()
        return sorted(before - after)

    # -- Discovery tiers ------------------------------------------------------

    def _handle_broken(self, name: str, exc: Exception, skip_broken: bool) -> None:
        """Apply the broken-plugin policy to a failed optional plugin.

        Parameters
        ----------
        name : str
            The plugin name that failed.
        exc : Exception
            The exception raised during load or registration.
        skip_broken : bool
            Whether to warn and continue instead of aborting.

        Raises
        ------
        PluginError
            When ``skip_broken`` is false; the message names the plugin and the
            remedy command.
        """
        if skip_broken:
            logger.warning(f"Skipping broken plugin '{name}': {exc}")
            return
        raise PluginError(
            f"Plugin '{name}' failed to load: {exc}\n"
            "Re-run with --skip-broken-plugins to continue past it."
        ) from exc

    @staticmethod
    def _load_path_module(name: str, init: Path) -> object:
        """Import a plugin module from an ``__init__.py`` (or module) file.

        Parameters
        ----------
        name : str
            The module name to import under.
        init : Path
            Path to the ``__init__.py`` or module file to load.

        Returns
        -------
        object
            The imported module.
        """
        spec = importlib.util.spec_from_file_location(name, init)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        return module

    def _register_external(
        self, name: str, load: Callable[[], object], skip_broken: bool
    ) -> None:
        """Load, version-check, and register one externally discovered plugin.

        Tiers 2-4 are the untrusted boundary, so each plugin must declare a
        compatible contract version through a module-level ``FABULOUS_PLUGIN_API``
        attribute. A load failure, a version mismatch, or a registration clash
        is routed through :meth:`_handle_broken`, honouring ``skip_broken``.

        Parameters
        ----------
        name : str
            The registration name for the plugin.
        load : Callable[[], object]
            Zero-argument callable returning the imported plugin module.
        skip_broken : bool
            Whether to warn and continue instead of aborting on failure.
        """
        try:
            module = load()
            self._assert_compatible(module)
            self.pm.register(module, name=name)
        except Exception as exc:  # noqa: BLE001 - policy decides re-raise
            self._handle_broken(name, exc, skip_broken)

    @staticmethod
    def _assert_compatible(module: object) -> None:
        """Raise unless ``module`` declares a compatible plugin-API version.

        Parameters
        ----------
        module : object
            The imported plugin module to check.

        Raises
        ------
        PluginError
            If the module's ``FABULOUS_PLUGIN_API`` does not match
            :data:`PLUGIN_API_VERSION`.
        """
        declared = getattr(module, "FABULOUS_PLUGIN_API", None)
        if declared != PLUGIN_API_VERSION:
            raise PluginError(
                f"declares plugin API {declared!r}, but this FABulous provides "
                f"{PLUGIN_API_VERSION}; set FABULOUS_PLUGIN_API = "
                f"{PLUGIN_API_VERSION} once the plugin supports it"
            )

    def register_builtins(self) -> None:
        """Register the essential built-in plugins (tier 1). Always fail loud."""
        for plugin in BuiltinPlugin:
            module = importlib.import_module(plugin.value)
            self.pm.register(module, name=plugin.value)

    def discover_dir(self, base: Path, skip_broken: bool) -> None:
        """Register tier-2 sub-plugins found as packages under ``base``.

        Parameters
        ----------
        base : Path
            Directory whose immediate package subdirectories are scanned.
        skip_broken : bool
            Whether to warn and continue when a plugin fails to load.
        """
        if not base.is_dir():
            return
        for child in sorted(base.iterdir(), key=lambda p: p.name):
            init = child / "__init__.py"
            if not child.is_dir() or not init.exists():
                continue
            name = child.name
            self._register_external(
                name, partial(self._load_path_module, name, init), skip_broken
            )

    def discover_entrypoints(self, skip_broken: bool) -> None:
        """Register tier-3 third-party plugins from the entry-point group.

        Parameters
        ----------
        skip_broken : bool
            Whether to warn and continue when a plugin fails to load.
        """
        eps = sorted(
            importlib_metadata.entry_points(group="fabulous.plugins"),
            key=lambda ep: ep.name,
        )
        for ep in eps:
            self._register_external(ep.name, ep.load, skip_broken)

    def register_session(self, spec: str, skip_broken: bool) -> None:
        """Register a tier-4 session plugin (a dotted path or a local dir/file).

        Parameters
        ----------
        spec : str
            A dotted module path, or a path to a package directory or module file.
        skip_broken : bool
            Whether to warn and continue when the plugin fails to load.
        """
        path = Path(spec)
        if path.exists():
            init = path / "__init__.py" if path.is_dir() else path
            name = path.name if path.is_dir() else path.stem
            load = partial(self._load_path_module, name, init)
        else:
            name = spec
            load = partial(importlib.import_module, spec)
        self._register_external(name, load, skip_broken)

    # -- Construction helpers -------------------------------------------------

    @staticmethod
    def _plugin_dir() -> Path:
        """Resolve the configured tier-2 plugin directory against the project.

        Returns
        -------
        Path
            ``plugins.dir``, resolved against the project directory when relative.
        """
        plugin_dir = get_context().plugins.dir
        if not plugin_dir.is_absolute():
            plugin_dir = get_context().proj_dir / plugin_dir
        return plugin_dir

    @classmethod
    def core_only(cls) -> Self:
        """Build a manager with only the essential built-ins registered.

        Returns
        -------
        Self
            A manager with tier-1 plugins registered and registries built.
        """
        manager = cls()
        manager.register_builtins()
        manager.build_registries()
        return manager

    @classmethod
    def for_management(cls) -> Self:
        """Discover every installed tier, for read-only management commands.

        Used by ``plugins list`` / ``info``. Unlike :meth:`create`, registries
        are not built and ``fabulous_startup`` is not fired, so inspecting
        plugins never runs their startup side effects. Broken optional plugins
        are downgraded to warnings so one bad plugin cannot hide the rest of
        the listing.

        Returns
        -------
        Self
            A manager with the built-in, directory, and entry-point plugins
            registered.
        """
        manager = cls()
        manager.register_builtins()
        manager.discover_dir(cls._plugin_dir(), skip_broken=True)
        manager.discover_entrypoints(skip_broken=True)
        return manager

    @classmethod
    def create(
        cls, extra_plugins: tuple[str, ...] = (), skip_broken: bool | None = None
    ) -> Self:
        """Build a fully discovered manager across all tiers.

        Parameters
        ----------
        extra_plugins : tuple[str, ...]
            Tier-4 session plugins (``-m/--plugin`` values).
        skip_broken : bool | None
            Override for ``plugins.skip_broken``; ``None`` uses the setting.

        Returns
        -------
        Self
            The populated manager, after ``fabulous_startup`` has fired.
        """
        settings = get_context().plugins
        if skip_broken is None:
            skip_broken = settings.skip_broken

        manager = cls()
        manager.register_builtins()

        manager.discover_dir(cls._plugin_dir(), skip_broken)
        manager.discover_entrypoints(skip_broken)
        for spec in extra_plugins:
            manager.register_session(spec, skip_broken)

        manager.build_registries()
        manager.pm.hook.fabulous_startup(manager=manager)
        return manager
