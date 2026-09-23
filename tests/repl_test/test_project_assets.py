"""Tests for assembling a project from packaged fabric and tile assets."""

import sys
from collections.abc import Generator
from pathlib import Path

import pytest

from fabulous.fabric_definition.define import HDLType
from fabulous.fabulous_repl.project_assets import (
    TileLibraryRef,
    copy_fabric,
    copy_tile_library,
)

TILES_MANIFEST = "tile_libraries:\n  demo:\n    root: tiles/demo\n"
FABRICS_MANIFEST = (
    "fabrics:\n  demo:\n    root: fabrics/demo\n"
    "    tile_library:\n      package: fake_tiles\n      name: demo\n"
)


def _write(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, newline="")


@pytest.fixture
def fake_packages(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> Generator[Path]:
    """Install `fake_tiles` and `fake_fabrics`, shaped like the real packages."""
    site = tmp_path / "site"
    tiles = site / "fake_tiles"
    _write(tiles / "__init__.py", "")
    _write(tiles / "manifest.yaml", TILES_MANIFEST)
    _write(tiles / "tiles/demo/demo.csv", "TileLibraryBegin\nTileLibraryEnd\n")
    _write(tiles / "tiles/demo/include/Base.csv", "NORTH,N1BEG,0,-1,N1END,4\n")
    _write(
        tiles / "tiles/demo/LUT/LUT.csv",
        "TILE,LUT,DEPRECATED\n"
        "BEL,../../../primitives/LUT4/fabulous/LUT4.{HDL_SUFFIX},LA_,,\n"
        "BEL,../../../primitives/LUT4/fabulous/LUT4.{HDL_SUFFIX},LB_,,\n"
        "EndTILE\n",
    )
    _write(
        tiles / "tiles/demo/DSP/DSP_bot/DSP_bot.csv",
        "TILE,DSP_bot\nBEL,../../../../primitives/MULADD/fabulous/MULADD.{HDL_SUFFIX}\nEndTILE\n",
    )
    for name in ("LUT4", "MULADD"):
        _write(
            tiles / f"primitives/{name}/fabulous/{name}.v",
            f"module {name}; endmodule\n",
        )
        _write(
            tiles / f"primitives/{name}/fabulous/{name}.vhdl",
            f"entity {name} is end;\n",
        )
    fabrics = site / "fake_fabrics"
    _write(fabrics / "__init__.py", "")
    _write(fabrics / "manifest.yaml", FABRICS_MANIFEST)
    _write(fabrics / "fabrics/demo/common/fabric.csv", "FabricBegin\nFabricEnd\n")
    _write(fabrics / "fabrics/demo/verilog/Fabric/models_pack.v", "// verilog\n")
    _write(fabrics / "fabrics/demo/vhdl/Fabric/models_pack.vhdl", "-- vhdl\n")
    monkeypatch.syspath_prepend(str(site))
    yield site
    # The import system caches the packages, so the next test would read this tree.
    for package in ("fake_tiles", "fake_fabrics"):
        sys.modules.pop(package, None)


@pytest.mark.usefixtures("fake_packages")
@pytest.mark.parametrize(
    ("lang", "models_pack"),
    [
        (HDLType.VERILOG, "Fabric/models_pack.v"),
        (HDLType.VHDL, "Fabric/models_pack.vhdl"),
    ],
)
def test_copy_fabric_copies_common_then_language(
    tmp_path: Path, lang: HDLType, models_pack: str
) -> None:
    project = tmp_path / "proj"
    ref = copy_fabric(project, lang, package="fake_fabrics", name="demo")
    assert ref == TileLibraryRef(package="fake_tiles", name="demo")
    assert (project / "fabric.csv").read_text() == "FabricBegin\nFabricEnd\n"
    assert (project / models_pack).is_file()


@pytest.mark.usefixtures("fake_packages")
@pytest.mark.parametrize(
    ("lang", "suffix"), [(HDLType.VERILOG, "v"), (HDLType.VHDL, "vhdl")]
)
def test_copy_tile_library_localises_bel_rows(
    tmp_path: Path, lang: HDLType, suffix: str
) -> None:
    project = tmp_path / "proj"
    copy_tile_library(project, TileLibraryRef(package="fake_tiles", name="demo"), lang)
    tile = project / "Tile"
    assert (tile / "LUT/LUT.csv").read_text() == (
        "TILE,LUT,DEPRECATED\n"
        "BEL,./LUT4.{HDL_SUFFIX},LA_,,\n"
        "BEL,./LUT4.{HDL_SUFFIX},LB_,,\n"
        "EndTILE\n"
    )
    assert (tile / f"LUT/LUT4.{suffix}").is_file()
    assert (tile / "DSP/DSP_bot/DSP_bot.csv").read_text() == (
        "TILE,DSP_bot\nBEL,./MULADD.{HDL_SUFFIX}\nEndTILE\n"
    )
    assert (tile / f"DSP/DSP_bot/MULADD.{suffix}").is_file()
    assert (tile / "include/Base.csv").is_file()
    assert not (tile / "demo.csv").exists()


def test_copy_tile_library_keeps_crlf(fake_packages: Path, tmp_path: Path) -> None:
    csv = fake_packages / "fake_tiles/tiles/demo/LUT/LUT.csv"
    csv.write_bytes(csv.read_bytes().replace(b"\n", b"\r\n"))
    project = tmp_path / "proj"
    copy_tile_library(
        project, TileLibraryRef(package="fake_tiles", name="demo"), HDLType.VERILOG
    )
    assert (
        b"BEL,./LUT4.{HDL_SUFFIX},LA_,,\r\n"
        in (project / "Tile/LUT/LUT.csv").read_bytes()
    )


def test_copied_files_are_writable_from_read_only_package(
    fake_packages: Path, tmp_path: Path
) -> None:
    for path in (fake_packages / "fake_tiles").rglob("*"):
        path.chmod(0o555 if path.is_dir() else 0o444)
    project = tmp_path / "proj"
    try:
        copy_tile_library(
            project, TileLibraryRef(package="fake_tiles", name="demo"), HDLType.VERILOG
        )
    finally:
        for path in (fake_packages / "fake_tiles").rglob("*"):
            path.chmod(0o755 if path.is_dir() else 0o644)
    for path in (project / "Tile").rglob("*"):
        assert path.stat().st_mode & 0o200, path


def test_bel_outside_primitives_raises(fake_packages: Path, tmp_path: Path) -> None:
    _write(
        fake_packages / "fake_tiles/tiles/demo/LUT/LUT.csv",
        "TILE,LUT\nBEL,./stray.{HDL_SUFFIX}\nEndTILE\n",
    )
    _write(
        fake_packages / "fake_tiles/tiles/demo/LUT/stray.v", "module stray; endmodule\n"
    )
    with pytest.raises(ValueError, match="outside"):
        copy_tile_library(
            tmp_path / "proj",
            TileLibraryRef(package="fake_tiles", name="demo"),
            HDLType.VERILOG,
        )


@pytest.mark.usefixtures("fake_packages")
@pytest.mark.parametrize("lang", [HDLType.SYSTEM_VERILOG])
def test_copy_tile_library_rejects_unsupported_language(
    tmp_path: Path, lang: HDLType
) -> None:
    with pytest.raises(ValueError, match=str(lang)):
        copy_tile_library(
            tmp_path / "proj", TileLibraryRef(package="fake_tiles", name="demo"), lang
        )


@pytest.mark.usefixtures("fake_packages")
@pytest.mark.parametrize("lang", [HDLType.SYSTEM_VERILOG])
def test_copy_fabric_rejects_unsupported_language(
    tmp_path: Path, lang: HDLType
) -> None:
    with pytest.raises(ValueError, match=str(lang)):
        copy_fabric(tmp_path / "proj", lang, package="fake_fabrics", name="demo")


def test_missing_bel_source_names_tile_csv(fake_packages: Path, tmp_path: Path) -> None:
    (fake_packages / "fake_tiles/primitives/LUT4/fabulous/LUT4.vhdl").unlink()
    with pytest.raises(FileNotFoundError, match=r"LUT4\.vhdl") as exc_info:
        copy_tile_library(
            tmp_path / "proj",
            TileLibraryRef(package="fake_tiles", name="demo"),
            HDLType.VHDL,
        )
    assert "LUT4.{HDL_SUFFIX}" in str(exc_info.value)
    assert str(fake_packages / "fake_tiles/tiles/demo/LUT/LUT.csv") in str(
        exc_info.value
    )


def test_bel_name_clash_raises(fake_packages: Path, tmp_path: Path) -> None:
    _write(
        fake_packages / "fake_tiles/primitives/other/fabulous/LUT4.v",
        "module LUT4_other; endmodule\n",
    )
    _write(
        fake_packages / "fake_tiles/tiles/demo/LUT/LUT.csv",
        "TILE,LUT\n"
        "BEL,../../../primitives/LUT4/fabulous/LUT4.{HDL_SUFFIX}\n"
        "BEL,../../../primitives/other/fabulous/LUT4.{HDL_SUFFIX}\n"
        "EndTILE\n",
    )
    with pytest.raises(FileExistsError, match="LUT4.v"):
        copy_tile_library(
            tmp_path / "proj",
            TileLibraryRef(package="fake_tiles", name="demo"),
            HDLType.VERILOG,
        )


# `A.v` sorts before `LUT.csv` and `LUT4.v` after it, so both copy orders are covered.
@pytest.mark.parametrize("primitive", ["A", "LUT4"])
def test_tile_file_clashing_with_bel_raises(
    fake_packages: Path, tmp_path: Path, primitive: str
) -> None:
    tiles = fake_packages / "fake_tiles"
    _write(
        tiles / f"primitives/{primitive}/fabulous/{primitive}.v",
        f"module {primitive}; endmodule\n",
    )
    _write(tiles / f"tiles/demo/LUT/{primitive}.v", "module tile_local; endmodule\n")
    _write(
        tiles / "tiles/demo/LUT/LUT.csv",
        f"TILE,LUT\nBEL,../../../primitives/{primitive}/fabulous/{primitive}"
        ".{HDL_SUFFIX}\nEndTILE\n",
    )
    with pytest.raises(FileExistsError, match=f"{primitive}.v"):
        copy_tile_library(
            tmp_path / "proj",
            TileLibraryRef(package="fake_tiles", name="demo"),
            HDLType.VERILOG,
        )


@pytest.mark.usefixtures("fake_packages")
@pytest.mark.parametrize(
    ("package", "name", "error", "match"),
    [
        ("fake_fabrics", "missing", ValueError, "missing"),
        ("not_installed_fabrics", "demo", ModuleNotFoundError, "uv sync"),
    ],
)
def test_copy_fabric_lookup_errors(
    tmp_path: Path,
    package: str,
    name: str,
    error: type[Exception],
    match: str,
) -> None:
    with pytest.raises(error, match=match):
        copy_fabric(tmp_path / "proj", HDLType.VERILOG, package=package, name=name)


def test_missing_manifest_names_path(fake_packages: Path, tmp_path: Path) -> None:
    (fake_packages / "fake_fabrics/manifest.yaml").unlink()
    with pytest.raises(FileNotFoundError, match="manifest.yaml"):
        copy_fabric(
            tmp_path / "proj", HDLType.VERILOG, package="fake_fabrics", name="demo"
        )
