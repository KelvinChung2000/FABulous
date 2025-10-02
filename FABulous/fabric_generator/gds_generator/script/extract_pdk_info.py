#!/usr/bin/env python3
"""
Script to extract PDK information from LEF files using OpenROAD's ODB API.

This script reads LEF files and extracts key PDK statistics including:
- Site information (row height, width, classes)
- Technology information (units, layers, vias)
- Library information
- Row patterns and orientations
"""

import sys
from dataclasses import dataclass
from pathlib import Path

import odb


@dataclass
class SiteInfo:
    """Information about a placement site."""

    name: str
    width: int  # in database units
    height: int  # in database units
    width_microns: float
    height_microns: float
    site_class: str
    symmetry_x: bool
    symmetry_y: bool
    symmetry_r90: bool
    has_row_pattern: bool
    row_pattern_count: int


@dataclass
class TechInfo:
    """Technology information from LEF."""

    name: str
    lef_version: str
    lef_units: int  # database units per micron
    manufacturing_grid: int
    num_layers: int
    num_routing_layers: int
    num_vias: int
    layer_names: list[str]
    via_names: list[str]


@dataclass
class LibraryInfo:
    """Library information."""

    name: str
    num_sites: int
    num_masters: int
    hierarchy_delimiter: str
    bus_delimiters: tuple[str, str]


@dataclass
class PDKStats:
    """Complete PDK statistics."""

    tech_info: TechInfo
    library_info: LibraryInfo | None
    sites: list[SiteInfo]
    min_row_height: int | None
    max_row_height: int | None
    common_row_heights: list[int]


def microns_to_dbu(microns: float, dbu_per_micron: int) -> int:
    """Convert microns to database units."""
    return int(microns * dbu_per_micron)


def dbu_to_microns(dbu: int, dbu_per_micron: int) -> float:
    """Convert database units to microns."""
    return dbu / dbu_per_micron


def extract_site_info(site: odb.dbSite, dbu_per_micron: int) -> SiteInfo:
    """Extract information from a single site."""
    width_dbu = site.getWidth()
    height_dbu = site.getHeight()

    return SiteInfo(
        name=site.getName(),
        width=width_dbu,
        height=height_dbu,
        width_microns=dbu_to_microns(width_dbu, dbu_per_micron),
        height_microns=dbu_to_microns(height_dbu, dbu_per_micron),
        site_class=str(site.getClass()),
        symmetry_x=site.getSymmetryX(),
        symmetry_y=site.getSymmetryY(),
        symmetry_r90=site.getSymmetryR90(),
        has_row_pattern=site.hasRowPattern(),
        row_pattern_count=len(site.getRowPattern()) if site.hasRowPattern() else 0,
    )


def extract_tech_info(tech: odb.dbTech) -> TechInfo:
    """Extract technology information."""
    # Get layers
    layers = tech.getLayers()
    layer_names = []
    for layer in layers:
        layer_names.append(layer.getName())

    # Get vias
    vias = tech.getVias()
    via_names = []
    for via in vias:
        via_names.append(via.getName())

    return TechInfo(
        name=tech.getName(),
        lef_version=tech.getLefVersionStr(),
        lef_units=tech.getLefUnits(),
        manufacturing_grid=tech.getManufacturingGrid()
        if tech.hasManufacturingGrid()
        else 0,
        num_layers=tech.getLayerCount(),
        num_routing_layers=tech.getRoutingLayerCount(),
        num_vias=tech.getViaCount(),
        layer_names=layer_names,
        via_names=via_names,
    )


def extract_library_info(lib: odb.dbLib) -> LibraryInfo:
    """Extract library information."""
    # Get sites
    sites = lib.getSites()
    num_sites = len(sites)

    # Get masters (standard cells)
    masters = lib.getMasters()
    num_masters = len(masters)

    # Get delimiters
    hierarchy_delim = lib.getHierarchyDelimiter()
    bus_left, bus_right = lib.getBusDelimiters()

    return LibraryInfo(
        name=lib.getName(),
        num_sites=num_sites,
        num_masters=num_masters,
        hierarchy_delimiter=chr(hierarchy_delim) if hierarchy_delim != 0 else "",
        bus_delimiters=(
            chr(bus_left) if bus_left != 0 else "",
            chr(bus_right) if bus_right != 0 else "",
        ),
    )


def analyze_row_heights(
    sites: list[SiteInfo],
) -> tuple[int | None, int | None, list[int]]:
    """Analyze row heights to find min, max, and common heights."""
    if not sites:
        return None, None, []

    heights = [site.height for site in sites]
    height_counts = {}

    for height in heights:
        height_counts[height] = height_counts.get(height, 0) + 1

    # Sort by frequency (most common first)
    common_heights = sorted(
        height_counts.keys(), key=lambda h: height_counts[h], reverse=True
    )

    return min(heights), max(heights), common_heights


def extract_pdk_info(lef_file_path: str) -> PDKStats:
    """Extract PDK information from LEF file."""
    if not Path(lef_file_path).exists():
        raise FileNotFoundError(f"LEF file not found: {lef_file_path}")

    # Create database and read LEF
    print(f"Reading LEF file: {lef_file_path}")
    db = odb.dbDatabase_create()

    try:
        # Read LEF file - this creates both tech and library if present
        lib = odb.read_lef(db, lef_file_path)
        if not lib:
            raise RuntimeError(f"Failed to read LEF file: {lef_file_path}")

        tech = db.getTech()
        if not tech:
            raise RuntimeError("No technology information found in LEF file")

        print(f"Successfully loaded technology: {tech.getName()}")
        print(f"Library: {lib.getName()}")

        # Extract technology information
        tech_info = extract_tech_info(tech)
        print(f"LEF Units: {tech_info.lef_units} DBU per micron")

        # Extract library information
        library_info = extract_library_info(lib)

        # Extract site information
        sites_list = []
        sites = lib.getSites()
        print(f"Found {len(sites)} sites:")

        for site in sites:
            site_info = extract_site_info(site, tech_info.lef_units)
            sites_list.append(site_info)
            print(
                f"  - {site_info.name}: {site_info.width_microns:.3f} x {site_info.height_microns:.3f} µm "
                f"({site_info.width} x {site_info.height} DBU) [{site_info.site_class}]"
            )

        # Analyze row heights
        min_height, max_height, common_heights = analyze_row_heights(sites_list)

        return PDKStats(
            tech_info=tech_info,
            library_info=library_info,
            sites=sites_list,
            min_row_height=min_height,
            max_row_height=max_height,
            common_row_heights=common_heights,
        )

    except Exception as e:
        print(f"Error processing LEF file: {e}")
        raise
    finally:
        # Clean up database
        odb.dbDatabase_destroy(db)


def print_pdk_stats(stats: PDKStats) -> None:
    """Print formatted PDK statistics."""
    print("\n" + "=" * 60)
    print("PDK STATISTICS SUMMARY")
    print("=" * 60)

    # Technology Info
    print("\nTECHNOLOGY INFORMATION:")
    print(f"  Name: {stats.tech_info.name}")
    print(f"  LEF Version: {stats.tech_info.lef_version}")
    print(f"  Units: {stats.tech_info.lef_units} DBU per micron")
    print(f"  Manufacturing Grid: {stats.tech_info.manufacturing_grid} DBU")
    print(f"  Total Layers: {stats.tech_info.num_layers}")
    print(f"  Routing Layers: {stats.tech_info.num_routing_layers}")
    print(f"  Technology Vias: {stats.tech_info.num_vias}")

    # Library Info
    if stats.library_info:
        print("\nLIBRARY INFORMATION:")
        print(f"  Name: {stats.library_info.name}")
        print(f"  Sites: {stats.library_info.num_sites}")
        print(f"  Standard Cells: {stats.library_info.num_masters}")
        if stats.library_info.hierarchy_delimiter:
            print(f"  Hierarchy Delimiter: '{stats.library_info.hierarchy_delimiter}'")
        if any(stats.library_info.bus_delimiters):
            print(
                f"  Bus Delimiters: '{stats.library_info.bus_delimiters[0]}' ... '{stats.library_info.bus_delimiters[1]}'"
            )

    # Site Information
    print("\nSITE INFORMATION:")
    print(f"  Total Sites: {len(stats.sites)}")

    if stats.min_row_height and stats.max_row_height:
        min_height_um = dbu_to_microns(stats.min_row_height, stats.tech_info.lef_units)
        max_height_um = dbu_to_microns(stats.max_row_height, stats.tech_info.lef_units)
        print(f"  Row Height Range: {min_height_um:.3f} - {max_height_um:.3f} µm")
        print(
            f"                    ({stats.min_row_height} - {stats.max_row_height} DBU)"
        )

    if stats.common_row_heights:
        print("  Common Row Heights:")
        for height in stats.common_row_heights[:5]:  # Show top 5
            height_um = dbu_to_microns(height, stats.tech_info.lef_units)
            count = sum(1 for site in stats.sites if site.height == height)
            print(f"    {height_um:.3f} µm ({height} DBU) - {count} sites")

    # Detailed site breakdown
    print("\nDETAILED SITE BREAKDOWN:")
    for site in stats.sites:
        symmetries = []
        if site.symmetry_x:
            symmetries.append("X")
        if site.symmetry_y:
            symmetries.append("Y")
        if site.symmetry_r90:
            symmetries.append("R90")
        sym_str = ",".join(symmetries) if symmetries else "None"

        print(
            f"  {site.name:20s} | {site.width_microns:6.3f} x {site.height_microns:6.3f} µm | "
            f"{site.site_class:8s} | Sym: {sym_str:8s} | "
            f"Pattern: {'Yes' if site.has_row_pattern else 'No'}"
        )

    # Layer names (first 10)
    if stats.tech_info.layer_names:
        print(f"\nLAYERS (showing first 10 of {len(stats.tech_info.layer_names)}):")
        for i, layer in enumerate(stats.tech_info.layer_names[:10]):
            print(f"  {i + 1:2d}. {layer}")
        if len(stats.tech_info.layer_names) > 10:
            print(f"  ... and {len(stats.tech_info.layer_names) - 10} more")

    print("\n" + "=" * 60)


def main():
    """Main function."""
    if len(sys.argv) != 2:
        print("Usage: python extract_pdk_info.py <lef_file>")
        print("\nExample: python extract_pdk_info.py technology.lef")
        sys.exit(1)

    lef_file = sys.argv[1]

    try:
        # Extract PDK information
        pdk_stats = extract_pdk_info(lef_file)

        # Print results
        print_pdk_stats(pdk_stats)

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
