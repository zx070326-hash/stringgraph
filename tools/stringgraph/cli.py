"""Command-line interface: stringgraph <command>."""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

from .loader import find_project_root, load_graph
from .report import format_report, full_report, search, status_report, to_dot, to_json
from .validate import validate


def main(argv: list[str] | None = None) -> int:
    # Windows consoles default to a legacy code page; graph content is UTF-8 Chinese.
    for stream in (sys.stdout, sys.stderr):
        if hasattr(stream, "reconfigure"):
            try:
                stream.reconfigure(encoding="utf-8")
            except (ValueError, OSError):
                pass
    ap = argparse.ArgumentParser(prog="stringgraph", description="String theory results dependency graph tools")
    ap.add_argument("--root", type=Path, default=None, help="project root (default: auto-detect)")
    sub = ap.add_subparsers(dest="cmd", required=True)

    sub.add_parser("validate", help="validate the whole graph; exit 1 on errors")
    p_status = sub.add_parser("status", help="effective status of one statement")
    p_status.add_argument("id")
    p_status.add_argument("--json", action="store_true")
    p_report = sub.add_parser("report", help="whole-graph report")
    p_report.add_argument("--open", action="store_true", help="only list work items (open props, inferred edges, gaps)")
    p_report.add_argument("--json", action="store_true")
    p_search = sub.add_parser("search", help="keyword search over statements and conventions")
    p_search.add_argument("terms", nargs="+")
    sub.add_parser("dot", help="print Graphviz dot to stdout")

    args = ap.parse_args(argv)
    root = args.root or find_project_root()
    g = load_graph(root)

    if args.cmd == "validate":
        problems = validate(g)
        for p in problems:
            print(p)
        n_err = sum(1 for p in problems if p.severity == "error")
        n_warn = len(problems) - n_err
        print(f"\n{len(g.statements)} statements, {len(g.derivations)} derivations, "
              f"{len(g.milestones)} milestones, {len(g.conventions)} conventions: "
              f"{n_err} errors, {n_warn} warnings")
        return 1 if n_err else 0

    if args.cmd == "status":
        if args.id not in g.statements:
            print(f"unknown statement id: {args.id}", file=sys.stderr)
            return 2
        rep = status_report(g, args.id)
        if args.json:
            print(to_json(rep))
        else:
            for k, v in rep.items():
                print(f"{k}: {', '.join(v) if isinstance(v, list) else v}")
        return 0

    if args.cmd == "report":
        rep = full_report(g, open_only=args.open)
        print(to_json(rep) if args.json else format_report(rep))
        return 0

    if args.cmd == "search":
        hits = search(g, args.terms)
        if not hits:
            print("no matches")
        for score, sid, title in hits:
            print(f"{score:3d}  {sid}  —  {title}")
        return 0

    if args.cmd == "dot":
        print(to_dot(g))
        return 0

    return 2


if __name__ == "__main__":
    raise SystemExit(main())
