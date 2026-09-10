# 抽取记录：wen-witten-1985

- 文献：X.-G. Wen and E. Witten, *Electric and magnetic charges in superstring models*, Nucl. Phys. **B261** (1985) 651–677
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**正文一字未获取**。本轮拿到的是：出版方元数据（L2）+ **逐字完整摘要**（L2）
- 目标 area：`swampland`（`arkani-hamed-2006` E19 = 本项目图中**第一条 `status: refuted` 节点**的一手证据来源）

---

## 0. 核实方法与证据等级（必读）

### 0.1 ★★ 结论先说：**本轮最重要的结果是一个否定结论**

**摘要（L2，逐字完整取到）里没有 "winding"、没有 "half-integral"、没有 "heterotic"、没有 "string state" 这些词。**

`arkani-hamed-2006` §3, p.11 逐字（本项目已 L1 核实）：

> "… the spinor of SO(32) is exactly stable and has minimal half-integral charges …, but is heavy and can violate our bounds. **A generalization of these are the half-integrally charged winding strings considered by Wen and Witten [7]** … So (I) can't be right."

**本轮结论**：AMNV 对 Wen–Witten 内容的这句刻画（「半整数荷的缠绕弦」）**在摘要级得不到证实，也得不到证伪**。摘要说的是：**`O(10)` 或 `E₆` 大统一群被 Wilson 线破缺时，最小磁荷不是 Dirac 量子 `2π/e` 而是它的整数倍；相应地非禁闭色单态的最小电荷是电子电荷的 `1/n`。**

这两件事**在物理上相容**（Wilson 线破缺确实会产生分数电荷态，而缠绕态是其自然载体），**但「缠绕弦」「半整数」这两个具体限定词是 AMNV 的刻画，不是本文摘要的措辞。**

⇒ **图里那条 `refutation` 推导的 `summary` 必须逐字用 AMNV 的话，并在 `gaps` 里写明「Wen–Witten 正文未获取；『半整数荷缠绕弦』是 AMNV 的刻画，本项目未在 Wen–Witten 一手材料中证实」。**

### 0.2 证据等级

| 层次 | 拿到了什么 | 等级 |
|---|---|---|
| 书目元数据 | INSPIRE recid **214221**，DOI `10.1016/0550-3213(85)90592-9`，`Nucl.Phys.B` **261**, **651–677**, 1985，报告号 **`Print-85-0468 (PRINCETON)`** | **L2** |
| 摘要 | **逐字完整**（见 E1） | **L2** |
| 正文、公式号、图表 | **一字未获取** | **L0** |

- **L1** = 亲自读到原文页图。**本文件没有任何 L1 条目。**
- **L3**（第三方一手转述）：本轮**没有取到任何可用的 L3**（见 §0.4 的失败记录）。
- **L4** = 检索后端复述，不入库。**本文件无 L4 条目。**

⇒ **图节点的 `loc` 只能写「Nucl. Phys. B261 (1985) 651–677」。**

### 0.3 获取失败路径（逐条留痕）

| 路线 | URL / 手法 | 结果 |
|---|---|---|
| INSPIRE 全文 | `inspirehep.net/api/literature?q=t electric and magnetic charges in superstring models and a wen&fields=...documents,urls` | **`documents` 与 `urls` 两字段皆 absent** ⇒ INSPIRE 无全文 |
| CDS / KEK | 需 `external_system_identifiers` 里的 `CDS` / `KEKSCAN` | **只有 `MSNET 818422` 与 `SPIRES-1357069`** ⇒ **两条路线入口即排除** |
| OSTI | `osti.gov/api/v1/records?q="Electric and magnetic charges in superstring models"` | **10 条命中，全部是 millicharged / fractionally charged particle 的现代实验文献**（LANL、LZ、CMS 等），**无本文**。⚠ 命中主题相关 ⇒ 查询**没有被吞**，是**真的不藏本文**（Princeton 预印本，非 DOE 报告） |
| Semantic Scholar 引用上下文 | `api.semanticscholar.org/graph/v1/paper/DOI:10.1016/0550-3213(85)90592-9/citations?fields=title,year,contexts&limit=60` | **成功返回**，但**引用语境全部落在「分数电荷粒子是弦论的一般预言」这一类泛泛表述上**（LANSCE-mQ、MoEDAL、CMS、free-fermionic 构造等），**没有一条给出 Wen–Witten 的具体机制、公式或「缠绕弦」字样** ⇒ 对本任务无用 |
| INSPIRE 全文检索（找描述本文的论文） | `q=ft "Wen and Witten" and ft "half-integral"` | 5 条：`2001.07731`、**`hep-th/0601001`（= AMNV 本身）**、Anomalies and the SM、`1910.11277`、Three instanton computations。**除 AMNV 外全部是把 "Wen and Witten" 指向 Wang–Wen–Witten 2019「A New SU(2) Anomaly」的误命中**（已逐一核对 `2001.07731`：其唯一 Wen–Witten 引用是 2019 那篇，非 1985） |
| 同上 | `q=ft "Wen and Witten" and ft "winding"` | 4 条：`hep-th/0605256`、**`hep-th/0601001`（= AMNV）**、`1404.5180`、`1404.2601`。**同样没有第二篇描述 1985 那篇内容的文献** |
| WGC 后续文献 | `ar5iv…/html/1509.06374`（Heidenreich–Reece–Rudelius, *Sharpening the WGC…*） | **该文全文里没有 Wen–Witten 1985 的引用**（抽取者核对：只在被截断处之前搜过，但"Wen"一词全篇未出现） |
| 大学课程页扫描件 | — | **本轮无法执行**：会话 `WebSearch` 额度已耗尽（200/200） |
| Elsevier | `sciencedirect.com` | 按既有记录直接判死路，未尝试 |

⇒ **下一轮升级的唯一现实路线：`WebSearch` 找 `.edu` 课程页扫描件。** 检索词建议：`Wen Witten "Electric and magnetic charges in superstring models" pdf`、`"Nucl. Phys. B261" 651 1985 scan`。**`Print-85-0468` 是 SPIRES 占位号，不是真实报告号。**

### 0.4 ★ 一条值得记住的方法论教训

`INSPIRE ft "Wen and Witten"` **几乎全部命中 Wang–Wen–Witten 2019（"A New SU(2) Anomaly"）**，而不是 Wen–Witten 1985。
⇒ **对「姓氏 + 姓氏」型作者检索，必须同时带一个只属于目标篇的判别词**（此处应带 `"B261"` 或 `"Wilson lines"` + `"Dirac quantum"`）。本轮两次 ft 检索都因此浪费。

---

## 1. 约定

**本轮无法确定本文的任何约定**（正文未获取）。

由摘要可知本文用的电荷单位是 **`e`（电子电荷）与 Dirac 量子 `2π/e`**（即 Gauss/Heaviside 型、`ħ = c = 1`、**不带 `1/4π`** 的写法：Dirac 条件写成 `eg = 2πn` 而非 `eg = n/2`）。
⇒ **这与 `arkani-hamed-2006` 的约定（`M_Pl = 1`、`α' = 4`、电荷记为无量纲 `q`）完全不同，且两篇都没给换算。**
⇒ **图里若要把「Wen–Witten 的分数电荷」与 AMNV 的 `q_min` 联系起来，必须标 `inferred: true`。**

与 `graph/conventions/` 的对照：本文陈述与度规号差、`α'` 无关；**但与电荷归一化强相关，而图里目前没有电荷归一化约定卡**。见 §5。

---

## 2. 陈述

编号 `E<n>`。转成节点时在节点 `notes` 写 `from: wen-witten-1985#E<n>`。

### E1 ★★ 摘要（**L2 逐字完整，分段拼接**）

- 位置：**摘要**（INSPIRE recid 214221）— **L2**
- 类型：proposition
- 原文陈述 **[逐字，五段拼接即为完整摘要]**：
  > 1. "We investigate the allowed values of magnetic and electric charge in superstring models in which a"
  > 2. " grand unified O(10) or E 6 gauge group is broken by Wilson lines. In general, the minimum value of"
  > 3. " magnetic charge is not the Dirac quantum 2 π / e but an integer multiple of it. Conversely, the"
  > 4. " quantum of electric charge (for unconfined, color singlet particles) is less than the charge of the"
  > 5. " electron by the same ratio."
  >
  > **拼接结果**：
  > "We investigate the allowed values of magnetic and electric charge in superstring models in which a grand unified O(10) or E 6 gauge group is broken by Wilson lines. In general, the minimum value of magnetic charge is not the Dirac quantum `2π/e` but an integer multiple of it. Conversely, the quantum of electric charge (for unconfined, color singlet particles) is less than the charge of the electron by the same ratio."
- 文献自称的严格程度：**"We investigate"** + **"In general, the minimum value ... is"** —— 陈述式，无 conjecture 措辞。
- 文献列出的依赖：摘要不给。
- 备注（**六点，全部对图有约束**）：
  1. **设定是 `O(10)` 或 `E₆` 被 Wilson 线破缺的超弦模型**——**不是一般的弦论紧化**。⇒ 若图里要用它作 AMNV `(I)` 的反例来源，`statement` 必须带这个限定，否则会把一个特定模型类的结果当成普遍结论。
  2. **"In general" 在原文里修饰的是「最小磁荷不是 Dirac 量子」这一整句**，不是「所有模型都如此」。摘要没有给出「同一个 `n` 对所有模型成立」的断言。
  3. **磁荷与电荷的结论是同一个整数 `n` 的两面**（"by the same ratio"）——这是本文的核心结构。⇒ **图里应建成一条陈述，不是两条。**
  4. ⚠ **摘要里的 "O(10)"**（不是现代常写的 `SO(10)`）与 **"E 6"**（原文排印如此）照抄。
  5. ⚠ **摘要没有说这个整数是 2**（即没有说「半整数电荷」）。AMNV 的 "half-integrally charged" 对应 `n = 2` 的情形。**这是 AMNV 的特化，不是本文摘要的内容。**
  6. ⚠ **摘要没有出现 "winding"、"string state"、"stable"、"BPS"、"mass" 任何一个词。** ⇒ **AMNV 用来反驳 `(I)` 所需的两个关键性质——「精确稳定」与「很重」——在摘要级完全没有依据。**

---

### E2 ★ 由 `arkani-hamed-2006` 逐字记录的、对本文的转述（**AMNV 侧 L1，Wen–Witten 侧 L0**）

- 位置：`arkani-hamed-2006` §3, p.11（v2）— **AMNV 的措辞是 L1**（本项目已逐页核实）
- 转述方原文 **[逐字，节录]**：
  > "there are easy counterexamples to the conjecture (I) in string theory … the spinor of SO(32) is exactly stable and has minimal half-integral charges …, but is heavy and can violate our bounds. **A generalization of these are the half-integrally charged winding strings considered by Wen and Witten [7]** … **So (I) can't be right.**"
  > ⚠ 原文排印错误：`that have fractionally charges`（应为 fractional）。照抄。
- 备注（**这是本文件的关键一条**）：
  1. **AMNV 的反驳有两个例子**：(a) 弱耦合 `SO(32)` 杂化弦的 `SO(32)` 旋量；(b) Wen–Witten 的「半整数荷缠绕弦」。**AMNV 明说 (b) 是 (a) 的推广。**
  2. **(a) 不需要 Wen–Witten**：`SO(32)` 旋量的存在性、稳定性与最小半整数荷，AMNV 直接断言，不引本文。
  3. ⇒ ★ **图里那条 `kind: refutation` 的推导，即使 Wen–Witten 永远取不到，也仍然成立**——因为 (a) 独立于本文。**本文只是让反例的覆盖面更宽。**
  4. **`SO(32)` 与 `O(10)`/`E₆` 是不同的设定**：AMNV 的 (a) 在 10 维 `SO(32)` 杂化弦里，本文的设定是 `O(10)`/`E₆` GUT 被 Wilson 线破缺（即 4 维紧化后的可见规范群）。**两者不是同一件事，AMNV 说 (b) 是 (a) 的"推广"这一点本项目未核实。**

---

### E3 参考文献与引用网络（**L2/L3，记录性**）

- 事实（本轮取得）：
  - INSPIRE 记录本文**被引 405 次**。
  - Semantic Scholar 的引用语境显示：现代引用它的主流是**分数电荷粒子的唯象与实验搜寻文献**（LANSCE-mQ、MoEDAL-MAPP、LZ、CMS 分数电荷搜寻、millicharged dark sector），典型措辞如「Fractionally charged particles are also well motivated in superstring models [4, 45]」「fractionally charged particles are a generic prediction of string compactification」。
  - **弦论侧的高被引邻居**（INSPIRE `refersto` 前列）：`Strings on Orbifolds. 2.`（DHVW）、`Four-Dimensional Superstrings`、`Chiral Four-Dimensional Heterotic Strings from Selfdual Lattices`、`Construction of Fermionic String Models in Four-Dimensions`、以及 **`hep-th/0601001`（= AMNV）** 与 **`1509.06374`（Heidenreich–Reece–Rudelius, Sharpening the WGC）**。
- 备注：
  1. **`1509.06374` 出现在 `refersto` 列表里，但抽取者在其 ar5iv 全文中搜不到 "Wen"** ⇒ 二者有一个是错的（INSPIRE 的引用抽取，或 ar5iv 的截断）。**本轮未裁决，标 L0。** 若要找「WGC 文献如何转述 Wen–Witten」，这是下一轮最该核的一条。
  2. **现代实验文献的引用一律是泛泛的「弦论预言分数电荷」，不含机制细节** ⇒ **它们不能作为本文内容的 L3 来源。**

---

## 3. 未核实项清单

| 编号 | 项 | 影响 | 处理建议 |
|---|---|---|---|
| U1 | **正文全部** | `loc` 只能到篇级 | `.edu` 课程页扫描件（需 `WebSearch`） |
| U2 | **「半整数荷缠绕弦」是否真在本文里** | 决定 AMNV 反例 (b) 的一手性 | 同上。**在取到之前，图里只能引 AMNV 的转述** |
| U3 | **那些态是否「精确稳定」且「很重」** | 这是 AMNV 反驳 `(I)` 所需的性质 | 摘要完全不涉及；只能靠原文 |
| U4 | **整数比 `n` 的取值范围与它由什么决定** | 「半整数」= `n = 2` 是特例还是典型？ | 只能靠原文 |
| U5 | **终页 `677`** | bib 完整性 | **本轮已由 INSPIRE `publication_info` 核实：`page_start: 651`, `page_end: 677`（L2）** ⇒ **U5 关闭** |
| U6 | **`1509.06374` 是否真的引本文** | 影响「WGC 文献如何看待这个反例」 | INSPIRE 说引，ar5iv 全文搜不到，矛盾未裁决（E3 备注 1） |

---

## 4. 未解决的疑问

### Q1 — ★ 这条 `refuted` 节点的证据强度到底有多少？

拆开看：

| 环节 | 证据 | 等级 |
|---|---|---|
| AMNV 说了 "So (I) can't be right." | 本项目逐页读到 | **L1** |
| 反例 (a)：`SO(32)` 旋量精确稳定、最小半整数荷、很重 | AMNV 断言，**不引任何文献** | **L1（AMNV 的断言）+ L0（其依据）** |
| 反例 (b)：Wen–Witten 的半整数荷缠绕弦 | AMNV 转述 | **L1（AMNV 的措辞）+ L0（Wen–Witten 的内容）** |
| 「重到足以违反界」的定量估计 | **AMNV 与本文都没给** | **L0** |

⇒ **`swampland.wgc-sharp-minimal-charge` 打成 `status: refuted` 是站得住的**（作者本人对自己的精确陈述宣布反驳，这是最高级别的自证），
**但那条 `kind: refutation` 推导的 `status` 只能是 `physical-argument`，且 `gaps` 必须写满上面四行。**

### Q2 — 反例 (a) 的依据在哪里？（比 Wen–Witten 更该追的一条）

AMNV 对 `SO(32)` 旋量的三个性质（**存在**、**精确稳定**、**最小半整数荷**）**一个引用都不给**。这三条里：
- 「`SO(32)` 杂化弦谱中有旋量表示的态」——是标准结果，可由 `polchinski-1998-v2` §11 或 `gsw-1987-v1` 覆盖（本项目已有 Vol.2 §11 的 L1 抽取）；
- 「**精确稳定**」——需要一个电荷守恒/最轻带荷态论证，**AMNV 没给**；
- 「**很重**」——需要质量估计，**AMNV 没给**。

⇒ **下一轮最省力的补强不是找 Wen–Witten，而是从 `polchinski-1998-v2` §11（杂化弦谱）里把 `SO(32)` 旋量态的质量与荷补出来。** 该章本项目已 L1 读过。

### Q3 — 「半整数」在两篇里指的是同一件事吗？

- AMNV：「minimal **half-integral** charges」——相对于 `SO(32)` 的荷格，旋量表示的权是半整数。
- Wen–Witten（摘要）：「the quantum of electric charge ... is **less than the charge of the electron** by the same ratio」——相对于**电子电荷**的分数。

**这两个「分数」的参照系完全不同**（一个是规范群的权格，一个是可见的 `U(1)_EM`）。**AMNV 说 (b) 是 (a) 的"推广"，但这一步的合法性本项目无法核实。**

⇒ 图节点若同时引两者，**必须在 `notes` 里写明两种「分数电荷」的参照系不同**。

---

## 5. 给图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`，下列节点由 curator 落地。

### 5.1 ★ 最重要的一条：**这条 `refutation` 不要 `depends_on` 本文**

`arkani-hamed-2006.md` §5.2 (d) 原来建议：

```
swampland.wgc-sharp-minimal-charge (I)        status: refuted
  --via-so32-spinor-counterexample   kind: refutation   status: physical-argument
      depends_on: 〈Wen–Witten NPB 261, 651 (1985)〉  ← 建议登记并抽取
```

**本轮建议修正为：把 Wen–Witten 从 `depends_on` 移到 `notes`/`gaps`。** 理由（E2 备注 3）：

- AMNV 的反例 **(a)（`SO(32)` 旋量）不引任何文献，独立于本文**；
- 本文**正文取不到**，`depends_on` 一个内容全 L0 的节点，会让 `validate` 里出现一条无法核实的边（违反 `CLAUDE.md` 原则 5）；
- 若坚持建边，**必须 `inferred: true` + note 写明「本文正文未获取，依赖关系仅由 AMNV 的转述建立」**。

建议的最终布局：

```
swampland.wgc-sharp-minimal-charge (I)        status: refuted
  --via-so32-spinor-counterexample   kind: refutation   status: physical-argument
      depends_on: 〈SO(32) 杂化弦谱〉  ← polchinski-1998-v2 §11（本项目已 L1）
      sources: arkani-hamed-2006, loc "§3, p.11（v2，逐字 'So (I) can't be right.'）"
      summary: 弱耦合 SO(32) 杂化弦的 SO(32) 旋量精确稳定、最小半整数荷、但很重
      notes: AMNV 另举 Wen–Witten NPB 261, 651 (1985) 的「半整数荷缠绕弦」作为
             同型反例的推广；本项目已登记该文献但正文未获取（见 wen-witten-1985.md §0.1），
             故不建依赖边。
      gaps: ["「SO(32) 旋量精确稳定」AMNV 无引用无论证（Q2）",
             "「重到足以违反界」的定量估计原文未给出（Q1）",
             "Wen–Witten 正文未获取；「半整数荷缠绕弦」是 AMNV 的刻画，
              本项目未在 Wen–Witten 一手材料中证实（§0.1）",
             "两处「分数电荷」的参照系不同（Q3）"]
```

### 5.2 本文自己可以建的节点（**摘要级，独立于 WGC**）

| 建议 id | kind | status | 内容 | loc | 抽取条目 |
|---|---|---|---|---|---|
| `compactification.wilson-line-charge-quantization` | proposition | `physical-argument` | `O(10)`/`E₆` 被 Wilson 线破缺的超弦模型中，最小磁荷是 Dirac 量子 `2π/e` 的整数倍 `n`，对应非禁闭色单态的最小电荷是电子电荷的 `1/n` | `Nucl. Phys. B261 (1985) 651–677`（**篇级，摘要来源**） | **E1** |

⚠ 该节点 `notes` 必须写死：「**摘要级（L2）；正文未获取。设定限于 `O(10)`/`E₆` + Wilson 线破缺。摘要没有 winding / half-integral / stable / mass 任何一词。**」

### 5.3 **不得**挂到 `wen-witten-1985` 的东西（红线清单）

| 内容 | 为什么不行 | 正确处理 |
|---|---|---|
| 任何公式号、节号、图号 | **正文一字未获取** | `loc` 只写篇级 |
| 「半整数荷」（`n = 2`） | 摘要只说「整数倍 `n`」，不说 `n = 2` | 引 AMNV 的措辞，标明是 AMNV 的特化 |
| 「缠绕弦」 | **摘要无 "winding" 一词** | 同上 |
| 「精确稳定」「很重」 | **摘要完全不涉及**；这两条是 AMNV 反驳 `(I)` 的必要条件 | 只能引 AMNV，且进 `gaps` |
| `SO(32)` 旋量的性质 | **本文设定是 `O(10)`/`E₆`，不是 `SO(32)`** | 来源应是 `polchinski-1998-v2` §11 + AMNV 的断言 |
| 「弦论一般预言分数电荷」 | 本文限定于 Wilson 线破缺的 GUT 模型；泛化是后世文献做的 | 若要建这条，须另找来源 |
| 任何与 `M_Pl`/`q` 的换算 | 本文用 `e` 与 `2π/e`，AMNV 用无量纲 `q`；**两篇都没给换算** | `inferred: true` |

### 5.4 建议同时更新的既有文件

- `literature/sources.bib`：`wen-witten-1985` 的 `note` **补写**：终页 677 已 L2 核实；摘要已逐字取得且**不含 winding/half-integral**；无 CDS/KEKSCAN/OSTI 入口；`Print-85-0468` 是 SPIRES 占位号。**本轮已改。**
- `literature/reading-list.md`：状态改为 **`attempted, L2（摘要级；正文未获取）`**，并写明「优先级可下调：AMNV 的反例 (a) 独立于本文，`refuted` 节点不靠它」。**本轮已改。**
- **建议新增 reading-list 条目**：**从 `polchinski-1998-v2` §11 补 `SO(32)` 杂化弦旋量态的质量与荷**（Q2）——**这比找 Wen–Witten 更省力且更直接支撑那条 `refutation`**。**本轮已加。**

---
