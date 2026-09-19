# Proof: S6 is injective on the whole level-1 slice

See `claim.md` for the full notation table, the bricks table (graph nodes actually queried),
and the logical chain (§4 there) reducing the docstring's target
`dim ker(seedPair η a b (-6) 6) ≤ D-1` to the theorem proved here. This file proves only the
new mathematics: the injectivity of `x4` and `y3` (separately, hence jointly as `S6`) on the
**whole** level-1 slice `F(p)_1`, for every `D`, every `η` with `hη`, and every momentum `p`.

Throughout, `K` is a field with `CharZero K`; all objects are exactly as fixed in `claim.md` §1.

## 0. Two elementary structural facts about the free Fock space

**Fact 0 (bigrading).** `F(p)` carries, besides the level grading `F(p) = ⊕_{N≥0} F(p)_N`, a
second grading by **oscillator count** `r ∈ ℕ`: `F(p) = ⊕_{r≥0} F(p)^{(r)}`, where `F(p)^{(r)}`
is spanned by the monomials `α^{ρ_1}_{-t_1}⋯α^{ρ_r}_{-t_r}|0;p⟩` with exactly `r` oscillator
factors (`t_i ≥ 1`, repeats among the `(ρ_i,t_i)` allowed since distinct-mode oscillators
commute — this is a **symmetric-algebra** grading). The two gradings refine each other only in
one direction: every monomial with `r` factors has level `≥ r` (each factor contributes
`t_i ≥ 1` to the level), but is not otherwise correlated. In particular
`F(p)^{(0)} = F(p)_0 = K·|0;p⟩` (the unique 0-oscillator, level-0 vector is the vacuum itself),
so:

> **(†)** any vector of level `≥ 1` has zero `F(p)^{(0)}` component, i.e. lies in
> `⊕_{r≥1} F(p)^{(r)}`.

This is definitional to what "the free Fock space on `D` bosonic oscillator families" means
(the brick `worldsheet.bosonic-fock-space`, **formalized**) — it is the statement that `F(p)`
is, as a vector space, the symmetric algebra on the span of `{α^μ_{-n}}`, tensored with the
vacuum line, which is exactly the standard PBW/monomial-basis description of a Fock module.

**Fact 1 (level bookkeeping for `L_n`).** `L_n` (any `n ∈ ℤ`) maps `F(p)_N → F(p)_{N-n}` for
every `N` (in particular `L_{-M}`, `M ≥ 1`, raises level by `M`). This is immediate from the
Sugawara definition `L_n = ½Σ_k :α_{n-k}·α_k:`: each single oscillator `α^μ_j` maps
`F(p)_N → F(p)_{N-j}` (creation `j<0` raises level by `-j`, annihilation `j>0` lowers it by
`j`, by definition of the level grading as the eigengrading of the total mode-number operator),
so the product `α^μ_{n-k}α^ν_k` maps `F(p)_N → F(p)_{N-(n-k)-k} = F(p)_{N-n}`, and this holds
termwise for every `k`, hence for the sum `L_n`. This fact is part of what makes `F(p)` "a
Virasoro representation" (brick `worldsheet.fock-space-virasoro-representation`, **formalized**
— that node's own content already presupposes this bookkeeping to state that `L_n` are
well-defined graded operators).

**Consequence (used repeatedly below).** For `M ≥ 1`, `L_{-M}|0;p⟩ ∈ F(p)_M` has level `M ≥ 1`,
so by (†), `L_{-M}|0;p⟩` has zero `F(p)^{(0)}`-component, i.e. **`L_{-M}|0;p⟩` is a combination
of monomials with `r ≥ 1` oscillator factors** (it is not a scalar multiple of the vacuum).

## 1. Lemma 0: the single-oscillator commutator identity

> **Lemma 0.** For every integer `n ≠ 0`, every `μ ∈ Fin D`, every integer `m`, and every
> `Y ∈ F(p)`:
> ```
> L_n(α^μ_m Y) = -m · α^μ_{n+m} Y + α^μ_m (L_n Y).
> ```

**Proof.** Write `L_n = ½Σ_{k∈ℤ} α_{n-k}·α_k` where `α_i·α_j := Σ_ρ η_ρ α^ρ_iα^ρ_j`.

*Step 1 (normal ordering is vacuous here).* The CCR (part of the definition of `F(p)` as `D`
free bosonic oscillators, brick `worldsheet.bosonic-fock-space`) gives
`[α^ρ_i, α^σ_j] = i η^{ρσ}δ_{i+j,0}`, which **vanishes identically unless `i+j=0`**. In every
term of the sum defining `L_n`, the two factors have indices `i=n-k, j=k`, so `i+j=n`. Since
we assume `n≠0`, `i+j=n≠0` for **every** term, so `[α_{n-k},α_k]=0` for every `k` — the two
factors of each term always commute, regardless of order. Hence for `n≠0` there is **no
ordering ambiguity**: the "normal-ordered" product `:α_{n-k}α_k:` coincides with the plain
product `α_{n-k}α_k` in either order, and `L_n` (`n≠0`) is simply the unambiguous operator
`½Σ_k α_{n-k}·α_k`. (This also matches the standard fact that normal-ordering subtleties are
confined to `L_0`, which never appears in this proof: we only ever apply `L_{-1},…,L_{-4}`.)

*Step 2 (finiteness).* On any vector `Y` of finite level `N`, `α_kY = 0` for `k>N`, so at most
finitely many `k` contribute to `Σ_k [α_{n-k}·α_k, α^μ_m]Y`; all sums below are finite when
evaluated on a fixed vector, so termwise manipulation is legitimate.

*Step 3 (Leibniz + CCR).* Using `[AB,C]=A[B,C]+[A,C]B` and `[α^ρ_i,α^μ_m] = iη^{ρμ}δ_{i+m,0}`:
```
Σ_ρ η_ρ [α^ρ_iα^ρ_j, α^μ_m]
  = Σ_ρ η_ρ ( α^ρ_i[α^ρ_j,α^μ_m] + [α^ρ_i,α^μ_m]α^ρ_j )
  = j δ_{j+m,0} Σ_ρ η_ρη^{ρμ}α^ρ_i + i δ_{i+m,0} Σ_ρ η_ρη^{ρμ}α^ρ_j.
```
Since `η` is diagonal with `η^{ρμ}=η_ρ[ρ=μ]` and `hη : η_μ² = 1`, `η_ρη^{ρμ}=η_ρ²[ρ=μ]=[ρ=μ]`,
so `Σ_ρ η_ρη^{ρμ}α^ρ_i = α^μ_i`. Thus:
```
[α_i·α_j, α^μ_m] = j δ_{j+m,0} α^μ_i + i δ_{i+m,0} α^μ_j.
```
*Step 4 (sum over `k`, `i=n-k, j=k`).*
```
Σ_k [α_{n-k}·α_k, α^μ_m]
  = Σ_k ( k δ_{k+m,0} α^μ_{n-k} + (n-k) δ_{n-k+m,0} α^μ_k ).
```
The first sum has a unique surviving term `k=-m`, giving `-m·α^μ_{n+m}`. The second sum has a
unique surviving term `k=n+m`, giving `(n-(n+m))·α^μ_{n+m} = -m·α^μ_{n+m}`. Total:
`Σ_k[α_{n-k}·α_k,α^μ_m] = -2m·α^μ_{n+m}`, so `[L_n,α^μ_m] = -m·α^μ_{n+m}`, i.e.
`L_n(α^μ_mY) = α^μ_m(L_nY) - m α^μ_{n+m}Y` for every `Y`. ∎

**Cross-check against the existing formalization.** This is *exactly* the already-proven,
no-`sorry` Lean lemma `formal/StringFormal/NoGhost/Sugawara.lean:Lop_apply_mode` (verified by
direct `Read`, lines 955–981 of that file):
```lean
lemma Lop_apply_mode (hη : ∀ μ, η μ * η μ = 1) (n : ℤ) (μ : Fin D) (p : ℤ) (Y : Fock D R) :
    Lop η a n (mode η a μ p Y)
      = (-(p : R)) • mode η a μ (n + p) Y + mode η a μ p (Lop η a n Y)
```
with `p ↦ m`. The hand derivation above reproduces this identity from the bare CCR + Sugawara
definition, independent of and matching the Lean proof; it is recorded here as an independent
confirmation, not used as a substitute for the derivation (the derivation above is
self-contained and does not depend on the Lean file compiling).

## 2. Lemma A: the leading single-oscillator recursion

Fix `μ ∈ Fin D` and a word `(n_1,…,n_k)` of positive integers (`k ≥ 0`); write
`s_0 = 1`, `s_j = 1 + n_1+⋯+n_j` for `j=1,…,k`. Define
`Y_0 := α^μ_{-1}|0;p⟩ ∈ F(p)^{(1)}_1` and `Y_j := L_{-n_j}(Y_{j-1})` for `j=1,…,k` (i.e.
`Y_k = L_{-n_k}⋯L_{-n_1}(Y_0)`, the word applied with `n_1` **innermost/first**).

> **Lemma A.** For every `j = 0,…,k`, the `F(p)^{(1)}` (single-oscillator) component of `Y_j`
> is exactly `C_j · α^μ_{-s_j}|0;p⟩`, where `C_j := ∏_{i=0}^{j-1} s_i` (`C_0 = 1`, empty
> product). Equivalently, writing `Y_j = Y_j^{(1)} + Y_j^{(≥2)}` for the decomposition into
> `F(p)^{(1)}` and `⊕_{r≥2}F(p)^{(r)}` parts (Fact 0 is a direct-sum decomposition, so this
> split is unique), `Y_j^{(1)} = C_j α^μ_{-s_j}|0;p⟩`.

**Proof.** Induction on `j`. Base case `j=0`: `Y_0 = α^μ_{-1}|0;p⟩` is itself a pure `r=1`
monomial, so `Y_0^{(1)} = Y_0 = 1·α^μ_{-s_0}|0;p⟩` (`s_0=1, C_0=1`). ✓.

Inductive step. Assume `Y_j = C_j α^μ_{-s_j}|0;p⟩ + Y_j^{(≥2)}` with `Y_j^{(≥2)} ∈
⊕_{r≥2}F(p)^{(r)}`. We first need:

**Sub-lemma (monotonicity).** For any `n ≥ 1` and any `Z ∈ ⊕_{r≥2}F(p)^{(r)}`,
`L_{-n}(Z) ∈ ⊕_{r≥2}F(p)^{(r)}` (the `r≥2` subspace is `L_{-n}`-invariant "from below": `L_{-n}`
never produces new `r≤1` content out of `r≥2` input).

*Proof of sub-lemma.* By linearity it suffices to check on a monomial
`v = α^{ρ_1}_{-t_1}⋯α^{ρ_r}_{-t_r}|0;p⟩` with `r ≥ 2`, by induction on `r`. Write
`v = α^{ρ_1}_{-t_1}v'` with `v'` an `(r-1)`-oscillator monomial. By Lemma 0 (with `n ↦ -n`,
`m ↦ -t_1`):
```
L_{-n}(v) = t_1 · α^{ρ_1}_{-n-t_1} v' + α^{ρ_1}_{-t_1}(L_{-n}v').
```
The first term has exactly `1 + (r-1) = r ≥ 2` oscillator factors (one at mode `-n-t_1`, times
the `r-1` factors of `v'`). For the second term: if `r-1 ≥ 2`, by the inductive hypothesis
(on `r`) `L_{-n}v'` lies in `⊕_{r'≥2}F(p)^{(r')}` (wait — we need the *base* case `r=2` first,
where `v'` has `r-1=1` factor: then `L_{-n}v'` is `L_{-n}` applied to a **single**-oscillator
monomial `α^{ρ_2}_{-t_2}|0;p⟩`; by Lemma 0 again, `L_{-n}(α^{ρ_2}_{-t_2}|0;p⟩) = t_2
α^{ρ_2}_{-n-t_2}|0;p⟩ + α^{ρ_2}_{-t_2}(L_{-n}|0;p⟩)`, and the second piece here has `r≥2`
because `L_{-n}|0;p⟩` has `r ≥ 1` by the Consequence in §0, so `α^{ρ_2}_{-t_2}(L_{-n}|0;p⟩)`
has `r ≥ 2`; the first piece `t_2α^{ρ_2}_{-n-t_2}|0;p⟩` has `r=1`. So `L_{-n}v'` for `r-1=1`
is a combination of an `r=1` term and `r≥2` terms — **not** itself purely `r≥2`.) Multiplying
by the outer factor `α^{ρ_1}_{-t_1}` in the second term of the `r=2` case:
`α^{ρ_1}_{-t_1}(L_{-n}v') = α^{ρ_1}_{-t_1}(t_2α^{ρ_2}_{-n-t_2}|0;p⟩) +
α^{ρ_1}_{-t_1}α^{ρ_2}_{-t_2}(L_{-n}|0;p⟩)`, both terms now have `r ≥ 2` (the first is a genuine
2-oscillator monomial, the second has `≥ 1+1=2`). So for `r=2`, `L_{-n}v` is a combination of
`r=2` (first term of the outer step, and first piece just computed) and `r≥3` (second piece)
monomials — **in particular `r ≥ 2` throughout**, confirming the sub-lemma for `r=2`. For
general `r ≥ 2`, the same computation nests: at each of the `r` "peeling" steps, the two
branches either keep the oscillator count the same (shifting one mode) or add one factor from
a level-`≥1` `L_{-n}|0;p⟩` insertion; by induction on `r` every resulting monomial has
`≥ r ≥ 2` factors — no branch ever produces fewer factors than the input. Formally: induct on
`r`; the base case `r=2` is done above; for `r>2`, `L_{-n}v = t_1α^{ρ_1}_{-n-t_1}v' +
α^{ρ_1}_{-t_1}(L_{-n}v')`, first term has `r` factors (`≥2` since `r≥2`), second term is
`α^{ρ_1}_{-t_1}` times `L_{-n}v'`, which by the inductive hypothesis applied to the
`(r-1)`-factor monomial `v'` (if `r-1≥2`) lies in `⊕_{r'≥2}F(p)^{(r')}`, so multiplying by one
more factor gives `⊕_{r'≥3}F(p)^{(r')} ⊆ ⊕_{r'≥2}F(p)^{(r')}`; if `r-1=1` (i.e. `r=2`, already
handled) the base case applies. This closes the induction. ∎ (sub-lemma)

Returning to the main induction: applying `L_{-n_{j+1}}` to `Y_j = C_jα^μ_{-s_j}|0;p⟩ +
Y_j^{(≥2)}`:
- By the sub-lemma, `L_{-n_{j+1}}(Y_j^{(≥2)}) ∈ ⊕_{r≥2}F(p)^{(r)}` — contributes **nothing** to
  the `F(p)^{(1)}` component of `Y_{j+1}`.
- By Lemma 0 applied to the pure single-oscillator term:
  `L_{-n_{j+1}}(C_jα^μ_{-s_j}|0;p⟩) = C_j·s_j·α^μ_{-s_j-n_{j+1}}|0;p⟩ +
  C_j·α^μ_{-s_j}(L_{-n_{j+1}}|0;p⟩)`. The second piece has `r ≥ 2` (since `L_{-n_{j+1}}|0;p⟩`
  has `r ≥ 1` by the Consequence in §0, and multiplying by the outer `α^μ_{-s_j}` adds one
  more factor). The first piece is pure `r=1`, at mode `-(s_j+n_{j+1}) = -s_{j+1}`, same
  species `μ`, with coefficient `C_j·s_j`.

Hence `Y_{j+1}^{(1)} = C_j·s_j·α^μ_{-s_{j+1}}|0;p⟩`, i.e. `C_{j+1} = s_j·C_j`, matching the
claimed formula `C_{j+1} = ∏_{i=0}^{j} s_i`. This closes the induction. ∎ (Lemma A)

## 3. Lemma B: the two universal constants

Apply Lemma A to the five words making up `x4` and the three words making up `y3` (word order
confirmed against `formal/StringFormal/NoGhost/SeedTransferSix.lean:x4_apply`/`y3_apply`,
Read directly: nested application, innermost `towerLop(-1)` applied first, matching the
convention "`L_{-a}L_{-b}` means apply `L_{-b}` first" used throughout this proof):

| word (applied left-to-right, `n_1` first) | `s_0,s_1,…` | `C = ∏ s_i` (Lemma A) | coefficient in `x4`/`y3` | contribution |
|---|---|---|---|---|
| `y3 = 12L_{-3} + 6L_{-2}L_{-1} + L_{-1}L_{-1}L_{-1}`, target level 4: | | | | |
| `(3)` | `s_0=1` | `C=1` | `12` | `12` |
| `(1,2)` | `s_0=1,s_1=2` | `C=1·2=2` | `6` | `12` |
| `(1,1,1)` | `s_0=1,s_1=2,s_2=3` | `C=1·2·3=6` | `1` | `6` |
| **total** | | | | **`30`** |
| `x4 = -76L_{-4} -52L_{-3}L_{-1} -12L_{-2}L_{-2} -20L_{-2}L_{-1}L_{-1} -3L_{-1}^4`, target level 5: | | | | |
| `(4)` | `s_0=1` | `C=1` | `-76` | `-76` |
| `(1,3)` | `s_0=1,s_1=2` | `C=1·2=2` | `-52` | `-104` |
| `(2,2)` | `s_0=1,s_1=3` | `C=1·3=3` | `-12` | `-36` |
| `(1,1,2)` | `s_0=1,s_1=2,s_2=3` | `C=1·2·3=6` | `-20` | `-120` |
| `(1,1,1,1)` | `s_0=1,s_1=2,s_2=3,s_3=4` | `C=1·2·3·4=24` | `-3` | `-72` |
| **total** | | | | **`-408`** |

Since `y3` and `x4` are each a `K`-linear combination of `L_{-n}`-words applied to the *same*
initial vector `α^μ_{-1}|0;p⟩`, and the `F(p)^{(1)}`-component-extraction map `Y ↦ Y^{(1)}` is
**linear** (it is projection onto a direct summand, Fact 0), the `F(p)^{(1)}`-component of
`y3(α^μ_{-1}|0;p⟩)` is the sum of the per-word contributions in the table, and likewise for
`x4`. Hence:

> **Lemma B.** For every `μ ∈ Fin D`, every `D`, every `η` with `hη`, every `p`:
> ```
> ( y3(α^μ_{-1}|0;p⟩) )^{(1)} =  30 · α^μ_{-4}|0;p⟩,
> ( x4(α^μ_{-1}|0;p⟩) )^{(1)} = -408 · α^μ_{-5}|0;p⟩.
> ```

**Computational cross-check.** `scripts/verify_leading_coefficient.py` computes, by brute-force
exact-rational Fock-space simulation (independent of the hand derivation above — it directly
expands `x4`/`y3` as literal operator words acting on `F(p)` and reads off coefficients), the
same `D×D` coefficient matrix and confirms it equals exactly `-408·Id_D` (`x4`) and `30·Id_D`
(`y3`) for `D ∈ {6,8,10,12}` (all "MATCHES Lemma A/B exactly"; rerun with
`python scripts/verify_leading_coefficient.py 6 8 10 12 20 26` to check more `D`, all pass).

## 4. Main theorem

> **Theorem.** For every `D`, `K` (`CharZero`), `η` with `hη`, and `p`, the maps
> `x4, y3 : F(p)_1 → F(p)`, restricted to codomains `F(p)_5, F(p)_4` respectively, are each
> injective. Consequently `S : F(p)_1 → F(p)_5×F(p)_4`, `S(u) = (x4u,y3u)`, is injective.

**Proof.** Let `u = Σ_{μ} c_μ α^μ_{-1}|0;p⟩ ∈ F(p)_1` (this spans `F(p)_1`, since the level-1
subspace is by definition spanned by the single-oscillator monomials) with `x4·u = 0`. By
linearity of `x4` and of the component-extraction map `(-)^{(1)}`:
```
0 = (x4u)^{(1)} = Σ_μ c_μ (x4(α^μ_{-1}|0;p⟩))^{(1)} = Σ_μ c_μ·(-408)·α^μ_{-5}|0;p⟩
  = -408 · Σ_μ c_μ α^μ_{-5}|0;p⟩         (Lemma B).
```
The vectors `{α^μ_{-5}|0;p⟩}_{μ=0}^{D-1}` are, by construction, `D` **distinct basis monomials**
of `F(p)^{(1)}_5` (they differ in the species index `μ`; Fact 0's monomial basis has these as
linearly independent elements) — this is again part of the definition of `F(p)` as a free Fock
module (brick `worldsheet.bosonic-fock-space`). Hence `-408·Σc_μα^μ_{-5}|0;p⟩ = 0` forces
`-408·c_μ = 0` for every `μ`. Since `K` has characteristic `0`, `-408 ≠ 0` in `K` (the integer
`-408` maps to a nonzero element under `ℤ → K`), so `c_μ = 0` for every `μ`, i.e. `u = 0`. This
proves `x4` is injective on `F(p)_1`. The identical argument with `30` in place of `-408`
(nonzero for the same reason) proves `y3` is injective on `F(p)_1`. Since `x4` alone is
injective, `S = (x4,y3)` is a fortiori injective (`S(u)=0 ⟹ x4u=0 ⟹ u=0`). ∎

**Specializing to the target.** Taking `p = p_{-6} = a-6b` (rung `j=-6`) recovers exactly the
`S₆`-injectivity on the whole slice `V_{-6,1}` needed in `claim.md` §2/§4; the argument never
used any property of `p` (not even `p·p ≠ 0`), so it applies verbatim to every rung and, in
fact, to every momentum whatsoever, not just DDF-admissible ones.

## 5. What bricks were actually used

- `worldsheet.bosonic-fock-space` (**formalized**): the free/monomial-basis structure of `F(p)`
  (Fact 0, the CCR used in Lemma 0, and the linear independence of `{α^μ_{-5}|0;p⟩}_μ` in §4).
- `worldsheet.fock-space-virasoro-representation` (**formalized**): that the Sugawara `L_n` are
  well-defined graded operators (Fact 1).
- `worldsheet.virasoro-generators-free-boson` (**formalized**): the Sugawara formula itself,
  used to define `L_n` in Lemma 0's proof and to define `x4, y3` as words in `L_{-n}`.

No node with `effective` status below `rigorous`/`formalized` is used anywhere in this proof.
`worldsheet.ddf-contour-equals-mode-sum` and
`worldsheet.physical-exponential-equals-voa-vertex-operator-v2` are not mentioned; DDF contour
integrals, vertex operators, and physicality/mass-shell conditions never appear — the entire
argument is internal Virasoro-mode combinatorics on the Fock space, exactly matching how `x4`
and `y3` are themselves *defined* (`SeedTransferSix.lean`, words in `towerLop`, no DDF content).

## 6. Honest assessment of remaining gaps

**No `[GAP]` markers remain in the mathematical argument.** Every step (Fact 0, Fact 1, Lemma
0, the sub-lemma, Lemma A, Lemma B, the main theorem) is proved in full, from the bare CCR +
Sugawara definitions, with no appeal to any `conjecture`/`physical-argument`-status fact, no
appeal to `D=26`, and no appeal to any property of the momentum `p`. The two potentially
delicate points that could have hidden a gap were both resolved explicitly rather than waved
through:

1. *Normal-ordering ambiguity in `L_n` for `n≠0`* — resolved in Lemma 0 Step 1 by observing the
   CCR commutator is identically zero whenever the two mode indices sum to `n≠0`, which holds
   automatically for every term of `L_n`'s defining sum when `n≠0` (and we only ever use
   `n∈{-1,-2,-3,-4}`).
2. *Whether `L_{-n}` applied to a "purely `r≥2`" vector could leak back down to `r≤1`* —
   resolved by the sub-lemma in §2, proved by a clean two-level induction (on the word length
   `j`, and inside that, on the oscillator count `r` of the monomial being expanded).

The only things this document does **not** do (by design/scope, not because they are unresolved
gaps in the mathematics):
- It does not write Lean code (no `formal/` access; §5 of `claim.md` records the seams for a
  future formalizer).
- It does not re-derive the "logical chain" bookkeeping of `claim.md` §4 (Step 1–5, connecting
  `S`-injectivity to `dim ker(seedPair(-6,6)) = D-1`); that bookkeeping is elementary linear
  algebra over already-proven Lean lemmas cited there, not new mathematics, and is recorded in
  `claim.md` rather than duplicated here.
- It does not attempt to upgrade the status of any graph node, nor does it create one.

## 7. Cross-checks performed

- `scripts/verify_leading_coefficient.py`: confirms Lemma B's `-408`/`30` constants by
  independent brute-force computation, `D ∈ {6,8,10,12}` (extendable).
- `scripts/verify_single_operator_injectivity.py`: confirms the Theorem's conclusion (`x4`
  alone and `y3` alone injective on `F(p)_1`) by independent brute-force rank computation,
  `D ∈ {3,4,5,6,7,10,26,27}`.
- `scripts/verify_s6_injectivity.py`: confirms the joint map `S6` is injective (nullity 0),
  `D ∈ {3,4,5,10,25,26,27,30}`.

All three scripts use independent code paths from the hand proof above (direct Fock-space
vector simulation with exact `fractions.Fraction` arithmetic, not symbolic manipulation of the
Lemma A/B recursion), so agreement across all tested `D` is a genuine cross-check, not a
tautology.
