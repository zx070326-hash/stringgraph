# 抽取记录：dabholkar-gomes-murthy-2008（DGM）+ 交叉核 alexandrov-nampuri-2020

- 文献：A. Dabholkar, J. Gomes, S. Murthy, "Counting all dyons in N=4 string theory,"
  arXiv:0803.2692 (2008)；JHEP 05 (2011) 059。
- 交叉文献：S. Alexandrov, S. Nampuri, "Refinement and modularity of immortal dyons,"
  arXiv:2009.01172；JHEP 01 (2021) 147。
- 抽取者：researcher（对抗性逐字裁定，为 research/attempts/torsion-immortal-positivity-hecke 两条外部依赖把关）
- 日期：2026-09-15
- 抽取来源：ar5iv HTML 全文 https://ar5iv.labs.arxiv.org/html/0803.2692 与 .../abs/2009.01172
  （多次独立 fetch 交叉核，确认 eq 号与式子内容一致）。
- 覆盖范围：DGM eq(50)(51)(52) 及其推导脉络、符号约定；A-N eq(2.11)(2.13)(2.16)。
  用于裁定草稿声明 (丙)：DGM eq(51) 与 eq(52) 是否真矛盾。

## 约定

- N=4 弦论（heterotic on T⁶），四维 1/4-BPS dyon。电荷 (Q,P)，不变量 (Q²,P²,Q·P)，
  挠 I = gcd(Q∧P)。指标三元组 (m,n,ℓ) = (Q²/2, P²/2, Q·P)。
- Ω = [[ρ,v],[v,σ]] ∈ ℍ₂；Φ₁₀ = Igusa 尖点形式（Sp(4,ℤ) 权 10）。

## DGM 逐字陈述（arXiv:0803.2692，ar5iv HTML）

### S1 eq(50)：简并度作围道积分（逐字，含符号）
- 位置：正文第 3 节，eq(50)。
- 原文（逐字，LaTeX 转写）：
  `Ω_I(Γ) = (−1)^{Q.P+1} ∮_C dσ dρ dv exp(−iπ Γ^t · [[ρ,v],[v,σ]] · Γ) 𝒵_I(τ)`
- 符号前因子精确为 **(−1)^{Q·P+1}**（指数用**总**电荷 Q·P，即 ℓ），是**积分号外的整体**因子。
- 引言脉络：作者先 "In terms of the invariants (Q², P², Q.P) and I = gcd(Q∧P) of the charge vector Γ"
  改写结果为 eq(50)。

### S2 eq(51)：配分函数作除子和（逐字）—— **无半整平移**
- 位置：正文第 3 节，eq(51)。
- 原文（逐字）：`𝒵_I(ρ,σ,v) = Σ_{s|I} s · 1/Φ₁₀(s²ρ, σ, sv)`
- Φ₁₀ 的第三自变量精确为 **sv**，**无任何加性平移**（无 +(s−1)/2 或半整移动）。
  （对 ar5iv HTML 做了专门的第二次定向 fetch 复核，确认无 shift。）

### S3 eq(52)：简并度作除子和（逐字）
- 位置：正文第 3 节，eq(52)（"The degeneracy can also be expressed as"）。
- 原文（逐字）：
  `Ω_I(Q²/2, P²/2, Q·P) = Σ_{s|I} s · Ω₁(Q²/2s², P²/2, Q·P/s)`
- Ω₁ 的自变量精确为 (Q²/2s², P²/2, Q·P/s) = (m/s², n, ℓ/s)。

### S4 推导脉络与符号来源（逐字/近逐字）
- 推导链 eq(44)–(47)：从 I=1 的围道积分 (45) 出发，**重标 ρ→s²ρ, v→sv**（46），
  再"drop the divisibility conditions on n and ℓ since the contour integral automatically enforces them"（47），
  然后用对偶不变量重新打包成 (50)–(52)。
- 脚注 5（近 eq(42)）：`The factor of (−1)^ℓ noted in [5,19] arises because the charge quantum
  number ñ in four dimensions becomes the spin quantum number j in five dimensions.` 并解释
  "The overall negative sign arises because we are counting the number of bosonic supermultiplets minus"
  fermionic ones。
- **无 erratum**：0803.2692 posted 2008，published JHEP 05 (2011) 059；检索未见任何 erratum/corrigendum，
  也未见后续版本静默修正 eq(51)（ar5iv 抽取的即最新 arXiv 版仍为 sv，无 shift）。

## alexandrov-nampuri-2020 交叉核（arXiv:2009.01172）

### X1 eq(2.11)（逐字）
- `Z^{(4|4)}_I(τ,z,σ) = Σ_{n,m,ℓ} (−1)^ℓ Ω^{(4|4)}_I(n,m,ℓ) q^n y^ℓ p^m`，
  `y=e^{2πiz}, p=e^{2πiσ}`；`Z^{(4|4)}_1(τ,z,σ) = 1/Φ₁₀(τ,z,σ)`。
  脚注："We introduced the sign (−1)^ℓ consistently with [24]"。
  **注意变量标号与 DGM/Rosselló 不同**：此处 n↔q(=e^{2πiτ}), ℓ↔y(=e^{2πiz}), m↔p(=e^{2πiσ})，
  即"指标 m 挂在 p=e^{2πiσ} 上"（与 Rosselló"指标挂 ρ"是 ρ↔σ 换名，结构同）。

### X2 eq(2.13)（逐字）
- `Ω^{(4|4)}_I(n,m,ℓ) = Σ_{d|I} d · Ω^{(4|4)}_1(n, m/d², ℓ/d)`

### X3 eq(2.16)（逐字）
- `Γ⁰(I) = { [[a,b],[c,d]] ∈ SL(2,ℤ) : b = 0 mod I }`

### X4 联立 (2.11)+(2.13) 解出的 Z_I 闭式（本抽取者推导，非文献逐字）
- 代 (2.13) 入 (2.11)，令 m=d²m', ℓ=dℓ'，并用 (−1)^{dℓ'}y^{dℓ'} = (−1)^{ℓ'}(y_new)^{ℓ'}，
  y_new=(−1)^{d−1}y^d ⇔ z_new = dz+(d−1)/2，得
  `Z_I = Σ_{d|I} d/Φ₁₀(τ, dz+(d−1)/2, d²σ)`，
  即**在椭圆变量上带半整平移 (d−1)/2（偶 d 非平凡，奇 d 平凡）**。翻回 DGM 记号即
  `Σ_{d|I} d/Φ₁₀(d²ρ, σ, dv+(d−1)/2)`，**与 DGM eq(51)（无平移）不同，与半整平移版一致**。
  文献本身未直接给出该闭式（A-N 不写 eq(51) 型式子），故与草稿 Prop 5.4 结论无冲突。

## 关键裁定（对草稿声明 (丙)）

### 裁定 (丙-1)：草稿对 eq(50)(51)(52) 的转录 —— **SUPPORT（忠实）**
- 草稿 §0/§5 转录的 eq(50)(51)(52) 与 S1–S3 逐字一致，符号 (−1)^{Q·P+1} 用总电荷、eq(51) 无平移、
  eq(52) Ω₁ 自变量 (m/s²,n,ℓ/s) 均忠实。

### 裁定 (丙-2)：eq(51) 与 eq(52) 是否真矛盾 —— **SUPPORT（真矛盾，非误读约定）**
- 展开：eq(50)+(51) 给 Ω_I = (−1)^{ℓ+1}·[𝒵_I 的 (m,n,ℓ) 系数] = (−1)^{ℓ+1}Σ_{s|I} s·D(m/s²,n,ℓ/s)，
  D=1/Φ₁₀ 的吸引子系数（重标是初等替换，无额外符号）。
  用 Ω₁(m',n',ℓ')=(−1)^{ℓ'+1}D(m',n',ℓ') 改写 ⇒ eq(50)+(51) = Σ_{s|I} s·(−1)^{ℓ+ℓ/s}Ω₁(m/s²,n,ℓ/s)。
  而 eq(52) = Σ_{s|I} s·Ω₁(m/s²,n,ℓ/s)。逐项差因子 **(−1)^{ℓ−ℓ/s}**。
  ℓ=s·(ℓ/s)：s 奇 ⇒ +1；**s 偶且 ℓ/s 奇 ⇒ −1**。差别源自 eq(50) 把 (−1)^{Q·P+1} 作**整体**因子
  （用总 ℓ），而 eq(52) 每个 Ω₁ 自带 (−1)^{(ℓ/s)+1}（用局部 ℓ/s）。
- **穷力寻找能自洽的约定，均告失败**：
  (i) 把 Ω₁ 的符号视作"自变量 Q·P/s 决定"——这正是自然读法，得上述矛盾；
  (ii) 把 y↦−y / 归一化改写——重标 1/Φ₁₀(s²ρ,σ,sv) 的 (m,n,ℓ) 系数就是 1/Φ₁₀ 的 (m/s²,n,ℓ/s)
       系数（初等替换，无符号），无处引入补偿相位；
  (iii) 编号/版本——eq 号 (50)(51)(52) 经多次独立 fetch 确认，无 erratum，无静默修正。
  **唯一能使两式自洽的修改是把 eq(51) 改为 sv→sv+(s−1)/2（偶除子半整平移）**，此即草稿 Prop 5.4，
  且被 A-N (2.11)+(2.13) 的联立闭式 X4 独立佐证。
- **结论：eq(51) 与 eq(52) 按字面写法确为不相容**；最合理解释是 eq(51) 漏了偶除子的半整平移（疑似笔误/
  归一化滑移），eq(52) 才是物理上正确者（对偶不变、整值）。草稿的显式整数见证
  I=2,(m,n,ℓ)=(4,1,2)：两读法差 4·d_*(1,1,1)，与本裁定 (−1)^{ℓ−ℓ/s} 机制吻合（s=2 项翻号）。

### 裁定 (丙-3)：草稿 §5.5 关于 A-N 的论断 —— **SUPPORT**
- 草稿称"联立 A-N eq(2.11)+(2.13) 解出的闭式是 Σ_{d|I} d/Φ₁₀(d²ρ,σ,dv+(d−1)/2)（半整平移版），
  与 DGM eq(51) 不同"。见 X4：联立结果确为半整平移版。A-N 正文未给 eq(51) 型闭式，故与结论无冲突。SUPPORT。

## 未解决/保留

- eq(50) 的围道 C 是否严格等于 Rosselló 的吸引子围道，本抽取未逐字核（DGM 2008 早于系统的吸引子围道讨论）；
  但 (丙-2) 的矛盾是纯符号问题，与围道选取无关（两读法用同一围道、同一 D）。
- Ω 在两文中的整体符号约定相反（DGM Ω₁=(−1)^{ℓ+1}D，A-N Ω₁=(−1)^ℓD），不影响半整平移这一判别特征。

---

## 订正 C2：eq(50)(51)(52) 的编号有误——直接读取 arXiv PDF 确认实际编号为 (3.26)/(3.27)/(3.28)（researcher, 2026-09-20）

**背景**：本文件 S1–S3（2026-09-15 抽取）与项目内多处引用（`graph/statements/holography/dgm-torsion-divisor-sum.yaml`、
`graph/statements/holography/torsion-immortal-positivity.yaml`、`research/attempts/torsion-immortal-positivity-hecke/**`）
均把 §3 三条关键公式标注为 **"eq(50)/(51)/(52)"**。这批编号来自 2026-09-15 抽取时使用的
ar5iv HTML 渲染（`https://ar5iv.labs.arxiv.org/html/0803.2692`），其自动编号计数器**不是**逐节重置的
LaTeX 原生计数器，与 arXiv 官方 PDF 编译结果不一致。

**本次核实方法**：直接 `curl` 下载 arXiv PDF（`https://arxiv.org/pdf/0803.2692`，30 页，单一版本 v1，
2008-03-18 提交，未修订，无 erratum），用 `Read` 工具按页读取图像（含公式编号），逐条核对。

**核实结果（逐字，公式编号取自 PDF 页面图像，非转述）**：

- **实际 eq (2.13)**（第 6 页，§2.2 末尾）：`Ω_I(Γ,φ) = (−1)^{P·Q+1} ∫_C d³τ e^{−iπΓ^t·τ·Γ} 𝒵_I(τ)`
  ——这是**先于微观推导、在 §2 给出的一般定义式**，围道 C 由 (2.14)-(2.15) 给出（`0<Re(ρ,σ,v)≤1`，
  `Im(ρ,σ,v)>>1`，一般 3-环面围道，非电荷依赖的吸引子围道）。内容与 S1 所述"eq(50)"**逐字相同**
  （同一符号前因子 (−1)^{P·Q+1}、同一被积形式），但这是该式**在文中第一次出现的位置**，属 §2 不属 §3。
- **实际 eq (3.26)**（第 16 页，§3.4 内，紧接 (3.24)-(3.25) 之后）：
  `Ω_I(Γ) = (−1)^{Q·P+1} ∮_C dσdρdv exp(−iπ Γ^t·[[ρ,v],[v,σ]]·Γ) 𝒵_I(τ)`
  ——这是 §3 微观推导完成后，**用 T-duality 不变量 (Q²,P²,Q·P) 重新打包改写**同一公式的位置，
  紧接正文"In terms of the invariants (Q²,P²,Q.P) and I=gcd(Q∧P) of the charge vector Γ (3.4),
  we can rewrite this formula as"。**S1 标注的"位置：正文第 3 节，eq(50)"实际对应的是 (3.26)，
  不是 (2.13)**（两式内容相同，只是 (2.13) 是首次定义、(3.26) 是 §3 用不变量重述；S1 引用的
  "第 3 节"上下文与 (3.26) 吻合，故判定 S1 应订正为 **eq(3.26)**，(2.13) 可作为并列/更早出处一并注明）。
- **实际 eq (3.27)**（第 16 页，紧接 (3.26) 之后）：`𝒵_I(ρ,σ,v) = Σ_{s|I} s / Φ₁₀(s²ρ,σ,sv)`
  ——与 S2 所述"eq(51)"内容逐字相同（Φ₁₀ 第三自变量精确为 `sv`，无半整平移）。
  **S2 的"eq(51)"应订正为 eq(3.27)。**
- **实际 eq (3.28)**（第 16 页，紧接 (3.27) 之后）：
  `Ω_I(Q²/2, P²/2, Q·P) = Σ_{s|I} s · Ω₁(Q²/(2s²), P²/2, (Q·P)/s)`
  ——与 S3 所述"eq(52)"内容逐字相同。**S3 的"eq(52)"应订正为 eq(3.28)。**

**结论**：
1. **S1–S3 记录的数学内容本身是准确的**（逐字核对无误，(丙-1)(丙-2)(丙-3) 三条裁定的推理与结论**不受影响**——
   矛盾/相容性分析全部只依赖式子内容，不依赖编号）。
2. **编号本身有误**：项目内所有引用"DGM eq(50)/(51)/(52)"之处，正确编号应为
   **eq(3.26)/(3.27)/(3.28)**（S1 对应式并列出现于更早的 eq(2.13)，内容相同，位置不同）。
   这是 ar5iv 自动编号与 arXiv 官方 PDF 编译编号不一致导致的**转录性错误**，不是原文本身的问题、
   也不是本项目数学论证的错误。
3. **需要 curator/lead 后续更正的文件位置清单**（本人无写入权限，只能在此指出，具体改动留给 curator）：
   - `graph/statements/holography/dgm-torsion-divisor-sum.yaml`（statement/sources/notes 中"eq(50)/(51)/(52)"字样）
     →"eq(3.26)/(3.27)/(3.28)"，必要时 loc 字段"eq(50)+(51)"→"eq(2.13)/(3.26)+(3.27)"。
   - `graph/statements/holography/torsion-immortal-positivity.yaml`（sources/notes 中"eq(52)"引用）。
   - `research/attempts/torsion-immortal-positivity-hecke/**`（claim.md/proof.md 中一切"eq(50)/(51)/(52)"字样）。
   - 本文件（`literature/extractions/dabholkar-gomes-murthy-2008.md`）S1/S2/S3 标题与"位置"字段中的
     "eq(50)/(51)/(52)"——按 append-only 规则不回改原文，仅以本订正节声明正确编号，供后续读者对照。
   - `literature/sources.bib` 中 `dabholkar-gomes-murthy-2008` 条目 note 若含 eq 号需同步（已一并检查，见下方改动）。

**教训（写入供 curator/后续 researcher 参考）**：ar5iv HTML 渲染的公式编号**不可信**，尤其是像本文这样
分节编号（2.x, 3.x）的论文——LaTeXML 有时会把编号拉平成单一全局计数器，导致所有下游转录（包括本
extraction 文件自己 2026-09-15 的初版）系统性引用错误编号。**建议今后核对关键公式编号时，优先下载
PDF 直接读取页面图像**（`curl -sL -o <name>.pdf <arxiv-pdf-url>`，再用 Read 工具 `pages` 参数按 ≤10 页
分块读取），不要单独信任 ar5iv/HTML 渲染的编号，即便内容本身经交叉核对是对的。
