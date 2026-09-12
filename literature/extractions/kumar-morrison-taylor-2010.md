# 抽取记录：kumar-morrison-taylor-2010

- 文献：V. Kumar, D. R. Morrison, W. Taylor, "Global aspects of the space of 6D N=1 supergravities", arXiv:1008.1062v1 [hep-th], 5 Aug 2010. 报告号 MIT-CTP-4132 / NSF-KITP-10-096 / UCSB-Math-2010-19.
- 抽取者：researcher agent
- 日期：2026-09-13
- 覆盖范围：标题页、目录、§1 Introduction、§2 Anomalies and lattices（§2.1–§2.2 起始）、§3 Finite bound for fixed T<9（全节）、§4.1–§4.2 起始
- 取件方式：`arxiv.org/pdf/1008.1062` → WebFetch 落盘 → `Read(pages=)` 逐页读图。**证据等级 L1（原文页图）**。
- 页码换算：PDF 第 N 页 = 论文第 N−1 页（PDF p.1 为标题页，PDF p.2 页脚为 "– 1 –"）。

## 约定

- 规范群取 **半单** `𝒢 = ∏ᵢ Gᵢ`；正文 §2 开头逐字：「The analysis of abelian factors will appear elsewhere [8]」，**本文全程忽略 U(1) 因子**。
- `T` = 张量多重态数目；张量标量模空间为 `SO(1,T)/SO(T)`，由 `ℝ^{1,T}` 中范数 `Ω_{αβ} j^α j^β = +1` 的向量 `j^α` 参数化。
- `x·y ≡ Ω_{αβ} x^α y^β`；反常向量 `a^α`、`b_i^α ∈ ℝ^{1,T}`。
- 归一化因子 `λ_i` 由「嵌入 SU(2) 瞬子的最小拓扑荷为 1」定出，Table 1：`A_n:1, B_n:2, C_n:1, D_n:2, E6:6, E7:12, E8:60, F4:6, G2:2`。
- **与本项目 conv.canonical 的换算未做**（本次纯调研，不进图）。

## 陈述

### E1 GSS 机制的反常因子化形式
- 位置：§2.1，(2.1)–(2.2)，论文 p.3
- 类型：definition
- 原文陈述（逐字）：「Anomalies can be cancelled by the Green-Schwarz-Sagnotti mechanism if the anomaly polynomial `I_8` can be written in the form `I_8(R,F) = ½ Ω_{αβ} X_4^α X_4^β`」，其中 `X_4^α = ½ a^α trR² + Σ_i b_i^α (2/λ_i) trF_i²`。
- 文献自称的严格程度：定义性陈述，引 Sagnotti [9]，记号取自 [10]。
- 备注：`T ≠ 1` 时**写不出 Lorentz 协变拉氏量**（§2.1 逐字：「When T ≠ 1, one cannot write down a Lorentz covariant Lagrangian」），只能按 [14,15] 构造配分函数。

### E2 反常抵消条件组（本项目关心的"条件集合"）
- 位置：§2.1，(2.6)–(2.13)，论文 p.4–5
- 类型：proposition
- 原文陈述：
  - (2.6) `H − V = 273 − 29T`（由 `trR⁴` 反常消失）
  - (2.7) `B^i_adj = Σ_R x^i_R B^i_R`（由 `trF⁴` 消失）
  - (2.10) `a·a = 9 − T`
  - (2.11) `a·b_i = (1/6)λ_i (A^i_adj − Σ_R x^i_R A^i_R)`
  - (2.12) `b_i·b_i = −(1/3)λ_i² (C^i_adj − Σ_R x^i_R C^i_R)`
  - (2.13) `b_i·b_j = λ_iλ_j Σ_{RS} x^{ij}_{RS} A^i_R A^j_S`
- 文献自称的严格程度：由反常多项式因子化直接导出。
- 备注：`A_R, B_R, C_R` 由 (2.8)(2.9) 定义。

### E3 整格 Λ 的存在性是**结论而非假设**
- 位置：§2.2 "Proof of integrality"（论文 p.5 起）+ §2 开头
- 类型：proposition
- 原文陈述（逐字）：「we … show that the anomaly cancellation conditions imply the existence of an integral lattice associated with any consistent 6D N=1 theory」；§2.1 末逐字：「We demonstrate in the following section that these inner products are all integers, so that `a, b_i` can be used to define an integral lattice.」
- 文献自称的严格程度：「We demonstrate」「we show」——自称证明。
- 备注：**★ 这一条修正了我方立项草稿的一个误设。** 我方原拟把「Dirac 量子化 ⇒ 反常系数格可延拓为幺模格」当作**附加假设**列入命题前提；KMT §2.3（论文 p.9–10）逐字说：「It is interesting and perhaps suggestive that the integrality of the lattice Λ follows directly from the anomaly cancellation conditions, **with no further assumptions** about the quantum consistency of the theory or the existence of quantum string states.」⇒ 整性不是独立条件。文中同时指出 Λ **可能退化**（「Note that this lattice may be degenerate」），且真正需要额外假设的是"含 Λ 为子格的号差 (1,T) 整格 Λ̄"（BPS 双荷弦的电荷格）。

### E4 ★ T<9 有限性定理（本次任务的核心）
- 位置：§3，论文 p.10 开头 + p.14 末的结论句
- 类型：proposition
- 原文陈述（逐字，p.10）：「In this section we prove that for fixed `T < 9` there are a finite number of distinct possible combinations of nonabelian gauge group and matter representations. This analysis is purely based on aspects of the low-energy supergravity theory, and is independent of string theory or any other specific UV completion.」
  结论句（逐字，p.14 末）：「So we have proven that for `T < 9` there are a finite number of distinct gauge groups and matter content which satisfy anomaly cancellation with physical kinetic terms for all gauge field factors.」
- 文献自称的严格程度：「we prove」「we have proven」——自称严格证明（物理学家式，非形式化）。
- 精确量词与条件（抽取者按原文归纳，非原文语句）：
  - 量词：∀ 固定的 `T ∈ {0,…,8}`（p.10 逐字「for any fixed `T` between 0 and 8」），满足下列条件的（半单非阿贝尔规范群，物质表示）组合只有**有限多**。
  - 条件仅两条：**(i)** 反常抵消 (2.7)–(2.13)；**(ii)** 所有规范场因子的动能项符号正确（即 `j·b_i > 0`）。
  - **不含**全局反常、不含 Dirac 量子化附加条件（见 E3）、**不含 U(1) 因子**。
- 证明结构（原文）：反证法 + 两种情形。Case 1（单因子维数有界、因子数无界）用 Turán 定理 (3.7) 与类型 Z/N/P 分类，对**所有 T>0** 排除；Case 2（至少一个单因子维数无界）用 `F⁴` 条件 (3.12)(3.13) 把大 `N` 解限制到 Table 2 的有限清单，再用 `a² = 9−T > 0` 排除。
- 失效点（逐字，p.10）：「The constraint on infinite families breaks down at `T = 9` due to the change of sign of `a² = 9 − T`.」

### E5 ★★ 完全枚举被明确列为未来工作（本次任务的判决性证据）
- 位置：§3 末，论文 p.15
- 类型：作者自陈的开放问题
- 原文陈述（逐字）：「A systematic enumeration of the finite set of possible gauge groups and matter content compatible with a fixed `T < 9` is in principle possible. … One could proceed with a systematic enumeration by sequentially classifying all models with matter transforming under at most `λ` distinct gauge group factors for increasing values of `λ`. … **We leave a complete and systematic enumeration of the finite set of possible `T < 9` models for future work.**」
- 备注：**⇒ KMT 只证有限性、不给枚举。** 这与我方立项草稿拟证的命题（"有限 + 完全枚举"）在 2010 年确实存在缺口。**但该缺口在 2023–2025 年已被填上，见 `hamada-loges-2023.md` / `hamada-loges-2024.md` / `hamada-loges-2025.md`。**

### E6 未被排除的情形（作者自陈的边界）
- 位置：§3 末，论文 p.15
- 类型：作者自陈
- 原文陈述（逐字）：「We have ruled out infinite families with unbounded numbers of gauge group factors at any finite `T`, though we show that such infinite families exist when `T` is unbounded in Section 4. We have not ruled out infinite families with a finite number of gauge group factors which become unbounded at finite `T > 8`. Indeed, we give an explicit construction of such a family in Section 4.」
- 备注：§4.1 给出 `T = 9` 处 `SU(N)×SU(N)` 双基本表示的无穷族（(4.1)(4.2) 给出显式向量）；§4.2 给出 `G = E_8^k`、`T = 9+8k` 的无穷族 (4.4)。§4.1 末逐字：「We will show in Section 6 that at `T = 9` these models are incompatible with F-theory for large enough values of `N` and thus do not have any known string realization.」

### E7 F-theory 可实现性条件的状态
- 位置：§1 Introduction（论文 p.2）、§5 标题与 §5.2
- 类型：作者自陈
- 原文陈述（逐字，§1）：「In Section 5 we use the integral lattice for each theory to construct topological data which would be associated with any corresponding F-theory construction, and describe constraints on the class of models which can be realized through F-theory.」；「The analysis of models which satisfy known low-energy consistency conditions and yet violate F-theory constraints suggests possible novel constraints on low-energy supergravity theories.」（摘要）
- 备注：**本次只读到 §5 的标题与 §1 的描述，未逐页读 §5–§7**，故「KMT 自陈 F-theory 可实现性充要条件 left for future work」这句**在本轮未取得逐字背书**；我此前向 lead 转述该句时标为二手，现仍维持二手（L3）。摘要用词是 "constraints"（约束）而非 "necessary and sufficient conditions"。

## 未解决的疑问

1. §5–§7 未读。「F-theory 可实现性的充要条件」是否被 KMT 明确列为 open，尚无 L1 背书。
2. Table 2 的四类 `SU(N)` 物质内容与 `SO(N)`、`Sp(N/2)` 行未逐项复核数值。
3. 本文为 v1（2010-08-05）；是否有后续版本修订 §3 的陈述未查。
4. bib 条目未登记（本次无内容进图，抽取记录为中间产物）。
