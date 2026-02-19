#!/usr/bin/env python3
import json
from pathlib import Path

# Get all tile directories
tile_base_path = Path("./demo/Tile")
tiles = {}

for tile_dir in sorted(tile_base_path.iterdir()):
    if tile_dir.is_dir():
        # First check for final_views
        metrics_path = tile_dir / "macro" / "final_views" / "metrics.json"
        if metrics_path.exists():
            try:
                with open(metrics_path) as f:
                    metrics = json.load(f)
                    bbox = metrics.get("design__die__bbox", "N/A")
                    if bbox != "N/A":
                        parts = bbox.split()
                        width = float(parts[2]) - float(parts[0])
                        height = float(parts[3]) - float(parts[1])
                        tiles[tile_dir.name] = {
                            "width": width,
                            "height": height,
                            "bbox": bbox,
                            "area": width * height,
                            "source": "final_views",
                        }
            except Exception as e:
                tiles[tile_dir.name] = {"error": str(e)}
        else:
            # Check for latest run in no_opt
            runs_path = tile_dir / "macro" / "no_opt" / "runs"
            if runs_path.exists():
                runs = sorted(runs_path.iterdir(), key=lambda x: x.name, reverse=True)
                if runs:
                    latest_run = runs[0]
                    final_metrics = latest_run / "final" / "metrics.json"
                    if final_metrics.exists():
                        try:
                            with open(final_metrics) as f:
                                metrics = json.load(f)
                                bbox = metrics.get("design__die__bbox", "N/A")
                                if bbox != "N/A":
                                    parts = bbox.split()
                                    width = float(parts[2]) - float(parts[0])
                                    height = float(parts[3]) - float(parts[1])
                                    tiles[tile_dir.name] = {
                                        "width": width,
                                        "height": height,
                                        "bbox": bbox,
                                        "area": width * height,
                                        "source": f"no_opt/{latest_run.name}",
                                    }
                        except Exception as e:
                            tiles[tile_dir.name] = {"error": str(e)}

# Print results
print("Tile Final Dimensions (from metrics.json):")
print("=" * 100)
print(f"{'Tile Name':<22} {'Width':<15} {'Height':<15} {'Area':<15} {'Source':<20}")
print("-" * 100)
for tile_name in sorted(tiles.keys()):
    if "error" not in tiles[tile_name]:
        width = tiles[tile_name]["width"]
        height = tiles[tile_name]["height"]
        area = tiles[tile_name]["area"]
        source = tiles[tile_name]["source"]
        print(
            f"{tile_name:<22} {width:<15.2f} {height:<15.2f} {area:<15.2f} {source:<20}"
        )
    else:
        print(f"{tile_name:<22} ERROR: {tiles[tile_name]['error']}")

print("\n" + "=" * 100)
print("\nRaw JSON output:")
print(json.dumps(tiles, indent=2))
