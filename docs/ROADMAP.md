# 路线图

## Phase 0：骨架与种子数据（当前）

- [x] 目录结构、CLAUDE.md、agent 角色、skill
- [x] 节点/边/里程碑 schema
- [x] 校验、状态传播、报告、搜索、dot 导出工具
- [x] 种子节点：从 Virasoro 代数到无鬼定理的最短链
- [x] Lean 工程能 `lake build`（2026-09-10 验证：929 jobs 全过）
- [x] 第一次完整 `validate` + `report` 通过并提交

## Phase 1：世界面理论子图（目标：约 150 个节点）

覆盖 Polchinski 第一卷第 1–4 章和第二卷第 10–12 章能陈述为命题的内容：
- 玻色弦：Nambu–Goto / Polyakov 作用量、共形规范、Virasoro 约束、光锥量子化、临界维数、无鬼定理、树级振幅
- 超弦：RNS、GSO 投影、旋量场、临界维数 10
- 里程碑：`no-ghost-theorem`、`critical-dimension-bosonic`、`critical-dimension-superstring`

同步：Lean 岛 1 无鬼定理形式化。

### Phase 1 进度（2026-09-11 深夜）
- 计数（2026-09-11 午后，第四次中断（401 鉴权）后）：main 617 statements / 510 derivations / 3 milestones / 22 conventions；Lean 86 声明公理干净（3522 jobs）。本轮合入：Euler–Poincaré（`Math/EulerPoincare.lean`，Mathlib 无此定理）、LZ Thm 2.7 与相对复形非退化型两卡、**`NoGhost/Glue.lean`（逐片 ⇒ 全体：`ddfSpans_of_forall_slice`；`CharZero` 下只剩反对角 ∀N；能级 ≤ 1 整块无条件于 D）**、条件版无鬼两卡（`worldsheet.ddf-spanning-hypothesis` open、`worldsheet.no-ghost-theorem-conditional-on-ddf-spanning` formalized）、`Virasoro/FockFreeLowLevel.lean`（Kac 行列式非零 ⇒ N ≤ 4 标准后代线性无关；在壳 D=26 时 det₁=det₂=0，故 N ≤ 2 无用）、`NoGhost/LevelTwoSpan.lean`（54 声明：能级 2 物理态完整刻画、A^ε_{−2} 与 A^ε_{−1}A^δ_{−1} 显式；**N = 2 张成消元仍缺**，且 N ≥ 2 起 DDF 态 ≠ 横向振子态，只模伪态相等）、`Math/RegulatedSum.lean` + `riemannZeta_neg_one` 桥、超 Virasoro Kac 行列式卡（MRC 1986，rigorous，新约定卡 `conv.super-virasoro-central-charge-mrc`）、船长审批包修订版与方法论 outline 修订版（**均待第二轮 reviewer**）。ch10-residuals 分支剩余的 D=10 汇总卡 v2 换代（0059d92）**不合入**：main 已按更晚的 lead 裁决（`superstring-brst-nilpotency-requires-d10-flat` 平坦 ⟹ 边）修好同一问题，两者冲突；只 cherry-pick 了玻色化过期注（f1a007c）。
- 计数（2026-09-11 白天，第三次 API 中断后）：main 611 statements / 504 derivations / 3 milestones / 21 conventions；effective formalized 78 / rigorous 110；Lean 82 声明公理干净（3512 jobs）。第三次证书类 API 中断一次杀掉 11 个 agent（含三份人类面向文档的修订）；工作树全部完好，已按「增量落盘」规则逐一续派。已合入 auditor r9、mathlib-issue（`formal/MATHLIB-ISSUE-quotient-finsupp.md`：根因是 `Submodule.addCommGroup` 只接受语法上为 `AddCommGroup.toAddCommMonoid ?G` 的单位槽，TowerNull 原注「AddMonoidAlgebra 双路径」为假、已改正）、theta-cards、batch27-fix；reviewer-batch17 #1（鬼数 convention_map）与 batch18 #1（Q39 重号→Q39b）已落地；batch28 两项换代（`spectrum.type-i-long-cylinder-constant-term`、total-fermionic v2）已派工。**无鬼定理条件版已 Lean**（`NoGhost/Assembly.lean` `no_ghost_of_spans`：DDFSpans ⇒ H_phys/H_null 诱导形式正定，任意 D、任意有序域，文件中 D=26 不出现）；全部猜想负担集中于 `DDFSpans`（= (B-26)），已证片 (rung −1, level 1)，N=2 与「逐片 ⇒ 全体」引理派工中。DDFGram 补：`|d⟩` 落在 rung −N(d) 已证（卡 (3) 后半句关闭）；`PartitionCard.lean` 给 p(2..5) = 2,3,5,7（Mathlib 无此引理；`toFinsuppAntidiag` 只单射非双射——用它计数会错），`dim V_N ≤ p(N)` 在 N≤5 可实例化。
- 玻色弦：Polchinski v1 §1–6 全部入图并经 reviewer 审查（§5 moduli/CKV/Riemann–Roch/S 矩阵母公式；§6 树级振幅 spectrum 区 23 节点，Veneziano/Virasoro–Shapiro/Chan–Paton）；§8（T 对偶、Narain、D 膜）分支在审。**原书页核实**（Cambridge Core）关闭 13 条疑问、30 条 loc 修正、15 条作者自承缺口——落图中。
- 超弦：v2 §10–11 抽取完成（61 条 L1）；§10 RNS/GSO/超共形代数/D=10 分支已交付（41 statements + 28 derivations，`critical-dimension-superstring` 汇总卡 (I)–(IV) 明确本卷对 D=10 只有一条实质论证），在审。
- 里程碑：`ms.no-ghost-theorem` 五轮回译 faithful，等船长 approved；`ms.critical-dimension-bosonic` v3 已换代（(I) a 待定 + D ≥ 4；(V) "一致性要求 a = 1"），第三轮回译进行中；`ms.critical-dimension-superstring` 待 §10 入图后起草。
- **Lean 岛 1 里程碑（2026-09-11 深夜）**：`[L_m, V_J]` 对**每个 m ∈ ℤ**、`[L_m, A^ε_n] = 0` 对**每个 m**、**DDF 算子保持塔上物理子空间**（统一截距 a₀）全部机器验证；`ddf-commute-with-virasoro`（∀m）经 G–N 顶点代数推导已 **rigorous**，Lean 接线中。无鬼定理 v4 剩余上限（2026-09-12 凌晨）：**仅两处**——`ddf-operators-adjoint`（← `vertex-operator-adjoint` ← 径向共轭/态-算子同构）与被它封顶的 `transverse-ddf-fock-gram-matrix`；`ddf-transverse-oscillator-algebra-v2` 已 rigorous。最短路径：**Lean 证 Fock 配对下顶点算子伴随** (V^{(b)}_J)† = V^{(−b)}_{−J}（TowerPairing + 模伴随已有）⇒ A^ε_n† = A^ε_{−n} formalized ⇒ v4 回 rigorous。
- Lean 岛 1（无鬼定理）：Fock / Sugawara / 物理态 / L_m 伴随 / 伪态 / 商形式 / 动量塔配对 / **[L_m, V_J] 共形权（所有 m ≠ 0）** / **DDF 算子 A^ε_n 作为局部有限模态和 + [L_m, A^ε_n] = 0（m ≥ 1）** / level-2 负模态（含 p ≠ 0）已机器验证。剩：m = 0（真正例外）、塔版 m < 0、DDF 横向代数 [A,A]、张成定理。图接线（v6 定义卡、弱节点 positive-virasoro）进行中。
- 无鬼定理回 rigorous：号差在顶点代数层不是假设（一切在 ℂ 上）；Li–Wang Thm 3.6/3.10 覆盖类光格——curator 正建 lattice-VA 卡并把 G–N 推导接离 open 根。
- 无鬼定理回 rigorous 的最短路径：Gebert–Nicolai 顶点代数推导已入图（own rigorous），只被"自由玻色子顶点代数"缺卡压成 open——researcher 正找 Kac/LL/FLM 对不定号差格的编号定理。
- Lean 岛 2 扩展：GSO 扇区穷举（(a)(b)(c) 字面 10 解、maximal 6 解——"maximality" 是 Polchinski 未明说的第四条件）、六边形奇数扭转 = 32、Polchinski (12.2.27) ≡ (12.2.11)+(12.2.12)（同时验证 ADT (7)）、IIB 引力反常整数解射线（三式秩 2）、GS (20) = −96 × Polchinski 引力部分。E₈ 根系幂和形式化中。
- Lean 岛 2（Green–Schwarz 代数）：因子化恒等式（SO(32)/E₈）、迹条件算术 7 条声明已合入；等 GS 1984 图节点合入后接线。
- 附带数学岛：Verma 模、Euler 分拆、Witt/Virasoro 完美、Shapovalov 形式、Möbius Jacobian、Mandelstam 和。

## Phase 2：一致性与对偶子图

- Green–Schwarz 反常消除、T 对偶（环面）、S 对偶（猜想）、五种超弦与 M 理论关系
- 这一阶段的目的是让报告第一次显示"哪些结论压在哪些猜想上"
- Lean 岛 2：Green–Schwarz 反常多项式的因子化（代数部分）

### Phase 2 种子（2026-09-11 已启动）
- Green–Schwarz 1984 全文抽取完成；consistency 区节点分支在审查；因子化恒等式 (19) 等三条纯代数命题 Lean 形式化中（岛 2 种子）。Alvarez-Gaumé–Witten 1984 全文抽取完成（大学课程页扫描件路线）：GS (20) 五个系数经 AGW (119)+(83) 复算一致（差公共因子 −48，两篇原文均未写）；n = 496 是 p₃ 系数唯一零点；常数 c 与 (22) 仍在 Zumino–Wu–Zee 1984（升 P0）。**AGW 不得标 refuted**：其"规范群不能消引力反常"是自旋间相消框架内的结论，GS 出路是局域反项，在该框架外。
- T 对偶：Polchinski v1 §8 抽取完成，compact/duality/branes 三区首批节点分支在审查（`duality.t-duality-is-cft-isomorphism` 陈述只写谱与算子层，"同一 CFT / 非微扰"原书措辞 L0 待 Cambridge Core 核实）。

## Phase 3：全息与黑洞

- AdS/CFT（作为 axiom/conjecture 双轨）、Strominger–Vafa 熵、Ryu–Takayanagi、岛公式
- 目标产出：一份公开报告，列出全息扇区每条主要结论的猜想依赖集合

### Phase 3 种子（2026-09-11 已启动）
- Maldacena 1997 全文抽取完成；`holography.n4sym-contains-iib-sugra-states`（physical-argument）与 `holography.ads5-cft4-duality-v2`（conjecture，逐字猜想句、U(N)、无配分函数陈述）已建，旧 duality.ads-cft superseded。待建：D3 退耦极限等 7 张前提卡、对称性匹配独立推导、`conv.ym-coupling-normalization`。

## Phase 4：沼泽地

- 每条沼泽地猜想双轨挂载（成立方向 / 反例方向）
- 与观测约束（暗能量演化等）的接口节点

### Phase 4 种子（2026-09-11 已启动）
- Vafa 2005 / Ooguri–Vafa 2006 / AMNV 2006 全文抽取完成（L1）；swampland 区 27 节点 + 2 约定分支已交付（conjecture 20、refuted 1 = AMNV (I)），在审。待抽：Bagger–Witten 1983、Borel–Harish-Chandra 1962、Wen–Witten 1985、Sen 1995；`math.cy3-cohomology-bounded` 需检索 2005 后进展。**记账红线**：AMNV 猜想 (I) 被作者本人用 SO(32) 旋量反驳（适用域内 → refuted）；OV/Vafa 的"反例"全在引力解耦极限（适用域外 → 独立卡，不作 refutation）。三篇均无 de Sitter / 暗能量约束——观测接口需 2018 年后文献（Obied–Ooguri–Spodyneiko–Vafa 等），抽取中。

## 长期

- 与 TheoremGraph / Physlib 对接，导入导出
- 向 Prove2Me 提交里程碑作为 mission

## lead 裁决记录（2026-09-10）

- **OPE 收敛公理**：暂不建公理节点。凡靠"围道变形 + OPE"得到算子关系的推导一律 `physical-argument`，gaps 写明"OPE 级数收敛与围道变形合法性在来源中未证明"。等 CFT 子图有足够多此类推导再统一挂公理。
- **c = D / Sugawara**：建"Fock 空间上的 Virasoro 生成元"定义节点 + "满足 Virasoro 关系、c = D"命题节点；命题配 `--via-ope`（physical-argument）与 `--via-mode-algebra`（严格代数事实，来源 Kac–Raina 1987 / Schottenloher 2008，定理编号核实后才标 rigorous）两条推导。
- **`worldsheet.virasoro-algebra` 拆卡**：同意拆。待本批 curator 分支合并后由 lead 执行：新定义卡不含唯一性断言（可标 formalized），唯一性另立命题卡，旧卡 `superseded_by`。
- **a < 1 分支**：已解决（2026-09-10 第二轮核验）。成文来源是 Lian–Zuckerman 1991 Theorem 3.5(ii), p.570：「D = 26, h = 1 or 26 > D ≥ 2, h ≤ 1」（h 即截距 a）。注意 LZ 设定是 V(D,p) ⊗ L(26−D, 1−h)（D < 26 需补一个 c = 26−D 的模），与纯 D 玻色子设定不同；建独立节点 `worldsheet.no-ghost-theorem-subcritical`。Thorn 1987 摘要不提 intercept，降级为候选。
- **"初等可复核"能否标 rigorous**（reviewer-ch1 第 8 条）：可以，条件是前提完整 + 有限步初等计算 + reviewer 独立复核并在推导 `notes` 留 `reviewer-verified` 记录；写入 docs/STATUS_LEVELS.md。
- **Goddard–Thorn 1972 正文**：四条获取路径（INSPIRE files、CDS、KEK、archive.org 重印本）全部失败；"CERN TH.1471 报告号"线索已证伪。里程碑 canonical_source.loc 保持"无编号；摘要末句"。
- **Lian–Zuckerman 1991 不含 Q_B² = 0 ⟺ c = 26**：全文核实，该文与 FGZ 一样把 c = 26 作为相对复形的定义条件；`critical-dimension-brst` 的升级候选清单里删去它。Kato–Ogawa 1983 摘要方向为 ⟹。
- **个人笔记类来源（headrick-2008、schrans-2020）**：可登记 bib、可作核对源写进 source note，**不得作为推导 `sources[]` 条目承载论证**。例外：Headrick 习题解答对某个显式计算（如 Euler 数边界项）是唯一成文来源时，可作为该推导的 source，但 reviewer 须复核计算。
- **a^g 正规序常数**：reviewer-ch23 裁定 a^g = −1（λ = 2），抽取记录 polchinski-1998-v1 §1.1/E43 的 a^g = 0 是误记，researcher 订正中。
- **非官方全本扫描**（如大学个人页挂出的 Weibel 全本 PDF）：按 literature/CLAUDE.md 规则 1 的精神**不使用**，与既定的 nzdr.ru 口径一致；出版社/作者本人/课程页挂出的**单章**扫描可用（如 Lieb–Loss Ch.6、Schottenloher 各章）。
- **Polchinski 原书核对**：仍无持书者。E34 改由 Kac–Raina 等数学来源支撑，E53、E58 继续挂"二手源核实"gap。

## 待船长裁决

- **第三个里程碑 `ms.ddf-commute-with-virasoro`（2026-09-12 起草）**：陈述 `worldsheet.ddf-commute-with-virasoro`（∀m, n: [L_m, A^ε_n] = 0），**effective = formalized**（Lean `lie_towerLop_ddfOp`）且 own rigorous（G–N 顶点代数推导）——本项目首个同时严格且机器验证的非平凡物理命题。**两轮独立回译均 faithful，`audit.status: back-translated`——船长可批**（批准操作：`audit.status` 改 `approved`，填 captain/approved_on）。船长须知：Lean 证的是**模态和**版本；"文献围道定义的 A^i_n 与之相同"由一张 physical-argument 卡承载；n = 0 卡排除但来源与 Lean 都覆盖（不建议为此换代）。
- **ms.critical-dimension-bosonic 审批**：第三轮回译（2026-09-11）裁定 **faithful**，`audit.status: back-translated`，陈述 `worldsheet.critical-dimension-bosonic-v3`（五条合取 (I)–(V)：(I) a 待定 + D ≥ 4；(V) "一致性要求 a = 1"）。auditor 建议 approved；两处记账（F1 闭弦截距节点已存在、F2 删 ζ 共享输入一句）与光锥路线卡换代 D ≥ 4 由 curator 处理中，均不阻塞。effective = physical-argument（光锥/Weyl 路线本身如此）。批准操作：`audit.status` 改 `approved`，填 captain 与 approved_on。
- **ms.no-ghost-theorem 审批**：第四轮回译裁定 faithful，`audit.status: back-translated`，陈述 `worldsheet.no-ghost-theorem-v4`。审计员建议 approved。**2026-09-11 更新：拆 ddf-operators-v4 后，该里程碑的有效状态从 rigorous 降为 physical-argument**——原因是 [L_m, A^i_n] = 0 与 [A^i_m, A^j_n] = mδδ 两条对易关系此前以"定义的一部分"身份传播 rigorous，图中从未独立论证，文献（Goddard 2008/GSW）也只预设不证明。这不是陈述有错，是记账修正；升级路径是 Lean 共形权（进行中）与顶点算子乘积。船长审批 approved 时应知晓：**里程碑陈述忠实，但其推导链目前含两处 physical-argument**。第五轮审计（2026-09-11）确认 canonical_text 不引 ddf-v4（引用只在 statement 内，不可变），忠实性裁定维持；裁定 **approved 只断言忠实性，不绑有效状态**（已写入 docs/STATUS_LEVELS.md）。船长可在 effective = physical-argument 下批准。**2026-09-12 更新（第六轮记账）**：两条对易关系已 rigorous（且 Lean 对每个 m 证得）；推导链剩余两处 physical-argument **均在伴随层**（`ddf-operators-adjoint` ← 顶点算子伴随 (V^{(b)}_J)† = V^{(−b)}_{−J}，同点 E₊E₋ 重排；`transverse-ddf-fock-gram-matrix` 被其封顶）。**2026-09-12 已证（VertexAdjoint.lean）**：(V^{(n)}_K)† = V^{(−n)}_{−K} 与 **(A^ε_n)† = A^ε_{−n}**，对任意 b、任意 n；**"同点 E₊E₋ 重排序"这一步不存在**（伴随本身正规序），此前五张卡登记的该缺口全部作废；k_0² = 0 在伴随里不起作用。图接线中（curator-adjoint-wire）；**已接（dfc8bc0）：`vertex-operator-adjoint` 与 `ddf-operators-adjoint-v2` formalized，`transverse-ddf-fock-gram-matrix` 升 rigorous。无鬼定理 v4 现在**唯一**上限是 `ddf-contour-equals-mode-sum`（围道定义 ≡ 模态和定义的溯源卡）——auditor 正裁它是逻辑依赖还是溯源记账；若为后者，v4 回 **rigorous**。**原文本：**接完后无鬼定理 v4 的剩余上限只剩 `transverse-ddf-fock-gram-matrix` 的 (H1) 横向代数 [A,A]（Lean (5a) 已证，(5b) 加权和进行中）与 `ddf-contour-equals-mode-sum`（定义字典，physical-argument）。船长需知晓三个已登记 gap：(2) 的历史归属仅二手（Goddard 2008 → Brower–Thorn 1971）；canonical_source 仍是 GT 1972 摘要级、只覆盖 (1a)；逐塔打包与一般 α' 归一化是本项目规范化，文献无逐字。批准操作：把该文件 `audit.status` 改为 `approved` 并提交。
  - **2026-09-11 第七轮（最终记账）**：auditor 裁定 `ddf-contour-equals-mode-sum` 是**溯源记账而非证明步骤**，撤出 `--via-goddard-thorn` 的 depends_on（summary 各步只用模态和算子的代数性质，图内所有 DDF 性质卡以 v6 模态和为对象）。同日 `DDFAlgebra.lean` 证得 **[A^ε_m, A^δ_n] = m(ε·δ)δ_{m+n,0}**（任意 m,n∈ℤ、任意横向 ε,δ、任意交换 ℚ-代数），`ddf-transverse-oscillator-algebra-v2` 升 **formalized**。现在 **`worldsheet.no-ghost-theorem-v4` effective = rigorous**（= 推导自报，无压低依赖），`critical-dimension-old-covariant-v3` 随之 rigorous。DDF 侧输入至此全部 formalized 或 rigorous；剩余非机器验证部分是 GT 论证本身的张成步（物理态 = DDF 态 + 零模态）、[K_m, A] = 0、纵向算子构造——图内无节点、Lean 未做，且 GT 1972 / Brower 1972 正文仍未获取（船长点击项 1、2）。船长批准仍只断言忠实性；围道 ↔ 模态和的字典缺口记在 ms.no-ghost-theorem 第七轮 R7-2。

- **开放问题（curator theta-cards，2026-09-11）：`spectrum.long-cylinder-lightest-state-count` 里那三个 16 的来路对不上，原书全程沉默。** 三条，建议与下面 `#E74 §Q5` 的「三个 2⁵ = 32」**一并裁决**（同一类现象）：**(O1)** 同一个常数项 16 有两条互不相干的组合来路——圆柱 (10.8.4) 与 Klein 瓶 (10.8.11) 是 **16 = 2×8**（∏(1+q^{m−1/2})⁸ 与 ∏(1−q^{m−1/2})⁸ 在 q^{1/2} 阶的系数 +8 与 −8 相减，8 = 横向世界面费米子个数），Möbius (10.8.18) 是 **16 = 2⁴**（R 扇区基态二重简并的四次幂，四次幂来自「迹对一对维数取」）。**原书对两条路径都不评论，也从不说这两个 16 为什么相等。** **(O2)** 抽取记录 `polchinski-1998-v2-sec10-8.md #E66` **备注栏**（非逐字栏）里那句「16 = 十维无质量态计数」**朴素读法与本图别处的计数对不上**：D=10 的 NS–NS 无质量态是 **8⊗8 = 64**；玻色弦一侧同样，D=26 的无质量闭弦态是 **24×24 = 576** 而 (7.4.4) 的常数项是 24。该卡的「不断言 (a)」据此把一切计数释义挡在断言之外；要断言任何计数解释，必须先精确写出「闭弦通道里被边界态/cross-cap 态挑出的那个子集」是什么——**那是一条新的独立命题，本图没有**。 **(O3)** 与 `#E74 §Q5` 同型：三处各自独立出处的 **2⁵ = 32** 原书同样从不解释为何相等。**请船长裁决**：(a) 承认这是本书的记账风格、图上只记不问；还是 (b) 立项去找统一来源（典型候选：边界态 / cross-cap 态的归一化），找到后为「三处的 16（与三处的 2⁵）为何相等」单建一张命题卡。详见该卡 notes 的「开放问题登记」与 `spectrum.long-cylinder-lightest-state-count--via-q-expansion` 的逐步复算。
- **需船长人工点击一次的文件**（agent 被反爬拦住，文件本身公开；见 literature/extractions/primary-sources-round2.md §12.9）：
  1. Goddard–Thorn 1972 正文：`https://cds.cern.ch/record/388690/files/CM-P00058839.pdf`（CERN-TH-1493，MARC 963 = PUBLIC）——里程碑 canonical_source 的一手来源
  2. Brower–Thorn 1971：`https://cds.cern.ch/record/352004/files/CM-P00058794.pdf`——可裁决 D>26 负模态的历史归属
  4. **GSW Vol.2 ch.13（pp.307–362，12 MB，超出 WebFetch 10 MB 上限）**：`https://www.cambridge.org/core/services/aop-cambridge-core/content/view/F2BEB1F0811FE1D8458547AAB73D12AF/9781139248570c6_p307-362_CBO.pdf/low-energy-effective-action.pdf`——本机构有 Cambridge Core 订阅；取到即可裁决四解分类的原文措辞（§13.5.3 pp.353–358）。同一天花板卡住 GSW v1 ch.2（无鬼定理 §2.3.3，13 MB）。
  3. Thorn 1985 Santa Barbara 42 页报告（自述"improved version of the Goddard–Thorn proof"）：`https://inis.iaea.org/records/szqhd-hct30`，需免费注册——是否注册请船长决定
  下载后放 `literature/raw/`（gitignore）并告知，researcher 即可逐页抽取。

## 待落地的 reviewer 必修项（2026-09-11，lead 记账；派工中）

- **branes（reviewer-branes）**：(13.3.12) 因子写反（∫F = 2κ₁₀²μ_{6−p}，非 /2κ₁₀²）——换代 `branes.rr-charge-quantization` v2；抽取记录 ch13 第 417 行同错，**researcher 须核印刷页 148**。五条 TODO 边现可建实；tension 卡递推式位置漂移换代 v2；n=1 推导可升 rigorous（reviewer-verified）。建议：rr-coupling 卡四命题应拆；圆柱三推导可挂玻色弦圆柱卡为二级上游。
- **batch15（ch8-fix）**：(8.6.11) 不存在；dual-coordinate 柱面字典误标平面约定；dilaton-shift「原书 (8.3.31) 写法」误归属（原书是 e^{Φ'} 形式，e^{−Φ} 形式是 Schrans）。
- **batch16**：G–N 两条推导实质用共形向量 ω 与 L_(n)=ω_{n+1}，桥接卡 (N4) 明写不断言 ω——须建 `worldsheet.free-boson-vertex-algebra-conformal-vector`（physical-argument，G–N §2.2 Sugawara 页未读）并改指；`--via-zero-mode-bracket` 因此降 physical-argument，但 v2 卡 best 已是 `--via-lean`。ShapovalovLevelThree.lean:34 注释符号笔误。
- **reviewer-v2-ch10b 残余**：tadpole 前缀 (8π²α')^5 换代；bosonic-v2→v3 边；(10.8.12)/(10.2.15) 来源。Q_B²=0 ⟺ c=15 已拆单向（9ff17d1）。
- **lead 裁决（2026-09-11，superstring-flat：超弦链档位不对称已修）**：超弦侧的 ⟹ 卡 `worldsheet.critical-dimension-superstring-brst-v2` 写的是**一般正范数 SCFT**，而唯一来源 IMNU 1986 (3.8)–(3.10) **只算平坦** D 个 X^μψ^μ，那条外推使其推导只能标 conjecture，并沿 `critical-dimension-superstring → open-superstring-mass-shell → … → d-brane-charge` 把整条超弦链压成 conjecture，而同构的玻色弦链是 physical-argument——**不对称的根源是陈述宽度，不是证据**。裁决：(a) 新建与来源同范围的平坦卡 `worldsheet.superstring-brst-nilpotency-requires-d10-flat`（限平坦 X^μψ^μ、受限模与鬼场数算符线性无关写进陈述，与 `critical-dimension-brst-v2` 同型）+ 推导 `--via-imnu-explicit-coefficients`（physical-argument）；(b) **一般形式的 v2 卡与其推导保留为 conjecture，理由一字不改**，只在 notes 加指针；(c) `critical-dimension-superstring--via-two-routes` 的 (I) ⟹ 半改指平坦卡（非 inferred，sources 补 IMNU §3），**撤掉**指向一般形式卡的边（理由：本卷用 D = 10 的三处都在平坦背景）。效果：`critical-dimension-superstring` 与 `d-brane-charge-minimal-dirac-quantum` 均由 conjecture 回到 physical-argument，全图 conjecture 67 → 29。**未覆盖部分**（目标卡 (I) 文本里 ⟹ 的一般 SCFT 形式）记在该推导 gaps 第一条；消掉它需把 (I) 按「⟸ 一般 / ⟹ 限平坦」收窄换代（待 lead 排期）或取得一般 SCFT 的 Q_B² 系数来源。
- **gkpw**：d=4 拆卡已落地（gkpw-ads5）。
- **去重事故**：`branes.bps-bound-point-particle-d4` / `branes.brane-charges-in-susy-algebra` 与 `susy.*` 同名命题并行建卡，保留 susy.*，branes.* superseded（派工中）。**教训：同一命题不得同时派给两个 curator。**
- **lead 裁决（2026-09-11，three-checks）**：(a) `consistency.iib-gravitational-anomaly-cancels` **不**为「无规范群」换代——statement 已以「三个规范迹为零」写出前提；(b) `worldsheet.nsr-fock-space-verma-decomposition` 维持 conjecture 不降 refuted——LZ 反例区 p·p<0 真含于 FOK 的 p≠0，是不利证据，但 LZ 不给层数不写显式反例，不满足「被接受的反例」；(c) 超弦无鬼两卡 (H2) 只写 p≠0、LZ p.305 另设「p 未来向」——**待裁**，先由下一轮 auditor 在回译时判定是否本质前提；(d) 2 待登记文献：Gibbons–Hull PLB 109 (1982) 109、Terao–Uehara PLB 168B (1986) 70、Schwarz NPB 46 (1972) 61。
- **lead 裁决（2026-09-11，small-backlog-5）**：Kac 2015 (1.32) 的费米型模式对易公式立为独立 `math.mode-commutator-formula-super`（rigorous），**不**挂到围道语言卡 `worldsheet.ope-anticommutator-dictionary-fermionic`（形式分布证明不得抬高径向排序陈述，同 reviewer-batch3 对玻色侧的先例）。待办：`worldsheet.weyl-anomaly-central-charge-constant` statement 把 ∂^aC = 0 归给 (3.4.31)（实为 ansatz，结论是 p.97 无式号散文）——纯改名式换代 v2；Seifert–Threlfall Ch. VI §38/§40 待登记 bib（带节号的曲面分类来源）；`worldsheet.critical-dimension-superstring` (I) 文本为一般 SCFT ⟺，two-routes 只覆盖「⟸ 一般 + ⟹ 平坦」——应按此收窄换代 v2。
- **lead 正式裁定（2026-09-12）：Polchinski v2 (13.3.12) 是排印错误**（分数线倒置：印 μ_{6−p}/2κ₁₀²，应为 2κ₁₀²μ_{6−p}）。证据三条：量纲；与同页 (13.3.11)+次页 (13.3.13) 相容性；Polchinski hep-th/9510017 p.5 Φ = μ_p/α_p、α_p = 1/(2κ₁₀²)（bib `polchinski-1995-dbranes`）。2005 校订本仍误印。图上 `branes.rr-charge-quantization-v2` 不引该式。
- **reviewer-lean-noghost（2026-09-12）**：七个 NoGhost 文件 233 条声明公理全清、0 bad；**D=26 在任何定理陈述里不出现**（只在 docstring），CONFIRMED。N=1 张成定理右端是单个伪态向量的张成（非 null 子模）且多两条前件（ε·k=0、标架完备）；spurious→null 桥已由 Assembly.lean `mem_ddfSpan_sup_null_of_mem_ddfSpan_sup_spurious` 提供（需质壳）。三条记账修正已落地（transOp docstring、TODO 的 ℤ 见证与 rung 定位）。
- **auditor page-checks（2026-09-12，三项裁决，`literature/extractions/page-check-rulings-2026-09-12.md`）**：(1) MRC 1986 (7)–(9) **可建卡**——(9) 指数 ½p̂(n) 无 ±（§55.3 误读）、p̂ 由 Prop 3.6 定义、证明 Prop 4.10/4.13；`c^{MRC} = (2/3)c^{std}` 是 auditor 自算须 inferred（派工中：`worldsheet.super-virasoro-kac-determinant`）。(2) FGZ Prop 2.6 `D ≥ 2` vs `D > 2` **非排印错误**（D>2 是 Verma 分解前提，D=2 由 s≥1 分支覆盖）；`ch_q T = q^{p·p/2}φ^{D−2}` **原刊漏负号**（三条内证），正确 φ^{−(D−2)}。(3) LZ p.312/317 括号无实质差异。
- **reviewer-batch27（2026-09-12，两条 CONFIRMED，均派工修复）**：(F1) Möbius 卡转录的 (10.8.17) 按 (10.7.8) 定义为假——解析+数值三点得 +16 而卡录 −16，要么原书印错要么读错；裁定：(10.8.17) **不进任何节点**（抽取记录 Q3 的做法合规），Möbius 卡换代 v2 只留 (1)(3)，researcher 重读 p.42。(F2) `superstring-worldsheet-parity-action` 定义卡把 Ω² = exp(πiF) 当无条件断言——由 (10.8.13) 推出 Ω²ψ_rΩ⁻² = e^{−2πir}ψ_r，R 扇区（r∈ℤ）给 +ψ_r 而 exp(πiF) 反对易，**在 R 扇区与定义矛盾**，只在 GSO 投影谱上成立、原书只论证 NS；拆为 definition v2（(10.8.12)(10.8.13)）+ 命题卡（physical-argument，gaps 记 R 扇区矛盾）。可签：Klein 2¹⁰、Möbius 2⁶ 前缀手算闭合；Möbius 长柱常数 +16 数值验证。
- **lead 正式裁定（2026-09-11，batch27）：Polchinski v2 (10.8.17) 是排印错误**（印出的等式左右两端**恒定反号**：左端 −16 q^{1/3}∏[1+(−1)^m q^m]⁸ − (1−1)⁴(…) 恒负，右端 Z⁰₁(2it)⁴Z¹₀(2it)⁴ 恒正）。证据三条：(i) **页图逐字**——researcher 单页重读 p.42 确认原书确印 **−16**，且该处是全字号首行，**不是**被降为小字号的分式分母，故不适用同节 α' 幂次那条「渲染假象」裁定；(ii) **(10.7.7b) 独立复算**——右端 = **+16** q^{1/3}∏[1+(−1)^m q^m]⁸，与左端指数与奇偶结构逐项吻合、只差整体符号（reviewer 另以 t = 0.3/0.7/1.5 三点数值核到 1e−6）；(iii) **符号恒不相容**——不存在使两端相等的 t。⚠ **与 (13.3.12) 的区别：错在哪一端不可判定**（左端改 +16 与右端改 −Z⁰₁⁴Z¹₀⁴ 同样经济；原书自承 'This calculation does not determine the sign of the tadpole'），故裁定只到「该式为排印错误」，**不**裁定正确形式。**矛盾隔离在该式之内**：(10.8.18) 第一行的分子在原书独立印出，SO(32) 主结论（`worldsheet.type-i-tadpole-cancellation-so32-v2`）不经过 (10.8.17)、不受影响。图上 `worldsheet.superstring-mobius-strip-amplitude-closed-channel-v2` 把该式整条移出断言（v1 曾照录为断言 (2)）。副产品：**(1−1)⁴ = Z¹₁(2it)⁴**（R 零模因子四次方），旧 Q3「8 个横向费米子分成 4 对逐对相消」的解读作废。
- **researcher-lz-214b（2026-09-12，pp.311–317 L1）**：LZ Prop 2.14 逐字与 E5 一致；「非退化」出处是 p.311 Def 2.11 上方（承载者 Prop 2.10(i)(iii)），不在 2.14；Def 2.12(i) 藏两条前提（每层有限维、T^n=0 for large n）；Prop 2.14 证明只引 Def 1.3/2.2/Thm 2.7 + 内嵌 Lemma 2.14.1–5，**不引 Thm 2.4**。FGZ Prop 1.3 逐字（V∈𝒪₀）但**证明未印出**。Hatcher Thm 2.44 = Ch.2 §2.2 p.146。
- **researcher-lz-refs（2026-09-12，L1 页图 p.335 + pp.316–321）**：LZ [8] = GSO NPB 122 (1977)（非 PLB 65）；LZ 参考表四处原刊印错；Cor 2.15 证明只引 Prop 2.14(ii)；**Cor 2.19(iii) 只依赖 Prop 2.18 证明体内的 (24)(25)，再上游是 [22] Meurman–Rocha-Caridi 超 Virasoro Kac 行列式**；**FGZ Prop 2.6(i)/(ii) 共用证明，核心输入是 Kac 行列式（refs 10, 11）** ⇒ 玻色与 RNS 两条消灭定理链的 rigorous 都以 Kac 行列式为共同上游（此前低估）。Meurman–Rocha-Caridi 待登记（派工中）。
- **lead 裁决（2026-09-12，small-backlog-10）**：(a) Fock-free 拆成玻色/RNS 两卡维持——合并会因 RNS 对象卡 physical-argument 把 `bosonic-relative-cohomology-vanishing` 从 rigorous 压到 physical-argument，纯记账式回归；(b) `brst-cohomology-equals-ocq-physical-superstring-v2` 整条删去「p 在未来半光锥」前提（按 auditor rulings-3），reviewer-batch24 复核 Thm 2.20 是否隐含用 p^D>0 定符号；(c) PNAS 公告体裁（FGZ）的 rigorous 口径统一为「逐字编号命题 + 明写输入 + gaps 记无印出证明」，与 `no-ghost-theorem-brst--via-fgz` 一致，不降。
- **lead 裁决（2026-09-12，researcher-1084）**：Polchinski v2 (10.8.4)/(10.8.19) 前缀 α' 幂次的页图争议判为**渲染假象**（α'² 读数 100% 落在分母小字号；跨卷控制组同字形；重渲染读单撇），**不是排印错误**，不援引 (13.3.12) 先例；图上写 8π(8π²α')⁵。FGZ Prop 2.4 = Thm 1.12 + Prop 1.3（Thm 2.7 的「四条输入」逻辑冗余）；FGZ bib key 是 `fgz-1986`。
- **lead 裁决（2026-09-12，small-backlog-8）**：(a) FGZ 1986 是 PNAS 公告体裁，Thm 2.7 无独立证明但原文明写四条输入 "imply the following"——rigorous 按「逐字核实的编号定理 + 明写输入」判，gaps 记 Thm 1.12 证明未逐行复核；(b) (10.8.4) **不是** (13.3.1) 的母式（含 n² 与 Ω 的 ½），curator 判定正确，派工前提错；(c) (10.8.4)/(10.8.19) 前缀 α' 幂次页图 vs 复算冲突——researcher 高分辨页图复核中，若页图确印 α'² 则按 (13.3.12) 同法判排印错误。
- **lead 裁决（2026-09-12）**：`serre-1973-arithmetic` 的 bib 红线维持——本项目未核实该书任何定理号，图上 loc 只写章定位（Ch. VII pp.77–111，L2），「§1 Thm 2」只作 note 记为转引常见写法。
- **researcher-p148（2026-09-12，三项 L1）**：(1) Polchinski §5.1 全节**不印** Im(γτ) = Im τ/|cτ+d|²，该式在图上只有 Mathlib 桥来源；S、T 生成在 §5.1/§7.2 均只断言不证；(2) FGZ 1986 Thm 2.7 逐字入档，**Prop 2.6 后 Remark「V(E,p) not in general a direct sum of Verma modules」是 LZ vs FOK 之争的第二条独立反证（玻色版），站 LZ 一边**；(3) LZ p.330 原文引号只包 "covariant"、动词 achieved——图上不得写「LZ 证明了 GSO 投影」；Ḡ_κ 在 p.328 定义两次需消歧；βγ 项符号扫描件不可靠不入公式型 statement；GSO 原始提案 Gliozzi–Scherk–Olive 1977 待登记。
- **auditor 三项裁决（2026-09-11，rulings-3，一手页图）**：(1) LZ 1989 p.305 「p 未来向」实为**半空间** p^D > 0（非「未来半光锥」，两卡 source note 与抽取记录均误译），只定 R 扇区厄米型整体符号，Thm 2.4/2.7/Cor 2.15(i)/NS 扇区全不用它——**不是本质前提，(H2) p≠0 维持，不换代**；`brst-cohomology-equals-ocq-physical-superstring` statement 里「取 p 在未来半光锥」是比原文更强的误译（方向安全），下次实质换代时删。(2) `d-brane-bps-no-force → susy.brane-charges-in-susy-algebra` **维持 inferred**：Polchinski p.146 原句是 "its energy is determined only by its charge and **is independent of** the separations"——抽取记录 E16 与 branes 版论证都漏了 "is independent of"，把「无力」的复述当成了质荷引理；(13.3.2) 唯一依据是 "supersymmetric cancellation in the trace"。(3) ms.critical-dimension-bosonic 现真实瓶颈：光锥链（ζ 正规化、横向振子对易 ← Polyakov–NG）与 OPE/路径积分链（bc 中心荷）；DDF/无鬼已完全不在瓶颈。**待办（researcher）**：订正 `lian-zuckerman-1989.md`（半空间）与 `polchinski-1998-v2-ch13.md` E16（补 "is independent of"）两处误录，只加不改旧行。
- **researcher 五项**（派工中）：η S 变换数学来源（Apostol Thm 3.1 / Siegel 1954——ch7 子图最集中的单点缺口）；Polchinski v1 p.159 页图；LZ 1989 p.320 Remark 反例的 p；Gallier–Xu Lemma 6.1/Prop 6.1 逐字；Humphreys GTM 9 §23/§8 入口。

## 瓶颈分析（2026-09-10，`stringgraph why`）

- **光锥路线**（critical-dimension-light-cone）：瓶颈是 ζ 正规化、振子对易关系的无穷模式重排、光锥规范可达性、Polyakov–Nambu–Goto 经典等价，四处 physical-argument。
- **Weyl 反常路线**（critical-dimension-weyl-anomaly）：全部瓶颈汇聚到两个根——`laplacian-log-contact-term`（缺数学来源，researcher 找 PDE 教材定理中）与 `operator-product-expansion`（收敛未证）。中间节点自身都 rigorous。**升级该路线唯一有效动作是严格化这两个根。** `free-boson-central-charge-d` 因 `--via-mode-algebra` 绕开 OPE 已是 rigorous。
- **旧协变路线**：no-ghost-theorem-v3/v4 与 subcritical 均 rigorous，但可追溯性弱（GT 1972 正文未获取；LZ 1991 到本项目对象的翻译字典标 inferred）。

## 待拆清单（定义卡内嵌命题）

- ~~`tt-ope-central-charge`~~（已拆，2026-09-11 small-backlog-3：定义 v2 + 命题卡 tt-ope-pole-structure-from-conformal-invariance）、`bc-ghost-cft`、`open-string-virasoro-modes`（reviewer-ch23）
- ~~`worldsheet.verma-module`~~ 已拆（v2 formalized + math.verma-module-free-over-negative-part），2026-09-11
- ~~`worldsheet.virasoro-algebra`~~ 已拆（v2 formalized + virasoro-unique-central-extension），2026-09-11
- ~~待建：`math.euler-partition-generating-function`~~ 已建并 formalized（2026-09-11，任意交换环上无逆元形式）；Verma 特征标的形式化缺口现只剩 PBW 下界
- ~~`worldsheet.critical-dimension-bosonic`~~ 已建 v2（四路线分列、a = 1 限开弦、intercept-sign 约定，2026-09-11）；ms.critical-dimension-bosonic 指向 v2，待 auditor 第一轮回译
- ~~三张路线卡 v2、闭弦截距卡~~ 已完成（2026-09-11）。后续：`no-ghost-theorem-brst` 设定段自带 c^m = D，同法换代；闭弦 OCQ 物理态条件与闭弦光锥临界维数节点缺失
- ~~`worldsheet.brst-quantization`~~ 已建 v2（c^g 符号化，2026-09-11）；a^g = −1 仍在定义里，若 reviewer 坚持可再拆 v3
- `worldsheet.conformal-gauge-fixing`（"本图未单建该节点"已过时）
- `worldsheet.bc-ghost-cft`（两条内嵌命题）
- `worldsheet.no-ghost-theorem-v4`（(1) D=26 等距同构 与 (2) D>26 负模 的来源集合不相交：GT/Goddard/FGZ 只管 (1)，LZ 只管 (2)；拆成两卡后 LZ 可作 (2) 的独立推导。涉及里程碑指向，须在船长批准 v4 之后作为 v5 换代处理，不阻塞本次审批）
- `worldsheet.open-string-intercept`（"α'm² = N − a"已 formalized 覆盖，"一致性要求 a = 1"是 physical-argument，绑在一起无法记账；与 open-string-l0-level-form 同构）
- 待建：`H_phys 按 level 分级`（Fock.physSubmodule_eq_iSup_inf_levelSubmodule，现成 formalized 命题）
- `worldsheet.physical-states-level-one` 的 (3) 可拆出"a = 1 处纵向光子是零模态"
- `worldsheet.ocq-spurious-states`（定义带质量壳条件，Lean 的 spuriousSubmodule 不带；拆成"L_{−n} 像空间"（formalized）与"再交质量壳"两卡，让 spurious-orthogonal-to-physical 与 physical-states-level-one 回到 formalized）——**已完成 2026-09-11**（spurious-subspace formalized，level-one 复位）
- ~~vertex-operator-adjoint 与 momentum-tower-fock-space~~ 已建（2026-09-11）。后续（curator 建议，按价值排序）：~~(1) `:e^{ink_0·X}:` 在 k_0² = 0 时权 0 且主场~~ 与 ~~(2) "径向厄米共轭规则"卡~~ 已建（2026-09-11，分支 agent/curator/vertex-primary：`worldsheet.exponential-vertex-operator-weight` + `--via-ope-with-t`、`worldsheet.radial-hermitian-conjugation`；两条瓶颈推导与 ddf-operators-adjoint 推导已接线，四处散文加指针；两张 formalized 卡只加 notes 不加 uses）。(1) 的后续待裁：Lean 证的是**模形式** `L_m^{(a+b)}V_J − V_J L_m^{(a)} = (J + b·a − m + (m+1)·½b·b)V_{J−m}`，与卡片断言的 OPE 形式互推要经 `ope-pole-mode-commutator-dictionary`（physical-argument），故 VertexWeight.lean 完成后**不能直接**把该卡标 formalized——建议届时拆一张模形式卡承载 formalized。另待建：`worldsheet.boundary-normal-ordering`（开弦边界缩并加倍 = 闭弦 α'k²/4 与开弦 α'k² 之间的因子 4，Polchinski (6.2.34)，本图无节点）。仍待办：(3) 拆 ddf-operators-adjoint 的 (2) Gram 递推走 rigorous 例外；(4) A^i_n = Σ α^i_m V^{(n)}_{−m} vs Lean 的 V^{(n)}_m 逐项对应相反，形式化前定死一种
- `worldsheet.ddf-operators-v4`（一卡三事：A^i_n 定义、[L_m, A^i_n] = 0、[A^i_m, A^j_n] = mδδ；后两条是命题，形式化路径不同，拆成 v5 纯定义 + 两条 proposition；再加"横向性 ⟹ 模态和局部有限"命题，Lean 已有支撑）
- ~~`worldsheet.open-string-virasoro-modes-v2`~~ 已建 v3 + `open-string-doubling-trick` 命题（2026-09-11）。后续 doubling-trick 边已加（2026-09-11）
- `worldsheet.ocq-spurious-states`（定义带质量壳条件，Lean 的 spuriousSubmodule 不带；拆成"L_{−n} 像空间"（formalized）与"再交质量壳"两卡，让 spurious-orthogonal-to-physical 与 physical-states-level-one 回到 formalized）——**已派**
- ~~`worldsheet.ddf-operators-v4`（一卡三事：A^i_n 定义、[L_m, A^i_n] = 0、[A^i_m, A^j_n] = mδδ）~~ **已拆（2026-09-11，curator）**：`worldsheet.ddf-operators-v5`（definition, rigorous，只含围道积分定义与说明 (a)(b)(c)）+ `worldsheet.ddf-commute-with-virasoro`（physical-argument，--via-conformal-weight）+ `worldsheet.ddf-transverse-oscillator-algebra`（physical-argument，--via-conformal-weight）+ `worldsheet.ddf-transversality-gives-local-finiteness`（physical-argument，--via-mode-sum；Lean 两条支撑引理已在，组装未做）。`no-ghost-theorem-v4--via-goddard-thorn` 的 depends_on 已就地换代。**后果：`worldsheet.no-ghost-theorem-v4` 与 `worldsheet.critical-dimension-old-covariant` 的 effective 由 rigorous 降为 physical-argument**——这是 v4 定义卡长期掩盖的既有事实，不是论证退步。升级路径见两条命题节点的 notes。
- 待建：`(A^i_n)† = A^i_{−n}`（DDF 算子的伴随）。拆 ddf-operators-v4 时发现：`no-ghost-theorem-v4` (1b) 计算 H^⊥(k) 的 Gram 矩阵需要它，横向振子代数只给对易子。Lean 侧对应 V(b)_J† = V(−b)_{−J}，未做且当前只有 R-双线性型。
- 待裁决：**DDF 围道积分 ⟹ 模态和** 的字典（A^i_n = Σ_m α^i_m V^{(n)}_m）在图中无节点。两条出路：另立节点，或由 lead 裁定把模态和写进 A^i_n 的定义卡。这是 `ddf-transversality-gives-local-finiteness--via-mode-sum` 无法升到 rigorous 的第一个理由（第二个是缺 reviewer 复核记录）。
- `worldsheet.open-string-virasoro-modes-v2`（仍内嵌 doubling trick 命题，reviewer-batch2）
- `worldsheet.fock-indefinite-form`（"有序域上不定"末句未形式化：加一条平凡 Lean 引理或移到 notes）
- ~~`worldsheet.brst-cohomology-equals-ocq-physical` 拆目标~~ 已否决（2026-09-11）：LZ Lemma 2.22 p.565 逐字给出映射 ω ↦ [ω ⊗ 鬼真空]，两条推导都覆盖具体映射，不拆。
- ~~待建：math.virasoro-universal-central-extension~~ 已建（2026-09-11，Feldvoss–Siciliano Lemma 2.6）。`math.witt-algebra-perfect` 与 Hochschild–Serre 登记已完成（2026-09-11）；witt-perfect 的 Lean 形式化已派；PBW 基元模态排列方向（Kytölä 递增 vs 本图递减）待统一。kac-raina 2013 二版是否单独登记待裁。
- ~~待建：正规序等同节点~~ 已建 `worldsheet.normal-ordering-modes-agree`（2026-09-11）。后续拆：X 半边弱节点（让 c = D 的 OPE 路线不拖进鬼场链）与不含常数值的纯代数弱节点（可走 rigorous 例外）。`conformal-normal-ordering` 已出 v2（任意自由场含费米型，2026-09-11）。
- 待建：解析层节点"R{A(z)B(w)} 在环域全纯、两种排序互为解析延拓"（Gui Thm 8.1），使 ope-commutator-dictionary = 解析节点 + ope-pole-mode-commutator-dictionary
- **已闭合（2026-09-11）**：H 的 Chern–Simons 符号约定——Bilal 2008 β̃ = 1 已由 lead 逐页核实（(12.14)/(12.26)），GS (4) 与 Bilal (12.14) 相差 (B,H)↦(−B,−H)，两家一致；GS (5)(6)(15)(16) 与 Zumino Les Houches 1983 约定逐字同一；ZWZ 正文不可得（L2），图中不得出现"ZWZ eq. (X)"。
- 换代中：`worldsheet.critical-dimension-light-cone` → v2 补前提 D ≥ 4（auditor 第三轮要求；curator-critdim-followups）。
- **已建（2026-09-11）**：Riemann–Roch 数学路线——`math.riemann-roch-theorem`（Eynard Thm 1.2，rigorous）、`math.canonical-divisor-degree`、`math.quadratic-differentials-minus-holomorphic-vector-fields`（3g−3，待 reviewer 签字）、`worldsheet.riemann-roch-kappa-minus-mu-v2`（限可定向）。`why` 瓶颈在两座桥（CKV ⇔ 全纯向量场、模 ⇔ 全纯二次微分），不在 RR——正确暴露。待建：不可定向版（只有鬼数反常路线）、`math.negative-degree-divisor-no-sections`（关 μ(S₂)=0 残余）。
- 待建：`worldsheet.no-ghost-theorem-closed`（闭弦两组振子的 H_OCQ ≅ H_lc；v4 是单组振子）——桥卡 `covariant-external-legs-on-shell` 第 (4) 步闭弦半目前是类比。
- 待换代：`worldsheet.kac-determinant` 陈述中 α_N "正"无据（FF 写 ненулевая、Schottenloher 写 K_N ≥ 0）；lead 裁决：新建 v2 写"非零常数"并 superseded_by（不是里程碑，走普通换代）。
- 待建：`worldsheet.shapovalov-form-unconditional-existence`（rigorous，依赖 verma-module-free-over-negative-part；`--via-pbw` 已证到但无节点承载）；`descendant-weight-grading*` 可挂 Verma.lean 新 `lie_lgen_mem_levelSpan`（任意交换 ℚ-代数、无 c,h 假设）。
- **lead 裁决（2026-09-11）**：`math.chern-simons-descent-equations--via-chern-weil-transgression` 保持 rigorous——Chern–Weil transgression 是标准已发表数学定理，own status 按论证本身；但三条 canonical 数学源（Chern / Kobayashi–Nomizu / Nakahara）目前 L0，researcher 须在该卡进入任何里程碑推导链前核实到编号。
- **记账红线（2026-09-11，ADT 2010 L1）**：U(1)⁴⁹⁶ 与 E₈×U(1)²⁴⁸ 只是使反常十二形式**因子化**，GS 抵消项在阿贝尔情形**写不下来**（Y₄ ≠ dH₃，与超对称+阿贝尔规范不变性不相容）——图中分类卡只能写"因子化"，不得写"反常抵消"；Vafa 2005 E15 的前提被 ADT 反驳。四解分类原文措辞仍 L0（GSW ch.13 待船长点击）。
- **已核实（2026-09-11，Polchinski v2 ch.12 L1）**：四解分类原文措辞——p.101 脚注 1 "They also **hold** for E₈×U(1)²⁴⁸ and U(1)⁴⁹⁶, but no corresponding string theories are known"；两条 properties（伴随迹组合为零 + n = 496），**无唯一性主张**。裁决：分类拆 (A1) 四群满足两条 properties（rigorous，纯代数）+ (A2) 完备性（physical-argument/conjecture）。Polchinski 拒绝固定 H 的 CS 常数 c、c′（(12.2.22)），独立佐证"相对符号是不变量"。**§12.5 p.126 作者自承**："a fully explicit proof of the perturbative consistency of the theory seems to be lacking"——建 `consistency.superstring-perturbative-consistency-unproven` 作 consistency 区共同瓶颈（Witten 2012–13 超黎曼面是否填上：待查）。
- **原书页核实结案（2026-09-11，Polchinski v1 §13–§14）**：X^μ **是** h=0 主场（p.47 逐字；旧 `primary-field` 卡的反例是错的，已换代 v2）；T = 1/(2πα') 是 (1.2.10)；(A.1.31) 不是 e^{iS}=e^{−S_E}（本项目合成）；(1.2.31) Euler 数无边界项；书末参考文献把 OCQ 无鬼定理归 Brower 1972 + GT 1972，§4.4 自陈 "loosely patterned on" Kato–Ogawa（Kac/FF/Thorn 1985 不在参考文献）；ch.7 tadpole 相消是 **SO(8192)**（玻色弦，作者自称 "probably has no special significance"），SO(32) 只一句前向指路；(6.4.18) α's = 0 极点在两循环序间相消（p.183 逐字，含全部偶数倍）；(6.6.21) 印刷 4α' 是误印（应 ¼α'）。
- **Witten 2012–13 超黎曼面系列（L1）**：PCO 被导出、伪奇点被指认，但**全系列无一处宣称微扰一致性已证**（摘要 "demonstration"，§8.3 归纳挂在未证 "if"）；Donagi–Witten 非投影性**不是**对 PCO 的否定（逐字 "does not depend on a projection"）。三卡结构（1998 缺口 open / Witten 框架 physical-argument / DW rigorous）建设中。
- **type I SO(32) 来源已定（Polchinski v2 §10.8 L1）**：(10.8.19) (n ∓ 32)²，"The R–R tadpole vanishes only for the gauge group SO(32)"；全节零习题；但符号未算（"should be n ∓ 32"）、脚注 7 真条件是 NS–NS 与 R–R 各自拓扑求和为零。**与六边形反常无原文连接**（§10.6 p.31 并列为两件事；§12.2 E19 "determined by cancellation of tadpole divergences"）——两卡不建边。辛支 (n+32)² 无解，本书不出现 USp(32)。待建 ch10 分支 `type-i-tadpole-cancellation-so32` 修正（ch10 审查后）。
- **两章矛盾待裁（ch11 curator 发现）**：ch10 `ten-dimensional-superstring-theories` (P5) 以"时空反常"筛选 vs §12.2 "in principle not necessary to check the low energy anomaly"——交 reviewer-v2-ch10。
- **Vol.2 ch.13 已抽（L1，2026-09-12）**：原书 p.144 逐字 "**16 D9-branes** (and an orientifold 9-plane)"、O 面荷 −2^{4−k}——**不是 32**（p.141 "each CP degree of freedom as a 9-brane" 蕴含 32，原书不调和，Q1 未裁）；O9–D9 相消是 §10.8 的推论（三处 "deduced in section 10.8"），不独立；BPS 无力有作者亲口反例 (13.4.23)；τ_p (13.3.4)/(13.3.23)、Dirac n=1 精确。branes 区建设中。App. B（旋量）已抽并建卡（2026-09-11：`math.clifford-majorana-weyl-mod-8`、`math.so-n-spinor-reality-mod-8`、`susy.bps-bound-point-particle-d4` 等，见 v2-appB 分支）。
- 待建：玻色化节点（§10.3 (10.3.5) 起，本图最大结构性空白）；§11.4–11.5 李代数/流代数/Sugawara c^{g,k}（E59–E62 ★★★）。
- **lead 裁决（2026-09-12）**：陈述正文内嵌的**节点 id 指针**过期（如 `veneziano-regge-behavior`、`open-string-hard-scattering-exponential-falloff` 正文写 `veneziano-amplitude-weak`；`cft/one-and-two-point-functions-mobius-fixed`、`radial-hermitian-conjugation` 写 `primary-field`）**不单独换代**——纯指针不改命题内容；依赖边已指新卡；等下次实质换代时一并同步。
- **BRST 无鬼一手来源（2026-09-12）**：Kato–Ogawa/Ohta/Henneaux 正文均未取得（L2/L3）；意外取得 L1 全文：Lian–Zuckerman 1989 CMP 125 **Thm 2.20**（超弦相对上同调 ≅ 光锥谱，自命名 "No-ghost Theorem" Cor 2.15(ii)）、Figueroa-O'Farrill–Kimura 1989、IMNU 1986（R 扇区无鬼物理证明）、Dedushenko（picture 无关性）。**FOK vs LZ 真矛盾**（Fock 空间是否 Verma 模直和）待 Brower–Friedman 1973。超弦无鬼卡经 LZ Thm 2.20 可 rigorous——curator 接线中。
- **GGRT 1973 正文仍 L0**（CDS 394307 PUBLIC 但 Anubis 拦截；Wayback 快照存在——**船长点击清单 +1**：`https://cds.cern.ch/record/394307/files/CM-P00058492.pdf`）；Bering arXiv:1104.4446 (7.1) 是 [J^{−i},J^{−j}] 显式表达式的 L1 替代（"precisely vanishes for D = 26 and a = 1"，非 iff）；Bering 说 GGRT "sparse on details" vs Polchinski "careful treatment"——未裁。Polchinski (3.2.3b) p.82 Euler 数含边界项 L1（`worldsheet-euler-number` 可改挂）。
- **偶幺模格来源（2026-09-12，L1）**：秩 ≡ 0 mod 8 = Zagier 2008 §3.2 **Prop 12(i)**（有证明）；16 维恰两类 = Chenevier–Lannes arXiv:1409.7616 ch.II **Cor 3.6**（含"不同构"）。四本教科书定理号全 L0 禁写；"Witt 1941 证 16 维分类"查无实据（CL 归功不挂标签）。认识论要点：数学卡升 rigorous **不会**让杂化弦"恰有两个"变严格——瓶颈是 §11.6 "一致 CFT ⟺ 偶自对偶格"物理桥，且原书 "exactly two such lattices" 零出处。
- **consistency 区 Lean 接线完成（2026-09-12）**：反常多项式重排 (12.2.27)≡(12.2.11)+(12.2.12)（formalized）、IIB 整数解（formalized；三式秩 2）、六边形 32（拆出 n=6 卡 formalized，一般 n 卡保持）、GS 三张 math 卡各挂 Lean（被迹恒等式压 physical-argument）；`h-field-strength-chern-simons` 与 `anomaly-twelve-form-d10` 各拆三卡。**consistency 区最大单条来源缺口**：升维字典（2n 维反常 ↔ 2n+2 维不变多项式）——四条来源全当已知。
- **ch10/ch11 栈上待合**（等 ch10 审查）：ch11 杂化弦（17 卡）、bosonization（7 卡 + `conv.nonembedding-scalar-normalization`）、unimodular-cards、brst-noghost（LZ Thm 2.20 rigorous 推导）。
- **待船长裁决（open ruling）**：AdS₅/CFT₄ 规范群 **U(N)（Maldacena 逐字）vs SU(N)（Witten §2.6 k=1 态不在 KK 谱，脚注 7 U(1) singleton）**——两卡并列（`ads5-cft4-duality-v2` / `gauge-group-su-n-from-kk-spectrum-v2`，v1 已换代）；钩子：Maldacena "(and possibly also some boundary degrees of freedom)" ↔ Witten fn7。若日后立 AdS/CFT 里程碑，canonical 须择一并注明。
- 待拆：`consistency.h-field-strength-chern-simons`（H 定义 + δB 变换律两件事；补 δH = 0 命题卡）；`consistency.anomaly-twelve-form-d10` 定义卡内嵌两条命题（六边形唯一决定高点反常；WZ 条件 ⇒ 十二形式）（reviewer-gs1984）。
- 待建（GS 迹恒等式升 rigorous 所需数学来源）：so(N) 伴随 ≅ Λ²V、usp(N) 伴随 ≅ Sym²V（Fulton–Harris 节号待核）；E₈ 根系（Bourbaki Lie VI Planche VII）+ Chevalley 限制定理（Humphreys §23.1）后建 `--via-so16-weights`。
- **lead 裁决（2026-09-11）来源合规**：Appelquist 重印本扫描中的 GS 1984 单篇（4 页）按"单章扫描"处理，允许作 L1 载体；"非官方全本扫描不使用"针对整本教材，不针对重印文集里的单篇论文。
- 待建：**`worldsheet.free-boson-vertex-algebra`**（D 个自由玻色子（不定号差）⊗ C[Z k_0] 的 Heisenberg/格点顶点代数，动量塔为其模；来源 FLM / Kac / Lepowsky–Li）与 **`math.vertex-algebra-jacobi-identity`**（Borcherds 恒等式带编号）。补上后 G–N 推导 `ddf-commute-with-virasoro--via-vertex-algebra-primary` 直接升 rigorous，无鬼定理随之回 rigorous——**这是当前最短的升级路径**（curator-gn-ddf 2026-09-11）。
- 待处理：Polchinski v1 原书核实（§12.10）30 条 loc 修改、15 条作者自承缺口、Q6（weyl-anomaly-v2 的 c^m=26 应挂 §4.3 (4.3.9)）、Q22 撤销 Narain 压级建议、Q3（OPE 收敛 p.69 有论证）。
- **已建（2026-09-11）**：`spectrum.covariant-external-legs-on-shell`（撤 4 条 inferred，3 条窄化为中间态上壳）。原条目：**"光锥质量壳 → 协变振幅外线 on-shell"**（§1 光锥谱与 §6 协变振幅外线之间的系统性缺环，§6 分支 6 条 inferred 边全指向它；reviewer-ch6）
- 待建：`compact.kaluza-klein-metric-ansatz`（(8.1.2)，KK 塔的前提 G^{μd}=0 目前只在陈述文本里）；Chan–Paton 卡就位后 Wilson 线两卡补边
- 待建：欧氏 Polyakov 作用量定义卡或"S_P^L diff×Weyl 不变 ⟹ S_P^E 亦然"命题，让 Wick 旋转从约定节点变成有陈述承载

## 待裁决（历史，2026-09-10 第一批 agent 提出；处理见上）

- **`worldsheet.ope-convergence` 公理节点**（researcher Q3）：Polchinski 用围道变形从 OPE 推 Virasoro 代数，书中不证 OPE 收敛。图里现有的 `virasoro-algebra` 是抽象李代数定义，本身 rigorous，不受影响；受影响的是尚未建立的"自由玻色子的 Sugawara 构造满足 Virasoro 关系"一类节点。建 Sugawara 节点时再决定是否挂此公理。
- **`worldsheet.virasoro-algebra` 拆卡**（formalizer）：定义部分已形式化，"唯一非平凡中心扩张"未形式化。拆成定义卡（可标 formalized）+ 唯一性命题卡。
- **a<1 分支的文献出处**：GT 1972 / Brower 1972 只覆盖 a=1。候选 Thorn 1987（已登记 `thorn-1987`）。
- **原书核对**：Polchinski v1 抽取全部依赖二手源；E34（c=D 锚点）、E53、E58 三条主线陈述需持原书者核对。GT 1972 与 Brower 1972 正文在付费墙后。

## 发表路线（2026-09-12，lead 评估，船长确认前为草案）

- **现状**：DDF 构造全部 Lean 机检（[L_m,A]=0 ∀m、伴随、保持物理态、[A,A]=m(ε·δ)δ；任意交换 ℚ-代数、动量塔 Fock 空间）+ Kac N≤4 + Verma 层基 + Fock Gram；无鬼定理 v4 本身 effective rigorous 但**非 Lean 定理**，且 GT 1972 / Brower 1972 正文未取得；全部审查为 AI agent。
- **三条路线**：(1) Lean 形式化论文（ITP/CPP/JAR）——差一个定理：在 Lean 里关无鬼定理（张成引理 ← Fock 模在 Vir⁻ 下自由 ← Kac 行列式非零；纵向算子 K_m；正定性组装）；(2) 方法论 + 工具 + 数据集（SciPost Codebases / JOSS / CICM）——接近可投，需英文化、schema 冻结、公开仓库、一次人类审计、先行工作对比；(3) 物理侧依赖审计综述（CMP/JHEP 类）——最远，需整块覆盖 + 人类专家复核。
- **无鬼定理 Lean 蓝图（2026-09-12，`formal/BLUEPRINT-noghost.md`，748 行）**：(A) 纵向算子取 GT 的 K_n = k_0·α_n（非 Brower A^L），在本仓库就是 `towerModeVec` 取偏振 ε := b，四条关系是现有引理特例——几乎白送；(B) 张成引理：FGZ 路线（一般 N Kac 行列式）判死路，推荐光锥标架下「DDF/K/L 单项式 → 振子单项式」转移矩阵幺三角；**D = 26 只在 (B-26)「H^⊥ 之外的 p_{D−1}(N)−p_{D−2}(N) 个方向恰为零模态」一步进入**，DDF 代数/伴随/Gram 均与 D 无关——这是整条 GT 链的真正承重点，文献支撑只有 Goddard 2008 (6.4) 一句转引；(C) 正定性组装不依赖 B。**先做三条**：C.2 假设可满足性见证、A.1 K 算子、C.1 塔上零模态与商形式。**2026-09-12 上午：C.2 与 A.1/A.2 已合 main（Witness.lean、Longitudinal.lean；六条 K 关系全证，含 [K,A]=0；21 条声明公理干净）**；**C.1/C.3 已合 main（TowerNull.lean 44 条：塔上 H_null、正交补、商形式；HeisenbergGram.lean 19 条：任意 Heisenberg 族 Gram 对角）**；**B.1 已合 main（LightCone.lean 81 条：塔上双分次、光锥标架代数、A^ε_{−1}|0⟩ 首项、N=1 张成 `towerPhys_bigrade_one_le_ddfSpan_sup_spurious`）**；N=2 卡在 (a) creaExp 层 2 分量 (b) 层 2 完整物理态解（派工中）。**新发现的缺假设**：A^ε_{−1}|0;k⟩ = α^ε_{−1}|0;k−k₀⟩ 需 ε·k = 0（非仅 ε·k₀ = 0），`ddf-operators-v6` 未列；标架完备性是独立假设。剩余 C.4（DDF 族实例化：⟨vac,vac⟩=1、A vac=0、横向正交标架）与 C.5 组装。Mathlib 障碍：`ℤ →₀ k` 的子模商实例合成失败（值得提 issue）。结构性限制：`Fock D R` 度规钉死对角 η，光锥基只能在算子层换。
- **已产出**：先行工作检索两轮（`literature/extractions/prior-formalizations.md`，A 级清单无反例）；无鬼定理 Lean 蓝图（`formal/BLUEPRINT-noghost.md`）；**两份英文论文骨架**：`docs/PAPER-outline-formalization.md`（ITP/CPP 路线，只宣称 A 级项）与 `docs/PAPER-outline-methodology.md`（SciPost Codebases / JOSS / CICM 路线）——均在 reviewer 对抗核查中；船长审批包 `docs/CAPTAIN-PACKET-2026-09-12.md`（**初版被 reviewer 核出 9 处错误，修订中，勿据此签字、勿运行其清理脚本**）。
- **先行工作检索结论（2026-09-12，`literature/extractions/prior-formalizations.md`）**：Carnahan `vertexAlg`（最先进的 Lean 顶点代数项目）README TODO 逐字列「virasoro representations, no-ghost theorem, invariant inner products」为未来目标；Kytölä arXiv:2510.21741 §1.3 逐字「not aware of earlier formalizations in any proof assistants」；Mathlib/AFP/agda-unimath/Physlib 均无 Virasoro 表示/Verma/Kac/DDF。**A 级可宣称首次**：Virasoro Shapovalov 形式；Kac 行列式 N≤4 机器验证（措辞「实例」）；横向 DDF 算子及其代数；洛伦兹不定内积 D 分量 Fock 空间 + c=D Sugawara；GS 反常因子化代数层 + IIB 整数解唯一性；E₈ 显式根集幂和。**不可宣称**：无鬼定理本身（未做完）、Virasoro/Witt/Verma/中心扩张（Kytölä、Carnahan）、顶点代数/locality、PBW、η S 变换与模群生成（Mathlib 搬运）。方法论对照：leanblueprint 已是「节点=陈述、边=uses、带状态」的图，差异只在状态轴语义（离形式化多远 vs 底层论证严格度）——论文不得写「已有工作只有静态文档」。最大证据缺口：Lean Zulip 与 GitHub code search 未查（WebSearch 额度为 0）。
- **条件版无鬼定理已机检（2026-09-11，noghost-conditional）**：`StringFormal.NoGhost.no_ghost_of_spans`（Assembly.lean，C.5 组装）证明「若 H_phys ⊆ DDF 张成 + H_null 则 H_phys/H_null 上诱导型正定」，对**任意 D、任意有序域**，文件里 26 一次不出现；图上 `worldsheet.no-ghost-theorem-conditional-on-ddf-spanning`（own formalized，effective open——由前件压低，这是条件命题的正确读数）。**猜想负担集中于一张卡**：`worldsheet.ddf-spanning-hypothesis`（= Lean `DDFSpans`，open，刻意无推导，D = 26 只在此进入；已证片 (rung −1, level 1) 见 `…-level-one-modulo-null`，N=2 进行中，「逐片 ⇒ 全体」拼装引理尚缺）。对路线 (1) 的含义：「差一个定理」现在精确到「差一条假设的证明」，论文可如实宣称条件版；无鬼定理本身仍**不可宣称**。
- **需船长**：GT 1972 / Brower 1972 原文；至少一位人类审阅者核三个里程碑与 Lean 定理陈述。
