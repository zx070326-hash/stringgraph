# 文献前沿测绘：N=4 免死 dyon 指标正性（Sen positivity）周边"已证 vs 未证"边界

- 角色：researcher（只写 `literature/`）
- 日期：2026-09-15
- 任务：把 N=4 黑洞 dyon 指标正性（Sen positivity）周边"已证 vs 未证"的边界钉死，为 lead 判断"哪条缝真 open、值得开原创证明轨道"提供事实依据。
- 方法：WebSearch/WebFetch 查 arXiv/公开出版物。只登记公开可获取文献。不做"我觉得它依赖 X"的推断。

## 旗舰锚点（背景，已知）

- **Rosselló 2024** — arXiv:2403.19630, "The Immortal Dyon Index Is Positive", Martí Rosselló (Institute of Mathematics, Academia Sinica, Taipei).
  - 完全关闭 N=4 旗舰（type II on K3×T²，单位挠 I=1）的免死（immortal/单心）dyon 指标正性。
  - Thm 1（代表元范围 (−1)^{ℓ+1} c_m^F(n,ℓ)>0）+ Cor 1.1（GL(2,ℤ) 推全域 d_*(m,n,ℓ)>0，∀ m,n≥1, Δ=4mn−ℓ²>0, gcd=1）。
  - 方法：S-对偶约化 + Rademacher 展开 + Kloosterman/Bessel 显式定界。纯数学，无物理前提。
  - 上游：DMZ 2012（1/Φ₁₀ 的 mock Jacobi 典范分解，rigorous）、Bringmann-Murthy 2012、Zwegers 2002。

（以下三节为逐条测绘结论。）

---

## 缝 A：挠 I = gcd(m,n,ℓ) > 1 的免死指标正性——纯数学证明有没有？

### 裁定：**仅物理论证、纯数学 open**（作为"免死/单心指标正性"定理）。
存在一条显式的、Hecke 型的除子求和公式把 I>1 的**总简并度**约化到 I=1，且权重全为正（若各 I=1 项正，则和为正）；但该公式的推导是**物理的**（对偶 + 4d-5d 提升 + 费米零模计数），不是只依赖 Φ₁₀ 模性质的数学定理。Rosselló 本人只证 I=1，明确把 I>1 用 [52,53,54] 物理归约掉。此外，公式给的是总简并度 Ω_I，把它精确限制到"免死/单心"部分并保证正性，仍需额外的物理输入（见下"两点未闭合"）。

### 支撑证据

1. **Rosselló 2024（arXiv:2403.19630）显式限制在 I=1，并物理归约 I>1。** 忠实转述其正文（HTML 全文抽取）：
   - 定义 `I = gcd{Q_i P_j − Q_j P_i, 1≤i,j≤28}`。
   - "A state with unit torsion, I=1, is completely specified by the charge bilinears." 定理与推论只对 I=1 证明。
   - "From now on we focus on this class of states, since the degeneracies of dyons with torsion greater than one are related to the degeneracies of unit torsion dyons [52, 53, 54]." —— 即 I>1 不独立证明，靠所引文献归约。
   - 定理 1（逐字）：`Let m>0, n≥m and 0≤ℓ≤m, then (−1)^{ℓ+1} c_m^F(n,ℓ) > 0.`
   - 推论 1.1（逐字）：`Let m,n,ℓ∈ℤ with m,n≥1 and Δ=4mn−ℓ²>0. Then, d_*(m,n,ℓ) > 0.`（经 S-对偶不变性从定理 1 推全域）。
   - 引用 [52,53,54] 对应即任务背景所列 Banerjee-Sen 0801.0149 / Banerjee-Sen-Srivastava 0802.1556 / Dabholkar-Gomes-Murthy 0803.2692（Rosselló 抽取到的引文位置未逐一印证编号，但内容一致）。

2. **除子求和公式的确切形式（DGM 0803.2692，ar5iv 全文抽取）。** 
   - 简并度层面 eq (52)：
     `Ω_I(Q²/2, P²/2, Q·P) = Σ_{s|I} s · Ω_1(Q²/(2s²), P²/2, Q·P/s)`
   - 配分函数层面 eq (51)：
     `Z_I(ρ,σ,v) = Σ_{s|I} s · 1/Φ_{10}(s²ρ, σ, sv)`
   - 结构：对 I 的除子 s 求和，算术权重为 s（**恒正**），作用在单位挠对象 1/Φ_{10} 上，Hecke 型（重标 ρ,v 的化学势，σ 不动）。
   - **关键：权重 s>0。** 因此若每个 Ω_1(…) 项都正（Rosselló），则 Ω_I 是正项之和 → 正。**但这只在"公式成立"的前提下成立，公式本身是物理导出的。**

3. **该约化公式的推导是物理的，不是纯模形式定理（DGM 0803.2692，ar5iv 全文抽取）。** 作者自述用 "a combination of arguments from duality, 4d-5d lift, and a careful analysis of fermionic zero modes."
   - 对偶：KK-monopole 系统映到 heterotic 基本弦（F1-P）；用 S/T-对偶与弦-弦对偶换帧。
   - 4d-5d 提升：多 KK-monopole → 多心 Taub-NUT；近核极限把 4d dyon 关联到 ALE（ℂ²/ℤ_I）背景的 5d 黑洞。
   - 费米零模：除子求和的"局域化"来自——多粒子态一般带过多费米零模、不贡献指标 ℰ_2；只有 s 个全同弦（s|I）的对称化组态约化到所需的两个复零模。含过多零模的态 "will not contribute to the index under consideration."
   - 单心/零角动量假设：所算指标是 helicity supertrace B_6；多心黑洞因额外零模 "will not contribute to the index B_6."
   - 附录 A.1（eq 81）关于对称积 ℰ_2 的模形式恒等式提供形式结构，但"该对称化哪个 SCFT（Sym^I(X^{4d})/ℤ_I）"这一步需上述全部物理输入。与 Banerjee-Sen-Srivastava 宏观提议、Stern-Yi 场论 dyon 计数的一致只是**验证**，不是独立推导。

4. **Banerjee-Sen-Srivastava 0802.1556（"Partition Functions of Torsion >1 Dyons…"）** 给出同一除子求和结构（宏观/S-对偶轨道侧），据 DGM 与检索摘要，推导同样是物理论证（对偶轨道 + Siegel 模形式性质），非严格数学定理。（注：0802.1556 的 PDF 为压缩流，未能逐字抽取正文；此条依 DGM 正文对其结论的转述与检索摘要，标 `二手转述`，需读原文正文确认逐字公式。）

### 两点尚未闭合（原创轨道的真实缝）
- **(i) 总简并度 vs 免死/单心指标。** DGM eq (52) 是**总**简并度 Ω_I 的约化；Rosselló 的正性针对**免死（mock 模形式典范分解出的单心）**部分 d_*。把除子求和精确投影到免死部分、并逐项落在 Rosselló 定理 1 的代表元范围（m>0, n≥m, 0≤ℓ≤m），需要一个"免死部分也满足同一 Hecke 型除子公式"的陈述——这一步在公开文献里目前只见物理论证，未见纯数学证明。
- **(ii) 归约公式本身的纯数学地位。** eq (51)/(52) 若被当作**关于 Φ_{10} 的模形式/Hecke 恒等式**独立证明（不借费米零模、4d-5d 等物理输入），则 I>1 免死正性可立即由"正权除子和 + Rosselló I=1"闭合。**查无这样的纯数学证明。** 这正是可开原创轨道的候选点：证明"Z_I(ρ,σ,v)=Σ_{s|I} s/Φ_{10}(s²ρ,σ,sv) 的免死部分的 Fourier 系数带符号 (−1)^{ℓ+1} 后为正"，或先纯数学地确立 eq(51) 的免死投影版本。

### 原创轨道现成可用的最接近结果
- Rosselló I=1 定理 1 + 推论 1.1（纯数学，无物理前提）——作为"底座"。
- DGM eq (52) 的**正权除子和结构**——若能纯数学地重证其免死投影版本，正性即为推论。缺口在"物理导出 → 纯数学定理"这一升级。

---

## 缝 B：mock 系数符号 (−1)^{ℓ+1} c_m^F>0 有没有"结构性/代数性"理解（而非解析估计）？

### 裁定：**查无**（就"免死/mock 系数符号正性的代数原因"而言）。
存在一整套把 1/Φ₁₀ 与 **Borcherds-Kac-Moody（BKM）超代数**联系起来的成熟代数框架（Gritsenko-Nikulin + Cheng-Verlinde 等），但该框架解释的是 **wall-crossing**（Weyl 群 = 边际稳定壁）与**全简并度**（根重数），**不是**免死（mock 模形式典范分解出的单心）部分的符号正性。Rosselló 本人明确未给符号任何代数/表示论来源，其证明是硬分析（Rademacher + 极点/polar 系数主导）。把"免死系数符号"直接归因于 BKM 根重数/Weyl 群结构——公开文献里查无。

### 支撑证据

1. **确有 BKM 代数框架，但对象是全简并度 + wall-crossing。**
   - **Gritsenko-Nikulin**（alg-geom/9504006, 9603010, 9610022, 9611028）：Φ₁₀ 有无穷乘积表示，与一个 rank-3 BKM 超代数 g_{1,II} 的 Weyl-Kac-Borcherds 分母公式相关；Φ₁₀ = Δ₅²，Δ₅ 为带特征标的 Sp(2,ℤ) 分母形式；dyon 简并度 ↔ 该 BKM 的**根重数**（由权 0 指标 1 Jacobi 形式的 Fourier 系数决定）。
   - **Cheng-Verlinde**（"Wall Crossing, Discrete Attractor Flow and Borcherds Algebra", SIGMA 4 (2008) 068）：根格 = dyon 电荷 T-对偶不变量格；根系对称群 = 扩展 S-对偶群 PGL(2,ℤ)；**Weyl 腔壁 = 边际稳定壁**；Weyl 群 = wall-crossing 群 / 离散 attractor flow 群。
   - **Cheng-Dabholkar** 0809.4258（"Borcherds-Kac-Moody Symmetry of N=4 Dyons"）、**Govindarajan-Krishna** 0807.4451（"Generalized Kac-Moody Algebras from CHL dyons"）、"BKM Lie superalgebras from counting twisted CHL dyons"（0907.1410, 1905.06083）：把该对应推广到 CHL；平方根 Δ_{k/2} 是 dd-modular forms（Cléry-Gritsenko 分类），各为一个 rank-3 BKM 超代数的分母公式；Weyl 腔壁 ↔ CHL 边际稳定壁。CHL 侧的代数多为**猜想**（"Lie algebra connection is not yet known"）。

2. **该框架编码的符号是"根的 even/odd（玻色/费米）分级"，作用于全 Fourier 系数（含 wall-crossing），不是免死部分。** 在 CHL 推广里根重数系数 C_{d,r} 可正可负（bosonic/fermionic 根），符号由 d+r 奇偶决定。这是**全简并度/Siegel 形式系数**层面的符号结构，与"免死 mock 部分 (−1)^{ℓ+1} c_m^F>0"不是同一命题——免死部分恰是**去掉 polar（Weyl 轨道/wall-crossing）后**的 mock 残余。

3. **Rosselló 2024 明确不走代数路线。** HTML 全文抽取确认：全文**只字未提** BKM / 分母公式 / 根重数 / Weyl 群作为符号来源；符号 (−1)^{ℓ+1} 仅来自 helicity supertrace 与 Witten 指标的关系（B_6 = −d(m,n,ℓ)）+ 定义 d_*=(−1)^{ℓ+1}c_m^F。证明机制是 Rademacher 展开中"最 polar 态"项恒正且远大于其余项之和（解析估计），**无**表示论解释。

4. **原始猜想本身把问题摆成"黑洞预言 Siegel 形式系数符号"**（Sen 1008.4209, "How Do Black Holes Predict the Sign of the Fourier Coefficients of Siegel Modular Forms?"）——即"为什么符号是这个"在物理侧靠视界球对称（单心态零角动量→玻色），数学侧至今是解析结论而非代数结构定理。

### 若开原创轨道：现成可用/最接近的结果
- **候选研究方向本身就是这条缝**：把 BKM 的 even/odd 根分级（已知控制全简并度符号）与免死 mock 部分的符号正性建立精确对应，即"用 BKM 表示论重证 (−1)^{ℓ+1}c_m^F>0"。目前**无人做到**；这会是真正新的数学（把 Rosselló 的解析定理提升为代数/表示论定理）。
- 现成砖：Gritsenko-Nikulin 根重数公式 + Cheng-Verlinde 的 Weyl群=wall-crossing 字典 + DMZ mock 分解 + Rosselló 解析正性。缺的是把"免死=去 polar 残余"与"根重数符号分级"缝起来的那一步。

---

## 缝 C：CHL orbifold 的免死指标正性判据

### 裁定：**纯数学 open / 无完整判据**；且需先厘清一个模型混淆——已知的**正性违反发生在"环面 orbifold"（type II on T⁶ 的 Z_N），不是标准 CHL**。真正 CHL 的免死正性目前既无反例、也无完整证明或判据，是**候选原创点**。

### 关键事实澄清（供 lead 修正任务背景）
- 任务背景把"低电荷 CHL 出现违反正性的负号"系到 arXiv:2311.16252。**核对：2311.16252 是 Bhand-Sen-Singh "Mock Modularity in CHL Models"，讲的是 mock 模性推广，并未报告正性违反。** 真正报告负号违反的是 **Chattopadhyaya-David** 的 1810.12060 与 2010.08967，而且其模型是 **type II 在 T⁶ 上的 Z_2、Z_3 环面 orbifold**（N=8→N=4），**不是降秩 CHL**。两类 orbifold 必须分开。

### 支撑证据

1. **环面 orbifold（非 CHL）中免死正性确被违反**——已确证的"反例区"。
   - **Chattopadhyaya-David 1810.12060**（"Properties of dyons in N=4 theories at small charges"）：研究 type II on T⁶ 的 Z_2、Z_3 orbifold dyon 配分函数的 Fourier 系数符号；用"减去 Fourier-Jacobi 分解的 polar 部分"判据挑单心 dyon；**证明 Z_2 orbifold 中存在一个无穷类单心 dyon（磁荷 P²=2）违反正性猜想**。物理解读：这些 dyon 可能带 hair 模，贡献 1/4-BPS 指标符号。
   - **Chattopadhyaya-David 2010.08967**（"Horizon states and the sign of their index in N=4 dyons"）：后续，给出 Z_2 环面 orbifold 单心 dyon 指标的显式负值表。
   - 含义：Sen 正性在这些环面 orbifold 中**已知为假**（有明确负号），因此"哪些构型免死为正"在此类里是真问题。

2. **真正 CHL（降秩 Z_N，保 N=4）里，免死正性只有部分/启发式结果，无完整判据、无反例。**
   - **"Sign of BPS index for N=4 dyons"（2303.03913）**：研究 K3×T² 被 [M_23] 中 order-N 元素 + 1/N 平移生成的 CHL orbifold，固定 P²=2；把逆 Siegel 形式展成 mock Jacobi + Appell-Lerch。结论：**正性由基本弦主导项保证**（"the fundamental string … ensures the positivity"），但去掉主导项后残余 mock 系数**平均出现符号变化**。**未给完整判据，无严格定理**——混合解析估计 + 数值。
   - **Bhand-Sen-Singh 2311.16252（"Mock Modularity in CHL Models"）**：严格把 DMZ 典范分解推广到 SL(2,ℤ) 同余子群的有理指标 meromorphic Jacobi 形式（数学定理）；由此"一大类 CHL 单心简并度 = mock Jacobi 系数"。但**同时给出反例：存在电荷（甚至在原 DMZ/Z_1 情形）其单心简并度并非预期指标 mock 形式所刻画**。**未直接处理正性**。→ 连"免死=mock 系数"这一步在 CHL（乃至 Z_1）都不是对所有电荷成立，正性判据的地基本身有洞。
   - **"Generating Function of single-centered Black Hole Index in CHL Models"（2606.19479）**：构造一般 Z_N CHL 单心黑洞指标生成函数（减去用"bound state metamorphosis"造的双心部分），**证明 N=2,3 收敛**。**完全未涉及正性**——只做构造与收敛。
   - **Cardoso-Nampuri-Rosselló 2112.10023**（"Rademacher Expansion of a Siegel Modular Form for N=4 Counting", Ann. Henri Poincaré）：把 1/Φ₁₀ 的 BPS 简并度做细粒度 Rademacher 展开（两个 SL(2,ℤ)⊂Sp(2,ℤ) 子群、Kloosterman 和、Eichler 积分、polar 数据由 1/η²⁴ 经连分数造出）。这是 Rosselló I=1 正性证明的**解析引擎**，但本文只做 heterotic/T⁶（I=1），未推 CHL 正性。
   - **Bossard-Cosnier-Horeau-Pioline**（1608.01660, 1806.03330）：CHL dyon 指标作为 D=3 半极大规范耦合的 genus-two 模积分系数；给出 CHL dyon 指标的 U-对偶不变精确表述，但目标是有效作用/精确耦合，**非正性判据**。

3. **判据现状小结。** CHL 免死正性：(a) 无完整"哪些电荷为正"的判据；(b) 无严格正性定理；(c) 目前也无确证的 CHL 反例（反例都在环面 orbifold）。P²=2 有启发式（基本弦主导）+ 数值证据倾向正，但残余项符号不定，且"免死=mock 系数"在部分电荷失效。→ **纯数学 open，构型甄别是候选原创点。**

### 若开原创轨道：现成可用/最接近的结果
- **数学地基**：Bhand-Sen-Singh 2311.16252 的同余子群版 DMZ 分解（严格）+ 其"哪些电荷被 mock 形式刻画"的精确化（含反例边界）——这是判据必须尊重的边界条件。
- **解析引擎**：Cardoso-Nampuri-Rosselló 2112.10023 的细粒度 Rademacher 展开，原则上可移植到 CHL 的 Δ_k（Rosselló I=1 正是这么用的）。
- **构造与收敛**：2606.19479 已把 Z_N CHL 单心指标显式造出并证 N=2,3 收敛——正性分析可直接接在其生成函数上。
- **真实缝**：把 Rosselló 的"最 polar 项主导 ⇒ 正"论证移植到 CHL 的低权 Δ_k，判定它在哪些电荷区成立（基本弦主导区）、哪些区可能失效；并把 2311.16252 的"非 mock 电荷"排除在外。据现有文献，这块**无人系统做过**，且需先确认真正 CHL 是否也有像环面 orbifold 那样的负号（目前查无 CHL 确证反例）。

---

## 三条缝一句话裁定汇总

- **缝 A（挠 I>1 免死正性）**：仅物理论证、纯数学 open——有正权除子和公式 Ω_I=Σ_{s|I} s·Ω_1（DGM 0803.2692 eq 52）可把 I>1 约化到 Rosselló 的 I=1，但该公式是物理导出（对偶+4d-5d+费米零模），且给的是总简并度而非免死部分；纯数学升级 + 免死投影版本查无。
- **缝 B（mock 符号的代数原因）**：查无——BKM 超代数框架（Gritsenko-Nikulin/Cheng-Verlinde）解释的是 wall-crossing（Weyl群=边际稳定壁）与全简并度根重数，不是免死 mock 系数符号正性；Rosselló 的正性纯解析，无表示论解释。
- **缝 C（CHL 免死正性判据）**：纯数学 open、无完整判据——已知正性违反在**环面 orbifold**（Chattopadhyaya-David 1810.12060/2010.08967）而非标准 CHL；真正 CHL 只有 P²=2 的启发式+数值（2303.03913）、严格 mock 分解但含"非 mock 电荷"反例（2311.16252）、单心生成函数构造+收敛（2606.19479），无正性定理、无确证 CHL 反例——是候选原创点。

## 本次登记的相关文献（供 curator/lead 补 sources.bib）

- Sen, arXiv:1008.4209, "How Do Black Holes Predict the Sign of the Fourier Coefficients of Siegel Modular Forms?"（原始猜想）
- Rosselló, arXiv:2403.19630, "The Immortal Dyon Index Is Positive"（I=1 旗舰关闭）
- Dabholkar-Gomes-Murthy, arXiv:0803.2692, "Counting all dyons in N=4 string theory"（挠 I>1 除子求和，物理导出）
- Banerjee-Sen-Srivastava, arXiv:0802.1556, "Partition Functions of Torsion >1 Dyons…"（挠 I>1 配分函数）
- Banerjee-Sen, arXiv:0801.0149（挠不变量 U-对偶，Rosselló [52] 候选）
- Bringmann-Murthy, arXiv:1208.3476, "On the positivity of black hole degeneracies…"（m=1,2 正性，纯数学）
- Dabholkar-Murthy-Zagier, arXiv:1208.4074, "Quantum Black Holes, Wall Crossing, and Mock Modular Forms"（DMZ 典范分解）
- Gritsenko-Nikulin, alg-geom/9504006 / 9603010 / 9610022 / 9611028（BKM 超代数 / Φ₁₀=Δ₅²）
- Cheng-Verlinde, SIGMA 4 (2008) 068, "Wall Crossing, Discrete Attractor Flow and Borcherds Algebra"
- Cheng-Dabholkar, arXiv:0809.4258, "Borcherds-Kac-Moody Symmetry of N=4 Dyons"
- Govindarajan-Krishna, arXiv:0807.4451, "Generalized Kac-Moody Algebras from CHL dyons"
- Chattopadhyaya-David, arXiv:1810.12060, "Properties of dyons in N=4 theories at small charges"（环面 orbifold 正性违反）
- Chattopadhyaya-David, arXiv:2010.08967, "Horizon states and the sign of their index in N=4 dyons"（负号显式表）
- (Chattopadhyaya), arXiv:2303.03913, "Sign of BPS index for N=4 dyons"（CHL P²=2 启发式+数值）
- Bhand-Sen-Singh, arXiv:2311.16252, "Mock Modularity in CHL Models"（同余子群 DMZ 推广 + 非 mock 电荷反例）
- arXiv:2606.19479, "Generating Function of single-centered Black Hole Index in CHL Models"（Z_N CHL 单心生成函数 + N=2,3 收敛）
- Cardoso-Nampuri-Rosselló, arXiv:2112.10023, "Rademacher Expansion of a Siegel Modular Form for N=4 Counting"（Rosselló 证明的解析引擎）
- Bossard-Cosnier-Horeau-Pioline, arXiv:1608.01660 / 1806.03330（CHL dyon 指标的 U-对偶不变精确表述）
- Zwegers, 2002 thesis, "Mock Theta Functions"（mock 模形式基础）

（注：以上仅为本次前沿测绘所触及文献的登记建议，bib key 与逐条抽取由 curator 按 literature/CLAUDE.md 规范落地；本 researcher 只写本文件，不改 sources.bib、不写 graph/。）
