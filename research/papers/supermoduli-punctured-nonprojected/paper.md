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
normal-bundle computation is only conjectural in Felder–Kazhdan–Polishchuk ([FKP, §9.3], verbatim
"We conjecture that…"); taking that shortcut would have lowered the epistemic status of the
conclusion from *proved* to *conditional on a conjecture*.

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
primary obstruction class [G], whose non-vanishing obstructs projectedness [CN, Proposition 2.2].

> **Theorem M.** Let $h,a,n,r$ be integers with
> $$\textbf{(P1)}\quad h\ge 2, \qquad\qquad \textbf{(P2)}\quad 2a-2+(n+1)+2r>0 ,$$
> and set $g := h+a$. Then
> $$\omega_2\big(\overline{\mathfrak S}_{g;n,2r}\big)\ \neq\ 0 ,$$
> and hence $\overline{\mathfrak S}_{g;n,2r}$ is non-projected, in particular non-split.

Eliminating $h$ and $a$ (Corollary 8.5 below) turns (P1)–(P2) into a closed criterion in the
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

Neither change matters, because the key estimate (Lemma 6.1 below, after [CN, Lemma 7.1]) uses only
$H^0(C,W\otimes L)=W\otimes H^0(C,L)=0$ and $h^0(C,\mathcal O_C)\cdot\dim\mathfrak n=1$. The
argument is insensitive to $\dim W$, and it never needs to know what $\mathfrak n$ is.

The reason the genus threshold *improves* when punctures are added is equally short. In [CN] the tail
must have genus $1$: a rational tail carrying a single special point is unstable. As soon as
spectator punctures are available they can be parked on the tail, which then becomes stable at genus
$0$. **The punctures pay for the tail's stability, and one unit of genus is refunded.** This is why
$g=2$ becomes accessible exactly when $n+2r\ge2$.

The technical reward of the constant-tail placement is separate and equally important: every
difficulty specific to Ramond punctures is confined to the constant factor, and **no formula is ever
needed on the constant factor**. This is why Corollary B costs no more than Corollary A
(Remark 5.7).

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
parity refinement, Corollaries A and B, and the threshold in closed form, and records the machine
verification of the threshold arithmetic. §9 collects four consistency checks, one of which is a
deliberate attempt to make the method contradict a known theorem. §10 lists the open ends, and §11
concludes.

---

## 2. Notation and conventions

### 2.1 Superstacks and the obstruction class

$\mathfrak X$ always denotes a smooth Deligne–Mumford superstack over $\mathbb C$, $\mathcal J\subset
\mathcal O_{\mathfrak X}$ the ideal generated by the odd functions, and
$X:=\mathfrak X_{\rm bos}$ the bosonic truncation, i.e. the closed substack defined by $\mathcal J$.
We write $\mathcal T_{\pm}\mathfrak X$ for the even and odd parts of
$\mathcal T\mathfrak X/\mathcal J\,\mathcal T\mathfrak X$, and use throughout the standard
identifications

$$\mathcal T_+\mathfrak X\cong\mathcal T_X,\qquad
\mathcal T_-\mathfrak X\cong\mathcal F^\vee_{\mathfrak X},\qquad
\mathcal F_{\mathfrak X}:=\mathcal J/\mathcal J^2 ,$$

which are the ones used by Donagi–Witten and by Corrêa–Noja (Manin; [DW, §2]; [CN, §2]). We do not
reprove them. Set

$$\mathcal F^{\rm obs}_{\mathfrak X}:=\mathrm{Hom}\big(\Lambda^2\mathcal T_-\mathfrak X,\
\mathcal T_+\mathfrak X\big),\qquad
\omega_2(\mathfrak X)\in H^1\big(X,\ \mathcal F^{\rm obs}_{\mathfrak X}\big) .$$

$\mathfrak X$ is **projected** if the closed embedding $X\hookrightarrow\mathfrak X$ admits a
retraction $\mathfrak X\to X$ in the category of superstacks, and **split** if $\mathfrak X$ is
isomorphic to the total space of an odd vector bundle on $X$. Split $\Rightarrow$ projected.

### 2.2 Supermoduli notation used in this paper

$\overline{\mathfrak S}_{g;n,2r}$ denotes the moduli superstack of **stable** supercurves of genus
$g$ with $n$ NS punctures and $2r$ Ramond punctures,

with $\mathfrak S_{g;n,2r}\subset\overline{\mathfrak S}_{g;n,2r}$ the open substack of smooth
supercurves, and $\overline S_{g;n,2r}$ the corresponding moduli stack of stable *spin* curves. When
$r=0$ the parity of the spin structure is locally constant, and we write
$\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}$, $\varepsilon\in\{+,-\}$, for the parity
components. For the unpunctured case we follow Corrêa–Noja and abbreviate
$\overline{\mathfrak M}{}^{\varepsilon}_g:=\overline{\mathfrak S}{}^{\varepsilon}_{g;0,0}$,
$\mathfrak M^+_{h,1}:=\mathfrak S^+_{h;1,0}$.

**Generalized spin structures.** We use the definition of [FKP, §2.6]: a generalized spin structure
on a curve $C$ with punctures is a line bundle $L$ with an isomorphism

$$L^{\otimes2}\ \cong\ \omega_C\big(\rho_1+\dots+\rho_{2r}\big),$$

where the $\rho_j$ are the **Ramond** punctures.

> ⚠ **NS punctures do not twist $\omega_C$; only Ramond punctures do.** This single asymmetry is
> responsible for several of the design decisions below, and for the fact that Corollary B behaves
> differently from Corollary A.

### 2.3 Three notational traps in [FKP]

Any reader checking our citations against [FKP] should be warned of the following, all of which we
verified against the published text.

1. **The letter $m$ has three distinct meanings in [FKP].** In (8.11) and throughout §8.4 it is the
   number of NS punctures; in Lemma 9.1 and Lemma 9.3 it is the exponent of $\omega$; in the proof of
   Lemma 7.10 it is the number of nodes other than the distinguished node $q$. We therefore never
   write "$m$" without saying which one we mean, and in this paper we use $n$ for NS punctures and
   $2r$ for Ramond punctures exclusively.
2. **[FKP] uses two incompatible-looking subscript conventions and never states they agree.** From
   §7.5 onwards the semicolon notation $\overline{\mathcal S}_{g;m,n}$ ($m$ = NS, $n$ = Ramond) is
   used; §1 and §5 use the comma notation $\overline{\mathcal S}_{g,n_{\rm NS},n_{\rm R}}$. The paper
   contains no sentence asserting that the two are the same object, although this is evidently
   intended. Our $\overline{\mathfrak S}_{g;n,2r}$ corresponds to [FKP]'s
   $\overline{\mathcal S}_{g;n,2r}$ in the semicolon convention.
3. **The upper limit in (8.11) is $m$, while Theorem B in the introduction writes $n_{\rm NS}$**, and
   [FKP] nowhere declares $m=n_{\rm NS}$. We do not use (8.11) anywhere (see Lemma 5.5, route 1
   versus route 2), so this ambiguity does not propagate into our argument; we record it because it
   would matter for anyone attempting the alternative route.

### 2.4 Parity

For $r=0$ the parity $\mathrm{par}(L):=h^0(C,L)\bmod 2$ is deformation invariant (Mumford), so
$\overline S_{g;n,0}=\overline S{}^+_{g;n,0}\sqcup\overline S{}^-_{g;n,0}$; for compact-type nodal
spin curves, parity is additive over the irreducible components, because the spin sheaf at an NS node
is the direct sum of the direct images from the two branches (see the proof of Proposition 8.1
below). For $r>0$ the twist $\omega_C(\rho_1+\dots+\rho_{2r})$ destroys Mumford's invariance
argument, and we make no component-level statement — see §10.3.

---

## 3. External inputs

The proof uses the following external results as black boxes. We list them exhaustively, with the
rigour status each carries; the point of the list is that **none of them is a conjecture or a
physics-level argument**, so the conclusion inherits no such ceiling.

| # | Input | Source | Status |
|---|---|---|---|
| I1 | Existence of the primary obstruction class $\omega_2$, its compatibility with étale pullback, and $\omega_2\neq0\Rightarrow$ non-projected | [CN, Prop. 2.2] | rigorous |
| I2 | Functoriality of $\omega_2$ along an arbitrary morphism: $j_f(\omega_2(\mathfrak Y))=\iota_f(\omega_2(\mathfrak X))$ | [CN, Lemma 2.6] (stack version of [DW, Cor. 2.10, 2.12]) | rigorous |
| I3 | The Donagi–Witten one-point obstruction family $X_\eta$, with $\omega_2(X_\eta)=\eta$ | [DW, Prop. 3.4], reviewed verbatim in [CN, §5] | rigorous |
| I4 | $\overline{\mathfrak S}_{g;n,2r}$ exists and is a smooth proper DM superstack | [FKP, Thm. A] | rigorous (published) |
| I5 | The separating NS gluing morphism (7.8) **with arbitrary punctures**, and its tangent-level properties | [FKP, Lemmas 7.9, 7.10] | rigorous (published) |
| I6 | The normal-line formula $\mathcal O(\Delta)|_B\cong\Psi_1^{-1}\otimes\Psi_2^{-1}$ | [FKP, §9.1, Lemma 9.1(iii)(iv), eq. (9.6), pp. 59–61] — **not** Theorem C, see Remark 5.6 | rigorous (published) |
| I7 | Over an even base with NS punctures, $\Psi_i^{-1}\simeq p_i^*L^{-1}$ | [FKP, Example 8.9, p. 57] | rigorous (published); used **only** on the unpunctured genus-$h$ factor |
| I8 | Every smooth curve of genus $h\ge2$ carries an ineffective even theta characteristic | Mumford; Cornalba (cited in [CN, §5]) | standard |
| I9 | $H^i(\text{affine},\ \mathcal F)=0$ for $i\ge1$ and $\mathcal F$ coherent | Serre | standard; used **only** for the negative result of §7 |

> **Remark 3.1 (what is deliberately not used).** [FKP, §9.3] formulates the **Ramond-node**
> analogue of the normal-line computation, verbatim, as
> *"We conjecture that the following diagram is commutative (up to a sign)"*, with no proof. Gluing
> at Ramond nodes would give a shorter route to some of our statements, but the resulting theorem
> would be conditional on that conjecture. **We therefore glue only at NS nodes.** Every use of
> Ramond punctures in this paper is as a *spectator* on the constant tail, where no formula is
> required.

---

## 4. Preliminaries

This section recalls, without proof, the three imported ingredients I1–I3 in the exact form in which
we use them. Nothing here is new; we state them carefully because the *shape* of Lemma 4.2 governs
the whole strategy, and because the affineness phenomenon of §7 is invisible unless one knows
exactly which space the cohomology is computed on.

### The primary obstruction

**Proposition 4.1** ([CN, Prop. 2.2]). *Let $\mathfrak X$ be a smooth Deligne–Mumford superstack over
$\mathbb C$ and $X=\mathfrak X_{\rm bos}$. There is a canonical primary obstruction class*
$$\omega_2(\mathfrak X)\in H^1\big(X,\ \mathcal T_X\otimes\Lambda^2\mathcal T_-^\vee\mathfrak X\big)
= H^1\big(X,\ \mathcal F^{\rm obs}_{\mathfrak X}\big),$$
*compatible with étale pullback. If $\omega_2(\mathfrak X)\neq0$ then $\mathfrak X$ is not projected.
If $\mathcal T_-\mathfrak X$ has rank two, then $\mathfrak X$ is split if and only if
$\omega_2(\mathfrak X)=0$.*

### Functoriality: a cospan, not a map

**Lemma 4.2** ([CN, Lemma 2.6]). *Let $f:\mathfrak Y\to\mathfrak X$ be a morphism of smooth DM
superstacks, $f_0:Y\to X$ the induced morphism of bosonic truncations, and*
$$df_+:\mathcal T_+\mathfrak Y\to f_0^*\mathcal T_+\mathfrak X,\qquad
df_-:\mathcal T_-\mathfrak Y\to f_0^*\mathcal T_-\mathfrak X$$
*the even and odd components of the differential restricted to $Y$. Put*
$$\mathcal G_f:=\mathrm{Hom}\big(\Lambda^2\mathcal T_-\mathfrak Y,\ f_0^*\mathcal T_+\mathfrak X\big)
\qquad\text{(a sheaf on $Y$).}$$
*Pullback followed by precomposition with $\Lambda^2df_-$ gives
$\iota_f:H^1(X,\mathcal F^{\rm obs}_{\mathfrak X})\to H^1(Y,\mathcal G_f)$, and postcomposition with
$df_+$ gives $j_f:H^1(Y,\mathcal F^{\rm obs}_{\mathfrak Y})\to H^1(Y,\mathcal G_f)$. Then*
$$j_f\big(\omega_2(\mathfrak Y)\big)\ =\ \iota_f\big(\omega_2(\mathfrak X)\big)
\qquad\text{in } H^1(Y,\mathcal G_f).$$
*In particular, if $j_f(\omega_2(\mathfrak Y))\neq0$ then $\omega_2(\mathfrak X)\neq0$.*

> **Remark 4.3 (the shape matters).** Lemma 4.2 does **not** produce a map between the two obstruction
> groups. It places the images of both classes into the *same* group $H^1(Y,\mathcal G_f)$ — a cospan.
> Consequently **all cohomology in the entire argument is computed on $Y=\mathfrak Y_{\rm bos}$**, the
> bosonic truncation of the *test* object. What $Y$ is — projective or affine — therefore decides
> whether the method can say anything at all. This is the single observation that produces
> Proposition N in §7.

### The Donagi–Witten one-point obstruction family

Let $h\ge2$, let $C$ be a smooth curve of genus $h$, and let $L$ be an **ineffective even theta
characteristic**:
$$L^{\otimes2}\cong\omega_C,\qquad H^0(C,L)=0 .$$
Such pairs exist for every $h\ge2$ (I8: a general even theta characteristic is ineffective; Mumford,
Cornalba). The odd tangent space to the even supermoduli component at the split super Riemann surface
attached to $(C,L)$ is $H^1(C,L^{-1})$.

For $\eta\in H^1(C,L^{-1})$, Donagi and Witten construct a $(1|2)$-dimensional supermanifold $X_\eta$
by pulling back the universal one-NS-pointed supercurve along the odd tangent line determined by
$\eta$ [DW, §3.5]. We use the following three properties (I3), all recorded verbatim in [CN, §5]:

**(DW1)** The reduced space of $X_\eta$ is the curve $C$ itself, viewed as the moving NS marking in
the universal pointed curve over the *fixed* spin curve $(C,L)$; in particular $X_\eta$ carries a
natural morphism $u_\eta:X_\eta\to\mathfrak M^+_{h,1}=\mathfrak S^+_{h;1,0}$.

**(DW2)** There is an exact sequence $0\to L^{-1}\to\mathcal T_-X_\eta\to\mathcal O_C\cdot\eta\to0$;
after trivialising the odd base line by the generator $\eta$ one gets
$\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$, and moreover
$\mathcal T_+X_\eta\cong\mathcal T_C\cong L^{-2}$. Hence
$\mathcal F^{\rm obs}_{X_\eta}\cong\mathrm{Hom}(L^{-1},L^{-2})\cong L^{-1}$.

**(DW3)** Under these identifications $\omega_2(X_\eta)=\eta$ in $H^1(C,L^{-1})$ [DW, Prop. 3.4].

Three consequences are used repeatedly and are worth isolating:

- The parameter space of the construction is $H^1(C,L^{-1})$, which is non-zero **only because $C$ is
  projective**; on an affine curve it vanishes.
- $\mathcal T_+X_\eta\cong\mathcal T_C$ holds because the even direction of $X_\eta$ is exactly
  "move the NS marking".
- $\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$ uses $L^{\otimes2}\cong\omega_C$ **without twist**, i.e.
  it requires that the genus-$h$ side carry **no Ramond punctures**. This is one of the two reasons
  (the other is §7) why Ramond punctures must live on the tail.

---

## 5. The construction

Throughout this section and the next, fix integers $h,a,n,r$ subject to

$$\textbf{(P1)}\quad h\ge 2, \qquad\qquad \textbf{(P2)}\quad 2a-2+(n+1)+2r>0 ,$$

and put $g:=h+a$. Condition (P2) is the stability condition for a genus-$a$ curve carrying
$n+1+2r$ marked points; it is automatic for $a\ge1$ and equivalent to $n+2r\ge2$ for $a=0$.

### Two preliminary lemmas

**Lemma 5.1 (bosonic truncation).** *For all $g$ and all $m$, $n$ with $n$ even,*
$$\big(\overline{\mathfrak S}_{g;m,n}\big)_{\rm bos}\ \cong\ \overline S_{g;m,n},$$
*the moduli stack of stable spin curves of genus $g$ with $m$ NS and $n$ Ramond punctures, a smooth
proper Deligne–Mumford stack.*

*Proof.* Let $\mathfrak X$ be a superstack over $\mathbb C$ and $S$ a purely even (ordinary) scheme.
A morphism $\varphi:S\to\mathfrak X$ induces
$\varphi^{\#}:\mathcal O_{\mathfrak X}\to\varphi_*\mathcal O_S$. Since $\mathcal O_S$ has no odd part,
$\varphi^{\#}$ kills every odd section, hence kills the ideal $\mathcal J$ they generate, hence
factors uniquely through $\mathcal O_{\mathfrak X}/\mathcal J=\mathcal O_{\mathfrak X_{\rm bos}}$.
Therefore
$$\mathrm{Hom}(S,\mathfrak X)=\mathrm{Hom}(S,\mathfrak X_{\rm bos})\quad\text{for every purely even
$S$,}$$
i.e. $\mathfrak X_{\rm bos}$ represents the restriction of the functor of $\mathfrak X$ to purely
even bases.

On the other hand [FKP, §2.6] states verbatim that *"if we only consider even bases, the functor of
(stable) supercurves with punctures coincides with the functor of stable curves with punctures
equipped with generalized spin structures"*, and that the latter functor is represented by
$\overline S_{g,n_{\rm NS},n_{\rm R}}$, which *"was studied in [22], [23], as a particular case of the
stack of stable $r$-spin curves. In particular, it [is] shown to be a smooth proper Deligne–Mumford
stack."* (In [FKP]'s numbering, [22] and [23] are Jarvis's papers on moduli of higher spin curves.)
Two stacks representing the same functor on purely even bases are canonically isomorphic. $\square$

*(For $m=n=0$ this is asserted, without proof, in [CN, §3.1]; Lemma 5.1 is the punctured version with
the argument written out.)*

**Lemma 5.2 (existence of the fixed tail).** *Let $a,n,r\ge0$ satisfy (P2). Then there exist a smooth
curve $F$ of genus $a$, pairwise distinct points $q,y_1,\dots,y_n,\rho_1,\dots,\rho_{2r}\in F$, and a
line bundle $N$ on $F$ with*
$$N^{\otimes2}\ \cong\ \omega_F\big(\rho_1+\dots+\rho_{2r}\big),$$
*such that the resulting datum $\xi=(F,N;q,y_1,\dots,y_n;\rho_1,\dots,\rho_{2r})$ is a
$\mathbb C$-point of $\overline S_{a;n+1,2r}$ lying in the open locus $S_{a;n+1,2r}$ of smooth
curves. Moreover:*

- *for $a=0$ (which forces $n+2r\ge2$): $\omega_{\mathbb P^1}(\rho_1+\dots+\rho_{2r})=
  \mathcal O(2r-2)$, so $N=\mathcal O_{\mathbb P^1}(r-1)$ is **unique**; when $r=0$,
  $N=\mathcal O(-1)$ has $h^0=0$ and is therefore **even**;*
- *for $a=1$ and $r=0$: $N^{\otimes2}\cong\mathcal O_E$, so $N$ is one of the four theta
  characteristics of the elliptic curve $E$; $\mathcal O_E$ is **odd** and the three non-trivial
  $2$-torsion points are **even**. In particular **both parities occur**.*

*Proof.* Choose any smooth genus-$a$ curve $F$ and any $n+1+2r$ pairwise distinct points on it (over
$\mathbb C$ this is always possible; for $a=0$ take points of $\mathbb P^1$). Write
$\rho:=\rho_1+\dots+\rho_{2r}$. Then $\deg\omega_F(\rho)=2a-2+2r$ is even. On a smooth projective
curve, $\mathrm{Pic}^0(F)$ is a complex torus, in particular a **divisible** abelian group, so every
line bundle of even degree admits a square root: pick any $N_0$ with $\deg N_0=a-1+r$; then
$\omega_F(\rho)\otimes N_0^{-2}\in\mathrm{Pic}^0(F)$ has a square root $\alpha$, and
$N:=N_0\otimes\alpha$ works. Stability of the marked curve (finiteness of its automorphism group) is
equivalent to $2a-2+\#\{\text{marked points}\}>0$, i.e. to $2a-2+(n+1)+2r>0$, which is (P2).
Uniqueness for $a=0$ follows from $\mathrm{Pic}(\mathbb P^1)=\mathbb Z$; the parity count for
$a=1,r=0$ is classical and is quoted verbatim in [CN, §6]. $\square$

### Construction 5.3

Fix, once and for all:

- $(C,L)$: a smooth curve of genus $h\ge2$ together with an ineffective even theta characteristic,
  $L^{\otimes2}\cong\omega_C$ and $H^0(C,L)=0$ (I8);
- $\xi=(F,N;q,y_1,\dots,y_n;\rho_1,\dots,\rho_{2r})$: the fixed tail from Lemma 5.2, regarded as a
  $\mathbb C$-point of the *smooth* supermoduli stack $\mathfrak S_{a;n+1,2r}$ (legitimate by
  Lemma 5.1: over an even base, supercurves are spin curves). Since $\mathfrak S_{a;n+1,2r}$ is
  Deligne–Mumford ([FKP, Thm. A] plus passage to an open substack) and $\xi$ is stable, the
  automorphism group $A:=\mathrm{Aut}(\xi)$ is finite étale.

Define

$$\mathcal B\ :=\ \underbrace{\mathfrak S^+_{h;1,0}}_{=\ \mathfrak M^+_{h,1}\ \text{of [CN]}}\ \times\
\mathfrak S_{a;\,n+1,\,2r},\qquad
\mathcal B_{\rm bos}=S^+_{h;1,0}\times S_{a;n+1,2r}\ \ \text{(Lemma 5.1)},$$

$$\Gamma\colon\ \mathcal B\ \longrightarrow\ \overline{\mathfrak S}_{g;n,2r}
\qquad\big(\text{[FKP], eq. (7.8), with } g_1=h,\ m_1=0,\ n_1=0;\ g_2=a,\ m_2=n,\ n_2=2r\big).$$

Indeed [FKP, (7.8)] reads, in general form,
$$\overline{\mathfrak S}_{g_1;m_1+1,n_1}\times\overline{\mathfrak S}_{g_2;m_2+1,n_2}\longrightarrow
\overline{\mathfrak S}_{g_1+g_2;\,m_1+m_2,\,n_1+n_2},$$
gluing the last NS puncture on each factor; with the above indices the target is exactly
$\overline{\mathfrak S}_{h+a;n,2r}$. Concretely: **the single NS puncture on the moving component and
the point $q$ on the tail are glued into a separating NS node, while the $y_i$ and $\rho_j$ survive
untouched as the $n$ NS and $2r$ Ramond punctures of the resulting curve.**

Next put

$$\tau_\xi\colon\ \mathfrak S^+_{h;1,0}\to\mathcal B,\quad
\mathcal X\longmapsto(\mathcal X,\ \xi_S),\qquad \xi_S:=\xi\times_{\mathrm{Spec}\,\mathbb C}S,$$

on $S$-points, and $\phi\mapsto(\phi,\mathrm{id}_S)$ on morphisms — this is the *constant tail*
morphism, defined exactly as in [CN, §6]. Then set

$$G_\xi:=\Gamma\circ\tau_\xi\colon\ \mathfrak S^+_{h;1,0}\to\overline{\mathfrak S}_{g;n,2r},
\qquad
F_{\eta,\xi}:=G_\xi\circ u_\eta\colon\ X_\eta\to\overline{\mathfrak S}_{g;n,2r},$$

with $u_\eta$ as in (DW1). On bosonic truncations,

$$e_C\colon C\to S^+_{h;1,0},\ p\mapsto(C,L,p);\qquad e:=\tau_{\xi,\rm bos}\circ e_C;\qquad
i:=\Gamma_{\rm bos}\circ e\colon C\to\overline S_{g;n,2r},$$
$$i(p)=(C,L,p)\ \cup_{p=q}\ (F,N;y_1,\dots,y_n;\rho_1,\dots,\rho_{2r}).$$

> **The entire novelty is the second factor.** In [CN] it is $\mathfrak M^{\varepsilon}_{1,1}$
> (genus $1$, one NS point); here it is $\mathfrak S_{a;n+1,2r}$ (genus $a$, $n+1$ NS points, $2r$
> Ramond points). **The first factor is unchanged**, which is precisely why every lemma below can be
> transported from [CN] with at most notational edits.

### The tangent sheaf along the test curve

**Lemma 5.4.** *Along $e\colon C\to\mathcal B_{\rm bos}$ there is an exact sequence*
$$0\longrightarrow\mathcal T_C\longrightarrow e^*\mathcal T\mathcal B_{\rm bos}\longrightarrow
W\otimes\mathcal O_C\longrightarrow0,\qquad
W:=H^1(C,\mathcal T_C)\oplus T_{\xi_{\rm bos}}S_{a;n+1,2r},$$
*where $W$ is a fixed finite-dimensional vector space.*

*Proof.* This is [CN, Lemma 6.1] with the second factor replaced; we go through it factor by factor.

*First factor.* $S^+_{h;1,0}\to S^+_h$ is the universal pointed curve over the smooth spin moduli
stack. Pulling back its tangent sequence along $e_C$ gives
$$0\to\mathcal T_C\to e_C^*\mathcal T S^+_{h;1,0}\to T_{(C,L)}S^+_h\otimes\mathcal O_C\to0 .$$
Since the smooth spin moduli stack is finite étale over the moduli stack of smooth curves,
$T_{(C,L)}S^+_h\cong H^1(C,\mathcal T_C)$. **This paragraph is identical to [CN], because the first
factor is untouched.**

*Second factor.* On the second factor $e$ is **constant**, equal to the stack-theoretic point
$\xi_{\rm bos}$; hence
$e^*\mathrm{pr}_2^*\mathcal T S_{a;n+1,2r}\cong T_{\xi_{\rm bos}}S_{a;n+1,2r}\otimes\mathcal O_C$.
The *only* change relative to [CN] is that the constant vector space is now of dimension
$3a-3+(n+1)+2r$ instead of $1$. The argument of [CN] uses only that this space is constant and
finite-dimensional; its dimension never enters.

*Residual gerbe.* $A=\mathrm{Aut}(\xi)$ is finite étale, so the residual gerbe contributes no
infinitesimal tangent directions; all computations take place after pullback along $e$ to $C$, and no
$A$-invariant part is taken. Identical to [CN].

Adding the two factors gives the stated sequence. $\square$

### The normal line

This is the only step requiring care, and the only place where we deviate from the citation used in
[CN].

**Lemma 5.5 (normal line).** *Let $N_{\mathcal B}:=\mathcal O(\Delta_{\rm NS})|_{\mathcal B}$ be the
normal line bundle of the gluing morphism $\Gamma$. Then*
$$e^*N_{\mathcal B}\ \cong\ L^{-1}\otimes\mathfrak n ,$$
*where $\mathfrak n:=\big(\Psi_2^{-1}\big)\big|_{\xi}$ is a one-dimensional $\mathbb C$-vector space
— the fibre at $q$ of the inverse NS psi-line of the tail.*

*Proof.* **(a) The normal-line formula applies in the punctured generality.** [FKP, §9.1, p. 58]
begins verbatim: *"Let $\iota:B\to\overline{\mathcal S}$ be the standard gluing map covering an NS
type boundary component, i.e., one of the maps (7.8) or (7.9), restricted to the locus of smooth
supercurves."* Our $\Gamma$ **is** the map (7.8) (Construction 5.3), and $\mathcal B$ is a product of
two *uncompactified* factors, hence lies in the locus of smooth supercurves. The setup therefore
applies verbatim.

[FKP] establishes $N_B\cong\Psi_1^{-1}\otimes\Psi_2^{-1}$ **twice**, by two independent routes, and
only the second is available to us:

- *Route 1 (bottom of p. 58 – top of p. 59): via the super Mumford isomorphism (8.11).* Here the
  identification $N_B\cong\Psi_1^{-1}\otimes\Psi_2^{-1}$ appears as an **unnumbered display on
  p. 59** — it is *not* equation (9.6). This route does survive the introduction of punctures, but
  not for free: the psi-lines of the spectator punctures appear on both sides (on $B$ from the
  factorwise (8.11), on $\overline{\mathcal S}$ from the (8.11) of the glued curve, with
  $\iota^*\Psi_j=\Psi_j$ since they are literally the same punctures) and cancel, and one needs in
  addition an argument that $\mathcal O(\Delta_R)|_B\cong\mathcal O_B$. **We do not use this route.**
- *Route 2 (bottom of p. 60 – p. 61): via the definition (7.6) of the NS boundary line bundle.*
  [FKP, eq. (9.6), p. 61] reads verbatim
  $$\mathcal O(\Delta)|_B\simeq\operatorname{Ber}R\pi_*(j_*\Omega_{U/S})|_B\otimes
  \operatorname{Ber}^{-1}R\pi_*(\Omega_{X/S}|_B)\simeq\Psi_1^{-1}\Psi_2^{-1}.$$
  This route runs entirely through [FKP, Lemma 9.1(iii)(iv), p. 59], whose comparison sheaves
  $\mathcal K$ and $\tilde{\mathcal C}$ are described in the source, verbatim, as *"supported on the
  node"*. **No puncture enters this derivation**, which is what makes it the puncture-independent
  route. This is the route we use.

That $\Psi_1$ comes from the first factor and $\Psi_2$ from the second follows from the **definition**
of $\Psi$ together with flat base change: [FKP, p. 57] (end of the proof of Lemma 8.7) states
$\Psi\simeq\tilde\Psi\simeq\pi_*(I_P/I_D)$ and
$P^*\omega_{D/S}\simeq\operatorname{Ber}(\Psi)=\Psi^{-1}$, every object in which is computed on the
divisor $D_i$ of the $i$-th puncture; for $\mathcal B=S_1\times S_2$ the universal curve is
$\tilde X=\mathrm{pr}_1^*\tilde X_1\sqcup\mathrm{pr}_2^*\tilde X_2$, whence
$\Psi_2=\mathrm{pr}_2^*\Psi_{P_2}$.

*(A caution for readers checking this against the source: the sentence on [FKP, p. 58] beginning
"Note that in the case of a separating node, where $B=S_1\times S_2$, the line bundle
$\mathcal B(\mathcal O_{\tilde X})$ is the exterior product of two similar line bundles on the
factors $S_1$ and $S_2$" is about the Berezinian $\mathcal B(\mathcal O_{\tilde X})$, not about
$\Psi$, and must not be used for the factorisation above.)*

**(b) The $\Psi_1$ side: identical to [CN].** The first factor $\mathfrak S^+_{h;1,0}$ carries
**exactly one NS puncture and no Ramond punctures** — precisely the situation of [CN, Lemma 6.2]. By
[FKP, Example 8.9] (over an even base, the inverse NS psi-line at a marked point is the fibre of the
inverse spin line at that point), applied along $e_C$ (base $C$, family = the fixed spin curve
$(C,L)$ with moving marking $p$),
$$e^*\Psi_1^{-1}\ \cong\ L^{-1}.$$
Note that Example 8.9 is used **only here**, and here its hypotheses ("a family of supercurves with
NS-punctures" over an even base, with $L^{\otimes2}\cong\omega_C$ untwisted) are satisfied verbatim.

**(c) The $\Psi_2$ side: no formula is needed.** The tail is **constant** along $e$, so
$e^*\Psi_2^{-1}$ is the constant line bundle $\mathfrak n\otimes\mathcal O_C$ for a one-dimensional
vector space $\mathfrak n$. **Everything below uses only that it is a line; never what it is.**

Combining (a), (b), (c) gives the claim. $\square$

> **Remark 5.6 (do not cite [FKP, Theorem C] here).** [FKP, Theorem C, p. 2] reads verbatim: *"Let
> $B\to\overline{\mathcal S}_g$ be the gluing map to one of the components of $\Delta_{NS}$ from a
> lower genus (uncompactified) moduli space $B$."* Its **target** is the **unpunctured**
> $\overline{\mathcal S}_g$; on the same page, Theorem B explicitly writes
> $\overline{\mathcal S}=\overline{\mathcal S}_{g,n_{NS},n_R}$, so the distinction is deliberate on
> [FKP]'s part. Theorem C allows the *source* $B$ to carry punctures but not the *target*, and we
> need a punctured target. This is why Lemma 5.5 is routed through §9.1 / Lemma 9.1(iii)(iv) /
> eq. (9.6) instead.

> **Remark 5.7 (why the generalisation is free, and why Ramond costs nothing extra).** In [CN,
> Lemma 6.2] the constant line $\mathfrak n$ is computed to be $M_q^{-1}$, using Example 8.9 on the
> elliptic tail. With Ramond punctures on the tail, Example 8.9 — stated for families with
> NS-punctures — does not directly apply, and the relation between the $\Psi$-lines and the
> generalized spin structure would have to be re-examined. **Lemma 5.5(c) sidesteps this entirely by
> not computing $\mathfrak n$**: the tail is constant, so $\mathfrak n$ is a line, and the only thing
> the argument ever consumes is $h^0(C,\mathcal O_C\otimes\mathfrak n)=1$ (see Lemma 6.1). All of the
> technical difficulty introduced by Ramond punctures is thereby quarantined inside the constant
> factor, and no formula is ever required there. This is the real payoff of mounting the spectator
> punctures on the fixed tail.

> **Remark 5.8 (an inference, honestly labelled) [INF-NORMAL].** [FKP] never states eq. (9.6) for a
> target with an arbitrary number of punctures. Our use of it for the punctured target
> $\overline{\mathfrak S}_{g;n,2r}$ is **an inference based on the locality of the node singularity —
> the sheaves in Lemma 9.1(iii)(iv) are, verbatim, "supported on the node" — and not a general
> conclusion stated verbatim by [FKP]**. We regard the inference as solid (deformation theory of a
> node is genuinely local, and no puncture enters route 2 at any point), but it is an inference, and
> a reader who declines to make it should read every statement of this paper as conditional on it.

### The even tangent quotient

**Proposition 5.9.** *Let $\mathcal T:=i^*\mathcal T_+\overline{\mathfrak S}_{g;n,2r}\cong
i^*\mathcal T\overline S_{g;n,2r}$ (the second isomorphism by $\mathcal T_+\cong\mathcal T_X$ and
Lemma 5.1). The differential of $i$ gives an injection $\mathcal T_C\hookrightarrow\mathcal T$, and
$Q:=\mathcal T/\mathcal T_C$ carries a two-step filtration*
$$0\subseteq Q_0\subseteq Q,\qquad Q_0\cong W\otimes\mathcal O_C,\qquad
Q/Q_0\cong L^{-1}\otimes\mathfrak n .$$

*Proof.* By [FKP, Lemma 7.10], verbatim: *"Both morphisms (7.8) and (7.9) induce embeddings of
codimension $1|0$ on tangent spaces and factor through the divisor $\Delta_{NS}$. Furthermore, near a
stable supercurve with a single separating (resp., non-separating) NS node, the divisor
$\Delta_{NS}$ coincides with the schematic image of (7.8) (resp., (7.9))."* Pulling back the tangent
sequence of the boundary inclusion along $e$ therefore gives
$$0\longrightarrow e^*\mathcal T\mathcal B_{\rm bos}\longrightarrow\mathcal T\longrightarrow
e^*N_{\mathcal B}\longrightarrow0 .$$
Splice this with the sequence of Lemma 5.4. The splice is the **third isomorphism theorem** applied to
the two-step filtration $\mathcal T_C\subset e^*\mathcal T\mathcal B_{\rm bos}\subset\mathcal T$: with
$Q:=\mathcal T/\mathcal T_C$ and
$Q_0:=e^*\mathcal T\mathcal B_{\rm bos}/\mathcal T_C\cong W\otimes\mathcal O_C$ one obtains
$$0\to W\otimes\mathcal O_C\to Q\to e^*N_{\mathcal B}\to0 ,$$
and $e^*N_{\mathcal B}\cong L^{-1}\otimes\mathfrak n$ by Lemma 5.5. (The assertion is a filtration,
not a splitting.) $\square$

> **Remark 5.10 (no closed-immersion hypothesis is needed).** One might worry that the first sequence
> above requires $\Gamma$ to be a closed immersion. It does not. By [FKP, Lemma 7.10, p. 48],
> $d\Gamma$ has **constant corank $1|0$**, so $\operatorname{coker}(d\Gamma)$ is locally free of rank
> $1|0$; its identification with $\mathcal O(\Delta_{NS})|_B=N_{\mathcal B}$ is exactly the content of
> the sentence in the proof on p. 49: *"Using the fact that the morphism on tangent spaces is an
> embedding with the image which is the orthogonal to $dt$, we deduce that near this point
> $\Delta_{NS}$ is the schematic image of the morphism"* ($t$ = a local equation of $\Delta_{NS}$).
> Pullback along $e$ of a short exact sequence of locally free sheaves is exact, so no closed
> immersion is required. A closed immersion would be needed only to identify $\mathcal T$ with the
> tangent sheaf of an actual subscheme; but our $\mathcal T$ is *defined* as the pullback
> $i^*\mathcal T_+\overline{\mathfrak S}_{g;n,2r}$, not as an intrinsic object attached to an image.
>
> We also record that [FKP, Lemma 7.10] is itself stated and proved in punctured generality: its
> proof begins, verbatim, *"Let $X$ be a stable supercurve with punctures and a fixed NS-node
> $q\in X$"*, with the parenthetical *"(where we take into account all the punctures on both
> sides)"*, and the displayed form of (7.8) on the same page matches our index choice
> ($g_1=h,m_1=0,n_1=0$; $g_2=a,m_2=n,n_2=2r$) verbatim.

> **Remark 5.11 (dimension cross-check).** $\dim\mathcal B_{\rm bos}=(3h-3+1)+(3a-3+(n+1)+2r)=
> 3g-4+n+2r=\dim\overline S_{g;n,2r}-1$, consistent with codimension $1|0$. The ranks in
> Proposition 5.9 add up correctly as well:
> $1+\big[(3h-3)+(3a-3+n+1+2r)\big]+1=3g-3+n+2r=\dim\overline S_{g;n,2r}$.

**Changes relative to [CN], in full.** Exactly two, neither of which touches the structure of the
argument: (i) the second summand of $W$ becomes $T_\xi S_{a;n+1,2r}$ instead of
$T_\xi S^{\varepsilon}_{1,1}$; (ii) the constant line $M_q^{-1}$ becomes the uncomputed line
$\mathfrak n$.

---

## 6. Proof of Theorem M

Keep the notation of §5 and define
$$J\colon\ H^1(C,L^{-1})\longrightarrow H^1\big(C,\mathrm{Hom}(L^{-1},\mathcal T)\big)
=H^1(C,\mathcal T\otimes L),$$
the map induced by the inclusion $\mathcal T_C\cong L^{-2}\hookrightarrow\mathcal T$ (equivalently, by
$\mathrm{Hom}(L^{-1},\mathcal T_C)\cong L^{-1}\to\mathrm{Hom}(L^{-1},\mathcal T)$).

**Lemma 6.1.** $\dim\ker J\le1$.

*Proof.* Apply $\mathrm{Hom}(L^{-1},-)=(-)\otimes L$ to $0\to\mathcal T_C\to\mathcal T\to Q\to0$;
using $\mathcal T_C\cong L^{-2}$ this gives
$$0\to L^{-1}\to\mathcal T\otimes L\to Q\otimes L\to0 .$$
The long exact sequence contains
$$H^0(C,Q\otimes L)\xrightarrow{\ \delta\ }H^1(C,L^{-1})\xrightarrow{\ J\ }H^1(C,\mathcal T\otimes L),$$
so $\ker J=\operatorname{im}\delta$ and $\dim\ker J\le h^0(C,Q\otimes L)$.

By Proposition 5.9, tensoring the filtration by $L$ yields the exact sequence
$$0\to W\otimes L\to Q\otimes L\to \mathcal O_C\otimes\mathfrak n\to0 ,$$
using $(L^{-1}\otimes\mathfrak n)\otimes L\cong\mathcal O_C\otimes\mathfrak n$. Taking global
sections and using ineffectivity of $L$,
$$H^0(C,W\otimes L)=W\otimes H^0(C,L)=0 ,$$
so $H^0(C,Q\otimes L)\hookrightarrow H^0(C,\mathcal O_C)\otimes\mathfrak n$ and therefore
$$h^0(C,Q\otimes L)\ \le\ h^0(C,\mathcal O_C)\cdot\dim\mathfrak n\ =\ 1\cdot1\ =\ 1 .$$
Hence $\dim\ker J\le1$. $\square$

> **Remark 6.2 (insensitivity to $\dim W$ — the technical root of the whole generalisation).** The
> proof of Lemma 6.1 uses the constant vector space $W$ only through
> $H^0(C,W\otimes L)=W\otimes H^0(C,L)=0$. It is therefore **completely insensitive to $\dim W$**.
> Since $\dim T_\xi S_{a;n+1,2r}=3a-3+(n+1)+2r$ grows linearly in $n$ and $r$, this is exactly why
> adding arbitrarily many spectator punctures costs nothing. Likewise the line $\mathfrak n$ enters
> only through $\dim\mathfrak n=1$; it occurs in exactly two places in the whole paper
> (Proposition 5.9 and Lemma 6.1) and is never touched again.

**Corollary 6.3.** *If $h\ge2$, there exists $\eta\in H^1(C,L^{-1})$ with $J(\eta)\neq0$.*

*Proof.* From $L^{\otimes2}\cong\omega_C$ we get $\deg L=h-1$, hence $\deg L^{-1}=1-h<0$ and
$H^0(C,L^{-1})=0$. Riemann–Roch gives
$\chi(C,L^{-1})=\deg L^{-1}+1-h=2-2h$, so $h^1(C,L^{-1})=2h-2$. For $h\ge2$ the source of $J$ has
dimension $\ge2>1\ge\dim\ker J$ (Lemma 6.1), so $\ker J\subsetneq H^1(C,L^{-1})$; choose
$\eta\notin\ker J$. $\square$

*(Note that here $L^{\otimes2}\cong\omega_C$ carries **no** Ramond twist, because the genus-$h$ side
has no Ramond punctures. This is the second reason — the first being §7 — why Ramond punctures must
be mounted on the tail; see Corollary 7.3.)*

**Theorem 6.4 (= Theorem M).** *Let $h\ge2$ and $a,n,r\ge0$ satisfy $2a-2+(n+1)+2r>0$, and put
$g=h+a$. Then*
$$\omega_2\big(\overline{\mathfrak S}_{g;n,2r}\big)\ \neq\ 0 ,$$
*and consequently $\overline{\mathfrak S}_{g;n,2r}$ is non-projected, in particular non-split.*

*Proof.* Take all the data of Construction 5.3 and the class $\eta$ of Corollary 6.3, and form
$F:=F_{\eta,\xi}\colon X_\eta\to\overline{\mathfrak S}_{g;n,2r}$.

**Step 1 (identification of the comparison sheaf).** By (DW2)–(DW3),
$\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$, $\mathcal T_+X_\eta\cong\mathcal T_C\cong L^{-2}$ and
$\omega_2(X_\eta)=\eta\in H^1(C,L^{-1})$. The comparison sheaf of Lemma 4.2 is
$$\mathcal G_{F}=\mathrm{Hom}\big(\Lambda^2\mathcal T_-X_\eta,\ i^*\mathcal T_+
\overline{\mathfrak S}_{g;n,2r}\big)\cong\mathrm{Hom}(L^{-1},\mathcal T)=\mathcal T\otimes L .$$

**Step 2 (the coefficient morphism is $J$).** The map $j_F$ is induced by the even differential
$dF_+\colon\mathcal T_+X_\eta=\mathcal T_C\to i^*\mathcal T_+\overline{\mathfrak S}_{g;n,2r}
=\mathcal T$. The bosonic truncation of $F$ is $i$, and $di$ sends tangent directions of $C$ to
tangent directions of the target, so under the identifications of Step 1 $dF_+$ is precisely the
inclusion $\mathcal T_C\hookrightarrow\mathcal T$. Passing to cohomology gives exactly the map $J$ of
this section, whence
$$j_F\big(\omega_2(X_\eta)\big)=J(\eta)\neq0 .$$

**Step 3 (functoriality).** Apply Lemma 4.2 to $F\colon X_\eta\to\overline{\mathfrak S}_{g;n,2r}$.
Its hypotheses hold: $X_\eta$ is a $(1|2)$-dimensional supermanifold, and
$\overline{\mathfrak S}_{g;n,2r}$ is a smooth proper DM superstack by [FKP, Thm. A] (I4). Hence
$$\iota_F\big(\omega_2(\overline{\mathfrak S}_{g;n,2r})\big)=j_F\big(\omega_2(X_\eta)\big)=J(\eta)
\neq0\quad\text{in }H^1(C,\mathcal G_F).$$
In particular $\omega_2(\overline{\mathfrak S}_{g;n,2r})\neq0$.

**Step 4.** By Proposition 4.1, non-vanishing of the primary obstruction prevents projectedness.
$\square$

> **Remark 6.5 (what the proof also gives).** The argument does more than assert non-vanishing: it
> **locates** the obstruction. The class is already non-zero after restriction to the boundary test
> curve $i(C)\subset\Delta_{\rm NS}$, and it is witnessed by an explicit $\eta$, namely any
> $\eta\in H^1(C,L^{-1})\smallsetminus\ker J$ — a subset of complement dimension at most $1$ in a
> space of dimension $2h-2$.

---

## 7. Proposition N: the naive placement returns zero identically

Theorem M places the spectator punctures on the constant tail. The obvious alternative — and the
first thing one tries — is to place them on the moving component, i.e. to replace [CN]'s
$\mathfrak M^+_{h,1}$ by $\mathfrak M^+_{h,n+1}$ with $n$ of the markings fixed and one moving. This
section proves that the alternative yields **no information whatsoever**, for structural reasons that
have nothing to do with how cleverly the rest of the argument is arranged.

This is not an aside. Together with Corollary 7.2 it shows that *separating gluing with a constant
tail* is not a convenient choice but the **only** one available to the method — which retroactively
explains a construction choice that [CN] makes without comment.

**Proposition 7.1 (Proposition N).** *Let $n\ge1$. Fix a smooth curve $C$ of genus $h$, an
ineffective even theta characteristic $L$, and $n$ pairwise distinct points
$p_1,\dots,p_n\in C$. Consider the test family obtained by moving the $(n{+}1)$-st NS marking, i.e.
the family built along*
$$e_C^{\circ}\colon\ C^{\circ}:=C\smallsetminus\{p_1,\dots,p_n\}\ \longrightarrow\ S^+_{h;n+1,0},
\qquad p\longmapsto (C,L,p_1,\dots,p_n,p),$$
*and let $X^{\circ}_\eta$ be the corresponding Donagi–Witten one-point obstruction family. Then*
$$(X^{\circ}_\eta)_{\rm bos}=C^{\circ}\ \text{ is affine},\qquad
H^1(C^{\circ},\mathcal F)=0\ \ \text{for every coherent sheaf }\mathcal F .$$
*In particular the primary obstruction class of the test family lies in the zero group,*
$$\omega_2(X^\circ_\eta)\in H^1\big(C^\circ,\ \mathcal F^{\rm obs}_{X^\circ_\eta}\big)=0 ,$$
*so the comparison map of Lemma 4.2 gives $j_F(\omega_2(X^\circ_\eta))=0$ and hence the trivial
identity $\iota_F(\omega_2(\text{target}))=0$, for **every** $\eta$ and every target. The route
detects nothing.*

*Proof.* In four steps.

**Step 1 (the test base must omit the fixed points).** Objects of the moduli problem
$S_{h;n+1,0}$ are spin curves with $n+1$ **pairwise distinct** markings — in the definitions of
stable spin curves with punctures used by [FKP, §2.6] (after Cornalba and Jarvis), markings on a
smooth curve must be distinct, since otherwise the resulting family is not a family of
$S_{h;n+1,0}$. Hence $p\mapsto(C,L,p_1,\dots,p_n,p)$ is undefined at $p=p_j$, and its maximal domain
of definition is $C^{\circ}=C\smallsetminus\{p_1,\dots,p_n\}$. The Donagi–Witten one-point
obstruction family is pulled back along this curve — the fibre of the universal pointed supercurve
over the fixed spin curve — so its reduced space is exactly $C^{\circ}$.

**Step 2 ($C^\circ$ is affine).** $C$ is a smooth projective curve and $n\ge1$, so $C^\circ$ is a
smooth projective curve minus a non-empty finite set, hence affine (take an ample divisor supported
on $\{p_1,\dots,p_n\}$).

**Step 3 (Serre vanishing).** Higher cohomology of coherent sheaves on an affine scheme vanishes
(Serre, I9): $H^i(C^\circ,\mathcal F)=0$ for $i\ge1$ and every coherent $\mathcal F$.

**Step 4 (the value group is zero).** By §2.1 the primary obstruction of any smooth DM superstack
$\mathfrak X$ lies in $H^1(\mathfrak X_{\rm bos},\mathcal F^{\rm obs}_{\mathfrak X})$. Here
$(X^\circ_\eta)_{\rm bos}=C^\circ$ is affine by Steps 1–2, and
$\mathcal F^{\rm obs}_{X^\circ_\eta}=\mathrm{Hom}(\Lambda^2\mathcal T_-X^\circ_\eta,
\mathcal T_+X^\circ_\eta)$ is coherent — indeed locally free, since $\mathcal T_\pm$ of the
Donagi–Witten family are vector bundles and both $\Lambda^2$ and $\mathrm{Hom}$ preserve local
freeness. So Step 3 applies **whatever the coefficient sheaf is**, and
$$\omega_2(X^\circ_\eta)\in H^1\big(C^\circ,\ \mathcal F^{\rm obs}\big)=0 .$$
Therefore $j_F(\omega_2(X^\circ_\eta))=0$, and Lemma 4.2 yields only
$\iota_F(\omega_2(\text{target}))=0$, which carries no information. $\square$

> **Remark (an alternative one-line proof).** Proposition 4.1 states verbatim that $\omega_2$ *"is
> compatible with étale pullback"*, and the open immersion $C^\circ\hookrightarrow C$ is étale;
> hence $\omega_2(X^\circ_\eta)=\eta|_{C^\circ}\in H^1(C^\circ,L^{-1})=0$. Both proofs are correct;
> the one given above is shorter and does not depend on the shape of $\eta$.

> **Remark (the quantifier, which is easy to get backwards).** The conclusion is **not** that
> the only available $\eta$ is $0$. On the contrary, with punctures the odd tangent space at
> $(C,L,p_1,\dots,p_n)$ is $H^1\big(C,L^{-1}(-\sum_ip_i)\big)$, computed on the **projective** curve
> $C$, of dimension
> $$h^1\big(C,L^{-1}(-\textstyle\sum_ip_i)\big)=2h-2+n$$
> (from $\deg L^{-1}(-\sum p_i)=1-h-n$, $\chi=2-2h-n$, $h^0=0$), matching the odd dimension of
> $\mathfrak M_{h,n}$. So there are **more** classes $\eta$ to try than in the unpunctured case of
> [CN], which has $2h-2$. What collapses is the **value** space of the obstruction, not its
> **parameter** space. The correct reading of Proposition N is therefore stronger than the naive one:
> *more to try than before, and every single one of them invisible.*

**Corollary 7.2 (the non-separating gluing morphism is killed too).** *The non-separating NS gluing
morphism [FKP, (7.9)],*
$$\overline{\mathfrak S}_{g;m+2,n}\longrightarrow\overline{\mathfrak S}_{g+1;m,n},$$
*cannot carry this method either.*

*Proof.* (7.9) glues two NS punctures **on the same curve**. If it is to carry the method, one of the
two glued points must be the moving point $p$ and the other a fixed point $q\in C$. The test base is
then $C\smallsetminus\{q\}$, again affine, and Steps 2–4 of Proposition 7.1 apply verbatim. $\square$

**Corollary 7.3 (Ramond punctures cannot go on the moving component either).** *Putting Ramond
punctures on the moving genus-$h$ component fails for the reason of Proposition 7.1, and
additionally for a second, independent reason: if the genus-$h$ side carries a non-zero Ramond
divisor $R$, then $L^{\otimes2}\cong\omega_C(R)$, and the identifications
$\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$ and $\mathcal T_+X_\eta\cong L^{-2}$ of (DW2) both fail
simultaneously, as does the step $\mathrm{Hom}(L^{-1},\mathcal T_C)\cong L^{-1}$ in the proof of
Lemma 6.1.* $\square$

> **Remark 7.4 (exactly what Proposition N does and does not assert).** Proposition N does **not**
> assert that $\overline{\mathfrak S}_{g;n,2r}$ is projected, and it is not a meta-theorem saying
> that no argument of this shape can work. It asserts that **this particular family of test curves
> returns zero identically**. That is enough to force the placement decision: the spectator punctures
> cannot sit on the moving component, so the only remaining option is the fixed tail — which §5–§6
> show does work.

> **Remark 7.5 (a by-product for [CN]).** [CN] uses a separating gluing with a constant elliptic tail
> and offers no motivation for either choice. Proposition N and Corollary 7.2 supply one: both
> choices are **forced** by the affineness obstruction, not selected for convenience.

---

## 8. Parity, corollaries, and the threshold in closed form

### The parity refinement

**Proposition 8.1 (parity refinement, $r=0$).** *Assume $r=0$. Then the test curve $i(C)$ lies in the
parity component $\overline S{}^{\varepsilon}_{g;n,0}$ with $\varepsilon=\mathrm{par}(N)$, and
consequently*
$$\omega_2\big(\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}\big)\neq0 .$$

*Proof.* For $r=0$ the generalized spin structure satisfies $L^{\otimes2}\cong\omega$ with no Ramond
twist ([FKP, §2.6]), so the parity $h^0\bmod2$ is locally constant on $\overline S_{g;n,0}$
(Mumford; Cornalba for stable spin curves) and
$\overline S_{g;n,0}=\overline S{}^+_{g;n,0}\sqcup\overline S{}^-_{g;n,0}$.

The tested curve $Z=C\cup_{p=q}F$ is of compact type with a single NS node. Its generalized spin
sheaf is given in the proof of [FKP, Lemma 7.9], verbatim
"$\mathcal O_Z\cong\mathcal O_{Z_0}\oplus j_*L\oplus j'_*L'$" — at an NS node the spin sheaf is not
locally free, and equals the sum of the direct images from the two branches. Hence
$$h^0\big(Z,\ j_*L\oplus j'_*N\big)=h^0(C,L)+h^0(F,N),\qquad
\mathrm{par}(Z)=\mathrm{par}(L)+\mathrm{par}(N)=\mathrm{par}(N),$$
the last step because $L$ is even. So the whole curve $i(C)$ lies in the component of parity
$\varepsilon=\mathrm{par}(N)$. Since $H^1$ of a disjoint union decomposes as a direct sum, the
non-zero class produced in Step 3 of Theorem 6.4 lives in the $H^1$ of that component, giving
$\omega_2(\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0})\neq0$. $\square$

### Eliminating $h$ and $a$

**Lemma 8.2.** *(i) $h\ge2$ cannot be weakened within this method. (ii) Tails of genus $a\ge2$ give
nothing beyond $a\in\{0,1\}$.*

*Proof.* (i) For $h=1$, $\deg L^{-1}=0$ and $L$ is a theta characteristic on an elliptic curve $E$;
if $L$ is even (a non-trivial $2$-torsion point) then $h^0(E,L^{-1})=0$ and, by Serre duality with
$\omega_E=\mathcal O_E$, $h^1(E,L^{-1})=h^0(E,L)^\vee=0$. So $H^1(C,L^{-1})=0$ and **no non-zero
$\eta$ exists at all**. For $h=0$, $L=\mathcal O(-1)$ and $h^1(\mathbb P^1,\mathcal O(1))=0$,
likewise. Hence (P1) is a genuine threshold of this technical route, not an oversight.

(ii) For $a\ge2$, (P2) holds automatically, but $g=h+a\ge2+a\ge4$, which is a worse threshold than
the one obtained from $a\in\{0,1\}$; and no new parity arises, since both parities are already
reached at $a=1$ (Lemma 5.2). $\square$

Now specialise Theorem 6.4 and Proposition 8.1.

- **$a=1$.** (P2) becomes $n+1+2r>0$, always true; $h=g-1\ge2\iff g\ge3$. For $r=0$ the tail is a
  genus-$1$ spin curve with $n+1$ NS markings, so $N^{\otimes2}\cong\mathcal O_E$ — *NS punctures do
  not twist $\omega$* — and **both parities occur** (Lemma 5.2).
- **$a=0$.** (P2) becomes $n+2r\ge2$; $h=g\ge2$. For $r=0$ (hence $n\ge2$) the tail's spin structure
  is forced to be $N=\mathcal O_{\mathbb P^1}(-1)$, with $h^0=0$, i.e. **even**.

**Corollary 8.3 (= Corollary A; pure NS punctures).**
*(A1) For every $g\ge3$, every $n\ge0$ and **both** parities $\varepsilon\in\{+,-\}$, the component
$\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}$ is non-projected. (Take $a=1$, $h=g-1\ge2$.)*
*(A2) For every $g\ge2$ and every $n\ge2$, the even component $\overline{\mathfrak S}{}^{+}_{g;n,0}$
is non-projected. (Take $a=0$, $h=g\ge2$.)*

**Corollary 8.4 (= Corollary B; Ramond punctures present).** *For every $g\ge2$, every $n\ge0$ and
every $r\ge1$, the stack $\overline{\mathfrak S}_{g;n,2r}$ is non-projected. (Take $a=0$, $h=g\ge2$;
(P2) holds automatically because $2r\ge2$.) Moreover, for every $g\ge3$, every $n\ge0$ and every
$r\ge0$, $\overline{\mathfrak S}_{g;n,2r}$ is non-projected (take $a=1$). No connected-component
refinement is claimed when $r>0$; see §10.3.*

**Corollary 8.5 (threshold, closed form).**
$$\boxed{\ \overline{\mathfrak S}_{g;n,2r}\ \text{is non-projected whenever}\quad g\ge 3,\ \ \text{or}
\ \ \big(g=2\ \text{and}\ n+2r\ge 2\big).\ }$$

*Proof.* Immediate from Corollaries 8.3, 8.4 and Lemma 8.2(ii): the union of the region reachable
with $a=1$ ($g\ge3$, any $n,r$) and the region reachable with $a=0$ ($g\ge2$ and $n+2r\ge2$) is
exactly the stated set, and $a\ge2$ adds nothing. $\square$

### Machine verification of the threshold arithmetic

The passage from (P1)–(P2) to Corollary 8.5, and the statement that $a\in\{0,1\}$ already suffices,
are pure integer arithmetic and have been verified by exhaustive enumeration.

- **Script:** `scripts/thresholds.py` (accompanying this manuscript).
- **Dependencies:** Python 3, standard library only.
- **How to run:** `python -X utf8 scripts/thresholds.py` (the `-X utf8` flag is only needed on
  Windows consoles with a non-UTF-8 code page).
- **Range enumerated:** $g\le8$, $n\le6$, $r\le4$, $a\le6$.
- **Runtime:** well under one second. **Exit code:** $0$.

The script checks five things: (1) the closed form of Corollary 8.5 agrees pointwise with the
enumeration of $(h,a)$ satisfying (P1)–(P2); (2) $(g,n,r)=(2,0,0)$ is **not** reachable (§9.2);
(3) at $g=2$ only the even parity component is reachable (§9.2); (4) for $n=r=0$ the reachable set is
exactly $g\ge3$, with $g=3$ forcing $a=1$, i.e. [CN]'s theorem is recovered (§9.1); (5) the
comparisons with the literature thresholds quoted in §1.4, including that $(g,n,r)=(2,1,0)$ is indeed
**not** covered.

> ⚠ **What the script does not do.** It checks *integer arithmetic only*. The structural assertions of
> §9.1 (that the construction degenerates to [CN]) and §9.2 (that the odd component at $g=2$ is
> structurally out of reach) are **not** machine-checkable by it; the script supplies only the
> arithmetic consistency that those assertions require. Those two were verified by hand.

---

## 9. Consistency checks

The checks in §9.1 and §9.2 were designed to *break* the argument: each has a known answer that the
method must reproduce, and §9.2 in particular would expose an error by producing a contradiction with
a published theorem. Both pass.

### 9.1 Degeneration to [CN]: $n=r=0$

When $n=r=0$, (P2) forces $a\ge1$; taking $a=1$, the tail is a one-NS-pointed elliptic spin curve
$(E,M,q)$ and
$$\mathcal B=\mathfrak S^+_{h;1,0}\times\mathfrak S_{1;1,0},$$
which is literally [CN]'s $\mathcal B^{\varepsilon}$. Theorem 6.4 degenerates verbatim into [CN,
Thm. 1.1(3)]: $g\ge3$, both parities. The construction therefore **reproduces [CN] on [CN]'s own
range**.

### 9.2 The method structurally cannot reach $\overline{\mathfrak M}{}^{-}_2$

[CN, Thm. 1.1(1)] proves that $\overline{\mathfrak M}{}^{-}_2=\overline{\mathfrak S}{}^-_{2;0,0}$ is
**split**, hence has $\omega_2=0$. If our construction could reach that object, we would contradict a
published theorem, and the error would be ours. Check $(g,n,r)=(2,0,0)$:

- $a=1\Rightarrow h=1$, violating (P1);
- $a=0\Rightarrow n+2r=0<2$, violating (P2).

Both routes are blocked. Going further: even when punctures are allowed ($g=2$, $n\ge2$), $a$ must
be $0$, and then the tail's spin structure is forced to be $\mathcal O_{\mathbb P^1}(-1)$, which is
**even**; so $\varepsilon=\mathrm{par}(L)+\mathrm{par}(N)=+$. **At $g=2$ the method can reach only the
even component, and structurally cannot reach the odd one.** This is fully compatible with [CN,
Thm. 1.1(1)] and is strong evidence that no hidden error is inflating our range.

A heuristic for *why* this is the right behaviour, which we state as such and do not claim to have
proved: [CN]'s splitting proof for $\overline{\mathfrak M}{}^{-}_2$ relies on features special to
unpunctured genus $2$ (every genus-$2$ curve is hyperelliptic and carries a distinguished odd theta
characteristic), none of which survives the addition of $n\ge2$ marked points.

### 9.3 No conflict with Donagi–Ott or Wang

Corollary 8.4 gives $g\ge2$ where [DO] requires $g\ge5r+1$ and [W] requires $g\ge n+5r+3$. The gap is
large and must be explained rather than advertised. **The assertions are about different objects.**
[DO] and [W] assert non-projectedness of the **uncompactified** $\mathfrak S_{g;n,2r}$; we assert
non-projectedness of the **compactified** $\overline{\mathfrak S}_{g;n,2r}$, and our non-zero class is
detected on a boundary test curve $i(C)\subset\Delta_{\rm NS}$. **Non-projectedness of the
compactification does not imply non-projectedness of the smooth locus.** Exactly the same relation
holds between [CN]'s $g\ge3$ and [DW]'s $g\ge5$: [CN] can do better precisely because it works on the
boundary. There is no contradiction, and no claim of improvement on [DO] or [W] as statements about
$\mathfrak S_{g;n,2r}$.

### 9.4 The forgetful-morphism objection, answered

**Objection.** [CN] already proves $\overline{\mathfrak S}{}^\varepsilon_{g;0,0}$ non-projected for
$g\ge3$. Take the puncture-forgetting morphism
$\pi\colon\overline{\mathfrak S}_{g;n,0}\to\overline{\mathfrak S}_{g;0,0}$; Lemma 4.2 gives
$j_\pi(\omega_2(\overline{\mathfrak S}_{g;n,0}))=\iota_\pi(\omega_2(\overline{\mathfrak S}_{g;0,0}))$,
and if the right-hand side is non-zero, Corollary A follows immediately. Is Corollary A free?

**Answer: no — the route has two gaps we cannot close.**

1. **The forgetful morphism on compactified supermoduli stacks has no support in the literature.** We
   searched [FKP] and [CN] for "forget": in [FKP] both occurrences are prose ("forget about the
   punctures") inside local computations and construct no morphism; in [CN] all three occurrences
   refer to forgetting the **spin structure** ($\overline S_g\to\overline M_g$), not punctures. The
   compactified case is genuinely non-trivial: when a marking collides with a node one must stabilise
   by inserting a rational bridge, and how a generalized spin structure is to be specified on that
   bridge in the supergeometric setting is, as far as we know, not treated anywhere.
2. **Even granting the morphism, non-vanishing of $\iota_\pi$ is the problem itself.** The map
   $\iota_\pi$ is "pull back by $\pi_0^*$", then "precompose with $\Lambda^2 d\pi_-$". The first half
   is injective ($\pi_0$ proper with connected fibres and $\pi_{0*}\mathcal O=\mathcal O$, so the
   Leray edge map is injective). The second half is induced by the sheaf **injection**
   $$\mathrm{Hom}(\pi^*\Lambda^2\mathcal T_-,\pi^*\mathcal T_+)\hookrightarrow
   \mathrm{Hom}(\Lambda^2\mathcal T_-,\pi^*\mathcal T_+),$$
   and **an injection of sheaves does not imply injectivity on $H^1$** — that would require surjectivity
   on $H^0$ of the cokernel, a global statement about the whole moduli stack which we can neither
   prove nor disprove. (For completeness: $d\pi_-$ on the odd tangent space of the Donagi–Witten
   family is $H^1(C,L^{-1}(-\sum p_i))\to H^1(C,L^{-1})$, which is surjective with $n$-dimensional
   kernel, the cokernel being a skyscraper with vanishing $H^1$; so $\Lambda^2 d\pi_-$ is indeed
   surjective and the composite is a sheaf injection. The obstruction is purely at the level of
   passing to $H^1$.)

**Conclusion.** The trivialisation route does not currently go through. Our construction is
unconditional and, in addition, locates the obstruction (Remark 6.5). But we state the value risk
plainly: **if someone closes both gaps, Corollary A becomes a corollary of [CN]** and its novelty
drops. **Corollary B is untouched by this**, because forgetting a Ramond puncture is not a morphism at
all — Ramond punctures are the branch locus of the superconformal structure, not marked points, a
point emphasised verbatim in [DO] ("Ramond punctures are not marked points!"). For this reason
**Corollary B is the most robust and least replaceable output of this paper**, and it is where we
would ask a reader to place the paper's weight.

---

## 10. Honest boundaries and open problems

### 10.1 [GAP-FKP-RAMOND]: an omission in an external proof

The **proof text** of [FKP, Lemma 7.9, p. 48] checks the generalized spin structures by writing, in
the source's own notation, *"Note that $L$ and $L'$ are generalized spin-structures, i.e., we have an
isomorphism $L\xrightarrow{\ \sim\ }\mathrm{Hom}(L,\omega_C)$…"* — i.e. **without the Ramond twist
$\omega_C(R)$** — although the *statement* (7.8) permits $n_1,n_2>0$ Ramond punctures. We judge this
a harmless omission: the gluing is a local operation in a neighbourhood of the NS node, which may be
taken disjoint from the Ramond divisor, and replacing $\omega_C$ by $\omega_C(R)$ is a verbatim
substitution there. **We have not independently rewritten that local computation, and we do not claim
to have done so.** The affected statement is Corollary 8.4 ($r\ge1$).

It should be recorded that the footprint of this gap is wider than the single lemma: [FKP, Lemma 8.7]
and [FKP, Cor. 8.8] are also stated for NS punctures only, and the proof of [FKP, Lemma 9.1(i)] cites
Cor. 8.8 ("we use the canonical trivializations … see Corollary 8.8"). So the entire derivation chain
leading to (9.6) runs on NS-only lemmas. This is **consistent with the design of this paper** — we
glue only at NS nodes, and all Ramond complexity is quarantined on the constant factor — and it is
**not a gap of this paper**. But anyone extending the method to Ramond-node gluing must complete that
whole chain, not merely Lemma 7.9.

### 10.2 The shortcut we refuse

[FKP, §9.3] formulates the Ramond-node analogue of the normal-line computation as a **conjecture**
(verbatim: *"We conjecture that the following diagram is commutative (up to a sign)"*), with no
proof. Gluing at Ramond nodes could give a shorter derivation and possibly a lower threshold, but the
resulting theorem would be conditional on an unproved conjecture. We therefore glue only at NS nodes
throughout. If that conjecture is later proved, new and possibly better constructions become
available.

### 10.3 [GAP-COMP]: no component refinement when $r>0$

For $r>0$ the generalized spin structure satisfies $L^{\otimes2}\cong\omega(R)$ and Mumford's parity
invariance no longer applies; we do not know whether $\overline S_{g;n,2r}$ is connected, nor which
discrete invariants label its components. Theorem 6.4 therefore asserts only that the **whole stack**
$\overline{\mathfrak S}_{g;n,2r}$ is non-projected — which is logically complete, since
$\omega_2\neq0$ suffices — and identifies no component. Refining to the component level requires a
classification of the connected components of $\overline S_{g;n,2r}$.

### 10.4 [GAP-ALT]: a value risk, not a mathematical gap

As explained in §9.4: if the compactified puncture-forgetting morphism is constructed and
$\iota_\pi\neq0$ is proved, Corollary A degenerates into a corollary of [CN]. Corollary B is
unaffected. This is a risk to the paper's novelty, not to its correctness.

### 10.5 Standard facts used without reproof

- **[GAP-STD]** The identifications $\mathcal T_+\mathfrak X|_X\cong\mathcal T_X$ and
  $\mathcal T\mathfrak X/\mathcal J\mathcal T\mathfrak X=\mathcal T_+\oplus\mathcal T_-$ are standard
  supergeometry (Manin; [DW, §2]; [CN, §2]) and are used without reproof.
- **[GAP-DW]** The construction of the Donagi–Witten one-point family and the identity
  $\omega_2(X_\eta)=\eta$ [DW, Prop. 3.4] are used as quoted verbatim in [CN, §5]; we did not
  independently re-derive them.

### 10.6 Not addressed

- Nothing is asserted about the **uncompactified** $\mathfrak S_{g;n,2r}$.
- Nothing is asserted in the **positive** direction (splitness or projectedness), in contrast with
  [CN, Thm. 1.1(1)].
- $(g,n,r)=(2,1,0)$ and the **odd**-parity punctured components at $g=2$ are completely open here;
  by §9.2 the method cannot reach them, and for the odd component at $g=2$ that is structurally
  required rather than accidental.
- Gluing at Ramond nodes is deliberately avoided (§10.2).

---

## 11. Conclusion

Reassembling the Corrêa–Noja elliptic-tail argument on the general punctured separating NS gluing
morphism of Felder–Kazhdan–Polishchuk, with all spectator punctures mounted on a **constant** tail,
shows that the compactified punctured supermoduli stack $\overline{\mathfrak S}_{g;n,2r}$ is
non-projected for $g\ge3$ (any $n$, any $r$) and for $g=2$ whenever $n+2r\ge2$; and, for $r=0$, that
both parity components are non-projected for $g\ge3$ and every $n\ge0$. The Donagi–Witten restriction
$n\le g-1$ disappears entirely, and the Ramond thresholds of Donagi–Ott and Wang are replaced by
$g\ge2$ in the compactified category, without using either of those results.

The complementary negative result is, in our view, the more structural of the two: mounting the
spectator punctures on the moving component degenerates the test base to an affine curve, Serre
vanishing annihilates the value group of the obstruction, and the route returns zero for every one of
the $2h-2+n$ available odd tangent vectors — more than in the unpunctured case, and all of them
invisible. Separating gluing with a constant tail is therefore forced, not chosen.

All external inputs are rigorous (§3); none is a conjecture or a physics-level argument. The
deliberately refused shortcut — Ramond-node gluing, which rests on an explicit conjecture in [FKP,
§9.3] — is recorded in §10.2 rather than taken.

---

## References

- **[CN]** M. Corrêa, S. Noja, *Compactified Supermoduli Space is Almost Never Projected*,
  arXiv:2606.06733 [math.AG] (2026).
- **[DN]** R. Donagi, S. Noja, *Genus 4 Supermoduli Space Is Not Projected*, arXiv:2608.24996
  [math.AG] (2026).
- **[DO]** R. Donagi, N. Ott, *Supermoduli Space with Ramond punctures is not projected*,
  arXiv:2308.07957 [math.AG] (2023).
- **[DW]** R. Donagi, E. Witten, *Supermoduli Space Is Not Projected*, arXiv:1304.7798 [hep-th]
  (2013); in: String-Math 2012, Proc. Sympos. Pure Math. **90**, Amer. Math. Soc. (2015), 19–71.
- **[FKP]** G. Felder, D. Kazhdan, A. Polishchuk, *The Moduli Space of Stable Supercurves and Its
  Canonical Line Bundle*, Amer. J. Math. **145** (2023), no. 6, 1777–1886; DOI
  `10.1353/ajm.2023.a913296`; arXiv:2006.13271 [math.AG].
- **[FKP2]** G. Felder, D. Kazhdan, A. Polishchuk, *Superperiods and Superstring Measure Near the
  Boundary of the Moduli Space of Supercurves*, arXiv:2408.11136 [math.AG] (2024). *(Source of the
  first proof that the compactified genus-two even component is non-projected, recalled as [CN,
  Thm. 1.1(2)]; not used in this paper.)*
- **[G]** P. Green, *On holomorphic graded manifolds*, Proc. Amer. Math. Soc. **85** (1982), no. 4,
  587–590.
- **[W]** T. Wang, *On the Nonprojectedness of Supermoduli with Neveu-Schwarz and Ramond Punctures*,
  arXiv:2512.15727 [math.AG] (2025). *Not used in any proof of this paper; the arXiv comment field
  describes it as a preliminary draft.*
- Mumford, D., *Theta characteristics of an algebraic curve*, Ann. Sci. École Norm. Sup. (4) **4**
  (1971), 181–192.
- Cornalba, M., *Moduli of curves and theta-characteristics*, in: Lectures on Riemann Surfaces
  (Trieste, 1987), World Scientific (1989), 560–589.
- Jarvis, T. J., *Geometry of the moduli of higher spin curves*, Internat. J. Math. **11** (2000),
  637–663. *(Cited via [FKP, §2.6] — where the relevant references are numbered [22], [23] — for
  smoothness and properness of the stack of stable spin curves with punctures. ⚠ [FKP] cites two
  papers of Jarvis; only one is listed here, and the pair must be completed before submission.)*
- Serre, J.-P., *Faisceaux algébriques cohérents*, Ann. of Math. **61** (1955), 197–278. *(Vanishing
  of higher coherent cohomology on affine schemes; used only in §7.)*

---

*Manuscript prepared: 2026-09-22. Draft — not submitted, not circulated.*
