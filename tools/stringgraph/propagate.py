"""Effective-status propagation.

effective(proposition) = max over derivations of
    min(derivation.status, min over deps of effective(dep))
effective(definition|axiom) = min(own status, min over `uses` of effective(dep))
conventions never participate in the min.
A refutation derivation whose own effective rigor is at least physical-argument
forces the target to `refuted`.
A proposition with no derivations is `open`.

Alongside the level we track:
  assumes:      set of axiom ids the best derivation chain rests on
  conjectures:  set of statement ids in the best chain whose own effective
                status is conjecture/speculation/open
"""
from __future__ import annotations

from dataclasses import dataclass, field

from .model import LEVEL, LEVEL_NAME, Derivation, Graph


@dataclass
class Effective:
    level: int
    assumes: set[str] = field(default_factory=set)
    conjectures: set[str] = field(default_factory=set)
    best_derivation: str | None = None
    cycle: bool = False

    @property
    def name(self) -> str:
        return LEVEL_NAME[self.level]


class Propagator:
    def __init__(self, g: Graph):
        self.g = g
        self._memo: dict[str, Effective] = {}
        self._stack: list[str] = []

    def effective(self, sid: str) -> Effective:
        if sid in self._memo:
            return self._memo[sid]
        if sid in self._stack:
            # Cycle: report as open and flag. validate.py reports cycles separately.
            return Effective(level=LEVEL["open"], cycle=True)
        if sid not in self.g.statements:
            # Dangling reference; validate reports it. Treat as open.
            return Effective(level=LEVEL["open"])

        self._stack.append(sid)
        try:
            st = self.g.statements[sid]
            if st.kind in ("definition", "axiom"):
                eff = self._definition_like(st.id, st.kind, st.status, st.uses)
            else:
                eff = self._proposition(st.id)
        finally:
            self._stack.pop()
        self._memo[sid] = eff
        return eff

    def _combine_deps(self, dep_ids: list[str]) -> Effective:
        level = LEVEL["formalized"]
        assumes: set[str] = set()
        conjectures: set[str] = set()
        cycle = False
        for did in dep_ids:
            if did in self.g.conventions:
                continue
            sub = self.effective(did)
            cycle = cycle or sub.cycle
            level = min(level, sub.level)
            assumes |= sub.assumes
            conjectures |= sub.conjectures
            if sub.level <= LEVEL["conjecture"]:
                conjectures.add(did)
        return Effective(level=level, assumes=assumes, conjectures=conjectures, cycle=cycle)

    def _definition_like(self, sid: str, kind: str, status: str | None, uses: list[str]) -> Effective:
        own = LEVEL.get(status or "", LEVEL["physical-argument"])
        deps = self._combine_deps(uses)
        eff = Effective(
            level=min(own, deps.level),
            assumes=set(deps.assumes),
            conjectures=set(deps.conjectures),
            cycle=deps.cycle,
        )
        if kind == "axiom":
            eff.assumes.add(sid)
        return eff

    def _derivation(self, d: Derivation) -> Effective:
        deps = self._combine_deps([x.id for x in d.depends_on])
        own = LEVEL.get(d.status, LEVEL["speculation"])
        return Effective(
            level=min(own, deps.level),
            assumes=deps.assumes,
            conjectures=deps.conjectures,
            best_derivation=d.id,
            cycle=deps.cycle,
        )

    def _proposition(self, sid: str) -> Effective:
        ders = self.g.derivations_for(sid)
        if not ders:
            return Effective(level=LEVEL["open"])

        refutations = [d for d in ders if d.kind == "refutation"]
        for r in refutations:
            e = self._derivation(r)
            if e.level >= LEVEL["physical-argument"]:
                return Effective(
                    level=LEVEL["refuted"],
                    assumes=e.assumes,
                    conjectures=e.conjectures,
                    best_derivation=r.id,
                    cycle=e.cycle,
                )

        supports = [d for d in ders if d.kind != "refutation"]
        if not supports:
            return Effective(level=LEVEL["open"])
        # Strongest derivation wins. Ties on effective level are broken by
        # (1) the strongest dependency floor (a derivation whose deps are all
        # formalized beats one capped by its own status), (2) fewest conjectures
        # depended on, (3) derivation id, so the choice is deterministic and
        # `why` shows the shortest honest bottleneck chain (ROADMAP F1, 2026-09-12).
        best: Effective | None = None
        best_key: tuple[int, int, int, str] | None = None
        for d in sorted(supports, key=lambda x: x.id):
            e = self._derivation(d)
            deps_floor = self._combine_deps([x.id for x in d.depends_on]).level
            key = (e.level, deps_floor, -len(e.conjectures), d.id)
            if best_key is None or key[:3] > best_key[:3]:
                best, best_key = e, key
        assert best is not None
        return best


def compute_all(g: Graph) -> dict[str, Effective]:
    p = Propagator(g)
    return {sid: p.effective(sid) for sid in g.statements}
