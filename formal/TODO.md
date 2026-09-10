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
    做 Verma 模时才需要。
- [ ] `verma-module`：Verma 模 `V(c,h)` 的构造与分级；对应图节点 `worldsheet.verma-module`。
- [ ] `shapovalov-form`：Shapovalov 形式。
- [ ] `kac-determinant`：Kac 行列式公式。这是独立的、有价值的数学形式化目标；对应 `worldsheet.kac-determinant`。可能很长，允许先做低阶（N ≤ 3）的显式版本。

## 无鬼定理岛

- [ ] `fock-space`：`D` 个玻色振子的 Fock 空间，带 `η` 诱导的不定内积。Mathlib 里没有现成的，需要从多项式代数或对称代数构造。
- [ ] `sugawara`：`L n` 在 Fock 空间上的作用，证明满足 Virasoro 关系且 `c = D`。这一步的正规序处理是主要难点。
- [ ] `physical-states`：`H_phys` 子模与零模态。
- [ ] `ddf-operators`：DDF 算子及其对易关系（横向振子代数）。
- [ ] `ddf-spans`：DDF 态张成 `H_phys / null`（D = 26, a = 1）。这是定理的核心。
- [ ] `no_ghost_theorem`：组装。
- [ ] `negative-norm-above-26`：D > 26 时显式负模态。

## 基础设施

- [ ] `scripts/check_axioms.lean`：给定声明名，输出其公理集合，非标准三公理则退出非零。供 `stringgraph` 未来接入。
