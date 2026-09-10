"""Tests for validation, propagation, and reporting on the seed graph and on synthetic graphs."""
from __future__ import annotations

import textwrap
from pathlib import Path

import pytest

from stringgraph.axioms import (
    STANDARD_AXIOMS,
    check_axioms,
    collect_decls,
    format_axioms_report,
    parse_output,
)
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


def test_seed_no_ghost_v4_drops_to_physical_argument_after_ddf_split() -> None:
    """无鬼定理 v4 的有效状态是 physical-argument，不是 rigorous。

    2026-09-11 拆卡（worldsheet.ddf-operators-v4 → v5 纯定义 + 三条命题）之前，
    两条 DDF 对易关系写在一张 ``kind: definition`` + ``status: rigorous`` 的卡的
    陈述文本里，于是以"定义的一部分"的身份把 rigorous 传播上来。
    拆开后它们各自挂 physical-argument 的推导（论证是 OPE + 围道形变，
    来源未核实到式号），无鬼定理的有效状态相应下降。

    **这是记账修正，不是论证退步**：推导 --via-goddard-thorn 自身仍标 rigorous。

    【2026-09-11 更新（分支 agent/curator/lattice-va）】新建格点顶点代数一族卡
    （math.lattice-vertex-algebra、worldsheet.free-boson-vertex-algebra-with-lightlike-momentum-tower、
    math.vertex-algebra-borcherds-identity、math.vertex-algebra-commutator-formula）之后，
    两条 G–N 顶点代数推导的桥接边不再 inferred 到 effective = open 的卡，于是
    **ddf-commute-with-virasoro 升到 rigorous**（走 --via-vertex-algebra-primary）。
    无鬼定理 v4 仍是 physical-argument，瓶颈换成了**内积/伴随那一层**的三条依赖
    （见下面的断言）——即 literature/extractions/math-sources.md Q36 记的那个缺口。

    【2026-09-11 再更新（分支 agent/curator/ddf-algebra-split）】
    worldsheet.ddf-transverse-oscillator-algebra 被拆为
    worldsheet.ddf-transverse-oscillator-algebra-v2（只含对易关系）与
    worldsheet.ddf-algebra-isomorphic-to-transverse-oscillators（末句的同构识别）。
    末句比较此前把 --via-zero-mode-bracket（own rigorous）压到 physical-argument，
    拆开后 **v2 升到 rigorous**，同构卡留在 physical-argument（本质上限：
    worldsheet.transverse-oscillator-commutators）。无鬼定理 v4 **仍是 physical-argument**，
    瓶颈只剩内积/伴随那一层的两条。
    """
    g = load_graph(ROOT)
    effs = compute_all(g)
    assert effs["worldsheet.no-ghost-theorem-v4"].name == "physical-argument"
    assert effs["worldsheet.no-ghost-theorem-v4"].conjectures == set()
    # 顶点代数路线已把这一条接通到 rigorous
    # 2026-09-11（六，分支 agent/curator/ddf-all-wire）：DDFOperatorAll.lean 的
    # lie_towerLop_ddfOp 把 ⁅L_m, A^ε_n⁆ = 0 证到**每个** m ∈ Z，新推导 --via-lean
    # 使本卡升为 formalized（此前是 rigorous，best_derivation 为 --via-vertex-algebra-primary）。
    # 无鬼定理 v4 的 effective **不变**，瓶颈换成别处（见下面的注释）。
    assert effs["worldsheet.ddf-commute-with-virasoro"].name == "formalized"
    # 剩下的瓶颈：横向振子代数（末句比较被 transverse-oscillator-commutators 压住）
    # 与内积/伴随那一层的两条
    # 拆卡后对易关系本身也接通到 rigorous（G–N 零模李括号路线）
    assert (
        effs["worldsheet.ddf-transverse-oscillator-algebra-v2"].name == "rigorous"
    )
    # 末句的同构识别留在 physical-argument：它本质依赖光锥侧那条链
    assert (
        effs["worldsheet.ddf-algebra-isomorphic-to-transverse-oscillators"].name
        == "physical-argument"
    )
    assert (
        effs["worldsheet.transverse-oscillator-commutators"].name
        == "physical-argument"
    )
    # 剩下的瓶颈：内积/伴随那一层的两条
    assert effs["worldsheet.ddf-operators-adjoint"].name == "physical-argument"
    assert (
        effs["worldsheet.transverse-ddf-fock-gram-matrix"].name == "physical-argument"
    )
    # 纯定义卡本身不受影响
    assert effs["worldsheet.ddf-operators-v5"].name == "rigorous"


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


def test_ddf_operators_v4_split_into_v5_plus_propositions() -> None:
    """ddf-operators-v4 被 v5 取代（2026-09-11 拆卡）。

    v4 是"一卡三事"（定义 + 两条对易关系），拆成一张纯定义卡 v5 与三条命题：
    [L_m, A^i_n] = 0、[A^i_m, A^j_n] = m δδ、以及横向性 ⟹ 模态和局部有限。
    v3 → v4 的旧链条不动（v3 的 superseded_by 仍指向 v4）。
    v5 其后又被 v6 取代（模态和定义），见 test_ddf_operators_v6_is_the_lean_mode_sum_card。
    """
    g = load_graph(ROOT)
    assert (
        g.statements["worldsheet.ddf-operators-v4"].superseded_by
        == "worldsheet.ddf-operators-v5"
    )
    assert g.statements["worldsheet.ddf-operators-v5"].kind == "definition"
    for sid in (
        "worldsheet.ddf-commute-with-virasoro",
        # 2026-09-11（分支 agent/curator/ddf-algebra-split）：原 ...-algebra 已换代为 -v2
        "worldsheet.ddf-transverse-oscillator-algebra-v2",
    ):
        assert g.statements[sid].kind == "proposition"
        assert g.statements[sid].status is None, "命题的 status 由推导计算，不得手写"
        assert g.derivations_for(sid), f"{sid} 必须有推导"
    # 第三条命题（局部有限性）已换代到 -v2，见下一个测试
    assert (
        g.statements["worldsheet.ddf-transversality-gives-local-finiteness"].kind
        == "proposition"
    )
    # 无鬼定理的推导已就地换代：不再依赖 v4，改依赖当前定义卡 + 两条对易命题
    deriv = g.derivations["worldsheet.no-ghost-theorem-v4--via-goddard-thorn"]
    dep_ids = {d.id for d in deriv.depends_on}
    assert "worldsheet.ddf-operators-v4" not in dep_ids
    assert "worldsheet.ddf-operators-v5" not in dep_ids
    assert {
        "worldsheet.ddf-operators-v6",
        "worldsheet.ddf-commute-with-virasoro",
        "worldsheet.ddf-transverse-oscillator-algebra-v2",
    } <= dep_ids


def test_ddf_transverse_oscillator_algebra_split_into_v2_plus_isomorphism() -> None:
    """2026-09-11 拆卡（分支 agent/curator/ddf-algebra-split）。

    旧卡 worldsheet.ddf-transverse-oscillator-algebra 把两个命题捆在一起：
    (1) [A^i_m, A^j_n] = m δ^{ij} δ_{m+n,0}；(2) 末句「与世界面横向振子 α^i_n 的代数逐字同型」。
    (2) 把旧卡的每一条推导都拉到 worldsheet.transverse-oscillator-commutators
    （physical-argument）之下，是 --via-zero-mode-bracket（own rigorous）唯一剩下的上限。
    拆开后：v2 只含 (1) 且 effective = rigorous；同构卡承载 (2)，effective 仍是
    physical-argument（本质上限，不是记账问题）。
    """
    g = load_graph(ROOT)
    effs = compute_all(g)
    old = "worldsheet.ddf-transverse-oscillator-algebra"
    v2 = "worldsheet.ddf-transverse-oscillator-algebra-v2"
    iso = "worldsheet.ddf-algebra-isomorphic-to-transverse-oscillators"

    assert g.statements[old].superseded_by == v2
    assert g.statements[v2].superseded_by is None
    # 两条推导都改指 v2（git mv 改名），故旧卡没有推导
    assert not g.derivations_for(old)
    assert {d.id for d in g.derivations_for(v2)} == {
        f"{v2}--via-zero-mode-bracket",
        f"{v2}--via-conformal-weight",
    }
    assert effs[v2].name == "rigorous"

    # v2 的两条推导都不再依赖光锥横向振子代数：那条边只承载被拆掉的末句
    for d in g.derivations_for(v2):
        assert "worldsheet.transverse-oscillator-commutators" not in {
            x.id for x in d.depends_on
        }

    # 同构卡：承载末句，依赖两侧各一条对易关系，且两条边都不是 inferred
    assert g.statements[iso].kind == "proposition"
    assert g.statements[iso].status is None
    iso_der = g.derivations[f"{iso}--via-commutation-relations"]
    assert {x.id for x in iso_der.depends_on} == {
        v2,
        "worldsheet.transverse-oscillator-commutators",
    }
    assert all(not x.inferred for x in iso_der.depends_on)
    assert effs[iso].name == "physical-argument"

    # 无鬼定理 v4 只用对易关系，不用同构（其 (1b) 的 H^⊥(k) 是用 DDF 振子定义的）
    gt = g.derivations["worldsheet.no-ghost-theorem-v4--via-goddard-thorn"]
    gt_deps = {x.id for x in gt.depends_on}
    assert v2 in gt_deps
    assert old not in gt_deps
    assert iso not in gt_deps


def test_ddf_operators_v6_is_the_lean_mode_sum_card() -> None:
    """ddf-operators-v5 被 v6 取代（2026-09-11，lead 裁决）。

    v5 用围道积分定义 A^i_n，Lean 里没有对应物；v6 改用模态和
    A^ε_n = Σ_m (ε·α_m) V^{(n)}_m，与 `StringFormal.NoGhost.ddfOp` 逐句对应，
    横向性 ε·k_0 = 0 是定义的参数（Lean `hεb` 是 `ddfOp` 的显式参数）。
    图中不得再有指向 v5 的 depends_on 边。
    """
    g = load_graph(ROOT)
    effs = compute_all(g)
    assert (
        g.statements["worldsheet.ddf-operators-v5"].superseded_by
        == "worldsheet.ddf-operators-v6"
    )
    v6 = g.statements["worldsheet.ddf-operators-v6"]
    assert v6.superseded_by is None
    assert v6.kind == "definition"
    assert v6.status == "formalized"
    assert v6.formal is not None
    assert v6.formal.get("lean_decl") == "StringFormal.NoGhost.ddfOp"
    assert effs["worldsheet.ddf-operators-v6"].name == "formalized"
    for d in g.derivations.values():
        assert "worldsheet.ddf-operators-v5" not in {
            dep.id for dep in d.depends_on
        }, f"{d.id} 仍依赖已被取代的 ddf-operators-v5"



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
        "worldsheet.critical-dimension-light-cone-v2",
        "worldsheet.critical-dimension-brst-v2",
    }


# ---------------------------------------------------------------- bib


def test_duplicate_bib_key_is_error(mini: Path) -> None:
    bib = mini / "literature" / "sources.bib"
    extra = "@article{ref-a,\n title={A again}\n}\n"
    bib.write_text(bib.read_text(encoding="utf-8") + "\n" + extra, encoding="utf-8")
    g = load_graph(mini)
    errors = [p for p in validate(g) if p.severity == "error"]
    assert any("duplicate bib key 'ref-a'" in str(e) for e in errors)


def test_report_hides_superseded_open_cards() -> None:
    g = load_graph(ROOT)
    rep = full_report(g)
    assert "worldsheet.no-ghost-theorem" not in rep["open_propositions"]
    assert any(x.startswith("worldsheet.no-ghost-theorem -> ") for x in rep["superseded"])


# ---------------------------------------------------------------- check-axioms
#
# The Lean subprocess is mocked everywhere below: pytest must not need a built Mathlib.
# The real run is `uv run stringgraph check-axioms` after `cd formal && lake build`.


@pytest.fixture
def mini_formal(mini: Path) -> Path:
    """`mini` plus two nodes carrying `formal.lean_decl` and one `formalized` derivation."""
    _write(mini, "formal/Fake.lean", "-- placeholder so validate's lean_file check passes\n")
    _write(
        mini,
        "graph/statements/worldsheet/def-f.yaml",
        """
        id: worldsheet.def-f
        kind: definition
        status: formalized
        title: F
        statement: a formalized definition
        sources: [{ref: ref-a, loc: "2"}]
        formal:
          lean_decl: Fake.decl_one
          lean_file: Fake.lean
        """,
    )
    _write(
        mini,
        "graph/statements/worldsheet/prop-g.yaml",
        """
        id: worldsheet.prop-g
        kind: proposition
        title: G
        statement: g holds
        sources: [{ref: ref-b, loc: "thm 2"}]
        formal:
          lean_decl: Fake.thm_two
          lean_file: Fake.lean
        """,
    )
    _write(
        mini,
        "graph/derivations/worldsheet/prop-g--via-lean.yaml",
        """
        id: worldsheet.prop-g--via-lean
        target: worldsheet.prop-g
        kind: proof
        status: formalized
        depends_on: [{id: worldsheet.def-f}]
        sources: [{ref: ref-b, loc: "thm 2"}]
        summary: by lean
        """,
    )
    return mini


def _fake_runner(lines: list[str], code: int = 0, stderr: str = ""):
    """Stand-in for the Lean subprocess; records the names it was asked about."""

    def run(root: Path, decls: list[str]) -> tuple[int, str, str]:
        run.decls = list(decls)  # type: ignore[attr-defined]
        return code, "".join(f"{ln}\n" for ln in lines), stderr

    run.decls = []  # type: ignore[attr-defined]
    return run


def test_mini_formal_validates(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    errors = [p for p in validate(g) if p.severity == "error"]
    assert not errors, "\n".join(str(e) for e in errors)


def test_parse_output_reads_ok_bad_missing() -> None:
    text = (
        "# check_axioms: 4 declaration(s), imports: StringFormal\n"
        "# standard axioms: propext Classical.choice Quot.sound\n"
        "ok\tA.one\tpropext Classical.choice Quot.sound\n"
        "ok\tA.two\t\n"
        "bad\tA.three\tsorryAx propext\n"
        "missing\tA.four\tno such constant in the imported environment\n"
        "\n"
        "# summary: ok=2 bad=1 missing=1\n"
    )
    results = {r.decl: r for r in parse_output(text)}
    assert set(results) == {"A.one", "A.two", "A.three", "A.four"}
    assert results["A.one"].status == "ok"
    assert results["A.one"].axioms == list(STANDARD_AXIOMS)
    assert results["A.one"].nonstandard == []
    assert results["A.two"].axioms == []
    assert results["A.three"].status == "bad"
    assert results["A.three"].nonstandard == ["sorryAx"]
    assert results["A.four"].status == "missing"
    assert results["A.four"].axioms == []


def test_collect_decls_maps_decls_to_nodes(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    uses = {u.decl: u for u in collect_decls(g)}
    assert set(uses) == {"Fake.decl_one", "Fake.thm_two"}
    assert uses["Fake.decl_one"].statements == ["worldsheet.def-f"]
    assert uses["Fake.decl_one"].lean_files == ["Fake.lean"]
    assert uses["Fake.decl_one"].formalized_derivations == []
    assert uses["Fake.thm_two"].formalized_derivations == ["worldsheet.prop-g--via-lean"]
    # only the declaration a `formalized` derivation rests on
    assert [u.decl for u in collect_decls(g, formalized_only=True)] == ["Fake.thm_two"]


def test_check_axioms_clean_run(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    runner = _fake_runner(
        [
            "# check_axioms: 2 declaration(s), imports: StringFormal",
            "ok\tFake.decl_one\tpropext",
            "ok\tFake.thm_two\tpropext Classical.choice Quot.sound",
        ]
    )
    rep = check_axioms(g, runner=runner)
    assert runner.decls == ["Fake.decl_one", "Fake.thm_two"]
    assert rep["exit_code"] == 0
    assert rep["problems"] == []
    assert rep["counts"] == {"checked": 2, "ok": 2, "bad": 0, "missing": 0}
    # stable JSON keys for agent consumption
    assert set(rep) >= {
        "command",
        "cwd",
        "standard_axioms",
        "declarations",
        "counts",
        "problems",
        "exit_code",
    }
    entry = rep["declarations"][1]
    assert set(entry) == {
        "decl",
        "status",
        "axioms",
        "detail",
        "statements",
        "lean_files",
        "formalized_derivations",
    }
    assert entry["decl"] == "Fake.thm_two"
    assert entry["formalized_derivations"] == ["worldsheet.prop-g--via-lean"]
    assert "2 declarations checked: 2 ok" in format_axioms_report(rep)


def test_check_axioms_sorry_maps_to_statement_and_derivation(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    runner = _fake_runner(
        ["ok\tFake.decl_one\tpropext", "bad\tFake.thm_two\tpropext sorryAx"],
        code=1,
    )
    rep = check_axioms(g, runner=runner)
    assert rep["exit_code"] == 1
    assert rep["counts"]["bad"] == 1
    wheres = {p["where"] for p in rep["problems"]}
    assert "graph/statements/worldsheet/prop-g.yaml" in wheres
    assert "graph/derivations/worldsheet/prop-g--via-lean.yaml" in wheres
    assert all(p["severity"] == "error" for p in rep["problems"])
    assert any("sorryAx" in p["message"] for p in rep["problems"])
    assert any("downgrade this derivation" in p["message"] for p in rep["problems"])
    # the clean declaration produces no problem
    assert not any("Fake.decl_one" in p["message"] for p in rep["problems"])
    assert "non-standard: sorryAx" in format_axioms_report(rep)


def test_check_axioms_missing_decl_is_error(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    runner = _fake_runner(
        [
            "missing\tFake.decl_one\tno such constant in the imported environment",
            "ok\tFake.thm_two\tpropext",
        ],
        code=1,
    )
    rep = check_axioms(g, runner=runner)
    assert rep["exit_code"] == 1
    assert rep["counts"]["missing"] == 1
    msgs = [
        p["message"] for p in rep["problems"] if p["where"] == "graph/statements/worldsheet/def-f.yaml"
    ]
    assert msgs and "is not a declaration in the built environment" in msgs[0]
    # a missing declaration has no axiom list; its detail is shown as a note
    assert "note: no such constant" in format_axioms_report(rep)


def test_check_axioms_no_verdict_for_a_requested_decl_is_error(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    rep = check_axioms(g, runner=_fake_runner(["ok\tFake.decl_one\tpropext"]))
    assert rep["exit_code"] == 1
    assert any("no verdict for 'Fake.thm_two'" in p["message"] for p in rep["problems"])
    assert rep["declarations"][1]["status"] == "no-result"


def test_check_axioms_reports_unexpected_status(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    runner = _fake_runner(["weird\tFake.decl_one\t", "ok\tFake.thm_two\tpropext"])
    rep = check_axioms(g, runner=runner)
    assert rep["exit_code"] == 1
    assert any("unexpected status 'weird'" in p["message"] for p in rep["problems"])


def test_check_axioms_without_lean_toolchain_exits_2(mini_formal: Path) -> None:
    g = load_graph(mini_formal)

    def boom(root: Path, decls: list[str]) -> tuple[int, str, str]:
        raise FileNotFoundError("lake")

    rep = check_axioms(g, runner=boom)
    assert rep["exit_code"] == 2
    assert rep["problems"] and "cannot run the checker" in rep["problems"][0]["message"]


def test_check_axioms_crash_without_output_exits_2(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    runner = _fake_runner([], code=1, stderr="uncaught exception: unknown package 'StringFormal'")
    rep = check_axioms(g, runner=runner)
    assert rep["exit_code"] == 2
    assert any("without producing any result line" in p["message"] for p in rep["problems"])


def test_check_axioms_decl_filter_accepts_names_absent_from_the_graph(mini_formal: Path) -> None:
    g = load_graph(mini_formal)
    runner = _fake_runner(
        ["ok\tFake.thm_two\tpropext", "missing\tOther.decl\tno such constant"], code=1
    )
    rep = check_axioms(g, only=["Fake.thm_two", "Other.decl"], runner=runner)
    assert runner.decls == ["Fake.thm_two", "Other.decl"]
    assert rep["counts"]["checked"] == 2
    assert any(p["where"] == "formal.lean_decl Other.decl" for p in rep["problems"])


def test_seed_graph_decls_point_at_the_lean_island() -> None:
    """The real graph's `lean_decl` names are collected and attached to their nodes."""
    g = load_graph(ROOT)
    uses = {u.decl: u for u in collect_decls(g)}
    assert "StringFormal.NoGhost.Fock.lie_Lop_Lop" in uses
    assert (
        "worldsheet.free-boson-central-charge-d"
        in uses["StringFormal.NoGhost.Fock.lie_Lop_Lop"].statements
    )
    assert all(u.decl.startswith("StringFormal.") for u in uses.values())
    formalized = collect_decls(g, formalized_only=True)
    assert formalized and all(u.formalized_derivations for u in formalized)


def test_report_formalization_frontier(mini: Path) -> None:
    """def-a formalized with a Lean decl; prop-b (rigorous, depends only on def-a) is on the frontier."""
    _write(mini, "formal/StringFormal/X.lean", "-- stub")
    _write(
        mini,
        "graph/statements/worldsheet/def-a.yaml",
        """
        id: worldsheet.def-a
        kind: definition
        status: formalized
        title: A
        statement: a definition
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: "1"}]
        formal: {lean_decl: X.a, lean_file: StringFormal/X.lean}
        """,
    )
    g = load_graph(mini)
    rep = full_report(g)
    assert "worldsheet.prop-b" in rep["formalization_frontier"]
    assert "worldsheet.def-a" not in rep["formalization_frontier"]
    assert rep["counts"]["by_area"]["worldsheet"] == 2


def test_swallowed_yaml_item_in_string_warns(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/worldsheet/def-a.yaml",
        """
        id: worldsheet.def-a
        kind: definition
        status: rigorous
        title: A
        statement: a definition
        uses_conventions: [conv.metric-plus]
        sources:
          - ref: ref-a
            loc: "1"
            note: |
              first note
              - ref: ref-b
                loc: "swallowed"
        """,
    )
    g = load_graph(mini)
    warns = [p for p in validate(g) if p.severity == "warning" and "swallowed" in str(p)]
    assert warns


def test_status_report_lists_each_derivation_with_own_and_effective(tmp_path):
    """own_status is the max over derivations; the per-derivation list must expose that a
    rigorous derivation can be throttled below its own status by a dependency.

    2026-09-11 (branch agent/curator/lattice-va): the throttled example used to be
    ddf-commute-with-virasoro--via-vertex-algebra-primary (own=rigorous, effective=open,
    bridge edge inferred to an open card). That bridge is now wired to
    worldsheet.free-boson-vertex-algebra-with-lightlike-momentum-tower, so this derivation
    reaches rigorous. The throttling behaviour was then exercised by its sibling
    ddf-transverse-oscillator-algebra--via-zero-mode-bracket, which stayed at
    physical-argument because the target statement's closing comparison dragged in
    worldsheet.transverse-oscillator-commutators.

    2026-09-11 (branch agent/curator/ddf-algebra-split): that closing comparison has been
    split off into worldsheet.ddf-algebra-isomorphic-to-transverse-oscillators, so
    ...-algebra-v2--via-zero-mode-bracket now reaches rigorous too. The throttled example is
    now transverse-ddf-fock-gram-matrix--via-oscillator-recursion (own=rigorous: the Gram
    recursion is a finite induction; effective=physical-argument because its hypothesis (H2)
    is cashed in by worldsheet.ddf-operators-adjoint).
    """
    from stringgraph.loader import load_graph
    from stringgraph.report import status_report

    g = load_graph(ROOT)

    # (a) two derivations on one statement: the report takes the strongest one
    rep = status_report(g, "worldsheet.ddf-commute-with-virasoro")
    ders = {d["id"]: d for d in rep["derivations"]}
    assert "worldsheet.ddf-commute-with-virasoro--via-vertex-algebra-primary" in ders
    assert "worldsheet.ddf-commute-with-virasoro--via-conformal-weight" in ders
    d = ders["worldsheet.ddf-commute-with-virasoro--via-vertex-algebra-primary"]
    assert d["own"] == "rigorous"
    assert d["effective"] == "rigorous"
    assert ders["worldsheet.ddf-commute-with-virasoro--via-conformal-weight"][
        "effective"
    ] == "physical-argument"
    # 2026-09-11（六，分支 agent/curator/ddf-all-wire）：新增 --via-lean（formalized，
    # lie_towerLop_ddfOp，一切 m）后本卡的 effective 升到 formalized；
    # --via-vertex-algebra-primary 仍是 rigorous、--via-conformal-weight 仍是 physical-argument，
    # 上面那几条「多条推导取最强者」的断言因此仍然被这张卡检验着。
    assert rep["effective"] == "formalized"

    # (a') the same two-derivation pattern after the ddf-algebra split: the zero-mode
    # bracket route (rigorous) now wins over the OPE/contour route (physical-argument)
    rep_v2 = status_report(g, "worldsheet.ddf-transverse-oscillator-algebra-v2")
    ders_v2 = {d["id"]: d for d in rep_v2["derivations"]}
    dz = ders_v2["worldsheet.ddf-transverse-oscillator-algebra-v2--via-zero-mode-bracket"]
    assert dz["own"] == "rigorous"
    assert dz["effective"] == "rigorous"
    assert ders_v2[
        "worldsheet.ddf-transverse-oscillator-algebra-v2--via-conformal-weight"
    ]["effective"] == "physical-argument"
    assert rep_v2["effective"] == "rigorous"

    # (b) own > effective is still exposed per-derivation
    rep2 = status_report(g, "worldsheet.transverse-ddf-fock-gram-matrix")
    ders2 = {d["id"]: d for d in rep2["derivations"]}
    d2 = ders2["worldsheet.transverse-ddf-fock-gram-matrix--via-oscillator-recursion"]
    assert d2["own"] == "rigorous"
    assert d2["effective"] == "physical-argument"
    assert rep2["effective"] == "physical-argument"


def test_validate_warns_when_derivation_target_is_superseded():
    from stringgraph.validate import validate

    g = load_graph(ROOT)
    msgs = [p.message for p in validate(g) if p.severity == "warning" and "is superseded by" in p.message]
    # duality.ads-cft is superseded by holography.ads5-cft4-duality-v2 and still has a derivation
    assert any("duality.ads-cft" in m for m in msgs)
