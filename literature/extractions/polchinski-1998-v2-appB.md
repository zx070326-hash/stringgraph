# 抽取记录：polchinski-1998-v2 — Appendix B「Spinors and supersymmetry in various dimensions」（pp. 430–466）

- 文献：J. Polchinski, *String Theory, Volume II: Superstring Theory and Beyond*, Cambridge University Press.
  本轮读的是 **Cambridge Books Online 数字化本（© 1998/2001, 2005，已含 2000 年 "with corrections"）**。
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**Appendix B，pp. 430–466（37 印刷页）全附录逐页读图**
- 编号：**E 编号本文件独立重起，从 E1 开始**（与 `polchinski-1998-v2.md`、`-sec10-8.md`、`-ch12.md`、`-ch13.md` 各自独立；引用时必须写全文件名，例 `polchinski-1998-v2-appB.md#E9`）

> 状态：**全附录 L1 抽取完成（E1–E34 + Q1–Q8 + §5 图建议）。**
> ★ 本轮三条最重要的结论：
> 1. **Table B.1（Majorana / Weyl / Majorana–Weyl 按 `d` mod 8）已逐字转录（E9），且 min. rep. 列与正文的 mod-4 规则已独立复算全部吻合**（§0.3）。
> 2. **App. B 的 BPS 界 (B.2.39) `m ≥ q_i` 只对「点粒子可携带的荷」成立**，原文明写「Including charges that can be carried by *extended objects*, additional terms appear … we introduce it … first in section 11.6, and then in more variety in chapter 13. **The same caveat applies to the higher-dimensional algebras**」（E21）⇒ `branes.d-brane-bps-no-force` 不能把 BPS 界整体外包给 App. B（Q3）。
> 3. **否定结论：App. B 里没有 SO(8) 三重性、没有 `8_s`/`8_c` 记号、没有 SO(8) 意义下的 `56`、没有 R 扇区零模 `ψ_0^μ`**（§3.2）。附录的 SO(8) 记号只有 `8_v`、`8`、`8′`，而且 **p.457 写 `8_v + 8′`、习题 B.5 写 `8_v + 8`，同一个 type I 无质量开弦多重态两个标签**（Q1）。

---

## 0. 获取路线与证据等级

### 0.1 取件

- URL（直接推出，**一次命中**，未先 fetch abs 页）：
  `https://www.cambridge.org/core/services/aop-cambridge-core/content/view/872CC69E98F684AFA1019EB2A955BD11/9780511618123apx1_p430-466_CBO.pdf/appendix_b_spinors_and_susy_in_various_dimensions.pdf`
- item hash `872CC69E98F684AFA1019EB2A955BD11`，文件名 **`9780511618123apx1_p430-466_CBO.pdf`**（Vol.2 唯一的附录也用 `apx1` 前缀，与 Vol.1 App. A 相同），**545.6 KB / 37 页（≈14.7 KB/页）**。
- **PDF 页号 = 印刷页号 − 429**（PDF p.1 = 印刷 p.430，已用页眉逐页核对）。
- 页脚版本锚定（逐字抄一行）：
  `Downloaded from https://www.cambridge.org/core. Zhejiang University, on 11 Sep 2026 … Cambridge Books Online © Cambridge University Press, 2010 … https://doi.org/10.1017/CBO9780511618123.014`
  ⇒ **App. B 的 DOI 后缀是 `.014`**。
- 读法：37 页分 4 批（1–10 / 11–20 / 21–30 / 31–37）通读，再对 **PDF p.5（印刷 p.434，Table B.1）与 PDF p.28（印刷 p.457，type I 多重态与 SO(32)/E8×E8 句）做单页重渲染**核对，两页读数与首轮一致。

### 0.2 证据等级

本文件除另有标注外，**全部为 L1（一手原书页图）**。凡是「抽取者补的」「原书没写」的推断，一律在条目里显式标出。
**附录全文零文献引用**（无 "(Author, year)"、无编号引文；只有三处泛指 "the references"），与全书体例一致。

### 0.3 本轮做过的独立复算（六条，全部通过）

**(a) ★ Table B.1 的 min. rep. 列 vs 正文规则 ✅（11 行逐行）**
正文规则（p.433–434）：实参数数 = 2 × Dirac 维数（`2^{k+1}`，`d = 2k+2` 或 `2k+3`），可加 Weyl 条件则 ÷2，可加 Majorana 条件则 ÷2。
`d=2`(k=0): 2·2=4 → Weyl ÷2 → Majorana ÷2 = **1** ✅；`d=3`: 4 → Majorana = **2** ✅；`d=4`(k=1): 8 → Weyl 或 Majorana（不能同时）= **4** ✅；
`d=5`: 8，两者皆不可 = **8** ✅；`d=6`(k=2): 16 → Weyl = **8** ✅；`d=7`: **16** ✅；`d=8`(k=3): 32 → 二选一 = **16** ✅；`d=9`: 32 → Majorana = **16** ✅；
`d=10`(k=4): 64 → Weyl → Majorana = **16** ✅；`d=11`: 64 → Majorana = **32** ✅；`d=12`(k=5): 128 → 二选一 = **64** ✅。

**(b) ★ Majorana 的 mod-4 规则 ⇒ Table B.1 的 Majorana/M–W 两列 ✅**
由 (B.1.21)：`B_1` 可用 iff `k(k+1)/2` 偶 iff `k ≡ 0, 3 (mod 4)`；`B_2` 可用 iff `k(k−1)/2` 偶 iff `k ≡ 0, 1 (mod 4)`。
偶 `d = 2k+2`：任一 `B` 可用 iff `k ≡ 0,1,3` iff **`d ≡ 2, 4, 0 (mod 8)`**（表：d=2,4,8,10,12 yes；d=6 no）✅。
奇 `d = 2k+3`（只允许 `B_1`，p.433）：`k ≡ 0,3` iff **`d ≡ 3, 1 (mod 8)`**（表：d=3,9,11 yes；d=5,7 no）✅。
并集 `d ≡ 0,1,2,3,4 (mod 8)` = 正文 p.433 逐字「a Majorana condition is possible if d = 0, 1, 2, 3, or 4 (mod 8)」✅。
Majorana–Weyl 需 `B*B = 1` **且** Weyl 自共轭（`k` 偶，(B.1.19)）⇒ `k ≡ 0 (mod 4)` ⇒ **`d ≡ 2 (mod 8)`** = 表中仅 d=2, 10 ✅。

**(c) 十一维与 IIB 的态数 ✅**
`½·9·10 − 1 = 44`，`9·8·7/3! = 84`，`44 + 84 = 128`；费米 `16·9 − 16 = 128`（p.453）✅。(B.5.6) `2+35+28+28+35 = 128` ✅。

**(d) Table B.3 的 scalars/vectors 两列 vs (B.5.7)(B.5.8) 与正文的 Poincaré 对偶补项 ✅（9 行逐行）**
`d=4`(k=7)：`28 + 35 + 7 = 70`，vectors `7 + 21 = 28` ✅（且与 p.448 `N=8` 多重态的 `0^{70}`、`1^{28}` 吻合）；
`d=5`(k=6)：`21+20+1 = 42`、`6+15+6 = 27` ✅；`d=3`(k=8)：`36+56+28+8 = 128` ✅；`d=6`：`15+10=25`、`5+10+1=16` ✅；
`d=7`：`10+4=14`、`4+6=10` ✅；`d=8`：`6+1=7`、`3+3=6` ✅；`d=9`：`3`、`2+1=3` ✅；`10A`：`1`、`1` ✅。

**(e) `N=8` 多重态总数**：`1+8+28+56+70+56+28+8+1 = 256 = 2^8` ✅（p.448）。

**(f) (B.6.3) `16 → (4,2) + (4′,2′)`**：`8 + 8 = 16` ✅；(B.6.4) 每行 4 个态 ✅。

---

## 1. 约定（App. B 内实际用到的）

1. **号差**：`(d−1, 1)`，`η^{μν} = diag(−1, +1, …, +1)`（p.430 逐字：「To be specific we will take signature (d − 1, 1)」）。与全书一致。
   ⚠ **`d` 与 `D` 的区分**（p.430 逐字）：「Throughout this appendix the dimensionality of spacetime is denoted by `d`; we generally reserve `D` to designate the total spacetime dimensionality of a string theory.」
2. **Clifford 代数归一化**：(B.1.1) `{Γ^μ, Γ^ν} = 2η^{μν}`。
3. **Lorentz 生成元**：(B.1.8) `Σ^{μν} = −(i/4)[Γ^μ, Γ^ν]`，代数 (B.1.9)。
4. **Dirac 共轭**：(B.1.29) `ζ̄χ = ζ†Γ^0χ`；`Q̄ ≡ Q†Γ^0 = Q^T C`（p.440）。
5. **Majorana 条件**：(B.1.20) `ζ* = Bζ`，`B = B_1` 或 `B_2`（(B.1.16)）。
6. **荷共轭矩阵**：(B.1.24) `CΓ^μC^{−1} = −Γ^{μT}`；(B.1.27) `C = B_1Γ^0`（`d = 2 mod 4`）、`C = B_2Γ^0`（`d = 4 mod 4`）；奇 `d` 只有 `C = B_1Γ^0`。
7. **表示的记号**：以黑体维数标记，另一手征加撇（`2, 2′`；`16, 16′`；SO(8) 用 `8_v, 8, 8′`）。p.433 逐字：「Thus in `d = 4` we can designate the representations as **2** and **2̄** rather than **2** and **2′**, but in `d = 10`, only as **16** and **16′**」。
   ⚠ **附录从不出现 `8_s`、`8_c`**（§3.2）。
8. **`s` 基**：`s ≡ (s_0, s_1, …, s_k)`，`s_a = ±½`（(B.1.5)），`S_a` 定义 (B.1.10)；`U(1)` 荷归一化为 `2Σ S_a`（p.438）。
9. **SUSY 代数符号**：(B.2.1a) `{Q_α, Q̄_β} = −2P_μΓ^μ_{αβ}`，p.440 逐字：「The minus sign is due to our metric signature (− + … +)」。
10. **微分形式**：(B.4.1) 楔积含 `(p+q)!/(p!q!)`、(B.4.3) `(dA_p) = (p+1)∂_{[μ_1}A_{…]}`、(B.4.6) Hodge 星、(B.4.8) `A_p = (1/p!)A_{μ_1…μ_p}dx^{μ_1}…dx^{μ_p}`；`p`-形式作用量归一化 (B.4.12) `−½∫d^dx(−G)^{1/2}|F_{p+2}|²`，`|F|² ≡ (1/(p+2)!)F_{μ…}F^{μ…}`。
11. **`κ`**：(B.2.28) 四维 `1/(2κ²)R`；(B.5.2) 十一维 `S_{11} = (1/2κ²)∫d^{11}x(−G)^{1/2}(R − ½|F_4|²) − (1/12κ²)∫A_3∧F_4∧F_4`。
12. **`α'` 在本附录里完全不出现**。
13. 与 `graph/conventions/` 的对照：本附录只用到号差约定（与 canonical 一致）；**Clifford 归一化 `{Γ,Γ} = 2η` 与 Σ 的 `−i/4` 若图里有 `conv.clifford-*` 节点应指到 (B.1.1)/(B.1.8) p.430–431**（本轮 grep `graph/` 未见此类约定节点）。

---

## 2. 陈述（E1 起）

### E1 结构与页码表（本附录的"目录"，供后人定位）
- 位置：pp. 430–466 通读所得（节标题与起始印刷页均逐页核对）
- 类型：元数据

| 节 / 小节 | 起始印刷页 | 备注 |
|---|---|---|
| 附录导言（无编号） | 430 | 「Results about spinors and supersymmetry in various spacetime dimensions are used throughout this volume. This appendix provides an introduction …」 |
| **B.1 Spinors in various dimensions** | 430 | (B.1.1)–(B.1.15) |
|  └ *Majorana spinors* | 432 | (B.1.16)–(B.1.28)；**Table B.1 在 p.434** |
|  └ *Product representations* | 435 | (B.1.29)–(B.1.38) |
|  └ *Spinors of SO(N)* | 437 | **Table B.2 在 p.437**；(B.1.39)–(B.1.41) |
|  └ *Decomposition under subgroups* | 438 | (B.1.42)–(B.1.53) |
| **B.2 Introduction to supersymmetry: d = 4** | 439 | |
|  └ *d = 4, N = 1 supersymmetry* | 440 | (B.2.1)–(B.2.12) |
|  └ *Actions with d = 4, N = 1 SUSY* | 442 | (B.2.13)–(B.2.22) |
|  └ *Spontaneous supersymmetry breaking* | 444 | (B.2.23)–(B.2.27) |
|  └ *Higher corrections and supergravity* | 445 | (B.2.28)–(B.2.34)；脚注 1 |
|  └ *Extended supersymmetry in d = 4* | 447 | (B.2.35)–(B.2.39)；脚注 2；★ BPS 界 (B.2.39) p.449 |
| **B.3 Supersymmetry in d = 2** | 449 | (B.3.1) |
| **B.4 Differential forms and generalized gauge fields** | 450 | (B.4.1)–(B.4.17) |
| **B.5 Thirty-two supersymmetries** | 452 | |
|  └ *d = 11 supergravity* | 453 | (B.5.1)(B.5.2)；脚注 3 |
|  └ *d = 10 IIA supergravity* | 453 | (B.5.3)(B.5.4) |
|  └ *d = 10 IIB supergravity* | 454 | (B.5.5)(B.5.6) |
|  └ *d < 10 supergravity* | 454 | **Table B.3 在 p.455**；(B.5.7)–(B.5.12) |
| **B.6 Sixteen supersymmetries** | 457 | |
|  └ *d = 10, N = 1 (type I) supergravity* | 457 | ★ 无式号；`8_v + 8′`；SO(32)/E8×E8 句 |
|  └ *d < 10 supergravity* | 457 | (B.6.1)(B.6.2) |
|  └ *d = 6, N = 2 supersymmetry* | 458 | (B.6.3)–(B.6.11) |
|  └ *d = 4, N = 4 gauge theory* | 459 | (B.6.12)–(B.6.19)；★ (B.6.13) 十维 SYM |
| **B.7 Eight supersymmetries** | 461 | |
|  └ *d = 6, N = 1 supersymmetry* | 461 | (B.7.1)–(B.7.9)；脚注 4 |
|  └ *d = 4, N = 2 supersymmetry* | 463 | (B.7.10)–(B.7.20) |
| **Exercises B.1–B.5** | 466 | 5 道，见 E34 |
| 表 | B.1 p.434 / B.2 p.437 / B.3 p.455 | |
| 脚注 | 1 (p.445) / 2 (p.447) / 3 (p.453) / 4 (p.462) | 共 4 条 |

- 备注：**附录零文献引用**；"the references" 泛指出现 3 次（p.452、p.465 ×1、p.440 "we simply cite for reference"）。

---

### E2 Clifford 代数与号差
- 位置：§B.1, eq. (B.1.1), p.430
- 类型：definition
- 原文陈述（逐字）：「We develop first the Dirac matrices, which represent the Clifford algebra
  `{Γ^μ, Γ^ν} = 2η^{μν}` . (B.1.1)
  We then go on to representations of the Lorentz group. To be specific we will take signature `(d − 1, 1)`, so that `η^{μν} = diag(−1, +1, …, +1)`. The extension to signature `(d, 0)` (and to more than one timelike dimension) will be indicated later.」
- 文献自称的严格程度：定义
- 文献列出的依赖：无
- 备注：**这是图上 `rns-ramond-zero-modes-clifford` 所需 Clifford 关系的 canonical 定义位置**；但注意 App. B 全文不提 `ψ_0^μ`（§3.2 第 4 条），零模 ↔ Γ 矩阵的对应必须另引 ch.10。

### E3 Dirac 表示的构造：升降算子与 `s` 基，维数 `2^{k+1}`
- 位置：§B.1, eqs. (B.1.2a,b)(B.1.3a,b)(B.1.4)(B.1.5), pp.430–431
- 类型：proposition（构造）
- 原文陈述：偶维 `d = 2k+2`，把 `Γ^μ` 分成 `k+1` 组反对易升降算子
  `Γ^{0±} = ½(±Γ^0 + Γ^1)` (B.1.2a)，`Γ^{a±} = ½(Γ^{2a} ± iΓ^{2a+1})`, `a = 1,…,k` (B.1.2b)；
  `{Γ^{a+}, Γ^{b−}} = δ^{ab}` (B.1.3a)，`{Γ^{a+}, Γ^{b+}} = {Γ^{a−}, Γ^{b−}} = 0` (B.1.3b)；
  「In particular, `(Γ^{a+})² = (Γ^{a−})² = 0`. It follows that by acting repeatedly with the `Γ^{a−}` we can reach a spinor annihilated by all the `Γ^{a−}`, `Γ^{a−}ζ = 0` for all `a`. (B.1.4)
  Starting from `ζ` one obtains a representation of dimension `2^{k+1}` by acting in all possible ways with the `Γ^{a+}`, at most once each. We will label these by `s ≡ (s_0, s_1, …, s_k)`, where each of the `s_a` is `±½`:
  `ζ^{(s)} ≡ (Γ^{k+})^{s_k+1/2} … (Γ^{0+})^{s_0+1/2} ζ` . (B.1.5)」
- 文献自称的严格程度：「It follows that」「one obtains」（构造性论证）
- 文献列出的依赖：(B.1.1)
- 备注：无。

### E4 Γ 矩阵的显式迭代表示
- 位置：§B.1, eqs. (B.1.6)(B.1.7a,b), p.431
- 类型：definition（显式基）
- 原文陈述：`d = 2`：`Γ^0 = [[0,1],[−1,0]]`，`Γ^1 = [[0,1],[1,0]]` (B.1.6)。`d = 2k+2`：
  `Γ^μ = γ^μ ⊗ [[−1,0],[0,1]]`, `μ = 0,…,d−3` (B.1.7a)；`Γ^{d−2} = I ⊗ [[0,1],[1,0]]`，`Γ^{d−1} = I ⊗ [[0,−i],[i,0]]` (B.1.7b)，
  「with `γ^μ` the `2^k × 2^k` Dirac matrices in `d − 2` dimensions and `I` the `2^k × 2^k` identity. The `2 × 2` matrices act on the index `s_k`, which is added in going from `2k` to `2k + 2` dimensions.」
- 文献自称的严格程度：定义
- 备注：**这是可直接形式化的显式构造**（见 §5）。

### E5 Lorentz 生成元与 `s` 基的旋量性质
- 位置：§B.1, eqs. (B.1.8)(B.1.9)(B.1.10), p.431
- 类型：proposition
- 原文陈述：`Σ^{μν} = −(i/4)[Γ^μ, Γ^ν]` (B.1.8) 满足 `SO(d−1,1)` 代数
  `i[Σ^{μν}, Σ^{σρ}] = η^{νσ}Σ^{μρ} + η^{μρ}Σ^{νσ} − η^{νρ}Σ^{μσ} − η^{μσ}Σ^{νρ}` (B.1.9)。
  `S_a ≡ i^{δ_{a,0}}Σ^{2a,2a+1} = Γ^{a+}Γ^{a−} − ½` (B.1.10)，「so `ζ^{(s)}` is a simultaneous eigenstate of the `S_a` with eigenvalues `s_a`. The half-integer values show that this is a spinor representation. The spinors form the `2^{k+1}`-dimensional *Dirac* representation of the Lorentz algebra `SO(2k+1, 1)`.」
- 文献自称的严格程度：直接陈述（「satisfy」）
- 文献列出的依赖：E3

### E6 手征矩阵 Γ、Weyl 分解、奇维数
- 位置：§B.1, eqs. (B.1.11)–(B.1.15), p.432
- 类型：proposition
- 原文陈述：`Γ = i^{−k}Γ^0Γ^1…Γ^{d−1}` (B.1.11)；`(Γ)² = 1`, `{Γ, Γ^μ} = 0`, `[Γ, Σ^{μν}] = 0` (B.1.12)；「The conventional notation for `Γ` in `d = 4` is `Γ_5`, but this is inconvenient in general `d`.」`Γ = 2^{k+1}S_0S_1…S_k` (B.1.13)；
  「The `2^k` states with `Γ` eigenvalue (*chirality*) `+1` form a *Weyl* representation of the Lorentz algebra, and the `2^k` states with eigenvalue `−1` form a second, inequivalent, Weyl representation.」
  `4_Dirac = 2 + 2′` (B.1.14)；**`32_Dirac = 16 + 16′`** (B.1.15)。
  奇维（p.432 逐字）：「For an odd dimension `d = 2k+3`, simply add `Γ^d = Γ` or `Γ^d = −Γ` to the `Γ` matrices for `d = 2k+2`. This is now an irreducible representation of the Lorentz algebra, because `Σ^{μd}` anticommutes with `Γ`. Thus there is a single spinor representation of `SO(2k+2, 1)`, which has dimension `2^{k+1}`.」
- 文献自称的严格程度：直接陈述；「inequivalent」未给证明
- 备注：**(B.1.15) 是图上「十维 `16`/`16′`」标签的定义位置**。

### E7 Dirac 表示的唯一性主张与 `B` 矩阵
- 位置:§B.1 *Majorana spinors*, eqs. (B.1.16)–(B.1.19), pp.432–433
- 类型：proposition
- 原文陈述（逐字）：「The above construction of the irreducible representation of the `Γ` matrices **shows that** in even dimensions `d = 2k+2` it is **unique up to a change of basis**. The matrices `Γ^{μ*}` and `−Γ^{μ*}` satisfy the same Clifford algebra as `Γ^μ`, and so must be related to `Γ^μ` by a similarity transformation.」
  `B_1 = Γ^3Γ^5…Γ^{d−1}`, `B_2 = ΓB_1` (B.1.16)；`B_1Γ^μB_1^{−1} = (−1)^kΓ^{μ*}`, `B_2Γ^μB_2^{−1} = (−1)^{k+1}Γ^{μ*}` (B.1.17)；
  「For either `B_1` or `B_2` (and only for these two matrices), `BΣ^{μν}B^{−1} = −Σ^{μν*}` (B.1.18).」
  `B_1ΓB_1^{−1} = B_2ΓB_2^{−1} = (−1)^kΓ*` (B.1.19)，「so that either form for `B` will change the eigenvalue of `Γ` when `k` is odd and not when it is even. For `k` even (`d = 2 mod 4`) each Weyl representation is its own conjugate. For `k` odd (`d = 0 mod 4`) each Weyl representation is conjugate to the other.」
- 文献自称的严格程度：「shows that … unique」（唯一性只给一句话论证）；「one finds by anticommutation」
- 备注：**唯一性没有定理编号、没有证明细节**；要 `rigorous` 需数学来源（§5）。

### E8 ★ Majorana 条件的存在性：mod-4 / mod-8 规则
- 位置：§B.1, eqs. (B.1.20)(B.1.21) + 正文 p.433
- 类型：proposition
- 原文陈述（逐字）：「`ζ* = Bζ` (B.1.20) with `B` satisfying (B.1.18). Taking the conjugate gives `ζ = B*ζ* = B*Bζ`, so such a condition is consistent if and only if `B*B = 1`. Using the reality and anticommutation properties of the `Γ`-matrices one finds
  `B_1^*B_1 = (−1)^{k(k+1)/2}`, `B_2^*B_2 = (−1)^{k(k−1)/2}` . (B.1.21)
  A Majorana condition using `B_1` is therefore possible only if `k = 0 (mod 4)` or `3 (mod 4)`, and using `B_2` only if `k = 0 (mod 4)` or `1 (mod 4)`. If `k = 0 (mod 4)` both conditions are possible but they are physically equivalent, being related by a similarity transformation.
  A Majorana condition can be imposed on a Weyl spinor only if `B*B = 1` *and* the Weyl representation is conjugate to itself. For `k` odd, which is `d = 0` or `4 (mod 8)`, it is therefore not possible to impose both the Majorana and Weyl conditions on a spinor: one can impose one or the other. Precisely for `k = 0 mod 4`, which is `d = 2 (mod 8)`, a spinor can simultaneously satisfy the Majorana and Weyl conditions. Majorana–Weyl spinors in `d = 10` play a key role in the spacetime theory of the superstring, and Majorana–Weyl spinors in `d = 2` (`ψ^μ` and `ψ̃^μ`) play a key role on the world-sheet.
  Extending to odd dimensions, `Γ^d = ±Γ`, and so the conjugation (B.1.19) of `Γ^d` is compatible with the conjugation (B.1.17) of the other `Γ^μ` only for `B_1`, so that `k = 0` or `3 (mod 4)`. **In all, a Majorana condition is possible if `d = 0, 1, 2, 3`, or `4 (mod 8)`.** When the Majorana condition is allowed, there is a basis in which `B` is either `1` or `Γ` and so commutes with all the `Σ^{μν}`. In this basis the `Σ^{μν}` are imaginary.」
- 文献自称的严格程度：「one finds」「therefore」（推导链完整但 (B.1.21) 的计算未展开）
- 文献列出的依赖：E7
- 备注：**抽取者已独立复算 (B.1.21) ⇒ 表 B.1 三列全部吻合（§0.3b）。**

### E9 ★★ Table B.1（逐字转录）与「mod 8 周期性」句
- 位置：§B.1, **Table B.1, p.434**；表前后正文 pp.433–434
- 类型：proposition（汇总表）
- 表前正文（p.433 逐字）：「All these results are summarized in the table B.1. The number of real parameters in the smallest representation is indicated in each case. This is twice the dimension of the Dirac representation, reduced by a factor of 2 for a Weyl condition and 2 for a Majorana condition. The derivation」（接 p.434）「implies that the properties are periodic in `d` with period 8, except the dimension of the representation which increases by a factor of 16.」
- **表题（逐字）**：「Table B.1. *Dimensions in which various conditions are allowed for `SO(d − 1, 1)` spinors. A dash indicates that the condition cannot be imposed. For the Weyl representation, it is indicated whether these are conjugate to themselves or to each other (complex). The final column lists the smallest representation in each dimension, counting the number of real components. Except for the final column the properties depend only on `d` mod 8.*」
- **表体（逐字，含原书的 `10=2+8` 写法）**：

| `d` | Majorana | Weyl | Majorana–Weyl | min. rep. |
|---|---|---|---|---|
| 2 | yes | self | yes | 1 |
| 3 | yes | - | - | 2 |
| 4 | yes | complex | - | 4 |
| 5 | - | - | - | 8 |
| 6 | - | self | - | 8 |
| 7 | - | - | - | 16 |
| 8 | yes | complex | - | 16 |
| 9 | yes | - | - | 16 |
| 10=2+8 | yes | self | yes | 16 |
| 11=3+8 | yes | - | - | 32 |
| 12=4+8 | yes | complex | - | 64 |

- 文献自称的严格程度：「All these results are summarized」「The derivation implies」
- 文献列出的依赖：E6、E7、E8
- 备注：(1) **单页重渲染后读数不变**（§0.1）；(2) min. rep. 列 11 行已独立复算（§0.3a）；(3) 表后 p.434 逐字补充：「For `d` a multiple of 4, a spinor may have the Majorana or Weyl property but not both: conjugation changes one Weyl representation into the other. In fact, the two cases are physically identical, there being a one-to-one mapping between them」（见 E10）。
  ⇒ **这是图上 `math.clifford-algebra-representations-mod-8` 的 loc**：`"App. B §B.1, Table B.1, p.434；规则推导 (B.1.17)–(B.1.21) pp.432–433"`。

### E10 `d ≡ 0 (mod 4)` 时 Majorana ↔ Weyl 的一一映射
- 位置：§B.1, eqs. (B.1.22)(B.1.23), p.434
- 类型：proposition
- 原文陈述：`P_± = (1 ± Γ)/2` (B.1.22)；「Given a Majorana spinor `ζ` or a Weyl spinor `χ`, the maps `ζ → P_+ζ`, `χ → χ + B*χ*` (B.1.23) give a spinor of the other type, and these maps are inverse to one another.」
- 文献自称的严格程度：直接陈述

### E11 荷共轭矩阵 `C`
- 位置：§B.1, eqs. (B.1.24)–(B.1.28), pp.434–435
- 类型：definition + proposition
- 原文陈述：`CΓ^μC^{−1} = −Γ^{μT}` (B.1.24)；厄米性 `Γ^{μ†} = Γ_μ = −Γ^0Γ^μ(Γ^0)^{−1}` (B.1.25)；`CΓ^0Γ^μ(CΓ^0)^{−1} = Γ^{μ*}` (B.1.26)；偶 `d`：`C = B_1Γ^0` (`d = 2 mod 4`)，`C = B_2Γ^0` (`d = 4 mod 4`) (B.1.27)；奇 `d = 2k+3` 只有 `C = B_1Γ^0`，`CΓ^μC^{−1} = (−1)^{k+1}Γ^{μT}`；「In all cases, `CΣ^{μν}C^{−1} = −Σ^{μνT}` (B.1.28).」
- 文献自称的严格程度：直接陈述；「Additional properties of the matrices `B` and `C` are developed in **exercise B.1**」（外包）

### E12 旋量乘积的张量分解（含 Weyl × Weyl）
- 位置：§B.1 *Product representations*, eqs. (B.1.29)–(B.1.38), pp.435–436
- 类型：proposition
- 原文陈述：(B.1.29)–(B.1.31) 双线性型；奇 `d = 2k+3`：「we claim that `ζ^TCΓ^{μ_1μ_2…μ_m}χ` (B.1.32) for `m ≤ k+1` comprise a complete set of independent tensors」，`Γ^{μ_1…μ_m} = Γ^{[μ_1}Γ^{μ_2}…Γ^{μ_m]}` (B.1.33)；(B.1.34) `Γ^{μ_1…μ_s}Γ = −(i^{−k+s(s−1)}/(d−s)!)ε^{μ_1…μ_d}Γ_{μ_{s+1}…μ_d}`；
  **`2^{k+1} × 2^{k+1} = [0] + [1] + … + [k+1]`** (B.1.35)；偶 `d`：**`2^{k+1}_Dirac × 2^{k+1}_Dirac = [0] + [1] + … + [2k+2] = [0]² + [1]² + … + [k]² + [k+1]`** (B.1.36)；
  (B.1.37) `ζ^TCΓ^{μ_1…μ_m}Γχ = (−1)^{k+m+1}(Γζ)^TCΓ^{μ_1…μ_m}χ`，「The tensor (B.1.32) is then nonvanishing if `k + m` is odd and the chiralities of `ζ` and `χ` are the same, or if `k + m` is even and the chiralities are opposite.」
  **(B.1.38a)** `2^k × 2^k = [1]+[3]+…+[k+1]_+`（`k` even）／`[0]+[2]+…+[k+1]_+`（`k` odd）；
  **(B.1.38b)** `2^{k′} × 2^{k′} = [1]+[3]+…+[k+1]_−`（`k` even）／`[0]+[2]+…+[k+1]_−`（`k` odd）；
  **(B.1.38c)** `2^k × 2^{k′} = [0]+[2]+…+[k]`（`k` even）／`[1]+[3]+…+[k]`（`k` odd）。
  「The relation (B.1.34) implies that the tensors of rank `k + 1 = d/2` satisfy a self-duality condition with a sign that depends on the chirality of the spinor. A self-dual tensor representation can only be real for `k` even.」
- 文献自称的严格程度：「we claim that」+ 维数核对（「Again the dimensionality is correct」）
- 备注：(B.1.38) 是 §B.5 p.453「The product of two spinors of the same chirality contains a vector, while the product of spinors of opposite chirality contains a scalar (eq. (B.1.38))」的依据。⚠ **注意 (B.1.38) 是 `SO(d−1,1)` 的 `2^k`，不是 SO(8) 的 `8`**；十维 `8_v × 8′ = 56 + 8` 之类 SO(8) 小群分解**本附录未写**（§3.2）。

### E13 ★ Table B.2（`SO(N)` 旋量，逐字）与 pseudoreal
- 位置：§B.1 *Spinors of SO(N)*, **Table B.2, p.437**；(B.1.39)–(B.1.41), pp.437–438
- 类型：proposition
- 表题（逐字）：「Table B.2. *Dimensions in which various conditions are allowed for `SO(N)` spinors.*」

| `N` mod 8 | real | Weyl | real and Weyl |
|---|---|---|---|
| 0 | yes | self | yes |
| 1 | yes | - | - |
| 2 | yes | complex | - |
| 3 | pseudo | - | - |
| 4 | pseudo | self | - |
| 5 | pseudo | - | - |
| 6 | yes | complex | - |
| 7 | yes | - | - |

- 正文（p.437 逐字）：「For `SO(N)` the analysis is quite parallel. For `N = 2l`, there is a `2^l`-dimensional representation of the `Γ`-matrices which reduces to two `2^{l−1}`-dimensional spinor representations of `SO(2l)`, while for `SO(2l+1)` there is a single representation of dimension `2^l`. The reality properties can be analyzed as in the Minkowski case. Essentially one ignores `μ = 0, 1`, so `SO(N)` is analogous to `SO(N+1, 1)`, with the results shown in table B.2. Here *real* means the algebra can be written in terms of purely imaginary matrices. The term *pseudoreal* is often used for `N = 3, 4, 5 mod 8`, where the representation is conjugate to itself but cannot be written in terms of imaginary matrices.」
  「two wrongs make a right — the product of two pseudoreal representations is real」；(B.1.39) `u*_{ij} = ε_{ii′}ε_{jj′}u_{i′j′}`；(B.1.40) `SO(2,1)` 的实基 `Γ^0 = iσ², Γ^1 = σ¹, Γ^2 = σ³`；(B.1.41a–c) `SO(2l)` 的 Weyl 乘积分解（形式同 (B.1.38)，`k+1 → l`）。
  p.438 逐字：「For more than one timelike dimension, the analog of table B.1 or B.2 depends on the *difference* of the number of spacelike and timelike dimensions.」（**无证明**）
- 文献自称的严格程度：「quite parallel」「analogous」（把 Minkowski 情形的推导平移，未重做）
- 备注：**SO(8) 行是 `N mod 8 = 0`：real yes / Weyl self / real and Weyl yes** ⇒ 这是 `8`、`8′` 都实且自共轭的来源；**但 SO(8) 的三重性（`8_v`、`8`、`8′` 被外自同构轮换）本附录只字未提**（§3.2）。

### E14 子群分解：`SO(9,1) → SO(3,1)×SO(6)`、`SO(2n) → SU(n)×U(1)`、`SO(4) = SU(2)×SU(2)`
- 位置：§B.1 *Decomposition under subgroups*, eqs. (B.1.42)–(B.1.53), pp.438–439
- 类型：proposition
- 原文陈述：(B.1.42) `SO(9,1) → SO(3,1) × SO(6)`；(B.1.43) `SO(2k+1,1) → SO(2l+1,1) × SO(2k−2l)`，Weyl 旋量分解 (B.1.44a) `2^k → (2^l, 2^{k−l−1}) + (2^{l′}, 2^{k−l−1′})`，(B.1.44b) `2^{k′} → (2^{l′}, 2^{k−l−1}) + (2^l, 2^{k−l−1′})`；
  (B.1.45) `SO(2n) → SU(n) × U(1)`；(B.1.46) `ζ ∈ 1_{−n}`；**(B.1.47) `2^n → [0]_{−n} + [1]_{2−n} + [2]_{4−n} + … + [n]_n`**（`[k]` 为 `SU(n)` 的 `k` 次反对称 `n`）；(B.1.48)(B.1.49a,b) `SO(6) → SU(3)×U(1)`：`4 → 1_3 + 3_{−1}`，`4̄ → 1_{−3} + 3̄_1`；
  (B.1.50) `SO(4) = SU(2)×SU(2)`，(B.1.51)(B.1.52) `x = x^4I + ix^iσ^i`，`x′ = g_1xg_2^{−1}`；(B.1.53a–c) `4 = (2,2)`, `2 = (2,1)`, `2′ = (1,2)`。
- 文献自称的严格程度：「We can directly match representations by comparing the eigenvalues of `S_a`」；`SO(4)` 分解「the decomposition of the vector is just eq. (B.1.52), while those of the spinors can be derived in various ways」
- 备注：习题 B.2 要求推广到含奇维的子群。

### E15 §B.2 `d = 4, N = 1` 代数与无质量多重态
- 位置：§B.2, eqs. (B.2.1a,b)–(B.2.8), pp.440–441
- 类型：definition + proposition
- 原文陈述：p.440 逐字「The `N = 1` supersymmetry algebra is **uniquely determined** to be
  `{Q_α, Q̄_β} = −2P_μΓ^μ_{αβ}` (B.2.1a)，`[P^μ, Q_α] = 0` (B.2.1b)」；
  无质量帧 `k_1 = k_0`：(B.2.2) `{Q_α, Q_β^†} = 2k^0(1 + Γ^0Γ^1)_{αβ} = 2k^0(1 + 2S_0)_{αβ}`；(B.2.3)；(B.2.4) 正定性论证 `0 = ⟨ψ|{Q, Q^†}|ψ⟩ = ‖Q|ψ⟩‖² + ‖Q^†|ψ⟩‖²`；(B.2.5)(B.2.6) `{b, b^†} = 1`；(B.2.7)(B.2.8)。
  「The massless irreducible multiplets thus each consist of two states with helicities differing by ½」；**CPT** 要求加共轭；多重态列表（p.441）：chiral `(0,½)+(−½,0)`、vector `(½,1)+(−1,−½)`「both necessarily in the adjoint of the gauge group」、gravitino `(1,3/2)+(−3/2,−1)`、graviton `(3/2,2)+(−2,−3/2)`；
  p.441 逐字：「Massless particles with helicities greater than 2 **are believed to be impossible** to couple to gravity, and have not arisen in string theory.」
- 文献自称的严格程度：「uniquely determined」（**无证明、无引用**——Haag–Łopuszański–Sohnius 未被提及）；表示论「It is easy to work out」
- 备注：附录导言 p.439–440 逐字自陈：「The reader should be able to follow the derivation of the various representations (massless, standard massive, and BPS massive). However, the transformations and actions require detailed calculation, and so for these **we simply cite for reference** some of the key results.」

### E16 `d = 4, N = 1` 有质量表示
- 位置：§B.2, eqs. (B.2.9)–(B.2.12), p.442
- 类型：proposition
- 原文陈述：静止系 (B.2.9) `{Q_{s_0′s_1′}, Q^†_{s_0s_1}} = 2mδ_{ss′}`，两套振子 (B.2.10a,b)，(B.2.11)(B.2.12) 生成 `λ, λ+½, λ+½, λ+1`；「the massive chiral multiplet is `λ = −½, 0, 0, ½`, the same as the CPT-extended massless multiplet. The multiplet `λ = 0, ½, ½, 1` is incomplete, even without CPT …」
- 文献自称的严格程度：直接构造

### E17 `d = 4, N = 1` 作用量、`R` 对称性、非重整化定理（**无推导**）
- 位置：§B.2 *Actions with d = 4, N = 1 SUSY*, eqs. (B.2.13)–(B.2.22), pp.442–444
- 类型：proposition（照录）
- 原文陈述：p.442 逐字「We collect these here, **without derivation**.」超场 (B.2.13a,b)；SUSY 变换 (B.2.14a–c)(B.2.15a–c)；`ℒ = ℒ_1 + ℒ_2` (B.2.16)(B.2.17)(B.2.18)；势 (B.2.19) `V = |F^i(φ)|² + (1/2g_a²)[D^a(φ,φ*)]²`，(B.2.20a,b)；`R` 对称性 (B.2.21a–c)(B.2.22) `W(φ) → exp(2iα)W(φ)`。
  p.444 逐字：「An important **nonrenormalization theorem states** that the tree-level superpotential does not receive perturbative corrections. It is also important that this is only a perturbative statement, and that there can be nonperturbative corrections to the superpotential. An example of this arises in chapter 18.」
- 文献自称的严格程度：「without derivation」；非重整化定理只「states」不证不引
- 备注：这一小节对 `branes` 区无直接用处；记录以完整覆盖。

### E18 自发超对称破缺判据
- 位置：§B.2, eqs. (B.2.23)–(B.2.27), pp.444–445
- 类型：proposition
- 原文陈述：(B.2.23) `⟨0|{Q_α, χ_β}|0⟩`；(B.2.24) `δψ^i = δλ^a = 0`；(B.2.25) `F^i(φ) = D^a(φ) = 0`；「Supersymmetry will be spontaneously broken if there are no solutions to eqs. (B.2.25)」；O'Raifeartaigh 型例子 (B.2.26)(B.2.27)（未点名）。
- 文献自称的严格程度：「it follows that」

### E19 「模空间幂计数」与 `N = 1` 超引力的玻色作用量、Kähler 变换
- 位置：§B.2 *Higher corrections and supergravity*, eqs. (B.2.28)–(B.2.34), pp.445–447；脚注 1
- 类型：proposition（照录）
- 原文陈述：p.445 引入「moduli space power counting」（标量 `l^0`、费米子 `l^{−1/2}`、保留 `l^m, m ≥ −2` 的项）；脚注 1「the effective Lagrangian will still break down at particular points in moduli space, namely those points where extra massless fields occur」。三函数 `W(Φ)`、`f_{ab}(Φ)`、`K(Φ,Φ*)`；(B.2.28) 纯玻色 `ℒ_bos/(−G)^{1/2} = (1/2κ²)R − K_{īj}D_μφ^{i*}D^μφ^j − ¼Re(f_{ab})F^aF^b − ⅛Im(f_{ab})εFF − V`；**(B.2.29)** `V = exp(κ²K)(K^{īj}W^*_{;ī}W_{;j} − 3κ²W^*W) + ½f_{ab}D^aD^b`；(B.2.30a,b)；(B.2.31) Kähler 度规；(B.2.32) `K → K + f + f^*`，(B.2.33) `W → exp(−κ²f)W`；(B.2.34a–c) 费米子变换含 gravitino `δψ_μ = D_μζ + ½Γ_μζ exp(κ²K/2)W`。
- 文献自称的严格程度：「The full Lagrangian density is quite lengthy, so we give only the purely bosonic terms」（照录）

### E20 `d = 4` 扩展超对称的多重态表
- 位置：§B.2 *Extended supersymmetry in d = 4*, eq. (B.2.35) + pp.447–448 列表；脚注 2
- 类型：proposition
- 原文陈述：(B.2.35) `{Q^A_α, Q̄^B_β} = −2δ^{AB}P_μΓ^μ_{αβ}`, `[P^μ, Q^A_α] = 0`；「This is not the most general algebra」；`N` 个振子生成 `2^N` 态。
  **`N = 2`**（p.447）：hypermultiplet `(−½, 0², ½) + (−½, 0², ½)`；vector `(−1, −½², 0) + (0, ½², 1)`；supergravity `(−2, −3/2², −1) + (1, 3/2², 2)`；「For states that are their own CPT conjugates, a half-hypermultiplet is allowed」；「It follows that an `N = 2` theory cannot have chiral gauge interactions.²」脚注 2「There is an exception to this known as gauged supergravity, but it is not relevant to the gauge interactions of the Standard Model.」
  **`N = 4`**（p.448）：vector `(−1, −½⁴, 0⁶, ½⁴, 1)`；supergravity `(−2, −3/2⁴, −1⁶, −½⁴, 0) + (0, ½⁴, 1⁶, 3/2⁴, 2)`。
  **`N = 8`**：「there is only a single possible representation: supergravity multiplet `(−2, −3/2⁸, −1²⁸, −½⁵⁶, 0⁷⁰, ½⁵⁶, 1²⁸, 3/2⁸, 2)`.」
  p.448 逐字：「Larger algebras would require helicities greater than 2, which **is believed to be impossible** (there are some uninteresting exceptions, such as free field theories). String theory has several times turned up loopholes in such statements, but not yet here.」
- 文献自称的严格程度：表示论构造；「believed to be impossible」
- 备注：⚠ **这里的 `56` 是 `d = 4, N = 8` 的螺旋度 `∓½` 态数，不是 SO(8) 的 `56` 表示**（§3.2 第 3 条、Q6）。

### E21 ★★ 中心荷与 BPS 界 (B.2.39)——**只对点粒子荷**
- 位置：§B.2, eqs. (B.2.36a,b)(B.2.37)(B.2.38)(B.2.39), pp.448–449
- 类型：proposition
- 原文陈述（逐字）：「The most general extended supersymmetry algebra allowed by Lorentz invariance is
  `{Q^A_α, Q̄^B_β} = −2δ^{AB}P_μΓ^μ_{αβ} − 2iZ^{AB}δ_{αβ}` , (B.2.36a)
  `[P^μ, Q^A_α] = [Z^{AB}, Q^C_α] = [Z^{AB}, P_μ] = [Z^{AB}, Z^{CD}] = 0` . (B.2.36b)
  Here `Z^{AB}` is some set of conserved charges. It must be antisymmetric in `AB` due to the Majorana property and the antisymmetry of the charge conjugation matrix `C`.
  **To be precise, this is the most general algebra if we include only charges that can be carried by point particles. Including charges that can be carried by *extended objects*, additional terms appear. Rather than explain this here, we introduce it in its natural physical context: first in section 11.6, and then in more variety in chapter 13. The same caveat applies to the higher-dimensional algebras to be introduced later in this appendix.**
  To see the effect of the additional term consider a particle in its rest frame, for which the algebra becomes
  `{Q^A_α, Q^{B†}_β} = 2mδ^{AB}δ_{αβ} + 2iZ^{AB}Γ^0_{αβ}` . (B.2.37)
  Taking an eigenstate of the charges `Z^{AB}`, we can go to a basis in which `Z^{AB} = [[0, q_1, 0, 0], [−q_1, 0, 0, 0], [0, 0, 0, q_2], [0, 0, −q_2, 0], …]` (B.2.38) with `q_i ≥ 0`. The left-hand side of the algebra (B.2.37) is nonnegative as a matrix in `(Aα, Bβ)`. The eigenvalues `2(m ± q_i)` on the right-hand side must therefore also be nonnegative, implying the *Bogomolnyi–Prasad–Sommerfield (BPS) bound*
  **`m ≥ q_i`** . (B.2.39)
  Thus the mass is bounded below by the charges, and in particular massless states must be neutral. If `m` is strictly greater than all the `q_i`, the massive representations are unaffected and contain `2^{2N}` states. If the largest `k` `q_i`s are equal to one another and to `m`, the algebra requires `2k` pairs of fermionic oscillators to annihilate the states, just as half the oscillators do for a massless representation. This gives a *short* or *BPS* representation with `2^{2(N−k)}` states. If all the `q_i` are equal to one another and to `m`, the result is an *ultrashort* representation of dimension `2^N` (for `N` even), the same as the massless representation.」
- 文献自称的严格程度：「The most general … allowed by Lorentz invariance is」（无证明）；BPS 界的推导是完整的正定性论证（「must therefore also be nonnegative, implying」）
- 文献列出的依赖：Majorana 性质、`C` 反对称（E11）；**扩展物体的荷推给 §11.6 与 ch.13**
- 备注：**★ 这是本附录唯一的 BPS 界，且仅限 `d = 4` 点粒子中心荷。** 十一维/十维代数 (B.5.1)(B.5.4)(B.5.5)(B.6.12) 只写动量与 KK 荷，**不含膜荷**；原文明说「The same caveat applies」。⇒ 见 Q3 与 §5-B。

### E22 §B.3 `d = 2` 超对称代数与 R 扇区
- 位置：§B.3, eq. (B.3.1a,b), p.449
- 类型：proposition
- 原文陈述（逐字）：「The smallest spinor representation in two dimensions is Majorana–Weyl and has one Hermitean component. The general `(N, Ñ)` algebra would have `N` Hermitean left-moving supercharges `Q^A_L` and `Ñ` Hermitean right-moving supercharges `Q^A_R`. The algebra is
  `{Q^A_L, Q^B_L} = δ^{AB}(P^0 − P^1)`, `{Q^A_R, Q^B_R} = δ^{AB}(P^0 + P^1)` (B.3.1a)，`{Q^A_L, Q^B_R} = Z^{AB}` (B.3.1b)，
  where now `Z^{AB}` need have no special symmetry. The superconformal generators `G_0` and `G̃_0` satisfy this algebra. Thus the R sector of the `(N, Ñ)` superconformal theory contains the `(N, Ñ)` supersymmetry algebra. In fact, this was one of several independent routes by which supersymmetry was first discovered.
  The dimensional reduction of the `d = 4`, `N = 1` supersymmetry algebra gives the `d = 2` (2,2) algebra.」
- 文献自称的严格程度：直接陈述；约化细节交习题 B.3
- 备注：**这是 App. B 唯一提到世界面 R 扇区的地方**，说的是 `G_0` 满足 SUSY 代数，**不是** `ψ_0^μ` 满足 Clifford 代数（§3.2 第 4 条）。

### E23 §B.4 微分形式、`p`-形式规范场、Poincaré 对偶、自对偶
- 位置：§B.4, eqs. (B.4.1)–(B.4.17), pp.450–452
- 类型：definition + proposition
- 原文陈述：(B.4.1)–(B.4.8) 约定（§1 第 10 条）；(B.4.9)(B.4.10) 阿贝尔/非阿贝尔 `F_2`；(B.4.11) `F_{p+2} = dA_{p+1}`, `δA_{p+1} = dλ_p`；(B.4.12) 作用量；「For `p = −1`, the gauge invariance is trivial and this describes a massless scalar」；「The potential `A_{p+1}` thus gives rise to a massless particle in the representation `[p+1]` of the spin `SO(d−2)`. Since `[p+1] = [d−p−3]` for `SO(d−2)`, a `(p+1)`-form potential and a `(d−p−3)`-form potential describe the same particle states」；(B.4.13) `dF_{p+2} = 0, d*F_{p+2} = 0`；(B.4.14) `F′_{d−p−2} = *F_{p+2}`；(B.4.15) 作用量层面的对偶（拉格朗日乘子 `A′_{d−p−3}`）；「Again note that it is the field strength to which the Poincaré duality is applied, not the potential」；
  **(B.4.16)** `d = 2 mod 4` 时可加 `F_{d/2} = ±*F_{d/2}`；(B.4.17) `|F_{d/2}|² = ±F_{d/2}∧F_{d/2} = 0`「vanishes. There are more complicated actions which are not manifestly covariant.」
- 文献自称的严格程度：直接陈述；「One can check that」
- 备注：(B.4.16)(B.4.17) 是 IIB 自对偶 5-形式「无协变作用量」的附录级来源；与 `-ch13.md` E9 脚注 2「no local covariant action」互相呼应。

### E24 ★ §B.5 `d = 11` 是超对称的最大维数；十一维超引力多重态与作用量
- 位置：§B.5 *d = 11 supergravity*, eqs. (B.5.1)(B.5.2), p.453；脚注 3
- 类型：proposition
- 原文陈述（逐字）：「In four dimensions the largest supersymmetry algebra, `N = 8`, contains 32 supercharges. This same limit holds in higher dimensions, since we could reduce to four by compactifying on tori. **Table B.1 then implies that `d = 11` is the maximum in which supersymmetry can exist,³ since the spinor representations are too large for `d ≥ 12`.** Although this exceeds by one the critical dimension of superstring theory, we will start with this case.」
  脚注 3 逐字：「With *two* timelike dimensions a Majorana–Weyl spinor with 32 components is allowed at `d = 12`, **but we will not try to figure out what this might mean**.」
  (B.5.1) `{Q_α, Q̄_β} = −2P_μΓ^μ_{αβ}`；「The massless irreducible representation contains `2^8 = 256` states, half fermions and half bosons. By calculating the spins `S_1, …, S_4` one finds that the graviton multiplet contains two bosonic representations of `SO(9)`: a traceless symmetric tensor (the graviton) with `½ × 9 × 10 − 1 = 44` components and a completely antisymmetric three-index tensor with `9 × 8 × 7/3! = 84` components for 128 in all. There is a single fermionic vector-spinor representation. The spinor index takes 16 values and the vector 9 values; 16 components vanish by a trace condition as in eq. (10.5.19), leaving `16 × 9 − 16 = 128` fermionic components.」
  「With two or fewer derivatives there is **a unique** supersymmetric action, whose bosonic part is」(B.5.2)；「The final *Chern–Simons* term is gauge-invariant in spite of the explicit appearance of `A_3` because the term from the variation `δA_3 = dλ_2` vanishes by parts.」
- 文献自称的严格程度：「Table B.1 then implies」；「a unique supersymmetric action」（无证明、无引用）
- 文献列出的依赖：Table B.1（E9）+ 「helicity > 2 不可能」（E20，自称 "believed"）+ (10.5.19)
- 备注：**「`d = 11` 最大」这条的严格度受两处限制**：(i) 依赖 E20 的「believed to be impossible」；(ii) 脚注 3 明写 `(10,2)` 号差是漏洞。转卡必须带这两条。

### E25 IIA 超引力 = 十一维约化；KK 动量作为中心荷；膜荷推给 §13.2
- 位置：§B.5 *d = 10 IIA supergravity*, eqs. (B.5.3)(B.5.4a,b), pp.453–454
- 类型：proposition
- 原文陈述（逐字）：「By compactifying the `d = 11` theory on a torus and keeping only the massless fields (*dimensional reduction*), we obtain a `d = 10` theory with 32 supercharges. The `d = 11` Majorana spinor becomes a `d = 10` Majorana spinor, which reduces to one Majorana–Weyl spinor of each chirality, `Q^1_α ∈ 16`, `Q^2_α ∈ 16′` . (B.5.3)
  The product of two spinors of the same chirality contains a vector, while the product of spinors of opposite chirality contains a scalar (eq. (B.1.38)), so from the eleven-dimensional algebra we deduce
  `{Q^1_α, Q̄^1_β} = −2P_μ(P_+Γ^μ)_{αβ}`, `{Q^2_α, Q̄^2_β} = −2P_μ(P_−Γ^μ)_{αβ}` (B.5.4a)，`{Q^1_α, Q̄^2_β} = −2P_{10}(P_+Γ)_{αβ}` (B.5.4b)。
  Here `Γ = Γ^{10}` is from the toroidal dimension. A notable feature is the appearance of a central charge proportional to the Kaluza–Klein momentum. This is one of the ways that a central charge in the supersymmetry algebra can arise; **additional central charges carried by extended objects are introduced in their physical context in section 13.2.**
  The dimensional reduction of the `d = 11` theory leaves a scalar from `G_{10 10}`, a Kaluza–Klein vector from `G_{μ10}`, a 2-form potential from `B_{μν10}` and a 3-form from `B_{μνσ}`. This is the same as the massless content of the IIA superstring, the scalar dilaton and the 2-form being from the NS–NS sector and the 1- and 3-forms from the R–R sector. This is no surprise because the large amount of supersymmetry determines the massless particle content completely. What is a surprise is that there really is an eleventh dimension hidden in the IIA string, invisible in perturbation theory but visible at strong coupling. This is discussed in chapter 14.
  The action can be obtained by dimensional reduction; further details are given in section 12.1.」
- 文献自称的严格程度:「we deduce」「This is no surprise because the large amount of supersymmetry determines the massless particle content completely」（后一句是断言）
- 备注：⚠ 原书 (B.5.4) 里写的是 `B_{μν10}`、`B_{μνσ}`（用 `B` 记十一维 3-形式势），而 (B.5.2) 用 `A_3`——**同一小节两种记号**；转卡时统一说明。

### E26 IIB 超引力多重态 (B.5.5)(B.5.6)
- 位置：§B.5 *d = 10 IIB supergravity*, p.454
- 类型：proposition
- 原文陈述（逐字）：「There is another ten-dimensional supergravity, which is not obtained by compactifying an eleven-dimensional theory. This has two supercharges of the same chirality, which we can define to be **16**. The algebra is `{Q^A_α, Q̄^B_β} = −2δ^{AB}P_μ(P_+Γ^μ)_{αβ}` . (B.5.5)
  The graviton multiplet contains two scalars, the traceless symmetric graviton, two antisymmetric 2-forms, and a 4-form with self-dual field strength, for `2 + 35 + 28 + 28 + 35 = 128` (B.5.6) bosonic states in all. This is the same as the massless content of the IIB superstring. More details are given in chapters 10 and 12.」
- 文献自称的严格程度：直接陈述（多重态内容未推导，「More details are given in chapters 10 and 12」）
- 备注：**费米子内容（`2 × 8′ + 2 × 56`）在本附录不写**；图上 `consistency.iib-gravitational-anomaly-cancels` 的「two 8′s, two 56s」仍只能溯源到 §12.2 p.98（§3.2 第 3 条）。

### E27 `d < 10` 的 32 超荷超引力：Table B.3（逐字）与 KK 中心荷 BPS = 高维无质量
- 位置：§B.5 *d < 10 supergravity*, **Table B.3, p.455**；(B.5.7)–(B.5.12), pp.454–457
- 类型：proposition
- 表题（逐字）：「Table B.3. *Supergravities with 32 supercharges. The group `G` is a symmetry of the low energy supergravity theory, and the moduli space is locally `G/H`.*」

| `d` | scalars | vectors | `G` | `H` |
|---|---|---|---|---|
| 10A | 1 | 1 | `SO(1,1,R)` | - |
| 10B | 2 | 0 | `SL(2,R)` | `SO(2,R)` |
| 9 | 3 | 3 | `SL(2,R) × SO(1,1,R)` | `SO(2,R)` |
| 8 | 7 | 6 | `SL(2,R) × SL(3,R)` | `SO(2,R) × SO(3,R)` |
| 7 | 14 | 10 | `SL(5,R)` | `SO(5,R)` |
| 6 | 25 | 16 | `SO(5,5,R)` | `SO(5,R) × SO(5,R)` |
| 5 | 42 | 27 | `E_{6(6)}(R)` | `USp(8)` |
| 4 | 70 | 28 | `E_{7(7)}(R)` | `SU(8)` |
| 3 | 128 | - | `E_{8(8)}(R)` | `SO(16,R)` |

- 正文：(B.5.7) `½k(k+1)` 个标量来自 `G_{mn}`，(B.5.8) `(1/3!)k(k−1)(k−2)` 来自 `B_{mnp}`，加 Poincaré 对偶补项（`d=5`：1；`d=4`：7；`d=3`：28 + 8 个 KK 矢量对偶）；矢量 `k + ½k(k−1)`（`d=6` 加 1，`d=5` 加 6，`d=4` 时 `*(H_{μνmn})` 是磁描述，`d=3` 无矢量）；规范群 `U(1)^{n_V}`；「there is no potential — the scalars are moduli — and the moduli space metric is completely determined by symmetry」；p.456 逐字「**The details of table B.3 are not at this point important**, but it is interesting to see in chapter 14 how the structure fits into string theory.」
  (B.5.9) 十一维代数按 `SO(3,1) × SO(7)` 拆开；(B.5.10) `Γ_{(4)} = i(Γ^0Γ^1Γ^2Γ^3)`；(B.5.11) `(P_mΓ^mP_nΓ^n)^{AB} = δ^{AB}P_mP^m`；p.456 逐字「the eigenvalues `q_i` of the central charge are all equal and any BPS multiplet will be ultrashort, with the same 256 states as a massless multiplet. In this case there is a simple explanation. The BPS condition is `−P_μP^μ = P_mP^m`, so a BPS multiplet is actually a massless multiplet from the higher-dimensional point of view.」(B.5.12) 含全部 28 个 `P^{AB}` 的代数；p.457「the compact momenta depend on the moduli, for example `p = n/R` … it has explicit dependence on the moduli.」
- 文献自称的严格程度：计数是完整的；`G/H` 表「completely determined by symmetry」无推导，且原文自称「not at this point important」
- 备注：§0.3d 已逐行复算 scalars/vectors 两列 ✅。

### E28 ★★ §B.6 `d = 10, N = 1` (type I) 超引力：`16`、`8_v + 8′`、`8_v × (8_v + 8′)`，以及「anomalies unless `g = SO(32)` or `E8 × E8`」
- 位置：§B.6 *d = 10, N = 1 (type I) supergravity*, **p.457（无式号）**
- 类型：proposition
- 原文陈述（逐字，单页重渲染核对）：「This algebra has a single Majorana–Weyl **16** supercharge. The massless vector representation has 16 states, **`8_v + 8′`** under the `SO(8)` little group. The supergravity multiplet is **`8_v × (8_v + 8′)`** as found in the bosonic and type I strings. The bosonic content is then a graviton, an antisymmetric tensor, and a dilaton from the supergravity multiplet plus `dim g` vectors from the gauge multiplets, `g` being the gauge group. The bosonic action is given in section 12.1. **The action is classically invariant for any `g`, but as discussed in section 12.2 there are anomalies unless `g = SO(32)` or `E_8 × E_8`.**」
- 文献自称的严格程度：直接陈述；反常这句是**指向 §12.2 的转述**，不是推导
- 文献列出的依赖：§12.1（作用量）、§12.2（反常）
- 备注：
  1. ⚠ **「as found in the bosonic and type I strings」页图读作 *bosonic***——玻色弦没有超引力多重态，物理上应是 *heterotic*；**疑似原书笔误**，本轮两次渲染同读。见 Q2。
  2. ⚠ **同一附录习题 B.5（p.466）把同一个 type I 无质量开弦多重态写成 `8_v + 8`（无撇）**。见 Q1。
  3. ★ **依赖方向**：本句是 §12.2 → App. B 的**引用**，App. B 不是 SO(32)/E8×E8 的来源；**且只列两个群**，与 §12.2 p.101 脚注 1 的「四解」不同口径。见 Q4。
  4. 「`8_v × (8_v + 8′)`」是本附录唯一的 SO(8) 小群多重态表达式；**没有展开成 `1 + 28 + 35 + 8 + 56`**。

### E29 `d < 10` 的 16 超荷超引力：Narain 模空间 (B.6.1)(B.6.2)
- 位置：§B.6 *d < 10 supergravity*, pp.457–458
- 类型：proposition
- 原文陈述（逐字节选）：「Toroidal compactification of `k` dimensions gives supergravity with 16 supersymmetries in `d = 10 − k`. There are a total of `k(k + r) + 1` moduli, `r` being the rank of the ten-dimensional gauge group `g`. … Of course `g` is `SO(32)` or `E_8 × E_8`, both having `r = 16`, in a consistent ten-dimensional theory, but here we are just using this as a trick to generate theories in lower dimensions. The reduced theories are parity-symmetric and have no anomalies, and so can have any `g`. In fact, various `r < 16` theories can be obtained in string theory by slightly more complicated compactifications. The moduli space is as given explicitly by the Narain compactification of the heterotic string,
  `SO(1,1,R) × SO(k+r, k, R) / (SO(k+r, R) × SO(k, R))` , (B.6.1)
  the `SO(1,1,R)` being from the dilaton. In `d = 4` the antisymmetric tensor gives another scalar, the axion, via Poincaré duality; this combines with the dilaton to form `SL(2,R)/SO(2,R)`. In `d = 3` (`k = 7`), the Poincaré duals of the `14 + r` vectors combine with the dilaton and the other moduli to enlarge the moduli space (B.6.1) to `SO(8+r, 8, R)/(SO(8+r, R) × SO(8, R))` . (B.6.2)」
  p.458：「Toroidal compactification gives gauge group `U(1)^{2k+r}` at generic points in moduli space … the rank remains `2k + r`.」
- 文献自称的严格程度：直接陈述

### E30 `d = 6, N = 2`（`(1,1)` 与 `(2,0)`）多重态
- 位置：§B.6 *d = 6, N = 2 supersymmetry*, eqs. (B.6.3)–(B.6.11), pp.458–459
- 类型：proposition
- 原文陈述：(B.6.3) `16 → (4, 2) + (4′, 2′)` under `SO(9,1) → SO(5,1) × SO(4)`；「The `(4, 2)` has eight real components, forming a single complex `4`. The `4` cannot have a Majorana condition imposed so the complex `4` is the smallest algebra in `d = 6`.」`(1,1)` 代数 = 十维 `N = 1` 的约化，「The only representation with spins `≤ 1` is the vector … one vector and four scalars」；(B.6.4a,b) Weyl 超荷按 `SO(1,1) × SO(4)` 分解；(B.6.5) `r = (½,½) + (½,0)² + (0,½)² + (0,0)⁴`；(B.6.6) `r × |j_1, j_2⟩`；(B.6.7) `(1,1)` 超引力多重态；(B.6.8) 矢量多重态；`(2,0)`：(B.6.9) `r′ = (1,0) + (½,0)⁴ + (0,0)⁵`，(B.6.10) 超引力「a graviton and five anti-self-dual antisymmetric tensors」，(B.6.11) 张量多重态「self-dual antisymmetric tensor and five scalars」。
- 文献自称的严格程度：构造性（「by taking all combinations of raising operators one obtains」）

### E31 ★ `d = 4, N = 4` 规范理论 = 十维 SYM (B.6.13) 的约化；(B.6.17) = Vol.1 (8.7.11) 的 D 膜模势
- 位置：§B.6 *d = 4, N = 4 gauge theory*, eqs. (B.6.12)–(B.6.19), pp.459–461
- 类型：proposition
- 原文陈述（逐字）：(B.6.12) `{Q^A_α, Q̄^B_β} = −2P_μδ^{AB}Γ^μ_{αβ} − 2P_{Rm}Γ^{mAB}δ_{αβ}`「In this case only six of the gauge charges appear; in the heterotic string these are the ones coming from right-moving currents.」
  「It will be useful to derive the full action and SUSY transformation by dimensional reduction of ten-dimensional supersymmetric Yang–Mills theory, whose Lagrangian density is
  **`−(1/4g²)Tr(F_{MN}F^{MN}) − (i/2g²)Tr(λ̄Γ^M D_M λ)`** . (B.6.13)
  The gauge field and the gaugino `λ` (a Majorana–Weyl **16**) are written in matrix notation, and `M, N` run from 0 to 9. The supersymmetry transformation is `δA_M = −iζ̄Γ_Mλ` (B.6.14a), `δλ = ½F_{MN}Γ^{MN}ζ` (B.6.14b).」
  约化 `M → μ, m`：(B.6.15) `−(1/4g²)Tr(F_{μν}F^{μν} + 2D_μA_mD^μA_m − [A_m, A_n]²) − (i/2g²)Tr(λ̄Γ^μD_μλ + iλ̄Γ_m[A_m, λ])`；「The **16** index separates into `(2, 4) + (2̄, 4̄)` under `SO(3,1) × SO(6)`, so the ten-dimensional spinor becomes four Weyl spinors」；(B.6.16a–c)；
  **(B.6.17)** `V = −(1/4g²)Tr([A_m, A_n]²)`「is nonnegative and vanishes only if `[A_m, A_n] = 0` for all `m, n`. Thus, in the flat directions the `A_m` can be taken simultaneously diagonal, and the moduli are just the `6 rank(h)` eigenvalues. At generic points the group is broken to `U(1)^{rank(h)}`. **We have seen this potential before, in eq. (8.7.11) for the D-brane moduli. This is no accident, as the `T`-duality that produces the D-brane has the effect of dimensionally reducing the open string Yang–Mills action.**」
  p.460 逐字：「Eq. (B.6.15) is the most general renormalizable action consistent with `N = 4` global supersymmetry. It remains the most general action if we adopt the looser moduli space power counting described in section B.2 … In other words, `N = 4` global supersymmetry requires the moduli space to be flat.」
  β 函数（p.460–461）：「the first being that its beta function vanishes identically … **It is easy to prove this statement, not just to all orders of perturbation theory but exactly.** Consider for simplicity `h = SU(2)`…」(B.6.18) `v = (A_mA_m)^{1/2} ≡ A`，(B.6.19) `−(1/4g²(A))F_{μν}F^{μν}`「However, this is a field-dependent kinetic term, which we have just stated is inconsistent with `N = 4` supersymmetry — unless in fact the coupling is independent of scale as claimed.」
- 文献自称的严格程度：(B.6.13)(B.6.14) **照录无推导**；约化是直接计算；β 函数「It is easy to prove」后给的是一段依赖「`N = 4` 要求模空间平坦」的论证
- 文献列出的依赖：Vol.1 (8.7.11)（**本轮未翻页核对**，§3.3）
- 备注：**这条闭合了 `-ch13.md` E27 的悬空引用 (B.6.13)**；且 (B.6.17)↔(8.7.11) 这句给了 `branes` 区一条原书背书的边（D 膜模势 = 约化 SYM 势）。

### E32 §B.7 `d = 6, N = 1`：多重态、`D`-项、张量多重态与六维 GS 机制、hyper-Kähler
- 位置：§B.7 *d = 6, N = 1 supersymmetry*, eqs. (B.7.1)–(B.7.9), pp.461–463；脚注 4
- 类型：proposition
- 原文陈述：「We start in six dimensions, the maximum in which a spinor with eight components is allowed according to table B.1.」(B.7.1) `r″ = (½, 0) + (0, 0)²`；(B.7.2) 超引力 `|1,1⟩ + |½,1⟩² + |0,1⟩`「containing the graviton, gravitino (which requires two copies of `|½,1⟩`), and the `(0,1)` which is an anti-self-dual 2-form」；
  **多重态列表（p.461）**：half-hypermultiplet `|½,0⟩, |0,0⟩²`；vector multiplet `|½,½⟩, |0,½⟩²`；tensor multiplet `|1,0⟩, |½,0⟩², |0,0⟩`；「The respective bosonic content is: two scalars; a vector; a self-dual tensor plus scalar.」
  (B.7.3) `D^{Aa} = (g²/2)Φ^{i*}_α σ^A_{αβ}t^a_{ij}Φ^j_β`；(B.7.4) `(1/2g²)D^{Aa}D^{Aa}`「The interactions, incidentally, are nonrenormalizable in six dimensions」；脚注 4（pseudoreal ⇒ half-hypermultiplet 的实条件 `Φ^{i*}_α = ε_{αβ}C_{ij}Φ^j_β`）；
  (B.7.5) `tTr(F_{μν}F^{μν})`，(B.7.6) `B_2Tr(F_2 ∧ F_2)`，p.462 逐字：「**The term (B.7.6) is needed to cancel anomalies in a six-dimensional version of the Green–Schwarz mechanism**, so these terms can arise only at exactly one loop, with a coefficient that is determined by the gauge quantum numbers of the hyper- and vector multiplets.」
  (B.7.7) `G_{rs}(φ)∂_μφ^r∂^μφ^s`；hyper-Kähler：(B.7.8) `J^i_j = iδ^i_j, J^{ī}_{j̄} = −iδ^{ī}_{j̄}, J^i_{j̄} = J^{ī}_j = 0`，(B.7.9) `J^AJ^B = −δ^{AB} + ε^{ABC}J^C`「These properties require the number of real moduli to be a multiple of 4」；holonomy 刻画「a hyper-Kähler manifold is one for which the holonomy lies in this `Sp(m)` subgroup」。
- 文献自称的严格程度：多重态构造性；`D`-项与势「determined entirely by the gauge symmetry」；GS 六维版**只一句话**
- 备注：这条闭合了 `-ch13.md` E28 的悬空引用 §B.7（5–9 弦谱的 `d = 6, N = 1` 分类）。

### E33 `d = 4, N = 2`：special Kähler 与 prepotential
- 位置：§B.7 *d = 4, N = 2 supersymmetry*, eqs. (B.7.10)–(B.7.20), pp.463–465
- 类型：proposition（照录）
- 原文陈述：(B.7.10) `−(1/4g²)Tr([A_4, A_5]²)`；(B.7.11)(B.7.12) `M_{mij} = A^a_mt^a_{ij} + q_{mij}`（「'dummy' gauge field」）；(B.7.13) `K(A, A*) = Im(Σ_a A^{a*}∂_aF(A))`，(B.7.14) `G_{ab̄} = Im(∂_a∂_bF)`「*rigid special Kähler metric*」；超引力：(B.7.15) 射影坐标 `X^I`，(B.7.16) `T^A = X^A/X^0`，(B.7.17) `F(λX) = λ²F(X)`，(B.7.18) `K = −ln Im(Σ_I X^{I*}∂_IF(X))`，(B.7.19) `K → K − ln λ − ln λ*`；p.465 逐字「Their kinetic term is again determined by `F` and depends only on the vector multiplet moduli; **its explicit form is left to the references**」；(B.7.20) 辛变换 `[X′^I; ∂_{I′}F′] = S[X^I; ∂_IF]`，「in recent literature it has been noted that in special cases the symplectic transformation (B.7.20) gives a would-be gradient `∂_{I′}F′` whose curl is actually nonvanishing. For these the definition of special geometry needs to be generalized.」
- 文献自称的严格程度：照录；「left to the references」

### E34 习题清单（5 道）
- 位置：p.466
- 类型：元数据
- 逐字：
  **B.1** 「In section B.1 we defined `B` and `C` in a particular basis. The properties (B.1.17) and (B.1.24) define them in general. Under a change of basis `Γ^μ → UΓ^μU^{−1}` for unitary `U`, find the transformations of `B` and `C`. Show that the properties (B.1.18), (B.1.19), (B.1.21), (B.1.26), and (B.1.28) are independent of such a change of basis. Determine the relations between `B` and `B^T` and between `C` and `C^T`, and show that these are independent of basis.」
  **B.2** 「Extend the decomposition (B.1.44) to the general `SO(d−1,1) → SO(d′−1,1) × SO(d−d′)`, where some of the dimensions are odd.」
  **B.3** 「Work out the details of the reduction of the `d = 4`, `N = 1` supersymmetry algebra to the `d = 2` (2,2) algebra. Identify the central charges.」
  **B.4** 「Verify eq. (B.4.7) for `*²` and derive the corresponding result for Euclidean space.」
  **B.5** 「List the helicities `(s_1, s_2, s_3, s_4)` for the massless **`8_v + 8`** open string states and show that these constitute a representation of the type I supersymmetry algebra.」
- 备注：**B.1 把 `B`、`C` 的基无关性整体外包给读者**（这是 Table B.1 严格化时必须补的一步）；**B.5 与 p.457 的 `8′` 标签不一致**（Q1）。

---

## 3. 否定结论与未核实清单

### 3.1 ★ 作者自承的缺口 / 外包（逐字，本附录共 13 条）

| # | 位置 | 逐字 |
|---|---|---|
| 1 | p.435 | 「Additional properties of the matrices `B` and `C` are developed in **exercise B.1**」（基无关性未证） |
| 2 | p.438 | 「For more than one timelike dimension, the analog of table B.1 or B.2 depends on the *difference* of the number of spacelike and timelike dimensions.」（**无证明**） |
| 3 | p.439–440 | 「the transformations and actions require detailed calculation, and so for these **we simply cite for reference** some of the key results」 |
| 4 | p.440 | 「The `N = 1` supersymmetry algebra is **uniquely determined** to be (B.2.1)」（无证明无引用） |
| 5 | p.441 / p.448 | 「Massless particles with helicities greater than 2 **are believed to be impossible** to couple to gravity」／「which **is believed to be impossible** (there are some uninteresting exceptions, such as free field theories). String theory has several times turned up loopholes in such statements, but not yet here.」 |
| 6 | p.442 | 「We collect these here, **without derivation**.」 |
| 7 | p.444 | 「An important nonrenormalization theorem **states** that …」（不证不引） |
| 8 | p.446 | 「The full Lagrangian density is quite lengthy, so **we give only the purely bosonic terms**」 |
| 9 | p.448 | 「Rather than explain this here, **we introduce it in its natural physical context: first in section 11.6, and then in more variety in chapter 13**. The same caveat applies to the higher-dimensional algebras」（★ 膜荷不在本附录） |
| 10 | p.452 | 「**A more complete treatment can be found in the references.**」 |
| 11 | p.453 脚注 3 | 「a Majorana–Weyl spinor with 32 components is allowed at `d = 12`, but **we will not try to figure out what this might mean**」 |
| 12 | p.456 | 「**The details of table B.3 are not at this point important**」 |
| 13 | p.465 | 「its explicit form **is left to the references**」 |

### 3.2 ★★★ 本附录**没有**出现的东西（逐条都是通读 37 页页图后的否定观察）

> ⚠ 以下判断基于页图通读，**不是文本层 grep**（PDF 二进制，本环境无法可靠 grep）。等级：**L1 观察，非穷尽检索**。

1. **★ 没有 "triality"（三重性）一词，没有 `8_s`、`8_c` 记号。** 附录的 SO(8) 记号只有 `8_v`、`8`、`8′`（p.457、p.466），且 Table B.2 只说 `N ≡ 0 mod 8` 时两个 Weyl 表示都「real, self」——**从未说三个 8 维表示被外自同构轮换**。⇒ **`worldsheet.so8-triality` 不能以 App. B 为 source**（§5）。
2. **没有把 `8_v × (8_v + 8′)` 或 `8_v × 8_v`、`8 × 8′` 展开成 SO(8) 不可约表示**；(B.1.38)(B.1.41) 给的是一般 `SO(d−1,1)`/`SO(2l)` 的 `2^k × 2^k` 张量分解规则，**没有对 `l = 4` 写出 `1 + 28 + 35` 或 `8_v + 56` 这类数字**。
3. **★ 没有 SO(8) 意义下的 `56`。** 附录里 `56` 只出现在 p.448 `d = 4, N = 8` 多重态的 `∓½^{56}`（螺旋度态数）。⇒ 图上 `consistency.d10-n1-anomaly-polynomial-factorized-form` 与 `consistency.iib-gravitational-anomaly-cancels` 的「gravitino **56**」标签**不能升级到 App. B**，仍只溯源 §12.2 pp.98/100。
4. **没有世界面 R 扇区零模 `ψ_0^μ`**。唯一提世界面 R 扇区的是 §B.3 p.449（`G_0`、`G̃_0` 满足 `(N,Ñ)` SUSY 代数）和 p.433 一句「Majorana–Weyl spinors in `d = 2` (`ψ^μ` and `ψ̃^μ`) play a key role on the world-sheet」。⇒ `rns-ramond-zero-modes-clifford` 只能从 App. B 拿 **(B.1.1)–(B.1.15) 的抽象表示论**；「零模 = Γ 矩阵 ⇒ 基态 = Dirac 表示」这一步须引 ch.10（本轮未核对 §10.2 式号）。
5. **没有膜荷（`p`-形式中心荷）的超对称代数。** 全附录的中心荷只有 (B.2.36) 的点粒子 `Z^{AB}` 与 (B.5.4b)(B.5.9)(B.5.12)(B.6.12) 的 KK 动量；原文明写推给 §11.6、§13.2（§3.1 第 9 条）。⇒ `branes.d-brane-bps-no-force` 的 BPS 界不能整体挂在 App. B（Q3）。
6. **没有「四解」**：反常自由规范群在附录里只写 **`SO(32)` 或 `E_8 × E_8`** 两个（p.457），无 `E_8 × U(1)^{248}`、无 `U(1)^{496}`（Q4）。
7. **没有任何文献引用、没有编号定理/引理/证明环境**；唯一性（E7）、Haag–Łopuszański–Sohnius（E15）、非重整化定理（E17）、`d = 11` 唯一作用量（E24）全部是断言。
8. **没有 `α'`**，没有弦振幅；附录是纯粹的（超）场论/表示论材料。
9. **没有 Euclidean 号差的 Table B.1 类比**（只在 p.430 说「will be indicated later」，实际落地为 Table B.2 的 `SO(N)`）。

### 3.3 本附录引用、但本轮**未翻页核对**的外部式号 / 节号

| 被引 | 本附录在哪里引它 | 本项目是否已 L1 核过 |
|---|---|---|
| **(10.5.19)**（gravitino 的迹条件） | E24 p.453 | ⚠ `polchinski-1998-v2.md` 覆盖 ch.10，但该式是否已记待查 |
| **§12.1**（IIA/type I 玻色作用量） | E25 / E28 | ⚠ `-ch12.md` 覆盖 §12.1，未定点核 |
| **§12.2**（反常 ⇒ `SO(32)`/`E_8×E_8`） | E28 | ✅ `-ch12.md`（但见 Q4 的口径差） |
| **§11.6**、**§13.2**（扩展物体的中心荷） | E21 / E25 | ✅ `-ch13.md` E14 覆盖 §13.2 (13.2.9)；§11.6 (11.6.32) 未核 |
| **§14.2**、**chapter 14**（`d < 10` 超引力、M 理论） | E25 / E27 | ❌ ch.14 未抽 |
| **§16.2**、**§16.4**、**chapter 18** | E15 / E17 | ❌ 未抽 |
| **Vol.1 (8.7.11)**（D 膜模势）、**§8.4**（环面模空间） | E31 / E27 | ⚠ `polchinski-1998-v1.md` §8.7 只有 [S] 二手源 |
| **chapters 10 and 12**（IIB 多重态细节） | E26 | ✅ 两章已 L1，但 IIB 费米子内容的式号未定点核 |

---

## 4. 未解决的疑问

### Q1 ★ 同一 type I 无质量开弦多重态：p.457 写 `8_v + 8′`，习题 B.5（p.466）写 `8_v + 8`
- 两处均单页/批量渲染核对无误。哪一手征叫 `8` 哪一手征叫 `8′` 本是约定（p.433 说 `d = 10` 「only as **16** and **16′**」），但**附录内部两处不一致且原书不说明**。
- ⇒ 转卡时不要写死「type I 规范多重态 = `8_v + 8′`」；写「`8_v` + 一个 Majorana–Weyl `8`（手征标签在原书两处不一致）」，并两句都抄进 note。
- 与 `-ch12.md` 的 §12.2 p.100「a neutral fermion **8′**, and an **8** gaugino」对照：ch.12 把 gaugino 记 `8`，与习题 B.5 一致、与 p.457 不一致。**维持未裁决。**

### Q2 p.457「as found in the bosonic and type I strings」
- 页图两次渲染均读作 *bosonic*。玻色弦没有 `8_v × (8_v + 8′)` 超引力多重态，物理上应为 *heterotic*（杂化弦与 type I 共享同一 `N = 1` 超引力多重态）。
- **疑似原书笔误**；本轮不裁决，须由人复核印刷页 457 一次。转卡时不要引这半句。

### Q3 ★★★ App. B 的 BPS 界只覆盖点粒子中心荷——`branes.d-brane-bps-no-force` 的依赖链不能止于 App. B
- 事实（E21 逐字）：「To be precise, this is the most general algebra if we include only charges that can be carried by point particles … we introduce it … first in section 11.6, and then in more variety in chapter 13. The same caveat applies to the higher-dimensional algebras to be introduced later in this appendix.」
- 事实（E25 逐字）：「additional central charges carried by extended objects are introduced in their physical context in section 13.2」。
- 事实（`-ch13.md` E14 / §3.1 第 8 条）：ch.13 自己说 (13.2.9)「is **still not complete**: the magnetic NS–NS charge is missing」。
- ⇒ **D 膜 BPS 性的代数来源是 (13.2.9)，而 (13.2.9) 在原书里是不完整的；App. B 只提供 `d = 4` 点粒子版的模板 (B.2.36)–(B.2.39) 与正定性论证。** 图里若建 `susy.bps-bound-*`，须分两个节点（见 §5-B），**不得**把 (B.2.39) 直接当作 D 膜张力–荷等式 `τ_p = μ_p` 的依据。

### Q4 ★ App. B p.457 只列 `SO(32)` 与 `E_8 × E_8`，与 §12.2 p.101 脚注 1 的「四解」口径不同
- App. B（E28 逐字）：「there are anomalies unless `g = SO(32)` or `E_8 × E_8`」——**两个群**。
- `-ch12.md` 已核实：§12.2 p.101 脚注 1 另提 `E_8 × U(1)^{248}` 与 `U(1)^{496}`，且只说两条 properties "hold"。
- 两处不矛盾（脚注说的是因子化条件的解，附录说的是「有反常」的补集），但**口径不同**：附录这句若被单独引用，会得到「十维 `N = 1` 反常自由 ⇔ `SO(32)` 或 `E_8×E_8`」这一**比 §12.2 更强**的陈述。
- ⇒ **不得用 App. B p.457 支持任何唯一性/完备分类主张**；它是 §12.2 的下游转述。

### Q5 「`d = 11` 是超对称最大维数」的严格度
- 推导链（E24）：Table B.1（min. rep. 在 `d = 12` 为 64 > 32）+「32 超荷是上限」；后者来自 `d = 4` 的「helicity > 2 impossible」，而这在 p.441/p.448 的措辞是 **"believed to be impossible"**，且 p.448 补了「String theory has several times turned up loopholes in such statements」。
- 加上脚注 3 的 `(10,2)` 漏洞。⇒ 该命题在本书内**最高只能 `physical-argument`**，note 必须带「believed」原话与脚注 3。

### Q6 SO(8) 三重性与 `8_s/8_c/56` 到底在本书哪里
- App. B 不含（§3.2 第 1–3 条）。候选：Vol.2 §10.2–10.4（R 扇区基态与 GSO）、§10.6（IIA/IIB 无质量谱的 `8_v × 8_v` 等分解）。`polchinski-1998-v2.md`（ch.10）是否已记这些式号，本轮未复查。
- ⇒ **`worldsheet.so8-triality` 与 `type-ii-massless-spectrum` 的 `8/8′/56` 标签溯源仍开放**；App. B 只能提供 (B.1.15)（`16/16′`）、Table B.2 的 `N ≡ 0 mod 8` 行（两个 `8` 都实且自共轭）与 (B.1.41)（`SO(2l)` Weyl 乘积规则）三块**通用**材料。

### Q7 p.433「twice the dimension of the Dirac representation」的措辞
- 指「实参数数 = 2 × 复维数」；抽取者按此理解复算 11 行全部吻合（§0.3a）。非歧义，记录以免后人误读为「两倍 Dirac 旋量」。

### Q8 (B.5.2) 用 `A_3`、p.454 用 `B_{μνσ}` 记十一维 3-形式
- 同一小节两种记号，原书不说明。转卡统一用 (B.5.2) 的 `A_3`。

---

## 5. 对图的建议

> researcher 不写 `graph/`。以下全部是**给 curator 的建议**。
> 本轮 grep `graph/`：`clifford`（仅 bc 鬼场 Clifford 模节点）、`triality`、`8_s`、`8_c`、`Majorana` 命中情况——**没有任何旋量表示论节点、没有 `susy.*` 区节点**；`branes/` 目前 6 个 statement（`d-brane-from-t-duality`、`dbi-action-is-born-infeld-type`、`massless-open-string-gauge-field-and-collective-coordinates`、`stretched-open-string-mass`、`t-duality-changes-brane-dimension`、`wilson-line-eigenvalues-are-brane-positions`），无 `bps-no-force`。派工单点名的 `rns-ramond-zero-modes-clifford`、`type-ii-massless-spectrum` **在 `graph/` 里尚不存在**（Glob 零命中）。

### 5-A 派工单点名的三个节点

#### 5-A1 `math.clifford-algebra-representations-mod-8`
- **kind**：proposition
- **建议 statement**：设 `{Γ^μ, Γ^ν} = 2η^{μν}`，号差 `(d−1, 1)`。(i) `d = 2k+2` 时不可约表示维数 `2^{k+1}`，在基变换下唯一，分解为两个不等价 Weyl 表示 `2^k`、`2^{k′}`；`d = 2k+3` 时单一不可约表示 `2^{k+1}`。(ii) Weyl 表示自共轭 iff `d ≡ 2 (mod 4)`，互共轭 iff `d ≡ 0 (mod 4)`。(iii) Majorana 条件可加 iff `d ≡ 0,1,2,3,4 (mod 8)`；Majorana–Weyl 可加 iff `d ≡ 2 (mod 8)`。(iv) 最小实表示维数如 Table B.1 末列，每 8 维乘 16。
- **sources.loc 建议逐字**：`"App. B §B.1, Table B.1, p.434（表题与表体逐字见 polchinski-1998-v2-appB.md#E9）；规则推导 (B.1.11)–(B.1.13) p.432、(B.1.16)–(B.1.21) pp.432–433；正文结论句 p.433「In all, a Majorana condition is possible if d = 0, 1, 2, 3, or 4 (mod 8)」"`
- **★ status 建议：`physical-argument`，不能凭 App. B 标 `rigorous`。** 理由：(a) 无编号定理、无证明环境；(b) 唯一性只有一句「The above construction … shows that … it is unique up to a change of basis」（E7）；(c) `B`、`C` 的基无关性整体外包给习题 B.1（§3.1 第 1 条）；(d) 零文献引用。
  **若要 `rigorous`**，须另加数学来源（候选：Atiyah–Bott–Shapiro, *Clifford modules*, Topology 3 (1964) suppl. 1；Lawson–Michelsohn, *Spin Geometry*, Ch. I——**两者本项目均未取、编号 L0**，不得先写式号）。可先建 `physical-argument` 版，留 note「数学来源待补」。
- **note 必带**：§0.3a/b 的独立复算（表与规则互洽）；Q7 的措辞说明。
- **不可形式化的部分 / 可形式化的岛**：(B.1.6)(B.1.7) 的显式迭代构造 + (B.1.1) 验证是**纯有限维矩阵代数**，是 Lean 热身岛；Majorana 存在性 (B.1.21) 也是有限计算。真正难的是「唯一性」与「不等价」，Mathlib 有 `CliffordAlgebra` 但（本轮未查）未必有实 Clifford 代数的 mod-8 分类。

#### 5-A2 `worldsheet.so8-triality`
- **★ 结论：不能以 App. B 为 source**（§3.2 第 1 条）。App. B 能给的只有三块通用材料：(B.1.15) `32 = 16 + 16′`；Table B.2 `N ≡ 0 mod 8` 行（`8`、`8′` 都 real 且 self-conjugate）；(B.1.41a–c) `SO(2l)` 的 Weyl 乘积规则（`l = 4` 时 `8 × 8 = [0]+[2]+[4]_+`、`8 × 8′ = [1]+[3]`，**数字要 curator 自己代**，原书未写）。
- 建议：先在 `polchinski-1998-v2.md`（ch.10）里找 `8_v/8_s/8_c` 与「triality」是否出现；找不到就另找来源（GSW Vol.1 App. 5.A 或数学来源），**在此之前该节点不建或标 `inferred`**。

#### 5-A3 `consistency.ten-dimensional-supergravity-multiplets`
- 建议拆成三张卡（同一 statement 挂多个推导不合适，因为三种理论的多重态是三个不同命题）：
  1. **`sugra.d11-graviton-multiplet`**：`44 + 84 = 128` 玻色 + `128` 费米，loc `App. B §B.5 p.453（无式号；计数句逐字见 #E24）`，`physical-argument`；依赖「helicity ≤ 2」（自称 believed）。
  2. **`sugra.iia-from-d11-reduction`**：(B.5.3)(B.5.4a,b) + p.453–454 的场内容句，`physical-argument`；note 带 KK 中心荷句与「膜荷见 §13.2」。
  3. **`sugra.iib-graviton-multiplet`**：(B.5.5)(B.5.6) `2+35+28+28+35 = 128`，`physical-argument`；**费米子内容不在 App. B**，仍指 §12.2 p.98。
  4. **`sugra.d10-n1-multiplets`**（type I / 杂化共用）：p.457 无式号，statement 写「规范多重态 `8_v` + 一个 MW `8`；超引力多重态 `8_v × (8_v + 8)`」，**手征标签按 Q1 处理**，`physical-argument`。
     **★ 红线**：p.457 的「anomalies unless `SO(32)` or `E_8×E_8`」是 §12.2 的转述（Q4）——**`depends_on` 方向是本卡 → `consistency.*`（§12.2 的卡），不得反向，也不得据此建唯一性节点**。与 ch.10 (P5) / GS 卡的接口：本卡提供「谱」，反常卡提供「约束」，两者之间的边由 §12.2 p.100 末句（已在 `d10-n1-anomaly-polynomial-factorized-form` 的 loc 里）背书，不需要 App. B。

### 5-B 与 `branes.d-brane-bps-no-force` 的接口（Q3 的落地）

| 建议 id | 来源 loc | status | 备注 |
|---|---|---|---|
| **`susy.bps-bound-point-particle-d4`** | `App. B §B.2, eqs. (B.2.36)–(B.2.39), pp.448–449` | `physical-argument`（正定性论证完整，但「most general algebra」无证明） | **statement 必须写明「仅点粒子中心荷」**，note 逐字带 p.448 的 caveat 与短/超短表示的计数 |
| **`susy.brane-charges-in-susy-algebra`** | `Vol.2 §13.2, eq. (13.2.9), p.145`（见 `-ch13.md` E14） | `physical-argument` | 原书自承「still not complete」；App. B 只作模板（本卡 `depends_on` 上一条，**原文有背书**：p.448「introduce it … in chapter 13」） |
| `branes.d-brane-bps-half-susy`（`-ch13.md` 5-B 已建议） | (13.2.5)(13.2.6) | `physical-argument` | `depends_on` 上两条 |
| `branes.bps-no-force`（`-ch13.md` 5-A3 已建议） | (13.3.1)(13.3.2) | `physical-argument` | 不直接依赖 App. B；经 `d-brane-bps-half-susy` 间接依赖 |

⇒ **App. B 在 `branes` 区的角色是「模板 + 正定性论证」，不是「D 膜 BPS 界的来源」。**

### 5-C 其他值得建的节点（按性价比）

| 建议 id | 来源 loc | 备注 |
|---|---|---|
| **`gauge.d10-super-yang-mills-action`** | `App. B §B.6, eqs. (B.6.13)(B.6.14a,b), pp.459–460` | ★ 闭合 `-ch13.md` E27 的悬空引用；**照录无推导** ⇒ `physical-argument` |
| **`gauge.d4-n4-from-d10-sym-reduction`** | `(B.6.15)–(B.6.17), p.460` | (B.6.17) 与 Vol.1 (8.7.11) 的等同句是**原书背书**的 `branes` ↔ `gauge` 边；(8.7.11) 本项目只有二手源，边可建但 loc 标「(8.7.11) 未核」 |
| **`susy.max-dimension-eleven`** | `App. B §B.5 p.453 + 脚注 3` | `physical-argument`；note 带 Q5 两条限制 |
| `susy.d2-nn-algebra-from-r-sector` | `(B.3.1a,b), p.449` | 「`G_0`, `G̃_0` satisfy this algebra」——与 worldsheet 区超共形代数卡的接口 |
| `forms.p-form-poincare-duality` | `(B.4.13)–(B.4.17), pp.451–452` | IIB 自对偶 5-形式「无协变作用量」的附录级来源 |
| `sugra.d6-n1-multiplets` | `§B.7 p.461 列表 + (B.7.1)(B.7.2)` | 闭合 `-ch13.md` E28（5–9 弦谱）；(B.7.6) 六维 GS 机制只一句 |
| `sugra.moduli-space-32-supercharges`（Table B.3） | `p.455` | 原书自称「not at this point important」，低优先 |

### 5-D 对已有节点的影响

- **`consistency.d10-n1-anomaly-polynomial-factorized-form`、`consistency.iib-gravitational-anomaly-cancels`**：其 `56/8′/8` 标签**不能**通过 App. B 升级（§3.2 第 3 条）；维持 §12.2 的 loc。可在 note 加一句「`16/16′` 定义见 App. B (B.1.15)；SO(8) `56` 不在 App. B」。
- **`rns-ramond-zero-modes-clifford`（待建）**：source 应写两处——`App. B (B.1.1)–(B.1.5), (B.1.11)–(B.1.15)`（表示论）+ ch.10 的零模式号（**本轮未核**）；**不能只挂 App. B**。
- **`branes.dbi-action-is-born-infeld-type`（已存在）**：与 (B.6.17)↔(8.7.11) 无直接关系，不动。
- **约定节点**：若 curator 建 `conv.clifford-normalization`，loc = `App. B (B.1.1) p.430、(B.1.8) p.431`；SUSY 代数的负号约定 loc = `(B.2.1a) p.440 + 「The minus sign is due to our metric signature」`。
