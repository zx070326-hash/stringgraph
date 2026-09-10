"""`stringgraph check-axioms`: run formal/scripts/check_axioms.lean and map its verdict onto nodes.

The graph claims `status: formalized` for a derivation only when the Lean declaration named by the
target statement's `formal.lean_decl` compiles with no `sorry` and no axiom outside
`propext`, `Classical.choice`, `Quot.sound`.  This module checks that claim mechanically: it
collects every `formal.lean_decl` in the graph, feeds the names to the Lean script (one subprocess,
`cwd = formal/`), and reports non-standard axioms / missing declarations against the node ids that
carry them.

Deliberately *not* part of `validate`: loading the Lean environment takes seconds to minutes, and
pre-commit must stay fast.  Run this after a `lake build`, and before flipping a derivation to
`formalized`.
"""
from __future__ import annotations

import subprocess
from dataclasses import dataclass, field
from pathlib import Path

from .model import Graph
from .validate import Problem

#: The axioms a declaration may depend on; anything else (notably `sorryAx`) is an error.
STANDARD_AXIOMS = ("propext", "Classical.choice", "Quot.sound")

#: Argument vector of the Lean script, relative to `formal/`.
LEAN_COMMAND = ("lake", "env", "lean", "--run", "scripts/check_axioms.lean", "--all")

_STATUSES = ("ok", "bad", "missing")


@dataclass
class DeclUse:
    """A Lean declaration name together with the graph nodes that point at it."""

    decl: str
    statements: list[str] = field(default_factory=list)
    lean_files: list[str] = field(default_factory=list)
    formalized_derivations: list[str] = field(default_factory=list)


@dataclass
class DeclResult:
    """One output row of the Lean script."""

    decl: str
    status: str  # "ok" | "bad" | "missing"
    axioms: list[str] = field(default_factory=list)
    detail: str = ""

    @property
    def nonstandard(self) -> list[str]:
        return [a for a in self.axioms if a not in STANDARD_AXIOMS]


def _rel(root: Path, p: Path) -> str:
    try:
        return str(p.relative_to(root)).replace("\\", "/")
    except ValueError:
        return str(p)


def collect_decls(g: Graph, formalized_only: bool = False) -> list[DeclUse]:
    """Every `formal.lean_decl` in the graph, with the nodes that reference it.

    `formalized_only` keeps just the declarations that back a `status: formalized` derivation,
    i.e. the ones whose axiom set the graph's epistemic claims actually rest on.
    """
    uses: dict[str, DeclUse] = {}
    for st in g.statements.values():
        decl = (st.formal or {}).get("lean_decl")
        if not decl:
            continue
        use = uses.setdefault(decl, DeclUse(decl=decl))
        use.statements.append(st.id)
        lean_file = (st.formal or {}).get("lean_file")
        if lean_file and lean_file not in use.lean_files:
            use.lean_files.append(lean_file)
    for d in g.derivations.values():
        if d.status != "formalized":
            continue
        tgt = g.statements.get(d.target)
        decl = (tgt.formal or {}).get("lean_decl") if tgt else None
        if decl and decl in uses:
            uses[decl].formalized_derivations.append(d.id)
    for use in uses.values():
        use.statements.sort()
        use.formalized_derivations.sort()
    out = sorted(uses.values(), key=lambda u: u.decl)
    if formalized_only:
        out = [u for u in out if u.formalized_derivations]
    return out


def parse_output(text: str) -> list[DeclResult]:
    """Parse the script's tab-separated `<status>\\t<decl>\\t<detail>` lines.

    `#` comment lines and blank lines are ignored; unknown statuses are reported as-is so that a
    contract change shows up as an error rather than as silent success.
    """
    out: list[DeclResult] = []
    for line in text.splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        parts = line.rstrip("\r").split("\t")
        if len(parts) < 2:
            continue
        status, decl = parts[0].strip(), parts[1].strip()
        detail = parts[2] if len(parts) > 2 else ""
        axioms = detail.split() if status in ("ok", "bad") else []
        out.append(DeclResult(decl=decl, status=status, axioms=axioms, detail=detail))
    return out


def _default_runner(root: Path, decls: list[str]) -> tuple[int, str, str]:
    proc = subprocess.run(  # noqa: S603
        list(LEAN_COMMAND),
        cwd=root / "formal",
        input="\n".join(decls) + "\n",
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    return proc.returncode, proc.stdout or "", proc.stderr or ""


def check_axioms(
    g: Graph,
    formalized_only: bool = False,
    only: list[str] | None = None,
    runner=None,
) -> dict:
    """Run the Lean script over the graph's declarations and map the verdict back onto node ids.

    `runner(root, decls) -> (returncode, stdout, stderr)` is injectable for tests.
    Returns a JSON-ready report; `report["exit_code"]` is what the CLI should exit with
    (0 clean, 1 axiom/mapping errors, 2 could not run the checker).
    """
    runner = runner or _default_runner
    uses = collect_decls(g, formalized_only=formalized_only)
    if only:
        wanted = set(only)
        known = {u.decl for u in uses}
        uses = [u for u in uses if u.decl in wanted]
        for decl in sorted(wanted - known):
            uses.append(DeclUse(decl=decl))
        uses.sort(key=lambda u: u.decl)

    report: dict = {
        "command": list(LEAN_COMMAND),
        "cwd": "formal",
        "standard_axioms": list(STANDARD_AXIOMS),
        "declarations": [],
        "counts": {"checked": len(uses), "ok": 0, "bad": 0, "missing": 0},
        "problems": [],
        "exit_code": 0,
    }
    problems: list[Problem] = []

    if not uses:
        report["stderr"] = ""
        return report

    try:
        code, stdout, stderr = runner(g.root, [u.decl for u in uses])
    except FileNotFoundError as e:  # lake / lean not on PATH
        report["exit_code"] = 2
        report["stderr"] = str(e)
        report["problems"] = [
            vars(Problem("error", "formal/scripts/check_axioms.lean", f"cannot run the checker: {e}"))
        ]
        return report

    results = {r.decl: r for r in parse_output(stdout)}
    report["stderr"] = stderr.strip()

    if not results and code != 0:
        report["exit_code"] = 2
        problems.append(
            Problem(
                "error",
                "formal/scripts/check_axioms.lean",
                f"checker exited {code} without producing any result line; stderr: {stderr.strip()[-500:]}",
            )
        )

    for use in uses:
        r = results.get(use.decl)
        entry = {
            "decl": use.decl,
            "status": r.status if r else "no-result",
            "axioms": r.axioms if r else [],
            "detail": r.detail if r else "",
            "statements": use.statements,
            "lean_files": use.lean_files,
            "formalized_derivations": use.formalized_derivations,
        }
        report["declarations"].append(entry)

        wheres = [_rel(g.root, g.statements[sid].path) for sid in use.statements if sid in g.statements]
        wheres = wheres or [f"formal.lean_decl {use.decl}"]

        if r is None:
            if report["exit_code"] != 2:
                for where in wheres:
                    problems.append(
                        Problem("error", where, f"checker produced no verdict for '{use.decl}'")
                    )
            continue
        if r.status == "ok":
            report["counts"]["ok"] += 1
            continue
        if r.status == "bad":
            report["counts"]["bad"] += 1
            bad = ", ".join(r.nonstandard)
            for where in wheres:
                problems.append(
                    Problem(
                        "error",
                        where,
                        f"formal.lean_decl '{use.decl}' depends on non-standard axioms: {bad}",
                    )
                )
        elif r.status == "missing":
            report["counts"]["missing"] += 1
            for where in wheres:
                problems.append(
                    Problem(
                        "error",
                        where,
                        f"formal.lean_decl '{use.decl}' is not a declaration in the built "
                        f"environment ({r.detail or 'not found'})",
                    )
                )
        else:
            problems.append(
                Problem(
                    "error",
                    "formal/scripts/check_axioms.lean",
                    f"unexpected status '{r.status}' for '{use.decl}' "
                    f"(expected one of {', '.join(_STATUSES)})",
                )
            )
        for did in use.formalized_derivations:
            d = g.derivations.get(did)
            problems.append(
                Problem(
                    "error",
                    _rel(g.root, d.path) if d else did,
                    f"status formalized rests on '{use.decl}', which did not pass the axiom check "
                    f"({r.status}); fix the proof or downgrade this derivation",
                )
            )

    if problems and report["exit_code"] == 0:
        report["exit_code"] = 1
    report["problems"] = [vars(p) for p in problems]
    return report


def format_axioms_report(rep: dict) -> str:
    """Human-readable rendering of `check_axioms`."""
    lines: list[str] = []
    counts = rep["counts"]
    lines.append(
        f"{' '.join(rep['command'])}  (cwd: {rep['cwd']}, "
        f"standard axioms: {', '.join(rep['standard_axioms'])})"
    )
    for entry in rep["declarations"]:
        detail = " ".join(entry["axioms"]) if entry["axioms"] else entry["detail"]
        lines.append(f"{entry['status']:8s} {entry['decl']}")
        if detail:
            lines.append(f"         axioms: {detail}")
        for sid in entry["statements"]:
            lines.append(f"         ← {sid}")
        for did in entry["formalized_derivations"]:
            lines.append(f"         ← {did}  [formalized]")
    if rep.get("stderr"):
        lines.append(f"\nchecker stderr:\n{rep['stderr']}")
    if rep["problems"]:
        lines.append("")
        for p in rep["problems"]:
            lines.append(f"[{p['severity']}] {p['where']}: {p['message']}")
    n_err = sum(1 for p in rep["problems"] if p["severity"] == "error")
    lines.append(
        f"\n{counts['checked']} declarations checked: {counts['ok']} ok, "
        f"{counts['bad']} non-standard, {counts['missing']} missing; {n_err} errors"
    )
    return "\n".join(lines)
