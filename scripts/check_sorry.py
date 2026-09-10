"""Fail if any given Lean file contains `sorry` outside of comments.

Usage: python scripts/check_sorry.py file1.lean file2.lean ...
Exit 1 and print offending file:line on failure. Strips `--` line comments and
`/- ... -/` block comments (including nested `/-! ... -/` docstrings) first.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

BLOCK = re.compile(r"/-.*?-/", re.DOTALL)
LINE = re.compile(r"--[^\n]*")
SORRY = re.compile(r"\bsorry\b")


def strip_comments(src: str) -> str:
    # Replace comments with same number of newlines so line numbers survive.
    def keep_newlines(m: re.Match[str]) -> str:
        return "\n" * m.group(0).count("\n")

    src = BLOCK.sub(keep_newlines, src)
    src = LINE.sub("", src)
    return src


def main(paths: list[str]) -> int:
    bad = 0
    for p in paths:
        path = Path(p)
        if not path.exists():
            continue  # deleted in this commit
        code = strip_comments(path.read_text(encoding="utf-8"))
        for i, line in enumerate(code.splitlines(), 1):
            if SORRY.search(line):
                print(f"{p}:{i}: sorry", file=sys.stderr)
                bad += 1
    if bad:
        print(f"[check_sorry] refusing: {bad} sorry occurrence(s) outside comments", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
