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

## Phase 2：一致性与对偶子图

- Green–Schwarz 反常消除、T 对偶（环面）、S 对偶（猜想）、五种超弦与 M 理论关系
- 这一阶段的目的是让报告第一次显示"哪些结论压在哪些猜想上"
- Lean 岛 2：Green–Schwarz 反常多项式的因子化（代数部分）

## Phase 3：全息与黑洞

- AdS/CFT（作为 axiom/conjecture 双轨）、Strominger–Vafa 熵、Ryu–Takayanagi、岛公式
- 目标产出：一份公开报告，列出全息扇区每条主要结论的猜想依赖集合

## Phase 4：沼泽地

- 每条沼泽地猜想双轨挂载（成立方向 / 反例方向）
- 与观测约束（暗能量演化等）的接口节点

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
- `worldsheet.critical-dimension-old-covariant`（"退耦""不幺正"无定义措辞；末句 D<26 不被 no-ghost-v4 支撑）——**已派**
- `worldsheet.critical-dimension-brst` / `-weyl-anomaly`（末句自带 c^m = D ⟹ D = 26 一步，应移出陈述改为依赖 free-boson-central-charge-d）——**已派**
- 待建：闭弦截距 (a, ã) = (1, 1) 与质量壳 α'm²/4 = N − a 卡——**已派**
- ~~`worldsheet.brst-quantization`~~ 已建 v2（c^g 符号化，2026-09-11）；a^g = −1 仍在定义里，若 reviewer 坚持可再拆 v3
- `worldsheet.conformal-gauge-fixing`（"本图未单建该节点"已过时）
- `worldsheet.bc-ghost-cft`（两条内嵌命题）
- `worldsheet.no-ghost-theorem-v4`（(1) D=26 等距同构 与 (2) D>26 负模 的来源集合不相交：GT/Goddard/FGZ 只管 (1)，LZ 只管 (2)；拆成两卡后 LZ 可作 (2) 的独立推导。涉及里程碑指向，须在船长批准 v4 之后作为 v5 换代处理，不阻塞本次审批）
- `worldsheet.open-string-intercept`（"α'm² = N − a"已 formalized 覆盖，"一致性要求 a = 1"是 physical-argument，绑在一起无法记账；与 open-string-l0-level-form 同构）
- 待建：`H_phys 按 level 分级`（Fock.physSubmodule_eq_iSup_inf_levelSubmodule，现成 formalized 命题）
- `worldsheet.physical-states-level-one` 的 (3) 可拆出"a = 1 处纵向光子是零模态"
- `worldsheet.ocq-spurious-states`（定义带质量壳条件，Lean 的 spuriousSubmodule 不带；拆成"L_{−n} 像空间"（formalized）与"再交质量壳"两卡，让 spurious-orthogonal-to-physical 与 physical-states-level-one 回到 formalized）——**已完成 2026-09-11**（spurious-subspace formalized，level-one 复位）
- 待建：`worldsheet.vertex-operator-adjoint`（V(b)_J† = V(−b)_{−J}，b·b = 0）与"动量塔及其双线性型"定义卡（ddf-adjoint / ddf-commute / no-ghost v4 三处隐含使用层间正交）——**已派**
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
- 待建：欧氏 Polyakov 作用量定义卡或"S_P^L diff×Weyl 不变 ⟹ S_P^E 亦然"命题，让 Wick 旋转从约定节点变成有陈述承载

## 待裁决（历史，2026-09-10 第一批 agent 提出；处理见上）

- **`worldsheet.ope-convergence` 公理节点**（researcher Q3）：Polchinski 用围道变形从 OPE 推 Virasoro 代数，书中不证 OPE 收敛。图里现有的 `virasoro-algebra` 是抽象李代数定义，本身 rigorous，不受影响；受影响的是尚未建立的"自由玻色子的 Sugawara 构造满足 Virasoro 关系"一类节点。建 Sugawara 节点时再决定是否挂此公理。
- **`worldsheet.virasoro-algebra` 拆卡**（formalizer）：定义部分已形式化，"唯一非平凡中心扩张"未形式化。拆成定义卡（可标 formalized）+ 唯一性命题卡。
- **a<1 分支的文献出处**：GT 1972 / Brower 1972 只覆盖 a=1。候选 Thorn 1987（已登记 `thorn-1987`）。
- **原书核对**：Polchinski v1 抽取全部依赖二手源；E34（c=D 锚点）、E53、E58 三条主线陈述需持原书者核对。GT 1972 与 Brower 1972 正文在付费墙后。
