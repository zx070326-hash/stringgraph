/-
# No-ghost theorem (Goddard–Thorn): statement file

Graph node: `worldsheet.no-ghost-theorem`
Milestone:  `ms.no-ghost-theorem`

## Scope of this file

Only the *statement* lives here, and only once the ingredients exist:

1. `StringFormal.Fock`   – Fock space of `D` free bosons (not yet written)
2. `StringFormal.Virasoro.Sugawara` – `L n` acting on Fock space, `c = D`
3. `StringFormal.NoGhost.PhysicalStates` – `H_phys` as a submodule
4. `StringFormal.NoGhost.DDF` – DDF operators and the transverse Fock space

The theorem is to be declared as `StringFormal.NoGhost.no_ghost_theorem`.
Until the ingredients exist, this file intentionally contains **no theorem
statement** rather than a `sorry`-ed one: a `sorry`-ed statement would let the
graph tool believe a Lean declaration exists.

See `formal/TODO.md` for the decomposition.
-/

import StringFormal.Virasoro.Basic

namespace StringFormal.NoGhost

-- intentionally empty: see header

end StringFormal.NoGhost
