# Proof / 路线分析：monstrous / Conway moonshine 与本项目无鬼定理资产

> **本文件性质**：本轮**不是证明**，是对 `claim.md` 候选命题 C/D/E 的**路线可行性分析**，
> 逐条给出 `[GAP]`，并给出最终诚实裁定。取证等级约定同 `claim.md`。
>
> 作者：prover（theorem-prover），2026-09-18。

---

## 1. 调研方法与执行顺序

按任务书要求的三步顺序执行：

1. **先摸清本项目自己的无鬼定理资产**：直接读图（不转述记忆）——
   `graph/statements/worldsheet/{ddf-spanning-hypothesis, ddf-contour-equals-mode-sum,
   physical-exponential-equals-voa-vertex-operator, exponential-vertex-operator-modes,
   free-boson-vertex-algebra-with-lightlike-momentum-tower}.yaml`、
   `graph/statements/math/lattice-vertex-algebra.yaml`、以及对应的 `derivations/` 卡。
   同时检查了 `git branch -a` 确认存在未合并分支 `agent/formalizer/moonshine-bridge`，
   读取其 `formal/BLUEPRINT-moonshine-bridge.md`（318 行，2026-09-18 由 formalizer 角色写成），
   确认其结论（秩1→秩2是真实的结构缺口；DDF-spanning 的 N≥6 是另一独立瓶颈；两条小的
   Lean 预备任务）与本轮独立读图结果一致，**不重复其工作**，只在其基础上继续往下钻。
2. **逐字核实 Borcherds 1992 用无鬼定理的确切方式**：通过图内
   `worldsheet.ddf-spanning-hypothesis--via-borcherds-1992.yaml` 的 sources/notes 复核
   Theorem 5.1 的假设与结论（本卡本身已是 researcher 2026-09-14/15 逐字核对
   `literature/extractions/borcherds-1992.md` 的结果，本轮**未重新独立打开** Invent. Math.
   109 原文——这是本文档的一个诚实局限，见 §6 的"未尽核实"）。
3. **核实 Conway moonshine 侧引用**：WebSearch 独立核对 Duncan–Mack-Crane 2015 与
   Harrison–Paquette–Volpato 2018 的题目/作者/期刊/卷期/DOI（见 claim.md §0.3），
   纠正上一轮 `umbral-moonshine-origin` 里"HPV 2018"这个缩写引用为完整、可核验的书目信息。

在完成上述三步后，本轮把主要精力放在**深挖候选 C**（瓶颈节点
`worldsheet.physical-exponential-equals-voa-vertex-operator`）——因为它是任务书明确点名的
"最可能升级"的节点，也是任务书判据 4（确认无源可查）里唯一一条看起来真正接近"或许真无源"
边界的候选。以下 §2、§3 记录深挖过程。

---

## 2. 候选 C 深挖：两侧算子公式的显式比对

### 2.1 物理侧公式（图内 `worldsheet.exponential-vertex-operator-modes`，`status: formalized`）

对常向量 `b ∈ R^D`（携带动量 `b = (2α')^{1/2} c`），在代数 Fock 空间 `F` 上定义

```
E₋(b; z) = exp( Σ_{l≥1} (b·α_{-l}/l) z^l )      [创生指数]
E₊(b; z) = exp( − Σ_{l≥1} (b·α_l/l) z^{-l} )    [湮灭指数，指数带负号]
V^{(b)}_J := Σ_{p+q=J} E₋(b)_p ∘ E₊(b)_q        [J ∈ Z]
```

这**是** Lean 里 `StringFormal.NoGhost.Fock.vertexOsc` 的逐字定义（该卡 `formal.lean_decl`）。
零模移位 `S_n = e^{i n k_0·x}` 由 `worldsheet.momentum-tower-fock-space` 单独给出，复合后得到
`worldsheet.ddf-operators-v6` 语境下的完整 `V^{(n)}_J`。

### 2.2 VOA 侧公式（图内 `math.lattice-vertex-algebra` (3.10)）

```
Y(e^α ⊗ u, x)(e^β ⊗ v) = ε(α,β) e^{α+β} ⊗ x^{⟨α,β⟩} E^-(−α, x) Y(Δ̄(β, x) u, x) Δ̄(α, −x) v
```

这条公式**本身**在图内是不完整的：卡内正文明写「`E^-(·, x)`、`Δ̄(·, x)` 是 Li–Wang §2–§3 的
标准算子，本卡照抄为记号，见 gaps」。也就是说：**图内目前没有 `E^-`、`Δ̄` 的显式展开式**，
只有一个"占位记号"。这一点本轮**逐字重读该卡确认**（不是转述），见上面工具调用返回的原文。

### 2.3 `⟨analysis 2026-09-18⟩` 结构性判断：这不是"无源"，是"抽取不完整"

判断依据有三层：

**(a) Li–Wang 2008 是本项目已经深度使用的一手来源。** 图内已经从该论文抽出并逐字核对了
(3.5)–(3.8)（`ε` 的三条公理）、(3.9)（`V_(𝔥,L)` 的定义）、Definition 3.5（Condition C_L）、
Theorem 3.6（模构造，前后两半都已引用）、Proposition 3.9（不可约性）、(3.17)（`L°` 的刻画）、
Theorem 3.10、Proposition 3.11——这些编号结果分布在该文§2–§4，页码集中在 p.10–20（据图内
`loc` 字段）。`E^-`、`Δ̄` 是同一篇论文里、**紧挨着** (3.9)/(3.10) 之前（该文 §2–§3）就必须先
定义好的算子（(3.10) 的等式右边直接用到它们，任何读者要看懂 (3.10) 本身就必须先看懂 `E^-`、
`Δ̄` 的定义）——这不是"另一篇论文的另一个概念"，是**同一页数学论证链条上的上一步**。

**(b) 这类算子在格点顶点代数文献里的标准形式高度模式化，且与本项目物理侧公式在结构上
逐项对应。** 从 Frenkel–Kac (1980)、Segal (1981)、Borcherds (1986) 到 Frenkel–Lepowsky–Meurman
(1988) 再到 Li–Wang (2008)，构造格点顶点算子 `Y(e^α, x)` 的标准配方从未改变过：
"（创生指数）×（零模位移 `e^{α}`）×（单值化因子 `x^{⟨α,β⟩}`）×（湮灭指数）"，
其中创生/湮灭指数分别是
`exp(Σ_{n>0} (α(-n)/n) x^n)` 与 `exp(−Σ_{n>0} (α(n)/n) x^{-n})`
（或符号相反的等价写法，视作者的符号惯例）。本轮独立阅读的 Frenkel 1985
（见 §3，该文 (2.2)–(2.3)）与图内已经核实的物理侧 `E₋(b;z)`、`E₊(b;z)` 公式**逐项同构**：
把 Frenkel 的 `α(-n)` 换成本项目的 `α_{-l}`（同一物理对象，DDF 语境下的振子模），
两条公式的指数级数**逐项相同**（甚至符号约定都一致：产生模除以 `n`、湮灭模也除以 `n` 且带
负号）。**这强烈暗示 Li–Wang 的 `E^-(α,x)` 与本项目的 `E₋(b;z)` 是同一构造在不同论文里的
记号变体，`Δ̄(α,x)` 承担的是零模位移 + `x^{⟨α,β⟩}` 单值化因子的角色**（对应本项目里
`worldsheet.momentum-tower-fock-space` 单独处理的零模移位那一半）。

**(c) 真正需要补的不是"新概念"，是两件具体的抽取/核对工作：**
- **抽取任务 1**：把 Li–Wang 2008 §2–§3 里 `E^-(α,x)`、`Δ̄(β,x)` 的定义式**逐字**抄进图（补全
  `math.lattice-vertex-algebra` 或新立一张卡）。这是纯粹的文献抽取，`researcher`/`curator` 半天
  工作量。
- **抽取任务 2（更关键）**：(3.10) 写的是 `Y` 在 `V_(𝔥,L)`**自身**（真空模）上的作用；
  但本项目瓶颈节点需要的是 `Y` 在 **`U`-模** `V_(𝔥,L)(U) = ⊕_j e^{jk}⊗M(1,p̃)` 上的作用
  （`U = M(1,p̃)` 带非零动量 `p̃`）。Li–Wang Theorem 3.6 的**前半句**（构造模的那一半，
  图内已引用其"后半句"即模的良定义/不可约性，但**尚未抽取模作用的显式公式**）几乎肯定给出
  这个 twisted 版本的算子公式（这是任何"顶点算子代数的表示论"论文构造 `Y_W` 的标准步骤：
  先在真空模上定义 `Y`，再证明同一公式在**任意** `U`-模上有意义，通常靠把 `U` 上的零模作用
  换成 `p̃` 而不是 `α(0)|vac⟩=0` 完成）。**这条抽取一旦补上，候选 C 的两侧公式就可以逐项比对**
  ——一个是塔上模式指标的显式代数运算（图内已有，formalized），另一个是补全后的 (3.10)-twisted
  版本（同样是显式代数运算）。比对本身是**有限步初等计算**（形式幂级数系数比较，不涉及任何
  未解决的数学问题），一旦公式钉死，这一步可以由 `prover` 或 `curator` 直接在图内写一条
  `rigorous` 推导，**完全不需要"原创研究"**。

### 2.4 判定

**候选 C 不满足 `research/CLAUDE.md`/根 `CLAUDE.md` 的判据 4（确认无源可查）。**
它看起来像"文献里没人写过这句话"（图内笔记原话），但那是因为**图内自己对 Li–Wang 2008 的抽取
还没做完**，不是因为 Li–Wang 论文本身没写。这是 `researcher` 继续抽取 + `curator` 补卡 + （若
公式确认逐项相同）一条初等的、rigorous 的比对推导，**不是** `research/` 原创证明轨道的对象。

**`[GAP: E^-/Δ̄ 的显式公式与 twisted 模作用公式，本轮未独立打开 arXiv:0802.0173 重新抽取]`**——
本轮判断基于 (a)(b)(c) 三层结构性论证，**没有**重新读 Li–Wang 原文第 2–3 节确认 `E^-`、`Δ̄`
的逐字定义（这需要专门的 researcher 任务，超出本轮 scoping 的时间预算）。如果重新读图后发现
Li–Wang 的公式与本项目物理侧公式**不是**逐项对应（例如零模位移的归一化、`x^{⟨α,β⟩}` 因子的
指数约定、E^-/E^+ 的模指标偏移量不同），候选 C 仍然可能需要一条实质推导（哪怕只是"记号换算"
级别），但即便如此，那条推导的**输入**（Li–Wang 的显式公式）仍然是文献已有的，不构成
"原创数学"意义上的 `research/` 轨道对象——最多是一条需要小心记账的、`rigorous` 的"记号字典"
推导，性质与图内已有的许多"两套记号的字典"推导（如 `ddf-contour-equals-mode-sum` 本身）相同。

---

## 3. Frenkel 1985 的独立一手阅读（本轮新获得的能力：`Read` 工具可解析扫描版 PDF）

### 3.1 为什么读这篇：图内瓶颈节点笔记明文建议的路径 (i)

`worldsheet.physical-exponential-equals-voa-vertex-operator` 卡的笔记【怎么把本卡升上去】
第 (i) 条：「读 Frenkel 1985……若能 L1 读到它把物理正规序指数与顶点算子对应起来的段落，
本卡可直接升级」。该文献此前在项目登记里状态是**内容 L0**——
`literature/extractions/voa-residue-mode-sum-2026-09-15.md` 记录 researcher 当时用 `WebFetch`
抓取该文 PDF，"落盘 1.1 MB 但正文 OCR 极差，未能读图，无法逐字引任何公式号"。

### 3.2 本轮的技术突破：`Read` 工具直接解析 PDF 页面图像

本轮用 `curl -sL` 重新下载同一份 PDF（`cpb-us-w2.wpmucdn.com/campuspress.yale.edu/dist/2/3739/
files/2021/06/frenkel_representations_kac_moody.pdf`，`I.B. Frenkel, "Representations of
Kac–Moody Algebras and Dual Resonance Models", in Applications of Group Theory in Physics and
Mathematical Physics (Chicago, 1982), Lectures in Applied Mathematics vol. 21, AMS, 1985,
pp. 325–353`），确认为合法 15 页 PDF v1.4（1,185,011 字节），随后用本项目的 `Read` 工具
（`pages: "1-15"`）**直接读取 PDF 页面图像**——这与此前 researcher 使用的 `WebFetch`
（走 HTML/文本抽取管道，对扫描版 CCITT 传真编码 PDF 的 OCR 很差）是**完全不同的技术路径**，
本轮**成功获得全文 15 页的清晰内容**（原文 pp.325–353）。**评级为 `⟨lit, L1, Read-PDF⟩`**——
一手直接阅读，不是转述、不是摘要拼接。这是本轮任务对项目文献抽取能力的一个**可复用的
方法论发现**：以后遇到"WebFetch OCR 失败⟹L0"标记的扫描版 PDF，应先尝试
`curl` 下载 + `cygpath -w` 转 Windows 路径 + `Read(pages=...)`，而不是直接判定"无法获取"。

### 3.3 内容摘要（逐节，`⟨lit, L1, Read-PDF⟩`）

- **引言 (p.325–326)**：给出"顶点算子" `X(p,z)` 的雏形——对**连续**动量算符 `𝐩`
  的本征态 `|p⟩`（`[x^μ,p^ν]=iη^{μν}`，`𝐩^ν|p⟩=p^ν|p⟩`），定义
  ```
  X(p,z) = exp(p·Σ_{n≥1} (α(-n)/n) z^n) · exp(p·(p log z − ix)) · exp(−p·Σ_{n≥1}(α(n)/n) z^{-n})
  ```
  （原文 eq. (3)）。这**正是**本项目物理侧 `E₋(b;z)·（零模）·E₊(b;z)` 的**逐项同构**写法
  （创生指数、零模移位、湮灭指数三段结构完全一致，`α(-n)/n` 与 `α_{-l}/l` 记号仅字母不同）。
- **§1 Kac–Moody 代数与标准表示 (p.326–332)**：标准的仿射李代数最高权表示理论回顾。
- **§2 "Vertex representations of Kac–Moody algebras" (p.332–338)**：引言处的连续动量
  `p` **限制到根格 `Q`**（更一般地任何满足 `Q⊂Γ⊂P` 的格 `Γ`）时，同一个 `V`（此处记号复用，
  指 `S(𝔥^-)⊗ℂ[Γ]`）给出仿射李代数的标准表示；顶点算子写成
  `X(α,z) = exp(Σ_{n≥1}(z^n/n)α(-n)) exp(log z·α(0)+α) exp(−Σ_{n≥1}(z^{-n}/n)α(n))`
  （eq. (2.3)，`α∈Γ`）——**与引言 eq.(3) 是同一个构造，仅把连续 `p` 换成格点 `α`**。
  这一点原文**没有另外写一条"两者相等"的定理**去桥接——因为在 Frenkel 的叙述里它们从
  一开始就是同一个构造在不同的动量取值域上的实例，不存在需要架桥的两个独立对象。
  这与图内瓶颈节点面对的情况（"物理侧"与"VOA 侧"被**分别**构造，需要一条桥）**不同**：
  Frenkel 1985 因为写作时间早于 Borcherds/FLM 把"顶点算子公理化"，所以从未产生过这个
  裂缝——他的处理方式是"公式本来就只有一个"，而不是"证明两个公式相等"。
- **§3 标准表示的分解 (p.338–346)**：Kac–Moody 表示论的分支法则、Weyl–Kac 公式应用等。
- **§4 "The dual model in the critical dimension and hyperbolic algebras of rank 26"
  (p.346–350)**：这是与本项目无鬼定理链**最直接相关**的一节。
  - **Theorem 4.1（无鬼定理）**（原文逐字，`⟨lit, L1, Read-PDF⟩`）："Let `V` be a vertex
    representation of a hyperbolic Lie algebra `g`, then `V₁°` is a positive semidefinite
    space if and only if `rank g ≤ 26`"，附多步证明纲要：横向空间 `T(α,c)`；
    Lemma 4.2（正定性/交零/直和分解）；算子 `E`（由 `D(n)` 与 `L(n)` 构造，eq (4.7)）；
    Lemma 4.3（`E` 的特征向量张成 `S(α)`，特征值为非正整数，零特征空间恰在 `rank=26` 时
    等于 `T(α,c)`）；临界维数经对易子 `[L(n),E] = -nL(n) + (dim h - 26)/12·(n³-n)D(n)` 进入。
  - 应用于 Monster Lie 代数/Griess 代数（维数 196884）/McKay 观察/Conway–Norton 猜想/
    Garland–Kac 的部分构造；文末"Added in proof"提到 Lepowsky–Meurman–Frenkel **刚刚**
    构造出 `F₁` 表示（特征标 `j(q)-24`），"与偶模型在 D=26 的联系仍等待其解释"。
  - **DDF 型算子**：`A^i(n) = ∫_C α^i(z) X(nk,z) dz/z`（eq. (4)），其中 `X(nk,z)` 是
    eq.(2.3) 在**类光**格点 `nk` 处的取值——与图内 `worldsheet.ddf-contour-equals-mode-sum`
    卡引用的 `goddard-2008 (5.1)` 记号结构几乎相同（`A^μ_n = (1/2πi)∮P^μ(z)V(nk,z)dz`）。

### 3.4 `⟨analysis 2026-09-18⟩` 判定：Frenkel 1985 是否关闭瓶颈节点？

**不直接关闭，但提供了强历史/结构性佐证，且指出了图内瓶颈节点的一个"人为"性质。**

- Frenkel 1985 的构造方式说明：在**这篇历史源头论文**里，"物理正规序指数"与"格点顶点算子"
  从来就是**同一个公式**（eq (3) 与 eq (2.3)），从未被当作两个需要独立证明相等的对象。
  图内瓶颈节点存在的原因，是本项目**分两步**构造了这两个对象——先用
  `worldsheet.exponential-vertex-operator-modes`（纯物理侧记账，E₋E₊ 拆分）构造一个，
  再用 `math.lattice-vertex-algebra`/Li–Wang 的公理化 VOA 构造另一个——这在方法论上更严格
  （每一步都要有自己的编号来源），但**副作用**是产生了一条"两个独立构造的对象是否相同"的
  桥接命题，而这条桥接命题在 Frenkel 原始写法里根本不存在（因为他只写了一个公式）。
- 但 Frenkel 1985 **不能直接**作为"断言 (2)"的引用来源，原因有三：
  1. 他的 `V`（§2）建在**格点**动量 `α∈Γ` 上，而本项目的动量塔以**连续** `p` 为基点、
     只沿**一个**类光方向 `k_0` 离散移动（`p+Nk_0`）——这个"连续基点 + 单方向离散移位"的
     具体取法，Frenkel 原文没有单独处理（他考虑的是"全部动量都限制到格"或"完全连续"两种
     情形，没有"部分方向格化、部分方向连续"的中间情形）；这个中间情形恰恰是 Li–Wang (3.17)
     处理的（`L°` 只要求 `⟨k,λ⟩∈Z`，`λ` 不必落在格里）——**这再次指向 Li–Wang 而不是
     Frenkel 是补瓶颈节点的正确来源**（呼应 §2 的结论）。
  2. Frenkel 1985 全文没有出现"顶点代数"这个公理化概念（该概念 1986 年由 Borcherds 提出，
     晚于本文），故它不可能"逐字断言" `𝒴(e^{nk},z)`（一个公理化 VOA 结构映射的记号）
     等于任何东西——这个记号在 1985 年还不存在。
  3. δ-归一化、模的良定义性等本项目关心的细节，Frenkel 1985 全文没有触及（他工作在
     物理学家的"形式操作"层面，不做这类严格性记账）。

**结论**：Frenkel 1985 **不满足**瓶颈节点笔记路径 (i) 设想的"直接读到能让本卡升级的段落"——
它提供的是**为什么这条桥接在历史上从未被当作独立问题**的解释（因为原始构造是一体的），
但**不提供**本项目需要的、按现代 VOA 公理化记账方式写出的桥接证明。它作为**背景/历史动机**
很有价值（建议 researcher 后续把这次 L1 阅读正式登记进
`literature/extractions/`，把 `frenkel-1985` 的内容状态从 L0 升到 L1），但**不改变** §2 的
主判定：真正能关闭瓶颈节点的路径是**继续抽取 Li–Wang 2008**，不是 Frenkel 1985。

**`[GAP: FLM 1988 Ch.8 / Frenkel–Ben-Zvi §5，路径 (ii)，本轮未尝试重新获取]`**——瓶颈节点笔记
第二条建议路径本轮未执行。理由：`literature/sources.bib` 里 `flm-1988` 条目明文写「原书本轮
完全未获取——本条目的书目数据是 L1，内容全部是 L3」且有明确禁令"图里不得写「FLM,
Theorem 8.x」"；`math-sources.md §38.2` 记 Frenkel–Ben-Zvi 的定理号"全 L0"。这两本都是**书**
（非期刊论文），不像 Frenkel 1985 是一篇 15 页的会议论文集文章，重新用 `Read`-PDF 技巧获取
整本书的可行性未知（页数大、且这类数学专著的 PDF 扫描质量、版权可获得性都是未知变量）。
鉴于 §2、§3 已经把最合理的修补路径（Li–Wang 2008 继续抽取）钉得足够清楚，本轮判断**没有
必要**为了完备性再去花额外预算尝试获取 FLM/Frenkel–Ben-Zvi——即使成功读到，大概率只是
Li–Wang 同一构造的另一个措辞版本，不会改变 §2/§3 的结论方向。留给未来 researcher 视需要
再补。

---

## 4. 候选 D 补充分析：秩 1 → 秩 2 翻译的确切工作量与性质

`claim.md` §0.2 已指出结构性事实：本项目的动量塔是秩 1（单一类光方向 `k_0`），Borcherds 1992
Theorem 5.1 需要的是秩 2（`H = V ⊗ V_{II_{1,1}}`，`V_{II_{1,1}}` 是秩 2 洛伦兹偶自对偶格
`II_{1,1}` 的格顶点代数，`V` 是独立的 `c=24` 因子）。本节把"这需要多少新东西"具体化：

- **`math.lattice-vertex-algebra`（Li–Wang 存在性定理）本身对秩没有限制**——正文逐字
  "不要求 `L` 有限秩（有限秩只在 Li–Wang Remark 3.4 处作为额外假设出现）"，即定理**已经**
  覆盖秩 2 情形，不需要新的数学。真正要做的是**具体实例化**：取 `𝔥=ℂ^{1,1}`（或作为大
  `𝔥=ℂ^D` 的一个秩 2 子空间）、`L = II_{1,1}`（偶自对偶，非退化，`⟨α,α⟩∈2Z` 对全部 `α`
  自动成立因为自对偶偶格定义就是如此）、验证 `ε` 的 cocycle 条件（此时**不能**取 `ε≡1`，
  因为 `II_{1,1}` 非退化——这是本项目瓶颈节点"秩1类光⟹cocycle平凡"这条捷径**不适用**的
  地方，需要真正构造非平凡的 `ε`，即标准的"格顶点算子的 2-cocycle"构造，Borcherds 1986 §2
  或 FLM 1988 里都有现成配方）。
- **与独立 `c=24` 因子的张量**：Borcherds 1992 允许 `V` 是**任意**满足假设的向量空间——
  对 fake monster，`V = V(Λ)`（Leech 格 VOA，`c=24`，本身又是 `math.lattice-vertex-algebra`
  的另一个实例，秩 24，正定）；对真 Monster，`V = V^♮`（FLM 轨道化构造，同样 `c=24`，但
  **不是**格顶点代数，需要 `ℤ_2`-轨道化/扭模这一整套额外机器）。fake monster 路线在这一步
  比真 Monster 路线**便宜得多**：只需要再实例化一次 Li–Wang 定理（秩 24，Leech 格），
  不需要 FLM 轨道化。
- **总体判断（`⟨analysis⟩`，与 `formal/BLUEPRINT-moonshine-bridge.md` §3.1/§5 独立一致）**：
  fake monster 路线所需的全部数学工具（两次 Li–Wang 定理实例化：秩 2 `II_{1,1}` 与秩 24
  Leech 格；非平凡 cocycle 的显式构造；Borcherds 1992 Theorem 5.1 本身）**全部已经是发表
  数学**，没有一处是"文献查无证明"。这是一个大规模但纯粹的**形式化工程任务**（预估规模：
  至少是当前 `formal/NoGhost/` 全部代码量的数倍，因为要新增秩 2/24 格 VOA 构造、cocycle
  构造、张量积顶点代数结构——`formal/BLUEPRINT-moonshine-bridge.md` §5 判断 3 独立得出
  "多年级项目"的结论，本轮同意）。**不满足** `research/` 判据 4。

---

## 5. 候选 E 补充：为什么"物理解释"这一支仍然不可攻

Harrison–Paquette–Volpato 2018（`⟨lit, 待核⟩`，见 claim.md §0.3）末尾的"suggestion"——把
BKM 超代数的分母公式提升为时空 BPS 指标从而解释 Conway moonshine 的 genus-zero 性质——
是本轮找到的**唯一**一处文献本身也承认未完成的命题。但按判据 3（砖块合规）逐项核对：

1. **Conway 模 `V^{s♮}` 的完整超 VOA 构造**：Duncan–Mack-Crane 2015 已经**发表**这个构造
   （见 claim.md §0.3），但**图内没有登记**——不是"文献没有"，是"本项目没抽取"。要引用它
   作为 `research/` 证明的砖块，必须先有 `curator` 把它做成 rigorous 图节点；`research/`
   纪律禁止直接引用图外文献当作"已知"砖块（那等于绕过图的状态传播机制）。
2. **超弦 BRST 同调物理态刻画**：本项目 `worldsheet.no-ghost-theorem-v4` 及其全部下游链条
   （§0.1 的链）都是针对**玻色**弦（无鬼定理的 Goddard–Thorn 版本，DDF 算子建立在玻色
   `X^μ` 场上）。HPV 2018 用的是**手性超弦**（引入 `ψ^μ` 费米场、超 Virasoro、GSO 投影），
   这是完全不同的一套物理输入，图内**不存在任何超弦相关节点**（已用
   `grep -rli "superstring\|GSO\|super-Virasoro\|RNS" graph/statements/ graph/derivations/`
   风格检索确认——本轮未逐一列出结果，但整个 `worldsheet` area 目前只有玻色弦子图，这与
   `docs/ROADMAP.md`"当前阶段：形式化线...Goddard–Thorn 无鬼定理"的描述一致，无超弦条目）。
3. **"BPS 指标"与分母公式对应的精确数学表述**：HPV 2018 本身把这一步标记为"建议"，
   意味着**连文献自己都没有把它写成一条可核验的命题**——这不是"证明存在但本项目没读到"，
   是"这条命题在专业文献里目前就是猜测性的"。按判据 3+4 的联合判断：即使承认这是
   "查无证明"（判据 4 通过），证明它所需的三块砖（1）（2）（3）**没有一块**是图内
   rigorous/formalized 节点，且（2）本身是一整层缺失的基础设施（超弦形式化），规模与
   `worldsheet.no-ghost-theorem-v4` 整个岛相当。**判据 3 失败，且失败程度是"缺整层
   基础设施"级别**，与上一轮 umbral moonshine 候选 A/B 的否决理由性质相同。

---

## 6. 最终裁定与后续建议

### 6.1 三条候选的裁定汇总

| 候选 | 判据 1（精确到量词） | 判据 2（有终点线） | 判据 3（砖块合规） | 判据 4（确认无源可查） | 结论 |
|---|---|---|---|---|---|
| C（瓶颈节点算子恒等式） | 通过 | 通过 | 通过（两侧对象已定义/半定义，比对是有限步计算） | **失败**——源大概率在已登记的 Li–Wang 2008 里，抽取不完整 | 不可作为 `research/` 对象 |
| D（秩1→秩2翻译） | 可以写精确（"构造 `V_{II_{1,1}}` 并核实与 `V(Λ)`/`V^♮` 张量后满足 Thm 5.1 假设"） | 通过 | 通过（每一步都是 Li–Wang 定理的具体实例化，无未解决数学） | **失败**——纯粹是发表数学的工程实例化 | 不可作为 `research/` 对象（是 formalizer 的活） |
| E（moonshine 物理解释） | 可以写精确（HPV 2018 式子层面已有雏形） | 通过（分母公式≟BPS指标是可核验命题） | **失败**——三块基础设施图里全无 | 通过（HPV 2018 自己标"suggestion"） | 不可作为 `research/` 对象（缺整层基础设施，规模堪比另开一个无鬼定理岛） |

**没有一条候选同时通过全部四项判据。** 按任务书的判断标准，这构成一次诚实的"提不出来"交付。

### 6.2 与上一轮 `umbral-moonshine-origin` 的裁定性质对比

上一轮的否决理由主要是"缺整层基础设施"（候选 A：轨道化构造/mock 模形式论全无；候选 B：Zhu
定理这块砖本身不在图里）。本轮的否决理由**更细致、更具体**：

- 候选 C、D 的否决理由**不是**"缺基础设施"，而是**判据 4 本身失败**——文献已经把要用的
  数学写清楚了（Li–Wang 2008 之于候选 C；Li–Wang 存在性定理 + Borcherds 1992 之于候选 D），
  只是本项目**尚未抽取/实例化**。这是一个**更乐观**的发现：它把"任务不可攻"精化成了
  "任务不该由 `research/` 攻，该由 `researcher`/`curator`/`lean-formalizer` 攻"——即
  瓶颈节点 `worldsheet.physical-exponential-equals-voa-vertex-operator` 很可能可以在
  **不开研究轨道**的情况下，被一次 Li–Wang 2008 §2–§3 的继续抽取 + 一条初等的逐项系数比对
  推导直接升级为 `rigorous`。
- 候选 E 的否决理由与上一轮候选 A/B 同构（缺整层基础设施），但本轮把"整层基础设施"的
  具体清单钉得更细（超弦 BRST 层 + `V^{s♮}` 轨道化构造 + BPS-指标数学定义，三层分别列出）。

### 6.3 给后续 agent 的具体建议（本轮不执行，仅指路）

1. **【最具体、最可执行、优先级最高】** 一个 `researcher` 任务：重新打开 Li–Wang 2008
   （arXiv:0802.0173）§2–§3，逐字抽取 `E^-(α,x)`、`Δ̄(β,x)` 的定义式，以及 Theorem 3.6
   证明中 `Y` 在 `U`-模 `⊕_j e^{jk}⊗M(1,p̃)` 上作用的显式公式（即 twisted 版本的 (3.10)）。
   抽出后，`curator` 补全 `math.lattice-vertex-algebra` 卡（或新立子卡），随后可能由
   `prover` 或 `curator` 直接写一条 `rigorous` 推导，把公式与图内已 `formalized` 的
   `worldsheet.exponential-vertex-operator-modes` 逐项比对，尝试关闭瓶颈节点
   `worldsheet.physical-exponential-equals-voa-vertex-operator`。**这不是本轮 `research/`
   轨道的产出，是留给下一个 `researcher`/`curator` 回合的具体任务。**
2. **【次优先级，纯登记工作】** `curator` 可以把 Duncan–Mack-Crane 2015（Conway moonshine
   模的存在性）和 Harrison–Paquette–Volpato 2018（超弦 BRST ⟹ Conway BKM 超代数）登记为
   图内节点——它们都是已发表定理，属于常规 curator 抽取流程，不是 `research/` 对象。
   若船长希望项目未来某天覆盖 monstrous/Conway moonshine 的完整链条，登记这两个节点是
   自然的起点（但需要先有超弦 BRST 层的图基础设施，规模不小，是独立的 roadmap 决策）。
3. **【文献登记维护】** 本轮用 `Read` 工具直接解析 PDF 页面图像的方式一手读完了 Frenkel
   1985（15 页全文），建议 `researcher` 把这次阅读正式登记进 `literature/extractions/`，
   把 `frenkel-1985` 的内容状态从 L0 升到 L1（书目数据本来就是 L1，内容此前是 L0/L3）。
   同时建议在 `literature/` 层面记录这次方法论发现：遇到"WebFetch OCR 失败⟹L0"标记的
   扫描版 PDF，应先尝试 `curl` 下载到本地 + 路径转换 + `Read(pages=...)`，而不是直接
   判定"无法获取"——这对项目里其他类似标记的历史文献（如 FLM 1988）可能同样有效。
4. **不建议**在近期开一条新的 `research/` 轨道专门攻 monstrous/Conway moonshine 的任何
   子问题——本轮排查的三条候选都不满足判据，且没有发现第四条更有希望的候选。如果未来
   Li–Wang 抽取完成、秩 2 翻译完成、超弦 BRST 层建立起来，届时"分母公式⟹BPS指标"这条
   （候选 E 的核心）可能重新变得可攻——但那是数年后、依赖大量前置形式化工作完成之后的事。
