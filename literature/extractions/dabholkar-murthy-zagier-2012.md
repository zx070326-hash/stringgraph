# 抽取记录：dabholkar-murthy-zagier-2012

- 文献：A. Dabholkar, S. Murthy, D. Zagier, "Quantum Black Holes, Wall Crossing, and Mock Modular Forms," arXiv:1208.4074 (151 pp.), 2012
- 抽取者：lead (direct, 2026-09-14)
- 日期：2026-09-14
- 覆盖范围：摘要、§1–§3（引言与分解定理主结果）、§6（物理识别）；151页未完整通读，标注待核处

## 约定

- Jacobi 形式的权 k、指标 m：φ(τ,z)，在 SL(2,ℤ)×Z² 下满足标准变换律。
- "亚纯 Jacobi 形式"（meromorphic Jacobi form）= 在 z 处有极点的 Jacobi 形式（标准 Jacobi 形式要求 z 处全纯）。
- "mock Jacobi 形式"：有全纯部分（shadow 意义下的调和推广），满足 Zwegers 框架下的非全纯完备化。
- Appell–Lerch 和 A_m(τ,z)：用于编码极点结构，定义见 DMZ §2。

## 陈述

### E1 亚纯 Jacobi 形式的典范分解（DMZ 分解定理）
- 位置：§3，Theorem 1（页码待核），含引言摘要
- 类型：proposition
- 原文陈述（忠实转述）：任意权 k、整数指标 m 的亚纯 Jacobi 形式 φ(τ,z)（在 z=0 处有二阶极点、由 SL(2,ℤ)×Z² 变换律确定）有唯一典范分解
  φ = φ_F + φ_P，
  其中 φ_F（"有限部" / "mock 部"）是一个 mock Jacobi 形式（满足 Zwegers 调和 Maass 框架下的完备化），φ_P（"极点部"）是 Appell–Lerch 和的线性组合；唯一性是"至多相差一个正则 Jacobi 尖点形式"意义下的典范性。
- 文献自称的严格程度：定理（"Theorem"），Zagier 是作者之一；证明建立在 Zwegers 2002 论文的框架上，并通过对极点结构的系统分析完成。
- 文献列出的依赖：Zwegers 2002（mock theta 函数的调和 Maass 刻画）；经典 Jacobi 形式理论（Eichler-Zagier 1985）；Appell–Lerch 和的性质。
- 备注：这是**严格数学定理（rigorous）**；Zagier 是数论领域权威，证明在数学文献中被接受。对物理的应用需要额外的识别步（见 E3）。

### E2 Appell–Lerch 和的极点结构
- 位置：§2，定义部分
- 类型：definition
- 原文陈述（忠实转述）：对整数 m ≥ 1，定义权 1、指标 m 的 Appell–Lerch 和
  A_m(τ,z) = e^{2πimz} ∑_{n∈ℤ} (e^{2πinz})^m / (1 − e^{2πi(nτ+z)})(待核精确公式)；
  A_m 在 z = pτ+q（p,q∈ℤ）处有一阶极点，且极点结构完全编码了 Jacobi 形式的极点数据。
- 文献自称的严格程度：定义，性质经代数验证。
- 文献列出的依赖：经典 theta 函数（Jacobi theta）；Appell 函数经典文献。
- 备注：待核精确表达式，需对照 DMZ 原文 §2.1–§2.2。

### E3 DMZ 单心识别：mock 部分 = 单心（immortal）黑洞简并度
- 位置：§6（物理应用），文中论证
- 类型：proposition
- 原文陈述（忠实转述）：将 DVV 生成函数 1/Φ₁₀ 中对应 N=4 弦论 1/4-BPS dyon 的 Jacobi 形式展开系数分解为典范分解，φ_F（mock 部分）的傅里叶系数被识别为**单心（immortal）黑洞**的简并度，φ_P（极点部分）对应多心（分裂态，mortal）黑洞的贡献，后者在壁穿越时跳变。
- 文献自称的严格程度："we identify" / 物理论证，基于对 1/Φ₁₀ 极点与多心分裂态的对应分析。作者明确指出，mock 部分的物理识别依赖"单心黑洞在任何 chamber 中都稳定"这一物理假定。
- 文献列出的依赖：E1（分解定理，严格）；DVV 1997（E2 中的 1/Φ₁₀ 识别，physical-argument）；Sen 壁穿越公式；"immortal dyon"的物理定义（仅在固定 chamber 计数）。
- 备注：这是**物理识别（physical-argument）**——识别③。它依赖 E1 的严格数学分解，但把数学对象 φ_F 与物理对象"单心黑洞"对应是物理论证，不是数学定理。

### E4 唯一性的歧义：Jacobi 尖点形式的不确定性
- 位置：§3，定理陈述后的注记
- 类型：proposition
- 原文陈述（忠实转述）：典范分解 φ = φ_F + φ_P 中，φ_F 的唯一性是"至多差一个（正则）Jacobi 尖点形式"——即若 ψ 是一个全纯的 Jacobi 尖点形式，则 φ_F + ψ 也是合法的 mock Jacobi 形式，满足同样的分解。物理上，这个歧义通过要求 φ_F 在某个 chamber 中系数非负（= 真实正整数简并度）来固定。
- 文献自称的严格程度：数学上的唯一性注记（定理陈述的一部分）；物理固定歧义的论证是物理论证。
- 文献列出的依赖：E1；Sen positivity（物理要求正性以固定歧义）。
- 备注：这一歧义是图节点中"识别③是否可升格为 rigorous"的关键脆点（见侦察报告候选 C）。

## 未解决的疑问

1. 精确的 Appell–Lerch 和公式（E2）需对照 DMZ 原文 §2 核实，本抽取从摘要和引言转述。
2. E1 的"典范性"定义：DMZ 是否给出一个不依赖额外物理条件的唯一 mock 部分，还是必须加物理正性条件才能唯一确定？需核实 §3 末尾的精确陈述。
3. Zwegers 2002 框架（调和 Maass 形式）本身未在本文证明，作为引用输入；Lean 形式化时需先处理 Zwegers 层。
