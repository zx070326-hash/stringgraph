# 抽取记录：断言 (2) 第三轮检索 —— arXiv 开放的"物理↔VOA 桥梁"综述

- 目标：为 `graph/statements/worldsheet/physical-exponential-equals-voa-vertex-operator.yaml` 的
  断言 (2)（即 `:e^{i n k₀·X(z)}: = 𝒴(e^{n k₀}, z)` 这一算子等式）找一手公开文献支持。
- 抽取者：researcher
- 日期：2026-09-18
- 覆盖范围：本轮（第三轮）明确策略——只追 arXiv 开放全文的物理学家写作的"翻译型"综述，
  放弃一切付费墙来源（第二轮已在 Goddard–Olive 1986 / Kac 1998 上耗尽这条路且确认真正
  不可获取，非本轮任务）。

## 判据（与第一、二轮完全一致，逐字重申以自我约束）

必须**同时**做到：
1. 写出物理侧对象——出现 `X^μ(z)`（或等价的自由玻色场模展开 `α^μ_n`）与正规序记号 `: :`；
   散文里提一句"free bosonic CFT"不算。
2. 与 VOA 侧结构映射 `Y(e^α, z)` / `𝒴(e^α, z)` 划等号，或明确说这两个是同一算子——且必须是
   **两个独立构造出来的对象之间的等式，不是定义式**。若某个 `Y_α(z)`/`V(α,z)` 被 `:=` 直接
   定义成正规序指数（或被"改写"成正规序指数），不算，即便记号上两套语言都出现了。

## 候选清单与结论

### E1 Gebert 1993（arXiv:hep-th/9308151）—— 本轮最强候选，逐字核实后仍判定不满足

- 位置：全文 55 页。核心段落 §3.1 Definition 1（PDF p.9–10，抽象顶点代数公理）、
  §4.1 Theorem 5（PDF p.27，格点顶点代数存在性）、**§4.2 "Fock space and vertex operators"
  （PDF p.28–30，物理化改写的核心段落）**、§4.3（PDF p.30 起，公理验证）。
- 类型：review article（物理学家写给物理学家的顶点代数/Borcherds 代数/Monster 引论），
  arXiv 全文开放，无付费墙，本条完全 L1（`pdftotext -layout` 落盘 3442 行 + PDF pp.27–31
  原始页图像核实，见下方逐字引文，图像核实优先于 pdftotext 因为后者会丢失部分求和上下限
  与花体符号）。
- 原文陈述（逐字，按出现顺序）：

  **(a) §3.1 Definition 1（抽象顶点代数公理，独立于任何具体构造，先于 §4 出现）**：
  > A vertex algebra is a Z-graded vector space F = ⊕_{n∈Z} F_{(n)} equipped with a linear map
  > V : F → (End F)[[z, z⁻¹]] which assigns to each state ψ ∈ F a vertex operator V(ψ, z), and
  > the vertex operators satisfy the following axioms:
  > 1. (Regularity) ... 2. (Vacuum) V(1, z) = id_F ... 3. (Injectivity) V(ψ, z) = 0 ⟹ ψ = 0 ...
  > 4. (Conformal vector) ... 5. (Jacobi identity) ...

  **(b) §4.1 Theorem 5（存在性定理，构造之前先陈述要证明什么）**：
  > Associated with each nondegenerate even lattice Λ there is a vertex algebra (F, V, 1, ω).
  > If in addition Λ is positive definite then (F, V, 1, ω) has the structure of a vertex
  > operator algebra.

  **(c) §4.2，引入物理动机与 Fock 空间构造**：
  > The vertex algebra (F, V, 1, ω) which we shall construct can be thought of as a bosonic
  > string theory with d spacetime dimensions compactified on a torus. Thus Λ represents the
  > allowed momentum vectors of the theory.

  **(d) §4.2，正规序的显式定义**：
  > We will employ the usual normal ordering procedure, i.e. colons indicate that in the
  > enclosed expressions, q^ν is written to the left of p^μ, as well as the creation operators
  > are to be placed to the left of the annihilation operators.

  **(e) §4.2，先用振子分裂记号 `:=` 定义 `V(e^r,z)`（eq. 69）**：
  > For e^r ∈ C{Λ}, we set
  >   V(e^r, z) := exp(∫ r_<(z)dz) e^r z^{r(0)} exp(∫ r_>(z)dz)          (69)
  > using an obvious formal integration notation, i.e.
  >   ∫ r_<(z)dz := Σ_{m>0} (1/m) r(−m) z^m,   ∫ r_>(z)dz := −Σ_{m>0} (1/m) r(m) z^{−m}

  **(f) §4.2，改写为物理记号，本轮全文最核心的一句（逐字，含两处自我限定措辞）**：
  > This can be written in a way more familiar to physicists by introducing formally the
  > Fubini-Veneziano field,
  >   Q^μ(z) ≡ q^μ − i p^μ ln z + i Σ_{m∈Z, m≠0} (1/m) α^μ_m z^{−m}
  > which really only has a meaning when exponentiated. We find
  >   V(e^r, z) = :e^{i r·Q(z)}: c_r

  **(g) §4.3，关于 Virasoro 生成元（非顶点算子本身）与弦论一致性的确认句**：
  > ... in agreement with the well-known expression from string theory.

- 文献自称的严格程度：综述文章（review），§3–§4 是标准的"公理化定义 → 构造范例 → 验证公理"
  数学结构，作者自述目标是让物理学家能读懂 VOA 形式化（引言："using the notation of [37]
  which we believe is more accessible to physicists"）。§4.3 标题"Regularity, vacuum,
  injectivity, conformal vector"，明确是在**证明** §4.2 构造出的 `V(·,z)` 满足 §3.1 抽象定义
  的公理——这是一个真正的数学证明结构（构造 + 验证），不是纯粹的类比陈述。
- 文献列出的依赖：§4.1 把 Theorem 5 的既有出处列为 [11], [32], [22]（本条目未核实完整书目）；
  §4.2 开篇"For physical motivations of the construction below the reader may consult the
  beautiful articles [39],[38],[40] or the comprehensive review [52]"——**这四个引用极可能
  正是 Round 2 里已判定 L0/不可获取的 Goddard–Olive 系论文**（本条目未逐一核实书目号，但
  强烈怀疑 [40] = Goddard–Olive "Kac-Moody and Virasoro algebras in relation to quantum
  physics"，出现在本文参考文献表 [40] 处，见 gebert1993.txt 行 3332 附近："[40] P. Goddard
  and D. Olive. Kac-Moody and Virasoro algebras in relation to quantum ..."）——**这构成
  一条新的间接证据**：本文作者自己认为"物理动机的完整论述"在别处（很可能就是 Round 2
  判定不可获取的那批文献），而不在本文§4.2 里把物理构造与 VOA 构造分别独立做出。
- 备注（判据核对，本轮最关键的分析）：
  - **判据条件 1（写出 `X^μ(z)` 类对象 + 正规序）：满足**。`Q^μ(z)` 携带时空指标 `μ`，
    正规序记号 `: :` 在 (d) 处被显式定义（不是含糊带过），整节明确框定为"bosonic string
    theory ... compactified on a torus"。这是本轮和前两轮读到的**唯一**同时满足条件 1 的
    物理化写法且伴有 VOA 记号 `V(·,z)` 并列出现的文本（比 Nikolov–Todorov 2004 的 `φ_α(z)`
    更贴近物理教科书写法：N-T 的场没有时空指标、没有零模项 `q^μ − ip^μ ln z` 在同一个
    指数内，Gebert 的 `Q^μ(z)` 把零模与振子部分统一写进一个场）。
  - **判据条件 2（两个独立构造对象之间的等式）：不满足，但比 N-T 更细致地不满足**——
    需要区分两层："VOA 侧的 `V(·,z)`" vs. "物理侧的 `Q^μ(z)`/`:e^{ir·Q(z)}:`"。
    - VOA 侧确实**独立构造**：§3.1 Definition 1 先给出完全抽象的顶点代数公理（不涉及任何
      格点、任何物理），§4.1 Theorem 5 断言"存在"满足这些公理的格点顶点代数，§4.2/4.3 才
      去构造并验证。这个逻辑顺序（先抽象公理，后具体构造+验证）**比 Nikolov–Todorov 更强**——
      N-T 的 `Y_α(z)` 是直接在格点段落里用 `:=` 定义的，没有先给出独立于格点情形的抽象刻画。
    - 但**物理侧不是独立构造**：`Q^μ(z)` 本身没有任何独立于 (69) 的物理论证（例如：没有从
      Polyakov 作用量正则量子化、没有从自由玻色场的正则对易关系 `[X^μ(z),X^ν(w)]` 或
      OPE 推导出 `Q^μ(z)` 的模展开形式）。作者原文用两个措辞**自陈**这一点：
      "introducing **formally** the Fubini-Veneziano field"（"formally"=只是形式上引入，
      不是独立构造）与"which **really only has a meaning when exponentiated**"（这个场本身
      没有独立意义，只有指数化后才有意义——即它是为了让 (69) 的表达式在指数化后look像物理
      记号而**倒推**引入的记号装置，不是先有一个独立定义好的场再指数化）。
    - 因此 (f) 处的等式"`V(e^r,z) = :e^{ir·Q(z)}:c_r`"的正确读法是：**同一个构造（(69)）
      的两种记号写法之间的恒等式**（振子分裂记号 ↔ 正规序指数记号），不是"物理上独立构造出
      的 `:e^{ikX(z)}:`"与"VOA 上独立构造出的 `Y(e^α,z)`"这两个各自成立的对象**之后**被
      证明或断言相等。这与 Nikolov–Todorov 2004 §5.2 的缺陷**同型**（定义式，不是识别式），
      但 Gebert 的版本因为作者自己写出"formally"与"only has a meaning when exponentiated"
      而更加**明确地自证**了这一点——这不是抽取者的推断，是原文文本本身的措辞。
  - **附带问题 (b) 连续动量↔离散格点接口**：本文全文构造只处理**离散**格点 `Λ`（偶格，
    `r ∈ Λ`），完全没有连续动量的物理设定，也没有"从连续谱到离散格点的极限/量子化论证"——
    这个接口问题本文**未处理**（不是"处理了但方式不同"，是**完全没有出现**这个问题，因为
    本文从头到尾的动量变量 `p^μ` 本征值就是格点向量，见 (b)/(c)/§4.1 前置定义）。
  - **附带问题 (c) δ 归一化**：本文 cocycle 因子 `c_r`（§4.1 (63)–(67)）处理得很仔细
    （双覆盖群 `Λ̂`、2-cocycle `ε(r,s)` 的存在性证明），但因为动量离散，**不需要**也**没有**
    出现 `δ(k−k')` 类型的归一化讨论——这个问题在本文的设定下不适用，不能算"处理了"。
  - **§4.3 (g) 的"in agreement with the well-known expression from string theory"**：这句话
    紧跟在 `L(n)` Virasoro 生成元的推导之后，是对**Virasoro 代数模式**（不是顶点算子本身）
    与弦论已知表达式一致性的确认——容易被误读成"作者确认了整个构造与弦论物理算符一致"，
    但严格讲这句话的语法主语是 `L(n)`，不是 `V(e^r,z)` 或 `:e^{ikX}:`，**不可**当作断言 (2)
    的额外支持证据引用。

### E2 Dolan–Goddard–Montague 1994（arXiv:hep-th/9410029）—— 本轮次强候选，尚待深入核实

- 位置：全文 65 页（Commun. Math. Phys. 179 (1996) 61–120）。已下载并 `pdftotext -layout`
  转换（65 页 PDF，3627 行文本），**本轮时间预算受限，未及深入分析**，标记为 **L0（未读）**，
  仅记录获取状态与后续路线，供下一轮或 curator 优先处理。
- 类型：review/research article（物理学家写作的格点 CFT 构造论文，作者组包含 Goddard，与
  Goddard–Olive 系一脉相承，是本轮任务书标注的"第二强候选"）。
- 获取状态：**全文已下载，可随时读取**（`arxiv.org/pdf/hep-th/9410029` 200，无付费墙），
  本轮因时间预算优先给了 Gebert 1993 的逐字核实（任务书明确要求"候选 1、2 必须做透，宁可
  不做候选 3–6"，本轮实际只做透了候选 1，候选 2 停在"已获取但未读"，如实记录，不强行
  拼凑结论）。
- 备注：任务书原文提示本文"明确写出 `:e^{ik·X}:` 类顶点算子**并与 FLM 构造对照**"——
  若这一提示准确，本文可能是本轮乃至三轮里最有希望满足判据条件 2 的候选（因为"与 FLM
  构造对照"暗示可能存在"物理侧独立构造 + 与数学侧 FLM 构造相比较/等同"这一结构，不同于
  Gebert 单线构造再改写记号的模式）。**这是本条目留给下一轮的最高优先级任务**，不应因为
  Gebert 已出结果就跳过。

### E3–E6 候选 3–6（任务书标注"若时间不足可只标 L0 并简述"）—— 本轮判定为时间预算不足，未展开

按任务书的明确优先级指示（"候选 1、2 必须做透……否则不要六个都浅尝辄止，这正是第二轮
散掉的失败模式"），本轮把全部核实时间用于候选 1（Gebert 1993，已做透，见 E1）与候选 2
的获取（Dolan–Goddard–Montague，已下载但未读，见 E2）。候选 3–6 如实标记为 **L0**：

- **候选 3：Goddard–Olive, "Algebras, Lattices and Strings", MSRI Publications vol. 3**
  （*Vertex Operators in Mathematics and Physics*, Lepowsky–Mandelstam–Singer eds., Springer
  1985, pp.51–96）。**L0，本轮未尝试获取渠道**（未查 msri.org、library.msri.org、
  archive.org 镜像）。任务书标注为"物理学家与数学家当面对照记号的历史现场"，仍是本项目
  一个真实的悬而未决的高价值目标，留给下一轮。
- **候选 4：Gaberdiel, "An Introduction to Conformal Field Theory", arXiv:hep-th/9910156**。
  **L0，本轮未获取**。arXiv 开放，获取成本低，是最容易"顺手"补的一条，留给下一轮。
- **候选 5：FLM 1988 第八章的二手逐字转引**（搜索引用 FLM 并逐字摘录 (8.x.x) 式号的 arXiv
  论文）。**L0，本轮未搜索**。
- **候选 6：Kac–Raina–Rozhkovskaya Bombay Lectures 新公开 PDF 复核**。**L0，本轮未复核**
  （bib 已登记为 L0 来源，本轮未尝试寻找新的公开镜像）。

## 结论

**(C) 部分结论，倾向于 (B) 但不满足自我设定的证据强度要求，不强行判定**。

本轮唯一深入核实的候选（Gebert 1993, hep-th/9308151, §4.2）是**迄今三轮里结构上最接近
断言 (2) 的文本**：它满足判据条件 1（写出带时空指标的物理场 `Q^μ(z)` 与显式正规序），
且其 VOA 侧结构映射 `V(·,z)` 确实先经抽象公理独立定义（比 Nikolov–Todorov 更强的独立性）——
但物理侧的 `Q^μ(z)` 本身缺乏独立构造，作者原文用"formally"与"which really only has a
meaning when exponentiated"两处措辞**自陈**该场只是既有构造 (69) 的记号改写装置。因此，
按照与前两轮完全一致的严格判据（定义式 ≠ 识别式），**本条不满足断言 (2)**，与
Nikolov–Todorov 2004 属同一失败模式，但本条的"两侧独立性"程度确实比 N-T 更高（VOA 侧
独立性强，物理侧独立性仍缺失），值得在图节点的 notes 里作为"目前读到的最强 near-miss"
记录，供后续判断"识别式在数学物理文献里是否根本罕见/不存在"提供更强的负面证据密度。

**本轮未能完成任务书要求的"候选 1、2 都做透"这一目标**——候选 2（Dolan–Goddard–Montague
1994）虽已下载全文（无付费墙，可随时读取），但受限于本轮时间预算，**未及分析**，是本轮
最大的遗留风险点。任务书特别提示该文"与 FLM 构造对照"，如果这一提示准确，候选 2 结构上
可能与 Gebert 1993 不同（存在"物理侧独立构造 + 与数学侧比较"的机会），**不能仅凭候选 1
的负面结果就推断候选 2 也会失败**，下一轮必须优先读它，而不是转向候选 3–6。

### 本轮明确未能核实/未完成的事项（残余风险，逐条列出）

1. **Dolan–Goddard–Montague 1994（hep-th/9410029）全文未读**——已下载
   （`C:\Users\charles\AppData\Local\Temp\a2r3\dgm1994.pdf` / `dgm1994.txt`，65 页/3627 行），
   本轮唯一遗留的"高优先级、低获取成本"目标，**强烈建议下一轮第一件事就是读它**，而不是
   六个候选平均分配时间。
2. **Gebert 1993 §4.2 引用的 [39],[38],[40] 三篇"物理动机"文献的完整书目未核实**——本条目
   推测 [40] 可能是 Goddard–Olive（本项目 Round 2 已判定该文献真正不可获取），但未逐一核对
   参考文献表条目号与书目细节，留待后续（若要核实，需读 gebert1993.txt 参考文献表全文，
   本轮已定位大致行号 3260–3340 附近但未逐条转录）。
3. **候选 3（Goddard–Olive MSRI Publications vol.3）的获取渠道完全未尝试**——历史上"物理
   学家与数学家当面对照记号"的最可能现场，任务书标注为高价值，本轮零进展。
4. **候选 4（Gaberdiel hep-th/9910156）** —— arXiv 开放，获取成本低，本轮零进展，是下一轮
   除候选 2 外的第二优先级。
5. **候选 5、6** —— 本轮零进展，见上方候选清单说明。
6. **本条目对 Gebert 1993 的"判据不满足"结论本身依赖对"formally"/"only has a meaning when
   exponentiated"两处措辞的解读**——抽取者判断这是作者自陈"记号装置而非独立构造"，但这是
   一个解释性判断（虽基于逐字原文，但涉及对论证结构的理解），按 `literature/CLAUDE.md`
   规则 2，若 curator 或 reviewer 认为这一解读过严，应重新审视原文（PDF pp.28–30，已给出
   精确页码，可独立复核），本条目的判定不应被当作不可挑战的定论。
