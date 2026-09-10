# 抽取记录：ito-morozumi-nojiri-uehara-1986

- 文献：M. Itō, T. Morozumi, S. Nojiri and S. Uehara, *Covariant Quantization of Neveu-Schwarz-Ramond Model*, Prog. Theor. Phys. **75** (1986) 934–952（No. 4, April 1986；Received December 9, 1985）
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文 19 页逐页读图（L1）**。获取途径：`https://academic.oup.com/ptp/article-lookup/doi/10.1143/PTP.75.934` → 页面给 `article-pdf/75/4/934/5260521/75-4-934.pdf` → 302 → `watermark02.silverchair.com/75-4-934.pdf?token=…` → 落盘 804 KB（扫描件，2002 年 Paper Capture）。**页面标「Subscribers Only」但实际可下载。**
- 触发：Dedushenko 2015 [15]、KKM 2010 [36] 把它与 Ohta 并列为超弦 BRST 无鬼定理的物理原始文献；作者单位东北大/京都大/广岛大 RITP，是 Kato–Ogawa 学派。

> **本文的价值有二**：(1) 它是 R 扇区无鬼定理的物理证明一手来源（Ohta 预印本没有，见 Note added）；(2) 它五处自称「same method in Ref. 1)」，是反推 Kato–Ogawa 证明结构的最可靠材料（见 `kato-ogawa-1983.md` §3）。

## 0. 证据等级

全文 L1，页码 934–952，公式号 `(章·号)`，附录 `(A·n)`。定理只有 **Proposition I、Proposition II**（§4，p.947），证明在 Appendix。

## 1. 约定

- 号差：p.935 逐字 `η_{μν} = diag(−1, 1, ⋯, 1)`；世界面 `ξ⁰ = τ, ξ¹ = σ`，`0 ≤ σ < π`。
- 作用量 (2.1)：二维超引力耦合的标量超多重态 `[A^μ, χ^μ, F^μ]`，规范 (2.7) `e^a_m = η^a_m, ψ_m = 0`。
- 模展开 (2.17)：`k` 取整数（R）/半整数（NS）；鬼零模 `η₀, η̄₀`（c₀/b₀ 型）与（R 扇区）`ζ₀, ζ̄₀`（γ₀/β₀ 型）；`{η₀, η̄₀} = 1`，`[ζ_k, ζ̄_l] = δ_{k,−l}`（(2.20)）。R 扇区 `b₀^μ` 满足 Clifford 代数 (2.21)，`b₀^μ = −(i/√2)Γ^μ` (2.22)。
- 截距 `α₀^NS`、`α₀^R` 作为正规序常数进入 `L^NS`、`L^R`（(3.3)(3.5) 末项 `−α₀/√π`），p.943 逐字「The parameters, α₀^NS and α₀^R, are undetermined so far.」

## 2. 陈述

### E1 BRS 荷的零模分解（(3.2)、(3.4)）
- 逐字 (3.2)：`Q_B^NS = η₀ L^NS + η̄₀ M^NS + √(κ/π) Q̃_B^NS`；(3.4)：`Q_B^R = η₀ L^R + η̄₀ M^R + ζ₀ F + ζ̄₀ K + √(κ/π) Q̃_B^R − (1/√π) η̄₀ ζ₀²`。
- 备注：与 LZ 1989 Prop 1.7(x)(xi)（归给 Ohta）同型：`Kc₀ + Mb₀ + D_Rγ₀ + Nβ₀ + Q₀ + b₀γ₀²`。末项 `η̄₀ζ₀²` = `b₀γ₀²`。

### E2 ★ 幂零条件（(3.8)–(3.10)）
- 逐字 (3.8)：`(Q_B^NS)² = (1/π)Σ_{n=1}^∞ ((D−10)/8 · n³ + (16α₀^NS − D + 2)/8 · n) η_n†η_n + (1/π)Σ_{r=1/2}^∞ ((D−10)/2 · r² + (16α₀^NS − D + 2)/8) ζ_r†ζ_r`；
  (3.9)：`(Q_B^R)² = (1/π)Σ_{n=1}^∞ ((D−10)/8 · n³ + 2α₀^R n) η_n†η_n + (1/π)Σ_{n=1}^∞ ((D−10)/2 · n² + 2α₀^R) ζ_n†ζ_n + (1/π) α₀^R ζ₀²`。
- (3.10) 逐字：「Thus the nilpotency of the BRS charges, which means the vanishing of the conformal anomaly, demands D = 10 and α₀^NS = 1/2 for the NS model, D = 10 and α₀^R = 0 for the R model.」
- 紧随逐字：「These conditions are necessary to prove the no-ghost theorem in the next section.」
- 文献自称："demands"（⟹）。**但 (3.8)(3.9) 的显式系数形式使 ⟺ 一眼可见**（各系数独立为零 ⟺ D = 10 且 α₀ 取值）。
- 备注：R 扇区 (3.9) 末项 `α₀^R ζ₀²` 含 βγ 零模——`α₀^R = 0` 同时消掉它。

### E3 Fock 空间与 R 扇区零模表示（(3.11)–(3.15)）
- (3.12)（NS，「As discussed in Ref. 1)」）：`{|−⟩, |+⟩ ≡ η₀|−⟩}`，`η̄₀|−⟩ = 0`。
- (3.14)（R）逐字：「Since ζ₀ and ζ̄₀ are bosonic variables, the representation with respect to them is infinitely degenerate,¹⁹⁾ `{|0⟩_ζ, |1⟩_ζ (≡ ζ₀|0⟩), |2⟩_ζ (≡ ζ₀|1⟩), ⋯}` with `ζ̄₀|0⟩_ζ = 0`」。
- (3.15)：`|Φ⟩^R_{±,n} = |Φ⟩^R × |±⟩ × |n⟩_ζ`。
- 备注：**`ζ̄₀`（β₀ 型）湮灭真空、`ζ₀`（γ₀ 型）生成 ⇒ 与 FOK 所称 "Henneaux representation" `C[γ₀]` 同一选择**（即 R 扇区 −½ picture，换算为推断）。

### E4 度规算子与内积（(3.16)–(3.21)）
- (3.18) `G^NS = η₀`；**(3.19) `G^R = η₀ × δ(ζ₀)`**；归一化 (3.20)(3.21)。逐字：「We introduce suitable metric operators G^NS and G^R to define inner product of the states:¹⁹⁾ … Then the states have usual norm of |Φ⟩.」
- 备注：R 扇区用 **δ(ζ₀) 型度规**处理 βγ 零模——与 KKM 2010 (3.5) `G^(0) = ψ⁺δ(γ)δ(γ)ψ⁺` 同一思路；与 LZ 1989 Definition 2.11 的 `√−1⟨u, v̂⟩` 是同一问题的两种解法。

### E5 物理态条件（(3.22)–(3.26)）
- NS：(3.22) `L^NS|phys⟩ = 0`，(3.23) `Q̃_B^NS|phys⟩ = 0`。
- R：(3.24) `F|phys⟩ = 0`，(3.25) `Q̃_B^R|phys⟩ = 0`；「Note that the condition L^R|phys⟩ = 0 is automatically satisfied under condition (3.24) because L^R = √π F².」
- 逐字：「These conditions are deduced from the usual physical state condition,²⁰⁾ Q_B|phys⟩ = 0, when we restrict the Fock spaces as¹⁹⁾ `|Φ⟩^NS_− = |Φ⟩ × |−⟩`，`|Φ⟩^R_{−,0} = |Φ⟩ × |−⟩ × |0⟩_ζ`」(3.26)。
- 备注：= `b₀|ψ⟩ = 0`（两扇区）与 `β₀|ψ⟩ = 0`、`F₀|ψ⟩ = 0`（R）——即 LZ 1989 Definition 2.2 的 `Ker b₀ ∩ Ker β₀ ∩ Ker K ∩ Ker D_R`。

### E6 ★ 无鬼定理（§4，Proposition I、II，(4.21)）
- p.945 逐字：「In this section we prove the positive semi-definiteness of the physical subspace. The procedure is similar to that in Ref. 1) in the bosonic string case. **We prove the no-ghost theorem for the R model. The proof for the NS model goes in a quite similar manner, and we will comment on it later.**」
- 结构（式号）：光锥参考系 (4.3)–(4.5)（`p^i = 0`，`p⁺` 固定，零矢 `k`，`k·p = 1`）；与 `F` 对易的重定义模 (4.6)–(4.7)；β 重标度 (4.9)（「¹⁾」）；`Q̃_B^R(β) = Q_I^R + βQ_II^R + β²Q_III^R` (4.10)–(4.11)；(4.13) `(Q_I)² = (Q_III)² = 0, {Q_I, Q_III} + (Q_II)² = −(π/κ)(M^R L^R − KF)` 等；β 阶展开 (4.15)–(4.16)。
- **Proposition I** 逐字：「Any state |φ⟩ in V_F satisfying Q_I^R|φ⟩ = 0 can be written as |φ⟩ = P^(0)|φ⟩ + Q_I^R|ρ⟩」(4.17)，`P^(0)` (4.18) 为横向模 `A^i_n†, B^i_n†` 生成子空间的投影。
- **Proposition II** 逐字：「Any state |φ(β)⟩ in V_F satisfying (4.14) can be written as |φ(β)⟩ = P(β)|φ(β)⟩ + Q̃_B^R(β)|J(β)⟩」(4.19)，`P(β)` (4.20) 为横向算子 `Ã^i_n†(β), B̃^i_n†(β)`（(A.7)，引 Brower–Friedman [21]）生成的横向扇区投影。
- (4.21) 逐字：「We put β = 1 in (4.19), then we see that the norm of the physical state |φ⟩ is positive semi-definite, `⟨φ|φ⟩ = ⟨φ|P|φ⟩ ≥ 0`, where the last inequality follows from the positive definiteness of the transverse state space.²¹⁾ This completes the proof.」
- NS 扇区（p.947）：只一段评论——「Conditions (4.1) and (4.2) should respectively be replaced by (4.22) L^NS|phys⟩ = 0, (4.23) Q̃_B^NS|phys⟩ = 0. … We get the similar propositions, and then we can complete the proof.」**无显式证明。**
- 证明（Appendix）：Prop I 用 Kugo–Ojima quartet（(A.1)–(A.6)，逐字「we can follow the usual procedure developed by Kugo and Ojima²⁰⁾」，`P^(n) = {Q_I^R, R^(n)}` (A.3)）；Prop II 按 n 归纳 (A.13)–(A.19)，逐字「Now we can prove Proposition II by the same method in Ref. 1).」；横向算子对易性 (A.10) `[Q̃_B^R(β), Ã^i_n(β)] = 0`；正定性 (A.9)。
- 文献自称："we prove"。**隐含假设**：`p⁺ ≠ 0`（(4.3)–(4.5)）；`|φ(β)⟩` 可按 β 展开（(4.16) 逐字「we have assumed that |φ(β)⟩ can be expanded in β」）；横向态空间正定引 [21]。

### E7 ★ Note added（p.952）
- 逐字：「After completion of this work we received a preprint²³⁾ from Ohta, in which the same subject is treated. However, the quantization method of the lagrangian is a little different and he did not present the proof of the no-ghost theorem in the Ramond sector.」[23] 逐字「N. Ohta, Texas Preprint UTTG 30-85.」
- 备注：见 `ohta-1986.md` §0.1。

### E8 §5 结论中的自评
- p.948 逐字：「The structure of the BRS charges is peculiar. Q̃_B, rather than Q_B itself, corresponds to BRS charges in ordinary gauge theories, which will be clear from the proof of the no-ghost theorem.」
- 「In that case we must restrict the ground states of both the NS and the R sectors with the generalized G-parity and chirality operators¹⁰⁾ according to Ref. 22).」（GSO，[10] = Terao–Uehara PLB 168B；与 LZ p.329 Remark 一致）。

## 3. 参考文献里的钥匙（L1）

[1] Kato–Ogawa NPB B212 443；[9] Schwarz CALT-68-1304；[10] Terao–Uehara PLB 168B 70；[19] Terao–Uehara Hiroshima RRK 85-24（零模表示与度规的出处）；[20] Kugo–Ojima PTP Suppl. 66 (1979) 1（quartet）；[21] Brower–Friedman PRD 7 (1973) 535；[22] GSO；[23] Ohta UTTG 30-85。**不引 Henneaux、FGZ。**

## 4. 未解决的疑问

- Q1：NS 扇区证明只有评论（p.947），严格说本文只**证**了 R 扇区。
- Q2：[19] Terao–Uehara RRK 85-24「to be published in Z. Phys. C」——是否即 PLB 168B 或另一篇，未核。
- Q3：(3.19) `δ(ζ₀)` 度规下 `Q̃_B^R` 是否厄米？本文未讨论（FOK 对 Henneaux 表示的批评同样适用）。

## 5. 对图的建议

- `no-ghost-theorem-superstring`（physical-argument 层）：**R 扇区 source 用本文 §4 Prop I/II + (4.21)**；NS 扇区本文只有评论，NS 的物理来源仍是 Ohta（L2）。
- 超弦 `Q² = 0 ⟺ D = 10, α₀`：(3.8)–(3.10) 是显式系数公式的 L1 来源（LZ Prop 1.7(ii) 的 iff 在此可读出），可挂 `physical-argument`（形式算子平方，未处理良定义性）。
- 「BRST 物理态条件 = 相对复形」：(3.22)–(3.26) 是物理侧的 L1 陈述，与 LZ Def 2.2 对照。
- 「R 扇区 βγ 零模表示 `C[γ₀]` + δ(γ₀) 度规」：(3.14)、(3.19) 是物理侧 L1；与 FOK Henneaux 表示、LZ `T₀ ⊕ T₁` 对照建卡。
- **对 `kato-ogawa-1983` 的反推**：本文 §4 + Appendix 是 KO 证明结构的最可靠 L3（五处「Ref. 1)」）。
