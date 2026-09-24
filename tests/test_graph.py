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
from stringgraph.report import (
    bottleneck_roots,
    counterfactual_report,
    force_rigorous,
    format_tied_derivations,
    format_why,
    full_report,
    greedy_root_cover,
    hitting_set_report,
    is_self_capped,
    search,
    tied_bottleneck_info,
    tied_effective_cards,
    tied_support_derivations,
    weak_active_ids,
    why_report,
)
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


# ⚠ 函数名是历史遗留：2026-09-25 起本用例断言的是 **rigorous**，不再是 physical-argument
#   （见函数体内 2026-09-25 一段）。名字不改，因为
#   graph/derivations/worldsheet/transverse-ddf-fock-gram-matrix--via-lean.yaml 与
#   graph/derivations/worldsheet/ddf-spans-physical-states-level-one--via-lean.yaml
#   的 notes 逐字引用了这个名字。
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

    【2026-09-12 再更新（分支 agent/curator/adjoint-wire）】
    formal/StringFormal/NoGhost/VertexAdjoint.lean（fb006f5）证出
    `Fock.pairing_vertexOsc_left`（⟨V(b)_K v, w⟩ = ⟨v, V(−b)_{−K} w⟩，**任意 b**）、
    `Fock.towerPairing_towerVertex_left` 与 `Fock.towerPairing_ddfOp_left`
    （(A^ε_n)† = A^ε_{−n}）。于是内积/伴随那一层的两条全部让开：
    worldsheet.ddf-operators-adjoint 换代为 -v2（只含伴随关系）并升为 **formalized**，
    worldsheet.transverse-ddf-fock-gram-matrix 随之升为 **rigorous**。
    无鬼定理 v4 **仍是 physical-argument**，但瓶颈树由三支收缩为一支：
    worldsheet.ddf-contour-equals-mode-sum（围道写法 ↔ 模态和写法的字典）。
    附带的数学结论：伴随**不需要** k_0² = 0，也没有「同点 E₊E₋ 重排序」这一步
    ——E₋E₊ 的伴随 E₊(−b)†E₋(−b)† 本身就是正规序。

    【2026-09-11 再更新（分支 agent/formalizer/ddf-algebra）】
    formal/StringFormal/NoGhost/DDFAlgebra.lean 的 `lie_ddfOp_ddfOp` 证出
    ⁅A^ε_m, A^δ_n⁆ = m (ε·δ) δ_{m+n,0}（一切 m,n ∈ ℤ，任意横向 ε、δ），
    于是 worldsheet.ddf-transverse-oscillator-algebra-v2 由 rigorous 升为 **formalized**
    （新推导 --via-lean；原有的 --via-zero-mode-bracket / --via-conformal-weight 保留）。
    DDF 侧的输入至此全部 formalized 或 rigorous（无鬼定理 v4 的 effective 见下一段第七轮裁决）。
    【2026-09-11 第七轮（分支 agent/auditor/noghost-contour，auditor 裁决）】
    worldsheet.ddf-contour-equals-mode-sum 那条边被裁定为**溯源记账而非证明步骤**并撤出
    --via-goddard-thorn 的 depends_on（summary 各步只用模态和算子的代数性质，图内所有
    DDF 性质卡均以 v6 模态和为对象）；围道 ↔ 模态和的忠实性备注移到
    ms.no-ghost-theorem 第七轮 R7-2。无鬼定理 v4 的 effective 因此回到 **rigorous**
    （= 推导自报 status，无压低依赖）；该字典卡本身仍是 physical-argument。
    【2026-09-11 第八轮（分支 agent/curator/small-backlog-12，依 formal/BLUEPRINT-noghost.md §A/§B.5/§D.3）】
    新卡 **worldsheet.gt-longitudinal-k-algebra**（Goddard 2008 (6.2)(6.3) 的 K_n = k_0·α_n 代数，
    推导 --via-mode-algebra 为 physical-argument：文献无证明、Lean 的 `towerK` 尚未落地）
    被接为 --via-goddard-thorn 的**非 inferred** 依赖（Goddard §6 逐字用 K_n 表述张成步）。
    无鬼定理 v4 的 effective 因此一度回到 physical-argument，瓶颈只有这一支。
    这是把此前隐含的输入显式化（推导 notes【（七）】早已自报「[K_m, A^ε_n] = 0 在图内无节点」），
    不是新弱点。**同日 formalizer-noghost-a 合入 main（6ed1638，Longitudinal.lean 的 `kOp` 与
    `lie_towerLop_kOp` 等）**，该卡接上 --via-lean 升为 **formalized**，无鬼定理 v4 回到 **rigorous**。
    同批在 --via-goddard-thorn 的 gaps 登记了 (B-26)：D = 26 唯一进入之处。

    【2026-09-15 更新（分支 agent/curator/noghost-ddf-wiring）——(B-26) 接线，effective 回落
    physical-argument】上面把 v4 拉回 rigorous 的每一步都只处理了 DDF／伴随／K_n 那一层。
    (B-26) 本身（「塔上任意物理态 = DDF 态 + 零模态」，即 H_phys ⊆ D(Ε) + H_null）自始至终**没有
    图内节点在 depends_on 里承载**：它只以文字形式记在 --via-goddard-thorn 的 gaps 与 summary 里，
    而 propagate 只读 depends_on，故对工具不可见——effective 虚高。
    本轮把该命题的已立陈述节点 worldsheet.ddf-spanning-hypothesis 接为本推导的
    **非 inferred** 依赖（来源是本推导 sources 已登记的 goddard-2008 §6 (6.4) 逐字）。
    该卡的 effective = physical-argument（最强推导 --via-borcherds-1992 被
    worldsheet.ddf-contour-equals-mode-sum 封顶），于是 v4 的 effective 诚实降为
    **physical-argument**，瓶颈链 = ddf-spanning-hypothesis → ddf-contour-equals-mode-sum。
    **这不是论证退步，也不是推翻第七轮撤围道边的裁决**（那条仍然只走溯源记账）：
    本边接入的是另一条此前只在 gaps 文字里的承重假设，里程碑 R8-3/R9-4 早已写明它就是猜想负担所在。

    【2026-09-22 更新（分支 agent/curator/ddf-spanning-intercept-premise）——承重卡换代到
    worldsheet.ddf-spanning-hypothesis-v2】旧卡 worldsheet.ddf-spanning-hypothesis 漏写了
    前件 η(v,v) = 0（v := a − b；在 (N)(S) 下即截距 a₀ = 1），因而逐字为假（D = 26, a₀ = 2
    的 (rung −1, level 1) 片上 dim H_phys 25 > dim D(Ε) 24 + dim H_null 0）。旧卡已 superseded，
    两条推导随 target 搬到 v2（validate 强制推导 id 以 target 开头，故 id 与文件名同时加 -v2）。
    本用例的断言随之改指 v2 卡：**v4 的 effective 与瓶颈链一字不变**，唯一移动的是旧卡自身
    掉到 open（换代的记账影子，旧卡已无节点依赖）。
    """
    g = load_graph(ROOT)
    effs = compute_all(g)
    # 2026-09-15：(B-26) 接线后，effective 由虚高的 rigorous 诚实落回 physical-argument。
    #
    # ⭐ 2026-09-25（lead）：**本断言值已变，且这一次是真实上移，不是记账修正。**
    # --via-goddard-thorn 的 (B-26) 依赖边由 worldsheet.ddf-spanning-hypothesis-v2
    # 改指 worldsheet.ddf-spanning-transverse-frame（本项目原创证明，rigorous：
    # research/attempts/tower-native-ddf-spanning 的 proof.md + proof-no-tprime.md，
    # 两轮独立对抗性审查 rev-tower-ddf / rev-no-tprime 均判 verified）。
    # 该推导自身 status 早已是 rigorous 且被且仅被这一条依赖压低，故边一换瓶颈即消失。
    # ⚠ 新卡**不蕴含也不取代 v2**：v2 卡面没有 (S) η(a,b) = 1，是真正更宽且仍未证的命题，
    #   (S) 不可删也不可弱化（A^b_n = (η(a,b) − 1)·S_n·V^{(n)}_{−n}，s = 2 一样坏）。
    #   下面两条关于 v2 与旧卡的断言因此**一字不动**，它们仍然成立。
    # ⚠ 新卡未形式化，本次上移**不**使 v4 成为 formalized；且模态和 ↔ 围道的桥
    #   （worldsheet.ddf-contour-equals-mode-sum，physical-argument）不在这条链上。
    assert effs["worldsheet.no-ghost-theorem-v4"].name == "rigorous"
    assert effs["worldsheet.no-ghost-theorem-v4"].conjectures == set()
    # 上一版承接猜想负担的节点仍在图上，effective 不变（本次改指没有碰它）
    # 2026-09-22：该节点换代为 -v2（旧卡缺截距前件、逐字为假）；effective 不变。
    assert effs["worldsheet.ddf-spanning-hypothesis-v2"].name == "physical-argument"
    # 2026-09-25 新增：承接本次上移的新卡，effective = rigorous（own rigorous、依赖全 formalized）
    assert effs["worldsheet.ddf-spanning-transverse-frame"].name == "rigorous"
    # 换代后旧卡无推导，诚实落到 open；它已 superseded 且无任何节点依赖，故对下游零影响。
    assert effs["worldsheet.ddf-spanning-hypothesis"].name == "open"
    # 2026-09-11 第八轮：K_n 代数卡经 Longitudinal.lean 为 formalized，不压低 v4（见 docstring 末段）
    assert effs["worldsheet.gt-longitudinal-k-algebra"].name == "formalized"
    gt8 = g.derivations["worldsheet.no-ghost-theorem-v4--via-goddard-thorn"]
    k_edge = [d for d in gt8.depends_on if d.id == "worldsheet.gt-longitudinal-k-algebra"]
    assert len(k_edge) == 1 and not k_edge[0].inferred
    # 顶点代数路线已把这一条接通到 rigorous
    # 2026-09-11（六，分支 agent/curator/ddf-all-wire）：DDFOperatorAll.lean 的
    # lie_towerLop_ddfOp 把 ⁅L_m, A^ε_n⁆ = 0 证到**每个** m ∈ Z，新推导 --via-lean
    # 使本卡升为 formalized（此前是 rigorous，best_derivation 为 --via-vertex-algebra-primary）。
    # 无鬼定理 v4 的 effective **不变**，瓶颈换成别处（见下面的注释）。
    assert effs["worldsheet.ddf-commute-with-virasoro"].name == "formalized"
    # 剩下的瓶颈：横向振子代数（末句比较被 transverse-oscillator-commutators 压住）
    # 与内积/伴随那一层的两条
    # 拆卡后对易关系本身接通到 rigorous（G–N 零模李括号路线）；
    # 2026-09-11（分支 agent/formalizer/ddf-algebra）DDFAlgebra.lean 的 lie_ddfOp_ddfOp
    # 再把它升为 formalized。
    assert (
        effs["worldsheet.ddf-transverse-oscillator-algebra-v2"].name == "formalized"
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
    # 剩下的瓶颈：2026-09-12（分支 agent/curator/adjoint-wire）之前是内积/伴随那一层的两条；
    # VertexAdjoint.lean（fb006f5）接线后它们都不再是瓶颈：
    #   · worldsheet.ddf-operators-adjoint 已 superseded_by -v2，v2 走 --via-lean
    #     （Fock.towerPairing_ddfOp_left）升为 formalized；
    #   · transverse-ddf-fock-gram-matrix 的前件 (H2) 因此不再被压低，升为 rigorous。
    # 于是 `why worldsheet.no-ghost-theorem-v4` 的瓶颈树由三支收缩为**一支**：
    # 围道写法 ↔ 模态和写法的字典。
    # 2026-09-11 第七轮：那一支也撤了（不是证明步骤，见上方 docstring），字典卡本身仍 physical-argument。
    assert effs["worldsheet.ddf-operators-adjoint-v2"].name == "formalized"
    # 2026-09-11 第九轮（分支 agent/curator/small-backlog-14，lead 追加项）：
    # formal/StringFormal/NoGhost/DDFGram.lean（分支 agent/formalizer/noghost-c4）把抽象的
    # StringFormal.gram_of_heisenberg_family（HeisenbergGram.lean，图上 math.heisenberg-family-gram-matrix）
    # 实例化到 DDF 算子上：ddf_gram_diagonal / ddf_span_pos / linearIndependent_ddfMonomial /
    # ddf_gram_of_level_ne，四条假设由 ddfFamily_ccr/_adj/_ann + Fock.towerPairing_towerVacuum_self 供给。
    # 于是 transverse-ddf-fock-gram-matrix 由 rigorous 升为 **formalized**（新推导 --via-lean；
    # 手写递推 --via-oscillator-recursion 保留并存）。本断言随之更新。
    # 无鬼定理 v4 的 effective **不变**（仍 rigorous，由自身 status 与 kac-determinant 一支决定）。
    assert effs["worldsheet.transverse-ddf-fock-gram-matrix"].name == "formalized"
    # 2026-09-15（分支 agent/curator/ddf-contour-rigorous）：新增推导
    # --via-voa-residue（own status: rigorous），依据 Gebert–Nicolai 1995 §3.1 (3.2)–(3.3)
    # 逐字把横向 DDF 写成 Res_z[ξ(z)𝒴(e^{mk},z)] = 零模，配合 Schottenloher Ch.10
    # Def 10.1/10.9/Thm 10.10(N=0) 与 Bakalov–Kac (2.22)。
    #
    # ⚠ 同日 graph-reviewer + lead 裁定首版的 effective=rigorous **虚高**并要求重建模：
    # 首版把「物理 :e^{ink_0X}: = VOA 𝒴(e^{nk},z)」这条**无源的实质识别**藏在一条
    # `inferred: true` 边里。但 propagate.py 的 _combine_deps 只按依赖的 effective level
    # 取下界、**不读 inferred 字段**，故依赖两端都 rigorous 时该 flag 对传播毫无影响——
    # 这条识别既承重又对 `why` 不可见。
    # 修正不是降 own（第 1–3 步的留数演算确实严格），而是把它提成显式节点
    # worldsheet.physical-exponential-equals-voa-vertex-operator（physical-argument：
    # cocycle 平凡有 GN (3.1) 逐字来源，但两套算子的识别无来源，且跨连续动量↔离散格、
    # δ-归一化两条接缝）。于是 effective **诚实落回 physical-argument**。
    assert (
        effs["worldsheet.ddf-contour-equals-mode-sum"].name == "physical-argument"
    )
    # 桥节点本身：显式、可被 why/report 看见，而不是藏在 flag 里
    #
    # 2026-09-18（分支 agent/curator/bridge-card-v2）：桥卡换代为 -v2，修正断言 (2)
    # 括注缺失的洛朗指标移位 V^{(n)}_K = S_n ∘ V^{(b)}_{K−nν}（v1 无移位，与 v6/Lean
    # towerVertex 不一致；lead 裁决见 docs/reviews/bridge-card-index-shift-2026-09-18.md）。
    # 唯一那条推导 --via-cocycle-triviality 随之改名改指 v2，故**旧卡不再有推导、
    # effective 落到 open**——它有 superseded_by，不进 open_propositions 报告。
    # 这与 ddf-operators-adjoint → v2 的先例同构。本断言随之改指 v2。
    assert (
        effs["worldsheet.physical-exponential-equals-voa-vertex-operator-v2"].name
        == "physical-argument"
    )
    assert (
        g.statements["worldsheet.physical-exponential-equals-voa-vertex-operator"]
        .superseded_by
        == "worldsheet.physical-exponential-equals-voa-vertex-operator-v2"
    )
    # --via-voa-residue 的 own 仍是 rigorous，但 effective 被桥节点压到 physical-argument。
    # 这正是「严格的推理作用在尚未严格建立的前提上」的正确记账。
    voa = g.derivations["worldsheet.ddf-contour-equals-mode-sum--via-voa-residue"]
    assert voa.status == "rigorous"
    assert not any(d.inferred for d in voa.depends_on)
    assert "worldsheet.physical-exponential-equals-voa-vertex-operator-v2" in {
        d.id for d in voa.depends_on
    }
    gt = g.derivations["worldsheet.no-ghost-theorem-v4--via-goddard-thorn"]
    assert "worldsheet.ddf-contour-equals-mode-sum" not in {d.id for d in gt.depends_on}
    # 旧卡保留其历史推导（--via-vertex-operator-adjoint 已改名改指 v2），
    # 故旧卡自身不再有推导，effective 为 open——它有 superseded_by，不进 open_propositions 报告。
    assert (
        g.statements["worldsheet.ddf-operators-adjoint"].superseded_by
        == "worldsheet.ddf-operators-adjoint-v2"
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

    【2026-09-11 更新（分支 agent/formalizer/ddf-algebra）】v2 又多挂一条
    --via-lean（`StringFormal.NoGhost.lie_ddfOp_ddfOp`），effective 升为 formalized。
    同构卡**不动**：它的上限是 worldsheet.transverse-oscillator-commutators，
    与本次形式化无关（Lean 侧只做了 DDF 一边，没有光锥横向振子那一边的对应物）。
    """
    g = load_graph(ROOT)
    effs = compute_all(g)
    old = "worldsheet.ddf-transverse-oscillator-algebra"
    v2 = "worldsheet.ddf-transverse-oscillator-algebra-v2"
    iso = "worldsheet.ddf-algebra-isomorphic-to-transverse-oscillators"

    assert g.statements[old].superseded_by == v2
    assert g.statements[v2].superseded_by is None
    # 两条文献推导都改指 v2（git mv 改名），故旧卡没有推导；--via-lean 是后加的第三条
    assert not g.derivations_for(old)
    assert {d.id for d in g.derivations_for(v2)} == {
        f"{v2}--via-zero-mode-bracket",
        f"{v2}--via-conformal-weight",
        f"{v2}--via-lean",
    }
    assert effs[v2].name == "formalized"

    # v2 的三条推导都不再依赖光锥横向振子代数：那条边只承载被拆掉的末句
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


def test_tie_break_prefers_strongest_dependency_floor(mini: Path) -> None:
    # Two physical-argument derivations of the same target: one rests on a
    # conjecture chain (deps floor = conjecture), the other on a formalized
    # definition (deps floor = formalized). Both have effective
    # physical-argument; the tool must pick the one whose deps are stronger,
    # regardless of alphabetical order (the weak one sorts first here).
    _write(
        mini,
        "graph/derivations/duality/prop-d--via-aaa-weak.yaml",
        """
        id: duality.prop-d--via-aaa-weak
        target: duality.prop-d
        kind: physical-argument
        status: physical-argument
        depends_on: [{id: duality.conj-c}]
        sources: [{ref: ref-b, loc: "p.1"}]
        summary: weak route through a conjecture
        """,
    )
    _write(
        mini,
        "graph/derivations/duality/prop-d--via-zzz-strong.yaml",
        """
        id: duality.prop-d--via-zzz-strong
        target: duality.prop-d
        kind: physical-argument
        status: physical-argument
        depends_on: [{id: worldsheet.def-a}]
        sources: [{ref: ref-b, loc: "p.2"}]
        summary: strong route through a formalized definition
        """,
    )
    g = load_graph(mini)
    effs = compute_all(g)
    assert effs["duality.prop-d"].name == "physical-argument"
    assert effs["duality.prop-d"].best_derivation == "duality.prop-d--via-zzz-strong"
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


def _warnings(root: Path) -> list[str]:
    return [p.message for p in validate(load_graph(root)) if p.severity == "warning"]


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
    # #4: convention conflict warns (not errors) unless target is in milestone
    assert any("convention conflict" in w for w in _warnings(mini))
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
    assert not any("convention conflict" in w for w in _warnings(mini))


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
    children = {c["id"] for c in tree["children"]}
    assert "worldsheet.critical-dimension-light-cone-v2" in children
    # 2026-09-12 (reviewer-brst-nilpotency): the BRST route reached effective=rigorous
    # after the independent recomputation of {Q_B, Q_B}, so it is no longer a bottleneck
    # and correctly drops out of the why-tree (docs/ROADMAP.md R3 "(III) drops out").
    assert "worldsheet.critical-dimension-brst-v2" not in children


# ---------------------------------------------------------------- leverage analysis
# (bottleneck roots, self-capping, counterfactual forcing, greedy hitting set --
#  tools/stringgraph/report.py, docs/LEVERAGE-ANALYSIS.md)


def test_bottleneck_roots_and_self_capped_on_mini(mini: Path) -> None:
    """duality.prop-d rests entirely on duality.conj-c (its rigorous derivation's only
    dependency), so prop-d's single bottleneck root is conj-c itself, and conj-d is
    pure-upstream (not self-capped) while conj-c -- whose own conjecture-support status ties
    its effective level -- is self-capped."""
    g = load_graph(mini)
    effs = compute_all(g)
    assert weak_active_ids(g, effs) == ["duality.conj-c", "duality.prop-d"]
    assert bottleneck_roots(g, "duality.prop-d", effs) == {"duality.conj-c"}
    assert bottleneck_roots(g, "duality.conj-c", effs) == {"duality.conj-c"}
    assert is_self_capped(g, "duality.prop-d", effs) is False
    assert is_self_capped(g, "duality.conj-c", effs) is True


def test_greedy_root_cover_resolves_shared_root_once(mini: Path) -> None:
    """Both weak cards in `mini` share the same single root, so one pick resolves both."""
    g = load_graph(mini)
    effs = compute_all(g)
    root_sets = {sid: bottleneck_roots(g, sid, effs) for sid in weak_active_ids(g, effs)}
    order = greedy_root_cover(root_sets)
    assert order == [("duality.conj-c", 2, 2)]

    rep = hitting_set_report(g, effs)
    assert rep["counts"] == {"active": 4, "weak": 2, "distinct_roots": 1}
    assert rep["root_set_size"]["median"] == 1
    assert rep["root_set_size"]["max"] == 1
    assert rep["greedy_cover"]["checkpoints"] == {0.25: 1, 0.5: 1, 0.75: 1, 0.9: 1, 1.0: 1}


@pytest.fixture
def leverage(tmp_path: Path) -> Path:
    """A chain def-x --[physical-argument]--> prop-y --[rigorous proof]--> prop-z, an
    unrelated already-rigorous def-w --> prop-v pair (for the no-op case), and a milestone on
    prop-z (for the "milestone hit" case)."""
    schema_src = ROOT / "graph" / "schema"
    for f in schema_src.iterdir():
        _write(tmp_path, f"graph/schema/{f.name}", f.read_text(encoding="utf-8"))
    _write(tmp_path, "literature/sources.bib", "@book{ref-a,\n title={A}\n}\n")
    _write(
        tmp_path,
        "graph/statements/worldsheet/def-x.yaml",
        """
        id: worldsheet.def-x
        kind: definition
        status: physical-argument
        title: X
        statement: a physically-argued definition
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    _write(
        tmp_path,
        "graph/statements/worldsheet/prop-y.yaml",
        """
        id: worldsheet.prop-y
        kind: proposition
        title: Y
        statement: y follows from x
        sources: [{ref: ref-a, loc: "2"}]
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/worldsheet/prop-y--via-x.yaml",
        """
        id: worldsheet.prop-y--via-x
        target: worldsheet.prop-y
        kind: proof
        status: rigorous
        depends_on: [{id: worldsheet.def-x}]
        sources: [{ref: ref-a, loc: "2"}]
        summary: direct
        """,
    )
    _write(
        tmp_path,
        "graph/statements/worldsheet/prop-z.yaml",
        """
        id: worldsheet.prop-z
        kind: proposition
        title: Z
        statement: z follows from y
        sources: [{ref: ref-a, loc: "3"}]
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/worldsheet/prop-z--via-y.yaml",
        """
        id: worldsheet.prop-z--via-y
        target: worldsheet.prop-z
        kind: proof
        status: rigorous
        depends_on: [{id: worldsheet.prop-y}]
        sources: [{ref: ref-a, loc: "3"}]
        summary: direct
        """,
    )
    _write(
        tmp_path,
        "graph/statements/worldsheet/def-w.yaml",
        """
        id: worldsheet.def-w
        kind: definition
        status: rigorous
        title: W
        statement: an already-rigorous definition
        sources: [{ref: ref-a, loc: "4"}]
        """,
    )
    _write(
        tmp_path,
        "graph/statements/worldsheet/prop-v.yaml",
        """
        id: worldsheet.prop-v
        kind: proposition
        title: V
        statement: v follows from w
        sources: [{ref: ref-a, loc: "5"}]
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/worldsheet/prop-v--via-w.yaml",
        """
        id: worldsheet.prop-v--via-w
        target: worldsheet.prop-v
        kind: proof
        status: rigorous
        depends_on: [{id: worldsheet.def-w}]
        sources: [{ref: ref-a, loc: "5"}]
        summary: direct
        """,
    )
    _write(
        tmp_path,
        "graph/milestones/prop-z.yaml",
        """
        id: ms.prop-z
        statement_id: worldsheet.prop-z
        canonical_text: Z
        audit: {status: draft}
        """,
    )
    return tmp_path


def test_counterfactual_force_definition_unlocks_downstream_chain(leverage: Path) -> None:
    g = load_graph(leverage)
    rep = counterfactual_report(g, ["worldsheet.def-x"])
    assert rep["forced"] == ["worldsheet.def-x"]
    assert rep["unknown_ids"] == []
    moved = {m["id"]: m for m in rep["moved"]}
    assert set(moved) == {"worldsheet.prop-y", "worldsheet.prop-z"}
    assert moved["worldsheet.prop-y"] == {
        "id": "worldsheet.prop-y", "before": "physical-argument", "after": "rigorous",
    }
    assert moved["worldsheet.prop-z"] == {
        "id": "worldsheet.prop-z", "before": "physical-argument", "after": "rigorous",
    }
    assert rep["moved_count"] == 2
    assert rep["milestones_hit"] == [{
        "milestone": "ms.prop-z", "statement_id": "worldsheet.prop-z",
        "before": "physical-argument", "after": "rigorous",
    }]


def test_counterfactual_force_proposition_only_moves_downstream(leverage: Path) -> None:
    """Forcing prop-y (not def-x) must not retroactively change def-x -- an upstream
    dependency is never affected by forcing something that depends on it."""
    g = load_graph(leverage)
    rep = counterfactual_report(g, ["worldsheet.prop-y"])
    moved_ids = {m["id"] for m in rep["moved"]}
    assert moved_ids == {"worldsheet.prop-z"}
    assert "worldsheet.def-x" not in moved_ids
    assert rep["moved_count"] == 1


def test_counterfactual_force_already_rigorous_node_is_noop(leverage: Path) -> None:
    g = load_graph(leverage)
    rep = counterfactual_report(g, ["worldsheet.def-w"])
    assert rep["moved"] == []
    assert rep["moved_count"] == 0
    assert rep["milestones_hit"] == []


def test_counterfactual_excludes_forced_node_from_its_own_delta(leverage: Path) -> None:
    """The forced node's own status trivially changes (that is the premise being tested), but
    `counterfactual_report` must not count that as part of the "unlocked" delta -- only report
    *other* cards moving. Cross-checked against a direct force_rigorous + compute_all diff."""
    g = load_graph(leverage)
    baseline = compute_all(g)
    assert baseline["worldsheet.def-x"].name == "physical-argument"
    g2 = force_rigorous(g, ["worldsheet.def-x"])
    after = compute_all(g2)
    assert after["worldsheet.def-x"].name == "rigorous"  # it really did move...

    rep = counterfactual_report(g, ["worldsheet.def-x"])
    assert all(m["id"] != "worldsheet.def-x" for m in rep["moved"])  # ...but is excluded here


def test_counterfactual_reports_unknown_ids_without_forcing_them(leverage: Path) -> None:
    g = load_graph(leverage)
    rep = counterfactual_report(g, ["worldsheet.def-x", "nope.does-not-exist"])
    assert rep["forced"] == ["worldsheet.def-x"]
    assert rep["unknown_ids"] == ["nope.does-not-exist"]


# ------------------------------------------- tied derivations (roots/why hidden-story note)
#
# Reproduces the shape of the real worldsheet.ddf-contour-equals-mode-sum blind spot: two
# non-refutation derivations of the same proposition tie for the best effective level, but
# `_proposition`'s tie-break (propagate.py) deterministically anoints only one as
# `best_derivation`. `bottleneck_roots`/`hitting_set_report` only ever follow that one, so the
# other tied derivation's own bottleneck (here: prop-bridge) is invisible to the stats unless
# surfaced through `tied_support_derivations`/`tied_bottleneck_info`.


@pytest.fixture
def tied(tmp_path: Path) -> Path:
    """prop-target has two derivations tied at effective=physical-argument:
      --via-a: own status physical-argument, depends on the already-rigorous def-p
               (self-capped; deps_floor=rigorous). Wins the tie-break (higher deps_floor).
      --via-b: own status rigorous, depends on prop-bridge (effective=physical-argument,
               itself self-capped). Loses the tie-break, so its bottleneck (prop-bridge) is
               exactly what `bottleneck_roots(g, "worldsheet.prop-target", ...)` cannot see.
    """
    schema_src = ROOT / "graph" / "schema"
    for f in schema_src.iterdir():
        _write(tmp_path, f"graph/schema/{f.name}", f.read_text(encoding="utf-8"))
    _write(tmp_path, "literature/sources.bib", "@book{ref-a,\n title={A}\n}\n")
    _write(
        tmp_path,
        "graph/statements/worldsheet/def-p.yaml",
        """
        id: worldsheet.def-p
        kind: definition
        status: rigorous
        title: P
        statement: an already-rigorous definition
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    _write(
        tmp_path,
        "graph/statements/worldsheet/prop-bridge.yaml",
        """
        id: worldsheet.prop-bridge
        kind: proposition
        title: Bridge
        statement: a physically-argued bridge identification
        sources: [{ref: ref-a, loc: "2"}]
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/worldsheet/prop-bridge--via-argument.yaml",
        """
        id: worldsheet.prop-bridge--via-argument
        target: worldsheet.prop-bridge
        kind: physical-argument
        status: physical-argument
        depends_on: [{id: worldsheet.def-p}]
        sources: [{ref: ref-a, loc: "2"}]
        summary: physical identification, own status caps it
        """,
    )
    _write(
        tmp_path,
        "graph/statements/worldsheet/prop-target.yaml",
        """
        id: worldsheet.prop-target
        kind: proposition
        title: Target
        statement: target reachable two independent ways
        sources: [{ref: ref-a, loc: "3"}]
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/worldsheet/prop-target--via-a.yaml",
        """
        id: worldsheet.prop-target--via-a
        target: worldsheet.prop-target
        kind: physical-argument
        status: physical-argument
        depends_on: [{id: worldsheet.def-p}]
        sources: [{ref: ref-a, loc: "3"}]
        summary: own status physical-argument, self-capped
        """,
    )
    _write(
        tmp_path,
        "graph/derivations/worldsheet/prop-target--via-b.yaml",
        """
        id: worldsheet.prop-target--via-b
        target: worldsheet.prop-target
        kind: proof
        status: rigorous
        depends_on: [{id: worldsheet.prop-bridge}]
        sources: [{ref: ref-a, loc: "3"}]
        summary: rigorous reasoning on top of the not-yet-rigorous bridge
        """,
    )
    return tmp_path


def test_tied_fixture_reproduces_the_ddf_contour_shape(tied: Path) -> None:
    g = load_graph(tied)
    effs = compute_all(g)
    assert effs["worldsheet.prop-target"].name == "physical-argument"
    # via-a wins the tie-break: same effective level, but higher deps_floor (rigorous vs.
    # prop-bridge's physical-argument) -- exactly the real card's --via-laurent... win.
    assert effs["worldsheet.prop-target"].best_derivation == "worldsheet.prop-target--via-a"
    # The official, stats-facing root set only ever sees the winning derivation: self-capped.
    assert bottleneck_roots(g, "worldsheet.prop-target", effs) == {"worldsheet.prop-target"}


def test_tied_support_derivations_lists_both_and_tied_bottleneck_info_reveals_hidden_root(
    tied: Path,
) -> None:
    g = load_graph(tied)
    effs = compute_all(g)
    tds = tied_support_derivations(g, "worldsheet.prop-target", effs)
    assert [d.id for d in tds] == [
        "worldsheet.prop-target--via-a",
        "worldsheet.prop-target--via-b",
    ]

    info = tied_bottleneck_info(g, "worldsheet.prop-target", effs)
    by_id = {t["id"]: t for t in info}
    assert set(by_id) == {"worldsheet.prop-target--via-a", "worldsheet.prop-target--via-b"}
    assert by_id["worldsheet.prop-target--via-a"]["is_best"] is True
    assert by_id["worldsheet.prop-target--via-a"]["roots"] == ["worldsheet.prop-target"]
    # The hidden story: via-b's own bottleneck is prop-bridge, invisible to bottleneck_roots.
    assert by_id["worldsheet.prop-target--via-b"]["is_best"] is False
    assert by_id["worldsheet.prop-target--via-b"]["roots"] == ["worldsheet.prop-bridge"]


def test_tied_helpers_are_empty_when_there_is_no_genuine_tie(mini: Path) -> None:
    """duality.prop-d has exactly one (non-refutation) derivation, so there is nothing to tie:
    all the tied-* helpers must report "no tie" rather than treating a singleton as a tie."""
    g = load_graph(mini)
    effs = compute_all(g)
    tds = tied_support_derivations(g, "duality.prop-d", effs)
    assert [d.id for d in tds] == ["duality.prop-d--via-c"]
    assert tied_bottleneck_info(g, "duality.prop-d", effs) == []
    assert tied_effective_cards(g, effs) == []


def test_tied_effective_cards_and_full_report_key(tied: Path) -> None:
    g = load_graph(tied)
    effs = compute_all(g)
    assert tied_effective_cards(g, effs) == ["worldsheet.prop-target"]
    rep = full_report(g)
    assert rep["tied_effective_derivations"] == ["worldsheet.prop-target"]
    rep_open = full_report(g, open_only=True)
    assert rep_open["tied_effective_derivations"] == ["worldsheet.prop-target"]


def test_full_report_tied_effective_derivations_key_is_empty_without_a_tie(mini: Path) -> None:
    """No-noise requirement at the whole-graph level: `mini` has no tied cards."""
    g = load_graph(mini)
    assert full_report(g)["tied_effective_derivations"] == []


def test_format_tied_derivations_marks_best_and_lists_hidden_root(tied: Path) -> None:
    g = load_graph(tied)
    effs = compute_all(g)
    info = tied_bottleneck_info(g, "worldsheet.prop-target", effs)
    text = format_tied_derivations("worldsheet.prop-target", effs["worldsheet.prop-target"], info)
    assert "2 derivations" in text
    assert "worldsheet.prop-target--via-a" in text
    assert "BEST" in text
    assert "worldsheet.prop-target--via-b" in text
    assert "worldsheet.prop-bridge" in text


def test_roots_cli_prints_tied_note_and_reveals_hidden_root(tied: Path, capsys) -> None:
    from stringgraph.cli import main

    assert main(["--root", str(tied), "roots", "worldsheet.prop-target"]) == 0
    out = capsys.readouterr().out
    # The headline count is unaffected: still 1 root, the self-capped winner.
    assert "1 bottleneck root(s)" in out
    assert "worldsheet.prop-target--via-a" in out and "BEST" in out
    assert "worldsheet.prop-target--via-b" in out
    assert "worldsheet.prop-bridge" in out  # the hidden bottleneck, now visible


def test_roots_cli_json_carries_tied_derivations_when_tied(tied: Path, capsys) -> None:
    import json as _json

    from stringgraph.cli import main

    assert main(["--root", str(tied), "roots", "worldsheet.prop-target", "--json"]) == 0
    rep = _json.loads(capsys.readouterr().out)
    assert rep["roots"] == ["worldsheet.prop-target"]
    tied_by_id = {t["id"]: t for t in rep["tied_derivations"]}
    assert tied_by_id["worldsheet.prop-target--via-a"]["is_best"] is True
    assert tied_by_id["worldsheet.prop-target--via-b"]["roots"] == ["worldsheet.prop-bridge"]


def test_roots_cli_is_silent_about_ties_when_there_is_no_tie(mini: Path, capsys) -> None:
    """No-noise requirement: a card with a single derivation must not grow any extra output."""
    from stringgraph.cli import main

    assert main(["--root", str(mini), "roots", "duality.prop-d"]) == 0
    out = capsys.readouterr().out
    assert "NOTE" not in out
    assert "tie at effective level" not in out


def test_roots_cli_json_has_no_tied_derivations_key_when_there_is_no_tie(
    mini: Path, capsys
) -> None:
    import json as _json

    from stringgraph.cli import main

    assert main(["--root", str(mini), "roots", "duality.prop-d", "--json"]) == 0
    rep = _json.loads(capsys.readouterr().out)
    assert "tied_derivations" not in rep


def test_why_cli_prints_tied_note_and_reveals_hidden_root(tied: Path, capsys) -> None:
    from stringgraph.cli import main

    assert main(["--root", str(tied), "why", "worldsheet.prop-target"]) == 0
    out = capsys.readouterr().out
    assert "worldsheet.prop-target [physical-argument]" in out
    assert "worldsheet.prop-target--via-a" in out and "BEST" in out
    assert "worldsheet.prop-target--via-b" in out
    assert "worldsheet.prop-bridge" in out


def test_why_cli_json_carries_tied_derivations_when_tied(tied: Path, capsys) -> None:
    import json as _json

    from stringgraph.cli import main

    assert main(["--root", str(tied), "why", "worldsheet.prop-target", "--json"]) == 0
    rep = _json.loads(capsys.readouterr().out)
    tied_by_id = {t["id"]: t for t in rep["tied_derivations"]}
    assert tied_by_id["worldsheet.prop-target--via-b"]["roots"] == ["worldsheet.prop-bridge"]


def test_why_cli_is_silent_about_ties_when_there_is_no_tie(mini: Path, capsys) -> None:
    from stringgraph.cli import main

    assert main(["--root", str(mini), "why", "duality.prop-d"]) == 0
    out = capsys.readouterr().out
    assert "NOTE" not in out
    assert "tie at effective level" not in out


def test_why_cli_json_has_no_tied_derivations_key_when_there_is_no_tie(
    mini: Path, capsys
) -> None:
    import json as _json

    from stringgraph.cli import main

    assert main(["--root", str(mini), "why", "duality.prop-d", "--json"]) == 0
    rep = _json.loads(capsys.readouterr().out)
    assert "tied_derivations" not in rep


def test_hitting_set_report_unaffected_by_tied_derivation_helpers(tied: Path) -> None:
    """The headline leverage-analysis numbers (docs/LEVERAGE-ANALYSIS.md) must stay exactly the
    single-best-derivation view: prop-target's root set is {itself}, not {prop-bridge}, even
    though prop-bridge is independently weak and self-capped in its own right."""
    g = load_graph(tied)
    effs = compute_all(g)
    rep = hitting_set_report(g, effs)
    assert set(weak_active_ids(g, effs)) == {"worldsheet.prop-target", "worldsheet.prop-bridge"}
    root_sets = {sid: bottleneck_roots(g, sid, effs) for sid in weak_active_ids(g, effs)}
    assert root_sets["worldsheet.prop-target"] == {"worldsheet.prop-target"}
    assert root_sets["worldsheet.prop-bridge"] == {"worldsheet.prop-bridge"}
    assert rep["counts"] == {"active": 3, "weak": 2, "distinct_roots": 2}


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
    # 2026-09-11 (branch agent/curator/fixes-batch-c, reviewer-batch16): the Sugawara
    # identification (G-N's L_(n) = omega_{n+1} == the graph's Sugawara L_n) used to hide in an
    # inferred edge to worldsheet.virasoro-generators-free-boson; it is now an honest
    # physical-argument card worldsheet.free-boson-vertex-algebra-conformal-vector, so this
    # derivation is throttled to physical-argument while its own status stays rigorous --
    # exactly the own > effective exposure this test exists to check.
    assert d["effective"] == "physical-argument"
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
    # 2026-09-11 (fixes-batch-c): same conformal-vector edge as above (the R_(1) <-> OCQ
    # identification was previously carried by no edge at all); throttled to physical-argument.
    assert dz["effective"] == "physical-argument"
    assert ders_v2[
        "worldsheet.ddf-transverse-oscillator-algebra-v2--via-conformal-weight"
    ]["effective"] == "physical-argument"
    # 2026-09-11（分支 agent/formalizer/ddf-algebra）：第三条 --via-lean
    # （`StringFormal.NoGhost.lie_ddfOp_ddfOp`）把本卡顶到 formalized；
    # 前两条推导的 own/effective 不变，仍逐条列出——这正是本测试要盯的「三条并列、取最强」。
    assert ders_v2[
        "worldsheet.ddf-transverse-oscillator-algebra-v2--via-lean"
    ]["own"] == "formalized"
    assert ders_v2[
        "worldsheet.ddf-transverse-oscillator-algebra-v2--via-lean"
    ]["effective"] == "formalized"
    assert rep_v2["effective"] == "formalized"

    # (b) own > effective is still exposed per-derivation.
    # 2026-09-12 (branch agent/curator/adjoint-wire): the throttled example used to be
    # transverse-ddf-fock-gram-matrix--via-oscillator-recursion, whose hypothesis (H2) was
    # cashed in by worldsheet.ddf-operators-adjoint (physical-argument). That card is now
    # superseded by -v2, which is formalized via VertexAdjoint.lean, so the Gram recursion
    # reaches rigorous. Then the throttled example was no-ghost-theorem-v4--via-goddard-thorn
    # (own=rigorous; effective=physical-argument via worldsheet.ddf-contour-equals-mode-sum).
    # 2026-09-11 round 7 (branch agent/auditor/noghost-contour): that edge was ruled
    # provenance-not-proof and removed, so no-ghost v4 is rigorous end to end. The throttled
    # example is now math.mobius-three-point-fixing-jacobian--via-vandermonde (own=rigorous,
    # effective=physical-argument), on a node whose best derivation (--via-lean) is formalized —
    # which also re-checks "strongest derivation wins" with a throttled sibling present.
    # 2026-09-11 round 8 (branch agent/curator/small-backlog-12): --via-goddard-thorn now
    # depends (non-inferred) on worldsheet.gt-longitudinal-k-algebra; that card is formalized
    # via Longitudinal.lean (merged 6ed1638), so no-ghost v4 stays rigorous end to end and the
    # Mobius example below remains the throttled case.
    # 2026-09-15 (branch agent/curator/noghost-ddf-wiring): that is no longer true. The (B-26)
    # spanning step was never carried by a depends_on edge — only by gap prose — so the tool
    # could not see it. Wiring the already-existing card worldsheet.ddf-spanning-hypothesis
    # (non-inferred, source goddard-2008 §6 (6.4), already listed) throttles --via-goddard-thorn
    # to physical-argument again. no-ghost v4 is now a *second* own>effective example here
    # (own=rigorous, effective=physical-argument), alongside the Mobius case below.
    # 2026-09-25 (lead, main): that throttle is gone again, and this time by a real proof,
    # not by re-classifying an edge. The (B-26) edge was retargeted from
    # worldsheet.ddf-spanning-hypothesis-v2 (physical-argument) to
    # worldsheet.ddf-spanning-transverse-frame (rigorous) — this project's own tower-native
    # proof, graduated from research/attempts/tower-native-ddf-spanning after two independent
    # adversarial reviews. --via-goddard-thorn was limited by exactly that one dep, so
    # no-ghost v4 is rigorous end to end again and is **no longer** an own>effective example
    # here. The Mobius case below remains the throttled example this assertion block needs.
    # NB the new card does NOT subsume v2 (v2's face lacks (S) η(a,b)=1 and is still open),
    # and it is NOT formalized — v4 is rigorous, not formalized.
    rep2 = status_report(g, "worldsheet.no-ghost-theorem-v4")
    ders2 = {d["id"]: d for d in rep2["derivations"]}
    d2 = ders2["worldsheet.no-ghost-theorem-v4--via-goddard-thorn"]
    assert d2["own"] == "rigorous"
    assert d2["effective"] == "rigorous"
    assert rep2["effective"] == "rigorous"
    # the card that supplies the (B-26) step now, and the one it replaced on that edge
    rep_sp = status_report(g, "worldsheet.ddf-spanning-transverse-frame")
    assert rep_sp["effective"] == "rigorous"
    assert status_report(g, "worldsheet.ddf-spanning-hypothesis-v2")["effective"] == "physical-argument"
    rep_k = status_report(g, "worldsheet.gt-longitudinal-k-algebra")
    ders_k = {d["id"]: d for d in rep_k["derivations"]}
    assert ders_k["worldsheet.gt-longitudinal-k-algebra--via-lean"]["effective"] == "formalized"
    assert ders_k["worldsheet.gt-longitudinal-k-algebra--via-mode-algebra"]["effective"] == "physical-argument"
    assert rep_k["effective"] == "formalized"

    rep_mob = status_report(g, "math.mobius-three-point-fixing-jacobian")
    ders_mob = {d["id"]: d for d in rep_mob["derivations"]}
    d_mob = ders_mob["math.mobius-three-point-fixing-jacobian--via-vandermonde"]
    assert d_mob["own"] == "rigorous"
    assert d_mob["effective"] == "physical-argument"
    assert rep_mob["effective"] == "formalized"

    # (b') the Gram recursion itself is no longer throttled
    rep3 = status_report(g, "worldsheet.transverse-ddf-fock-gram-matrix")
    ders3 = {d["id"]: d for d in rep3["derivations"]}
    d3 = ders3["worldsheet.transverse-ddf-fock-gram-matrix--via-oscillator-recursion"]
    assert d3["own"] == "rigorous"
    assert d3["effective"] == "rigorous"


def test_validate_warns_when_derivation_target_is_superseded():
    from stringgraph.validate import validate

    g = load_graph(ROOT)
    msgs = [p.message for p in validate(g) if p.severity == "warning" and "is superseded by" in p.message]
    # duality.ads-cft is superseded by holography.ads5-cft4-duality-v2 and still has a derivation
    assert any("duality.ads-cft" in m for m in msgs)


def test_validate_errors_when_dep_is_superseded_proposition_without_derivation(mini: Path):
    """2026-09-11 事故：ch10-residuals 把旧推导 git mv 到新卡，旧卡（仍被 10 条推导依赖）
    没有任何推导，effective 变 open，波及 40 个下游节点。这种情形一定是错的：
    要么活边改指新卡，要么按 STATUS_LEVELS 把旧推导保留为历史。升为 error。"""
    from stringgraph.validate import validate

    _write(mini, "graph/statements/worldsheet/old-prop.yaml", """
        id: worldsheet.old-prop
        kind: proposition
        title: old
        statement: old
        superseded_by: worldsheet.new-prop
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    _write(mini, "graph/statements/worldsheet/new-prop.yaml", """
        id: worldsheet.new-prop
        kind: proposition
        title: new
        statement: new
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    _write(mini, "graph/derivations/worldsheet/new-prop--via-x.yaml", """
        id: worldsheet.new-prop--via-x
        target: worldsheet.new-prop
        kind: physical-argument
        status: physical-argument
        summary: s
        depends_on: [{id: worldsheet.old-prop}]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    g = load_graph(mini)
    errs = [p.message for p in validate(g) if p.severity == "error"]
    assert any("has no derivation left" in m and "worldsheet.old-prop" in m for m in errs)


def test_report_frontier_hides_ruled_out_cards(mini: Path) -> None:
    """A card tagged `formalization-ruled-out` (lead ruling recorded in its notes) is not listed
    on the formalization frontier, even if all its deps are formalized."""
    _write(mini, "graph/statements/worldsheet/def-a.yaml", """
        id: worldsheet.def-a
        kind: definition
        status: formalized
        title: a
        statement: a
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: p.1}]
        formal: {lean_decl: X.a, lean_file: StringFormal/X.lean}
        """)
    (mini / "formal" / "StringFormal").mkdir(parents=True, exist_ok=True)
    (mini / "formal" / "StringFormal" / "X.lean").write_text("-- stub", encoding="utf-8")
    _write(mini, "graph/statements/worldsheet/prop-b.yaml", """
        id: worldsheet.prop-b
        kind: proposition
        title: b
        statement: b
        tags: [formalization-ruled-out]
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    _write(mini, "graph/derivations/worldsheet/prop-b--via-x.yaml", """
        id: worldsheet.prop-b--via-x
        target: worldsheet.prop-b
        kind: proof
        status: rigorous
        summary: s
        depends_on: [{id: worldsheet.def-a}]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    rep = full_report(load_graph(mini))
    assert "worldsheet.prop-b" not in rep["formalization_frontier"]


# ------------------------------------------------- history vs live warnings


@pytest.fixture
def mini_history(mini: Path) -> Path:
    """`mini` plus a superseded card A (whose old derivation is kept as history per
    docs/STATUS_LEVELS.md) and its replacement B, whose live derivation still points at A."""
    _write(mini, "graph/statements/worldsheet/old-def.yaml", """
        id: worldsheet.old-def
        kind: definition
        status: rigorous
        title: old def
        statement: superseded definition
        superseded_by: worldsheet.def-a
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    _write(mini, "graph/statements/worldsheet/prop-a.yaml", """
        id: worldsheet.prop-a
        kind: proposition
        title: A
        statement: superseded proposition
        superseded_by: worldsheet.prop-a-v2
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    _write(mini, "graph/derivations/worldsheet/prop-a--via-x.yaml", """
        id: worldsheet.prop-a--via-x
        target: worldsheet.prop-a
        kind: physical-argument
        status: physical-argument
        summary: kept as history
        depends_on: [{id: worldsheet.old-def}]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    _write(mini, "graph/statements/worldsheet/prop-a-v2.yaml", """
        id: worldsheet.prop-a-v2
        kind: proposition
        title: B
        statement: replacement proposition
        uses_conventions: [conv.metric-plus]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    _write(mini, "graph/derivations/worldsheet/prop-a-v2--via-y.yaml", """
        id: worldsheet.prop-a-v2--via-y
        target: worldsheet.prop-a-v2
        kind: physical-argument
        status: physical-argument
        summary: live derivation that still points at the old card
        depends_on: [{id: worldsheet.prop-a}]
        sources: [{ref: ref-a, loc: p.1}]
        """)
    return mini


def test_superseded_target_warning_is_history_but_live_dep_edge_stays_live(mini_history: Path) -> None:
    """旧推导保留为历史是裁决（docs/STATUS_LEVELS.md），其 warning 是提醒不是错误：
    target 已 superseded ⇒ kind=history；活推导依赖已换代陈述 ⇒ kind=live（这是要改指的）。"""
    problems = validate(load_graph(mini_history))
    assert not [p for p in problems if p.severity == "error"]
    by_where: dict[str, list] = {}
    for p in problems:
        if "superseded" in p.message:
            by_where.setdefault(p.where, []).append(p)

    old = by_where["graph/derivations/worldsheet/prop-a--via-x.yaml"]
    target_warn = [p for p in old if "target 'worldsheet.prop-a'" in p.message]
    assert [p.kind for p in target_warn] == ["history"]
    # (b) the history derivation's own superseded dependency is history too
    dep_warn = [p for p in old if "depends on superseded statement 'worldsheet.old-def'" in p.message]
    assert [p.kind for p in dep_warn] == ["history"]

    new = by_where["graph/derivations/worldsheet/prop-a-v2--via-y.yaml"]
    assert [p.kind for p in new] == ["live"]
    assert "depends on superseded statement 'worldsheet.prop-a'" in new[0].message


def test_validate_cli_hide_history_drops_only_history_lines(mini_history: Path, capsys) -> None:
    from stringgraph.cli import main

    assert main(["--root", str(mini_history), "validate"]) == 0
    full = capsys.readouterr().out
    assert "prop-a--via-x.yaml" in full
    assert "prop-a-v2--via-y.yaml" in full
    assert "2 history)" in full.splitlines()[-1]

    assert main(["--root", str(mini_history), "validate", "--hide-history"]) == 0
    hidden = capsys.readouterr().out
    assert "prop-a--via-x.yaml" not in hidden
    assert "prop-a-v2--via-y.yaml" in hidden
    # the summary still reports the totals, so hidden lines stay accounted for
    assert "2 history)" in hidden.splitlines()[-1]


def test_validate_cli_json_carries_kind(mini_history: Path, capsys) -> None:
    import json as _json

    from stringgraph.cli import main

    assert main(["--root", str(mini_history), "validate", "--json"]) == 0
    rep = _json.loads(capsys.readouterr().out)
    assert rep["counts"]["errors"] == 0
    assert rep["counts"]["history"] == 2
    assert {p["kind"] for p in rep["problems"]} == {"live", "history"}
    assert all({"severity", "where", "message", "kind"} <= set(p) for p in rep["problems"])

    assert main(["--root", str(mini_history), "validate", "--json", "--hide-history"]) == 0
    rep2 = _json.loads(capsys.readouterr().out)
    assert {p["kind"] for p in rep2["problems"]} == {"live"}
    assert rep2["counts"]["history"] == 2


# ------------------------------------------------- formal: lean_decl / lean_related gates
#
# Guards the 2026-09-20 incident: a proposition carried `formal.lean_decl` pointing at a
# Prop-valued `def` with no formalized derivation, and that pointer got read as a machine
# endorsement. The fix is a biconditional (`lean_decl` <-> a formalized derivation) plus an
# explicit, annotated escape hatch (`lean_related` + `lean_note`) for declarations that only
# state a card or cover part of it.


def _with_lean_file(root: Path, rel: str = "Fake/Decl.lean") -> str:
    """Create a file under formal/ so the lean_file existence check passes; return its rel path."""
    p = root / "formal" / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text("-- fixture\n", encoding="utf-8")
    return rel


def _prop_with_formal(root: Path, slug: str, formal_body: str, *, extra: str = "") -> None:
    _write(
        root,
        f"graph/statements/worldsheet/{slug}.yaml",
        f"""
        id: worldsheet.{slug}
        kind: proposition
        title: T
        statement: t
        sources: [{{ref: ref-a, loc: "1"}}]
        {extra}formal:
        {formal_body}
        """,
    )


def test_lean_decl_without_formalized_derivation_is_error(mini: Path) -> None:
    lf = _with_lean_file(mini)
    _prop_with_formal(mini, "gated", f"  lean_decl: Fake.thm\n          lean_file: {lf}")
    assert any("claims a machine-checked proof" in e for e in _errors(mini))


def test_lean_decl_with_formalized_derivation_is_ok(mini: Path) -> None:
    lf = _with_lean_file(mini)
    _prop_with_formal(mini, "gated", f"  lean_decl: Fake.thm\n          lean_file: {lf}")
    _write(
        mini,
        "graph/derivations/worldsheet/gated--via-lean.yaml",
        """
        id: worldsheet.gated--via-lean
        target: worldsheet.gated
        kind: proof
        status: formalized
        depends_on: [{id: worldsheet.def-a}]
        sources: [{ref: ref-a, loc: "1"}]
        summary: machine checked
        """,
    )
    assert not [e for e in _errors(mini) if "claims a machine-checked proof" in e]


def test_lean_decl_gate_exempts_superseded_cards(mini: Path) -> None:
    """Superseded cards are frozen history; principle 1 forbids editing them to satisfy a gate."""
    lf = _with_lean_file(mini)
    _prop_with_formal(
        mini,
        "gated",
        f"  lean_decl: Fake.thm\n          lean_file: {lf}",
        extra="superseded_by: worldsheet.prop-b\n        ",
    )
    assert not [e for e in _errors(mini) if "claims a machine-checked proof" in e]


def test_lean_related_with_note_is_the_escape_hatch(mini: Path) -> None:
    lf = _with_lean_file(mini)
    _prop_with_formal(
        mini,
        "gated",
        f"  lean_related: Fake.someDef\n          lean_file: {lf}\n"
        f"          lean_note: states the card only; it is a Prop-valued def",
    )
    assert not _errors(mini)


def test_lean_related_without_note_is_error(mini: Path) -> None:
    lf = _with_lean_file(mini)
    _prop_with_formal(mini, "gated", f"  lean_related: Fake.someDef\n          lean_file: {lf}")
    assert any("lean_related requires lean_note" in e for e in _errors(mini))


def test_lean_decl_and_lean_related_are_mutually_exclusive(mini: Path) -> None:
    lf = _with_lean_file(mini)
    _prop_with_formal(
        mini,
        "gated",
        f"  lean_decl: Fake.thm\n          lean_related: Fake.someDef\n"
        f"          lean_file: {lf}\n          lean_note: n",
    )
    assert any("mutually exclusive" in e for e in _errors(mini))


def test_lean_note_without_lean_related_is_error(mini: Path) -> None:
    lf = _with_lean_file(mini)
    _prop_with_formal(
        mini, "gated", f"  lean_note: dangling\n          lean_file: {lf}"
    )
    assert any("lean_note is only meaningful" in e for e in _errors(mini))


def test_lean_pointer_requires_lean_file(mini: Path) -> None:
    _prop_with_formal(mini, "gated", "  lean_decl: Fake.thm")
    assert any("requires formal.lean_file" in e for e in _errors(mini))


def test_unknown_formal_key_is_error(mini: Path) -> None:
    lf = _with_lean_file(mini)
    _prop_with_formal(mini, "gated", f"  lean_dec: Fake.thm\n          lean_file: {lf}")
    errs = _errors(mini)
    # caught by the JSON schema's additionalProperties, before the FORMAL_KEYS check
    assert any("Additional properties are not allowed" in e and "'lean_dec'" in e for e in errs)


def test_definition_formalized_requires_lean_decl(mini: Path) -> None:
    _write(
        mini,
        "graph/statements/worldsheet/def-formalized.yaml",
        """
        id: worldsheet.def-formalized
        kind: definition
        status: formalized
        title: F
        statement: f
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    assert any("status formalized but no formal.lean_decl" in e for e in _errors(mini))


def test_collect_decls_covers_lean_related_but_formalized_only_excludes_it(mini: Path) -> None:
    """Axiom auditing should still reach lean_related; epistemic filtering should not."""
    lf = _with_lean_file(mini)
    _prop_with_formal(
        mini,
        "gated",
        f"  lean_related: Fake.def\n          lean_file: {lf}\n          lean_note: partial",
    )
    decls = collect_decls(load_graph(mini))
    assert any(u.decl == "Fake.def" for u in decls)
    # collect_decls does not require status=formalized so it collects lean_related too.


def test_exploration_derivation_no_sources_warns_not_errors(mini: Path) -> None:
    """#3: derivation without sources warns (not errors) if notes indicate exploration."""
    _write(
        mini,
        "graph/derivations/worldsheet/thm-a--via-exploring.yaml",
        """
        id: worldsheet.thm-a--via-exploring
        target: worldsheet.thm-a
        kind: proof
        status: rigorous
        summary: "探索中 - pending formalization"
        depends_on: []
        """,
    )
    probs = validate(load_graph(mini))
    warns = [p for p in probs if p.severity == "warning" and "no sources" in p.message]
    errs = [p for p in probs if p.severity == "error"]
    assert len(warns) == 1
    assert "exploration in progress" in warns[0].message
    assert "must be completed before milestone" in warns[0].message
    assert len([e for e in errs if "must have sources" in e.message]) == 0


def test_convention_conflict_warns_unless_milestone(mini: Path) -> None:
    """#4: convention conflict warns unless target is in milestones."""
    _write(
        mini,
        "graph/conventions/metric-west.yaml",
        """
        id: conventions.metric-west
        family: metric-signature
        canonical: false
        title: "West metric"
        description: "(-,+)"
        """,
    )
    _write(
        mini,
        "graph/conventions/metric-east.yaml",
        """
        id: conventions.metric-east
        family: metric-signature
        canonical: true
        title: "East metric"
        description: "(+,-)"
        """,
    )
    _write(
        mini,
        "graph/statements/worldsheet/base.yaml",
        """
        id: worldsheet.base
        kind: proposition
        title: B
        statement: b
        uses_conventions: [conventions.metric-east]
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    _write(
        mini,
        "graph/statements/worldsheet/dep.yaml",
        """
        id: worldsheet.dep
        kind: proposition
        title: D
        statement: d
        uses_conventions: [conventions.metric-west]
        sources: [{ref: ref-a, loc: "2"}]
        """,
    )
    _write(
        mini,
        "graph/derivations/worldsheet/base--via-dep.yaml",
        """
        id: worldsheet.base--via-dep
        target: worldsheet.base
        kind: proof
        status: rigorous
        sources: [{ref: ref-a, loc: "3"}]
        depends_on:
          - id: worldsheet.dep
        """,
    )
    # Without milestone: should warn
    probs = validate(load_graph(mini))
    warns = [p for p in probs if p.severity == "warning" and "convention conflict" in p.message]
    errs = [p for p in probs if p.severity == "error" and "convention conflict" in p.message]
    assert len(warns) == 1
    assert "must resolve before milestone" in warns[0].message
    assert len(errs) == 0

    # Add milestone pointing to target
    _write(
        mini,
        "graph/milestones/base-milestone.yaml",
        """
        id: milestones.base-milestone
        statement_id: worldsheet.base
        audit:
          status: draft
        """,
    )
    # Now should error
    probs2 = validate(load_graph(mini))
    errs2 = [p for p in probs2 if p.severity == "error" and "convention conflict" in p.message]
    assert len(errs2) == 1
    assert "add convention_map" in errs2[0].message


def test_inferred_edge_pending_note_warns(mini: Path) -> None:
    """#5: inferred edge with empty or pending note warns."""
    _write(
        mini,
        "graph/derivations/worldsheet/thm-a--via-inferred.yaml",
        """
        id: worldsheet.thm-a--via-inferred
        target: worldsheet.thm-a
        kind: proof
        status: rigorous
        sources: [{ref: ref-a, loc: "1"}]
        depends_on:
          - id: worldsheet.def-a
            inferred: true
            note: "待整理"
        """,
    )
    probs = validate(load_graph(mini))
    warns = [p for p in probs if p.severity == "warning" and "inferred edge" in p.message and "pending note" in p.message]
    assert len(warns) == 1
    assert "must be completed before milestone" in warns[0].message
    assert warns[0].kind == "live"


def test_definition_empty_uses_warns(mini: Path) -> None:
    """#6: definition/axiom with empty uses warns for confirmation."""
    _write(
        mini,
        "graph/statements/worldsheet/orphan-def.yaml",
        """
        id: worldsheet.orphan-def
        kind: definition
        status: rigorous
        title: O
        statement: orphan
        sources: [{ref: ref-a, loc: "1"}]
        """,
    )
    probs = validate(load_graph(mini))
    warns = [p for p in probs if p.severity == "warning" and "no declared dependencies" in p.message]
    assert len(warns) >= 1
    assert any("confirm self-contained before milestone" in w.message for w in warns)
