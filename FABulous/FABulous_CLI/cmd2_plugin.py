"""Hook-based Typer integration for cmd2 (clean implementation)."""

from __future__ import annotations

import argparse
import inspect
from collections.abc import Callable
from typing import Any, Protocol, cast

import click
import typer
from cmd2 import Cmd
from cmd2.parsing import Statement, shlex_split
from cmd2.plugin import PostparsingData
from loguru import logger

from FABulous.custom_exception import CommandError


class _SupportsTyperConfig(Protocol):  # pragma: no cover
    typer_auto_enable: bool
    typer_skip_commands: set[str]
    typer_command_kwargs: dict[str, dict[str, Any]]
    typer_command_builder: (
        Callable[[Callable[..., Any], str, dict[str, Any]], click.Command] | None
    )


def _split_line(line: str) -> list[str]:
    # shlex_split from cmd2 already raises ValueError for malformed quotes;
    # fall back to simple split.
    try:
        return shlex_split(line)
    except ValueError:  # pragma: no cover
        return line.strip().split()


def _is_candidate(func: Callable[..., Any]) -> bool:
    sig = inspect.signature(func)
    params = list(sig.parameters.values())
    if not params or params[0].name != "self":
        return False
    var_positional_count = 0
    for p in params[1:]:
        if p.kind is inspect.Parameter.VAR_KEYWORD:
            return False
        if p.kind is inspect.Parameter.VAR_POSITIONAL:
            var_positional_count += 1
            # allow exactly one *args annotated as str (variadic tokens)
            ann = p.annotation
            if ann not in (str, inspect.Signature.empty):
                return False
            continue
        ann = p.annotation
        if ann in {argparse.Namespace}:
            return False
        origin = getattr(ann, "__origin__", None)
        if origin in {argparse.Namespace}:
            return False
    return var_positional_count <= 1


def _default_builder(
    cb: Callable[..., Any], name: str, kwargs: dict[str, Any]
) -> click.Command:
    """Return a Click command object for the method's Typer subcommand.

    We build a transient Typer application, register the method as a subcommand
    with the same name, then extract the underlying Click command for that
    subcommand. This allows us to call ``click_cmd.main(args=...)`` directly
    with the user's argument tokens (without inserting the command name).
    No implicit normalization or fallback coercion is performed—argument
    semantics are entirely driven by the function signature and annotations.
    """
    app = typer.Typer(add_completion=False, **kwargs)
    app.command(name=name)(cb)
    root = typer.main.get_command(app)
    if isinstance(root, click.Group):
        command = root.commands.get(name)
        if command is not None:
            return command
    if isinstance(root, click.Command):
        return root
    raise RuntimeError(f"Failed to build Typer command for {name}")


def _register_click_completer(
    app: Cmd, cmd_name: str, click_cmd: click.Command
) -> None:
    """Register a cmd2 completer that delegates to Click shell completion."""

    def completer(text: str, _line: str, _begidx: int, _endidx: int) -> list[str]:
        # Parse the command line to get arguments so far
        try:
            # Create Click context for completion
            ctx = click.Context(click_cmd, obj=app)

            # Get completions from Click
            completions = click_cmd.shell_complete(ctx, text)

            # Extract completion values
            return [comp.value for comp in completions]
        except (AttributeError, TypeError, ValueError):
            # Fall back to empty completion on any error
            return []

    # Register the completer with cmd2
    completer_name = f"complete_{cmd_name}"
    setattr(app, completer_name, completer)


def _build_cache(app: Cmd) -> dict[str, click.Command]:
    cfg = cast("_SupportsTyperConfig", app)
    if not getattr(cfg, "typer_auto_enable", True):
        return {}
    skip_raw = getattr(cfg, "typer_skip_commands", set())
    skip = {s if s.startswith("do_") else f"do_{s}" for s in skip_raw}

    # Always skip standard cmd2 commands regardless of where they're defined
    standard_cmd2_commands = {
        "do_exit",
        "do_quit",
        "do_q",
        "do_help",
        "do_history",
        "do_edit",
        "do_shell",
        "do_alias",
        "do_unalias",
        "do_shortcuts",
        "do_macro",
        "do_run_pyscript",
        "do_run_script",
        "do_set",
        "do_settable",
    }
    skip.update(standard_cmd2_commands)

    overrides = getattr(cfg, "typer_command_kwargs", {})
    builder = getattr(cfg, "typer_command_builder", None) or _default_builder
    cache: dict[str, click.Command] = {}
    for attr in dir(app):
        if not attr.startswith("do_"):
            continue
        if attr in skip or attr[3:] in skip:
            continue
        func = getattr(type(app), attr, None)
        if func is None or not inspect.isfunction(func):
            continue
        if func.__module__.startswith("cmd2."):
            continue
        if not _is_candidate(func):
            continue
        cmd_name = attr[3:]
        bound_cb = cast("Callable[..., Any]", func.__get__(app))
        try:
            cache[cmd_name] = builder(
                bound_cb, cmd_name, dict(overrides.get(cmd_name, {}))
            )
        except (TypeError, ValueError) as e:  # pragma: no cover
            logger.error("Failed to build Typer command '{}': {}", cmd_name, e)
    return cache


def plugin_start(app: Cmd) -> None:
    """cmd2 plugin start: install a postparsing hook to delegate to Typer.

    We wait until cmd2 parses a Statement. If the command token matches a Typer
    command we execute it immediately and prevent further cmd2 dispatch by
    rewriting the statement into a harmless no-op and marking it as empty.
    """
    logger.debug("cmd2_typer plugin_start for {}", type(app).__name__)
    cache = _build_cache(app)
    app.typer_command_cache = cache  # type: ignore[attr-defined]
    if not cache:
        logger.debug("No Typer commands discovered – plugin idle")
        return

    # Register shell completion handlers for each Typer command
    for cmd_name, click_cmd in cache.items():
        _register_click_completer(app, cmd_name, click_cmd)

    def _postparsing(data: PostparsingData) -> PostparsingData:  # pragma: no cover
        """Postparsing hook compatible with cmd2 2.7.0.

        Expects an object with a ``statement`` attribute (Statement) and a
        ``stop`` flag.
        """
        statement = getattr(data, "statement", None)
        if statement is None:
            return data
        cmd = statement.command
        if not cmd:
            return data
        click_cmd = cache.get(cmd)
        if not click_cmd:
            return data
        arg_tokens = getattr(statement, "arg_list", None)
        arg_list = list(arg_tokens) if arg_tokens else []
        try:
            click_cmd.main(
                args=arg_list,
                prog_name=cmd,
                standalone_mode=False,
                obj=app,
            )
        except click.exceptions.Exit as exc:
            if exc.exit_code not in (None, 0):
                raise CommandError(f"{cmd} exited with status {exc.exit_code}") from exc
        except click.ClickException as exc:
            msg = exc.format_message()
            logger.error(msg)
            raise CommandError(msg) from exc
        # Suppress further processing
        try:
            data.stop = True  # type: ignore[attr-defined]
            data.statement = Statement("")  # type: ignore[attr-defined]
        except AttributeError:
            pass
        return data

    app.register_postparsing_hook(_postparsing)  # type: ignore[arg-type]
    logger.debug("Registered Typer postparsing hook for: {}", sorted(cache))


class Cmd2TyperPlugin:
    """Optional mixin supplying default Typer integration attributes.

    Inherit alongside your ``cmd2.Cmd`` subclass if you want convenient defaults,
    or simply define the same attributes on your class directly.
    """

    typer_auto_enable: bool = True
    typer_skip_commands: set[str] = set()
    typer_command_kwargs: dict[str, dict[str, Any]] = {}
    typer_command_builder: (
        Callable[[Callable[..., Any], str, dict[str, Any]], click.Command] | None
    ) = None

    def __init__(self, *args: object, **kwargs: object) -> None:  # pragma: no cover
        super().__init__(*args, **kwargs)
        if not getattr(self, "_typer_plugin_installed", False) and isinstance(
            self, Cmd
        ):
            plugin_start(cast("Cmd", self))
            self._typer_plugin_installed = True


__all__ = ["plugin_start", "Cmd2TyperPlugin"]
