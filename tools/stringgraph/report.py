"""Reports, search, and Graphviz export."""
from __future__ import annotations

import json
from collections import Counter
from dataclasses import replace

from .model import LEVEL, Derivation, Graph
from .propagate import Propagator, Effective, compute_all

_COLORS = {
    "formalized": "#2e7d32",
    "rigorous": "#43a047",
    "physical-argument": "#fbc02d",
    "conjecture": "#fb8c00",
    "speculation": "#e53935",
    "refuted": "#6d4c41",
    "open": "#9e9e9e",
}


def status_report(g: Graph, sid: str) -> dict:
    eff = compute_all(g)[sid]
    st = g.statements[sid]
    return {
        "id": sid,
        "kind": st.kind,
        "title": st.title,
        "own_status": st.status if st.kind != "proposition" else _own_prop_status(g, sid),
        "effective": eff.name,
        "best_derivation": eff.best_derivation,
        "assumes": sorted(eff.assumes),
        "conjectures_depended_on": sorted(eff.conjectures),
        # Per-derivation view: own status vs. effective level after dependencies.
        # `own_status` above is the max over derivations and can read as "already rigorous"
        # when the rigorous derivation is in fact throttled by an open dependency.
        "derivations": [
            {"id": d.id, "kind": d.kind, "own": d.status,
             "effective": Propagator(g)._derivation(d).name}
            for d in g.derivations_for(sid)
        ] if st.kind == "proposition" else [],
    }


def why_report(g: Graph, sid: str, _effs: dict[str, Effective] | None = None, _seen: set[str] | None = None) -> dict:
    """Explain why `sid` has its effective status: follow the best derivation and
    report which own status / dependency is the bottleneck, recursively.

    Returns a tree {id, kind, effective, own, bottleneck: str, via: derivation id|None,
    children: [subtree for each dep whose effective level == this level]}.
    """
    effs = _effs if _effs is not None else compute_all(g)
    seen = _seen if _seen is not None else set()
    st = g.statements[sid]
    eff = effs[sid]
    node: dict = {"id": sid, "kind": st.kind, "effective": eff.name, "via": None, "own": None,
                  "bottleneck": "", "children": []}
    if sid in seen:
        node["bottleneck"] = "(already shown above)"
        return node
    seen.add(sid)

    if st.kind == "proposition":
        d = g.derivations.get(eff.best_derivation) if eff.best_derivation else None
        if d is None:
            node["bottleneck"] = "no derivation" if eff.name == "open" else "refuted"
            return node
        node["via"] = d.id
        node["own"] = d.status
        dep_ids = [x.id for x in d.depends_on if x.id in g.statements]
    else:
        node["own"] = st.status or "physical-argument"
        dep_ids = [u for u in st.uses if u in g.statements]

    own_level = LEVEL.get(node["own"], LEVEL["speculation"])
    weak = [u for u in dep_ids if effs[u].level <= eff.level]
    if own_level <= eff.level and not weak:
        node["bottleneck"] = f"own status {node['own']}"
    elif own_level <= eff.level:
        node["bottleneck"] = f"own status {node['own']} and {len(weak)} dep(s)"
    else:
        node["bottleneck"] = f"own status {node['own']}; limited by {len(weak)} dep(s)"
    node["children"] = [why_report(g, u, effs, seen) for u in weak]
    return node


def format_why(tree: dict, indent: int = 0) -> str:
    pad = "  " * indent
    via = f"  via {tree['via']}" if tree.get("via") else ""
    lines = [f"{pad}{tree['id']} [{tree['effective']}]{via}", f"{pad}  ↳ {tree['bottleneck']}"]
    for c in tree["children"]:
        lines.append(format_why(c, indent + 1))
    return "\n".join(lines)


def weak_active_ids(g: Graph, effs: dict[str, Effective]) -> list[str]:
    """Active (not superseded) statements whose effective level is below `rigorous`.

    This is the "弱卡" universe the leverage analysis (`docs/LEVERAGE-ANALYSIS.md`) operates
    over: superseded cards are excluded (they are not work items, see `full_report`'s
    `open_propositions`), and `refuted` counts as weak (level 0 < rigorous).
    """
    return sorted(
        sid for sid, st in g.statements.items()
        if not st.superseded_by and effs[sid].level < LEVEL["rigorous"]
    )


def bottleneck_roots(g: Graph, sid: str, effs: dict[str, Effective], seen: set[str] | None = None) -> set[str]:
    """Recursively follow `sid`'s best-derivation (or `uses`) chain into whichever dependencies
    are themselves at or below `sid`'s own effective level, stopping at nodes with no such
    "weak" dependency. The leaves collected this way are `sid`'s bottleneck roots: the cards
    that, if none of them ever improve, are the ultimate reason `sid` cannot reach `rigorous`.

    Same recursive shape as `why_report`'s descent into `weak` children, but returns the leaf
    set instead of a tree, and only descends into dependencies that are themselves statements
    (conventions never gate anything here, matching `propagate.py`'s `_combine_deps`).

    Caveat (see docs/LEVERAGE-ANALYSIS.md "the missing card"): a `refutation` derivation whose
    own computed level reaches `physical-argument` forces the *target's* effective level to
    `refuted` regardless of the ordinary `min(own, deps)` formula (`propagate.py`,
    `_proposition`). This function still terminates correctly on such targets (any dependency
    of the refutation is compared against the *overridden* `refuted` level, so a
    convention-only or dependency-free refutation always comes back with no weak deps and
    reports itself as the root), but the "own status" reasoning `why_report` prints in its
    `bottleneck` text does not apply the same way to a refuted node's own status field.
    """
    if seen is None:
        seen = set()
    if sid in seen or sid not in g.statements:
        return set()
    seen.add(sid)
    st, eff = g.statements[sid], effs[sid]
    if st.kind == "proposition":
        d = g.derivations.get(eff.best_derivation) if eff.best_derivation else None
        if d is None:
            return {sid}
        dep_ids = [x.id for x in d.depends_on if x.id in g.statements]
    else:
        dep_ids = [u for u in st.uses if u in g.statements]
    weak = [u for u in dep_ids if effs[u].level <= eff.level]
    if not weak:
        return {sid}
    out: set[str] = set()
    for u in weak:
        out |= bottleneck_roots(g, u, effs, seen)
    return out or {sid}


def all_bottleneck_roots(g: Graph, effs: dict[str, Effective] | None = None) -> dict[str, set[str]]:
    """`{weak card id: its bottleneck-root set}` for every active card below `rigorous`."""
    effs = effs if effs is not None else compute_all(g)
    return {sid: bottleneck_roots(g, sid, effs) for sid in weak_active_ids(g, effs)}


def is_self_capped(g: Graph, sid: str, effs: dict[str, Effective]) -> bool:
    """True if `sid`'s own status is (one of) the bottleneck(s) for its effective level, as
    opposed to being capped purely by an upstream dependency.

    For the ordinary `eff = min(own, deps_floor)` formula, `eff <= own` always, so `own ==
    eff` exactly captures "own is at least tied for the tightest constraint" (`why_report`
    checks the same `own_level <= eff.level` condition to decide whether to print "own status
    X" in its bottleneck text). Two edge cases fall outside that formula and are treated as
    self-capped rather than silently mis-classified:

    - no derivation at all (`open`): there is no upstream dependency to blame either.
    - the winning derivation carries no statement-level dependency (e.g. a `refutation` whose
      only `depends_on` is a convention): `propagate.py`'s refutation override forces the
      target's effective level to `refuted` independently of `min(own, deps)`, so `own_level ==
      eff.level` need not hold even though nothing upstream is responsible. See
      docs/LEVERAGE-ANALYSIS.md for the one graph card (`swampland.wgc-sharp-form-i`) this
      matters for.
    """
    st = g.statements[sid]
    eff = effs[sid]
    if st.kind == "proposition":
        d = g.derivations.get(eff.best_derivation) if eff.best_derivation else None
        if d is None:
            return True
        dep_ids = [x.id for x in d.depends_on if x.id in g.statements]
        if not dep_ids:
            return True
        own_level = LEVEL.get(d.status, LEVEL["speculation"])
    else:
        dep_ids = [u for u in st.uses if u in g.statements]
        own_level = LEVEL.get(st.status or "", LEVEL["physical-argument"])
        if not dep_ids:
            return True
    return own_level <= eff.level


def greedy_root_cover(root_sets: dict[str, set[str]]) -> list[tuple[str, int, int]]:
    """Greedy order to force bottleneck roots so that weak cards become fully free of them.

    A weak card is "resolved" once *every* root in its `bottleneck_roots` set has been picked
    (forcing only some of a card's roots need not raise its effective level -- see
    docs/LEVERAGE-ANALYSIS.md for why an adaptive "maximize newly-resolved" greedy does not
    reproduce this ordering as cleanly as the simpler rule used here). Roots are ranked once, by
    how many weak cards' root sets contain them (ties broken by root id), and then applied in
    that fixed order; a card counts as resolved the first time the accumulated prefix of picked
    roots is a superset of its own root set.

    Returns `[(root_id, newly_resolved_count, cumulative_resolved_count), ...]` in pick order,
    covering every root that appears in at least one weak card's root set.
    """
    freq: dict[str, int] = {}
    for roots in root_sets.values():
        for r in roots:
            freq[r] = freq.get(r, 0) + 1
    order = sorted(freq, key=lambda r: (-freq[r], r))

    selected: set[str] = set()
    resolved: set[str] = set()
    out: list[tuple[str, int, int]] = []
    for r in order:
        selected.add(r)
        newly = [cid for cid, roots in root_sets.items() if cid not in resolved and roots <= selected]
        resolved.update(newly)
        out.append((r, len(newly), len(resolved)))
    return out


def hitting_set_report(g: Graph, effs: dict[str, Effective] | None = None) -> dict:
    """Full leverage-analysis bundle: root-set size stats, self-capping ratio, and the greedy
    root-cover curve, overall and broken down by area. Every number in
    docs/LEVERAGE-ANALYSIS.md's headline table is one of these fields or derived from them."""
    effs = effs if effs is not None else compute_all(g)
    active = [sid for sid, st in g.statements.items() if not st.superseded_by]
    weak = weak_active_ids(g, effs)
    root_sets = all_bottleneck_roots(g, effs)
    all_roots: set[str] = set()
    for r in root_sets.values():
        all_roots |= r
    sizes = sorted(len(r) for r in root_sets.values())

    def _area(sid: str) -> str:
        return sid.split(".", 1)[0]

    by_area_sizes: dict[str, list[int]] = {}
    by_area_self: dict[str, list[bool]] = {}
    self_flags = {sid: is_self_capped(g, sid, effs) for sid in weak}
    for sid in weak:
        by_area_sizes.setdefault(_area(sid), []).append(len(root_sets[sid]))
        by_area_self.setdefault(_area(sid), []).append(self_flags[sid])

    def _median(xs: list[int]) -> float:
        n = len(xs)
        mid = n // 2
        return float(xs[mid]) if n % 2 else (xs[mid - 1] + xs[mid]) / 2

    order = greedy_root_cover(root_sets)
    total = len(weak)
    checkpoints = {}
    for target in (0.25, 0.5, 0.75, 0.9, 1.0):
        need = None
        for i, (_root, _new, cum) in enumerate(order, start=1):
            if total == 0 or cum / total >= target:
                need = i
                break
        checkpoints[target] = need if need is not None else len(order)

    return {
        "counts": {
            "active": len(active),
            "weak": total,
            "distinct_roots": len(all_roots),
        },
        "root_set_size": {
            "median": _median(sizes) if sizes else 0,
            "max": max(sizes) if sizes else 0,
            "by_area": {
                a: {"n": len(v), "mean": sum(v) / len(v), "max": max(v)}
                for a, v in sorted(by_area_sizes.items(), key=lambda kv: -sum(kv[1]) / len(kv[1]))
            },
        },
        "self_capped": {
            "n": sum(self_flags.values()),
            "total": total,
            "fraction": (sum(self_flags.values()) / total) if total else 0.0,
            "by_area": {
                a: {"n": len(v), "fraction": sum(v) / len(v)}
                for a, v in sorted(by_area_self.items(), key=lambda kv: -sum(kv[1]) / len(kv[1]))
            },
        },
        "greedy_cover": {
            "order": [{"root": r, "newly_resolved": n, "cumulative": c} for r, n, c in order],
            "checkpoints": checkpoints,
        },
    }


def format_hitting_set(rep: dict) -> str:
    lines: list[str] = []
    c = rep["counts"]
    lines.append(f"active={c['active']} weak(<rigorous)={c['weak']} distinct_roots={c['distinct_roots']}")
    rs = rep["root_set_size"]
    lines.append(f"root-set size: median={rs['median']} max={rs['max']}")
    lines.append("by area (mean root-set size, max):")
    for a, v in rs["by_area"].items():
        lines.append(f"  {a:12s} n={v['n']:3d} mean={v['mean']:5.1f} max={v['max']}")
    sc = rep["self_capped"]
    lines.append(f"\nself-capped: {sc['n']}/{sc['total']} = {sc['fraction']*100:.1f}%")
    lines.append("by area (self-capped fraction):")
    for a, v in sc["by_area"].items():
        lines.append(f"  {a:12s} n={v['n']:3d} self-capped={v['fraction']*100:5.1f}%")
    lines.append("\ngreedy root-cover checkpoints (roots needed -> weak cards fully resolved):")
    for t, k in rep["greedy_cover"]["checkpoints"].items():
        lines.append(f"  {int(t*100):3d}%  -> {k} roots")
    return "\n".join(lines)


def roots_needed_for_target(order: list[tuple[str, int, int]], total: int, target: float) -> tuple[int, list[str]]:
    """First k (and the k roots picked) such that the greedy `order`'s cumulative resolved
    count reaches `target` fraction of `total` weak cards."""
    cum = 0
    for i, (root, _new, cumulative) in enumerate(order, start=1):
        if total == 0 or cumulative / total >= target:
            return i, [r for r, _n, _c in order[:i]]
    return len(order), [r for r, _n, _c in order]


def force_rigorous(g: Graph, ids: list[str]) -> Graph:
    """Return a new Graph in which every id in `ids` that names a live statement is forced to
    `rigorous`, for counterfactual "what if this were already established" analysis.

    Setting `status: rigorous` alone is not enough for a `proposition`: its effective level is
    still `min` over whichever derivations it already has, so an existing weak dependency would
    keep throttling it. The correct forcing replaces every derivation targeting the proposition
    with a single dependency-free `rigorous` proof. For a `definition`/`axiom`, `status` does
    drive its effective level directly (via `_definition_like`), so setting `status` and
    clearing `uses` is sufficient.

    Does not mutate `g`: statements/derivations dicts are shallow-copied and only the forced
    entries are replaced, so unrelated `Statement`/`Derivation` objects are shared with the
    original graph (they are never mutated in place).
    """
    statements = dict(g.statements)
    derivations = dict(g.derivations)
    for sid in ids:
        st = statements.get(sid)
        if st is None:
            continue
        if st.kind == "proposition":
            for did in [d.id for d in derivations.values() if d.target == sid]:
                del derivations[did]
            fid = f"{sid}--FORCED"
            derivations[fid] = Derivation(
                id=fid, target=sid, kind="proof", status="rigorous",
                depends_on=[], sources=[], summary="counterfactual forcing (stringgraph counterfactual)",
                path=st.path,
            )
        else:
            statements[sid] = replace(st, status="rigorous", uses=[])
    return replace(g, statements=statements, derivations=derivations)


def counterfactual_report(g: Graph, ids: list[str]) -> dict:
    """Force every (known) id in `ids` to `rigorous` and report which *other* active cards move.

    Excludes the forced nodes themselves from the delta (forcing a node trivially "moves" it;
    counting that would be double-dipping on the premise). Only active (not superseded) cards
    are reported, matching `weak_active_ids`. Milestones whose `statement_id` moved are called
    out separately -- see docs/LEVERAGE-ANALYSIS.md for why that is the real payoff signal.
    """
    known = [sid for sid in ids if sid in g.statements]
    unknown = [sid for sid in ids if sid not in g.statements]
    baseline = compute_all(g)
    g2 = force_rigorous(g, known)
    after = compute_all(g2)
    forced_set = set(known)

    moved = []
    for sid, st in g.statements.items():
        if sid in forced_set or st.superseded_by:
            continue
        b, a = baseline[sid], after[sid]
        if a.level != b.level:
            moved.append({"id": sid, "before": b.name, "after": a.name})
    moved.sort(key=lambda m: m["id"])
    moved_ids = {m["id"] for m in moved}

    milestones_hit = []
    for m in g.milestones.values():
        if m.statement_id in moved_ids:
            entry = next(x for x in moved if x["id"] == m.statement_id)
            milestones_hit.append({
                "milestone": m.id, "statement_id": m.statement_id,
                "before": entry["before"], "after": entry["after"],
            })
    milestones_hit.sort(key=lambda m: m["milestone"])

    return {
        "forced": sorted(forced_set),
        "unknown_ids": unknown,
        "moved_count": len(moved),
        "moved": moved,
        "milestones_hit": milestones_hit,
    }


def format_counterfactual(rep: dict) -> str:
    lines = [f"forced ({len(rep['forced'])}): " + ", ".join(rep["forced"])]
    if rep["unknown_ids"]:
        lines.append(f"unknown ids (ignored): {', '.join(rep['unknown_ids'])}")
    lines.append(f"\nmoved ({rep['moved_count']} other active cards):")
    for m in rep["moved"]:
        lines.append(f"  {m['id']}: {m['before']} -> {m['after']}")
    lines.append(f"\nmilestones hit ({len(rep['milestones_hit'])}):")
    for m in rep["milestones_hit"]:
        lines.append(f"  *** {m['milestone']} ({m['statement_id']}): {m['before']} -> {m['after']}")
    return "\n".join(lines)


def _own_prop_status(g: Graph, sid: str) -> str:
    ders = [d for d in g.derivations_for(sid) if d.kind != "refutation"]
    if not ders:
        return "open"
    return max((d.status for d in ders), key=lambda s: LEVEL[s])


def full_report(g: Graph, open_only: bool = False) -> dict:
    effs = compute_all(g)
    by_kind = Counter(st.kind for st in g.statements.values())
    by_eff = Counter(e.name for e in effs.values())
    # Superseded cards keep no derivations once their successors take over, so they read as
    # "open" but are not work items; list them separately.
    open_props = sorted(
        sid
        for sid, st in g.statements.items()
        if st.kind == "proposition" and effs[sid].name == "open" and not st.superseded_by
    )
    superseded = sorted(f"{sid} -> {st.superseded_by}" for sid, st in g.statements.items() if st.superseded_by)
    inferred_edges = sorted(
        f"{d.id} -> {dep.id}" for d in g.derivations.values() for dep in d.depends_on if dep.inferred
    )
    gaps = sorted((d.id, gap) for d in g.derivations.values() for gap in d.gaps)
    # Formalization frontier: statements not yet formalized whose every statement
    # dependency (uses for definitions; best derivation's depends_on for propositions)
    # already is. These are the cheapest next Lean targets.
    frontier: list[str] = []
    for sid, st in g.statements.items():
        if effs[sid].name == "formalized" or st.superseded_by:
            continue
        # A card whose formalization has been ruled out (e.g. it asserts more than any
        # planned Lean statement can carry, and a narrower formalized card already exists)
        # opts out with this tag so the list stops attracting wiring attempts.
        if "formalization-ruled-out" in st.tags:
            continue
        if st.kind == "proposition":
            d = g.derivations.get(effs[sid].best_derivation) if effs[sid].best_derivation else None
            if d is None:
                continue
            deps = [x.id for x in d.depends_on if x.id in g.statements]
        else:
            deps = [u for u in st.uses if u in g.statements]
        if deps and all(effs[u].name == "formalized" for u in deps):
            frontier.append(sid)
    frontier.sort()
    by_area = Counter(sid.split(".", 1)[0] for sid in g.statements)
    milestones = []
    for m in g.milestones.values():
        e: Effective | None = effs.get(m.statement_id)
        milestones.append(
            {
                "id": m.id,
                "statement_id": m.statement_id,
                "audit": m.audit.get("status"),
                "effective": e.name if e else "missing",
                "assumes": sorted(e.assumes) if e else [],
                "conjectures_depended_on": sorted(e.conjectures) if e else [],
            }
        )
    out = {
        "counts": {
            "statements": len(g.statements),
            "derivations": len(g.derivations),
            "milestones": len(g.milestones),
            "conventions": len(g.conventions),
            "by_kind": dict(by_kind),
            "by_effective_status": dict(by_eff),
            "by_area": dict(by_area),
        },
        "formalization_frontier": frontier,
        "milestones": milestones,
        "open_propositions": open_props,
        "superseded": superseded,
        "inferred_edges": inferred_edges,
        "gaps": [{"derivation": d, "gap": gp} for d, gp in gaps],
    }
    if open_only:
        return {k: out[k] for k in ("open_propositions", "superseded", "inferred_edges", "gaps", "formalization_frontier")}
    return out


def format_report(rep: dict) -> str:
    lines: list[str] = []
    if "counts" in rep:
        c = rep["counts"]
        lines.append(
            f"statements={c['statements']} derivations={c['derivations']} "
            f"milestones={c['milestones']} conventions={c['conventions']}"
        )
        lines.append("by kind: " + ", ".join(f"{k}={v}" for k, v in sorted(c["by_kind"].items())))
        lines.append(
            "by effective status: "
            + ", ".join(f"{k}={v}" for k, v in sorted(c["by_effective_status"].items(), key=lambda kv: -LEVEL[kv[0]]))
        )
        lines.append("by area: " + ", ".join(f"{k}={v}" for k, v in sorted(c["by_area"].items())))
        lines.append("")
        lines.append("milestones:")
        for m in rep["milestones"]:
            lines.append(f"  {m['id']} -> {m['statement_id']}  audit={m['audit']}  effective={m['effective']}")
            if m["assumes"]:
                lines.append(f"    assumes: {', '.join(m['assumes'])}")
            if m["conjectures_depended_on"]:
                lines.append(f"    conjectures: {', '.join(m['conjectures_depended_on'])}")
        lines.append("")
    lines.append(f"open propositions ({len(rep['open_propositions'])}):")
    lines += [f"  {x}" for x in rep["open_propositions"]]
    lines.append(f"formalization frontier ({len(rep['formalization_frontier'])}, all deps formalized, self not; a candidate list, not a to-do — cards tagged formalization-ruled-out are hidden):")
    lines += [f"  {x}" for x in rep["formalization_frontier"]]
    lines.append(f"superseded ({len(rep['superseded'])}):")
    lines += [f"  {x}" for x in rep["superseded"]]
    lines.append(f"inferred edges ({len(rep['inferred_edges'])}):")
    lines += [f"  {x}" for x in rep["inferred_edges"]]
    lines.append(f"known gaps ({len(rep['gaps'])}):")
    lines += [f"  {x['derivation']}: {x['gap']}" for x in rep["gaps"]]
    return "\n".join(lines)


def search(g: Graph, terms: list[str]) -> list[tuple[int, str, str]]:
    """Return (score, id, title) sorted by score desc. Case-insensitive substring match."""
    terms_l = [t.lower() for t in terms]
    hits: list[tuple[int, str, str]] = []
    for st in g.statements.values():
        hay = " ".join([st.id, st.title, st.statement, " ".join(st.tags), st.notes or ""]).lower()
        score = sum(hay.count(t) for t in terms_l)
        if score:
            hits.append((score, st.id, st.title))
    for c in g.conventions.values():
        hay = " ".join([c.id, c.title, c.definition]).lower()
        score = sum(hay.count(t) for t in terms_l)
        if score:
            hits.append((score, c.id, c.title))
    hits.sort(key=lambda h: (-h[0], h[1]))
    return hits


def to_dot(g: Graph) -> str:
    effs = compute_all(g)
    out = ["digraph stringgraph {", "  rankdir=BT;", '  node [shape=box, style="rounded,filled", fontname="Helvetica"];']
    for sid, st in g.statements.items():
        e = effs[sid]
        shape = {"definition": "note", "axiom": "octagon"}.get(st.kind, "box")
        label = f"{sid}\\n[{e.name}]"
        out.append(f'  "{sid}" [label="{label}", shape={shape}, fillcolor="{_COLORS[e.name]}"];')
    for d in g.derivations.values():
        for dep in d.depends_on:
            if dep.id in g.conventions:
                continue
            style = "dashed" if dep.inferred else "solid"
            out.append(f'  "{dep.id}" -> "{d.target}" [style={style}, label="{d.id.split("--via-")[1]}", fontsize=8];')
    for st in g.statements.values():
        for u in st.uses:
            if u in g.statements:
                out.append(f'  "{u}" -> "{st.id}" [style=dotted];')
    out.append("}")
    return "\n".join(out)


def captain_queue(root: Path) -> dict:
    """Scan for items awaiting captain decision.

    Returns a dict with two lists:
      "research": attempts where state=="verified" and captain_confirmed is falsy.
      "milestones": milestones where audit.status != "approved".
    Each entry is a plain dict with human-readable fields plus "path".
    """
    import yaml as _yaml

    research_items: list[dict] = []
    attempts_dir = root / "research" / "attempts"
    if attempts_dir.is_dir():
        for status_file in sorted(attempts_dir.glob("*/status.yaml")):
            try:
                raw = _yaml.safe_load(status_file.read_text(encoding="utf-8")) or {}
            except Exception:  # noqa: BLE001
                raw = {}
            state = raw.get("state", "")
            captain_confirmed = raw.get("captain_confirmed", False)
            if state == "verified" and not captain_confirmed:
                slug = status_file.parent.name
                verdict = str(raw.get("verdict") or "").strip()
                # Truncate very long verdict strings to a summary line
                verdict_line = verdict.split("\n")[0][:120] if verdict else "(no verdict)"
                research_items.append({
                    "slug": slug,
                    "state": state,
                    "captain_confirmed": captain_confirmed,
                    "verdict_summary": verdict_line,
                    "path": str(status_file),
                })

    milestone_items: list[dict] = []
    milestones_dir = root / "graph" / "milestones"
    if milestones_dir.is_dir():
        for milestone_file in sorted(milestones_dir.glob("*.yaml")):
            try:
                raw = _yaml.safe_load(milestone_file.read_text(encoding="utf-8")) or {}
            except Exception:  # noqa: BLE001
                raw = {}
            audit = raw.get("audit") or {}
            audit_status = audit.get("status", "") if isinstance(audit, dict) else ""
            if audit_status != "approved":
                milestone_items.append({
                    "id": str(raw.get("id", milestone_file.stem)),
                    "audit_status": audit_status or "(missing)",
                    "path": str(milestone_file),
                })

    return {
        "research": research_items,
        "milestones": milestone_items,
    }


def format_captain_queue(data: dict) -> str:
    lines: list[str] = []

    research = data["research"]
    lines.append(f"=== 待船长确认（research 尝试）: {len(research)} 条 ===")
    if not research:
        lines.append("  (无待办)")
    else:
        for item in research:
            lines.append(f"  slug:              {item['slug']}")
            lines.append(f"  state:             {item['state']}")
            lines.append(f"  captain_confirmed: {item['captain_confirmed']}")
            lines.append(f"  verdict:           {item['verdict_summary']}")
            lines.append(f"  path:              {item['path']}")
            lines.append("")

    lines.append(f"=== 待船长审计（里程碑）: {len(data['milestones'])} 条 ===")
    milestones = data["milestones"]
    if not milestones:
        lines.append("  (无待办)")
    else:
        for item in milestones:
            lines.append(f"  id:           {item['id']}")
            lines.append(f"  audit_status: {item['audit_status']}")
            lines.append(f"  path:         {item['path']}")
            lines.append("")

    return "\n".join(lines)


def to_json(obj: object) -> str:
    return json.dumps(obj, ensure_ascii=False, indent=2)
