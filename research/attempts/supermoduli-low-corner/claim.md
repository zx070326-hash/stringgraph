# Claim — projectedness/splitness of the two smallest surface-base supermoduli cells

Slug: `supermoduli-low-corner`.
Status of this file: precise statement of what is being attempted. See `proof.md` for what is
actually established and `status.yaml` for the lifecycle state.

## 0. Conventions (fixed once, used throughout)

All conventions are those of `research/papers/supermoduli-punctured-nonprojected/paper.md`
(read-only for this attempt), which in turn follows Felder–Kazhdan–Polishchuk (FKP),
*Regularity of the superstring supermeasure and the superperiod map*, arXiv:2006.13271, and
its sequel arXiv:2408.11136.

* $\overline{\mathfrak S}_{g;n,2r}$ denotes the FKP Deligne–Mumford compactification of the
  moduli superstack of stable $\mathcal N=1$ super Riemann surfaces of genus $g$ with $n$
  Neveu–Schwarz (NS) punctures and $2r$ Ramond punctures, over $\mathbb C$. It is a smooth
  proper Deligne–Mumford superstack of dimension
  $$\dim \overline{\mathfrak S}_{g;n,2r} \;=\; \bigl(\,3g-3+n+2r \;\bigm|\; 2g-2+n+r\,\bigr).$$
* $X := \overline{\mathfrak S}_{\bullet,\mathrm{bos}}$ is the bosonic truncation (the underlying
  even DM stack), $\mathcal J\subset\mathcal O_{\mathfrak X}$ the odd ideal,
  $\mathcal F_{\mathfrak X} := \mathcal J/\mathcal J^2$ (locally free on $X$ of rank equal to the
  odd dimension), $T_-\mathfrak X := \mathcal F_{\mathfrak X}^\vee$, $T_+\mathfrak X := T_X$.
* **Projected** means: the closed embedding $X\hookrightarrow\mathfrak X$ admits a retraction
  $\mathfrak X\to X$ of superstacks. **Split** means: $\mathfrak X\cong
  \mathbf{Spec}_X(\Lambda^\bullet \mathcal F_{\mathfrak X})$ as superstacks over $X$.
  Split $\Rightarrow$ projected always.
* $\omega_2(\mathfrak X)\in H^1\bigl(X,\;T_X\otimes\Lambda^2 T_-^\vee\mathfrak X\bigr)$ is
  Green's primary obstruction. We write
  $$\mathcal V_{\mathfrak X} \;:=\; T_X\otimes\Lambda^2 T_-^\vee\mathfrak X \;=\;
    T_X\otimes\det\mathcal F_{\mathfrak X}.$$
* $\overline{\mathfrak S}_{g;n,2r}$ carries a canonical $\mu_2$ acting on every fibre by the
  fermionic parity $(-1)^F$; every object has this in its automorphism group, so the stacks
  below are $\mu_2$-gerbes over their rigidifications.
* Spin conventions: a generalized spin structure on a punctured curve $(C;y_1,\dots,y_n;
  \rho_1,\dots,\rho_{2r})$ is $L$ with $L^{\otimes2}\cong\omega_C(\rho_1+\dots+\rho_{2r})$.
  **NS punctures do not twist $\omega_C$; only Ramond punctures do.**
* Node typing, verbatim from Corrêa–Noja arXiv:2606.06733 p.6 (checked against the rendered
  page image): *"A node is Ramond when $L$ is locally free at the node and Neveu–Schwarz when
  it is not locally free."*

## 1. The two cells

$$\mathbf{(A)}\quad \overline{\mathfrak S}_{1;2,0}\qquad\qquad
  \mathbf{(B)}\quad \overline{\mathfrak S}_{0;3,2}$$

Dimensions: $\dim\overline{\mathfrak S}_{1;2,0} = (3\cdot1-3+2+0\mid 2\cdot1-2+2+0) = (2\mid2)$
and $\dim\overline{\mathfrak S}_{0;3,2} = (0-3+3+2\mid 0-2+3+1) = (2\mid2)$.
Both have **odd rank exactly 2** and **bosonic base of dimension 2**.

Bosonic truncations:
* $X_A := (\overline{\mathfrak S}_{1;2,0})_{\mathrm{bos}}
   = \overline{\mathcal S}_{1;2,0}$, the stack of stable generalized spin curves of genus 1 with
   2 NS marked points. It has two connected components $\overline{\mathcal S}^-_{1;2,0}$ (odd,
   i.e. $h^0(L)$ odd) and $\overline{\mathcal S}^+_{1;2,0}$ (even), lying over
   $\overline{\mathcal M}_{1,2}$.
* $X_B := (\overline{\mathfrak S}_{0;3,2})_{\mathrm{bos}}
   = \overline{\mathcal S}_{0;3,2}$, lying over $\overline{M}_{0,5}$ (the quintic del Pezzo
   surface), connected.

Both cells lie **strictly below** the non-projectedness threshold of
`research/papers/supermoduli-punctured-nonprojected/paper.md` (its Corollary 8.5 reaches
$g\ge3$, or $g=2$ with $n+2r\ge2$), and below the thresholds of Donagi–Witten, Donagi–Ott and
Corrêa–Noja. So both are open in that framework.

## 2. Claims

Throughout, "$\mathfrak X$ is split" for a disconnected $\mathfrak X$ means split on every
connected component.

### Claim 1 (machinery, to be verified not imported)

Let $\mathfrak X$ be a smooth DM superstack over $\mathbb C$ with $\operatorname{rk} T_-\mathfrak X = 2$.
Then $\mathfrak X$ is split $\iff$ $\mathfrak X$ is projected $\iff$ $\omega_2(\mathfrak X)=0$.

### Claim 2 (uncompactified cells)

The open substacks $\mathfrak S_{1;2,0}\subset\overline{\mathfrak S}_{1;2,0}$ and
$\mathfrak S_{0;3,2}\subset\overline{\mathfrak S}_{0;3,2}$ of **smooth** super Riemann surfaces
are split.

### Claim 3 (structure of the bosonic truncations)

1. $\overline{\mathcal S}_{0;3,2}$ is a $\mu_2$-gerbe over the $\mu_2$-root stack
   $\mathcal X_0 := \sqrt[2]{\bigl(\overline M_{0,5},\,D_{12}+D_{13}+D_{23}+D_{45}\bigr)}$,
   where $1,2,3$ label the NS punctures and $4,5$ the Ramond punctures. The other six boundary
   divisors $D_{i4},D_{i5}$ ($i=1,2,3$) are Ramond-node divisors and carry **no** root structure.
2. $\overline{\mathcal S}^{\,-}_{1;2,0}$ is a $\mu_2$-gerbe over the $\mu_2$-root stack
   $\sqrt[2]{(\overline{\mathcal M}_{1,2},\,\Delta_{0,\{12\}})}$; the divisor $\Delta_{\mathrm{irr}}$
   is a Ramond-node divisor and carries no root structure.
3. $\overline{\mathcal S}^{\,+}_{1;2,0}\to\overline{\mathcal M}_{1,2}$ is, after rigidifying the
   $\mu_2$-gerbe, finite of degree 3, étale over $\mathcal M_{1,2}$, with a $\mu_2$-root
   structure along the preimage of $\Delta_{0,\{12\}}$.

### Claim 4 (negative: the only known positive technique does not apply)

Corrêa–Noja's inertia-character criterion (arXiv:2606.06733, Lemma 2.5) cannot prove
$\omega_2=0$ for either cell: for **every** finite étale surjective $p:Y\to X_A$ or $Y\to X_B$
and every bosonic inertia section $a$ over $Y$ acting on $p^*\mathcal V$ by a scalar $\chi$, one
has $\chi=1$.

### Claim 5 (the decision problem, reduced)

$\omega_2(\overline{\mathfrak S}_{0;3,2})$ lies in the image of
$H^1_{\partial}(X_B,\mathcal V)\to H^1(X_B,\mathcal V)$, i.e. it is supported on the boundary;
likewise for cell (A). Consequently: if $H^1(X,\mathcal V_{\mathfrak X})=0$ then the cell is
split.

### Claim 6 (the target dichotomy — what this attempt is trying to settle)

Exactly one of the following holds for each of (A), (B):
* $\omega_2=0$, hence the cell is **split** (a positive result: no split compactified
  supermoduli stack with $\ge2$ punctures and $2$-dimensional bosonic base is in the
  literature); or
* $\omega_2\ne0$, hence the cell is **non-projected**, which would place the obstructed region
  strictly below every published threshold.

`proof.md` records which of Claims 1–5 are established and exactly what remains for Claim 6.
