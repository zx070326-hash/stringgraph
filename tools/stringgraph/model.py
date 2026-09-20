"""Data model and status ordering.

Status levels (see docs/STATUS_LEVELS.md). Higher is stronger.
"""
from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

# Own-status values that may appear in YAML.
DERIVATION_STATUSES = ("formalized", "rigorous", "physical-argument", "conjecture", "speculation")
DEFINITION_STATUSES = ("formalized", "rigorous", "physical-argument")

# Keys allowed under a statement's `formal:` block.
#   lean_decl    — this declaration PROVES this card, sentence for sentence. It is the machine
#                  endorsement `formalized` rests on, so validate.py requires a formalized
#                  derivation alongside it (and vice versa).
#   lean_related — a Lean declaration relevant to this card that does NOT machine-check it:
#                  it may only *state* the card (a Prop-valued `def`), or cover only *part* of
#                  it. Asserts nothing about status and can never back `formalized`.
#                  Requires `lean_note` saying which relationship holds.
#   lean_note    — one line explaining how `lean_related` relates to the card.
#   lean_file    — the file the declaration lives in; required when either pointer is present.
FORMAL_KEYS = frozenset({"lean_decl", "lean_related", "lean_note", "lean_file"})

# Effective statuses (computed). "refuted" and "open" are only ever computed.
LEVEL: dict[str, int] = {
    "formalized": 5,
    "rigorous": 4,
    "physical-argument": 3,
    "conjecture": 2,
    "speculation": 1,
    "refuted": 0,
    "open": -1,
}
LEVEL_NAME: dict[int, str] = {v: k for k, v in LEVEL.items()}

STATEMENT_KINDS = ("definition", "proposition", "axiom")
DERIVATION_KINDS = ("proof", "physical-argument", "conjecture-support", "refutation")


@dataclass
class Source:
    ref: str
    loc: str | None = None
    note: str | None = None


@dataclass
class Dep:
    id: str
    inferred: bool = False
    note: str | None = None
    convention_map: str | None = None


@dataclass
class Statement:
    id: str
    kind: str
    title: str
    statement: str
    sources: list[Source]
    path: Path
    status: str | None = None  # required for definition/axiom, forbidden for proposition
    uses: list[str] = field(default_factory=list)  # definitional dependencies
    uses_conventions: list[str] = field(default_factory=list)
    tags: list[str] = field(default_factory=list)
    notes: str | None = None
    superseded_by: str | None = None
    formal: dict[str, Any] | None = None
    author: str | None = None
    created: str | None = None
    raw: dict[str, Any] = field(default_factory=dict)

    @property
    def area(self) -> str:
        return self.id.split(".", 1)[0]

    @property
    def slug(self) -> str:
        return self.id.split(".", 1)[1]


@dataclass
class Derivation:
    id: str
    target: str
    kind: str
    status: str
    depends_on: list[Dep]
    sources: list[Source]
    summary: str
    path: Path
    gaps: list[str] = field(default_factory=list)
    author: str | None = None
    created: str | None = None
    raw: dict[str, Any] = field(default_factory=dict)

    @property
    def area(self) -> str:
        return self.id.split(".", 1)[0]


@dataclass
class Milestone:
    id: str
    statement_id: str
    canonical_text: str
    audit: dict[str, Any]
    path: Path
    canonical_source: dict[str, str] | None = None
    phase: int | None = None
    raw: dict[str, Any] = field(default_factory=dict)


@dataclass
class Convention:
    id: str
    family: str
    title: str
    definition: str
    sources: list[Source]
    path: Path
    canonical: bool = False
    notes: str | None = None
    raw: dict[str, Any] = field(default_factory=dict)


@dataclass
class Graph:
    root: Path
    statements: dict[str, Statement] = field(default_factory=dict)
    derivations: dict[str, Derivation] = field(default_factory=dict)
    milestones: dict[str, Milestone] = field(default_factory=dict)
    conventions: dict[str, Convention] = field(default_factory=dict)
    areas: dict[str, str] = field(default_factory=dict)
    bib_keys: set[str] = field(default_factory=set)
    bib_duplicate_keys: list[str] = field(default_factory=list)
    # Populated by loader: raw dicts that failed to parse, with the error.
    load_errors: list[str] = field(default_factory=list)

    def derivations_for(self, statement_id: str) -> list[Derivation]:
        return [d for d in self.derivations.values() if d.target == statement_id]
