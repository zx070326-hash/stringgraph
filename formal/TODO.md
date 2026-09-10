# formal/ 任务分解

按依赖顺序。每项完成后在这里打勾并在图里更新对应节点。

## 数学基础

与弦论无关、但被多条链子用到的纯数学岛。放在 `StringFormal/Math/`，**不 import 其他子目录**。

- [x] `euler-partition-gf`：Euler 分拆生成函数
  `Σ_{N≥0} p(N) q^N = ∏_{n≥1} (1 - q^n)^{-1}`，`p(N) = Fintype.card (Nat.Partition N)`。
  见 `StringFormal/Math/EulerPartition.lean`（无 sorry，公理只有标准三条）。
  Verma 模特征标 `ch V(c,h) = q^h ∏(1-q^n)^{-1}` 与
  `worldsheet.no-ghost-theorem-subcritical--via-lian-zuckerman` 都默默用它，此前图里无节点无来源。
  形式化在 `PowerSeries R`（`X` 就是 `q`），无穷乘积取 Mathlib 的
  `PowerSeries.WithPiTopology`（逐系数/乘积拓扑），四种等价写法：
  - `partitionGF_mul_tprod_one_sub_X_pow`：**任意交换环**上 `(Σ p(N) X^N)·∏(1-X^n) = 1`
    （无逆元形式，最一般，推荐作为图节点的 `lean_decl`）；
  - `partitionGF_eq_invOfUnit`：任意交换环上等于 `PowerSeries.invOfUnit`；
  - `partitionGF_eq`：域上 `= (∏(1-X^n))⁻¹`；
  - `partitionGF_eq_tprod_inv`：域上 `= ∏(1-X^n)⁻¹`（逐因子取逆，物理文献的字面形状）；
  - `coeff_partitionGF_mul_prod_one_sub_X_pow_eventually_eq`：**完全无拓扑**的重述
    （有限部分积的系数最终稳定），对标 Mathlib 的
    `PowerSeries.coeff_prod_one_sub_X_pow_eventually_eq`。
  **绝大部分工作是 Mathlib 的**：`Nat.Partition.hasProd_genFun`
  （`Mathlib/Combinatorics/Enumerative/Partition/GenFun.lean`，v4.33.1 新增）与它的推论
  `Nat.Partition.hasProd_powerSeriesMk_card_restricted`（`Partition/Glaisher.lean`）。
  Mathlib 的 GenFun 模块文档把 `f ≡ 1` 这一特化列为 TODO（"the generating function for
  partition function p(n) (TODO: prove this)"），本文件补的就是它，外加几何级数
  `Σ_j X^{nj}` 到 `(1 - X^n)⁻¹` 的那一步。**Archive 里没有**分拆生成函数：
  `Archive/Wiedijk100Theorems/Partition.lean` 在 v4.33.1 已被删除，Euler 奇/异分拆定理搬到了
  `Partition/Glaisher.lean`（`card_odds_eq_card_distincts`），`partialGF` 框架不复存在。
  **未做**：`p(N)` 的渐近（Hardy–Ramanujan）；Dedekind `η` 的模性；与 Verma 特征标的接线
  （需要 PBW 下界，见 `pbw-verma` (b)）。

- [x] `mobius-three-point-jacobian`：Möbius 三点固定的 Jacobian。
  见 `StringFormal/Math/MobiusJacobian.lean` A 节（无 sorry，公理只有标准三条）。
  `mobius_three_point_jacobian`：任意交换环上 `det (vandermonde z) = (z₂-z₁)(z₃-z₁)(z₃-z₂)`
  （Mathlib `Matrix.det_vandermonde` 特化 n = 3）；`det_mobius_matrix` 是三个变量写开的版本；
  `mobius_three_point_jacobian_eq_neg` 记录符号：等于 `-z₁₂z₁₃z₂₃`，文献里的 `|z₁₂z₁₃z₂₃|`
  是取绝对值后的结果，符号随三点置换翻转，**不是**物理陈述的一部分。
  `mobius_three_point_det_ne_zero` / `mobius_three_point_fixing_bijective`（域上）：三点两两不同
  ⟺ 把 `δz = a₀ + a₁z + a₂z²` 的参数映到三点处取值的线性映射是双射，即三点规范固定存在且唯一。
  建议图节点 `math.mobius-three-point-fixing-jacobian` 的 `lean_decl`。
  **未做**：这只是无穷小（李代数）层面的陈述。群层面的 `PSL(2,ℝ)` 在三元组上单可迁、
  Faddeev–Popov 行列式与测度的关系、以及 `|z₁₂z₁₃z₂₃|` 作为体积因子出现在振幅里，都没碰。

- [x] `mandelstam-sum-rule`：`s + t + u = Σ mᵢ²`。
  见 `StringFormal/Math/MobiusJacobian.lean` B 节（无 sorry，公理只有标准三条）。
  `mandelstam_sum`：任意模上任意**对称双线性型** `B`，`Σkᵢ = 0`、`B(kᵢ,kᵢ) = -mᵢ²`（mostly-plus）
  ⟹ `s + t + u = Σ mᵢ²`，其中 `s = -B(k₁+k₂, k₁+k₂)` 等（`mandelstamS/T/U`）。
  不需要非退化、不需要号差、不需要域、连 2 可逆都不需要——纯运动学。
  `mandelstam_sum_four_tachyons`：加 `α'mᵢ² = -1` 得 `α'(s+t+u) = -4`；
  `mandelstam_sum_four_closed_tachyons`：加 `α'mᵢ² = -4`（闭弦基态，`α'kᵢ² = 4`）得 `α'(s+t+u) = -16`；
  `regge_trajectory_sum_four_tachyons`：`α_c(x) = a + α'x` 时 `Σα_c = 3a - 4`（截距留作参数）；
  `regge_intercept_sum_four_tachyons`：`a = 1` 时 `Σα_c = -1`。
  `mandelstam_sum_diagonal_metric`：`Fin D → K` 上对角度规 `η` 的具体版本（与 `DDF.dotVec` 同形，
  但不 import 该文件）；`minkowskiForm = Matrix.toBilin' (diagonal η)`。
  建议图节点 `spectrum.mandelstam-invariants-sum-rule` 的 `lean_decl`。
  **未做**：`s`、`t`、`u` 与散射道的关系（需要 in/out 态与解析延拓，不是代数），
  Veneziano 振幅本身，以及 `α_c` 是"领头轨迹"这一物理陈述。

## Lean 岛 2：Green–Schwarz 反常抵消的代数部分

`StringFormal/Math/GreenSchwarzAlgebra.lean`，独立小岛（只 import Mathlib）。
对应 Green–Schwarz 1984 抽取记录 `literature/extractions/green-schwarz-1984.md` §5 的
Lean 候选 A1/A2/A3。三项都已完成，无 sorry，公理只有标准三条。

- [x] `gs-factorization`（A1）：十二形式因子化 `Ω₁₂ = (1/48) Ω₄ [Ω₈ − (1/300) Ω₄²]`。
  `gs_factorization_so32`：`SO(32)` 支，`Ω₄ = 30x`、`Ω₈ = 24y + 3x²`、`Ω₁₂ = 15xy`；
  `gs_factorization_e8`：`E₈` 支，`Ω₄ = x`、`Ω₈ = x²/100`、`Ω₁₂ = x³/7200`；
  `gs_factorization_nested_eq_expanded`：GS 原文的嵌套形与二手文献的展开形
  `(1/48)Ω₄Ω₈ − (1/14400)Ω₄³` 是同一恒等式。
  建议图节点 `math.anomaly-twelve-form-factorization` 的 `lean_decl`（取前两条）。
  **环境选择**：陈述在 `[Field K] [CharZero K]` 上，系数写作 `48⁻¹`、`300⁻¹`、`/100`、`/7200`，
  证明是 `field_simp; ring`。**不要**改回 `[CommRing R] [Algebra ℚ R]` + `algebraMap ℚ R (1/48)`：
  那样 `ring` 把 `algebraMap ℚ R (1/48)` 当不透明原子，两个不同写法的有理常数不会被认同，
  一名 formalizer 曾因此停摆一轮。系数本来就是有理数，域上陈述对图完全够用。
  **未做**：迹恒等式本身（`math.so-usp-adjoint-fundamental-trace-identities`、
  `math.e8-adjoint-trace-identities`）是独立节点，这里只把它们的输出当写死的数字系数；
  微分形式、指标定理、反常多项式的来历一概不碰。

- [x] `gs-trace-conditions`（A2）：混合反常的两条迹条件。
  `mixed_anomaly_trace_conditions_n32`：`N + 8l = 24 ∧ N + 2l = 30 ⟹ (N, l) = (32, −1)`；
  `mixed_anomaly_no_solution_l_one`：`l = +1`（`usp`）时两条件矛盾，无解。
  建议图节点 `math.mixed-anomaly-trace-conditions-n32` 的 `lean_decl`。`omega` 一行。

- [x] `gs-tr-f6`（A3）：`Ω₁₂` 中 `tr F⁶` 的系数 `N + 32l`。
  `tr_f6_coefficient_vanishing`：`so(N)` 支 `N − 32 = 0 ⟺ N = 32`；
  `tr_f6_usp_positive`：`usp(N)` 支 `N + 32 > 0`（`N ≥ 1`）恒不为零。
  建议图节点 `math.tr-f6-coefficient-vanishing` 的 `lean_decl`。`omega` 一行。

**整个岛都不碰物理**：这几条方程为什么是反常抵消条件，由
`consistency.anomaly-cancellation-so32-effective-theory` 承载；
"只有 `SO(32)` 与 `E₈ × E₈` 因子化" 这类唯一性断言**不是** GS 1984 的结果，图里也没有节点。

## Virasoro

- [x] `virasoro-lie-instance`：`VirasoroAlgebra R`（`R` 为交换 ℚ-代数）已是真正的 `LieRing` +
  `LieAlgebra R` 实例，见 `StringFormal/Virasoro/Witt.lean`（Witt 代数，任意 `CommRing`）与
  `StringFormal/Virasoro/Basic.lean`（Virasoro = Witt 的中心扩张，用 Mathlib
  `LieAlgebra.ofTwoCocycle`）。复用调研见 `NOTES-virasoro-reuse.md`，署名见
  `StringFormal/Virasoro/ATTRIBUTION.md`。
  **剩余**（未做，不属本项）：
  - `H²(WittAlgebra R, R) ≅ R`，即"Virasoro 是 Witt 的**唯一**非平凡一维中心扩张"。
    Mathlib v4.33.1 有 2-cocycle 但没有 2-coboundary / 上同调商，需先补 `twoCoboundary`
    （或等上游）。图节点 `worldsheet.virasoro-algebra` 的陈述断言了唯一性，`gaps` 里已记。
  - Virasoro 代数的基 `Basis (Option ℤ) R (VirasoroAlgebra R)`（`L n` 与 `C`）；
    做 Verma 模时才需要。**已部分做掉**：`StringFormal/Virasoro/Verma.lean` 里的
    `VirasoroAlgebra.span_lgen_cgen_eq_top`（`Vir = span_R ({C} ∪ {L n})`）与
    `VirasoroAlgebra.toProdₗ`（线性同构 `Vir ≃ₗ Witt × R`）；完整的 `Basis` 还没造，
    目前也没有地方需要它。
- [x] `witt-virasoro-perfect`：Witt 与 Virasoro 代数完美（`⁅⊤, ⊤⁆ = ⊤`），对应图节点
  `math.witt-algebra-perfect` 与 `math.virasoro-universal-central-extension` 的第 (1) 条。
  见 `StringFormal/Virasoro/WittPerfect.lean`（无 sorry，公理只有标准三条）：
  `WittAlgebra.isPerfect`（需 `[Invertible (2 : R)]`）、`VirasoroAlgebra.isPerfect`
  （`ℚ`-代数，`C = 2⁅L 2, L (-2)⁆ - 4⁅L 1, L (-1)⁆` 见 `VirasoroAlgebra.cgen_eq`）。
  **数学缺口**：`2` 可逆是必要的，`WittAlgebra.derivedSeries_one_eq_top_iff` 给出
  `⁅⊤,⊤⁆ = ⊤ ↔ IsUnit (2 : R)`；`ZMod 2` 与 `ℤ` 上不完美
  （`derivedSeries_one_ne_top_zmod_two` / `derivedSeries_one_ne_top_int`）。
  教科书里"任意交换环上 Witt 代数完美"的说法是错的。
- [x] `verma-module`：Verma 模 `V(c,h)` 的构造与分级；对应图节点 `worldsheet.verma-module`。
  见 `StringFormal/Virasoro/Verma.lean`（739 行，无 sorry，公理只有标准三条）。
  走的是**抽象路线**：`V(c,h) := U(Vir) ⧸ (L_n (n>0), L_0 - h, C - c 生成的左理想)`，
  底层用 Mathlib 的 `UniversalEnvelopingAlgebra`。做到：
  - `VermaModule R c h` 及其 `Module R` / `Module U(Vir)` / `LieRingModule` / `LieModule` 实例；
  - 最高权向量 `hwv` 与三条最高权关系；`exists_smul_hwv`（由 `|c,h⟩` 生成）；
  - `negSpan_eq_top`：`V(c,h)` 由**无序**负模态词 `L_{n_1}⋯L_{n_k}|c,h⟩`（`n_i < 0`）张成；
  - `lie_lgen_zero_wordAct` / `lie_lgen_zero_of_mem_levelSpan`：`L_0` 在 level `N` 上作用为 `h+N`；
  - `iSup_levelSpan_eq_top` + `levelSpan_fg`：`⨆_N V_N = V(c,h)`，每个 `V_N` 有限生成；
  - **level 平移** `lie_lgen_mem_levelSpan`（`k ≥ 1` 时 `L_{-k} : V_N → V_{N+k}`）与
    整数版 `lie_lgen_mem_levelSpan_of_neg`；辅助 `consComposition` / `lie_lgen_levelWord`。
    对任意交换 `ℚ`-代数 `R` 成立，不需要 `V(c,h) ≠ 0`（`levelSpan` 是按张成词定义的，
    不是按 `L_0` 特征子空间定义的）；
  - 域上（`[Field K] [CharZero K]`）：`isInternal_levelSpan`（`V = ⨁_N V_N`）与
    `levelSpan_eq_eigenspace`（`V_N` 恰为 `L_0` 的 `h+N` 特征子空间）；
  - 万有性质 `vermaLift` / `vermaLift_hwv` / `vermaLift_lie` / `eq_of_lie_of_eq_hwv`；
  - 副产品 `adjoin_range_uea_ι_eq_top`（`U(L)` 由 `ι '' L` 生成，Mathlib v4.33.1 没有）。
  **剩余**（不属本项，见下一条与图节点 `notes`）：PBW 基、`dim V_N = p(N)`、`V(c,h) ≠ 0`。
- [x] `descendant-weight-grading`：`L_0` 对**任意** Virasoro 模中降算符词的作用；对应图节点
  `worldsheet.descendant-weight-grading`。见 `StringFormal/Virasoro/DescendantGrading.lean`
  （无 sorry，公理只有标准三条）：`wordActOn R M l v` 是 `L_{n_1}⋯L_{n_k} v` 在任意
  `[LieRingModule (VirasoroAlgebra R) M]` 上的作用（在 Verma 模上按定义等于 `wordAct`，
  见 `wordActOn_verma`），`lie_lgen_zero_wordActOn` 给出
  `⁅L_0, wordActOn l v⁆ = (h - l.sum) • wordActOn l v`；取 `n_i = -k_i` 即图节点的 `h + Σ k_i`。
  **只用 `⁅L_0, v⁆ = h • v` 这一条假设**：最高权条件 `L_n v = 0 (n>0)` 与中心荷 `c` 都不进入
  计算（因为 `centralTerm R 0 = 0`）；带 `IsHighestWeightVector` 的版本是推论
  `lie_lgen_zero_wordActOn_of_isHighestWeightVector`。另有 `vermaLift_wordAct`：这些降算符
  向量是 Verma 模同名向量在 `vermaLift` 下的像。
  **未做**（图节点 `gaps` 已记）：这些向量的线性无关、张成性、`M` 的 `L_0` 本征空间分解。
- [ ] `pbw-verma`：Verma 模的 PBW 基。两半独立，**(a) 已做，(b) 未做**：
  - [x] (a) **straightening**：有序词张成 `V_N`，给出 `dim V_N ≤ p(N)`。
    见 `StringFormal/Virasoro/VermaPBW.lean`（无 sorry，公理只有标准三条）：
    - `IsOrdWord l`：`l` 是严格负、非降的模态表，即 `L_{-b_1} ⋯ L_{-b_k}`（`b_1 ≥ ⋯ ≥ b_k ≥ 1`）；
    - `straighten`：`L_a`（`a < 0`）作用在有序词上落在同总模态的有序词张成里；
    - `wordAct_mem_ordSpan`：**任意**负模态词都是同总模态有序词的线性组合；
    - `levelSpan_eq_ordSpan`、`levelSpan_eq_span_range_partitionWord`：`V_N` 由 `N` 的分拆
      （`Nat.Partition N`）指标化的有序词张成；
    - `finrank_levelSpan_le_card_partition`：域上 `dim V_N ≤ p(N)`。
    **不用逆序数**：换序步与对易子步都严格增大 `wordWeight l = Σ_i i·l_i`（表头不贡献），
    故 `wordMeasure l = (-wordWeight l).toNat` 严格下降，单一 ℕ 测度即可归纳。
    关键的记账是 `straighten` 的结论要带「输出有序词的测度 ≤ 输入词的测度」这一上界，
    否则 Leibniz 第二项 `⁅L b, ⁅L a, X⁆⁆` 的嵌套整理无法被归纳假设覆盖
    （内层整理可能产生比原尾巴更长的词）。
  - [ ] (b) **线性无关**：即 `U(Vir_-)` 的 Poincaré–Birkhoff–Witt + 诱导模的自由性。
    Mathlib v4.33.1 **没有** PBW（`Algebra/Lie/Free.lean`、`SerreConstruction.lean` 都注明缺）。
  `V(c,h) ≠ 0` 是 (b) 的推论；在 (b) 之前 `Verma.lean` / `VermaPBW.lean` 里的一切都可能是空洞真，
  `dim V_N = p(N)` 也只证到 `≤`。这一项是 `shapovalov-form` 与 `kac-determinant` 的前提。
- [x] `shapovalov-form`：Shapovalov（逆变）形式。见 `StringFormal/Virasoro/Shapovalov.lean`
  （无 sorry，公理只有标准三条）：
  - `VirasoroAlgebra.antiInvolution`：反对合 `σ : L_n ↦ L_{-n}`、`C ↦ C`，
    `antiInvolution_lie : σ⁅X,Y⁆ = ⁅σY, σX⁆`、`antiInvolution_involutive`。
    中心项 `(n³-n)/12` 在 `n ↦ -n` 下变号，恰与括号反序的负号抵消（`cocycleBilin_antiInvolution`）。
  - `IsContravariant B`：`B(L_n x, y) = B(x, L_{-n} y)`。
  - **`eq_of_isContravariant`：唯一性无条件成立**（只用 `negSpan_eq_top`，不需要 PBW / 分级 /
    `V ≠ 0`）；推论 `IsContravariant.flip_eq`（**对称性是定理不是公理**）、
    `IsContravariant.eq_zero_of_level_ne`（不同 level 正交）。
  - `ContraDual`：`V(c,h) →ₗ R` 带 **σ-扭** 作用 `(X·f)(v) = f(σX·v)` 的 Virasoro 模
    （类型同义词，因为 Mathlib 的 `Module.Dual.instLieRingModule` 已经在这个类型上放了未扭的
    余伴随作用）。
  - **存在性只差一条**：`IsShapovalovFunctional f`（`f|c,h⟩ = 1`，且 `f` 杀掉 `L_n V (n<0)`、
    `(L_0-h)V`）。由它经万有性质得 `shapovalov`，逆变性由 `vermaLift_lie` 一行推出；
    `existsUnique_isContravariant` 给出存在唯一；`exists_isContravariant_iff` 说这条假设
    **不只是充分条件而是等价**（归一化逆变型 ↔ Shapovalov 泛函）。
    这条假设**不可去**：`hwv_ne_zero_of_isContravariant` 说归一化的逆变型蕴含 `V(c,h) ≠ 0`，
    而后者正是 `pbw-verma` (b) 的推论。故在 (b) 之前不可能有无条件构造。
  - **char-0 域上存在性已收紧为 iff**（2026-09-11）：`levelSpan_zero`（`V_0 = R·|c,h⟩`，任意
    `ℚ`-代数）+ `isCompl_levelSpan_zero`（`V = V_0 ⊕ ⨁_{N≥1} V_N`）+ level 平移
    ⇒ `hwvFunctional`（level-0 坐标）是 Shapovalov 泛函，
    `exists_isShapovalovFunctional_of_hwv_ne_zero`、`exists_isContravariant_of_hwv_ne_zero`、
    `exists_isContravariant_iff_hwv_ne_zero`（**存在 ⟺ `hwv ≠ 0`**）、
    `existsUnique_isContravariant_of_hwv_ne_zero`。
    即：在 `[Field K] [CharZero K]` 上，Shapovalov 形式的唯一缺口就是 `V(c,h) ≠ 0`
    （`pbw-verma` (b)），`IsShapovalovFunctional` 不再是独立假设。
    一般交换 `ℚ`-代数 `R` 上是否也成立**未定**：构造用了 `isInternal_levelSpan`，
    而后者只在 char-0 域上有（level 片靠 `L_0` 特征值 `h+N` 分离）。
  - 低阶 Gram：`gram_level_one`（`2h`）、`gram_level_two_aa/ab/bb`（`4h+c/2`、`6h`、`8h²+4h`）、
    `gram_level_two_det`（`2h(16h² + 2h(c-5) + c)`，即 `N=2` 的 Kac 行列式）。
    这些是对**具体向量** `L₋₁|c,h⟩`、`L₋₂|c,h⟩`、`L₋₁²|c,h⟩` 说的；它们张成 `V_N`
    （`desc*_mem_levelSpan`），但线性无关仍缺 → 与「Kac 行列式」的等同还差 `pbw-verma` (b)。
- [ ] `kac-determinant`：Kac 行列式公式。这是独立的、有价值的数学形式化目标；对应 `worldsheet.kac-determinant`。可能很长，允许先做低阶（N ≤ 3）的显式版本。`N = 1, 2` 的显式 Gram 矩阵已在 `Shapovalov.lean`（对具体向量，非基）。

## 无鬼定理岛

- [x] `fock-space`：`D` 个玻色振子的 Fock 空间，带 `η` 诱导的不定内积。
  见 `StringFormal/NoGhost/Fock.lean`：`Fock D R = MvPolynomial (Fin D × ℕ+) R`（任意
  `CommRing R`，因为内积矩阵元 `∏ (n η^{μμ})^k k!` 没有分母），带：
  - 振子代数 `annihilation_creation_sub` 与 Lie 括号版 `lie_annihilation_creation`
    （`[α^μ_m, α^ν_{-n}] = m η^{μν} δ_{m,n}`）、`lie_creation_creation`、
    `lie_annihilation_annihilation`；
  - level 分级 `levelSubmodule`（= Mathlib `weightedHomogeneousSubmodule`），
    `creation_mem_levelSubmodule` / `annihilation_mem_levelSubmodule`，每片有限生成
    `levelSubmodule_fg` / `levelSubmodule_finite`（`finite_setOf_level_eq`）；
  - 不定双线性型 `pairing η`：对称 `pairing_comm`，伴随关系
    `pairing_creation_left` / `pairing_creation_right`，level 正交
    `pairing_eq_zero_of_level_ne`，单项式基下的显式对角公式
    `pairing_monomial_monomial`，以及**唯一性** `pairing_unique`（〈 0|0 〉 = 1 加
    互为伴随完全确定这个形式）；
  - 不定性的显式见证 `pairing_X_X_minkowski_timelike`（`α^0_{-n}|k⟩` 模为 `-n`）。
  公理检查：全部声明只用 propext / Classical.choice / Quot.sound。
  **本项未做（留给后续）**：零模（动量 `k`、算符 `x^μ, p^μ`）不在本文件里，
  `L₀` 依赖它们，做 Sugawara 时必须先补；度规只支持对角 `η : Fin D → R`；
  未取完化（代数 Fock 空间，不是 Hilbert 空间）；未做复双线性/埃尔米特版本。
  图侧：节点 `worldsheet.bosonic-fock-space`（定义卡）与
  `worldsheet.fock-indefinite-form`（命题卡）已由 curator 添加。
- [x] `sugawara`：`L n` 在 Fock 空间上的作用，Virasoro 关系与 `c = D`。
  见 `StringFormal/NoGhost/Sugawara.lean`（约 1400 行，无 sorry，公理只有标准三条）。
  零模按**参数**处理：`a : Fin D → R` 代表 `a^μ = α^μ_0 = (2α')^{1/2} k^μ`（`x^μ` 未引入，
  无鬼定理不需要）。度规仍是对角 `η : Fin D → R`，且**所有实质命题都带假设
  `hη : ∀ μ, η μ * η μ = 1`**（即 `η_{μμ} = η^{μμ}`，`minkowski` 满足），因为同一个 `η`
  既用于对易关系又用于缩并时空指标。做到：
  - `mode η a μ j`（任意 `j : ℤ` 的 `α^μ_j`：`j>0` 湮灭、`j<0` 产生、`j=0` 标量 `a^μ`）
    与全模态对易关系 `lie_mode_mode`；
  - `lsumLocFin`：**局部有限**算子族的和，这是「`Σ_{j∈ℤ}` 在代数 Fock 空间上逐向量只有
    有限多非零项」的形式化，不需要任何收敛性假设；
  - `Lop η a n = ½ Σ_{j∈ℤ} :α_{n-j}·α_j:`（`nordPair` 是产生-湮灭正规序，`a^X = 0`），
    以及「用任何足够大的有限指标集计算」的 `Lop_apply`；
  - `lie_Lop_mode`：**`[L_m, α^ν_p] = -p α^ν_{m+p}`**；
  - `eq_smul_id_of_lie_mode`：Fock 表示的**不可约性/刚性**（与所有模态对易的算子是标量）；
  - `Lop_apply_one_of_pos`（`L_n|k⟩ = 0`, `n ≥ 1`）、`Lop_zero_apply_one`
    （`L_0|k⟩ = α'k²|k⟩`）、`Lop_zero_apply_of_mem_levelSubmodule`
    （**`L_0 = α'k² + N` 在 level `N` 片上**）；
  - `lie_Lop_Lop`：**`[L_m,L_n] = (m-n)L_{m+n} + D·(m³-m)/12·δ_{m+n,0}`，即 `c = D`**；
  - `virRep` / `virRep_lgen` / `virRep_cgen` / `virRep_lie`：`L n ↦ L_n`、`C ↦ D·id`
    的线性映射及其保李括号性质（未打包成 `LieHom`：Mathlib v4.33.1 只把
    `Module.End R M` 的 `LieRing` 结构做成 `local instance`）。
  证明路线（不走硬算重排）：`[L_m,α_p]` → Jacobi ⇒ `W_{m,n} := [L_m,L_n]-(m-n)L_{m+n}`
  与所有模态对易 ⇒ 刚性给出 `W = z(m,n)·id` ⇒ `z(m,0)=0` 加 2-上闭链恒等式给出
  `m+n≠0` 时 `z=0` 与对角上的递推 `(m-1)z(m+1)=(m+2)z(m)` ⇒ 真空上算两个初值
  `z(1,-1)=0`、`z(2,-2)=D/2`（`D` 只在 `Σ_μ η^{μμ}η_{μμ}=D` 这一处进入）。
  **本项未做**：`L_m` 与全纯能动张量 Laurent 模的等同（那是 `--via-ope` 那条推导的内容）；
  `L_m^† = L_{-m}` 对 `Fock.pairing` 的伴随性；正定性/幺正性。
  图侧：建议 curator 把 `worldsheet.virasoro-generators-free-boson` 的
  `formal.lean_decl` 填 `StringFormal.NoGhost.Fock.Lop`，把
  `worldsheet.free-boson-central-charge-d--via-mode-algebra` 标 `formalized`，
  `lean_decl` 填 `StringFormal.NoGhost.Fock.lie_Lop_Lop`。
- [x] `fock-indefinite-over-ordered-ring`：`worldsheet.fock-indefinite-form` 第 (4) 条末句
  「有序域上、`D ≥ 2` 时该形式不定」的形式化（即推导节点
  `worldsheet.fock-indefinite-form--via-lean` 的 gap (v)）。
  见 `StringFormal/NoGhost/FockSigned.lean`（不改 `Fock.lean`，只加序假设）：
  `pairing_timelike_neg` / `pairing_spacelike_pos`（每个 level `n ≥ 1` 的显式见证）、
  `exists_pairing_self_neg`（需 `D ≥ 1`）、`exists_pairing_self_pos`（需 `D ≥ 2`）、
  `pairing_indefinite`（主结论，有序环上）、`pairing_indefinite_field`（按图节点措辞的有序域版）、
  `not_forall_pairing_self_nonneg` / `not_forall_pairing_self_nonpos`、
  `exists_mem_levelSubmodule_pairing_self_neg`（每个 level 都有鬼，不只集中在一片）。
  注意：Mathlib v4.33.1 **已无** `LinearOrderedField` 类，有序域写作
  `[Field K] [LinearOrder K] [IsStrictOrderedRing K]`；证明只需有序环，域与全序都用不上。
  公理检查：全部声明只用 propext / Classical.choice / Quot.sound。
- [x] `physical-states`：`H_phys` 子模与零模态。
  见 `StringFormal/NoGhost/PhysicalStates.lean`（约 800 行，无 sorry，公理只有标准三条）。
  截距记作 `a₀ : R`（`a` 已被零模参数占用；符号按 `conv.intercept-sign-a`）。做到：
  - **`L_m^† = L_{-m}`**：`pairing_Lop_left`（`⟨L_m v, w⟩ = ⟨v, L_{-m} w⟩`），经
    `pairing_mode_left`（全部 `j : ℤ` 含 `j = 0` 标量）→ `pairing_nordPair_left` →
    对 `lsumLocFin` 用对称有限指标区间加 `Finset.sum_equiv (Equiv.neg ℤ)`。这是
    Sugawara 那条的缺口 5，不需要 `hη`。
  - `physSubmodule η a a₀ = ker(L_0 - a₀) ⊓ ⨅_{n>0} ker L_n`，`mem_physSubmodule`；
  - **齐次性**：`mode_mem_levelSubmodule` / `nordPair_mem_levelSubmodule` /
    `Lop_mem_levelSubmodule`（`L_n` 把 level `M` 送进 level `M-n`，`M<n` 时为零）、
    `levelComponent_Lop`（`L_n` 与 level 投影交换）；由此 **`H_phys` 按 level 分级**：
    `levelComponent_mem_physSubmodule`、`physSubmodule_eq_iSup_inf_levelSubmodule`；
  - **质量壳**：`mem_physSubmodule_iff_of_mem_levelSubmodule`（level `N` 上 `L_0` 条件即
    `(α'k² + N - a₀) • ψ = 0`）、`massShell_of_mem_physSubmodule`（无零因子环上非零物理态
    强迫 `α'k² + N = a₀`）；
  - `nullSubmodule = H_phys ⊓ orthComplement H_phys`、`spuriousSubmodule = ⨆_{n>0} range L_{-n}`，
    **`spuriousSubmodule_le_orthComplement`**（伪态 ⊥ 物理态）与
    **`spurious_inf_physSubmodule_le_nullSubmodule`**（伪 ∩ 物理 ⊆ 零模）；
  - **level 1**：`exists_polState_of_mem_levelSubmodule_one`（level 1 态都是 `ζ·α_{-1}|k⟩`）、
    `mem_physSubmodule_inf_levelSubmodule_one_iff`（`H_phys ∩ F_1` = 横向极化 `ζ·k = 0` 加壳
    `α'k² + 1 = a₀`）、`Lop_neg_one_apply_one_mem_nullSubmodule`（`a₀ = 1`、`k² = 0` 时
    `L_{-1}|k⟩` 是物理零模态：光子纵向极化退耦）。
  **本项未做**：反向包含"零模态 ⊆ 伪态"（无鬼定理核心）；`a₀ = 1` 的唯一性与 level 2 分析；
  `⨆` 未打包成 `DirectSum.IsInternal`；双线性而非半双线性形式。
  图侧：建议 curator 把 `worldsheet.old-covariant-physical-states` 的 `formal.lean_decl`
  填 `StringFormal.NoGhost.Fock.physSubmodule`；`worldsheet.spurious-orthogonal-to-physical`
  新建 `--via-lean` 推导指向 `spuriousSubmodule_le_orthComplement`；
  无壳的 `worldsheet.spurious-subspace`（已建、formalized）的 `lean_decl` 是 `spuriousSubmodule`；带壳的 `worldsheet.ocq-spurious-states-v2` 不填 `lean_decl`（2026-09-11 已落地）；
  `worldsheet.open-string-intercept--via-null-state-decoupling` 的 level 1 半边可引
  `Lop_neg_one_apply_one_mem_nullSubmodule`（但该推导还需 level 2 与唯一性，不能标 formalized）。
- [x] `spurious-shell`：带质量壳的伪态 S(k) = S ∩ ker(L_0 − a₀) 与零态 N(k) = S(k) ∩ H_phys。
  见 `StringFormal/NoGhost/SpuriousShell.lean`（无 sorry，公理只有标准三条）。对应图节点
  `worldsheet.ocq-spurious-states-v2`（Polchinski (4.1.8)/(4.1.9)）。做到：
  - `spuriousShell η a a₀ = spuriousSubmodule η a ⊓ ker(L_0 − a₀·id)`，`mem_spuriousShell`；
  - `nullStates η a a₀ = spuriousShell ⊓ physSubmodule`；
  - **`nullStates_eq`**：`nullStates = spuriousSubmodule ⊓ physSubmodule`，即零态的定义
    对「S 带不带质量壳」不敏感（因 `physSubmodule ≤ ker(L_0 − a₀)`，见
    `physSubmodule_le_ker_Lop_zero_sub`）——这正是 v2 卡陈述里那句话；
  - **`nullStates_le_nullSubmodule`**：N(k) ⊆ H_0(k)（H_phys 的根基），由
    `spurious_inf_physSubmodule_le_nullSubmodule` 一行；配套
    `pairing_self_eq_zero_of_mem_nullStates`（零态零范数）、`spuriousShell_le_orthComplement`、
    `Lop_neg_apply_mem_nullStates`。
  **本项未做**：反包含 H_0(k) ⊆ N(k)（临界维数命题，D = 26、a₀ = 1，图上尚无节点）；
  没有把 on-shell 伪态分解成 Σ_{n≥1} L_{−n}（各自在壳的）|χ_n⟩。
  图侧：建议把 `worldsheet.ocq-spurious-states-v2` 的 `formal.lean_decl` 填
  `StringFormal.NoGhost.Fock.spuriousShell`（并在 notes 记 `nullStates` 与 `nullStates_eq`），
  `lean_file` 填 `formal/StringFormal/NoGhost/SpuriousShell.lean`；这会撤销该卡 notes 里
  「Lean 侧没有这个子模，故不填 lean_decl」的记账。
- [x] `quotient-form`：`H_phys / H_null` 上诱导形式良定义 ——
  `StringFormal/NoGhost/QuotientForm.lean`（图节点 `worldsheet.spurious-orthogonal-to-physical`
  的后半句）。`Fock.pairing_add_null`（`⟨ψ+χ, φ+χ'⟩ = ⟨ψ,φ⟩`，ψ,φ ∈ H_phys，χ,χ' ∈ H_null）、
  `Fock.pairing_eq_of_sub_mem_nullSubmodule`（差式版本）、`Fock.nullInPhys` / `Fock.PhysQuot`
  （= `physSubmodule ⧸ nullSubmodule.comap physSubmodule.subtype`）、两次 `Submodule.liftQ`
  得到的 `Fock.quotientPairing : LinearMap.BilinForm R (PhysQuot η a a₀)`，计算规则
  **`Fock.quotientPairing_mk`** 与对称性 `Fock.quotientPairing_comm`。
  **未做**：非退化性（`∀ q', ⟨q,q'⟩ = 0 → q = 0`，形式上 routine 但没写）与正定性（无鬼定理本体）。
  图侧：建议 `worldsheet.spurious-orthogonal-to-physical--via-lean` 的 `lean_decl` 列
  `spuriousSubmodule_le_orthComplement` 与 `quotientPairing_mk`，从 rigorous 升回 formalized。
- [ ] `ddf-operators`：DDF 算子及其对易关系（横向振子代数）。**部分完成**，见
  `StringFormal/NoGhost/VertexOperator.lean`（顶点算子振子部分）与
  `StringFormal/NoGhost/DDF.lean`（动量塔）。两个文件都无 sorry，公理只有标准三条。

  **路线选择：走了 lead 倾向的 (A) 多动量 Fock 空间路线**，不是 (B) 公理化。理由：
  (B) 把 DDF 算子的存在性设为假设，形式化的就只是"无鬼定理在 DDF 存在下的推论"，
  而无鬼定理的全部力气恰恰在于构造这些算子，价值很低。选 (A) 之后发现工程量比预期小，
  因为在**代数** Fock 空间 `MvPolynomial (Osc D) R` 上顶点算子的两半都是初等的：
  - 产生半 `E_-(z) = exp(Σ_{m≥1} (b·α_{-m}/m) z^m)` 只是"乘以交换环 `Fock D R` 的一个元素"，
    其单项式系数就是经典指数权 `∏ (η_μ b^μ)^{d(v)} / (v.2^{d(v)} d(v)!)`；它的**全部**所需性质
    （`∂/∂X_{μ,m}` 把它乘上 `η_μ b^μ / m` 并把 z 次数降 m）在系数层面一行可证，
    不需要任何"exp 的乘法性质"或 Schur 多项式组合学。
  - 湮灭半 `E_+(z) = exp(-Σ_{l≥1} (b·α_l/l) z^{-l})` 的指数是**常系数导子**
    （在 `η^{μμ}η_{μμ}=1` 下 `b·α_l/l = Σ_μ b^μ ∂/∂X_{μ,l}`），所以 `E_+` 就是**变量平移**
    `X_{μ,l} ↦ X_{μ,l} - b^μ T^l`，即一个到 `Polynomial (Fock D R)` 的代数同态
    （`vertexSub`），其 `T^L` 系数就是多项式取系数。完全不需要收敛性。
  - 二者的乘积 `V_K = Σ_L Φ_{K+L} Ψ_L` 用 `Sugawara.lean` 已有的 `lsumLocFin` 实现：
    逐向量只有有限多项非零（`Ψ_L` 在 `L` 超过平移后多项式的次数时为零）。

  已做（(1)(2) 全做完，(3) 只做了归约不含底）：
  - [x] (1) **动量塔与移位算子**：`TowerFock D R = ℤ →₀ Fock D R`，第 `j` 层动量参数
    `towerMomentum a b j = a + j·b`（`b^μ = (2α')^{1/2} k_0^μ`；与图节点的 `k - N k_0` 的
    字典是 `j = -N`）；`towerShift n`（= `e^{i n k_0·x}`，把第 `j` 层送到第 `j+n` 层）、
    `towerDiag`、`towerMode`、`towerLop`，以及 `lie_towerLop_towerMode`。
    另有动量算术：`dotVec_towerMomentum_right_of_isotropic`（`k_0²=0` ⟹ `k_0·p` 沿塔不变，
    即图节点 ddf-operators-v4 说明 (b)）与 `invTwo_mul_zeroModeSq_towerMomentum`
    （`α'(k - N k_0)² = α'k² - N`，即 no-ghost-theorem-v4 (1b) 的质量壳记账）。
  - [x] (1b) **塔上的双线性型**（`StringFormal/NoGhost/TowerPairing.lean`，图节点
    `worldsheet.momentum-tower-fock-space` (2)(4)）：`Fock.towerPairing η = Σ_j ⟨·_j, ·_j⟩`
    作为 `LinearMap.BilinForm`；层间正交 `towerPairing_single_single_of_ne`、对称
    `towerPairing_comm`、以及三条伴随 `towerPairing_towerShift_left`（`(e^{ink_0·x})^† = e^{-ink_0·x}`，
    层间关系，**不是** `Fock.lean` 任何引理的推论）、`towerPairing_towerMode_left`、
    `towerPairing_towerLop_left`（后两条逐层继承 `pairing_mode_left` / `pairing_Lop_left`）。
    另补 `towerShift_apply` / `towerDiag_apply` / `towerMode_apply` / `towerLop_apply`
    （DDF.lean 只有 single 上的公式）。顶点算子 `towerVertex` 的伴随仍未做（需
    `vertexOsc` 的伴随，图节点 `worldsheet.vertex-operator-adjoint`），故 `A^i_n` 的伴随不可用。
  - [x] (2) **指数顶点算子的振子部分**：`Fock.creaExp`（产生半的 Laurent 系数）、
    `Fock.vertexSub` / `Fock.vertexAnn`（湮灭半）、`Fock.vertexOsc η b K`（`z^K` 系数）。
    核心定理 **`Fock.lie_mode_vertexOsc`**：`[α^μ_p, V_K] = b^μ V_{K-p}`（`p ≠ 0`）；
    `Fock.lie_mode_zero_vertexOsc`：单个 Fock 空间上 `p = 0` 的括号**为零**（物理关系需要动量移位）；
    **`Fock.mode_vertexOsc_sub`**：左边用参数 `a+b`、右边用参数 `a` 的双动量形式，对**所有** `p`
    （含 0）成立；塔上的版本是 **`lie_towerMode_towerVertex`**。
    分级：`Fock.vertexOsc_mem_levelSubmodule`（`V_K` 把 level `N` 抬到 `N+K`）与
    `Fock.vertexOsc_apply_eq_zero_of_level`（`N+K<0` 时为零）。
    横向性：`lie_towerMode_towerVertex_of_eq_zero`（`b^μ = 0` ⟹ 与所有 `α^μ_p` 对易）。
  - [x] (3) **共形权 `[L_m, V]`**：`m ≠ 0` **已证**（`m ≥ 1` 见 (3d) 单 Fock、(3e) 塔上；
    `m ≤ -1` 见 (3c')、(3f)；`m = 0` 见 (3c)，只有真空上的形式）。陈述是
    `L_m^{(a+b)} V_J - V_J L_m^{(a)} = (J + b·a - m + (m+1)·½ b·b) V_{J-m}`，权
    `h = ½ b·b = α' k_0²`，故 `k_0² = 0` 给权 0。已做的是它的**归纳步**：
    `Fock.eq_zero_of_vertex_recursion` / `Fock.vertexOsc_unique`（满足产生模态递推且在真空上
    取定值的算子族唯一），加上 `Fock.mode_vertexOsc_sub` 与 `Fock.lie_Lop_mode`，把该恒等式
    **归约为真空上的单条等式**，即计算 `L_m` 作用在相干态系数 `creaExp` 上。
    做它需要的组合输入已经看清楚：欧拉型递推 `M·Φ_M = Σ_{l=1}^{M} (b·α_{-l}) Φ_{M-l}`，
    在系数层面等价于 `Σ_v (η_{v.1} b^{v.1}) w(d - e_v) = (level d) · w(d)`，可由
    `Fock.expWeight_add_single` 直接得到。
    - [x] (3a) 上述**欧拉型递推已证**：`Fock.creaExp_euler`（`StringFormal/NoGhost/VertexWeight.lean`），
      连同辅助引理 `Fock.level_sub_single_add`、`Fock.expWeight_sub_single`；
      无 sorry，公理只有标准三条。求和索引写成 `l ∈ Finset.range M` 配 `l.succPNat`，
      即模态跑遍 `1, …, M`。
    - [x] (3b) 真空上的单条等式，`m ≥ 1` 的情形**已证**：
      `Fock.Lop_apply_creaExp_of_pos`（`StringFormal/NoGhost/VertexWeight.lean`）
      `L_m Φ_J = (a·b + ½ (m-1)(b·b) + (J - m)) Φ_{J-m}`，对任意 `J : ℤ` 成立
      （`J < m` 时两边都为零）。证明把 `L_m = ½ Σ_j :α_{m-j}·α_j:` 的指标分成五段
      （`j ≤ -1` / `j = 0` / `1 ≤ j ≤ m-1` / `j = m` / `j ≥ m+1`），两条产生尾用
      `Fock.sum_mode_creaExp_eq_smul`（(3a) 的 `mode` 形式）求和。
      推论 `Fock.Lop_apply_creaExp_of_pos_shifted`（零模参数 `a → a+b`）给出
      `L_m^{(a+b)} Φ_J = (J - m + a·b + ½ (m+1)(b·b)) Φ_{J-m}`，与本项 (3) 记录的文献形式
      `(J + b·a - m + (m+1)·½ b·b)` **逐项相符**，即权 `h = ½ b·b`。
      交叉验证：`Fock.Lop_one_apply_creaExp_one`（由上式）与
      `Fock.Lop_one_apply_creaExp_one_via_mode`（由对易子 `Lop_apply_mode_one`）
      在 `m = J = 1` 给出同一答案。无 sorry，公理只有标准三条。
    - [x] (3c) `m = 0`：`Fock.Lop_zero_apply_creaExp`，`L_0 Φ_J = (α'k² + J) Φ_J`。
      **数学要点**：它不是 (3b) 在 `m = 0` 的特例——`m ≥ 1` 时 `j = 0` 与 `j = m` 是两项、
      各出 `½ (a·b)`，`m = 0` 时并成一项 `½ (a·a)`，把 `m = 0` 代入 (3b) 会得到错误的
      `a·b - ½ (b·b) + J`。因为 `Φ_J` 是 level `J` 齐次元，这条直接由已有的
      `Fock.Lop_zero_apply_of_mem_levelSubmodule` 得到。
    - [x] (3c') `m < 0` 的真空等式：**已证**
      `Fock.Lop_apply_creaExp_of_neg_shifted`（`StringFormal/NoGhost/VertexWeightNeg.lean`）
      `L_m^{(a+b)} Φ_J = (J - m + a·b + ½(m+1)(b·b)) Φ_{J-m} + V_J (L_m^{(a)}|k⟩)`。
      形状确实与 `m ≥ 1` 不同：第二项是含产生算子的真向量。分三步做：
      * `Fock.Lop_apply_one_of_neg`：`L_m|k⟩ = (α_m·α_0)|k⟩ + ½ Σ_{j=m+1}^{-1}(α_{m-j}·α_j)|k⟩`
        （Sugawara 指标集在真空上是 `Finset.Icc m 0`；两端点项相等、合起来抵掉 `½`）。
      * `Fock.Lop_apply_creaExp_of_neg`：`L_m Φ_J` 的显式表达式。与 (3b) 的五段分法相比，
        中间段 `m+1 ≤ j ≤ -1` 两个因子都是产生算子（非标量项，用新引理
        `Fock.nordPair_apply_of_neg_left`：`i < 0` 时对**任意** `j` 都不必换序），
        两条产生尾换元后只覆盖 `l ≥ -m+1`，所以欧拉递推
        `Fock.sum_mode_creaExp_eq_smul` 要减掉头 `-m` 项。
      * `Fock.vertexOsc_apply_Lop_apply_one_of_neg`：把 `V_J` 穿过 `L_m|k⟩` 的每个产生算子
        （`Fock.vertexOsc_mode_of_ne` / `_apply_mode_one` / `_apply_mode_mode_one`）。
        **数学要点**：双产生中间段经 `j ↦ m - j` 给出两个相等的单缩并求和（`½` 被吃掉），
        双缩并的重数是 `#{m+1,…,-1} = -m-1`，产生的常数正好是
        `-(a·b + ½(m+1)(b·b))`，与共形权系数里除 `(J-m)` 之外的全部逐项抵消。
        这个抵消是 `m < 0` 半能成立的关键，也说明系数**对所有 `m ≠ 0` 是同一个多项式**。
      无 sorry，公理只有标准三条。
    - [x] (3d) 完整的 `[L_m, V_J]`，`m ≥ 1`：**已证**
      `Fock.lie_Lop_vertexOsc_of_pos`（`StringFormal/NoGhost/VertexWeight.lean`）
      `L_m^{(a+b)} ∘ V_J - V_J ∘ L_m^{(a)} = (J - m + a·b + ½ (m+1)(b·b)) • V_{J-m}`。
      证明按预定路线：两边作为 `ℤ → Module.End` 的族满足**同一条**产生模态递推，
      再由 `Fock.eq_zero_of_vertex_recursion` 归约到真空，真空上是 (3b) 的
      `Fock.Lop_apply_creaExp_of_pos_shifted` 加 `Lop_apply_one_of_pos`（`m ≥ 1` 时 `L_m|k⟩ = 0`）。
      递推的关键在于系数对 `J` 是**斜率 1 的仿射函数**：`c(J+l) = c(J) + l`，这恰好抵消
      `⁅α^μ_{-l}, L_m⁆ = -l α^μ_{m-l}` 产生的多余项 `l · V_{J+l-m}`，两边才同构。
      辅助引理 `Fock.Lop_apply_X_mul`（`⁅L_m, α_p⁆` 的逐点形式）。
      推论 `Fock.lie_Lop_vertexOsc_of_pos_isotropic`（`b·b = 0` 时右端为 `(J - m + a·b)`）。
      无 sorry，公理只有标准三条。
    - [x] (3e) 塔上版本，`m ≥ 1`：`lie_towerLop_towerVertex_of_pos`
      （`StringFormal/NoGhost/VertexWeight.lean`）
      `⁅L_m, V^{(n)}_K⁆ = (K - m - n + n (k_0·p)) • V^{(n)}_{K-m}`，
      归一化推论 `lie_towerLop_towerVertex_of_pos_normalized`（`k_0² = 0` 且 `2α' k_0·p = 1`）
      给 `⁅L_m, V^{(n)}_K⁆ = (K - m) • V^{(n)}_{K-m}`，即 `towerVertex` 是权 **0** 的准初级场
      （权 1 来自 DDF 算子里的 `∂X^i`，不属于 `towerVertex`）。
      **数学要点（本项发现）**：塔上版本**必须**假设 `k_0² = 0`（`dotVec η b b = 0`），
      这不是为方便。单个 Fock 空间上的系数在第 `j` 级是
      `(K-n) - m + n(k_0·p) + (jn + ½(m+1)n²)(k_0²)`，含 `j`；`k_0² ≠ 0` 时
      `⁅L_m, V^{(n)}_K⁆` 在整条塔上**不是** `V^{(n)}_{K-m}` 的标量倍，只是逐级成比例、
      比例因子依赖动量级数 `j`。单 Fock 版本 (3d) 则对任意 `b` 成立，不需要 `b·b = 0`。
      无 sorry，公理只有标准三条。
    - [x] (3f) `m < 0` 的 `[L_m, V_J]`：**已证**
      `Fock.lie_Lop_vertexOsc_of_neg`（`StringFormal/NoGhost/VertexWeightNeg.lean`）
      `L_m^{(a+b)} ∘ V_J - V_J ∘ L_m^{(a)} = (J - m + a·b + ½(m+1)(b·b)) • V_{J-m}`，
      系数与 `m ≥ 1` 的 (3d) **完全相同**。(3d) 用到 `m ≥ 1` 的两处里，只有真空那处
      真正依赖符号：`Fock.eq_zero_of_vertex_recursion` 的产生模态递推逐字照搬即可，
      真空值换成 (3c') 的 `Fock.Lop_apply_creaExp_of_neg_shifted`。
      合并推论：`Fock.lie_Lop_vertexOsc_of_ne`（一切 `m ≠ 0`）与
      `Fock.lie_Lop_vertexOsc_of_ne_isotropic`（`b·b = 0`，DDF 归一化下的权 1 变换律）。
      无 sorry，公理只有标准三条。
      **仍缺**：`m = 0` 的一般态算子形式（真空上是 (3c)；`m = 0` 时 Sugawara 的
      `j = 0` 与 `j = m` 并成一项，系数多项式在 `m = 0` 处**不适用**，见 (3c) 的要点）。
      塔上的负模对应物已由 (5) 补齐。
  - [x] (4) **DDF 算子本身与 `⁅L_m, A^ε_n⁆ = 0`（`m ≥ 1`）**：
    `StringFormal/NoGhost/DDFOperator.lean`，无 sorry，28 条声明公理只有标准三条。
    - 偏振经由**收缩**进入：`towerModeVec η a b ε p = Σ_μ η_μ ε^μ α^μ_p`（`α^ε_p`），
      横向性是 `dotVec η ε b = 0`（`ε·k_0 = 0`）。
      `lie_towerModeVec_towerVertex`：`⁅α^ε_p, V^{(n)}_K⁆ = n (ε·k_0) V^{(n)}_{K-p}`，
      横向时给 `towerModeVec_mul_towerVertex_of_transverse`（严格对易，含 `p = 0`）。
    - **局部有限性**（图节点 `worldsheet.ddf-transversality-gives-local-finiteness`）：
      `ddfSummand_apply_eq_zero_of_notMem_window`。窗口 `ddfWindow n x =
      Icc (n - towerLevelBound x) (towerModeBound x)`，两端机制**不同**：
      下端只靠 `towerVertex_apply_eq_zero_of_lt`（顶点算子不能把 level 降到真空以下，
      与横向性无关），上端**必须**用横向性把 `α^ε_j` 移到右边变成高指标湮灭算子。
      为此新增 `Fock.levelBound`（`P.support.sup (level D)`）与
      `Fock.vertexOsc_apply_eq_zero_of_levelBound_lt`，以及塔上的
      `towerLevelBound` / `towerModeBound`。
    - `ddfOp η a b ε hη hεb n`（`A^ε_n = Σ_{j∈ℤ} α^ε_j V^{(n)}_j`，用 `lsumLocFin` 组装；
      `hη`、`hεb` 是**定义的参数**，因为求和的存在性本身依赖横向性），
      `ddfOp_apply`（任意够大的有限窗口都算得对）。
    - **`lie_towerLop_ddfOp_of_pos`**：`k_0² = 0`、`2α' k_0·p = 1`、`ε·k_0 = 0`、`m ≥ 1`
      ⟹ `⁅L_m, A^ε_n⁆ = 0`。证明是逐项 Leibniz + 重标 `j ↦ j+m` 的伸缩和；
      边界项靠窗口两端各自的消失机制。
      辅助：`lie_towerLop_ddfSummand`（单项括号的伸缩形式）、
      `lie_mul_end` / `lie_smul_end` / `smul_lie_end` / `lie_sum_end` / `sum_lie_end`
      （Mathlib 的 `lie_sum` / `sum_lie` / `lie_smul` 对 `Module.End` 的括号**匹配不上**：
      `LieRingModule.toBracket` 与 `LieRing.toBracket` 不是同一个实例路径，
      只能从 `LieRing.of_associative_ring_bracket` 重证）。
    - **仍缺**：见 (5)，`m ≤ -1` 已补齐，只剩 `m = 0`。
  - [x] (5) **`⁅L_m, A^ε_n⁆ = 0` 推广到一切 `m ≠ 0`**：
    `StringFormal/NoGhost/DDFOperatorNeg.lean`，无 sorry，7 条声明公理只有标准三条。
    把 (3f) 的单 Fock 恒等式机械搬到塔上再重跑伸缩和：
    - `lie_towerLop_towerVertex_of_ne` / `_of_neg`：塔上共形权恒等式
      `⁅L_m, V^{(n)}_K⁆ = (K - m - n + n(k_0·p)) V^{(n)}_{K-m}`，`m ≠ 0`。证明与 (3e) 的
      `_of_pos` 逐字相同，只把 `Fock.lie_Lop_vertexOsc_of_pos` 换成 `..._of_ne`；
      `k_0² = 0` 依然**必要**，理由同 (3e)（否则系数含 `j·n·(b·b)`，依赖塔的级数 `j`）。
    - `lie_towerLop_towerVertex_of_ne_normalized` / `_of_neg_normalized`：归一化后的权 0
      变换律 `⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}`。两项 `n` 依赖的贡献
      （单项式 `z^n` 的单值性移位与 `n(k_0·p)`）都与 `m` 无关，故抵消对符号不敏感。
    - `lie_towerLop_ddfSummand_of_ne`、**`lie_towerLop_ddfOp_of_ne`**、
      `lie_towerLop_ddfOp_of_neg`。
    - **窗口两端的消失机制在 `m < 0` 时仍成立，但边界项换边**：伸缩和把
      `∑_{[lo,up]} (g(j-m) - g(j))` 化成 `∑_{[lo-m,up-m]} g - ∑_{[lo,up]} g`。`m > 0` 时
      多出的两条边带是 `[lo-m, lo-1]`（下端机制：顶点算子降不到真空以下）与
      `[up-m+1, up]`（上端机制：横向性）；`m < 0` 时重标 `j ↦ j-m` 方向反转，两条边带
      **交换到另一侧**，变成 `[lo, lo-m-1]`（位置在 `lo` 之上，却仍须由**下端**机制消灭）
      与 `[up+1, up-m]`（仍由上端机制消灭）。修正办法：窗口两端各留 `|m|` 的余量
      （`lo + |m| ≤ n - towerLevelBound x`、`towerModeBound x + |m| ≤ up`），
      再把两个和都与公共大窗口 `[min lo (lo-m), max up (up-m)]` 比较，一次覆盖两种符号。
      因为 `ddfOp_apply` 对任意够大的窗口都成立，放大窗口不花代价。
    - **仍缺**：只剩 `m = 0`，且**只卡在一处**——`hm : m ≠ 0` 在
      `lie_towerLop_ddfOp_of_ne` 里只用了一次，就是引用 `lie_towerLop_ddfSummand_of_ne`。
      伸缩和与上面的窗口分析在 `m = 0` 处逐字成立（`m = 0` 时两项
      `(j-m) G_{j-m}` 与 `j G_j` 本来就相同，单项括号自己就是零）。真正缺的是单 Fock
      恒等式 (3f) 在 `m = 0` 的版本。缺的结论是 **`⁅L_0, A^ε_n⁆ = 0`**（注意**不是**
      `A^ε_n` 的非零倍：`A^ε_n` 是权 1 流的**零模**，`⁅L_m, j_0⁆ = ((h-1)m - 0) j_m`
      在 `h = 1` 时为零），它正是 DDF 态自动满足 `L_0` 质壳条件的原因。因此
      「`A^ε_n` 保持物理子空间」仍不能陈述（另外塔上的 `physSubmodule` 尚未定义）。

  **未做（下一项 `ddf-spans` 之前必须补）**：
  - `⁅L_m, A^ε_n⁆ = 0` 已覆盖一切 `m ≠ 0`（见 (5)）；**只剩 `m = 0`**，
    所以「`A^ε_n` 把物理态送到物理态」仍证不了（`L_0` 条件缺）。
  - `[A^i_m, A^j_n] = m δ^{ij} δ_{m+n,0}` 需要顶点算子的乘积/OPE，完全未碰。
  - `A^ε_n` 的伴随未做（需 `vertexOsc` 的伴随，图节点 `worldsheet.vertex-operator-adjoint`）。
  - `x^μ` 只以 `towerShift`（即 `e^{i n k_0·x}`）的形式出现，Heisenberg 对易 `[x^μ,p^ν]` 未形式化；
    塔是建在**固定的** `a` 与 `b` 上，不是全动量空间。
  - 归一化 `2α' k_0·p = 1` 与 `k_0² = 0` 只作为显式假设 `dotVec η b a = 1` / `dotVec η b b = 0`
    出现；「存在类光 `k_0` 使 `k_0·p ≠ 0`」是关于实二次型的断言，在一般环上假，未（也不该）证。
- [ ] `ddf-spans`：DDF 态张成 `H_phys / null`（D = 26, a = 1）。这是定理的核心。
- [ ] `no_ghost_theorem`：组装。
- [x] `negative-norm-above-26`：D > 26 时显式负模态 —— `StringFormal/NoGhost/LevelTwo.lean`。
  level-2 标量试探态 `ψ₂ = [α_{-1}·α_{-1} + c₂(a·α_{-2}) + c₃(a·α_{-1})²]|k⟩`
  （`Fock.levelTwoScalar`），其中 `a^μ = α^μ_0 = (2α')^{1/2}k^μ`，`s := zeroModeSq η a = 2α'k²`。
  - 任意系数下的模：`Fock.pairing_levelTwoScalar_self`，`⟨ψ₂,ψ₂⟩ = 2D + 2s c₂² + 2s² c₃² + 4s c₃`。
  - 物理态条件：`Fock.Lop_one_apply_levelTwoScalar`（`L₁ψ₂ = (2+2c₂+2c₃s)(a·α_{-1})|k⟩`）、
    `Fock.Lop_two_apply_levelTwoScalar`（`L₂ψ₂ = (D+2c₂s+c₃s)|k⟩`）；`n ≥ 3` 自动
    （`Fock.Lop_apply_levelTwoScalar_of_three_le`，用 level 分级）。
    合起来是 `Fock.levelTwoScalar_mem_physSubmodule`。
  - 闭式（图节点 `worldsheet.ocq-level-two-scalar-norm`）：`Fock.pairing_levelTwoScalar_physical`，
    `(4a₀-9)² ⟨ψ₂,ψ₂⟩ = 2(D-1)[16a₀² + (2D-74)a₀ + 84 - 3D]`（分母已清；括号内判别式 `4(D-1)(D-25)`）。
    非空性：`Fock.exists_levelTwoScalar_mem_physSubmodule`（域上，`4a₀ ≠ 9` 且 `k² ≠ 0`）。
  - `a₀ = 1`：`Fock.pairing_levelTwoScalar_intercept_one`，`⟨ψ₂,ψ₂⟩ = -2(D-26)(D-1)/25`，
    系数 `c₂ = (D-1)/5`、`c₃ = (D+4)/10`。
  - **鬼**（no-ghost-theorem-v4 第 (2) 条）：`Fock.exists_mem_physSubmodule_pairing_self_neg`，
    有序域上 `D > 26` ⟹ `∃ ψ ∈ physSubmodule (minkowski D K) b 1, ⟨ψ,ψ⟩ < 0`；
    动量见 `Fock.exists_zeroModeSq_eq_neg_two`（`α'k² = -1`，需 `D ≥ 2` 与域，因为
    单分量的 `k² = -1` 在 ℚ 上无解）。
  - 带动量量词的加强版：`Fock.exists_mem_physSubmodule_pairing_self_neg'`，结论多输出
    `zeroModeSq (minkowski D K) b = -2` 与 `b ≠ 0`，可逐字对应 no-ghost-theorem-v4 第 (2) 条的
    `∃ p ≠ 0`；`b ≠ 0` 由质壳本身逼出（`zeroModeSq η 0 = 0 ≠ -2`）。
    图节点 `worldsheet.negative-norm-physical-state-above-26` 的 `lean_decl` 宜改指这个声明。
  - **公理登记**（curator 要求）：上述声明均无 `sorry`，
    `lake env lean --run scripts/check_axioms.lean --import StringFormal.NoGhost.LevelTwo --all`
    对 `exists_mem_physSubmodule_pairing_self_neg`、`exists_mem_physSubmodule_pairing_self_neg'`、
    `exists_zeroModeSq_eq_neg_two` 均输出 `ok`，公理集只有
    `propext`、`Classical.choice`、`Quot.sound`（2026-09-11 复核）。

  **未做**：没有证明 `ψ₂` 张成 level-2 物理态的标量（`SO(D-1)` 不变）部分，所以「level-2 标量模」
  是关于这一族显式试探态的陈述，不是关于某个典范向量的。做鬼不需要这一步（一个负模态就够），
  但图节点若要读作「level-2 标量物理态的模」，应在 `gaps` 里写明这一点。
  也没有证明 `D ≤ 26` 时模非负——那是无鬼定理本身。

## 基础设施

- [x] `scripts/check_axioms.lean`：给定声明名，输出其公理集合，非标准三公理则退出非零。
  `lake env lean --run scripts/check_axioms.lean <DeclName>...`，或 `--all` 从 stdin 读名字表；
  每行 `<ok|bad|missing>\t<声明名>\t<公理集合>`，`sorryAx`、未知声明都算失败。
  用 `Lean.importModules`（`loadExts := false`，因而不需要 `enableInitializersExecution`/unsafe main）
  加载 `StringFormal` 环境，再对每个名字跑 `Lean.collectAxioms`；`--import <Module>` 可换环境。
  图侧接入已做：`uv run stringgraph check-axioms`（`tools/stringgraph/axioms.py`）把结论映回节点 id，
  非标准公理同时报到陈述卡和依赖它的 `formalized` 推导上；**不进 `validate`/pre-commit**（要起 Lean）。
  2026-09-11 全图 14 个 `formal.lean_decl` 跑通：14 ok，0 bad，0 missing。
- [x] `basic-lean-housekeeping`：`toProdₗ` / `ofWitt` / `toProd_ofWitt` / `ofWitt_lgen` /
  `span_lgen_cgen_eq_top` / `centralTerm_zero` 已于 2026-09-11 从 `Verma.lean` 挪到
  `Basic.lean`（声明全名不变，图卡 `lean_decl` 无需改）。`WittPerfect.lean` 的 import 已从
  `Virasoro.Verma` 改成 `Virasoro.Basic`。`DescendantGrading.lean` **仍需** import Verma：
  它实际用了 `wordAct` / `vermaLift` / `VermaModule`（约 40 处），不是只为这几条。
  另记：`R = ℤ` 处 `Module ℤ (WittAlgebra ℤ)` 实例菱形，`rw` 会失败须写应用式。
