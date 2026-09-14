# 抽取记录：strominger-vafa-1996

- 文献：A. Strominger, C. Vafa, "Microscopic Origin of the Bekenstein-Hawking Entropy," Phys. Lett. B 379 (1996) 99–104, arXiv:hep-th/9601029
- 抽取者：lead (direct, 2026-09-14)
- 日期：2026-09-14
- 覆盖范围：全文（4页），重点 §2–§4

## 约定

- 五维黑洞（type IIA on K3×T²），无量纲化单位使 G₅=1。
- 弦耦合 g_s 小：D-brane 描述有效。
- BPS 极端黑洞：质量 = 中心荷。
- 本文未明确写出 α' 归一化；D-brane 张力公式用标准 Polchinski 约定（τ_p ∝ 1/(g_s α'^{(p+1)/2})）。

## 陈述

### E1 D1-D5 微观态计数与 Bekenstein-Hawking 熵匹配
- 位置：pp. 1–4，式 (1)–(8) 及结语
- 类型：proposition
- 原文陈述（忠实转述）：考虑 type IIA 弦论紧化到 K3×S¹，取 Q₁ 根 D1-brane 绕 S¹ 缠绕、Q₅ 根 D5-brane 绕 K3×S¹ 缠绕、动量量子数 n 沿 S¹ 的五维极端 BPS 黑洞，其 Bekenstein-Hawking 面积熵为
  S_BH = 2π √(Q₁ Q₅ n)。
  D-brane 系统的微观态数（由 Q₁Q₅ 弦的零模 CFT 计算，用 Cardy 公式）给出
  S_micro = 2π √(Q₁ Q₅ n)，
  两者精确相等。
- 文献自称的严格程度："we obtain exact agreement"；依赖 BPS 非重整化论证（指标计数不受耦合修正）以及 4d-5d 提升的 D-brane 有效场论。
- 文献列出的依赖：
  - Bekenstein-Hawking 面积公式（S=A/4G）；
  - D-brane 有效场论与 BPS 指标的 SUSY 非重整化（Sen, Vafa 1995–1996）；
  - 4d-5d 提升几何（Callan-Maldacena 1996, 同期）；
  - Cardy 公式（椭圆亏格 / CFT₂ 的渐近态密度）。
- 备注：这是弦论"成功计算黑洞熵"的原始文献。严格程度属于 physical-argument：指标保护依赖 SUSY 非重整化（物理论证，不是纯数学定理）；Cardy 公式本身是严格的但应用到这一 D-brane CFT 的 central charge 计算依赖 D1-D5 系统的有效描述（= 物理识别）。两者合在一起定级为 physical-argument。

### E2 D1-D5 系统的有效中心荷
- 位置：p. 3，文中
- 类型：proposition
- 原文陈述（忠实转述）：Q₁Q₅ 根开弦（D1-D5 字符串）的低能有效理论是一个 (4,4) SCFT，其中心荷 c = 6 Q₁ Q₅，从而 Cardy 公式给出态密度 ρ(n) ∼ exp(2π√(Q₁Q₅ n/6 · c/6)) = exp(2π√(Q₁Q₅n))。
- 文献自称的严格程度："it can be shown"，引用 D-brane 模空间分析。
- 文献列出的依赖：D1-D5 有效场论（Callan-Maldacena 1996）；开弦计数。
- 备注：中心荷 c=6Q₁Q₅ 是 physical-argument（依赖 D1-D5 有效 CFT 识别）。

## 未解决的疑问

1. 原文用 type IIA on K3×T² 还是 K3×S¹？标题给的是五维黑洞，实际模型是 IIA on K3×S¹（T² = K3×S¹ 的一个 S¹ 方向），需在节点描述中写清楚具体几何。
2. Q₁, Q₅, n 是整数电荷还是连续参数？原文要求它们为正整数（D-brane charge）。节点应声明此约束。
3. 文献没有写出 G₅ 的明确表达式（它依赖 K3 体积等参数）；匹配是在极端限制下参数相消后成立的。节点应声明这一点。
