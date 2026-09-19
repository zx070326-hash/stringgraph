# 抽取记录：sen-2007-wall-crossing

- 文献：A. Sen, "Wall Crossing Formula for N=4 Dyons," JHEP 0712 (2007) 084, arXiv:hep-th/0702141
- 抽取者：lead (direct, 2026-09-14)
- 日期：2026-09-14
- 覆盖范围：摘要、引言及 §2–§4（壁穿越公式推导与围道识别）；未完整通读全文，标注待核处

## 约定

- N=4 弦论：type II on K3×T²（或杂化 on T⁶），四维。
- 1/4-BPS dyon 带荷向量 (Q,P)，Q²/2 = m, P²/2 = n, Q·P = l（均为整数）。
- dyon 指标（第六螺旋超迹）：d(m,n,l) = −B₆。
- "壁"（wall of marginal stability）：模空间中 1/4-BPS 态变为边缘稳定（可分裂为两个 1/2-BPS 态）的超曲面。
- Siegel 上半空间变量 Ω = (ρ v; v σ)，与 DVV 约定一致。

## 陈述

### E1 壁穿越公式（N=4 dyon 指标的跳变）
- 位置：§2–§3，式 (2.x)–(3.x)（具体式号待核）
- 类型：proposition
- 原文陈述（忠实转述）：当模参数穿越 1/4-BPS dyon (Q,P) 的边缘稳定壁时，其指标 d(m,n,l) 的跳变为
  Δd(m,n,l) = (−1)^{Q·P+1} (Q·P) · d_{1/2}(Q²/2) · d_{1/2}(P²/2)，
  其中 d_{1/2}(k) 是具有电荷平方 2k 的 1/2-BPS 态（半 BPS 态）的指标（由 1/η²⁴ 或类似函数给出），Q·P 为整数内积。
- 文献自称的严格程度："we derive" / "we show"；推导基于 1/Φ₁₀ 的极点结构分析（Siegel 模形式的留数计算），结合物理的边缘稳定性条件。
- 文献列出的依赖：DVV 1997（E2 中的 1/Φ₁₀ 识别，physical-argument）；Φ₁₀ 在 n·ρ+m·σ+l·v=0 处有二阶极点（数学事实，严格）；极点的留数因子化 = 半-BPS 指标之积（留数计算严格，但因子识别为物理态是 physical-argument）。
- 备注：这是**识别②**（physical-argument）——围道选择 = 壁穿越，留数因子化 = 半-BPS 简并度之积。留数计算本身是严格复分析（rigorous），但把极点位置识别为物理模空间中的壁需要物理论证。

### E2 Φ₁₀ 极点的数学结构
- 位置：§2，文中讨论
- 类型：proposition
- 原文陈述（忠实转述）：Φ₁₀(ρ,σ,v) 的零点（= 1/Φ₁₀ 的极点）位于超平面 {mρ + nσ + lv = 0 (mod 1)}（m,n ∈ ℤ, l ∈ ℤ, gcd(m,n,l) = 1, m,n ≥ 0）；在这些极点上 Φ₁₀ 有单零点，因而 1/Φ₁₀ 有简单极点；极点的留数因子化为两个 Jacobi 形式（对应两个半-BPS 子系统）的乘积。
- 文献自称的严格程度：引用已知 Φ₁₀ 的数学性质；留数因子化通过直接计算给出。
- 文献列出的依赖：DVV 1997；Igusa 尖点形式的经典性质（Gritsenko-Nikulin, Borcherds）。
- 备注：**数学部分（极点位置与留数因子化）是 rigorous**；物理识别（极点位置 = 壁的位置）是 physical-argument。

### E3 围道选择与模参数 chamber 的对应
- 位置：§3，图示及讨论
- 类型：proposition
- 原文陈述（忠实转述）：DVV 生成函数中的傅里叶积分围道（在 Siegel 上半空间中积分 ρ, σ, v 的虚部路径）与 dyon 所在的 BPS chamber（模参数 τ = τ₁ + iτ₂ 的区域，由 Arg(τ_2/(|τ|²)) 等参量决定）之间有一一对应：特定围道给出特定 chamber 中的 dyon 指标 d(m,n,l)。
- 文献自称的严格程度：物理论证；基于边缘稳定性条件与超引力模空间几何的对比。
- 文献列出的依赖：E1；DVV 1997；Cheng-Verlinde 2007（并行工作）。
- 备注：这是 physical-argument 的核心内容，不是数学定理。图和模空间之间的精确识别依赖超引力语言。

### E4（★核心补充，2026-09-20）：Sen 2007 关于墙穿越的核心陈述（从 arXiv PDF 逐字确认）

- 位置：摘要 + §1（pp.1-5），arXiv:hep-th/0702141
- 类型：proposition
- 原文陈述（逐字）：
  
  **摘要，p.1**："The spectrum of quarter BPS dyons in N=4 supersymmetric string theories can change as the asymptotic moduli cross walls of marginal stability on which the dyon can break apart into a pair of half BPS states. … We argue that the dyon partition functions in different domains separated by marginal stability walls are the same, but the choice of integration contour needed for extracting the degeneracies from the partition function differ in these different regions. … **in the limit of large charges the change in the degeneracy is exponentially suppressed** compared to the leading contribution."

  **§1，p.4**："We find that **the change in the degeneracy is proportional to the total degeneracy of the half-BPS electric and magnetic states** into which the original dyon can decay on this particular marginal stability wall."
  
- 文献自称的严格程度："we argue" / "we find"；基于围道变形与极点留数分析。
- **判定（researcher，2026-09-20，逐字核对原文后）**：
  - Sen 2007 讨论的是**跨墙跳变 Δd**，不是"单个围道在某个极点的留数"
  - 原文**没有给出形如 `Res(1/Φ₁₀) = f·g` 的留数因子化公式**
  - 只说"change is proportional to … half-BPS … degeneracy"（比例关系，未给精确系数结构）
  - **Q·P 线性因子未在摘要或 §1-§3 中以公式形式出现**——需查阅 §4 或后续章节

### E5（2026-09-20）：Sen 2007 未明确给出的内容（诚实记录）

**在已读章节（摘要 + §1-§3，pp.1-15）中未找到**：
1. 显式的 `Δd = (−1)^{Q·P+1} (Q·P) · d₁/₂(...) · d₁/₂(...)` 公式及其式号
2. "1/Φ₁₀ 在二阶极点的留数因子化闭式"
3. Q·P 线性因子的显式出现位置

**原因分析**：
- Sen 2007 的主要结果是**围道变形规则**与**跳变的定性结构**（正比于半-BPS 简并度之积）
- 具体的留数计算细节可能在：
  - §4"Duality Transformation"或更后面的章节
  - 或在 Sen 的后续论文（如 Sen 2008 arXiv:0708.1270）中完善
- 已有抽取记录 E1 的 `Δd = (−1)^{Q·P+1} (Q·P) · ...` 公式**来源待核实**（可能是从后续文献或 Sen 2010 综述转引）

## 未解决的疑问

1. **（2026-09-20 更新）壁穿越公式 `Δd = (−1)^{Q·P+1} (Q·P) · d₁/₂(...) · d₁/₂(...)` 的精确出处**：已读章节（pp.1-15）未见此公式；需查阅 Sen 2007 §4 之后或 Sen 2008/2010 后续工作。
2. "d_{1/2}(k) = 1/η²⁴ 傅里叶系数"与 Dabholkar-Harvey 的 1/2-BPS 计数的精确对应需核实（文献中有时用 Dedekind eta，有时用 K3 椭圆亏格）。
3. E3 中围道与 chamber 的对应在后续 Banerjee-Sen 2007（arXiv:0708.1270）中有更系统化处理，节点应引用两篇。
4. **（2026-09-20 新增）Sen 2007 未给出"1/Φ₁₀ 在极点的留数因子化闭式"**——只给出跳变的物理图像（正比于半-BPS 简并度）与围道变形规则；留数的精确数学表达式需从 Sen 2008 Appendix C/D 或数学文献补充。
