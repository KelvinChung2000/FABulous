#!/usr/bin/env python3

r"""
query_generator.py  - pin resolver **v4**
========================================================

Find every instance whose port map connects to the bare pin net (e.g. .A4(LC_O)).

Descend into that instance module definition, treating the port
name on the child side (A4) as the new net name.

Repeat until the net is no longer used to feed any deeper child.

Emit the path we accumulated plus .lastPort:

    Inst_LUT4AB_switch_matrix/inst_cus_mux161_buf_E6BEG0/cus_mux41_buf_inst1.A0
"""

from __future__ import annotations
import argparse
import json
import re
import sys
from collections import defaultdict
from pathlib import Path
from typing import Dict, List, Set, Tuple

## Settings ##

PORT_DELIM = "/"
INST_DELIM = "/"

###############################################################################
# Regex helpers (legal Verilog identifiers)                                   #
###############################################################################

ID_RE  = r"(?:[A-Za-z_][A-Za-z0-9_$]*|\\[^\s]+)"
NET_RE = rf"{ID_RE}(?:\[\d+\])?"

MOD_START = re.compile(fr"^\s*module\s+(?P<name>{ID_RE})\s*(?:#\s*\([^)]*\))?\s*\(")
MOD_END   = re.compile(r"^\s*endmodule\b")
WIRE_DECL = re.compile(r"^\s*(?:wire|reg|input|output|inout)\b([^;]*);")
INST_LINE = re.compile(fr"^\s*(?P<type>{ID_RE})\s+(?P<inst>{ID_RE})\s*\(")
PORT_MAP  = re.compile(fr"\.\s*(?P<port>{ID_RE})\s*\(\s*(?P<net>{NET_RE})\s*\)")

###############################################################################

class Instance:
    __slots__ = ("modtype", "name", "portmap")
    def __init__(self, modtype: str, name: str, portmap: Dict[str, str]):
        self.modtype = modtype
        self.name = name
        self.portmap = portmap

class ModuleDef:
    __slots__ = ("name", "nets", "instances")
    def __init__(self, name: str):
        self.name = name
        self.nets: Set[str] = set()
        self.instances: List[Instance] = []

###############################################################################
# Parsing helpers                                                              #
###############################################################################

def _expand(decl: str) -> List[str]:
    decl = re.sub(r"\[[^]]+\]", "", decl)
    return [t.strip() for t in decl.split(',') if t.strip()]


def parse_verilog(vfiles: List[Path]) -> Dict[str, ModuleDef]:
    mods: Dict[str, ModuleDef] = {}
    for vf in vfiles:
        with vf.open() as fh:
            cur: ModuleDef | None = None
            buf = ""
            collecting = False
            for line in fh:
                if cur is None:
                    m = MOD_START.match(line)
                    if m:
                        cur = ModuleDef(m.group('name'))
                        mods[cur.name] = cur
                        rest = line.split('(', 1)[1]
                        if ');' in rest:
                            cur.nets.update(_expand(rest.split(');', 1)[0]))
                        else:
                            buf = rest
                            collecting = True
                    continue

                if collecting:
                    if ');' in line:
                        buf += line.split(');', 1)[0]
                        cur.nets.update(_expand(buf))
                        collecting = False
                    else:
                        buf += line
                    continue

                if MOD_END.match(line):
                    cur = None
                    continue

                wd = WIRE_DECL.match(line)
                if wd:
                    cur.nets.update(_expand(wd.group(1)))
                    continue

                im = INST_LINE.match(line)
                if im:
                    typ, iname = im.group('type'), im.group('inst')
                    pt = line.split('(', 1)[1]
                    if ');' not in line:
                        for extra in fh:
                            pt += extra
                            if ');' in extra:
                                break
                    portmap = {m.group('port'): m.group('net') for m in PORT_MAP.finditer(pt)}
                    cur.instances.append(Instance(typ, iname, portmap))
    return mods

###############################################################################
# Build instance roots                                                         #
###############################################################################

def build_roots(mods: Dict[str, ModuleDef]) -> List[Tuple[Instance,List[str]]]:
    instantiated = {i.modtype for m in mods.values() for i in m.instances}
    top_modules = set(mods) - instantiated or set(mods)
    roots: List[Tuple[Instance,List[str]]] = []

    def rec(modname: str, path: List[str]):
        mod = mods.get(modname)
        if mod is None:
            return
        for inst in mod.instances:
            obj = Instance(inst.modtype, inst.name, inst.portmap)
            full = path + [inst.name]
            roots.append((obj, full))
            rec(inst.modtype, full)

    for tm in top_modules:
        rec(tm, [])
    return roots

###############################################################################
# Helper: compress consecutive duplicates in a path                            #
###############################################################################

def compress(parts: List[str]) -> List[str]:
    out: List[str] = []
    for p in parts:
        if not out or p != out[-1]:
            out.append(p)
    return out

###############################################################################
# Resolve pins                                                                 #
###############################################################################

def resolve_pin(mods: Dict[str, ModuleDef], roots: List[Tuple[Instance,List[str]]], pin: str, undef_warned: Set[str]) -> Set[str]:
    found: Set[str] = set()
    seen: Set[Tuple[str,str,str]] = set()

    uses: Dict[str, Dict[str, List[Tuple[Instance,str]]]] = defaultdict(lambda: defaultdict(list))
    for mod in mods.values():
        for inst in mod.instances:
            for cp, net in inst.portmap.items():
                uses[mod.name][net].append((inst, cp))

    def dfs(modname: str, net: str, path: List[str]):
        key = (modname, net, INST_DELIM.join(path))
        if key in seen:
            return
        seen.add(key)
        mod = mods.get(modname)
        if mod is None:
            if modname not in undef_warned:
                print(f"[warn] no definition for module '{modname}'", file=sys.stderr)
                undef_warned.add(modname)
            path_str = INST_DELIM.join(compress(path)) + (PORT_DELIM if path else '') + net
            found.add(path_str)
            return
        nexts = uses[modname].get(net, [])
        if not nexts:
            path_str = INST_DELIM.join(compress(path)) + (PORT_DELIM if path else '') + net
            found.add(path_str)
            return
        for inst, cport in nexts:
            dfs(inst.modtype, cport, path + [inst.name])

    for inst, ipath in roots:
        for cp, pnet in inst.portmap.items():
            if pnet == pin:
                dfs(inst.modtype, cp, ipath)   # fixed: ipath (not ipath+[inst.name])
    return found

###############################################################################
# pips helpers                                                                #
###############################################################################

def wire_remap(pip_i: str, p_src: str, p_dest: str) -> Tuple[str,str,str]:
    pattern = r'^([A-Za-z]+)(\d+)([A-Za-z]+)(\d+)$'
    a = re.fullmatch(pattern, p_src)
    b = re.fullmatch(pattern, p_dest)
    
    if bool(a) and bool(b):
        aa = a.groups()
        bb = b.groups()
        if ("END" in aa[2]) and ("BEG" in bb[2]) and aa[3] == bb[3] and aa[1] == bb[1] and aa[0] == bb[0]:  
            if bb[1] == "4":
                p_src_new = f"{aa[0]}{aa[1]}{aa[2]}[{aa[3]}]"
                p_dest_new = f"{bb[0]}{bb[1]}{bb[2]}[{int(bb[3])-4}]"
                print(f"[INFO] remap {p_src}.{p_dest} to {p_src_new}.{p_dest_new}")
                return (pip_i, p_src_new, p_dest_new)
            if bb[1] == "6":
                p_src_new = f"{aa[0]}{aa[1]}{aa[2]}[{aa[3]}]"
                p_dest_new = f"{bb[0]}{bb[1]}{bb[2]}[{int(bb[3])-2}]"
                print(f"[INFO] remap {p_src}.{p_dest} to {p_src_new}.{p_dest_new}")
                return (pip_i, p_src_new, p_dest_new)
    return (pip_i, p_src, p_dest)

def load_pips(p: Path) -> List[Tuple[str,str,str]]:
    out = []
    with p.open() as fh:
        for raw in fh:
            raw = raw.rstrip('\n')
            if not raw or raw.startswith('#'):
                continue
            cols = [c.strip() for c in raw.split(',')]
            if len(cols) < 4:
                continue
            out.append(wire_remap(raw, cols[1], cols[3]))
    return out

###############################################################################
# Main                                                                         #
###############################################################################

def main() -> None:
    ap = argparse.ArgumentParser(description='Resolve bare pins to hierarchical OpenSTA paths')
    ap.add_argument('--nl_hier', type=Path)
    ap.add_argument('--pips', type=Path)
    ap.add_argument('--out', type=Path, default=Path('resolved_pips.txt'))
    args = ap.parse_args()

    vfiles = [args.nl_hier]
    if not vfiles:
        sys.exit(f"error: no Verilog files found!")
    print(f"[info] parsing {len(vfiles)} Verilog files", file=sys.stderr)
    mods = parse_verilog(vfiles)

    roots = build_roots(mods)

    entries = load_pips(args.pips)
    pins = {p for _, a, b in entries for p in (a, b)}

    undef_warned: Set[str] = set()
    pin_paths: Dict[str, List[str]] = {}
    for pin in pins:     
        #### begin: retry with bus-index form e.g. WW4BEG13 --> WW4BEG[13] => wire unroll ####
        paths = sorted(resolve_pin(mods, roots, pin, undef_warned))
        if not paths:
            alt_pin = re.sub(r'\b(\w+?)(\d+)\b', r'\1[\2]', pin)
            paths = sorted(resolve_pin(mods, roots, alt_pin, undef_warned))
            
        pin_paths[pin] = paths
        if not paths:
            print(f"[warn] no hierarchical path resolved for pin '{pin}'", file=sys.stderr)
        #### end: retry with bus-index form e.g. WW4BEG13 --> WW4BEG[13] => wire unroll ####

    with args.out.open('w') as out:
        for raw, a, b in entries:
            out.write(raw + '\n')
            out.write(json.dumps({a: pin_paths.get(a, []), b: pin_paths.get(b, [])}, indent=4) + '\n')
    print(f"[info] wrote {args.out}", file=sys.stderr)
    
    
    path = args.out
    # 1. read the whole file
    text = path.read_text(encoding="utf-8")
    # 2. perform the replacement
    text = text.replace('---', r'\/')     # r'\/' == '\\/'
    # 3. write back to the same file
    path.write_text(text, encoding="utf-8")

if __name__ == '__main__':
    main()
