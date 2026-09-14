# 抽取记录：denef-moore-2007

- 文献：F. Denef, G. W. Moore, "Split States, Entropy Enigmas, Holes and Halos," JHEP 1111 (2011) 129, arXiv:hep-th/0702146 (originally 2007)
- 抽取者：lead (direct, 2026-09-14)
- 日期：2026-09-14
- 覆盖范围：摘要与引言（§1）、§2（分裂态 / multi-center BPS）、§5（熵谜题与壁穿越）；未完整通读，标注待核处

## 约定

- N=2 弦论（type II on Calabi-Yau 三折叠，或 N=4 的特殊情形作为子案例）。
- 四维黑洞（D4-D2-D0 系统或更一般的 D-brane bound state）。
- 中心荷 Z(γ; t)，Kähler 模 t；BPS 黑洞满足 |Z(γ)| = M_BH。
- Attractor 机制：极端 BPS 黑洞的模空间流 t(r) 在 r→0 流向 attractor 点。

## 陈述

### E1 分裂态（split states）的存在性与壁穿越
- 位置：§1–§2，文中定义及式 (2.x)（待核具体式号）
- 类型：proposition
- 原文陈述（忠实转述）：在 N=2 弦论 BPS 态的模空间中，荷向量 γ = γ₁ + γ₂ 的双中心（two-center）BPS 构型在满足边缘稳定性条件
  Im(Z(γ₁) Z*(γ₂)) = 0（即中心荷相位对齐）
  的超曲面（壁，wall of marginal stability）两侧分别稳定/不稳定；穿越此壁时，γ 的 BPS 指标跳变 Δd(γ) = (−1)^{⟨γ₁,γ₂⟩+1} |⟨γ₁,γ₂⟩| d(γ₁) d(γ₂)，其中 ⟨·,·⟩ 为 Dirac-Schwinger-Zwanziger 内积。
- 文献自称的严格程度："we derive" / "we find"；基于超引力多中心解（attractor 方程）的分析和 BPS 壁穿越的经典超引力计算。
- 文献列出的依赖：Denef 2000（单心 attractor 方程）；多中心 BPS 解的存在性（Bates-Denef 2003 等）；BPS 指标的自旋结构（Manschot-Pioline-Sen 等后续）。
- 备注：这是**识别②的超引力侧**（physical-argument）——壁穿越公式是超引力经典计算（严格的 GR 计算），但"超引力 ≈ 弦论低能有效理论"和"经典解 ↔ 量子 BPS 态"的识别是物理论证。与 Sen 2007 共同支撑壁穿越识别。

### E2 熵谜题（entropy enigma）
- 位置：§5，文中讨论
- 类型：proposition
- 原文陈述（忠实转述）：在某些电磁荷 (Q,P) 的情形下，"halo"构型（即一个中心 γ₀ 被一圈 γ₁ 态包围）的 BPS 指标贡献 Δd 在某个 chamber 中可以超过单心黑洞的指标 d_{sc}，甚至在热力学极限下 log Δd > log d_{sc}（halo 态熵超过单心 Bekenstein-Hawking 熵）。文献把这称为"entropy enigma"并分析其在 N=4 情形下是否发生。
- 文献自称的严格程度：对具体模型（N=4 弦论某些荷向量）通过显式计算分析，结论是 N=4 情形中 OSV 形式的熵代入 halo 计数可能给出多于期望的贡献；"enigma"语气暗示这是未完全理解的现象。
- 文献列出的依赖：E1；OSV 猜想（Ooguri-Strominger-Vafa 2004）；N=4 的 DVV 生成函数。
- 备注：这是 OSV 猜想"接近失效"的一个具体讨论案例；在本项目图中应标 physical-argument，且 OSV 猜想本身标 conjecture。

### E3 N=4 壁穿越与 Denef-Moore 公式的适用范围
- 位置：§5–§6（待核）
- 类型：proposition
- 原文陈述（忠实转述）：在 N=4 情形（type II on K3×T² 或杂化 on T⁶）下，壁穿越公式 E1 与 Sen 2007 的 N=4 版本一致；两文共同确立了 N=4 dyon 指标在不同 chamber 中的跳变由半-BPS 指标之积给出，从而为 DVV 的 1/Φ₁₀ 生成函数提供了壁穿越解释。
- 文献自称的严格程度：物理论证，与 Sen 2007 的结果互相印证。
- 文献列出的依赖：Sen 2007；E1；DVV 1997。
- 备注：本条是图节点"识别②"（physical-argument）的第二个来源，与 sen-2007-wall-crossing 共同引用。

## 未解决的疑问

1. E1 中 Δd 的精确系数（特别是 |⟨γ₁,γ₂⟩| 的因子）需对照 Denef-Moore 原文式号核实；本抽取从引言和综述转述。
2. "entropy enigma"在 N=4 情形是否真正发生（即单心 mock 部分的正性是否被 halo 破坏）已由 Bringmann-Murthy 2012 和 Rosselló 2024 从正方向解决，应在图节点中注明后续状态。
3. 本文实际上也分析了 N=2 情形；节点引用时需区分 N=2 和 N=4 适用范围。
