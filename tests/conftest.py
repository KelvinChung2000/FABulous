from collections.abc import Generator
from pathlib import Path

import pytest

from FABulous.FABulous_CLI.helper import create_project
from FABulous.FABulous_settings import reset_context


@pytest.fixture
def project(tmp_path: Path) -> Generator[Path]:
    project_dir = tmp_path / "test_project"
    create_project(project_dir)

    yield project_dir

    # Cleanup
    reset_context()  # Reset context after each test to avoid state leakage
