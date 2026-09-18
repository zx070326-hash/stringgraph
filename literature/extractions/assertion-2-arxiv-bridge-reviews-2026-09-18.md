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

### E2 Dolan–Goddard–Montague 1994（arXiv:hep-th/9410029）—— 已逐字核实，判定不满足（比 Gebert 更彻底地不满足）

- 文献：L. Dolan, P. Goddard, P. Montague, "Conformal Field Theories, Representations and Lattice
  Constructions", arXiv:hep-th/9410029（v1 1994-10-05）；Commun. Math. Phys. **179** (1996) 61–120。
- 位置：全文 65 页。已下载 + `pdftotext -layout`（3627 行文本，符号丢失较严重，见下方"记号"
  备注）+ **PDF 第 29–31 页原始图像核实**（`Read` 工具直接渲染，核实 (5.14)–(5.25) 全部公式），
  另用 `Grep` 对全文做关键词扫描（`FLM`、`Y\(|Y_|vertex operator algebra|Jacobi identity|axiom`）。
  本条目现为 **L1（全文关键段落已读，含图像核实的逐字公式）**。
  重点通读：引言（p.1–2，pdftotext 行 1–82）、§2「Definitions and elementary properties」
  开篇 Definition 2.1（pdftotext 行 92–122，图像未核实，纯文本清晰无需图像复核）、§5.2
  「Untwisted construction of a conformal field theory」（pdftotext 行 1578–1730 ≈ PDF pp.29–31，
  **图像逐式核实**）、triality 相关段落（pdftotext 行 2777–2792，PDF §6 附近）。
- 类型：research article（不是综述——是 DGM 自己的原创格点 CFT 构造论文，作者组含 Goddard，
  与 Goddard–Olive 系一脉相承，是本轮任务书标注的"第二强候选"）。
- 原文陈述（逐字，节选，按出现顺序）：

  **(a) 引言，交代与 FLM/Borcherds 的关系（pdftotext 行 67–72，纯文本无符号丢失）**：
  > Our treatment is based on the approach of [12], which was inspired by the work of FLM and
  > Borcherds' general approach to "vertex operator algebras"[13]. Results in a similar direction
  > have also been independently described in [14].
  （[12] = Goddard, "Meromorphic Conformal Field Theory", MSRI 1989；[13] = Borcherds 1986；
  [14] = Frenkel–Huang–Lepowsky, "On axiomatic approaches to vertex operator algebras and
  modules"，本条目核实 [14] 在全文**只在参考文献表出现一次**，见下方"判据核对"。）

  **(b) §2 Definition 2.1，DGM 自建的"共形场论"公理（不是 FLM/Borcherds 的顶点代数公理）**：
  > A conformal field theory $(H, F, V, |0\rangle, L)$ consists of a Hilbert space of states $H$,
  > a dense subspace $F$ [typically the Fock space of states of finite occupation number for some
  > set of harmonic oscillators] and a set $V$ of linear operators called vertex operators
  > $V(\psi, z)$ in one-to-one correspondence with the states $\psi \in F$. ... The theory must
  > satisfy the properties P1–6 detailed below, and is said to be a hermitian conformal field
  > theory if it satisfies in addition property P7.

  **(c) §5.2，物理场的模展开（(5.17)，PDF p.30 原始图像逐符号核实）**：
  > $X^j(z) = q^j - ip^j \ln z + i\sum_{n\neq 0}\dfrac{a^j_n}{n}z^{-n}$   (5.17)

  **(d) §5.2，顶点算子的定义（(5.18)，同页，`:=` 直接定义，非独立等式）**：
  > $V(\psi, z) =: \left(\prod_{a=1}^M \dfrac{i}{(m_a-1)!}\dfrac{d^{m_a}X^{j_a}}{dz^{m_a}}(z)\right)
  > \exp\{i\lambda\cdot X(z)\} : \hat\sigma_\lambda$   (5.18)

  **(e) §5.2，正规序的显式定义（(5.19)–(5.20)，PDF p.31 原始图像逐符号核实）**：
  > where the normal ordering denoted by the colons indicates that $q^j$ is written to the left of
  > $p^j$ as well as the creation operators being written to the left of the annihilation
  > operators, i.e. if $X^j_<(z) = i\sum_{n\gtrless 0}\dfrac{a^j_n}{n}z^{-n}$ (5.19), then
  > $:\exp\{i\lambda\cdot X(z)\}: := \exp\{i\lambda\cdot X_<(z)\}e^{i\lambda\cdot q}z^{\lambda\cdot p}
  > \exp\{i\lambda\cdot X_>(z)\}$   (5.20)

  **(f) §5.2，构造归属：证明"外包"给作者自己更早的论文 [11]**：
  > We have$^{[11]}$ Theorem 5.1 If $\Lambda$ is even, $\mathcal{H}(\Lambda)$, with the structure
  > defined above, forms a conformal field theory with central charge $c=d$ ...
  （[11] = L. Dolan, P. Goddard and P. Montague, *Nucl. Phys.* B338 (1990) 529 —— 即 DGM 自己
  1990 年的更早论文，本文书目表第 11 条，本条目已核实。）

  **(g) 全文对"FLM"的全部四处正文提及（`Grep` 全文核实，逐条列出，均为散文引用，无一处伴随
  `Y(v,z)` 记号）**：
  - 行 51–56（引言）：介绍 Monster module 构造背景（"constructed initially by Frenkel,
    Lepowsky and Meurman (FLM)[5] from the Leech lattice"），叙述性历史陈述。
  - 行 60（引言）：提到"the triality structure of the form exhibited by FLM"，仍是叙述 FLM
    结果内容，不涉及记号。
  - 行 67–72（引言，即 (a)）：交代方法论谱系，如上。
  - 行 78–79（引言，路线图段落）："Section 6 gives the results of these constructions, and
    discusses the connection with the Monster provided by the work of FLM"——预告 §6 会讨论
    FLM 结果的**内容**（Monster 群的实现），不是记号对照。
  - 行 2780、2789（§6/triality 附近）：两次提到"the triality structure of FLM"，同样是讨论
    FLM 结果里"triality 这个群论结构"，与顶点算子记号无关。

- 文献自称的严格程度：research article。§2 Definition 2.1–Proposition 2.16 是 DGM **自建的
  一套物理学家式共形场论公理系统**（P1–P7 性质，Virasoro 表示 + 局域性/OPE 公理，见 (b)），
  §5.2 是在这套自建公理系统下对格点 CFT 的具体构造（(5.14)–(5.31)），Theorem 5.1 的证明
  归属 DGM 自己 1990 年的更早论文 [11]（见 (f)），不是本文原创证明。全文**没有一处**采用
  FLM/Borcherds 的顶点代数（VOA）公理系统本身作为构造或验证的框架——DGM 自陈其方法"based
  on the approach of [12]" 且"[12] was inspired by the work of FLM and Borcherds"（(a)），
  即隔了两层："DGM 的方法" ← "被 [12] 启发" ← "[12] 被 FLM/Borcherds 启发"，从未把 FLM/
  Borcherds 的 `Y(v,z)` 结构映射记号本身写入正文、更没有拿它与 (5.18) 的 `V(ψ,z)` 做逐符号
  对照或证明等价。
- 文献列出的依赖：Theorem 5.1（格点 CFT 存在性）依赖 [11]（DGM 自己 1990 年论文，证明外包，
  见 (f)）；方法论谱系依赖 [12]（Goddard 1989 MSRI）、[13]（Borcherds 1986）、[14]
  （Frenkel–Huang–Lepowsky "On axiomatic approaches to VOA", 1989，仅在参考文献表出现，
  正文未展开引用其公理内容）。
- 备注（判据核对，本条目的核心结论）：
  - **判据条件 1（写出 `X^μ(z)` 类对象 + 正规序）：满足，且是三轮里写得最详尽的一版**。
    (5.17) 携带格点指标 `j`，(5.19)–(5.20) 把正规序拆成 `X_<`、零模 `e^{iλ·q}z^{λ·p}`、`X_>`
    三段并给出显式公式（比 Gebert 的口头正规序定义更精确，比 Nikolov–Todorov 更贴近教科书写法）。
  - **判据条件 2（两个独立构造对象之间的等式）：不满足，且比 Gebert 1993 失败得更彻底**——
    Gebert 至少存在"VOA 侧先给抽象公理（§3.1 Definition 1）、后验证具体构造满足公理"这一
    结构，物理侧的失败在于"记号装置不是独立构造"；DGM 则**从未在正文写出 FLM/Borcherds 的
    `Y(v,z)` 结构映射记号本身**——`Grep` 对全文 3627 行做 `Y\(|Y_|vertex operator
    algebra|Jacobi identity|axiom` 检索只命中 3 处，其中与 VOA 记号最相关的一处（[14] 的
    书目条目，pdftotext 行 3601）**只是参考文献表的一条书目引用**，不是正文使用。换言之，
    本文根本**不存在"VOA 侧的独立构造"这一半**——它只用**自己的**共形场论公理系统
    （Definition 2.1, P1–P7）来构造并验证 `V(ψ,z)`，FLM/Borcherds 的 VOA 形式化仅以历史
    谱系的方式在引言散文中被提及三次（(g) 逐条列出），从未被写出记号、从未被拿来做逐符号
    对照，更谈不上被证明与 `V(ψ,z)` 相等。这是一种"连尝试都没尝试"的不满足，比 Gebert
    "尝试了但物理侧不独立"的不满足更彻底。
  - **附带排查：pdftotext 符号丢失是否可能掩盖了被丢弃的 `Y(v,z)` 记号？**——已用 `Read`
    工具直接渲染 PDF pp.29–31 原始图像核实 (5.14)–(5.25) 全部公式，图像中确认没有任何
    `Y(·,·)` 记号出现（该页面全部顶点算子记号统一用 `V(ψ,z)`/`\hat\sigma_\lambda`）；
    引言与 triality 段落（(g) 各行）纯文本清晰无符号丢失迹象（连续英文句子，非公式行），
    `Y` 作为拉丁字母不属于 pdftotext 易丢失的希腊字母/花体符号类别，本条目判断"记号被
    pdftotext 误删"的风险可以排除，圖像核實的頁面之外的正文段落用纯文本 grep 已足够可靠。
  - **附带问题 (b) 连续动量↔离散格点接口**：与 Gebert 同型，本文全文构造只处理**离散**格点
    `Λ`（偶格），完全没有连续动量的物理设定，未处理该接口问题。
  - **附带问题 (c) δ 归一化**：本文 cocycle 算子 `σ_λ`、`\hat\sigma_λ`（(5.21)）处理仔细，
    但因动量离散，**不需要**也**没有**出现 `δ(k-k')` 类型归一化，同 Gebert，此问题不适用。
  - **triality 段落（(g) 最后两处，pdftotext 行 2777–2792）本条目判断不构成"记号对照"**：
    通读该段（`H(C)^± = V_0^± \oplus \cdots`，"The triality structure of FLM is an involution
    acting on `H(C)` which mixes the straight and twisted spaces..."）——这里"FLM 的 triality
    结构"指的是 FLM 在 Monster module 构造里发现的一个**群论对称性/对合**，DGM 讨论的是
    "能否把这个对称性推广到更一般的格点/编码构造"，与"顶点算子记号是否相等"是完全不同的
    问题，不能作为判据条件 2 的证据。

### E3 Gaberdiel 1999（arXiv:hep-th/9910156）—— 已获取并快速核实，判据条件 1 即不满足，快速排除

- 文献：M. R. Gaberdiel, "An Introduction to Conformal Field Theory", Rept. Prog. Phys. 63
  (2000) 607, arXiv:hep-th/9910156。
- 位置：全文（`pdftotext -layout` 落盘 4282 行）。本条目 **L1（已获取并针对判据条件 1 做
  全文关键词排查，未逐字精读全篇——因为判据条件 1 在排查阶段即已明确不满足，不需要更深入
  核实）**。重点核对 §3.7.4 "Lattice Theories"（pdftotext 行 1575–1669，本文对格点 CFT 的
  唯一构造性段落）与全文 `normal order`/`colons` 关键词命中处（行 1391, 1509）。
- 类型：review article（物理学家写给物理学家的 CFT 教程综述，篇幅极长，公理化程度高）。
- 原文陈述（逐字，§3.7.4 核心构造）：
  > Suppose $\Lambda$ is an even Euclidean lattice with basis $e_j$ ... We define the theory
  > associated to the lattice $\Lambda$ by taking a basis for $V$ to consist of the states
  > $|k\rangle$, $k\in\Lambda$. For each $k$, the corresponding field $V(k,z)$ has conformal
  > weight $\frac12 k^2$, and the amplitudes are given by
  > $V(k_1,z_1)V(k_2,z_2)\cdots V(k_N,z_N) = \epsilon(k_1,\ldots,k_N)\prod_{i<j}(z_i-z_j)^{k_i\cdot k_j}$
  > if $k_1+\cdots+k_N=0$ and zero otherwise.
  且随后 Virasoro 场由自定义流 $H^i(z)$ 的 OPE $H^i(z)H^j(w)\sim \delta^{ij}/(z-w)^2$ (145)
  构造，正规序 `: :` 在全文中**仅**用于流的模式双线性组合（如 (135)：
  `: J^a_m J^b_l := J^a_m J^b_l` if $m<0$, else $J^b_l J^a_m$；Sugawara 构造 (133)–(134)），
  从未出现在一个自由玻色场 `X^μ(z)`/Fubini–Veneziano 场的指数上。
- 文献自称的严格程度：教程综述，§2–§3 用"振幅公理"（amplitude/OPE-based axioms，非 FLM/
  Borcherds 的 `Y(v,z)` 公理，但精神近似）从零构造整套 CFT 形式化，§3.7.4 的格点理论是
  该公理系统下的一个"例子"，顶点算子 $V(k,z)$ 直接由振幅公式 (140) **定义**，不经过任何
  自由玻色场的正则量子化或模展开步骤。
- 备注（判据核对）：**判据条件 1（写出 `X^μ(z)` 类对象 + 正规序指数）：不满足**——全文
  搜索 `e\^\{i|exp\{i` 在 §3.7.4 附近**零命中**，格点顶点算子 $V(k,z)$ 从未写成
  `:e^{ik·X(z)}:` 的形式，也没有引入携带时空/格点指标的模展开场；正规序记号确实存在（(135)
  处显式定义）但只用于流的双线性组合，不用于指数化顶点算子。**因此本文在判据的第一道门槛
  就未通过，不需要进一步核实条件 2**——这是三轮六个候选里第一个"连条件 1 都不满足"的
  候选（Nikolov–Todorov、Gebert、DGM 均满足条件 1 但败在条件 2）。任务书原本认为本文
  "获取成本低、可能是快速补充候选"，核实结果是它确实获取成本低，但结论也来得快：
  **不适用**。

### E4–E6 候选 4（原候选 4 已作为 E3 完成，此处编号顺延为 5–6）与候选 5、6 —— 本轮判定为
时间预算不足，未展开

- **候选 5（原候选 3）：Goddard–Olive, "Algebras, Lattices and Strings", MSRI Publications
  vol. 3**（*Vertex Operators in Mathematics and Physics*, Lepowsky–Mandelstam–Singer eds.,
  Springer 1985, pp.51–96）。**L0，本轮未尝试获取渠道**（未查 msri.org、library.msri.org、
  archive.org 镜像）。任务书标注为"物理学家与数学家当面对照记号的历史现场"，仍是本项目
  一个真实的悬而未决的高价值目标，留给下一轮——**尤其是候选 1、2、4(E3) 三个 arXiv 开放
  候选已全部核实为不满足判据后，候选 5 成为本项目"识别式是否真的存在于公开文献"这一问题
  剩余最后一个未排查的高价值历史现场**。
- **候选 6（原候选 5）：FLM 1988 第八章的二手逐字转引**（搜索引用 FLM 并逐字摘录 (8.x.x)
  式号的 arXiv 论文）。**L0，本轮未搜索**。
- **候选 7（原候选 6）：Kac–Raina–Rozhkovskaya Bombay Lectures 新公开 PDF 复核**。**L0，
  本轮未复核**（bib 已登记为 L0 来源，本轮未尝试寻找新的公开镜像）。

## 结论

**(A) 结论明确：本轮（第三轮）两个优先候选（Gebert 1993、Dolan–Goddard–Montague 1994）
均已逐字核实完毕，均不满足断言 (2) 的严格判据，且两者失败的方式不同、互相印证**。

**Gebert 1993**（hep-th/9308151, §4.2）是**三轮里结构上最接近断言 (2) 的文本**：满足
判据条件 1（写出带时空指标的物理场 `Q^μ(z)` 与显式正规序），且其 VOA 侧结构映射 `V(·,z)`
确实先经抽象公理独立定义（§3.1 Definition 1，比 Nikolov–Todorov 更强的独立性）——但物理侧
的 `Q^μ(z)` 本身缺乏独立构造，作者原文用"formally"与"which really only has a meaning when
exponentiated"两处措辞**自陈**该场只是既有构造 (69) 的记号改写装置。**失败模式：VOA 侧
独立，物理侧不独立（同一构造的两种记号写法）。**

**Dolan–Goddard–Montague 1994**（hep-th/9410029）失败得**更彻底**：全文构造了详尽的物理侧
顶点算子（(5.17)–(5.20)，`X^j(z)` 模展开 + 显式正规序，判据条件 1 满足度是三轮最高），
但**全文正文从未写出 FLM/Borcherds 的 VOA 结构映射 `Y(v,z)` 记号本身**——`Y(v,z)` 一类记号
仅以书目引用的形式出现一次（参考文献表 [14]），FLM 的名字在正文出现 4 次但全部是叙述
FLM 的**结果内容**（Monster module、triality 群论结构），从未把 `Y(v,z)` 与 `V(ψ,z)` 并列
对照。DGM 用的是**自建的**物理学家式共形场论公理系统（Definition 2.1, P1–P7），只在方法论
谱系上"两层转引"式地提及受 FLM/Borcherds 启发，从未采用 VOA 公理系统本身。**失败模式：
VOA 侧对象根本不在场，无从谈"识别"。**

**Gaberdiel 1999**（hep-th/9910156, §3.7.4）核实更快：本文格点顶点算子 `V(k,z)` 直接由
振幅公理 (140) 定义，全文正规序记号只用于流的模式双线性组合（Sugawara 构造），**从未写出
携带时空/格点指标的自由玻色场 `X^μ(z)` 或正规序指数 `:e^{ikX(z)}:`**——判据条件 1 本身
即不满足，是三轮六个候选里第一个"第一道门槛都未过"的候选。

三个失败模式合起来构成了比前两轮更强的负面证据密度：**四篇被认为最有希望的"物理↔VOA 桥梁"
文献（Nikolov–Todorov 2004、Gebert 1993、Dolan–Goddard–Montague 1994、Gaberdiel 1999）
分别以"定义式非识别式"、"物理侧非独立构造"、"VOA 侧记号根本不在场"、"物理侧记号本身都不
在场"四种不同方式全部未能满足断言 (2) 的严格判据**。

候选 5–7（Goddard–Olive MSRI、FLM 二手转引、Kac–Raina 复核）本轮零进展，如实标记 L0，
留给下一轮或 curator 判断是否值得继续追加检索预算，还是转而接受"断言 (2) 在公开数学物理
文献里可能根本没有以'两个独立对象随后被等同'的强形式被写出过"这一假设，把图节点标注为
`physical-argument`/`inferred` 并附三轮检索的负面证据摘要。

### 本轮明确未能核实/未完成的事项（残余风险，逐条列出）

1. **Gebert 1993 §4.2 引用的 [39],[38],[40] 三篇"物理动机"文献的完整书目未核实**——本条目
   推测 [40] 可能是 Goddard–Olive（本项目 Round 2 已判定该文献真正不可获取），但未逐一核对
   参考文献表条目号与书目细节，留待后续（若要核实，需读 gebert1993.txt 参考文献表全文，
   本轮已定位大致行号 3260–3340 附近但未逐条转录）。
2. **候选 5（原候选 3，Goddard–Olive MSRI Publications vol.3）的获取渠道完全未尝试**——
   历史上"物理学家与数学家当面对照记号"的最可能现场，任务书标注为高价值，本轮零进展，
   是下一轮的最高优先级（因为候选 1、2、E3 三个 arXiv 开放候选已全部确认失败，候选 5
   是唯一"当面对照"历史现场且尚未排查获取渠道的候选）。
3. **候选 6、7（FLM 二手转引、Kac–Raina 复核）** —— 本轮零进展，见上方候选清单说明。
4. **本条目对 Gebert 1993 的"判据不满足"结论本身依赖对"formally"/"only has a meaning when
   exponentiated"两处措辞的解读**——抽取者判断这是作者自陈"记号装置而非独立构造"，但这是
   一个解释性判断（虽基于逐字原文，但涉及对论证结构的理解），按 `literature/CLAUDE.md`
   规则 2，若 curator 或 reviewer 认为这一解读过严，应重新审视原文（PDF pp.28–30，已给出
   精确页码，可独立复核），本条目的判定不应被当作不可挑战的定论。
5. **DGM 1994 的"FLM 记号从未在正文出现"这一结论依赖对全文 3627 行 `pdftotext` 文本的
   `Grep` 关键词扫描 + 三页图像核实（PDF pp.29–31）**——已排查"pdftotext 丢失符号导致误判"
   的风险（见 E2 备注），但**未对全文 65 页逐页做图像核实**（只核实了 §5.2 构造性核心的
   3 页），若 curator/reviewer 认为有必要，可对引言与 §6 triality 段落（pdftotext 行
   51–82、2777–2792）也做图像复核，本条目判断风险很低但不排除。
6. **Gaberdiel 1999（E3）本轮未逐字精读全篇**——只针对判据条件 1 做关键词排查，一旦确认
   条件 1 不满足即停止深入（任务书允许"若候选显然不适用可快速排除，不必逐字精读"的精神，
   但本条目未做 PDF 图像核实，仅凭 `pdftotext` 文本判断，若 curator 认为 §3.7.4 附近存在
   pdftotext 符号丢失掩盖了某个指数化正规序表达式的风险，应对 PDF 对应页（约 pdftotext
   行 1575–1669 附近）做图像复核，本条目判断此风险较低（因为该段落逐字讨论振幅公理，
   叙述连贯，非公式密集丢失区）但不排除。
