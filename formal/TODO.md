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
  - 域上（`[Field K] [CharZero K]`）：`isInternal_levelSpan`（`V = ⨁_N V_N`）与
    `levelSpan_eq_eigenspace`（`V_N` 恰为 `L_0` 的 `h+N` 特征子空间）；
  - 万有性质 `vermaLift` / `vermaLift_hwv` / `vermaLift_lie` / `eq_of_lie_of_eq_hwv`；
  - 副产品 `adjoin_range_uea_ι_eq_top`（`U(L)` 由 `ι '' L` 生成，Mathlib v4.33.1 没有）。
  **剩余**（不属本项，见下一条与图节点 `notes`）：PBW 基、`dim V_N = p(N)`、`V(c,h) ≠ 0`。
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
- [ ] `shapovalov-form`：Shapovalov 形式。
- [ ] `kac-determinant`：Kac 行列式公式。这是独立的、有价值的数学形式化目标；对应 `worldsheet.kac-determinant`。可能很长，允许先做低阶（N ≤ 3）的显式版本。

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
  - [x] (2) **指数顶点算子的振子部分**：`Fock.creaExp`（产生半的 Laurent 系数）、
    `Fock.vertexSub` / `Fock.vertexAnn`（湮灭半）、`Fock.vertexOsc η b K`（`z^K` 系数）。
    核心定理 **`Fock.lie_mode_vertexOsc`**：`[α^μ_p, V_K] = b^μ V_{K-p}`（`p ≠ 0`）；
    `Fock.lie_mode_zero_vertexOsc`：单个 Fock 空间上 `p = 0` 的括号**为零**（物理关系需要动量移位）；
    **`Fock.mode_vertexOsc_sub`**：左边用参数 `a+b`、右边用参数 `a` 的双动量形式，对**所有** `p`
    （含 0）成立；塔上的版本是 **`lie_towerMode_towerVertex`**。
    分级：`Fock.vertexOsc_mem_levelSubmodule`（`V_K` 把 level `N` 抬到 `N+K`）与
    `Fock.vertexOsc_apply_eq_zero_of_level`（`N+K<0` 时为零）。
    横向性：`lie_towerMode_towerVertex_of_eq_zero`（`b^μ = 0` ⟹ 与所有 `α^μ_p` 对易）。
  - [ ] (3) **共形权 `[L_m, V]`**：**未做**。真正的陈述是
    `L_m^{(a+b)} V_J - V_J L_m^{(a)} = (J + b·a - m + (m+1)·½ b·b) V_{J-m}`，权
    `h = ½ b·b = α' k_0²`，故 `k_0² = 0` 给权 0。已做的是它的**归纳步**：
    `Fock.eq_zero_of_vertex_recursion` / `Fock.vertexOsc_unique`（满足产生模态递推且在真空上
    取定值的算子族唯一），加上 `Fock.mode_vertexOsc_sub` 与 `Fock.lie_Lop_mode`，把该恒等式
    **归约为真空上的单条等式**，即计算 `L_m` 作用在相干态系数 `creaExp` 上。那条计算未做。
    做它需要的组合输入已经看清楚：欧拉型递推 `M·Φ_M = Σ_{l=1}^{M} (b·α_{-l}) Φ_{M-l}`，
    在系数层面等价于 `Σ_v (η_{v.1} b^{v.1}) w(d - e_v) = (level d) · w(d)`，可由
    `Fock.expWeight_add_single` 直接得到。

  **未做（下一项 `ddf-spans` 之前必须补）**：
  - DDF 算子本身 `A^i_n = Σ_{m ∈ ℤ} α^i_m ∘ V^{(n)}_m` 没有定义。它的局部有限性来自横向性
    （`lie_towerMode_towerVertex_of_eq_zero` 允许把 `α^i_m` 移到右边，那里 `m` 大时湮灭态）
    加上 `vertexOsc_apply_eq_zero_of_level`；**这一步是本项发现的一个实质数学点**：
    没有 `ε·k_0 = 0`，围道积分的模态和在代数 Fock 空间上**不是**有限和。
  - `[A^i_m, A^j_n] = m δ^{ij} δ_{m+n,0}` 需要顶点算子的乘积/OPE，完全未碰。
  - `x^μ` 只以 `towerShift`（即 `e^{i n k_0·x}`）的形式出现，Heisenberg 对易 `[x^μ,p^ν]` 未形式化；
    塔是建在**固定的** `a` 与 `b` 上，不是全动量空间。
  - 归一化 `2α' k_0·p = 1` 与 `k_0² = 0` 只作为显式假设 `dotVec η b a = 1` / `dotVec η b b = 0`
    出现；「存在类光 `k_0` 使 `k_0·p ≠ 0`」是关于实二次型的断言，在一般环上假，未（也不该）证。
- [ ] `ddf-spans`：DDF 态张成 `H_phys / null`（D = 26, a = 1）。这是定理的核心。
- [ ] `no_ghost_theorem`：组装。
- [ ] `negative-norm-above-26`：D > 26 时显式负模态。

## 基础设施

- [x] `scripts/check_axioms.lean`：给定声明名，输出其公理集合，非标准三公理则退出非零。
  `lake env lean --run scripts/check_axioms.lean <DeclName>...`，或 `--all` 从 stdin 读名字表；
  每行 `<ok|bad|missing>\t<声明名>\t<公理集合>`，`sorryAx`、未知声明都算失败。
  用 `Lean.importModules`（`loadExts := false`，因而不需要 `enableInitializersExecution`/unsafe main）
  加载 `StringFormal` 环境，再对每个名字跑 `Lean.collectAxioms`；`--import <Module>` 可换环境。
  图侧接入已做：`uv run stringgraph check-axioms`（`tools/stringgraph/axioms.py`）把结论映回节点 id，
  非标准公理同时报到陈述卡和依赖它的 `formalized` 推导上；**不进 `validate`/pre-commit**（要起 Lean）。
  2026-09-11 全图 14 个 `formal.lean_decl` 跑通：14 ok，0 bad，0 missing。
