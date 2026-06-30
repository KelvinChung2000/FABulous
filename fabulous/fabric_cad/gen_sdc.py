"""Generate SDC constraints that break combinational loops in switch matrices.

The loop graph combines switch-matrix routing (from a tile's `.list` file,
see `build_graph_from_list_file`) with the tile's BEL combinational arcs (read
from the BEL's parsed netlist `Bel.yosys_json`, see `add_bel_comb_arcs`). A
combinational loop alternates routing and logic, so the BEL arcs are required
for any loop that closes through
a cell (e.g. a LUT feeding its own input). Loops are broken at node granularity
by selecting a small feedback-vertex set (see `select_break_nodes`) and disabling
the driver pin of each chosen net. BEL pins are excluded from that set so a cut
never disables a cell's own combinational arc; loops break on the switch-matrix
and jump-wire feedback instead, which leaves every BEL forward delay analyzable.
The chosen net names are emitted as portable `set_disable_timing` constraints.
"""

from pathlib import Path

import networkx as nx
from jinja2 import Environment, PackageLoader
from loguru import logger

from fabulous.custom_exception import InvalidState
from fabulous.fabric_definition.bel import Bel
from fabulous.fabric_definition.tile import Tile
from fabulous.fabric_definition.yosys_obj import YosysJson, YosysModule
from fabulous.fabric_generator.parser.parse_switchmatrix import parseList
from fabulous.fabulous_settings import get_context

# Yosys cell types whose internal input->output path is sequential (broken by a
# register or memory) and therefore is NOT a combinational timing arc.
_REGISTER_CELL_PREFIXES = (
    "$dff",
    "$adff",
    "$sdff",
    "$dffsr",
    "$dlatch",
    "$adlatch",
    "$sr",
    "$mem",
    "$_DFF",
    "$_SDFF",
    "$_DLATCH",
    "$_SR",
)

# Combinational input->output arcs per BEL module, keyed by module name. A BEL
# type is resolved once; its arcs are reused across every instance.
_bel_comb_arc_cache: dict[str, set[tuple[str, str]]] = {}

# models_pack primitive port directions and sequential flag, keyed by module
# name. Resolved once per process from the project's models_pack.
_models_pack_prim_cache: dict[str, tuple[dict[str, str], bool]] | None = None

_SDC_ENV = Environment(
    loader=PackageLoader("fabulous.fabric_cad", "templates"),
    trim_blocks=True,
    lstrip_blocks=True,
    autoescape=False,
)
_SDC_TEMPLATE = _SDC_ENV.get_template("loop_break.sdc.j2")


# Strongly connected components up to this size are reduced one vertex per round,
# which is near-minimum and exact on the per-tile switch matrices. Larger
# components remove the top `_FVS_BATCH_FRACTION` of vertices per round so the
# whole-fabric graph (one large inter-tile component) stays fast.
_FVS_SINGLE_MAX = 300
_FVS_BATCH_FRACTION = 0.02


def select_break_nodes(graph: nx.DiGraph, protected: set[str]) -> list[str]:
    """Select a feedback-vertex set whose removal makes `graph` acyclic.

    Nodes in `protected` stay in the graph but are never chosen as a cut, so a
    `set_disable_timing` never lands on a cell's own pin.

    Parameters
    ----------
    graph : nx.DiGraph
        Directed connectivity graph. Nodes are net names.
    protected : set[str]
        Net names that must never be chosen as a cut (typically BEL pins). They
        remain in the graph and may still lie on a cycle that is broken elsewhere.

    Returns
    -------
    list[str]
        Sorted list of node names to disable. Empty if `graph` is acyclic.

    Raises
    ------
    InvalidState
        A protected net carries a self-loop, or a strongly connected component
        contains only protected nets, so no loop can be broken without disabling a
        protected pin.
    """
    self_loops = set(nx.nodes_with_selfloops(graph))
    protected_self_loops = self_loops & protected
    if protected_self_loops:
        raise InvalidState(
            f"Protected net(s) {sorted(protected_self_loops)} carry a self-loop; "
            f"cannot break it without disabling a protected pin."
        )
    chosen: set[str] = set(self_loops)
    remaining = graph.copy()
    remaining.remove_nodes_from(chosen)

    work = [
        remaining.subgraph(component).copy()
        for component in nx.strongly_connected_components(remaining)
        if len(component) > 1
    ]
    while work:
        scc = work.pop()
        candidates = [node for node in scc.nodes() if node not in protected]
        if not candidates:
            raise InvalidState(
                f"Strongly connected component of {scc.number_of_nodes()} nets is "
                f"entirely protected; no routing net to break the loop on."
            )
        ranked = sorted(
            candidates,
            key=lambda node: (scc.in_degree(node) * scc.out_degree(node), node),
            reverse=True,
        )
        if scc.number_of_nodes() <= _FVS_SINGLE_MAX:
            count = 1
        else:
            count = max(1, int(scc.number_of_nodes() * _FVS_BATCH_FRACTION))
        victims = ranked[:count]
        chosen.update(victims)
        scc.remove_nodes_from(victims)
        for component in nx.strongly_connected_components(scc):
            if len(component) > 1:
                work.append(scc.subgraph(component).copy())

    return sorted(chosen)


def render_sdc(break_nodes: list[str], scope: str, *, resolved: bool) -> str:
    """Render SDC text that breaks loops by disabling each node's driver pin.

    Emits one `set_disable_timing` constraint per node, in sorted order, using
    the common-denominator syntax accepted by OpenSTA, Cadence Tempus, and
    Synopsys PrimeTime.

    Parameters
    ----------
    break_nodes : list[str]
        Net names whose driver pins should be disabled.
    scope : str
        Human-readable scope label recorded in the header (e.g. `tile LUT4AB`).
    resolved : bool
        Whether `break_nodes` are real synthesized-netlist net names. When
        `False` (names taken from the `.list` files), a warning is added that
        the names are logical and may not match a synthesized netlist.

    Returns
    -------
    str
        The complete SDC file contents.
    """
    return _SDC_TEMPLATE.render(
        scope=scope,
        resolved=resolved,
        break_nodes=sorted(break_nodes),
    )


def build_graph_from_list_file(matrix_path: Path) -> nx.DiGraph:
    """Build a connectivity graph from a switch-matrix `.list` file.

    Parameters
    ----------
    matrix_path : Path
        Path to the `.list` switch-matrix file.

    Returns
    -------
    nx.DiGraph
        Directed graph whose nodes are port names and whose edges run from
        driver to sink.
    """
    graph = nx.DiGraph()
    for sink, source in parseList(matrix_path, collect="pair"):
        graph.add_edge(source, sink)
    return graph


def _models_pack_primitives() -> dict[str, tuple[dict[str, str], bool]]:
    """Return the project's models_pack primitives, keyed by module name.

    Returns
    -------
    dict[str, tuple[dict[str, str], bool]]
        `module_name -> ({port: direction}, is_sequential)`.

    Raises
    ------
    InvalidState
        `models_pack` is not configured.
    """
    global _models_pack_prim_cache
    if _models_pack_prim_cache is not None:
        return _models_pack_prim_cache

    models_pack = get_context().models_pack
    if models_pack is None:
        raise InvalidState(
            "models_pack is not configured; load a fabric project before "
            "exporting loop-break SDC."
        )
    # models_pack is a flat primitive library with no single top, so keep every
    # module instead of letting `hierarchy -auto-top` prune it.
    yosys_json = YosysJson(models_pack, run_hierarchy=False)

    primitives: dict[str, tuple[dict[str, str], bool]] = {}
    for name, module in yosys_json.modules.items():
        directions = {port: detail.direction for port, detail in module.ports.items()}
        sequential = any(
            cell.type.startswith(_REGISTER_CELL_PREFIXES)
            for cell in module.cells.values()
        )
        primitives[name] = (directions, sequential)
    _models_pack_prim_cache = primitives
    return primitives


def _comb_arcs_from_module(
    module: YosysModule, primitives: dict[str, tuple[dict[str, str], bool]]
) -> set[tuple[str, str]]:
    """Extract combinational input->output port arcs from a parsed module.

    Parameters
    ----------
    module : YosysModule
        The parsed netlist module to analyze.
    primitives : dict[str, tuple[dict[str, str], bool]]
        models_pack primitives, `module_name -> ({port: direction}, sequential)`.

    Returns
    -------
    set[tuple[str, str]]
        Combinational `(input_port, output_port)` arcs in module-local names.
    """
    graph = nx.DiGraph()
    for cell in module.cells.values():
        if cell.type in primitives:
            directions, sequential = primitives[cell.type]
            if sequential:
                continue
        else:
            directions = cell.port_directions
            if not directions or cell.type.startswith(_REGISTER_CELL_PREFIXES):
                continue
        input_bits = [
            bit
            for port, bits in cell.connections.items()
            if directions.get(port) == "input"
            for bit in bits
            if isinstance(bit, int)
        ]
        output_bits = [
            bit
            for port, bits in cell.connections.items()
            if directions.get(port) == "output"
            for bit in bits
            if isinstance(bit, int)
        ]
        for source_bit in input_bits:
            for sink_bit in output_bits:
                graph.add_edge(source_bit, sink_bit)

    input_name: dict[int, str] = {}
    output_name: dict[int, str] = {}
    for port, detail in module.ports.items():
        multibit = len(detail.bits) > 1
        for index, bit in enumerate(detail.bits):
            if not isinstance(bit, int):
                continue
            name = f"{port}{index}" if multibit else port
            if detail.direction == "input":
                input_name[bit] = name
            elif detail.direction == "output":
                output_name[bit] = name

    arcs: set[tuple[str, str]] = set()
    for in_bit, in_port in input_name.items():
        reachable = nx.descendants(graph, in_bit) if in_bit in graph else set()
        for out_bit, out_port in output_name.items():
            if out_bit in reachable:
                arcs.add((in_port, out_port))
    return arcs


def _bel_comb_arcs(bel: Bel) -> set[tuple[str, str]]:
    """Return a BEL type's combinational input->output arcs in BEL-local names.

    Parameters
    ----------
    bel : Bel
        The BEL whose combinational arcs are extracted.

    Returns
    -------
    set[tuple[str, str]]
        Combinational `(input_port, output_port)` arcs in BEL-local names.

    Raises
    ------
    InvalidState
        The BEL has no parsed netlist, or its module is missing from it.
    """
    cached = _bel_comb_arc_cache.get(bel.module_name)
    if cached is not None:
        return cached

    if bel.yosys_json is None:
        raise InvalidState(
            f"BEL {bel.name} has no parsed netlist (yosys_json); cannot extract "
            f"combinational arcs."
        )
    module = bel.yosys_json.modules.get(bel.module_name)
    if module is None:
        raise InvalidState(
            f"Module {bel.module_name} not found in the parsed netlist of BEL "
            f"{bel.name}."
        )

    arcs = _comb_arcs_from_module(module, _models_pack_primitives())
    _bel_comb_arc_cache[bel.module_name] = arcs
    return arcs


def add_bel_comb_arcs(graph: nx.DiGraph, tile: Tile) -> None:
    """Add a tile's BEL combinational arcs to `graph` in place.

    Parameters
    ----------
    graph : nx.DiGraph
        Graph to add the arcs to.
    tile : Tile
        Tile whose BELs are analyzed.
    """
    for bel in tile.bels:
        valid_inputs = set(bel.inputs)
        valid_outputs = set(bel.outputs)
        for in_port, out_port in _bel_comb_arcs(bel):
            source = f"{bel.prefix}{in_port}"
            sink = f"{bel.prefix}{out_port}"
            if source in valid_inputs and sink in valid_outputs:
                graph.add_edge(source, sink)


def export_tile_sdc(tile: Tile, out_path: Path) -> Path:
    """Write a loop-break SDC for a single tile.

    The tile graph is the switch-matrix routing graph plus the tile's BEL
    combinational arcs and its intra-tile jump wires (those with zero offset,
    whose `BEG -> END` return path closes loops inside the tile). `tile` must be
    a placed instance from the fabric grid so its `wireList` is populated.

    Parameters
    ----------
    tile : Tile
        Placed tile to analyze.
    out_path : Path
        Destination SDC file path. Parent directories are created.

    Returns
    -------
    Path
        `out_path`.
    """
    graph = build_graph_from_list_file(tile.matrixDir)
    add_bel_comb_arcs(graph, tile)
    for wire in tile.wireList:
        if wire.xOffset == 0 and wire.yOffset == 0:
            graph.add_edge(wire.source, wire.destination)
    # Protect BEL pins so a cut never disables a cell's own combinational arc.
    protected = {pin for bel in tile.bels for pin in (*bel.inputs, *bel.outputs)}
    break_nodes = select_break_nodes(graph, protected)
    text = render_sdc(break_nodes, scope=f"tile {tile.name}", resolved=False)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(text)
    logger.info(f"Wrote loop-break SDC for tile {tile.name} to {out_path}")
    return out_path
