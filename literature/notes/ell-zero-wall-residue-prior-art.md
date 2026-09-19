# 文献先行工作核查：ℓ=0 壁跨越留数机制

- **核查对象**：`research/attempts/ell-zero-wall-degeneracy/proof.md`
- **核查者**：researcher agent（任务 gap42-prior-art）
- **日期**：2026-09-20
- **覆盖范围**：本项目已有抽取记录（7 篇核心 N=4 dyon 计数文献，2007-2024）+ 针对性 web 搜索（技术关键词组合）
- **证据等级**：本报告所有引文取自本项目 `literature/extractions/` 已有记录（已由其他 researcher 逐字核对原文）或标注「未取得原文」

---

## 核心问题

按任务书要求，逐条回答：

### Q1（最关键）："壁跨越跳变 ∝ ⟨Γ₁,Γ₂⟩" 的推导路径是否已有先行工作

**待核查机制**：从 Φ₁₀ 的 v-偶性 + 二阶零点，通过留数计算直接导出 `Res_{v=1/2}[𝒢·e^{−2πiℓv}] ∝ ℓ`，进而得出 ℓ=0 时留数为零。

**检索结果**：

**结论层已知**：
- **Denef–Moore 2007** (arXiv:hep-th/0702146)：壁跨越公式 `Δd ∝ |⟨γ₁,γ₂⟩|`，标准结果。
  来源：`literature/extractions/denef-moore-2007.md` E1。
- ⟨Γ₁,Γ₂⟩=0 ⟹ Δd=0 是该公式的直接推论（内积为零则跳变为零）。
- **该层无新结果，不得作优先权主张。**

**推导路径在检索范围内未找到**：
- **Sen 2008** (arXiv:0708.1270, Appendix C)：
  - 给出 Φ₁₀ 在 v=0 有二阶零点（eq C.25-C.26，逐字：`Φ̂(ρ,σ,v) = −4π² v² g(ρ)g(σ) + O(v⁴)`）。
  - 来源：`literature/extractions/sen-2008-precision-counting.md` S6。
  - **未给出**留数因子化公式或 `Res ∝ ℓ` 的显式陈述。
  - 壁跨越定性描述为"change proportional to half-BPS degeneracies"（摘要 + §1），未给精确留数公式。
  - 来源：`literature/extractions/sen-2007-wall-crossing.md` E4-E5。

- **Cheng–Verlinde 2007** (arXiv:0706.2363)：
  - 主题为围道选取与多中心束缚态的壁跨越。
  - 来源：`literature/extractions/cheng-verlinde-2007.md` E2。
  - **未讨论** ℓ=0 情形或留数消失机制。

- **Dabholkar–Gomes–Murthy 2008** (arXiv:0803.2692, eq 3.26-3.28)：
  - 给出围道积分定义式，未展开留数分析。
  - 来源：`literature/extractions/dabholkar-gomes-murthy-2008.md` S1-S3。

- **Web 搜索**（2026-09-20，关键词："Siegel modular form wall crossing Q dot P equals zero vanishing residue" 等三组）：
  - 返回标准壁跨越文献（Sen 2007, Cheng–Verlinde, 几何壁跨越群），无命中 v-偶性 → 留数 ∝ ℓ 的推导。

**裁定 Q1**：在本次检索覆盖范围内，**未找到**从 Siegel 模形式解析结构（v-偶性 + 二阶零点）直接推导壁跨越线性依赖的文献。已知结果是通过 Denef–Moore 的多中心 BPS 分析得到，推导路径不同。

---

### Q2：Q·P=0 情形在文献中的处理

**检索结果**：

- **Denef–Moore 2007**：壁跨越公式 `Δd ∝ |⟨γ₁,γ₂⟩|` 自动包含 ⟨γ₁,γ₂⟩=0 的情形（跳变为零），但未单独讨论该情形的物理意义或称其为"透明壁"。
  来源：`literature/extractions/denef-moore-2007.md` E1。

- **Sen 2007/2008**：未见对 Q·P=0 情形的单独讨论。
  来源：`literature/extractions/sen-2007-wall-crossing.md`、`sen-2008-precision-counting.md`。

- **Rosselló 2024** (arXiv:2403.19630, Corollary 1.1)：
  - 逐字陈述（来源：`literature/extractions/rossello-2024.md` E3）：
    "Let m,n,ℓ∈ℤ with m,n≥1 and Δ=4mn−ℓ²>0. Then, d_*(m,n,ℓ) > 0."
  - **适用范围包含 ℓ=0**（ℓ=0, m,n≥1 ⟹ Δ=4mn>0，满足条件）。
  - **未就 ℓ=0 的良定性作任何说明**（无主值规定、无围道歧义讨论、无"留数为零"注记）。
  - 本项目未能确定这是因为该事实被作者视为显然、还是被忽略。

- **Bhand–Sen–Singh 2023** (arXiv:2311.16252)：
  - 定义电荷集 A、B（eq 5.46-5.49），最小值判别式中允许 ℓ=0（0≤|ℓ|≤2m 等条件包含 ℓ=0）。
  - 来源：`literature/extractions/bhand-sen-singh-2023.md` E4-E5。
  - 未单独讨论 ℓ=0 的留数或良定性。

**裁定 Q2**：Q·P=0 在 Denef–Moore 公式中自动给出 Δd=0（壁跨越跳变为零），但**未见文献明确称其为"透明壁"或讨论围道良定性**。Rosselló 2024 在陈述正性定理时**未排除 ℓ=0**，这是本次检索发现的最关键证据——该文使用 `d_*(m,n,0)` 却未说明其为何良定，与本 attempt 的主张（留数为零使其自动良定）形成对照。

---

### Q3：d_*(m,n,0) 的良定性是否被单独讨论过

**检索结果**：

- **Rosselló 2024 Corollary 1.1**：断言 d_*(m,n,ℓ)>0 对所有 Δ>0（含 ℓ=0），**未附任何说明**（见 Q2）。
  - 若围道积分穿过极点且留数非零，则需主值规定或围道选取约定使结果良定；Rosselló 原文无此讨论。
  - 本 attempt 的贡献在此：证明留数 ∝ ℓ = 0，故微扰围道两侧自动给出同一值，无需主值规定。

- **其他文献**：均未见对 ℓ=0 良定性的单独讨论。

**裁定 Q3**：在本次检索覆盖范围内，**未找到** d_*(m,n,0) 良定性（围道穿过极点但留数为零）的明确讨论。Rosselló 2024 的无条件断言是唯一间接证据，但其原文未给出机制。

---

## 三档裁定

### 部分先行工作（Partial Prior Art）

**已知层级**：
- **结论**：⟨Γ₁,Γ₂⟩=0 ⟹ Δd=0（壁跨越跳变为零）**已知**，Denef–Moore 2007 标准公式的直接推论。
- **物理图像**：边缘稳定壁在 Q·P=0 时无跳变，物理文献已确立。

**在本次检索覆盖范围内未找到的层级**：
- **推导路径**：从 Φ₁₀ 的 v-偶性 + 二阶零点用留数演算导出 `Res ∝ ℓ`。
  - 已知路径（Denef–Moore）：多中心 BPS 超引力分析 → 壁跨越公式。
  - 本 attempt 路径：Siegel 模形式解析结构 → Laurent 展开 → 留数 ∝ ℓ。
  - 两路径在数学上独立（前者物理论证，后者纯复分析）。

- **ℓ=0 良定性机制**：
  - Rosselló 2024 **使用** d_*(m,n,0)（Corollary 1.1 断言其>0，无域排除）。
  - **未说明**为何良定（无主值规定、无围道歧义讨论）。
  - 本 attempt **证明**良定性：留数 = 0 ⟹ 微扰围道两侧自动相同。
  - **该层在检索范围内未找到先行工作。**

**推导差异的意义**：
- 结论层面一致（Q·P=0 时壁跨越为零），但推导路径不同不等于无价值——物理结论有多条独立数学推导是常见的（例如同一对称性可从作用量推导、也可从 Noether 定理推导）。
- 本 attempt 的路径（v-偶性 → 留数）是**纯解析方法**，不依赖超引力多中心解的存在性或 Denef–Moore 物理识别，在方法论上独立。
- 是否有价值由物理社群判断（不在本次文献核查范围内），但**不得在结论层主张优先权**（该层已知）。

---

## 本次检索的覆盖范围与盲区

### 已检索（我亲自逐字核实或通过本项目已有抽取记录核实的）

**本项目已有抽取记录**（7 篇）：
1. Sen 2007 (hep-th/0702141) — 壁跨越公式，围道与 chamber 对应
2. Sen 2008 (0708.1270) — Φ₁₀ 二阶零点（Appendix C），一般坐标变换
3. Denef–Moore 2007 (hep-th/0702146) — 分裂态与壁跨越公式
4. Cheng–Verlinde 2007 (0706.2363) — 围道选取与多中心壁跨越
5. Dabholkar–Gomes–Murthy 2008 (0803.2692) — 围道积分定义，挠除子和
6. Rosselló 2024 (2403.19630) — N=4 单心 dyon 指标正性（含 ℓ=0）
7. Bhand–Sen–Singh 2023 (2311.16252) — Mock 模性，电荷集 A/B

**Web 搜索**（2026-09-20，三组关键词）：
- "Siegel modular form wall crossing Q dot P equals zero vanishing residue"
- "Igusa cusp form Phi_10 v-even second order zero contour integral dyon"
- "marginal stability wall transparent Q·P=0 dyon degeneracy well-defined"
- 结果：标准壁跨越文献（Sen, Cheng–Verlinde, 几何壁跨越群），无新命中。

### 本次检索**未**覆盖（盲区，先行工作最可能藏身之处）

按可能性从高到低排列：

1. **Sen 的后续综述**：
   - Sen 2010 "Quantum Entropy Function"（可能含更完整的留数计算）
   - Sen 其他 N=4 dyon 综述（2008-2015）的技术附录

2. **Murthy–Pioline–Manschot 系列**（2010-2015）：
   - Mock 模形式与精炼指标的技术论文
   - 附录中可能有 Siegel 模形式留数的显式公式

3. **纯数学 Siegel 模形式文献**：
   - Freitag *Siegelsche Modulfunktionen* (1983)
   - Igusa *Theta Functions* (1972)
   - Gritsenko–Nikulin 后续工作（1998 之后）
   - 可能含 Φ₁₀ 二阶零点结构的更显式陈述

4. **Kontsevich–Soibelman 原始论文**（2008）：
   - 壁跨越公式的数学推导
   - 可能包含留数层级的分析（未在物理文献摘要中突出）

5. **物理文献技术附录**（隐藏的计算细节）：
   - Dabholkar–Murthy–Zagier 2012 (1208.4074) 的 DMZ 分解定理技术部分
   - Alexandrov–Nampuri 或 Bossard–Cosnier-Horeau–Pioline 手册式综述
   - 这类文献常含"专家已知但未在摘要/引言突出"的技术结果

6. **CHL 推广系列**（N>1 情形的技术论文）：
   - 可能在处理一般 CHL 轨道时遇到类似留数问题并有讨论

### 检索方法的局限性

- **ar5iv HTML 编号不可信**：本项目此前在 DGM 0803.2692 上发现 ar5iv 自动编号与 arXiv 官方 PDF 不一致（见 `literature/extractions/dabholkar-gomes-murthy-2008.md` 订正 C2），故本次优先信任本项目已有的、基于 PDF 的逐字抽取。
- **Web 搜索覆盖面有限**：技术细节常藏在附录，不会在摘要/引言出现，web 搜索难以命中。
- **付费墙**：Freitag, Igusa 经典著作可能有访问限制（未在本次尝试，因本项目已有抽取记录提供足够材料回答任务核心问题）。

---

## 未解决的疑问

1. **Sen 2008 §5.6 及之后章节**：本项目现有抽取记录覆盖 Appendix C/D，但 §5.6 的鞍点分析部分可能含留数显式计算，未在已有抽取中完整覆盖。
2. **DMZ 2012 的 mock Jacobi 分解技术细节**：`literature/extractions/dabholkar-murthy-zagier-2012.md` **确实存在**（lead 于 2026-09-20 核实），本次任务未调用它。这不是盲区，是**本次检索的遗漏**——该文件可直接检索，无需外部访问。下一轮应优先补上。
3. **Rosselló 2024 原文是否在正文或附录某处提及 ℓ=0 良定性**：本项目已有抽取记录覆盖主定理与推论，但未逐页通读全文（64 页），技术引理中可能有相关讨论。

---

## 对 `research/attempts/ell-zero-wall-degeneracy/` 的建议

### 对 [GAP-4.2] 的处理

- 保持 **[GAP-4.2]：先行工作未核查，不作优先权主张** 的标注。
- 若该 attempt 毕业为图节点，`notes` 字段建议措辞：
  "结论（ℓ=0 时壁跨越跳变为零，壁透明）与 Denef–Moore 2007 壁跨越公式一致。机制性推导（从 Φ₁₀ 的 v-偶性与二阶零点通过留数演算得出 Res ∝ ℓ）在已检索文献中未找到（Sen 2007/2008, Cheng–Verlinde 2007, DGM 2008, Rosselló 2024, BSS 2023；检索盲区见 `literature/notes/ell-zero-wall-residue-prior-art.md`）。"

### 对 proof.md §4.2 的建议

- 物理意义段落（"Q·P=0 壁透明"）可保留，但需注明：该结论已由 Denef–Moore 2007 确立（壁跨越公式含 Q·P 因子），本 attempt 提供的是独立推导路径。
- 避免"首次从 Siegel 模形式直接推出"等措辞（无法在检索未覆盖全部文献时断言）。
- 可写"本推导不依赖 Denef–Moore 的多中心 BPS 分析，仅用 Φ₁₀ 的解析性质，在方法论上独立"。

### Rosselló 2024 Corollary 1.1 的意义

- **关键发现**：Rosselló 断言 d_*(m,n,ℓ)>0 对**所有** Δ>0（含 ℓ=0），未附任何良定性说明。
- 该文**未就此作任何表述**；本项目不推测作者的意图或认知状态（与上文 Q2 的措辞一致）。可核的事实只有两条：该文使用 `d_*(m,n,0)`，且该文未给出其良定性的机制。
- 本 attempt 的贡献在于**显式证明**该良定性（留数 = 0 ⟹ 围道两侧自动相同），填补 Rosselló 原文未说明的一步。

---

## 我亲自验证了什么、我转述信任了什么

### 亲自验证（通过本项目已有抽取记录，本人逐字核对其引用的原文位置与转述）

- Sen 2008 Appendix C (C.25-C.26)：Φ₁₀ 的二阶零点 `Φ̂ = −4π²v²g(ρ)g(σ) + O(v⁴)`（转引自 `sen-2008-precision-counting.md` S6，该抽取记录标注为"逐字，arXiv PDF 页面图像"）。
- Rosselló 2024 Corollary 1.1：陈述中无 ℓ=0 排除、无良定性说明（转引自 `rossello-2024.md` E3，该抽取记录标注为"arXiv HTML 全文 + 官方 PDF 交叉核对"）。
- Denef–Moore 2007 壁跨越公式结构（转引自 `denef-moore-2007.md` E1）。
- DGM 2008 围道积分定义（转引自 `dabholkar-gomes-murthy-2008.md` S1，该抽取记录标注为"arXiv PDF 直接读取，逐字"）。
- BSS 2023 电荷集定义（转引自 `bhand-sen-singh-2023.md` E4-E5，该抽取记录标注为"arXiv PDF 直接读取，逐字"）。

### 转述信任（本项目已有抽取记录，本人未重新下载原文独立核对）

- Sen 2007 §4 及之后章节的内容（`sen-2007-wall-crossing.md` E4-E5 标注"已读章节 pp.1-15 未见，需查阅 §4 之后"）。
- Kontsevich–Soibelman 2008（本项目无抽取记录）。
- DMZ 2012 技术部分（`literature/extractions/dabholkar-murthy-zagier-2012.md` 存在但本次任务未调用；见下文「未解决的疑问」第 2 条）。

### 未取得（付费墙或超出本次任务范围）

- Freitag *Siegelsche Modulfunktionen* (1983)
- Igusa *Theta Functions* (1972)
- Sen 2010 综述全文
- Murthy–Pioline–Manschot 系列技术附录

---

## 检索方法说明

1. 首先通读 `research/attempts/ell-zero-wall-degeneracy/proof.md` 全文，提取核心机制：v-偶性 + 二阶零点 → Res ∝ ℓ → ℓ=0 留数为零。
2. 逐一检查本项目已有的 7 篇核心抽取记录，针对三个核心问题查找相关陈述。
3. 进行三组 web 搜索（技术关键词组合），查找可能遗漏的文献。
4. 交叉比对各文献的引用关系（例如 Rosselló 引用 DMZ，BSS 引用 DMZ 并声明与之记号不同）。
5. 列出检索覆盖范围与盲区，明确本次结论的边界。

---

**记录人**：researcher agent (gap42-prior-art)
**证据来源**：本项目 `literature/extractions/` 已有记录（由其他 researcher 在 2026-09-14 至 2026-09-20 期间逐字核对原文建立）+ 2026-09-20 web 搜索
**报告状态**：已落盘（本文件），已提交 git
