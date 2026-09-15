# proof: GAP 10.2b Route A — attractor 围道避开 Φ₁₀ 零点

对应 `claim.md`。记号：Ω=(ρ,v;v,σ)，Δ=4mn−ℓ²，T=[[m,ℓ/2],[ℓ/2,n]]。

---

## §1. Sen 2008 eq. (D.19) 的逐字核对与坐标identification

### 1.1 来源与核对方式

下载 arXiv:0708.1270v4 PDF（通过 WebFetch 获取，本地路径
`/tmp/sen2008/sen-0708.1270v4.pdf`，196 页，v4，2009-11-05），用 Read 工具
以 `pages` 参数逐页读取 pp.159–169（Appendix C 全文 + Appendix D 全文），
图像原文核对（非 OCR 转录已有文本，是本次任务新做的独立核对，弥补
`literature/extractions/sen-2008-precision-counting.md` §S7 此前留下的
"转述而非逐字引用"缺口）。

### 1.2 Appendix C 的记号结构（逐字，p.159-163）

(C.1)：`Ω = (ρ v; v σ)`，"ρ,σ,v 是三个复变量"。

(C.3)-(C.6) 定义两个"threshold integral" `Ĩ(ρ,σ,v)` 与 `Î(ρ,σ,v)`（同一变量记号，
不同构造：分别来自求和范围 `n1∈ℤ+r/N,j∈2ℤ+b` 与 `n2∈Nℤ+r,j∈2ℤ+b` 的格点求和，
对应两个不同的轨道扇区截断）。

(C.7)-(C.9) 引入**第二套**变量 `(ρ̃,σ̃,ṽ)`：
```
ρ̃ = (1/N)·1/(2v−ρ−σ),  σ̃ = N(v²−ρσ)/(2v−ρ−σ),  ṽ = (v−ρ)/(2v−ρ−σ)     (C.7)
```
（逆变换见 (C.8)）。

(C.15)-(C.16) 用 threshold 积分定义 Φ̃ 与 Φ̂（都是各自"原生"变量 (ρ,σ,v) 的函数，
tilde 只是**函数名**标签，区分两种构造，不代表参数取 tilde 变量）：
```
Ĩ(ρ,σ,v) = −2ln[(det ImΩ)^k] − 2 ln Φ̃(ρ,σ,v) − 2 ln Φ̄̃(ρ,σ,v) + const     (C.15)
Î(ρ,σ,v) = −2ln[(det ImΩ)^k] − 2 ln Φ̂(ρ,σ,v) − 2 ln Φ̄̂(ρ,σ,v) + const     (C.16)
```

(C.12) `Î(ρ,σ,v) = Ĩ(ρ̃,σ̃,ṽ)`（把 Î 在 (ρ,σ,v) 的值等同于 Ĩ 在变换点 (ρ̃,σ̃,ṽ) 的值）
结合 (C.15)(C.16) 给出 (C.21)：
```
Φ̃(ρ̃,σ̃,ṽ) = −i^k C1 (2v−ρ−σ)^k Φ̂(ρ,σ,v)                                (C.21)
```
即 Φ̃ **在变换点** `(ρ̃,σ̃,ṽ)`（用原变量 (ρ,σ,v) 通过 (C.7) 算出）的值，正比于
Φ̂ 在原变量的值乘一个 Jacobian 型因子。

**p.164 顶部（Appendix D 标题正上方，verbatim）**："For M=K3 and N=1, the function
Φ̃ constructed in this appendix is the well known weight 10 cusp form of the genus
two Siegel modular group."

**identification（本证明使用的桥接，标注推理依据，非文献逐字断言）**：Φ̃ 是其
**自身原生坐标**（Appendix C 记号沿用 (ρ,σ,v) 或后文 Appendix D 沿用 (ρ̃,σ̃,ṽ) 作
Φ̃ 的参数名，两者是同一 ℂ³ 的不同命名，指同一个函数的同一组自变量）的函数，
N=1 时就是标准亏格 2 Igusa 尖点形式 χ₁₀=Φ₁₀。交叉验证（(C.26)展开系数结构）：
`Φ̃(own coords) = −4π²v²f₁(Nρ)f₂(σ/N) + O(v⁴)`，N=1 时 `f₁(ρ)f₂(σ)`，
其乘积公式结构（(C.28)(C.29)，指数 `s_l,t_r` 来自 K3 的 `Q_{r,s}` 数据）与经典
`Φ₁₀ ≈ −4π²v²Δ_cusp(ρ)Δ_cusp(σ)+O(v⁴)`（`torsion-immortal-positivity-hecke/claim.md`
line 53 已用作自洽性检查，来自 Gritsenko-Nikulin 型经典结果）**吻合**（Δ_cusp 是
权 12 判别式尖点形式，f₁,f₂ 在 N=1 时退化为同一个 η^24 型对象，与 Δ_cusp 一致）。
**[GAP-identify]**：Sen 原文没有把"Φ̃ 自身坐标"与"GN1996/Rosselló 的 (ρ,σ,v)"
显式写成同一记号（这本来就是符号使用上的固有含糊，源自物理文献重复借用
希腊字母做不同对象的参数名）；本证明把二者等同，依据是上述系数结构吻合
+ "well known weight 10 cusp form" 的直接陈述，是**合理但非逐字证明**的桥接，
留作已知的、有限的解释性缺口（不影响下文对 D.19 本身公式的逐字使用）。

### 1.3 Appendix D eq. (D.19)（逐字，p.168）

Sen 通过分析 threshold 积分 (D.1) 在 τ→i∞ 处的发散源，逐步排除各类贡献
（(D.3)(D.5)(D.8)-(D.18)，含 N 一般情形的轨道扇区分析），得到**净结论**（p.168，
"The net conclusion of this analysis..."，verbatim）：

> "The net conclusion of this analysis is that both for M=K3 and M=T⁴, the only
> zeroes of Φ̃(ρ̃,σ̃,ṽ) are of the form:
> ```
> Φ̃ ∼ (n2(σ̃ρ̃−ṽ²)+jṽ+n1σ̃−ρ̃m1+m2)²,
> m1 ∈ Nℤ,  n1,m2,n2 ∈ ℤ,  j ∈ 2ℤ+1,  m1n1+m2n2+j²/4 = 1/4.
> The rest are poles."                                                    (D.19)

对 K3、N=1（Nℤ=ℤ）情形，本证明使用的 D.19 精确形式为：

> **(D.19', N=1)** Div(Φ₁₀) 恰是并集 ⋃ 2·{F=0}，其中
> `F := n2(σρ−v²)+jv+n1σ−m1ρ+m2`，并集取遍所有 (m1,n1,m2,n2,j)∈ℤ⁵，j 奇，
> 满足 `4m1n1+4m2n2+j²=1`；且**没有其他零点**（"the rest are poles"，
> 对 N=1 情形，p.168 前一段进一步论证 r≠0 mod N 扇区对 N=1 是空集，
> 故 K3/N=1 时 Φ₁₀ 事实上**没有任何极点**——与 Φ₁₀ 是整尖点形式一致，
> 交叉验证了 identification 的合理性）。

**与 GN1996 的交叉验证**：取 (m1,n1,m2,n2,j)=(0,0,0,0,1)（判别式 `0+0+1/4=1/4`✓），
F=jv=v，给出零点分支 `{v=0}`，重数 2——**恰好**匹配 GN1996 抽取记录中
"Div(Φ₁₀)=2H₁, H₁={z₂=0}"（`gritsenko-nikulin-1996-phi10.md` line 39），
v=z₂ 是同一坐标（Sen 2008 抽取记录 §S1 已确认坐标对应）。两条**独立**文献
（GN1996 代数几何 vs. Sen 2008 threshold 积分物理推导）在此退化情形完全一致，
强支持 D.19 与 identification 的正确性。

---

## §2. 精确 Re/Im 分解引理（不含近似，对一切 Λ>0 成立）

**记号**：ρ=ρ1+i·2nΛ, σ=σ1+i·2mΛ, v=v1+i·ℓΛ（ρ1,σ1,v1∈ℝ；这里取 ε=+1，
即 Im v=+ℓΛ，与 claim.md §0 的约定一致；`torsion-immortal-positivity-hecke`
用 Im v=−ℓΛ，两者由 Φ₁₀(ρ,σ,−v)=Φ₁₀(ρ,σ,v) 的经典 v-偶性等价，见 claim.md §0）。

**Lemma 1（精确分解）**。对任意整数 m1,n1,m2,n2,j 与实数 ρ1,σ1,v1，记
```
F := n2(σρ−v²) + jv + n1σ − m1ρ + m2.
```
则 F 的实部与虚部**恰好**（无近似）等于：
```
Re F = −n2ΔΛ² + g(ρ1,σ1,v1),     g := n2(σ1ρ1−v1²) + jv1 + n1σ1 − m1ρ1 + m2
Im F = Λ·h(ρ1,σ1,v1),            h := n2(2nσ1+2mρ1−2ℓv1) + jℓ + 2mn1 − 2nm1
```

**证明**。直接展开复数乘法：
`Re(σρ)=σ1ρ1−σ2ρ2`, `Im(σρ)=σ1ρ2+σ2ρ1`, `Re(v²)=v1²−v2²`, `Im(v²)=2v1v2`，
代入 σ2=2mΛ,ρ2=2nΛ,v2=ℓΛ：`σ2ρ2−v2²=4mnΛ²−ℓ²Λ²=ΔΛ²`（精确等式，非近似）。
于是
```
Re F = n2(σ1ρ1−σ2ρ2−v1²+v2²) + jv1+n1σ1−m1ρ1+m2
     = n2(σ1ρ1−v1²) − n2ΔΛ² + jv1+n1σ1−m1ρ1+m2 = −n2ΔΛ²+g.
Im F = n2(σ1ρ2+σ2ρ1−2v1v2) + jv2+n1σ2−m1ρ2
     = n2·Λ(2nσ1+2mρ1−2ℓv1) + jℓΛ+2mn1Λ−2nm1Λ = Λh.  ∎
```

**Corollary 2**。Ω 在 (m1,n1,m2,n2,j) 分支上（即 F=0，Λ≠0）当且仅当同时
```
(R)  n2ΔΛ² = g(ρ1,σ1,v1)
(I)  h(ρ1,σ1,v1) = 0                                      （Λ 无关！）
```

（I) 完全不含 Λ，是纯粹的、对 (ρ1,σ1,v1) 的约束，这个事实是下文所有论证的支点。

**Bound 3（g 的界）**：对 ρ1,σ1,v1∈[0,1]（Rosselló 围道闭方体，claim.md §0），
`σ1ρ1∈[0,1]`, `v1²∈[0,1]` ⟹ `σ1ρ1−v1²∈[−1,1]`，故
```
|g| ≤ |m1|+|n1|+|m2|+|n2|+|j|.                                    (A)
```

---

## §3. ℓ=0 反例（原始命题在此边界不成立）

取 (m1,n1,m2,n2,j)=(0,0,0,0,1)（判别式 `1/4`✓，即上文交叉验证过的 v=0 分支）。
则 F=v=v1+iℓΛ。**若 ℓ=0**，F=v1，与 Λ **完全无关**。取 v1=0（在闭区间
[0,1] 内，是围道 v-实部环上的一点），F=0 **对任意 Λ>0 精确成立**——
即 attractor 围道（无论 Λ 多大）恒经过 Φ₁₀ 的零点 v=0。

**结论**：claim.md §1 的原始命题（0≤ℓ≤m）在 ℓ=0 处**不成立**：不存在 Λ0 使
∀Λ>Λ0 围道避开零点，因为 Λ 根本不影响此处的相遇。这与 `torsion-immortal-
positivity-hecke/proof.md` Theorem 10.5（假设 0≤ℓ≤m）的 ℓ=0 情形提示了一个
真实的、此前未被記录的边界问题：**d_*(m,n,0) 的围道定义 (R4)/(R5) 若按字面
理解，在 ℓ=0 时穿过 1/Φ₁₀ 的（二阶）极点，需要主值/极限规定，而非普通
收敛积分**。这不在本任务范围内解决，留 [GAP-ℓ0]（见 §5 讨论对上游的影响）。

**因此本证明的其余部分只处理 claim.md 命题 A：0<ℓ≤m。**

---

## §4. n2=0 分支：完全闭合（对 0<ℓ≤m≤n, Δ>0，一切 Λ>0）

### 4.1 方程化简

n2=0 时 Lemma 1 给出（discriminant 也化简，因 4m2n2 项消失）：
```
(I0)  jℓ + 2mn1 − 2nm1 = 0      ⟺   mn1 − nm1 = −jℓ/2
(R0)  n1σ1 − m1ρ1 + jv1 + m2 = 0     （对某 (ρ1,σ1,v1)∈[0,1]³ 恰好成立）
判别式：4m1n1 + j² = 1，j 奇。
```
（注：n2=0 时 m2 在判别式中不出现——它是**完全自由**的整数，只受 (R0) 约束。）

### 4.2 引理 A（宇称）：ℓ 奇 ⟹ (I0) 无解

(I0) 左边 `mn1−nm1` 是整数，`2(mn1−nm1)` 是**偶数**；右边 `−jℓ`，j 奇。
若 ℓ 奇，`jℓ` 是奇×奇=奇，矛盾。**故 ℓ 奇时 n2=0 分支对任意 (m1,n1,j) 都
不可能满足 (I0)，遑论进一步的 (R0)。∎**

*（结合上游 Theorem 10.5 的假设范围：ℓ 从 0 到 m，奇偶各半，本引理关闭了
恰好一半的 n2=0 情形；§3 已处理 ℓ=0；下面处理 ℓ 偶、ℓ>0。）*

### 4.3 引理 B（j 的界）：对 0<ℓ≤m≤n，(I0)+判别式 ⟹ j=±1

设 ℓ 偶，ℓ>0，(m1,n1,j) 满足 (I0) 与判别式 `4m1n1+j²=1`。定义
```
u := nm1+mn1,   w := mn1−nm1 = −jℓ/2   （由 (I0) 直接给出）
```
则 `m1=(u−w)/(2n)`, `n1=(u+w)/(2m)`（由 u,w 定义反解，需 m,n≠0，成立因 m,n≥1），
```
m1n1 = (u²−w²)/(4mn).
```
代入判别式 `4m1n1+j²=1` ⟹ `(u²−w²)/mn + j² = 1` ⟹ `u² = mn(1−j²)+w²`。
代入 `w²=j²ℓ²/4`：
```
u² = mn(1−j²) + j²ℓ²/4 = mn − j²(mn−ℓ²/4) = mn − (Δ/4)j².                (∗)
```
（这里用了 `mn−ℓ²/4 = (4mn−ℓ²)/4 = Δ/4`。）

`u` 是实数（自动是整数，因 m1,n1,m,n 都是整数），故 `u²≥0`，(∗) 给出**必要条件**
```
j² ≤ 4mn/Δ.
```

**关键不等式**：给定 `0<ℓ≤m≤n`，有 `ℓ²≤m²≤mn`（用 ℓ≤m 与 m≤n），故
```
9ℓ² ≤ 9mn < 32mn  ⟹  9ℓ² < 32mn  ⟹  4mn/Δ = 4mn/(4mn−ℓ²) < 9
```
（末一步：`4mn/Δ<9 ⟺ 4mn<9Δ=36mn−9ℓ² ⟺ 9ℓ²<32mn`，已证）。

**结合**：`j² ≤ 4mn/Δ < 9`，j 是奇整数，故 **j²∈{1}**（j²=9 已被严格不等式排除），
即 **j=±1**。∎

### 4.4 引理 C（j=±1 也无解）：完成 n2=0 分支的闭合

取 j=1：w=−ℓ/2，(∗) 给 u²=mn−(Δ/4)=ℓ²/4，u=±ℓ/2。
- u=ℓ/2：`m1=(u−w)/(2n)=(ℓ/2+ℓ/2)/(2n)=ℓ/(2n)`；`n1=(u+w)/(2m)=(ℓ/2−ℓ/2)/(2m)=0`。
  由 `0<ℓ≤m≤n` ⟹ `0<ℓ/(2n)≤m/(2n)≤1/2`，**非整数**（严格在 (0,1/2] 内）。
- u=−ℓ/2：`m1=(−ℓ/2+ℓ/2)/(2n)=0`；`n1=(−ℓ/2−ℓ/2)/(2m)=−ℓ/(2m)`。
  由 `0<ℓ≤m` ⟹ `−1/2≤−ℓ/(2m)<0`，**非整数**。

取 j=−1：w=ℓ/2，(∗) 同样给 u²=ℓ²/4，u=±ℓ/2。
- u=ℓ/2：`m1=(ℓ/2−ℓ/2)/(2n)=0`；`n1=(ℓ/2+ℓ/2)/(2m)=ℓ/(2m)∈(0,1/2]`，非整数。
- u=−ℓ/2：`m1=(−ℓ/2−ℓ/2)/(2n)=−ℓ/n /2... = −ℓ/(2n)∈[−1/2,0)`，非整数；`n1=0`。

**四种子情形全部给出非整数 m1 或 n1。∎**

### 4.5 定理 4（n2=0 分支完全闭合）

**对任意整数 n≥m≥1、0<ℓ≤m、Δ=4mn−ℓ²>0，n2=0 的 Φ₁₀ 零点分支
（对应 (D.19) 中 n2=0 的所有 (m1,n1,m2,j)）都不经过 attractor 围道上的
任何一点——对**一切** Λ>0（不仅是"充分大的 Λ"）。**

**证明**：ℓ 奇由引理 A（无 (I0) 解）；ℓ 偶、ℓ>0 由引理 B+C：任何满足 (I0)+
判别式的 (m1,n1,j) 必是 j=±1 之一，而引理 C 证明 j=±1 都不产生整数解
(m1,n1)。故 n2=0、0<ℓ≤m≤n 情形下 (I0) **本身**（不涉及 m2、不涉及 (R0)、
不涉及 Λ）已经无整数解，围道自然避开。∎

**注**：此定理比 claim.md 目标更强——不需要"Λ 充分大"，对任意 Λ 都成立
（因为障碍在纯数论层面，与几何/解析大小无关）。

---

## §5. n2≠0 分支：p_L/p_R 工具、部分界、与未闭合的 [GAP]

### 5.1 Sen (D.6)-(D.7) 的 p_L, p_R 恒等式（逐字来源 p.165-166）

Sen 在 Appendix C 引言 (C.2)（对**任意**整数 m1,n1,m2,n2,j，非仅判别式=1 的情形）
定义：
```
p_R² := (1/(2Y))|F|²,           Y := det Im Ω
p_L² := p_R² + 2(m1n1+m2n2+j²/4)                                       (D.6变形)
```
且 (D.7) 把 p_L² 显式写成**三个实数的平方和**（恒 ≥0，无需任何假设）：
```
p_L² = (1/(2Y))B1² + (1/(2Y))B2² + 2B3²
```
其中（把 Sen 原文 Appendix D 的 (ρ̃,σ̃,ṽ) 换回本证明记号 (ρ,σ,v)，依据 §1.2 的
identification；Y=ΔΛ² 由 §2 已算出）：
```
B1 = m2+n2(σ2ρ2+σ1ρ1−v1²−v2²)−m1ρ1+n1σ1+jv1
B2 = n2(σ1ρ2−σ2ρ1+2v1v2−2v2²ρ1/ρ2) + m1ρ2 + n1(σ2−2v2²/ρ2) − jv2
B3 = j/2 + n1(v2/ρ2) − n2v1 + n2(v2ρ1/ρ2)
```

**代入 attractor 坐标**（ρ2=2nΛ,σ2=2mΛ,v2=ℓΛ，与 §2 同）得到**精确**：
```
B1 = n2ΔΛ² + g                                          (g 同 §2 定义)
B2 = Λ·b2,   b2 = n2[2nσ1−2mρ1+2ℓv1−ℓ²ρ1/n] + 2nm1+2mn1−n1ℓ²/n − jℓ
B3 = j/2 + (ℓ/(2n))(n1+n2ρ1) − n2v1                      （Λ 无关！）
```
（推导：直接代入并化简，与 §2 手法相同，过程见 scripts/verify_route_a.py 中的
`compute_B1B2B3` 函数，已用符号代入交叉核对。）

### 5.2 关键恒等式：F=0 分支上 p_L²=1/2

Sen (D.6)：`m1n1+m2n2+j²/4 = (1/2)(p_L²−p_R²)`。我们的判别式条件正是
`m1n1+m2n2+j²/4=1/4`。若 F=0（即在 D.19 的零点分支上），则 p_R²=|F|²/(2Y)=0，
代入得 **p_L² = 1/2** 精确成立（不是不等式，是等式，因为(D.6)是恒等式）。

**Proposition 5**。若 attractor 点在 (m1,n1,m2,n2,j) 分支上（F=0），则
```
(i)   B1² ≤ ΔΛ²      即  |n2ΔΛ²+g| ≤ Λ√Δ
(ii)  B2² ≤ ΔΛ²      即  |b2| ≤ √Δ                        （Λ 已约去！）
(iii) B3² ≤ 1/4       即  |j/2+(ℓ/(2n))(n1+n2ρ1)−n2v1| ≤ 1/2
```
（三者之和的 `(1/(2Y))`-加权等于 p_L²=1/2，每项非负，故各自 ≤1/2 的对应量。）

**证明**：`p_L²=(1/(2Y))B1²+(1/(2Y))B2²+2B3²=1/2`，三项皆≥0，故每项≤1/2：
`B1²/(2Y)≤1/2⟹B1²≤Y=ΔΛ²`；同理 `B2²≤ΔΛ²⟹(Λb2)²≤ΔΛ²⟹b2²≤Δ`；
`2B3²≤1/2⟹B3²≤1/4`。∎

### 5.3 由 (iii) 得到 j 的一个界（Λ 无关）

`|B3|≤1/2` 结合三角不等式（ρ1,v1∈[0,1]，ℓ≤m≤n⟹ℓ/n≤1）：
```
|j|/2 ≤ 1/2 + (ℓ/(2n))(|n1|+|n2|) + |n2|  ⟹  |j| ≤ 1+|n1|+3|n2|.        (J)
```

### 5.4 由 (ii) 得到 m1 的一个界（Λ 无关，依赖 (J)）

`n·b2 = n2[2n²σ1−(2mn+ℓ²)ρ1+2nℓv1] + 2n²m1+2mnn1−n1ℓ²−jnℓ`，`|n·b2|≤n√Δ`。
用 ℓ≤m≤n（故 2mn≤2n², ℓ²≤n², nℓ≤n²）与 ρ1,σ1,v1≤1：
```
2n²|m1| ≤ n√Δ + |n2|(2n²+2mn+ℓ²+2nℓ) + 2mn|n1|+ℓ²|n1|+nℓ|j|
        ≤ n√Δ + 7n²|n2| + 2n²|n1| + n²|j|
⟹ |m1| ≤ √Δ/(2n) + 3.5|n2| + |n1| + |j|/2.                              (M)
```
代入 (J)：`|m1| ≤ √Δ/(2n) + 3.5|n2| + |n1| + 0.5(1+|n1|+3|n2|)
              = √Δ/(2n)+0.5 + 1.5|n1| + 5|n2|.`

### 5.5 [GAP-n2] 未闭合的部分：n1 的界

(J)(M) 把 |j|,|m1| 都线性地界定在 |n1|,|n2| 之内（外加与 Λ 无关的常数项），
但**没有**独立界定 |n1| 本身相对于 |n2|（或反之）——这是因为 (I) 方程存在
`(n1,m1)→(n1+nt,m1+mt)` 的移位不变方向（对任意整数 t，(I) 左边
`n2(2nσ1+2mρ1−2ℓv1)+jℓ+2mn1−2nm1` 的 `2mn1−2nm1` 项在此移位下**不变**：
`2m(n1+nt)−2n(m1+mt)=2mn1−2nm1+2mnt−2nmt=2mn1−2nm1`），使得单靠 (I)/(iii)
本身不能排除 n1 沿此方向任意增大。

**需要的闭合论证（未完成，留待下一轮）**：利用判别式 `4m1n1+4m2n2+j²=1`
（尚未使用 m2）+ 不等式 (i)（尚未充分使用，只提取了 n2 的初步信息）联合分析
"移位 t" 下 g（从而 B1）随 t 的**二次**依赖（仿照 §4.3 的技巧：n2=0 情形下
移位使 `m1n1` 随 t² 增长，此处类似地 m2（由判别式定出）也应随 t² 增长，
需要证明这使得 (i) 在 t 与 Λ 联合增大时不能同时满足——这是 §4 技巧向
n2≠0 情形的直接推广，但 n2≠0 时公式中额外出现 n2·(σ1ρ1−v1²) 等交叉项，
使二次型的"顶点"计算更复杂，本轮未能在预算内完成代数闭合）。

**替代/更强的路线（也未完成）**：直接使用一般 Siegel 约化理论
（Siegel 1943 "Symplectic Geometry"、或 Klingen *Introduction to Modular Forms
of Several Variables* 第 I 章的亏格 2 基本域定理）证明 `Y=Λ·adj(T)`（T 已
GL(2,ℤ) 约化）对应的 Ω 落在 Sp(4,ℤ) 基本域的一个**固定紧集邻域**内（当
Λ→∞，沿此特定方向），因此只有有限多个（与 Λ 无关个数的）Sp(4,ℤ) 陪集代表
可能接近——这是标准但需要引用/重新证明经典约化定理的论证，本次未展开。

**结论（诚实标注）**：n2≠0 分支**未完全闭合**。已建立的是：
(a) 精确的 B1,B2,B3 公式（可复用的计算工具）；
(b) F=0 蕴含 p_L²=1/2 精确等式，从而 (i)(ii)(iii) 三条必要不等式；
(c) 由 (iii)+(ii) 得到 |j|,|m1| 关于 |n1|,|n2| 的线性界；
(d) 剩余缺口是 |n1| 相对 |n2|（或反之）的独立界，指向经典 Sp(4,ℤ) 约化理论
    或 §4.3 技巧的推广，两条路线都具体但未完成。

---

## §6. 数值验证

见 `scripts/verify_route_a.py`。方法：对 10 组 (n,m,ℓ)（含 n=m、ℓ=m、ℓ=0 边界）
与若干 Λ 值，在有界搜索范围内枚举满足判别式的整数元组 (m1,n1,m2,n2,j)，对每个
元组在闭方体 (ρ1,σ1,v1)∈[0,1]³ 上做网格搜索找 |F|² 的最小值，报告全局最小值。

**预期与实际结果**（脚本运行后填写，见下方"运行记录"）：
- ℓ=0 样本：应在网格分辨率内找到 |F|²≈0（对应 v1=0 精确解，任何 Λ）。
- n2=0 精确解已解析证明不存在（0<ℓ≤m≤n）；数值应看到 min|F|² 有限
  正下界（不会精确为 0，但会显示"最接近"的搜索结果，量级检验解析论证）。
- n2≠0：网格+有界枚举下未发现 |F|²≈0 的情形（支持猜想但非证明，见 §5 GAP）。

### 运行记录

运行方式：`python scripts/verify_route_a.py`（Windows 环境下 `python3` 指向
WindowsApps 的存根，会立即以 exit code 49 失败且不产生输出；须用 `python`，
指向实际的 CPython 3.12 安装）。运行耗时 6 秒，退出码 0。

**结果摘要**（完整输出见下）：
- 3 个 ℓ=0 样本（(n,m,ℓ)=(2,2,0),(5,3,0),(10,1,0)）：**对全部 7 个 Λ 值，
  min|F|²=0 精确**，均在 argmin tuple=(0,0,0,0,−1)（即§3的平凡分支 F=∓v，
  j=−1 与 j=1 只差 F 的整体符号，不影响 |F|²=0）、点 (ρ1,σ1,v1)=(0,0,0) 达到
  ——**与 §3 的解析反例逐位一致**（v1=0 恰是网格点，Im v=ℓΛ=0，故 F=v=0
  对任意 Λ 精确成立）。脚本明确报告 "VIOLATION"。
- 其余 7 个样本（ℓ>0，含 ℓ 奇/偶、n=m/n>m 边界）：对全部 7 个 Λ 值，
  **未发现** |F|²<1e-9 的情形；min|F|² 随 Λ² 增长（如 (n,m,ℓ)=(2,2,2) 从
  Λ=1 的 4 增长到 Λ=100 的 4×10⁴，符合 Re F 中 −n2ΔΛ² 主导项的量级预期，
  argmin 多落在 n2=0、j=±1 的平凡候选上，与 §4 引理 C 证明"j=±1 时
  (m1,n1) 非整数"一致——网格搜索天然只测试整数元组，找不到这些非整数
  interpolation 点，min|F|² 停在 O(1)~O(Λ²) 量级，不趋于 0）。**与 §4 定理 4
  （n2=0 完全排除）及 §5 的（未完全闭合的）n2≠0 预期均一致，不构成对
  n2≠0 情形的证明，只是搜索范围内的健全性检查**（见脚本文档字符串的
  scope 声明）。

**完整输出**：

```
Route A numerical verification -- pure Python, no numpy/scipy.
Lambda grid: [1, 2, 5, 10, 20, 50, 100]
Tuple search bounds: |m1|,|n1|<=5, |n2|<=1, |j|<=5, m2 solved from discriminant (n2!=0) or scanned in [-3,3] (n2=0).
Cube grid: 5x5x5 uniform points in [0,1]^3 per (tuple, Lambda).

[n=m=1, ell=m=1 (odd, parity-excluded for n2=0)]

=== sample (n,m,ell)=(1,1,1)  Delta=3 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=1.000000e+00  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda=  2.00  min|F|^2=4.000000e+00  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda=  5.00  min|F|^2=2.500000e+01  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda= 10.00  min|F|^2=1.000000e+02  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda= 20.00  min|F|^2=4.000000e+02  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda= 50.00  min|F|^2=2.500000e+03  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda=100.00  min|F|^2=1.000000e+04  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  >>> GLOBAL min over this Lambda grid: |F|^2=1.000000e+00 at Lambda=1, tuple=(-1, 0, -1, 0, -1)
  >>> no violation found in this search (does NOT prove absence outside search bounds; see proof.md GAP-n2)

[n=m=2, ell=m=2 (even boundary)]

=== sample (n,m,ell)=(2,2,2)  Delta=12 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=4.000000e+00  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda=  2.00  min|F|^2=1.600000e+01  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda=  5.00  min|F|^2=1.000000e+02  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda= 10.00  min|F|^2=4.000000e+02  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda= 20.00  min|F|^2=1.600000e+03  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda= 50.00  min|F|^2=1.000000e+04  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  Lambda=100.00  min|F|^2=4.000000e+04  argmin tuple=(-1, 0, -1, 0, -1)  (rho1,sigma1,v1)=(1.0, 0.0, 0.0)
  >>> GLOBAL min over this Lambda grid: |F|^2=4.000000e+00 at Lambda=1, tuple=(-1, 0, -1, 0, -1)
  >>> no violation found in this search (does NOT prove absence outside search bounds; see proof.md GAP-n2)

[n=m=2, ell=1 (odd)]

=== sample (n,m,ell)=(2,2,1)  Delta=15 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=1.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  2.00  min|F|^2=4.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  5.00  min|F|^2=2.500000e+01  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 10.00  min|F|^2=1.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 20.00  min|F|^2=4.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 50.00  min|F|^2=2.500000e+03  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=100.00  min|F|^2=1.000000e+04  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  >>> GLOBAL min over this Lambda grid: |F|^2=1.000000e+00 at Lambda=1, tuple=(0, 0, 0, 0, -1)
  >>> no violation found in this search (does NOT prove absence outside search bounds; see proof.md GAP-n2)

[n=m=2, ell=0 (boundary counterexample expected)]

=== sample (n,m,ell)=(2,2,0)  Delta=16 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=  2.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=  5.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 10.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 20.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 50.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=100.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  >>> GLOBAL min over this Lambda grid: |F|^2=0.000000e+00 at Lambda=1, tuple=(0, 0, 0, 0, -1)
  >>> VIOLATION (contour meets a zero) at Lambda=1: tuple=(0, 0, 0, 0, -1), point=(0.0, 0.0, 0.0)

[n=3,m=2, ell=2=m (even boundary)]

=== sample (n,m,ell)=(3,2,2)  Delta=20 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=4.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  2.00  min|F|^2=1.600000e+01  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  5.00  min|F|^2=1.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 10.00  min|F|^2=4.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 20.00  min|F|^2=1.600000e+03  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 50.00  min|F|^2=1.000000e+04  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=100.00  min|F|^2=4.000000e+04  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  >>> GLOBAL min over this Lambda grid: |F|^2=4.000000e+00 at Lambda=1, tuple=(0, 0, 0, 0, -1)
  >>> no violation found in this search (does NOT prove absence outside search bounds; see proof.md GAP-n2)

[n=3,m=2, ell=1 (odd)]

=== sample (n,m,ell)=(3,2,1)  Delta=23 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=1.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  2.00  min|F|^2=4.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  5.00  min|F|^2=2.500000e+01  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 10.00  min|F|^2=1.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 20.00  min|F|^2=4.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 50.00  min|F|^2=2.500000e+03  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=100.00  min|F|^2=1.000000e+04  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  >>> GLOBAL min over this Lambda grid: |F|^2=1.000000e+00 at Lambda=1, tuple=(0, 0, 0, 0, -1)
  >>> no violation found in this search (does NOT prove absence outside search bounds; see proof.md GAP-n2)

[n=5,m=3, ell=0 (boundary counterexample expected)]

=== sample (n,m,ell)=(5,3,0)  Delta=60 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=  2.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=  5.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 10.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 20.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 50.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=100.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  >>> GLOBAL min over this Lambda grid: |F|^2=0.000000e+00 at Lambda=1, tuple=(0, 0, 0, 0, -1)
  >>> VIOLATION (contour meets a zero) at Lambda=1: tuple=(0, 0, 0, 0, -1), point=(0.0, 0.0, 0.0)

[n=5,m=3, ell=2 (even, 0<ell<m)]

=== sample (n,m,ell)=(5,3,2)  Delta=56 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=4.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  2.00  min|F|^2=1.600000e+01  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  5.00  min|F|^2=1.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 10.00  min|F|^2=4.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 20.00  min|F|^2=1.600000e+03  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 50.00  min|F|^2=1.000000e+04  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=100.00  min|F|^2=4.000000e+04  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  >>> GLOBAL min over this Lambda grid: |F|^2=4.000000e+00 at Lambda=1, tuple=(0, 0, 0, 0, -1)
  >>> no violation found in this search (does NOT prove absence outside search bounds; see proof.md GAP-n2)

[n=10,m=5, ell=4=m (even boundary)]

=== sample (n,m,ell)=(10,5,4)  Delta=184 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=1.600000e+01  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  2.00  min|F|^2=6.400000e+01  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=  5.00  min|F|^2=4.000000e+02  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 10.00  min|F|^2=1.600000e+03  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 20.00  min|F|^2=6.400000e+03  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda= 50.00  min|F|^2=4.000000e+04  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  Lambda=100.00  min|F|^2=1.600000e+05  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)
  >>> GLOBAL min over this Lambda grid: |F|^2=1.600000e+01 at Lambda=1, tuple=(0, 0, 0, 0, -1)
  >>> no violation found in this search (does NOT prove absence outside search bounds; see proof.md GAP-n2)

[n=10,m=1, ell=0 (boundary counterexample expected, m=1)]

=== sample (n,m,ell)=(10,1,0)  Delta=40 ===
  tuple search space size: 1858
  Lambda=  1.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=  2.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=  5.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 10.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 20.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda= 50.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  Lambda=100.00  min|F|^2=0.000000e+00  argmin tuple=(0, 0, 0, 0, -1)  (rho1,sigma1,v1)=(0.0, 0.0, 0.0)  <-- NEAR-ZERO (|F|^2 < 1e-9)
  >>> GLOBAL min over this Lambda grid: |F|^2=0.000000e+00 at Lambda=1, tuple=(0, 0, 0, 0, -1)
  >>> VIOLATION (contour meets a zero) at Lambda=1: tuple=(0, 0, 0, 0, -1), point=(0.0, 0.0, 0.0)
```

---

## §7. 与上游 Theorem 10.5 / Route A 的关系（诚实评估）

1. **本证明的直接产出**：D.19 逐字精确形式（§1，弥补此前抽取记录的转述缺口）；
   n2=0 分支（"线性壁"）对 0<ℓ≤m≤n **完全**闭合（§4，Λ 无关的强结果）；
   n2≠0 分支（"二次壁"）建立了 p_L/p_R 工具与部分界，未完全闭合（§5）。

2. **ℓ=0 反例（§3）是一个新发现**，尚未被 `torsion-immortal-positivity-hecke/
   proof.md` §10.5 记录。Theorem 10.5 的假设是 "0≤ℓ≤m"（闭区间），若其证明
   路线（任何路线，不限于 Route A）依赖"围道避开 Φ₁₀ 零点"这一几何事实，
   则 ℓ=0 情形需要单独处理（原点 v=0 的主值/留数贡献），不能套用"Λ 充分大"
   的论证模式。**建议**：上游 proof.md 在引用本尝试时，把 Theorem 10.5 的
   n2=0 相关部分限定为 0<ℓ≤m，ℓ=0 另立小节。

3. **即使 n2≠0 分支完全闭合，也不能直接推出 [GAP 10.5.a]**（FJ 级数收敛性）。
   "围道避开零点"只保证 1/Φ₁₀ 在围道**本身**（一个二维环面）上处处有限，
   是 FJ 展开逐项积分合法性的**必要**条件，不是**充分**条件——逐项积分还
   需要控制级数在围道**邻域**内的一致收敛性（[GAP 10.5.c] 的 Weierstrass/
   Mellin 型估计），这是分析问题，不是代数几何问题，本尝试的方法（有限
   維代数不等式）不能触及。因此本尝试是 Route A 的**必要**砖块之一，
   而非全部。

4. **不更新 upstream proof.md §10.5.4 为"已闭合"**——因 n2≠0 分支未闭合，
   且[GAP 10.5.a]本身超出本尝试范围。将在 upstream 添加一条**指针**（非
   声称闭合），说明本 attempt 的进展与局限，供后续引用。

---

## 结论清单

**已证明（完整、严格）**：
- Lemma 1（Re/Im 精确分解，对一切 Λ>0，一切整数元组）。
- ℓ=0 反例：围道对任意 Λ 都经过 Φ₁₀ 零点 v=0（§3）。
- Theorem 4：n2=0 分支对 0<ℓ≤m≤n（一切 Λ>0）完全避开（§4，含引理 A/B/C）。
- Proposition 5：F=0 分支上 p_L²=1/2 精确成立，导出 (i)(ii)(iii) 三条必要不等式，
  并由此导出 (J)(M) 两条 Λ-无关的线性界（§5.1-5.4）。

**未证明 / [GAP]**：
- [GAP-identify]（§1.2）：Sen "Φ̃ 自身坐标 = 标准 Φ₁₀ 坐标" 的等同，是合理推断
  但非文献逐字断言（不影响 D.19 公式本身的使用，只影响"这是哪一份 Φ₁₀
  变量的零点"这一诠释问题——经 GN1996 交叉验证支持）。
- [GAP-ℓ0]（§3/§7.2）：ℓ=0 情形的 d_*(m,n,0) 需要独立的主值/留数处理，
  不在本尝试范围。
- [GAP-n2]（§5.5）：n2≠0 分支的 |n1| vs |n2| 独立界未建立，两条候选路线
  （§4.3 技巧推广 / 经典 Sp(4,ℤ) 约化理论）均具体但未完成。
