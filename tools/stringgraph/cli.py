"""Command-line interface: stringgraph <command>."""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

from .axioms import check_axioms, format_axioms_report
from .loader import find_project_root, load_graph
from .propagate import compute_all
from .report import (
    all_bottleneck_roots,
    bottleneck_roots,
    captain_queue,
    counterfactual_report,
    format_captain_queue,
    format_counterfactual,
    format_hitting_set,
    format_report,
    format_why,
    full_report,
    greedy_root_cover,
    hitting_set_report,
    roots_needed_for_target,
    search,
    status_report,
    to_dot,
    to_json,
    why_report,
)
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

    p_val = sub.add_parser("validate", help="validate the whole graph; exit 1 on errors")
    p_val.add_argument(
        "--hide-history",
        action="store_true",
        help="hide warnings that are expected traces of superseded cards (kind=history), "
             "leaving only live problems",
    )
    p_val.add_argument("--json", action="store_true")
    p_ax = sub.add_parser(
        "check-axioms",
        help="run formal/scripts/check_axioms.lean over every formal.lean_decl; exit 1 on non-standard axioms",
    )
    p_ax.add_argument("--json", action="store_true")
    p_ax.add_argument(
        "--formalized-only",
        action="store_true",
        help="only check declarations that back a `status: formalized` derivation",
    )
    p_ax.add_argument(
        "--decl",
        action="append",
        default=[],
        metavar="NAME",
        help="check only this declaration name (repeatable)",
    )
    p_status = sub.add_parser("status", help="effective status of one statement")
    p_status.add_argument("id")
    p_status.add_argument("--json", action="store_true")
    p_why = sub.add_parser("why", help="explain which chain limits a statement's effective status")
    p_why.add_argument("id")
    p_why.add_argument("--json", action="store_true")
    p_report = sub.add_parser("report", help="whole-graph report")
    p_report.add_argument("--open", action="store_true", help="only list work items (open props, inferred edges, gaps)")
    p_report.add_argument("--json", action="store_true")
    p_search = sub.add_parser("search", help="keyword search over statements and conventions")
    p_search.add_argument("terms", nargs="+")
    p_cq = sub.add_parser(
        "captain-queue",
        help="list items awaiting captain decision: verified-but-unconfirmed research attempts "
             "and milestones whose audit status is not approved",
    )
    p_cq.add_argument("--json", action="store_true")
    sub.add_parser("dot", help="print Graphviz dot to stdout")

    p_roots = sub.add_parser(
        "roots",
        help="bottleneck-root set of one statement: the leaf cards it ultimately cannot "
             "outrank (see docs/LEVERAGE-ANALYSIS.md)",
    )
    p_roots.add_argument("id")
    p_roots.add_argument("--json", action="store_true")

    p_hs = sub.add_parser(
        "hitting-set",
        help="graph-wide bottleneck-root leverage analysis: root-set size stats, self-capping "
             "ratio, and the greedy root-cover curve (docs/LEVERAGE-ANALYSIS.md)",
    )
    p_hs.add_argument(
        "--target",
        type=float,
        default=None,
        metavar="FRACTION",
        help="instead of the full report, print the smallest greedy root set that fully frees "
             "at least this fraction (0-1) of weak cards from their bottleneck roots",
    )
    p_hs.add_argument("--json", action="store_true")

    p_cf = sub.add_parser(
        "counterfactual",
        help="force one or more statements to `rigorous` (definitions: status; propositions: "
             "replace derivations with a dependency-free rigorous proof) and report which other "
             "active cards' effective status moves",
    )
    p_cf.add_argument("ids", nargs="+", metavar="ID")
    p_cf.add_argument("--json", action="store_true")

    args = ap.parse_args(argv)
    root = args.root or find_project_root()
    g = load_graph(root)

    if args.cmd == "validate":
        problems = validate(g)
        n_err = sum(1 for p in problems if p.severity == "error")
        n_warn = len(problems) - n_err
        n_hist = sum(1 for p in problems if p.kind == "history")
        shown = [p for p in problems if not (args.hide_history and p.kind == "history")]
        if args.json:
            print(to_json({
                "problems": [vars(p) for p in shown],
                "counts": {"errors": n_err, "warnings": n_warn, "history": n_hist},
                "statements": len(g.statements),
                "derivations": len(g.derivations),
                "milestones": len(g.milestones),
                "conventions": len(g.conventions),
                "exit_code": 1 if n_err else 0,
            }))
        else:
            for p in shown:
                print(p)
            print(f"\n{len(g.statements)} statements, {len(g.derivations)} derivations, "
                  f"{len(g.milestones)} milestones, {len(g.conventions)} conventions: "
                  f"{n_err} errors, {n_warn} warnings ({n_hist} history)")
        return 1 if n_err else 0

    if args.cmd == "check-axioms":
        rep = check_axioms(g, formalized_only=args.formalized_only, only=args.decl)
        print(to_json(rep) if args.json else format_axioms_report(rep))
        return int(rep["exit_code"])

    if args.cmd == "status":
        if args.id not in g.statements:
            print(f"unknown statement id: {args.id}", file=sys.stderr)
            return 2
        rep = status_report(g, args.id)
        if args.json:
            print(to_json(rep))
        else:
            for k, v in rep.items():
                if k == "derivations":
                    print("derivations:")
                    for d in v:
                        print(f"  {d['id']}  [{d['kind']}] own={d['own']} effective={d['effective']}")
                else:
                    print(f"{k}: {', '.join(v) if isinstance(v, list) else v}")
        return 0

    if args.cmd == "why":
        if args.id not in g.statements:
            print(f"unknown statement id: {args.id}", file=sys.stderr)
            return 2
        tree = why_report(g, args.id)
        print(to_json(tree) if args.json else format_why(tree))
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

    if args.cmd == "captain-queue":
        q = captain_queue(root)
        print(to_json(q) if args.json else format_captain_queue(q))
        return 0

    if args.cmd == "dot":
        print(to_dot(g))
        return 0

    if args.cmd == "roots":
        if args.id not in g.statements:
            print(f"unknown statement id: {args.id}", file=sys.stderr)
            return 2
        effs = compute_all(g)
        rs = sorted(bottleneck_roots(g, args.id, effs))
        if args.json:
            print(to_json({"id": args.id, "roots": rs, "count": len(rs)}))
        else:
            print(f"{args.id}: {len(rs)} bottleneck root(s)")
            for r in rs:
                print(f"  {r}")
        return 0

    if args.cmd == "hitting-set":
        effs = compute_all(g)
        if args.target is None:
            rep = hitting_set_report(g, effs)
            print(to_json(rep) if args.json else format_hitting_set(rep))
        else:
            root_sets = all_bottleneck_roots(g, effs)
            order = greedy_root_cover(root_sets)
            k, roots = roots_needed_for_target(order, len(root_sets), args.target)
            if args.json:
                print(to_json({"target": args.target, "roots_needed": k, "roots": roots}))
            else:
                print(f"target {args.target*100:.0f}% of {len(root_sets)} weak cards -> "
                      f"{k} roots:")
                for r in roots:
                    print(f"  {r}")
        return 0

    if args.cmd == "counterfactual":
        unknown = [i for i in args.ids if i not in g.statements]
        if unknown:
            print(f"unknown statement id(s): {', '.join(unknown)}", file=sys.stderr)
            return 2
        rep = counterfactual_report(g, args.ids)
        print(to_json(rep) if args.json else format_counterfactual(rep))
        return 0

    return 2


if __name__ == "__main__":
    raise SystemExit(main())
