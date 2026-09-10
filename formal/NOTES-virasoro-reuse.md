# 调研：Virasoro 代数的既有 Lean 形式化能否复用

任务：`formal/TODO.md#virasoro-lie-instance`。
调研日期：2026-09-10。调研人：lean-formalizer（agora `formalizer`）。
结论摘要见最后一节 **决策**。

---

## 1. arXiv:2510.21741

| 项 | 内容 |
|---|---|
| 标题 | *Virasoro algebra and Sugawara constructions formally in Lean* |
| 作者 | Kalle Kytölä（单作者） |
| 单位 | Aalto University, Department of Mathematics and Systems Analysis（associate professor） |
| 提交 | 2025-10-06（v1），16 页含附录 |
| 分类 | math.QA, math-ph；MSC 68V20；ACM F.3.1 |
| 资助 | Research Council of Finland 项目 346309（FiRST） |
| 摘要要点 | 把 Virasoro 代数构造为 Witt 代数关于一个非平凡 2-cocycle 的中心扩张；并用 Sugawara 构造给出 Virasoro 代数的表示 |
| 论文许可 | arXiv nonexclusive-distrib/1.0（只覆盖论文，不覆盖代码） |

来源：<https://arxiv.org/abs/2510.21741>、<https://arxiv.org/pdf/2510.21741>、
<https://people.aalto.fi/kalle.kytola>

### 代码仓库

| 项 | 内容 |
|---|---|
| 仓库 | <https://github.com/kkytola/VirasoroProject> |
| 文档站 | <https://kkytola.github.io/VirasoroProject> |
| **许可证** | **Apache-2.0**。GitHub license 字段 `apache-2.0`；每个源文件头写 `Copyright (c) 2024 Kalle Kytölä. All rights reserved. Released under Apache 2.0 license as described in the file LICENSE.` 与 Mathlib 同一许可，**允许在保留署名与许可声明的前提下移植** |
| 默认分支 | `main` |
| 最后一次代码提交 | `555a9096` 2025-12-28 "Bump Lean and Mathlib." |
| Lean 版本 | `leanprover/lean4:v4.27.0-rc1` |
| Mathlib 版本 | `lake-manifest.json` 里 `mathlib` 的 `inputRev` 是 `master`，锁定 rev `b9b7d0bade32`（约 2025-12） |
| 其他依赖 | `checkdecls`、`doc-gen4`（工具，不含数学内容） |
| 规模 | 约 25 个 `.lean` 文件，合计约 250 KB |

### 它怎么定义 Virasoro 代数

是**真正的 Mathlib `LieRing` / `LieAlgebra` 实例**，路线为「Witt 代数 + 2-cocycle 的中心扩张」：

1. `VirasoroProject.WittAlgebra 𝕜 := ℤ →₀ 𝕜`（Finsupp 上的 type synonym），
   基 `WittAlgebra.lgen : Basis ℤ 𝕜 (WittAlgebra 𝕜)`（取他自建的 `Finsupp.basisFun`），
   括号用 `Basis.constr` 双线性延拓 `⁅ℓ n, ℓ m⁆ = (n−m) • ℓ (n+m)`。
   - `instLieRing` 的假设是 `[CommRing 𝕜] [CharZero 𝕜] [NoZeroSMulDivisors 𝕜 (WittAlgebra 𝕜)]`。
     多出来的两条假设**只**用于从反对称性 `B X Y = −B Y X` 推 `lie_self : B X X = 0`（先得 `2 • B X X = 0` 再除以 2）。
   - Jacobi 恒等式经自建的 `cyclicTripleSumHom`（`VirasoroProject/CyclicTripleSum.lean`）打包成三线性映射，
     再 `LinearMap.ext_basis` + `Basis.ext` 化到基上，最后 `ring`。
2. 自建的二阶 Lie 代数上同调 API：`LieOneCochain` / `LieTwoCocycle` / `LieTwoCoboundary` / `LieTwoCohomology`
   （`VirasoroProject/LieCohomologySmallDegree.lean`，文件头作者自己写着 *"WARNING: This file needs cleaning up"*）。
3. `WittAlgebra.virasoroCocycle : LieTwoCocycle 𝕜 (WittAlgebra 𝕜) 𝕜`，
   定义值 `γ(ℓ n, ℓ m) = δ_{n+m,0} (n³−n)/12`；系数取在 `𝕜`（平凡系数），假设 `[Field 𝕜] [CharZero 𝕜]`。
4. `VirasoroAlgebra 𝕜 := LieTwoCocycle.CentralExtension (WittAlgebra.virasoroCocycle 𝕜)`，
   carrier 实为 `WittAlgebra 𝕜 × 𝕜`，生成元 `lgen 𝕜 n = ⟨ℓ n, 0⟩`、中心元 `cgen 𝕜 = ⟨0, 1⟩`，
   `basisLC : Basis (Option ℤ) 𝕜 (VirasoroAlgebra 𝕜)`。主关系 `VirasoroAlgebra.lgen_bracket`：
   `⁅L n, L m⁆ = (n−m) • L (n+m) + (if n+m = 0 then ((n³−n)/12) • C else 0)`。
5. 额外证了 `H²(Witt, 𝕜) ≠ 0`（`cohomologyClass_virasoroCocycle_ne_zero`），
   并有中心扩张的短正合序列刻画（`SectionSES.lean`、`IsCentralExtension.lean`）。

### Sugawara 覆盖到什么程度

- `HeisenbergAlgebra.lean`：Heisenberg 代数作为可数无穷维交换 Lie 代数的一维中心扩张。
- `Sugawara.lean`（39 KB，仓库最大文件）：**基本玻色 Sugawara 构造**——任何满足「局部截断」
  （local truncation）条件的 Heisenberg 代数表示，都由 `L n` 的正规序二次表达式得到一个
  **中心荷 c = 1** 的 Virasoro 表示。`CentralChargeCalc.lean` 单独算中心荷。
- `FockSpace.lean` / `FockSpaceSugawara.lean`：带电 Fock 空间作为 Heisenberg 表示，
  真空是最高权向量，最高权 `½·charge²`。
- **没有**：`c = D` 的多分量版本、`η` 诱导的不定内积、DDF 算子、无鬼定理；
  也没有一般 affine Lie 代数 `ĝ` 的 Sugawara（只有 Heisenberg 情形）。

### Verma 模

**有。** `VermaModule.lean` 定义了一个「广义 Verma 模」概念并证了其**万有性质**；
`LieVerma.lean`、`VirasoroVerma.lean` 给出 Virasoro 情形，`LieAlgebraModuleUEA.lean` 处理普遍包络代数上的模。
但**没有** Shapovalov 形式、**没有** Kac 行列式，也没有 Verma 模的 character 公式。
→ `formal/TODO.md` 的 `verma-module` 项**值得**评估复用；`shapovalov-form` / `kac-determinant` 得自己做。

---

## 2. Mathlib v4.33.1（本项目锁定版本）现状

### 没有 Witt / Virasoro 代数

`grep -ri virasoro Mathlib/` 零命中；`WittAlgebra` 零命中
（`Mathlib/RingTheory/WittVector/*` 是 p-typical Witt 向量环，与圆上向量场的 Witt 代数无关）。
所以**上游没有可直接 import 的 Virasoro**。

### 但中心扩张的全部基础设施已经在上游（Scott Carnahan）

这是本次调研最重要的发现：

- `Mathlib/Algebra/Lie/Cochain.lean`（Scott Carnahan, 2025）
  - `LieModule.Cohomology.oneCochain R L M := L →ₗ[R] M`
  - `LieModule.Cohomology.twoCochain R L M`：满足 `c x x = 0` 的双线性映射构成的 `Submodule`
  - `d₁₂`、`d₂₃`（**已打包成 bundled 线性映射** `twoCochain →ₗ L →ₗ L →ₗ L →ₗ M`）、`d₂₃_comp_d₁₂ = 0`
  - `LieModule.Cohomology.twoCocycle R L M := LinearMap.ker (d₂₃ R L M)`
  - `mem_twoCocycle_iff_of_trivial`：平凡系数下 cocycle 条件 ⟺ `a x ⁅y,z⁆ = a ⁅x,y⁆ z + a y ⁅x,z⁆`
- `Mathlib/Algebra/Lie/Extension.lean`（Scott Carnahan, 2024；即上游 PR #20206）
  - `LieAlgebra.IsExtension`、`LieAlgebra.Extension`
  - **`LieAlgebra.ofTwoCocycle (c : twoCocycle R L M)`**：`L × M` 上把括号按 cocycle 平移后的 Lie 代数，
    **`LieRing` 与 `LieAlgebra R` 实例都已在 Mathlib 里证好**（`leibniz_lie` 用的正是 `d₂₃ c = 0`）
  - `LieAlgebra.Extension.ofTwoCocycle`：对应短正合序列 `0 → M → · → L → 0`
  - `LieEquiv.ofCoboundary`：差一个 coboundary 的两个 cocycle 给出同构的扩张
  - 缺：中心扩张的 `IsCentral` 谓词、扩张的等价关系（文件 TODO 里写着）
- `Mathlib/Algebra/Lie/Loop.lean`（Scott Carnahan, 2026）：loop 代数 `L ⊗ R[ℤ]`、
  `twoCocycleOfBilinear`（由不变对称双线性形式造的 2-cocycle）——**affine Kac–Moody 的上游路线已开工**。
  缺：由不变形式真正造出中心扩张、evaluation 表示、正能量表示。

结论：Kytölä 的 `LieCohomologySmallDegree.lean` + `CentralExtension.lean` + `IsCentralExtension.lean` +
`SectionSES.lean`（合计约 50 KB）在 v4.33.1 上**已被 Mathlib 上游的等价物取代**，移植等于重复劳动。
Kytölä 论文自己也提到 Carnahan 的 PR #20206 与他的定义 "almost directly compatible"。

### 顶点代数（vertex algebra）进 Mathlib 的进展

- 已进上游：`Mathlib/Algebra/Vertex/HVertexOperator.lean`、`Mathlib/Algebra/Vertex/VertexOperator.lean`
  （Scott Carnahan, 2024，即 PR #11797）。
  - `HVertexOperator Γ R V W := V →ₗ[R] HahnModule Γ R W`（异质顶点算子，用 Hahn series）
  - `VertexOperator R V := HVertexOperator ℤ R V V`，`ncoeff`（`A_(n)` 归一化系数）、复合、ext
  - 依赖 `Mathlib/RingTheory/HahnSeries/*`（已相当完整：Addition / Multiplication / Summable / HEval / …）
- **尚未进上游**：`VertexAlgebra` 这个 class 本身、locality、residue product、Hasse 导数
  （`VertexOperator.lean` 的 TODO 明确列着 `HasseDerivative` / `Locality` / `Residue products`）。
- 相关活动：Carnahan 在 Lean Together 2025 讲过 "Vertex algebras in mathlib: coming soon?"。
- 对本项目的含义：**现在还不能靠上游顶点代数做无鬼定理**；Fock 空间与正规序仍需自建，
  但 `HahnSeries` / `HVertexOperator` 是将来写 `sugawara`（模式展开、正规序）时该先看的工具。

---

## 3. 决策

**不整仓库拷贝，也不移植 Kytölä 的中心扩张 / 上同调栈。**
采用「**Mathlib 上游基础设施 + 自写 Witt 代数与 Virasoro cocycle**」的混合路线：

```
StringFormal/Virasoro/Witt.lean    -- WittAlgebra R := ℤ →₀ R，LieRing + LieAlgebra R 实例
StringFormal/Virasoro/Basic.lean   -- virasoroCocycle : twoCocycle R (WittAlgebra R) R
                                   -- VirasoroAlgebra R := LieAlgebra.ofTwoCocycle (virasoroCocycle R)
```

理由：

1. **许可证没问题**（Apache-2.0，与 Mathlib 相同），但**版本差 6 个 Lean 小版本**
   （v4.27.0-rc1 vs v4.33.1），且 Kytölä 的上同调 API 与 Mathlib v4.33.1 新增的
   `LieModule.Cohomology` **不是同一套**。照搬会引入一份与上游平行、作者自标
   "needs cleaning up" 的 API，长期是负债。
2. Mathlib 的 `LieAlgebra.ofTwoCocycle` **白送 `LieRing` + `LieAlgebra R` 实例**（含 Jacobi 恒等式），
   我们只需提供 `WittAlgebra` 的 Lie 结构与一个 `twoCocycle`。工作量从约 90 KB 降到约 250 行。
3. 设计仍照 Kytölä 走（`ℤ →₀ R` carrier、`Basis.constr` 定括号、cocycle 值 `δ_{n+m,0}(n³−n)/12`），
   署名与致谢写在 `StringFormal/Virasoro/ATTRIBUTION.md`。

### 顺带修掉的两个多余假设（数学发现）

- Kytölä 的 `WittAlgebra.instLieRing` 需要 `[CharZero 𝕜] [NoZeroSMulDivisors 𝕜 (WittAlgebra 𝕜)]`，
  只为从反对称推 `lie_self`。**这两条假设是不必要的**：把括号定义成 `A − Aᵀ`
  （其中 `A(ℓ n, ℓ m) := n • ℓ (n+m)`），`lie_self` 就是 `sub_self`，于是
  **Witt 代数在任意交换环上都是 Lie 代数**（包括特征 2）。我们的 `StringFormal.Virasoro.WittAlgebra` 采用这个写法。
  （注：一般的「反对称 ⟹ `lie_self`」确实要 2 可逆或用配对求和论证；这里是靠改写定义绕开，不是补上了缺失的证明。）
- 同理 Virasoro cocycle 用 `γ − γᵀ` 写法可免掉 `Field`，只需 ground ring 里有 `1/12`；
  我们取 `[CommRing R] [Algebra ℚ R]`，比 `[Field 𝕜] [CharZero 𝕜]` 更弱且自动覆盖 ℚ / ℝ / ℂ。
  注意：**cocycle 的非平凡性（`H² ≠ 0`）确实需要特征 0**，这条我们没证（见下）。

### 本次未做、留给后续的

- `H²(Witt, R) ≅ R`（Virasoro cocycle 生成二阶上同调，故 Virasoro 是 Witt 的**唯一**非平凡一维中心扩张）。
  Kytölä 证了 `≠ 0` 和一维性。Mathlib 的 `LieModule.Cohomology` 目前**没有** coboundary 与
  cohomology 商（文件 TODO 里写着），所以要么等上游，要么自己补 `twoCoboundary`。
  **图节点 `worldsheet.virasoro-algebra` 的 statement 里断言了「唯一非平凡中心扩张」，
  而我们只形式化了「是一个中心扩张」——这是形式化与陈述之间的一个真实缺口，已写入节点 `notes`。**
- `verma-module`：Kytölä 的 `VermaModule.lean` + `VirasoroVerma.lean` 值得认真评估复用（万有性质已证）。
- Sugawara：Kytölä 只做了 Heisenberg（c = 1）单分量情形；无鬼定理要的是 D 分量、带 `η` 不定内积的版本，
  不能直接用，但正规序手法可参考 `Sugawara.lean` 与 `CentralChargeCalc.lean`。
