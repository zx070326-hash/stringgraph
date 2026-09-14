# 抽取记录：voa-residue-mode-sum（专题）——「围道 DDF 算子 = 模态和」在 VOA 数学文献里是否已严格证明

- 专题：`worldsheet.ddf-contour-equals-mode-sum`（现 effective = physical-argument）断言
  `(1/2πi) ∮ ε·P(z) V(n k_0, z) dz = Σ_{m∈Z} α^ε_m V^{(n)}_m`（= Lean 的 `ddfOp`）是否在
  顶点代数（VOA）数学文献里已有严格证明。
- 抽取者：researcher
- 日期：2026-09-15
- 覆盖范围：本仓库已 L1 核实的 VOA 材料的**重新定向复用**（不是新读文献），主要是
  - `literature/extractions/math-sources.md` §10–§11A（Kac / Schottenloher 第 10 章，形式留数与正规序积）、§36–§37（Li–Wang / Gebert–Nicolai / Bakalov–Kac 的格点顶点代数）；
  - `literature/extractions/gsw-1987-v1.md` §4（Gebert–Nicolai 1995 的 **§3.1「DDF vertex operators」逐字**，E14/E15/E18）。
  这些段落此前是为「无鬼定理链」「[L_m,A]=0」「对易子公式」抽取的，本专题第一次把它们对准**围道 = 模态和**这条缝。
- 结论先行（也在最终回复里给船长一句话）：**裁定 (A) 文献可闭合**。见文末 §裁定。

> 方法说明：本专题**没有**打开任何新 PDF 读图；引用的每条 VOA 公式都指向本仓库已有抽取记录里
> 标了 L1 的位置，等级沿用（转引记为 L1↩，即「他人 L1、本轮未重读原图」）。唯一新登记的文献
> `frenkel-1985` 的**内容**是 L0（见 §bib）。凡本轮自己的推断，均显式标「researcher 推断」。

---

## 背景：这张卡到底缺哪一步（先精确化问题）

卡的左端 `(1/2πi)∮ ε·P(z) V(n k_0,z) dz` 是**两个算子值场在同一点 z 的乘积**的形式留数（取总 z^{−1} 系数）；
右端 `Σ_m α^ε_m V^{(n)}_m` 是**全部**振子模 α^ε_m（含湮灭 m>0 与产生 m<0，**未正规序**）与顶点算子模 V^{(n)}_K 的卷积。
卡自己把关键缺口逐字定位为（`--via-laurent-coefficient-extraction` 的 gaps）：

- **gap #1**：第 3 步「两个形式级数逐项相乘并按 z 幂次重排，且这在**算子**层面成立」在图中无严格承载；最近的近亲
  `worldsheet.ope-pole-mode-commutator-dictionary`（形式分布版）自身 effective = open。
- **gap #3**：`:e^{i n k_0·X}: = Σ_K V^{(n)}_K z^K` 只是记号约定，正规序 ⟹ E₋E₊ 拆分「两者未被对接」。
- **gap #4**：「横向性 ε·k_0 = 0 使两因子无缩并、同点乘积良定义」**被卡标为「本项目的解读，文献未逐字如此说」**。

下面逐条对照 VOA 文献。**核心发现：gap #4 已被 Gebert–Nicolai 1995 (3.3) 逐字推翻，gap #1 与 gap #3 的严格承载
在 VOA 形式演算里都是带编号的定理/定义，且本仓库已 L1 到手。**

---

## Q1 形式留数演算的严格性：`a_(n)=Res_z z^n Y(a,z)` 与「两场乘积的模由形式留数给出、逐项重排合法」是否带证明？

**答：是，且是初等/定义层面的严格结论，本仓库已 L1 到手三处独立带编号来源。** 分两半：

### (1a) 「模 = 留数」`a_(n) = Res_z z^n Y(a,z)`（tautology 级）

| 来源 | 精确定位 | 逐字 | 等级 |
|---|---|---|---|
| `schottenloher-2008` | Ch. 10, **Definition 10.1**, 书 p.173 | `Res_z A(z) = A_{−1}` | L1↩（math-sources.md §11.1） |
| `schottenloher-2008` | Ch. 10, 书 p.177 记号段 | `A_{(n)} = A_{−n−1} = Res_z A(z) z^n` | L1↩（math-sources.md §11A.1(b)） |
| `gebert-nicolai-1995` | **(2.16)/(2.17)**, 刊 p.580 一带 | `Res_z[w(z)] = w_{−1}`；`w_n = Res_z[z^{−n−1} w(z)]` | L1↩（math-sources.md §37.3 末） |

这是形式分布演算里 residue 的**定义**加模的定义，非平凡内容为零。**严格。**

### (1b) 「两场之积（正规序积）是良定义的场，其模由留数/卷积给出，逐项重排合法」

关键：一般地两个形式分布 `A(z)=ΣA_m z^{−m−1}`、`B(z)=ΣB_K z^K` 的**同点乘积**的某个幂次系数是**无穷卷积** `Σ_m A_m B_{K−m}`，
要成为算子必须逐向量有限（局部有限）。VOA 用两条机制保证：

| 机制 | 来源 | 精确定位 | 内容 | 等级 |
|---|---|---|---|---|
| **场公理 / 正规性**（局部有限性的公理根据） | `gebert-nicolai-1995` | **(2.32) Regularity 公理**, 刊 p.579 | `ψ_n φ = 0` for n large；正文逐字「any finite occupation number state φ is killed by a finite but large enough number of annihilation operators contained in (the normal ordered expression) ψ_n」 | L1↩（gsw-1987-v1.md §4 E18 备注） |
| 同上（数学书版） | `schottenloher-2008` | **Definition 10.12（Field）**, 书 p.181 | `∀v ∃n₀, a_{(n)}v = 0 for n ≥ n₀` | L1↩（math-sources.md §11.1 表） |
| **正规序积是良定义的形式分布** | `schottenloher-2008` | **Definition 10.9**, 书 p.178 | `:A(z)B(w): := A(z)_+ B(w) + B(w)A(z)_−`，且 `A(z)B(w) = [A(z)_−,B(w)] + :A(z)B(w):`；给出模式卷积形式 `Σ_{m<0}A_{(m)}B_{(n)} + Σ_{m≥0}B_{(n)}A_{(m)}` | L1↩（math-sources.md §11A.2） |
| **无奇异部分时 普通积 = 正规序积**（即卷积良定义、逐项重排合法） | `schottenloher-2008` | **Theorem 10.10** 第 4 条（取 N=0）, 书 p.178 | `A(z)B(w) = Σ_{j=0}^{N−1} i_{z,w}(z−w)^{−(j+1)} C^j(w) + :A(z)B(w):`；N=0（无奇异项）⟹ `A(z)B(w) = :A(z)B(w):` | L1↩（math-sources.md §11.3） |
| **合成场的模 = 分量场模的 n 次积**（把「零模」翻回卷积） | `bakalov-kac-2004` | **(2.22)**, p.9 | `Y(a,w)_{(n)}Y(b,w) = Y(a_{(n)}b, w)`（取 n=−1 即正规序积 = `Y(a_{(−1)}b,w)`） | L1↩（math-sources.md §37.4(a)） |

**小结 Q1**：本项目 gap #1 说的「逐项相乘 + 按幂次重排 + 算子层面成立」，在 VOA 形式演算里**恰好由
Def 10.9 + Thm 10.10（N=0）+ 场公理/正规性 (2.32) 承载**，是带编号的定义与定理，**全部 L1 到手，全程无收敛性假设**
（Schottenloher 的 "Analytic Aspects" 段逐字点明整章停在形式级数层面，`i_{z,w}/i_{w,z}` 只是把有理函数展开成级数的两种选择，
不是解析收敛，见 math-sources.md §11.3、§11A.1）。
⇒ **gap #1 在 VOA 侧不是 open，而是标准结果；图里之前挂在 open 的 `ope-pole-mode-commutator-dictionary` 只是没建对的桥。**

---

## Q2 DDF 型算子的具体处理：文献是否**直接**把 `∮ ∂X^i e^{ink_0X}` 写成模态和/零模并证等价？

**答：是。Gebert–Nicolai 1995 §3.1「DDF vertex operators」逐字给出，且本仓库已 L1 核实。这是本专题最重要的发现。**

| 来源 | 精确定位 | 逐字（关键三行） | 等级 |
|---|---|---|---|
| `gebert-nicolai-1995` | **§3.1「DDF vertex operators」, 刊 p.593, eq. (3.2)–(3.3)** | (3.2) `A^ξ_m := (ξ(−1)e^{mk})_0`；(3.3) `= Res_z[𝒴(ξ(−1)e^{mk}, z)] = Res_z[ξ(z) 𝒴(e^{mk}, z)]`，正文续「**where normal ordering in the last line is unnecessary due to ξ·k = 0**」 | **L1↩（gsw-1987-v1.md §4 E15，标「[L1 已核实]」）** |

逐条对应本卡：

- **本卡左端** `(1/2πi)∮ ε·P(z) V(nk_0,z) dz` = GN 的 `Res_z[ξ(z) 𝒴(e^{mk}, z)]`：
  GN 的 `ξ(z) = 𝒴(ξ(−1), z) = Σ_l (ξ·α_l) z^{−l−1}` 就是物理的 Heisenberg 流 ε·P(z) = ∂X^ε；
  GN 的 `𝒴(e^{mk}, z)` 就是本卡的 `V(n k_0, z) = :e^{i n k_0·X}: c_r`（相差一个 cocycle，见 Q4）；`Res_z = (1/2πi)∮ dz`。
- **本卡右端** `Σ_m α^ε_m V^{(n)}_m` = GN 的**零模** `(ξ(−1)e^{mk})_0`：
  由 (3.2) 定义，A^ξ_m 是合成态 `ξ(−1)e^{mk}`（权 1 primary，因 ξ(−1) 加权 1、e^{mk} 权 ½(mk)²=0）
  的顶点算子 `𝒴(ξ(−1)e^{mk},z)=Σ_n(·)_n z^{−n−1}` 的第 0 号模；
  由 **Bakalov–Kac (2.22)**（取合成态 `ξ(−1)e^{mk} = (ξ(−1))_{(−1)}e^{mk}`）该合成算子 = 正规序积 `:ξ(z)𝒴(e^{mk},z):`，
  取零模（Res_z）即卷积 `Σ_l α^ε_l V^{(m)}_{...}`。
- **等价「Res of product = zero mode = 卷积模态和」正是 (3.3) 的两个等号**，GN 逐字写出，非「留给读者」。

⇒ **Q2 的答案不是「文献只给一般 VOA 模乘积、把 DDF 当特例留给读者」，而是「文献（GN §3.1）直接把横向 DDF 算子
写成 `Res_z[ξ(z)𝒴(e^{mk},z)] = 零模`，并逐字用 ξ·k = 0 说明为何不必正规序」。** 历史源头是 Frenkel 1985（见 §bib，内容 L0 未核实）。

---

## Q3 横向性 ε·k_0 = 0 与类光性 k_0² = 0 的作用：本项目的解读与文献一致，还是本项目推断？

### (3a) 横向性 ε·k_0 = 0 —— **本项目此前标「文献未逐字说」的 gap #4，现被 GN (3.3) 逐字推翻**

- 本卡 notes【横向性在本卡中的角色】与推导 gap #4 写：「横向性使 ε·P 与 :e^{ink_0X}: 无缩并、同点乘积良定义……
  **这一段是本项目的解读，文献未逐字如此说**」。
- **GN (3.3) 正文逐字**：`= Res_z[ξ(z)𝒴(e^{mk},z)], where normal ordering in the last line is unnecessary due to ξ·k = 0.`
  （gsw-1987-v1.md §4 E15，L1↩）。
  ⇒ **文献确实逐字说了**：横向性 ξ·k = 0（= 本卡 ε·k_0 = 0）正是「同点乘积不需要正规序处方」的理由。
  **本项目的解读与文献一致，gap #4 应从「本项目推断」改为「有 L1 来源」。**
- 一处细化（researcher 推断，供 auditor 记账）：GN 说的是「不必**正规序**」，本卡 v6 说的是「模态和**局部有限**」。
  这是同一条件（无奇异 OPE）的两副面孔：无奇异 OPE ⟹ 普通积 = 正规序积（Thm 10.10 N=0）⟹ 卷积逐项有限（场公理 (2.32)）。
  gsw-1987-v1.md §4 E15 备注已提示「两者不是同一件事，勿混」——**严格地它们由 Thm 10.10 相连，不是同义反复**，
  故图里若把这两句都用，中间那一步（无奇异 ⟹ 普通积=正规序积）应显式引 Schottenloher Thm 10.10。

### (3b) 类光性 k_0² = 0 —— 用在**塔/模结构与整数指标**，不在留数抽取那一步

- GN (3.1)/(3.3) 用 k·k = 0 保证 cocycle `ε(mk,nk) = (−1)^{½mnk²} = 1`（秩 1 类光 ⟹ 无 cocycle 麻烦），
  以及 `k(−1)e^{nk} = (1/n)L_(−1)(e^{nk}) ≡ 0`（n≠0）。**这是 (3.4) 对易子那一步用的，不是 (3.3) 留数=模态和那一步。**
- 本卡把 k_0² = 0 用在第 2 步「V^{(n)}_K 的**整数**指标」：单值因子 `z^{2α' n k_0·(p+Nk_0)}` 因 k_0²=0 与层数 N 无关，
  再由 (S) 2α' k_0·p = 1 等于 z^n。这与 **Li–Wang** 的整性条件 (I) `⟨k, p̃⟩ = 2α'(k_0·p) ∈ Z`
  （`worldsheet.free-boson-vertex-algebra-with-lightlike-momentum-tower` 已 L1 承载，Li–Wang (3.17)/Thm 3.10）**是同一条**。
  ⇒ **k_0²=0 与 (S) 的作用是「让动量塔成为 VOA 的模、让顶点算子模是整数指标」，与本卡第 2 步一致，非留数步骤所需。**
- 结论 Q3：**横向性 ε·k_0=0 的作用与文献逐字一致（GN 3.3）；类光性 k_0²=0 的作用与文献一致（GN cocycle + Li–Wang 整性），
  但它作用在模结构那一层，不在「留数 = 模态和」那一步。** 本项目对二者作用的解读**与文献一致，不是无源推断**。

---

## Q4 差距评估：抽象 VOA（一般模乘积 / Heisenberg-格 VOA）与本项目具体对象之间隔多远？

**答：主要是「记号翻译 + 一条桥接边（物理算子 ↔ VOA 形式顶点算子）」，不是实质补证。** 逐项：

| 本项目对象 | VOA 对应物 | 隔多远 | 是否 inferred |
|---|---|---|---|
| 右端模态和 `A^ε_n = Σ_m α^ε_m V^{(n)}_m`（Lean `ddfOp`） | GN 的零模 `(ξ(−1)e^{mk})_0` = 卷积（Bakalov–Kac (2.22) n=−1 + Def 10.9） | 记号翻译（z^K 系数约定 vs 𝒴(ψ,z)=Σψ_n z^{−n−1}，差一个共形权移位，图里已在 v6 / exponential-vertex-operator-modes 追踪） | 否 |
| 左端围道 `(1/2πi)∮ε·P·V dz` | GN 的 `Res_z[ξ(z)𝒴(e^{mk},z)]`（(3.3)） | 逐字同一（形式留数读法下） | 否 |
| 「同点乘积良定义、逐项重排」 | Def 10.9 + Thm 10.10(N=0) + 场公理 (2.32) | 标准定理，L1 | 否 |
| 动量塔 `T(p;k_0)=⊕_N F(p+Nk_0)` 是 ε·P、𝒴(e^{mk}) 作用的空间 | `worldsheet.free-boson-vertex-algebra-with-lightlike-momentum-tower`（Li–Wang Thm 3.6，图内 **rigorous**，桥接边非 inferred） | 已有 rigorous 图节点 | 否 |
| **物理 `:e^{i n k_0·X(z)}:` = VOA `𝒴(e^{n k_0}, z)`（秩 1 类光 ⟹ cocycle 平凡）** | GN (2.95)/(2.98) `𝒱(e^r,z) = :e^{ir·Q(z)}: c_r`；秩 1 类光时 c_r=1 | **一层桥接**，与 free-boson 卡的边界 (N6) 同一件事 | **是（inferred）** |

- 唯一实质的**残留 inferred 边**：**物理正规序指数与 VOA 格点顶点算子的逐字对应**（含「秩 1 类光 ⟹ 扭群代数退化为普通群代数、cocycle=1」）。
  这**正是** `worldsheet.free-boson-vertex-algebra-with-lightlike-momentum-tower` 的边界 (N6) 已登记的那条边，
  也是 math-sources.md §36.5 末标 `inferred: true` 的那一步（「此特例下扭群代数 = 普通群代数」）。
  GN 自己在 (3.1) 逐字写 `ε(mk,nk)=1`，所以这条边**几乎闭合**，但「物理 :e: 与 VOA 𝒴(e) 是同一算子」这一句
  仍无单一来源逐字断言 ⇒ 图里保持 inferred。
- 结论 Q4：**隔的是「记号翻译」加「一条已在别处登记的 inferred 桥」，不是「实质补证」。** 本卡具体形式的每一步都能落到
  带编号的 VOA 结果或图内已有 rigorous 节点上。

---

## 裁定：**(A) 文献可闭合**

VOA 文献（尤其 Gebert–Nicolai 1995 §3.1 (3.2)–(3.3)，直接把横向 DDF 算子写成 `Res_z[ξ(z)𝒴(e^{mk},z)] = 零模`，
并逐字用 ξ·k=0 说明不必正规序）已严格给出本卡等价；配合 VOA 形式留数演算（Schottenloher Ch.10 Def 10.1/10.9/Thm 10.10、
Bakalov–Kac (2.22)、GN 正规性公理 (2.32)）与图内已 rigorous 的「动量塔是 Li–Wang 意义下的 VOA 模」卡，
**本卡可加一条 `status: rigorous` 的推导**。

### 该 rigorous 推导应引的精确来源（供 curator；researcher 不改 graph/）

1. **直接源（承载「围道 = 零模 = 留数积」这句话本身）**：
   `gebert-nicolai-1995`，**§3.1「DDF vertex operators」, 刊 p.593, eq. (3.2)–(3.3)**
   （loc: `§3.1, p.593, eq. (3.2)–(3.3)`；抽取 gsw-1987-v1.md §4 E15；L1）。
2. **形式留数 = 模、正规序积良定义、无奇异 ⟹ 普通积=正规序积**：
   `schottenloher-2008`，**Ch. 10, Definition 10.1 (p.173)、Definition 10.9 (p.178)、Theorem 10.10 (p.178)**
   （math-sources.md §11、§11A；L1；⚠ Thm 10.10 第 5 条印本下限 j=1 是排印错误，本步只用第 1/4 条，不涉及）。
3. **合成场的模 = 分量场模的卷积（把「零模」翻回模态和）**：
   `bakalov-kac-2004`，**(2.22), p.9**（math-sources.md §37.4(a)；L1）；
   备源 `gebert-nicolai-1995` **(2.16)/(2.17)** 模=留数、**(2.32)** 正规性公理（局部有限性）。
4. **动量塔是自由玻色/格点 VOA 的模（两个场作用的空间、模就是 α^ε_m 与 V^{(n)}_K）**：
   图内 `worldsheet.free-boson-vertex-algebra-with-lightlike-momentum-tower`（rigorous，Li–Wang Thm 3.6/3.10/(3.17)）
   + `worldsheet.ddf-transversality-gives-local-finiteness-v2`（formalized，局部有限性）。

### 仍须 inferred 的那条边（务必显式标）

- **物理 `:e^{i n k_0·X(z)}:` = VOA `𝒴(e^{n k_0}, z)`（秩 1 类光 ⟹ cocycle 平凡）** —— 标 `inferred: true`，
  note 指向 `free-boson-vertex-algebra-with-lightlike-momentum-tower` 的边界 (N6) 与 math-sources.md §36.5 末。
  这就是任务书预判的「本项目 Fock 塔 ↔ VOA 模结构的桥接」。**除此之外的每条边都可非 inferred。**

### 附带订正（curator 建新推导时应一并修）

- 现推导 `--via-laurent-coefficient-extraction` 的 **gap #4「横向性使两因子无缩并……文献未逐字如此说」已过时**：
  GN (3.3) 逐字说了（"normal ordering … unnecessary due to ξ·k = 0"）。新 rigorous 推导应把它从 gap 升为 **(3.3) 的正文引用**。
- **gap #1「重排在算子层面无论证」**在 VOA 侧由 Def 10.9 + Thm 10.10(N=0) + (2.32) 承载，**不再是 open**；
  旧推导把它挂在 open 的 `ope-pole-mode-commutator-dictionary` 上是「没建对桥」，非真缺口。
- **gap #3「:e: = ΣV^{(n)}_K z^K 未对接」**收敛为 Q4 的那条 inferred 桥（物理算子 ↔ VOA 顶点算子），不再是独立缺口。
- 保留的真限制：围道语义（形式留数 vs 复平面真积分，本卡取前者，gap #2 保留）、k_0·p=0 扇区不覆盖（gap #6 保留）。

> ⚠ 是否**保留** physical-argument 版旧推导：建议保留（它锚定文献的**围道写法**逐字来源 goddard-2008 (5.1)），
> 新加的 rigorous 推导锚定**VOA 侧**的 (3.3)。两条推导并存，卡的 effective 取 max，升为 rigorous。
> 这是 curator/lead 的裁量，researcher 只给来源，不改 graph/。

---

## bib 变更（只碰 literature/）

**新增一个 key**（历史直接源，供未来直接抽取以消掉那条 inferred 桥）：

- `frenkel-1985` = I. B. Frenkel, *Representations of Kac–Moody Algebras and Dual Resonance Models*,
  in *Applications of Group Theory in Physics and Mathematical Physics* (Chicago, 1982),
  Lectures in Applied Mathematics **vol. 21**, American Mathematical Society, Providence, R.I., 1985, pp. 325–353。
  - **获取**：公开 PDF（作者主页镜像）`https://cpb-us-w2.wpmucdn.com/campuspress.yale.edu/dist/2/3739/files/2021/06/frenkel_representations_kac_moody.pdf`
    （2026-09-15 WebFetch 落盘 1.1 MB；扫描件 CCITT 传真编码，**正文 OCR 极差**）。
  - **等级**：书目 L1（标题页/页码/系列已确认）；**内容 L0（未能读图，本轮无法逐字引任何公式号）**。
  - **用途**：这是「把 DDF 算子当作顶点算子」的**历史源头**（GN 1995、FLM 等都上溯到它）；
    §4 标题「The dual model in the critical dimension and hyperbolic algebras of rank 26」正是 DDF/无鬼语境。
    **若日后 L1 读到它把横向 DDF 写成顶点算子模的段落，可望把 Q4 那条 inferred 桥升为有据。**
    ⚠ **注意与既有 key 区分**：`frenkel-1986` 是 FGZ（Frenkel–Garland–Zuckerman）的别名，**不是**本文；本文的 key 是 `frenkel-1985`。

**无需新增**：Schottenloher、Kac、Gebert–Nicolai、Bakalov–Kac、Li–Wang、Borcherds、FLM 均已在 `sources.bib`
（keys：`schottenloher-2008`、`kac-1998`、`gebert-nicolai-1995`、`bakalov-kac-2004`、`li-wang-2008`、`borcherds-1986`、`flm-1988`）。

---

## 未解决的疑问 / 未核实项（诚实登记）

- **GN §3.1 (3.2)–(3.3) 的 L1 是转引**（gsw-1987-v1.md §4 E15 标「[L1 已核实]」，本轮未重开 PDF 复核页图）。
  curator 若要把它写进 rigorous 推导的 `sources`，可直接沿用该抽取的 L1（同一 researcher 团队本仓库记录），
  但若 auditor 要求，应重开 `pure.mpg.de/rest/items/item_153125_1/component/file_153124/content` 读刊 p.593 复核。
- **Frenkel 1985 内容 L0**：本轮 OCR 失败，未能逐字确认它是否把 DDF 写成留数=模态和。**不得**据它写任何公式号。
- **Bakalov–Kac (2.22) 是「场版 n 次积」`Y(a,w)_{(n)}Y(b,w)=Y(a_{(n)}b,w)`**；把它翻成「零模 = 卷积模态和」
  用的是 n=−1 特例 + 取 Res_w，这一步（researcher 推断）是标准的，但 Bakalov–Kac 没有逐字写出「模态和」形式；
  真正逐字写「零模 = Res of product」的是 GN (3.3)，故直接源以 GN 为准，Bakalov–Kac/Schottenloher 作机制来源。
- 未查 **FLM 1988 Ch. 8**（自由玻色/格点顶点算子的显式积）与 **Frenkel–Ben-Zvi §5**：它们大概率也含等价内容，
  但本仓库对二者的定理号一律 L0（math-sources.md §38.2），本轮不据它们下任何断言。裁定 (A) 不依赖它们。
