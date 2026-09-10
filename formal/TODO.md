# formal/ 任务分解

按依赖顺序。每项完成后在这里打勾并在图里更新对应节点。

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
- [ ] `pbw-verma`：Verma 模的 PBW 基。两半独立：
  (a) **straightening**：有序词已张成 `V_N`（给出 `dim V_N ≤ p(N)`）。对词长与逆序数做双重归纳，
      用 `⁅L a, L b⁆ = (a-b) L_{a+b}`（`a,b < 0` 时无中心项）。不依赖上游。
  (b) **线性无关**：即 `U(Vir_-)` 的 Poincaré–Birkhoff–Witt + 诱导模的自由性。
      Mathlib v4.33.1 **没有** PBW（`Algebra/Lie/Free.lean`、`SerreConstruction.lean` 都注明缺）。
  `V(c,h) ≠ 0` 是 (b) 的推论；在 (b) 之前 `Verma.lean` 里的一切都可能是空洞真。
  这一项是 `shapovalov-form` 与 `kac-determinant` 的前提。
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
  图侧：建议新建节点 `worldsheet.bosonic-fock-space`（定义卡）与
  `worldsheet.fock-indefinite-form`（命题卡），由 curator 添加。
- [ ] `sugawara`：`L n` 在 Fock 空间上的作用，证明满足 Virasoro 关系且 `c = D`。这一步的正规序处理是主要难点。
- [ ] `physical-states`：`H_phys` 子模与零模态。
- [ ] `ddf-operators`：DDF 算子及其对易关系（横向振子代数）。
- [ ] `ddf-spans`：DDF 态张成 `H_phys / null`（D = 26, a = 1）。这是定理的核心。
- [ ] `no_ghost_theorem`：组装。
- [ ] `negative-norm-above-26`：D > 26 时显式负模态。

## 基础设施

- [ ] `scripts/check_axioms.lean`：给定声明名，输出其公理集合，非标准三公理则退出非零。供 `stringgraph` 未来接入。
