"""Reports, search, and Graphviz export."""
from __future__ import annotations

import json
from collections import Counter

from .model import LEVEL, Graph
from .propagate import Effective, compute_all

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
    }


def _own_prop_status(g: Graph, sid: str) -> str:
    ders = [d for d in g.derivations_for(sid) if d.kind != "refutation"]
    if not ders:
        return "open"
    return max((d.status for d in ders), key=lambda s: LEVEL[s])


def full_report(g: Graph, open_only: bool = False) -> dict:
    effs = compute_all(g)
    by_kind = Counter(st.kind for st in g.statements.values())
    by_eff = Counter(e.name for e in effs.values())
    open_props = sorted(
        sid for sid, st in g.statements.items() if st.kind == "proposition" and effs[sid].name == "open"
    )
    inferred_edges = sorted(
        f"{d.id} -> {dep.id}" for d in g.derivations.values() for dep in d.depends_on if dep.inferred
    )
    gaps = sorted((d.id, gap) for d in g.derivations.values() for gap in d.gaps)
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
        },
        "milestones": milestones,
        "open_propositions": open_props,
        "inferred_edges": inferred_edges,
        "gaps": [{"derivation": d, "gap": gp} for d, gp in gaps],
    }
    if open_only:
        return {k: out[k] for k in ("open_propositions", "inferred_edges", "gaps")}
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
