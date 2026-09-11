# 抽取记录：prior-formalizations（先行形式化工作扫描）

- 文献：多篇（见下），**不是单篇抽取记录**；这是为论文「先行工作 / Related work」节做的**形式化现状扫描**
- 抽取者：researcher agent（agora `researcher`）
- 日期：2026-09-11
- 覆盖范围：Mathlib 4 master / Lean 社区项目 / Isabelle AFP / Coq-Rocq / Agda / Mizar / arXiv 形式化论文 / 方法论对照项目
- 目的：确定本项目 `formal/StringFormal/**` 里哪些声明可以宣称**首次形式化**

## 方法与限制（必读）

- **本次 WebSearch 额度在任务开始前已被同会话前序任务耗尽（200/200）**，全部检索改走
  已知 URL 的 WebFetch + 各站 API。后果：**「搜不到」这类否定结论的强度分两档**：
  - **强否定（可写进论文）**：来自*完整目录列举*或*项目自己的 README/TODO*。例如
    「`Mathlib/Algebra/Lie/` 的 46 个条目里没有 Virasoro」是完整列举。
  - **弱否定（论文里只能写「未发现」）**：来自关键词式 API 查询。例如 Zulip 全站搜索、
    GitHub code search、grep.app 本次都**未能执行**（见「已尝试但失败的入口」）。
- 本文件是对 `formal/NOTES-virasoro-reuse.md`（2026-09-10，lean-formalizer 写）的**独立复核与扩展**。
  复核结论：该文件关于 Mathlib 与 Kytölä 的记述**本轮全部复现，无需订正**；新增的是
  Carnahan 个人项目、AFP/Coq/Agda/Mizar、arXiv 论文、方法论对照四块。

## 已尝试但失败的入口（下一个人不必重试）

| 入口 | 结果 |
|---|---|
| `WebSearch`（任何查询） | 会话额度 200/200 用尽，**本轮一次都没跑成** |
| `grep.app/api/search?q=Virasoro&filter[lang][0]=Lean` | **HTTP 429**（两次，间隔重试无效） |
| `api.github.com/search/code` | 需要认证，本环境无 `gh` |
| `leanprover.zulipchat.com` 搜索 | 需登录；公开 archive 需要先有检索能力才能定位帖子 ⇒ **本轮未执行**（≠ 失败） |
| `raw.githubusercontent.com/.../Mathlib.lean` | 取到了，但摘要器自报**内容被截断** ⇒ 只当旁证，不当主证据 |

---

## 1. Mathlib 4（master，读取日期 2026-09-11）

### 1.1 完整目录列举（强证据）

| 目录 | 本轮读到的全部条目 | 结论 |
|---|---|---|
| `Mathlib/Algebra/Vertex/` | **只有 2 个文件**：`HVertexOperator.lean`（5495 B）、`VertexOperator.lean`（3615 B） | 无 `VertexAlgebra` class |
| `Mathlib/Algebra/Lie/` | 46 个条目（39 文件 + 7 子目录），含 `Cochain.lean`、`Extension.lean`、`Loop.lean`、`SerreConstruction.lean`、`UniversalEnveloping.lean`、`Killing.lean`、`Sl2.lean`、`Weights/` | **无 Virasoro、无（Lie 意义的）Witt、无 Verma、无 highest-weight 模** |
| `Mathlib/RepresentationTheory/` | 19 文件 + 4 子目录（`Action`、`Character`、`FDRep`、`Induced`、`Maschke`、`Tannaka`…） | **无 Verma** |

入口：`api.github.com/repos/leanprover-community/mathlib4/contents/<path>`（免认证可用）。

### 1.2 `VertexOperator.lean` 的 TODO 逐字（强证据，本轮独立复核）

文件头 `Copyright (c) 2024 Scott Carnahan`。Definitions 段只有两条：
`VertexOperator`（= `HVertexOperator ℤ R V V`）与 `VertexOperator.ncoeff`。
**TODO 段逐字三条**：

- `` `HasseDerivative` : A divided-power derivative. ``
- `` `Locality` : A weak form of commutativity. ``
- `` `Residue products` : A family of products on `VertexOperator R V` parametrized by integers. ``

References 段点名 Mason 2017 与 Matsuo–Nagatomo 1997（= `arXiv:hep-th/9706118`）。

⇒ **Mathlib 里的「顶点代数」目前只是「顶点算子 = 到 Laurent/Hahn 级数的线性映射」这一层，
locality 与剩余乘积都还在 TODO。**（注意：检索后端曾把 TODO 段误报成 Definitions 段，
见 `researcher` 记忆 `lit-ope-vertex-algebra-numbered-theorems`。必须读源文件。）

### 1.3 官方「未形式化」登记

`raw.githubusercontent.com/leanprover-community/mathlib4/master/docs/1000.yaml` 中
`Q2270905: Poincaré–Birkhoff–Witt theorem` **有 `title` 但没有 `decl`/`authors`/`date` 字段**
（2026-09-11 前一轮核实，本轮未重取）⇒ 这是 Mathlib 官方口径的「未形式化」记录，
比「我 grep 了没看到」强得多。

### 1.4 `Mathlib.lean` 导入表关键词扫描（弱旁证，内容被截断）

对 `Virasoro` / `Verma` / `Heisenberg` / `Fock` / `Witt` / `Kac` / `HighestWeight` 均报 none；
只有两条含 `Vertex`（即 1.1 那两个文件）。⚠ 摘要器自报内容被截断，**只作旁证**。

### 1.5 本项目实际用到的 Mathlib 上游件（不是我们的功劳，必须点名）

- `Mathlib/Algebra/Lie/Cochain.lean`（Scott Carnahan, 2025）：`LieModule.Cohomology.twoCochain`、`d₁₂`、`d₂₃`、`twoCocycle`
- `Mathlib/Algebra/Lie/Extension.lean`（Scott Carnahan, 2024，上游 PR **#20206**）：**`LieAlgebra.ofTwoCocycle`**，`LieRing`/`LieAlgebra` 实例连 Jacobi 一起白送
- `Mathlib/Algebra/Lie/Loop.lean`（Scott Carnahan, 2026）：loop 代数、`twoCocycleOfBilinear`
- `ModularForm.eta` 及 `eta_comp_eq_csqrt_I_inv`（η 的 S 变换）、`SpecialLinearGroup.SL2Z_generators`、
  `SMulInvariantMeasure (GL (Fin 2) ℝ) ℍ volume`

⇒ 论文里**不能**把 Virasoro 的中心扩张说成本项目首创；我们做的是 Witt 括号 + cocycle 那一层。

### 1.6 两个「差点撞车」的上游件（本轮新发现，直接影响首次清单）

- **`Mathlib/Combinatorics/Enumerative/Partition/GenFun.lean`**（master，9790 B）
  有一般的分拆生成函数定理 `hasProd_genFun` / `genFun_eq_tprod`，其 docstring 逐字写：
  「When $f(i, c) = 1$, this is the generating function for partition function $p(n)$
  (**TODO: prove this**).」
  ⇒ `Math/EulerPartition.lean` 的 `Σ p(N)Xᴺ = ∏(1−Xⁿ)⁻¹` **确实不在 Mathlib**，但它是 Mathlib
  已有定理的直接特化，且是 Mathlib 自己挂的 TODO。**宣称价值极低，建议不列入首次清单。**
  同目录另有 `Pentagonal.lean`（欧拉五边形数定理）与 `Glaisher.lean`。
- **Dedekind η**：`Mathlib/NumberTheory/ModularForms/DedekindEta.lean`（master 8800 B）
  含 `eta_q`、`eta`、非零性、可微性、`logDeriv_eta_eq_E2` 等 22 条声明。
  本轮**远程抓取 master 与 v4.33.1 两个 ref 都报「无 S/T 变换」**，但这与本项目
  `Math/DedekindEtaS.lean` 实际 import 的 `ModularForm.eta_comp_eq_csqrt_I_inv` 矛盾。
  **按「本项目 Lean 能编译」判断，更可能是摘要器的假否定** ⇒ 见文末「未解决的疑问」第 3 条。
  formalizer 在 `formal/TODO.md:133` 的本地核查结论是「Mathlib v4.33.1 确实没有 `eta_T`」，
  **本地 grep 优于远程抓取，采信之**。

---

## 2. Lean 社区项目

### 2.1 Kalle Kytölä, `VirasoroProject`（最接近的先行工作）

- 仓库 <https://github.com/kkytola/VirasoroProject>，文档站 <https://kkytola.github.io/VirasoroProject>，**Apache-2.0**
- 论文：Kytölä, *Virasoro algebra and Sugawara constructions formally in Lean*, **arXiv:2510.21741**（v1, 2025-10-06, 16 页, math.QA/math-ph）
- 本轮复核 `VirasoroProject/` 目录：**21 个 `.lean` 文件 + `ToMathlib/` 子目录**，
  最大者 `Sugawara.lean`（39 436 B）。全部文件名：
  `CentralChargeCalc` `CentralExtension` `Commutator` `CyclicTripleSum` `FockSpace`
  `FockSpaceSugawara` `HeisenbergAlgebra` `IndexTri` `IsCentralExtension`
  `LieAlgebraModuleUEA` `LieAlgebraRepresentationOfBasis` `LieCohomologySmallDegree`
  `LieVerma` `SectionSES` `Sugawara` `VermaModule` `VirasoroAlgebra` `VirasoroCocycle`
  `VirasoroVerma` `WittAlgebra` `WittAlgebraCohomology`
- **覆盖到哪一步**（与 `NOTES-virasoro-reuse.md` 一致）：
  Witt 代数 → Virasoro 2-cocycle → 中心扩张；`H²(Witt,𝕜)` **一维且非零**；
  Heisenberg 代数；**单分量玻色 Sugawara，中心荷 c = 1**；带电 Fock 空间为 Heisenberg 表示；
  Verma 模（广义定义 + 万有性质）与 Virasoro Verma。
- **明确没有**（三条独立证据：21 个文件名、论文 Table 1、论文 §14 把 Feigin–Fuks 结构定理列为 future work）：
  Shapovalov / 逆变形式、**Kac 行列式**、character 公式、**PBW 基**（作者逐字「Mathlib does not
  currently have the PBW theorem」、补它是 "a major undertaking"）、`c = D` 多分量、
  **洛伦兹不定内积**、DDF 算子、**无鬼定理**、顶点代数/locality/OPE。
- 论文 §1.2 逐字：其代码 "**not yet been pull-requested to Mathlib**"。§1.3 把 VOA 方向划给 Carnahan、
  把「CFT 的数学定义」指向 Bin Gui。

### 2.2 Scott Carnahan, `vertexAlg`（本轮新发现，对论文最关键）

- <https://github.com/ScottCarnahan/vertexAlg>，描述 "Vertex Algebras"，语言 Lean，
  **创建 2026-05-15，最后 push 2026-08-31**（活跃）。根目录 8 条：`VertexAlg.lean`、`VertexAlg/`、
  `README.md`(2053 B)、`lakefile.toml`、`lean-toolchain`、`lake-manifest.json`、`.gitignore`、`.github/`
- 同作者另一仓库 `vertexStuff`（2023-07-18 建，2025-10-30 最后 push）**只有三个文本文件**
  （`Roadmap.txt`、`MonsterRoadmap`、`BinomialNotes.txt`），无 Lean 代码。
- `VertexAlg.lean` 的 34 条 import（逐字）分五组：
  `Extras.{FormalSeries,MonoidProd,NuSMeval,RevLex}`、`GroupTheory.{Golay,IntegerValued}`、
  `HahnSeries`、`LaurentPoly`、
  **`Lie.{Basic,CentralExtension,ChevalleyEilenberg,Cochain,Cocycle,Extension,Graded,Loop,PBW}`**、
  `OrderAddTorsor`、`TensorProductDecomposition`、
  **`VertexBasic.{Affine,Borcherds,Defs,HVertexOperator,Lattice,VertexOperator}`**、
  `toMathlib.{Binomial,Decomposition,DirectSum,FinsuppBasic,Graded,GroupBasic,NegOnePow,PointwiseSMul}`
- `VertexAlg/VertexBasic/Defs.lean`：**有真正的 `VertexAlgebra` class**（`AddCommGroupWithOne` +
  `stateField : V →ₗ[R] V →ₗ[R] V((z))` + associativity + locality），另有 `associativity`、
  `commutatorFormula`、`skewSymmetry`、`translationCovariance`、`poissonKernel`、
  `VertexSubalgebra`/`VertexHom`/`VertexEquiv` 全套。**`sorry` 计数 = 0。**
  docstring 里把 `Conformal`（内部 Virasoro 作用）列为 **To do** 的 typeclass。
- **README 的 "Done so far" 逐字四条**：`Definition of vertex algebra` / `some formal power series
  manipulations` / `loop algebras` / `Lie algebra extensions and 2-cocycles`。
- ★★ **README 的 "TODO" 里逐字包含**：
  「Lie algebras: Positive energy representations, vertex operators attached to Lie algebra elements,
  generalized Kac-Moody Lie algebras, twisted denominator formula, **virasoro representations,
  no-ghost theorem**」
  以及「Vertex algebras: **Dong's lemma**, Jacobi identity for local fields, Vacuum representations,
  **invariant inner products**, **Lattice vertex algebras**, -1-twisted module for lattices, …」
  ⇒ **这是「无鬼定理在 Lean 里尚未形式化」最硬的一手证据**：目前最先进的 Lean 顶点代数项目
  把它列为未来目标，而不是已完成项。项目主目标是 Monster VOA `V♮` + Borcherds 1992 月光猜想。
- `VertexAlg/Lie/PBW.lean`：docstring 首行逐字 **"Attempt at PBW"**，只有
  `Bracket.ofStructureConstant`、`structureConstant`、`subMin`、`actionAux`、`actionMap` 等辅助件；
  3 处 `sorry` **全部在被注释掉的代码块里**（`LieRing.ofStructureConstant`、
  `LieModule.ofStructureConstant`）。⇒ **PBW 定理本身没有**，与 Mathlib `1000.yaml` 口径一致。

### 2.3 Physlib（原 PhysLean/HepLean，`leanprover-community/physlib`）

- 有 `Physlib/StringTheory/`，但本轮完整列举**只有 `Basic.lean` + `FTheory/` 子目录**；
  导入表里 string 相关全部是 `Physlib.StringTheory.FTheory.SU5.{Basic,Charges,Fluxes,Quanta,…}`。
- 导入表关键词：**`Virasoro` 零命中、`CFT` 零命中、`Bosonic` 零命中**；
  唯一含 `Conformal` 的是 `Physlib.Cosmology.FLRW.ConformalTime`（宇宙学共形时间，无关）。
- `Anomaly` 命中很多，但全部是 **4D 反常抵消条件**：`Physlib.QFT.AnomalyCancellation.Basic`、
  `Physlib.Particles.StandardModel.AnomalyCancellation.*`、`…RHN.AnomalyCancellation.*`、
  `Physlib.QFT.QED.AnomalyCancellation.*`（FamilyMaps / Permutations / NoGrav / PlusU1）。
  **不是 10D Green–Schwarz 六维/十二维反常多项式。**
- ⇒ 对本项目 `Math/AnomalyPolynomial.lean`、`Math/GreenSchwarzAlgebra*.lean`、`Math/IIBAnomalyUnique.lean`：
  **Physlib 有「反常抵消」这个题材但不是同一个对象**，论文里必须写清这个区分，否则读者会误以为撞车。

---

## 3. Isabelle / AFP（读取日期 2026-09-11）

- `isa-afp.org/topics/` 完整分类列举：**Mathematics 下有 "Physics (8)"，其唯一子类是
  "Quantum information (8)"** ⇒ AFP 的物理条目全是量子信息，**没有弦论/CFT 条目**。
- `isa-afp.org/topics/mathematics/algebra/`（107 条，本轮全表列举）：
  **`Virasoro` 零命中、`vertex algebra` 零命中、`Verma module` 零命中、`highest weight` 零命中。**
  唯一的 Lie 条目是 **"Lie Groups and Algebras"（2024）**（= Schmoetten–Fleuriot，微分几何路线：
  流形上的 Lie 群 + 左不变向量场；**无泛包络代数、无 PBW**，前一轮已核实）。
  另有 "Representations of Finite Groups"（2015，有限群，不对口）、
  "The Gelfand–Naimark–Segal Construction"（2026）。
- ⚠ `isa-afp.org/search?term=…` 是纯 JS，返回空表单 ⇒ **只能用 topic 索引页**（这条已在 researcher 记忆里）。

---

## 4. Coq / Rocq、Agda、Mizar

**结论：三个系统都没有找到相关形式化，但证据强度不一。**

| 系统 | 已做的检查 | 强度 |
|---|---|---|
| **Agda** | `api.github.com/repos/UniMath/agda-unimath/contents/src` **完整列举 41 个顶层命名空间**（analysis, category-theory, commutative-algebra, …, group-theory, linear-algebra, ring-theory, universal-algebra, …）——**没有任何 Lie / 表示论 / 顶点代数命名空间** | **强**（完整列举；agda-unimath 是 Agda 最大的数学库） |
| **Coq / Rocq** | `api.github.com/repos/coq/opam/contents/released/packages`（全部已发布 opam 包名）里 `lie` / `virasoro` / `vertex` / `verma` / `enveloping` / `conformal` / `kac` / `moonshine` 零命中 | **弱**：摘要器自报**列表被截断**（只看到约 150 条）。`api.github.com/orgs/coq-community/repos?per_page=100` 返回空 `[]`（组织名可能要用 `users/` 端点），未重试 |
| **Mizar** | `mizar.uwb.edu.pl/library/` 只是导航页，不列文章；`mizar.uwb.edu.pl/fm/fm.bib`（Formalized Mathematics 全刊 BibTeX）取到但**在 `AMI_1.ABS` 处被截断**，可见部分 `Lie` / `Virasoro` / `vertex` / `Verma` / `enveloping` / `highest weight` / `conformal` / `Kac` 全部零命中 | **弱**（截断） |

**补强这三条的最好证据不是我的检索，而是 Kytölä 自己的文献综述**（见 §5.2 逐字）：
他 2025-10 在 §1.3 写「**We are not aware of earlier formalizations in any proof assistants** of …
constructing the Virasoro algebra and Heisenberg algebra as central extensions, or constructing
representations of the Virasoro algebra by Sugawara-type constructions」——这是一位领域内形式化者
对**所有证明助手**做出的公开断言，比我的截断式关键词扫描强。

**下一轮该做的**（本轮因 WebSearch 额度为零无法执行）：
Coq 用 `api.github.com/users/coq-community/repos`；Mizar 用分卷的 Formalized Mathematics 目录页；
另外 Isabelle 侧还可查 `isa-afp.org/topics/mathematics/analysis/` 与 Physics 子类的 8 条条目名。


---

## 5. arXiv 形式化论文

入口全部走 `export.arxiv.org/api/query`（WebSearch 不可用时仍然好用）。

### 5.1 已定位

- **Kytölä, arXiv:2510.21741**（见 §2.1、§5.2）。已登记 `virasoro-lean-2025`。
- ★ **Sihai Jin, arXiv:2608.20793v1（2026-08-21, math.QA, 14 页）**,
  *A Lean 4 Verification Report for Subregular Affine Cells and the Level $-1$ Vertex Algebra of Type $D$*。
  伴随数学论文 arXiv:2608.11997；代码 <https://github.com/jshemail12345-debug/SubregularAffineCells-Lean>（v1.0.0）。
  **摘要自陈的边界逐字（关键）**：
  「Higher representation-theoretic results whose foundational infrastructure is not presently
  constructed in the file are isolated as explicit **semantic interfaces** rather than introduced as
  Lean axioms. Thus the precise claim is a kernel-checked **internal deduction from explicit
  representation-theoretic boundary inputs, not a from-scratch formalization of vertex algebras,
  BRST reduction, finite W-algebras, or affine Hecke theory inside Mathlib**.」
  ⇒ **不构成「顶点代数/BRST 已被形式化」的先例，作者本人明确否认**。已登记 `jin-2026-subregular-lean`。
  论文里值得引作方法论对照：它用 **semantic interface** 承接未形式化前提，本项目用
  **认识论状态等级 + 沿图传播 + 禁止 `sorry`**，是同一问题的两种不同解法。

### 5.2 ★★ Kytölä §1.3 "Related work" 全段逐字（本轮 PDF 页图 L1 读取，p.2）

> **We are not aware of earlier formalizations in any proof assistants of any substantial part of
> using Lie algebra cohomology to classify central extensions, calculating cohomology groups of
> specific (infinite-dimensional) Lie algebras explicitly, constructing the Virasoro algebra and
> Heisenberg algebra as central extensions, or constructing representations of the Virasoro algebra
> by Sugawara-type constructions.**
>
> The project directly builds on the formalization of Lie algebras in Mathlib contributed primarily
> by Oliver Nash [Nas22]. Nash's work included constructions of specific Lie algebras, including all
> finite-dimensional complex semisimple Lie algebras.
>
> （同页右栏）Essentially concurrently with the present work, pull request **#20206** by Scott
> Carnahan on Lie algebra extensions was merged to Mathlib. The definition is almost directly
> compatible with the current project's one, so reconciling the small overlap should be easy.
>
> Some ambitious formalization work of Carnahan **[Car25]** builds towards the theory of vertex
> operator algebras (VOA). … VOAs include the Virasoro algebra as a component, often via variants of
> Sugawara constructions. We hope that the current project finds synergies with the formalization of VOAs.

另，p.1 §1.2 末句逐字：「The results here have **not yet been pull-requested to Mathlib**.」；
p.1 正文：仓库约 **4000 行** Lean 代码，报告对应 commit `29e118b`，**另有在线 blueprint**
<https://kkytola.github.io/VirasoroProject/>（含依赖图）。

**Table 1（p.2）逐字转录**（本轮页图复核，与 `NOTES-virasoro-reuse.md` 一致）：

| Topic | Reference | Lean declaration |
|---|---|---|
| central extensions of Lie algebras | Def 3.1 | `LieAlgebra.IsCentralExtension`, `LieTwoCocycle.CentralExtension` |
| Lie algebra cohomology in degree 2 | Def 4.3 | `LieTwoCohomology` |
| Virasoro algebra | Def 8.1 | `VirasoroAlgebra` |
| Heisenberg algebra | Sec 9 | `HeisenbergAlgebra` |
| Verma modules | Def 12.2 | `VermaModule`, `IsVermaModule` |
| 2nd cohomology of the Witt algebra | Thm 6.2 | `WittAlgebra.rank_lieTwoCohomology_eq_one` |
| Sugawara construction for Heisenberg algebra | Thm 10.1 | `sugawaraRepresentation_of_representation_heisenbergAlgebra` |
| module map Virasoro Verma → charged Fock space | Thm 12.7 | `ChargedFockSpace.virasoroVermaToChargedFockSpace` |

⇒ **Table 1 是「Kytölä 覆盖到哪一步」的权威清单；它里面没有的东西（Shapovalov、Kac 行列式、
PBW 基、c = D、不定内积、DDF、无鬼），就是本项目的空地。**

### 5.3 否定性检索（弱证据，术语受限）

- `(all:"no-ghost theorem" OR all:"Goddard-Thorn" OR all:"Kac determinant" OR all:"DDF operators")
  AND (all:"Lean" OR all:"proof assistant" OR all:"formalization" OR all:"formally verified")`
  → **feed 报 8 条，全部是 hep-th/math.QA 物理论文**（Naderi 2208.01617、Bianchi 1902.07016、
  Kugo 1401.3873、Borcherds math/9805123、Dei 2312.04622、Matsuda hep-th/9201008、Boels 1402.6356、
  Itoyama 1406.4750），**没有一条是形式化论文**。
- `abs:"Virasoro" AND (abs:"formalization" OR abs:"formalized" OR abs:"Lean 4" OR abs:"Isabelle")`
  → feed 报 188 条，**绝大多数是被 "formalism" 一词误命中的物理论文**；前 30 条里唯一的形式化论文
  是 2510.21741。⚠ 这条查询污染严重，**只能当弱旁证**。
- `abs:"vertex algebra" AND abs:"Lean"` → **只有 1 条**，即 2608.20793。


---

## 6. 方法论对照（Prove2Me / FLT / Lean blueprint）

| 项目 | URL | 一句定位 | 与本项目的差异 |
|---|---|---|---|
| **Prove2Me**（Chen–Marwaha–Lu–Yuen–Peng, arXiv:**2608.28433v2**, 2026-08-28, **cs.AI**） | <https://prove2.me> | 开放协作的数学形式化平台：陈述/证明分离、审计面固定在核心、proof sketch 可导入未证陈述 | 它的节点状态是**二元的**（该陈述在 Lean 里证了没有）；本项目的 `status` 是**有序等级**（formalized / rigorous / physical-argument / conjecture / refuted），有效状态由工具沿图取最小值传播 |
| **FLT Project**（Buzzard 等，Imperial College London，EPSRC） | <https://imperialcollegelondon.github.io/FLT/> | 自述逐字：「An ongoing multi-author open source project to formalise a proof of Fermat's Last Theorem」 | 目标是把**一条已被人类证明的定理**推到 Lean；本项目要处理的是**大部分推导根本没有严格证明**的领域 |
| **Anthropic, "Formalizing Fermat's Last Theorem"**（2026-09-04 报告） | <https://www.anthropic.com/research/formalizing-fermats-last-theorem> | agent 以 DAG 为外部记忆的经验来源 | ⚠ 与上一行的 Imperial FLT **不是同一个东西**，引用时勿混 |
| **leanblueprint**（Patrick Massot） | <https://github.com/PatrickMassot/leanblueprint> | plasTeX 插件；2020 年为 Sphere Eversion Project 所建，现被 PFR / FLT / Carleson 采用 | **见下，这是最需要讲清楚的对照** |
| **OpenAI, Navier–Stokes**（2026-09-08） | <https://openai.com/index/navier-stokes-solution/> | 「同时挂成立与反例两个方向」「先攻跳板问题」 | — |
| **Kytölä 的 VirasoroProject blueprint** | <https://kkytola.github.io/VirasoroProject/> | 同一领域里**已经存在**的依赖图 | 它是 blueprint 型的图，见下 |

### ★ 与 Lean blueprint 的精确差异（论文里必须写准，否则会被审稿人抓）

blueprint 的依赖图**已经是**「节点 = 陈述、边 = 依赖、节点带状态」的东西。差异**不在有没有图**，
而在**状态轴的语义**：

- blueprint 的节点 = LaTeX 环境（默认 `definition/lemma/proposition/theorem/corollary`）；
  边 = `\uses` 宏声明的「用到」关系；
- blueprint 的节点颜色 = **形式化流水线进度**。README 的 `\graphcolor` 默认色表逐字为配置键：
  `stated`、`can_state`、`not_ready`、`proved`、`can_prove`、`defined`、`fully_proved`、`mathlib`；
  配套宏 `\leanok`（逐字 "the surrounding environment is fully formalized"）、`\notready`、
  `\mathlibok`（逐字 "marks nodes that were already merged into mathlib"）、`\lean`（挂 Lean 声明名）。
- ⇒ **blueprint 的状态刻画的是「离形式化还有多远」，不刻画「底层论证本身有多严格」。**
  它没有 `physical-argument` / `conjecture` / `refuted` 这一轴，因为它的前提是
  「这条数学已经被人类严格证明，只是还没打进 Lean」。
- **本项目的新东西**是把状态轴换成**认识论强度**并让它沿图取最小值传播，从而能回答
  「这条结论压在几条猜想上」。**不要写成「已有工作只有静态文档」——那是不实的。**

---

## 主题对照表

「本项目是否更远」一栏的判断依据是 `formal/CLAUDE.md` 的目录说明与 `formal/StringFormal.lean`
的 49 条 import（读取日期 2026-09-11）。**本 researcher 没有跑 `lake build`，也没有逐条读 Lean 证明**
——「本项目已做」一律以 `formal/CLAUDE.md` 的自述为准，最终宣称前应由 formalizer 用
`uv run stringgraph check-axioms` 复核无 `sorry`、无新公理。

| 主题 | 已有工作（URL / 声明） | 覆盖到哪一步 | 本项目是否更远 |
|---|---|---|---|
| Witt 代数（Lie 结构） | Kytölä `VirasoroProject/WittAlgebra.lean`；**Mathlib 无** | 域上、`[CharZero]` + `[NoZeroSMulDivisors]` | **否（不是首次）**；仅假设更弱：任意 `CommRing` |
| Virasoro 代数（中心扩张） | Kytölä `VirasoroAlgebra`（Def 8.1）；Mathlib `LieAlgebra.ofTwoCocycle`（Carnahan, PR #20206） | 中心扩张 + `H²(Witt)` **一维**（Thm 6.2） | **否**；我们连 `H² ≠ 0` 都没证（已写进节点 notes 的真实缺口） |
| Witt/Virasoro 完美性、`C = 2[L₂,L₋₂] − 4[L₁,L₋₁]` | 未发现 | — | **可能首次**（Kytölä 21 个文件名无 Perfect；Mathlib 无 Witt） |
| Verma 模 V(c,h)、万有性质 | Kytölä `VermaModule` / `IsVermaModule`（Def 12.2）、`VirasoroVerma.lean` | 万有性质已证 | **否** |
| **PBW 基 / Verma 的显式基** | Mathlib **无**（`docs/1000.yaml` 的 `Q2270905` 无 `decl`）；Kytölä 逐字「Mathlib does not currently have the PBW theorem」；Carnahan `Lie/PBW.lean` 首行「**Attempt at PBW**」；AFP 无；Coq/Agda 未发现 | 三家都只到「需要它」 | **部分**：我们做的是 `VermaPBW.lean` 的**上界半边**（有序词张成 level 片、`dim V_N ≤ p(N)`），**线性无关那半没做** ⇒ 只能说「首次形式化了 Virasoro Verma 模 level 片的有序词张成与维数上界」 |
| **Virasoro Shapovalov（逆变）形式** | **全域未发现**（Kytölä 无；Mathlib 无；AFP 无；Carnahan README 把 "invariant inner products" 列为 TODO） | — | **是（最强的首次候选）** |
| **Kac 行列式** | **全域未发现**；Kytölä §14 明确把 Feigin–Fuks 结构定理列为 future work | — | **部分**：只有 **N ≤ 4** 的 Gram 行列式与 Kac 乘积形的相等（`ShapovalovLevelThree/Four`、`GenericIndependence`）。**通用公式没有** ⇒ 只能宣称「首次机器验证 Kac 行列式公式在 N ≤ 4 的实例」 |
| **D 分量玻色 Fock 空间 + η 诱导的不定型** | Kytölä `FockSpace.lean` 是**单分量带电 Fock 空间**（Heisenberg 表示）；无洛伦兹号差 | 单分量 | **是**（`NoGhost/Fock.lean`、`FockSigned.lean`：每个 level 都有负模态） |
| **Sugawara，中心荷 c = D** | Kytölä Thm 10.1 / Cor 10.2：**c = 1，单分量** | c = 1 | **是**（`NoGhost/Sugawara.lean` 的 `lie_Lop_Lop` 给 c = D） |
| **DDF 算子及其代数** | **全域未发现**；Carnahan README 把「vertex operators attached to Lie algebra elements」列为 TODO | — | **是**（`DDFOperator*.lean`、`DDFAlgebra.lean`：`[L_m, A^ε_n] = 0` 对一切 m、`⁅A^ε_m, A^δ_n⁆ = m(ε·δ)δ_{m+n,0}`） |
| **无鬼定理（Goddard–Thorn）** | **全域未发现**；★ Carnahan README 的 TODO 里逐字有 "**no-ghost theorem**" | 没有人做到 | **否——我们也没做完**。`NoGhost/Statement.lean` 只写了陈述骨架。**绝不可宣称** |
| 顶点代数 / locality / OPE | Mathlib 只到 `VertexOperator`（locality 在 TODO）；**Carnahan `vertexAlg` 有完整 `VertexAlgebra` class，0 sorry** | Carnahan 最远 | **否**。本项目的 `NoGhost/VertexOperator.lean` 是**具体的指数顶点算子 `:e^{ic·X}:` 的振子部分**，不是抽象顶点代数公理 ⇒ 两者**不是同一个对象**，论文里要写清，不要声称比 Carnahan 远 |
| Dedekind η 的 S 变换 | **Mathlib 有**（`ModularForm.eta_comp_eq_csqrt_I_inv`，`(√i)⁻¹√z` 形状） | — | **否**；我们只做归一化到 `(−iτ)^{1/2}`（`csqrt_neg_I_mul` 是唯一新数学） |
| Dedekind η 的 T 变换 | Mathlib **无**（formalizer 在 `formal/TODO.md:133` 记「Mathlib v4.33.1 确实没有 `eta_T`」） | — | **可能首次**（价值不高，从定义直接证） |
| `τ₂\|η\|⁴` 的 SL(2,ℤ) 不变性、`τ₂¹²\|η\|⁴⁸` | 未发现 | — | **可能首次**（玻色弦单圈被积函数的倒数）。**乘子系统仍缺**，别说「η 的模形式性质已形式化」 |
| S、T 生成模群 | Mathlib `SpecialLinearGroup.SL2Z_generators` | SL 层已有 | **否**；新的只是 `(ST)³ = −1` 与到 `PSL` 的搬运 |
| `d²τ/τ₂²` 的模不变性 | Mathlib `SMulInvariantMeasure (GL (Fin 2) ℝ) ℍ volume` | 已有更一般的 | **否**（搬运）；**取向版（带符号 2-形式）未做** |
| 分拆生成函数 `Σp(N)Xᴺ = ∏(1−Xⁿ)⁻¹` | ★ Mathlib **`Mathlib/Combinatorics/Enumerative/Partition/GenFun.lean`** 有一般定理 `hasProd_genFun`，但把它特化到 p(n) 在 docstring 里逐字写着「(**TODO: prove this**)」 | 一般机器已有，特化没做 | **技术上首次，但价值极低** ⇒ 建议论文**不要**把它列进首次清单 |
| E₈ 240 根的显式列表与幂和恒等式 | **未核实 Mathlib 是否有 E₈ 根系**（本轮没查 `Mathlib/LinearAlgebra/RootSystem/`） | ? | **待核实**，暂不宣称 |
| **10D Green–Schwarz 反常因子化（代数恒等式层）** | Physlib 有大量 `AnomalyCancellation`，但**全部是 4D**（`QFT/`、`StandardModel/`、`RHN/`、`QED/`）；Physlib 的 `StringTheory/` **只有 `Basic.lean` + `FTheory/SU5/`** | 对象不同 | **是（首次候选）**，但必须限定为「反常多项式的**代数恒等式**」：指标定理、六边形图、下降方程都不在 Lean 里 |
| IIB 引力反常的整数解唯一性 | 未发现 | — | **可能首次**（`IIBAnomalyUnique.lean`：`ker A = ℚ·(2,−2,1)`、显式线性关系 `2r₁+3r₂−5r₃=0`，两本书都只说「线性相关」不给关系） |

---

## 可宣称首次的清单

**（A 级：证据最硬，可写「to our knowledge the first formalization of …」）**

1. **Virasoro 代数的 Shapovalov（逆变）形式**及其存在唯一性、level 正交性。
   证据：Kytölä Table 1 与 21 个文件名里都没有；Kytölä §14 把 Feigin–Fuks 结构定理列为 future work；
   Mathlib `Algebra/Lie/` 完整列举无；AFP 完整列举无；Carnahan README 把 "invariant inner products" 列 TODO。
2. **Kac 行列式公式在 level N ≤ 4 的机器验证**（Gram 行列式与 Kac 乘积形在 Lean 内相等）。
   ⚠ 措辞必须是「**N ≤ 4 的实例**」，不是「Kac 行列式定理」。
3. **横向 DDF 算子及其振子代数** `⁅A^ε_m, A^δ_n⁆ = m(ε·δ)δ_{m+n,0}`、`[L_m, A^ε_n] = 0`。
   证据：Carnahan README 把相邻目标列 TODO；arXiv 检索 8 条全为物理论文。
4. **带洛伦兹不定内积的 D 分量玻色 Fock 空间**，以及**中心荷 c = D 的 Sugawara 构造**。
   证据：Kytölä 本人限定在 c = 1 单分量（他自己的三条使用限制之一就是「没有洛伦兹不定内积」）。
5. **10D Green–Schwarz 反常因子化的代数恒等式**与 **IIB 引力反常整数解唯一性**（限定为代数层）。
   证据：Physlib 的反常模块全是 4D；其 `StringTheory/` 只有 F-theory SU(5)。

**（B 级：很可能首次，但只有「未发现」级证据，建议措辞降级为「我们未发现先例」）**

6. Witt/Virasoro 代数完美性与 `C = 2[L₂,L₋₂] − 4[L₁,L₋₁]`。
7. Virasoro Verma 模 level 片的有序词张成 + `dim V_N ≤ p(N)`（PBW 的上界半边）。
8. Dedekind η 的 T 变换；`τ₂|η|⁴` 的 SL(2,ℤ) 不变性与 `τ₂¹²|η|⁴⁸`。
9. level-2 物理态的闭式模公式与 `D > 26` 时负模物理态的显式构造。
10. GSO 扇区穷举（Polchinski §10.6 的 10 解 / 6 个 maximal 解）、六边形奇数扭转计数 `Σ_{k odd} C(6,k) = 32`。

## 不可宣称的

1. ❌ **无鬼定理（Goddard–Thorn）本身。** 无人形式化过，**我们也没有**——`NoGhost/Statement.lean`
   只有陈述骨架。论文只能写「我们形式化了其证明所需的若干组成部分（Fock 空间、c = D Sugawara、
   DDF 代数），定理本身仍未闭合」。
2. ❌ **Virasoro 代数 / Witt 代数 / Verma 模 / Heisenberg 代数 / 中心扩张的首次形式化**——
   全部属于 Kytölä（arXiv:2510.21741，2025-10）与 Carnahan（Mathlib PR #20206）。
   本项目在这些点上的贡献只是**假设更弱**（任意 `CommRing` / `[Algebra ℚ R]`）与**复用 Mathlib 上游**。
3. ❌ **「Virasoro 是 Witt 的唯一非平凡中心扩张」**——Kytölä 的 `WittAlgebra.rank_lieTwoCohomology_eq_one`
   已经证了 `H²` 一维，**本项目没证**。这是我们的缺口，不是我们的成果。
4. ❌ **顶点代数 / locality / OPE 的形式化**——Carnahan `vertexAlg` 已有完整 `VertexAlgebra` class
   且 0 `sorry`。本项目的 `VertexOperator.lean` 是具体的 `:e^{ic·X}:`，与之不是同一对象。
5. ❌ **PBW 定理**——三个系统都没有，**我们也没有**（只做了张成/上界半边）。
6. ❌ **Dedekind η 的 S 变换**、**S/T 生成 SL(2,ℤ)**、**`d²τ/τ₂²` 的不变性**——都是 Mathlib 已有件的搬运。
7. ❌ **分拆生成函数**——Mathlib 已有一般定理，特化是其自身 TODO；技术上算首次但没有宣称价值。
8. ❌ **「首个把物理论证纳入形式化依赖图的项目」这类宽泛说法未经验证**——本轮**没能**检索
   Lean Zulip、GitHub code search、通用网页搜索（WebSearch 额度为零）。在补上这些检索之前，
   宽泛的领域级首创宣称应避免。

## 未解决的疑问 / 下一轮优先

1. **Lean Zulip 与 GitHub code search 完全没查**（无搜索额度）。这是目前最大的证据缺口，
   也是最可能翻出反例的地方（`#maths` / `#new members` 里可能有人做过 Virasoro 或 CFT 玩具项目）。
   → 下一轮把这两项排在会话最前面。
2. `Mathlib/LinearAlgebra/RootSystem/` 是否已有 **E₈ 根系的显式构造**？未查。
   影响 `Math/E8Roots.lean` 的首次宣称。
3. **`ModularForm.eta_comp_eq_csqrt_I_inv` 的定位有矛盾**：`formal/StringFormal/Math/DedekindEtaS.lean`
   文件头说它在 `Mathlib/NumberTheory/ModularForms/DedekindEta.lean`，但本轮远程抓取该文件
   （`master` 与 `v4.33.1` 两个 ref）都报「不含该 token」。由于本项目的 Lean 能编译，
   **更可能是摘要器的假否定**（已知失败模式）。→ 请 formalizer 在本地
   `grep -rn eta_comp_eq_csqrt_I_inv formal/.lake/packages/mathlib/` 一句话定位，把真实路径回填这里。
4. Coq / Mizar 的检查因截断只到弱否定（见 §4）。
5. Carnahan `vertexAlg` 的 `VertexBasic/Affine.lean`、`Lattice.lean`、`Borcherds.lean` 本轮**没读内容**，
   只读了 `Defs.lean` 与 `Lie/PBW.lean`。若论文要和它精确划界，这三个文件应补读。

## § Zulip 与 GitHub code search（2026-09-11 追加，补上一轮最大缺口）

上一轮（本文件 §「已尝试但失败的入口」）把 **Lean Zulip** 与 **GitHub code search** 记为"未执行"，
并在「未解决的疑问」第 1 条把它们列为最可能翻出反例的地方。本节是补做记录。
**逐条记录入口 URL 与结果，包括失败的入口**，以便下一个人不必重试。

### A. GitHub code search：入口全部被封（本轮复核）

| 入口 | 结果（2026-09-11） |
|---|---|
| `https://github.com/search?q=...&type=code`（网页） | 逐字："**Sign in to search code on GitHub** Before you can access our code search functionality please sign in or create a free account." **零结果可读** |
| `https://api.github.com/search/code?q=...` | **HTTP 401 Unauthorized**（免认证不可用；本环境无 `gh`、无 token） |
| `https://grep.app/api/search?q=Virasoro&filter[lang][0]=Lean` | **HTTP 429**（上一轮两次 429，本轮第三次仍 429）⇒ 判为对本环境长期不可用 |
| `https://searchcode.com/api/codesearch_I/?q=Virasoro` | **HTTP 404**（该 API 端点已下线） |

⇒ **GitHub 的"文件内容级"搜索在本环境无法执行**，这是一个**不能靠重试解决**的硬限制，
论文里凡涉及"无人写过某个 Lean 声明"的宣称，其证据只能来自**仓库级搜索 + 目标仓库的完整目录列举**，
不能声称做过全网代码 grep。

### B. 替代路线：`api.github.com/search/repositories`（免认证可用，本轮主力）

这是本轮找到的可用替代。限制必须写清：**它只搜仓库名/描述/README/topic，不搜文件内容**，
且 `language:` 限定的是**仓库主语言**。所以"零命中"只是弱否定；"有命中"则是硬事实。

| 查询 | total_count | 命中（Lean 相关的全部列出） |
|---|---|---|
| `Virasoro language:Lean` | **1** | `kkytola/VirasoroProject`（建 2025-01-01，最后 push **2026-06-14**） |
| `vertex algebra language:Lean` | **4** | ① `ScottCarnahan/vertexAlg`（2026-05-15 / 2026-08-31）② **`dbrueg/lean-geometric-vertex-algebras`**（2026-09-04 建，同日 push；"Lean formalization of *Geometric Vertex Algebras*"）③ `jshemail12345-debug/SubregularAffineCells-Lean`（2026-08-21）④ **`jshemail12345-debug/ArakawaMoreauFormalAudit`**（2026-08-23；"Lean 4 formal audit for *Completing the Arakawa–Moreau Conjecture on Maximal Ideals of Affine Vertex Algebras*"） |
| `"no-ghost"`（不限语言） | 174，**全部噪声** | Ghost 博客主题 / Discord bot / 物理引擎 "no ghost collisions"。**无一条是数学形式化** |

| `Verma language:Lean` | **0** | — |
| `Sugawara`（不限语言） | 103，**全部噪声** | 日本姓氏 Sugawara 的个人仓库 + 一个水文学 "Tank model"。**无形式化仓库** |
| `Shapovalov`（不限语言） | 142，**全部噪声** | 斯拉夫姓氏 Shapovalov（CVPR 论文作者、蛋白质 beta-turn、个人作业）。**无形式化仓库，无 Lean** |
| `"Kac determinant"`（不限语言） | **1**，非形式化 | `kabhay166/vira-soro-algebra`（**Python**，2023-09-24 / 2023-10-04）："computing conformal blocks and kac determinant in the viro soro algebra"。是数值/符号计算脚本，**不是证明助手** |
| `string theory language:Lean` | **0** | —（注：Physlib 的仓库描述不含 "string theory"，故此查询漏掉它；见本文件 §2.3） |
| `conformal field theory language:Lean` | **1** | ★★ **`Deicyde/formal-conformal`**（2026-04-21 建，最后 push 2026-06-23）："A Lean 4 formalization of Conformal Field Theory" |

★ **本轮新发现三个上一轮完全不知道的 Lean 仓库**：
`dbrueg/lean-geometric-vertex-algebras`、`jshemail12345-debug/ArakawaMoreauFormalAudit`、
**`Deicyde/formal-conformal`**。内容核查见 §C。

### C. 本轮新发现的 Lean 仓库：内容核查

#### C.1 ★★ `dbrueg/lean-geometric-vertex-algebras`（最实质的新发现）

- 建 **2026-09-04**，同日 push；顶层 `GeomVA.lean` + `GeomVA/` + `geom_va.tex`(67 007 B) + `docs/`
- `GeomVA/` 目录完整列举：`Analytic/`、`Category.lean`(14 798)、`Equivalence.lean`(13 529)、
  `Formal/`、`GVA/`、**`GVAtoVA.lean`(122 868)**、`Graded/`、`Util/`、`VA/`、**`VAtoGVA.lean`(232 682)**
  ⇒ 约 **400 KB** Lean 源码，是一个**真正做完的**项目，不是骨架。
- 形式化对象：Daniel Bruegmann, *Geometric Vertex Algebras*, **arXiv:2012.09717** 的
  **Theorem 4.2**——几何顶点代数与 **ℤ-分次顶点代数**范畴等价（拆成 Φ∘Ψ=id、Ψ∘Φ=id、态射层，
  最后用 `PhiCatIso` 打包成范畴同构）。
- ★ README 逐字（经 WebFetch 摘要器引出）：「Every declaration is fully proved (no `sorry`);
  the main theorems depend only on `propext`, `Classical.choice`, `Quot.sound`.」
  toolchain `leanprover/lean4:v4.33.1`。
- 覆盖到的前置件：全纯函数 / Laurent 展开 / **围道积分**、分次向量空间、形式分布、
  顶点代数定义（原文 §3）、几何顶点代数定义（§2）、两个方向（§5、§6）。
- **对本项目的影响**：这是"顶点代数领域已有一个 0-sorry 的完整定理级形式化"的最新证据，
  ⇒ §「不可宣称的」第 4 条（顶点代数/locality/OPE 不可宣称首次）**本轮被进一步加固**，不必修改。
  但它**不碰** Virasoro 表示、Shapovalov、Kac 行列式、洛伦兹号差、DDF、无鬼定理 ⇒ **不构成反例**。
  注意：它有**围道积分与 Laurent 展开**的 Lean 基础设施，若本项目将来要做解析版 OPE，这是可复用资产。

#### C.2 ★ `Deicyde/formal-conformal`（Stony Brook，"A Lean 4 formalization of Conformal Field Theory"）

- 建 **2026-04-21**，最后 push **2026-06-23**。作者：Jack McCarthy（研究生）+ Fedor Popov（博后），
  Stony Brook University；Apache-2.0。README 自陈部分代码/证明/文档由 Anthropic Claude 协助完成。
- **全部 Lean 内容 = 一个文件**：`FormalConformal/Basic.lean`（**8 812 B**）。
  顶层只有 `FormalConformal.lean`(165 B)、`Main.lean`(104 B)。
- ★ **该文件的全部声明只有四条**（逐条列举）：
  `VertexAlgebra`（structure）、`VertexAlgebra.mode`（abbrev）、
  `VertexOperatorAlgebra`（structure）、`VertexOperatorAlgebra.L`（abbrev）。**`sorry` 计数 = 0**。
- 文件头逐字："# Vertex Operator Algebras" / "This file formalizes the definition of a vertex algebra
  and of a vertex operator algebra (VOA) **following the Wikipedia article**"；
  References 段列 Wikipedia、FLM88、Kac98、Borcherds86、Gannon06。
- ⇒ **尽管仓库描述叫"CFT 的 Lean 4 形式化"，实际只到 VOA 的定义（含 `L` 的 abbrev），没有任何定理。**
  **不构成对本项目任何首次宣称的反例**，但论文写 related work 时应点名它，
  否则读者按仓库名会以为 CFT 已被形式化。这是一个"名字比内容大得多"的仓库。

#### C.3 `jshemail12345-debug/ArakawaMoreauFormalAudit`（2026-08-23，与已登记的 `jin-2026-subregular-lean` 同作者同套路）

- 顶层只有 6 个文件，Lean 代码是**单个 446 445 B 的 `ArakawaMoreauFormalAudit.lean`** + `SHA256SUMS.txt`。
- ★ README 自陈边界（与 §5.1 的 2608.20793 措辞几乎同构）：
  "**not a from-definitions formalization of vertex operator algebras, BRST reduction, or minimal
  W-algebras**"；未重证的背景结果以 "**literature interfaces**"（Lean 里的 theorem 参数）暴露；
  推荐的刻画是 "**a formal audit modulo explicit interfaces**"。
  README 说这些 literature interfaces "do not appear as custom axioms in `#print axioms`"，
  并报告 `lake build` 成功（"Build completed successfully (8708 jobs)"）。
- ⇒ 与 2608.20793 同样**不构成"顶点代数/BRST 已被形式化"的先例，作者本人明确否认**。
  但它是**第二个**采用"未形式化前提当显式接口"路线的项目，
  §6 方法论对照里"semantic interface vs 认识论状态等级"的对比可以点名两个实例而不是一个。

### D. ★ Carnahan `vertexAlg` 的 `Affine.lean` / `Lattice.lean` / `Borcherds.lean`（补上一轮缺口 §「未解决的疑问」第 5 条）

`api.github.com/repos/ScottCarnahan/vertexAlg/contents/VertexAlg/VertexBasic`（分支 `main`）完整列举：

| 文件 | 大小 | 本轮读到的内容 |
|---|---|---|
| `Affine.lean` | 2 674 B | **零条 live 声明**。docstring 写"Vertex operators and vertex algebras attached to affine Lie algebras"，Definitions 段列的 `vertexOperator x V`、`vertexAlgebra χ g` 与 Main results 段三条**都是计划**；"To do"段逐字要求"写定义与证明"。`class positiveEnergy`、`class smooth`、`def affineVertexOperator`、`def vacuumModule` **全部在注释块里**；3 处 `sorry` **全在被注释掉的 `positiveEnergy` 块内**。 |
| `Lattice.lean` | **1 088 B** | **零条声明**。只有 copyright、2 条 import（`Mathlib.Algebra.Lie.Loop`、`VertexAlg.VertexBasic.VertexOperator`）、docstring（"# Lattice vertex operators … vertex operators attached to elements in the **double cover** of an integer lattice"，Definitions 段只写了打算做 `VertexOperator.Lattice.E-` / `E+`）、一个空 `section`、一行 `variable`、一条注释掉的 `-- import Affine.`。`sorry` 计数 0（因为根本没有代码）。 |
| `Borcherds.lean` | 19 839 B | **有实质定理**（见下） |

#### D.1 `Borcherds.lean` 的真实覆盖范围（对 `math.lattice-vertex-algebra` 与 OPE 卡的判断有直接影响）

docstring 首行逐字 "# Basic results on the Borcherds identity"。live 声明按序 26 条，关键结构是：

- **Borcherds 恒等式本身是 `def borcherdsId`（Prop 值定义，= `borcherdsSum1 = borcherdsSum2 + borcherdsSum3`），
  并作为 `class VertexAlgebra1` 的一个 field 出现 ⇒ 它是公理/假设，不是被证出来的定理。**
  `theorem borcherdsIdentity` 只是把该 class field 重述成独立定理（wrapper），**不是独立证明的结果**。
- **真正被证明的是"特化 ⟺ 其它公理"的等价**：`borcherdsId_at_zero_iff_associativity`、
  `borcherdsId_at_zero_iff_commutatorFormula`、`borcherdsId_at_large_r_iff_weak_assoc`，
  外加 `borcherdsSum1_eq_zero`、`locality_left_eq_borcherdsSum2`、`locality_right_eq_borcherdsSum3`、
  `associativity_left/right`、`unit_right_order/zero`、`commutator_right_2/3` 等辅助定理，
  以及三条 `Int` 工具引理。
- `sorry` 共 3 处，**全部在 `/-! -/` 注释块内**（`conv_pow_succ_X_sub_Y` 与两条
  `locality_if_Borcherds_sums_2_3_eq` / `Borcherds_sums_2_3_eq_if_locality` 的证明草稿）。
  ⇒ **`borcherdsId_at_large_t_iff_locality`（"大 t 特化 ⟺ locality"）目前只存在于注释里，未完成。**

★ **对本项目的两条可用结论**：

1. **格顶点代数（lattice VOA）在 Carnahan 项目里是空的**——`Lattice.lean` 只有 docstring，零声明。
   这与 README 把 "Lattice vertex algebras" 列进 TODO 一致，**是两条互相独立的证据**。
   ⇒ `math.lattice-vertex-algebra` 卡若要宣称"未见先例"，本轮**没有找到反例**；
   但措辞仍应是"我们未发现先例"而非"全网首次"（GitHub 内容级搜索本环境不可用，见 §A）。
2. **Borcherds 恒等式 ⇔ 结合律/对易子公式的等价已被 Carnahan 证出**，
   所以任何"OPE 与对易子的等价性首次形式化"一类宣称都**站不住**——这是本轮最接近反例的一条，
   请 curator/formalizer 在 OPE 相关卡上避开这个说法。

### E. Lean Zulip（`leanprover-community.github.io/archive`，本轮首次执行）

**入口裁决**：
- `leanprover.zulipchat.com` 的搜索页与 API（`/api/v1/messages?narrow=[{"operator":"search",...}]`）
  **都跳到登录页**（"View without an account" 只是营销按钮，WebFetch 拿不到 SPA 内容）⇒ **死路**。
- ✅ **可用路线**：公开归档 <https://leanprover-community.github.io/archive/>，
  站点自报 **"last updated Feb 28 2026 at 14:05 UTC"**（本轮 2026-09-11 读到），近 100 个 stream。
  `maths` 有 **2 986 topics**、`new members` 12 843、`general` 9 924、`lean4` 7 667、`mathlib4` 6 722、
  `Is there code for X?` 5 499。另有专门的 **PhysLean** stream。
  ⚠ stream 索引页会被摘要器截断（`maths` 页本轮只读到约 600 条最新 topic 标题，站点自报 "Content truncated"）
  ⇒ **Zulip 侧的"零命中"一律是弱否定**。
- ⚠ 配套的 GitHub 仓库是 `leanprover-community/archive`（"Replacement for the archive repo"，
  default branch `main`，size ≈ 196 GB-KB 量级、最后 push 2026-08-25），但
  `contents/stream` **返回 404** ⇒ 不能用目录列举绕过截断。

在 `maths` 流可见的约 600 条最新 topic 标题里，关键词 `Virasoro / vertex / ghost / Verma / Kac /
conformal / string theory / Sugawara / Shapovalov / Witt` **只命中两条**，两条都已读全文：

#### E.1 topic「Virasoro algebra (and cohomology of the Witt algebra)」（14 条消息，2025-01-01 → 2025-06-15）

`…/archive/stream/116395-maths/topic/Virasoro.20algebra.20(and.20cohomology.20of.20the.20Witt.20algebra).html`

- **Kytölä 2025-01-01** 发布 `VirasoroProject`：Virasoro = Witt 的**唯一**一维中心扩张；
  为此建了二次 Lie 代数上同调、从 2-cocycle 造中心扩张、中心扩张的短正合列刻画；
  核心是 `H²(Witt)` 一维且由 Virasoro cocycle 类生成。Heisenberg 作为更简单的例子；
  **自陈 Sugawara 当时没时间做**。
- **Tanimoto 2025-01-02** 指出与 Carnahan 的 mathlib4 **PR #20206** 可能重叠。
- ★ **Carnahan 2025-01-12 逐字要点**：他**没有做过上同调计算**，只有"从 2-cocycle 造中心扩张"的构造。
  ⇒ 这条**独立佐证**了本文件 §「不可宣称的」第 3 条（`H²(Witt)` 一维归 Kytölä，不归 Carnahan/Mathlib）。
- **Kytölä 2025-01-13 / 02-08** 追问 Carnahan 有没有**反方向**（每个中心扩张都来自 2-cocycle、
  模 coboundary 良定）的图追踪；Carnahan 答**没做**。Kytölä 自陈这条**因证明线性性太烦而放弃**
  ⇒ **"中心扩张 ↔ H² 的完整双向对应"至今在任何 Lean 项目里都没有做完**（双方自陈，最强的一手证据）。
- **Kytölä 2025-06-14** 宣布加入 **基本玻色 Sugawara**，把 Heisenberg 表示装上 **c = 1** 的 Virasoro 表示；
  计划（**当时未做**）：背景荷改中心荷、推广到仿射 Kac–Moody、**费米 Sugawara**（Ising/Majorana、辛费米子）。
  ⇒ **再次确认 c = 1 是 Kytölä 的上限**，本文件主题对照表"Sugawara c = D"一行**本轮无反例**。
- **全帖零次提到 no-ghost / Kac determinant / Shapovalov / Verma 的实现。**

#### E.2 ★★ topic「Formal calculus for vertex algebras, sorry-free library with…」（3 条，**2026-02-28**，本轮最新的反例候选）

`…/topic/Formal.20calculus.20for.20vertex.20algebras.2C.20sorry-free.20library.20with.html`

- **Justin McClung（2026-02-28 00:19）** 发布 <https://github.com/JustinMcClung/formal-distribution>：
  Nozaradan *Introduction to Vertex Algebras* **第 1 章**的 Lean 4 形式化，自陈
  **"complete and sorry-free"**，约 **3 850 行 / 11 个文件**，覆盖
  **形式分布、展开算子、形式 δ 的性质、分解定理、locality 与 j-th products、Fourier 变换 / λ-bracket**。
  他自己在帖子里问"哪些值得 upstream 到 Mathlib、设计会不会和现有顶点代数开发冲突"。
- **Weiyi Wang（01:48）**：提到另有一个**开着的 mathlib4 PR #25822** 与之相关，并已 ping Carnahan。
- **Kevin Buzzard（09:08）**：直接问是否用了 LLM，并说社区惯例要求明确披露。
  （⇒ 该库的署名/工具披露状态**截至归档时未解决**，引用时应注明。）
- **对本项目的影响**：**locality 与 λ-bracket 的形式演算已有 sorry-free 实现**，
  这进一步堵死任何"形式分布/locality 首次形式化"的说法。**但它仍不碰 Virasoro 表示论**
  ⇒ 对本项目 A 级清单**不构成反例**。
- ★ **新线索（本轮已查完，见 E.4）**：**mathlib4 PR #25822**。

#### E.3 ⚠ `JustinMcClung/formal-distribution` 现在**取不到**（重要的引用风险）

- `api.github.com/repos/JustinMcClung/formal-distribution` → **404**；
  `api.github.com/users/JustinMcClung/repos` → **空数组 `[]`**（该用户当前**没有任何公开仓库**）；
  仓库搜索 `formal-distribution vertex` → **0**。
- ⇒ 该库在 2026-02-28 的 Zulip 公告之后被删除或转私。**"3 850 行、sorry-free"只有作者自述，
  本轮无法独立核实**。论文若要引用，必须写成"Zulip 公告（2026-02-28）自述，代码当前不可获取"，
  **不能当作已验证的先例**。（时间线上它紧跟 Buzzard 的 LLM 披露追问，但**因果关系纯属推测，不得写进论文**。）

#### E.4 mathlib4 PR #25822 的真身（本轮核实，免认证 API）

`api.github.com/repos/leanprover-community/mathlib4/pulls/25822`：
- **title 逐字："WIP: experiments with vertex algebras"**；author **ScottCarnahan**；
  created **2025-06-12**；**state = open，merged = false，merged_at = null**（读取日 2026-09-11）。
- body 首句逐字："This is a testbed for various attempts at things. **Please don't bother reviewing.**"
- ⇒ **Mathlib 主线至今没有合并任何顶点代数实质内容**，本文件 §1.1（`Algebra/Vertex/` 只有 2 个文件）
  **本轮无需订正**。这是比目录列举更强的一条证据：连作者自己都把它标成 WIP testbed。

#### E.5 ★★ PhysLean stream 完整列举（99 个 topic，无截断）——对 GS 反常与 BRST 卡最有用

`archive/stream/479953-PhysLean/index.html` 本轮**完整读到 99 条 topic 标题**（页面未截断）。
关键词 **string / conformal / Virasoro / vertex / anomaly / Green–Schwarz / CFT / bosonic
在 99 条标题里零命中**。两条看似相关的已逐条读全文排除：

- **"A 'WorldVolume' directory"**（6 条，2025-06-19 → 06-24）：Joseph Tooby-Smith 提议把
  `Space`/`Time`/`SpaceTime` 合并成顶层目录，名字借用 sigma 模型的 worldvolume Σ→M。
  **纯粹是代码目录命名讨论，最终命名为 `SpaceAndTime`（PR624）**，与弦/膜物理内容无关。
- ★★ **"BV formalism anyone?"**（2 条，2025-11-24）：**Xi Yin** 提议形式化
  "Batalin–Vilkovisky formalism of general quantum gauge theories"，自陈主要用例是**弦场论**，
  并问社区有没有人做过。**Joseph Tooby-Smith（PhysLean 主导者）当日回复逐字大意：
  "not aware of anyone having worked in a related area."**
  ⇒ **这是"BRST/BV/弦场论在 Lean 生态里无人做过"的一手证言**，
  由 PhysLean 的实际维护者在 2025-11 作出，强度类似 Kytölä §1.3 的那句断言。
  本项目若涉及 BRST 相关节点，可引这条（但注意它是**社区认知**，不是穷举证明）。

#### E.6 其它 stream：弱否定

- `Is there code for X?`（5 499 topics）：可见约 **700** 条最新标题（2025-07 → 2026-02），
  `Virasoro / vertex algebra / no-ghost / Verma / Kac / Sugawara / Shapovalov / Witt algebra /
  conformal / string theory` **全部零命中**；页面自报截断 ⇒ **弱否定**。
- `general`(9 924)、`new members`(12 843)、`mathlib4`(6 722) 本轮**未查**（必被截断，投入产出比低）。

### F. 本轮未能执行的项（诚实登记）

- **WebSearch 额度再次为 0**（"this session has used its web search budget (200 of 200)"，
  与上一轮同样是被同会话前序任务耗尽）⇒ 任务里第 3 项的三条通用网页检索
  （`"formalization" "Virasoro algebra" (Lean OR Isabelle OR Coq)`、`"no-ghost theorem" formal proof`、
  `"Kac determinant" "proof assistant"`）**一条都没跑成**。
  ⇒ **非英文/非 GitHub 的先行工作（例如 Coq 的 Rocq-community 之外的个人项目、
  日文/法文博客、会议 talk）仍是未覆盖面。**
- Zulip 的 `general` / `new members` 两个最大流未做关键词扫描。

## lead 本地复核（2026-09-12）

- 矛盾点 1 已解：`ModularForm.eta_comp_eq_csqrt_I_inv` 在本地 Mathlib（formal/.lake/packages/mathlib）`Mathlib/NumberTheory/ModularForms/Discriminant.lean:136`，远程抓取是假否定。η 的 S 变换本身**不可宣称首次**（我们只补了 (√i)⁻¹√τ = (−iτ)^{1/2} 的桥）。
- 不确定点 4：本地 grep `Mathlib/LinearAlgebra/RootSystem/` 含 "E8"/"E₈" 的文件：无。 ⇒ E₈ 根系显式 240 根与幂和恒等式在 Mathlib 无现成对象，`Math/E8Roots.lean` 的根幂和可列入 A 级（措辞：显式根集合上的幂和恒等式，不宣称根系分类）。

---

## § 可宣称首次清单 —— 第二轮反例复核（2026-09-11，GitHub 仓库搜索 + Lean Zulip 归档）

本轮新增的检索面：GitHub 仓库级搜索（9 条查询）、Lean Zulip 公开归档（`maths` 约 600 条最新
topic、`PhysLean` **全部 99 条**、`Is there code for X?` 约 700 条）、Carnahan 三个未读文件、
mathlib4 PR #25822、四个新仓库的内容核查。**逐条标注"本轮是否找到反例"。**

| # | 宣称 | 本轮是否找到反例 | 依据（本轮新证据） |
|---|---|---|---|
| A1 | Virasoro 的 **Shapovalov/逆变形式** | **否** | `Shapovalov` 仓库搜索 142 条**全是姓氏噪声、零 Lean**；Zulip Virasoro 帖全程未提；Carnahan `Lattice/Affine/Borcherds` 三文件里无内积 |
| A2 | **Kac 行列式 N ≤ 4 的机器验证** | **否** | `"Kac determinant"` 全 GitHub 仅 1 个仓库且是 **Python** 脚本（`kabhay166/vira-soro-algebra`）；Zulip 零命中 |
| A3 | **横向 DDF 算子及其振子代数** | **否** | 仓库搜索与 Zulip 全流零命中；Carnahan `Affine.lean` 的"attached to Lie algebra elements"仍是**注释里的计划** |
| A4 | **洛伦兹不定 D 分量 Fock + c = D Sugawara** | **否，且被加固** | Zulip 帖里 Kytölä **2025-06-14 亲口**只做到 **c = 1 玻色 Sugawara**，费米/仿射推广列为"计划"；`Sugawara` 仓库搜索 103 条全是日本姓氏噪声 |
| A5 | **10D GS 反常因子化 + IIB 整数解唯一性**（代数层） | **否，且被加固** | **PhysLean stream 99 条 topic 完整列举中 `anomaly`/`string`/`Green-Schwarz` 零命中**；`string theory language:Lean` 仓库搜索 = 0 |
| A6 | **E₈ 显式 240 根的幂和恒等式**（lead 2026-09-12 追加） | **否** | 本轮未新增证据，沿用 lead 的本地 grep 结论 |
| B6 | Witt/Virasoro 完美性、`C = 2[L₂,L₋₂] − 4[L₁,L₋₁]` | **否** | `Virasoro language:Lean` 全 GitHub **只有 `kkytola/VirasoroProject` 一个仓库**（total_count = 1）⇒ 上一轮"21 个文件名里没有"的证据本轮升级为"全 GitHub 只有这一个 Lean Virasoro 仓库" |
| B7 | Verma level 片的有序词张成 + `dim V_N ≤ p(N)` | **否** | `Verma language:Lean` 仓库搜索 **total_count = 0** |
| B8 | η 的 T 变换、`τ₂\|η\|⁴` 不变性 | **否**（本轮未新查） | — |
| B9 | level-2 物理态闭式模公式、D > 26 负模态构造 | **否** | 同 A3/A4 的面 |
| B10 | GSO 扇区穷举、六边形奇数扭转计数 | **否** | 同 A5 的面 |
| — | `math.lattice-vertex-algebra`（格顶点代数） | **否，但须降级措辞** | ★ Carnahan `Lattice.lean` **只有 1 088 B、零条声明**（仅 docstring 提到打算做 `E±`）⇒ 无人做过；但 **GitHub 内容级搜索在本环境不可用**（§A），只能写"我们未发现先例" |

### ★ 本轮找到的**接近反例 / 需要改措辞**的三条

1. **⚠ 不要宣称"Borcherds 恒等式 ⇔ 结合律 / 对易子公式"的等价是首次**——
   Carnahan `Borcherds.lean` 已有 `borcherdsId_at_zero_iff_associativity`、
   `borcherdsId_at_zero_iff_commutatorFormula`、`borcherdsId_at_large_r_iff_weak_assoc`
   （live 定理，非注释）。**只有"大 t ⇔ locality"那条还在注释里未完成。**
2. **⚠ 不要宣称"形式分布 / locality / λ-bracket 的形式演算"首次**——
   Justin McClung 在 Zulip（2026-02-28）公告过 sorry-free 的 Nozaradan 第 1 章实现。
   **但该仓库现已 404**（§E.3），引用时必须注明"自述、当前不可核实"。
3. **⚠ 不要宣称"顶点代数的定理级形式化"首次**——`dbrueg/lean-geometric-vertex-algebras`
   （2026-09-04）已 0-sorry 证完 arXiv:2012.09717 Thm 4.2 的范畴等价，约 400 KB Lean。

### 本轮证据强度的净变化

- **变强**：A4（Kytölä 本人 c = 1 的口头确认）、A5（PhysLean 99 条完整列举 + BV 帖的维护者证言）、
  B6/B7（仓库搜索 total_count = 1 / 0）、Mathlib 无顶点代数（PR #25822 是作者自标的 WIP testbed）。
- **未变**：A1、A2、A3。
- **新增的"不可宣称"面**：Borcherds 恒等式等价、形式分布/locality、几何顶点代数范畴等价、
  **BRST/BV 与弦场论**（虽无人做过，但 Xi Yin 2025-11 已在 PhysLean 公开提出，属于**他人已宣示的方向**）。
- **仍未覆盖**：GitHub 文件内容级 grep（结构性不可用）、WebSearch（额度 0，两轮皆然）、
  Zulip `general` / `new members` 两大流。⇒ §「不可宣称的」第 8 条
  （不做宽泛的领域级首创宣称）**本轮仍然成立，建议保留**。
