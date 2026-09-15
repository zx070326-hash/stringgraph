# Proof: general N-level oscillator counting formula, exact m-recursion, and N=7 explicit formula

See `claim.md` for the precise statement of what is proved here (Claims 1-4). This
document proves Claims 1-3 in general and Claim 4 (N=7) as a worked instance, then
documents (§5) a build-breaking bug found in `formal/StringFormal/NoGhost/LevelSixCount.lean`
while cross-checking Claim 3 at N=6, and (§6) the Lean skeleton produced for N=7.

## 0. Bricks used from the graph (rigorous/formalized only)

- **`math.euler-partition-generating-function`** (formalized; Lean decl
  `StringFormal.Math.partitionGF_mul_tprod_one_sub_X_pow` et al. in
  `formal/StringFormal/Math/EulerPartition.lean`). Its content, form (1): for any
  commutative ring `R`, in `R[[X]]`,

    P_R(X) · ∏'_{n≥1} (1 − X^n) = 1,     where P_R(X) := Σ_{N≥0} p(N) X^N.

  In particular `∏'_{n≥1}(1−X^n)` is a **unit** in `R[[X]]` with inverse `P_R(X)`; this
  holds with **no field / characteristic-zero / domain hypothesis**.

- **Elementary finite combinatorics** ("stars and bars" / multiset counting): the number
  of multisets of size `r` drawn from an `m`-element set is `C(m+r-1, r)`. This is a
  standard bijective fact (weak compositions of `r` into `m` parts), not attributed to
  any graph node — it is pure finite combinatorics, proved by the standard "balls and
  dividers" bijection (also literally `Nat.multichoose_eq` in Mathlib, used implicitly
  throughout `NoGhost/*Count.lean`).

- **Small values of the ordinary partition function** `p(0..7) = 1,1,2,3,5,7,11,15`. For
  `N ≤ 5` these are exactly the values recorded in `formal/StringFormal/Math/PartitionCard.lean`
  (`p(n) = Fintype.card (Nat.Partition n)` for `n=2,3,4,5` equal to `2,3,5,7`); `p(6)=11`
  and `p(7)=15` are not yet in that file but are elementary (finite enumeration; also
  triple-cross-checked by three independent Python routines in
  `scripts/verify_level_n.py`, see §4). **No claim below needs `p(N)` for `N > 7`.**

I do **not** use Euler's pentagonal number theorem in the "any partition satisfies the
infinite alternating recursion" sense (that identity is explicitly flagged as *not*
covered by `math.euler-partition-generating-function`, point (c) in that node's "does
NOT assert" list, and no other graph node covers it). Below, the quantity `Δ(s)` is
introduced purely as a **finite bookkeeping shorthand** `Δ(s) := p(s-1)+p(s-2)-p(s)`
(with `p(negative):=0`), evaluated **directly** from the seven known values of `p(0..7)`
above — I do not need or use its general closed form via pentagonal numbers, and flag
that closed form only as unverified expository context in a remark.

## 1. Claim 1: closed-form counting identity

**Setup.** Fix `R = ℤ` and work in the formal power series ring `ℤ[[X]]` (all
manipulations below are finite-degree truncations, so nothing here needs any topology;
I only extract single coefficients).

**Step 1 (generating function of `p_m`).** Fix `m ≥ 0` and let `ι` be an `m`-element
index set. An occupation function `d : ι × ℕ₊ →₀ ℕ` with `oscWeight d = N` is, by
definition, the same data as: for each `i ∈ ι`, an ordinary partition `λ_i` (encoded as
a finitely-supported function `ℕ₊ →₀ ℕ`, `λ_i(s) = d(i,s)` = multiplicity of part `s` in
`λ_i`), such that `Σ_i |λ_i| = N` (where `|λ_i| := Σ_s s·λ_i(s)` is the size of `λ_i`).
This is a literal identity of sets — an occupation function *is* an `ι`-tuple of ordinary
partitions with sizes summing to `N` — no bijection needs to be constructed, only the
data re-packaged. Hence

  p_m(N) = #{ (λ_i)_{i∈ι} : Σ_i |λ_i| = N } = Σ_{N_1+⋯+N_m = N} ∏_{i=1}^m p(N_i)

which is exactly the coefficient of `X^N` in `P_R(X)^m` (definition of power series
multiplication, `m`-fold). Hence, as formal power series,

  Σ_{N≥0} p_m(N) X^N  =  P_R(X)^m.               (★)

By the brick `math.euler-partition-generating-function` (1), `P_R(X) = [∏'_{n≥1}(1-X^n)]^{-1}`
literally as the inverse of a unit in `R[[X]]`, so `P_R(X)^m = [∏'_{n≥1}(1-X^n)]^{-m}`
(inverse of the unit `∏(1-X^n)^m`, using that inverses of units in a commutative ring
satisfy `(u^{-1})^m = (u^m)^{-1}`). This proves the generating-function form of Claim 1.

**Step 2 (expanding by partition shape).** Fix `N`. Group the sum in (★)'s combinatorial
definition of `p_m(N)` by the **underlying uncolored partition shape**: given
`(λ_i)_{i∈ι}` with `Σ|λ_i|=N`, define `r_s := Σ_i λ_i(s)` (the total multiplicity of part
size `s` across all `m` colors) and `λ := ` the partition of `N` with part-`s`
multiplicity `r_s`. Conversely, fixing the shape `λ` (i.e., fixing every `r_s`), the
number of ways to distribute the `r_s` copies of part `s` among the `m` colors,
independently for each `s`, is (by the "stars and bars" brick) `C(m+r_s-1, r_s)`
multichoices, and these choices are independent across distinct `s` because they use
disjoint coordinates `(i,s)`. Hence

  p_m(N) = Σ_{λ ⊢ N} ∏_{s : r_s(λ)>0} C(m + r_s(λ) - 1, r_s(λ)),

proving Claim 1 exactly. **This step is a direct, elementary bijective counting
argument; no gap.** ∎

## 2. Claim 2: exact convolution recursion

Immediate from (★): `Σ_N p_{m+1}(N) X^N = P_R(X)^{m+1} = P_R(X)^m · P_R(X) =
(Σ_N p_m(N) X^N)·(Σ_N p(N) X^N)`. Extracting the coefficient of `X^N` on both sides
(definition of power series multiplication) gives

  p_{m+1}(N) = Σ_{k=0}^{N} p(k) · p_m(N-k).    ∎

(No gap; this is literally the `m=1` factor peeled off `P_R(X)^{m+1}`.)

## 3. Claim 3: the κ_N(m) recursion

**Definition.** For `N ≥ 2`, `m ≥ 0`: `κ_N(m) := p_m(N) + p_{m+1}(N-1) + p_{m+1}(N-2) -
p_{m+1}(N)`.

**Derivation.** Substitute Claim 2 into each `p_{m+1}(·)` term:

```
p_{m+1}(N)   = Σ_{k=0}^{N}   p(k) p_m(N-k)
p_{m+1}(N-1) = Σ_{k=0}^{N-1} p(k) p_m(N-1-k)
p_{m+1}(N-2) = Σ_{k=0}^{N-2} p(k) p_m(N-2-k)
```

Re-index each sum by `j := N - (shift) - k`, i.e. by the index of `p_m(j)` appearing in
it (`j` ranges from `0` up to the top of that sum), to collect κ_N(m) as
`Σ_j c(j) p_m(j)` for coefficients `c(j)`:

```
from  p_m(N):                    c(N)   += 1
from  p_{m+1}(N-1) = Σ_k p(k)p_m(N-1-k): c(j) += p(N-1-j)   for 0 ≤ j ≤ N-1
from  p_{m+1}(N-2) = Σ_k p(k)p_m(N-2-k): c(j) += p(N-2-j)   for 0 ≤ j ≤ N-2
from -p_{m+1}(N)   = -Σ_k p(k)p_m(N-k):  c(j) -= p(N-j)     for 0 ≤ j ≤ N
```

Writing `s := N - j` (the "shift" from the top index `N`), and using `p(0)=p(1)=1`, this
gives, for each `s ≥ 0`:

  c(N-s) = [s=0] + p(s-1)·[s≤N] + p(s-2)·[s≤N] - p(s)·[s≤N]     ... which for `s ≤ N`
           (the only range that matters, since `p_m(j)` is only defined for `j ≥ 0`)
           simplifies, after using `p(0)=1` to absorb the `[s=0]` boundary term into the
           `p(s-1)+p(s-2)-p(s)` pattern (check directly: at `s=0` the RHS pattern gives
           `p(-1)+p(-2)-p(0) = 0+0-1 = -1`, but the *true* `c(N) = 1` includes the extra
           `+1` from the `p_m(N)` term above that only fires at `s=0` — so for `s=0`,
           `c(N) = 1 + [p(-1)+p(-2)-p(0)] = 1 - 1 = 0`),
  to

    c(N-s) = Δ(s),   where   Δ(s) := p(s-1) + p(s-2) - p(s)   for s ≥ 1,   Δ(0) := 0.

(The `s=0` and `s=1` boundary cases were checked directly above/below and match
`Δ(0)=0`, `Δ(1) = p(0)+p(-1)-p(1) = 1+0-1 = 0`, consistent with the formula once `p(-1)
:=0`.) Hence

  **κ_N(m) = Σ_{s=0}^{N} Δ(s) · p_m(N-s).**

Now evaluate `Δ(s)` for `s = 0..7` directly from `p(0..7) = 1,1,2,3,5,7,11,15`:

| s | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|---|
| `Δ(s) = p(s-1)+p(s-2)-p(s)` | 0 | 0 | `1+1-2=0` | `2+1-3=0` | `3+2-5=0` | `5+3-7=1` | `7+5-11=1` | `11+7-15=3` |

So `Δ(s) = 0` for `0 ≤ s ≤ 4`, `Δ(5)=1`, `Δ(6)=1`, `Δ(7)=3`.

**Corollary (Claim 3(b)).**

- **N ≤ 4**: since `Δ(s)=0` for all `s ≤ 4`, `κ_N(m) = 0` for all `m` — matches the
  unconditional Pascal identities `levelTwo/Three/FourCount.lean`.
- **N = 5**: `κ_5(m) = Σ_{s=0}^5 Δ(s) p_m(5-s) = Δ(5)·p_m(0) = 1·1 = 1` for every `m` —
  matches `levelFive_count_identity_gen`'s `+1`.
- **N = 6**: `κ_6(m) = Δ(5)p_m(1) + Δ(6)p_m(0) = 1·m + 1·1 = m+1`. **This is the first `N`
  where κ_N is not constant in `m`.**
- **N = 7**: `κ_7(m) = Δ(5)p_m(2) + Δ(6)p_m(1) + Δ(7)p_m(0) = p_m(2) + m + 3`. Using
  `p_m(2) = m + C(m+1,2)` (partition shapes `{2}` and `{1,1}` of `N=2`), this is
  `κ_7(m) = 2m + C(m+1,2) + 3`, which is algebraically equal to `C(m+3,2)`
  (`C(m+3,2) = (m+3)(m+2)/2 = (m²+5m+6)/2`, and `2m+C(m+1,2)+3 = 2m+m(m+1)/2+3 =
  (m²+5m+6)/2` — same polynomial).

Numerically verified for `m = 1..7` against three independent computations of `p_m(N)`
in `scripts/find_kappa.py` (output reproduced in §4).

**Remark (not used, expository only).** The sequence `Δ(s)` for `s ≥ 5` is, by Euler's
pentagonal number theorem applied to `p(N) = p(N-1)+p(N-2)-p(N-5)-p(N-7)+p(N-12)+⋯`,
equal to `p(s-5)+p(s-7)-p(s-12)-p(s-15)+⋯`. This gives a closed recursive description of
`Δ` for all `s`, and would let one derive `κ_N(m)` for arbitrary `N` without needing all
of `p(0..N)` tabulated by hand. This remark is **not used** in the derivations above
(which only needed `Δ(5),Δ(6),Δ(7)`, directly computed from 7 known values of `p`), and
Euler's pentagonal number theorem itself is **not** a graph brick (flagged explicitly as
out of scope by `math.euler-partition-generating-function`, note (c)) — so this paragraph
is context, not part of the logical chain.

## 4. Numerical verification

`scripts/verify_level_n.py` computes `p_m(N)` for `N=1..10`, `m=1..5` by three
independent methods (partition-shape formula = Claim 1's RHS; generating-function
power-series DP; brute-force recursive mode-by-mode enumeration) and asserts all three
agree. Output (excerpt, full run below):

```
$ python research/attempts/level-n-count-generalization/scripts/verify_level_n.py
  N   m   partitions     gen.func        brute  match
  7   1           15           15           15   True
  7   2          110          110          110   True
  7   3          429          429          429   True
  7   4         1240         1240         1240   True
  7   5         2990         2990         2990   True
  ...
All three independent methods agree for N=1..10, m=1..5.
```

`scripts/find_kappa.py` computes `κ_N(m) := p_m(N)+p_{m+1}(N-1)+p_{m+1}(N-2)-p_{m+1}(N)`
directly from the (independently verified) `p_m(N)` table, for `N=2..10`, `m=1..7`, and
separately verifies the convolution identity of Claim 2 for `N=0..10`, `m=1..5`. Output:

```
N= 2  kappa(m=1..7) = [0, 0, 0, 0, 0, 0, 0]
N= 3  kappa(m=1..7) = [0, 0, 0, 0, 0, 0, 0]
N= 4  kappa(m=1..7) = [0, 0, 0, 0, 0, 0, 0]
N= 5  kappa(m=1..7) = [1, 1, 1, 1, 1, 1, 1]
N= 6  kappa(m=1..7) = [2, 3, 4, 5, 6, 7, 8]        <-  m+1 for m=1..7  ✓
N= 7  kappa(m=1..7) = [6, 10, 15, 21, 28, 36, 45]  <-  C(m+3,2) for m=1..7  ✓
N= 8  kappa(m=1..7) = [12, 25, 44, 70, 104, 147, 200]
N= 9  kappa(m=1..7) = [25, 60, 119, 210, 342, 525, 770]
N=10  kappa(m=1..7) = [46, 130, 292, 571, 1016, 1687, 2656]

convolution identity holds for all tested (N,m): True
```

(κ_8, κ_9, κ_10 are shown for completeness but not derived in closed form above — see
§7 GAP list.)

## 5. Bug found in `formal/StringFormal/NoGhost/LevelSixCount.lean` (out of assigned
scope, documented here because discovered as a direct byproduct of verifying §3)

The theorem `levelSix_count_identity_gen` in that file states an identity of the form
`F(m+1) = F(m)` for an 11-term arithmetic expression `F` (LHS uses `m+1`, RHS uses `m`,
shifted `Nat.choose` indices throughout, no `p_{m+1}(5)`/`p_{m+1}(4)`-style extra
summands on either side). By §3, `κ_6(m) = m+1 ≠ 0` for every `m ≥ 0`, so
`p_{m+1}(6) ≠ p_m(6)` for every `m ≥ 0` — **no** correct closed-form expression `F` for
`p_x(6)` can satisfy `F(m+1)=F(m)`, regardless of how many terms it has or what its
coefficients are. This is a structural error, not merely an arithmetic slip in one term.

This is confirmed empirically by direct `lake build` of the file (worktree build log,
reproduced verbatim):

```
error: StringFormal/NoGhost/LevelSixCount.lean:87:86: unsolved goals
m : ℕ
h2 : (m + 2).choose 2 = m + 1 + (m + 1).choose 2
...
⊢ 12 + m * 21 + m * (1 + m).choose 2 * 6 + ... (long polynomial) ... =
    m + m * (1 + m).choose 2 + ... (different polynomial) ...
error: Lean exited with code 1
Some required targets logged failures:
- StringFormal.NoGhost.LevelSixCount
error: build failed
```

i.e. `levelSix_count_identity_gen`'s proof (`rw [h6,h5,h4,h3,h2]; ring`) fails because
the stated identity is false, and hence `StringFormal.NoGhost.LevelSixCount` **does not
currently build** (confirmed twice, ~340s full-chain build in this worktree). Everything
downstream in that same file (`levelSix_count_identity`, `levelSix_count_identity_full`)
is equally unproven/unprovable as stated.

**Also notable**: `LevelSixCount.lean` is not listed in `formal/CLAUDE.md`'s directory
map of `NoGhost/*.lean` (which otherwise documents every file through `LevelFiveCount.lean`
and beyond, in detail) — suggesting this file may have been added without going through
the usual documentation/review step that the rest of the `NoGhost/` chain follows.

**Correct form of the N=6 identity** (per §3, matching the N=2..5 structural pattern):

  p_{m+1}(6) = p_m(6) + p_{m+1}(5) + p_{m+1}(4) + (m+1),    for every m ≥ 0.

I do **not** fix `LevelSixCount.lean` myself — that is out of my assigned scope (N≥7
generalization), and unilaterally rewriting another file's theorem is exactly the kind
of scope creep the project asks agents to flag rather than act on. **Recommendation for
the lead**: dispatch a fix (either to the correct recursive form above, or drop the file
until `lean-formalizer` redoes it) before merging any branch that would import
`LevelSixCount` and rely on its stated theorem.

**Consequence for my own N=7 Lean skeleton (§6)**: I do not `import
StringFormal.NoGhost.LevelSixCount`, to avoid inheriting a non-compiling dependency; I
import `StringFormal.NoGhost.LevelFiveCount` instead (last known-good file in the chain,
fully documented in `formal/CLAUDE.md`).

## 6. Claim 4: explicit N=7 formula

15 partitions of 7 group into 10 distinct shapes (full correspondence table in
`claim.md`); direct application of Claim 1 gives:

  p_m(7) = m + 3m² + 3m·C(m+1,2) + m³ + 2m·C(m+2,3) + m²·C(m+1,2)
           + m·C(m+3,4) + C(m+1,2)·C(m+2,3) + m·C(m+4,5) + C(m+6,7)

Verified numerically at m=1..5 against `p_m(7) = 15, 110, 429, 1240, 2990`
(three independent methods, §4) — **exact match at every tested value.**

**Recursive ("N-1,N-2 plus correction") form**, for use as a Lean theorem shell mirroring
the `levelFive_count_identity_gen` pattern (§3, N=7 row):

  p_{m+1}(7) + C(m+3,2) = p_m(7) + p_{m+1}(6) + p_{m+1}(5),    for every m ≥ 0.

Both forms are mathematically equivalent (both reduce to the same 10-shape closed form
once `p_{m+1}(6)` and `p_{m+1}(5)` are themselves expanded via Claim 1 — this expansion
is a `ring`-checkable finite polynomial identity, not re-derived here since it is exactly
analogous to the `h2..h6`/`ring` proof pattern already used successfully for N=2..5).

## 7. Lean skeleton

`formal/StringFormal/NoGhost/LevelSevenCount.lean` (new file): three theorem shells
mirroring the `LevelFiveCount.lean`/`LevelSixCount.lean` template
(`levelSeven_count_identity_gen / _identity / _identity_full`), **signatures only, all
proof bodies `sorry`** (per task instructions — actual Lean proofs are for
`lean-formalizer`, not for this attempt). Statement content is the closed form of §6
(the direct 10-shape formula, chosen over the recursive form because it does not need to
cite `p_{m+1}(6)`/`p_{m+1}(5)` as black boxes — it is fully self-contained arithmetic in
`m`, verified correct in §4/§6, and does not risk repeating the LevelSixCount.lean
mistake since I am not asserting any `F(m+1)=F(m)`-shaped claim). File imports
`StringFormal.NoGhost.LevelFiveCount` (not `LevelSixCount`, per §5). Build attempted via
`lake build StringFormal.NoGhost.LevelSevenCount` in this worktree; result recorded in
the commit that adds the file.

## 8. Open [GAP]s

- **[GAP: general-N closed form for κ_N(m)]** I have not derived a single closed-form
  expression for `κ_N(m)` valid for *all* `N` (only worked N=5,6,7 explicitly from
  tabulated small `p` values, plus numerically tabulated κ_8,κ_9,κ_10 without closed
  forms). The remark in §3 sketches how Euler's pentagonal number theorem would give one,
  but that theorem is not itself established here or in the graph as a rigorous brick —
  proving it (classical, via Franklin's involution) is a self-contained side-project not
  attempted in this round.
- **[GAP: N=8,9,10 explicit closed forms]** Shape-decomposition data was generated by
  the scripts (16/18/24 shapes respectively) but not written up with the same care as
  N=7's table in `claim.md`/`proof.md`. Numerically verified only (§4's `verify_level_n.py`
  table covers N up to 10).
- **[GAP: Lean proof bodies]** All three theorems in `LevelSevenCount.lean` are `sorry`
  by task design; a `ring`-based proof analogous to `levelFive_count_identity_gen`'s
  (Pascal-rewrite chain + `ring`) is expected to close them but was not attempted (would
  require care: 15-way case split or a chain of ~9 `Nat.choose_succ_succ` rewrites plus
  possibly `Nat.choose` shift lemmas the existing files don't yet use for shapes like
  `C(m+1,2)·C(m+2,3)` that mix two different binomial families multiplicatively).
- **[GAP: LevelSixCount.lean itself]** Not fixed (out of scope, flagged to lead in §5).
