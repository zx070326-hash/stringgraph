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
- 计数：main 238 statements / 176 derivations / 27 formalized；Lean 26 声明公理干净（2144 jobs）。
- 玻色弦：Polchinski v1 §1–6 全部入图并经 reviewer 审查（§5 moduli/CKV/Riemann–Roch/S 矩阵母公式；§6 树级振幅 spectrum 区 23 节点，Veneziano/Virasoro–Shapiro/Chan–Paton）；§8（T 对偶、Narain、D 膜）分支在审。**原书页核实**（Cambridge Core）关闭 13 条疑问、30 条 loc 修正、15 条作者自承缺口——落图中。
- 超弦：v2 §10–11 抽取完成（61 条 L1）；§10 RNS/GSO/超共形代数/D=10 分支已交付（41 statements + 28 derivations，`critical-dimension-superstring` 汇总卡 (I)–(IV) 明确本卷对 D=10 只有一条实质论证），在审。
- 里程碑：`ms.no-ghost-theorem` 五轮回译 faithful，等船长 approved；`ms.critical-dimension-bosonic` v3 已换代（(I) a 待定 + D ≥ 4；(V) "一致性要求 a = 1"），第三轮回译进行中；`ms.critical-dimension-superstring` 待 §10 入图后起草。
- Lean 岛 1（无鬼定理）：Fock / Sugawara / 物理态 / L_m 伴随 / 伪态 / 商形式 / 动量塔配对 / **[L_m, V_J] 共形权（m ≥ 1）与塔上版本** / level-2 负模态（含 p ≠ 0）已机器验证；进行中：DDF 算子 A^i_n 定义 + [L_m, A]=0（m ≥ 1）。剩：m < 0、DDF 横向代数、张成定理。
- 无鬼定理回 rigorous 的最短路径：Gebert–Nicolai 顶点代数推导已入图（own rigorous），只被"自由玻色子顶点代数"缺卡压成 open——researcher 正找 Kac/LL/FLM 对不定号差格的编号定理。
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

- **ms.no-ghost-theorem 审批**：第四轮回译裁定 faithful，`audit.status: back-translated`，陈述 `worldsheet.no-ghost-theorem-v4`。审计员建议 approved。**2026-09-11 更新：拆 ddf-operators-v4 后，该里程碑的有效状态从 rigorous 降为 physical-argument**——原因是 [L_m, A^i_n] = 0 与 [A^i_m, A^j_n] = mδδ 两条对易关系此前以"定义的一部分"身份传播 rigorous，图中从未独立论证，文献（Goddard 2008/GSW）也只预设不证明。这不是陈述有错，是记账修正；升级路径是 Lean 共形权（进行中）与顶点算子乘积。船长审批 approved 时应知晓：**里程碑陈述忠实，但其推导链目前含两处 physical-argument**。第五轮审计（2026-09-11）确认 canonical_text 不引 ddf-v4（引用只在 statement 内，不可变），忠实性裁定维持；裁定 **approved 只断言忠实性，不绑有效状态**（已写入 docs/STATUS_LEVELS.md）。船长可在 effective = physical-argument 下批准。船长需知晓三个已登记 gap：(2) 的历史归属仅二手（Goddard 2008 → Brower–Thorn 1971）；canonical_source 仍是 GT 1972 摘要级、只覆盖 (1a)；逐塔打包与一般 α' 归一化是本项目规范化，文献无逐字。批准操作：把该文件 `audit.status` 改为 `approved` 并提交。

- **需船长人工点击一次的文件**（agent 被反爬拦住，文件本身公开；见 literature/extractions/primary-sources-round2.md §12.9）：
  1. Goddard–Thorn 1972 正文：`https://cds.cern.ch/record/388690/files/CM-P00058839.pdf`（CERN-TH-1493，MARC 963 = PUBLIC）——里程碑 canonical_source 的一手来源
  2. Brower–Thorn 1971：`https://cds.cern.ch/record/352004/files/CM-P00058794.pdf`——可裁决 D>26 负模态的历史归属
  4. **GSW Vol.2 ch.13（pp.307–362，12 MB，超出 WebFetch 10 MB 上限）**：`https://www.cambridge.org/core/services/aop-cambridge-core/content/view/F2BEB1F0811FE1D8458547AAB73D12AF/9781139248570c6_p307-362_CBO.pdf/low-energy-effective-action.pdf`——本机构有 Cambridge Core 订阅；取到即可裁决四解分类的原文措辞（§13.5.3 pp.353–358）。同一天花板卡住 GSW v1 ch.2（无鬼定理 §2.3.3，13 MB）。
  3. Thorn 1985 Santa Barbara 42 页报告（自述"improved version of the Goddard–Thorn proof"）：`https://inis.iaea.org/records/szqhd-hct30`，需免费注册——是否注册请船长决定
  下载后放 `literature/raw/`（gitignore）并告知，researcher 即可逐页抽取。

## 瓶颈分析（2026-09-10，`stringgraph why`）

- **光锥路线**（critical-dimension-light-cone）：瓶颈是 ζ 正规化、振子对易关系的无穷模式重排、光锥规范可达性、Polyakov–Nambu–Goto 经典等价，四处 physical-argument。
- **Weyl 反常路线**（critical-dimension-weyl-anomaly）：全部瓶颈汇聚到两个根——`laplacian-log-contact-term`（缺数学来源，researcher 找 PDE 教材定理中）与 `operator-product-expansion`（收敛未证）。中间节点自身都 rigorous。**升级该路线唯一有效动作是严格化这两个根。** `free-boson-central-charge-d` 因 `--via-mode-algebra` 绕开 OPE 已是 rigorous。
- **旧协变路线**：no-ghost-theorem-v3/v4 与 subcritical 均 rigorous，但可追溯性弱（GT 1972 正文未获取；LZ 1991 到本项目对象的翻译字典标 inferred）。

## 待拆清单（定义卡内嵌命题）

- `tt-ope-central-charge`、`bc-ghost-cft`、`open-string-virasoro-modes`（reviewer-ch23）
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
- 待换代：`worldsheet.critical-dimension-light-cone` 补前提 D ≥ 4（iff 在 D ≤ 3 不成立；GSW 原文同样未写）——等 auditor 第三轮裁定。
- 待换代：`worldsheet.kac-determinant` 陈述中 α_N "正"无据（FF 写 ненулевая、Schottenloher 写 K_N ≥ 0）；lead 裁决：新建 v2 写"非零常数"并 superseded_by（不是里程碑，走普通换代）。
- 待建：`worldsheet.shapovalov-form-unconditional-existence`（rigorous，依赖 verma-module-free-over-negative-part；`--via-pbw` 已证到但无节点承载）；`descendant-weight-grading*` 可挂 Verma.lean 新 `lie_lgen_mem_levelSpan`（任意交换 ℚ-代数、无 c,h 假设）。
- **lead 裁决（2026-09-11）**：`math.chern-simons-descent-equations--via-chern-weil-transgression` 保持 rigorous——Chern–Weil transgression 是标准已发表数学定理，own status 按论证本身；但三条 canonical 数学源（Chern / Kobayashi–Nomizu / Nakahara）目前 L0，researcher 须在该卡进入任何里程碑推导链前核实到编号。
- **记账红线（2026-09-11，ADT 2010 L1）**：U(1)⁴⁹⁶ 与 E₈×U(1)²⁴⁸ 只是使反常十二形式**因子化**，GS 抵消项在阿贝尔情形**写不下来**（Y₄ ≠ dH₃，与超对称+阿贝尔规范不变性不相容）——图中分类卡只能写"因子化"，不得写"反常抵消"；Vafa 2005 E15 的前提被 ADT 反驳。四解分类原文措辞仍 L0（GSW ch.13 待船长点击）。
- 待拆：`consistency.h-field-strength-chern-simons`（H 定义 + δB 变换律两件事；补 δH = 0 命题卡）；`consistency.anomaly-twelve-form-d10` 定义卡内嵌两条命题（六边形唯一决定高点反常；WZ 条件 ⇒ 十二形式）（reviewer-gs1984）。
- 待建（GS 迹恒等式升 rigorous 所需数学来源）：so(N) 伴随 ≅ Λ²V、usp(N) 伴随 ≅ Sym²V（Fulton–Harris 节号待核）；E₈ 根系（Bourbaki Lie VI Planche VII）+ Chevalley 限制定理（Humphreys §23.1）后建 `--via-so16-weights`。
- **lead 裁决（2026-09-11）来源合规**：Appelquist 重印本扫描中的 GS 1984 单篇（4 页）按"单章扫描"处理，允许作 L1 载体；"非官方全本扫描不使用"针对整本教材，不针对重印文集里的单篇论文。
- 待建：**`worldsheet.free-boson-vertex-algebra`**（D 个自由玻色子（不定号差）⊗ C[Z k_0] 的 Heisenberg/格点顶点代数，动量塔为其模；来源 FLM / Kac / Lepowsky–Li）与 **`math.vertex-algebra-jacobi-identity`**（Borcherds 恒等式带编号）。补上后 G–N 推导 `ddf-commute-with-virasoro--via-vertex-algebra-primary` 直接升 rigorous，无鬼定理随之回 rigorous——**这是当前最短的升级路径**（curator-gn-ddf 2026-09-11）。
- 待处理：Polchinski v1 原书核实（§12.10）30 条 loc 修改、15 条作者自承缺口、Q6（weyl-anomaly-v2 的 c^m=26 应挂 §4.3 (4.3.9)）、Q22 撤销 Narain 压级建议、Q3（OPE 收敛 p.69 有论证）。
- 待建：**"光锥质量壳 → 协变振幅外线 on-shell"**（§1 光锥谱与 §6 协变振幅外线之间的系统性缺环，§6 分支 6 条 inferred 边全指向它；reviewer-ch6）
- 待建：`compact.kaluza-klein-metric-ansatz`（(8.1.2)，KK 塔的前提 G^{μd}=0 目前只在陈述文本里）；Chan–Paton 卡就位后 Wilson 线两卡补边
- 待建：欧氏 Polyakov 作用量定义卡或"S_P^L diff×Weyl 不变 ⟹ S_P^E 亦然"命题，让 Wick 旋转从约定节点变成有陈述承载

## 待裁决（历史，2026-09-10 第一批 agent 提出；处理见上）

- **`worldsheet.ope-convergence` 公理节点**（researcher Q3）：Polchinski 用围道变形从 OPE 推 Virasoro 代数，书中不证 OPE 收敛。图里现有的 `virasoro-algebra` 是抽象李代数定义，本身 rigorous，不受影响；受影响的是尚未建立的"自由玻色子的 Sugawara 构造满足 Virasoro 关系"一类节点。建 Sugawara 节点时再决定是否挂此公理。
- **`worldsheet.virasoro-algebra` 拆卡**（formalizer）：定义部分已形式化，"唯一非平凡中心扩张"未形式化。拆成定义卡（可标 formalized）+ 唯一性命题卡。
- **a<1 分支的文献出处**：GT 1972 / Brower 1972 只覆盖 a=1。候选 Thorn 1987（已登记 `thorn-1987`）。
- **原书核对**：Polchinski v1 抽取全部依赖二手源；E34（c=D 锚点）、E53、E58 三条主线陈述需持原书者核对。GT 1972 与 Brower 1972 正文在付费墙后。
