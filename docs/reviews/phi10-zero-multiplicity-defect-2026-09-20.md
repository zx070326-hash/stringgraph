# 缺陷报告：Φ₁₀ 零点重数在图中被写成「单零点」，与本项目已登记的一手来源矛盾

**发现人**：graph-curator（agent `grad3`，2026-09-20，毕业三条数学结果时顺带发现）
**lead 复核并扩大范围**：2026-09-20（本文件）
**严重性**：🔴 事实错误，且**已污染一条船长批准的里程碑回译**
**处置**：**不由 lead 单方面改卡**——按根 CLAUDE.md 原则 4（同一对象的不兼容表述提交
里程碑流程做规范化）+ 原则 3（里程碑是船长的审计面），交 `physics-auditor` 规范化。

---

## 1. 错误是什么

Igusa 权 10 尖点形式 Φ₁₀ 在其零点除子上是**二重**零点，不是单零点。

图中三处写成「单零点」：

| 位置 | 原文 | 性质 |
|---|---|---|
| `graph/statements/holography/igusa-cusp-form-phi10.yaml`（`statement` 末句） | 「……的 Sp(4,ℤ)-轨道上，**为单零点**」 | 定义卡 |
| `graph/statements/holography/phi10-wall-crossing-poles.yaml`（`statement` (a)） | 「判别式 4mn−l²=1，**故极点为单零点**」 | 命题卡，`uses` 上一张 |
| `graph/milestones/bh-entropy-cartography.yaml`（`back_translation.text`，第 64 行附近） | 「唯一零点位于超曲面……**为单零点**」 | 🔴 **`approved_on: "2026-09-15"` 的已批准回译** |

## 2. 证据（全部来自本项目**已登记**的一手来源，不依赖任何 agent 的记忆）

1. `literature/sources.bib`，`gritsenko-nikulin-1996` 条目 note：
   > 关键几何结果：`Div(Δ₅)=H₁`（判别式 1 Humbert 曲面，即 `{z₂=0}`）

   Δ₅ 是权 5 带特征尖点形式，`Δ₅² ∝ Φ₁₀`，故 `Div(Φ₁₀) = 2·Div(Δ₅) = 2H₁`——**重数 2**。

2. `literature/sources.bib` 另一条 note（第 5491 行附近）已**直接写明**：
   > ……面 H₁）附近**恰为二重零点**，与 `gritsenko-nikulin-1996` 的 `Div(Φ₁₀)=2H₁`
   > 在局部完全吻合（独立的物理 threshold-integral 推导）

   即：**本项目的文献层早已记录了正确答案，是图层与文献层脱节。**

3. **图的内部自洽性反证**（lead 补充，独立于上述文献）：
   `graph/statements/holography/dvv-wall-crossing-identification.yaml:12` 写
   `Δd = (−1)^{Q·P+1} (Q·P) · d_{1/2}(Q²/2) · d_{1/2}(P²/2)`。
   这个跳变**线性正比于 Q·P**。单极点的留数不会产生这样一个线性因子；
   **恰恰是二重极点**的留数（取一次导数）才给出正比于指数中 v 的系数（即 Q·P）的因子。
   所以图里**下游的物理结论是对的**，错的只是上游那句重数断言——
   两者目前互相矛盾。

## 3. 影响面

- `igusa-cusp-form-phi10` 被 **17 个文件**引用；`phi10-wall-crossing-poles` 被 6 个。
- 但 **下游结论大概率无需改动**：如 §2.3 所述，依赖链末端的物理公式本来就是按二重极点写的。
  错误集中在「为什么」这一句justification，不在结论。
- ⚠ 但 `mock-jacobi-coefficient-positivity` 所属的里程碑回译已把错误表述固化进审计面，
  **必须重新回译并请船长重新批准**——这是本缺陷唯一真正"贵"的部分。

## 4. 另一条**尚有争议**、不一并判错的观察

curator 同时提出：两张卡对零点轨迹的描述 `{mρ+nσ+lv∈ℤ, 4mn−l²=1}` 只覆盖了线性
（BSS 记号下 `n₂=0`）子族，遗漏了 `n₂≠0` 的二次分支
（`n₂(ρσ−v²)+jv+n₁σ−m₁ρ+m₂=0`）。

**lead 认为这条不成立或至少不确定**：两张卡的原文都写的是该超曲面的
**「Sp(4,ℤ)-轨道」**，而 Sp(4,ℤ) 把线性墙映到二次墙，轨道取遍后很可能已覆盖整个除子。
**请 auditor 一并裁决**，但不要把它和 §1 那条确定的错误混为一谈。

## 5. 建议的处置（供 auditor 裁决，非指令）

1. 按原则 1，`igusa-cusp-form-phi10` 与 `phi10-wall-crossing-poles` 各新建 v2 卡，
   订正重数，旧卡标 `superseded_by`；**注意这会产生约 15 条
   「depends on superseded statement」告警**，需一并给出依赖重定向计划。
2. 里程碑 `bh-entropy-cartography` 的回译重写 + 重新请船长批准。
3. 在新卡 `sources` 中补 `gritsenko-nikulin-1996`（`Div(Δ₅)=H₁`）为重数的直接依据——
   现有卡只引了 `gritsenko-nikulin-1998`，而重数那句在 1996 那篇里。

## 6. 教训（与 2026-09-19 的 D=26 事件同类）

图层写下一句"顺带"的技术断言时，没有回到 `literature/` 核对，而文献层其实**早就登记了
正确答案**。与 `research/attempts/s6-injectivity-level-six/status.yaml` 里记录的教训
（"凡涉及某条假设是否被消费，一律以声明签名为准，不看散文"）是同一类失败：
**二手转述与一手记录脱节，且没有任何机制强制它们对帐。**

值得考虑的机制性补救：给 `stringgraph validate` 加一条弱检查——陈述卡里出现
「单零点/二重/重数/multiplicity」等字样时，要求 `sources.loc` 明确指向给出该重数的位置。
（仅为建议，未实施。）

---

## 7. physics-auditor 裁决（2026-09-20）

按流程只做裁决，不重复上面已完成的取证。完整规范表述、v2 文本、依赖重定向逐文件判据，
见 `docs/reviews/phi10-multiplicity-normalization-2026-09-20.md`；里程碑回译订正见
`graph/milestones/bh-entropy-cartography.yaml` 的 `audit.back_translation.diff_notes`
2026-09-20 追加段（该处有更完整的推导过程，本节只记结论）。

### 7.1 §1/§2 确定错误：**wrong，重数应为 2**

独立核实了报告给出的三条证据，全部成立：

1. `gritsenko-nikulin-1996` 的 bib note 确实给出 χ₁₀=Φ₁₀=Δ₅²（p.7 环生成元列表）
   与 Div(Δ₅)=H₁，代数上直接推出 Div(Φ₁₀)=2H₁。
2. `sen-2008-precision-counting` 的 bib note 独立给出 (C.25)/(C.26)
   Φ̂(ρ,σ,v)=−4π²v²g(ρ)g(σ)+O(v⁴)，v=0 附近显式 v² 阶零点，与 1 局部吻合，且明确标注
   "非引用 GN"（独立推导，非循环引用）。
3. **本报告要求我独立核实、且未获文献直接背书的第三条论证（"单极点留数给不出线性
   Q·P 因子"）——核实结论：成立，且可以严格化为标准 Laurent 级数计算**，不依赖任何
   额外物理假设：设 1/Φ₁₀ 在某极点超平面附近局部坐标 w 下写成 1/(w^k·h(Ω))（h 在该
   超平面上非零解析），围道跳变（穿越该极点时的"留数"）本质是 Res_{w=0}[f(w)/w^k]，
   f 为对偶方向的指数核 e^{-2πi(Q·P)w}。k=1 时 Res=f(0)，是与 Q·P 无关的常数；k=2 时
   Res=f'(0)=−2πi(Q·P)·f(0)，恰好线性正比 Q·P。图内 `holography.dvv-wall-crossing-identification`
   的 Δd 公式明确线性正比 Q·P，故只与 k=2（二重极点，对应 Φ₁₀ 二重零点）自洽。
   这条论证本身没有漏洞，是初等复分析，不需要额外文献背书即可成立。

三条证据独立、方法不同、结论一致，无一相反，**裁决：确定错误，重数为 2**。

### 7.2 §4 争议点：**证据不足以判定**（三选一中的第三项）

不裁定"覆盖"也不裁定"不覆盖"。理由见 `phi10-multiplicity-normalization-2026-09-20.md`；
核心是本项目自己已审查通过的 `research/attempts/gap-102b-route-a/` 把 n2≠0 明确列为
未闭合的 `[GAP-n2]`，而不是用"取 Sp(4,ℤ) 轨道"一步带过——若轨道覆盖性对该 attempt
的作者而言是显然的代数事实，没有理由把它留白。GN1996 的 Theorem B.1（bib note 转述）
也只给出零点存在性机制，未见对本原向量轨道传递性的逐字确认。建议：两张 v2 卡维持现有
"Sp(4,ℤ)-轨道"措辞，但在 notes 里明确注明覆盖性是开放问题（见 normalization memo §1.1
的建议 notes 文本），不要因为这条不确定就下调整条陈述的严格度（该措辞本身未被证伪，
只是完整性未经本项目独立核实）。

### 7.3 额外发现（原报告未列出，转交 curator）

`graph/derivations/holography/phi10-wall-crossing-poles--via-siegel-modular-analysis.yaml`
的 `summary` 字段本身也写着"单零点"，且其留数论证语言隐含简单极点逻辑，是**第四处**
错误位置（原报告"三处"清单未列入）。此外，`phi10-wall-crossing-poles` 自身 (b) 的
"Res=f·g"公式字面上也是简单极点写法，与订正后的二阶极点结构不自洽，需要 curator 回
原文核实后再定稿，不能只做文字替换。详见 normalization memo §0.3、§1.2。

### 7.4 处置

- 里程碑 `bh-entropy-cartography` 的回译已订正，`audit.status` 已从 `approved` 降级为
  `back-translated`，需船长重新审阅签字（2026-09-20，physics-auditor 完成）。
- 两张卡的 v2 文本、`sources.loc`、依赖重定向的逐文件判据已写入
  `docs/reviews/phi10-multiplicity-normalization-2026-09-20.md`，供 lead 派 curator 落地。
  curator 落地时**必须一并处理 §7.3 的额外发现**，不能只订正重数这一处。
