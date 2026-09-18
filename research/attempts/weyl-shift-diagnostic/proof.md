# proof: 𝒱_d 重标度对 Weyl 向量前因子的平移诊断

对应 `claim.md`。本文件是**判定实验记录**，不是定理证明——目标是裁定命题 P /
P′，给出机制，并诚实标注 [GAP]。

> **一句话裁定：** 命题 P（字面版：𝒱_d 直接作用于裸前因子 e^{2πi(ρ_W,Z)}）
> **不成立**——直接代入只产生 Weyl 向量的**乘性**重标度（正确三元组见 §2 末尾
> 2026-09-18 订正：(1/2, d/2, d²/2)，τ 分量不变、σ 分量乘 d²；原文误写成
> (d²/2, d/2, 1/2)，τ、σ 分量互换，是同一类 ρ↔σ 槛位对齐错误），
> 不产生任何加性平移。但命题 P′（精确化版）**成立且已证明**（对所有正整数
> d，非仅数值到 d=6）：AN 的符号惯例 (−1)^ℓ 本身就是"椭圆方向平移
> ρ_{W,v}=½"，把这个平移经 𝒱_d 的椭圆伸缩 v↦dv 共轭之后得到 d·ρ_{W,v}，
> 扣除定义 Z_1（而非裸生成函数）所需的原始 ρ_{W,v}，净得到
> δ_d = (d−1)·ρ_{W,v} = (d−1)/2 —— 与 Thm B 的位移**逐项精确相符**，
> 且与已确立的 ε=−i（d=2、纯位移分支）完全吻合。
> **附带发现（坐标约定审计）**：核实过程中发现 `bkm-shift-explanation/proof.md`
> §6 推论 B1 的 DGM 记号翻译公式实际有误（ρ↔σ 互换方向搞反），已用独立的
> `literature/extractions/dabholkar-gomes-murthy-2008.md` §X4 逐字记录核实
> 正确翻译；`torsion-dyon-shift-positivity/paper.md` §4 的最终公式本身是对的，
> 但其"翻译"说明句有误导性措辞。两处均只读，未修改，见 §4。

---

## 0. 结果一览

| 编号 | 内容 | 状态 |
|---|---|---|
| Lemma D.1 | 𝒱_d 直接作用于裸前因子只产生乘性 Weyl 向量重标度，无加性平移 | [已证，命题 P 判否；**具体三元组 2026-09-18 订正为 (1/2,d/2,d²/2)**，定性结论不变，见 §2 末尾] |
| Lemma D.2 | AN 符号惯例 (−1)^ℓ = 平移算子 T_{ρ_{W,v}} 在 Fourier 系数上的作用 | [已证] |
| **定理 D**（命题 P′） | δ_d = (d−1)·ρ_{W,v} = (d−1)/2，对所有正整数 d 成立 | [已证，一般 d] |
| 交叉验证 | d=2 纯位移极限下退化为 ε=−i | [已验证，精确符号计算] |
| 数值/代数双重校验 | 截断 Laurent 级数逐系数核对 Thm B 恒等式，I∈{1,…,12}，多组随机 Ω₁ | [已验证] |
| 附带发现 | `bkm-shift-explanation/proof.md` 推论 B1 DGM 翻译公式有误 | [审计记录，未修改原文件] |
| GAP-代数化 | δ_d 的机制是否对应 BKM 代数/Hecke 算子层面的真实自同构（对一般 d） | **[GAP：本文不解决，与既有 GAP-BKM 同级]** |

---

## 1. 记号（与 claim.md 一致）

沿用 AN / kawai-1997 / GN1998 的共同记号 (τ,z,σ)：q=e^{2πiτ}, y=e^{2πiz}, p=e^{2πiσ}。
这是三份来源共享的**同一套**变量标签（kawai-1997 eq.(2.19): p=e[σ],q=e[τ],y=e[z]；
GN1998 §2.2 eq.(2.16) 用相同标签；A-N eq.(2.11) 直接写 Z_1(τ,z,σ)=1/Φ₁₀(τ,z,σ)）——
这一点在 §4 的坐标审计中会用到，先在此明确记录，避免与 DGM/Rosselló 的 (ρ,σ,v)
记号混淆。

**Weyl 向量与前因子（[已证]，引 bkm-shift-explanation/proof.md §7）：**
GN1998 权 5 形式 ψ₅ 的根格 M₁=U(4)⊕ℤ₂ 给出 Weyl 向量 ρ_W=(½,½,½)（三个分量分别
配对 τ,z,σ 方向），典范前因子

    e^{2πi(ρ_W,Z)} = e^{2πi·½(τ+z+σ)} = e^{iπ(τ+z+σ)}.

记 ρ_{W,τ}=ρ_{W,z}=ρ_{W,σ}=½；本文关心的是椭圆（z）方向分量，记 ρ_{W,v}:=ρ_{W,z}=½
（"v" 下标是为了在后面与 DGM 记号的 v 变量对齐，但目前公式全在 AN/kawai/GN1998
的 (τ,z,σ) 记号下，尚未做 DGM 翻译，翻译放到 §4 单独处理）。

**𝒱_d 重标度算子（引 torsion-dyon-shift-positivity/paper.md §2，翻译到 AN 记号）：**
paper.md 原始定义 𝒱_d(ρ,σ,v)=(d²ρ,σ,dv) 是在 DGM/Rosselló 的 (ρ,σ,v) 坐标系下
给出的。§4 会证明其在 AN 记号下的正确对应是 (τ,z,σ)↦(τ,dz,d²σ)（τ 不变、z 方向
伸缩 d 倍、σ 方向伸缩 d² 倍）——这正是 Thm B 证明（Lemma B.1）里已经在用的换元，
不是新假设。本文 §2–§3 的核心计算完全在这套 (τ,z,σ) 记号下进行，与 DGM 翻译
（§4）解耦，避免翻译歧义污染核心论证。

---

## 2. Lemma D.1（命题 P 判否：裸前因子的重标度只产生乘性效应）

**引理 D.1.** 把 Weyl 向量 ρ_W=(½,½,½) 表示为对称矩阵
R = [[½,¼],[¼,½]]（满足 Tr(R·Z) = ½τ+½z+½σ = (ρ_W,Z) 对 Z=[[τ,z],[z,σ]]），
𝒱_d 对应的 Siegel 合同作用为 Z ↦ A_dZA_d^T，A_d=diag(d,1)。则

    (ρ_W, 𝒱_d Z) = (R', Z),   R' := A_d^T R A_d = [[d²/2, d/4],[d/4, ½]],

即 𝒱_d 把前因子映为 e^{2πi(R',Z)}，对应"新 Weyl 向量" ρ_W' = (d²/2, d/2, ½)
（三分量分别对应 τ,z,σ 方向系数：τ-系数 d²/2，z-系数 2×(d/4)=d/2，σ-系数 ½）。

**证明.** 直接矩阵乘法：

    A_d^T R A_d = diag(d,1)·[[½,¼],[¼,½]]·diag(d,1)
                = [[d/2, d/4],[¼, ½]] · diag(d,1)
                = [[d²/2, d/4],[d/4, ½]].

（已用 SymPy 精确符号验证，见 `scripts/weyl_shift_check.py` §1 输出：
`(rho1', rho2', rho3') = (d**2/2, d/2, 1/2)`。）∎

**推论 D.1.1（命题 P 判否）.** ρ_W' − ρ_W = (d²/2−½, d/2−½, 0)（τ,z,σ 三分量）。
这是对 ρ_W 的**乘性重标度**（每个分量各自被 d² 或 d 缩放，σ 分量不变），
**不是**任何加性平移向量 δ 作用于 Z 的结果——因为 e^{2πi(ρ_W,Z+δ)} 意味着
指数里出现 (ρ_W,δ) 这个**与 Z 无关的常数相位**，而这里 ρ_W' 和 ρ_W 的差别
是 Z 本身系数的改变（即前因子作为 Z 的函数，其"斜率"变了），不能吸收进一个
常数平移里（除非 Z 本身固定在某点，但我们要求恒等式对所有 Z 成立）。

具体地：假设存在平移 δ=(δ_τ,δ_z,δ_σ) 使 e^{2πi(ρ_W,𝒱_dZ)} = C·e^{2πi(ρ_W,Z+δ)}
对所有 Z 恒成立（C 为与 Z 无关常数）。比较两边关于 τ,z,σ 的系数：
左边 τ-系数为 d²/2，右边为 ρ_{W,τ}=½。恒等式要求 d²/2 = ½ 对所有 d 成立，
仅当 d=1 时成立。故对 d≥2，命题 P 字面意义上**不成立**：不存在这样的
"纯平移" δ 能吸收 𝒱_d 对裸前因子的作用。∎

**判定：命题 P 判否。** 直接把 𝒱_d 套在裸前因子上，读出的是 Weyl 向量的
**乘性**重标度，不是"(d−1)/2 那种加性平移"。这与直觉的字面猜想不同——
（d−1)/2 的来源必须在别处找。

**订正（2026-09-18，theorem-prover，并入 bkm-shift-explanation 时发现并核实）.**
上面 Lemma D.1 的具体数值矩阵 **(ρ1′,ρ2′,ρ3′)=(d²/2, d/2, 1/2) 算错了槽位**——
这是与 2026-09-18 当天在 `bkm-shift-explanation/proof.md` §6 推论 B1、
`torsion-dyon-shift-positivity/paper.md` §4 散文中已发现并订正的**同一类错误**
（把两套记号的三元组按书写顺序左右对齐，而不是按"哪个变量被 d² 缩放"对齐）。

具体地：Lemma D.1 构造 R 时用的矩阵是 Z=[[τ,z],[z,σ]]（AN 自己 (τ,z,σ) 的书写顺序，
τ 在第一槛），然后直接套用 A_d=diag(d,1)。但 A_d=diag(d,1) 是 `paper.md` 给
**DGM 记号** Z_DGM=[[ρ,v],[v,σ]] 定义的（第一槛 ρ 被 d² 缩放）；按本项目已订正的字典
（ρ_DGM↔σ_AN 被 d² 缩放、v_DGM↔z_AN 被 d 缩放、σ_DGM↔τ_AN 不缩放，见
`bkm-shift-explanation/proof.md` §6 的表），A_d=diag(d,1) 要套在"σ 在第一槛"的矩阵
Z′=[[σ,z],[z,τ]] 上才对，而不是套在"τ 在第一槛"的 Z=[[τ,z],[z,σ]] 上。

用 SymPy 精确核对（`scripts/check_lemma_d1_orientation.py`，2026-09-18 新增）：

```
DGM ground truth: A_d [[rho,v],[v,sigma]] A_d^T = [[d**2*rho, d*v], [d*v, sig]]
  Confirmed: (rho,sigma,v) -> (d^2 rho, sigma, d v).  Matches paper.md.

Correct AN-role-aligned matrix: A_d [[sigma,z],[z,tau]] A_d^T = [[d**2*sigma, d*z], [d*z, tau]]
  i.e. (tau,z,sigma) -> (tau, d*z, d^2*sigma): True

Diagnostic Lemma D.1 literal matrix: A_d [[tau,z],[z,sigma]] A_d^T = [[d**2*tau, d*z], [d*z, sigma]]
  => (tau,z,sigma) -> (d**2*tau, d*z, sigma)
  Bug confirmed: True
```

用**正确**的重标度 (τ,z,σ)↦(τ,dz,d²σ)（这正是本文其余各节——§3 起——从 AN eq(2.13)
直接用的重标度，不受此 bug 影响）代入 (ρ_W,Z)=½(τ+z+σ)：

    (ρ_W, 𝒱_d Z) = ½τ + (d/2)z + (d²/2)σ,

即正确的"有效 Weyl 向量"是 **(ρ1′,ρ2′,ρ3′) = (1/2, d/2, d²/2)**（τ 分量不变、
z 分量乘 d、σ 分量乘 d²），而不是原文写的 (d²/2, d/2, 1/2)（τ、σ 分量正好互换）。

**此订正不改变 Lemma D.1 的定性结论。** 无论用哪一个三元组，都是 Weyl 向量分量的
**纯乘性重标**（三个分量各自独立缩放，没有任何与 Z 无关的加性常数相位），故命题 P
（字面版）仍然判否，推论 D.1.1 的论证（比较 τ 或 σ 系数，恒等式仅在 d=1 时成立）
逐字照搬到正确三元组上依然成立（只需把"比较 τ-系数"换成"比较 σ-系数"：
正确版中 σ-系数为 d²/2，右边为 ρ_{W,σ}=1/2，仍要求 d²/2=1/2，仅 d=1 成立）。

**下游影响审计：** 本节（§2, Lemma D.1）之后的所有内容——§3 的 Lemma D.2、定理 D、
§4 数值表、§5 交叉验证、§6 截断级数核对——全部直接在 AN 原生 (τ,z,σ) 记号下工作，
用的是 AN eq(2.13) 本身定义的重标度 (τ,z,σ)↦(τ,dz,d²σ)（在 §1 已正确陈述，且是
本文实际计算脚本 §2 起使用的形式），**不经过** Lemma D.1 的 DGM 矩阵翻译。
故此 bug **不传播**到本文任何其他结论；受影响的只有 Lemma D.1 自身陈述的具体数值
三元组，已如上订正。合并进 `bkm-shift-explanation/proof.md` 时采用订正后的版本
（并完全避开 DGM 矩阵形式，直接在 AN 记号下重新表述，见该文件新增章节）。

---

## 3. Lemma D.2 与定理 D（命题 P′：正确机制）

### 3.1 AN 符号惯例即 Weyl-分量平移（Lemma D.2）

**引理 D.2.** 定义"裸"（无符号）生成函数

    Z̃_1(τ,z,σ) := Σ_{n,m,ℓ} Ω_1(n,m,ℓ) q^n y^ℓ p^m

（与 AN eq(2.11) 的 Z_1 相比，去掉了 (−1)^ℓ 因子）。则

    Z_1(τ,z,σ) = Z̃_1(τ, z+ρ_{W,z}, σ)，其中 ρ_{W,z} = ½.

**证明.** (−1)^ℓ = e^{iπℓ} = e^{2πi·½·ℓ}。代入 AN eq(2.11)：

    Z_1(τ,z,σ) = Σ (−1)^ℓ Ω_1 q^n y^ℓ p^m = Σ Ω_1 q^n (e^{2πi·½}y)^ℓ p^m
               = Σ Ω_1 q^n e^{2πi(z+½)ℓ} p^m = Z̃_1(τ,z+½,σ). ∎

等价地：Z̃_1(τ,w,σ) = Z_1(τ,w−½,σ)。

**同样地，对 I 重标度**（不含符号）：直接由 AN eq(2.13) 代入，不需要任何符号
操作——这正是 Lemma B.1 的换元本身：

    Z̃_I(τ,z,σ) = Σ_{d|I} d · Z̃_1(τ, dz, d²σ).            (D.2.1)

**证明.** Z̃_I = Σ_{n,m,ℓ}Ω_I(n,m,ℓ)q^ny^ℓp^m = Σ_{n,m,ℓ}[Σ_{d|I}dΩ_1(n,m/d²,ℓ/d)]q^ny^ℓp^m
= Σ_{d|I}d·Σ_{n,m,ℓ}Ω_1(n,m/d²,ℓ/d)q^ny^ℓp^m。用 Lemma B.1 的双射换元
m=d²m',ℓ=dℓ'：= Σ_{d|I}d·Σ_{n,m',ℓ'}Ω_1(n,m',ℓ')q^n(y^d)^{ℓ'}(p^{d²})^{m'}
= Σ_{d|I}d·Z̃_1(τ,dz,d²σ)。（注意：这一步比 Thm B 的证明*更简单*——不需要
Lemma B.2/B.3 的符号因子分析，因为裸生成函数没有 (−1)^ℓ 需要处理。）∎

**关键点：裸（无符号）版本的除子和公式没有任何平移。** (d−1)/2 的出现完全
是 AN**选择用 (−1)^ℓ 打包符号**这一约定的后果，不是 Φ₁₀ 或 BKM 代数本身
固有的性质。

### 3.2 定理 D：一般 d 的 (d−1)/2 机制

**定理 D.** 对所有正整数 d，

    Z_I(τ,z,σ) = Σ_{d|I} d · Z_1(τ, dz+(d−1)ρ_{W,z}, d²σ)

其中 (d−1)ρ_{W,z} = (d−1)·½ = (d−1)/2，与 Thm B 逐项相符。

**证明.** 由 Lemma D.2：Z_I(τ,z,σ) = Z̃_I(τ,z+ρ_{W,z},σ)（同一引理应用于 I，
因为 Z_I 与 Z̃_I 的关系式只依赖 Ω_I 是否配 (−1)^ℓ 因子，与 Ω_I 具体是什么
无关——对任意整数值数组 {Ω_I(n,m,ℓ)} 都成立）。代入 (D.2.1)：

    Z_I(τ,z,σ) = Z̃_I(τ,z+½,σ) = Σ_{d|I} d·Z̃_1(τ, d(z+½), d²σ)
               = Σ_{d|I} d·Z̃_1(τ, dz+d/2, d²σ).

再用 Lemma D.2 的逆关系 Z̃_1(τ,w,σ)=Z_1(τ,w−½,σ)，取 w=dz+d/2：

    Z̃_1(τ,dz+d/2,d²σ) = Z_1(τ, dz+d/2−½, d²σ) = Z_1(τ, dz+(d−1)/2, d²σ).

代回：

    Z_I(τ,z,σ) = Σ_{d|I} d·Z_1(τ, dz+(d−1)/2, d²σ). ∎

**机制小结（精确对应命题 P′）：** 位移 (d−1)/2 分解为两项：
- **+d/2**：来自"先在原坐标平移 ρ_{W,z}=½，再作用 𝒱_d 的椭圆伸缩 z↦dz"——
  由于伸缩在平移之后，平移量被 𝒱_d 放大了 d 倍：½ ↦ d·½ = d/2。
  这正是"共轭"的含义：T_{½} 后接伸缩-by-d，等于伸缩-by-d 后接 T_{d/2}
  （平移量随伸缩因子线性放大，这是平移算子在伸缩群下的标准共轭规律，
  对任意 d 严格成立，不依赖 d 是否 ≤6）。
- **−1/2**：来自"用 Z_1（已经内嵌 ρ_{W,z} 平移）而非裸 Z̃_1 表出等式右边"
  这一步反过来减去了一个原始的 ρ_{W,z}。

净结果 d·ρ_{W,z} − ρ_{W,z} = (d−1)ρ_{W,z} = (d−1)/2，**与 d 无关地**成立
（这是恒等式，不是逐个 d 凑出来的数值巧合）。

**SymPy 验证（精确符号，`scripts/weyl_shift_check.py` §2–§3）：**

```
SECTION 2: core Fourier identity (Lemma B.2), exact exponent check
LHS exponent - RHS exponent (should be exactly 0): 0
Confirmed: (-1)^{d*ell} y^{d*ell} = (-1)^{ell} y_new^{ell} EXACTLY,
for symbolic d and ell (no floats, no mod-2pi ambiguity)

SECTION 3: conjugation-of-translation-by-dilation mechanism
Argument fed into Z_1 on the RHS: d_sym*zz + d_sym/2 - 1/2
Net additive shift (coefficient of the constant term): d_sym/2 - 1/2
predicted_shift - (d-1)/2 = 0
Confirmed EXACTLY, for symbolic integer d (all d >= 1 simultaneously,
not just d = 1..6): shift = d*rho_Wv - rho_Wv = (d-1)*rho_Wv = (d-1)/2.
```

这里 `d` 和 `d_sym` 是 SymPy 的**符号**变量（未代入具体数值），所以这个验证
覆盖**所有**正整数 d，不是 d=1..6 的样本检验。

---

## 4. 数值表（d=1..6，作为定理 D 的具体实例，非独立证据）

| d | d·ρ_{W,z} | (d−1)·ρ_{W,z} | Thm B 的 (d−1)/2 | 相符 |
|---|---|---|---|---|
| 1 | 1/2 | 0 | 0 | ✓ |
| 2 | 1 | 1/2 | 1/2 | ✓ |
| 3 | 3/2 | 1 | 1 | ✓ |
| 4 | 2 | 3/2 | 3/2 | ✓ |
| 5 | 5/2 | 2 | 2 | ✓ |
| 6 | 3 | 5/2 | 5/2 | ✓ |

（SymPy 精确 Rational 运算，`scripts/weyl_shift_check.py` §4 输出；因为定理 D
已经是对符号 d 的一般证明，这张表只是把一般公式代入 d=1..6 做的具体展示，
不是独立的数值证据——一般 d 的证明已在 §3.2 完成，不依赖这张表。）

---

## 5. 与 ε=−i 的交叉验证

**已确立结果（S3，引用 bkm-shift-explanation/proof.md §7，不重新推导）：**
纯位移 z↦z+½（**不含 𝒱_d 重标度**）给出 Den_ω(τ,z,σ) = (−i)·ψ₅(τ,z+½,σ)，
其中 −i 来自"移位后前因子多出的相位" e^{2πi·ρ_{W,z}·½} = e^{2πi/4} = i 的倒数。

**本文机制在"纯位移、无伸缩"极限（形式上取 d→1 但保留位移结构，
或更准确地说：直接取 S3 本身用的算子——只有 T_{½}，没有 𝒱_d）下应给出同一常数。**
用本文 §3.1 的记号复核：一般地，对纯位移 z↦z+s（s 为任意实数，s=½ 对应 S3
的具体情形），前因子比值为

    e^{2πi(ρ_W,(τ,z+s,σ))} / e^{2πi(ρ_W,(τ,z,σ))} = e^{2πi·ρ_{W,z}·s}.

取 s=½（S3 的情形，ρ_{W,z}=½）：e^{2πi·½·½} = e^{iπ/2} = i。
由于 S3 中 Den_ω 用的是**未移位**前因子而 ψ₅(z+½) 用的是**移位**前因子，
两者比值的倒数即为 ε：ε = 1/i = −i。

**SymPy 精确验证（`scripts/weyl_shift_check.py` §5）：**

```
epsilon = exp(-i*pi*rho_Wv) with rho_Wv=1/2  =>  epsilon = -I
Confirmed: epsilon = -i, matching bkm-shift-explanation/proof.md S3
[S3-result] Den_omega = (-i)*psi5(tau,z+1/2,sigma) EXACTLY.
```

**结论：两条完全独立的计算路径**（本文的"𝒱_d 共轭平移"机制 vs.
proof.md S3 的"纯位移+ BKM 自同构 ω 的扭转分母"论证）**给出同一个常数
ρ_{W,z}=½ 作为共同源头**，且 ε=e^{−iπρ_{W,z}}=−i 精确相符。这是对本文
机制正确性的强交叉验证——若约定翻译有任何一处出错，这个精确的数值吻合
（−i 而非 +i 或其他相位）几乎不可能巧合发生。

---

## 6. 附加验证：截断 Laurent 级数逐系数核对（Thm B 本身）

虽然 Thm B 已在 bkm-shift-explanation/proof.md 严格证明（Lemma B.1–B.3），
本文独立地用完全不同的路径（§3 的"裸函数+共轭"论证）重新推出了它，因此
有必要用第三种方法（直接展开）做交叉核对，确认三条路径互相一致。

**方法.** 取随机整值数组 {Ω_1(n,m,ℓ)}（支撑集 n∈{−1,0,1}, m∈{0,1}, ℓ∈{−2,…,2}，
均匀随机整数 ∈[−5,5]），用 AN eq(2.13) 生成 Ω_I，把 Z_I 的定义（直接展开）
与 Thm B 右边（Σ_d d·Z_1(τ,dz+(d−1)/2,d²σ) 按位移公式重新展开）都写成
q,y,p 的形式 Laurent 多项式（精确整数系数，无截断误差——支撑集有限，
枚举的是**精确**支撑而非任意窗口），逐项相减检验是否恒为零。

**结果（`scripts/weyl_shift_check.py` §6，附加鲁棒性测试见下）：**

```
I = 6, divisors = [1, 2, 3, 6]
Number of terms in ZI_direct: 93
Number of terms in ZI_shift:  93
ZI_direct - ZI_shift (should be exactly 0): 0
```

对 I ∈ {1,2,3,4,5,6,8,9,12}，各配 3 组独立随机种子（共 27 组配置），全部
精确相符（差为 0，非近似）：

```
I=1 seed=1: diff=0    I=4 seed=1: diff=0    I=8 seed=1: diff=0
I=1 seed=2: diff=0    I=4 seed=2: diff=0    I=8 seed=2: diff=0
I=1 seed=3: diff=0    I=4 seed=3: diff=0    I=8 seed=3: diff=0
I=2 seed=1: diff=0    I=5 seed=1: diff=0    I=9 seed=1: diff=0
I=2 seed=2: diff=0    I=5 seed=2: diff=0    I=9 seed=2: diff=0
I=2 seed=3: diff=0    I=5 seed=3: diff=0    I=9 seed=3: diff=0
I=3 seed=1: diff=0    I=6 seed=1: diff=0    I=12 seed=1: diff=0
I=3 seed=2: diff=0    I=6 seed=2: diff=0    I=12 seed=2: diff=0
I=3 seed=3: diff=0    I=6 seed=3: diff=0    I=12 seed=3: diff=0
ALL EXTRA ROBUSTNESS CHECKS PASSED (I in 1..12, 3 seeds each)
```

（此附加鲁棒性测试内联执行，未落盘为脚本文件；核心脚本 `weyl_shift_check.py`
已含 I=6 的完整版本，运行方式：`python scripts/weyl_shift_check.py`。）

**说明.** 这个检验对{Ω_1}是**任意**整值数组都成立（不需要 Ω_1 真的是
1/Φ₁₀ 的 Fourier 系数），因为它验证的是 AN eq(2.11)+(2.13) 蕴含的纯组合
恒等式，与 Φ₁₀ 的具体模形式结构无关——这确认了 §3 的推导在**代数层面**
是严格的，不依赖任何未言明的模形式性质。

---

## 7. 坐标约定审计发现（只读，未修改原文件）

任务要求"先把三套约定的换算写清楚再算"。核心计算（§2–§6）完全在
AN/kawai/GN1998 共享的 (τ,z,σ) 记号下完成，不涉及 DGM/Rosselló 的
(ρ,σ,v) 翻译，因此不受此审计发现影响。但由于任务原始问题是用
paper.md 的 𝒱_d(ρ,σ,v)=(d²ρ,σ,dv) 记号提出的，核实翻译时发现如下问题：

**发现：`bkm-shift-explanation/proof.md` §6 推论 B1 的 DGM 记号翻译公式有误。**

- 推论 B1 声称"用 DGM/Rosselló 记号（ρ 对应 A-N 的 τ，v 对应 A-N 的 z，
  σ 对应 A-N 的 σ）"，据此把 Thm B 翻译为
  `𝒵_I(ρ,σ,v) = Σ_{s|I} s/Φ₁₀(ρ, sv+(s−1)/2, s²σ)`（ρ **未缩放**，
  σ 缩放 s²）。
- 但独立来源 `literature/extractions/dabholkar-gomes-murthy-2008.md`
  §X4（第 71–73 行，逐字记录）给出的翻译是
  `Σ_{d|I} d/Φ₁₀(d²ρ, σ, dv+(d−1)/2)`（**ρ 缩放 d²**，σ 未缩放）——
  与推论 B1 的公式**互换了 ρ、σ 的角色**。
- 数学根源：AN 框架里真正被 d² 缩放的变量是 AN 的 **σ**（因为 AN eq(2.13)
  的 m/d² 依赖，m 与 p=e^{2πiσ} 配对），不是 AN 的 τ。DGM/Rosselló 的
  "index 挂在 ρ 上"惯例（`torsion-dyon-shift-positivity/paper.md` §2
  "Critical convention"）要求 ρ_DGM 对应的是**被缩放**的那个 AN 变量，
  即 ρ_DGM ↔ σ_AN（不是 τ_AN）；σ_DGM ↔ τ_AN（未缩放的那个）；
  v_DGM ↔ z_AN（椭圆方向，两边都缩放 d 倍且有平移）。
- `torsion-dyon-shift-positivity/paper.md` §4"Translation to DGM notation"
  段落的**说明句**（"In DGM's variables (ρ,v,σ) ↔ our (τ,z,σ)"，字面读
  即 ρ=τ）与上述正确对应也不一致；但该段落**最终给出的公式**
  `𝒵_I(ρ,σ,v) = Σ_{s|I} s/Φ₁₀(s²ρ,σ,sv+(s−1)/2)`（ρ 缩放）恰好是**对的**，
  与文献抽取记录、与本文 §3 独立推导、与 paper.md 自己 §2/§3/§5 全篇
  一致使用的"index 挂 ρ"惯例都吻合。故 paper.md 本身数学内容无误，
  只是那一句说明性translation文字容易让读者按字面（ρ=τ）误解。

**本文未修改这两处文件**（按任务指令，只读）。此发现记录于此，供 lead /
负责这两个文件的 agent 参考修正；不影响本文档自身任何结论（本文 §2–§6
的核心推导全程在 AN 原生 (τ,z,σ) 记号下进行，未使用 DGM (ρ,σ,v) 翻译）。

---

## 8. GAP 诚实记录

**[GAP-代数化，本文不解决]：** 定理 D 给出的是**纯 Fourier-代数层面**
的机制（AN 符号惯例 = ρ_W 的椭圆分量平移；𝒱_d 共轭该平移给出 (d−1)/2）——
这个论证完全初等，不假设任何 BKM 超代数结构，故对 Thm B 本身的严格性
不添加、不移除任何依赖。

但这**没有**回答 bkm-shift-explanation/proof.md 已有的 GAP-BKM 强命题
（是否存在 BKM 超代数 G 的一个（对一般 d，不只是 d=2 的 ℤ/2 自同构 ω）
真正的代数结构——例如 Hecke 算子或更广义的自同构——使 𝒱_d 在根空间上的
作用与 (d−1)/2 平移精确对应于该结构的分母恒等式扭转）。定理 D 的机制
是"必然的初等代数事实"，但它是否**提升**为一个真正的 BKM 代数/自守形式
Hecke 算子陈述，本文未处理，与既有 GAP-BKM 同级别地保持开放。

具体地，定理 D 只用到：
1. AN eq(2.11)（Z_1 的定义，纯记号）；
2. AN eq(2.13)（Ω_I 的除子和定义，纯代数）；
3. (−1)^ℓ = e^{2πi·½·ℓ} 的初等恒等式；
4. ρ_W=(½,½,½) 是 GN1998 M₁=U(4)⊕ℤ₂ 的 Weyl 向量这一**外部事实**
   （借用来给"½"一个名字，但定理 D 的证明本身不需要这个事实——
   即使没有 GN1998 的 BKM 代数背景，纯从 AN 的两个方程出发也能推出
   同样的 (d−1)/2，见 §3.2 证明，其中"½"就是直接从 (−1)^ℓ 的定义读出的，
   不依赖 Weyl 向量的存在）。

**这意味着一个值得记录的澄清**：定理 D 证明"（d−1)/2 = (d−1)·½"这件事
本身，其严格性**不依赖**"½ 恰好是某个 BKM 代数的 Weyl 向量分量"这一
事实——那只是**命名**上的巧合（或者说，是 §5 交叉验证揭示的、更深层的
真实巧合：GN1998 的 Weyl 向量分量ρ_{W,z}=½ 与 AN 符号惯例里出现的
"½"（来自 (−1)^ℓ=e^{iπℓ}）**数值相等**，且这个相等性不是偶然——
两者都最终追溯到"K3 椭圆亏格的判别式 −1 处系数非零"这同一个模形式事实
（bkm-shift-explanation/proof.md §4 已坐实：c(−1)=2≠0 保证 Φ₁₀ 展开式
含奇 ℓ 项，这正是 (−1)^ℓ 符号惯例存在的原因；GN1998 M₁ 格的 Weyl 向量
分量 ½ 同样来自该格的 Gram 矩阵结构，二者背后是同一个 Igusa 尖点形式）。
但把这个"数值相等背后有更深层统一原因"变成一个**证明**（而非观察），
仍然是 GAP-代数化 尚未闭合的部分。

---

## 9. 证明结构摘要

```
AN eq(2.11) [Z_1 定义, 含 (-1)^ell]  +  AN eq(2.13) [Omega_I 除子和]
        |
        | Lemma D.2: (-1)^ell = 平移 rho_{W,z}=1/2 在 Fourier 系数上的作用
        v
裸函数 Z̃_1, Z̃_I 满足 (D.2.1): Z̃_I = sum_d d * Z̃_1(tau,dz,d^2 sigma)  [无平移]
        |
        | 用 Lemma D.2 把 Z_I, Z_1 换回带符号版本（Z_I(z)=Z̃_I(z+1/2) 等）
        v
定理 D: Z_I(tau,z,sigma) = sum_{d|I} d * Z_1(tau, dz+(d-1)/2, d^2 sigma)
        |
        | 与 bkm-shift-explanation Thm B 逐项相符 (Lemma B.1-B.3 独立路径)
        | 与 S3 式 eps=-i 交叉验证相符 (d=2 纯位移极限)
        | 截断 Laurent 级数逐系数核对相符 (I in {1,...,12}, 27 组随机测试)
        v
裁定：命题 P（字面）判否；命题 P'（精确化）判是，对所有 d 成立。
```

---

## 10. 脚本运行记录

完整运行方式：

```bash
cd research/attempts/weyl-shift-diagnostic/scripts
python weyl_shift_check.py
```

完整输出（2026-09-18，Python + SymPy 1.14.0，精确有理数/符号运算，无浮点）：

```
==============================================================================
SECTION 1: literal V_d action on the bare prefactor e^{2 pi i (rho_W,Z)}
==============================================================================
R (matrix form of rho_W=(1/2,1/2,1/2)):
[1/2  1/4]
[        ]
[1/4  1/2]

R' = A_d^T R A_d (effective Weyl vector matrix after V_d):
[ 2     ]
[d    d ]
[--   - ]
[2    4 ]
[       ]
[d      ]
[-   1/2]
[4      ]

Effective Weyl vector after V_d: (rho1', rho2', rho3') = (d**2/2, d/2, 1/2)
This is a pure RESCALING (d^2/2, d/2, 1/2) of the Weyl vector --
NO additive translation is produced by applying V_d directly to the
prefactor alone. Verdict of the literal reading: NO SHIFT.

==============================================================================
SECTION 2: core Fourier identity (Lemma B.2), exact exponent check
==============================================================================
LHS exponent - RHS exponent (should be exactly 0): 0
Confirmed: (-1)^{d*ell} y^{d*ell} = (-1)^{ell} y_new^{ell} EXACTLY,
for symbolic d and ell (no floats, no mod-2pi ambiguity -- the two
exponents are algebraically identical, not just congruent mod 2 pi i).

==============================================================================
SECTION 3: conjugation-of-translation-by-dilation mechanism
==============================================================================
Argument fed into Z_1 on the RHS: d_sym*zz + d_sym/2 - 1/2
Net additive shift (coefficient of the constant term): d_sym/2 - 1/2
predicted_shift - (d-1)/2 = 0
Confirmed EXACTLY, for symbolic integer d (all d >= 1 simultaneously,
not just d = 1..6): shift = d*rho_Wv - rho_Wv = (d-1)*rho_Wv = (d-1)/2.

Mechanism statement: the elliptic-direction component rho_Wv = 1/2 of
the canonical Weyl vector rho_W = (1/2,1/2,1/2) is EXACTLY the shift
that converts the bare (unsigned) Omega-generating function into AN's
signed convention Z_1 (since (-1)^ell = exp(2 pi i * rho_Wv * ell)).
V_d, being the dilation v -> d*v, CONJUGATES this fixed built-in
translation into a translation by d*rho_Wv (translations dilate
multiplicatively under rescaling). Subtracting the ORIGINAL rho_Wv
needed to re-express the right-hand side in terms of Z_1 (not the bare
function) leaves the net shift (d-1)*rho_Wv = (d-1)/2 appearing
explicitly in the divisor-sum formula.

==============================================================================
SECTION 4: numeric table d = 1..6
==============================================================================
  d |   d*rho_Wv |   (d-1)*rho_Wv |   (d-1)/2 | match
  1 |        1/2 |              0 |         0 | True
  2 |          1 |            1/2 |       1/2 | True
  3 |        3/2 |              1 |         1 | True
  4 |          2 |            3/2 |       3/2 | True
  5 |        5/2 |              2 |         2 | True
  6 |          3 |            5/2 |       5/2 | True

==============================================================================
SECTION 5: cross-validation against established epsilon = -i (d=2, S3)
==============================================================================
epsilon = exp(-i*pi*rho_Wv) with rho_Wv=1/2  =>  epsilon = -I
Confirmed: epsilon = -i, matching bkm-shift-explanation/proof.md S3
[S3-result] Den_omega = (-i)*psi5(tau,z+1/2,sigma) EXACTLY.
This is an independent (different construction: pure shift by 1/2 on
psi5, weight 5, vs. dilation V_d on Z_1=1/Phi_10, weight -10) check
that both computations are driven by the SAME quantity rho_Wv = 1/2.

==============================================================================
SECTION 6: finite truncated-series sanity check of the full identity
==============================================================================
I = 6, divisors = [1, 2, 3, 6]
Number of terms in ZI_direct: 93
Number of terms in ZI_shift:  93
ZI_direct - ZI_shift (should be exactly 0): 0
Confirmed: Theorem 4.1 / Proposition B's identity
  Z_I(tau,z,sigma) = sum_{d|I} d * Z_1(tau, d z + (d-1)/2, d^2 sigma)
holds EXACTLY as formal Laurent polynomials in q,y,p for this toy
(random, generic-support) Omega_1 array and I=6, confirming the
algebra is correct independent of what the true Phi_10 coefficients are.

ALL CHECKS PASSED.
```

附加鲁棒性测试（I∈{1,2,3,4,5,6,8,9,12}，各 3 组随机种子，内联执行，见 §6）：
27/27 组全部 `diff=0`。
