# 抽取记录：hamada-loges-2025

- 文献：Y. Hamada, G. J. Loges, "A finite 6d supergravity landscape from anomalies", arXiv:2507.20949v1 [hep-th], 28 Jul 2025. 报告号 KEK-TH-2741. Prepared for submission to JHEP.
- 抽取者：researcher agent
- 日期：2026-09-13
- 覆盖范围：标题页（摘要逐字）、目录、§1 Introduction、§2 Preliminaries 含 Figure 1 与 §2.1 起始
- 取件方式：`arxiv.org/pdf/2507.20949` → WebFetch 落盘 → `Read(pages=)`。**证据等级 L1（原文页图）**。
- 页码换算：PDF 第 N 页 = 论文第 N−1 页。

## 约定

- 规范群 `G = ∏_i G_i` 取为**非阿贝尔**（§2 逐字：「The gauge group, `G = ∏_i G_i`, we take to be non-abelian」）。
- 反常向量记号与 KMT 差一个符号：脚注 1 逐字「The notation `a := −b_0` is common.」即本文的 `b_0` = KMT 的 `−a`。
- 张量标量 `𝔍 ∈ SO(1,T)/SO(T)`，规范动能项 `∝ 𝔍·b_i`，**要求非负以避免鬼态**。
- Table 1 给出 `λ_i` 与对偶 Coxeter 数 `h_i^∨`。

## 陈述

### E1 ★★ 局域+整体反常合起来给出有限景观（本次任务的判决性陈述）
- 位置：摘要，论文标题页
- 类型：proposition
- 原文陈述（**逐字**）：「6d supergravities with non-abelian gauge group are subject to many consistency conditions. **While the absence of local gauge and gravitational anomalies allows for infinitely many models, we show that those conditions stemming from the absence of both local and global anomalies together are strong enough to leave only finitely many consistent models.** To do this we distill the consequences of anomaly cancellation into a high-dimensional linear program whose dual can be efficiently studied using standard techniques. We obtain a universal bound on the number of tensor multiplets `T ≤ 11 · 273 = 3003` and show that this leads to a finite landscape of consistent non-abelian models. Interestingly, the model which saturates this bound has gauge group `[E_8 × F_4 × (G_2 × SU(2))²]^{273}`, which bears a striking resemblance to the model which saturates the bound `T ≤ 193` for F-theory constructions.」
- 文献自称的严格程度：「we show」。物理论证级（用线性规划对偶 + Dai–Freed 反常分析），**非形式化证明**。
- 备注：**★★ 这一条直接占据了我方立项草稿里"全局反常能排除哪些模型"那条缺口。** 该缺口在 KMT (2010) 时确实开放，2025 年 7 月被填。

### E2 全局反常的具体形式是 Dai–Freed 反常
- 位置：§1，论文 p.2
- 类型：definition / 方法说明
- 原文陈述（逐字）：「Dai-Freed [22] global anomalies arise when properly accounting for the fact that differential forms cannot fully capture all of the features of an (anti)self-dual 2-form gauge field. These anomalies are detected by placing the theory on a non-trivial curved background, such as the lens spaces that we consider in this work. In the context of 6d supergravity, Dai-Freed anomalies have recently been studied in [23, 24] and shown to be quite discerning.」
- 备注：§3.1 标题为 "Quadratic refinements and Dai-Freed anomalies"，§3.2 为 "Linear programming"。附录 B 为 η-invariants。

### E3 论证的逻辑结构（Figure 1）与假设清单
- 位置：Figure 1，论文 p.3
- 类型：方法说明
- 原文陈述（图注逐字）：「Logical organization of the finiteness argument. **Assumptions are in blue** and the absence of local gauge anomalies is used implicitly throughout.」
- 图中**蓝色（= 假设）只有三个**：`b_0 ∈ I_{1,T}` 或 `b_0/2 ∈ 𝕀_{1,T}` is primitive；`[Γ : Γ^BPS] ≤ C < ∞`；`∃𝔍 with 𝔍² > 0 and 𝔍·b_i > 0`；另有 `b_i² ≤ h(Δ_i)`（绿色）。
- 绿色（= 已证步骤）链条：Dai–Freed anomalies →(§3.1) if `b_i² ≤ −1`, `b_i^0 = 0` →(§3.2) `T ≥ f*(N)` →(§4.2) `T ≤ 3003`；另一支 `Δ + 29T ≤ 273` → `T ≤ 3003`；以及 "String probes & anomaly inflow" + 三个假设 →(§4.1) "Finite number of models for fixed T" → "Finite landscape"。
- 备注：**「Finite number of models for fixed T」在本文的论证图里是一个需要 §4.1 论证的中间结论**，其依赖包括 `[Γ:Γ^BPS] ≤ C < ∞` 这一假设——即本文的"固定 T 有限性"覆盖面比 KMT 的 `T<9` 更广（含 `T ≥ 9`），但代价是引入了 BPS 弦电荷格指标有限这一额外假设。

### E4 与其它两条有限性路线的关系（作者自陈）
- 位置：§1，论文 p.2
- 类型：文献定位
- 原文陈述（逐字）：「Recently in [19] it was argued by Kim, Vafa and Xu that the landscape of consistent 6d, N=1 supergravities with non-abelian gauge group is in fact finite. This is thanks to a sharp upper bound on the number of massless modes derived using the presence of a so-called `H`-string in the BPS spectrum. In particular, they find the bounds `T ≤ 193` and rank `G ≤ 480`, both of which are saturated by known F-theory constructions; this provides additional evidence for string universality. A similar bound of `T ≤ 567` was also recently achieved by Birkar and Lee [21] as a consequence of techniques developed to bound Hodge numbers of elliptic Calabi-Yau 3-folds. In the present work we give an argument for the finiteness of this 6d landscape which is complementary to both of these. Our upper bound on `T` will come from analyzing the structure of anomaly lattices subject to constraints coming from the absence of Dai-Freed anomalies; **consequently our working assumptions are somewhat different than those of [19] and [21]**.」
- 备注：⇒ 截至 2025-07 至少有**三条独立**的 6d 有限性论证（Kim–Vafa–Xu、Birkar–Lee、Hamada–Loges），且作者明说假设不同、互补。

## 未解决的疑问

1. §3–§4 正文（论文 p.7–23）未读，`T ≤ 3003` 的推导细节与 §4.1 "Finite number of models for fixed T" 的确切陈述未取。
2. 附录 A「Orbits in unimodular Lorentzian lattices」含 `b_0 = (3;1^T)` 唯一性的证明（§1 逐字：「Appendix A contains a proof of the uniqueness of `(3;1^T)` for the gravitational anomaly vector」）——**这是与本项目偶幺模格卡最近的一段，若日后想做形式化可从这里入手**，本次未读。
3. v1 尚未见发表版；是否被 JHEP 接收未查。
4. bib 条目未登记（本次无内容进图）。
