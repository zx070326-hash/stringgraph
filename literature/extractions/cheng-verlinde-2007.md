# 抽取记录：cheng-verlinde-2007

- **文献**：`cheng-verlinde-2007` = Miranda C. N. Cheng and Erik Verlinde, "Dying Dyons Don't Count", JHEP 09 (2007) 070, arXiv:0706.2363.
- **抽取者**：researcher
- **日期**：2026-09-18
- **覆盖范围**：全文（Introduction, 主体, Conclusion），通过关键词定向检索。
- **证据等级**：**L1** — ar5iv HTML 版 `https://ar5iv.labs.arxiv.org/html/0706.2363` 全文可读，通过 WebFetch 获取。

## 订正说明（重要）

原查重任务指令给出的 arXiv 号为 "0806.2337"，**该号不存在对应文献**；本文正确 arXiv 号是 **0706.2363**（2007 年提交，非 2008）。已核实标题、作者、期刊出处一致（"Dying Dyons Don't Count"，Cheng–Verlinde，JHEP 09 (2007) 070），可以确认是任务所指的同一篇文献，只是号码笔误。

## 约定

- Ω = Siegel 上半空间坐标（本文用 ρ, σ, ν，不用 z）
- Φ(Ω) = 逆配分函数的分母（即 Φ₁₀）

## 陈述

### E1 — 否定证据：三个核查点均未出现（全文定向检索）

- **位置**：全文。
- **类型**：negative evidence（定向 WebFetch 检索确认）。
- **检索结果（逐条）**：
  1. **挠不变量 I 标记 BKM 代数自同构**：全文未讨论"torsion invariant"，也未提及自同构标记；文中出现的标签是 $Sp(2,\mathbb{Z})$ 元素、$SL(2,\mathbb{Z})$ 元素 γ（含整数 a,b,c,d）、以及三元组 (k,ℓ,m,r,s)（满足某长度条件），均与本项目假说的挠 I 概念**不同轴**。
  2. **除子和公式称为"twisted denominator formula"**：全文给出乘积公式
     > "1/Φ(Ω) = 1/[e^{2πi(ρ+σ+ν)} ∏_{(k,ℓ,m)>0} (1−e^{2πi(kρ+ℓσ+mν)})^{c(4kℓ−m²)}]"
     
     但只在"最低振子多重性"与"是否是模像求和"的语境下讨论（引 refs [20–22,14]），**全文不出现"twisted denominator formula"字样**。
  3. **半整平移 z→dz+(d−1)/2**：全文不讨论任何椭圆变量半整平移；本文用变量 ρ,σ,ν（非 z），亦无 d 依赖的平移公式（文中 "d" 仅作为 $SL(2,\mathbb{Z})$ 矩阵元出现，如 "ad−bc=1"）。

### E2 — 论文实际主题（Conclusion，逐字/转述）

- **位置**：Conclusion。
- **类型**：作者自述未解决问题。
- **原文陈述（逐字）**：
  > "It would be nice to understand better the role of other splittings of charges in the BPS spectrum."
  >
  > "We hope to put these puzzles together and return to these issues in the future."

- **备注**：本文的核心主题是**围墙穿越（wall-crossing）与 1/Φ₁₀ 极点结构的等高线处方**（moduli-dependent contour prescription），确保配分函数 duality-invariant 并正确反映二中心束缚态的出现/消失。这与本项目假说的"挠→自同构"问题**属于不同的技术问题**，作者自己把"其他电荷分裂方式的角色"列为未来工作，但**未具体点名挠自同构或扭转分母**。

## 对 GAP-BKM 的影响（⟨judgment⟩）

**未被抢先**。本文虽然标题看似与 N=4 dyon 计数密切相关，但实际处理的是**围墙穿越与等高线选取**问题（挠 I=1 情形下的模糊性），不涉及 I>1 的挠标签或代数自同构结构。三条核查点定向检索均为阴性，是 GAP-BKM C 档判定的支持证据之一。

## 未解决的疑问

1. 本文的"其他电荷分裂方式"（"other splittings of charges"）展望是否在后续 Cheng 系列论文中被具体化为挠 I>1 的讨论？未做引用链追踪。
