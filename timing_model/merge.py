#!/usr/bin/env python3
import argparse
from pathlib import Path
import sys

def line_has_none_field(line: str, token: str = "NONE") -> bool:
    # Split by commas and check if any field equals token (after stripping spaces/newlines).
    fields = [f.strip() for f in line.rstrip("\n").split(",")]
    return any(f == token for f in fields)

def main():
    ap = argparse.ArgumentParser(
        description="Merge two two query files"
    )
    ap.add_argument("file1", type=Path, help="Primary input (base) file")
    ap.add_argument("file2", type=Path, help="Secondary input (provides replacements)")
    ap.add_argument("-o", "--out", type=Path, default=None, help="Output file (default: stdout)")
    ap.add_argument("--none-token", default="NONE", help='Token to treat as NONE (default: "NONE")')
    args = ap.parse_args()

    try:
        lines1 = args.file1.read_text(encoding="utf-8").splitlines(keepends=True)
    except Exception as e:
        print(f"Error reading {args.file1}: {e}", file=sys.stderr)
        sys.exit(1)

    try:
        lines2 = args.file2.read_text(encoding="utf-8").splitlines(keepends=True)
    except Exception as e:
        print(f"Error reading {args.file2}: {e}", file=sys.stderr)
        sys.exit(1)

    out_lines = []
    for i, l1 in enumerate(lines1):
        if i < len(lines2):
            l2 = lines2[i]
            # Use line2 if it has NO field equal to NONE; else keep line1
            use_l2 = not line_has_none_field(l2, args.none_token)
            out_lines.append(l2 if use_l2 else l1)
        else:
            # file2 shorter: keep line1
            out_lines.append(l1)

    output = "".join(out_lines)
    if args.out:
        try:
            args.out.write_text(output, encoding="utf-8")
        except Exception as e:
            print(f"Error writing {args.out}: {e}", file=sys.stderr)
            sys.exit(1)
    else:
        sys.stdout.write(output)

if __name__ == "__main__":
    main()

