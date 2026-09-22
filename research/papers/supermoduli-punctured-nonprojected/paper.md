# Compactified supermoduli spaces with punctures are non-projected

**Authors:** [To be determined by project lead]

**Status of this file:** *draft manuscript, not submitted anywhere.* The underlying attempt
(`research/attempts/supermoduli-elliptic-tail-punctured/`) has passed two rounds of adversarial
review inside the project, but `captain_confirmed` is still `false`; no part of this text may be
posted, circulated or submitted before that flag is set. See `NOTES-for-captain.md`.

---

**Abstract**

Let $\overline{\mathfrak S}_{g;n,2r}$ denote the Deligne–Mumford superstack of stable supercurves of
genus $g$ with $n$ Neveu–Schwarz and $2r$ Ramond punctures, in the sense of Felder–Kazhdan–Polishchuk.
We prove that $\overline{\mathfrak S}_{g;n,2r}$ is **non-projected** — in particular non-split —
whenever $g\ge 3$, or $g=2$ and $n+2r\ge 2$; and, when $r=0$, that both parity components
$\overline{\mathfrak S}{}^{\pm}_{g;n,0}$ are non-projected for $g \ge 3$ and every $n \ge 0$. The
proof reassembles the elliptic-tail argument of Corrêa–Noja on the *general punctured* separating
NS gluing morphism (7.8) of Felder–Kazhdan–Polishchuk. The single new idea is a placement decision:
all spectator punctures are loaded onto a **constant** tail, so that the moving genus-$h$ factor —
the only factor on which any cohomology is computed — is left exactly as in the unpunctured case.
The punctures then enter the argument solely through a finite-dimensional constant vector space and
a one-dimensional constant line, neither of whose sizes the argument is sensitive to; this is why
the generalisation costs nothing, and why the genus threshold *drops* rather than rises when
punctures are added (a rational tail is unstable without punctures but stable with them, so one
genus is saved).

We prove a second, negative result of equal weight. If the spectator punctures are instead carried by
the moving component — the naive generalisation — then the reduced space of the Donagi–Witten
one-point obstruction family is the affine curve $C\smallsetminus\{p_1,\dots,p_n\}$, Serre vanishing
forces $H^1$ of *every* coherent sheaf on it to vanish, and the primary obstruction class of the test
family is zero for **every** odd tangent vector, although the space of available odd tangent vectors
is *larger* than in the unpunctured case. The same affineness obstruction kills the non-separating
gluing morphism (7.9) as a carrier of the method. Consequently "separating gluing with a constant
tail" is not a convenient choice but the only possible one; this explains, retroactively, a
construction choice left unmotivated in Corrêa–Noja.

We state explicitly what is not proved: nothing is claimed about the uncompactified stacks
$\mathfrak S_{g;n,2r}$, nothing in the positive (split/projected) direction, nothing about
$(g,n,r)=(2,1,0)$ or about odd-parity punctured components at $g=2$, and no connected-component
refinement when $r>0$. We deliberately avoid gluing at Ramond nodes, since the Ramond analogue of the
normal-bundle computation is only conjectural in Felder–Kazhdan–Polishchuk (§9.3, verbatim "We
conjecture that…"); taking that shortcut would have lowered the epistemic status of the conclusion
from *proved* to *conditional on a conjecture*.

---

## 1. Introduction

### 1.1 Background

A supermanifold or superstack $\mathfrak X$ with bosonic truncation $X = \mathfrak X_{\rm bos}$ is
**split** if it is isomorphic to the total space of an odd vector bundle over $X$, and **projected**
if the closed embedding $X\hookrightarrow\mathfrak X$ admits a retraction $\mathfrak X\to X$. Split
$\Rightarrow$ projected, and the failure of projectedness is the precise obstruction to reducing
integration over a supermoduli space to integration over an ordinary moduli space fibrewise along a
projection.

Donagi and Witten [DW] proved that the supermoduli space $\mathfrak M_g$ of super Riemann surfaces is
non-projected for $g\ge 5$, and that the punctured spaces $\mathfrak M_{g,n}$ are non-projected for
$g \ge 2$ and $1\le n\le g-1$. All of their statements concern the **uncompactified** spaces; this
is explicit in [DW, Remark 1.4], verbatim: *"Our assertion is that $\mathfrak M_g$ and
$\mathfrak M_{g,n}$ are non-projected without any consideration of the compactification."*
Donagi–Ott [DO] extended the result to purely Ramond punctures, again uncompactified, with threshold
$g \ge 5r+1$, and Wang [W] to mixed NS/Ramond punctures with threshold $g\ge n+5r+3$.

The compactified side was opened by Felder–Kazhdan–Polishchuk [FKP2] in genus two and then, in
general genus, by Corrêa–Noja [CN], who proved that the compactified unpunctured supermoduli stacks
$\overline{\mathfrak M}{}^{\pm}_g$ are non-projected for all $g\ge 3$ — a *better* threshold than
[DW]'s $g\ge 5$, obtained precisely because the obstruction is detected on a boundary test curve
rather than inside the smooth locus. Corrêa–Noja also showed, in the opposite direction, that
$\overline{\mathfrak M}{}^{-}_2$ is **split**.

What was missing is the intersection of the two developments: **compactified *and* punctured**. That
is the quadrant this paper fills.

### 1.2 Main results

Throughout, $\overline{\mathfrak S}_{g;n,2r}$ is the moduli superstack of stable supercurves of genus
$g$ with $n$ NS punctures and $2r$ Ramond punctures, constructed and proved to be a smooth proper
Deligne–Mumford superstack in [FKP, Theorem A]. (Our subscript convention is fixed in §2.1; it
differs from [FKP]'s own letters, which are overloaded — see the warning in §2.3.) We write
$\omega_2(\mathfrak X)\in H^1(X,\mathcal T_X\otimes\Lambda^2\mathcal T_-^\vee\mathfrak X)$ for Green's
primary obstruction class, whose non-vanishing obstructs projectedness [CN, Proposition 2.2].

> **Theorem M.** Let $h,a,n,r$ be integers with
> $$\textbf{(P1)}\quad h\ge 2, \qquad\qquad \textbf{(P2)}\quad 2a-2+(n+1)+2r>0 ,$$
> and set $g := h+a$. Then
> $$\omega_2\big(\overline{\mathfrak S}_{g;n,2r}\big)\ \neq\ 0 ,$$
> and hence $\overline{\mathfrak S}_{g;n,2r}$ is non-projected, in particular non-split.

Eliminating $h$ and $a$ (Corollary 8.4 below) turns (P1)–(P2) into a closed criterion in the
invariants of the target:

> **Corollary (threshold).**
> $$\boxed{\ \overline{\mathfrak S}_{g;n,2r}\ \text{is non-projected whenever}\quad g\ge 3,\ \ \text{or}\ \ \big(g=2\ \text{and}\ n+2r\ge 2\big).\ }$$

For $r=0$ the target splits by parity, and the construction reaches components:

> **Corollary A (pure NS punctures).**
> **(A1)** For every $g\ge 3$, every $n\ge0$ and **both** parities $\varepsilon\in\{+,-\}$, the
> component $\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}$ is non-projected.
> **(A2)** For every $g\ge2$ and every $n\ge2$, the **even** component
> $\overline{\mathfrak S}{}^{+}_{g;n,0}$ is non-projected.

> **Corollary B (Ramond punctures present).** For every $g\ge2$, every $n\ge0$ and every $r\ge1$,
> the stack $\overline{\mathfrak S}_{g;n,2r}$ is non-projected. (No component refinement is claimed
> when $r>0$; see §10.3.)

The second main result is negative and, we believe, structurally the more informative of the two.

> **Proposition N (the naive placement returns zero identically).** Let $n\ge1$. Put the $n$
> spectator NS punctures on the *moving* genus-$h$ component, i.e. replace Corrêa–Noja's
> $\mathfrak M^+_{h,1}$ by $\mathfrak M^+_{h,n+1}$ with the first $n$ points fixed and the
> $(n{+}1)$-st moving. Then the reduced space of the resulting Donagi–Witten one-point obstruction
> family is the **affine** curve $C^\circ := C\smallsetminus\{p_1,\dots,p_n\}$, so
> $H^1(C^\circ,\mathcal F)=0$ for every coherent sheaf $\mathcal F$; in particular the primary
> obstruction class of the test family lands in the zero group and the comparison map of [CN, Lemma
> 2.6] yields $0=0$ for **every** odd tangent vector $\eta$. The same argument applies to the
> non-separating gluing morphism (7.9) of [FKP] and to Ramond punctures placed on the moving
> component.

The point of Proposition N is a quantifier that is easy to get backwards, and which we got backwards
in a first draft: it is **not** that no $\eta$ is available. On the contrary, with punctures the odd
tangent space at $(C,L,p_1,\dots,p_n)$ is $H^1(C,L^{-1}(-\sum_i p_i))$, of dimension $2h-2+n$, which
is *strictly larger* than Corrêa–Noja's $2h-2$. It is the **target** group of the obstruction class,
not its parameter space, that collapses. So the failure is not "nothing to try" but "more to try than
before, and every single one of them invisible".

### 1.3 The one-line idea, and why the threshold goes *down*

Corrêa–Noja glue a moving one-pointed genus-$h$ spin supercurve to a **fixed** one-pointed elliptic
spin supercurve along an NS node. Our construction is

$$\mathcal B\ :=\ \underbrace{\mathfrak S^+_{h;1,0}}_{\text{unchanged}}\ \times\ \mathfrak S_{a;\,n+1,\,2r}\ \xrightarrow{\ \Gamma\ =\ \text{(7.8)}\ }\ \overline{\mathfrak S}_{g;n,2r},\qquad g=h+a ,$$

with the second factor held **constant**. Every spectator puncture lives on the constant tail. The
first factor is literally the same stack that appears in [CN]; consequently every cohomological step
of [CN, §§5–8] transcribes verbatim, and the only two changes anywhere in the argument are

1. the constant finite-dimensional vector space $W$ acquires a bigger second summand
   ($T_\xi S^{\varepsilon}_{1,1}$ becomes $T_\xi S_{a;n+1,2r}$), and
2. the constant line $M_q^{-1}$ becomes an unnamed one-dimensional space $\mathfrak n$, which we
   never compute.

Neither change matters, because the key estimate (Lemma 8.1 below, after [CN, Lemma 7.1]) uses only
$H^0(C,W\otimes L)=W\otimes H^0(C,L)=0$ and $h^0(C,\mathcal O_C)\cdot\dim\mathfrak n=1$. The
argument is insensitive to $\dim W$, and it never needs to know what $\mathfrak n$ is.

The reason the genus threshold *improves* when punctures are added is equally short. In [CN] the tail
must have genus $1$: a rational tail carrying a single special point is unstable. As soon as
spectator punctures are available they can be parked on the tail, which then becomes stable at genus
$0$. **The punctures pay for the tail's stability, and one unit of genus is refunded.** This is why
$g=2$ becomes accessible exactly when $n+2r\ge2$.

The technical reward of the constant-tail placement is separate and equally important: every
difficulty specific to Ramond punctures is confined to the constant factor, and **no formula is ever
needed on the constant factor**. This is why Corollary B costs no more than Corollary A (§7.3,
Remark 7.4).

### 1.4 Precise comparison with the literature

| Reference | Object | Compactified? | Punctures | Threshold | Parity reached |
|---|---|---|---|---|---|
| [DW, Thm 1.1] | $\mathfrak M_g$ | no | none | $g\ge5$ | both |
| [DW, Thm 1.2] | $\mathfrak M_{g,1}$ | no | $n=1$ NS | $g\ge2$ | even only |
| [DW, Thm 1.3] | $\mathfrak M_{g,n}$ | no | $1\le n\le g-1$ NS | $g\ge2$ | both if $g$ odd, even if $g$ even |
| [DO, Thm 1] | $\mathfrak M_{g,0,2r}$ | no | $2r$ Ramond, $n=0$ | $g\ge 5r+1$ | — |
| [W] | $\mathfrak M_{g,n,2r}$ | no | $n$ NS, $2r$ Ramond | $g\ge n+5r+3$ | — |
| [CN, Thm 1.1(2)] | $\overline{\mathfrak M}{}^{+}_2$ | **yes** | none | $g=2$ | even |
| [CN, Thm 1.1(3)] | $\overline{\mathfrak M}{}^{\pm}_g$ | **yes** | none | $g\ge3$ | both |
| [CN, Thm 1.1(1)] | $\overline{\mathfrak M}{}^{-}_2$ | **yes** | none | — (**split**: positive result) | odd |
| **This paper** | $\overline{\mathfrak S}_{g;n,2r}$ | **yes** | $n$ NS **and** $2r$ Ramond, arbitrary | $g\ge3$; or $g=2$ with $n+2r\ge2$ | both for $g\ge3,r=0$; even for $g=2$ |

Read off from the table, the three concrete gains are:

- **The restriction $n\le g-1$ of [DW, Thm 1.3] disappears.** Corollary A holds for *every* $n\ge0$
  with no coupling to $g$. In particular the whole region $n\ge g$, invisible to [DW], is covered.
- **The Ramond thresholds $g\ge5r+1$ of [DO] and $g\ge n+5r+3$ of [W] are replaced by $g\ge2$**,
  uniformly in $n$ and $r$ (Corollary B).
- **Parity coverage is complete for $g\ge3$**: both $\varepsilon=\pm$ for every $n$, whereas
  [DW, Thm 1.3] reaches the odd component only for odd $g$.

**Two caveats, stated here rather than buried.**

*(i) The objects are not the same.* [DW], [DO] and [W] concern the **uncompactified** stacks; this
paper, like [CN], concerns the **compactified** ones. Our non-vanishing class is detected on a test
curve lying inside the NS boundary divisor $\Delta_{\rm NS}$, so Theorem M says nothing whatever about
the smooth locus $\mathfrak S_{g;n,2r}$, and we make no claim to supersede [DW], [DO] or [W] as
statements about it (§9.3). Precisely the same relation holds between [CN]'s $g\ge3$ and [DW]'s
$g\ge5$, and it is the reason the numbers in the table can look so different without any
contradiction. The comparison above should be read as: *in the compactified punctured quadrant there
was previously no threshold at all, and there now is one, namely $g\ge2$.*

*(ii) We do not use [W].* Wang's preprint is self-described in its arXiv comment field as a
"preliminary draft". No step of any proof in this paper invokes [W], nor [DO]; both appear only in
this comparison and in §9.3. The external inputs are listed exhaustively in §3, and every one of them
is a completed published or preprinted proof.

### 1.5 What is *not* claimed

Listed once, and repeated where relevant:

1. Nothing about the **uncompactified** stacks $\mathfrak S_{g;n,2r}$.
2. Nothing in the **positive** direction: we exhibit no projection and no splitting, and in
   particular we do not touch [CN, Thm 1.1(1)].
3. The cases $(g,n,r)=(2,1,0)$ and the **odd-parity punctured components at $g=2$** are open here.
   Our method provably cannot reach them, and §9.2 explains why that is a feature: if it could, it
   would contradict [CN, Thm 1.1(1)].
4. For $r>0$ we assert non-projectedness of the whole stack $\overline{\mathfrak S}_{g;n,2r}$ and do
   **not** identify a connected component ([GAP-COMP], §10.3).
5. We do not glue at Ramond nodes, so nothing is claimed about the Ramond boundary components; see
   §10.2 for why we refuse that shortcut.
6. One external lemma we rely on, [FKP, Lemma 7.9], has a proof whose text omits the Ramond twist;
   we judge the omission harmless but did not rewrite the proof ([GAP-FKP-RAMOND], §10.1).
7. One of our two corollaries carries a *value* risk, not a mathematical gap: if someone constructs a
   puncture-forgetting morphism of compactified supermoduli stacks and proves a non-vanishing
   statement about it, Corollary A would become a corollary of [CN]. Corollary B would not be
   affected, because forgetting a Ramond puncture is not a morphism at all ([GAP-ALT], §10.4).

### 1.6 Organisation

§2 fixes notation and warns about three notational traps in [FKP]. §3 lists the external inputs with
their rigour status. §4 recalls the obstruction class, its functoriality, and the Donagi–Witten
one-point obstruction family. §5 constructs the test morphism and computes the two sheaves that enter
the argument. §6 proves Theorem M. §7 proves Proposition N and its two corollaries. §8 derives the
threshold in closed form and proves Corollaries A and B. §9 collects four consistency checks, one of
which is a deliberate attempt to make the method contradict a known theorem. §10 lists the open ends.

---

<!-- SECTION-MARKER -->
