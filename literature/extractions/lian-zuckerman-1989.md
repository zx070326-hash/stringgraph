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
