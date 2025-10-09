"""Hook-based Typer integration for cmd2 (clean implementation)."""

from __future__ import annotations

import inspect
from collections.abc import Callable
from typing import Any, cast

import click
import typer
from cmd2 import Cmd
from cmd2.parsing import Statement
from loguru import logger

from FABulous.custom_exception import CommandError


class CompleterSpec:
    """Specification for tab completion behavior.

    Used to declare completion functions that the plugin will wire up to both Click's
    autocompletion and cmd2's tab completion.
    """

    def __init__(self, completer: Callable[[Cmd, str, str, int], list[str]]):
        """Initialize completion specification.

        Args:
            completer: Function that takes (app, text, line, begidx) and returns
                      list of completion strings. Compatible with cmd2 completer signature.
        """
        self.completer = completer


class Cmd2TyperPlugin(Cmd):
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

    __inner_app: typer.Typer

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

    def _extract_completion_spec(
        self, func: Callable[..., Any]
    ) -> CompleterSpec | None:
        """Extract CompletionSpec from function annotations if present."""
        # Extract completion specification if present
        completion_spec = None
        sig = inspect.signature(func)
        for param in sig.parameters.values():
            if param.name == "self":
                continue

            # Check if annotation contains CompletionSpec
            ann = param.annotation
            if ann is inspect.Signature.empty:
                continue

            # Handle Annotated types
            origin = getattr(ann, "__origin__", None)
            if origin is not None:
                # For Annotated[type, metadata...], check metadata
                metadata = getattr(ann, "__metadata__", ())
                for item in metadata:
                    if isinstance(item, CompleterSpec):
                        completion_spec = item
        return completion_spec

    def cmd_register(self) -> None:
        """Register all cmd2 do_* methods as Typer commands."""
        skip = set()

        # Always skip standard cmd2 commands regardless of where they're defined
        skip.update(self.standard_cmd2_commands)

        for attr in dir(self):
            if not attr.startswith("do_"):
                continue
            if attr in skip or attr[3:] in skip:
                continue
            func = getattr(type(self), attr, None)
            if func is None or not inspect.isfunction(func):
                continue
            if func.__module__.startswith("cmd2."):
                continue

            cmd_name = attr[3:]
            bound_cb = cast("Callable[..., Any]", func.__get__(self))
            completer_spec = self._extract_completion_spec(func)
            self.__inner_app.command(name=cmd_name)(bound_cb)

            if completer_spec is None:
                continue

            # bind completer_spec into function default to capture current loop value
            def completer(
                text: str,
                line: str,
                begidx: int,
                endidx: int,
                _completer_spec: CompleterSpec = completer_spec,
            ) -> list[str]:
                try:
                    # Call the user-provided completion function
                    return _completer_spec.completer(self, text, line, begidx)
                except (AttributeError, TypeError, ValueError):
                    return []

            setattr(self, f"complete_{cmd_name}", completer)

    def onecmd(
        self, statement: Statement | str, *, add_to_history: bool = True
    ) -> bool:
        cmds = typer.main.get_command(self.__inner_app)
        if isinstance(cmds, click.Group) and isinstance(statement, Statement):
            if statement.command not in cmds.commands:
                return super().onecmd(statement, add_to_history=add_to_history)
            return cmds.commands[statement.command].main(
                args=list(statement.arg_list),
                prog_name=statement.command,
                standalone_mode=False,
                obj=self.__inner_app,
            )
        raise CommandError("Invalid command or statement")

    def __init__(self, *args: object, **kwargs: object) -> None:  # pragma: no cover
        super().__init__(*args, **kwargs)
        logger.debug("cmd2_typer plugin_start for {}", type(self).__name__)
        self.__inner_app = typer.Typer(add_completion=False)

        self.cmd_register()
