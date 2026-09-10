"""Reports, search, and Graphviz export."""
from __future__ import annotations

import json
from collections import Counter

from .model import LEVEL, Graph
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
    lines.append(f"formalization frontier ({len(rep['formalization_frontier'])}, all deps formalized, self not):")
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


def to_json(obj: object) -> str:
    return json.dumps(obj, ensure_ascii=False, indent=2)
