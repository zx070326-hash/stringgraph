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

