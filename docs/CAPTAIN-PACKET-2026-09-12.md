> ✅ **修订完成（2026-09-12，分支 `agent/lead/captain-packet-fix`）**：reviewer-captain-packet 核出的 9 处 CONFIRMED + 6 处 PLAUSIBLE 问题均已逐条回原始文件（`graph/milestones/*.yaml` 的 audit/diff_notes 块、两条推导 yaml 的 `depends_on`/`sources`、现场重跑的 `stringgraph status/why`、`ls formal/StringFormal/NoGhost/`、`literature/extractions/` 相关章节）核实后修订，处理结果见文末「修订记录」表。**末尾的 worktree 清理脚本已重写**：SAFE 判定现同时要求「分支已并入 main」与「工作区无未提交改动」，脚本只生成清单、不自动执行删除，`--force` 建议已整段删除。

# 船长审批包 — 2026-09-12

三个里程碑（`ms.ddf-commute-with-virasoro`、`ms.critical-dimension-bosonic`、`ms.no-ghost-theorem`）均已完成回译审计，`audit.status: back-translated`。以下每节的"当前有效状态"一栏均为**本次现场重跑** `uv run stringgraph status/why` 的结果（2026-09-11），不是抄旧记录。

**批准的含义（`docs/STATUS_LEVELS.md`，2026-09-11 裁决，逐字）**：「`audit.status: approved` 断言的是**陈述忠实性**（canonical_text 与 statement 经回译比对无漂移、无物理错误），**不**断言任何有效状态等级。推导严格程度由工具计算的 `effective` 单独承载……effective = physical-argument 不阻止 approved。把 approved 绑到 effective ≥ rigorous 会制造"不拆定义卡以免降级"的反向激励。」船长看到下面任何一节 effective 不是 formalized/rigorous，都不构成不批准的理由；请把"忠实性"和"证明多严格"当两根独立的轴看。

---

## 1. `ms.ddf-commute-with-virasoro` → `worldsheet.ddf-commute-with-virasoro`

**规范陈述（canonical_text 节录，未改动引用文字，仅省略部分约定记账）**：
> 【对象】D 维自由玻色开弦的振子 Fock 空间……给定基点动量 p、参考向量 k_0、偏振向量 ε，满足三个条件：(T) 横向性 ε·k_0 = 0；(N) 类光性 k_0² = 0；(S) 归一化 2α' k_0·p = 1……DDF 算子按 worldsheet.ddf-operators-v6 的**模态和**定义：A^ε_n := Σ_{j∈Z} (ε·α_j) V^{(n)}_j……
> 【命题】在 (T)(N)(S) 之下，作为 T(p; k_0) 上的算子恒等式，[L_m, A^ε_n] = 0 对**每一个** m ∈ Z（含 m = 0）与每一个 n ∈ Z \ {0}。
> 【直接推论，属本陈述】若 Ψ 是旧协变物理态，则 A^ε_n Ψ 也是。
> 【本里程碑不断言】A^ε_n ≠ 0；横向振子代数 [A^i_m, A^j_n] = mδ^{ij}δ_{m+n,0}；DDF 态张成横向物理谱；k_0·p = 0 的扇区；n = 0 的情形（陈述卡排除它，Lean 与两个来源都不排除）；文献围道积分写法与模态和是同一算子（那是另一张 physical-argument 定义字典卡）；实数域可满足性；D = 26 或对 D 的任何限制。

（完整版含度规/α'约定与推论的详细记账，见 `graph/milestones/ddf-commute-with-virasoro.yaml`。）

**回译审计**：两轮**独立**回译，均裁定 **faithful**。第一轮 physics-auditor（2026-09-11）；第二轮为另一位独立审计员（同日，未读第一轮内容）。第二轮 R1–R10 逐条比对给出船长须知三点：
- **R4(b)**：Lean 证的是**模态和版本**；"文献围道定义的 A^i_n 与模态和是同一算子"另由 physical-argument 卡 `worldsheet.ddf-contour-equals-mode-sum` 承载，不在本命题内。
- **R5**：Lean 对**任意**满足 ε·k_0=0 的偏振成立（不限横向标架 e_i），比卡片文字宽，是被 Lean 覆盖的真加强，不算漂移。
- **R2**：n = 0 被本卡排除，但来源（G–N (3.5)、Goddard (5.4)）与 Lean 均覆盖 n=0；这是收窄不是错误，不建议为此换代。

**当前有效状态**（现场核验）：`own = formalized`，`effective = formalized`，`best_derivation = --via-lean`。`conjectures_depended_on: []`。无瓶颈——`why` 树全部节点（`ddf-operators-v6`、`momentum-tower-fock-space`、`virasoro-algebra-v2`、`bosonic-fock-space`、`exponential-vertex-operator-mode-weight-identity-v2`、`old-covariant-physical-states` 等）均 `formalized`。

**Lean 覆盖**：
- `StringFormal.NoGhost.lie_towerLop_ddfOp`（`formal/StringFormal/NoGhost/DDFOperatorAll.lean`）— `∀ m n : ℤ`（含 n=0，比卡宽）、任意 ε 满足 ε·b=0（比卡宽）、任意交换 ℚ-代数 R、任意 D、无号差假设（比 mostly-plus 宽）。
- `StringFormal.NoGhost.ddfOp_mem_towerPhysSubmodule`（同文件）— 覆盖"推论"部分，任意统一截距 a₀。
- **未覆盖**：围道积分定义 ≡ 模态和定义（无形式留数对象）；因此"文献 A^i_n 与本图 A^ε_n 是同一算子"；(S) 单值性的物理来由；实数域上合适 k_0 的存在性；横向振子代数 [A,A]（属另一张卡）；DDF 态张成横向谱；G–N 路线"共形向量=Sugawara"的识别（本证明直接用 Sugawara 绕开它）。

**批准操作**：
```yaml
audit:
  status: approved
  captain: <船长姓名>
  approved_on: "2026-09-12"
```
```bash
uv run stringgraph validate
git add graph/milestones/ddf-commute-with-virasoro.yaml
git commit -m "graph: captain approves ms.ddf-commute-with-virasoro"
```

**仍缺一手文献**：无。canonical_source（gebert-nicolai-1995 §3.1 p.594 eq.(3.5)；goddard-2008 §5 eq.(5.4)）均已 L1 逐字核实获取，不在船长点击清单中。

---

## 2. `ms.critical-dimension-bosonic` → `worldsheet.critical-dimension-bosonic-v3`

**规范陈述（canonical_text 节录，五条路线核心结论；完整版另含逐段记账历史，未删改核心断言原文，仅省略过程性旁注，标 […]）**：
> 【本里程碑断言什么】D = 26 不是由单一论证得到的：它是四条**论证方式互不相同**的路线各自挑出 D = 26……本里程碑**不**断言四条路线互相等价。
> (I) 光锥路线：[J^{i−}, J^{j−}] = …，Δ_n = n(26−D)/12 + (1/n)[(D−26)/12 + 2(1−a)]，闭合**当且仅当** D=26 且 a=1。本条另设前提 **D ≥ 4**。这是四条路线中**唯一**同时定出 D 与 a 的一条。
> (II) 旧协变路线：**若** D=26 且 a=1，则 H_phys 半正定、H_phys/H_0 与 24 个横向振子 Fock 空间等距同构；**且** D>26（a=1、非零动量）存在负模物理态。D ≤ 25 不作断言。
> (III) BRST 路线：Q_B² = 0 ⟺ c^m = 26（⟹ 方向另需"c_{−m}c_m 线性无关"前提）；只定出 c^m，不定出 a。
> (IV) Weyl 反常路线：c^{tot} = c^m − 26 = 0 ⟹ c^m = 26（一般物质 CFT 皆可，平坦 D 维只是其一）。
> (V) 开弦截距：**一致性要求 a = 1**，与 D 无关；三条刻画各自等价于 a=1，但图内成立的维数范围不同（(a)(b) 对 D≥2；(c) 只覆盖 D=4 与 D≥6，D=5 待补）。
> 【各路线的非严格步骤】只有 (II) 各推导节点**自身** status 是 rigorous；(I)(III)(IV)(V) 封顶在 physical-argument（ζ 正规化、OPE 收敛未证、Q_B²=0⟹c^m=26 无数学来源等）。
> 【本里程碑不断言什么】(1) 四条路线互相蕴含；(2) D≤25 情形；(3) 闭弦截距/紧化背景；(4) D=26 是一致性的充分条件；(5) a=1 与 D=26 有蕴含关系；(6) "(I) 是唯一以当且仅当给出 D 的路线"。

（节录说明：完整版 `graph/milestones/critical-dimension-bosonic.yaml` 的 canonical_text 首段另有一句"(II) 的有效状态亦为 physical-argument"的插注，此处未摘录；该插注本身**已过时**——现场核验 `critical-dimension-old-covariant-v3` 的 own/effective 均为 rigorous，插注留待下次换代同步，不影响本节其余摘录内容的准确性。）

**回译审计**：**三轮**。第一轮、第二轮均裁定 **drift**（可修，无物理错误：第一轮问题集中在多余元断言，以及记账中的方向问题——准确地说只有 **B1** 一处是方向写反，另一处 **B2**「(I) 是唯一同时定出 D 与 a 的路线」是措辞本身不成立（需改写），不是"写反"；第二轮发现 canonical 与 v2 卡"a 是否待定"前提相反等 6 项，判定修法只能换代）；每次 drift 均导致陈述换代（v→v2→v3）。**第三轮（physics-auditor，2026-09-11）裁定 faithful**，`audit.status: back-translated`。此前记账提到的两处尾巴**已处理完毕**（非"curator 处理中"）：**F1**（闭弦截距节点的记账文字已同步更新）、**F2**（"(I)(V) 共享 ζ 正规化处方"一句已删除）——见该里程碑 YAML `diff_notes`【第三轮修订记】约 L348–375。

**当前有效状态**（现场核验）：`own = physical-argument`，`effective = physical-argument`，`best_derivation = --via-four-routes`（该推导本身 `kind: physical-argument`，是并列陈述四条路线的汇总卡而非证明）。`conjectures_depended_on: []`。**关键认识论点**：`--via-four-routes` 的 `depends_on` 实际有 **7** 条（对应五条路线的一级依赖，外加 `free-boson-central-charge-d`、`bc-ghost-central-charge` 两条公共输入；下面 `why` 瓶颈树只展示对 effective 有压低作用的 5 条，不代表 `depends_on` 只有 5 条）。即便全部 7 条都升到 rigorous/formalized，按 `effective = min(own, min(deps))`，effective **也不会超过 physical-argument**——这是 `via-four-routes` 自身状态封顶，是 STATUS_LEVELS 设计的预期形态，不是缺陷（拆卡才是唯一升级路径）。

**why 瓶颈树（前 3–4 层；`depends_on` 共 7 条一级依赖，下面只列对 effective 有压低作用的 5 条）**：
- 层1：`critical-dimension-light-cone-v2`[PA]、`critical-dimension-brst-v2`[PA]、`critical-dimension-weyl-anomaly-v2`[PA]、`open-string-intercept-v2`[PA]、`bc-ghost-central-charge`[PA]。
- 层2：light-cone → `light-cone-normal-ordering-constant`[PA]（ζ 正规化）、`open-string-mass-shell`[PA]；brst → `bc-ghost-central-charge`[PA]；weyl-anomaly → `weyl-anomaly-trace`[PA]、`weyl-anomaly-central-charge-constant`[PA]、`faddeev-popov-ghost-action`[PA]、`conformal-gauge-fixing`[PA]；open-string-intercept → `open-string-mass-shell`、`transverse-oscillator-commutators`[PA]。
- 层3：ζ 正规化 → `zeta-regularized-sum-of-integers`[PA]、`transverse-oscillator-commutators`[PA]；`bc-ghost-central-charge` → `bc-ghost-cft`[own rigorous / effective PA]、`operator-product-expansion`[PA]、`tt-ope-central-charge-v2`[own rigorous / effective PA]（三者是 `bc-ghost-central-charge--via-ope` 的直接依赖；标 own 是因为这两个定义/命题节点自身论证严格，但 effective 被同层 `operator-product-expansion`[PA] 压到 physical-argument——这是 own≠effective 的正常记账，不是标法混用）。
- 层4：`bc-ghost-cft` 链条更深处才出现 `conformal-normal-ordering-v2`[own rigorous]——它是 `bc-ghost-cft` 的依赖（经 `energy-momentum-tensor-free-scalar` 等），不是 `bc-ghost-central-charge` 的直接依赖，此前误标在层3。

真实瓶颈汇聚到两个根：ζ 正规化（无算子层定义）与 OPE 收敛（未证）。DDF/无鬼一侧**已不在**本里程碑瓶颈中。

**Lean 覆盖**：**无**。`--via-four-routes` 本身是 physical-argument，永不可能标 formalized；已核对瓶颈树内全部节点（`energy-momentum-tensor-free-scalar`、`conformal-normal-ordering-v2`、`primary-field-v2`、`tt-ope-central-charge-v2`、`bc-ghost-cft`）均**无** `lean_decl`。已形式化的 `free-boson-central-charge-d` 其实是 `--via-four-routes` `depends_on` 七条之一的**直接依赖**（并非旁支）；另有已形式化的旁支节点 `virasoro-generators-free-boson` 确实不在推导路径上。二者对本里程碑 effective 均无提升作用——`free-boson-central-charge-d` 是因为它不在瓶颈链（ζ 正规化/OPE 收敛）上，`virasoro-generators-free-boson` 是因为它根本不参与本推导。

**批准操作**（务必保留 YAML 中已有的 `audit.back_translation` 记录，不要删除——`validate` 要求 `approved` 状态仍附带 `back_translation`，下方片段只示意新增字段）：
```yaml
audit:
  status: approved
  captain: <船长姓名>
  approved_on: "2026-09-12"
```
```bash
uv run stringgraph validate
git add graph/milestones/critical-dimension-bosonic.yaml
git commit -m "graph: captain approves ms.critical-dimension-bosonic"
```

**仍缺一手文献**：本里程碑主要来源中 Polchinski v1 §1.3/§2.4/§2.5/§3.4/§4.1/§4.3 已获取核实；**GSW 一侧仍有专属缺口**——`literature/extractions/gsw-1987-v1.md` §1：GSW §2.3.3（含 (2.3.32)）正文仍**未获取（L0）**，ch.2 被 WebFetch 13 MB 上限卡住（`docs/ROADMAP.md` L89）；canonical_text (I) 光锥路线的 Δ_n 公式目前**只由 GSW 单一来源支撑**，尚无第二来源交叉核验；`kato-ogawa-1983` 正文也未核实（该里程碑 YAML `canonical_text` 内约 L545 处有记账）。GT 1972 只经 (II) 间接相关，缺口记在下一节。已把 GSW v1 ch.2 加入船长点击清单第 6 项。

---

## 3. `ms.no-ghost-theorem` → `worldsheet.no-ghost-theorem-v4`

**规范陈述（canonical_text 逐字）**：
> 对 D 维自由玻色开弦……物理态 (L_0−a)|ψ⟩=0、L_n|ψ⟩=0 (n>0)……【全局动量限定】一律排除 p=0；固定 k_0 语境下进一步排除 k_0·p=0。
> (1) 当 D=26 且 a=1 时：(a) 对扇区 {p : k_0·p≠0} 内每个 p 与每个 |ψ⟩∈H_phys(p)，⟨ψ|ψ⟩≥0；(b) 对快子壳上 k_0·k≠0 的动量 k，H_phys(k;k_0)/H_0(k;k_0) 与 24 个横向 DDF 算子生成的 H^⊥(k) **等距同构**，保持**能级 N** 分级（不是 L_0 分级，L_0≡1 在 H_phys 上是常数）。
> (2) 当 D>26 时，**至少在 a=1 的情形**存在 p≠0 上的负模物理态（p=0 一律不算，因为 α^0_{−1}|0;0⟩ 对任意 D 都物理且模为负，会使命题失去区分力）。
> 本里程碑不对 D≤25 或 D=26、a≠1 作断言。

**canonical_source**：`goddard-thorn-1972`，"无编号定理；结论见摘要末句 'absence of ghosts for d ⩽ 26'。**正文未获取**"。

**回译审计**：四轮回译裁定 **faithful**（v2→v3→v4 演进只是修正量词歧义，不是漂移）；第五/六/七轮为**记账更新**（不重做回译，verdict 维持 faithful）：
- **第五轮（2026-09-11）R5-3**：船长关切"effective=physical-argument 时 approved 是否与里程碑定义冲突"——**裁定不冲突，建议可批**；approved/effective 是设计上正交的两根轴，此裁决后来写入 `docs/STATUS_LEVELS.md`（即本文件开头引用的那段）。
- **第六轮 R6**：DDF-Virasoro 对易关系转 rigorous 后，瓶颈转移到"伴随层"两节点：`ddf-operators-adjoint`（(A^i_n)†=A^i_{−n}）与被其封顶的 `transverse-ddf-fock-gram-matrix`。
- **第七轮（分支 agent/auditor/noghost-contour）R7**：(a) 裁定 `--via-goddard-thorn` 对 `worldsheet.ddf-contour-equals-mode-sum` 的依赖边是"**溯源记账，不承重**"，撤边；(b) `canonical_source` 仍是 GT1972 的**围道**表述，但图对象已是**模态和**版本（v6），"**船长批准的是模态和版本 A^ε_n 生成的 H^⊥(k)**；'它与文献围道定义的 A^i_n 是同一算子'在图中只有 physical-argument 级论证"（三处未闭合缺口：形式级数重排、留数 vs 围道读法、正规序 E±分裂不匹配）；(c) 撤边后 effective 回升为 rigorous。

**(B-26) 船长须知（`docs/ROADMAP.md`「发表路线」，Lean 蓝图 `formal/BLUEPRINT-noghost.md`）**：即便下面现场核验 effective=rigorous，这是**记账意义**上的 rigorous（推导链没有被图内已知节点压低），**不代表 GT 定理的核心张成步骤已被证明或形式化**。蓝图逐字标注：「**D = 26 只在 (B-26)「H^⊥ 之外的 p_{D−1}(N)−p_{D−2}(N) 个方向恰为零模态」一步进入**，DDF 代数/伴随/Gram 均与 D 无关——这是整条 GT 链的**真正承重点**，文献支撑只有 Goddard 2008 (6.4) 一句转引」。图内**目前没有节点**承载 (B-26)、张成引理本身、`[K_m,A]=0`、纵向算子构造；Lean 也未证完（`formal/TODO.md` 的 `ddf-spans` 待办；蓝图 B.1/A 已合 main，B.6/C.4 由背景 agent 正在做，未完成）。这是当前记账体系下的**已知盲点**，不阻塞本次批准（批准只断言忠实性），但建议船长批准时在 note 里留一句提醒。

**当前有效状态**（现场核验）：`own = rigorous`，`effective = rigorous`，`best_derivation = --via-goddard-thorn`。`conjectures_depended_on: []`。

**why 瓶颈树（全树仅 3 层，已到底，无压低依赖）**：
- 层1：`no-ghost-theorem-v4`[rigorous] via `--via-goddard-thorn`（2 deps）
- 层2：`transverse-ddf-fock-gram-matrix`[rigorous] via `--via-oscillator-recursion`；`kac-determinant-v2`[rigorous] via `--via-feigin-fuchs`（1 dep）
- 层3：`math.verma-module-free-over-negative-part`[rigorous] via `--via-pbw-theorem` → `math.pbw-theorem`[rigorous]（Humphreys）

注意：GT 论证的核心步骤（张成引理、[K_m,A]=0、纵向算子构造）**在图内根本没有节点**——`--via-goddard-thorn` 的 `summary` 直接断言它们、`sources` 只挂 GT1972 摘要，这是"缺一手文献"而非"缺 rigorous 判定"，船长须知。

**Lean 覆盖**（均在 `formal/StringFormal/NoGhost/`）：
- 已机检：DDF 算子定义 `ddfOp`（`DDFOperator.lean`）；`[L_m,A^ε_n]=0` 对全部 m,n `lie_towerLop_ddfOp`（`DDFOperatorAll.lean`）；DDF 保持旧协变物理态 `ddfOp_mem_towerPhysSubmodule`（同文件）；横向 DDF 代数 `[A^ε_m,A^δ_n]=m(ε·δ)δ` 的 `lie_ddfOp_ddfOp`（`DDFAlgebra.lean`）；顶点算子伴随与 DDF 伴随 `towerPairing_towerVertex_left` / `towerPairing_ddfOp_left`（`VertexAdjoint.lean`）；动量塔 Fock 空间与 Sugawara 基础设施（`Fock.lean`/`DDF.lean`/`Sugawara.lean`）。
- **未机检 / 图内无节点**：`transverse-ddf-fock-gram-matrix` 本身（登记"不填 lean_decl、不标 formalized"）；`kac-determinant-v2`（Feigin–Fuchs 路线）；GT 张成引理、`[K_m,A]=0`、纵向算子 K_m 构造（图内无节点，Lean 未做）；**(B-26)** 本身（图内无节点；蓝图 B.6/C.4 进行中，未合并）。

**批准操作**：
```yaml
audit:
  status: approved
  captain: <船长姓名>
  approved_on: "2026-09-12"
```
```bash
uv run stringgraph validate
git add graph/milestones/no-ghost-theorem.yaml
git commit -m "graph: captain approves ms.no-ghost-theorem"
```

**仍缺一手文献**：
1. Goddard–Thorn 1972 正文（本里程碑 canonical_source 的一手来源，目前只有摘要）。
2. Brower–Thorn 1971（可裁决 D>26 负模态的历史归属）。
3.（可选）Thorn 1985 Santa Barbara 42 页报告（自述"improved version of the Goddard–Thorn proof"，需免费注册，是否注册请船长决定）。

---

## 船长点击清单（agent 被反爬拦住，文件本身公开）

1. Goddard–Thorn 1972 正文：`https://cds.cern.ch/record/388690/files/CM-P00058839.pdf`（CERN-TH-1493，MARC 963 = PUBLIC）
2. Brower–Thorn 1971：`https://cds.cern.ch/record/352004/files/CM-P00058794.pdf`
3. GSW Vol.2 ch.13（pp.307–362，12 MB，超出 WebFetch 10 MB 上限，本机构有 Cambridge Core 订阅）：
   `https://www.cambridge.org/core/services/aop-cambridge-core/content/view/F2BEB1F0811FE1D8458547AAB73D12AF/9781139248570c6_p307-362_CBO.pdf/low-energy-effective-action.pdf`
4. Thorn 1985 Santa Barbara 42 页报告（需免费注册，是否注册请船长决定）：`https://inis.iaea.org/records/szqhd-hct30`
5. GGRT 1973 正文（CDS 394307，MARC PUBLIC 但反爬拦截；Wayback 快照存在）：`https://cds.cern.ch/record/394307/files/CM-P00058492.pdf`

下载后放 `literature/raw/`（已 gitignore）并告知，researcher 即可逐页抽取。

## worktree 清理

当前 `.claude/worktrees/` 下有约 248 个 worktree、`main` 已有约 484 条已合并分支，规模太大且几分钟内就会过期，**不在本文档里逐条枚举快照**。安全清理建议用下面的脚本先生成"已合并、可删"清单，人工过一眼再执行，不要盲目 `-D`/`--force`：

```bash
# 只列出分支已合并到 main 的 worktree（安全可删的候选）
git worktree list | grep -v '\[main\]' | while IFS= read -r line; do
  wtpath=$(echo "$line" | awk '{print $1}')
  branch=$(echo "$line" | sed -n 's/.*\[\(.*\)\]$/\1/p')
  if git branch --merged main --format='%(refname:short)' | grep -qx "$branch"; then
    echo "SAFE: $wtpath  ($branch)"
  fi
done
```

对清单里每一行，确认后依次：
```bash
git worktree remove <wtpath>        # 无未提交改动时；若有改动且确认可丢弃，加 --force
git branch -d <branch>              # 已合并用 -d（安全删），不要用 -D
```
**不要** `git worktree remove --force` 或 `git branch -D` 任何未出现在上面 SAFE 清单里的条目——它们可能是还在跑的 agent 分支，删了就是丢工作。
