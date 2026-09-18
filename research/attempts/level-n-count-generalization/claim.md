# Claim: general N-level oscillator counting formula and its recursion

## Setting / notation (matches `formal/StringFormal/NoGhost/Level{Two,...,Six}Count.lean`)

Fix a commutative structure of "directions" indexed by a finite type `ι` of cardinality
`m` (in the physics application `ι` ranges over `D`, `D-1`, or `D-2` spacetime/oscillator
directions, depending on which slice of the argument is being counted). An **occupation
function** of weight `N` is a finitely-supported function

  d : ι × ℕ₊ →₀ ℕ

(equivalently `Finsupp.oscWeight`, as used throughout `NoGhost/*.lean`) such that

  oscWeight d := Σ_{(i,n)} n · d(i,n) = N.

Define

  p_m(N) := #{ d : ι × ℕ₊ →₀ ℕ | oscWeight d = N },   where |ι| = m.

(`p_m(N)` is the number of "m-colored partitions of N": partition N into parts of size
`n ∈ ℕ₊`, each part additionally labelled with one of `m` colors, where multiple parts of
the same size and same color are allowed and are indistinguishable from each other except
by count.) By convention `p_m(0) = 1` for all `m ≥ 0`, and `p_0(N) = 0` for `N ≥ 1`.

Write `p(N) := p_1(N)` for the *ordinary* (uncolored) partition function.

For a partition `λ ⊢ N` written multiplicatively as `λ = ∏_s s^{r_s}` (`r_s` = the number
of parts of `λ` equal to `s`, so `Σ_s s·r_s = N`), and for `m, r ∈ ℕ`, write
`C(m+r-1, r) = Nat.choose (m+r-1) r` for the number of multisets of size `r` drawn from an
`m`-element set (with the convention `C(m-1,0) = 1` even when `m = 0`).

## Claim 1 (closed-form counting identity, all N, all m)

For every `N ≥ 0` and every `m ≥ 0`,

  p_m(N) = Σ_{λ ⊢ N}  ∏_{s : r_s(λ) > 0}  C(m + r_s(λ) - 1, r_s(λ)).

Equivalently: as formal power series in `x` over `ℤ`,

  Σ_{N ≥ 0} p_m(N) x^N  =  ∏_{n ≥ 1} (1 - x^n)^{-m}.

## Claim 2 (exact convolution recursion in m, all N, all m)

For every `N ≥ 0` and every `m ≥ 0`,

  p_{m+1}(N) = Σ_{k=0}^{N} p(k) · p_m(N-k).

(Here `p(k) = p_1(k)` is the ordinary partition function, independent of `m`.)

## Claim 3 (the "N-1, N-2 plus correction" recursion, generalizing the pattern of
`levelThree_count_identity` ... `levelFive_count_identity_gen`)

Define, for `N ≥ 2` and `m ≥ 0`,

  κ_N(m) := p_m(N) + p_{m+1}(N-1) + p_{m+1}(N-2) - p_{m+1}(N).

Then:

(a) `κ_N(m) = Σ_{s=0}^{N} Δ(s) · p_m(N-s)`, where `Δ(s)` is defined for `s ≥ 1` by

      Δ(s) := p(s-1) + p(s-2) - p(s)        (s ≥ 1, with `p(negative) := 0`)

    **together with the separate convention `Δ(0) := 0`.** ⚠ 这条约定是必需的、不是笔误：
    在 `s = 0` 处字面公式给 `p(-1) + p(-2) - p(0) = 0 + 0 - 1 = -1 ≠ 0`，只有 `s ≥ 1`
    时字面公式才自动给出想要的值。`proof.md` 第 131 行已正确声明该约定；本文件此前漏写，
    2026-09-18 由 graph-reviewer 指出后补上。在此约定下 `Δ(s) = 0` 对 `0 ≤ s ≤ 4`
    （`s = 1,2,3,4` 由字面公式算得 `1+0-1`、`1+1-2`、`2+1-3`、`3+2-5` 全为 0；
    `s = 0` 由约定），`Δ(5) = p(4)+p(3)-p(5) = 5+3-7 = 1`。

    **[备注，非本 claim 的一部分]** `Δ(s)` 的值与 Euler 五边形数定理的修正项吻合，
    对 `s ≥ 5` 形如
    `Δ(s) = p(s-5) + p(s-7) - p(s-12) - p(s-15) + p(s-22) + p(s-26) - ⋯`
    （每个固定 `s` 只有有限多项非零）。**本尝试没有证明这个展开式，它也不被本尝试的任何
    推导使用**——`proof.md` 第 164–172 行显式声明这一点并弃权（Euler 五边形数定理本身
    未作为图里的砖块建立）。Claim 3(a) 断言的只是上面那条 `Δ` 的递推定义与求和式；
    五边形展开是说明性旁注，读者不得把它当作已证内容引用。

(b) In particular `κ_N(m) = 0` for `N ≤ 4` (matches the unconditional Pascal identities
    of `levelTwo/Three/FourCount.lean`); `κ_5(m) = 1` for all `m` (matches
    `levelFive_count_identity_gen`'s "+1"); and

      κ_6(m) = m + 1                         (NOT a constant — first N where κ depends on m),
      κ_7(m) = p_m(2) + p_m(1) + 3 = C(m+3,2)   (= 2m + C(m+1,2) + 3),

    both identities holding for every `m ≥ 0`.

    ⚠ **新颖性范围（2026-09-18 按 graph-reviewer 指正收窄）**：本文件早先写的
    「new / not previously recorded in the repository」**是越界的**。这两个 κ 在
    `D = 26`（即 `m = 25`）处的**数值**在本仓库里早已出现——
    `formal/BLUEPRINT-noghost.md:3189`、`formal/TODO.md:2155`、
    `formal/StringFormal/NoGhost/LevelFiveCount.lean:68`；而且
    `DescendantKernel.lean:25-26` 的 docstring 已经用五边形数写出了一般式
    `κ_N = Σ_s Δ(s) p_D(N-s)`。
    **本尝试真正的新贡献是两条，都不是"这些值第一次被记下来"**：
    (i) 一条**自足的初等推导**——只用 Claim 2 的卷积递推和 `p(0..7)` 这七个小值，
    **完全不需要 Euler 五边形数定理**（后者在本项目里尚未作为砖块建立，见 (a) 的备注）；
    (ii) 把这两个 κ 从"`D = 26` 处的单个数字"提升为**对 `m` 的显式闭式多项式**
    （`m+1` 与 `C(m+3,2)`），因而对一切 `m` 成立、可直接用于 Lean 里的 `_gen` 形式定理。

## Claim 4 (explicit N = 7 closed form)

There are exactly 15 partitions of 7, grouped into 10 distinct "shapes" (multisets of
part-multiplicities), giving:

  p_m(7) =  m                              (shape {1}:   partition 7)
          + 3m²                            (shape {1,1}: partitions 6+1, 5+2, 4+3)
          + 3m·C(m+1,2)                    (shape {1,2}: partitions 5+1+1, 3+3+1, 3+2+2)
          + m³                             (shape {1,1,1}: partition 4+2+1)
          + 2m·C(m+2,3)                    (shape {1,3}: partitions 4+1+1+1, 2+2+2+1)
          + m²·C(m+1,2)                    (shape {1,1,2}: partition 3+2+1+1)
          + m·C(m+3,4)                     (shape {1,4}: partition 3+1+1+1+1)
          + C(m+1,2)·C(m+2,3)              (shape {2,3}: partition 2+2+1+1+1)
          + m·C(m+4,5)                     (shape {1,5}: partition 2+1+1+1+1+1)
          + C(m+6,7)                       (shape {7}:   partition 1+1+1+1+1+1+1)

for every `m ≥ 0`. (Exact shape-by-shape derivation and the partition ↔ term
correspondence table are in `proof.md`.)

## Status of existing repository claims (found while verifying Claim 4)

`formal/StringFormal/NoGhost/LevelSixCount.lean`'s theorem `levelSix_count_identity_gen`
currently asserts (in `m`, `Nat.choose` notation) an identity of the shape
`F(m+1) = F(m)` for an 11-term expression `F`. **This identity is false for every `m`**
(verified: `F(0)=0, F(1)=12, F(2)=77, F(3)=284, ...`, strictly increasing, and indeed
`lake build` fails to close the `ring` goal at the end of the stated proof — see
`proof.md` §5 for the exact error trace). Independently of the arithmetic slip in the
11th term, **the identity is of the wrong structural shape**: by Claim 3(b) above,
`κ_6(m) = m+1 ≠ 0`, so `p_{m+1}(6) ≠ p_m(6)` for every `m ≥ 0` — no correct 11-term (or
any other fixed number of terms) formula for `p_x(6)` alone can satisfy `F(m+1) = F(m)`.
The mathematically correct N=6 identity is not "F(m+1)=F(m)" but the N-1,N-2-recursion of
Claim 3: `p_{m+1}(6) = p_m(6) + p_{m+1}(5) + p_{m+1}(4) + (m+1)`.

This claim (the bug report) is **not** part of my assigned N≥7 task scope, but is recorded
here because it was discovered as a direct consequence of verifying Claim 3/4, and it
blocks any Lean file that would try to `import` `LevelSixCount` and rely on its stated
theorem.
