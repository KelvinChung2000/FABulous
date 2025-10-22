#!/usr/bin/env python3
"""Heuristic search for librelane functions that lead to JSON serialization.

This throwaway script will:
- find json-related target functions in the pstats
- for each target, BFS upward through callers to a given max depth
- apply multiple matching heuristics for "librelane" filenames
- aggregate counts and print the top matches

Run from repo root; it reads cprofile/fabulous.pstats by default.
"""

import pstats
from collections import Counter, deque

PSTATS = "cprofile/fabulous.pstats"
MAX_DEPTH = 4
DEPTH_WEIGHT = False  # if True, weight matches by inverse depth

HEURISTICS = [
    "librelane",
    "site-packages/librelane",
    "/nix/store/mgks5hjg",
    "librelane/config",
    "librelane/logging",
    "librelane/steps",
    "librelane/common",
    "librelane/flows",
]


def is_librelane(fname: str):
    fn = fname.replace("\\", "/")
    for h in HEURISTICS:
        if h in fn:
            return True
    return False


def find_json_targets(stats):
    targets = []
    for k in stats.keys():
        fname, lineno, func = k
        fn = fname.replace("\\", "/")
        if "json" in fn or func == "dumps" or "encoder" in fn:
            targets.append(k)
    return targets


def main():
    p = pstats.Stats(PSTATS)
    p.strip_dirs()

    all_targets = find_json_targets(p.stats)
    print(f"Found {len(all_targets)} json-related targets; analysing...")

    lib_counts = Counter()
    file_counts = Counter()

    for target in all_targets:
        # BFS up to MAX_DEPTH
        visited = set()
        q = deque()
        # push immediate callers with depth 1
        callers = p.stats[target][4]
        for caller, vals in callers.items():
            calls = vals[0]
            if calls <= 0:
                continue
            q.append((caller, 1, calls))

        while q:
            node, depth, weight = q.popleft()
            if node in visited:
                continue
            visited.add(node)
            fname = node[0].replace("\\", "/")
            if is_librelane(fname):
                w = weight
                if DEPTH_WEIGHT:
                    w = int(weight / depth) if depth else weight
                lib_counts[node] += w
                file_counts[fname] += w
            # propagate upward
            if depth < MAX_DEPTH and node in p.stats:
                callers2 = p.stats[node][4]
                for caller2, vals2 in callers2.items():
                    calls2 = vals2[0]
                    if calls2 <= 0:
                        continue
                    # conservative propagation
                    q.append((caller2, depth + 1, min(weight, calls2)))

    print("\nTop librelane functions (heuristic):")
    for (fname, lineno, func), cnt in lib_counts.most_common(50):
        print(f"{cnt:10d} {fname}:{lineno}({func})")

    print("\nTop librelane files (aggregated):")
    for fname, cnt in file_counts.most_common(30):
        print(f"{cnt:10d} {fname}")


if __name__ == "__main__":
    main()
