"""Tests for the model_fields-based settings doc extractor."""

from pathlib import Path

import generate_configvar_docs as cfg
import pytest


def _flatten(settings_vars: dict) -> dict:
    return {
        v["name"]: v
        for subcats in settings_vars.values()
        for vars_ in subcats.values()
        for v in vars_
    }


def test_extracts_known_settings() -> None:
    flat = _flatten(cfg.extract_fabulous_settings())
    assert "proj_dir" in flat
    assert flat["proj_dir"]["env_var"] == "FAB_PROJ_DIR"
    assert flat["yosys_path"]["type"] == "Path"


def test_deprecated_field_excluded() -> None:
    flat = _flatten(cfg.extract_fabulous_settings())
    assert "version" not in flat  # `version` is deprecated=True


def test_none_default_renders_as_none() -> None:
    flat = _flatten(cfg.extract_fabulous_settings())
    assert flat["oss_cad_suite"]["default"] == "None"


def test_proj_version_not_leaking_build_version() -> None:
    flat = _flatten(cfg.extract_fabulous_settings())
    # Must not render the build-specific dev version string.
    assert flat["proj_version"]["default"] == "(dynamic)"


def test_settables_extracted_from_source() -> None:
    names = {s["name"] for s in cfg.extract_cli_settables()}
    assert {"projectDir", "csvFile", "verbose", "force"} <= names


def test_settables_extraction_does_not_swallow_errors(
    monkeypatch: pytest.MonkeyPatch, tmp_path: Path
) -> None:
    # With the hardcoded fallback removed, a missing source must raise, not
    # silently return a stale list.
    monkeypatch.setattr(cfg, "_PROJECT_ROOT", tmp_path)
    with pytest.raises(FileNotFoundError):
        cfg.extract_cli_settables()


def test_scope_split() -> None:
    settings_vars = cfg.extract_fabulous_settings()
    proj = {
        v["name"]
        for vars_ in settings_vars["Project Specific Environment Variables"].values()
        for v in vars_
    }
    glob = {
        v["name"]
        for vars_ in settings_vars["Global Environment Variables"].values()
        for v in vars_
    }
    assert "proj_dir" in proj
    assert "yosys_path" in glob
