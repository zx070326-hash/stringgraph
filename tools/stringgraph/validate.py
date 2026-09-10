"""Validation: schema, ids, references, cycles, conventions, sources, milestones."""
from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path

import jsonschema

from .model import DEFINITION_STATUSES, Graph
from .propagate import compute_all


@dataclass
class Problem:
    severity: str  # "error" | "warning"
    where: str
    message: str

    def __str__(self) -> str:
        return f"[{self.severity}] {self.where}: {self.message}"


def _load_schema(root: Path, name: str) -> dict:
    return json.loads((root / "graph" / "schema" / f"{name}.schema.json").read_text(encoding="utf-8"))


def _rel(root: Path, p: Path) -> str:
    try:
        return str(p.relative_to(root)).replace("\\", "/")
    except ValueError:
        return str(p)


def validate(g: Graph) -> list[Problem]:
    root = g.root
    problems: list[Problem] = []
    err = lambda where, msg: problems.append(Problem("error", where, msg))  # noqa: E731
    warn = lambda where, msg: problems.append(Problem("warning", where, msg))  # noqa: E731

    for e in g.load_errors:
        err("load", e)
    # A YAML block pasted into the previous string field is silently swallowed (still valid YAML).
    import re as _re
    _swallow = _re.compile(r"\n\s*- (ref|id):\s")
    for st in g.statements.values():
        for src in st.sources:
            for fld in (src.loc, src.note):
                if fld and _swallow.search(fld):
                    warn(f"graph/statements/{st.id}", "a source loc/note contains what looks like a YAML list item ('- ref:'/'- id:'); a following entry may have been swallowed into this string")
    for d in g.derivations.values():
        for src in d.sources:
            for fld in (src.loc, src.note):
                if fld and _swallow.search(fld):
                    warn(f"graph/derivations/{d.id}", "a source loc/note contains what looks like a YAML list item; a following entry may have been swallowed")
        for dep in d.depends_on:
            if dep.note and _swallow.search(dep.note):
                warn(f"graph/derivations/{d.id}", "a depends_on note contains what looks like a YAML list item; a following entry may have been swallowed")
    for k in g.bib_duplicate_keys:
        err("literature/sources.bib", f"duplicate bib key '{k}' (parallel merges of curator branches; keep one entry)")

    schemas = {k: _load_schema(root, k) for k in ("statement", "derivation", "milestone", "convention")}
    validators = {k: jsonschema.Draft202012Validator(v) for k, v in schemas.items()}

    def check_schema(kind: str, raw: dict, where: str) -> None:
        for e in validators[kind].iter_errors(raw):
            loc = "/".join(str(x) for x in e.absolute_path) or "<root>"
            err(where, f"schema: {loc}: {e.message}")

    # ---- statements -------------------------------------------------------
    for st in g.statements.values():
        where = _rel(root, st.path)
        check_schema("statement", st.raw, where)
        area = st.area
        if area not in g.areas:
            err(where, f"unknown area '{area}' (add to graph/schema/areas.yaml)")
        expected = root / "graph" / "statements" / area / f"{st.slug}.yaml"
        if st.path.resolve() != expected.resolve():
            err(where, f"file path must be graph/statements/{area}/{st.slug}.yaml for id {st.id}")
        if st.kind == "proposition":
            if st.status is not None:
                err(where, "propositions must not declare `status`; it is computed from derivations")
        else:
            if st.status not in DEFINITION_STATUSES:
                err(where, f"{st.kind} must declare `status` in {DEFINITION_STATUSES}")
        for u in st.uses:
            if u not in g.statements and u not in g.conventions:
                err(where, f"uses: unknown id '{u}'")
        for c in st.uses_conventions:
            if c not in g.conventions:
                err(where, f"uses_conventions: unknown convention '{c}'")
        for s in st.sources:
            if s.ref not in g.bib_keys:
                err(where, f"source ref '{s.ref}' not in literature/sources.bib")
            if not s.loc:
                warn(where, f"source '{s.ref}' has no `loc` (章节/公式号)")
        if st.superseded_by and st.superseded_by not in g.statements:
            err(where, f"superseded_by: unknown id '{st.superseded_by}'")
        if st.formal and st.formal.get("lean_file"):
            lf = root / "formal" / st.formal["lean_file"]
            if not lf.exists():
                err(where, f"formal.lean_file does not exist: {st.formal['lean_file']}")

    # ---- conventions ------------------------------------------------------
    for c in g.conventions.values():
        where = _rel(root, c.path)
        check_schema("convention", c.raw, where)
        expected = root / "graph" / "conventions" / f"{c.id.split('.', 1)[1]}.yaml"
        if c.path.resolve() != expected.resolve():
            err(where, f"file path must match id {c.id}")
        for s in c.sources:
            if s.ref not in g.bib_keys:
                err(where, f"source ref '{s.ref}' not in literature/sources.bib")
    fam_canon: dict[str, list[str]] = {}
    for c in g.conventions.values():
        if c.canonical:
            fam_canon.setdefault(c.family, []).append(c.id)
    for fam, ids in fam_canon.items():
        if len(ids) > 1:
            err("graph/conventions", f"family '{fam}' has more than one canonical convention: {ids}")

    def conv_family(cid: str) -> str | None:
        c = g.conventions.get(cid)
        return c.family if c else None

    # ---- derivations ------------------------------------------------------
    for d in g.derivations.values():
        where = _rel(root, d.path)
        check_schema("derivation", d.raw, where)
        if d.area not in g.areas:
            err(where, f"unknown area '{d.area}'")
        slug = d.id.split(".", 1)[1]
        expected = root / "graph" / "derivations" / d.area / f"{slug}.yaml"
        if d.path.resolve() != expected.resolve():
            err(where, f"file path must be graph/derivations/{d.area}/{slug}.yaml for id {d.id}")
        if not d.id.startswith(d.target + "--via-"):
            err(where, f"id must start with '{d.target}--via-'")
        tgt = g.statements.get(d.target)
        if tgt is None:
            err(where, f"target: unknown statement '{d.target}'")
        elif tgt.kind != "proposition":
            err(where, f"target '{d.target}' is a {tgt.kind}; derivations only target propositions")
        elif tgt.superseded_by:
            warn(where, f"target '{d.target}' is superseded by {tgt.superseded_by} (stale derivation; retarget or delete)")
        if d.kind == "proof" and d.status not in ("formalized", "rigorous"):
            err(where, "kind: proof requires status formalized or rigorous (else use physical-argument)")
        if d.kind == "physical-argument" and d.status != "physical-argument":
            err(where, "kind: physical-argument requires status physical-argument")
        if d.kind == "conjecture-support" and d.status not in ("conjecture", "speculation"):
            err(where, "kind: conjecture-support requires status conjecture or speculation")
        if d.status == "formalized":
            if not (tgt and tgt.formal and tgt.formal.get("lean_decl")):
                err(where, "status formalized requires target.formal.lean_decl")
        for s in d.sources:
            if s.ref not in g.bib_keys:
                err(where, f"source ref '{s.ref}' not in literature/sources.bib")
        seen: set[str] = set()
        tgt_fams = {conv_family(c): c for c in (tgt.uses_conventions if tgt else [])}
        for dep in d.depends_on:
            if dep.id in seen:
                err(where, f"duplicate dependency '{dep.id}'")
            seen.add(dep.id)
            if dep.id == d.target:
                err(where, "derivation depends on its own target")
            node = g.statements.get(dep.id)
            if node is None and dep.id not in g.conventions:
                err(where, f"depends_on: unknown id '{dep.id}'")
                continue
            if node is None:
                continue
            if node.superseded_by:
                warn(where, f"depends on superseded statement '{dep.id}' (use {node.superseded_by})")
            # convention conflict: same family, different convention, no map
            for c in node.uses_conventions:
                fam = conv_family(c)
                if fam in tgt_fams and tgt_fams[fam] != c and not dep.convention_map:
                    err(where, f"convention conflict on family '{fam}': target uses {tgt_fams[fam]}, dep {dep.id} uses {c}; add convention_map")
        if not d.depends_on:
            warn(where, "derivation has no dependencies (is it really self-contained?)")

    # ---- milestones -------------------------------------------------------
    for m in g.milestones.values():
        where = _rel(root, m.path)
        check_schema("milestone", m.raw, where)
        expected = root / "graph" / "milestones" / f"{m.id.split('.', 1)[1]}.yaml"
        if m.path.resolve() != expected.resolve():
            err(where, f"file path must match id {m.id}")
        st = g.statements.get(m.statement_id)
        if st is None:
            err(where, f"statement_id: unknown '{m.statement_id}'")
        else:
            for c in st.uses_conventions:
                conv = g.conventions.get(c)
                if conv and not conv.canonical:
                    err(where, f"milestone statement uses non-canonical convention '{c}'")
        status = m.audit.get("status")
        bt = m.audit.get("back_translation")
        if status in ("back-translated", "approved") and not bt:
            err(where, f"audit.status={status} requires audit.back_translation")
        if status == "approved":
            if not m.audit.get("captain") or not m.audit.get("approved_on"):
                err(where, "approved milestone requires audit.captain and audit.approved_on")
            if bt and bt.get("verdict") != "faithful":
                err(where, "approved milestone requires back_translation.verdict == faithful")
        if m.canonical_source and m.canonical_source.get("ref") not in g.bib_keys:
            err(where, f"canonical_source ref '{m.canonical_source.get('ref')}' not in sources.bib")

    # ---- cycles -----------------------------------------------------------
    for sid, eff in compute_all(g).items():
        if eff.cycle:
            err(sid, "dependency cycle detected through this node")

    return problems
