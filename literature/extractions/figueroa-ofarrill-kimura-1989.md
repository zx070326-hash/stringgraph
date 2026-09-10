# 抽取记录：figueroa-ofarrill-kimura-1989

- 文献：J. M. Figueroa-O'Farrill and T. Kimura, *The BRST cohomology of the NSR string: vanishing and "no-ghost" theorems*, Commun. Math. Phys. **124** (1989) 105–132
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文 28 页逐页读图（L1）**。获取途径：Project Euclid `https://projecteuclid.org/journalArticle/Download?urlId=cmp%2F1104179078`（免登录，2.6 MB）。
- 触发：为 `henneaux-1987` 找 L3 转述；结果它本身是超弦无鬼定理的独立严格来源，且**直接回应 curator 记的三处 βγ 差异**。

> 单位：ITP Stony Brook。Received October 4, 1988。Communicated by L. Alvarez-Gaumé。**参考文献只有 14 条；引 Henneaux [12]、Spiegelglas [3]、FGZ [1]、Brower–Friedman [11]，不引 Ohta、Kato–Ogawa、IMNU、Lian–Zuckerman。**

## 0. 证据等级与编号约定

全文 L1。**本文没有编号定理**（§2 的三条 "Theorem/Theorem'/Theorem''" 是引用的谱序列标准结果，无编号）；所有结果以**公式号**定位：(3.19)、(4.17)、(5.1)–(5.3)、(6.1)–(6.20)、(A.14)、(B.1)–(B.10)。

## 1. 约定

- NS 超 Virasoro (3.1)–(3.3)：`[l_m, l_n] = (m−n)l_{m+n} + (c/12)m(m²−1)δ_{m,−n}`；`{g_r, g_s} = 2l_{r+s} + (c/3)(r² − ¼)δ_{r,−s}`；`[l_n, g_r] = (n/2 − r)g_{r+n}`。**`c/12` 归一化**（与 LZ 的 `c/8` 不同）。R 扇区 (4.1)–(4.2) 同型。
- 鬼 Fock 空间中心荷 `c ↦ −15 Id`（p.111、p.115）；物质「with the opposite central charge (in the critical dimension)」——**D = 10 是假设，不推导**。
- 鬼数：NS 相对复形按整数分次；绝对复形「half-integrally graded」，上同调在 `±½`（(5.2)(5.3)）。
- 内积：附录 B 用自伴对合 `𝒞` 定义正定内积 `⟨ψ,φ⟩_𝒞 = ⟨ψ, 𝒞φ⟩`（(B.1)），并注明「Our ghost oscillators are not the natural ones but are unitarily related to them」（模展开 `b(σ) = b₀ + Σ√m(b_m e^{imσ} + b_{−m}e^{−imσ})` 等）。
- **零动量一律排除**：脚注 3（NS）、脚注 6（R）逐字「the vanishing theorem as it stands does not apply to the case where the center of mass momentum is zero. In this case the cohomology is again easy to compute explicitly」。

## 2. 陈述

### E1 NS 扇区相对复形消灭定理 (3.19)
- 位置：§3, p.114, (3.18)–(3.19)。
- 逐字：`H^m_∞(NS, L₀; H) ≅ H^{−m}_∞(NS, L₀; H)` (3.18)；「which gives the vanishing theorem for the relative subcomplex `H^{m≠0}_∞(NS, L₀; H) = 0` (3.19)」。
- 证明结构：相对子复形 (3.5) `{ω | L₀ω = b₀ω = 0}`（**注意 NS 只相对于 `L₀`、`b₀`**）；半整数过滤 (3.8)–(3.9)；谱序列 E₁ = Künneth (3.16)(3.17)；附录 A 的 `H^b_∞(NS_−; M) = 0, b ≠ 0`；Poincaré 对偶引自作者自己的预印本 [4]（ITP-SB-88-34）。
- 依赖：Brower–Friedman [11] 的完全可约性（p.111 逐字「It was proven by Brower and Friedman [11] that this representation is fully reducible」）—— **与 LZ 1989 p.320 Remark 矛盾**，见 `lian-zuckerman-1989.md` Q1。

### E2 R 扇区：两种零模表示（§4 p.115–116）
- 位置：p.115–116。
- 逐字（p.106）：「In fact there has not appeared in the literature a unique treatment of these zero modes and thus we treat them in two different ways. The cohomologies turn out to be isomorphic although one of them does not admit a grading by ghost number.」
- **Schrödinger 表示**（p.115）：`𝒦 = L²(R, dx)`，`β₀ = x·`，`γ₀ = i d/dx`；`β₀` 无本征值 ⇒ 不能施加 `β₀ω = 0`，只能相对 `L₀`；鬼数算子 `½((a†)² − a²)` 无本征值 ⇒ **上同调无鬼数分次**（p.120）。
- **Henneaux 表示**（p.116，小节标题 "The Henneaux Representation"）：`𝒦 = C[γ₀]`，`γ₀` 生成、`β₀` 湮灭，`β₀`、`γ₀` 互为伴随；可相对 `R₀ = L₀ ⊕ F₀`；**缺点**逐字「Changing the hermiticity properties of γ₀ and β₀ changes the hermiticity properties of the BRST operator: it is no longer hermitian.」
- 备注：这是 curator「βγ 不等价真空」问题在文献里最直接的处理。

### E3 R 扇区相对复形消灭定理 (4.17)（Henneaux 表示）
- 位置：p.117–118。
- 逐字：`H^{m≠0}_∞(R, R₀; H) = 0` (4.17)。
- 证明结构：双复形 (4.10)–(4.13)（横向 `Q`、纵向 `F₀` 的 cochain 微分 δ）；纵向上同调平凡（p.118 逐字「This space, however, turns out to be trivial [12]. In fact, one can⁹ define an operator K such that {F₀, K} = 1.」；脚注 9：仅 `p ≠ 0`）；两条谱序列合并得 (4.14) `H_D ≅ H^m(C^{F₀})` 与 (4.16)。
- 依赖：Henneaux [12]（`F₀` 上同调平凡）；附录 A；Poincaré 对偶 [4]。

### E4 两种表示的相对上同调同构 (5.1)、绝对复形的上同调 (5.2)(5.3)
- 位置：p.120–123。
- (5.1) 逐字：`H_∞(R, L₀; H) ≅ H_∞(R, R₀; H)`（**只作为无分次空间**，p.120「the isomorphism is only an isomorphism of ungraded vector spaces」）；证明 p.121–122 用 `γ₀` 多项式归约 (5.4)–(5.7)。
- (5.2) `H^n_∞(NS; H) ≅ H⁰_∞(NS, L₀; H)` for `n = ±½`, 0 otherwise；(5.3) R 扇区同型（Henneaux 表示）。p.121 逐字：「the rather surprising fact that the BRST cohomology of the Ramond sector has the same finite degeneracy as the one of the Neveu-Schwarz sector despite the fact that at the level of cochains the Ramond sector is infinitely degenerate due to the existence of the zero modes for the superconformal ghosts.」
- 证明 (5.3)：`Q = Q̂ + b₀𝒯`，`𝒯 = −2(T + ½γ₀²)` (5.10)，三重分次 (5.11)，双复形 (5.13)，谱序列在 E₁ 塌缩 (5.14)。Koszul [14] 的谱序列作为替代路线被提及 (5.8)(5.9)。

### E5 ★ "No-ghost" 定理（§6）
- 位置：p.123–128。
- 方法（p.123 逐字）：「we prove the "no-ghost" theorem for the NSR string along the lines suggested in [4]. This method was used to prove the similar result for the bosonic string in [1] and [3].」判据 (6.1) `Tr_{H₀} 𝒞 ≤ dim H₀`，饱和 ⟺ 正定；化为迹恒等式 (6.5) `Tr_{C_∞} q^L 𝒞 ≤ Tr_{C_∞} q^L (−1)^𝒢`。
- **NS**：(6.14) `Tr_{C_∞}(−1)^𝒢 q^L = Π(1−qⁿ)^{−8} × Π(1+q^r)^8`；(6.15) `Tr_{C_∞} 𝒞 q^L` 同值 ⇒「hence proving the "no-ghost" theorem for the Neveu-Schwarz sector」。
- **R（Henneaux 表示）**：(6.19) = (6.20) = `Π((1+qⁿ)/(1−qⁿ))^8` ⇒「hence proving the "no-ghost" theorem」。
- **R（Schrödinger 表示）**：p.128 一段：`Q` 厄米 ⇒ 上同调内积良定；取 `T ψ = 0` 的代表元，归一化零模空间内积使 `‖ψ ⊗ 1‖ = ‖ψ‖`，再由 Henneaux 表示的结果得正定。
- 脚注 11：「As it stands this next equation is ill-defined since H₀ is infinite dimensional. These quantities are to be understood as weighted traces」。
- **GSO**：p.128 逐字「we remark that the GSO projected NSR string is also free of ghosts. … We leave the details of this calculation as an exercise.」

### E6 附录 A（超李代数同调消灭）与附录 B（正定内积）
- (A.14)：`H^m(𝒞_∞(S_−; M)) = 0 if m ≠ 0`，`S_−` 为 NS 或 R 的负模超代数，`M` Verma 模；脚注 12「this theorem holds for any superalgebra with values in a free module but we shall omit the general proof」。p.106 逐字「We have never seen a published proof of this theorem, although Fuks [2] hints that it is a straightforward generalization」。
- (B.1)–(B.10)：对合 `𝒞` 的显式定义（`𝒞c_n𝒞 = b_n` 等）；p.132 逐字「To show that the new inner product defined by (B.1) is indeed positive-definite is completely straightforward and is left as an exercise for the reader.」p.132 关于零模：「following Henneaux [12], we can treat them as annihilation and creation operators, in which case β₀ and γ₀ are mutual adjoints. It is interesting to remark that in this case there is no self-adjoint involution 𝒞 which yields this adjointness property」。

## 3. 作者自承的缺口（供 gaps 字段）

1. 完全可约性引 Brower–Friedman：NS「It was proven」；R 逐字「Brower and Friedman **claim** to have proven full reducibility of this representation, although they do not write down the explicit spectrum generating algebra」（p.115）。
2. 超李代数同调定理无已发表证明，附录 A 只补特例（p.106）。
3. (B.1) 正定性「left as an exercise」（p.132）。
4. Poincaré 对偶与判据 (6.1) 外包给作者预印本 [4]（ITP-SB-88-34 (revised)）——**未见其发表版**（Dedushenko [19] 引 FOK 的 PLB 219, 273 (1989) "Some results on the BRST cohomology of the NSR string"，可能即 [4]/[13] 的发表版，L4）。
5. 零动量排除（脚注 3、6、9）。
6. GSO 后无鬼「as an exercise」。

## 4. 未解决的疑问

- Q1：与 LZ 1989 关于「V 是否 Verma 模直和」的矛盾（见 `lian-zuckerman-1989.md` Q1）。
- Q2：[4] 与 [13] 两份 Stony Brook 预印本的发表出处。
- Q3：(6.8) 玻色弦部分「essentially the "no-ghost" theorem for the bosonic string … away from the critical dimension」——此处 D = 10 算的是 8 个横向，其上同调意义 FOK 自己说「has no cohomological significance」。

## 5. 对图的建议

- 作为 `no-ghost-theorem-superstring` 的**第二条独立 rigorous derivation**（与 LZ 1989 互不引用）。loc 用公式号：NS (3.19)+(6.14)/(6.15)；R (4.17)+(6.19)/(6.20)+p.128。
- gaps 抄 §3 六条；其中第 1 条与 LZ 的矛盾要点名。
- 「R 扇区两种表示相对上同调同构 (5.1)」值得单独建卡——它就是 curator「βγ 不等价真空」问题的定理级回答（限 `p ≠ 0`、限这两种表示）。
- 引用时鬼数写相对值（FOK ±½ vs LZ −1,0,1 vs Dedushenko (A+1)±½）。
