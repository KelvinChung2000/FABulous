"""The ``plugins`` command surface shared by the shell and the Typer entry.

This is *not* a plugin. The manager owns every operation; these helpers only
format the manager's state, and the ``PluginCommands`` set is a thin cmd2 bridge
that the CLI registers directly. The shell subcommands (``plugins list``,
``plugins info``, …) are wired through cmd2's ``as_subcommand_to`` so each is a
self-contained handler rather than a branch in a manual dispatcher.
"""

import argparse

import cmd2
from cmd2 import CommandSet, with_default_category

from fabulous.plugins.manager import FABulousPluginManager
from fabulous.plugins.types import PluginError


def format_plugin_list(manager: FABulousPluginManager) -> str:
    """Return a human-readable listing of registered plugins.

    Parameters
    ----------
    manager : FABulousPluginManager
        The manager whose plugins are listed.

    Returns
    -------
    str
        The formatted listing.
    """
    header = f"  {'name':50s} tier"
    rows = [f"  {s.name:50s} {s.tier}" for s in manager.status()]
    return "Plugins:\n" + header + "\n" + "\n".join(rows)


def format_plugin_info(manager: FABulousPluginManager, name: str) -> str:
    """Return detail for a single plugin, including contributed settings.

    Parameters
    ----------
    manager : FABulousPluginManager
        The manager to query.
    name : str
        The plugin name.

    Returns
    -------
    str
        The formatted detail.

    Raises
    ------
    PluginError
        If no plugin named ``name`` is registered.
    """
    if not manager.is_registered(name):
        raise PluginError(f"No plugin named '{name}'")
    lines = [f"Plugin: {name}", f"  tier: {manager.tier_of(name)}"]
    summary = manager.settings_summary(name)
    if summary is not None:
        lines.append(f"  settings: {summary}")
    return "\n".join(lines)


def format_install_result(added: list[str]) -> str:
    """Return a human-readable summary of an ``install`` outcome.

    Parameters
    ----------
    added : list[str]
        The plugin entry points the install added.

    Returns
    -------
    str
        A success line naming the new plugin(s), or a warning that the package
        registered no FABulous plugin.
    """
    if added:
        return (
            f"Installed. Registered plugin(s): {', '.join(added)}. "
            "Restart FABulous to load them."
        )
    return (
        "Installed, but the package exposes no 'fabulous.plugins' entry point, "
        "so it adds no FABulous plugin."
    )


def format_uninstall_result(removed: list[str]) -> str:
    """Return a human-readable summary of an ``uninstall`` outcome.

    Parameters
    ----------
    removed : list[str]
        The plugin entry points the uninstall removed.

    Returns
    -------
    str
        A line naming the removed plugin(s), or a plain confirmation.
    """
    if removed:
        return f"Uninstalled. Removed plugin(s): {', '.join(removed)}."
    return "Uninstalled."


def _name_argument(metavar: str, help_text: str) -> cmd2.Cmd2ArgumentParser:
    """Build a subcommand parser taking a single positional argument."""
    parser = cmd2.Cmd2ArgumentParser()
    parser.add_argument(metavar, help=help_text)
    return parser


_plugins_parser = cmd2.Cmd2ArgumentParser()
_plugins_parser.add_subparsers(dest="action")


@with_default_category("Plugins")
class PluginCommands(CommandSet):
    """The shell ``plugins ...`` surface (a thin bridge to the manager)."""

    @property
    def _manager(self) -> FABulousPluginManager:
        return self._cmd.pluginManager

    @cmd2.with_argparser(_plugins_parser)
    def do_plugins(self, args: argparse.Namespace) -> None:
        """Manage FABulous plugins."""
        handler = args.cmd2_handler.get()
        if handler is not None:
            handler(args)
        else:
            self._cmd.do_help("plugins")

    @cmd2.as_subcommand_to(
        "plugins", "list", cmd2.Cmd2ArgumentParser(), help="List discovered plugins"
    )
    def _list(self, _args: argparse.Namespace) -> None:
        """List discovered plugins."""
        self._cmd.poutput(format_plugin_list(self._manager))

    @cmd2.as_subcommand_to(
        "plugins",
        "info",
        _name_argument("name", "Plugin name"),
        help="Show plugin detail",
    )
    def _info(self, args: argparse.Namespace) -> None:
        """Show detail for a single plugin."""
        self._cmd.poutput(format_plugin_info(self._manager, args.name))

    @cmd2.as_subcommand_to(
        "plugins",
        "install",
        _name_argument("spec", "Package name, git URL, or local path"),
        help="Install a plugin package via uv",
    )
    def _install(self, args: argparse.Namespace) -> None:
        """Install a plugin package via uv."""
        added = self._manager.install(args.spec)
        self._cmd.poutput(format_install_result(added))

    @cmd2.as_subcommand_to(
        "plugins",
        "uninstall",
        _name_argument("name", "Package name"),
        help="Uninstall a plugin package via uv",
    )
    def _uninstall(self, args: argparse.Namespace) -> None:
        """Uninstall a plugin package via uv."""
        removed = self._manager.uninstall(args.name)
        self._cmd.poutput(format_uninstall_result(removed))
