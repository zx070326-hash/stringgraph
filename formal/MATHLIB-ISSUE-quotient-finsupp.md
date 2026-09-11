# Mathlib issue draft: `HasQuotient` synthesis fails for `Submodule R (ℤ →₀ R)`

**Status: draft, NOT filed.** Filing is the captain's call. Everything below is reproduced
against a stock Mathlib checkout; nothing here depends on `StringFormal`.

Repro file: `formal/StringFormal/Scratch/QuotientInstanceRepro.lean` (compiles clean; the
failure is pinned with `#guard_msgs`, so the file breaks the moment Mathlib fixes this).

---

## Title

`Submodule.hasQuotient` is not found for a submodule of `ι →₀ R` when `R` is the scalar ring
(`AddCommGroup ↥p` unsynthesizable inside the search)

## Versions

| | |
|---|---|
| Lean | `4.33.1`, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`, `x86_64-w64-windows-gnu` |
| Mathlib | tag `v4.33.1`, rev `0df444a360eaa60ab8c11dca51a86af692955474` |
| Date checked | 2026-09-11 |

## Minimal reproduction

```lean
import Mathlib

-- fails
example (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ R)) (q : Submodule R p) : Type :=
  p ⧸ q
```

```
error: failed to synthesize instance of type class
  HasQuotient (↥p) (Submodule R ↥p)
```

Same failure, same message, for:

```lean
-- coefficient ring different from the scalar ring: still fails
example (R S : Type) [CommRing R] [CommRing S] [Algebra R S]
    (p : Submodule R (ℤ →₀ S)) (q : Submodule R p) : Type := p ⧸ q

-- index type irrelevant
example (R : Type) [CommRing R] (p : Submodule R (ℕ →₀ R)) (q : Submodule R p) : Type := p ⧸ q

-- iterated Finsupp: still fails
example (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ (ℤ →₀ R))) (q : Submodule R p) : Type :=
  p ⧸ q
```

## Expected

`p ⧸ q` elaborates, as it does for every neighbouring case.

## Actual

Synthesis fails. It fails *only* here: all of the following elaborate.

```lean
-- abstract coefficient module: OK
example (R : Type) [CommRing R] (M : Type) [AddCommGroup M] [Module R M]
    (p : Submodule R (ℤ →₀ M)) (q : Submodule R p) : Type := p ⧸ q

-- same carrier ℤ →₀ R, scalars ℤ: OK
example (R : Type) [CommRing R] (p : Submodule ℤ (ℤ →₀ R)) (q : Submodule ℤ p) : Type := p ⧸ q

-- R as a module over itself: OK
example (R : Type) [CommRing R] (p : Submodule R R) (q : Submodule R p) : Type := p ⧸ q

-- unbundled functions instead of Finsupp: OK
example (R : Type) [CommRing R] (p : Submodule R (ℤ → R)) (q : Submodule R p) : Type := p ⧸ q

-- MvPolynomial: OK
example (R : Type) [CommRing R] (p : Submodule R (MvPolynomial ℕ R)) (q : Submodule R p) : Type :=
  p ⧸ q
```

## Trace

`set_option trace.Meta.synthInstance true`. The search is short; the decisive lines:

```
[Meta.synthInstance] ❌️ HasQuotient (↥p) (Submodule R ↥p)
  [Meta.synthInstance] ✅️ new goal HasQuotient _tc.1 (Submodule R ↥p)
    [Meta.synthInstance.instances] #[@Submodule.hasQuotient, @Ideal.instHasQuotient, @Ideal.instHasQuotient_1]
  [Meta.synthInstance.apply] ❌️ apply @Submodule.hasQuotient to HasQuotient ?m.10 (Submodule R ↥p)
    [Meta.synthInstance.tryResolve] ❌️ HasQuotient ?m.10 (Submodule R ↥p) ≟ HasQuotient ?m.13 (Submodule ?m.12 ?m.13)
      [Meta.synthInstance] ✅️ Ring R
      [Meta.synthInstance] ❌️ AddCommGroup ↥p
        [Meta.synthInstance.apply] ❌️ apply @Submodule.addCommGroup to AddCommGroup ↥p
          [Meta.synthInstance.tryResolve] ❌️ AddCommGroup ↥p ≟ AddCommGroup ↥?m.23
```

Note `AddCommGroup ↥p` *does* succeed when asked on its own (`#check (inferInstance : AddCommGroup ↥p)`
returns `Submodule.addCommGroup …`). It is only unsynthesizable in the metavariable context
created by `Submodule.hasQuotient`.

## Root-cause hypothesis

With `pp.explicit`, the instances attached to `p` are

```
AddCommMonoid (ℤ →₀ R) = @Finsupp.instAddCommMonoid Int R (@Semiring.toAddCommMonoid R ‹…›)
AddCommGroup  (ℤ →₀ R) = @Finsupp.instAddCommGroup  Int R (@Ring.toAddCommGroup   R ‹…›)
Module R (ℤ →₀ R)      = @Finsupp.module Int R R ‹…› (@Semiring.toAddCommMonoid R ‹…›) (@Semiring.toModule R ‹…›)
```

`Submodule.addCommGroup` accepts a submodule whose `AddCommMonoid` slot is *syntactically* the
projection `AddCommGroup.toAddCommMonoid ?G`. Applying it therefore requires solving

```
@Finsupp.instAddCommMonoid Int R (@Semiring.toAddCommMonoid R ‹…›)
  ≟  @AddCommGroup.toAddCommMonoid (ℤ →₀ R) ?G
```

for the metavariable `?G` — inverting a structure projection through a `fast_instance%`
definition. That is the `≟ AddCommGroup ↥?m.23  ❌️` line.

The trigger is which `AddCommMonoid R` instance ends up inside `Finsupp.module`. Because `R` is a
`CommRing`, search reaches the additive structure of `R` through the **multiplicative** hierarchy
(`Semiring.toAddCommMonoid`), not through `AddCommGroup.toAddCommMonoid`. `Finsupp.instAddCommMonoid`
and `Finsupp.instAddCommGroup` are two independent `fast_instance%` definitions
(`Mathlib/Algebra/Group/Finsupp.lean:358` and `:501`), so the two sides become two different
flattened structure literals. They *are* definitionally equal — `rfl` at default transparency
proves

```lean
example (R : Type) [CommRing R] :
    @AddCommGroup.toAddCommMonoid (ℤ →₀ R) inferInstance = (inferInstance : AddCommMonoid (ℤ →₀ R)) :=
  rfl          -- succeeds
```

(and `with_reducible rfl` fails) — but instance search never reaches a defeq check, it is stuck on
`?G` under a projection.

This accounts for every control above:

* abstract `M`: the only `AddCommMonoid M` is `AddCommGroup.toAddCommMonoid ‹inst›`, so the slot is
  already in projected form and `?G` is determined at once;
* scalars `ℤ`: `Module ℤ _` is found via `AddCommGroup.toIntModule`, forcing the same projected form;
* `Submodule R R`, `Submodule R (ℤ → R)`: no `Finsupp` `fast_instance%` layer between the projection
  and the `Ring R` structure, and the instance arguments of `Submodule.addCommGroup` get synthesized
  rather than unified, so the residual check is concrete-against-concrete;
* `MvPolynomial ℕ R`: `AddMonoidAlgebra` is an opaque structure with its own `AddCommGroup`;
* `ℤ →₀ S` for an unrelated `CommRing S` fails, and `ℤ →₀ (ℤ →₀ R)` fails — so the trigger is not
  "scalars coincide with coefficients" but "the `AddCommMonoid` of the coefficient type is not found
  in the form `AddCommGroup.toAddCommMonoid _`".

A sharper confirmation that nothing is mathematically wrong, only the *search*: supplying the three
instance arguments as `_` (which makes Lean **synthesize** them, yielding concrete terms) typechecks,

```lean
example (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ R)) :
    HasQuotient ↥p (Submodule R ↥p) :=
  @Submodule.hasQuotient R ↥p _ _ _        -- OK
```

whereas the bare instance name, which leaves them as metavariables, does not:

```lean
example (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ R)) :
    HasQuotient ↥p (Submodule R ↥p) :=
  Submodule.hasQuotient                    -- type mismatch
```
```
has type
  HasQuotient ?m (@Submodule ?r ?m Ring.toSemiring AddCommGroup.toAddCommMonoid ?i)
but is expected to have type
  HasQuotient ↥p (@Submodule R ↥p CommRing.toCommSemiring.toSemiring p.addCommMonoid p.module)
```

This is the root cause with the search stripped away: `AddCommGroup.toAddCommMonoid ?G` against
`p.addCommMonoid`.

### Two hypotheses that are *wrong* (recorded because our own notes had them)

1. **"`ℤ →₀ R` is also an `AddMonoidAlgebra`."** False in `v4.33.1`: `AddMonoidAlgebra` is a
   one-field structure (`Mathlib/Algebra/MonoidAlgebra/Defs.lean:64`), not a type synonym, so it
   contributes no instances to `ℤ →₀ R`. This was the explanation written in
   `formal/StringFormal/NoGhost/TowerNull.lean`; it has been superseded by the above.
2. **The pointwise ring instances.** `Mathlib/Data/Finsupp/Pointwise.lean` does give
   `NonUnitalCommRing (ℤ →₀ R)` (Hadamard product) and hence a second route to
   `AddCommMonoid (ℤ →₀ R)`. But the trace shows search never takes it, and the abstract-`M`
   control (where those instances are absent) is not what distinguishes success from failure —
   the `ℤ`-scalars control is, and it keeps the pointwise instances. So they are a latent diamond,
   not this bug.

## Possible fixes (for maintainers; not attempted here)

* Make `Finsupp.instAddCommMonoid` on a ring-valued `Finsupp` agree syntactically with the monoid
  projection of `Finsupp.instAddCommGroup`, e.g. by defining the group instance to *extend* the
  monoid one rather than by an independent `fast_instance%` construction.
* Or add `Submodule.instHasQuotient`-style instances keyed on `AddCommMonoid` + a separate
  `AddCommGroup` side condition, so that the `AddCommMonoid` slot is not in projection form.

Neither is something this project should push; the first is a Mathlib design change.

## Our workaround

Prove everything for an abstract `[AddCommGroup M] [Module R M]` and instantiate at
`M := ℤ →₀ Fock D R` afterwards, so the search never runs. This is exactly why
`StringFormal.radicalIn` / `StringFormal.QuotRadical` / `StringFormal.quotRadicalForm` in
`formal/StringFormal/NoGhost/TowerNull.lean` are stated for a variable module rather than for the
tower directly, and why tower-level statements must go through `QuotRadical.mk` instead of bare
`Submodule.Quotient.mk`.

Cost to us: one extra layer of generic wrappers, no mathematical content lost.
