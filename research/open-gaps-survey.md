<!-- 扫描日期：2026-09-15 -->

# 黑洞熵 / 1/4-BPS dyon 子图：空白严格证明候选扫描

本文档由 researcher agent 于 2026-09-15 生成，依据 `graph/statements/holography/` 与
`graph/milestones/bh-entropy-cartography.yaml` 中 status 为 `physical-argument` 的节点，
结合 WebSearch 交叉核验后产出。

---

## 候选 1：DVV 识别①——1/Φ₁₀ 系数等于 1/4-BPS dyon 螺旋超迹

**命题**：在 type II on K3×T²（或等价的 N=4 杂化弦论 on T⁶）中，设 Ω = [[ρ,v],[v,σ]] 为
Siegel 上半空间变量。则对所有满足 Q²/2=m, P²/2=n, Q·P=l 的电荷 (Q,P)，Igusa 尖点形式
Φ₁₀ 的傅里叶展开系数 d(m,n,l)（来自 1/Φ₁₀ = Σ d(m,n,l) e^{2πi(mρ+nσ+lv)}）
等于（在给定 BPS chamber 中）该电荷组合的 1/4-BPS dyon 第六螺旋超迹 −B₆(Q,P)。

**文献现状**：Dijkgraaf-Verlinde-Verlinde 1997（hep-th/9709062）§3 提出此识别，
原文明确使用"we propose"和"conjecture"措辞，通过 4d-5d 提升与 SUSY 非重整化论证支撑，
并以低荷情形与直接 D-brane 计数做数值吻合。Sen 2007、DMZ 2012 在此识别基础上展开，
均未将其改变为严格证明。WebSearch（2026-09-15）确认：目前文献中仍以
"extremely well-supported conjecture"或"physical argument"定性，无第一性原理数学证明。
图节点 `holography.dvv-dyon-index-generating-function` notes 字段亦明确写明
"文献并未从第一性原理给出严格数学证明"。

**技术难点**：SUSY 非重整化定理在全阶（包括非微扰效应）尚无数学证明；4d-5d 提升依赖
type II / M 理论对偶，该对偶本身是 conjecture；将生成函数系数与物理超迹等同需要在
对偶框架内严格追踪算子谱。

**可能路径**：在 N=4 量子力学中严格构造 BPS Hilbert 空间（Vafa-Witten 扭曲理论路线），
对低荷显式验证后寻找模形式 bootstrap 约束（若极点结构 + 模性能唯一确定生成函数）。

**信心**：高——DVV 原文用"conjecture"，WebSearch 未发现任何宣称严格证明的文献，
图节点 notes 有逐字确认。

---

## 候选 2：DMZ 识别③——有限部 φ_F 等于单心（immortal）dyon 贡献

**命题**：在 N=4 弦论（type II on K3×T²）中，对固定判别式 Δ=4mn−l²>0、gcd=1 的电荷
(Q,P)，DVV 生成函数 1/Φ₁₀ 经 DMZ 典范分解后的 mock Jacobi 有限部 φ_F 的傅里叶系数
d_F(m,n,l) 等于在 immortal chamber 中稳定的单心 1/4-BPS dyon 的螺旋超迹；
Appell-Lerch 极部 φ_P 的系数对应多中心（壁穿越易受影响）的贡献。

**文献现状**：Dabholkar-Murthy-Zagier 2012（arXiv:1208.4074）§1–2 与 §6 提出此识别，
原文显式称之为"the finite part conjecture"。数学分解（φ=φ_F+φ_P）本身严格（见图节点
holography.dmz-mock-jacobi-decomposition，rigorous）。但"φ_F 系数 = 单心 dyon 贡献"
依赖 localization 分析与 supergravity BPS 解分类，原文 2012 年版仅对部分情形有理论支撑，
显式用猜想措辞。此后 Sen positivity（Bringmann-Murthy 2012、Rosselló 2024）以正性作旁证，
但旁证不等于正面证明识别本身。图节点 holography.dmz-single-center-identification 的
derivation notes 明确写"全部论证为 physical-argument"。WebSearch（2026-09-15）也确认
DMZ 框架"provides the rigorous proof of the mock modular structure"（指数学分解），
而"finite part = single-center"识别仍靠物理论证支撑，各综述文献均以此定性。

**技术难点**：要严格区分"multi-center bound states"与"single-center"需要在超引力或
弦场论层面对 BPS 解的模空间分类有严格控制；localization 方法（Sen 的 AdS₂ 路径积分）
目前缺少全量子严格框架，特别是非微扰贡献的操控。识别与 mock 模形式的非全纯补全之间
的关系在数学上尚无系统表述（仅有物理启发）。

**可能路径**：在 AdS₂/CFT₁ 框架内对单心极端黑洞做严格定义，再在 localization 可控的
情形（例如充分大判别式 + BPS 完全约简）逐步确认系数等同。

**信心**：高——原文用"conjecture"措辞，图节点明确标 physical-argument，WebSearch 确认
无人发表正面严格证明。与候选 1（DVV 识别①）是相互独立的两步识别，均缺证明。

---

## 候选 3：CHL 弦中 1/4-BPS dyon 生成函数的识别（DVV 框架的轨形推广）

**命题**：在 N=4 弦论的 CHL 轨形（type IIA on K3×T²/ℤ_N，N=2,3,5,7）中，
设 Φ̃_k(Ω) 为对应的 Siegel 权 k 尖点形式（paramodular 形式，k=(24/(N+1))−2），
则对固定 BPS chamber，其 Fourier 展开系数等于相应轨形理论的 1/4-BPS dyon
螺旋超迹；进一步，DMZ 型分解给出有限部等于单心 dyon 贡献（无挠 I=1 情形）。

**文献现状**：Jatkar-Sen 2006（hep-th/0510147）和 David-Jatkar-Sen 2006/2007
提出 CHL 轨形生成函数猜想；Banerjee-Sen-Srivastava（BSS）将 DMZ 框架推广到 CHL 模型；
2025 年 arXiv:2505.17182（"Mock modularity of twisted index in CHL models"，
已发表 JHEP 2025）进一步表明含挠扭曲指标由 mock Jacobi 形式的系数给出。
但 WebSearch（2026-09-15）确认："A fully rigorous, self-contained proof of
wall-crossing in the most general CHL setting does not appear in these results —
the state of the art seems to be strong consistency checks and structural
correspondences rather than a single comprehensive proof." 识别"paramodular
形式系数 = BPS 超迹"同样依赖物理论证（4d-5d 提升 + 轨形 CFT 分析），
并未见纯数学严格证明。

**技术难点**：paramodular 群（不同于 Sp(4,ℤ)）的模形式理论相对不成熟，
对应 Borcherds 升举公式在轨形情形有额外技术条件；CHL 模型中 K3 的扭曲椭圆亏格
（twisted elliptic genus）与轨形 BPS 计数的等同是核心识别，依赖月光类对称性与
对偶论证；模空间壁穿越在轨形情形有更复杂的分裂结构（含 twisted/untwisted 混合态）。

**可能路径**：在 N=2 CHL 情形（N=2，最简单的轨形）集中验证，利用 twisted elliptic genus
的已知严格计算（Eguchi-Hikami 型）锚定生成函数；再尝试 DMZ 型分解是否在 paramodular
情形给出类似严格分解定理。

**信心**：中——识别本身文献中未见严格证明，且 2025 年最新进展仍将 mock 模形式结构作为
"发现"而非已知结果的推论，说明理解仍不完整。但相比候选 1/2 而言，文献版图更分散，
不排除某些特殊情形（如 N=2 某些 chamber）有局部严格处理存在、只是未被本次搜索覆盖，
故信心评为中而非高。

---

## 扫描小结

| 候选 | 对应图节点 | 当前 status | 是否有 research/ 尝试 |
|---|---|---|---|
| 1. DVV 识别① | holography.dvv-dyon-index-generating-function | physical-argument | 否 |
| 2. DMZ 识别③ | holography.dmz-single-center-identification | physical-argument | 否 |
| 3. CHL DVV 推广 | 图内暂无该节点 | — | 否 |

已有 research/ 尝试：
- `torsion-immortal-positivity-hecke`：挠 I>1 免死指标正性——**不在本次候选范围内**（已有在进尝试）。
- `d10-anomaly-full-classification`：D=10 异常自由分类——与黑洞熵子图无关。

意外发现（扫描过程中）：
- 图节点 `holography.immortal-dyon-index-positive` 在 task #20（2026-09-14）之前曾错误标为 rigorous
  （因只挂 DMZ 数学分解推导而漏掉识别③的 physical-argument 依赖），已订正。该历史说明识别①③两步
  很容易被吸收进"纯数学"叙事而掩盖 physical-argument 地位——恰恰是候选 1/2 的证明缺口长期被低估的原因。
- arXiv:2505.17182（2025）提示 CHL 挠扭曲情形的 mock 结构比预期更精细，可能蕴含新的未证命题，
  但本次搜索深度不足以确认，标记为后续跟进。
