#!/usr/bin/env python3
"""
parse_pips.py - convert the pips-JSON file into a Tcl dict

USAGE
    python parse_pips.py  pips_raw.txt  >  pips_q.tcl
"""

import json, sys
from collections import OrderedDict

# ----------------------------------------------------------------------
def build_tcl(entries):
    """entries = [(key-string, OrderedDict(JSON)), ...]  ->  Tcl 'dict create ...'"""
    out = ['set pips_q [dict create \\']
    for n, (key, groups) in enumerate(entries):
        # one Tcl sub-list per JSON key, preserving the original order
        sublists = ['{' + ' '.join(f'"{item}"' for item in lst) + '}'
                    for lst in groups.values()]
        value = '{' + ' '.join(sublists) + '}'
        backslash = ' \\' if n < len(entries) - 1 else ''
        out.append(f'"{key}" {value}{backslash}')
    out.append(']')
    return '\n'.join(out)

# ----------------------------------------------------------------------
def parse_blocks(path):
    """Yield (header-line, OrderedDict(parsed-JSON)) pairs from the file"""
    entries, lines = [], open(path, encoding='utf-8').read().splitlines()
    i = 0
    while i < len(lines):
        header = lines[i].strip()
        if not header:                                   # skip blank lines
            i += 1;  continue
        if header.startswith('{'):
            sys.exit(f'Unexpected JSON at line {i+1}')
        i += 1                                           # now at first line of JSON
        brace = 0
        j = i
        while j < len(lines):
            brace += lines[j].count('{') - lines[j].count('}')
            j += 1
            if brace == 0:                               # JSON block closed
                break
        json_text = '\n'.join(lines[i:j])
        data = json.loads(json_text, object_pairs_hook=OrderedDict)
        entries.append((header, data))
        i = j                                            # continue after JSON
    return entries

# ----------------------------------------------------------------------
if __name__ == '__main__':
    if len(sys.argv) != 2:
        sys.exit('Usage:  parse_pips.py  <inputfile>')
    print(build_tcl(parse_blocks(sys.argv[1])))
