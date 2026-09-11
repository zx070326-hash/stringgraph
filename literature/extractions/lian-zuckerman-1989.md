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

---

## 6. 复核（2026-09-11，auditor 页图）

> 本节只**追加更正**，上文 §1（动量假设那一行）与 §2 E8（前提链那一行）的原文字句一律保留不改；两处凡写「未来半光锥」「p 未来向」的，**以本节为准**。

### 复核-1 p.305 Remark 的动量假设是**半空间 p^D > 0**，不是「未来半光锥」

- 位置：p.305，Definition 1.3 之后的 **Remark**（上文 E8 标注的位置正确）。
- **逐字（auditor 一手页图，2026-09-11）**：
  > 「For convenience, we will assume that p is always in the future half R^{D−1,1}_+ of R^{D−1,1}, i.e. R^{D−1,1}_+ = {p ∈ R^{D−1,1}: p^D > 0}. For if we allow p^D < 0, "time reversal" will reverse the signature of ⟨,⟩_R.」
- **更正点（来自原文逐字，非推断）**：
  1. 原文确实出现 "future half" 字样，但其中 "half" 修饰的是 **半空间** `R^{D−1,1}_+`，原文紧接着用 "i.e." 把它**定义为** `{p : p^D > 0}`——**只有一个不等式，是半空间，不是光锥**。上文写「未来半光锥」是误述：原文**不**要求 `p·p ≤ 0`，**不**要求类时或类光，因而该集合同样含类空动量。
  2. 原文自述强度是 "For convenience"（方便起见），并给出**唯一**理由：允许 `p^D < 0` 时，"time reversal" 会**翻转 `⟨,⟩_R` 的号差**。即按原文，这个假设的作用是**固定 R 扇区厄米型 `⟨,⟩_R` 的整体符号**。
  3. 与号差约定的接口：p.302 号差为 `((D−1)+, 1−)`（见 §1），故 `p^D` 是类时分量，`p^D > 0` 即"正能量分支"。
- **引用纪律**：
  - 凡在图节点里复述该前提，写「`p` 落在半空间 `R^{D−1,1}_+ = {p^D > 0}`」，**不得**写成「未来半光锥」「未来类时」「on/inside the forward light cone」。
  - 本节**不判定**该假设在 Theorem 2.4 / Theorem 2.20 的证明中是否可去——原文只说 "for convenience" 并只给了 `⟨,⟩_R` 号差这一个理由，是否还有别处依赖它，属 curator 的 `inferred` 判断，抽取阶段不做。E8「前提链」那一行仍应保留该条，但措辞按上一点改写。
- 证据等级：**L1**（auditor 页图逐字）。原记录（researcher 2026-09-11 首轮，同为 L1 页图）在此处转述失真，属**转述错误**而非取件错误。

---

## 7. ★ §4「GSO 投影」逐字复核（2026-09-11，researcher 第二轮页图）——Proposition 4.3、p.329 Remark 的 G-parity、p.330 收尾句

> 只追加，不改上文 §2 E9 任何一行。触发：图里要把「GSO 投影的协变/上同调版本」挂 LZ 1989，需要 Prop 4.3 与 G-parity 定义的逐字。
> 取件：Project Euclid `https://projecteuclid.org/download/pdf_1/euclid.cmp/1104179468`（2.5 MB 扫描件，免登录，**与 §0 同一文件**）→ `Read(pages=28-33)`。**PDF 页 = 期刊页 − 300**（p.328 = PDF 28）。

### 7.1 ★★ 两个都叫 `Ḡ_κ` 的算子（p.328）——**引用前必须先消歧**

本节最重要的发现：**p.328 上一页之内 `Ḡ_κ` 被定义了两次，作用空间不同**，上文 E9 只记了第二个。

**(a) 物质 Fock 空间上的 G-parity（p.328，正文，无编号）逐字：**

> 「GSO defined the *G*-parity on the Fock space `V(p,κ)` by
> `Ḡ_κ = Γ_κ(−1)^{Σ_{n≥1} d_{−n+κ}·d_{n−κ}}` ,
> where `Γ_{1/2} = −1` and `Γ₀` is the chirality operator on `R(p,0)` with `Γ₀² = 1`, `{Γ₀, d₀} = 0`. Note that `Ḡ_κ` is essentially the **Z₂**-gradation defined on `V(p,κ)`. Thus a natural extension to `C_rel(p,κ)` would be」

**(b) 相对复形上的延拓 = Definition 4.1（p.328）逐字：**

> 「**Definition 4.1.** *Let* `Ḡ_κ = Γ_κ(−1)^{Σ_{n≥1}(d_{−n+κ}d_{n−κ} + b_{−n}c_n + c_{−n}b_n)}`. *Then one has*
> `Q : ½(1 ± Ḡ_κ)C^n_rel(p,κ) → ½(1 ∓ Ḡ_κ)C^{n+1}_rel(p,κ)`.  (1)
> *Let*
> `P̄_± = ½(1 ± (−1)^{U+κ}Ḡ_κ)`.  (2)
> It follows that `(P̄_± C*_rel(p,κ), Q)` are two subcomplexes of `(C*_rel(p,κ), Q)`. We will denote their cohomology groups by `H*(P̄_± C_rel)` and call `(P̄_± C*_rel, Q)` the **GSO subcomplex**.」

⚠ **引用纪律**：(a) 只含物质振子 `d`，(b) 多了 `bc` 鬼场项。两者同名同记号。凡在节点里写 `Ḡ_κ`，**必须写明是 Definition 4.1 的版本还是 p.328 正文那个**。
⚠ **(1) 的箭头是 `± → ∓`**：`Q` **反转** `Ḡ_κ` 的本征值，所以真正与 `Q` 对易的投影是 (2) 里带 `(−1)^{U+κ}` 的那个组合，不是 `½(1±Ḡ_κ)` 本身。上文 E9 把 (1) 略掉了，而这一步正是 `P̄_±` 为什么要乘 `(−1)^{U+κ}` 的全部理由。

### 7.2 ★★ p.329 Remark 逐字——「the right-hand side」指的是 `(−1)^{U+κ}Ḡ_κ`，不是 `Ḡ_κ`

> 「**Remark.** We note that each of the factors
> `(−1)^{Σ_{n≥1} b_{−n}c_n}` , `(−1)^{Σ_{n≥1} c_{−n}b_n}` ,
> `(−1)^{Σ_{n≥1} β_{−n+κ}γ_{n−κ}}` , `(−1)^{Σ_{n≥1} γ_{−n+κ}β_{n−κ}}`
> in `(−1)^{U+κ}` is an involution. Thus we can write
> `(−1)^{U+κ}Ḡ_κ = Γ_κ(−1)^{Σ_{n≥1}(d_{−n+κ}d_{n−κ} + β_{−n+κ}γ_{n−κ} − γ_{−n+κ}β_{n−κ})}` .
> The right-hand side is precisely the **"G-parity"** proposed by Terao, Uehara [15], and Ohta [13], as a generalization of the GSO projection.」

**三条使用说明：**

1. **上文 E9 引的那句「The right-hand side is precisely the "G-parity"…」，其「right-hand side」是上面这个 `(−1)^{U+κ}Ḡ_κ` 的重写式**，**不是** Definition 4.1 的 `Ḡ_κ`。E9 只抄了结论句、没抄被指代的式子，容易被读成「Definition 4.1 = Terao–Uehara/Ohta 的 G-parity」——**那是错的**。
2. 结构上：`(−1)^{U+κ}` 提供四个鬼场对合因子，与 Definition 4.1 里的 `bc` 项相乘后 **`bc` 项在最终表达式里消失**，只剩 `dd` 与 `βγ` 项。这解释了为什么重写式比 Definition 4.1 「更短又更对称」。
3. ⚠ **转录可信度分层（1989 年 CMP 扫描件，下标字号极小）**：
   - **高可信**：四个对合因子的**类型**（两个 `bc`、两个 `βγ`）、`(−1)^{U+κ}Ḡ_κ` 这个左端、`Γ_κ` 前因子、`dd` 项、结论句逐字。
   - **需复核**：重写式指数里 `β γ` 与 `γ β` 两项之间的**相对符号**（我读到的是 `+ … −`），以及各下标 `−n+κ / n−κ` 的精确配对。**凡把这条式子写进图节点的 `statement`，先请 auditor 用同一页图复核一次符号**；只引「`(−1)^{U+κ}Ḡ_κ` = Terao–Uehara/Ohta 的 G-parity」这个**指认**则无此风险。

### 7.3 ★ Proposition 4.2 与 Proposition 4.3 逐字（p.329 下半 – p.330）

> 「**Proposition 4.2.** `char P̄_+C_rel(p,k) = 8p₀^{(8)}(−p·p/2)`.」

⚠ **原刊排印疑点**：参数写作 **`(p, k)`**，而全文其余各处一律用 `κ`（kappa）。按上下文（`Proof. Let κ = ½. Then …`，随后又做 `κ = 0`）**应为 `(p, κ)`**。属**原刊排印错误**的可能性大于扫描误读（同页其他 `κ` 渲染正常）。引用时写 `κ`。

> 「**Proposition 4.3.** *For* `κ = 0, ½`,
> (i) *there is an isometry*
> `H*_rel ≅ H*(P̄_+C_rel) ⊕ H*(P̄_−C_rel)`
> *such that the right-hand side is an orthogonal decomposition*;
> (ii) *the cohomology of the GSO subcomplex has*
> `dim H^n(P̄_+C_rel) = 8p₀^{(8)}(−p·p/2)`  *for* `n = 0`
> `= 0`  *otherwise*.」

**证明逐字（p.330）：**

> 「*Proof.*
> (i) It is easy to check that `P̄_±` are orthogonal projectors with respect to `⟨,⟩_rel` i.e.
> `P̄²_± = P̄_±` , `P̄_±* = P̄_±` ,
> `P̄_+P̄_− = P̄_−P̄_+ = 0` , `P̄_+ + P̄_− = 1` .
> Furthermore, `[Q, P̄_±] = 0`. These equations imply that the map
> `H*_rel → H*(P̄_+C_rel) + H*(P̄_−C_rel)` ,
> `[ω] ↦ [P̄_+ω] + [P̄_−ω]`
> is an isometry.
> (ii) Combining (i) and **Theorem 2.4**, we have `H^n(P̄_+C_rel) = 0` unless `n = 0`. By the **Euler–Poincaré Principle**, we have
> `Σ_{n∈Z}(−1)^n dim P̄_+C_rel = dim H^0(P̄_+C_rel)` .
> The left-hand side is `char P̄_+C_rel` which is given by **Proposition 4.2**. □」

**对建卡的四点（全部出自上面逐字，非推断）：**

1. **等距映射是显式给出的**：`[ω] ↦ [P̄_+ω] + [P̄_−ω]`（与 Thm 2.20 的 `λ` 一样，LZ 习惯把映射写出来）。
2. **Prop 4.3 的依赖是原文明写的**：`Theorem 2.4`（消灭定理）+ Euler–Poincaré + `Proposition 4.2`。⇒ **Prop 4.3 继承 Thm 2.4 的全部前提**，其中最要紧的是 **`p ≠ 0`**（Thm 2.4 逐字「Suppose p ≠ 0」），以及 §1 的 `D = 10`、`p` 在半空间 `{p^D > 0}`（见 §6 复核-1）。**Prop 4.3 自身的陈述里一个量词都没有**，`κ = 0, ½` 是唯一显式的。
3. **(ii) 只对 `P̄_+` 成立**——原文没有给 `P̄_−` 的维数公式。写节点时不要对称化。
4. **强度**：Proposition，证明完整（"It is easy to check" 只用在投影子的四条代数恒等式上，那几条确实是一行演算）。

### 7.4 ★ p.330 收尾句逐字——引号只加在 "covariant" 一个词上

> 「We note that the cohomology of the GSO subcomplexes `H^0(P̄_+C_rel(p,κ))`, `κ = 0, ½` no longer have the two undesirable features—i.e. `H^0(P̄_+C_rel(p,½))` has no tachyonic states and `dim H^0(P̄_+C_rel(p,½)) = dim H^0(P̄_+C_rel(p,0))`. Thus we have achieved the **"covariant"** equivalent of the GSO projection.」

⚠ **两处易错**：
- 原文是 `the "covariant" equivalent of the GSO projection`，**引号只包住 `covariant`**，不是 `the "covariant equivalent of the GSO projection"`。任务书与常见转述都写成后者。
- 动词是 **"we have achieved"**，不是 "we have proved/constructed"；作者把它当作**对已有物理提案的协变重述**，而不是新定理。**节点的 statement 不宜写成「LZ 证明了 GSO 投影」。**

### 7.5 「两个不良特征」的出处（p.328 开头，逐字）——Prop 4.3 的动机

> 「… sector (`κ = 0`) fermions. However, **Corollary 2.15 (i)** implies that `dim H^0_rel(p,0) ≠ dim H^0_rel(p,½)`. Thus one of the basic requirements of a supersymmetric theory — # bosons = # fermions at each mass level — is violated. It turns out that these two undesirable features can be removed by certain natural truncations on the spectrum. They were first proposed by **Gliozzi, Scherk and Olive [8]** (GSO) in the **"old covariant"** formalism. It turns out that if one projects out the **Z₂**-odd states of `P(p,κ)` in both sectors, the above two features will be eliminated. We will discuss these truncations below.」

⇒ (a) 两个不良特征 = **NS 扇区有快子** + **玻色/费米态数不等**（后者由 `Corollary 2.15(i)` 的维数公式直接读出）；
(b) **GSO 的原始提案归 [8] = Gliozzi–Scherk–Olive，且 LZ 明说那是在「old covariant」形式下提的**——本文自己只做协变化；
(c) 顺带：**LZ 1989 全文出现 "old covariant" 字样**（此处 + p.335 结论句）。这与 `lian-zuckerman-1991` 记录里「全文无 old covariant 字样」**不矛盾**，那是另一篇。

### 7.6 本轮 negative evidence（通读期刊 pp.328–333 六页）

- §4 **不出现 "spacetime supersymmetry" 的证明**，只出现「#bosons = #fermions at each mass level」这条必要条件（p.328）。**不要把 Prop 4.3 当作时空超对称的来源。**
- §4 **不出现 `E₈×E₈` / `SO(32)` / 模不变性 / 配分函数**——GSO 在本文是**纯代数截断**，没有一圈模不变性的论证。
- §4 **不引 Henneaux、不引 FGZ**；GSO 相关只引 [8]（GSO）、[13]（Ohta）、[15]（Terao–Uehara）、[19]（GSW，用于 Jacobi 公式：p.328 逐字「using Jacobi formula (see [19], Chap. 4)」）。

### 7.7 对图的建议（researcher 不改 `graph/`，仅列；替换 §5 里 GSO 那一行的粒度）

| 建议节点 | kind / status | statement 要点 | loc | 依赖 |
|---|---|---|---|---|
| `gso-subcomplex-definition` | definition | `P̄_± = ½(1 ± (−1)^{U+κ}Ḡ_κ)`；`(P̄_±C*_rel, Q)` 是子复形 | `Definition 4.1, p.328` | `Ḡ_κ`（Def 4.1 版）、`U`、`C_rel` |
| `gso-orthogonal-decomposition` | proposition / rigorous | Prop 4.3(i)：`H*_rel ≅ H*(P̄_+C_rel) ⊕ H*(P̄_−C_rel)` 为正交分解，等距由 `[ω] ↦ [P̄_+ω]+[P̄_−ω]` 给出 | `Proposition 4.3(i), pp.329–330` | Def 4.1 |
| `gso-projected-cohomology-dimension` | proposition / rigorous | Prop 4.3(ii)：`dim H^n(P̄_+C_rel) = 8p₀^{(8)}(−p·p/2)`（`n=0`），否则 0 | `Proposition 4.3(ii), p.329` | **`no-ghost-superstring` 的 Thm 2.4**（含 `p≠0`、`D=10`、半空间动量）、`Prop 4.2` |
| `gso-covariant-equivalence` | proposition / **physical-argument 或 definition-level** | NS 无快子且两扇区维数相等 ⇒ 作者称「achieved the "covariant" equivalent of the GSO projection」 | `p.330` | 上一条、`Corollary 2.15(i)` |

- **G-parity 的物理归属**：按 p.329 Remark，`(−1)^{U+κ}Ḡ_κ` = Terao–Uehara [15] / Ohta [13] 提出的 G-parity；**原始 GSO 截断归 [8] Gliozzi–Scherk–Olive**（`sources.bib` 目前**没有** GSO 条目，是干净的新增目标：Nucl. Phys. B122 (1977) 253–290）。
- ⚠ 上文 **E9 的表述需收紧**：E9 写「Definition 4.1：…；p.329 Remark 逐字：「The right-hand side is precisely…」」，中间缺了被指代的式子，按 7.2(1) 会被误读。E9 原文按规则不改，**以本节为准**。

### 7.8 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| LZ 1989 全文 PDF | `projecteuclid.org/download/pdf_1/euclid.cmp/1104179468` | ✅ 2.5 MB 落盘（此前只记了 `journalArticle/Download?urlId=` 端点，**`/download/pdf_1/` 这条同样有效且更短**） |
| 期刊 pp.328–333 | `Read(pages=28-33)` | ✅ 六页页图；`PDF 页 = 期刊页 − 300` |

---

## 8. ★ 参考文献表复核（2026-09-11，researcher 第三轮页图）——全 23 条逐字，重点 [8]/[13]/[15]

> 只追加，不改上文任何一行。触发（lead）：图里 GSO 的原始归属要挂 LZ 1989 的 **[8]**，而 Gliozzi–Scherk–Olive
> 有两篇易混文章（NPB **122** (1977) 253–290「dual spinor model」 vs PLB **65** (1976) 282–286「spinor dual model」），
> 此前**未裁决 [8] 指哪一篇**（见 `sources.bib` 的 GSO 相关 note 与 §7.5）。
> 取件：与 §7.8 同一文件（`projecteuclid.org/download/pdf_1/euclid.cmp/1104179468`，2.5 MB 扫描件）→ `Read(pages=34-35)`。
> **参考文献表在期刊 p.335 = PDF 第 35 页**（`PDF 页 = 期刊页 − 300`），单栏排版，全部可辨。证据等级 **L1**。

### 8.1 ★★★ 裁决：LZ 1989 的 **[8] = Gliozzi–Scherk–Olive, Nucl. Phys. B122 (1977) 253–290**

**逐字（p.335，第 8 条）：**

> 「 8. Gliozzi, F., Scherk, J., Olive, D.: Nucl. Phys. **B122**, 253–290 (1977)」

⇒ **是 NPB 122 (1977) 253，不是 PLB 65 (1976) 282。** 起止页 `253–290` 与 Crossref 记录（NPB 122(2) 253–290，
DOI `10.1016/0550-3213(77)90206-1`，报告号 CERN-TH-2253）**逐位一致**，无歧义。
⇒ §7.5 引的那句「They were first proposed by **Gliozzi, Scherk and Olive [8]** (GSO) in the "old covariant" formalism」
**确指 1977 年那篇 NPB**。图里/`sources.bib` 里新增 GSO 条目时，key 取 `gliozzi-scherk-olive-1977`（或按 key 规范 `gliozzi-1977`），
著录用 NPB 122 (1977) 253–290。
⚠ **但这只裁决了「LZ 的 [8] 是哪一篇」，没有裁决「GSO 投影是否真的首发于该篇」**——
后者的障碍仍是 **NPB 122 摘要里不出现 "projection"/"truncation"/"10"/"tachyon"/"chirality"**（L2 Crossref/INSPIRE 摘要），
即该归属目前**仍只靠 LZ 1989 p.328 这一条 L1 转引**，正文未取得。**不要把「[8] 的身份已定」误读成「归属已证实」。**

### 8.2 [13] Ohta 与 [15] Terao–Uehara 逐字

> 「13. Ohta, N.: Phys. Rev. **D33**, 681–1691 (1986)」
>
> 「15. Terao, H., Uehara, S.: Phys. Lett. **168B**, 70–74 (1986)」

- **[13] 的起页 `681` 复核属实，是原刊排印错误**（少印首位 `1`；真值 `1681–1691`，见 `ohta-1986.md` §0.3 的 OSTI 双源）。
  本轮为**第二次 L1 页图确认**，可视为定案：**凡转述 LZ 的引用串必须注明「LZ 印作 681，系误印」。**
- **[15] 逐字是 `Phys. Lett. 168B, 70–74 (1986)`**（旧式卷号写法 `168B`，不是 `B168`），页码 `70–74` 与
  `sources.bib` 的 `terao-uehara-1986`（PLB 168(1–2) 70–74，DOI `10.1016/0370-2693(86)91462-0`）一致。**无误印。**

### 8.3 顺带逐字取得的全表（同一页图，23 条；对图有用的都在此）

> 1. Brower, R. C., Friedman, K. A.: Phys. Rev. **D7**, 535–539 (1973)
> 2. Corrigan, E. F., Goddard, P.: Nucl. Phys. **B68**, 189–202 (1974)
> 3. Feigin, B. L., Fuks, D. B.: Funct. Anal. Appl. **16**, 114–126 (1982)
> 4. Feigin, B. L.: Usp. Mat. Nauk. **39**, 195–196 (1984) (English translation: Russ. Math. Surv. **39**, 155–156)
> 5. Frenkel, I., Garland, H., Zuckerman, G. J.: Proc. Natl. Acad. Sci. **USA 83**, 8446 (1986)
> 6. Friedan, D., Martinec, E., Shenker, S.: Nucl. Phys. **B271**, 93–165 (1986)
> 7. Friedan, D., Qui, Z., Shenker, S.: Phys. Lett. **151B**, 37–43 (1985)
> 8. Gliozzi, F., Scherk, J., Olive, D.: Nucl. Phys. **B122**, 253–290 (1977)
> 9. Kac, V.: Lecture Notes in Phys. vol. **94**. Berlin, Heidelberg, New York 1979
> 10. Kac, V., Wakimoto, M.: Proceedings of the Symposium on Conformal Groups and Structures. Lecture Notes in Phys. Berlin, Heidelberg, New York 1985
> 11. Kato, M., Ogawa, K.: Nucl. Phys. **B212**, 443 (1983)
> 12. Neveu, A., Schwarz, J. H.: Nucl. Phys. **B31**, 86 (1971)
> 13. Ohta, N.: Phys. Rev. **D33**, 681–1691 (1986)
> 14. Ramond, P.: Phys. Rev. **D3**, 2415 (1971)
> 15. Terao, H., Uehara, S.: Phys. Lett. **168B**, 70–74 (1986)
> 16. Witten, E.: Nucl. Phys. **B276**, 291–324 (1986)
> 17. Zuckerman, G. J.: Yale preprint (1988); to appear in the Proceedings of AMS Conference on Theta Functions, Bowdoin College (1987). Gunning, R., Ehrenpreis, L. (eds.).
> 18. Hilton, P. J., Stammbach, U.: A course in Homological algebra. Berlin, Heidelberg, New York: Springer 1970, Chap 7
> 19. Green, M. B., Schwarz, J. H., Witten, E.: Superstring theory, vol. 1, 1987
> 20. Jacobson, N.: Basic algebra. Volume II, New York: Freeman and Company 1980
> 21. Dixon, J. A., Taylor, J. C.: Nucl. Phys. **B78**, 552 (1974)
> 22. Meurman, A., Rocha, A.: Commun. Math. Phys. **107**, 263–294 (1986)
> 23. Leites, D. A.: Funct. Anal. Appl. **9**, 340–294 (1975)

**四条对图直接有用的读数：**

1. ★ **[5]（FGZ）的页码印作 `8446`，那是 FGZ 的*末页*不是起页**（真值 8442–8446，见 `sources.bib` 的 `fgz-1986`）。
   ⇒ **LZ 1989 的参考表在同一页上至少有两处页码误印（[5] 与 [13]）**，转述 LZ 的引用串时两处都要注明。
2. **[18] = Hilton–Stammbach, *A course in Homological algebra*, Chap 7** —— 这正是 §2 E3 里 `Theorem 3.3.1`
   自称「a good exposition is given in [18]」所指；[23] = Leites 是「see also」。⇒ **LZ 的超李代数同调正合序列的数学出处是标准同调代数教科书第 7 章**，
   可作该节点 `rigorous` 的旁证。
3. **[9] Kac LNP vol. 94 (1979) 与 [22] Meurman–Rocha CMP 107, 263–294 (1986) 分工明确**（见 p.318 Prop 2.18 证明逐字，§9.3）：
   `[7,9,10]` 给**幺正性**，**`[22]` 给（超 Virasoro 的）Kac 行列式公式**。
   ⇒ `brower-friedman-1973.md` / `sources.bib` 里记的「p.320 Remark 用的 Kac 行列式出处 [22] = Meurman–Rocha」**本轮复核无误**，且终页 `294` 确认。
4. **参考表里没有 Figueroa-O'Farrill–Kimura、没有 Henneaux、没有 Brower（单作者 1972）、没有 Goddard–Thorn 1972、没有 Schwarz 1972。**
   （[1] 是 **Brower–Friedman 1973**，不是 Brower 1972。）⇒ §3 记的「不引 Henneaux」**复核无误**；
   并新增一条：**LZ 1989 也不引玻色弦的 Goddard–Thorn**，其玻色弦对照组只有 **[5] = FGZ**。

⚠ **两条转录疑点（原刊排印，非扫描误读）**：
- **[7] 作者印作 "Friedan, D., **Qui**, Z., Shenker, S."** —— 通行拼写是 **Qiu**（Friedan–Qiu–Shenker, PLB 151B (1985) 37）。
- **[23] 页码印作 `340–294`**（起页大于终页，不可能）。真值未核（L0）；引用 Leites 时不要照抄这个页范围。
- **[10] 的 Lecture Notes in Physics 卷号在本行上未印出**（只有丛书名 + 地点 + 1985）。若需卷号须另查，**不得从 [9] 的 "vol. 94" 类推**。

### 8.4 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| LZ 1989 全文 PDF | `projecteuclid.org/download/pdf_1/euclid.cmp/1104179468` | ✅ 2.5 MB 落盘（第三次确认该端点可用） |
| 期刊 pp.334–335（参考表） | `Read(pages=34-35)` | ✅ 两页页图，参考表 23 条单栏全可辨 |

---

## 9. ★ `Corollary 2.15(i)` 与 `Corollary 2.19(iii)` 逐字复核 + 证明链（2026-09-11，researcher 第三轮页图）

> 只追加，不改上文 §2 E5/E6/E7 任何一行。触发（lead）：图里「量子化条件（维数公式）」与「`V(p,κ)` 是 `Vir_κ⁻`-free」
> 要各建一卡，需要逐字、页码与**原文明写的证明链**。
> 取件：与 §8.4 同一文件 → `Read(pages=16-21)`（期刊 pp.316–321）。证据等级 **L1**。

### 9.1 `Corollary 2.15` 逐字（期刊 **p.317**）——**E6 已有逐字，本轮「已核」，内容无更正**

> 「**Corollary 2.15.**
> (i) (*"Quantization Condition"*)
>   `dim H⁰_rel(p,κ) = ½(2κ + 1) dim R(p,κ) p_κ^{(8)}(κ − p·p/2)`.
> (ii) (*No-ghost Theorem*) `H⁰_rel(p,κ)` *is a positive definite space.*」

- **页码 p.317 复核无误**（E6 记的就是 p.317；同页下方紧跟 `Definition 2.16`、`Definition 2.17`，与 E7 的 p.317 起始一致）。
- **公式与 E6 逐字一致**，包括 `½(2κ+1)`、`dim R(p,κ)`、下标 `κ` 的 `p_κ^{(8)}`、自变量 `κ − p·p/2`。**不需要更正。**
- (i) 的引号内标题**原文就带引号**：`("Quantization Condition")`；(ii) 的 `(No-ghost Theorem)` **不带引号**。⚠ 两者排版不同，照抄时别统一。

### 9.2 ★ `Corollary 2.15` 的证明链逐字（p.317）——**两部分都只用 `Proposition 2.14(ii)`**

> 「*Proof.* (i) We recall the Euler–Poincaré Principle for characteristics:
> `Σ_{n∈Z}(−1)^n dim H^n_rel(p,κ) = Σ_{n∈Z}(−1)^n dim C^n_rel(p,κ)`.
> Thus by **Theorem 2.4**, the left-hand side gives `dim H⁰_rel(p,κ)` while the right-hand side is `char C_rel(p,κ)`.
> Hence (i) follows from **Proposition 2.14 (ii)**.
> (ii) Similarly, the Euler–Poincaré Principle for signature states that
> `Σ_{n∈Z} sign H^n_rel(p,κ) = Σ_{n∈Z} sign C^n_rel(p,κ)`.
> Again **Theorem 2.4** implies that the left-hand side `= sign H⁰_rel(p,κ)`, while the right-hand side is `sign C_rel(p,κ)`.
> Thus (ii) follows from **Proposition 2.14(ii) also**. □」

**四条读数（全部出自上面逐字）：**

1. **Cor 2.15(i) 的依赖 = `Theorem 2.4` + Euler–Poincaré 原理（特征标版）+ `Proposition 2.14(ii)`。**
   **Cor 2.15(ii) 的依赖 = `Theorem 2.4` + Euler–Poincaré 原理（号差版）+ `Proposition 2.14(ii)`。**
   ⇒ 与 §2 E6 记的「Euler–Poincaré 原理 + Theorem 2.4 + Prop 2.14(ii)」**完全一致，已核**。
2. ★ **`Proposition 2.14(i)`（`Q* = Q`）在 Cor 2.15 的证明里一个字都没被引用。**
   两部分都指向 **2.14(ii)**（那一条同时给出 `char C_rel` 与 `sign C_rel` 两个等式，见 §2 E5）。
   句末的 "**also**" 是内部佐证：作者明说第二次用的还是同一条。
   ⇒ **建边时不要从 Cor 2.15 拉一条到 `Prop 2.14(i)`**；`⟨,⟩_rel` 下 `Q` 的自伴性是 `sign H^n` 有定义的**背景条件**，
   但**原文没有把它列为依赖**，若 curator 要补这条边必须标 `inferred: true`。
3. **`p ≠ 0` 是经 `Theorem 2.4` 继承进来的**（Thm 2.4 逐字「Suppose p ≠ 0」，见 §2 E3），Cor 2.15 **自身语句里没有任何量词**。
   同理 `D = 10`（p.308「From now on, we will take D = 10」）与 `p` 落在半空间 `{p^D > 0}`（§6 复核-1）也都是全局前提。
4. 强度：**Corollary，证明完整且只有三行**——真正的工作量在 `Theorem 2.4`（消灭定理，§3 全章）与 `Proposition 2.14(ii)`（特征标/号差计算，pp.312–317）。
   p.335 结论逐字「The only mathematically non-trivial result is the vanishing theorem (2.4).」与此吻合。

### 9.3 `Proposition 2.18` 逐字（期刊 **p.318**）——E7 只有转述，本节补逐字

> 「**Proposition 2.18.** *There exists a subspace* `T(p,κ)` *of* `V(p,κ)^{Vir_κ^+}` (*i.e. elements annihilated by*
> `π(L_n), π(G_{n−κ}), n > 0`) *with*
> `ch_q T(p,κ) = dim R(p,κ) q^{p·p/2} φ_κ(q)^{−8}`.
> `T(p,½)` *is positive definite with respect to* `⟨,⟩_V`. `T(p,0)` *is a direct sum of two subspaces* `T^±` *of equal
> characteristics, where* `T^+` (*respectively* `T^−`) *is positive* (*respectively negative*) *definite with respect to* `⟨,⟩_V`.」

⚠ **下标读数注记**：`V(p,κ)^{Vir_κ^+}` 的括注是 `π(L_n), π(G_{n−κ}), n > 0`（**`n−κ`**），
而 `Definition 2.16`（p.317）的物理态条件是 `π(G_{n+κ})v = 0, n ≥ 0`（**`n+κ`**）。**两处符号不同是原文如此、且都自洽**
（κ=½ 时前者给 `G_{1/2}, G_{3/2}, …`、后者给 `G_{1/2}, G_{3/2}, …`；κ=0 时前者给 `G_1, G_2, …`（不含 `G_0`），后者含 `G_0`）。
**抄写时不要「统一」成同一个符号。**

**证明的输入（p.318 逐字，对图有用）：**

> 「*Proof.* Using the so-called spectrum generating algebra, physicists **[1, 2]** have constructed these spaces.
> However, we will prove their existence the way FGZ did in the bosonic case.
> It has been shown **[7, 9, 10]** that the Verma module of `M_κ(h,c)` over `Vir_κ` is non-unitary for `h < 0, c = 1`
> and unitary for `h > 0, c = 9`. By Kac's determinant **[22]** formula, for `h'' < 0` and `h' > 0`, `M_κ(h'',1)`, `M_κ(h',9)`
> have no (non-zero) proper **Z₂**-graded submodule. …」

⇒ 依 §8.3，**[1] = Brower–Friedman 1973、[2] = Corrigan–Goddard 1974**（谱生成代数的物理构造，LZ 明说自己**不走**这条路）；
**[7,9,10] = Friedan–Qiu–Shenker / Kac LNP 94 / Kac–Wakimoto**（幺正性）；**[22] = Meurman–Rocha CMP 107 (1986) 263–294**（超 Virasoro 的 Kac 行列式）。

### 9.4 ★★ `Corollary 2.19` 逐字（期刊 **p.320**）+ **(iii) 的证明链不经 `Proposition 2.18` 的陈述**

> 「**Corollary 2.19.**
> (i) `dim T ∩ 𝒫 = ½(2κ + 1) dim R(p,κ) p_κ^{(8)}(κ − p·p/2)`.
> (ii) `T ∩ 𝒫` *is positive definite with respect to* `⟨,⟩_𝒫`.
> (iii) `V(p,κ)` *is a free* `Vir_κ^-`*-module.*」

**证明逐字（p.320–321）：**

> 「*Proof.*
> (i) The case `κ = ½` is an immediate result of **Proposition 2.18**. Consider the case `κ = 0`. Clearly `T(p,0)` is left
> invariant by `π''(G₀) ⊗ 1`. But `{π(G₀), π''(G₀) ⊗ 1} = 2π''(G₀)² ⊗ 1 = p''·p''·Id_{T(p,0)}`. (39)
> This implies that in `T(p,0) ∩ Ker π(L₀)`, `T ∩ Ker π(G₀) = T ∩ Im π(G₀)`. (40)
> The left-hand side is `T ∩ 𝒫`. Thus by (40) and **Proposition 2.18**, we have
> `dim T ∩ 𝒫 = ½ dim R(p,0) p₀^{(8)}(−p·p/2)`. (41)
> (ii) Again the `κ = ½` case follows from **Definition 2.17** and **Proposition 2.18**. Let `κ = 0, n = −p·p/2`. Then one
> can check that `{π(G₀)1₊ ⊗ w_l(n)}_{l=1,…,dim T∩𝒫}` is basis of `T ∩ 𝒫`. By using **Definition 2.17**, and
> Eqs. **(27), (28), (31)**, we obtain `⟨π(G₀)1₊ ⊗ w_k(n), π(G₀)1₊ ⊗ w_l(n)⟩_𝒫 = δ_{k,l}`. (42)
> (iii) Equations **(24), (25)** imply that `V(p,κ)` is a direct sum of tensor products of free modules over `Vir_κ^-`.
> One can easily check that each of the tensor products is also `Vir_κ^-`-free. □」

**★★★ 对任务问题「2.19(iii) 经 Prop 2.18？」的直接回答：不经 `Proposition 2.18` 的*陈述*，只经其*证明内部*的两条显式方程。**

| Cor 2.19 的部分 | 原文明写引用的对象 |
|---|---|
| (i) | **`Proposition 2.18`（陈述）** + (39)(40) |
| (ii) | **`Definition 2.17`** + **`Proposition 2.18`（陈述）** + Eqs. (27)(28)(31) |
| **(iii)** | **只有 Eqs. `(24)`, `(25)`** —— **`Proposition 2.18` 这四个字在 (iii) 里不出现** |

- **`(24)`、`(25)` 印在期刊 p.319 的顶端，位于 `Proposition 2.18` 的证明体内**（该证明起于 p.318「*Proof.* Using the
  so-called spectrum generating algebra…」，止于 p.319 末尾 `(34)` 之后的 `□`）。p.319 引出它们的句子逐字是
  「Thus (i) to (iv) imply that we can express these spaces in terms of irreducible modules:」——
  其中 `(i)`–`(iv)` 是**该证明内部的编号步骤**，不是 Prop 2.18 陈述的分条。
- ⇒ **curator 注意**：若图里 `Prop 2.18` 的卡只承载其**陈述**（存在横向空间 `T` + 特征标 + 定号性），
  那么 `Cor 2.19(iii) → Prop 2.18` 这条边**在原文里不存在**；正确的边是
  `Cor 2.19(iii) → 「V(p,κ) 的不可约/Verma 分解 (24)(25)」`，而后者若无独立节点，
  只能写 `loc: §2, eqs. (24)–(25), p. 319（在 Prop 2.18 的证明内）` 并标 `inferred: true` 说明它取自证明而非陈述。
- ⇒ 顺着 (24)(25) 再往上，依赖落到 §9.3 引的那三组文献输入（**[7,9,10] 幺正性 + [22] 超 Virasoro Kac 行列式**），
  即 **`V(p,κ)` 的 `Vir_κ⁻`-freeness 最终建立在 Kac 行列式之上**，不是一条组合恒等式。

**(24)(25) 逐字（p.319，⚠ 下标字号极小，见下方可信度分层）：**

> 「`V(p'',κ) ≅ M_κ(p''·p''/2, 1)`,  (24)
> `V(p',κ) ≅ ⊔_{n∈(1/2)Z₊} p^{(8)}_{1/2}(n) M_{1/2}(p'·p'/2 + n, 9)`  *if* `κ = ½`
>   `≅ ⊔_{n∈Z₊} (a_n N₊(p'·p'/2 + n, 9) ⊕ b_n N₋(p'·p'/2 + n, 9))`  *if* `κ = 0`,  (25)
> *where* `a_n, b_n ∈ Z₊` *with* `a_n + b_n = 16 p₀^{(8)}(n)`.」

- **高可信**：(24) 右端是**一个 Verma 模** `M_κ(·, 1)`；(25) 是**直和分解**，κ=½ 用 `M_{1/2}(·, 9)`、κ=0 用两族 `N_±(·, 9)`；
  重数关系 `a_n + b_n = 16 p₀^{(8)}(n)`；两式的 `c` 值分别是 **1** 与 **9**（与 (23) `π''(c) = 1, π'(c) = 9` 一致）。
- **需复核**：`⊔` 的指标集（`(1/2)Z₊` vs `Z₊`）、`p''·p''/2` 与 `p'·p'/2` 的撇号归属。**凡把 (24)(25) 写进 `statement` 的，先请 auditor 用同一页图复核撇号。**

### 9.5 `Theorem 2.20` 证明末句的三条引用（p.321，顺带复核 §2 E8）

> 「…We note that `λ` maps `𝒫` into the cocycles `Z⁰_rel` and thus induces an isometric inclusion `𝒫/λ^{−1}B⁰_rel → H⁰_rel`,
> where `B⁰_rel` is the (zeroth) coboundaries. But `λ^{−1}B⁰_rel` is a subset of `rad 𝒫`. By **Corollary 2.19(ii)**,
> `T ∩ 𝒫 → 𝒫/rad 𝒫` is also an isometric inclusion. … Using **Corollary 2.15(i)** and **Corollary 2.19(i)**, we have the
> desired result. □」

⇒ §2 E8 记的证明链（Cor 2.19(ii) → Cor 2.15(i) + Cor 2.19(i) 维数相等）**复核无误**；映射逐字为
`λ(v) = v ⊗ |q_F = 1⟩ ⊗ |q_B = 1 − κ⟩, v ∈ 𝒫`（E8 写作 `|q_B = 1 − κ⟩`，一致）。
⇒ 因此 **`Theorem 2.20` 经 `Cor 2.19(i)(ii)` 间接依赖 `Prop 2.18`，但不经 `Cor 2.19(iii)`**——
(iii) 是喂给 **`Theorem 2.4`（消灭定理）的证明**（§3，见 §2 E3「用于 `Vir_κ^-` 与 `V(p,κ)` 自由性 Corollary 2.19(iii)」），
不是喂给 Thm 2.20 的。**两条路径不要合并成一条边。**

### 9.6 抽取者观察（**不是原文陈述**，留给 curator/auditor 裁决）

p.320 的 `Remark`（「`V(p,κ)` is in general **not** a direct sum of Verma modules of `Vir_κ` even though it is `Vir_κ^-`-free」）
与紧随其后的 `Cor 2.19(iii)` 证明（「(24), (25) imply that `V(p,κ)` is a direct sum of **tensor products** of free modules」）
**印在同一页、相距十余行**。两句的字面区别在 "direct sum of Verma modules" vs "direct sum of **tensor products of** free modules"。
**本记录不裁决二者如何相容**（那需要读懂 `V(p,κ) ≅ V(p'',κ) ⊗ V(p',κ)` 这条 canonical isometry 的具体含义，p.318 (iii) 附近）。
⚠ 但**引用时必须注意**：Cor 2.19(iii) 说的是 **free**，Remark 否定的是 **Verma 模直和**；
**把 (iii) 转述成「`V(p,κ)` 分解为 Verma 模直和」会与同页 Remark 直接冲突，且那正是与 FOK 1989 p.111 矛盾的那一点**（见 §4 Q1）。

### 9.7 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| 期刊 pp.316–318 | `Read(pages=16-18)` | ✅ Cor 2.15 全文 + Def 2.16/2.17 + Prop 2.18 陈述与证明首段 |
| 期刊 pp.319–321 | `Read(pages=19-21)` | ✅ (24)(25) + p.320 Remark + Cor 2.19 全文 + Thm 2.20 全文 + Lemma 3.1 |
| 期刊 p.317 单页重读 | `Read(pages=17)` | ✅ 专为确认 Cor 2.15 证明里两处都是 `Proposition 2.14(ii)`（"also" 为内部佐证） |
