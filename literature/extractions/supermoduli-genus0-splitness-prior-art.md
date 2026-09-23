# 抽取记录：supermoduli-genus0-splitness-prior-art（专题 prior-art 检索）

- 任务：对以下命题做公开文献 prior-art 检索
  > 紧化亏格零、4 个 NS 穿孔的超模叠 $\overline{\mathfrak S}_{0;4,0}$（维数 $(1|2)$，
  > Felder–Kazhdan–Polishchuk 约定下的 Deligne–Mumford 型紧化）是 **split** 的
  > （等价地，奇秩 2 时其首要障碍类 $\omega_2$ 消失）。
- 抽取者：researcher（agent/researcher/supermoduli-genus0-splitness-prior-art）
- 日期：2026-09-23
- 性质：**这不是单篇文献的抽取记录**，而是一次跨文献的 prior-art 检索归档。按
  `literature/CLAUDE.md` 规则 3，本文件可追加不覆盖。
- **方法等级**（沿用 `felder-kazhdan-polishchuk-2020.md` 的 L0–L4 制）：
  - **L1** = 用 `Read` 工具直接渲染 PDF 页图像逐字核对（任务书硬性要求的等级）。
  - **L0/text-only** = 只有 `pdftotext` 文本，**未**经页图像核实；本文件中每条这样的条目
    都显式标注 `text-only`。

---

## 0. 结论摘要（详细证据见下面各条）

| 问题 | 裁定 |
|---|---|
| 主命题：$\overline{\mathfrak S}_{0;4,0}$ 是 split | **KNOWN（作为 supermanifold 层面的陈述）** —— Witten, arXiv:1209.2459 §5.1.3, p.54–55，**逐字问了同一个问题并给出肯定回答**，并给出显式 splitting（超交比）。见 E1/E2。 |
| 该陈述是"证明"还是"断言" | **显式构造 + 一句话论证**，不是编号定理、无证明环境。Witten 自陈这些 splitting "first described in" Nelson (Superstrings '88) 与 Giddings, CMP 143 (1992)。见 E3。 |
| 奇维 2 时 projected ⟺ split | **KNOWN 且是编号推论** —— Donagi–Witten, arXiv:1304.7798, **Corollary 2.3, p.19**。见 E4。 |
| 一般机制（奇秩 2 + 基是负典范次数曲线 ⟹ $\omega_2=0$，Serre 对偶） | **标准到"练习"的程度**：所需全部输入（$\omega_2 \in H^1(M,\mathrm{Hom}(\wedge^2T_-,T_+))$ 是唯一障碍、曲线上线丛 $H^1$ 的消失判据）都是教科书级。见 §3 的评估。 |
| $\mu_2$-gerbe over $\sqrt[2]{(\mathbb P^1,0+1+\infty)}$ 的显式识别 | **NOT FOUND（按此措辞）**。Witten p.55 末段用物理语言描述了**同一个几何**（一般点自同构 $\mathbb Z_2$、三个边界点跳到 $\mathbb Z_2\times\mathbb Z_2$、法丛须在 orbifold 意义下定义），但**未**使用 "gerbe" / "root stack" / "square root stack" 任何一个词，且他为此引的是 Deligne 致 Witten 的**私人信件** [49]（不可登记）。见 E5。 |
| 文献是否有**相反**陈述（亏格零超模非 split/有障碍） | **未发现**。所有已核查的非 projected 结果的量词都是 $g\ge 2$ 或 $g\ge 5$，亏格零被显式排除在外。见 §4。 |

---

## 陈述

### E1 ★ Witten 2012 §5.1.3：**逐字提出并肯定回答了本任务的主问题**（紧化版、维数 $1|2$）
- 文献：E. Witten, "Notes On Super Riemann Surfaces And Their Moduli", arXiv:1209.2459
  （Pure Appl. Math. Q. **15** (2019) no.1, 57–211）。本轮用的是 arXiv PDF
  （`curl -sL https://arxiv.org/pdf/1209.2459`，106 页；PDF 页码 = 排版页码 + 3）。
- 位置：**排版 p.54 末（PDF 第 57 页）**，§5.1.3 "Cross Ratios"。**L1（页图像逐字核实）**。
- 类型：proposition（但见 E3：非定理环境）
- 原文陈述（**逐字，L1**；记号 $\widehat{\ }$ 表示紧化，$\mathfrak M$ 为超模空间、
  $\mathcal M$ 为通常模空间）：
  > properly (fig. 1), in which $\Sigma_{\mathrm{red}}$ may split into two components. The
  > following reasoning will be more succinct if we concentrate on the compactification
  > $\widehat{\mathcal M}_{0,4}$. Similarly, we write $\mathfrak M_{0,4}$ for the moduli space
  > that parametrizes 4 distinct NS punctures in a genus 0 super Riemann surface, and
  > $\widehat{\mathfrak M}_{0,4}$ for its compactification.
  >
  > […]
  >
  > Now let us consider the supersymmetric case. The supermanifold
  > $\widehat{\mathfrak M}_{0,4}$ has dimension $1|2$. Is this supermanifold split?
  > (See section 2.3.1 of [32] for an explanation of this concept.)
- ⚠ **承重核实点**：`pdftotext` 输出把 $\widehat{\ }$ 全部丢掉，会让读者误以为讨论的是
  **未紧化**的 $\mathfrak M_{0,4}$。**页图像（PDF p.57）确认帽子存在**：问的确实是
  **紧化**对象 $\widehat{\mathfrak M}_{0,4}$，维数逐字为 $1|2$。这与任务书里的
  $\overline{\mathfrak S}_{0;4,0}$（dim $(1|2)$）是同一个对象（记号系统不同，见 §5 记号对照）。
- 文献自称的严格程度：见 E2/E3。
- 文献列出的依赖：[32] = Witten, "Notes On Supermanifolds And Integration", arXiv:1209.2459
  的姊妹篇 arXiv:1209.2199 —— ⚠ **原文参考文献表 [32] 写的是 "arXiv:1209.2459"，即本文自身的
  编号**，这是原文的一处**自引笔误**（正确编号应为 arXiv:1209.2199）。逐字记录，不替作者改。
  详见 §6 疑点 1。

### E2 ★ Witten 2012 §5.1.3 续：**肯定回答 + 显式 splitting 构造**
- 位置：**排版 p.55（PDF 第 58 页）**。**L1（页图像逐字核实）**。
- 类型：proposition（构造性论证）
- 原文陈述（**逐字，L1**）：
  > concept.) To get a "yes," answer, we just need to find a holomorphic map from
  > $\widehat{\mathfrak M}_{0,4}$ to $\mathbb{CP}^1$ that when the odd variables vanish
  > coincides with one of the above formulas. To get such a map, it suffices to have an
  > $OSp(1|2)$-invariant extension of the cross ratio that reduces to the cross ratio if the
  > odd variables vanish. There is no problem to find one. For example, a super extension of
  > the cross ratio $\Psi$ is given by the $OSp(1|2)$ invariant
  > $\widehat\Psi = \langle w_1,w_2\rangle\langle w_3,w_4\rangle /
  > \langle w_1,w_3\rangle\langle w_4,w_2\rangle$. In view of (5.7), in the usual
  > superconformal coordinates, this becomes
  > $$\widehat\Psi = \frac{(z_1-z_2-\theta_1\theta_2)(z_3-z_4-\theta_3\theta_4)}
  > {(z_1-z_3-\theta_1\theta_3)(z_4-z_2-\theta_4\theta_2)}. \qquad (5.13)$$
  > Obviously, $\widehat\Psi$ reduces to $\Psi$ if we set the $\theta$'s to 0. **The map from
  > $\widehat{\mathfrak M}_{0,4}$ to $\widehat{\mathcal M}_{0,4} = \mathbb{CP}^1$ is a
  > splitting of $\widehat{\mathfrak M}_{0,4}$.**
  >
  > There is a small catch. Obviously we could define another splitting by
  > $$\widehat\Psi' = \frac{(z_1-z_3-\theta_1\theta_3)(z_4-z_2-\theta_4\theta_2)}
  > {(z_1-z_4-\theta_1\theta_4)(z_2-z_3-\theta_2\theta_3)}. \qquad (5.14)$$
  > […]
  > So $\widehat{\mathfrak M}_{0,4}$ can be split in several fairly natural ways, but none of
  > these is entirely natural.
- 同页稍后（**逐字，L1**）明确把 splitting 与 projection 等同使用：
  > A splitting is a holomorphic projection $\pi : \widehat{\mathfrak M}_{0,4} \to
  > \widehat{\mathcal M}_{0,4}$. For $p$ a point in $\widehat{\mathcal M}_{0,4}$,
  > $\pi^{-1}(p)$ is a divisor in $\widehat{\mathfrak M}_{0,4}$.
- 同页末（**逐字，L1**）：所谓 "good splitting" 的额外条件（与 split 与否无关）：
  > Over the point $p_{ij} \in \widehat{\mathcal M}_{0,4}$ given by $z_i - z_j = 0$, there is
  > a distinguished divisor $\mathcal D_{ij} \subset \widehat{\mathfrak M}_{0,4}$ given by
  > $z_i - z_j - \theta_i\theta_j = 0$. A good splitting is one such that for each $i$ and
  > $j$, $\pi^{-1}(p_{ij}) = \mathcal D_{ij}$. By this criterion, none of the splittings that
  > we have described is satisfactory at each of the divisors at infinity.
- 文献自称的严格程度：**非定理环境**，行文为叙述式（"There is no problem to find one"），
  但给出了**完整显式的 splitting 公式**并验证了它在 $\theta\to0$ 时还原为交比。
  用 Donagi–Witten 的术语说，Witten 这里构造的是一个 **projection**（$\pi:\mathfrak M\to
  \mathcal M$ 限制到约化空间为恒等）；由 E4 的 Corollary 2.3（奇维 2 时 projected ⟺ split），
  在本情形二者等价，所以 Witten 称之为 "splitting" 是**正确的**，且这条等价性由同一批作者
  在下一年的论文里给出编号证明。
- 文献列出的依赖：$OSp(1|2)$ 不变量 $\langle\cdot,\cdot\rangle$（(5.4)/(5.7)，p.52）；
  亏格零超黎曼面必为 $\mathbb{CP}^{1|1}$ 且 split（§5.1.1，见 E6）。
- 备注：**任务书所列"物理侧 folklore 的 $OSp(1|2)$ gauge fixing 论证"在这里就是原文的
  实际论证**，且 Witten 是把它当作数学陈述来用的，不是当作 folklore 提一句。

### E3 ★ Witten 2012 §5.1.3 的**归属**：splitting 最早由 Nelson 1988 描述、Giddings 1992 细化
- 位置：**排版 p.55（PDF 第 58 页）**紧接 E2 引文之后 / **排版 p.55 末至 p.56 初**。
  **L1（页图像逐字核实，PDF 第 59 页 = 排版 p.56）**。
- 类型：归属说明
- 原文陈述（**逐字，L1**）：
  > The splittings of $\widehat{\mathfrak M}_{0,4}$ and their properties were first described
  > in [46], with more detail in [33]. The relevance to superstring perturbation theory is as
  > follows [47]. Although tree level scattering amplitudes at generic values of the external
  > momenta do not have the subtleties that occur in higher genus, some of these subtleties do
  > occur in tree level scattering amplitudes at special values of the momenta (such as
  > momentum zero). And moreover, as essentially also explained there, as well as in [46], in
  > general a procedure to compute these amplitudes by first integrating over the fibers of a
  > projection $\pi : \widehat{\mathfrak M}_{0,4} \to \widehat{\mathcal M}_{0,4}$ will only
  > give the right answer if $\pi^{-1}(p_{ij}) = \mathcal D_{ij}$. Otherwise a correction has
  > to be made at infinity.
- 参考文献表逐字（text-only，arXiv:1209.2459 参考文献表）：
  - `[33] S. Giddings, "Punctures On Super Riemann Surfaces," Commun. Math. Phys. 143 (1992)`
  - `[46] P. Nelson, "Some Simple Supermoduli Spaces," in Superstrings '88, ed. M. B. Green et. al.`
  - `[47] M. B. Green and N. Seiberg, "Contact Interactions In Superstring Theory," Nucl. Phys.`
  - `[48] R. Donagi and E. Witten, "Supermoduli Space Is Not Projected," arXiv:1304.7798.`
  - `[49] P. Deligne, letter to E. Witten (March 4, 2012).`
- 备注：**主命题的原始出处按 Witten 的归属应上溯到 Nelson 1988 与 Giddings 1992**，两者的原文
  获取情况见 §5「仍未取得原文的来源」。[49] 是**私人信件**，按 `literature/CLAUDE.md` 规则 1
  **不得登记**，仅在此如实记录 Witten 的引用行为。

### E4 ★ Donagi–Witten 2013 Corollary 2.3：奇维 2 时 **projected ⟺ split**，且 $\omega_2$ 是唯一障碍
- 文献：R. Donagi, E. Witten, "Supermoduli Space Is Not Projected", arXiv:1304.7798
  （Proc. Symp. Pure Math. **90** (2015) 19–71）。
  ⚠ 任务书写的是 arXiv:1304.2832；**正确编号是 1304.7798**（1304.2832 是另一篇无关论文）。
- 位置：**p.19**（§2.2.4 "Some immediate applications"）。**L1（页图像逐字核实）**。
- 类型：proposition（编号推论）
- 原文陈述（**逐字，L1**）：
  > **Corollary 2.3.** *A supermanifold $S$ of dimension $(m|2)$ is determined by the triple
  > $(M, V, \omega)$, where $\omega = \omega_2 \in H^1(M, \mathrm{Hom}(\wedge^2 T_-, T_+))$,
  > and any such triple arises from some $S$. A supermanifold of dimension $(m|2)$ is
  > projected if and only if it is split.*
  >
  > The last statement reflects the fact that $\omega_2$, which is the only obstruction to a
  > splitting when the odd dimension is 2, is also an obstruction to a projection.
- 同页前文（**逐字，L1**）：
  > Note in particular that $\omega_2^- = \omega_2$, so the vanishing of $\omega_2$ is a
  > necessary condition for a projection. (This follows more directly from the fact that $G^-$
  > is contained in $G^3$.) This is the only necessary criterion for projectedness that we
  > will use in the present paper.
- 文献自称的严格程度：编号推论，证明是一句话（"The last statement reflects the fact that…"），
  即 §2.2.1 的障碍理论（$G_i/G_{i+1} = T_{(-)^i}M \otimes \wedge^i V^*$，$\omega_i \in
  H^1(M, T_{(-)^i}M\otimes\wedge^i V^*)$）在 $\wedge^{\ge3}V^*=0$ 时的直接代入。
- 备注：这正是任务书里"等价地，奇秩 2 时 $\omega_2$ 消失"的**文献依据**，且是编号推论，
  不是 folklore。

### E5 ★ Witten 2012 §5.1.3 末：$\overline{\mathfrak S}_{0;4,0}$ 的 **orbifold 结构**描述
  —— 与 "$\mu_2$-gerbe over $\sqrt[2]{(\mathbb P^1,0+1+\infty)}$" 是同一个几何，但**措辞不同**
- 位置：**排版 p.56（PDF 第 59 页）**。（本轮已对
  p.56（PDF 第 59 页）做了页图像核实 —— **L1**。）
- 类型：definition/remark
- 原文陈述（**逐字，L1**）：
  > To understand $\widehat{\mathfrak M}_{0,4}$ more deeply, one has to describe its orbifold
  > structure. Let us discuss what happens along the reduced space
  > $\widehat{\mathfrak M}_{0,4,\mathrm{red}}$, which roughly speaking (ignoring the orbifold
  > structure) is the same as $\widehat{\mathcal M}_{0,4}$. Generically, along
  > $\widehat{\mathfrak M}_{0,4,\mathrm{red}}$, the automorphism group of $\Sigma$ is the
  > universal $\mathbb Z_2$ symmetry of split super Riemann surfaces generated by
  > $\sigma : \theta \to -\theta$. However, at the three points in
  > $\widehat{\mathfrak M}_{0,4,\mathrm{red}}$ at which $\Sigma$ splits into two components,
  > the automorphism group is enhanced to $\mathbb Z_2 \times \mathbb Z_2$, since one has a
  > separate $\mathbb Z_2$ symmetry group on each component. […] Thus, although roughly
  > speaking $\widehat{\mathfrak M}_{0,4,\mathrm{red}}$ is the same as
  > $\widehat{\mathcal M}_{0,4}$ and is a copy of $\mathbb{CP}^1$ parametrized by the cross
  > ratio, it is more accurate to think of it as an orbifold version of $\mathbb{CP}^1$, with
  > an automorphism group that is generically $\mathbb Z_2$ and jumps to
  > $\mathbb Z_2 \times \mathbb Z_2$ at the three points at infinity. The normal bundle to
  > $\widehat{\mathfrak M}_{0,4,\mathrm{red}}$ in $\widehat{\mathfrak M}_{0,4}$ is, roughly
  > speaking, a vector bundle over $\widehat{\mathfrak M}_{0,4,\mathrm{red}}$ of rank $0|2$,
  > but actually this vector bundle must be defined in the orbifold sense [49].
- 文献自称的严格程度：叙述性（"roughly speaking"、"it is more accurate to think of it as"），
  **没有**给出叠层面的精确定义或定理；把精确化外包给 Deligne 的**私人信件** [49]。
- 备注（**判定所需的关键区分**）：
  - Witten 描述的几何**就是**任务书里的对象：一般点自同构 $\mathbb Z_2$（= $\mu_2$-gerbe）、
    三个边界点 $\Psi\in\{0,-1,\infty\}$ 处自同构跳到 $\mathbb Z_2\times\mathbb Z_2$
    （= 在 $0+1+\infty$ 处取二次根的 root stack；⚠ Witten 的三个点是 $\{0,-1,\infty\}$，
    任务书写 $\{0,1,\infty\}$，差一个交比归一化约定，见 §6 疑点 2）。
  - **但 Witten 全文未出现 "gerbe" / "root stack" / "square root stack" 任何一个词**
    （`pdftotext` 全文 grep 确认，见 §6 疑点 3）。
  - **更要紧的是顺序问题**：Witten 的 splitness 论证（E2）写在**引入 orbifold 结构之前**，
    并且其 splitting 是"$\mathbb{CP}^1$ 上的全纯映射"这一 **coarse / supermanifold 层面**的
    陈述。他**没有**回头声明"在叠的意义下这个 splitting 仍然成立"。
    **本抽取不判定这个缺口是否实质**（那是推断，留给 curator / prover）；只如实记录：
    **Witten 的 split 陈述与他自己的 orbifold 精确化之间，原文没有接上。**

---

## 1. 相邻陈述的检索结果（任务书要求分别搜的几条）

### 1a. 未紧化 $\mathfrak S_{0;n,0}$（任意 $n$）的 split / projected
- **KNOWN**。Witten arXiv:1209.2459 **排版 p.56 首段（PDF 第 59 页，L1 页图像核实）**逐字：
  > What we have said about $\widehat{\mathfrak M}_{0,4}$ extends to $\widehat{\mathfrak
  > M}_{0,k}$ for all $k \ge 4$. By making use of the supersymmetric extension of the cross
  > ratio, one can always define holomorphic splittings $\pi : \widehat{\mathfrak M}_{0,k}
  > \to \widehat{\mathcal M}_{0,k}$. But there are many ways to do this and none is fully
  > satisfactory.
  ⚠ 注意这条逐字说的是**紧化**版（带帽），对**所有 $k\ge4$**。同样是叙述式、无定理环境。
  ⚠ 但也请注意：$k\ge5$ 时奇维 $= k-2 \ge 3$，**Corollary 2.3（E4）不再适用**，
  "存在 projection" 不自动等于 "split"。Witten 这里用的词是 "splittings"。
  **本抽取不判定 $k\ge5$ 时该措辞是否精确**，如实记录。
- **$OSp(1|2)$ gauge fixing 的显式坐标化**：同文 **p.53**（text-only）：
  > More generally, for any number $k$ of NS punctures, we can use $OSp(1|2)$ and scaling of
  > the homogeneous coordinates to map the first three to $1,0|0$, $0,1|0$, and $1,1|\eta$,
  > and the others to $1,z_i|\theta_i$, $i = 4,\dots,k$. The supermoduli space
  > $\mathfrak M_{0,k,0}$ (genus 0, $k$ NS punctures and no Ramond punctures) can thus be
  > parametrized by the $k-3$ even parameters $z_i$, $i=4,\dots,k$, along with the $k-2$ odd
  > parameters $\theta_i$, $i=4,\dots,k$ and $\eta$. This parametrization of the moduli space
  > is used in practice in computing superstring scattering amplitudes in genus 0.

- **Ott–Voronov 2019/2024 的独立显式商描述**（arXiv:1910.05655v4，**排版 p.3，L1 页图像核实**）：
  > One kind, the Neveu-Schwarz punctures, are entirely analogous to marked points on ordinary
  > Riemann surfaces, and their moduli are straightforward to understand. The moduli space
  > $\mathfrak M_{0,n_{\mathrm{NS}}}$ of genus zero super Riemann surfaces with
  > $n_{\mathrm{NS}} \ge 3$ Neveu-Schwarz punctures may be described just like in the classical
  > case:
  > $$\mathfrak M_{0,n_{\mathrm{NS}}} \cong \mathrm{Conf}(\mathbb{CP}^{1|1},
  > n_{\mathrm{NS}})/\mathrm{POSp}(1|2,\mathbb C),$$
  > where $\mathrm{Conf}(\mathbb{CP}^{1|1}, n_{\mathrm{NS}})$ denotes the configuration space of
  > $n_{\mathrm{NS}}$ distinct, labeled points on the complex projective superspace
  > $\mathbb{CP}^{1|1}$ and $\mathrm{POSp}(1|2,\mathbb C) = OSp(1|2,\mathbb C)/\{\pm\,\mathrm{id}\}$
  > stands for the projective orthosymplectic supergroup, which is also the supergroup of
  > automorphisms of $\mathbb{CP}^{1|1}$ preserving the standard SUSY structure on it, cf.
  > [Wit19a]. Note that the action of the group is free up to stabilizer $\mathbb Z_2$ and
  > therefore $\dim \mathfrak M_{0,n_{\mathrm{NS}}} = \dim \mathrm{Conf}(\mathbb{CP}^{1|1},
  > n_{\mathrm{NS}}) - \dim OSp(1|2,\mathbb C) = (n_{\mathrm{NS}} - 3, n_{\mathrm{NS}} - 2)$.
  ⚠ **重要限定**：这是**未紧化**的 $\mathfrak M_{0,n_{NS}}$，而且他们**没有使用 "split" 或
  "projected" 任何一个词来描述它**——只给了商描述与维数，并称其 moduli "straightforward to
  understand"。全文 grep 确认：`split` 一词在本文中只用于 "split supercurve / split superscheme"
  等局部技术意义，**从未**用于断言 $\mathfrak M_{0,n_{NS}}$ 本身是 split。
  ⚠ 另注：`Conf(\mathbb{CP}^{1|1},n)` 是 split 超概形的开子概形，但**超群商未必保持 splitness**，
  所以这条商描述**本身不构成** splitness 的证明。本抽取只如实记录，不做推断。

- **Bettadapura 2021 的二手归属（arXiv:2106.16035，排版 p.2，L1 页图像核实）** ——
  这是本轮找到的**第二条**独立指向同一结果的文献：
  > remarks by Witten in [Wit15a, Wit15b] strongly suggest non-splitting in the instance
  > $g = 3$, $n = 0$. **In genus $g = 0, n = 4$, Giddings in [Gid92] constructs a splitting
  > through generalizing the familiar cross ratio. This construction is suggested to split
  > supermoduli space for $g = 0$ and any $n$.** In the case $(g,n) = (1,0)$, supermoduli space
  > is split for dimensional reasons. For $g = 1$ and general $n$, supermoduli space appears to
  > split in light of the classical, one loop calculations by Green and Schwarz in [GS82].
  ⚠ Bettadapura 在同页 Remark（p.2 底至 p.3 顶，text-only）明确说明他考虑的是**未紧化**空间：
  > Remark. As an aside, note that the bound in (1) is on the marked points. Since the
  > supermoduli space we consider here is not compactified, the marked points will not collide.
  > Consequently, it might well imply the genus $g$, $n$-pointed supermoduli space will split
  > for $n$ sufficiently large. This was conjectured by Donagi and Witten in [DW15, Remark 1.5].
  **判定**：Bettadapura 把 $(g,n)=(0,4)$ 的 splitting **归属给 Giddings 1992**（不是 Witten），
  用词是 "constructs a splitting"（肯定语气），而把"任意 $n$"一般化的地位降为
  "**is suggested to** split"（非断言）。这与 Witten 的归属（E3，"first described in [46]
  = Nelson 1988, with more detail in [33] = Giddings 1992"）**大体一致但不完全相同**：
  Witten 把最早的功劳给 Nelson，Bettadapura 只提 Giddings。

### 1b. 紧化 $\overline{\mathfrak S}_{0;n,2r}$ 对小 $(n,r)$
- $r=0$：见 1a（Witten 的 $\widehat{\mathfrak M}_{0,k}$，$k\ge4$，**紧化**，逐字）。
- **FKP arXiv:2006.13271（紧化构造论文本身）不讨论亏格零的 split/projected 问题**：
  全文 `pdftotext` grep（`genus 0` / `genus zero` / `g = 0` / `split` / `projected`）确认，
  `split` 只出现在 "split exact sequence" / "$X$ is split, with $\mathcal O_X = \mathcal O_C
  \oplus L$"（§局部节点模型）等**局部技术**意义上，`projected` 只出现在**参考文献表**
  （[16] Donagi–Witten）里。**FKP 全文没有任何一处断言或否定任何 $\overline{\mathcal S}_{g,n_{NS},n_R}$
  的 splitness。**
- **Corrêa–Noja arXiv:2606.06733（"Compactified supermoduli space is almost never projected"）
  的量词显式排除亏格 0/1**（摘要逐字，text-only）：
  > We settle the projectedness problem for the compactified unpunctured supermoduli stack in
  > **every genus at least two**. In genus two, the odd component is split, whereas the even
  > component is non-projected. In every genus $g \ge 3$, both compactified parity components
  > are non-projected.
  即：**紧化情形已知的完整分类从 $g\ge2$ 开始，$g=0$ 不在其射程内**，且他们**未**声称
  $g=0$ 有障碍。

### 1c. "奇维 2 + 基是负典范次数曲线 ⟹ split" 的一般定理
- 见 §3 的评估。**叠层面的奇秩 2 判据已有编号命题**：Corrêa–Noja arXiv:2606.06733
  **Proposition 2.2, p.3（L1 页图像核实）**逐字：
  > **Proposition 2.2.** *Let $\mathfrak X$ be a smooth Deligne–Mumford superstack over
  > $\mathbb C$, and let $X = \mathfrak X_{\mathrm{bos}}$. There is a canonical primary
  > obstruction class*
  > $$\omega_2(\mathfrak X) \in H^1\!\left(X,\ T_X \otimes \textstyle\bigwedge^2
  > T_-^\vee \mathfrak X\right).$$
  > *It is compatible with étale pullback. If $\omega_2(\mathfrak X)\ne 0$, then $\mathfrak X$
  > is not projected. If $T_-\mathfrak X$ has rank two, then*
  > $$\mathfrak X \text{ is split} \iff \omega_2(\mathfrak X) = 0.$$
  同页前文（**逐字，L1**）：
  > A splitting induces a projection. Conversely, in odd rank two, projectedness and splitting
  > are equivalent by Green's obstruction theory: there are no higher Green obstructions beyond
  > the primary obstruction, see for example [6, 7].
  证明末段（text-only）：
  > Finally, when $T_-\mathfrak X$ has rank two, there are no odd exterior powers beyond degree
  > two and hence no higher Green obstructions. Thus vanishing of the primary obstruction is
  > equivalent to projectedness, and in odd rank two projectedness is equivalent to splitting.
  > This is the rank-two case of Green's obstruction theory, again in the form recalled in [7,
  > Corollaries 2.3–2.4].
  **这条把 Donagi–Witten 的 supermanifold 版 Corollary 2.3（E4）提升到了
  smooth DM superstack**，正是把 Witten 的 coarse 论证搬到叠上所缺的那一块（见 E5 备注）。
  ⚠ 但注意：它给的是**判据**（$\omega_2=0 \Rightarrow$ split），**不是**"负典范次数 ⟹
  $\omega_2=0$" 的消失定理。消失那一步仍要逐例算。

### 1d. $\mu_2$-gerbe over 平方根叠的显式识别
- 见 E5：**按此措辞 NOT FOUND**；同一几何被 Witten 用 orbifold 语言描述过。

### 1e. 物理文献里"亏格零超弦测度无超模障碍 / 四点树图可在 split 超模空间上算"
- **KNOWN**，见 E2/E3：Witten 逐字把这一点与 Green–Seiberg 的 contact interaction 联系起来，
  并逐字指出**在一般动量下树图没有高亏格那些微妙之处**，但在特殊动量（如零动量）处会出现，
  **且**"先沿 projection 的纤维积分"的做法只在 $\pi^{-1}(p_{ij})=\mathcal D_{ij}$ 时才给出
  正确答案，否则**要在无穷远处做修正**。⚠ 这是一条重要的限制：**split 成立 ≠ 纤维积分无修正**。

---

## 6. 发现的原文疑点

1. **Witten arXiv:1209.2459 参考文献 [32] 的自引编号错误**：正文多处（p.54 等）引 [32] 指的是
   "Notes On Supermanifolds And Integration"，但参考文献表逐字写
   `[32] E. Witten, "Notes On Supermanifolds And Integration," arXiv:1209.2459.` ——
   **1209.2459 是本文自身的 arXiv 编号**；"Notes On Supermanifolds And Integration" 的实际编号是
   **arXiv:1209.2199**。属原文笔误，如实记录。（text-only 观察，来源为参考文献表纯文本。）
2. **三个边界点的坐标**：Witten 的交比归一化使三个退化点落在 $\Psi\in\{0,-1,\infty\}$
   （p.54 逐字，L1：「The other points at infinity are $\Psi=0$ … and $\Psi=-1$ …」），
   任务书写的是 $0+1+\infty$。**差一个交比约定**，不是矛盾，但 curator 若要把两者写进同一张卡，
   必须显式声明用的是哪个交比。
3. **"gerbe" / "root stack" 在 arXiv:1209.2459 全文不出现**（`pdftotext` 全文 grep，
   大小写不敏感，零命中）。
4. **任务书给的 Donagi–Witten arXiv 编号 1304.2832 是错的**，正确为 **1304.7798**。

---

## 5. 仍未取得原文的来源（供船长手点）

（本轮检索中被 Witten 指为原始出处、但本轮**未拿到全文**的条目，列在 §5 续表，见后续追加。）
