# 抽取记录：brower-friedman-1973

- 文献：R. C. Brower and K. A. Friedman, "Spectrum-Generating Algebra and No-Ghost Theorem for the Neveu-Schwarz Model", Phys. Rev. D **7** (1973) 535–539
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**摘要（L1 逐字）+ 元数据（L1）+ 四条外部转述（L3）。正文未获取（L0）。**

> **本轮任务的唯一目的**：裁决 `figueroa-ofarrill-kimura-1989.md` §3 第 1 条 / §4 Q1 与
> `lian-zuckerman-1989.md` Q1 之间的真矛盾 —— NSR Fock 空间作为 super-Virasoro 模是否
> 「fully reducible / Verma 模无穷直和」。
> **结论见 §3。简短版：矛盾没有被"消解"，但天平移动了 —— 「Verma 模直和」这个说法在本文的标题与摘要里都不存在，
> 而且它在全部文献中只有一个出处（Figueroa-O'Farrill 本人），不是两条独立证言。**

---

## 0. 获取途径与证据等级

### 0.1 证据等级约定

| 标记 | 含义 |
|---|---|
| `[L1]` | 一手正文（或出版方逐字元数据）核实 |
| `[L2]` | 摘要 / 元数据级 |
| `[L3]` | 他人论文里对本文的逐字转述 |
| `[L0]` | 未核实 |

### 0.2 本轮结果：**正文 L0；摘要 L1 逐字；元数据 L1**

**正文没有取到。** 按 `docs/` 的取证纪律，本文件的 `read_depth` 保持 `abstract`，不得升。

### 0.3 已尝试入口逐条留痕（下一个人不必重试）

| # | 入口 | 结果 |
|---|---|---|
| 1 | Crossref `api.crossref.org/works/10.1103/PhysRevD.7.535` | ✅ **成功**：完整书目（见 §1） |
| 2 | INSPIRE `api/literature?q=j Phys.Rev.D,7,535&fields=abstracts` | ✅ **成功**：出版方逐字摘要（见 §2） |
| 3 | INSPIRE `fields=external_system_identifiers,report_numbers,documents,urls` | ⚠ **`report_numbers` / `documents` / `urls` 三字段全部 ABSENT**；`external_system_identifiers` 只有 `OSTI 4607142`、`ADS 1973PhRvD...7..535B`、`SPIRES-1499769`。**无 CDS、无 KEKSCAN** ⇒ CDS-OAI 路线与 KEK 路线**在入口处即被排除**，不是"试过失败" |
| 4 | OSTI `www.osti.gov/servlets/purl/4607142` | ❌ **HTTP 404**（再次确认：期刊文章的 OSTI id 是引文级，purl 只对 DOE *报告* 有效） |
| 5 | Semantic Scholar `graph/v1/paper/DOI:10.1103/PhysRevD.7.535?fields=openAccessPdf` | ❌ `isOpenAccess: false`，`openAccessPdf.url` 空、`status: "CLOSED"`。**S2 这次是诚实的**（对比 Graham–Lee 那次的假 BRONZE） |
| 6 | WebSearch（找 `.edu` 课程页扫描件 / 重印本） | ❌ **未执行 —— 本会话 WebSearch 额度在本任务开始前已被耗尽（200/200）**。这是**唯一一条还没试过的路线**，下一轮应优先 |
| 7 | `journals.aps.org` | ❌ 未花预算（已知全域 403） |
| 8 | archive.org 上 Schwarz 编 *Superstrings: The First 15 Years*（该文集**收录本文**） | ❌ 未执行；**但既有记录显示该书不在 archive.org（此前 5 次检索全 0 命中）** |

**⇒ 剩余唯一现实路线：WebSearch 找 `.edu` 课程页扫描件，或人工从 APS 下载。**

---

## 1. 元数据（L1，Crossref `10.1103/PhysRevD.7.535`）

| 字段 | 值 |
|---|---|
| 作者 | Richard C. Brower; Kenneth A. Friedman |
| 标题 | "Spectrum-Generating Algebra and No-Ghost Theorem for the Neveu-Schwarz Model" |
| 期刊 | Physical Review D |
| 卷 / 期 | **7 / 2** |
| 页 | **535–539**（**共 5 页**） |
| 年 | 1973（线上 1973-01-15） |
| DOI | `10.1103/PhysRevD.7.535` |
| 出版方 | American Physical Society |

**独立佐证（L3，两条）**：
- **Schwarz, *String theory origins of supersymmetry*, hep-th/0011078, 参考文献 [59]** 逐字：
  「R. C. Brower and K. A. Friedman, "Spectrum Generating Algebra and No Ghost Theorem for the Neveu-Schwarz Model," Phys. Rev. **D7**, 535 (1973).」— 卷、页、标题全对。
- ⚠ **反例：Hasiewicz–Jaskólski–Ostrowski, hep-th/9901116, 参考文献 [29]** 逐字：
  「R.Brower and K.Friedman, Phys. Rev. **D3** (1973) 535」— **卷号印错（D3 应为 D7）**。
  ⇒ **这条引文在文献里会被抄错卷号，`sources.bib` 的 note 要点名。**

---

## 2. 摘要（L1 逐字，INSPIRE 出版方摘要）

> "The no-ghost theorem of Brower for the conventional dual model (intercept `α₀=1`) is extended to the Neveu-Schwarz model, and its spectrum-generating algebra is constructed. These conformally invariant generators (`A_n`, `B_s`) are obtained by a systematic use of the gauges `G_r`. As a consequence it is demonstrated that particular dual models having resonances with positive-definite norms and masses are possible."

**摘要层面可以直接读出的四条（全部 L1）**：

1. **本文是 Brower 1972（PRD 6, 1655，`brower-1972`）的推广**，推广方向是**从常规对偶模型到 Neveu–Schwarz 模型**，且**明确保留 `α₀ = 1` 这个截距限定作为被推广的对象的性质**。
2. **本文的两件事**：(i) 把无鬼定理推到 NS 模型；(ii) 构造谱生成代数，生成元记作 **`A_n` 与 `B_s`**（`B_s` 即费米型、半整数模）。
3. **方法**：「by a systematic use of the gauges `G_r`」—— 即用超 Virasoro 的 `G_r` 生成元。
4. ★★ **摘要里没有 "reducible"、没有 "Verma"、没有 "direct sum"、没有 "Fock space"、没有 "representation"。**
   摘要对结果的最强措辞是 **"it is demonstrated that particular dual models having resonances with positive-definite norms and masses are possible"**。

**★ 还有一条同等重要的否定信息**：**标题与摘要里完全没有 Ramond（"dual pion model" 的 R 扇区）。**
标题限定 "for the **Neveu-Schwarz** Model"，摘要从头到尾只讲 NS。

---

## 3. ★★ 对 FOK vs LZ 矛盾的裁决

### 3.1 矛盾的两方（复述，均已 L1 核实于各自记录）

| 方 | 位置 | 逐字 |
|---|---|---|
| **FOK 1989（NS 扇区）** | p.111 | 「**It was proven** by Brower and Friedman [11] that this representation is fully reducible … infinite direct sum of Verma modules」 |
| **FOK 1989（R 扇区）** | p.115 | 「Brower and Friedman **claim** to have proven full reducibility of this representation, although **they do not write down the explicit spectrum generating algebra**」 |
| **LZ 1989** | p.320 Remark | 「`V(p,κ)` is **in general not a direct sum of Verma modules** of `Vir_κ` even though it is `Vir_κ^-`-free.」（反例在 NS 扇区，用 Kac 行列式） |

**结构性事实**：FOK **需要**这条完全可约性（逐 Verma 模算上同调）；LZ **不需要**（只用 `Vir_κ^-`-free，即其 `Corollary 2.19(iii)`）。

### 3.2 本轮的四条新证据

**(a) `[L1]` 本文摘要不含任何可约性/Verma 主张。** 见 §2 第 4 点。
本文自称的成果是「无鬼定理 + 谱生成代数 + 正定范数共振态存在」，**不是**「Fock 空间分解为 Verma 模直和」。

**(b) `[L1]` 本文的标题与摘要都是 NS-only，没有 Ramond。**
⇒ **FOK p.115 把一条关于 R 扇区表示的完全可约性归给本文，在本文的标题/摘要里找不到任何支撑。**
FOK 自己那句括注「they do not write down the explicit spectrum generating algebra」恰恰与「本文是一篇 NS 论文」相容 ——
**最简单的解释是：本文根本没有处理 R 扇区**，所以既没有 R 的 SGA、也不会有 R 的可约性证明。
（⚠ 这一步是抽取者的推断，不是原文陈述；但它是现有证据下唯一自洽的读法。）

**(c) `[L3]` 「Verma 模直和」这个说法在全部文献里只有一个出处，而且不是独立的两条。**
Semantic Scholar 引文上下文检索（`DOI:10.1103/PhysRevD.7.535/citations?fields=contexts`，35 篇引用方）里，
**只有一篇**出现 "reducibility"/"Verma"：
> **"BRST Cohomology and its Applications to Two-Dimensional Conformal Field Theory" (1989)** —— 两条上下文逐字：
> 「In [109] Brower and Friedman **claim to have proven full reducibility** of this representation…」
> 「**It was proven by Brower and Friedman[109] that this representation is fully reducible into Verma modules.**」
**这两句与 FOK 1989 p.115 / p.111 逐字相同，作者是同一人（Figueroa-O'Farrill 的 1989 年博士论文/综述）。**
⇒ **FOK 1989 与这一篇不是两条独立证言，是同一条。** 在整个引用网络里，**没有第二个人**说过 Brower–Friedman 证明了 Verma 模可约性。

**(d) `[L3]` 两条独立的、非 FOK 系的引用方，对本文的归属都只到"DDF/SGA 构造 + 无鬼定理"，不到可约性。**
- **Hasiewicz–Jaskólski–Ostrowski, hep-th/9901116**（该文自己大量使用 super-Virasoro **Verma 模**，所以它是最可能提到可约性的场合）逐字：
  「The DDF construction [27] for the Neveu-Schwarz model was developed long time ago by Schwarz [28], **and by Brower and Friedman [29]**.」
  —— **它把 Verma 模的度规结构外包给 [30,31,32]（Meurman–Rocha 一系），不外包给 Brower–Friedman。**
- **Schwarz, hep-th/0011078**（作者本人是 NS 模型的共同发现者）逐字：
  「The no-ghost theorem for the dual pion model was also established using Brower's methods」+「**as well as by Brower and Friedman**」（引 [58] = Schwarz NPB 46, 61 (1972)、[59] = 本文）。
  —— 归属同样只到**无鬼定理 + Brower 方法**。

### 3.3 裁决

**不能宣布矛盾已解决（正文未读）。但可以给出三条可写进图的结论：**

1. **★ 「Brower–Friedman 证明了 Fock 空间是 Verma 模无穷直和」这条主张，在本项目现有全部证据下，只有 Figueroa-O'Farrill 一个来源，且本文自身的摘要不支持它。**
   ⇒ 图里**不得**把 `brower-friedman-1973` 作为「完全可约性/Verma 模直和」的 `source`。若 FOK 的推导需要它，应建成一个**独立的 gap 节点**，来源写 `figueroa-ofarrill-kimura-1989`（"FOK 如此归属"），`inferred: true`。

2. **★ 至少在 R 扇区，FOK 的归属大概率是误归。** 依据：本文标题+摘要 NS-only（§3.2 (b)），且 FOK 自己降级为 "claim"。
   ⇒ `figueroa-ofarrill-kimura-1989` 的 R 扇区推导，其 `gaps` 里那一条应当**加强措辞**：不是"作者自承是 claim"，而是"被归属的文献看起来根本不覆盖 R 扇区"。

3. **★ LZ 的 Remark 与 FOK 的用法之间还有一个尚未排除的调和可能（抽取者假设，非原文）。**
   LZ 的措辞是 **"in general** not a direct sum"。若 FOK 实际使用的是**一般动量 `p`**（Kac 行列式不为零的情形），则两者可以并存：
   - 一般 `p`：Verma 模不可约 ⇒ `Vir⁻`-free + 最高权向量生成 ⇒ 确实是 Verma 模直和；
   - 特殊 `p`（Kac 行列式为零）：LZ 的反例。
   **但 FOK 全文只声明 `p ≠ 0`（脚注 3/6/9），没有声明 `p` 一般性。**
   ⇒ **这是一条可检验的裁决路径，但需要读 LZ p.320 Remark 的反例究竟取在哪个 `p`。** 本轮未做。
   ⚠ **在验证之前，不要把这条调和写进图节点。**

---

## 4. 未解决的疑问

- **Q1**：本文正文（5 页）里究竟有没有一条关于 Fock 空间分解的陈述？形式是什么？**唯一入口是 WebSearch 找扫描件或人工下载 APS。**
- **Q2**：本文的 `A_n`、`B_s` 与 `figueroa-ofarrill-kimura-1989` / `lian-zuckerman-1989` 里的 SGA 记号如何对应？（摘要给了记号，没给对易关系。）
- **Q3**：LZ p.320 Remark 的 Kac 行列式反例取在哪个动量 `p`？—— 这是 §3.3 第 3 条的裁决前提，**本轮未读**（需回 `lian-zuckerman-1989` 的 PDF p.320，Project Euclid `cmp%2F1104179468`）。
- **Q4**：Schwarz NPB **46** (1972) 61（"Physical States and Pomeron Poles in the Dual Pion Model"）是与本文并列的第二条 NS 无鬼定理来源（Schwarz 自述，L3）。**本项目尚未登记。** 若要给 `no-ghost-theorem-superstring` 的 NS 分支找第二条独立物理来源，这是最直接的候选。
- **Q5**：本文第二作者 **Kenneth A. Friedman** 在本项目其它文献里从未出现；`brower-1972`（单作者）与本文是**不同论文**，`sources.bib` 已有的 `brower-1972` note 要与本条互指。

---

## 5. 对图的建议

> researcher 只写 `literature/`，下列由 curator 落地。

1. **`brower-friedman-1973` 可以作为 `no-ghost-theorem-superstring`（NS 扇区）的一条 `physical-argument` 级来源**，loc 只能写 `abstract`（正文 L0）。
   statement 用摘要措辞：「Brower 的（`α₀=1` 常规对偶模型）无鬼定理被推广到 Neveu–Schwarz 模型，并构造了谱生成代数 `(A_n, B_s)`」。
   ⚠ **不得**写成「证明了完全可约性」。
2. **新建一个 gap / 争议节点**：`nsr-fock-space-verma-decomposition`，
   - statement：「NSR 物质 Fock 空间作为 super-Virasoro 模是否分解为 Verma 模直和」
   - `status`：**`conjecture`（甚至 `disputed`，若工具支持）**
   - sources：`figueroa-ofarrill-kimura-1989`（p.111 / p.115，主张成立）与 `lian-zuckerman-1989`（p.320 Remark，主张一般不成立）**并列**
   - notes：抄 §3.2 的四条证据 + §3.3 第 3 条的调和假设（标 `inferred`）
   - ⇒ **`figueroa-ofarrill-kimura-1989` 的 NS 无鬼定理推导应 `depends_on` 这个节点**，这样它的 effective status 会被如实压低；`lian-zuckerman-1989` 的推导**不**依赖它（这正是「两条独立 derivation 其实强度不同」的一个真实例子，是本项目方法论想展示的场景）。
3. **`sources.bib` 里 `brower-1972` 与 `figueroa-ofarrill-kimura-1989` 两条 note 各加一句互指**（易混：`brower-1972` = PRD 6, 1655 单作者 dual model；本条 = PRD 7, 535 双作者 NS）。

---

## 6. §6 LZ Remark 复核（researcher，2026-09-11；结算 §4 的 Q3）

> 目标（任务书）：**LZ 1989 CMP 125 p.320 Remark 的反例取在哪个动量 `p`、是否 `p ≠ 0`、用哪层 Kac 行列式。**
> 取件：Project Euclid `https://projecteuclid.org/journalArticle/Download?urlId=cmp%2F1104179468`
> → 落盘 2.5 MB 扫描件 → `Read(pages=19-21)` 与 `Read(pages=35)`。**PDF 页 = 期刊页 − 300。**
> 本节**只加不改** §1–§5 的旧行。

### 6.1 ★★ p.320 Remark 全文逐字（L1 页图）

> **"*Remark.* `V(p,κ)` is in general not a direct sum of Verma modules of `Vir_κ` even though it is `Vir_κ^−`-free.
> **This was also pointed out in [5] in the bosonic case.** To see a counter-example, we consider the Neveu–Schwarz case.
> Suppose `V = V(p,½)` is a direct sum of Verma modules. Then computing `ch_q` gives**
>
> `V ≅ ⊕_n a_n M( p·p/2 + n , 10 )`   **(35)**
>
> **for some positive integers `a_n`, `n` ranges over `0, ½, 1, …`. We wish to derive a contradiction.
> Recall that `V` is hermitian. Thus**
>
> `⊕ a_n M(p·p/2 + n, 10) ≅ ⊕ a_n M(p·p/2 + n, 10)*`   **(36)**
>
> **By Kac's determinant formula, `M(h,10)` is irreducible for `h > 0` and hence hermitian. Thus**
>
> `⊕_{0 ≤ n ≤ |p·p/2|} a_n M(p·p/2 + n, 10) ≅ ⊕_{0 ≤ n ≤ |p·p/2|} a_n M(p·p/2 + n, 10)*`   **(37)**
>
> **Since Verma modules are strongly indecomposable, (37) implies that (see [20], Sect. 3.4)**
>
> `M(p·p/2 + n, 10) ≅ M(p·p/2 + n, 10)*`  for `n ≤ |p·p/2|` .   **(38)**
>
> **But by Kac's determinant formula, there are some negative half integers `h` such that `M(h,10)` is reducible.
> If `p·p/2 + n` is one such number, (38) contradicts reducibility.**"

（紧接其后即是 **Corollary 2.19**，其 (iii) 的证明在 p.321 逐字：
「Equations (24), (25) imply that `V(p,κ)` is a direct sum of tensor products of free modules over `Vir_κ^−`.
One can easily check that each of the tensor products is also `Vir_κ^−`-free.」）

### 6.2 ★★★ 对任务书三问的逐条回答

**(1) 反例取在哪个动量 `p`？——原文不给任何具体的 `p`，给的是一个"存在性"条件。**
反例的成立条件是：**`p·p/2 + n` 恰好落在"使 `M(h,10)` 可约的某个负半整数 `h`"上**（原文措辞是 **"If … is one such number"**）。
⇒ **这是一族条件，不是一个点。** 由于 `n ∈ ½Z_{≥0}` 且要求 `h = p·p/2 + n < 0`，
**必须 `p·p < 0`**（LZ 的号差是 `((D−1)+, 1−)`，见 §2 的抽取记录 §1，故 `p·p < 0` = 类时）。
⚠ **"取在哪个 `p`"这个问法本身预设了一个具体反例点，而原文没有给。** 引用时不得写成"LZ 在 `p = …` 处给出反例"。

**(2) 是否 `p ≠ 0`？——是，而且比 `p ≠ 0` 强得多。**
- `p ≠ 0`：p.303 全局假设，逐字「`p` will always be assumed non-zero until Sect. 5」（已在 `lian-zuckerman-1989.md` §1 记录）；
  p.305 Remark 另有「we will assume that `p` is always in the future half `R^{D−1,1}_+`」。**p.320 落在 §2，故两条都生效。**
- **但反例还额外要求 `p·p < 0`**（见上）。**`p·p = 0`（类光）时 (37) 的求和范围 `0 ≤ n ≤ |p·p/2|` 退化为 `n = 0`，
  `h = 0`，"负半整数"条件不满足，反例不成立**（这一句是抽取者的推断，不是原文）。

**(3) 用哪层 Kac 行列式？——原文不指定层，且用的是 *超* Virasoro 的 Kac 行列式（`c = 10`），不是 Virasoro 的。**
- 原文两次用到 Kac 行列式公式，**两次都只用它的定性推论、不写 `(r,s)` 或层数 `N`**：
  (i) 「`M(h,10)` is irreducible for `h > 0`」；
  (ii) 「there are some negative half integers `h` such that `M(h,10)` is reducible」。
- `M(h, 10)` 是 **`Vir_κ`（κ = ½，即 NS 超 Virasoro）** 的 Verma 模，中心荷 `10`
  （LZ 的归一化是 `c/8`，故 `D = 10` ⇒ `c = 10`，见 `lian-zuckerman-1989.md` §1）。
  LZ 全文的超 Virasoro Kac 行列式出处是 **[22] = Meurman, A., Rocha, A.: Commun. Math. Phys. 107, 263–294 (1986)**
  （L1，见 6.4 的参考文献表）。
- ⇒ **图里/报告里不得写「用第 N 层 Kac 行列式」。可写的最强形式是「由（超 Virasoro，`c=10`）Kac 行列式公式，
  存在负半整数 `h` 使 `M(h,10)` 可约」。**

### 6.3 ★★ 对 §3.3 第 3 条「调和假设」的裁决：**部分支持，但被一个新事实推翻**

§3.3(3) 的假设是：「若 FOK 实际只用**一般动量 `p`**（Kac 行列式不为零），则 FOK 与 LZ 可并存。」

- **支持的一半（来自本轮逐字）**：LZ 的反例确实**不是对所有 `p` 成立**——它需要 `p·p/2 + n` 命中一个特定的
  负半整数集合。对"一般"的 `p`（`p·p/2` 不是半整数）该论证**产生不出矛盾**。
  ⇒ **"in general not" 的确切含义因此被钉死了：不是"对所有 p 都不是"，而是"存在 p 使之不是"。**
- **★ 推翻它的新事实（⚠ 以下是抽取者的推断，不是任何来源的原文）**：
  LZ 的物理态定义 `P(p,κ)` 要求 `π(L₀)v = κ v`（Definition 2.16）。在第 `N` 层上 `L₀` 本征值是 `p·p/2 + N`，
  故**能承载物理态的动量必然满足 `p·p/2 = κ − N`，即 `p·p/2` 必是半整数**，且 `N ≥ 1` 时为负。
  ⇒ **"一般 `p`"恰恰是没有物理态的那些 `p`；无鬼定理真正关心的 `p` 全部落在 LZ 反例的危险区。**
  ⇒ **§3.3(3) 的调和不能救 FOK 的 NS 推导。** 仍**不要**把这条写进图节点（它是推断），
  但它足以支持 §3.3 第 1 条的禁令：**图里不得把 `brower-friedman-1973` 当作"完全可约性"的 source。**

### 6.4 ★★ 本轮顺带取得的三条硬事实（L1，p.335 参考文献表与结论页）

1. **LZ 的 `[5]` = Frenkel, I., Garland, H., Zuckerman, G. J.: Proc. Natl. Acad. Sci. USA **83**, 8442 (1986) = 本项目的 `fgz-1986`。**
   ⇒ **Remark 那句「This was also pointed out in [5] in the bosonic case」的意思是：
   FGZ 本人早已指出玻色弦的 Fock 空间"一般也不是 Verma 模直和"。**
   ⇒ **FOK 若想用"玻色情形的类比"来支撑 NS 的完全可约性，这条路也被 FGZ 自己堵死了。**
   ⚠ 本项目 `brst-cohomology-sources.md` §1 对 FGZ 的抽取**未记录过这一条**，值得回头补核（Q6.2）。
2. **LZ 的 `[1]` = Brower, R. C., Friedman, K. A.: Phys. Rev. **D7**, 535–539 (1973)** —— 卷、页、年**与本项目的 Crossref 元数据逐字一致**
   （再次印证 §1 的判断：hep-th/9901116 的 "D3" 是抄错）。
   **LZ 引用它的唯一场合是 Proposition 2.18 的证明**，措辞是「physicists **[1, 2]** have constructed these spaces」
   （`[2]` = Corrigan, E. F., Goddard, P.: Nucl. Phys. **B68**, 189–202 (1974)），
   **紧接着一句是「However, we will prove their existence the way FGZ did in the bosonic case.」**
   ⇒ **LZ 把 BF 的功劳定位为"构造了横向空间 `T(p,κ)`"，与 §3.2(d) 的两条独立证言完全一致，
   同样不归给它任何"完全可约性"。**
3. **⚠ 订正一条既有记录**：`lian-zuckerman-1989.md` 与 `reading-list.md` 都写「LZ 1989 与 FOK 1989 **互不引用**」——
   **参考文献表里确实没有 FOK，但 p.335 结论节之后有一条 "Note added in proof"（L1 逐字）**：
   > 「After the completion of this work, we received preprints from **J. Figueroa-O'Farrill and T. Kimura**,
   > whose work appears to be similar to ours.」
   ⇒ **"互不引用"应收窄为"LZ 不在参考文献里列 FOK，但在校样附注里点名承认收到其预印本"。**
   **LZ 自己对两者关系的措辞只到 "appears to be similar to ours"，既不确认一致、也不点出矛盾。**
   （另：p.335 的 `Received February 21, 1989`，`Communicated by A. Jaffe`。）

### 6.5 两条引用纪律（给 curator）

- **`[20], Sect. 3.4` 不是关于 Verma 模的文献**：`[20] = Jacobson, N.: *Basic algebra*, Volume II (Freeman, 1980)`。
  LZ 用它只是为了"强不可分解 ⇒ 直和分解唯一"（Krull–Schmidt 类结论）。
  **不要把 "Verma modules are strongly indecomposable" 归给 Jacobson**——LZ 把这句话本身当作已知事实陈述，
  只把"由此推出 (38)"的那一步指向 Jacobson §3.4。
- **(35)–(38) 是 §2 的公式号**。`lian-zuckerman-1989.md` §0 已记「章内公式号每章重起」，
  引用必须写成 **「LZ 1989, §2, eqs. (35)–(38), p. 320」**，不能只写 "(35)"。

### 6.6 本节剩余问题

- **Q6.1** LZ 从不写出一个**具体**的 `(p·p, n, h)` 三元组。若图里要一个可验证的反例实例，
  必须自己用 Meurman–Rocha 的 NS Kac 行列式在 `c = 10` 上找一个可约的负半整数 `h`——**这是一次真正的计算，不是检索**。
- **Q6.2 ★** 回头核 `fgz-1986` 正文里"玻色 Fock 空间一般不是 Verma 模直和"这句在哪（LZ 说在 [5] 里）。
  `brst-cohomology-sources.md` §1 是 L1 全文抽取，**应当能一次定位**。这条若坐实，
  FOK 的 NS 推导就同时被 LZ（超）与 FGZ（玻色）两侧否定。
- **Q6.3** 本文 §4 的 Q1 至此可以改写为：**矛盾不是"谁对谁错"，而是"FOK 把一条 LZ 与 FGZ 都明确否认的性质
  归给了 Brower–Friedman"**。但 **BF 正文（5 页）仍是 L0**，最终裁决仍需正文。
