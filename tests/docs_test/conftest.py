"""Make the custom Sphinx extensions importable in the docs test suite."""

import sys
from pathlib import Path

_EXT_DIR = Path(__file__).resolve().parents[2] / "docs" / "source" / "_ext"
if _EXT_DIR.as_posix() not in sys.path:
    sys.path.insert(0, _EXT_DIR.as_posix())
