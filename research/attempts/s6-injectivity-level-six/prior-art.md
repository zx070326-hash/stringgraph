# Prior-art gate for S6-injectivity-level-six

Status: **CLEARED — no equivalent lemma found in the checked literature.** Proceeding to
`claim.md` / `proof.md`.

## Target claim being checked for prior art

Let `x4, y3 ∈ U(Vir⁻)` be the two singular-vector words at `h = -4, c = 26`
(`y3 = 12L₋₃ + 6L₋₂L₋₁ + L₋₁³`, `x4 = -76L₋₄ -52L₋₃L₋₁ -12L₋₂² -20L₋₂L₋₁² -3L₋₁⁴`,
satisfying `L₋₁x4 + (2L₋₂+3L₋₁²)y3 = 0`). Fix a free-boson Fock space realization at momentum
`p` on rung `j = -6` (`p·p = -10`). The question is:

> Is the map `S6 : u ↦ (x4·u, y3·u)`, from the **whole** level-1 slice `V_{-6,1}`
> (dimension `D`, no seed/annihilation condition on `u`) into
> `V_{-6,5} × V_{-6,4}`, injective?

This is an internal bookkeeping lemma inside a specific counting architecture
(`descPair`/`seedPair`, bigrade `(rung, level)` slices, `κ_N` from the Euler pentagonal-number
theorem) that was **built from scratch inside this project's own Lean formalization**
(`formal/StringFormal/NoGhost/DescendantKernel.lean`, `LevelSixCount.lean`,
`SeedCriterionSix.lean` — see `formal/BLUEPRINT-noghost.md` §B⁗). This architecture is not
itself taken from any single paper (see "assessment" below). The prior-art question is
narrower and more honest than "has the no-ghost theorem been proved" (yes, many times over,
since 1972): it is "does any published proof of the no-ghost theorem, or any published
structural result about Virasoro Verma-module/Feigin–Fuchs singular vectors, already contain
an equivalent injectivity statement for a map built from a PAIR of singular-vector operators
applied to a whole intermediate weight space (not just to the highest-weight line)?"

## Sources checked (with what was actually found)

### 1. Goddard–Thorn 1972 (Phys. Lett. B 40 (1972) 235) and the "K/S split" proof architecture

Checked via `WebSearch` (two independent queries) plus the summary in Polchinski/standard
secondary literature already cited throughout this project's blueprint. The GT proof
structure is:
- basis `|{λ,μ}f⟩ = L₋₁^{λ₁}⋯L₋ₘ^{λₘ} K₋₁^{μ₁}⋯K₋ₘ^{μₘ}|f⟩` (transverse DDF part `f`, times
  words in `L₋ₙ` and the **longitudinal** operators `K₋ₙ = k₀·α₋ₙ`);
- split `𝓗 = 𝓢 ⊕ 𝓚` (spurious states `𝓢` = at least one `λᵢ≠0`, transverse-generated `𝓚` = all
  `λᵢ=0`);
- **at `c=26`** the positive Virasoro modes preserve `𝓢` and `𝓚` separately, so a physical
  state's `𝓚`-part is itself primary and transverse, giving non-negative norm.

This is a **completely different architecture** from the one used here. It never isolates a
map `u ↦ (x4 u, y3 u)` on a bare weight-space slice; the level-4 singular vectors `x4, y3` are
not named objects in this proof at all — the `L₋₂+3L₋₁²`-type "spurious" combination is
absorbed directly into the `𝓢/𝓚` decomposition via the longitudinal `K` operators, not via a
joint-kernel/counting argument. **No match.**

### 2. Brower 1972 (Phys. Rev. D 6 (1972) 1655) — independent DDF+longitudinal construction

Per the same search summaries (corroborated by the standard historical account, e.g. Goddard's
1988 "Early history" recollection, and the nLab/Wikipedia Goddard–Thorn theorem pages fetched
directly): Brower's proof uses DDF operators together with a **different** family of
longitudinal operators to show the physical Hilbert space is spanned, with the `d=26` case
special because the longitudinal operators produce null states directly. Again a
spanning-of-the-whole-space argument, not a two-singular-vector joint-injectivity lemma on a
fixed weight-space slice. **No match.**

### 3. Thorn, later refinements: Thorn 1985 ("A Proof of the No-Ghost Theorem Using the Kac
   Determinant", in *Vertex Operators in Mathematics and Physics*, MSRI Publ. 3, Springer),
   Thorn Nucl. Phys. B286 (1987) 61, Thorn Phys. Rept. 175 (1989) 1

These are the closest in *spirit* to the counting/rank-nullity architecture used in this
project (Kac determinant ⇒ dimension counts), located via `WebSearch`. The 1985 abstract
(as returned by search) states only: "A new proof of the no-ghost theorem for dual resonance
models using results of Kac on infinite dimensional Lie algebras is presented" — i.e. it uses
the **Kac determinant formula** (vanishing/non-vanishing of the Shapovalov determinant) to
control dimensions of physical-state spaces, not a two-generator joint map on an
intermediate slice. The 1987 Nucl. Phys. B paper is described (via search summary) as finding
"an efficient basis for string state space and a self-contained proof ... of the linear
independence of the basis elements" — again a basis/spanning argument, not the
`descPair`/`seedPair` kernel-counting structure. I was not able to fetch the full text of
either paper through the available tools (no open-access PDF surfaced; MSRI volume and Nucl.
Phys. B are paywalled/not indexed on arXiv, this predates the arXiv). This is a genuine
**residual gap in the search** (see "Caveats" below), but the abstract-level description gives
no indication of a two-family joint injectivity lemma, and Thorn's dimension-counting is at
the level of a single Kac determinant per weight, not a rank-nullity argument on a pair map.
**No match found in available secondary sources; primary text not obtained.**

### 4. Gebert–Nicolai (CMP paper "On E10 and the DDF construction", plus "E10 for beginners",
   Lect. Notes Phys. 447) — §3–4 DDF/spanning argument

Located via `WebSearch`. This paper's actual subject is using the DDF construction to
characterize root spaces of the hyperbolic Kac–Moody algebra `E10` (level-1 root spaces fully
characterized by transversal DDF states; **longitudinal DDF states appear beyond level one**,
requiring "a rational extension of the self-dual root lattice" and non-summable vertex
operators to handle a level-2 root space of dimension 53). This is a **Lorentzian-lattice**
DDF/spanning computation for a completely different target (root multiplicities of `E10`, not
the bosonic-string no-ghost theorem's physical-state count), and again does not construct or
use a two-singular-vector joint map of the `S6` type. **No match.** (I could not locate the
specific "§3–4" the task description points to — the CMP paper's actual section numbering was
not recoverable through search summaries alone; see caveat below.)

### 5. Frenkel–Lepowsky–Meurman (*Vertex Operator Algebras and the Monster*) and Borcherds
   (1986 VOA paper; 1990 "The monster Lie algebra", Adv. Math. 83; 1992 "Monstrous moonshine
   and monstrous Lie superalgebras", Invent. Math. 109)

These establish the no-ghost theorem in the VOA/vertex-algebra language (physical states =
BRST cohomology of the Virasoro-plus-ghost complex), used by Borcherds to construct the Monster
Lie algebra from the moonshine module. The proof route here is BRST-cohomological (semi-infinite
cohomology vanishing outside degree 0), not a Fock-space kernel-counting argument over
`descPair`/`seedPair`. Nothing resembling `S6`-type injectivity surfaced in the search
summaries or the Wikipedia "Goddard–Thorn theorem" page (fetched directly, see below). **No
match** (full FLM book text not fetched — see caveat).

### 6. Kac / Feigin–Fuchs Virasoro Verma-module embedding literature

Located via `WebSearch` (query on Feigin–Fuchs classification and Verma embeddings). Key facts
surfaced, all classical and NOT specific to this claim:
- Feigin–Fuchs give the existence criterion for singular vectors (`h = h_{r,s}(t)`) and the
  full classification of embedding patterns (six types) between Virasoro Verma modules.
- At a given level, a Verma module has **at most one** singular vector up to scalar (hence the
  well-known fact used throughout this project's own blueprint that `x4, y3` together with the
  identity that `10 x4 = (some word) related to y3` etc. reduce to a 1-dimensional space of
  singular vectors PER FAMILY at generic `c`, with `c=26,h=-4` being the exactly-two-family
  degenerate point governed by the syzygy `L₋₁x4+𝒟₂y3=0`).
- Verma-to-Verma module homomorphisms have `dim Hom ≤ 1`, and (per the search summary,
  attributed to Verma's original structure theorem and its use in BGG-type resolutions,
  e.g. Felder's Coulomb-gas construction of a Virasoro BGG complex) a **nonzero morphism of
  Verma modules is injective**.

**This last fact is the closest genuine hit and needs to be addressed explicitly** because it
sounds superficially similar. It is NOT the same claim, for two independent reasons:
  (a) It is a statement about a map **out of a full Verma module** `V(c,h')` (i.e. `U(n⁻)`
      applied to the single highest-weight line), sending the highest-weight vector to a
      *fixed* singular vector `w`. My claim is about a map **out of a fixed weight-space slice
      of level 1**, `V_{-6,1}` (dimension `D`, spanned by `{α^μ_{-1}v}`), which is not a highest
      weight line and is not `V_{-6,1}` — the Fock-space object here is a *concrete tensor
      realization* at fixed momentum `p_{-6}`, not an abstract Verma module; `x4, y3` are
      applied to a *generic level-1 descendant*, not to the primary vector itself. The two
      statements are logically independent: neither implies the other (the classical fact says
      nothing about what happens when the operator is applied one level up from the h.w.
      vector, and conversely says nothing about the *joint* kernel of two independent
      operators).
  (b) Even granting (a), the classical fact is single-operator (`x4` alone, or `y3` alone,
      mapping `V(c,h')→V(c,h)` under the standard Verma-embedding reading), not the
      **pair** map `u ↦ (x4u, y3u)` that this task is about; and it is stated for `c,h`
      generic/arbitrary (wherever a singular vector exists), whereas the present target is
      specifically about the free-boson Fock-space realization at `c=D=26` acting on a
      `D`-dimensional slice.

No source checked constructs, or needs to construct, the map `S6` or anything with its
`(descPair, seedPair, κ_N)` bookkeeping. That machinery (Euler-pentagonal-number counting of
`κ_N`, the `(rung,level)` double grading `towerBigrade`, the `descPair`/`seedPair` linear maps)
is native to this project's own Lean formalization (see `formal/BLUEPRINT-noghost.md` §B⁗,
which documents it being *built*, not *extracted from a paper*, across PR9a/PR9b and the
`LevelFiveCount.lean`/`LevelSixCount.lean` files). It would be a category error to expect a
1970s–1990s physics paper to contain a lemma phrased in these exact terms.

## Caveats (honest gaps in this search)

- I did **not** obtain the full text of Thorn 1985/1987/1989 or the Gebert–Nicolai CMP paper's
  §3–4 (no open-access copy surfaced via `WebSearch`/`WebFetch` in the time available; MSRI
  volumes and pre-arXiv Nucl. Phys. B papers are frequently paywalled). I checked abstracts and
  multiple independent secondary summaries (search-engine synthesis across several queries)
  instead of the primary PDF pages for these two specific items. Per the project's hard
  constraint #2 ("any formula used as a load-bearing basis for a decision must be verified by
  Reading the actual page image"), I am **not** using anything from these two sources as a
  load-bearing brick in `proof.md` — they are cited here only as due-diligence prior-art checks
  that turned up no contrary or overlapping result at the abstract/summary level, not as
  bricks in the proof itself. If a reviewer can obtain these documents, re-checking them
  against the specific "two-family joint injectivity" phrasing above is the natural follow-up.
- FLM's book and Borcherds' two papers were only checked via reference lists / secondary
  discussion, not full text.

None of these caveats change the conclusion for the purpose of this gate: at the level of
every abstract, summary, and secondary account obtained, **no source describes, uses, or needs
an injectivity statement of the `S6` type**, and the specific counting/bookkeeping objects in
the target claim (`descPair`, `seedPair`, bigraded slices `V_{j,N}`, `κ_N`) do not appear
anywhere in the literature searched — they are internal to this project's own prior Lean work.

## Verdict

**Gate cleared.** This is genuine original-proof territory, not literature extraction.
Proceeding to `claim.md` and `proof.md`.
