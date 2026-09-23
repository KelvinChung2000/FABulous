"""Assemble a new project from a packaged fabric and its tile library.

Fabrics and tile libraries ship as Python packages with a `manifest.yaml` at the
import root, so a project builds the same from a wheel, a uv git source or the Nix
store. Every file is copied into the project, because parsing a VHDL BEL writes `.v`
and `.json` files next to its source and an installed package can be read-only.
"""

import shutil
from importlib import resources
from pathlib import Path

import yaml
from pydantic import BaseModel, ConfigDict

from fabulous.fabric_definition.define import HDLType

DEFAULT_FABRIC_PACKAGE = "fabulous_fabrics"
DEFAULT_FABRIC = "fabulous"
_HDL_SUFFIX = "{HDL_SUFFIX}"


class TileLibraryRef(BaseModel):
    """A tile library named by the package that ships it and its manifest key."""

    model_config = ConfigDict(extra="forbid", frozen=True)

    package: str
    name: str


class FabricAsset(BaseModel):
    """A fabric skeleton under `root`, split into `common/`, `verilog/` and `vhdl/`."""

    model_config = ConfigDict(extra="forbid", frozen=True)

    root: Path
    tile_library: TileLibraryRef


class TileLibraryAsset(BaseModel):
    """A tile library whose tile directories sit under `root`."""

    model_config = ConfigDict(extra="forbid", frozen=True)

    root: Path


class AssetManifest(BaseModel):
    """The `manifest.yaml` at the import root of an asset package."""

    model_config = ConfigDict(extra="forbid", frozen=True)

    fabrics: dict[str, FabricAsset] = {}
    tile_libraries: dict[str, TileLibraryAsset] = {}


def _load_manifest(package: str) -> tuple[Path, AssetManifest]:
    """Return the import root of `package` and its validated manifest.

    Parameters
    ----------
    package : str
        The import package shipping the manifest.

    Returns
    -------
    tuple[Path, AssetManifest]
        The import root and the validated manifest.

    Raises
    ------
    ModuleNotFoundError
        If `package` is not installed.
    FileNotFoundError
        If `package` is not installed as a directory or has no `manifest.yaml`.
    """
    try:
        root = resources.files(package)
    except ModuleNotFoundError as e:
        raise ModuleNotFoundError(
            f"The asset package {package} is not installed. Run `uv sync` in the "
            "FABulous checkout, or reinstall FABulous with its dependencies."
        ) from e
    if not isinstance(root, Path):
        raise FileNotFoundError(
            f"The asset package {package} is not installed as a directory ({root!r}). "
            "Reinstall it from a wheel or a source checkout."
        )
    manifest_path = root / "manifest.yaml"
    if not manifest_path.is_file():
        raise FileNotFoundError(
            f"The asset package {package} has no manifest at {manifest_path}. "
            "Install a release of it that ships manifest.yaml."
        )
    return root, AssetManifest.model_validate(yaml.safe_load(manifest_path.read_text()))


def _copy_writable(src: Path, dest: Path) -> None:
    """Copy file contents only, so a read-only source yields a writable copy."""
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(src, dest)


def _copy_into_tile(src: Path, dest: Path, sources: dict[Path, Path]) -> None:
    """Copy `src` to `dest` unless a different source already landed at `dest`.

    Parameters
    ----------
    src : Path
        The file to copy.
    dest : Path
        The destination under the project's `Tile/`.
    sources : dict[Path, Path]
        The source already copied to each destination, updated in place.

    Raises
    ------
    FileExistsError
        If `dest` already holds a copy of a file whose bytes differ from `src`.
    """
    if dest in sources and sources[dest].read_bytes() != src.read_bytes():
        raise FileExistsError(
            f"{dest} would hold both {sources[dest]} and {src}, which differ. "
            "Rename one of them."
        )
    sources[dest] = src
    _copy_writable(src, dest)


def copy_fabric(
    project_dir: Path,
    lang: HDLType,
    package: str = DEFAULT_FABRIC_PACKAGE,
    name: str = DEFAULT_FABRIC,
) -> TileLibraryRef:
    """Copy fabric `name` from `package` into `project_dir`.

    `common/` is copied first and the language directory second, so a language file
    replaces a common file at the same path.

    Parameters
    ----------
    project_dir : Path
        The project root.
    lang : HDLType
        The project language, which selects `verilog/` or `vhdl/`.
    package : str
        The import package shipping the fabric. Defaults to `fabulous_fabrics`.
    name : str
        The fabric's manifest key. Defaults to `fabulous`.

    Returns
    -------
    TileLibraryRef
        The tile library the fabric declares.

    Raises
    ------
    ValueError
        If `lang` is neither Verilog nor VHDL, or the manifest has no fabric `name`.
    FileNotFoundError
        If the fabric lacks `common/` or the language directory.
    """
    if lang not in (HDLType.VERILOG, HDLType.VHDL):
        raise ValueError(f"Fabrics ship Verilog and VHDL skeletons only, not {lang}.")
    root, manifest = _load_manifest(package)
    if name not in manifest.fabrics:
        raise ValueError(
            f"Fabric {name} is not in {package}. Available: {sorted(manifest.fabrics)}."
        )
    fabric = manifest.fabrics[name]
    for part in ("common", str(lang)):
        part_dir = root / fabric.root / part
        if not part_dir.is_dir():
            raise FileNotFoundError(f"Fabric {name} in {package} has no {part_dir}.")
        for src in sorted(part_dir.rglob("*")):
            if src.is_file():
                _copy_writable(src, project_dir / src.relative_to(part_dir))
    return fabric.tile_library


def copy_tile_library(project_dir: Path, ref: TileLibraryRef, lang: HDLType) -> None:
    """Copy tile library `ref` into `project_dir/Tile` with tile-local BEL sources.

    Files directly in the library root are library metadata and are skipped. Each
    `BEL,` row is rewritten to `./<file name>`, and the primitive it names, with
    `{HDL_SUFFIX}` resolved for `lang`, is copied next to the tile CSV. Two files
    with different bytes that would land at the same path raise `FileExistsError`.

    Parameters
    ----------
    project_dir : Path
        The project root.
    ref : TileLibraryRef
        The tile library to copy.
    lang : HDLType
        The project language, which selects the primitive file suffix.

    Raises
    ------
    ValueError
        If `lang` is neither Verilog nor VHDL, the manifest has no library
        `ref.name`, or a BEL path resolves outside the package's `primitives/`
        directory.
    FileNotFoundError
        If the primitive a BEL row names does not exist for `lang`.
    """
    match lang:
        case HDLType.VERILOG:
            suffix = "v"
        case HDLType.VHDL:
            suffix = "vhdl"
        case _:
            raise ValueError(
                f"Tile libraries ship Verilog and VHDL primitives only, not {lang}."
            )
    root, manifest = _load_manifest(ref.package)
    if ref.name not in manifest.tile_libraries:
        raise ValueError(
            f"Tile library {ref.name} is not in {ref.package}. "
            f"Available: {sorted(manifest.tile_libraries)}."
        )
    library_dir = root / manifest.tile_libraries[ref.name].root
    primitives_dir = (root / "primitives").resolve()
    sources: dict[Path, Path] = {}
    for src in sorted(library_dir.rglob("*")):
        if not src.is_file() or src.parent == library_dir:
            continue
        dest = project_dir / "Tile" / src.relative_to(library_dir)
        if src.suffix != ".csv":
            _copy_into_tile(src, dest, sources)
            continue
        out: list[str] = []
        with src.open(newline="") as f:
            lines = f.read().splitlines(keepends=True)
        for line in lines:
            body = line.rstrip("\r\n")
            fields = body.split(",")
            if fields[0] != "BEL":
                out.append(line)
                continue
            bel_src = (src.parent / fields[1].replace(_HDL_SUFFIX, suffix)).resolve()
            if not bel_src.is_relative_to(primitives_dir):
                raise ValueError(
                    f"BEL {fields[1]} in {src} resolves to {bel_src}, outside "
                    f"{primitives_dir}. Tile library BELs must live in primitives/."
                )
            if not bel_src.is_file():
                raise FileNotFoundError(
                    f"BEL {fields[1]} in {src} resolves to {bel_src}, which does not "
                    f"exist. The tile library ships no {lang} source for it."
                )
            _copy_into_tile(bel_src, dest.parent / bel_src.name, sources)
            fields[1] = f"./{Path(fields[1]).name}"
            out.append(",".join(fields) + line[len(body) :])
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text("".join(out), newline="")
