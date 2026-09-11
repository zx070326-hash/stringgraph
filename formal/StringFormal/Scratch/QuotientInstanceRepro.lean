/-
# Minimal repro: `HasQuotient` synthesis fails for `Submodule R (ι →₀ R)`

Scratch file.  **Not** imported by `StringFormal.lean`; it proves nothing about string
theory.  It exists to pin down, against plain Mathlib, the elaboration failure described
in the "Elaboration note (a real Mathlib-level obstruction, not a style choice)" paragraph
of `StringFormal/NoGhost/TowerNull.lean`, which is why every tower-level quotient in that
file has to be routed through generic wrappers over an abstract module `M`.

Toolchain: Lean `4.33.1` (commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`),
Mathlib `v4.33.1` = rev `0df444a360eaa60ab8c11dca51a86af692955474` (from `lake-manifest.json`).
Verified 2026-09-11: the failure reproduces.

**The hypothesis recorded in `TowerNull.lean` is wrong and is corrected here.**  It says the
clash comes from `ℤ →₀ R` "also being an `AddMonoidAlgebra`".  In Mathlib `v4.33.1`
`AddMonoidAlgebra` is a one-field *structure* (`Mathlib/Algebra/MonoidAlgebra/Defs.lean:64`,
`structure AddMonoidAlgebra (R M) [Semiring R] where ofCoeff :: coeff : M →₀ R`), so it is
not even defeq to `ℤ →₀ R` and contributes no instances to it.  See §5 for the real cause.

There is no `sorry` in this file.  The failing cases are recorded with `#guard_msgs`, so the
file compiles exactly as long as the bug is still present; when Mathlib fixes it this file
will break, which is the intended alarm.

Companion writeup: `formal/MATHLIB-ISSUE-quotient-finsupp.md` (not filed upstream).
-/
import Mathlib

set_option autoImplicit false
set_option maxHeartbeats 1000000

/-! ## 1. The failure -/

/--
error: failed to synthesize instance of type class
  HasQuotient (↥p) (Submodule R ↥p)

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
-/
#guard_msgs(error, drop info) in
#check fun (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ R)) (q : Submodule R p) =>
  (p ⧸ q : Type)

-- Same failure with the coefficient ring `S` *different* from the scalar ring `R`.  This rules
-- out "scalars coincide with coefficients" as the cause; what matters is that the coefficients
-- are a ring (§5).
/--
error: failed to synthesize instance of type class
  HasQuotient (↥p) (Submodule R ↥p)

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
-/
#guard_msgs(error, drop info) in
#check fun (R S : Type) [CommRing R] [CommRing S] [Algebra R S]
    (p : Submodule R (ℤ →₀ S)) (q : Submodule R p) => (p ⧸ q : Type)

-- Index type is irrelevant (`ℕ` in place of `ℤ`), and iterating `Finsupp` does not help either
-- (`ℤ →₀ (ℤ →₀ R)` fails for the same reason: the inner `AddCommMonoid (ℤ →₀ R)` is itself not
-- in projected form).  Both checked; not repeated here to keep the file short.

/-! ## 2. Trace of the failure

`set_option trace.Meta.synthInstance true in` on the first `#check` above.  The search is short;
the two lines that matter are the `Submodule.hasQuotient` attempt and the `AddCommGroup ↥p`
subgoal it spawns, reproduced verbatim (indentation preserved, the `Ring R` subtree elided):

```
[Meta.synthInstance] ❌️ HasQuotient (↥p) (Submodule R ↥p)
  [Meta.synthInstance] ✅️ new goal HasQuotient _tc.1 (Submodule R ↥p)
    [Meta.synthInstance.instances] #[@Submodule.hasQuotient, @Ideal.instHasQuotient,
                                     @Ideal.instHasQuotient_1]
  [Meta.synthInstance.apply] ❌️ apply @Ideal.instHasQuotient_1 to HasQuotient ?m.10 (Submodule R ↥p)
    [Meta.synthInstance.tryResolve] ❌️ HasQuotient ?m.10 (Submodule R ↥p) ≟ HasQuotient ?m.12 (Ideal ?m.12)
  [Meta.synthInstance.apply] ❌️ apply @Ideal.instHasQuotient to HasQuotient ?m.10 (Submodule R ↥p)
    [Meta.synthInstance.tryResolve] ❌️ HasQuotient ?m.10 (Submodule R ↥p) ≟ HasQuotient ?m.12 (Ideal ?m.12)
  [Meta.synthInstance.apply] ❌️ apply @Submodule.hasQuotient to HasQuotient ?m.10 (Submodule R ↥p)
    [Meta.synthInstance.tryResolve] ❌️ HasQuotient ?m.10 (Submodule R ↥p) ≟ HasQuotient ?m.13 (Submodule ?m.12 ?m.13)
      [Meta.synthInstance] ✅️ Ring R
        ... (succeeds, result inst✝.toRing)
      [Meta.synthInstance] ❌️ AddCommGroup ↥p
        [Meta.synthInstance] ✅️ new goal AddCommGroup ↥p
          [Meta.synthInstance.instances] #[@SeminormedAddCommGroup.toAddCommGroup,
            @NormedAddCommGroup.toAddCommGroup, @AddSubgroupClass.toAddCommGroup,
            @AddCommGroupWithOne.toAddCommGroup, @NonUnitalNonAssocRing.toAddCommGroup,
            @Ring.toAddCommGroup, @LieRing.toAddCommGroup, @Submodule.addCommGroup]
        [Meta.synthInstance.apply] ❌️ apply @Submodule.addCommGroup to AddCommGroup ↥p
          [Meta.synthInstance.tryResolve] ❌️ AddCommGroup ↥p ≟ AddCommGroup ↥?m.23
```

So the proximate failure is **`AddCommGroup ↥p` is not synthesizable from inside the search**:
`@Submodule.addCommGroup` cannot be applied because `↥p ≟ ↥?m.23` fails.  Note that the very
same goal *does* succeed when asked at the top level (see §4), so this is a unification
problem, not a missing instance.
-/

/-! ## 3. Controls that succeed

All five of these elaborate.  They bracket the failure from every side. -/

section Controls

-- Abstract coefficient module: works.
#check fun (R : Type) [CommRing R] (M : Type) [AddCommGroup M] [Module R M]
    (p : Submodule R (ℤ →₀ M)) (q : Submodule R p) => (p ⧸ q : Type)

-- Same carrier `ℤ →₀ R`, but scalars `ℤ` instead of `R`: works.
#check fun (R : Type) [CommRing R] (p : Submodule ℤ (ℤ →₀ R)) (q : Submodule ℤ p) =>
  (p ⧸ q : Type)

-- `R` as a module over itself: works.
#check fun (R : Type) [CommRing R] (p : Submodule R R) (q : Submodule R p) => (p ⧸ q : Type)

-- The unbundled function type `ℤ → R` instead of `ℤ →₀ R`: works.
#check fun (R : Type) [CommRing R] (p : Submodule R (ℤ → R)) (q : Submodule R p) =>
  (p ⧸ q : Type)

-- `MvPolynomial ℕ R` (a structure wrapping `(ℕ →₀ ℕ) →₀ R`): works.
#check fun (R : Type) [CommRing R] (p : Submodule R (MvPolynomial ℕ R)) (q : Submodule R p) =>
  (p ⧸ q : Type)

end Controls

/-! ## 4. The instances that *are* found, printed explicitly

`set_option pp.explicit true` on the failing configuration gives (reformatted, the
`CommRing R → CommSemiring R → Semiring R` chain abbreviated as `‹…›`):

```
AddCommMonoid (ℤ →₀ R) = @Finsupp.instAddCommMonoid Int R (@Semiring.toAddCommMonoid R ‹…›)
AddCommGroup  (ℤ →₀ R) = @Finsupp.instAddCommGroup  Int R (@Ring.toAddCommGroup R ‹…›)
Module R (ℤ →₀ R)      = @Finsupp.module Int R R ‹…› (@Semiring.toAddCommMonoid R ‹…›)
                                                     (@Semiring.toModule R ‹…›)
AddCommMonoid ↥p       = @Submodule.addCommMonoid R (ℤ →₀ R) ‹…›
                            (@Finsupp.instAddCommMonoid Int R (@Semiring.toAddCommMonoid R ‹…›))
                            (@Finsupp.module …) p
AddCommGroup  ↥p       = @Submodule.addCommGroup R (ℤ →₀ R) ‹…›
                            (@Finsupp.instAddCommGroup Int R (@Ring.toAddCommGroup R ‹…›))
                            (@Finsupp.module …) p
```

and for the *working* abstract control `pM : Submodule R (ℤ →₀ M)`:

```
AddCommMonoid (ℤ →₀ M) = @Finsupp.instAddCommMonoid Int M (@AddCommGroup.toAddCommMonoid M ‹inst›)
AddCommMonoid ↥pM      = @Submodule.addCommMonoid R (ℤ →₀ M) ‹…›
                            (@Finsupp.instAddCommMonoid Int M (@AddCommGroup.toAddCommMonoid M ‹inst›))
                            (@Finsupp.module Int M R ‹…› (@AddCommGroup.toAddCommMonoid M ‹inst›) ‹inst›)
                            pM
```

These are live `#check`s, not comments (re-run with `set_option pp.explicit true` to see the
full terms): -/

section WhatIsFound

variable (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ R))

#check (inferInstance : AddCommMonoid (ℤ →₀ R))
#check (inferInstance : AddCommGroup (ℤ →₀ R))
#check (inferInstance : Module R (ℤ →₀ R))

-- Asked at the top level this **succeeds** (`Submodule.addCommMonoid …`), unlike inside the
-- `HasQuotient` search of §2.
#check (inferInstance : AddCommMonoid ↥p)

-- Likewise: `Submodule.addCommGroup …`.  Contrast the `❌️ AddCommGroup ↥p` in the trace.
#check (inferInstance : AddCommGroup ↥p)

end WhatIsFound

/-! ## 5. Root cause

`Submodule.addCommGroup` has signature

```
instance Submodule.addCommGroup {R M} [Ring R] [AddCommGroup M] [Module R M]
    (p : @Submodule R M _ (AddCommGroup.toAddCommMonoid ‹AddCommGroup M›) _) : AddCommGroup ↥p
```

— the `AddCommMonoid M` slot of the `Submodule` it accepts is *syntactically a projection*
`AddCommGroup.toAddCommMonoid ?G`.  To apply it to our `p`, the elaborator must solve

```
@Finsupp.instAddCommMonoid Int R (@Semiring.toAddCommMonoid R ‹…›)   -- what p actually has
  ≟  @AddCommGroup.toAddCommMonoid (ℤ →₀ R) ?G                        -- what the instance wants
```

for a metavariable `?G`, i.e. invert a structure projection.  That is what the trace records as
`AddCommGroup ↥p ≟ AddCommGroup ↥?m.23  ❌️`.

The decisive detail is **which `AddCommMonoid R` instance the `Finsupp` module structure got**.
Because `R` is a `CommRing`, typeclass search reaches the additive structure of `R` through the
*multiplicative* hierarchy, `Semiring.toAddCommMonoid`, not through `AddCommGroup.toAddCommMonoid`.
`Finsupp.instAddCommMonoid` and `Finsupp.instAddCommGroup` are separate `fast_instance%`
definitions (`Mathlib/Algebra/Group/Finsupp.lean` lines 358 and 501), so after that choice the two
sides are two different flattened structure literals.  They *are* defeq — `rfl` at default
transparency proves the two agree (see `defeq_at_default` below) — but `with_reducible rfl` does
not, and instance search never gets that far anyway: it is stuck on the metavariable `?G` under a
projection.

This explains every control in §3:

* `ℤ →₀ M` with abstract `[AddCommGroup M]`: the only `AddCommMonoid M` available *is*
  `AddCommGroup.toAddCommMonoid ‹inst›`, so the slot is already in projected form and `?G`
  is determined immediately.  ✅
* `Submodule ℤ (ℤ →₀ R)`: `Module ℤ _` is found via `AddCommGroup.toIntModule`, which again
  forces the `AddCommMonoid` slot into projected form.  ✅
* `Submodule R R` and `Submodule R (ℤ → R)`: no `Finsupp` `fast_instance%` layer sits between
  the projection and the `Ring R` structure, and the instance arguments of
  `Submodule.addCommGroup` get *synthesized* (`Ring.toAddCommGroup ‹inst›`) rather than left
  as metavariables, so the remaining check is concrete-against-concrete.  ✅
* `MvPolynomial ℕ R`: `AddMonoidAlgebra` is an opaque structure with its own hand-written
  `AddCommGroup`, so no competing route exists.  ✅

and the two extra failures noted in §1: `ℤ →₀ S` for an unrelated `CommRing S` fails (so it is not
about scalars coinciding with coefficients), and `ℤ →₀ (ℤ →₀ R)` fails (the inner
`AddCommMonoid (ℤ →₀ R)` is again not in projected form).

Corollary for `TowerNull.lean`: `AddMonoidAlgebra` is *not* the culprit (see the file header), and
neither are the pointwise ring instances of `Mathlib/Data/Finsupp/Pointwise.lean` — those do supply
`NonUnitalCommRing (ℤ →₀ R)` and hence a second route to `AddCommMonoid (ℤ →₀ R)`, but the trace
shows search never takes it, and they are present in the *working* `Submodule ℤ (ℤ →₀ R)` control
too.  The culprit is the projection-shaped `AddCommMonoid` slot of `Submodule.addCommGroup` against
a `Finsupp` monoid structure built from `Semiring.toAddCommMonoid`. -/

section RootCauseEvidence

namespace StringFormal.Scratch

-- The two routes to `AddCommMonoid (ℤ →₀ R)` are definitionally equal at default transparency …
theorem defeq_at_default (R : Type) [CommRing R] :
    @AddCommGroup.toAddCommMonoid (ℤ →₀ R) inferInstance
      = (inferInstance : AddCommMonoid (ℤ →₀ R)) :=
  rfl

-- … and the same holds one level down, at the submodule.
theorem defeq_at_default_sub (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ R)) :
    @AddCommGroup.toAddCommMonoid ↥p inferInstance = (inferInstance : AddCommMonoid ↥p) :=
  rfl

-- `with_reducible rfl` fails for both of these.  (It also fails in the *working* abstract-`M`
-- case, so reducible transparency alone is not what separates success from failure; instance
-- search uses `.instances` transparency and, more importantly, never reaches a defeq check
-- here at all — it fails at the projection-inversion step.)

end StringFormal.Scratch

end RootCauseEvidence

/-! ## 6. Workarounds -/

-- (a) The instance term itself is fine; only the *search* fails.  Note the `_ _ _`: the explicit
-- placeholders force Lean to *synthesize* the three instance arguments, producing concrete terms,
-- after which the defeq check against `p`'s instances succeeds at default transparency.  Writing
-- the bare `Submodule.hasQuotient` instead leaves them as metavariables and reproduces the
-- original failure, now as a type mismatch:
--   has type      HasQuotient ?m (@Submodule ?r ?m Ring.toSemiring AddCommGroup.toAddCommMonoid ?i)
--   but expected  HasQuotient ↥p (@Submodule R ↥p CommRing.toCommSemiring.toSemiring
--                                   p.addCommMonoid p.module)
-- That mismatch is the root cause of §5 stated as a unification problem, with no search involved.
#check fun (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ R)) =>
  (@Submodule.hasQuotient R ↥p _ _ _ : HasQuotient ↥p (Submodule R ↥p))

-- (b) The workaround actually used in `NoGhost/TowerNull.lean`: state everything for an abstract
-- module `M` and instantiate at `M := ℤ →₀ Fock D R` afterwards, so the search of §2 never runs.
-- This is the `StringFormal.QuotRadical` / `StringFormal.quotRadicalForm` design.
example (R : Type) [CommRing R] (M : Type) [AddCommGroup M] [Module R M]
    (p : Submodule R M) (q : Submodule R p) : Type :=
  p ⧸ q

/-
(c) Not a workaround: even with (a) in scope, downstream `Submodule.liftQ` applications have to
unfold the mismatched instances at `whnf` and diverge.  Reported by `formalizer-noghost-c`; not
re-measured here because (b) removes the need.
-/
