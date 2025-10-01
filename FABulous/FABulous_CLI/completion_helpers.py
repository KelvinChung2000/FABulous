"""Completion helper functions for FABulous CLI commands.

These functions can be used in Annotated types with CompletionSpec to provide
intelligent tab completion for various command arguments.
"""

from cmd2 import Cmd
from cmd2.parsing import shlex_split


def _split_line(line: str) -> list[str]:
    """Split command line, handling quotes properly."""
    try:
        return shlex_split(line)
    except ValueError:
        return line.strip().split()


def complete_tile_names(app: Cmd, text: str, line: str, begidx: int) -> list[str]:
    """Complete tile names with support for multiple arguments.

    Args:
        app: The CLI application instance
        text: The text being completed
        line: The full command line
        begidx: The beginning index of text in line

    Returns
    -------
        List of matching tile names
    """
    if not hasattr(app, "fabricLoaded") or not app.fabricLoaded:
        return []

    all_tiles = getattr(app, "allTile", [])
    if not all_tiles:
        return []

    # Parse already entered tokens to avoid duplicates
    try:
        tokens = _split_line(line[:begidx])[1:]  # Skip command name
        used_tiles = {token for token in tokens if token in all_tiles}
        available_tiles = [tile for tile in all_tiles if tile not in used_tiles]
    except (ValueError, IndexError):
        available_tiles = all_tiles

    # Filter by prefix
    if text:
        text_lower = text.lower()
        available_tiles = [
            tile for tile in available_tiles if tile.lower().startswith(text_lower)
        ]

    return sorted(available_tiles)


def complete_bel_names(app: Cmd, text: str, line: str, begidx: int) -> list[str]:
    """Complete BEL names.

    Args:
        app: The CLI application instance
        text: The text being completed
        line: The full command line
        begidx: The beginning index of text in line

    Returns
    -------
        List of matching BEL names
    """
    if not hasattr(app, "fabricLoaded") or not app.fabricLoaded:
        return []

    bel_names = getattr(app, "_bel_names", [])
    if not bel_names:
        return []

    # Filter by prefix
    if text:
        text_lower = text.lower()
        bel_names = [bel for bel in bel_names if bel.lower().startswith(text_lower)]

    return sorted(bel_names)


# Example usage in command annotations:
#
# from FABulous.FABulous_CLI.cmd2_plugin import CompletionSpec
# from FABulous.FABulous_CLI.completion_helpers import complete_tile_names
#
# def do_gen_tile(
#     self,
#     tiles: Annotated[
#         list[str],
#         CompletionSpec(completer=complete_tile_names),
#         typer.Argument(..., metavar="TILE...", help="Tiles to generate"),
#     ],
# ) -> None:
#     ...
