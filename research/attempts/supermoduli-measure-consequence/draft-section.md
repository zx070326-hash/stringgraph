# draft-section.md — weldable paragraph(s) on the physical consequence of Theorem M

**Status of this file**: written by a `theorem-prover` attempt
(`research/attempts/supermoduli-measure-consequence/`), **not** part of `paper.md`. It is offered as
a directly weldable section — English, paper register, notation consistent with `paper.md` — should
the project (i.e. the lead / a future curator or editorial pass) decide the paper should say anything
about physical consequences. Placement suggestion: a new §9.5, after §9.4 and before §10, continuing
the "consistency checks" numbering; alternatively a short paragraph appended to §1.4. No claim is made
here about whether it *should* be welded in — that editorial decision belongs to whoever owns
`paper.md`, not to this attempt.

Two new citation keys are used that do not exist in `paper.md`'s reference list: **[EW]** for
E. Witten, *Superstring Perturbation Theory Revisited*, arXiv:1209.5461, and **[DP]** for
E. D'Hoker and D.H. Phong, the six-paper *Two-Loop Superstrings* series (hep-th/0110247, 0110283,
0111016, 0111040, 0501196, 0501197) together with its review, *Lectures on Two-Loop Superstrings*,
hep-th/0211111. Both would need entries added to the reference list, and — per this project's own
`literature/` discipline — registered in `literature/sources.bib` with extraction records, before any
external use; [EW] is already extracted at
`literature/extractions/witten-2012-superstring-perturbation.md` (not yet in `literature/sources.bib`
as a bib key, which is a separate registration step).

---

### 9.5 Remark: relation to the superstring-perturbation-theory measure

Theorem M is a statement about the geometry of $\overline{\mathfrak S}_{g;n,2r}$ and carries no
physical content on its own; this remark records, for the reader who arrives at this paper from the
physics side, exactly what it does and does not say about the construction of the superstring measure.

If $\overline{\mathfrak S}_{g;n,2r}$ (or the uncompactified locus $\mathfrak S_{g;n,2r}$) were
projected, one available strategy for defining a genus-$g$ scattering amplitude with $n$ NS and $2r$
Ramond external legs would be to fix a global retraction onto the bosonic truncation and integrate
fibrewise along it. Theorem M shows this strategy is unavailable **for the compactified stack, over
its full range**: for every $g\ge3$ (any $n,r$), and for $g=2$ whenever $n+2r\ge2$, no such retraction
exists.

This is a narrower statement than it may first appear, for a reason that follows directly from the
definitions. If $\mathfrak X$ is projected via a global splitting $r^\#$ of $\mathcal O_{\mathfrak X}
\twoheadrightarrow\mathcal O_X$, then for any open $U\subset X$ the restriction $r^\#|_U$ is again a
splitting, so the open substack $\mathfrak X|_U$ is projected. Equivalently, non-projectedness of
$\mathfrak X$ places **no constraint** on whether any given open substack — in particular the smooth
locus $\mathfrak S_{g;n,2r}\subset\overline{\mathfrak S}_{g;n,2r}$, or any single coordinate patch
used in a local construction — is itself projected. Donagi and Witten record the same fact for their
own (uncompactified) theorem, in the converse direction: "Asking for the compactification to be
projected would only be a stronger condition" [DW, Remark 1.4]. Theorem M's non-vanishing obstruction
class is, in fact, detected on a test curve lying inside the boundary divisor $\Delta_{\rm NS}$ (§5–§6
above), so this is not merely a logical possibility left open by the definitions but the literal
geometric content of the proof: the obstruction is supported on the boundary and certifies nothing
about the interior.

Consequently, Theorem M is consistent with, and cannot obstruct, any measure construction — such as
the rigorous "vertical integration" method of [EW] — that proceeds by local patches on
$\mathfrak S_{g;n,2r}$ glued across boundary strata, rather than by a single global retraction of the
compactified stack. In particular it is consistent with the historical success of the genus-2
construction of D'Hoker and Phong [DP], which lies numerically inside Theorem M's range — the explicit
four-point ($n=4$) computation of [DP, papers V–VI] satisfies $(g,n,r)=(2,4,0)$, inside Corollary A2 —
because that construction is a statement about, and makes use of, projectedness of the
**uncompactified** locus "in low orders," a fact Witten attributes explicitly to the D'Hoker–Phong
program [EW, §3.3.2]: "Supermoduli space is holomorphically projected in low orders and this fact has
been exploited in explicit computations, especially in [D'Hoker–Phong]." Theorem M says nothing about
that locus, in either direction.

What Theorem M rules out, unconditionally, is a hypothetical strategy that current rigorous
constructions do not in fact use: a single global holomorphic retraction of the **compactified**
moduli space, valid on the interior and on every boundary stratum simultaneously, which would have
offered a shortcut for treating degeneration limits (needed for factorization and IR consistency
checks) without the patchwise machinery of [EW]. No such shortcut is available already at $g=2$ with
as few as two external legs — a regime that includes the lowest-genus, lowest-point-count string
amplitudes of physical interest — and, by Corollary A, remains unavailable for **every** number of NS
punctures at $g\ge3$, with no coupling between the puncture count and the genus threshold. This last
point sharpens an expectation Donagi and Witten record but do not prove for the uncompactified case:
discussing why their own punctured theorem is capped at $n\le g-1$, they remark that for $n\gg g$
"requiring the $n$ points to be distinct very likely kills the obstructions to splitness, though we
would expect the compactification of $\mathfrak M_{g,n}$ to be non-split" [DW, Remark 1.5]. Theorem M
establishes, rigorously and with no upper bound on $n$, the compactified half of exactly this
expectation, in a regime reaching far beyond [DW]'s own $n\le g-1$ ceiling.

We emphasise, to avoid overstatement, what is *not* claimed. Theorem M does not identify any new
obstruction to the validity of superstring perturbation theory; on that point we can do no better than
quote Donagi–Witten's own assessment of their unpunctured, uncompactified result, which applies with
equal force here: "The validity of superstring perturbation theory does not depend on a projection"
[DW, §1]. Nor does Theorem M explain, retroactively, any historical difficulty in constructing explicit
higher-genus measures; the well-documented obstacles to extending the ansatz-based program of
[Cacciatori–Dalla Piazza–van Geemen] and others beyond genus $4$ are internal inconsistencies among
modular-form constraints, unrelated in method and in chronology to the projectedness results of [DW]
and this paper.

---

## Notes for whoever welds this in (not part of the weldable text above)

- The paragraph "We emphasise... any historical difficulty..." names the ansatz program without a
  citation key; `research/attempts/genus-five-supermeasure/proof.md` §2.1 is this project's own
  (unpublished, internal) investigation supporting that claim, not a citable external source — if this
  section is welded in, that sentence needs either a proper external citation
  (Grushevsky–Salvati Manni, arXiv:0809.1391; Dunin-Barkowski–Sleptsov–Stern, arXiv:1208.2324) added
  through the normal `literature/` registration process, or should be cut. It is included here only
  because the mandatory self-check surfaced it as directly relevant context, not because this attempt
  has independently verified those papers (see `argument.md` §5 item 2 and the genus-five-supermeasure
  attempt's own `⟨lit, 待核⟩` labelling of the same material).
- [EW] needs a `literature/sources.bib` key (extraction already exists); [DP] needs both a
  `literature/sources.bib` key and a `literature/extractions/` record — none of the six D'Hoker–Phong
  papers has been individually extracted by this project (checked: zero hits in
  `literature/sources.bib` and `literature/extractions/` for "D'Hoker" or "Phong"). This attempt used
  `WebSearch`-level verification only for their scope (arXiv IDs, titles, which paper covers which
  $(g,n)$); no formula from those papers is used as a premise anywhere in `argument.md`. Before this
  section could be welded into a submission-track paper, at minimum the abstract of [DP, Paper II]
  (the "projection onto super-period matrices" quotation) should be upgraded to a page-image-verified
  extraction.
- This section makes no claim about `graph/` node effective-status; it does not touch, and should not
  be read as touching, any node under `graph/statements/consistency/`.
