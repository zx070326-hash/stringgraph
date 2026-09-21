"""Validation: schema, ids, references, cycles, conventions, sources, milestones."""
from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path

import jsonschema

from .model import DEFINITION_STATUSES, FORMAL_KEYS, Graph
from .propagate import compute_all


@dataclass
class Problem:
    severity: str  # "error" | "warning"
    where: str
    message: str
    # "live" = something to act on; "history" = an expected trace of a superseded card
    # (see docs/STATUS_LEVELS.md「旧推导的去留」). Errors are always "live".
    kind: str = "live"

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
    warn = lambda where, msg, kind="live": problems.append(Problem("warning", where, msg, kind))  # noqa: E731

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
            # `formal.lean_decl` means "this Lean declaration PROVES this card", so it must be
            # backed by a formalized derivation. Together with the reverse check below
            # ("status formalized requires target.formal.lean_decl") this makes lean_decl and
            # a formalized derivation a biconditional. A Lean declaration that merely states the
            # card, or covers only part of it, belongs in `lean_related` + `lean_note`.
            # Superseded cards are exempt: they are frozen history, and principle 1 forbids
            # editing a card that other nodes may already build on.
            if st.formal and st.formal.get("lean_decl") and not st.superseded_by:
                if not any(d.status == "formalized" for d in g.derivations_for(st.id)):
                    err(
                        where,
                        f"formal.lean_decl '{st.formal['lean_decl']}' claims a machine-checked "
                        f"proof of this card, but no derivation has status formalized. Either add "
                        f"the formalized derivation, or — if the declaration only states the card "
                        f"or covers only part of it — move it to formal.lean_related + lean_note",
                    )
        else:
            if st.status not in DEFINITION_STATUSES:
                err(where, f"{st.kind} must declare `status` in {DEFINITION_STATUSES}")
            # Symmetric gate: claiming `formalized` requires naming the Lean declaration that
            # backs the claim. Propositions get this via the derivation check below.
            if st.status == "formalized" and not (st.formal and st.formal.get("lean_decl")):
                err(
                    where,
                    f"{st.kind} has status formalized but no formal.lean_decl; add the "
                    f"declaration that backs the claim, or downgrade status",
                )
        for u in st.uses:
            if u not in g.statements and u not in g.conventions:
                err(where, f"uses: unknown id '{u}'")
        # #6: definition/axiom with empty uses should warn for confirmation
        if st.kind in ("definition", "axiom") and not st.uses:
            warn(where, f"{st.kind} with no declared dependencies; confirm self-contained before milestone inclusion")
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
        if st.formal:
            unknown = set(st.formal) - FORMAL_KEYS
            if unknown:
                err(
                    where,
                    f"formal: unknown key(s) {sorted(unknown)}; allowed: {sorted(FORMAL_KEYS)}",
                )
            if st.formal.get("lean_decl") and st.formal.get("lean_related"):
                err(
                    where,
                    "formal: lean_decl and lean_related are mutually exclusive — lean_decl says "
                    "the declaration proves the card, lean_related says it does not",
                )
            if st.formal.get("lean_related") and not str(st.formal.get("lean_note") or "").strip():
                err(
                    where,
                    "formal: lean_related requires lean_note saying how the declaration relates "
                    "to the card (states it only / covers only part of it, and which part)",
                )
            if st.formal.get("lean_note") and not st.formal.get("lean_related"):
                err(where, "formal: lean_note is only meaningful alongside lean_related")
            if (
                st.formal.get("lean_decl") or st.formal.get("lean_related")
            ) and not st.formal.get("lean_file"):
                err(where, "formal: lean_decl/lean_related requires formal.lean_file")

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
            warn(where, f"target '{d.target}' is superseded by {tgt.superseded_by} (stale derivation; retarget or delete)", "history")
        if d.kind == "proof" and d.status not in ("formalized", "rigorous"):
            err(where, "kind: proof requires status formalized or rigorous (else use physical-argument)")
        if d.kind == "physical-argument" and d.status != "physical-argument":
            err(where, "kind: physical-argument requires status physical-argument")
        if d.kind == "conjecture-support" and d.status not in ("conjecture", "speculation"):
            err(where, "kind: conjecture-support requires status conjecture or speculation")
        if d.status == "formalized":
            if not (tgt and tgt.formal and tgt.formal.get("lean_decl")):
                err(where, "status formalized requires target.formal.lean_decl")

        # #3: sources may be deferred during exploration; warn if notes indicate work in progress
        if not d.sources and not any(dep.inferred for dep in d.depends_on):
            summary_lower = (d.summary or "").lower()
            if "探索中" in summary_lower or "exploration in progress" in summary_lower:
                warn(where, "derivation has no sources (exploration in progress); must be completed before milestone inclusion or external publication")
            else:
                err(where, "derivation must have sources (or mark edges as inferred: true with note)")

        for s in d.sources:
            if s.ref not in g.bib_keys:
                err(where, f"source ref '{s.ref}' not in literature/sources.bib")
        seen: set[str] = set()
        # A derivation whose own target is superseded is itself history: its dependencies are
        # frozen as a record, so a superseded dep there is an expected trace, not work to do.
        tgt_is_history = bool(tgt is not None and tgt.superseded_by)
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
                if node.kind == "proposition" and not g.derivations_for(dep.id):
                    err(where, f"depends on superseded proposition '{dep.id}' which has no derivation left (effective open); retarget to {node.superseded_by} or restore the old derivation as history")
                else:
                    warn(where, f"depends on superseded statement '{dep.id}' (use {node.superseded_by})",
                         "history" if tgt_is_history else "live")
            # #5: inferred edges may have pending notes during exploration
            if dep.inferred:
                note_lower = (dep.note or "").lower()
                if not dep.note or "待整理" in note_lower or "pending" in note_lower:
                    warn(where, f"inferred edge to '{dep.id}' has pending note; must be completed before milestone inclusion or external publication", kind="live")
            # #4: convention conflict warns unless target is in milestones
            for c in node.uses_conventions:
                fam = conv_family(c)
                if fam in tgt_fams and tgt_fams[fam] != c and not dep.convention_map:
                    # Check if target is in any milestone
                    target_in_milestone = any(m.statement_id == d.target for m in g.milestones.values())
                    if target_in_milestone:
                        err(where, f"convention conflict on family '{fam}': target uses {tgt_fams[fam]}, dep {dep.id} uses {c}; add convention_map")
                    else:
                        warn(where, f"convention conflict on family '{fam}': target uses {tgt_fams[fam]}, dep {dep.id} uses {c}; must resolve before milestone inclusion")
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
