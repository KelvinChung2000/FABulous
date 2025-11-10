#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path
from collections import OrderedDict

# ---------------- Comments stripping ----------------
RE_BLOCK_COMMENT = re.compile(r"/\*.*?\*/", re.S)
RE_LINE_COMMENT  = re.compile(r"//.*?$", re.M)

def strip_comments(text: str) -> str:
    text = RE_BLOCK_COMMENT.sub("", text)
    text = RE_LINE_COMMENT.sub("", text)
    return text

# ---------------- Netlist parsing -------------------
# Very permissive instance matcher:
RE_INSTANCE = re.compile(
    r"""
    (?P<type>\b[a-zA-Z_][\w$]*\b)       # cell type
    \s+
    (?P<inst>\\?[^\s(;)]+)              # instance name (supports escaped identifiers)
    \s*
    \(
        (?P<ports>.*?)                  # everything inside parentheses
    \)
    \s*;
    """,
    re.S | re.X,
)

# .PIN(ARG) connections
RE_PORT_CONN = re.compile(
    r"""
    \.
    (?P<pin>[a-zA-Z_][\w$]*)
    \s*\(
        (?P<arg>[^()]+?)
    \)
    """,
    re.X,
)

# Identifiers inside ARG
RE_IDENT = re.compile(
    r"""
    (\\[^ \t\r\n)]+)                 # escaped identifier (ends at space or ')')
    |
    ([a-zA-Z_][\w$]*(?:\[\d+\])?)    # normal ident, optional bit-select
    """,
    re.X,
)

def normalize_ident(s: str) -> str:
    return s.rstrip()

def index_netlist(netlist_text: str):
    """Return list of (inst, pin, arg_raw) for every .PIN(ARG) connection."""
    nl = strip_comments(netlist_text)
    conns = []
    for mi in RE_INSTANCE.finditer(nl):
        inst = mi.group("inst").strip()
        ports = mi.group("ports")
        for mp in RE_PORT_CONN.finditer(ports):
            pin = mp.group("pin")
            arg = mp.group("arg").strip()
            conns.append((inst, pin, arg))
    return conns

# ---------------- Name variants ---------------------
def name_variants(name: str):
    """Return exact name and bracket variant if trailing digits exist: JW2END3 -> {JW2END3, JW2END[3]}"""
    vs = {name}
    m = re.match(r"^(.*?)(\d+)$", name)
    if m:
        vs.add(f"{m.group(1)}[{m.group(2)}]")
    return vs

# ---------------- Matching --------------------------
def arg_contains_token(arg: str, targets: set) -> bool:
    """Identifier-token match in ARG."""
    for m in RE_IDENT.finditer(arg):
        tok = normalize_ident(m.group(0))
        if tok in targets:
            return True
        if tok.startswith("\\") and tok[1:] in targets:
            return True
    return False

def field_contains_substring(field: str, variants: set) -> bool:
    """Substring match in any field (inst/pin/arg)."""
    if not field:
        return False
    deesc = field[1:] if field.startswith("\\") else None
    for v in variants:
        if v in field:
            return True
        if deesc and v in deesc:
            return True
    return False

def collect_hits(conns, targets_map):
    """
    targets_map: {canonical_name: set(variants)}
    Returns {canonical_name: set('inst/pin')}
    """
    hits = {name: set() for name in targets_map}
    for inst, pin, arg in conns:
        for name, variants in targets_map.items():
            token_hit = arg_contains_token(arg, variants)
            substr_hit = (
                field_contains_substring(inst, variants) or
                field_contains_substring(pin,  variants) or
                field_contains_substring(arg,  variants)
            )
            if token_hit or substr_hit:
                hits[name].add(f"{inst}/{pin}")
    return hits

# ---------------- wire_remap ------------------------
_NAME_RE = re.compile(r'^([A-Za-z]+)(\d+)([A-Za-z]+)(\d+)$')
_BRKT_RE = re.compile(r'^([A-Za-z]+)(\d+)([A-Za-z]+)\[(\d+)\]$')

def _split_name(name: str):
    """
    Split 'JW2END3' or 'JW2END[3]' -> (alpha1, num1, alpha2, num2, is_bracketed) or None.
    """
    m = _NAME_RE.fullmatch(name)
    if m:
        a1, n1, a2, n2 = m.groups()
        return a1, n1, a2, n2, False
    m = _BRKT_RE.fullmatch(name)
    if m:
        a1, n1, a2, n2 = m.groups()
        return a1, n1, a2, n2, True
    return None

def _fmt_bracket(a1, n1, a2, n2) -> str:
    return f"{a1}{n1}{a2}[{n2}]"

def wire_remap(pip_i: str,
               p_src: str,
               p_dest: str,
               width_offsets: dict) -> tuple:
    """
    Try to remap ENDx -> BEGy into bracketed form with index shift on BEG.
    width_offsets: e.g., {4: -4, 6: -2}
    Returns (pip_i, src_used, dest_used, remapped_pair_or_None)
    """
    A = _split_name(p_src)
    B = _split_name(p_dest)
    if not A or not B:
        return (pip_i, p_src, p_dest, None)

    a1, n1, a2, n2, _ = A
    b1, m1, b2, m2, _ = B

    if ("END" in a2) and ("BEG" in b2) and (a1 == b1) and (n1 == m1) and (n2 == m2):
        try:
            width = int(m1)
        except ValueError:
            width = None
        if width in width_offsets:
            dest_idx_new = int(m2) + width_offsets[width]
            src_new  = _fmt_bracket(a1, n1, a2, n2)              # bracketize END
            dest_new = _fmt_bracket(b1, m1, b2, str(dest_idx_new))  # bracketize BEG with shift
            print(f"[INFO] remap {p_src}.{p_dest} -> {src_new}.{dest_new}")
            return (pip_i, src_new, dest_new, (src_new, dest_new))

    return (pip_i, p_src, p_dest, None)

# ---------------- Driver ---------------------------
def parse_width_offsets(s: str) -> dict:
    """
    Parse '4:-4,6:-2' -> {4:-4, 6:-2}
    """
    out = {}
    if not s:
        return out
    for item in s.split(","):
        item = item.strip()
        if not item:
            continue
        k, v = item.split(":")
        out[int(k.strip())] = int(v.strip())
    return out

def variants_union(*names):
    s = set()
    for nm in names:
        if nm:
            s |= name_variants(nm)
    return s

def process(pips_path: Path, netlist_path: Path, out_path: Path,
            apply_remap: bool, width_offsets: dict):
    pips_lines = [ln.rstrip("\n") for ln in pips_path.read_text(encoding="utf-8").splitlines()]
    netlist_text = netlist_path.read_text(encoding="utf-8", errors="ignore")
    conns = index_netlist(netlist_text)

    with out_path.open("w", encoding="utf-8") as fout:
        for ln in pips_lines:
            if not ln or ln.lstrip().startswith("#"):
                continue
            parts = [p.strip() for p in ln.split(",")]
            if len(parts) < 6:
                fout.write(ln + "\n")
                fout.write(json.dumps({"_warning": "Malformed PIP line (expected 6+ CSV fields)"}, indent=4))
                fout.write("\n")
                continue

            netA = parts[1]
            netB = parts[3]

            if apply_remap:
                _, netA_used, netB_used, _rem = wire_remap(ln, netA, netB, width_offsets)
            else:
                netA_used, netB_used = netA, netB

            # Build search targets including original and (if different) remapped forms
            targets_map = {
                netA: variants_union(netA, netA_used),
                netB: variants_union(netB, netB_used),
            }

            hits = collect_hits(conns, targets_map)

            # Deterministic, sorted output (keys = original names, like your example)
            obj = OrderedDict()
            for key in (netA, netB):
                obj[key] = sorted(hits.get(key, []))

            fout.write(ln + "\n")
            fout.write(json.dumps(obj, indent=4))
            fout.write("\n")

# ---------------- CLI ------------------------------
def main():
    ap = argparse.ArgumentParser(
        description="Find instance/pin occurrences for PIPs in a flat Verilog netlist "
                    "(identifier + substring matches, bracket variants, optional wire remap).")
    ap.add_argument("--nl", "--netlist", dest="netlist", type=Path, required=True,
                    help="Flat Verilog netlist (e.g., LUT4AB.nl.v)")
    ap.add_argument("--pips", dest="pips", type=Path, required=True,
                    help="pips.txt (CSV lines)")
    ap.add_argument("--out", dest="out", type=Path, required=True,
                    help="Output report file")
    ap.add_argument("--no-remap", dest="no_remap", action="store_true",
                    help="Disable wire remapping (use raw names only)")
    ap.add_argument("--remap-spec", dest="remap_spec", default="4:-4,6:-2",
                    help="Width:offset comma-list for BEG index shift (default: 4:-4,6:-2)")
    args = ap.parse_args()

    apply_remap = not args.no_remap
    width_offsets = parse_width_offsets(args.remap_spec)

    process(args.pips, args.netlist, args.out, apply_remap, width_offsets)

if __name__ == "__main__":
    main()

