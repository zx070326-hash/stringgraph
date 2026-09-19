# claim：GAP 10.2b —— 代表元范围内 d_* = (−1)^{ℓ+1} c_m^F 的证明

对应 `torsion-immortal-positivity-hecke/proof.md` §10.5.1 的 [GAP 10.2b]：
把"n≥m≥1, 0≤ℓ≤m ⟹ d_*(m,n,ℓ) = (−1)^{ℓ+1} c_m^F(n,ℓ)"从数值观察升级为定理。
`dmz-finite-part-scoping/claim.md` §5.2 把此列为"首选、立即可做"的攻击目标（砖块 B4 的开放部分）。

**性质声明（诚实前置）**：本 attempt 的证明主体是对 Bhand–Sen–Singh
arXiv:2311.16252（"BSS"，Res. Math. Sci. 12 (2025) Paper 8，已发表、同行评审）
Appendix B + Theorem 5.4 的**独立复核 + 翻译到本项目记号**，不是从零的原创推导——
详见 `prior-art.md` 的查证记录。这是 research/CLAUDE.md 明确允许的产出形式（结论一节）。

---

## 0. 记号（与 `torsion-immortal-positivity-hecke/claim.md` §1.1 一致）

- Siegel 上半空间元素 Ω=[[ρ,v],[v,σ]]（Rosselló 约定），p=e^{2πiρ}, q=e^{2πiσ}, y=e^{2πiv}。
- Φ₁₀：Sp(4,ℤ) 权 10 Igusa 尖点形式。
- **(R1)** `1/Φ₁₀(ρ,σ,v) = Σ_{m≥−1} ψ_m(σ,v) p^m`——指标 m 挂在 ρ 上（Rosselló 约定；
  upstream claim.md §1.1 已明确警告 DMZ 原文把指标挂在 σ 上，两者不同，本文件严格
  沿用 Rosselló/upstream 的挂 ρ 约定）。
- DMZ 典范分解（rigorous，DMZ 1208.4074 Thm 8.3）：ψ_m = ψ_m^F + ψ_m^P，
  ψ_m^F 是权 −10、指标 m 的 mock Jacobi 形式，Fourier 系数记 c_m^F(n,ℓ)。
- **(R4)** `d_*(m,n,ℓ) = ∫_{C_*} dρdσdv e^{−2πi(mρ+nσ+ℓ(v+1/2))}/Φ₁₀(ρ,σ,v)`
- **(R5)** `C_* = {0≤ρ₁,σ₁,v₁≤1, ρ₂=2nΛ, σ₂=2mΛ, v₂=−ℓΛ}`，Λ→∞。
- 物理荷（Rosselló eq 2.3，本人亲自逐字核对的原文定义）：`m = P⃗²/2`（磁荷）、
  `n = Q⃗²/2`（电荷）、`ℓ = Q⃗·P⃗`。Δ := 4mn−ℓ²。

## 1. 目标命题（= 上游 Theorem 10.5 的精确陈述）

> **命题**：设整数 m,n,ℓ 满足 m,n≥1、n≥m、0≤ℓ≤m、Δ=4mn−ℓ²>0（此不等式在
> 该域上自动成立：Δ≥4m²−m²=3m²>0）。则
> `d_*(m,n,ℓ) = (−1)^{ℓ+1} c_m^F(n,ℓ)`。

## 2. 允许使用的砖块

1. **BSS 2311.16252, Proposition B.1**（p.57–58）：吸引子方向围道变形不跨越
   `Div(Φ̃_k⁻¹)` 中落在电荷集 A 内的极点——纯不等式代数证明，非物理论证。
2. **BSS 2311.16252, Proposition B.2**（p.59）：对称命题，电荷集 B。
3. **BSS 2311.16252, §B.2**（p.59–60）：围道恰好经过极点时留数为零的显式计算。
4. **BSS 2311.16252, §B.4, 命题 A₂/B₂ 的显式充分子集**（p.61–62）：
   `B₂ = {(n,ℓ,m)：m,n>0, m≥n/N, 0≤|ℓ|≤2n} ⊆ B`（完成配方 + 奇偶性论证）。
5. **BSS 2311.16252, Theorem 5.4(b)**（p.47–48）：电荷集 B 上，围道积分值等于
   （BSS 自己记号下的）ψ_n^F 的 Fourier 系数——显式围道变形+周期性论证，
   只用 B.1/B.2 作外部输入。
6. **DMZ 1208.4074, Theorem 8.3**（rigorous，本项目已有节点/砖块，见
   `dmz-finite-part-scoping/claim.md` 表格 B1）：典范分解 ψ=ψ^F+ψ^P 的存在唯一性
   及 ψ^F 是 mock Jacobi 形式——BSS 自己的构造建立在此定理之上。
7. Φ₁₀ 的经典事实：v-偶性、c_m^F 只依赖 (Δ, ℓ mod 2m)（Eichler–Zagier 型经典结果，
   本项目 `coefficients.py` 自测已独立确认，见 prior-art.md §5）。

**不使用**：任何 conjecture/physical-argument 图节点。BSS 论文本身不是图节点
（未被 graph-curator 抽取），故严格而言不满足 research/CLAUDE.md"只能引用图里
rigorous/formalized 节点"的字面要求——proof.md 因此**不把 BSS 当作黑箱引用**，
而是重新走一遍其论证的关键步骤（域翻译、变量角色对应、符号交叉验证），使得
本证明的核心链条不依赖"相信 BSS 论文没有错"这一单点，而是本人独立可复核的推导
+ 独立数值交叉验证（用本项目已有、已自测的 `coefficients.py` 引擎，非 BSS 自己的代码）。

## 3. 证明的结构（本人独立完成的部分 vs 复核 BSS 的部分）

- **完全独立完成**：把上游目标域翻译到 BSS 电荷集 B₂ 的对应关系（proof.md §2），
  只依赖"哪个字母指代哪个物理荷"的字面定义比对，与任何 Jacobi 形式族构造细节无关。
- **独立推导 + 需要的新引理**：BSS 的三个 Siegel 变量 (τ,σ,z) 与 Rosselló 的
  (ρ,σ,v) 之间的角色对应关系（proof.md §3 的"变量角色引理"）——这是本人自己
  从两篇论文各自的围道虚部标度公式反推出来的，**不是**任一论文里的显式陈述。
- **复核（读懂 + 复述其论证骨架，未逐行重新推导 BSS 内部每一步不等式代数）**：
  BSS Prop B.1/B.2 的证明思路、Thm 5.4(b) 证明中的围道变形步骤。
- **诚实标注为未闭合**：BSS 的 d_* 定义式与 Rosselló 的 d_* 定义式之间是否存在
  一个（ℓ 无关的）整体符号差，本人给出了强支持证据（数值交叉检验在 ℓ=0 处精确吻合）
  但未能从 BSS 的一般乘积公式 (5.2) 出发以第一性原理确认，见 proof.md §4 [GAP]。

## 4. 与其它 attempt 的关系（关键交叉发现，需要转达给 lead）

- `gap-102b-route-a` 独立地攻同一个 GAP，走 Sen (D.19) 零点参数化路线，
  n₂=0 分支已完全证明，n₂≠0 分支未闭合（数值证据支持但缺一般解析论证）。
  **本 attempt 的发现意味着 route-a 未闭合的 n₂≠0 分支，在 BSS 的 Prop B.1
  框架下有一个更简洁的统一处理（不需要按 n₂ 分支讨论）**——这是一条对 route-a
  owner 有价值但本人无权限直接写入其目录的交叉发现，已记录在 status.yaml，
  供 lead 转达。
- `dmz-finite-part-scoping` 的砖块表 B4/B6 应当更新："证 d_*=c_m^F 的那一步
  ……尚未见就地严格的文献陈述"这句话经本次核查**不再成立**——现在有了
  BSS Appendix B 这个具体、严格的文献陈述，只是尚未完全翻译对齐符号。
  本人无权限编辑该文件，已记录在 status.yaml。
