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

- [x] `eta-s`：Dedekind η 的 S 变换 `η(−1/τ) = (−iτ)^{1/2} η(τ)`（主分支，Im τ > 0），
  对应图节点 `math.dedekind-eta-s-transformation`。
  见 `StringFormal/Math/DedekindEtaS.lean`（无 sorry，7 个声明公理检查全 `ok`，只有标准三条）。

  **结论先行**：`math.dedekind-eta-s-transformation` **可以标 formalized**，
  `lean_decl` 取 `StringFormal.DedekindEta.eta_neg_inv`
  （`{z : ℂ} (hz : 0 < z.im) : ModularForm.eta (-z⁻¹) = (-I * z) ^ ((1 : ℂ)/2) * ModularForm.eta z`，
  指数确是 `ℂ` 的 cpow 主分支，`pp.numericTypes` 复核过），`lean_file` 取上面的路径。
  本卡 statement 里的「推论」也已形式化：
  `norm_eta_neg_inv_pow_four`（`|η(−1/τ)|⁴ = |τ|²|η(τ)|⁴`）与
  `im_mul_norm_eta_pow_four_S_invariant`（`Im(−1/τ)·|η(−1/τ)|⁴ = Im τ·|η(τ)|⁴`，
  即 `τ₂|η|⁴` 的 **S** 不变性；全模群不变性还缺 T 半与「S,T 生成模群」）。
  其余声明：`csqrt_neg_I`、`csqrt_neg_I_mul`、`eta_S`（`τ : ℍ` 版）、`norm_eta_neg_inv_sq`，
  以及模群作用形 `eta_modular_S_smul`（`η(S · τ) = (−iτ)^{1/2} η(τ)`）与
  `im_mul_norm_eta_pow_four_modular_S_smul`（`(S·τ)₂|η(S·τ)|⁴ = τ₂|η(τ)|⁴`），
  后两条是为了将来接 `worldsheet.modular-group-generated-by-s-and-t`。
  共 9 个公开声明，`check_axioms --all` 全 `ok`。

  **Mathlib v4.33.1 现状清单**（2026-09-11 formalizer 逐文件读源码，L1）。
  ⚠ **图卡 `math.dedekind-eta-s-transformation` 的 notes 说「Mathlib 无 S 变换」是错的**：
  结论对 `DedekindEta.lean` 成立，但 S 变换在**另一个文件** `Discriminant.lean` 里
  （该图卡的 Q48.2「Delta/Identities/JacobiTheta 侧未查」正是漏掉的地方）。

  (1) η 的定义 —— `Mathlib/NumberTheory/ModularForms/DedekindEta.lean`：
      `ModularForm.eta (z : ℂ) : ℂ := 𝕢 24 z * ∏' n, (1 - eta_q n z)`，
      `𝕢 h z = Periodic.qParam h z = cexp (2πi z / h)`，`eta_q n z = (𝕢 1 z) ^ (n + 1)`。
      即 `η(z) = e^{πiz/12} ∏_{n≥1}(1 − q^n)`，**与图卡 `math.dedekind-eta-function` 的约定逐字一致**。
      定义域是全 ℂ（ℍ 外是垃圾值），实质内容都带假设 `z ∈ ℍₒ := {z : ℂ | 0 < z.im}`。
      配套：`eta_ne_zero (hz : z ∈ ℍₒ)`、`differentiableAt_eta_of_mem_upperHalfPlaneSet`、
      `multipliableLocallyUniformlyOn_eta`。
  (2) `ModularForm.logDeriv_eta_eq_E2 (z : ℍ) : logDeriv eta ↑z = (π * I / 12) * E2 ↑z`
      （同文件末尾）。
  (3) E₂ —— `Mathlib/NumberTheory/ModularForms/EisensteinSeries/E2/Defs.lean`：
      `G2 : ℍ → ℂ := fun z ↦ ∑'[symmetricIcc ℤ] m, e2Summand m z`（Eisenstein 求和的对称截断），
      `E2 : ℍ → ℂ := (1 / (2 * riemannZeta 2)) • G2`。
  (4) **E₂ 的拟模性（S 变换）已在 Mathlib** —— `EisensteinSeries/E2/Transform.lean`：
      - `G2_S_transform (z : ℍ) : G2 z = ((z : ℂ) ^ 2)⁻¹ * G2 (S • z) - -2 * π * I / z`
        （等价于 `G2(−1/z) = z² G2(z) − 2πi z`）；
      - `D2 (γ : SL(2,ℤ)) : ℍ → ℂ := fun z ↦ 2πi·γ₁₀ / denom γ z`，`D2_S z = 2πI/z`、`D2_T = 0`；
      - `G2_slash_action (γ) : G2 ∣[(2:ℤ)] γ = G2 − D2 γ`（**对全 SL(2,ℤ)**）；
      - `E2_slash_action (γ) : E2 ∣[(2:ℤ)] γ = E2 − (1/(2ζ(2))) • D2 γ`；
      - `G2_T_transform : G2 ∣[(2:ℤ)] T = G2`。
      所以任务书里「若 E₂ 的 S 变换不在 Mathlib 就退化成带假设的定理」这一分支**用不上**。
  (5) **η 的 S 变换本身已在 Mathlib** —— `Mathlib/NumberTheory/ModularForms/Discriminant.lean`
      （v4.33.1 新文件，2026，Birkbeck）：
      `ModularForm.eta_comp_eq_csqrt_I_inv : upperHalfPlaneSet.EqOn (η ∘ (-1 / ·)) ((sqrt I)⁻¹ • (sqrt * η))`，
      即 `η(−1/z) = (√i)⁻¹ √z · η(z)`，其中 `Complex.sqrt a = a ^ (2⁻¹ : ℂ)`（主分支 cpow，
      `Mathlib/Analysis/RCLike/Sqrt.lean`）。证明路线就是任务书设想的那条：
      `logDeriv_eta_comp_div_eq` → `logDeriv_eta_comp_eq_logDeriv_csqrt_eta`（用 `E2_slash_action S`）
      → `logDeriv_eqOn_iff` 给出常数 c → 在 `z = I` 定 `c = (√i)⁻¹`。
      同文件另有 `discriminant_S_invariant`、`discriminant_T_invariant`（Δ = η²⁴）。
  (6) **Mathlib 里没有**：η 的 T 变换（`η(τ+1) = e^{iπ/12}η(τ)`，图卡
      `math.dedekind-eta-t-transformation`）、η 对一般 `(a b; c d) ∈ SL(2,ℤ)` 的乘子系统
      （Dedekind 和）、`τ₂|η|⁴` 的模不变性（图卡 statement 里的「推论」）。
      T 变换从乘积定义直接可得（`eta_q` 关于 z 是 1-周期，`𝕢 24 (z+1) = e^{2πi/24}·𝕢 24 z`），
      是下一个低成本目标。

  **本项目要补的只有归一化那一步**：把 Mathlib 的 `(√i)⁻¹ √z` 形状换成弦论文献的 `(−iτ)^{1/2}`。
  两者在 ℍ 上逐点相等：`arg(−iz) = arg z − π/2 ∈ (−π/2, π/2)`，故
  `log(−iz) = log(−i) + log z`，取 `exp(·/2)` 即得。见 `StringFormal/Math/DedekindEtaS.lean`。
  实际做下来只需 `Complex.log_mul` + `arg_nonneg_iff` + `arg_le_pi`（**不需要 `arg z > 0` 的严格性**：
  `log_mul` 要的是 `arg(−i) + arg z ∈ Ioc (−π, π]`，下端由 `arg z ≥ 0` 就够）。
  全文件 90 行，其中真正的新数学是 `csqrt_neg_I_mul` 一条。

- [x] `eta-t`：Dedekind η 的 T 变换 `η(τ+1) = e^{iπ/12} η(τ)`，对应图节点
  `math.dedekind-eta-t-transformation`。见 `StringFormal/Math/DedekindEtaT.lean`
  （无 sorry，11 个声明 `check_axioms --all` 全 `ok`，只有标准三条）。

  **结论先行**：`math.dedekind-eta-t-transformation` **可以标 formalized**，
  `lean_decl` 取 `StringFormal.DedekindEta.eta_add_one`
  （`{z : ℂ} (hz : 0 < z.im) : ModularForm.eta (z + 1) = Complex.exp (↑π * I / 12) * ModularForm.eta z`）。
  Mathlib v4.33.1 确实没有 `eta_T`（见上面 (6)），本文件从 `ModularForm.eta` 的定义直接证：
  `𝕢 1 (z+1) = 𝕢 1 z`（`Complex.exp_two_pi_mul_I`）⇒ 无穷乘积**逐项**不变（`tprod_congr`）；
  `𝕢 24 (z+1) = e^{2πi/24}·𝕢 24 z = e^{iπ/12}·𝕢 24 z`（`exp_add` + `push_cast; ring`）。

  ⚠ **数学缺口/加强（建议写进图卡 notes）**：T 变换**对一切 `z : ℂ` 成立，不需要 `Im z > 0`**。
  `ModularForm.eta` 在 ℍ 外按同一公式定义，周期性论证从不看 `Im z`，而 `tprod` 是逐项比较，
  乘积是否收敛无关紧要。无条件版是 `eta_add_one_eq (z : ℂ)`；`eta_add_one` 只是为了与图卡逐字
  对齐才保留（未用的）假设（`set_option linter.unusedVariables false`）。
  这与 S 变换**性质不同**：那里 `Im z > 0` 是本质的（它把 `−iz` 放进右半平面，使主对数可加）。

  其余声明：`qParam_one_add_one`、`eta_q_add_one`、`qParam_24_add_one`（三条原子），
  `eta_T`（`τ : ℍ` 版）、`eta_modular_T_smul`（`η(T · τ) = e^{iπ/12} η(τ)`，
  与 `eta_modular_S_smul` 配对）、`norm_exp_pi_I_div_twelve`、`norm_eta_add_one`
  （`‖η(τ+1)‖ = ‖η(τ)‖`）、`im_mul_norm_eta_pow_four_T_invariant` 与
  `im_mul_norm_eta_pow_four_modular_T_smul`（`τ₂|η|⁴` 的 **T** 不变性）。
  与 `DedekindEtaS` 的 S 版合起来，`τ₂|η(τ)|⁴` 在模群**两个生成元**下都不变；
  **全模群不变性仍缺** `worldsheet.modular-group-generated-by-s-and-t`（未形式化）。
  同样仍缺：η 对一般 `SL(2,ℤ)` 元素的乘子系统（Dedekind 和）。

- [x] `eta-modular`：`τ₂|η(τ)|⁴` 在**整个 `SL(2,ℤ)`** 下不变。
  见 `StringFormal/Math/DedekindEtaModular.lean`（无 sorry，8 个声明 `check_axioms --all` 全 `ok`，
  只有标准三条）。

  **调研结论（先记下来，省得后人重查）**：Mathlib v4.33.1 **有**「S、T 生成 `SL(2,ℤ)`」：

  ```
  SpecialLinearGroup.SL2Z_generators : Subgroup.closure {ModularGroup.S, ModularGroup.T} = ⊤
  ```

  在 `Mathlib/LinearAlgebra/Matrix/FixedDetMatrices.lean:274`（`section SL2Z_generators`，
  `open ModularGroup Subgroup`，作者 Chris Birkbeck，Lean 3 原型来自 kbb 仓库）。它由同文件的
  `FixedDetMatrices.induction_on`（对 `FixedDetMatrix (Fin 2) ℤ 1` 的欧几里得型归约，cases
  `h0`/`hS`/`hT`）证出。用法样板见
  `Mathlib/NumberTheory/ModularForms/EisensteinSeries/E2/Transform.lean:200`
  （`G2_slash_action`：`have : γ ∈ Subgroup.closure {S, T} := by simp [SpecialLinearGroup.SL2Z_generators]`
  然后 `induction this using Subgroup.closure_induction with | one | mem | mul | inv`）。
  另一处用法：`Mathlib/NumberTheory/ModularForms/LevelOne/Basic.lean:60`。

  ⇒ 因此 **不需要**自己证生成定理，也**不必**退化成条件版
  `… (hg : g ∈ Subgroup.closure {S, T})`。图节点
  `worldsheet.modular-group-generated-by-s-and-t` 的数学内容**在 Mathlib 里已形式化**，
  可以用 `lean_decl = SpecialLinearGroup.SL2Z_generators` 标 `formalized`
  （前提是图卡陈述与「`closure {S,T} = ⊤` 在 `SL(2,ℤ)` 上」逐字对得上；注意这是 `SL(2,ℤ)` 版，
  不是 `PSL(2,ℤ)` 版，且 `S` `T` 取 Mathlib 的 `ModularGroup.S = ![![0,-1],![1,0]]`、
  `ModularGroup.T = ![![1,1],![0,1]]`）。

  **本文件做的事**：只有一次 `Subgroup.closure_induction`。关键技术点：归纳的谓词必须是
  `∀ τ` 形（`im_mul_norm_eta_pow_four_modular_forall`），因为 `inv` 分支要在**另一个点**
  `g⁻¹ • τ` 用归纳假设（`smul_inv_smul`）；`mul` 分支是 `mul_smul` + 两次归纳假设；
  `one` 分支是 `one_smul`。两个生成元分支直接就是
  `DedekindEtaS.im_mul_norm_eta_pow_four_modular_S_smul` 与
  `DedekindEtaT.im_mul_norm_eta_pow_four_modular_T_smul`（一字不改）。

  声明清单：`modular_group_generated_by_S_and_T`（Mathlib 定理的再导出）、
  `im_mul_norm_eta_pow_four_modular_forall`、
  **`im_mul_norm_eta_pow_four_modular_invariant`**（主定理，`(g • τ).im * ‖η(g•τ)‖^4 = τ.im * ‖η τ‖^4`）、
  `norm_eta_pow_four_modular`（解出形 `‖η(g•τ)‖⁴ = (τ₂/(gτ)₂)‖η(τ)‖⁴`）、
  `im_mul_norm_eta_pow_four_isInvariant`（函数相等形）、
  `im_mul_norm_eta_pow_four_pow_modular`、`im_pow_mul_norm_eta_pow_modular`（任意 n 次幂）、
  `im_pow_twelve_mul_norm_eta_pow_48_modular`（`τ₂¹²|η|⁴⁸`，即玻色单圈被积函数的倒数）。

  ⚠ **给图的建议（本 agent 未改 graph/）**：
  1. `worldsheet.modular-group-generated-by-s-and-t` 可标 `formalized`。**注意图卡是 `PSL(2,ℤ)` 版
     且含两条关系**（(1) S、T 生成 PSL(2,ℤ)；(2) S² = 1、(ST)³ = 1），Mathlib 只给了 `SL(2,ℤ)` 版
     生成定理，所以本轮另开了一个小岛
     `StringFormal/Math/ModularGroupGenerators.lean` 把三条都补齐：
     `ModularGroupGen.psl_closure_S_T`（(1)）、`psl_S_sq`（(2) 前半）、`psl_ST_cube`（(2) 后半）。
     `lean_decl` 建议取 `StringFormal.ModularGroupGen.psl_closure_S_T`（主断言），
     另两条写进 notes 或 `lean_decl_extra`（若 schema 支持列表）。
     ✔ 图卡自己声明「**不**断言这是一个 presentation」——Lean 侧完全一致：本文件也不证
     `PSL(2,ℤ) ≅ ℤ/2 ∗ ℤ/3`，Mathlib v4.33.1 也没有。两边口径对得上，不需要额外 gap。
     △ 一条**真正的**缺口（建议写进 `gaps`）：Lean 里 `PSL(2,ℤ) := SL(2,ℤ)/Z(SL(2,ℤ))`
     （Mathlib `Matrix.ProjectiveSpecialLinearGroup`），本文件**没有**证 `Z(SL(2,ℤ)) = {±1}`
     （真命题，但用不上；只需要 `−1 ∈ Z`，即 `neg_one_mem_center`）。因此 Lean 的两条关系严格说是
     「模去中心后成立」，若图卡想要「S² = ±I 在 SL(2,ℤ) 里」，那是 `sl_S_sq : S^2 = -1` 与
     `sl_ST_cube : (S*T)^3 = -1`（本文件也有，且更强）。
  2. 若图里有「`τ₂|η|⁴` 模不变」这条卡（一般挂在单圈配分函数链上），可挂
     `im_mul_norm_eta_pow_four_modular_invariant`。
  3. **仍缺**（不要误标）：η 本身对一般 `g` 的乘子系统（Dedekind 和、24 次单位根）。
     本文件只控制 `‖η‖` 在 `τ₂|η|⁴` 这一特定组合里的行为；`12 = (D−2)/2` 是输入不是输出。
     ✔ **测度 `d²τ/τ₂²` 的模不变性已不在此列**（2026-09-11）：它在
     `StringFormal/Math/TorusMeasure.lean`（`measure_smul_eq` / `measure_density_modular_invariant`），
     图卡 `spectrum.torus-measure-modular-invariant` 已挂 `lean_decl` 并新增
     `--via-lean`（formalized）。本文件仍然 η-free 且不涉及测度，两边分工不变。

- [x] `psl-generators`：`StringFormal/Math/ModularGroupGenerators.lean`（无 sorry，8 个声明
  `check_axioms --all` 全 `ok`）。只 import Mathlib，是独立小岛，被 `DedekindEtaModular` 复用。
  `SL(2,ℤ)` 层：`sl_S_sq : S^2 = -1`、`sl_ST_cube : (S*T)^3 = -1`（两条都是
  `ext i j; fin_cases i <;> fin_cases j <;> rfl`，`-1 : SL(2,ℤ)` 靠全局实例
  `Fact (Even (Fintype.card (Fin 2)))` 提供 `Neg`）、`sl_closure_S_T`（Mathlib 再导出）、
  `neg_one_mem_center`。`PSL(2,ℤ)` 层（`psl := QuotientGroup.mk'` 到 `SL/Z`）：
  `psl_neg_one`、`psl_S_sq`、`psl_ST_cube`、`psl_closure_S_T`。
  生成定理的搬运用 `MonoidHom.map_closure` + `Set.image_pair` + `MonoidHom.range_eq_top`
  （样板抄自 Mathlib `NumberTheory/ModularForms/LevelOne/Basic.lean:60`）。

- [x] `mathlib-bridge`：`StringFormal/Math/MathlibBridges.lean`（无 sorry，19 个声明
  `check_axioms --all` 全 `ok`）。**桥层**：两张定义卡 `math.dedekind-eta-function` 与
  `worldsheet.modular-group-psl2z` 的对象在 Mathlib 里已经有了（`ModularForm.eta`、
  `Matrix.ProjectiveSpecialLinearGroup`），但工具要求 `lean_decl` 指向 `formal/` 下的声明，
  于是在 `namespace StringFormal.Bridge` 里给每张卡写一条**逐字重述定理**，证明就是
  「这是 Mathlib 的定义」。**不重新定义对象**（重定义等于凭空多一份未经验证的副本）。
  - η 侧：`dedekindEta_eq_qpow_mul_tprod`（= `rfl`，Mathlib 定义的展开）、
    `qParam_one_eq_exp`（q = e^{2πiτ}）、`qParam_24_eq_exp` 与
    `qParam_24_eq_exp_pi_I_div_twelve`（q^{1/24} = e^{2πiτ/24} = e^{πiτ/12}，即卡面**分支选取**
    是单值的 `exp`，不是多值根式）、`dedekindEta_eq_exp_mul_tprod`（全部展开成 `exp` 的卡面形）、
    `dedekindEta_ne_zero` 与 `differentiableAt_dedekindEta`（卡面自己断言的两条解析性质）。
  - PSL 侧：`psl2z_smul_eq`（(aτ+b)/(cτ+d)，矩阵元写开）、`psl2z_im_smul_eq`
    （Im(γτ) = Im τ/|cτ+d|²）、`psl2z_T_smul` / `psl2z_S_smul`、`neg_smul_eq` / `neg_one_smul_eq`、
    `smul_eq_of_pslMk_eq` 与 `MulAction PSL2Z ℍ` 实例（`pslMk_smul`）：作用**确实降到 PSL(2,ℤ)**。
  - ★ 顺手补上了 `psl-generators` 条目里记的那条缺口：`center_eq_pm_one : (Z(SL(2,ℤ)) : Set _)
    = {1, -1}`（Mathlib `SpecialLinearGroup.mem_center_iff` 给「中心元 = 标量 r·I 且 r² = 1」，
    在 ℤ 上 r = ±1）。所以 Mathlib 的 `PSL = SL/Z(SL)` **就是**卡面的 `SL(2,ℤ)/{±I}`，
    `ModularGroupGenerators.lean` 里「只证了 −I ∈ Z」的保留意见可以撤掉。
  - **仍不断言**：PSL 作用的忠实性（卡面也没断言）、S/T 生成（在 `ModularGroupGenerators.lean`）、
    基本域、η 的任何模变换性质。

- [x] `mathlib-bridge-2`：桥层补两处（同文件，`check_axioms --all` 全 `ok`，全图 75 条回归全 `ok`）。
  - `psl2z_im_pos (g : SL(2,ℤ)) (τ : ℍ) : 0 < (g • τ).im`——拆出来的命题卡
    `math.mobius-action-preserves-upper-half-plane` 的第 (2) 条「作用保持 H」此前**只活在
    `psl2z_im_smul_eq` 的类型里**（`g • τ : ℍ`），该卡 sources 与其 `--via-lean` 的 gaps 首条
    都为此留了记账。现在它有自己的具名声明（证明是 Mathlib 的 `UpperHalfPlane.im_pos`）。
  - ★ **外延性**：`psl2z_eq_quotient_pm_one : Z(SL(2,ℤ)) = Subgroup.closure {-1}`
    与 `center_eq_zpowers_neg_one`（`= Subgroup.zpowers (-1)`）把 `center_eq_pm_one` 的集合等式
    提到**子群等式**；`pslMk_eq_iff (g h) : pslMk g = pslMk h ↔ g = h ∨ g = -h` 则完全不提中心，
    直接说 Mathlib 的商**恰好**按卡面的 `±` 关系粘合。
    `math.psl2z-s-t-relations--via-lean` 与 `worldsheet.modular-group-generated-by-s-and-t-v2--via-lean`
    的 gaps 首条（「两者的拼接是人读两条声明后作的比对，不是一条机检蕴涵」）现在有机检替代物。
    ⚠ **口径**：这三条让「Lean 的 PSL = 卡面的 SL/{±I}」成为机检事实，但它们仍**不在**
    `psl_S_sq` / `psl_closure_S_T` 的证明链上——那两条定理的对象本来就是 Mathlib 的 PSL，
    不需要这个识别；识别是为了**读者把 Lean 陈述读成卡面陈述**。改 gaps 时应说「群的识别已机检，
    余下的仅是陈述搬运」，而不是说 gaps 消失。图侧改动由 curator/lead 做，本轮不碰 `graph/`。

## Lean 岛 2：Green–Schwarz 反常抵消的代数部分

`StringFormal/Math/GreenSchwarzAlgebra.lean`（A1/A2/A3）与
`StringFormal/Math/AnomalyPolynomial.lean`（A8/A9）与 `StringFormal/Math/E8Roots.lean`（A11），三个独立小岛（只 import Mathlib）。
A1/A2/A3 对应 Green–Schwarz 1984 抽取记录 `literature/extractions/green-schwarz-1984.md` §5；
A8/A9 对应 Polchinski 抽取记录 `literature/extractions/polchinski-1998-v2-ch12.md` §5.4。
A11 对应 `literature/extractions/math-sources.md` §44（Humphreys §2.10 根系 + §44.7 手算）。六项都已完成，无 sorry，公理只有标准三条。
补强项 `gs-refine` 在 `StringFormal/Math/GreenSchwarzAlgebraGen.lean`，同样只 import Mathlib + 上面那个文件。

- [x] `gs-factorization`（A1）：十二形式因子化 `Ω₁₂ = (1/48) Ω₄ [Ω₈ − (1/300) Ω₄²]`。
  `gs_factorization_so32`：`SO(32)` 支，`Ω₄ = 30x`、`Ω₈ = 24y + 3x²`、`Ω₁₂ = 15xy`；
  `gs_factorization_e8`：`E₈` 支，`Ω₄ = x`、`Ω₈ = x²/100`、`Ω₁₂ = x³/7200`；
  `gs_factorization_nested_eq_expanded`：GS 原文的嵌套形与二手文献的展开形
  `(1/48)Ω₄Ω₈ − (1/14400)Ω₄³` 是同一恒等式。
  建议图节点 `math.anomaly-twelve-form-factorization` 的 `lean_decl`（取前两条）。
  **环境选择**：陈述在 `[Field K] [CharZero K]` 上，系数写作 `48⁻¹`、`300⁻¹`、`/100`、`/7200`，
  证明是 `field_simp; ring`。曾有"**不要**改回 `[CommRing R] [Algebra ℚ R]`"的告诫（`ring`
  把 `algebraMap ℚ R (1/48)` 当不透明原子，一名 formalizer 因此停摆一轮）——
  **该障碍已解除**，见下面的 `gs-refine`；本文件保持域上版本不动。
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

- [x] `gs-refine`（A1′/A2′/A3′，reviewer-gs1984b 提的三处补强）：
  新文件 `StringFormal/Math/GreenSchwarzAlgebraGen.lean`（import 上面那个文件，**不改**它）。
  七条声明，无 sorry，公理只有标准三条（`tr_f6_usp_ge_33` 只用两条）。
  - `gs_factorization_so32_alg`、`gs_factorization_e8_alg`、
    `gs_factorization_nested_eq_expanded_alg`：把三条因子化恒等式从
    `[Field K] [CharZero K]` 推广到 `[CommRing R] [Algebra ℚ R]`。**这才是对的环境**：
    `Ω₄/Ω₈/Ω₁₂` 真正住的地方是偶次微分形式环、`H^even(BG;ℚ)`、不变多项式环，
    都是含幂零元与零因子的交换环，不是域；域上的陈述对它们只有"形状"上的意义。
  - `gs_factorization_alg`：两支的合取，`math.anomaly-twelve-form-factorization` 的
    单条 `lean_decl` 候选（比只取 `SO(32)` 一支更贴节点正文）。
  - `gs_factorization_so32_field_of_alg`：从 `_alg` 版**逐字**重新导出
    `gs_factorization_so32` 的陈述，证明推广没有偷改系数、`algebraMap ℚ K (1/48)`
    确实就是 `48⁻¹`。
  - **破局配方**（写给下一个碰到 `algebraMap` + `ring` 的人）：`ring` 把
    `algebraMap ℚ R (1/48)` 当原子是对的，那个等式本来就**不是**这些原子上的环恒等式；
    把定义关系显式喂进去即可。`SO(32)` 支用
    `have h48 : (48:R) * algebraMap ℚ R (1/48) = 1 := by rw [← map_ofNat (algebraMap ℚ R) 48, ← map_mul]; norm_num`
    （`300` 同理），然后
    `linear_combination (-(15*x*y)) * h48 + (90 * algebraMap ℚ R (1/48) * x^3) * h300`；
    `E₈` 支与嵌套/展开比较只需一条常数关系（`1/7200 = (1/48)(1/100 − 1/300)`、
    `1/14400 = (1/48)(1/300)`），在 `ℚ` 里 `rw [← map_mul]; norm_num` 证掉再 `rw` 回去，
    `ring` 就面对真原子了。（reviewer 另建议的 `MvPolynomial` 求值路线本轮没试，用不上。）
  - `mixed_anomaly_so_each_gives_32`：`so` 支上**每条**迹条件各自等价于 `N = 32`
    （`N + 8(−1) = 24 ↔ N = 32` 与 `N + 2(−1) = 30 ↔ N = 32` 两条独立的 iff）。
    原文件只在 docstring 里说了"两次独立确认"，没有陈述。`omega`。
  - `tr_f6_usp_ge_33`：`usp` 支 `N + 32 ≥ 33`（`N ≥ 1`），即图节点正文里的"≥ 33 > 0"逐字；
    原有的 `tr_f6_usp_positive` 只记了 `> 0`。`omega`。
  - **未接线**：本条只动 `formal/`，没改任何图节点。建议（留给 curator）：
    `math.anomaly-twelve-form-factorization` 的 `lean_decl` 改指 `gs_factorization_alg`，
    并在 notes 记一句"恒等式在任意交换 ℚ-代数上成立，故可直接用于反常多项式所在的环"；
    `math.mixed-anomaly-trace-conditions-n32`、`math.tr-f6-coefficient-vanishing`
    的 notes 各加一条指向 `mixed_anomaly_so_each_gives_32` / `tr_f6_usp_ge_33`。

**整个岛都不碰物理**：这几条方程为什么是反常抵消条件，由
`consistency.anomaly-cancellation-so32-effective-theory` 承载；
"只有 `SO(32)` 与 `E₈ × E₈` 因子化" 这类唯一性断言**不是** GS 1984 的结果，图里也没有节点。

### 有限可判定计算（`StringFormal/Math/FiniteCounts.lean`）

同一个岛的算术角落，只 import Mathlib。两项都已完成，无 sorry，公理只有标准三条。

- [x] `hexagon-odd-twist-count`：`hexagon_odd_twist_count`，
  `∑_{k 奇, k ≤ 6} C(6,k) = 32`（`decide`）。GS 1984 (12c) / GSW v2 p.165 里那个 "32" 的
  组合来历：六边形六条内线中奇数条带扭转的分布数 = `2⁵`。
  建议图节点 `math.hexagon-odd-twist-count` 的 `lean_decl`（该卡尚未进 main，见下）。
  **未做**：这个计数确实是 (12c) 系数来历这件事本身（物理/图层面的断言）。

- [x] `superstring-sector-exhaustion`：namespace `SuperstringSectors`，
  Polchinski v2 §10.6 (10.6.1)–(10.6.6) 的 `(ℤ₂)⁴` 扇区标签穷举（抽取记录 E40–E44）。
  `sectors_card`：16 个标签里 10 个扇区非空（level matching），即原文的 "`2¹⁰` combinations"；
  `mutuallyLocal_iff_even`：本文件的 `ZMod 2` 写法 ⟺ (10.6.5) 的整数偶性写法；
  `consistentSpectra_eq` / `consistentSpectra_card`：三条件 (a)(b)(c) 的解**恰好十个**；
  `maximalSpectra_card` / `halfSpectra_ssubset_maximal` / `mem_maximalSpectra_iff`：
  原文列的六个（IIB/IIA/IIA′/IIB′/0A/0B）= 解集里的**极大**元，另四个是它们的真子群；
  `maximalSpectra_filter_hasRamondNeveuSchwarz`：含 R–NS 扇区的极大解正好是四个 type II；
  `tachyonSector_notMem_of_hasRamondNeveuSchwarz` / `tachyonSector_mem_of_not_...`：
  四个 type II 不含 `(NS−,NS−)` 快子，两个 type 0 都含。
  建议图节点 `worldsheet.superstring-sector-consistency-solutions` 的 `lean_decl`
  （该卡尚未进 main，见下）。
  **数学缺口（给图的建议）**：三条件按原文字面只给出十个解，原文的 "one readily finds the
  only other solutions" 隐含了第四条未写出的条件——**谱是极大的**（"keeping all sectors
  with …"，即 (10.6.9)–(10.6.11) 的 GSO 投影写法）。补上极大性后穷举完全正确。
  推导卡的 `gaps` 里应记这一条，并注明补齐极大性的真正依据是 §10.7 的完整模不变性。
  **未做**：这些标签穷尽 RNS 弦扇区；`LevelMatched` 背后的 level 计算（此处是定义）；
  条件 (c) 作为模不变性必要条件的论证；(10.6.7) 的时空反射把 IIA′≅IIA、IIB′≅IIB
  （故四个 type II 解只是两个物理理论）；type 0 解的模不变性。

- [ ] **图接线待办**（不是 Lean 工作）：`math.hexagon-odd-twist-count` 与
  `worldsheet.superstring-sector-consistency-solutions` 两张卡在本分支建立时都还不在 main
  （分别在 `agent/curator/adt-abelian` 与 curator 的 GSO 支上），所以 `formal.lean_decl`
  / `--via-lean` 推导没有一并提交。卡进 main 后由 lead 或 curator 接线，并跑
  `uv run stringgraph check-axioms`。
### `StringFormal/Math/AnomalyPolynomial.lean`（Polchinski §12.2）

- [x] `anomaly-twelve-form-identity`（A9）：Polchinski (12.2.27)+(12.2.28a,b) 的**因子化形**
  与 (12.2.11)+(12.2.12) 的**逐项展开形**是同一多项式。
  `anomaly_polynomial_factorized_eq_expanded`，`[Field K] [CharZero K]` 上把
  `tr R², tr R⁴, tr R⁶, Tr_a F², Tr_a F⁴, Tr_a F⁶` 与生成元数 `n` 当作**七个独立标量**，
  证明是 `unfold; ring`（不需要 `field_simp`）。
  同一声明也验证 ADT 2010 (7)+(8)（抽取记录 E15 已确认与 (12.2.27)+(12.2.28) 逐字相同）。
  九类单项式系数已在纸上逐项复核，与抽取记录 E14 的 `[抽取者复算]` 完全一致，无一处对不上。
  建议做 `consistency.d10-n1-anomaly-polynomial`（若建卡，见抽取记录 §7 接线表）某条
  **推导**的 `lean_decl`，**不要**挂陈述卡本身：陈述卡说的是"这个多项式是反常"，那是物理。
  **未做**：微分形式、楔积、指标定理、(12.2.10) 的 `−i/(2π)⁵` 归一化；
  任何具体李代数的迹恒等式（独立节点）；因而**不断言任何群的反常抵消**。

- [x] `iib-gravitational-anomaly`（A8）：Polchinski (12.2.14) 的三条整数式。
  `iib_gravitational_anomaly_cancels`：IIB 含量 `(n_{3/2}, n_{1/2}, n_A) = (2, −2, 1)` 给零；
  `iib_gravitational_anomaly_solutions`：三式 `↔ n_{3/2} = 2n_A ∧ n_{1/2} = −2n_A`（`omega` 一行）；
  `iib_anomaly_polynomial_vanishes_iff` / `iib_gravitational_anomaly_free_iff`：
  这三式**恰好**是"十二形式作为多项式恒为零"（正向靠在 (0,0,1)、(1,1,0)、(1,0,0) 处取值）。
  系数按 Polchinski (12.2.11 取 n=1)/(12.2.12)/(12.2.13) 的分子抄，
  与 Bilal (12.4)/(12.5) 同型（`−495n_{3/2} + n_{1/2} + 992n_A = 0` 等），归一化一致。
  ⚠ **数学缺口（值得写进图）**：这个 3×3 方程组**秩是 2 不是 3**——任取两式就已经推出
  `n_{3/2} = 2n_A`，第三式自动成立。Polchinski 说"三个条件、三个自由参数，barring a numerical
  coincidence 只能全零"（E11 的 "miraculous"/"accidental"），这个记账对巧合略微高估了：
  实际是**两个条件约束三个参数**，一维解空间是应该出现的。真正非平凡的是解恰好落在
  IIB 超引力实现的小整数 `(2, −2, 1)` 上。建议写进
  `consistency.iib-gravitational-anomaly-cancels` 的 `gaps` 或 `notes`。

- [x] **A8′ —— IIB 引力反常抵消的完整线性代数（唯一性）**。图侧接口已建：
  陈述 `consistency.iib-anomaly-solution-unique`，推导 `--via-linear-algebra`
  （physical-argument，待 reviewer 复核后升 rigorous）。
  设 `A : Matrix (Fin 3) (Fin 3) ℤ` 的行为 `(−495, 1, 992)`、`(225, 1, −448)`、`(−63, 1, 128)`
  （作用在 `(n_{3/2}, n_{1/2}, n_A)` 上）。要证三条：
  **(i)** `2·row₁ + 3·row₂ − 5·row₃ = 0`；**(ii)** `rank A = 2`（且 `det A = 0`）；
  **(iii)** `ker A = span {(2, −2, 1)}`。
  - (i) 与 (iii) 是 `decide` / `omega` 级；(ii) 需一行秩计算
    （`Matrix.rank`，或直接给两个线性无关行 + (i) 的关系夹出 `rank = 2`）。
  - **(iii) 已经有了**：现有 `iib_gravitational_anomaly_solutions` 就是它的等价形式
    （`↔ n_{3/2} = 2n_A ∧ n_{1/2} = −2n_A`）。⇒ **A8′ 相对 A8 的新增内容是 (i) 与 (ii)**：
    A8 只验证了 `(2, −2, 1)` 使三式为零，**没有排除别的解**，也没写出线性关系。
  - 来源：`bilal-2008` §12.2 (12.4)(12.5)（印刷 p.97 = PDF p.100，v1，L1）
    + `polchinski-1998-v2` (12.2.11)–(12.2.14)（L1，独立第二源，系数逐项相同）。
    **两书都只断言不展示**（Bilal "Amazingly … not linearly independent"；
    Polchinski "the coefficients … conspire to produce zero"），
    且**都不给线性关系、不给秩、不说唯一** ⇒ (i)(ii) 是本项目补出的。
  - 价值：把 Polchinski 亲口说的 "miraculous"/"accidental" 与 Bilal 的 "Amazingly"
    变成一条**完全可判定**的整数矩阵事实——秩是 2 不是 3，一维解空间**是应该出现的**；
    真正非平凡的是解射线恰好穿过 `(2, −2, 1)`，且该向量本原（gcd = 1）⇒ 整数解无整除障碍。
  - 附带已复算（**不必进 Lean，也不是图上的断言**）：`A` 的 Smith 不变因子是 `(1, 144, 0)`。
  - 形式化后：把 `formal.lean_decl` 挂到**陈述卡** `consistency.iib-anomaly-solution-unique`，
    并按本图惯例**新增**一条 `--via-lean` 推导（不覆盖纸上的 `--via-linear-algebra`）。

  **已完成（2026-09-11）**，新文件 `StringFormal/Math/IIBAnomalyUnique.lean`（独立小岛，只 import
  Mathlib；**不** import `AnomalyPolynomial.lean`，(iii) 在本文件内自成一体地重证，不从 A8 借）。
  矩阵与解向量对任意 `CommRing R` 定义：`iibAnomalyMatrix R`、`iibSolutionVector R = ![2, -2, 1]`。
  - **(i)** `iib_rows_relation (R) : (2:R) • A 0 + (3:R) • A 1 - (5:R) • A 2 = 0`——
    **任意交换环**上成立（系数关系是整数恒等式，与基环无关）。
  - **(ii)** `iib_det_zero (R) : (iibAnomalyMatrix R).det = 0`（任意交换环）；
    `iib_rank_eq_two : (iibAnomalyMatrix ℚ).rank = 2`。秩走**秩–零化度**，不是子式：
    先证 `iib_ker_mulVecLin : ker (mulVecLin A) = span ℚ {(2,-2,1)}`，
    再 `finrank_span_singleton` + `LinearMap.finrank_range_add_finrank_ker` + `omega`。
    见证子式另存为 `iib_minor_01_01_det (R) : A 0 0 * A 1 1 - A 0 1 * A 1 0 = -720`（任意交换环）。
  - **(iii)** `iib_kernel_eq (x : Fin 3 → ℚ) : A *ᵥ x = 0 ↔ ∃ t : ℚ, x = t • ![2,-2,1]`，
    以及整数版 `iib_kernel_eq_int`（同一陈述换成 ℤ，`omega`）。
    ⇒ 卡片 (iii) 的 `ker_ℚ` 与 `ker_ℤ` 两句**都**有独立 Lean 定理，不必只靠 A8 的重述。
  - 辅助：`iib_mulVec_apply`（`A *ᵥ x` 的显式三分量）、`iib_mulVec_eq_zero_iff`
    （`A *ᵥ x = 0` ↔ Bilal (12.4) 的三条标量方程，任意交换环）、`iibSolutionVector_ne_zero`。
  - 公理检查：10 条声明全部 `ok`，只有 `propext` / `Classical.choice` / `Quot.sound`
    （2026-09-11 扩到 16 条，含下述任意域版本，仍全 `ok`）。
  - ⚠ **给图的两条提醒**（本轮未改 `graph/`）：
    (a) `--via-lean` 推导的 `depends_on` **不需要**指向
        `consistency.iib-gravitational-anomaly-cancels`：Lean 侧把 (i)(ii)(iii) 一并证了，
        对那张卡只剩「三行系数取自何处」的**来源**关系，那属于 `sources` 而非 `depends_on`
        （纸上的 `--via-linear-algebra` 那条依赖照旧保留，两条推导本就独立）。
    (b) 卡片 (ii) 写「等价地，在任何特征零的域上秩为 2」——**已补齐（2026-09-11）**：
        `iib_rank_eq_two_of_field {K} [Field K] [CharZero K] : (iibAnomalyMatrix K).rank = 2`，
        连同 `iib_kernel_eq_of_field`、`iib_ker_mulVecLin_of_field`（同一秩–零化度论证）；
        `ℚ` 版三条现在是它们的推论，`lean_decl` 可安全担保全称版本。
        真正用到的只有 `(720 : K) ≠ 0`，故另有假设形 `iib_kernel_eq_of_720_ne_zero` /
        `iib_ker_mulVecLin_of_720_ne_zero` / `iib_rank_eq_two_of_720_ne_zero`。
        **数学注记（值得进图 notes）**：`CharZero` 充分但不必要。特征 2 时三行都退化成 `(1,1,0)`、
        特征 3 时都退化成 `(0,1,2)`，秩掉到 1、核变成平面，结论**真的假**；特征 5 虽整除 720，
        但第 0、2 行仍无关，秩 2 与核都成立（只是这条证明走不通）。锐化条件是
        `ringChar K ∉ {2,3}`，未形式化。

- [x] （附带，不属 A8/A9）`gs_gravitational_twelve_form_eq_polchinski`：
  Polchinski (12.2.27) 的**纯引力部分**（令三个规范迹为零）等于 `−1/96` 乘 GS 1984 (20)，
  **五个系数全对**，包括 Polchinski 侧来自 `Y₄X₈/768`、GS 侧写作常数 `1/8` 与 `1/32` 的那两项。
  这比 `consistency.gravitational-anomaly-polynomial-d10` notes 里记的"与 Bilal 括号内容之比
  都是 3/4"更强：那个比较对括号整体重标度，不检验 `n` 无关项与 `n` 相关项在同一整体归一下是否相容；
  这里一个常数 `−1/96` 就把五个系数全部对上。建议补进该卡 notes（Lean 候选 A5 由此闭合且加强）。

### `StringFormal/Math/E8Roots.lean`（Humphreys *Reflection Groups* §2.10 的 E₈ 根系；A11）

- [x] `e8-root-power-sums`（A11）：E₈ 根系的幂和 `Σ_α (α·x)^k`，**对任意 `x : Fin 8 → ℚ` 证到**。
  根表按 Humphreys §2.10 显式列出（`e8Roots : List (Fin 8 → ℚ)`：112 条 `±ε_i ± ε_j` +
  128 条 `½Σ±ε_i`（偶数个负号，实现为"前后两半宇称相同"的两块）；`e8Roots_length = 240`（`rfl`）、
  `e8_dim_248 : 240 + 8 = 248`）。
  `e8_power_sum_two/four/six`：`P₂ = 60 p₂`、`P₄ = 36 p₂²`、`P₆ = 30 p₂³`（`p₂ = Σ x_i²`）；
  `e8_trace_four/six`、`e8_trace_identities`：`P₄ = P₂²/100`、`P₆ = P₂³/7200` = GS (12b′)(12c′) =
  vRSV (176)(177)。与 `literature/extractions/math-sources.md` §44.7 的手算逐项一致，
  两块分别为 `vec_k = 28p₂ / 16p₄+12p₂² / 60p₂p₄−32p₆`、`spin_k = 32p₂ / 24p₂²−16p₄ / 30p₂³−60p₂p₄+32p₆`。
  **证明技术**：六次幂 240 项直接 `ring` 会爆（旋量块 128 × 1716 单项式）；改为把 128 条旋量根
  写成 `{偶}×{偶} ∪ {奇}×{奇}`，内层对 8 个符号型先做二项展开（`inner_ev_six` 等，`ring` 只见
  5 变量六次），外层再合并，`ring` 每次不超过 ~3000 单项式；全文件约 70 s。
  **数据自检**（不参与幂和证明）：`e8Roots_normSq`（每条根 `Σα_i² = 2`，按成员结构证）、
  `e8Roots_nodup`（240 条两两不同：kernel `decide` 不能算 ℚ，改让 `norm_num` 求出每条根的
  四进制指纹 `key : ℕ`，再 `decide` 比较 240 个自然数）、`e8RootSet_card = 240`（`Finset`）、
  `e8RootSet_power_sums`（`Finset` 形式的三条幂和）。
  **未做 / 不在 Lean 内的数学前提**（docstring 已写明）：(i) `Tr_248 F^k = Σ_α (α·x)^k`，即
  "伴随表示的 248 个权 = 240 条根 + 8 个零权，在 Cartan 元 `F = diag(x)` 上求值"；(ii) 要把
  恒等式从 Cartan 子代数推广到整个 e₈ 需要 Chevalley 限制定理（math-sources §44.4，最弱一环）；
  (iii) "这 240 个向量就是 E₈ 的根"在此是**定义**（Humphreys 的表），不是李代数定理；
  (iv) 根表的**完备性**（"L 中所有长度² = 2 的向量都在表里"）未证，只证了 `⊆` 方向（normSq）。
  建议图接线：**不要**把 `lean_decl` 直接挂到 `math.e8-adjoint-trace-identities`（该卡陈述的是
  e₈ 上的伴随迹，比 Lean 证的宽）；应新建 `math.e8-root-system-power-sums`（formalized，
  `lean_decl: StringFormal.Math.E8.e8_trace_identities`），再给 `math.e8-adjoint-trace-identities`
  加一条 `--via-root-power-sums` 推导，依赖新卡 + "伴随权 = 根 ∪ 零权"（待建）+ Chevalley 限制
  （待建）。这条推导比现有 `--via-casimir-structure`（physical-argument）强：系数来历有了。
  Humphreys Table 1 的次数表 `2, 8, 12, 14, 18, 20, 24, 30` 在此路线中**不需要**。

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
    **已有 generic `N ≤ 4` 替代（2026-09-11）**：见 `StringFormal/Virasoro/GenericIndependence.lean`
    （无 sorry，公理只有标准三条）。`linearIndependent_of_gram_det_ne_zero`：任意交换整环上、
    任意双线性型 `B`、`det [B(vᵢ,vⱼ)] ≠ 0` ⟹ `v` 线性无关（Mathlib 只有内积空间版
    `Matrix.linearIndependent_of_det_gram_ne_zero`）。配上已算出的 Kac 行列式即得
    `IsContravariant.linearIndependent_descFamily{2,3,4}`：**只要该层 Kac 多项式在 `(c,h)` 处不为零**
    （即一般 `(c,h)`），`N = 2,3,4` 的 `p(N)` 个标准降算符向量线性无关。
    `IsContravariant.finrank_levelSpan_{two,three,four}`：**`dim V_N = p(N)` 对 `N = 2,3,4`**
    （分别 `2, 3, 5`；PBW 等式的前三个实例，(a) 只给到 `≤`）。
    **上界不走 `finrank_levelSpan_le_card_partition`**：`p(3) = 3`、`p(4) = 5` 的计数从未用到。
    `levelSpan_{two,three,four}_eq_span_descFamily{2,3,4}` 无条件地把张成集直接砍到 `p(N)` 个标准
    向量（`V₂ = span{L₋₂|c,h⟩, L₋₁²|c,h⟩}` 等）。`N = 2` 靠枚举 `Composition 2`
    （`composition_two_blocks`）；**`N = 3,4` 靠 (a) 的 `levelSpan_eq_ordSpan` 先做整序**，
    再用纯算术枚举**有序词**：`ordWord_sum_three`（总模态 `-3` 的有序词恰是 `[-3]`、`[-2,-1]`、
    `[-1,-1,-1]`）、`ordWord_sum_four`（`-4` 的恰是 `[-4]`、`[-3,-1]`、`[-2,-2]`、`[-2,-1,-1]`、
    `[-1,-1,-1,-1]`）。证明只用「非负整数列非降且各项 ≤ -1、和给定」，`omega` 逐情形收尾，
    **不碰 Virasoro 关系**（整序恒等式 `L₋₁L₋₂v = L₋₂L₋₁v + L₋₃v` 已被 (a) 的 `straighten` 吸收）。
    `Composition 3` 有 4 个、`Composition 4` 有 8 个，多出的 `[1,2]` / `[1,3],[1,2,1],[1,1,2]`
    正是被整序消掉的非标准词。`three_le_finrank_levelSpan_three`、`five_le_finrank_levelSpan_four`
    保留为等式的 `≥` 半边推论。
    原先记录的障碍（`Fintype.card (Nat.Partition 3) = 3`，Mathlib 没有基数引理且 `decide`
    化不开 `Fintype.ofSurjective` 实例）**因此被绕过而非解决**：`Nat.Partition` 的计数仍然缺。
    `N ≥ 5` 同法可做，但需要该层 Kac 行列式（`ShapovalovLevelFive.lean` 不存在）；
    有序词枚举本身在 `N = 5` 是 7 个情形、长度 ≤ 5，`match` 分支数随 `N` 线性增长，
    不是瓶颈——**瓶颈是 Gram 行列式**。
    `kac_level_two_pos`：有序域上 `h > 0`、`c > 1` ⟹ 层 2 行列式 `> 0`，故该区无需行列式假设
    （`linearIndependent_descFamily2_of_pos`）。**`c` 无上界限制**：`c > 25` 时 Kac 二次式确有实根，
    但两根之和 `(5-c)/8 < 0`、积 `c/16 > 0`，故两根皆负，与 `h > 0` 无关；闭区域 `h > 0, c ≥ 1`
    上唯一零点是 `c = 1, h = 1/4`（`kac_level_two_at_c_one`：行列式 `= 2h(4h-1)²`）。
    该零点处的退化方向已给出：`desc2_sub_desc11_orthogonal_levelSpan_two`——`c = 1, h = 1/4` 时
    level-2 Gram 矩阵三个元全等于 `3/2`，故 `(L₋₂ − L₋₁²)|c,h⟩` 与整个 `V₂` 正交
    （即一般奇异向量 `(L₋₂ − 3/(2(2h+1)) L₋₁²)|c,h⟩` 在 `h = 1/4` 的系数恰为 1）。
    **由此也说明 Gram 判据不可逆**：`det = 0` **不**蕴含向量线性相关（按 PBW 它们对所有 `(c,h)`
    都独立），只说明形式在其张成上退化。
    **仍未做**：真正的 (b)。generic 版**不是** PBW：它假设存在归一化逆变型（等价于 `hwv ≠ 0`，
    见 `exists_isContravariant_iff_hwv_ne_zero`），而这正是 (b) 的推论；且在 Kac 零点处失效
    （那里向量可能仍独立，只是形式退化）。所以这是 `dim V_N = p(N)` 的**条件**、**一般点**版本。
  `V(c,h) ≠ 0` 是 (b) 的推论；在 (b) 之前 `Verma.lean` / `VermaPBW.lean` 里的一切都可能是空洞真，
  `dim V_N = p(N)` 除 generic `N = 2,3,4` 外只证到 `≤`。这一项是 `shapovalov-form` 与
  `kac-determinant` 的前提。
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
  - **level 3**（2026-09-11，`StringFormal/Virasoro/ShapovalovLevelThree.lean`，无 sorry，
    公理只有标准三条）：对 `desc3 = L₋₃v`、`desc21 = L₋₂L₋₁v`、`desc111 = L₋₁³v` 的
    9 个内积（`gram_level_three_entries`，非对角项经 `IsContravariant.comm` 对称）：

        ⟨L₋₃v, L₋₃v⟩ = 6h + 2c      ⟨L₋₃v, L₋₂L₋₁v⟩ = 10h      ⟨L₋₃v, L₋₁³v⟩ = 24h
        ⟨L₋₂L₋₁v, L₋₂L₋₁v⟩ = 8h² + ch + 8h        ⟨L₋₂L₋₁v, L₋₁³v⟩ = 36h² + 12h
        ⟨L₋₁³v, L₋₁³v⟩ = 48h³ + 72h² + 24h

    3×3 行列式 `gram_level_three_det`：

        det₃ = 48 h² (16h² + 2h(c−5) + c) (3h² + h(c−7) + c + 2)

    中间因子正是 level-2 行列式除以 2h——与 Kac 公式预言的「rs = 2 的根在 N = 3 以重数
    p(3−2) = p(1) = 1 重现」逐项吻合。`gram_level_three_det_eq_kac` 把它写成 Kac 乘积形

        det₃ = 2304 (h − h₁₁)² (h − h₁₂)(h − h₂₁)(h − h₁₃)(h − h₃₁),

    Kac 根只经对称函数进入（假设形式：`h₁₁ = 0`、`8(h₁₂+h₂₁) = 5−c`、`16h₁₂h₂₁ = c`、
    `3(h₁₃+h₃₁) = 7−c`、`3h₁₃h₃₁ = c+2`），所以定理与 √((c−1)(c−25)) 的分支约定无关。
    辅助引理 `kac_factor_rs_two` / `kac_factor_rs_three` 是清分母后的二次因式分解；
    `kac_level_three_at_c_one` 是 c = 1 处的退化核对：det₃ = 144h²(4h−1)²(h−1)²，
    与 `h_{r,s} = (r−s)²/4` 给的 h₁₁ = 0、h₁₂ = h₂₁ = 1/4、h₁₃ = h₃₁ = 1 一致（完全平方）。
    另有 `desc3/desc21/desc111_mem_levelSpan` 与正交性实例
    `gram_level_one_three` / `gram_level_two_three`。
    ⚠ 线性无关（= PBW）同样仍缺，故这依旧是**张成集**的 Gram 行列式，
    与「level-3 的 Kac 行列式」的等同差 `pbw-verma` (b)，同 level 2。
  - **level 4**（2026-09-11，`StringFormal/Virasoro/ShapovalovLevelFour.lean`）：
    5×5 Gram 矩阵与 `N = 4` Kac 行列式，详见下面 `kac-determinant` 条的 **N = 4 已完成**。
- [ ] `kac-determinant`：Kac 行列式公式。这是独立的、有价值的数学形式化目标；对应 `worldsheet.kac-determinant`。可能很长，允许先做低阶的显式版本。`N = 1, 2` 的显式 Gram 矩阵已在 `Shapovalov.lean`，`N = 3`（3×3，含与 Kac 乘积形的等同）已在 `ShapovalovLevelThree.lean`，`N = 4`（5×5，含与 Kac 乘积形的等同）已在 `ShapovalovLevelFour.lean`（均对具体向量，非基）。
  - **常数 α_N 的正确形状（2026-09-11，formalizer 用 CAS 独立核对，未形式化）**：
    `worldsheet.kac-determinant` 卡上悬而未决的 α_N，在本仓库这组 PBW 型基下满足

        α_N = ∏_{r,s≥1, rs≤N} ( (2r)^s · s! )^{ p(N−rs) − p(N−r(s+1)) }。

    注意指数是 **p(N−rs) − p(N−r(s+1))**，不是某些文献里随手写的 p(N−rs)。
    数值核对：N=1 → 2；N=2 → 32（= `gram_level_two_det` 的 2·16）；
    N=3 → 2304（= 48·16·3，本文件的 `gram_level_three_det_eq_kac`）；
    N=4 → 37748736（= 384·16²·3·8·16，由 5×5 Gram 的 CAS 行列式反读）。
    用 p(N−rs) 当指数会给 N=2 → 64、N=3 → 36864，与实际行列式**不符**。
    ⇒ α_N > 0 在 N ≤ 4 上是**已核对的事实**（每个因子都是正整数），
    但一般 N 的正性仍只是这个乘积公式的推论，而该公式本身未形式化也未在已核实来源里逐字找到。
  - **N = 4 已完成**（2026-09-11，`StringFormal/Virasoro/ShapovalovLevelFour.lean`，
    无 sorry，60 条声明 `check_axioms` 全 `ok`）：基
    {L₋₄, L₋₃L₋₁, L₋₂², L₋₂L₋₁², L₋₁⁴}（p(4) = 5），15 个独立 Gram 元：

        ⟨L₋₄v,L₋₄v⟩ = 8h+5c    ⟨L₋₄v,L₋₃L₋₁v⟩ = 14h    ⟨L₋₄v,L₋₂²v⟩ = 24h+3c
        ⟨L₋₄v,L₋₂L₋₁²v⟩ = 36h    ⟨L₋₄v,L₋₁⁴v⟩ = 120h
        ⟨L₋₃L₋₁v,L₋₃L₋₁v⟩ = 4ch+12h²+12h    ⟨L₋₃L₋₁v,L₋₂²v⟩ = 30h
        ⟨L₋₃L₋₁v,L₋₂L₋₁²v⟩ = 40h²+20h    ⟨L₋₃L₋₁v,L₋₁⁴v⟩ = 192h²+48h
        ⟨L₋₂²v,L₋₂²v⟩ = c²/2+8ch+4c+32h²+32h    ⟨L₋₂²v,L₋₂L₋₁²v⟩ = 6ch+48h²+48h
        ⟨L₋₂²v,L₋₁⁴v⟩ = 216h²+144h    ⟨L₋₂L₋₁²v,L₋₂L₋₁²v⟩ = 4ch²+2ch+32h³+116h²+32h
        ⟨L₋₂L₋₁²v,L₋₁⁴v⟩ = 288h³+336h²+96h    ⟨L₋₁⁴v,L₋₁⁴v⟩ = 384h⁴+1152h³+1056h²+288h

    `gram_level_four_22_22` 是唯一带分数系数的元（1/2 写作 `centralTerm R 2`；
    另有无分母形式 `two_mul_gram_level_four_22_22`）。5×5 行列式
    `gram_level_four_det`（`Matrix.det !![…]`）：

        det₄ = 384 h³ (8h + c − 1) (16h² + 2h(c−5) + c)² (3h² + h(c−7) + c + 2)
                   (16h² + 10ch − 82h + 15c + 66),

    其中 (8h + c − 1) = 8(h − h₂₂)（h₂₂ = (1−c)/8，rs = 4 的有理根，首次出现），
    末因子 = 16(h − h₁₄)(h − h₄₁)（h₁₄+h₄₁ = (41−5c)/8，h₁₄h₄₁ = (66+15c)/16）。
    重数 3, 2, 1, 1 = p(3), p(2), p(1), p(0) 与 Kac 公式吻合；
    `gram_level_four_det_eq_kac` 把它写成

        det₄ = 37748736 (h−h₁₁)³ ((h−h₁₂)(h−h₂₁))² (h−h₁₃)(h−h₃₁) (h−h₂₂) (h−h₁₄)(h−h₄₁),

    Kac 根仍只经对称函数进入（新增假设：`8h₂₂ = 1−c`、`8(h₁₄+h₄₁) = 41−5c`、
    `16h₁₄h₄₁ = 15c+66`），与 √((c−1)(c−25)) 的分支约定无关。
    辅助引理 `kac_factor_rs_two_two` / `kac_factor_rs_four`；
    `kac_level_four_at_c_one` 是 c = 1 处的退化核对：
    det₄ = 9216 h⁴ (4h−1)⁴ (h−1)² (4h−9)²（h₂₂ 在 c=1 处并到 h₁₁ = 0，故 h 的重数升到 4）。
    另有 `desc4/desc31/desc22/desc211/desc1111_mem_levelSpan` 与正交性实例
    `gram_level_three_four`。
    ⚠ 线性无关（= PBW）同样仍缺，故这依旧是**张成集**的 Gram 行列式，
    与「level-4 的 Kac 行列式」的等同差 `pbw-verma` (b)，同 level 2/3。

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
- [x] `fock-gram`：振子 Fock 空间上**产生单项式的 Gram 矩阵**，即图卡
  `worldsheet.transverse-ddf-fock-gram-matrix`（(H1)–(H4) 下的条件命题）在 `Fock D R` 上的实例。
  见 `StringFormal/NoGhost/FockGram.lean`（不改 `Fock.lean`，只加新文件）：
  - `creationMonomial R d`（`d : Osc D →₀ ℕ`）= `∏_{(μ,n)} (α^μ_{-n})^{d(μ,n)} |0⟩`；
    `creationMonomial_eq_monomial`（= `monomial d 1`）、`creationMonomial_zero` /
    `_single` / `_add_single`（递归刻画：逐个作用产生算子）、
    `creationMonomial_mem_levelSubmodule`（level = `Σ n·d(μ,n)`）。
  - (H1)：`commute_creation`（`Module.End` 里的 `Commute`）与
    **`foldr_creation_vacuum`**——沿**任意**枚举多重集 `d` 的列表逐个作用产生算子，结果相同，
    这是「乘积只依赖多重集」的精确含义（用 `List.count` 表述列表枚举 `d`）。
  - 第 (1) 步 Leibniz：**`annihilation_creationMonomial`**
    `α^μ_n ∏(α_{-m})^d |0⟩ = n η^{μμ} d(μ,n) · ∏(α_{-m})^{d-δ} |0⟩`，
    以及 `annihilation_creationMonomial_add_single`（递归形，系数 `n η^{μμ}(d(μ,n)+1)`）、
    `annihilation_creationMonomial_of_apply_eq_zero`。
  - 第 (2) 步：`pairing_creationMonomial_add_single`（由伴随性 + 第 (1) 步得到的递推）与主结论
    **`pairing_creationMonomial`**：`⟨mono d, mono e⟩ = δ_{d,e} ∏ (n η^{μμ})^{d(μ,n)} d(μ,n)!`
    （`monomialNorm`），加 `_of_ne` / `_self`；`monomialNorm_one` 与
    `pairing_creationMonomial_one` 给 η ≡ 1（横向/正定）时图卡字面的 `∏ n^{d} d!`。
  - **`pairing_creationMonomial_of_hypotheses`**：条件版，对**任意**满足 `⟨0|0⟩ = 1`(H4) 与
    产生/湮灭互为伴随 (H2)(H3) 的双线性型 `B` 成立（经 `Fock.pairing_unique`）。
    这条才是图卡的忠实 Lean 对应——**`Fock.pairing` 是按单项式基对角地*定义*的**，
    所以 `pairing_creationMonomial` 本身廉价，数学内容在 `pairing_unique` 与这条条件版里。
    图侧推导应引这条，不要引对角那条。
  - 第 (3) 步：`monomialNorm_pos` / `pairing_creationMonomial_self_pos`（有序环，需 `∀ μ, 0 < η μ`）、
    `pairing_self_pos_of_ne_zero`（全序环上**正定**：η > 0 时整个 Fock 空间无零/负模态）；
    `linearIndependent_creationMonomial` 与 `basisMonomials_eq_creationMonomial`
    （线性无关对**任意**基环成立，比「有序域上由正定推出」更强）。
  - **正特征退化（新发现）**：`monomialNorm_single` 与
    **`pairing_creationMonomial_self_eq_zero_zmod_two`**——`ZMod 2` 上（η ≡ 1）
    `(α^1_{-1})²|0⟩` 的模为 `2! = 0`。图卡结论 (1) 对**任意交换环**成立，
    但结论 (2)（正交基 + 正定）除了序之外还需要对角元 `∏ n^d d!` 在 R 中非零，
    即**特征 0**（有序域自动满足）。图卡应将此记入 notes/边界。
  公理检查：25 条声明全部 `ok`，只用 `propext` / `Classical.choice` / `Quot.sound`
  （`--import StringFormal.NoGhost.FockGram --all`，2026-09-11）。
  **数学缺口（对图）**：(a) 本文件把 (H1)–(H4) 证成了*定理*，因此证明了图卡的结论并说明假设集自洽，
  但**没有**证明 DDF 算子满足 (H1)–(H4)——那是无鬼岛里另一项义务；
  (b) 正定性要求 η 逐分量为正，mostly-plus Minkowski 的类时方向不成立
  （`Fock.pairing_X_X_minkowski_timelike`），这正是无鬼定理只谈**横向**扇区的原因；
  (c) 零模（动量 `k`）、完化、复埃尔米特版本的缺口与 `Fock.lean` 文件头相同，未新增。
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
- [x] `ddf-operators`：DDF 算子及其对易关系（横向振子代数）。**算子部分已完成**
  （构造、`⁅L_m, A^ε_n⁆ = 0` ∀m、保物理子空间、伴随、`[A^ε_m, A^δ_n] = m(ε·δ)δ_{m+n,0}`）；
  张成性属于下一项 `ddf-spans`。见
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
  - [x] (3) **共形权 `[L_m, V]`**：**一切 `m : ℤ` 已证**（`m ≥ 1` 见 (3d) 单 Fock、(3e) 塔上；
    `m ≤ -1` 见 (3c')、(3f)；`m = 0` 见 (3g)，真空上的形式见 (3c)）。合并声明
    `Fock.lie_Lop_vertexOsc`（`StringFormal/NoGhost/VertexWeightZero.lean`）对所有 `m` 成立。陈述是
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
      **塔上的 `m = 0` 版本已补**：`lie_towerLop_towerVertex`（见 (6)），即把 (3g) 搬到塔上。
      （原列的「`m = 0` 的一般态算子形式」已由 (3g) 补上；
      当时同时写下的「系数多项式在 `m = 0` 处**不适用**」是**错的**，见 (3g)。）
    - [x] (3g) `m = 0` 的 `[L_0, V_J]`：**已证**
      `Fock.lie_Lop_vertexOsc_zero`（`StringFormal/NoGhost/VertexWeightZero.lean`）
      `L_0^{(a+b)} ∘ V_J - V_J ∘ L_0^{(a)} = (J + a·b + ½ (b·b)) • V_J`。
      **数学结论（订正此前记录）：系数与 `m ≠ 0` 的通式一致。** 通式
      `J - m + a·b + ½ (m+1)(b·b)` 在 `m = 0` 处给 `J + a·b + ½ (b·b)`，正是所证系数。
      此前「代 `m = 0` 给错答案」的说法只对**真空引理**成立，对**对易子系数**不成立：
      * 真空引理确实变形状。`m ≥ 1` 靠 `Fock.Lop_apply_one_of_pos`（`L_m|k⟩ = 0`）；
        `m = 0` 时 `L_0^{(a)}|k⟩ = ½ (a·a)|k⟩`（`Fock.Lop_zero_apply_one`）非零。
      * 相应地 `Fock.Lop_apply_creaExp_zero_shifted` 给
        `L_0^{(a+b)} Φ_J = (J + ½ (a·a) + a·b + ½ (b·b)) Φ_J`，比
        `Fock.Lop_apply_creaExp_of_pos_shifted` 在 `m = 0` 处的形式**多出 `½ (a·a)`**。
      * 在对易子里 `V_J L_0^{(a)}|k⟩ = ½ (a·a) Φ_J` 恰好把这一项减掉，两处偏差抵消。
      这就是为什么 `m = 0` 必须单独证（真空值不同），而结果又落回同一条多项式。
      `Fock.eq_zero_of_vertex_recursion` 的产生模态递推同样不用 `m` 的符号（`m = 0` 也不例外），
      所以 (3d) 的递推块逐字照搬。
      合并推论：`Fock.lie_Lop_vertexOsc`（**一切 `m : ℤ`**）与
      `Fock.lie_Lop_vertexOsc_isotropic`（`b·b = 0`，权 1 准初级场变换律，无 `m` 限制）。
      辅助：`Fock.zeroModeSq_add`（极化 `(a+b)·(a+b) = a·a + 2 a·b + b·b`）。
      无 sorry，5 条声明 `check_axioms` 全 `ok`，公理只有标准三条。
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
    - **已补齐**：`m ≤ -1` 见 (5)，`m = 0` 见 (6)；全部 `m ∈ ℤ` 已证。
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
    - **`m = 0` 已补齐，见 (6)**。当时的判断得到验证：`hm : m ≠ 0` 在
      `lie_towerLop_ddfOp_of_ne` 里只用了一次（引用 `lie_towerLop_ddfSummand_of_ne`），
      伸缩和与上面的窗口分析在 `m = 0` 处逐字成立（`m = 0` 时两项
      `(j-m) G_{j-m}` 与 `j G_j` 本来就相同，单项括号自己就是零），
      唯一要重做的就是把单 Fock 恒等式 (3g) 搬到塔上。
  - [x] (4b) **塔上的物理子模与「`A^ε_n` 保持正模条件」**：
    `StringFormal/NoGhost/TowerPhysical.lean`，无 sorry，8 条声明公理只有标准三条。
    - `towerPositiveModeSubmodule η a b = {Ψ | ∀ m ≥ 1, L_m Ψ = 0}`（只正模条件），
      展开引理 `mem_towerPositiveModeSubmodule`。
    - **`ddfOp_mem_towerPositiveModeSubmodule`**：`k_0² = 0`、`2α' k_0·p = 1`、`ε·k_0 = 0`，
      `Ψ` 满足正模条件 ⟹ `A^ε_n Ψ` 也满足。证明是 `lie_towerLop_ddfOp_of_pos` 的
      一行推论：`L_m (A_n Ψ) = A_n (L_m Ψ) + ⁅L_m, A_n⁆ Ψ = 0 + 0`。
    - `towerL0Submodule η a b a₀`、`towerPhysSubmodule η a b a₀`（= L_0 条件 ⊓ 正模条件）
      及其展开引理；保持性定理见 (6)。
    - **数学上的一个订正**：最初以为 `L_0` 条件在塔上逐层截距不同、不能用单一 `a₀`，
      这是错的。`towerLop η a b 0` 本就按各层自己的动量 `p_j = a + j·b` 求值，
      所以单一 `a₀` 是正确且均匀的条件；它在层 `j`、振子 level `N` 上读作
      `α'k² + j + N = a₀`，恰好选出反对角线 `j + N` 为常数。
      `invTwo_zeroModeSq_towerMomentum_add_shift_cancel` 把这个抵消写成引理：
      `ddfSummand η a b ε n j` 把层 `+n`（`towerVertex_single`）、level `-n`
      （顶点算子 `+(j-n)`、`α^ε_j` `-j`），`L_0` 本征值不变，且与求和指标 `j` 无关。
      **因此阻碍不在塔结构，而纯粹在 `m = 0` 括号未形式化**——该括号已由 (6) 补上。
  - [x] (6) **`⁅L_m, A^ε_n⁆ = 0` 对一切 `m ∈ ℤ`，以及「`A^ε_n` 保持塔上物理子空间」**：
    `StringFormal/NoGhost/DDFOperatorAll.lean`，无 sorry，7 条声明公理只有标准三条。
    - `lie_towerLop_towerVertex` / `_normalized`：塔上共形权恒等式与归一化的权 0 变换律
      `⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}`，**一切 `m ∈ ℤ`**。证明与 (5) 的 `_of_ne`
      逐字相同，只把单 Fock 输入 `Fock.lie_Lop_vertexOsc_of_ne` 换成 (3g) 的
      `Fock.lie_Lop_vertexOsc`。这是整个 `m = 0` 升级里**唯一**需要重新核对的地方，
      而它成立正是因为 (3g) 证明的系数多项式 `J - m + a·b + ½(m+1)(b·b)` 与 `m ≠ 0` 通式
      同一个函数（不是"恰好在 `m = 0` 取值相同"，是同一条多项式）。
      `k_0² = 0` 依然必要，理由同 (3e)。
    - `lie_towerLop_ddfSummand_all`（不带后缀的名字已被 (4) 的 `m > 0` 版占用）、
      **`lie_towerLop_ddfOp`**、`lie_towerLop_ddfOp_zero`。(5) 的预判得到确认：
      伸缩和与窗口分析在 `m = 0` 逐字成立，`|m| = 0` 时四条边带为空、两个窗口重合，
      论证退化为 `∑ (g j - g j) = 0`，不需要任何 case split。
    - **`ddfOp_mem_towerL0Submodule`**：`L_0 (A_n Ψ) = A_n (L_0 Ψ) = a₀ • A_n Ψ`，
      截距 `a₀` **不变**（算术理由是 (4b) 的
      `invTwo_zeroModeSq_towerMomentum_add_shift_cancel`：层 `+n` 与 level `-n` 抵消）。
    - **`ddfOp_mem_towerPhysSubmodule`**：两半合起来，`A^ε_n` 把塔上的旧协变物理子空间
      映到自身。这是 `worldsheet.ddf-operators-v5` 的算子内容，也是图节点
      `worldsheet.ddf-commute-with-virasoro`（∀m）第一次可以标 formalized 的依据。

  - [x] (5) **横向代数第一步：正交动量的顶点算子彼此对易**：
    `StringFormal/NoGhost/VertexCommute.lean`，无 sorry，17 条声明公理只有标准三条
    （2026-09-11 用 `--import StringFormal.NoGhost.VertexCommute --all` 复核）。
    - **无缩并引理** `Fock.vertexSub_creaExp_of_dotVec_zero`：`b·b' = 0` ⟹
      `vertexSub b (Φ^{b'}_j) = Polynomial.C (Φ^{b'}_j)`，即平移 `X_{μ,l} ↦ X_{μ,l} - b^μ T^l`
      **原样固定**另一动量的相干态系数。这是收缩公式
      `E_+(b,z) E_-(b',w) = exp((b·b') Σ_{l≥1} (w/z)^l / l) · E_-(b',w) E_+(b,z)` 的系数形式，
      正交时标量因子为 `1`。证明**不需要**任何指数恒等式：对 `j` 归纳，把 (3a) 的欧拉递推
      `Fock.creaExp_euler` 整体穿过代数同态 `vertexSub b`，多出的项是
      `-(b'·b) T^l Φ_{j-l}`（私有引理 `vertexSub_sum_creation_mul`，**全文件唯一**用到
      `b·b' = 0` 的地方），然后用 `ℚ`-代数里除以 `M` 消掉标量。
    - 算子形式（题目要求的第 1 步）：`Fock.vertexAnn_creaExp_mul_of_dotVec_zero`
      （`E_+(b)_L ∘ E_-(b')_j = E_-(b')_j ∘ E_+(b)_L`）与
      `Fock.vertexAnn_creaExp_of_dotVec_zero`（`E_+(b)_L Φ^{b'}_j = δ_{L,0} Φ^{b'}_j`）。
    - 真空基：`Fock.vertexOsc_apply_creaExp_of_dotVec_zero`，`V^{(b)}_J Φ^{b'}_K = Φ^b_J Φ^{b'}_K`，
      右端对 `(b,J) ↔ (b',K)` 显然对称——这正是对易的底。
      推广 `Fock.vertexOsc_creaExp_mul_of_dotVec_zero`：`V^{(b)}_J (Φ^{b'}_c · P) = Φ^{b'}_c · V^{(b)}_J P`。
    - 归纳步：`Fock.eq_zero_of_vertex_recursion₂`（`eq_zero_of_vertex_recursion` 的**双指标**版）。
      两个顶点算子的乘积满足
      `W_{J,K}(X_v P) = X_v W_{J,K}P - b^{v.1} W_{J+n,K}P - b'^{v.1} W_{J,K+n}P`，
      每个动量只移自己的 Laurent 指标；对易子满足同一条递推，故由真空值决定。
    - **主定理** `Fock.vertexOsc_comm_of_dotVec_zero` / `Fock.lie_vertexOsc_vertexOsc_of_dotVec_zero`：
      `b·b' = 0` ⟹ `V^{(b)}_J V^{(b')}_K = V^{(b')}_K V^{(b)}_J`（题目要求的第 2 步）。
      注意这**不需要** `z ≠ w`，也没有任何单值因子：正交动量的两个指数顶点算子的 OPE 无奇点。
    - **塔上版本**（第 3 步）：`towerVertex_comm_of_isotropic` /
      `lie_towerVertex_towerVertex_of_isotropic`，`k_0² = 0` ⟹ `V^{(m)}_J` 与 `V^{(n)}_K` 对易。
      动量算术是 `dotVec_vertexMomentum`：`(m k_0)·(n k_0) = mn k_0²`；零模半是层移位
      `towerShift`，平凡对易（`j+n+m = j+m+n`）。
      **数学要点**：`k_0² ≠ 0` 时结论**假**——收缩给出单值因子 `(w/z)^{mn k_0²} ≠ 1`，
      所以这条对易性是「类光参考矢量」这个假设第二次真正起作用的地方
      （第一次是 (3e) 的塔上共形权）。
    - **[x] 做完了 (5a)** 同点乘积 `Σ_{J+K=L} V^{(b)}_J V^{(b')}_K = V^{(b+b')}_L`（`b·b'=0`）：
      `StringFormal/NoGhost/VertexProduct.lean`，无 sorry，17 条声明公理只有标准三条
      （2026-09-11 用 `--import StringFormal.NoGhost.VertexProduct --all` 复核）。
      主定理 **`Fock.vertexProduct_eq_vertexOsc_add`**（算子等式）与
      **`Fock.sum_vertexOsc_vertexOsc_of_dotVec_zero`**（有限和形式：任何包含窗口
      `-levelBound P ≤ K ≤ L + levelBound P` 的指标集都算得对）。三块都齐了：
      ① **相干态加法公式** `Fock.creaExpPair_eq_creaExp_add`：
      `Φ^{b+b'}_j = Σ_{p+q=j} Φ^b_p Φ^{b'}_q`（即 `E_-(b)E_-(b') = E_-(b+b')`），
      **对任意动量成立，不需要正交性**——产生半永远是交换环里的乘法，缩并只出在湮灭半。
      证明是欧拉递推的唯一性：`Fock.creaExpPair`（卷积，窗口 `Icc 0 j`）、
      `Fock.creaExpPair_eq_sum_Icc`（任何包含 `[0,j]` 的窗口都算得对）与
      `Fock.sum_mode_creaExpPair_eq_smul`（卷积满足**同一条** `b+b'` 的欧拉递推），
      再在 `ℚ`-代数里除以 `j`。
      ② **局部有限性已证**。上一位预判的辅助事实成立且是全部内容：
      **`Fock.vertexAnn_mem_levelSubmodule`**（`Ψ^b_M` 把 level `N` 送到 level `N - M`，
      对单项式按 level 强归纳，用 `vertexAnn_mul_X` 逐个剥 `X_v`）、
      `Fock.vertexAnn_apply_eq_zero_of_level`（`M > N` 时为零）与推论
      **`Fock.levelBound_vertexAnn_le`**：`levelBound (Ψ^b_M P) ≤ levelBound P`，
      **对 `M` 一致**。有了它，`vertexOsc_creaExp_mul_of_dotVec_zero` 把 `Φ^{b'}_{K+M}`
      提到左边后，`Fock.vertexOsc_vertexOsc_apply_eq_zero_of_gt` 给出
      「`V^{(b)}_J V^{(b')}_K P = 0` 只要 `levelBound P + J < 0`，**与 `K` 无关**」，
      这正是朴素 level 计数拿不到的那一步。下端 `_of_lt` 直接是
      `vertexOsc_apply_eq_zero_of_levelBound_lt`。窗口 `Fock.vertexProdIdx`。
      ③ **组装已证**。`Fock.vertexProduct` 用 `lsumLocFin`（局部有限性作为定义的一部分，
      所以 `hdot` 是定义的参数）；`Fock.vertexProduct_X_mul` 是 `b+b'` 的产生递推
      （两个 `V` 各移自己的指标，把第二个修正和重标 `K ↦ K+n` 后两项并成 `W_{L+n}`，
      系数相加成 `(b+b')^μ`——重标用私有引理 `sum_add_right_eq_sum`）；
      `Fock.vertexProduct_apply_one` 是真空值，正是 ① 的卷积；
      最后 `Fock.vertexOsc_unique` 收尾。
      **塔版本**（超出原计划）：`sum_towerVertex_towerVertex_single_of_isotropic`（单层）与
      **`sum_towerVertex_towerVertex_of_isotropic`**（任意塔矢量）：`k_0² = 0` 时
      `Σ_{J+K=L} V^{(m)}_J V^{(n)}_K = V^{(m+n)}_L`。动量算术是 `vertexMomentum_add`
      （`m k_0 + n k_0 = (m+n) k_0`），零模半是 `j + n + m = j + (m+n)`。
      **数学要点（供图节点 `gaps`）**：`b·b' ≠ 0` 时结论**假**，不只是没证——缩并给出
      `exp((b·b') Σ_{l≥1} (w/z)^l/l) = (1 - w/z)^{-b·b'}`，它的展开把所有 Laurent 指标
      混起来，`K`-求和不再局部有限，乘积也不是单个顶点算子。塔上这就是 `k_0² = 0`
      第三次真正起作用的地方（前两次：(3e) 塔上共形权、(5) 顶点算子对易）。
      **另一条更省的路（未走）**：湮灭半也有加法公式 `Σ_{L1+L2=M} Ψ^b_{L1}Ψ^{b'}_{L2} = Ψ^{b+b'}_M`
      （两次平移的复合＝平移之和，代数同态在生成元上比较即可，**且这个和是有限的**），
      配上 ① 可以把整个乘积公式化成三重和的重排；但重排里对 `K` 的求和仍是无限的，
      局部有限性 ② 绕不过去。
    - **[x] 做完了 (5b)** 加权和 `Σ_j j V^{(m)}_j V^{(n)}_{-j} = m δ_{m+n,0}`（塔上，`k_0² = 0`、
      `2α'k_0·p = 1`）：`StringFormal/NoGhost/VertexWeightedSum.lean`，无 sorry，
      35 条声明公理只有标准三条（2026-09-11 用
      `--import StringFormal.NoGhost.VertexWeightedSum --all` 复核）。
      主定理 **`sum_weighted_towerVertex_towerVertex`**。
      **上一位的两条记录都被独立复核确认**：
      (i) `L_0` Leibniz 那条路确实死了（重算一遍：`T_0 + U_0 = 0·S_0` 在 `L = 0` 退化成
      `0 = 0`），必须引入 `k_0·∂X` 这个场本身；
      (ii) `Fock.lie_mode_vertexOsc` 与 `k_0` 缩并后为零**正是**正确的工具，但它的作用
      **不是**"全导数"本身，而是给二重和一个**与另一个求和指标无关**的下端截断
      （见下面第 3 点）。
      **真正缺的原子事实（本文件的核心，约 250 行）**是**权恒等式**
      **`Fock.vertexCurrent_eq`**：`b·b = 0` ⟹
      `Σ_J (b·α_{-J}) V^{(b)}_{L-J} = (L + b·a) V^{(b)}_L`，
      即 `z ∂_z :e^{i b·X}: = :(i b·z∂_z X) e^{i b·X}:` 的代数形式。
      它**不是**对易子陈述（左边是乘积不是括号），所以 `lie_*` 系列都用不上；
      证明走刚性：两边满足**同一条**产生模态递推，且真空值相同。
      * 新算子 `Fock.dotMode η c a J = Σ_μ η_μ c^μ α^μ_{-J}`（指标约定与 `vertexOsc` 对齐：
        升 level `J`）。`c·b = 0` ⟹ 与 `V^{(b)}_K` **对易**（`Fock.dotMode_vertexOsc_comm`）。
      * 递推 `Fock.vertexCurrent_X_mul` 比顶点算子自己的递推多一项
        `k b^μ V_{L+k}`（来自 `⁅b·α_{-J}, α^μ_{-k}⁆ = k b^μ δ_{J,-k}`，`Fock.dotMode_X_mul`），
        而 `(L + b·a) V_L` 求导前缀 `L` 也恰好多出**同一项**——两者相消，这是整条证明的支点。
      * 真空值用现成的欧拉递推 `Fock.sum_mode_creaExp_eq_smul`；`J < 0` 的湮灭尾因
        `annihilation_creaExp` 给出 `(c·b) Φ = 0` 而消失，`J = 0` 出 `b·a`。
        **这解释了为什么常数是 `L + b·a` 而不是 `L`**：`b·a = 2α' b·k` 是顶点算子在动量 `k`
        的 Fock 空间上的单值指数，塔上它就是 `towerVertex` 已经内建的层移位，
        所以塔版 **`towerCurrentVertex_eq`** 干干净净：`m Σ_J (k_0·α_{-J}) V^{(m)}_{K-J} = K V^{(m)}_K`。
      * **组装**：把 `j V^{(m)}_j` 换成 `m Σ_J K_J V^{(m)}_{j-J}`，把 `K_J` 提出 `j`-求和
        （它与两个顶点算子都对易），用 (5a) 融合两个指数得 `m Σ_J K_J V^{(m+n)}_{-J}`，
        再用**第二次**权恒等式（动量 `m+n`、指标 `K = 0`）得
        `(m+n) Σ_J K_J V^{(m+n)}_{-J} = 0·V^{(m+n)}_0 = 0`。
        `m+n ≠ 0` 时 ℚ-代数里除掉 `m+n`（`eq_zero_of_intCast_smul_eq_zero`）⇒ 0
        ——**这就是"全导数留数为零"的纯代数版本**；
        `m+n = 0` 时指数退化成恒等（`towerVertex_zero_momentum`，先决原子
        `Fock.vertexOsc_zero_momentum` 约 20 行），只剩零模
        `k_0·α_0 = 1`（`towerCurrent_zero_of_normalized`），得 `m`。
      **数学要点（供图节点 `gaps` / `notes`）**：
      1. **(5b) 不是 (5a) 的推论**（复核确认）：`L_0` 的 Leibniz 只见两个因子的权之和。
      2. **`k_0² = 0` 在本文件用了三次**：权恒等式本身（`b·b ≠ 0` 时 `b·∂X` 与 `e^{ib·X}`
         有缩并 `b²/z`，恒等式多出反常项）、电流与顶点算子的对易、以及由后者给出的
         局部有限窗口。
      3. **二重和的交换靠"电流与两个顶点算子都对易"**：否则 `J`-求和的下端截断
         （`K_J` 是湮灭算子）依赖 `V^{(n)}_{-j}x` 的 mode bound，而后者随 `j → -∞` 发散，
         窗口的选取会**循环**。把 `K_J` 一路交换到 `x` 上，下端变成
         `-towerModeBound x`，与 `j` 无关，循环才打破。这是一个纯形式化层面的发现：
         纸上推导从不提这一步。
      4. **`2α' k_0·p = 1` 只在一处用到**（`towerCurrent_zero_of_normalized`），
         它使 `k_0·α_0 = 1` 在**每一层**都成立，而这与 `k_0² = 0` 自洽
         （`dotVec_towerMomentum_right_of_isotropic`）。等式右边的 `m` 就来自这里。
      5. **ℚ-代数是必需的**，不只为相干态系数，还为最后除以 `m+n`。
         在 `ℤ` 上只能得到 `(m+n)·Σ_j j V^{(m)}_j V^{(n)}_{-j} = 0`。
      6. 主定理的窗口假设比"最小窗口"多留了 `towerModeBound x` 的余量
         （`m - N - M ≤ j ≤ N - n`），这正是第 3 点里中间二重和需要的；对调用者无代价。
    - **[x] 做完了 (5c)** 组装 **`[A^ε_m, A^δ_n] = m (ε·δ) δ_{m+n,0}`**（塔上，`k_0² = 0`、
      `2α' k_0·p = 1`、`ε·k_0 = δ·k_0 = 0`）：`StringFormal/NoGhost/DDFAlgebra.lean`，
      无 sorry，4 条声明公理只有标准三条（`--import StringFormal.NoGhost.DDFAlgebra --all`）。
      主定理 **`lie_ddfOp_ddfOp`**，另三条 `lie_towerMode_towerMode`（塔上 CCR）、
      **`lie_towerModeVec_towerModeVec`**（偏振 CCR）、**`ddfOp_mul_ddfOp_apply`**（二重和）。
      上一位预判的路线（横向性移 `V`、(5) 换 `V`、CCR、(5b) 收尾）逐字走通，
      约 170 行，确实没有新的数学内容。三点实现上的记录：
      1. **偏振 CCR 要用 `η_μ² = 1`**：`[α^ε_j, α^δ_l]` 含三个度规因子
         `Σ_μ (η_μ ε^μ)(η_μ δ^μ)(m η^{μμ}) = m Σ_μ η_μ³ ε^μ δ^μ`，只有 `η² = 1` 才塌成
         `m (ε·δ)`。`hη` 本来就是全线程的假设，但这是它**第一次**在中心项里起作用
         （此前只用于 `[L_m, α_p]`），不是纯约定。
      2. **两个横向性各用各的**：`δ·k_0 = 0` 用在 `A^ε_m A^δ_n` 里（把 `V^{(m)}_j` 挪过
         `α^δ_l`），`ε·k_0 = 0` 用在反序乘积里；两者又都为 `ddfOp` 的存在性所必需。
         所以 `lie_ddfOp_ddfOp` 有四个几何假设，一个都省不掉。
      3. **窗口对齐用 `Finset.biUnion` 绕开显式界**：外层算子作用在 `α^δ_l V^{(n)}_l x` 上，
         它的 `towerLevelBound` / `towerModeBound` 没有现成的估计（要重新做一遍
         顶点算子对 level bound 的作用）。改成取 `t₁.biUnion (fun l => ddfWindow m (...))`，
         有限性自动，完全不需要界。最后两序的公共指标集取
         `U = V ∪ (-V)`（`V` 含四个窗口与 (5b) 的窗口 `Icc (m-N-M) (N-n)`），
         **对 `j ↦ -j` 封闭**是为了内层 `Σ_l δ_{j+l,0}` 落回 `U` 里。
      4. **`Module.End` 上的 `sub_mul` / `← LieRing.of_associative_ring_bracket` `rw` 不上**
         （实例路径 `LinearMap.instSub` 与环结构的 `Sub` 不同构于语法层面）。
         办法与 `Fock` 里既有的做法一致：`congrArg (fun T => T x)` 到向量层面，
         再 `simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.smul_apply]`。
  - **[x] [A,A] 的整条链已完成**：横向性 (4) 给
    `[A^ε_m, A^δ_n] = Σ_{j,l} [α^ε_j, α^δ_l] V^{(m)}_j V^{(n)}_l`（用到 (5) 的顶点算子对易
    把两个 `V` 并到右边），再用塔上的 `[α^ε_j, α^δ_l] = j (ε·δ) δ_{j+l,0}` 得
    `(ε·δ) Σ_j j V^{(m)}_j V^{(n)}_{-j}`，最后由 (5b) 收尾。见 (5c)。


  **未做（下一项 `ddf-spans` 之前必须补）**：
  - `⁅L_m, A^ε_n⁆ = 0` 与「`A^ε_n` 保持 `towerPhysSubmodule`」**全部 `m` 已证**（见 (6)）；
    `[A^ε_m, A^δ_n] = m (ε·δ) δ_{m+n,0}` **已证**（见 (5c)）；`A^ε_n` 的伴随**已证**
    （见 `vertex-adjoint`）。**本项只剩张成性，那是下一项 `ddf-spans`。**
  - `x^μ` 只以 `towerShift`（即 `e^{i n k_0·x}`）的形式出现，Heisenberg 对易 `[x^μ,p^ν]` 未形式化；
    塔是建在**固定的** `a` 与 `b` 上，不是全动量空间。
  - 归一化 `2α' k_0·p = 1` 与 `k_0² = 0` 只作为显式假设 `dotVec η b a = 1` / `dotVec η b b = 0`
    出现；「存在类光 `k_0` 使 `k_0·p ≠ 0`」是关于实二次型的断言，在一般环上假，未（也不该）证。
  - `lie_ddfOp_ddfOp` 右端的 `(ε·δ)` 是**任意**度规下的收缩；「横向子空间上 `ε·δ` 正定、
    因而 DDF 态的 Gram 是欧氏振子的 Gram」需要 `R` 为有序域与 `η = (-1,1,…,1)`，
    是 `ddf-spans` / 无鬼定理那一侧的内容，不属于本项。
- [x] `vertex-adjoint`：顶点算子与 DDF 算子在 Fock/塔配对下的伴随 ——
  `StringFormal/NoGhost/VertexAdjoint.lean`。对应图节点 `worldsheet.vertex-operator-adjoint`
  与 `worldsheet.ddf-operators-adjoint`；补上 `VertexOperator.lean` 的缺口 (3) 与
  `TowerPairing.lean` 的缺口 (2)。
  - **两半各自的伴随**：`Fock.pairing_creaExp_left`（`Φ_j(b)^† = Ψ_j(-b)`）与
    `Fock.pairing_vertexAnn_left`（`Ψ_L(b)^† = Φ_L(-b)`）。证明是两层归纳：
    先对 `w` 归纳得真空矩阵元 `Fock.pairing_creaExp_one_left`
    （`⟨Φ_j(b), w⟩ = coeff 0 (Ψ_j(-b) w)`，递推两边都来自
    `annihilation_creaExp` 与 `vertexAnn_mul_X`，是**同一条**递推），
    再对 `v` 归纳（这一层是平凡的，只用 `pairing_creation_left` 与
    `annihilation_vertexAnn`）。
  - **主定理** `Fock.pairing_vertexOsc_left`：`⟨V(b)_K v, w⟩ = ⟨v, V(-b)_{-K} w⟩`。
  - **塔上** `Fock.towerPairing_towerVertex_left`：`(V^{(n)}_K)^† = V^{(-n)}_{-K}`
    （零模半由 `towerPairing_towerShift_left` 承担，振子半由上一条；
    `-(n b) = (-n) b` 把 Fock 层的动量反号吸收成 `n ↦ -n`）。
  - **DDF 算子** `Fock.towerPairing_ddfOp_left`：`(A^ε_n)^† = A^ε_{-n}`。
    用横向性 `dotVec η ε b = 0` 把伴随重新排回「模乘顶点算子」的次序
    （`towerModeVec_mul_towerVertex_of_transverse`），再对局部有限和用
    `ddfOp_apply` 取一个同时够大的窗口 `ddfWindow n v ∪ (ddfWindow (-n) w).image (-·)`。
  - **两条数学结论（对图的建议，见报告）**：
    1. **不需要 `b·b = 0`**。原以为把 `E_+E_-` 重排回 `E_-E_+` 会生成自缩并
       `exp(Σ (b·b)/l ⋯)`。不会：正规序乘积 `E_-(b)E_+(b)` 的伴随是
       `E_+(b)^†E_-(b)^† = E_-(-b)E_+(-b)`，**本来就是正规序的**。所以
       `pairing_vertexOsc_left` 对任意 `b` 成立，图卡上的 `k_0² = 0` 假设可以去掉；
       `pairing_vertexOsc_left_of_dotVec_zero` 只是它的平凡特例。
       后果：`(A^ε_n)^† = A^ε_{-n}` **不依赖**类光条件。
    2. **动量必须反号**。「双线性无共轭 ⟹ 系数不变 ⟹ 仍是同一个 `b`」是错的：
       `E_-` 与 `E_+` 的指数**反号**（`creaExp` 用 `+η b`，`vertexSub` 用 `-b`），
       所以 `α_m ↦ α_{-m}` 把 `E_-(b)` 送到 `E_+(-b)`。
       审计引理 `Fock.add_self_eq_zero_of_pairing_vertexOsc_same_momentum`：
       若同动量版本对某个 `b` 成立则 `2b = 0`（见证是 `K = 1`、`v = |0⟩`、
       `w = α^μ_{-1}|0⟩`：左边 `b^μ`，右边 `-b^μ`）。
       塔上看不见这一点，因为 `-(n k_0)` 就是 `(-n) k_0`。
  - **公理登记**：上述 16 条声明（含辅助 `towerVertex_apply`、`Fock.vertexAnn_X`、
    `Fock.pairing_one_left`）经
    `lake env lean --run scripts/check_axioms.lean --import StringFormal.NoGhost.VertexAdjoint --all`
    全部 `ok`，公理集只有 `propext`、`Classical.choice`、`Quot.sound`（2026-09-11）。
  - **仍缺**：形式仍是 `R`-双线性而非 Hermite，无正定性、无完备化；
    伴随本身**不给** DDF 态的正模态——那还需要 `[A^i_m, A^j_n]`（(5a)(5b)，见上一项）。
- [x] `noghost-a`：**DDF 假设集的可满足性见证**（蓝图 §C.2）与**纵向 Goddard–Thorn 算子 `K_m`**
  （蓝图 §A.1/§A.2）—— `StringFormal/NoGhost/Witness.lean`、`StringFormal/NoGhost/Longitudinal.lean`。
  - **`Witness.lean`（§C.2）**：此前仓库里**没有任何一条**证明四条几何假设
    `hη ∧ hbb ∧ hba ∧ hεb` 可以同时满足，整个 DDF 岛原则上可能是空条件命题。
    现在给出 `D ≥ 3`、任意交换 ℚ-代数上的显式光锥标架
    `η = diag(-1,1,…,1)`、`b = (1,1,0,…)`、`a = (1/2,3/2,0,…)`、`b̃ = (1/2,-1/2,0,…)`、
    `ε_i = Pi.single i 1 (i ≥ 2)`：
    `noghost_hypotheses_satisfiable`（四条假设 + `ε·ε = 1` + 快子壳 `α'k² = 1`，即 `a₀ = 1`）、
    `noghost_lightcone_frame_satisfiable`（再加 `b·b̃ = -1`、`b̃·b̃ = 0`）、
    `noghost_transverse_gram_satisfiable`（`D-2` 个横向方向，Gram = `δ_{ij}`）。
    工具引理 `dotVec_add_left/right`、`dotVec_single_left`、`dotVec_single_single`、`dotVec_pair`
    可复用。**数学结论**：`b·a = 1` 与 `a·a = 2` 一起**强制** `a = (1/2,3/2,0,…)`，
    所以这套见证在 ℤ 上不存在，ℚ-代数假设不是偷懒而是必需。
  - **`Longitudinal.lean`（§A.1/§A.2）**：`K_m = k_0·α_m` **就是** `towerModeVec η a b b m`
    （偏振取 `b` 自身；类光条件 `b·b = 0` 就是「`b` 对自己横向」），于是 Goddard 2008 (6.3)
    的整套代数是既有引理在 `ε := b` 处的特例：
    `lie_towerLop_kOp`（`⁅L_m,K_n⁆ = -n K_{m+n}`，**只需 `hη`**）、
    `lie_kOp_kOp`（`= 0`，中心项 `m(k_0·k_0)δ` 由 `hbb` 消去——`K`-代数里 `hbb` 的唯一用处）、
    `kOp_zero_eq_id` / `kOp_zero_eq_one`（`K_0 = 1`，**逐层**成立，靠
    `dotVec_towerMomentum_right_of_isotropic` + `hba`）、
    `towerPairing_kOp_left`（`K_m† = K_{-m}`）、
    `kOp_mul_towerVertex`（`K` 穿过顶点算子，用 `hbb`）、
    **`lie_kOp_ddfOp`（`⁅K_m, A^ε_n⁆ = 0`，一切 `m,n`）**：与 `⁅L_m,A⁆` 不同，**没有**望远镜
    求和与边界项——`K_m` 与每个单项 `α^ε_j V^{(n)}_j` 逐项对易，只需取对 `x` 与 `K_m x`
    同时够大的窗口 `ddfWindow n x ∪ ddfWindow n (K_m x)`；两条几何输入各用一次
    （`hbb` 过顶点算子，`hεb` 过 `α^ε_j`）。
  - §A.2 侧：`kOp_apply_single_vacuum_of_pos`（`K_n|0;k+jk_0⟩ = 0`，`n > 0`，**每一层**）、
    `towerKerK = ⋂_{n>0} ker K_n`（Goddard (6.2)）、`single_vacuum_mem_towerKerK`、
    `ddfOp_mem_towerKerK`、`ddfCharacterization = towerPhysSubmodule ⊓ towerKerK` 与
    `ddfOp_mem_ddfCharacterization`。
  - **仍缺**：`ddfCharacterization` 只是**定义**，Goddard (6.2) 的「= DDF 态张成」是 `ddf-spans`
    （蓝图 §B），未做；本项只给出「DDF 态满足 `K`-条件」那一侧所需的全部基础设施
    （算子保持 + 真空满足），张成引理与其逆包含仍未形式化。
  - **公理登记**：两文件 21 条声明经 `check_axioms --all` 全 `ok`（2026-09-11）。
  - **图接线建议（本分支不碰 `graph/`）**：新建卡 `worldsheet.gt-longitudinal-k-algebra`
    （Goddard 2008 §6 (6.2)(6.3)，来源 E7 已 L1 核实），`formal.lean_decl` 可指
    `StringFormal.NoGhost.lie_towerLop_kOp` / `lie_kOp_kOp` / `kOp_zero_eq_one`；
    可满足性见证可挂在 `worldsheet.ddf-operators-v6` 的 notes 或新建定义卡。
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
  - 判别式（`worldsheet.ocq-level-two-scalar-norm-closed-form` 第 (4) 条，2026-09-11 补）：
    `Fock.levelTwo_norm_discriminant`，任意交换环上 `64[16a₀²+(2D-74)a₀+84-3D] =
    (32a₀+2D-74)² - 4(D-1)(D-25)`（配方形式，`ring` 一行；`ok`，标准三公理）。
    从此判别式 `4(D-1)(D-25)` 是定理而非 docstring。**注意**：由它推出「`1 ≤ D ≤ 25` 时括号恒非负、
    `D > 25` 时取负值」需要有序域上的符号分析，Lean 里没做，只有代数恒等式。
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
