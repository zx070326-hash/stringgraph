# 抽取记录：bhand-sen-singh-2025-single-centered

- **文献**：Ajit Bhand, Ashoke Sen, Ranveer Kumar Singh, *"Generating Function of Single Centered
  Black Hole Index from the Igusa Cusp Form"*, arXiv:**2510.05219** [hep-th, math.NT], v1,
  提交 2025-10-06 18:00:46 UTC，38 页 3 图。**无 journal-ref、无 DOI（截至 2026-09-23 查询）**。
- **抽取者**：researcher（lead 指派：查清 2510.05219 是什么，判定与
  `research/papers/torsion-dyon-shift-positivity/paper.md` 有无重叠；对应该论文
  `NOTES-for-captain.md` §4.5 的未闭缺口）。
- **日期**：2026-09-23
- **证据等级**：**L1** —— 直接 `curl -sL https://arxiv.org/pdf/2510.05219v1` 下载官方 PDF
  （930645 字节，`pdfinfo` 报 38 页，Creator "arXiv GenPDF"），用 Read 工具按页渲染**页面图像**
  逐字核对 p.1–7、p.28–29、p.36–38（印刷页 −1−…−5−、−27−…−28−、−35−…−37−）；
  关键式 (1.11)/(1.12)/(1.14)–(1.21) 另用 `pdftoppm -r 300` 渲染并裁剪放大复核。
  元数据（标题/作者/日期/摘要/分类/comment）来自 `export.arxiv.org/api/query?id_list=2510.05219`
  的 Atom feed，并与 PDF 首页图像交叉核对一致。
  全文 `pdftotext` 仅用于**导航与否定检索**，一切判据性引文均以页面图像为准（遵项目硬纪律）。
- **覆盖范围**：p.1（题名页/摘要）、印刷页 1–5（§1 Introduction and summary，含全部 6 条结果
  清单与 (1.1)–(1.30)）、§2 开头（(2.1)–(2.12)）、§5 开头（Thm 5.1/5.2 陈述）、§5.4 结尾
  ((5.40)–(5.45) + 致谢)、References 全 26 条。
  **未覆盖（只做关键词否定检索，未逐页读图）**：§3、§4 的收敛性证明主体（印刷页 11–27）、
  §5.1–§5.3 的证明细节（印刷页 29–34）。这些是解析估计，与本次判定问题无关。见 Q5。

---

## 0. 一句话结论（本次任务的裁定）

**无重叠。** 2510.05219 是 Bhand–Sen–Singh 关于**挠一（torsion one）**单心黑洞指标**生成函数**
`F(Ω)` 的解析性质论文：把 1/Φ₁₀ 减去双心黑洞贡献的生成函数，证明所得 F̃(Ω) 在 det Im Ω > 1/4
上无奇点、绝对收敛、PSL(2,ℤ) 不变，并确定其亚纯延拓的极点。

它**不含**任务书列出的四条中的任何一条，**不含** adapted frame / Q ∈ IΛ 判据、**不含**格论字典
(L ⊆ M、I = [M:L])、**不含**类数判据、**不含** DGM eq(51)/(52) 的任何讨论——它**根本不引用**
DGM 0803.2692。全文 "torsion" 一词只出现 **1 次**，就是把讨论范围限死在挠一（见 E2）。

唯一的实质接触点是 **E4**：其 (1.16)–(1.17) 就是 `paper.md` **Appendix A Proposition A.1**
（d_* 是 GL(2,ℤ) 类函数）的同一陈述，且用同一条围道协变论证得出。详见下"对 paper.md 的影响"。

---

## 约定

- 理论：heterotic on T⁶ × ℝ^{3,1}（与 `paper.md` 的 type II on K3×T² 由弦-弦对偶等价，
  同一 Γ^{6,22} 电荷格）。
- Siegel 变量记号（印刷页 2，(1.6)(1.7)，逐字）：

  ```
  Ω := ( τ  z )        T := (  m   ℓ/2 )
       ( z  σ ) ,            ( ℓ/2   n  ) ,
  ```

  "and use Ω to label the variables (τ, σ, z) and T to label the charges (m, n, ℓ)."
  ⚠ 与 `paper.md`（跟 Rosselló）用 Ω = [[ρ,v],[v,σ]] 不同：BSS 用 **τ** 占左上角、**z** 占非对角。
  与已登记的 `bhand-sen-singh-2023`（2311.16252）**同一套字母**（τ/σ/z），见该抽取记录。
- 电荷不变量 (1.2)，逐字：`m := Q²/2, n := P²/2, ℓ := Q · P, m, n, ℓ ∈ ℤ`。
  ⚠ 注意 **m ↔ Q²/2**，与 `paper.md` §2 的 `(m,n,ℓ) = (Q²/2, P²/2, Q·P)` 一致
  （与 `bhand-sen-singh-2023` 2311.16252 的 Q↔P 互换约定**不同**，见该记录 footnote 10 条）。
- 无 α'/号差问题（纯模形式与围道）。

---

## 陈述

### E1 标题 / 作者 / 日期 / 摘要（逐字）

- **位置**：PDF p.1（题名页，页面图像核对）；元数据另见 arXiv Atom feed。
- **类型**：metadata。
- **逐字**：

  > **Generating Function of Single Centered Black Hole Index from the Igusa Cusp Form**
  >
  > Ajit Bhand^a, Ashoke Sen^b, Ranveer Kumar Singh^c
  > ^a Department of Mathematics, Indian Institute of Science Education and Research Bhopal
  >   Bhopal bypass, Bhopal 462066, India
  > ^b International Centre for Theoretical Sciences - TIFR, Bengaluru - 560089, India
  > ^c NHETC and Department of Physics and Astronomy, Rutgers University, 126 Frelinghuysen Rd.,
  >   Piscataway NJ 08855, USA
  > E-mail: abhand@iiserb.ac.in, ashoke.sen@icts.res.in, ranveersfl@gmail.com
  >
  > **Abstract:** We introduce manifestly duality invariant generating function of the index of
  > single centered black holes in the heterotic string theory compactified on a six dimensional
  > torus. This function is obtained by subtracting, from the inverse of the Igusa cusp form, the
  > generating function of the index of two centered black holes constructed from the Dedekind eta
  > function. We also study the analytic properties of this function in the Siegel upper half plane.

- **元数据（Atom feed 逐字字段）**：
  - `<id>` `http://arxiv.org/abs/2510.05219v1`
  - `<published>` / `<updated>` 均为 `2025-10-06T18:00:46Z`（**只有 v1，无后续版本**）
  - `<category>` `hep-th`（primary）、`math.NT`
  - `<arxiv:comment>` `38 pages, 3 figures`
  - 无 `<arxiv:journal_ref>`、无 `<arxiv:doi>`
- **目录（逐字）**：
  1 Introduction and summary (1)；2 Construction of the generating function F̃(Ω) (5)；
  3 Analysis of the generating function F(Ω) (11)；4 Convergence of F̃(Ω) (13)
  [4.1 Convergence of 𝓕₁ (15)；4.2 𝓕₂ (16)；4.3 𝓕₃ (19)]；
  5 Properties of F̃(Ω) (28) [5.1 Proof of Theorem 5.1 (29)；5.2 Thm 5.2 (32)；
  5.3 Thm 5.3 (33)；5.4 Thm 5.4 (33)]。**无第 6 节，无附录。**

### E2 ★ 全文只讨论挠一（torsion one）——决定性的否定证据（逐字）

- **位置**：印刷页 1（PDF p.2），§1 第一段末 + eq (1.1)。
- **类型**：hypothesis / scope restriction。
- **逐字**：

  > "The black holes in heterotic string theory on T⁶ × ℝ^{3,1} are labeled by a 28 dimensional
  > electric charge vector Q and a 28 dimensional magnetic charge vector P. **However, for torsion
  > one dyons, for which**
  >
  >   gcd{Q_i P_j − Q_j P_i} = 1 ,   (1.1)
  >
  > the index is a function of only three quadratic combination of charges which we shall denote by
  > Q², P² and Q · P [5, 6]."

- **文献自称的严格程度**：这是全文的工作假设（"for torsion one dyons"），不是定理。
- **否定检索（L1 导航层，全文 `pdftotext` 4386 行）**：字串 **"torsion" 在全文只出现这一次**。
  以下字串**零次出现**：`divisor`（除子和意义上）、`class number`、`saturat`、`superlattice`、
  `congruence`、`Γ⁰(` / `Gamma^0` / `Γ₀(`、`adapted`、`Smith normal`。
  （(2.11) 附近确有 "positive definite quadratic form"，但指的是 σ̃₁, τ̃₁ 的**实**二次型，
  与二元整二次型的类无关。）
- **备注**：论文自己在印刷页 5 末明确圈定范围，逐字：
  > "While the analysis of this paper is restricted exclusively to the index of quarter BPS black
  > holes in heterotic string theory compactified in T⁶, results similar to the ones described in
  > (1.3), (1.11) are also known to hold for more general class of string compactifications with
  > sixteen unbroken supersymmetries [4, 20–24]. We expect that even in these general class of
  > theories we should be able to define the generating function for single centered black hole
  > index and prove their convergence. We leave this for future work."
  ——"future work" 指的是**推广到更一般的十六超荷紧化（CHL 等）**，**不是**推广到挠 I>1。

### E3 全指标与吸引子围道的定义 (1.3), (1.10)–(1.12)（逐字）

- **位置**：印刷页 1–2（PDF p.2–3）。
- **类型**：definition（作者把 (1.11) 归给 [9] = Cheng–Verlinde 0706.2363）。
- **逐字**：

  ```
  d(m, n, ℓ) = (−1)^{ℓ+1} ∫_𝒞 dτ dσ dz e^{−2πi(mτ+nσ+ℓz)} 1/Φ₁₀(τ, σ, z) ,        (1.3)

  m ≥ 0,   n ≥ 0,   4mn − ℓ² ≥ 0 ,                                              (1.10)

  d̃*(m, n, ℓ) = { (−1)^{ℓ+1} ∫_{𝒞_{m,n,ℓ}} dτ dσ dz e^{−2πi(mτ+nσ+ℓz)} 1/Φ₁₀(Ω) ,
                      for m ≥ 0, n ≥ 0, 4mn − ℓ² ≥ 0 ,
                  { 0 ,   otherwise ,                                            (1.11)

  𝒞_{m,n,ℓ} :  τ₂ = 2n/ε,  σ₂ = 2m/ε,  z₂ = −ℓ/ε,   0 ≤ τ₁, σ₁, z₁ < 1 .        (1.12)
  ```

  前置正文逐字：
  > "there is a special chamber in the (τ₂,σ₂,z₂) space, known as the attractor chamber, where the
  > contribution from two centered black holes vanish and we get single centered black hole index
  > d*(m,n,ℓ) carrying charges (m,n,ℓ). The precise expression for d*(m,n,ℓ) is [9]"

- **⚠ 印刷疑点（见 Q1）**：这段正文说的是 `d*`，但紧随的 (1.11) **左端印的是带波浪号的 `d̃*`**
  （300 dpi 放大复核确认波浪号存在）。而 `d̃*` 在 (1.21) 另有定义（= d − d^two），
  两者相等是本文自己的 **Theorem 5.4**。故 (1.11) 的波浪号应为排印错误。
- **备注（与 `paper.md` 的围道对照）**：(1.12) 给出
  Im Ω = (2/ε)·[[n, −ℓ/2],[−ℓ/2, m]] = (2/ε)·adj(T)。
  `paper.md` §2 的 `C_*` 取 `Im Ω = 2Λ·adj(T)`。**两者是同一处方，Λ ↔ 1/ε。**
  BSS 用 1/Φ₁₀(Ω) 配前因子 (−1)^{ℓ+1}；`paper.md` 用 𝒢 = −1/Φ₁₀(ρ,σ,v+1/2) 把符号吸进半周期移位。

### E4 ★ 与 `paper.md` Appendix A 同陈述：d*(T) 的 SL(2,ℤ) 不变性 (1.14)–(1.18)（逐字）

- **位置**：印刷页 3（PDF p.4）。
- **类型**：proposition（论文自称 "It follows from (1.14) and the identities … that"，**不给独立证明**，
  当作直接推论叙述）。
- **逐字**：

  ```
  d*(T) = { (−1)^{T₁₂+1} ∫_{Im Ω = 2γ₀^t T γ₀ / ε} d³(Re Ω) e^{−2πi Tr(ΩT)} 1/Φ₁₀(Ω) ,  for T ≥ 0 ,
          { 0 ,  otherwise ,                                                            (1.14)

  where T ≥ 0 means that T has non-negative eigenvalues and,

  γ₀ := ( 0  −1 )
        ( 1   0 ) .                                                                     (1.15)

  It follows from (1.14) and the identities

  Φ₁₀(γΩγ^t) = Φ₁₀(Ω),  γγ₀γ^t = γ₀,  γ^t γ₀ γ = γ₀ ,  d³(Re Ω) = d³(Re γΩγ^t) ,
                                                          for γ ∈ PSL(2, ℤ),            (1.16)

  that d* is invariant under an SL(2, ℤ) transformation:

  d*(γ^t T γ) = d*(T),   γ ∈ SL(2, ℤ) .                                                 (1.17)

  For γ = ( a  b )  the transformation T ↦ γ^t T γ takes the form:
          ( c  d )

  ( m )      (      a²m + c²n + acℓ        )
  ( n )  ↦   (      b²m + d²n + bdℓ        ) .                                          (1.18)
  ( ℓ )      ( 2abm + 2cdn + (ad + bc)ℓ    )
  ```

- **文献自称的严格程度**：**"It follows from (1.14) and the identities (1.16) that …"** ——
  推论式陈述，无编号定理、无独立证明段。论文把 (1.14)（等价于 (1.11)）本身归给 [9]。
- **文献列出的依赖**：[9] = M. C. N. Cheng, E. Verlinde, *Dying Dyons Don't Count*, JHEP 09 (2007) 070,
  arXiv:0706.2363（(1.11) 的出处）；(1.16) 的四条恒等式无引用，当作已知。
- **⚠ 关键对照**：γ₀^t T γ₀ = adj(T)（直接计算：γ₀^t = [[0,1],[−1,0]]，
  γ₀^t T γ₀ = [[n, −ℓ/2],[−ℓ/2, m]]）。所以 (1.14) 与 `paper.md` §2 的 `C_*` 完全同构，
  (1.16)–(1.17) 与 `paper.md` **Appendix A Prop A.1** 的陈述与论证路线**逐条对应**：
  Φ₁₀ 的 Sp(4,ℤ) 不变性、围道的 adj 协变律、测度 d³(Re Ω) 的不变性。
  **区别**：`paper.md` 的 𝒢 带半周期移位 v ↦ v+1/2，其 Appendix A 因此需要额外论证
  "A·(half-period)·A^T = (integer symmetric matrix) modulo the half-period itself"（该步在
  `paper.md` 里只用一句话带过）；BSS 把符号写成显式前因子 (−1)^{T₁₂+1}，**绕开了这一步**。

### E5 单心指标的生成函数与其"显然对偶不变" (1.19)–(1.22)（逐字）

- **位置**：印刷页 3–4（PDF p.4–5）。
- **类型**：definition + 条件式 proposition（"If we can prove the absolute convergence of F, then…"）。
- **逐字**：

  ```
  F(Ω) = Σ_{m,n,ℓ∈ℤ} d*(m,n,ℓ) (−1)^{ℓ+1} e^{2πi(mτ+nσ+ℓz)}
       = Σ_T (−1)^{2T₁₂+1} d*(T) e^{2πi Tr(ΩT)} .                        (1.19)

  F(γΩγ^t) = F(Ω) .                                                       (1.20)

  d̃*(m,n,ℓ) = d(m,n,ℓ) − d^two(m,n,ℓ) ,                                   (1.21)

  F̃(Ω) = Σ_T (−1)^{2T₁₂+1} d̃*(T) e^{2πi Tr(ΩT)} .                        (1.22)
  ```

  正文逐字："If we can prove the absolute convergence of F, then it follows from (1.19) and (1.17)
  that F(Ω) is also SL(2, ℤ) invariant."
- **备注**：这是摘要里 "manifestly duality invariant generating function" 的确切含义——
  **挠一的、把 SL(2,ℤ) 作用在 Ω 上的生成函数级不变性**。它**不是**"挠 I 除子和的 S-对偶不变化身"。
  与 `paper.md` Problem 9.1 提出的候选 `𝔇(L) := Σ_{L⊆L'⊆M} [L':L]·d_*(T_{L'})` 是**不同的对象**
  （后者是对固定电荷格 L 的中间格求和、挠 I≥1、是电荷格的函数；前者是全体 T 的 Fourier 级数、挠一）。
- **F̃(Ω) 的显式表达式**：(1.23)（印刷页 4），是 1/Φ₁₀(Ω) 减去三个由 η(τ)^{−24} 的系数 f_p、
  Heaviside 函数 H 与 PSL(2,ℤ)/G_r 陪集和构成的项。其中 (1.25) 逐字：
  `η(τ)^{−24} = Σ_{p=−1}^{∞} f_p e^{2πipτ}`，`f_+(τ) = Σ_{p=0}^{∞} f_p e^{2πipτ}`。
  (1.26) `G_r` 是由 [[0,−1],[1,−r]] 生成的循环群。**这些陪集和与任何除子和 Σ_{s|I} 无关。**

### E6 本文自列的六条结果（逐字，印刷页 4–5）

- **位置**：PDF p.5–6。
- **类型**：results summary。
- **逐字**：

  > 1. In Section 3, we show that d*(m, n, ℓ) defined in (1.11) is unambiguous even when T has a zero
  >    eigenvalue and when a pole falls on the contour 𝒞_{m,n,ℓ} since the residue at the pole vanishes.
  > 2. In Section 3, we also argue that the sum over m, n, ℓ in (1.19) converges absolutely and
  >    uniformly on compact subsets of the domain det Im Ω > 1/4. As a result F(Ω) is analytic for
  >    det Im Ω > 1/4.
  > 3. In Section 4, in Theorem 4.1, we show that the sum over a, b, c, d, r in each of the terms in
  >    (1.23) converges absolutely and uniformly on compact subsets of ℍ₂ except on the subspaces
  >    [(1.28)].
  > 4. In Theorem 5.1, we show that on the subspaces (1.28) the sums in (1.23) have poles. In theorem
  >    5.2 we show that these poles precisely cancel the poles of 1/Φ₁₀(Ω) at (1.28).
  > 5. In Theorem 5.3, we show that despite the presence of the Heaviside functions in its definition,
  >    F̃(Ω) admits a meromorphic continuation to ℍ₂ with double poles at [(1.29)]. … The behaviour at
  >    these poles coincide with those of 1/Φ₁₀(Ω). However 1/Φ₁₀(Ω) has additional poles for n₂ = 0
  >    which are absent in F̃(Ω).
  > 6. In Theorem 5.4, we show that the two different definitions of single centered index and their
  >    generating functions coincide:  d*(T) = d̃*(T) ∀ T,  F(Ω) = F̃(Ω) ,   (1.30)
  >    including contributions from states where T has a negative eigenvalue. This agrees with the
  >    analytical arguments of [10] and numerical results of [12]. …

- **§5 开头的定理陈述（印刷页 28，读图核对）**：
  **Theorem 5.1** 陈述 S(Ω)（即 (1.23) 中被减去的三项之和）"is a meromorphic function on ℍ₂ with
  double poles at (5.2)"；**Theorem 5.2**（逐字）："F̃(Ω) does not have any singularity in the region
  det Im Ω > 1/4."
- **备注**：六条全是**解析性质**（无歧义性、收敛性、极点抵消、亚纯延拓、两种定义相等）。
  没有一条涉及格论、除子和、挠 I>1。

### E7 ★ 与 `paper.md` Problem 9.5 的相邻性：mock Jacobi 形式的"限制"（逐字）

- **位置**：印刷页 5（PDF p.6），紧接 E6 第 6 条之后。
- **类型**：remark（转述已有文献 + 本文的对比陈述）。
- **逐字**：

  > "It is known that for fixed m, the coefficients d*(m, n, ℓ) can be identified as Fourier
  > coefficients of a mock Jacobi form of index m [14], **albeit with some restrictions on m, n, ℓ**
  > [15, 16]. In contrast d*(m, n, ℓ) are the Fourier coefficients of F(Ω) with no exceptions.
  > F(Ω) has PSL(2, ℤ)-invariance but does not have the full Sp(2, ℤ) invariance. It is tempting to
  > speculate that F(Ω) is closely related to a mock Siegel modular form [17–19], although it is not
  > known at present if we can add appropriate non-holomorphic part to F(Ω) to construct a harmonic
  > form for Sp(2, ℤ)."

- **文献列出的依赖**：[14] = DMZ 1208.4074；[15] = Bhand–Sen–Singh 2311.16252（本项目已抽取为
  `bhand-sen-singh-2023`）；[16] = N. Banerjee, V. Bhutra, R. K. Singh, arXiv:2505.17182。
- **备注（不是重叠，但值得转达）**：`paper.md` **Problem 9.5** 问的正是
  "d_*(m,n,ℓ) = (−1)^{ℓ+1} c_m^F(n,ℓ) 在 Gauss 约化域之外是否成立"，并给出反例 (5,1,4) vs (1,1,0)。
  本段是文献对**同一类现象**的自承（"albeit with some restrictions on m,n,ℓ"），归给 [15][16]。
  这是 Problem 9.5 该查的文献线索，**不是**对 Problem 9.5 的解答（BSS 未给出该限制的具体形状，
  只说"有限制"并把细节外包给 [15][16]）。

### E8 参考文献全表（逐字，印刷页 35–37，页面图像逐条核对）

- **位置**：PDF p.36–38。
- **类型**：bibliography（用于"是否引用 DGM 0803.2692"的否定判定）。
- **全 26 条**：
  [1] Dijkgraaf–E. Verlinde–H. Verlinde, *Counting dyons in N=4 string theory*, Nucl. Phys. B484 (1997) 543–561, hep-th/9607026.
  [2] Shih–Strominger–Yin, *Recounting Dyons in N=4 string theory*, JHEP 10 (2006) 087, hep-th/0505094.
  [3] G. Lopes Cardoso–B. de Wit–J. Kappeli–T. Mohaupt, *Asymptotic degeneracy of dyonic N = 4 string states and black hole entropy*, JHEP 12 (2004) 075, hep-th/0412287.
  [4] David–Sen, *CHL Dyons and Statistical Entropy Function from D1-D5 System*, JHEP 11 (2006) 072, hep-th/0605210.
  [5] Dabholkar–Gaiotto–Nampuri, *Comments on the spectrum of CHL dyons*, JHEP 01 (2008) 023, hep-th/0702150.
  [6] **Banerjee–Sen**, *Duality orbits, dyon spectrum and gauge theory limit of heterotic string theory on T\*\*6*, JHEP 03 (2008) 022, **arXiv:0712.0043**.
  [7] Sen, *Walls of Marginal Stability and Dyon Spectrum in N=4 Supersymmetric String Theories*, JHEP 05 (2007) 039, hep-th/0702141.
  [8] Sen, *Two centered black holes and N=4 dyon spectrum*, JHEP 09 (2007) 045, arXiv:0705.3874.
  [9] Cheng–E. Verlinde, *Dying Dyons Don't Count*, JHEP 09 (2007) 070, arXiv:0706.2363.
  [10] Sen, *Negative discriminant states in N=4 supersymmetric string theories*, JHEP 10 (2011) 073, arXiv:1104.1498.
  [11] Chowdhury–Lal–Saha–Sen, *Black Hole Bound State Metamorphosis*, JHEP 05 (2013) 020, arXiv:1210.4385.
  [12] Chowdhury–Kidambi–Murthy–Reys–Wrase, *Dyonic black hole degeneracies in N = 4 string theory from Dabholkar-Harvey degeneracies*, JHEP 10 (2020) 184, arXiv:1912.06562.
  [13] Lopes Cardoso–Nampuri–Rosselló, *Arithmetic of decay walls through continued fractions…*, JHEP 03 (2021) 154, arXiv:2007.10302.
  [14] Dabholkar–Murthy–Zagier, *Quantum Black Holes, Wall Crossing, and Mock Modular Forms*, arXiv:1208.4074.
  [15] Bhand–Sen–Singh, *Mock modularity in CHL models*, Res. Math. Sci. 12 (2025) no.1 8, arXiv:2311.16252.
  [16] N. Banerjee–Bhutra–Singh, *Mock Modularity Of Twisted Index In CHL Models*, arXiv:2505.17182.
  [17] Bringmann–Raum–Richter, Adv. Math. 231 (2012) no.2 1100–1118, arXiv:1105.5482.
  [18] Westerholt-Raum, IMRN 2018 (12, 2016) 1442–1472.
  [19] Bringmann–Richter–Westerholt-Raum, Res. Math. Sci. 3 (2016) no.1 30, arXiv:1604.05105.
  [20] Jatkar–Sen, *Dyon spectrum in CHL models*, JHEP 04 (2006) 018, hep-th/0510147.
  [21] David–Jatkar–Sen, JHEP 06 (2006) 064, hep-th/0602254.
  [22] David–Jatkar–Sen, JHEP 11 (2006) 073, hep-th/0607155.
  [23] David–Jatkar–Sen, JHEP 01 (2007) 016, hep-th/0609109.
  [24] Sen, *Black Hole Entropy Function, Attractors and Precision Counting of Microstates*,
       Gen. Rel. Grav. 40 (2008) 2249–2431, arXiv:0708.1270.
  [25] Lopes Cardoso–Nampuri–Rosselló, *Rademacher Expansion of a Siegel Modular Form for N = 4 Counting*, Ann. Henri Poincaré 25 (2024) no.9 4065–4120, arXiv:2112.10023.
  [26] "Lucas sequence wikipedia article." https://en.wikipedia.org/wiki/Lucas_sequence

- **★ 否定判定（逐条目视核对，非 grep）**：参考表中**没有**
  - **Dabholkar–Gomes–Murthy, arXiv:0803.2692**（`paper.md` 的 `[dgm-2008]`）；
  - **Rosselló, arXiv:2403.19630**（`paper.md` 的 `[rossello-2024]`）；
  - **Alexandrov–Nampuri, arXiv:2009.01172**（`paper.md` 的 `[alexandrov-nampuri-2020]`）；
  - **Banerjee–Sen–Srivastava 0802.0544 / 0802.1556**（本项目 bib 的挠>1 两篇）；
  - **Gritsenko–Nikulin**、**Kawai hep-th/9710016**。

  即：**挠 I>1 的整条文献线，2510.05219 一篇都没引。**

---

## 对 `research/papers/torsion-dyon-shift-positivity/paper.md` 的影响（本次任务的裁定表）

⚠ 以下是**比对结果的事实记录**。抽取者不写 `research/`；处置由 lead / 论文作者决定。

| `paper.md` 的结果 | 2510.05219 是否包含 | 裁定 | 依据 |
|---|---|---|---|
| Thm 6.3 除子和不是电荷的函数（三个整数见证） | **否** | **无重叠** | E2（全文只挠一）、E8（不引 DGM） |
| Prop 6.1 第 s 项 = 超格 ℤ(Q/s)+ℤP 的 immortal index | **否** | **无重叠** | E2、E6（六条结果全是解析性质） |
| Prop 6.5 / 6.9 类数与 p∤ν 判据 | **否** | **无重叠** | 全文无 "class number" / 二元二次型类语言 |
| Prop 3.1 DGM eq(51)/(52) 不相容 | **否** | **无重叠** | E8：不引 0803.2692；全文无除子和 |
| adapted frame / Q ∈ IΛ 判据 | **否** | **无重叠** | 全文无 "adapted"；"torsion" 仅 1 次且是挠一 |
| 格论字典 L ⊆ M、I = [M:L] | **否** | **无重叠** | 全文无 saturation / Smith normal form |
| Thm 4.1 半整数移位 (d−1)/2 | **否** | **无重叠** | 全文无除子和生成函数 |
| Thm 5.2 吸引子围道在 (ρ,σ,v)↦(s²ρ,σ,sv) 下协变 | **否** | **无重叠** | BSS 只用 T ↦ γ^t T γ（SL(2,ℤ)），不做 s-缩放；(1.16) 里 γγ₀γ^t = γ₀ 依赖 det γ = 1，A_s = diag(s,1) 不在其中 |
| Thm 7.1 / Cor 8.1 挠 I 正性 | **否** | **无重叠** | 全文不讨论正性，不引 Rosselló 2403.19630 |
| **Appendix A Prop A.1：d_* 是 GL(2,ℤ) 类函数** | **是** | **⚠ 已有公开先例** | **E4**：(1.16)–(1.17) 同陈述、同论证路线 |
| Problem 9.1 的 S-对偶不变对象 | 相邻但不同 | 邻近工作 | E5：BSS 的 F(Ω) 是挠一的生成函数级不变性 |
| Problem 9.5 Gauss 域外的 d_* = (−1)^{ℓ+1}c_m^F | 相邻 | 文献线索 | E7：自承 "with some restrictions"，归 [15][16] |

**唯一需要处置的一条**：`paper.md` Appendix A 现写 "For completeness, we provide an **independent
proof** that d_*(T) depends only on the GL(2,ℤ)-equivalence class of T"，Remark 7.2 又写
"We provide an independent proof of S-duality invariance in Appendix A"。事实是：

- 该陈述本身**在 2025-10 已有公开先例**（BSS 2510.05219 eq (1.17)），且 BSS 给的论证
  （Φ₁₀ 的 Sp 不变性 + γ₀^t T γ₀ = adj(T) 的围道协变 + 测度不变）与 `paper.md` Appendix A **同路**；
- 但 BSS 只写 "It follows from (1.14) and the identities (1.16) that"，**没有写出证明步骤**，
  也没有处理半周期移位（他们用显式前因子 (−1)^{T₁₂+1} 绕开）；
- `paper.md` 自己在 Remark 7.2 已把该不变性归给 Rosselló（"The S-duality invariance
  d_*(T) = d_*(A^{-T}TA^{-1}) for A∈SL(2,ℤ) propagates positivity…"），即已承认这不是新结果，
  Appendix A 只是 "for completeness"。

所以**这不构成优先权问题**，只是**引用完备性**问题：Appendix A 值得加一句
"cf. Bhand–Sen–Singh, arXiv:2510.05219, eq. (1.16)–(1.17)"。"independent proof" 的措辞仍然成立
（BSS 未给证明），但 "independent of [rossello-2024]" 这个限定最好改成明确列出已知先例。

---

## 未解决的疑问（原文疑点）

### Q1 ⚠ (1.11) 左端的波浪号与上下文矛盾（排印错误，已 300 dpi 复核）

- 印刷页 2 正文："The precise expression for **d\***(m,n,ℓ) is [9]"，但紧接的 (1.11) 左端印作
  **d̃\*(m,n,ℓ)**（波浪号清晰可辨）。
- 印刷页 3 起，(1.11) 一律被当作 `d*` 的定义引用："We then define **d\***(m,n,ℓ) using (1.11)"；
  §3 开头："d*(m,n,ℓ) defined in (1.11)"；E6 第 1 条同。
- 而 `d̃*` 在 (1.21) 另有定义 `d̃* = d − d^two`，两者相等是本文的 **Theorem 5.4**（(1.30)、(5.44)）。
  若 (1.11) 真定义 `d̃*`，Theorem 5.4 就退化成同义反复。
- **裁定：(1.11) 左端的波浪号是排印错误，应为 d\*(m,n,ℓ)。** 不影响任何结论。
  引用 (1.11) 时应说明这一点。

### Q2 编号漂移：印刷页 3 "Equation (1.12) can be written as" 疑应为 (1.11)

- 印刷页 3 在给出 (1.14) 之前写 "Equation (1.12) can be written as"。但 (1.12) 是围道
  𝒞_{m,n,ℓ} 的定义，(1.14) 是积分 (1.11) 的矩阵改写。上下文看应指 (1.11)（或 (1.11)+(1.12) 合并）。
- 同页稍前又有 "We then define d*(m,n,ℓ) using (1.11)" 与 "the procedure described below (1.12)"，
  两个编号都在用，故不能完全排除作者确实意指 (1.12)（即把围道条件改写成 Im Ω = 2γ₀^tTγ₀/ε）。
- **裁定：无定论，倾向排印/编号漂移。** 不影响任何结论。

### Q3 目录里 §3 写 "Analysis of the generating function **F(Ω)**"，§2/§4/§5 写 **F̃(Ω)**

- 不是错误（§3 确实分析 F，§4/§5 分析 F̃），但极易混淆。记录以便引用时不写错。

### Q4 与本项目 `sources.bib` 的一处冲突（不是 2510.05219 的问题）

- 2510.05219 的 [6] 逐字是 **Banerjee–Sen, *Duality orbits, dyon spectrum and gauge theory limit
  of heterotic string theory on T\*\*6*, JHEP 03 (2008) 022, arXiv:0712.0043**。
- 已用 arXiv API 独立核实（L1 元数据）：
  - `0712.0043` = **Shamik Banerjee, Ashoke Sen**, *Duality Orbits, Dyon Spectrum and Gauge Theory
    Limit of Heterotic String Theory on T^6*, published 2007-12-03, journal_ref **JHEP 0803:022,2008**。
  - `0801.0149` = **Shamik Banerjee, Ashoke Sen**, *S-duality Action on Discrete T-duality Invariants*,
    published 2007-12-30, journal_ref **JHEP 0804:012,2008**。
- 本项目 `literature/sources.bib` 的 `banerjee-sen-2008-tduality` 条目原写
  `author = {Banerjee, Sandip and Sen, Ashoke}` 与 `JHEP 09 (2008) 027`，两处都与 arXiv 元数据冲突
  （名字应是 **Shamik**；卷期应是 **JHEP 04 (2008) 012**）。**已在本轮订正**，见该条目 note 的
  2026-09-23 行。
- **另外记录（供 lead 转达，researcher 不改 `research/`）**：
  `research/papers/torsion-dyon-shift-positivity/paper.md` 第 549 行的
  `[banerjee-sen-2008] S. Banerjee, A. Sen, "Duality Orbits, Dyon Spectrum and Gauge Theory Limit of
  Heterotic String Theory on T^6," arXiv:0801.0149, JHEP 03 (2008) 022.`
  **把两篇论文混成了一条**：题名 + 刊号属于 **0712.0043**，arXiv 号却给的是 **0801.0149**。
  而 §8 第 1 点与 §10 引用它时所依据的 Γ⁰(r) 陈述，按本项目已有抽取记录
  `extractions/banerjee-sen-2008-tduality.md` E1，出处是 **0801.0149**。
  故需作者自行裁定引哪一篇（或两篇都引），并修正该条参考文献。

### Q5 未逐页读图的部分（证据等级说明）

印刷页 11–27（§3 末 + §4 全部）与 29–34（§5.1–§5.3 证明）只做了 `pdftotext` 关键词否定检索，
未读页面图像。基于 §1 自列的六条结果清单（E6，已读图）、目录（无第 6 节无附录，已读图）
与 "torsion" 全文仅 1 次的否定检索，这些页面含挠 I>1 内容的可能性极低；但严格说该否定断言
对这 20 余页是 **L2**（未读图）。若 lead 要 L1 级的"全文无挠 I>1"，需再花一轮读完。
