"""Tests for validation, propagation, and reporting on the seed graph and on synthetic graphs."""
from __future__ import annotations

import textwrap
from pathlib import Path

import pytest

from stringgraph.loader import find_project_root, load_graph
from stringgraph.propagate import compute_all
from stringgraph.report import format_why, full_report, search, why_report
from stringgraph.validate import validate

ROOT = find_project_root(Path(__file__).parent)


def _write(root: Path, rel: str, body: str) -> None:
    p = root / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(textwrap.dedent(body).lstrip(), encoding="utf-8")


@pytest.fixture
def mini(tmp_path: Path) -> Path:
    """A minimal valid project: schema copied from the real one, small synthetic graph."""
    schema_src = ROOT / "graph" / "schema"
    for f in schema_src.iterdir():
        _write(tmp_path, f"graph/schema/{f.name}", f.read_text(encoding="utf-8"))
    _write(tmp_path, "literature/sources.bib", "@book{ref-a,\n title={A}\n}\n@article{ref-b,\n title={B}\n}\n")
    _write(
        tmp_path,
        "graph/conventions/metric-plus.yaml",
        """
        id: conv.metric-plus
        family: metric
        title: plus
        definition: mostly plus
        canonical: true
        sources: [{ref: ref-a}]
        """,
    )
    _write(
        tmp_path,
        "graph/conventions/metric-minus.yaml",
        """
        id: conv.metric-minus
        family: metric
        title: minus
        definition: mostly minus
        canonical: false
        sources: [{ref: ref-a}]
        """,
    )
    _write(
        tmp_path,
        "graph/statements/worldsheet/def-a.yaml",
        """
        id: worldsheet.def-a
        kind: definition
        status: rigorous
        title: A
        statement: a definition
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    _write(
        tmp_path,
        "graph/statements/worldsheet/prop-b.yaml",
        """
        id: worldsheet.prop-b
        kind: proposition
        title: B
        statement: b follows from a
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-b, loc: "thm 1"}]
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/worldsheet/prop-b--via-a.yaml",
        """
        id: worldsheet.prop-b--via-a
        target: worldsheet.prop-b
        kind: proof
        status: rigorous
        depends_on: [{id: worldsheet.def-a}]
        sources: [{ref: ref-b, loc: "thm 1"}]
        summary: direct
        """,
    )
    _write(
        tmp_path,
        "graph/statements/duality/conj-c.yaml",
        """
        id: duality.conj-c
        kind: proposition
        title: C
        statement: a conjecture
        sources: [{ref: ref-b, loc: "sec 2"}]
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/duality/conj-c--via-checks.yaml",
        """
        id: duality.conj-c--via-checks
        target: duality.conj-c
        kind: conjecture-support
        status: conjecture
        depends_on: [{id: worldsheet.prop-b}]
        sources: [{ref: ref-b}]
        summary: many checks
        """,
    )
    _write(
        tmp_path,
        "graph/statements/duality/prop-d.yaml",
        """
        id: duality.prop-d
        kind: proposition
        title: D
        statement: rigorous given C
        sources: [{ref: ref-b, loc: "thm 3"}]
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/duality/prop-d--via-c.yaml",
        """
        id: duality.prop-d--via-c
        target: duality.prop-d
        kind: proof
        status: rigorous
        depends_on: [{id: duality.conj-c}]
        sources: [{ref: ref-b, loc: "thm 3"}]
        summary: assumes C
        """,
    )
    return tmp_path


# ---------------------------------------------------------------- seed graph


def test_seed_graph_validates() -> None:
    g = load_graph(ROOT)
    problems = validate(g)
    errors = [p for p in problems if p.severity == "error"]
    assert not errors, "\n".join(str(e) for e in errors)


def test_seed_no_ghost_v4_is_rigorous_with_inferred_kac() -> None:
    g = load_graph(ROOT)
    effs = compute_all(g)
    assert effs["worldsheet.no-ghost-theorem-v4"].name == "rigorous"
    assert effs["worldsheet.no-ghost-theorem-v4"].conjectures == set()


def test_superseded_no_ghost_v2_points_to_v3_but_keeps_its_derivation() -> None:
    """v2 被 v3 取代（第二轮审计 B1/B2/B3：逐动量塔表述、能级 N 分级、记号统一）。

    与 v1 不同，v2 的推导 --via-goddard-thorn 保留作历史，故 v2 的有效状态仍是 rigorous；
    ddf-operators-v2 同时被 v3 取代（审计 C2：一般 α' 下归一化是 2α' k_0·p = 1）。
    """
    g = load_graph(ROOT)
    effs = compute_all(g)
    assert (
        g.statements["worldsheet.no-ghost-theorem-v2"].superseded_by
        == "worldsheet.no-ghost-theorem-v3"
    )
    assert (
        g.statements["worldsheet.ddf-operators-v2"].superseded_by
        == "worldsheet.ddf-operators-v3"
    )
    assert g.derivations_for("worldsheet.no-ghost-theorem-v2")
    assert effs["worldsheet.no-ghost-theorem-v2"].name == "rigorous"


def test_superseded_no_ghost_v3_points_to_v4_but_keeps_its_derivation() -> None:
    """v3 被 v4 取代（第三轮审计 B1：第 (2) 条缺动量量词；A1：DDF 射线/标度符号矛盾）。

    与 v2 同理，v3 的推导 --via-goddard-thorn 保留作历史，故 v3 的有效状态仍是 rigorous；
    ddf-operators-v3 同时被 v4 取代（射线 {λ k_0 : λ > 0} → 去心直线 {λ k_0 : λ ∈ R \\ {0}}）。
    """
    g = load_graph(ROOT)
    effs = compute_all(g)
    assert (
        g.statements["worldsheet.no-ghost-theorem-v3"].superseded_by
        == "worldsheet.no-ghost-theorem-v4"
    )
    assert (
        g.statements["worldsheet.ddf-operators-v3"].superseded_by
        == "worldsheet.ddf-operators-v4"
    )
    assert g.derivations_for("worldsheet.no-ghost-theorem-v3")
    assert effs["worldsheet.no-ghost-theorem-v3"].name == "rigorous"
    # v4 未被取代，是当前的活节点
    assert g.statements["worldsheet.no-ghost-theorem-v4"].superseded_by is None
    assert g.statements["worldsheet.ddf-operators-v4"].superseded_by is None


def test_brst_ocq_equivalence_has_two_independent_derivations() -> None:
    """lead 2026-09-10 裁决：LZ 1991 Thm 3.5(i) 从 --via-fgz 的 sources 拆成独立推导。

    两条推导都是 rigorous 的 proof，故目标陈述仍是 rigorous；
    拆分后 --via-fgz 的 sources 里不应再出现 lian-zuckerman-1991。
    """
    g = load_graph(ROOT)
    derivs = {
        d.id: d for d in g.derivations_for("worldsheet.brst-cohomology-equals-ocq-physical")
    }
    assert "worldsheet.brst-cohomology-equals-ocq-physical--via-fgz" in derivs
    assert "worldsheet.brst-cohomology-equals-ocq-physical--via-lian-zuckerman" in derivs
    fgz = derivs["worldsheet.brst-cohomology-equals-ocq-physical--via-fgz"]
    lz = derivs["worldsheet.brst-cohomology-equals-ocq-physical--via-lian-zuckerman"]
    assert {s.ref for s in fgz.sources}.isdisjoint({"lian-zuckerman-1991"})
    assert "lian-zuckerman-1991" in {s.ref for s in lz.sources}
    effs = compute_all(g)
    assert effs["worldsheet.brst-cohomology-equals-ocq-physical"].name == "rigorous"


def test_milestone_no_ghost_points_at_v4() -> None:
    """里程碑 ms.no-ghost-theorem 跟随陈述换代指向 v4（第四轮回译前 audit.status 为 draft）。"""
    g = load_graph(ROOT)
    ms = g.milestones["ms.no-ghost-theorem"]
    assert ms.statement_id == "worldsheet.no-ghost-theorem-v4"
    assert ms.statement_id in g.statements


def test_superseded_no_ghost_v1_is_open() -> None:
    """旧节点被 v2 取代（审计 B1：第 (3) 条为假），不再挂推导，效状态 open 是预期结果。"""
    g = load_graph(ROOT)
    effs = compute_all(g)
    assert g.statements["worldsheet.no-ghost-theorem"].superseded_by == "worldsheet.no-ghost-theorem-v2"
    assert not g.derivations_for("worldsheet.no-ghost-theorem")
    assert effs["worldsheet.no-ghost-theorem"].name == "open"


def test_seed_ads_cft_is_conjecture() -> None:
    g = load_graph(ROOT)
    effs = compute_all(g)
    assert effs["duality.ads-cft"].name == "conjecture"


# ---------------------------------------------------------------- propagation


def test_propagation_min_over_chain(mini: Path) -> None:
    g = load_graph(mini)
    assert not [p for p in validate(g) if p.severity == "error"]
    effs = compute_all(g)
    assert effs["worldsheet.def-a"].name == "rigorous"
    assert effs["worldsheet.prop-b"].name == "rigorous"
    assert effs["duality.conj-c"].name == "conjecture"
    # D has a rigorous derivation but rests on C: effective must degrade.
    assert effs["duality.prop-d"].name == "conjecture"
    assert effs["duality.prop-d"].conjectures == {"duality.conj-c"}


def test_best_of_multiple_derivations(mini: Path) -> None:
    _write(
        mini,
        "graph/derivations/duality/conj-c--via-proof.yaml",
        """
        id: duality.conj-c--via-proof
        target: duality.conj-c
        kind: proof
        status: rigorous
        depends_on: [{id: worldsheet.def-a}]
        sources: [{ref: ref-b, loc: "thm 9"}]
        summary: someone proved it
        """,
    )
    g = load_graph(mini)
    effs = compute_all(g)
    assert effs["duality.conj-c"].name == "rigorous"
    assert effs["duality.prop-d"].name == "rigorous"
    assert effs["duality.prop-d"].conjectures == set()


def test_refutation_wins(mini: Path) -> None:
    _write(
        mini,
        "graph/derivations/duality/conj-c--via-counterexample.yaml",
        """
        id: duality.conj-c--via-counterexample
        target: duality.conj-c
        kind: refutation
        status: rigorous
        depends_on: [{id: worldsheet.def-a}]
        sources: [{ref: ref-b, loc: "thm 10"}]
        summary: explicit counterexample
        """,
    )
    g = load_graph(mini)
    effs = compute_all(g)
    assert effs["duality.conj-c"].name == "refuted"
    assert effs["duality.prop-d"].name == "refuted"


def test_axiom_tracked_in_assumes(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/duality/ax-e.yaml",
        """
        id: duality.ax-e
        kind: axiom
        status: rigorous
        title: E
        statement: assumed
        sources: [{ref: ref-b, loc: "sec 0"}]
        """,
    )
    _write(
        mini,
        "graph/derivations/duality/prop-d--via-axiom.yaml",
        """
        id: duality.prop-d--via-axiom
        target: duality.prop-d
        kind: proof
        status: rigorous
        depends_on: [{id: duality.ax-e}]
        sources: [{ref: ref-b, loc: "thm 3"}]
        summary: from the axiom
        """,
    )
    g = load_graph(mini)
    effs = compute_all(g)
    # Both derivations are level rigorous; the axiom one has assumes.
    assert effs["duality.prop-d"].name == "rigorous"
    assert effs["duality.prop-d"].assumes == {"duality.ax-e"}


# ---------------------------------------------------------------- validation rules


def _errors(root: Path) -> list[str]:
    return [p.message for p in validate(load_graph(root)) if p.severity == "error"]


def test_cycle_detected(mini: Path) -> None:
    _write(
        mini,
        "graph/derivations/worldsheet/prop-b--via-d.yaml",
        """
        id: worldsheet.prop-b--via-d
        target: worldsheet.prop-b
        kind: proof
        status: rigorous
        depends_on: [{id: duality.prop-d}]
        sources: [{ref: ref-b}]
        summary: circular
        """,
    )
    assert any("cycle" in e for e in _errors(mini))


def test_unknown_source_ref(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/worldsheet/def-z.yaml",
        """
        id: worldsheet.def-z
        kind: definition
        status: rigorous
        title: Z
        statement: z
        sources: [{ref: nope-2000, loc: "1"}]
        """,
    )
    assert any("nope-2000" in e for e in _errors(mini))


def test_proposition_must_not_declare_status(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/worldsheet/prop-y.yaml",
        """
        id: worldsheet.prop-y
        kind: proposition
        status: rigorous
        title: Y
        statement: y
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    assert any("must not declare `status`" in e for e in _errors(mini))


def test_path_must_match_id(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/worldsheet/wrong-name.yaml",
        """
        id: worldsheet.def-x
        kind: definition
        status: rigorous
        title: X
        statement: x
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    assert any("file path must be" in e for e in _errors(mini))


def test_convention_conflict_requires_map(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/worldsheet/def-minus.yaml",
        """
        id: worldsheet.def-minus
        kind: definition
        status: rigorous
        title: M
        statement: in mostly minus
        uses_conventions: [conv.metric-minus]
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    _write(
        mini,
        "graph/derivations/worldsheet/prop-b--via-minus.yaml",
        """
        id: worldsheet.prop-b--via-minus
        target: worldsheet.prop-b
        kind: proof
        status: rigorous
        depends_on: [{id: worldsheet.def-minus}]
        sources: [{ref: ref-b}]
        summary: mixes conventions
        """,
    )
    assert any("convention conflict" in e for e in _errors(mini))
    # Adding a convention_map clears it.
    _write(
        mini,
        "graph/derivations/worldsheet/prop-b--via-minus.yaml",
        """
        id: worldsheet.prop-b--via-minus
        target: worldsheet.prop-b
        kind: proof
        status: rigorous
        depends_on: [{id: worldsheet.def-minus, convention_map: "eta -> -eta"}]
        sources: [{ref: ref-b}]
        summary: mixes conventions
        """,
    )
    assert not any("convention conflict" in e for e in _errors(mini))


def test_two_canonical_in_family_rejected(mini: Path) -> None:
    _write(
        mini,
        "graph/conventions/metric-minus.yaml",
        """
        id: conv.metric-minus
        family: metric
        title: minus
        definition: mostly minus
        canonical: true
        sources: [{ref: ref-a}]
        """,
    )
    assert any("more than one canonical" in e for e in _errors(mini))


def test_approved_milestone_requires_faithful_back_translation(mini: Path) -> None:
    _write(
        mini,
        "graph/milestones/prop-b.yaml",
        """
        id: ms.prop-b
        statement_id: worldsheet.prop-b
        canonical_text: B holds
        audit:
          status: approved
          captain: someone
          approved_on: "2026-09-10"
        """,
    )
    errs = _errors(mini)
    assert any("requires audit.back_translation" in e for e in errs)


def test_milestone_rejects_non_canonical_convention(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/worldsheet/def-minus.yaml",
        """
        id: worldsheet.def-minus
        kind: definition
        status: rigorous
        title: M
        statement: in mostly minus
        uses_conventions: [conv.metric-minus]
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    _write(
        mini,
        "graph/milestones/def-minus.yaml",
        """
        id: ms.def-minus
        statement_id: worldsheet.def-minus
        canonical_text: M
        audit: {status: draft}
        """,
    )
    assert any("non-canonical convention" in e for e in _errors(mini))


def test_formalized_requires_lean_decl(mini: Path) -> None:
    _write(
        mini,
        "graph/derivations/worldsheet/prop-b--via-lean.yaml",
        """
        id: worldsheet.prop-b--via-lean
        target: worldsheet.prop-b
        kind: proof
        status: formalized
        depends_on: [{id: worldsheet.def-a}]
        sources: [{ref: ref-b}]
        summary: in Lean
        """,
    )
    assert any("requires target.formal.lean_decl" in e for e in _errors(mini))


# ---------------------------------------------------------------- report / search


def test_report_lists_conjecture_dependencies(mini: Path) -> None:
    _write(
        mini,
        "graph/milestones/prop-d.yaml",
        """
        id: ms.prop-d
        statement_id: duality.prop-d
        canonical_text: D
        audit: {status: draft}
        """,
    )
    rep = full_report(load_graph(mini))
    ms = {m["id"]: m for m in rep["milestones"]}["ms.prop-d"]
    assert ms["effective"] == "conjecture"
    assert ms["conjectures_depended_on"] == ["duality.conj-c"]


def test_search_finds_by_title_and_statement(mini: Path) -> None:
    hits = search(load_graph(mini), ["conjecture"])
    assert any(sid == "duality.conj-c" for _, sid, _ in hits)


# ---------------------------------------------------------------- why


def test_why_points_at_bottleneck_dep(mini: Path) -> None:
    """prop-d has a rigorous derivation but rests on conj-c: `why` must descend into conj-c
    and stop there with the conjecture's own status as the bottleneck."""
    g = load_graph(mini)
    tree = why_report(g, "duality.prop-d")
    assert tree["effective"] == "conjecture"
    assert tree["own"] == "rigorous"
    assert [c["id"] for c in tree["children"]] == ["duality.conj-c"]
    leaf = tree["children"][0]
    assert leaf["effective"] == "conjecture"
    assert leaf["bottleneck"] == "own status conjecture"
    assert leaf["children"] == []
    text = format_why(tree)
    assert "duality.prop-d [conjecture]" in text
    assert "limited by 1 dep(s)" in text


def test_why_on_open_proposition(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/duality/prop-e.yaml",
        """
        id: duality.prop-e
        kind: proposition
        title: E
        statement: no derivation yet
        sources: [{ref: ref-a}]
        """,
    )
    g = load_graph(mini)
    tree = why_report(g, "duality.prop-e")
    assert tree["effective"] == "open"
    assert tree["bottleneck"] == "no derivation"


def test_why_seed_critical_dimension_names_three_routes() -> None:
    g = load_graph(ROOT)
    tree = why_report(g, "worldsheet.critical-dimension-bosonic")
    assert tree["effective"] == "physical-argument"
    assert tree["own"] == "rigorous"
    assert {c["id"] for c in tree["children"]} >= {
        "worldsheet.critical-dimension-light-cone",
        "worldsheet.critical-dimension-brst",
    }


# ---------------------------------------------------------------- bib


def test_duplicate_bib_key_is_error(mini: Path) -> None:
    bib = mini / "literature" / "sources.bib"
    extra = "@article{ref-a,\n title={A again}\n}\n"
    bib.write_text(bib.read_text(encoding="utf-8") + "\n" + extra, encoding="utf-8")
    g = load_graph(mini)
    errors = [p for p in validate(g) if p.severity == "error"]
    assert any("duplicate bib key 'ref-a'" in str(e) for e in errors)
