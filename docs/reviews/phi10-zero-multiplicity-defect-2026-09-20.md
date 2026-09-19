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
