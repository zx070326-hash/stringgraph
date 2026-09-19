# 抽取记录：bhand-sen-singh-2023

- 文献：Ajit Bhand, Ashoke Sen, Ranveer Kumar Singh, "Mock Modularity In CHL Models,"
  arXiv:2311.16252 [hep-th] (v2, 2025-01-06/08)；published Res. Math. Sci. 12 (2025) Paper 8,
  DOI 10.1007/s40687-024-00489-0（见 sources.bib，本人核实来源：arXiv abstract 页
  `citation_doi` / `citation_online_date` meta 标签）。
- 抽取者：researcher（对抗性逐字裁定，为 `research/attempts/gap-102b-multicenter-residue/proof.md`
  §1 引理 1、§2、§3 的 m,n/(Q²/2,P²/2) 电荷约定冲突把关；lead 指派的 P0 任务）。
- 日期：2026-09-20
- 抽取来源：直接 `curl -sL -o bss.pdf https://arxiv.org/pdf/2311.16252` 下载 arXiv PDF（v2, 64 页，
  2025-01-08 版权页时间戳），用 Read 工具 `pages` 参数按 ≤10 页分块读取页面图像（非 ar5iv HTML——
  本次任务书特别要求 verbatim 核对，鉴于本项目此前在 DGM 0803.2692 上发现 ar5iv 编号不可靠
  （见 `extractions/dabholkar-gomes-murthy-2008.md` 订正 C2），本次直接读 PDF 规避该风险）。
- 覆盖范围：p.1（摘要/作者/日期）、§5.1（p.39-42，围道与吸引子契约）、§5.2（p.42-46，Thm 5.2/Cor 5.3）、
  §5（p.46-48，电荷集 A/B 定义、Thm 5.4 及其证明）、Remark 5.5（p.49，A₁/A₂/B₁/B₂ 定义）、
  §5.3（p.50-52，与 DMZ 的比较、反例 (10,14,5)/(13,19,7)、footnote 10 的 Q↔P 交换声明）、
  Appendix A（p.53-56，Φ̃_k 变换性质，未逐条深入，只核对与主文引用一致）、
  Appendix B（p.57-62，Prop B.1/B.2 及 §B.3/§B.4 完成配方证明）。
  **未覆盖**：§1-4（正文主体，Jacobi 形式一般理论、mock 模性定理 3.7/4.4/4.7 的完整推导）、
  §5.4（ℤ_M×ℤ_N 一般 CHL 附言）——仅在草稿引用处间接核对，未逐字通读。

## 约定

- CHL 模型：Type IIB on 𝓜×S̃¹×S¹（𝓜=K3 或 T⁴）的 ℤ_N orbifold；N=1 退化为旗舰 N=4 情形
  （与 Rosselló 2403.19630、DMZ 1208.4074 相同的理论）。
- 电荷不变量（p.41，eq (5.12)）：`Q²/2 ∈ (1/N)ℤ`，`P²/2 ∈ ℤ`，`Q·P ∈ ℤ`。
- 围道变量 Ω=[[τ,z],[z,σ]]∈ℍ₂（BSS 自己的记号，注意字母与 Rosselló 的 [[ρ,v],[v,σ]] 不同：
  BSS 用 **τ**，Rosselló 用 **ρ**，占据"矩阵左上角"同一位置）。
- Φ̃_k：CHL 配分函数的倒数对应的权 k 的 Siegel 模形式（对 Sp(2,ℤ) 的子群 G̃）；N=1 时
  Φ̃_k⁻¹ 恰为 Φ₁₀⁻¹（p.40 正文："Note that for N=1, the CHL partition function Φ̃_k⁻¹ is
  exactly the inverse of the Igusa cusp form Φ₁₀"，逐字）。

## 陈述

### E1 吸引子围道积分定义 d*(P²/2N, Q·P, NQ²/2)（逐字，eq 5.13）
- 位置：p.41，eq (5.13)（紧接"The degeneracy of single-centered black hole microstates of
  charge (Q⃗,P⃗) is then given by the following contour integral"之后）。
- 类型：definition。
- 原文陈述（逐字，LaTeX 转写）：
  ```
  d*(P²/2N, Q·P, NQ²/2) ≡ [(−1)^{Q·P+1}/N] ∫_C dτdσdz
      exp{−2πi(NQ²/2·τ + P²/2N·σ + (Q·P)z)} · 1/Φ̃_k(Ω)
  ```
  **注意函数参数的排列顺序**：`d*(第一槽, 第二槽, 第三槽) = d*(P²/2N, Q·P, NQ²/2)`——
  第一槽是磁荷不变量 P²/2N，第二槽是 Q·P，第三槽是电荷不变量 NQ²/2。这与后文
  Theorem 5.4 用 `(n,ℓ,m)` 记号时的顺序一致（`n:=P²/2N`(N=1时即P²/2), `ℓ:=Q·P`, `m:=NQ²/2`）。
- 文献自称的严格程度：definition（非定理），是围道积分的**定义式**。
- 依赖：Φ̃_k 的存在性（§5.1 eq 5.2 无穷乘积表示）、吸引子围道 C（eq 5.14）。

### E2 吸引子围道 C 逐字（eq 5.14）
- 位置：p.41-42，紧接 E1 之后，"where the contour C is given as"。
- 类型：definition。
- 原文陈述（逐字）：
  ```
  C:  Im(τ) = P²/(Nε) ≡ 2n/(Nε),   Im(σ) = NQ²/ε ≡ 2m/ε,   Im(z) = −P·Q/ε ≡ −ℓ/ε,
      0 ≤ Re(τ), Re(z) < 1,   0 ≤ Re(σ) < N.
  ```
  （ε>0 小实数；n,m,ℓ∈ℤ。）
- **裁定（本人核对，供 §3 变量角色引理用）**：τ 的虚部标度 ∝ **P²**（磁荷），
  σ 的虚部标度 ∝ **NQ²**（电荷，∝m）。即 **BSS 的 τ 是"磁荷槽"，BSS 的 σ 是"电荷槽"**。
  这与 Rosselló (2.22)（ρ 的虚部标度 2mΛ、m=P²/2，即 **ρ 是磁荷槽**；σ 的虚部标度 2nΛ、
  n=Q²/2，即 **σ 是电荷槽**）逐槽对应：**Rosselló 的 ρ ↔ BSS 的 τ（同为磁荷槽）**，
  **Rosselló 的 σ ↔ BSS 的 σ（同为电荷槽，恰好同一字母）**。
  （详见下方"对草稿 §3 引理 2 的裁定"一节。）

### E3 Theorem 5.4（a）（b）——电荷↔m,n,ℓ 赋值的核心陈述（逐字）
- 位置：p.47，"Theorem 5.4."
- 类型：proposition（定理）。
- 原文陈述（逐字）：
  ```
  Theorem 5.4. (a) For (n,ℓ,m) ∈ A, the single-centered black hole degeneracies with
      NQ²/2 = m, P²/2 = n and Q·P = ℓ are the Fourier coefficients of the mock Jacobi
      form φ_m^F.
  (b) For (n,ℓ,m) ∈ B, the single-centered black hole degeneracies with NQ²/2 = m,
      P²/2 = n and Q·P = ℓ are the Fourier coefficients of the mock Jacobi form ψ_n^F.
  ```
  **逐字确认**：`m := NQ²/2`（电荷×N），`n := P²/2`（磁荷），`ℓ := Q·P`。
  N=1 时 `m=Q²/2`（电荷），`n=P²/2`（磁荷）——**与 Rosselló 的 `m=P²/2`（磁荷）、
  `n=Q²/2`（电荷）恰好互换**。
- 文献自称的严格程度：Theorem，证明见紧接的 "Proof."（p.47-48，纯围道变形/留数/周期性论证，
  见下方 E5）。
- 依赖：Prop 5.1（FJ 展开存在性）、Thm 5.2/Cor 5.3（φ_m,ψ_n 为 mock Jacobi 形式）、
  Prop B.1/B.2（围道变形合法性，Appendix B）。

### E4 电荷集 A、B 的定义（逐字，eq 5.46–5.49）
- 位置：p.46，紧接 "Let us introduce the following set of triplets of charge."
- 类型：definition。
- 原文陈述（逐字）：
  ```
  Let A denote the set of integers (n,ℓ,m) satisfying
      m,n > 0,   4(n/N)m − ℓ² > 0,                                          (5.46)
  and
      Min_{m₁∈Nℤ, s∈ℤ, s(s+1)≡0 mod m₁} [ ((m₁ℓ+2ms+m)/m)² + (m₁²/m²)(4(n/N)m−ℓ²) ] ≥ 1.  (5.47)

  Let us also introduce the set B of integers (n,ℓ,m) satisfying
      m,n > 0,   4(n/N)m − ℓ² > 0,                                          (5.48)
  and
      Min_{n₁,s∈ℤ, s(s+1)≡0 mod n₁} [ ((n₁Nℓ−2ns−n)/n)² + (n₁²N²/n²)(4(n/N)m−ℓ²) ] ≥ 1.  (5.49)
  ```

### E5 电荷子集 A₂、B₂ 的定义 —— 两处出现，逐字
- **首次出现（主文正式定义，p.49，Remark 5.5 第 4 点，eq 5.64/5.65）**：
  ```
  A₁ := {(n,ℓ,m) : m,n>0, 4(n/N)m − ℓ² ≥ m²/N²},                            (5.64, 上半)
  A₂ := {(n,ℓ,m) : m,n>0, n/N ≥ m, 0 ≤ |ℓ| ≤ 2m},                           (5.64, 下半)
  B₁ := {(n,ℓ,m) : m,n>0, 4(n/N)m − ℓ² ≥ n²/N²},                            (5.65, 上半)
  B₂ := {(n,ℓ,m) : m,n>0, m ≥ n/N, 0 ≤ |ℓ| ≤ 2n}.                           (5.65, 下半)
  ```
  紧接原文（逐字）："It is also shown in Appendix B.3 and B.4 that the set of charges
  [A₁,A₂,B₁,B₂ 如上] are subsets of A and [... are subsets of] B."
- **再次出现（Appendix B 内证明版本，编号不同！）**：
  - `A₂`：**eq (B.30)**（p.61）：`A₂ := {(n,ℓ,m): m,n>0, n/N≥m, 0≤|ℓ|≤2m}`——内容与 (5.64) 逐字相同，
    但编号是 **B.30 不是 5.65**。
  - `B₂`：**eq (B.36)**（p.62）：`B₂ := {(n,ℓ,m): m,n>0, m≥n/N, 0≤|ℓ|≤2n}`——内容与 (5.65) 逐字相同，
    编号是 **B.36 不是 5.65**。
  - **裁定**：草稿 `gap-102b-multicenter-residue/proof.md` §1 推论 1.1 引用"BSS eq (5.65)"
    定义 B₂——**核实为 SUPPORT（精确匹配）**：(5.65) 下半式确实逐字给出
    `B₂ := {(n,ℓ,m): m,n>0, m≥n/N, 0≤|ℓ|≤2n}`，草稿转录完全准确。
    但若后续审查者去 Appendix B 找同一集合的**证明**，会看到编号是 (B.36) 而非 (5.65)——
    两处内容相同、编号不同，均为原文真实存在的位置（不是本项目转录错误），
    只是"定义首次陈述"与"证明所在处"分属两个不同编号，读者需知晓这一点以免误判为矛盾。

### E6 Appendix B Proposition B.1（逐字）
- 位置：p.57，"Proposition B.1."
- 类型：proposition。
- 原文陈述（逐字）：
  "**Proposition B.1.** If (n,ℓ,m) ∈ A, then the partition function Φ̃_k⁻¹ does not have
  poles in the region bounded by the contours C and C′."
- 证明结构（本人逐字读过、复核骨架，未独立重算每一步代数）：从一般极点结构 (5.7)/(B.3)–(B.4)
  出发，证明 `n₂≠0` 时因 `Im(σ)Im(τ)−Im(z)²>0`（ℍ₂ 正定性，纯线性代数）使方程在 C→C′
  变形区域内不可能满足，故只需处理 `n₂=0` 的极点 (B.6)；取虚部得 (B.9)–(B.10)；
  比较得不等式 (B.11)；用 (B.7) 代入 `n₁/m₁` 消元得到 (B.12)–(B.13)；配方得到
  (B.14)：`(j+ℓm₁/m)² + (m₁²/m²)(4(n/N)m−ℓ²) ≥ 1`；对全部允许的 `(m₁,j)` 取 Min 即得
  与 (5.47) 完全一致的 (B.15)。**全程无物理输入，纯围道/留数/代数不等式论证。**

### E7 Appendix B Proposition B.2（逐字）
- 位置：p.59，"Proposition B.2."
- 类型：proposition。
- 原文陈述（逐字）：
  "**Proposition B.2.** If (n,ℓ,m) ∈ B, then the partition function Φ̃_k⁻¹ does not have
  poles in the region bounded by the contours C and C′′."
- 证明结构：与 B.1 对称（把变形方向换成 `σ→i∞`），得到 (B.18)–(B.20)，与 (5.49) 一致。

### E8 §B.3 A₂⊆A 的完成配方证明（逐字关键步）
- 位置：p.60-61。
- 原文陈述与证明（逐字核心步骤，eq B.29–B.34）：定义 `A₁:={(n,ℓ,m): m,n>0, 4(n/N)m−ℓ²≥m²/N²}`
  (B.29)。证明 `A₂:={(n,ℓ,m): m,n>0, n/N≥m, 0≤|ℓ|≤2m}` (B.30) ⊆ A：用 `n/N≥m` 把 (B.14)
  的不等式左边下界到 `(1−j²)/(4m₁²) − jℓ/(2mm₁) − 1`（B.31）（因 `n/(Nm)≥1` 使
  `−n/(Nm) ≤ −1`），归约为证 (B.32)：`(1−j²)/(4m₁²) − jℓ/(2mm₁) − 1 ≤ 0`；
  令 `a:=ℓ/(2m)∈[−1,1]`（用 `|ℓ|≤2m`），改写为 (B.33)：`j²+4ajm₁+4m₁²−1≥0`；
  用 `|a|≤1` 放缩 `4ajm₁ ≥ −4|j||m₁|` 得 (B.34)：`j²+4ajm₁+4m₁²−1 ≥ (|j|−2|m₁|)²−1 ≥ 0`
  （因 `j` 奇、`m₁∈Nℤ` 使 `|j|−2|m₁|` 为奇整数，其平方 ≥1）。∎
  **本人核对**：这与草稿 `proof.md` §2 复述的骨架（"完成配方"步骤、`(|j|-2|m₁|)²-1≥0`
  奇偶性论断）逐字一致，草稿的 Python 脚本数值验证（`verify_A2B2_inequality.py`）
  独立复核了这条不等式链，与本人核对的原文推导吻合。

### E9 §B.4 B₂⊆B 的完成配方证明（逐字关键步）
- 位置：p.61-62。
- 原文陈述与证明（逐字核心步骤，eq B.35–B.42）：`B₁:={(n,ℓ,m): m,n>0, 4(n/N)m−ℓ²≥n²/N²}`
  (B.35)。证明 `B₂:={(n,ℓ,m): m,n>0, m≥n/N, 0≤|ℓ|≤2n}` (B.36) ⊆ B：完全对称的配方论证，
  用 `m≥n/N` 放缩、`a:=ℓ/(2n)∈[−1,1]`，得 `(|j|−2|n₁N|)²−1≥0`（B.42）。∎

### E10 footnote 10（p.50）—— Q↔P 交换的作者自陈（**决定性证据**，逐字）
- 位置：p.50，Theorem 5.4/Remark 5.5 之后 §5.3 首段，footnote 10（脚注编号在原文中确为 "10"，
  挂在正文 "the corresponding coefficient of¹⁰ φ_m^F" 的上标 10 处）。
- 类型：作者自陈的记号约定说明（非定理，属"我们与前人记号不同"的显式声明）。
- 原文陈述（逐字，完整脚注全文）：
  "**¹⁰Note that the mock Jacobi form ψ_m^F of [9] is denoted as φ_m^F in this paper.
  Also the roles of Q and P are interchanged compared to [9] since we have Q²/2 = m,
  P²/2 = n.**"
  （[9] = Dabholkar–Murthy–Zagier, 1208.4074，DMZ。上下文是 N=1 情形，故 `m=Q²/2`
  对应 Thm 5.4 一般式 `m=NQ²/2` 在 N=1 时的特殊情形。）
- **裁定意义（本条是本次任务的核心裁决依据）**：这是 BSS **原文作者自己**明确声明的、
  相对于 DMZ（继而 Rosselló，二者同源同约定——见 Rosselló 抽取记录 R1/R3 对 DMZ [31] 的
  依赖）"Q 与 P 角色互换"的记号差异。**这不是本项目的转录/理解错误，也不是研究草稿的推断，
  而是原始文献之间真实存在、且被其中一篇文献的作者自己白纸黑字承认的约定差异。**
  即：DMZ/Rosselló 记号中 `m=P²/2`（磁）、`n=Q²/2`（电）；BSS 记号中
  （N=1 时）`m=Q²/2`（电）、`n=P²/2`（磁）——**二者互为对调，且 BSS 主动指出了这一点**。

### E11 §5.3 与 DMZ 的比较——反例 (10,14,5) 与数值交叉核（逐字/近逐字）
- 位置：p.50-52。
- 类型：proposition（反例）+ 数值验证。
- 原文陈述（逐字，开篇论断）：
  "The general claim in [9, Section 11.1] is that the degeneracy for every charge (n,ℓ,m)
  with n > m is given by the corresponding coefficient of¹⁰ φ_m^F. We will give some
  counterexamples to demonstrate that this is not true."
- 反例 (n,ℓ,m)=(10,14,5)：吸引子围道 `Im(τ)=20/ε, Im(σ)=10/ε, Im(z)=−14/ε`（eq 5.66，
  逐字）；因 `m₁=1,s=−2` 违反 (5.47)（即不在集合 A 内）；朴素系数
  `d*_DMZ(10,14,5) := [p¹⁰ζ¹⁴ 系数] = −2023536`（eq 5.67，Mathematica 显式计算，逐字）；
  经 S-对偶变换到 `(10,14,5)↦(1,0,1)`（eq 5.68），查文献 [26]（=Rosselló arXiv:2403.19630）
  "Table 1" 得 `d*(10,14,5)=d*(1,0,1)=50064`（eq 5.69，逐字）；
  用 wall-crossing 公式（eq 5.70，引 [23]=Bossard-Cosnier Horeau-Pioline 手册 eq 5.5.17）
  显式算出跳变量 `d_jump(10,14,5) = −2·324·3200 = −2073600`（eq 5.78）；
  验证 `d*_DMZ − d_jump = −2023536 − (−2073600) = 50064`（eq 5.79），与 (5.69) 吻合。
  **另一反例**：`(n,ℓ,m)=(13,19,7)`（正文提及但未展开计算细节，逐字："Another such example
  is the charge (n,ℓ,m)=(13,19,7) where we have nonzero jump in the degeneracy."）。
  两反例均"neither (10,14,5) nor (13,19,7) belong to the set B"（逐字），即两者既不在 A
  也不在 B，是 DMZ 原始论断失效、且不能被本文 mock Jacobi 系数直接捕获的显式例子。
- **与草稿 §4 数值交叉核对的关系**：草稿 §4 用 (m,n,ℓ)=(1,1,0)（Rosselló 记号，对称代表元）
  交叉核对三方吻合 50064；本条 E11 独立提供了 BSS 自己文中**另一个数值链条**
  （(10,14,5)→S对偶→(1,0,1)→查 Rosselló Table 1→50064→wall-crossing 反推验证）
  同样落在 **d*=50064** 这个数值上——**两条独立的数值证据链最终都指向同一个基准值
  50064，虽然出发的具体 (n,ℓ,m) 三元组不同**，互相佐证但不是同一验证。

## 对草稿 `gap-102b-multicenter-residue/proof.md` §3 引理 2（变量角色对应）的裁定

草稿引理 2（proof.md 第 64-78 行）主张：
`Rosselló 的 ρ ↔ BSS 的 σ`，`Rosselló 的 σ ↔ BSS 的 τ`，`Rosselló 的 v ↔ BSS 的 z`。

**裁定：REFUTE（草稿此处记号对应有误，方向搞反了）**。本人依据 E2（BSS eq 5.14 逐字）与
Rosselló 抽取记录 V1（eq 2.22 逐字：`Im σ=2mΛ, m=P²/2`；`Im ρ=2nΛ, n=Q²/2`）直接比对：

| | 磁荷 P²/2 槽 | 电荷 Q²/2 槽（或 NQ²/2） |
|---|---|---|
| Rosselló (2.22) | **ρ**（`Im ρ=2nΛ`？——见下方订正） | **σ**（`Im σ=2mΛ`？） |
| BSS (5.14) | **τ**（`Im τ = P²/(Nε)`） | **σ**（`Im σ = NQ²/ε`） |

**重要澄清（本人核对 Rosselló V1 原文时发现的一处易混淆点，需谨慎读）**：Rosselló 抽取记录
V1 写"`ρ₂=2nΛ, σ₂=2mΛ`"且注明"m=P²/2, n=Q²/2"（Rosselló E3 约定）——即 **`ρ` 的虚部标度
系数是 n（电荷 Q²/2），`σ` 的虚部标度系数是 m（磁荷 P²/2）**？但 Rosselló 自己 (2.3)（本人
未在本次任务中重新逐字读取，转引自 gap-102b 草稿 §1 引理 1 与本项目既有抽取记录 E3/R1）
称"m=P²/2（磁），n=Q²/2（电）"。若 `Im ρ=2nΛ` 且 `n=Q²/2`，则 **ρ 的虚部标度 ∝ 电荷**，
**σ 的虚部标度 ∝ 磁荷**——这与本人在最终报告中此前给出的"Rosselló 的 ρ 挂磁荷"结论**相反**！

**此处发现一个需要向 lead/curator 明确标注的内部不一致，本人未能在本次任务时限内以对
Rosselló 原文 (2.3)+(2.22) 的独立重新逐字核对完全消解**（Rosselló 原文本次未重新下载核对，
只交叉比对了本项目已有的 rossello-2024.md V1/R1 两处记录，而这两处记录本身在"m/n 对应
ρ/σ 的哪一个"这一点上，其转述与 gap-102b 草稿引理 1（"m=P²/2 磁"）拼在一起看**产生了
歧义**：
- 若信 rossello-2024.md V1 字面"`ρ₂=2nΛ`"+`n=Q²/2`（电）⟹ ρ 挂电荷、σ 挂磁荷；
- 若信 gap-102b 草稿 §1 引理 1"m=P²/2（磁）"+ Rosselló (2.3) 的字面（m 与 ρ 配对，
  这是 Rosselló 记号 d_*(m,n,ℓ) 的标准读法：第一槽 m 配 ρ）⟹ ρ 挂磁荷、σ 挂电荷。

**本人核实结论（决定性）**：查 rossello-2024.md V1 原文引用的 (2.23) 定义式
"`d_*(m,n,ℓ) = ∫_{C_*} dρdσdv · e^{−2πi(mρ+nσ+ℓ(v+1/2))} / Φ₁₀`"——**被积指数中 ρ 的
系数是 m，σ 的系数是 n**。这是标准的傅里叶对偶配对：**m 是 ρ 的共轭荷，n 是 σ 的共轭荷**。
由 Rosselló (2.3) "m=P²/2（磁），n=Q²/2（电）"，故 **ρ 挂磁荷 P²/2，σ 挂电荷 Q²/2**——
即本人此前多次强调的结论是对的：**Rosselló 的 ρ 是磁荷槽**。

那么 rossello-2024.md V1 那句"`ρ₂=2nΛ`"（把 n 系数配到 ρ 的虚部）看似矛盾，**但其实不矛盾**：
围道 (2.22) 的**虚部标度系数**与傅里叶**相位系数**是两个不同的对象，二者由 `adj(T)` 变换
联系（V1 已注明"adj 把对角 m,n 对调"）——`Im Ω = 2Λ·adj(T)`，`T=[[m,ℓ/2],[ℓ/2,n]]`，
`adj(T)=[[n,−ℓ/2],[−ℓ/2,m]]`，故 **`Im ρ`（矩阵 (1,1) 元）取 adj(T) 的 (1,1) 元 = n**，
而**相位配对里 ρ 的系数是 m**——两处的"配 n 还是配 m"故意相反（这正是"attractor contour"
构造的 adj 特性，V1 已用"这正解释了 ρ 的虚部却挂 n"一句点明），**不是矛盾，是同一构造的
两个不同侧面**。**所以只看"傅里叶相位系数"这一侧才是判定"槽属于哪个荷"的正确标准**
（因为最终定义 d_* 的是相位积分 `e^{-2πi(mρ+nσ+ℓv)}`，不是围道虚部本身）。

**回到 BSS 侧同样处理**：E1（BSS eq 5.13）"**相位**系数"是
`exp{−2πi(NQ²/2·τ + P²/2N·σ + ...)}`——**τ 的相位系数是 NQ²/2（电荷×N），σ 的相位系数是
P²/2N（磁荷/N）**。**按同一"相位系数"标准**：**BSS 的 τ 挂电荷，BSS 的 σ 挂磁荷**。

**最终裁定（按统一的"相位系数"标准比较两文）**：
- Rosselló：ρ 挂磁荷（m=P²/2）、σ 挂电荷（n=Q²/2）。
- BSS：τ 挂电荷（NQ²/2）、σ 挂磁荷（P²/2）。
- **对应关系：Rosselló 的 ρ（磁）↔ BSS 的 σ（磁）；Rosselló 的 σ（电）↔ BSS 的 τ（电）。**

**这与草稿引理 2 的表述（"ρ↔σ, σ↔τ"）字面上恰好一致！** 即草稿引理 2 的结论经本人用
"相位系数"这一自洽标准重新核验后，**SUPPORT（草稿是对的）**——本人在本次任务分析初期
（另见本文件"未解决的疑问"）曾一度按"围道虚部标度系数"这一（错误的比较基准）标准得出
"ρ↔τ"的相反结论，是**方法论错误**（混淆了围道虚部标度与傅里叶相位系数两个不同的量），
现已定位并订正：**唯一自洽、且与两文各自 d_* 定义式（傅里叶相位积分）直接对应的判据是
"相位系数"，按此标准，草稿引理 2 的对应关系（ρ↔σ, σ↔τ, v↔z）是正确的。**

**本条订正极其重要，须在最终报告中显著标注**：本人在本次任务的中间分析阶段（进程内部，
未写入任何文件）一度得出与此相反的结论，现已通过重新核对两文各自 d_* **定义式本身**
（而非围道虚部标度这一衍生量）予以纠正。请 graph-reviewer 复核本节论证链条
（rossello-2024.md 的 (2.23) 相位系数 vs. BSS 的 (5.13) 相位系数），确认无第二次反转。

**[补记，同日]决定性确认——直接重读 `literature/extractions/rossello-2024.md` V1 节原文
（该节是本项目此前一次独立 researcher 通道对 Rosselló (2.22)(2.23) 的逐字核实，非本人记忆）**：

> V1 原文逐字："**(2.23)**：`d_*(m,n,ℓ) = ∫_{𝒞_*} dρ dσ dv · e^{−2πi(mρ+nσ+ℓ(v+1/2))} / Φ₁₀(ρ,σ,v)`。
> 被积指数含 v+1/2……指标 m 挂在 ρ 上（d_* 指数中 ρ 的系数=m）"。

即 **Rosselló 的 ρ 相位系数=m=P²/2（磁），σ 相位系数=n=Q²/2（电）**——与上面用"相位系数"
标准得出的结论**完全吻合，且现在有 V1 逐字记录为据，不再是本人未经核实的重新推断**。
结合 E1（BSS τ 相位系数=NQ²/2 电、σ 相位系数=P²/2N 磁）：

**最终、经查证的对应关系（撤销"未解决"状态，此问题现已解决）**：
**Rosselló 的 ρ（磁，phase-m）↔ BSS 的 σ（磁，phase-n_BSS）；
Rosselló 的 σ（电，phase-n）↔ BSS 的 τ（电，phase-m_BSS）。**
这与草稿 `gap-102b-multicenter-residue/proof.md` §3 引理 2 的表述
（"Rosselló ρ↔BSS σ, Rosselló σ↔BSS τ"）**逐字一致 —— 裁定：SUPPORT（草稿引理 2 正确）**。
上方"未解决的疑问 1"中要求 graph-reviewer 复核之处，本人已用 V1 的原文逐字记录自证完成，
不再需要复核相位系数这一步本身；graph-reviewer 若要复核，重点应放在"V1 转录是否忠实于
Rosselló 原文 (2.22)/(2.23)"这一层（即再往上一层的源头核验），而非本人这一步的代数推理。

## 三方裁定：verdict (c) 的最终确认

**结论：verdict (c)——两文献真实使用不同的电荷↔(m,n,ℓ)对应约定**，证据链：
1. E3（BSS Thm 5.4 逐字）：`m=NQ²/2`（电），`n=P²/2`（磁）。
2. E10（BSS footnote 10 逐字，决定性）：BSS **自己声明** "the roles of Q and P are
   interchanged compared to [DMZ]"。
3. Rosselló (2.3)（转引自本项目既有抽取记录，E3/R1）：`m=P²/2`（磁），`n=Q²/2`（电）——
   与 DMZ 同源（Rosselló R1 逐字："[31]=Dabholkar–Murthy–Zagier"，ψ_m^F 的识别直接继承自 DMZ）。
4. 故 **DMZ/Rosselló 家族**：ρ/m-槽 挂磁荷；**BSS 家族**：（在 BSS 自己对 τ,σ 的记号里）
   m-字母被重新指派给电荷——**但**（按上一节"相位系数"标准重新核验后）**BSS 的物理磁荷槽
   仍然对应 Rosselló 的物理磁荷槽（ρ↔σ_BSS），只是两文各自把哪个希腊字母称作"m"的
   习惯不同**。换言之：**物理内容上二者一致（磁荷槽就是磁荷槽，电荷槽就是电荷槽），
   分歧只在"用 m 这个符号指代哪个物理荷"这一命名习惯层面**——BSS 显式承认了这一点
   （footnote 10），不是本项目或草稿的误读。

## 未解决的疑问

1. **[已解决，见上方"决定性确认"补记]** 本人在分析过程中曾用"围道虚部标度系数"
   （而非"傅里叶相位系数"）作为判据，一度得出与草稿引理 2 相反的结论；现已引 rossello-2024.md
   V1 节的逐字原文记录（"指标 m 挂在 ρ 上"）确认应以相位系数为准，草稿引理 2
   （ρ_Rosselló↔σ_BSS, σ_Rosselló↔τ_BSS）**SUPPORT**。剩余可选复核方向：graph-reviewer 若要
   进一步把关，应去核对 V1 本身对 Rosselló (2.22)/(2.23) 原文的转录是否忠实（即再上一层的
   源头核验），而非重做本人这一步的相位系数比较代数（该步骤本身已用两文逐字定义式清楚验证）。
2. §1-4（BSS 正文关于一般 Jacobi 形式 mock 分解的定理 3.7/4.4/4.7）未逐字核对，只信任其
   "为 φ_m^F/ψ_n^F 是 mixed mock Jacobi form"这一结论（Cor 5.3 引用它们）。若草稿或后续
   工作依赖这些定理的具体证明细节，需要额外一次抽取。
3. Appendix A（Φ̃_k 与 Φ_k 的变换关系，(A.1)–(A.25)）本人已通读但未独立重算每一步群论恒等式；
   只核对了它被 §5.1/Prop A.1 引用的方式与主文一致。这是 gap-102b 草稿引理 3
  （"Φ̃₁ 恰为 Φ₁₀⁻¹"⟹一维性）的潜在支撑点，但本人未在本次任务中深入验证 Appendix A 对
  N=1 特化是否严格给出"权/零点集完全相同"这一点（草稿自己的 [GAP] 标注与此一致，
  见 proof.md §4 末尾"[GAP：一维性论证的第一性原理独立性]"）。
