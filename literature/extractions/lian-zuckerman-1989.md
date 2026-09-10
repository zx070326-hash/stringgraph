# 抽取记录：lian-zuckerman-1989

- 文献：B. H. Lian and G. J. Zuckerman, *BRST cohomology of the super-Virasoro algebras*, Commun. Math. Phys. **125** (1989) 301–335
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文 35 页逐页读图（L1）**。获取途径：Project Euclid `https://projecteuclid.org/journalArticle/Download?urlId=cmp%2F1104179468`（免登录，2.5 MB，扫描件）。与 `lian-zuckerman-1991` 同一路线。
- 触发：`reading-list.md` P2 行「可试 lian-zuckerman-1991 成功用的 Project Euclid 端点」——已试，成功。

> **本文是 RNS 超弦（super-Virasoro）的 BRST 上同调，不是玻色弦。** 玻色弦 c=26 的结论请用 `fgz-1986` / `lian-zuckerman-1991`。

## 0. 证据等级与页码

全文 L1。页码为期刊页码（301–335）。**编号陷阱两处**：(a) p.305 有 **Lemma 1.4**，p.306 又有 **Definition 1.4**——同号异类，引用必须带类型词；(b) 章内公式号每章重起（§1 的 (1)–(8)、§2 的 (1)–(42)、§3 的 (1)–(40)、§4 的 (1)–(8)、§5 的 (1)–(30)），引用公式必须带章号。

## 1. 约定

- 超 Virasoro 代数 `Vir_κ`，κ = 0（Ramond）、κ = ½（Neveu–Schwarz），p.302 逐字：`[L_m, L_n] = (m−n)L_{m+n} + (c/8)(m³ − 2κm)δ_{m+n}`；`{G_{m+κ}, G_{n−κ}} = 2L_{m+n} + (c/2)(m² + 2κm)δ_{m+n}`。**中心荷归一化：`c/8`（不是 `c/12`）**，故物质表示 `π(c) = D·Id`（Prop 1.1），鬼表示 `ρ(c) = −10·Id`（Prop 1.2），临界 `D = 10`。
- 号差 p.302 逐字：「g^{μν} is the inverse of the Lorentz metric with signature ((D−1)+, 1−)」。与 canonical 一致。
- 物质 Fock 空间 `V(p,κ) = R(p,κ) ⊗ U(κ)`，`U(κ) = C[α^μ_{−n}, d^μ_{−n+κ}]|p⟩`，`R(p,½) = C`，`R(p,0)` 是 `Spin(D−1,1)` 旋量表示（p.303）。**p ≠ 0 到 §5 之前始终假设**（p.303 逐字「p will always be assumed non-zero until Sect. 5」）；且 p 在未来半光锥（p.305 Remark 逐字「we will assume that p is always in the future half R^{D−1,1}_+」）。
- 鬼系统 p.303 (1)–(4)：`[γ_{m+κ}, β_{n−κ}] = δ_{m+n}`，`{c_m, b_n} = δ_{m+n}`。**Bose-sea charge `q_B`**（p.303–304，引 Friedan et al. [6]，「Note: q_B here differs from that in [6] by a constant」）：`β_{n+κ}|q_B⟩ = 0 (n+κ > −q_B)`，`γ_{n+κ}|q_B⟩ = 0 (n+κ ≥ q_B)`；**逐字「Representations corresponding to distinct charges are inequivalent.」** Fermi-sea charge 固定 `q_F = 0`，记 `Λ_∞`。
- **零模表示的选择（p.306，(7)）**：为了有非退化厄米形式且 deg 有上界，κ = ½ 取 `T_{1/2}`；**κ = 0 取 `T₀ ⊕ T₁`**（两个 Bose-sea charge 的直和）。逐字：「A space in which deg (or "energy") is bounded neither above nor below will give rise to various difficulties. Fortunately, for each sector κ = ½, 0, there is a unique such space in which deg is bounded above」。
- 复形 (8)：`C(p,0) = R(p,0) ⊗ U(0) ⊗ Λ_∞ ⊗ (T₀ ⊕ T₁)`；`C(p,½) = R(p,½) ⊗ U(½) ⊗ Λ_∞ ⊗ T_{1/2}`。
- 鬼数 = `U + κ` 的本征值（Definition 1.8 前），`Z + κ` 值；R 扇区鬼数是整数（与 FOK 的 ±½ 约定不同，见 §4）。

## 2. 陈述

### E1 Q 的定义与幂零（Definition 1.6 [19]、Proposition 1.7）
- 位置：p.307–308。
- 类型：definition + proposition
- Definition 1.6 给 `Q, K, D_R, U` 的显式模式和（`Q = Σ(π(L_{−n})c_n + π(G_{−n+κ})γ_{n+κ} − ½(m−n):b_{m+n}c_{−m}c_{−n}: + (3/2 n + m + κ):c_{−m}β_{−n−κ}γ_{m+n+κ}: − :γ_{−m−κ}γ_{−n+κ}b_{m+n}:) − κc₀`，`K = π(L₀) + ρ(L₀)`，`D_R = π(G₀) + ρ(G₀)`，`U` = 鬼数算子）。记号引 GSW [19]。
- **Proposition 1.7** 逐字：「(i) All the operator sums above are well-defined on C … (ii) **Q² = 0 iff D = 10.** (iii) D_R* = −D_R, K* = K, Q* = (−1)^{2κ+1}Q … (iv) [Q, K] = 0. (v) {Q, D_R} = 0. (vi) [U, Q] = Q. … (ix) D_R² = K. (x) For κ = 0, Q = Kc₀ + Mb₀ + D_Rγ₀ + Nβ₀ + Q₀ + b₀γ₀² … (xi) For κ = ½, Q = Kc₀ + Mb₀ + Q₀ …」
- 证明逐字：「(ii) is done in [13, 15]. … (iv) to (viii) are obtained by straightforward computations, some of which are done in [13, 15, 19]. … (x) and (xi) Calculations are done in [13].」——[13] = Ohta PRD 33, [15] = Terao–Uehara PLB 168B。**LZ 自己不证 (ii)。**
- 文献自称的严格程度：Proposition；(ii) 外包。

### E2 相对复形（Proposition 2.1、Definition 2.2、2.3）
- 位置：p.308–309。
- **Proposition 2.1** 逐字：「[13] {Q, b₀} = K, [Q, β₀] = D_R.」
- **Definition 2.2** 逐字：`B^r(p,κ) = Ker b₀`（κ=½）`= Ker b₀ ∩ Ker β₀`（κ=0）；`F^n(p,κ) = B^{n−κ}(p,κ) ∩ Ker K`；`C^n_rel(p,κ) = F^n(p,κ)`（κ=½）`= F^n(p,κ) ∩ Ker D_R`（κ=0）。
- 备注：R 扇区相对复形 = `Ker b₀ ∩ Ker β₀ ∩ Ker K ∩ Ker D_R`——**这就是物理学家「`b₀|ψ⟩ = β₀|ψ⟩ = L₀|ψ⟩ = F₀|ψ⟩ = 0`」的数学版**（IMNU (3.24)–(3.26) 同型）。

### E3 消灭定理（Theorem 2.4 / Corollary 3.4）
- 位置：p.309（陈述）、p.323（证明）。
- 类型：proposition
- **Theorem 2.4** 逐字：「Suppose p ≠ 0: then H^n_rel(p,κ) = 0 unless n = 0.」紧随逐字：「This is the analogue of the vanishing theorem proven by FGZ.」
- 证明：§3，Corollary 3.4 (Theorem 2.4)，经 Prop 3.2（有限过滤）、Prop 3.3（伴随分次复形 `H^m = 0, m < 0`）、Lemma 3.1（Poincaré 对偶 `H^m_rel ≅ (H^{−m}_rel)*`）、**Theorem 3.3.1**（超李代数同调的正合序列 (40)，「a generalization of a theorem in the theory of classical Lie algebra homology (a good exposition is given in [18]; see also [23])」；用于 `Vir_κ^-` 与 `V(p,κ)` 自由性 Corollary 2.19(iii)）。
- 文献自称的严格程度：Theorem，有完整证明。p.335 逐字：「The only mathematically non-trivial result is the vanishing theorem (2.4).」

### E4 R 扇区零模：Theorem 2.7
- 位置：p.310。
- 逐字：「**Theorem 2.7.** Assume p ≠ 0: the above complex has zero cohomology. Thus C_rel(p,0) = D_R F(p,0).」（"the above complex" = `(F, D_R|_F)`，`F = Ker b₀ ∩ Ker β₀ ∩ Ker K`）。证明逐字：「For p ≠ 0, say p¹ ≠ 0, we have {D_R|_F, d¹₀/p¹} = 1. Applying this formula on Ω ∈ Ker D_R|_F, one sees that Ω ∈ Im D_R|_F.」
- 备注：这是 Corrigan–Goddard / Henneaux「零模 supercharge 上同调平凡」的数学版；Definition 2.11 的 Remark 称之为 contracting homotopy `ε`，`{D_R, ε} = 1`。

### E5 相对复形上的厄米形式（Definition 2.11、Proposition 2.14(i)）
- 位置：p.311–312。
- Definition 2.11 逐字：`⟨u,v⟩_rel = ⟨u,v⟩_B`（κ=½）；`= √−1⟨u, v̂⟩_B` where `v = D_R v̂`（κ=0）。动机 p.310：「⟨·, c₀·⟩_C ≡ 0 when restricted to C_rel(p,0) … because ⟨T₁, T₁⟩_T = 0」——**R 扇区 β₀ 零模使朴素内积在相对复形上恒零，须用 `D_R` 原像定义**。
- Proposition 2.14(i)：`Q* = Q` w.r.t. `⟨,⟩_rel`。(ii) 特征标/号差公式 `char C_rel(p,κ) = ½(2κ+1) dim R(p,κ) p^{(8)}_κ(κ − p·p/2) = sign C_rel(p,κ)`。

### E6 ★ Corollary 2.15（量子化条件 + No-ghost Theorem）
- 位置：p.317。
- 逐字：「**Corollary 2.15.** (i) ("Quantization Condition") dim H⁰_rel(p,κ) = ½(2κ+1) dim R(p,κ) p^{(8)}_κ(κ − p·p/2). (ii) (No-ghost Theorem) H⁰_rel(p,κ) is a positive definite space.」
- 证明：Euler–Poincaré 原理 + Theorem 2.4 + Prop 2.14(ii)。
- 文献自称：Corollary；作者自命名 "No-ghost Theorem"。

### E7 物理态、横向空间（Definition 2.16、Proposition 2.18、Corollary 2.19）
- 位置：p.317–321。
- **Definition 2.16** 逐字：「Let P(p,κ) = {v ∈ V(p,κ): π(L_n)v = δ_n κv, π(G_{n+κ})v = 0, n ≥ 0}. It is called the space of physical states.」（`L₀` 本征值 = κ：NS 为 ½、R 为 0，即截距。）
- **Proposition 2.18**：存在 `T(p,κ) ⊂ V(p,κ)^{Vir_κ^+}` 使 `ch_q T(p,κ) = dim R(p,κ) q^{p·p/2} φ_κ(q)^{−8}`；`T(p,½)` 正定；`T(p,0) = T⁺ ⊕ T⁻`。证明逐字：「Using the so-called spectrum generating algebra, physicists [1, 2] have constructed these spaces. However, we will prove their existence the way FGZ did in the bosonic case.」用 Kac 行列式 [22]（Meurman–Rocha）与 `M_κ(h', 9)` 的幺正性 [7, 9, 10]。
- p.320 Remark：「V(p,κ) is in general not a direct sum of Verma modules of Vir_κ even though it is Vir_κ^- -free.」（反例 NS 扇区，用 Kac 行列式）——**与 FOK p.111「It was proven by Brower and Friedman [11] that this representation is fully reducible … infinite direct sum of Verma modules」直接矛盾**，见 §4。
- **Corollary 2.19**：(i) `dim T∩P = ½(2κ+1) dim R(p,κ) p^{(8)}_κ(κ − p·p/2)`；(ii) `T∩P` 正定；(iii) `V(p,κ)` 是自由 `Vir_κ^-` 模。

### E8 ★★ Theorem 2.20（超弦无鬼定理的上同调形式）
- 位置：p.321。
- 逐字：「**Theorem 2.20.** There are unitary isomorphisms T ∩ P ≅ P/rad P ≅ H⁰_rel.」
- 证明：映射 `λ: P → C⁰_rel, λ(v) = v ⊗ |q_F = 1⟩ ⊗ |q_B = 1 − κ⟩`（**显式给出包含映射**，与 LZ 1991 Lemma 2.22 同型），诱导等距 `P/λ^{−1}B⁰_rel → H⁰_rel`；由 Cor 2.19(ii)、Cor 2.15(i)、Cor 2.19(i) 维数相等得同构。
- 前提链（全文散布，引用时须集齐）：`p ≠ 0`（Thm 2.4）；`D = 10`（p.308「From now on, we will take D = 10」）；`p` 未来向（Def 1.3 Remark）；空间为 (8)，即 R 扇区用 `T₀ ⊕ T₁`。
- 文献自称：Theorem，有证明。p.335 结论逐字：「We have shown that such a construction indeed leads to a theory equivalent to the "old covariant" quantization method.」

### E9 GSO 投影的上同调版（§4：Definition 4.1、Proposition 4.2、4.3）
- 位置：p.327–330。
- Definition 4.1：`Ḡ_κ = Γ_κ(−1)^{Σ(d_{−n+κ}d_{n−κ} + b_{−n}c_n + c_{−n}b_n)}`，`P̄_± = ½(1 ± (−1)^{U+κ}Ḡ_κ)`；p.329 Remark 逐字：「The right-hand side is precisely the "G-parity" proposed by Terao, Uehara [15], and Ohta [13], as a generalization of the GSO projection.」
- **Proposition 4.3**：(i) `H*_rel ≅ H*(P̄₊C_rel) ⊕ H*(P̄₋C_rel)` 正交分解；(ii) `dim H^n(P̄₊C_rel) = 8p₀^{(8)}(−p·p/2)` for n = 0, 0 otherwise。p.330 逐字：「H⁰(P̄₊C_rel(p,½)) has no tachyonic states and dim H⁰(P̄₊C_rel(p,½)) = dim H⁰(P̄₊C_rel(p,0)). Thus we have achieved the "covariant" equivalent of the GSO projection.」

### E10 绝对复形的上同调（Theorem 5.1、Theorem 5.4）与例外情形（Proposition 5.5）
- 位置：p.330–334。
- **Theorem 5.1** 逐字：「There are isomorphisms H⁰_rel(p,½) ≅ H^{±1/2}(p,½) and H^n(p,½) = 0 for n ≠ ±½.」
- **Theorem 5.4** 逐字：「For κ = 0, the cohomology of the BRST complex is given by H^n(p,0) ≅ H⁰_rel(p,0) for n = 1; ≅ H⁰_rel(p,0)* ⊕ H⁰_rel(p,0) for n = 0; ≅ H⁰_rel(p,0)* for n = −1; = 0 otherwise.」（R 扇区绝对上同调有**三个**非零鬼数，因为 `T₀ ⊕ T₁` 两个 Bose-sea 分量各贡献。）
- **Lemma 5.3.1 (Dixon–Taylor)** + p.332 (18)–(23)：`Q = Aγ₀ + Bβ₀ + C` 结构，`A² = C² = 0, B² = CA`，`Ker A = Im A`；逐字「A similar structure ((18) to (23)) was first realized by Dixon and Taylor [21] … Kato and Ogawa [11] then apply it in a different context.」证明末句「The reader can consult [11] for details.」
- **Proposition 5.5**（p = 0）：p.333 逐字「For p = 0, the vanishing theorem does not hold because the Fock space V(p,κ) is not Vir_κ^- -free」；显式列出 `H^n_rel(0,κ)` 与 `H^n(0,κ)`（κ=0：n = 0, ±1；κ=½：n = ±½, ±3/2）。

## 3. 参考文献里的三条钥匙（L1）

- [11] Kato–Ogawa NPB B212, 443 (1983)；[13] **Ohta PRD D33, "681–1691" (1986)**（起页少印一位，终页 1691）；[15] Terao–Uehara PLB 168B, 70–74 (1986)。
- **不引 Henneaux（PLB 177/183）**。
- p.335 Note added in proof 逐字：「After the completion of this work, we received preprints from J. Figueroa-O'Farrill and T. Kimura, whose work appears to be similar to ours.」⇒ 与 FOK 1989 独立。

## 4. 未解决的疑问 / 矛盾

- **Q1（与 FOK 的矛盾）**：LZ p.320 Remark 明证「V(p,κ) is in general not a direct sum of Verma modules」；FOK p.111 却写「It was proven by Brower and Friedman [11] that this representation is fully reducible … infinite direct sum of Verma modules」并以此为据逐 Verma 模算上同调。**两篇的"Brower–Friedman 完全可约性"陈述互相矛盾**；LZ 不需要它（用自由性 Cor 2.19(iii)），FOK 需要。裁决需读 Brower–Friedman PRD 7, 535 (1973)。这是 FOK 路线的一处结构性弱点。
- **Q2（鬼数约定）**：LZ 的 R 扇区绝对上同调落在 n = −1, 0, 1（Thm 5.4），FOK 的落在 ±½（(5.3)），Dedushenko 的落在 `(A+1) ± ½`。三者是同一结果的不同鬼数零点约定（LZ 的 `T₀ ⊕ T₁` 使 U 取整数）；curator 建节点时鬼数只能相对地写。
- **Q3**：Prop 1.7(ii) 的 iff 是 LZ 陈述、证明外包 [13,15]；Ohta 摘要只有 ⟹。
- **Q4**：Definition 1.3(ii) 用 `p·d₀` 定义 `R(p,0)` 上的形式并要求 `p·p = 0` 时分半——`p·p ≠ 0` 情形 `⟨,⟩_R` 由 `√−1 δ^{ij}` 定义；Cor 2.19(ii) 的正定性对 R 扇区依赖 (27)(28) 的 `1_±` 归一化。转录时公式细节（`√−1` 位置）建议引用前复核 p.305、p.319。

## 5. 对图的建议

- `no-ghost-theorem-superstring`：**Theorem 2.20 + Corollary 2.15(ii)** 是最佳 canonical（L1、编号、有证明、显式包含映射）。前提链见 E8。status 可 `rigorous`，gaps：`p ≠ 0`（Prop 5.5 例外情形单独一卡）、Prop 1.7(ii) 幂零外包给物理文献、Thm 3.3.1 自称「slight modification of the ordinary case」。
- 超弦 `Q² = 0 ⟺ D = 10`：Proposition 1.7(ii) 是唯一带 iff 的编号陈述，但**本文不证**；显式系数公式见 `ito-morozumi-nojiri-uehara-1986` (3.8)–(3.10)。
- GSO：Prop 4.3 可作「GSO 投影与 BRST 上同调相容」的 rigorous 来源；物理提案归 Terao–Uehara / Ohta（p.329 Remark）。
- 相对 vs 绝对上同调：Thm 5.1 / 5.4 给出绝对上同调 = 相对上同调的两（三）份拷贝，可与 Dedushenko 2015 (39) 对照。
