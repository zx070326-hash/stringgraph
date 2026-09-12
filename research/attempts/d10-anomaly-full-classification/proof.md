# proof: the four anomaly-free gauge algebras in D = 10

Original proof attempt for the proposition (S) stated in `claim.md`.
Status: draft, see `status.yaml`.  Open points are marked `[GAP: ...]`.

Throughout, "the identity (i)" means

> **(i)**  `Tr F⁶ = (1/48) · Tr F⁴ · Tr F² − (1/14400) · (Tr F²)³`

as an identity of degree-6 homogeneous polynomials on 𝔤 (an equality in
Sym⁶(𝔤\*)), with `Tr` the trace in the **adjoint** representation; and
"(ii)" means `dim 𝔤 = 496`.

---

## 0. Summary of the argument

The proof has three independent parts.

1. **Structural reduction** (§2–§4, by hand).  The adjoint trace does not see
   abelian factors at all, and a cross-term count in the multidegree grading of
   Sym(𝔤\*) forces at most two simple factors.  Condition (ii) then bounds every
   simple factor by `dim ≤ 496`.
2. **A finite exhaustion** (§5–§6).  Chevalley/maximal-torus reduces `Tr H^k`
   to the power sum `Σ_{α∈Φ} α(H)^k` over the root system.  By the Killing–Cartan
   classification there are exactly **66** compact simple Lie algebras of
   dimension ≤ 496, and the identity (i) is an explicit polynomial identity in the
   root data of each.  All 66 are checked in exact rational arithmetic by
   `scripts/root_power_sums.py`; §6 additionally gives closed forms in the rank
   `n` and one-point witnesses, so that every exclusion can also be checked by
   hand without running the script.
3. **Reassembly** (§7).  Only `so(32)` and `e₈` survive (i); only `e₈` survives the
   stronger pair of conditions that a two-factor decomposition demands; the
   dimension bookkeeping then leaves exactly the four algebras of (S).

The outcome confirms the classification asserted without proof in GSW §13.5.3.
No step below uses `antonelli-2015`; every trace coefficient here was computed
from scratch from root data (see §8 for the disagreements with that preprint).

---

## 1. Conventions, and what is imported as known

**Notation.**  𝔤 is a compact (real) Lie algebra.  A compact Lie algebra splits
canonically as `𝔤 = 𝔤₁ ⊕ ⋯ ⊕ 𝔤_r ⊕ 𝔲` with each `𝔤_i` compact simple and
`𝔲 = u(1)^m` the centre (Knapp, *Lie Groups Beyond an Introduction*, 2nd ed.,
Cor. 4.25).  `Tr X^k := Tr_{𝔤}((ad X)^k)`.

**Homogeneity remark (normalization is irrelevant).**  Both sides of (i) are
homogeneous of degree 6 in `F`: under `F ↦ λF` the left side scales by `λ⁶`, and
so do `Tr F⁴·Tr F²` and `(Tr F²)³`.  Hence (i) is invariant under rescaling `F`,
**including by `λ = i`**.  Therefore the identity is insensitive to the choice of
Hermitian vs. anti-Hermitian convention for the field strength, and to any
overall normalization of the generators.  This is what lets us compute below
with real-valued roots on the split real form of the Cartan subalgebra without
tracking factors of `i`.  (This is also why no statement from
`conv.gauge-trace-normalization` beyond "`Tr` = adjoint trace" is needed.)

**Imported as black boxes** (permitted by `claim.md`; these are classical
mathematics outside the scope of the stringgraph corpus):

- **(K)** *Killing–Cartan classification.*  Every compact simple Lie algebra is
  isomorphic to exactly one of `A_n (n≥1)`, `B_n (n≥2)`, `C_n (n≥3)`,
  `D_n (n≥4)`, `G₂`, `F₄`, `E₆`, `E₇`, `E₈`.  (Bourbaki, *Groupes et algèbres de
  Lie*, Ch. VI §4.2, Théorème 3; the stated rank ranges are the standard
  non-redundant ones, excluding the coincidences `B₁=C₁=A₁`, `C₂=B₂`,
  `D₂=A₁⊕A₁`, `D₃=A₃`.)
- **(T)** *Maximal torus theorem.*  If `G` is a compact connected Lie group with
  Lie algebra 𝔤 and maximal abelian subalgebra 𝔱, then every `X ∈ 𝔤` is
  `Ad(G)`-conjugate to an element of 𝔱.  (Bröcker–tom Dieck, *Representations of
  Compact Lie Groups*, Ch. IV, Thm. 1.6.)
- **(R)** *Root space decomposition.*  `𝔤_ℂ = 𝔱_ℂ ⊕ ⊕_{α∈Φ} (𝔤_ℂ)_α` with
  `[H, X] = α(H) X` for `X ∈ (𝔤_ℂ)_α`, `H ∈ 𝔱_ℂ`, and `dim 𝔤 = |Φ| + rank 𝔤`.
  The root systems of the types in (K) in explicit coordinates are as listed in
  Bourbaki, *loc. cit.*, Planches I–IX.  (Reproduced in
  `scripts/root_power_sums.py`; independently cross-checked in §5.3.)

**Imported from the stringgraph corpus.**  None of the steps below *requires* a
graph node.  The `so(N)`/`usp(N)` exclusion proved here in §6.2–§6.4 overlaps the
rigorous, Lean-formalized node `math.tr-f6-coefficient-vanishing`; the derivation
given here is independent of it, and they agree.  The node
`math.tr-f6-coefficient-vanishing-u-n` is *not* used (its status is
`physical-argument`); the `A_n` case is derived from scratch in §6.1.

---

## 2. Lemma 1 (abelian factors are invisible to (i))

**Lemma 1.**  Let `𝔤 = 𝔤' ⊕ u(1)^m` with `𝔤'` the semisimple part.  Then for every
`k ≥ 1` and every `F = F' + F_𝔲 ∈ 𝔤`,

> `Tr F^k = Tr_{𝔤}((ad F')^k)`,

and `Tr_{𝔤}((ad F')^k) = Tr_{𝔤'}((ad_{𝔤'} F')^k)`.  Consequently **(i) holds on 𝔤
if and only if (i) holds on 𝔤'**, and in particular (i) places no condition
whatsoever on `m`.

*Proof.*  `u(1)^m` is by definition the centre of 𝔤, so `ad F_𝔲 = 0`, and since
`𝔤'` and `u(1)^m` commute, `ad F = ad F' + ad F_𝔲 = ad F'`.  This gives the first
equality.  For the second: `ad F'` preserves the decomposition `𝔤 = 𝔤' ⊕ u(1)^m`
and annihilates the second summand, so its matrix is block diagonal with a zero
block; for `k ≥ 1` the zero block contributes `0` to the trace of the `k`-th
power.  The last claim follows because every term of (i) is of the form
`Tr F^{k}` with `k ∈ {2,4,6}`. ∎

*Remark.*  This is the precise sense in which `u(1)⁴⁹⁶` and `e₈ ⊕ u(1)²⁴⁸`
"satisfy" the anomaly condition: they satisfy it vacuously in the abelian
directions.  It is consistent with — and is the algebraic shadow of — the
observation of `consistency.abelian-factorization-is-not-cancellation`
(Adams–DeWolfe–Taylor 2010) that no Green–Schwarz counterterm actually cancels
anything along abelian directions.  Proposition (S) as stated asks only about
(i) and (ii), so these two algebras are genuine solutions of the stated problem.

So from now on we classify **semisimple** `𝔤'` of dimension ≤ 496 satisfying (i);
`m := 496 − dim 𝔤'` is then determined by (ii).

---

## 3. Lemma 2 (reduction to power sums over roots)

Fix a semisimple compact 𝔤' with maximal abelian subalgebra 𝔱 and root system
`Φ ⊂ 𝔱_ℂ^*`.  Let `𝔱_ℝ ⊂ 𝔱_ℂ` be the real form on which every root takes real
values (`𝔱_ℝ = i𝔱`).  For `h ∈ 𝔱_ℝ` put

> `S_k(h) := Σ_{α ∈ Φ} α(h)^k`.

**Lemma 2.**  (i) holds on 𝔤' **if and only if**

> **(i′)**  `S₆(h) = (1/48) S₄(h) S₂(h) − (1/14400) S₂(h)³`  for all `h ∈ 𝔱_ℝ`,

an identity of polynomial functions on the real vector space `𝔱_ℝ`.

*Proof.*  Write `D := Tr F⁶ − (1/48)Tr F⁴ Tr F² + (1/14400)(Tr F²)³`, a
real-valued polynomial function on 𝔤' of degree 6.  Each `Tr F^k` is
`Ad(G)`-invariant (`Tr((ad(Ad_g F))^k) = Tr((Ad_g ad(F) Ad_g^{-1})^k)` by
naturality of `ad`, and trace is conjugation-invariant), hence so is `D`.

(⇐) Suppose `D|_𝔱 = 0`.  By (T) every `X ∈ 𝔤'` is `Ad(G)`-conjugate to some
`H ∈ 𝔱`, so `D(X) = D(H) = 0`.  Thus `D ≡ 0` on 𝔤', i.e. (i) holds.
(⇒) is trivial since `𝔱 ⊂ 𝔤'`.

So (i) ⟺ `D|_𝔱 = 0`.  Now `D|_𝔱` is a real polynomial on the real vector space
𝔱; it vanishes on 𝔱 iff its (unique) polynomial extension vanishes on the
complexification `𝔱_ℂ` (a polynomial vanishing on a real form of a complex vector
space vanishes identically, the real form being Zariski dense), iff it vanishes
on the other real form `𝔱_ℝ = i𝔱` — for the same reason.

Finally, for `H ∈ 𝔱_ℂ` the operator `ad H` acts on `𝔤_ℂ' = 𝔱_ℂ ⊕ ⊕_α (𝔤_ℂ')_α`
diagonally, by `0` on `𝔱_ℂ` and by `α(H)` on `(𝔤_ℂ')_α` (this is (R)).  Hence for
`k ≥ 1`,

> `Tr H^k = 0^k · rank(𝔤') + Σ_{α ∈ Φ} α(H)^k = S_k(H)`,

and substituting into `D` turns `D|_{𝔱_ℝ} = 0` into (i′) verbatim. ∎

**Lemma 2′ (choice of coordinates is free).**  If `T : ℝ^d → 𝔱_ℝ` is any linear
map with image containing... more precisely: let `V = span_ℝ Φ ⊆ 𝔱_ℝ^*`.  Then
`S_k(h)` depends only on the image of `h` under `𝔱_ℝ → V^*`.  Consequently, if we
realize `Φ` as a set of vectors in `ℝ^d` (for any `d ≥ rank`) via any injective
linear map, with `α(h)` computed as the standard dot product, then (i′) holds on
`𝔱_ℝ` iff the corresponding identity holds for all `h ∈ ℝ^d`.

*Proof.*  `𝔱_ℝ^* ⊇ V` and `Φ` spans `V`, so `S_k` factors through `𝔱_ℝ ↠ V^*`.
Both sides of (i′) are built from `S₂, S₄, S₆`, so the identity on `𝔱_ℝ` is
equivalent to the identity on `V^*`, which is a statement about the root system
alone and is invariant under any linear isomorphism.  Realizing `Φ ⊂ ℝ^d` and
letting `h` range over all of `ℝ^d` adds nothing: `⟨α, h⟩ = ⟨α, P h⟩` where `P` is
the orthogonal projection onto `span Φ ⊆ ℝ^d`, so the identity for all `h ∈ ℝ^d`
is equivalent to the identity for all `h ∈ span Φ ≅ V^*`. ∎

This is what licenses the use of the Bourbaki coordinates below, including the
realizations of `A_n` inside `ℝ^{n+1}` and of `E₆`, `E₇` inside `ℝ⁸`, without any
normalization bookkeeping.

---

## 4. Lemma 3 and Lemma 4 (the number of simple factors)

Let `𝔤' = 𝔤₁ ⊕ ⋯ ⊕ 𝔤_r` with each `𝔤_i` compact simple, and let
`𝔱_ℝ = 𝔱_{1,ℝ} ⊕ ⋯ ⊕ 𝔱_{r,ℝ}`.  Then

> `Sym(𝔱_ℝ^*) = Sym(𝔱_{1,ℝ}^*) ⊗ ⋯ ⊗ Sym(𝔱_{r,ℝ}^*)`

is graded by **multidegree** `(d₁,…,d_r)`, and it is an integral domain (a
polynomial ring).  Since `Φ = Φ₁ ⊔ ⋯ ⊔ Φ_r` with `Φ_i ⊂ 𝔱_{i,ℝ}^*`, we have for
each `k`

> `S_k = A_k^{(1)} + ⋯ + A_k^{(r)}`, where `A_k^{(i)}(h) := Σ_{α ∈ Φ_i} α(h_i)^k`

is of pure multidegree `k` in slot `i`.  Abbreviate `A_i := A_2^{(i)}`,
`C_i := A_4^{(i)}`, `E_i := A_6^{(i)}`.

**Observation 4.0.**  `A_i ≠ 0` in `Sym²(𝔱_{i,ℝ}^*)`.
*Proof.*  `A_i(h) = Σ_{α ∈ Φ_i} α(h)²` is a sum of squares of **real** numbers
(this is why we passed to `𝔱_ℝ`).  If `A_i(h) = 0` for all `h` then every root
`α ∈ Φ_i` vanishes identically, so `Φ_i = ∅`, so `dim 𝔤_i = rank 𝔤_i` by (R) and
`𝔤_i` is abelian — contradicting simplicity. ∎
(Equivalently: `A_i` is the Killing form, nondegenerate on a simple algebra.)

**Lemma 3 (at most two simple factors).**  If `𝔤'` satisfies (i) then `r ≤ 2`.

*Proof.*  Suppose `r ≥ 3` and pick distinct indices `i, j, k`.  Extract from
(i′) the component of multidegree `2` in each of slots `i, j, k` and `0` in every
other slot.  Term by term:

- `S₆ = Σ_l E_l` is a sum of terms of pure multidegree `(0,…,6,…,0)`.  Its
  `(2,2,2)`-component is `0`.
- `S₄ S₂ = (Σ_l C_l)(Σ_p A_p)` is a sum of products of one pure-degree-4 and one
  pure-degree-2 term, so each summand is supported on **at most two** slots.  Its
  `(2,2,2)`-component is `0`.
- `S₂³ = (Σ_l A_l)³`.  The summands with exactly the three slots `i, j, k`
  occupied, each to degree 2, are the `3! = 6` orderings of `A_i A_j A_k`.  Its
  `(2,2,2)`-component is `6 A_i A_j A_k`.

So (i′) forces `0 = −(6/14400) A_i A_j A_k`, i.e. `A_i A_j A_k = 0`.  But
`Sym(𝔱_ℝ^*)` is an integral domain and each `A_l ≠ 0` by Observation 4.0 —
contradiction. ∎

**Lemma 4 (what two factors must each satisfy).**  If `𝔤' = 𝔤₁ ⊕ 𝔤₂` with both
factors simple and (i) holds, then **each** factor separately satisfies the pair

> **(P)**  `S₄ = (1/100) S₂²`  and  `S₆ = (1/7200) S₂³`.

Conversely, if both factors satisfy (P) then `𝔤₁ ⊕ 𝔤₂` satisfies (i).

*Proof.*  With `r = 2` the possible multidegrees in degree 6 are `(6,0)`,
`(4,2)`, `(2,4)`, `(0,6)`.  Extract each.

*Multidegree `(4,2)`.*  `S₆` contributes `0`; `S₄S₂ = (C₁+C₂)(A₁+A₂)` contributes
`C₁A₂`; `S₂³ = (A₁+A₂)³` contributes `3A₁²A₂`.  Hence

> `0 = (1/48) C₁ A₂ − (3/14400) A₁² A₂`, i.e. `C₁ A₂ = (48·3/14400) A₁² A₂ = (1/100) A₁² A₂`.

Since `A₂ ≠ 0` (Observation 4.0) and the ring is a domain, we may cancel `A₂`:

> `C₁ = (1/100) A₁²`, i.e. `𝔤₁` satisfies the first half of (P).

By the symmetric argument on multidegree `(2,4)`, `C₂ = (1/100)A₂²`.

*Multidegree `(6,0)`.*  `S₆` contributes `E₁`, `S₄S₂` contributes `C₁A₁`, `S₂³`
contributes `A₁³`.  Hence, using `C₁ = (1/100)A₁²`,

> `E₁ = (1/48)(1/100)A₁³ − (1/14400)A₁³ = (1/4800 − 1/14400) A₁³ = (2/14400) A₁³ = (1/7200) A₁³`.

Same for `E₂` from multidegree `(0,6)`.  This is (P) for both factors.

Conversely, if `C_l = (1/100)A_l²` and `E_l = (1/7200)A_l³` for `l = 1,2`, then

> RHS of (i′) `= (1/48)·(1/100)(A₁²+A₂²)(A₁+A₂) − (1/14400)(A₁+A₂)³`.

The coefficient of `A₁³` is `1/4800 − 1/14400 = 1/7200`; the coefficient of
`A₁²A₂` is `1/4800 − 3/14400 = 3/14400 − 3/14400 = 0`; likewise for the mirror
terms.  So the RHS equals `(1/7200)(A₁³+A₂³) = E₁+E₂ = S₆`. ∎

**Lemma 4′ (P is strictly stronger than (i)).**  If a simple 𝔤 satisfies (P) then
it satisfies (i′).  *Proof:* substitute (P) into the right side of (i′):
`(1/48)(1/100)S₂³ − (1/14400)S₂³ = (1/7200)S₂³ = S₆`. ∎

Consequently a simple algebra that **fails** (i) also fails (P), and it suffices
to run the exhaustion of §6 for (i), recording separately which survivors also
satisfy (P).

**Corollary 4.1 (the finite search space).**  By (ii) and Lemma 1,
`dim 𝔤' ≤ 496`; since `dim 𝔤' = Σ_i dim 𝔤_i` and each `dim 𝔤_i ≥ 3`, every simple
factor has `dim 𝔤_i ≤ 496`.  By (K), the compact simple Lie algebras of dimension
≤ 496 are exactly

| type | dimension | range forced by dim ≤ 496 | count |
|---|---|---|---|
| `A_n = su(n+1)` | `n(n+2)` | `1 ≤ n ≤ 21` (`21·23 = 483`, `22·24 = 528`) | 21 |
| `B_n = so(2n+1)` | `n(2n+1)` | `2 ≤ n ≤ 15` (`15·31 = 465`, `16·33 = 528`) | 14 |
| `C_n = usp(2n)` | `n(2n+1)` | `3 ≤ n ≤ 15` | 13 |
| `D_n = so(2n)` | `n(2n−1)` | `4 ≤ n ≤ 16` (`16·31 = 496`, `17·33 = 561`) | 13 |
| `G₂, F₄, E₆, E₇, E₈` | `14, 52, 78, 133, 248` | — | 5 |

a list of exactly **66** algebras.  This is a finite, fully enumerable search
space. ∎

---

## 5. The exhaustion: method

### 5.1 What is computed

`scripts/root_power_sums.py` builds, for each of the 66 algebras, the explicit
root list in Bourbaki coordinates, forms `S₂, S₄, S₆` as exact multivariate
polynomials with `fractions.Fraction` coefficients (no floating point, no
external dependency), and tests two polynomial identities:

- (i′): `S₆ − (1/48)S₄S₂ + (1/14400)S₂³ = 0`;
- (P): `S₄ − (1/100)S₂² = 0` and `S₆ − (1/7200)S₂³ = 0`.

A polynomial is zero iff its coefficient dictionary is empty, so the test is an
exact decision, not a numerical one.

Run with `python scripts/root_power_sums.py` (≈70 s, stdlib only).  Result:

```
66 compact simple Lie algebras of dim <= 496 examined
satisfying (i)         : [('D_16 = so(32)', 496), ('E_8', 248)]
satisfying strong pair : [('E_8', 248)]
```

### 5.2 Why the root data may be trusted

Two independent checks are run on every root list actually used:

1. **Dimension check** (an `assert` inside `analyse`): `|Φ| + rank = dim 𝔤` for
   the independently known dimension of each type, as required by (R).  All 66
   pass.
2. **Dual Coxeter check** (`scripts/closed_forms_and_witnesses.py`).  For a
   simple Lie algebra, with the invariant form normalized so that long roots have
   squared length 2, the Killing form satisfies `S₂(h) = 2h^∨ · |Ph|²`.  The
   script rescales each root list so `|α_long|² = 2`, computes `tr(S₂)`, divides
   by `2h^∨` for the tabulated dual Coxeter number, and checks the result equals
   the rank.  Sampled across all nine types (`A₁, A₂, A₅, A₂₁, B₂, B₇, B₁₅, C₃,
   C₉, C₁₅, D₄, D₁₀, D₁₆, G₂, F₄, E₆, E₇, E₈`) with
   `h^∨ = n+1, 2n−1, n+1, 2n−2, 4, 9, 12, 18, 30`: **all pass exactly.**  This
   simultaneously validates the coordinates, the multiplicities, and the
   power-sum code.

### 5.3 Hand-checkable form

§6 restates every exclusion in a form checkable without the script: closed
formulas in the rank for the four classical families, and a single explicit
evaluation point for each exceptional algebra.

---

## 6. The exhaustion: closed forms and hand checks

Throughout §6, `p_k := Σ_i x_i^k` in the coordinates of the corresponding
Bourbaki realization.  All formulas below are verified against the explicit root
lists for a range of ranks by `scripts/closed_forms_and_witnesses.py`
(`check_classical`), which prints `True` for each.

### 6.1 Type `A_n = su(n+1)`

Roots `e_i − e_j` (`i ≠ j`) in `ℝ^N`, `N = n+1`; the Cartan is the hyperplane
`p₁ = 0`.  Using `Σ_{i≠j}(x_i−x_j)^k = Σ_{i,j}(x_i−x_j)^k` for `k ≥ 1` and the
binomial theorem,

> `S_k = Σ_{a=0}^{k} C(k,a) (−1)^{k−a} p_a p_{k−a}`  with `p₀ = N`,

hence, setting `p₁ = 0`,

> `S₂ = 2N p₂`,  `S₄ = 2N p₄ + 6 p₂²`,  `S₆ = 2N p₆ + 30 p₂p₄ − 20 p₃²`.

Condition (i′) becomes

> `2N p₆ + 30 p₂p₄ − 20 p₃² = (N²/12) p₂p₄ + (N/4 − N³/1800) p₂³`.   (A)

*Case `N ≥ 6`.*  The ring of `S_N`-invariants restricted to `{p₁ = 0}` is the
polynomial ring on the algebraically independent generators `p₂, p₃, …, p_N`
(Newton's identities give `ℝ[x]^{S_N} = ℝ[p₁,…,p_N]` with the `p_i`
algebraically independent; quotienting by the ideal `(p₁)` leaves `N−1`
independent generators on an `(N−1)`-dimensional space).  So in (A) the
monomials `p₆`, `p₂p₄`, `p₃²`, `p₂³` are linearly independent.  The coefficient
of `p₆` gives `2N = 0`, impossible.  **Excluded.**

*Case `N ≤ 5`.*  Here `p₆` is not independent.  With `e₁ = 0`,
`e₂ = −p₂/2`, `e₃ = p₃/3`, `e₄ = p₂²/8 − p₄/4`, Newton's recursion
`p₆ = e₁p₅ − e₂p₄ + e₃p₃ − e₄p₂ + e₅p₁` gives, for `N = 4` and `N = 5`,
`p₆ = (3/4)p₂p₄ + p₃²/3 − p₂³/8`; for `N = 3`, `p₆ = p₂³/4 + p₃²/3`; for `N = 2`,
`p₃ = 0`, `p₄ = p₂²/2`, `p₆ = p₂³/4`.  Substituting into (A):

| `N` | algebra | LHS of (A) | RHS of (A) | obstruction |
|---|---|---|---|---|
| 2 | `su(2)` | `128 t⁶` (at `x = (t,−t)`) | `(1/48)(32t⁴)(8t²) − (8t²)³/14400 = (1192/225) t⁶` | `128 ≠ 1192/225 ≈ 5.298` |
| 3 | `su(3)` | `(33/2)p₂³ − 18 p₃²` | `(111/100) p₂³` | coeff. of `p₃²`: `−18 ≠ 0` |
| 4 | `su(4)` | `36 p₂p₄ − (52/3) p₃² − p₂³` | `(4/3)p₂p₄ + (217/225) p₂³` | coeff. of `p₃²`: `−52/3 ≠ 0` |
| 5 | `su(5)` | `(75/2) p₂p₄ − (50/3) p₃² − (5/4) p₂³` | `(25/12)p₂p₄ + (85/72)p₂³` | coeff. of `p₃²`: `−50/3 ≠ 0` |

(`p₂, p₃` are algebraically independent on `{p₁=0}` already for `N = 3`, and
`p₂,p₃,p₄` for `N ≥ 4`, so the coefficient comparisons are legitimate.  Every row
of this table is re-verified against the explicit root lists by
`check_small_rank_tables` in `scripts/closed_forms_and_witnesses.py`.)
**All `A_n` are excluded**, for every `n ≥ 1` — not merely for `n ≤ 21`.

*Warning, recorded because it is a live trap.*  The tempting shortcut of testing
(A) only on the two-parameter slice `x = (a,−a,b,−b,0,…,0)` (where `p₃ = 0`)
**does not** exclude `A_n`.  On that slice (A) reduces to the two equations
`4N + 120 = N²/3 + 2N − N³/225` and `120 = N²/3 + 6N − N³/75`, whose common
solution is `N = 30`.  So `su(30)` passes this slice test and is excluded only by
the `p₆` (equivalently `p₃²`) terms.  Any proof of (S) that tests `A_n` on a
Cartan slice with `p₃ = 0` has a hole at `N = 30`.  (`su(30)` has dimension 899,
so it is in any case beyond the reach of (ii) — but the trap is real for the
argument, not only for the bookkeeping.)

### 6.2 Type `D_n = so(2n)`

Roots `±e_i ± e_j` (`i < j`) in `ℝ^n`.  For even `k`,

> `S_k = 2 Σ_{a even, 0≤a≤k} C(k,a) p_a p_{k−a} − 2^k p_k`,  `p₀ = n`,

giving

> `S₂ = 4(n−1) p₂`,  `S₄ = 4(n−4) p₄ + 12 p₂²`,  `S₆ = 4(n−16) p₆ + 60 p₂p₄`.

For `n ≥ 3`, `p₂, p₄, p₆` are algebraically independent (they are the power sums
`q₁, q₂, q₃` in the `n ≥ 3` variables `y_i = x_i²`), so the monomials `p₆`,
`p₂p₄`, `p₂³` are linearly independent and (i′) is equivalent to the **three**
scalar equations

| monomial | equation | solutions |
|---|---|---|
| `p₆` | `4(n−16) = 0` | `n = 16` |
| `p₂p₄` | `60 = (1/3)(n−4)(n−1)` i.e. `(n−4)(n−1) = 180` | `n = 16` (and `n = −11`) |
| `p₂³` | `(n−1) − (n−1)³/225 = 0` | `n = 1` or `n = 16` (or `n = −14`) |

The unique common positive integer solution is `n = 16`, and all three equations
are satisfied there simultaneously — a threefold consistency check that the
solution is real and not an artefact.  Hence **`so(32)` is the unique member of
the `D` family satisfying (i)**, and `dim so(32) = 16·31 = 496`, consistent with
(ii) at `m = 0`.

Note also that `so(32)` does **not** satisfy (P): `S₄ = 48p₄ + 12p₂²` while
`(1/100)S₂² = (1/100)(60p₂)² = 36p₂²`, and these differ by `48p₄ − 24p₂² ≠ 0`.
By Lemma 4 this means **`so(32)` can never occur as a factor of a two-factor
decomposition.**

### 6.3 Type `B_n = so(2n+1)`

The roots are those of `D_n` together with `±e_i`, so `S_k^{B_n} = S_k^{D_n} + 2p_k`
for even `k`:

> `S₂ = (4n−2) p₂`,  `S₄ = (4n−14) p₄ + 12 p₂²`,  `S₆ = (4n−62) p₆ + 60 p₂p₄`.

For `n ≥ 3` the coefficient of `p₆` in (i′) gives `4n − 62 = 0`, i.e. `n = 31/2`,
**not an integer**.  Excluded.  For `n = 2` (`so(5)`), `p₂,p₄` are independent but
`p₆ = −(1/2)p₂³ + (3/2)p₂p₄`; substituting, (i′) reads
`27p₂³ − 21p₂p₄ = (297/200)p₂³ − (3/4)p₂p₄`, and the `p₂p₄` coefficients `−21`
and `−3/4` differ.  Excluded.  **All `B_n` are excluded**, for every `n ≥ 2`.

### 6.4 Type `C_n = usp(2n)`

The roots are those of `D_n` together with `±2e_i`, so
`S_k^{C_n} = S_k^{D_n} + 2·2^k p_k`:

> `S₂ = (4n+4) p₂`,  `S₄ = (4n+16) p₄ + 12 p₂²`,  `S₆ = (4n+64) p₆ + 60 p₂p₄`.

For `n ≥ 3` the `p₆` coefficient gives `4n + 64 = 0`, i.e. `n = −16`, impossible
for a positive rank.  **All `C_n` are excluded**, for every `n ≥ 3`.

*Remark.*  §6.2–§6.4 reprove, by a different route, the content of the rigorous
node `math.tr-f6-coefficient-vanishing`, and agree with it.  The agreeable
numerology `n = 16` for `D`, `n = 31/2` for `B`, `n = −16` for `C` all come from
the single expression `4n + (D:−64, B:−62, C:+64)` for the `p₆` coefficient,
which is a useful mnemonic for a reviewer.

### 6.5 The exceptional algebras

For each of `G₂, F₄, E₆, E₇, E₈` the space of degree-4 Weyl-invariant polynomials
on the Cartan is **one-dimensional**, spanned by `S₂²`: the degrees of the basic
invariants are `(2,6)` for `G₂`, `(2,6,8,12)` for `F₄`, `(2,5,6,8,9,12)` for `E₆`,
`(2,6,8,10,12,14,18)` for `E₇`, `(2,8,12,14,18,20,24,30)` for `E₈` (Bourbaki,
*loc. cit.*, Planches; equivalently `1 +` exponents), and none of these lists
contains a `4`, nor can `4` be written as a sum of two of them other than
`2 + 2`.  Hence

> `S₄ = a₄ · S₂²` for a rational constant `a₄`,

and therefore the entire right-hand side of (i′) is proportional to `S₂³`:

> RHS `= (a₄/48 − 1/14400) S₂³`.

So (i′) holds **iff** `S₆` is itself proportional to `S₂³`, with exactly the
constant `a₄/48 − 1/14400`.  Computing `a₄` and testing the proportionality of
`S₆` (script `witnesses`, exact arithmetic):

| algebra | `dim` | `a₄` with `S₄ = a₄S₂²` | is `S₆ ∝ S₂³`? | verdict on (i) |
|---|---|---|---|---|
| `G₂` | 14 | `5/32` | **no** | excluded |
| `F₄` | 52 | `5/108` | **no** | excluded |
| `E₆` | 78 | `1/32` | **no** | excluded |
| `E₇` | 133 | `1/54` | **no** | excluded |
| `E₈` | 248 | `1/100` | yes, `S₆ = (1/7200)S₂³` | **satisfies (i)** |

and for `E₈` the constant matches exactly:
`a₄/48 − 1/14400 = (1/100)/48 − 1/14400 = 1/4800 − 1/14400 = 2/14400 = 1/7200`. ✔

Since `E₈` has `a₄ = 1/100` and `S₆ = (1/7200)S₂³`, it satisfies not only (i) but
also the stronger pair **(P)** — it is, by §6.2 and the table above, the only
algebra among the 66 that does.

**Single-point hand checks.**  For a reader who wants to verify the four
exclusions without the proportionality argument, one evaluation point suffices in
each case (exact rational values, from `witnesses`):

| algebra | `h` | `S₂` | `S₄` | `S₆` | RHS `= S₄S₂/48 − S₂³/14400` |
|---|---|---|---|---|---|
| `G₂` | `(1,0,−1)` | `48` | `360` | `3048` | `8808/25 = 352.32` |
| `F₄` | `(1,0,0,0)` | `18` | `15` | `57/4` | `261/50 = 5.22` |
| `E₆` | `(1,0,…,0)` | `24` | `18` | `33/2` | `201/25 = 8.04` |
| `E₇` | `(1,0,…,0)` | `36` | `24` | `21` | `369/25 = 14.76` |
| `E₈` | `(1,0,…,0)` | `60` | `36` | `30` | `30` ✔ |

For example, for `E₈`: `36·60/48 − 60³/14400 = 45 − 15 = 30 = S₆`. ✔
For `E₇`: `24·36/48 − 36³/14400 = 18 − 3.24 = 14.76 ≠ 21`. ✘

### 6.6 Result of the exhaustion

**Proposition 5.**  Among the 66 compact simple Lie algebras of dimension ≤ 496:

- exactly two satisfy (i): `so(32)` (`dim 496`) and `e₈` (`dim 248`);
- exactly one satisfies (P): `e₈`.

Moreover §6.1, §6.3, §6.4 prove the stronger statement that *no* `A_n`, `B_n` or
`C_n` satisfies (i) at any rank, and §6.2 that `D₁₆` is the only `D_n` at any
rank; only the exceptional cases and the `D` dimension bookkeeping actually use
`dim ≤ 496`.

---

## 7. Proof of proposition (S)

Let 𝔤 be compact with `dim 𝔤 = 496` satisfying (i).  Write
`𝔤 = 𝔤₁ ⊕ ⋯ ⊕ 𝔤_r ⊕ u(1)^m` with `𝔤_i` simple.  By **Lemma 1**, (i) holds iff it
holds on `𝔤' = 𝔤₁ ⊕ ⋯ ⊕ 𝔤_r`, and `m = 496 − dim 𝔤'`.  By **Lemma 3**, `r ≤ 2`.
By **Corollary 4.1** every `𝔤_i` appears in the list of 66.

**Case `r = 0`.**  `𝔤' = 0`, (i) reads `0 = 0` and holds; `m = 496`.
This is `𝔤 ≅ u(1)⁴⁹⁶`, solution **4**.

**Case `r = 1`.**  `𝔤' = 𝔤₁` simple satisfying (i′).  By Proposition 5,
`𝔤₁ ≅ so(32)` or `𝔤₁ ≅ e₈`.

- `𝔤₁ ≅ so(32)`: `dim = 496`, so `m = 0` and `𝔤 ≅ so(32)`, solution **1**.
- `𝔤₁ ≅ e₈`: `dim = 248`, so `m = 248` and `𝔤 ≅ e₈ ⊕ u(1)²⁴⁸`, solution **3**.

**Case `r = 2`.**  `𝔤' = 𝔤₁ ⊕ 𝔤₂`.  By **Lemma 4** each `𝔤_i` satisfies (P); by
Proposition 5 the only simple algebra of dimension ≤ 496 satisfying (P) is `e₈`.
Hence `𝔤₁ ≅ 𝔤₂ ≅ e₈`, `dim 𝔤' = 496`, `m = 0`, and `𝔤 ≅ e₈ ⊕ e₈`, solution **2**.
(The converse half of Lemma 4 confirms this really does satisfy (i); this is also
the content of the rigorous node
`consistency.d10-four-groups-satisfy-anomaly-conditions`, which (S) does not
re-prove.)

These four cases are exhaustive and mutually exclusive, so

> `𝔤 ≅ so(32)`, or `e₈ ⊕ e₈`, or `e₈ ⊕ u(1)²⁴⁸`, or `u(1)⁴⁹⁶`.  ∎

The final assembly is also performed mechanically at the end of
`scripts/root_power_sums.py`, which prints

```
solutions of (i) & (ii):
    u(1)^496
    D_16 = so(32)
    E_8 + u(1)^248
    E_8 + E_8
```

---

## 8. Relation to `antonelli-2015`

This proof was written without consulting the coefficient tables of that
preprint, as required.  Two structural remarks, offered so that a reviewer can
locate where the published attempt goes wrong:

- Its candidate-set framework (run over the whole Killing–Cartan list) is the
  right one and is reproduced here as Corollary 4.1.
- The `F₄` argument there is reported (in the Phase-0 review recorded in
  `claim.md`) to use an invalid method.  §6.5 shows that `F₄` needs no special
  method at all: it has no primitive degree-4 invariant, so `S₄ = (5/108)S₂²`
  automatically and the whole question collapses to whether `S₆ ∝ S₂³`, which it
  is not.  The single point `h = (1,0,0,0)` settles it: `S₆ = 57/4 = 14.25` while
  the right-hand side is `261/50 = 5.22`.

`[GAP: I have not line-by-line diffed this proof against antonelli-2015's
coefficient tables, so I cannot state which of its specific numbers are wrong,
only that the values computed here are independently derived and internally
cross-checked (§5.2).  A reviewer wanting that diff should treat it as separate
work; it is not needed for the validity of the proof above.]`

---

## 9. Open points

The proof above is believed complete for proposition (S) as stated.  The
residual items are verification-strength issues, not logical gaps:

`[GAP: reproducibility of the 66-case exhaustion.  §6.1–§6.4 give closed forms
that exclude A_n, B_n, C_n and all D_n except D₁₆ by hand at every rank, so the
classical part of the exhaustion does not depend on the script.  The five
exceptional cases in §6.5 depend on the explicit Bourbaki root lists encoded in
scripts/root_power_sums.py.  These are cross-checked two ways (§5.2) and each
exclusion is reduced to a single-point evaluation a reader can redo, but a
reviewer should re-derive at least one exceptional root list independently before
the result is taken as verified.]`

`[GAP: the invariant-degree argument in §6.5 (that no exceptional algebra has a
primitive degree-4 invariant, hence S₄ ∝ S₂²) is quoted from the Bourbaki tables
of exponents.  It is not logically necessary — the script verifies S₄ = a₄S₂² as
a polynomial identity directly, and the single-point witnesses exclude
G₂/F₄/E₆/E₇ without it — but as written §6.5 leans on the tables for the
*structure* of the argument.  If a reviewer prefers a table-free proof, §6.5's
witness table alone suffices for the four exclusions, and E₈'s inclusion is a
direct polynomial identity check.]`

`[GAP: Lean formalization not attempted.  The whole argument is finite and
combinatorial and should be formalizable: Lemmas 1, 3, 4 are elementary algebra
over a polynomial ring, and §6 is a decidable computation over ℚ.  The one
genuinely hard import would be the Killing–Cartan classification (K) and the
maximal torus theorem (T), neither of which is currently in Mathlib in the form
needed.  A realistic formalization target is the *conditional* statement "given
the root system of each of the 66 types, exactly so(32) and e₈ satisfy (i)",
which is pure computation.]`

`[GAP: physical interpretation not addressed.  (S) is a statement about the
algebraic conditions (i) and (ii) only.  Whether each of the four solutions
corresponds to a consistent string background is a separate question — and for
u(1)⁴⁹⁶ and e₈⊕u(1)²⁴⁸ the answer is known to be subtle, cf.
consistency.abelian-factorization-is-not-cancellation.  Nothing here should be
read as claiming otherwise.]`
