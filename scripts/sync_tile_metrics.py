#!/usr/bin/env python3
"""Sync tile dimensions from macro metrics.json into each tile's gds_config.yaml.

After run_FABulous_eFPGA_macro completes, each tile has final metrics in
{project}/Tile/{tile}/macro/final_views/metrics.json with the actual working
dimensions. This script reads those metrics and updates the same project's
gds_config.yaml so subsequent runs start from correct dimensions.

Default is dry-run; pass --apply to write changes.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

import yaml

REPO_ROOT = Path(__file__).resolve().parent.parent


class _FlowListDumper(yaml.SafeDumper):
    """YAML dumper that renders lists in flow style (single line)."""


def _represent_list(dumper: yaml.SafeDumper, data: list) -> yaml.Node:
    return dumper.represent_sequence("tag:yaml.org,2002:seq", data, flow_style=True)


_FlowListDumper.add_representer(list, _represent_list)


def load_metrics(metrics_path: Path) -> dict | None:
    """Load metrics.json and return extracted fields, or None on failure."""
    try:
        with metrics_path.open() as f:
            raw = json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return None

    bbox = raw.get("design__die__bbox")
    if not bbox:
        return None

    parts = bbox.split()
    width = float(parts[2]) - float(parts[0])
    height = float(parts[3]) - float(parts[1])

    return {
        "width": width,
        "height": height,
        "area": raw.get("design__die__area"),
        "util": raw.get("design__instance__utilization__stdcell"),
        "drc": raw.get("route__drc_errors"),
        "wirelength": raw.get("route__wirelength"),
        "antenna": raw.get("antenna__violating__nets"),
    }


def update_gds_config(
    config_path: Path, width: float, height: float
) -> tuple[list, str | None, bool]:
    """Update DIE_AREA in gds_config.yaml.

    Returns (old_die_area, new_content_or_none, changed).
    When unchanged, new_content is None (no write needed).
    """
    with config_path.open() as f:
        content = f.read()

    config = yaml.safe_load(content) or {}

    old_die_area = config.get("DIE_AREA", [0, 0, 0, 0])
    new_die_area = [0, 0, round(width, 2), round(height, 2)]

    if old_die_area == new_die_area:
        return (old_die_area, None, False)

    config["DIE_AREA"] = new_die_area
    new_content = yaml.dump(
        config, Dumper=_FlowListDumper, default_flow_style=False, sort_keys=False
    )

    return (old_die_area, new_content, True)


def _fmt(value: object, fmt: str = "") -> str:
    """Format a metric value, returning 'N/A' when None."""
    if value is None:
        return "N/A"
    return f"{value:{fmt}}" if fmt else str(value)


def _die_area_str(die_area: list) -> str:
    """Format a DIE_AREA list as a compact string."""
    return f"[{die_area[2]}, {die_area[3]}]"


def sync_tile_metrics(project: str, apply: bool) -> int:
    """Sync tile dimensions from metrics.json to gds_config.yaml."""
    project_dir = REPO_ROOT / project
    tile_dir = project_dir / "Tile"

    if not tile_dir.is_dir():
        raise FileNotFoundError(f"Tile directory not found: {tile_dir}")

    # Collect metrics and compute updates in one pass
    rows: list[dict] = []
    for entry in sorted(tile_dir.iterdir()):
        if not entry.is_dir() or "include" in str(entry):
            continue

        metrics_path = entry / "macro" / "final_views" / "metrics.json"
        if not metrics_path.exists():
            print(
                f"SKIP  {entry.name} (no final_views/metrics.json)",
                file=sys.stderr,
            )
            continue

        metrics = load_metrics(metrics_path)
        if not metrics:
            print(
                f"SKIP  {entry.name} (invalid metrics.json)",
                file=sys.stderr,
            )
            continue

        config_path = entry / "gds_config.yaml"
        if not config_path.is_file():
            print(
                f"SKIP  {entry.name} (missing gds_config.yaml)",
                file=sys.stderr,
            )
            continue

        old_die, new_content, changed = update_gds_config(
            config_path, metrics["width"], metrics["height"]
        )

        rows.append(
            {
                "tile": entry.name,
                "metrics": metrics,
                "config_path": config_path,
                "old_die": old_die,
                "changed": changed,
                "new_content": new_content,
            }
        )

    if not rows:
        raise FileNotFoundError(
            f"No valid metrics found in {tile_dir}/*/macro/final_views/"
        )

    # Print unified table
    header = (
        f"{'Tile':<20} {'Width':>8} {'Height':>8} {'Area':>10} "
        f"{'Util%':>7} {'DRC':>5} {'WireLen':>10} {'Ant':>5} "
        f"{'Old DIE_AREA':>16} {'Status':>10}"
    )
    sep = "─" * len(header)
    print(f"\n{sep}")
    print(header)
    print(sep)

    updated = 0
    unchanged = 0

    for row in rows:
        m = row["metrics"]
        util_pct = m["util"] * 100 if m["util"] is not None else None

        if row["changed"]:
            status = "UPDATE"
            updated += 1
            if apply:
                row["config_path"].write_text(row["new_content"], encoding="utf-8")
        else:
            status = "OK"
            unchanged += 1

        print(
            f"{row['tile']:<20} {m['width']:>8.2f} {m['height']:>8.2f} "
            f"{_fmt(m['area'], '.1f'):>10} {_fmt(util_pct, '.1f'):>7} "
            f"{_fmt(m['drc']):>5} {_fmt(m['wirelength']):>10} "
            f"{_fmt(m['antenna']):>5} "
            f"{_die_area_str(row['old_die']):>16} {status:>10}"
        )

    print(sep)

    # Summary
    mode = "APPLY" if apply else "DRY-RUN"
    print(
        f"{mode} summary: updated={updated}, unchanged={unchanged}, total={len(rows)}"
    )

    if not apply and updated > 0:
        print("No changes written. Run with --apply to update files.")

    return updated


def main() -> None:
    """CLI entry point."""
    parser = argparse.ArgumentParser(
        description=(
            "Sync tile dimensions from macro metrics.json"
            " into gds_config.yaml. Defaults to dry-run mode."
        )
    )
    parser.add_argument(
        "--apply",
        action="store_true",
        help="Write changes (default: dry-run).",
    )
    parser.add_argument(
        "--project",
        default="demo",
        help="Project directory relative to repo root (default: demo).",
    )
    args = parser.parse_args()

    sync_tile_metrics(project=args.project, apply=args.apply)


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, yaml.YAMLError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        sys.exit(1)
