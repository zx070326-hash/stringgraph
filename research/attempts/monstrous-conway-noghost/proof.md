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
