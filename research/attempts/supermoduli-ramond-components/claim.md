# claim — Ramond 穿孔情形下紧化超模叠的连通分量分类

slug: `supermoduli-ramond-components`
开工日期：2026-09-23
角色：theorem-prover（原创证明尝试）

---

## 0. 这份 attempt 要回答的问题

`research/papers/supermoduli-punctured-nonprojected/paper.md` §10.3 登记了一条缺口
`[GAP-COMP]`，逐字如下（引自该论文 §10.3，**只读引用，本 attempt 不修改该论文**）：

> For $r>0$ the generalized spin structure satisfies $L^{\otimes 2}\cong\omega(R)$ and Mumford's
> parity invariance no longer applies; we do not know whether $\overline S_{g;n,2r}$ is connected,
> nor which discrete invariants label its components. … Refining to the component level requires a
> classification of the connected components of $\overline S_{g;n,2r}$.

也就是说：该论文的定理 B（Ramond 情形，$r\ge1$）只能断言**整个叠** $\overline{\mathfrak S}_{g;n,2r}$
非投影，不能像 $r=0$ 的 §8 那样落到具体的宇称分量上。任务是查明 $r\ge1$ 时的连通分量到底是什么，
以及每个分量是否非投影。

## 1. 记号（全部固定在本文件里，不依赖论文正文的上下文）

- $k=\mathbb C$。所有叠都是 $\mathbb C$ 上的 Deligne–Mumford 叠，"连通"指底层拓扑空间连通。
- $g\ge0$，$n\ge0$（NS 穿孔数），$r\ge0$（Ramond 穿孔**对数**，故 Ramond 穿孔个数为 $2r$）。
  记 $m:=n+2r$ 为标记点总数。恒设 $(g,m)$ 满足稳定性 $2g-2+m>0$。
- $C$：亏格 $g$ 的光滑射影曲线；$p_1,\dots,p_n$ 为 NS 穿孔，$\rho_1,\dots,\rho_{2r}$ 为 Ramond
  穿孔，全部互异。记 $R:=\rho_1+\cdots+\rho_{2r}$（一个约化有效除子），$P:=p_1+\cdots+p_n$。
- **广义自旋结构**（FKP §2.6，p.13，已由本 attempt 以 170 dpi 页图逐字核对）：曲线 $C$ 上的线丛
  $L$ 配一个同构
  $$L^{\otimes2}\;\xrightarrow{\ \sim\ }\;\omega_C(R).$$
  **注意 NS 穿孔不扭转 $\omega_C$，只有 Ramond 穿孔扭转。** 这是本 attempt 全部内容的物理来源：
  $r=0$ 与 $r\ge1$ 的差别只在这一个式子里。
  逐字原文：*"A generalized spin structure $L$ over a smooth curve $C$ with punctures is a line
  bundle $L$ equipped with an isomorphism $L^2\simeq\omega_C(r_1+\ldots+r_n)$, where $(r_\bullet)$
  are the Ramond punctures."*（FKP p.13；该句中的 $n$ 是 Ramond 穿孔数，与本文件的 $n$ **不同**，
  见 §5 记号陷阱。）
- $S_{g;n,2r}$：光滑广义自旋曲线 $(C;p_\bullet;\rho_\bullet;L,\ L^2\cong\omega_C(R))$ 的模叠，
  穿孔**有编号**（$p_i$ 与 $\rho_j$ 各自可区分）。
  $\overline S_{g;n,2r}$：其稳定紧化（Cornalba / Jarvis；FKP p.13 引 [22],[23] 说明它是光滑固有
  DM 叠）。
- $\overline{\mathfrak S}_{g;n,2r}$：FKP 的紧化超模叠。该论文引理 5.1 给出玻色截断
  $(\overline{\mathfrak S}_{g;n,2r})_{\rm bos}\cong\overline S_{g;n,2r}$。
- 对 $r=0$：$\mathrm{par}(L):=h^0(C,L)\bmod 2\in\mathbb Z/2$（Mumford 宇称）。
- $J[2]=\mathrm{Pic}^0(C)[2]\cong H_1(C;\mathbb Z/2)\cong(\mathbb Z/2)^{2g}$。

## 2. 要证的断言（量词完备）

**(C1)（主断言，Ramond 情形）** 对一切 $r\ge1$、一切 $g\ge0$、一切 $n\ge0$ 满足稳定性
$2g-2+n+2r>0$：模叠 $S_{g;n,2r}$ **连通**。

**(C2)（对照，NS 情形；已知结论的独立重证）** 对 $r=0$：
- $g\ge1$ 时 $S_{g;n,0}$ 恰有 **2** 个连通分量，由 $\mathrm{par}(L)\in\mathbb Z/2$ 分开；
- $g=0$ 时（须 $n\ge3$）连通，且该唯一分量是偶宇称（$L=\mathcal O_{\mathbb P^1}(-1)$）。

**(C3)（紧化与超叠）** (C1)(C2) 中的分量个数对紧化 $\overline S_{g;n,2r}$ 不变；又因超叠与其玻色
截断有**相同的底层拓扑空间**，再由论文引理 5.1，同样的分量个数对 $\overline{\mathfrak S}_{g;n,2r}$
成立。

**(C4)（对 `[GAP-COMP]` 的处置）** 由 (C1)+(C3)：$r\ge1$ 时 $\overline{\mathfrak S}_{g;n,2r}$
连通，因此"整个叠非投影"**已经就是**分量级陈述，`[GAP-COMP]` 对 $r\ge1$ **是空的**——不是"还没
做出来的加细"，而是"不存在可加细的对象"。

**(C5)（机制诊断）** 论文 §8 的宇称加细用到三步：(i) Mumford 宇称不变性给出
$\overline S_{g;n,0}=\overline S^+\sqcup\overline S^-$；(ii) NS 节点处自旋层的分解定出宇称的可加性；
(iii) 不交并的 $H^1$ 分裂。$r\ge1$ 时断在**第 (i) 步**，且断得**不可修复**：不是"Mumford 的证法
失效、另找一个证法即可"，而是**该不变量根本不存在**（由 (C1)，任何连续不变量都是常值）。

## 3. 反向自洽性检验（任何分量论证必须通过）

论文 §9.2 断言其方法"结构上不可能够到 $\overline{\mathfrak M}^-_2$"（Corrêa–Noja 已证后者是
分裂的）。§9.2 是纯 $r=0$、$n=0$ 的陈述。因此本 attempt 的 (C1) 必须**不触及** $r=0$，(C2) 必须
**重现**而不是推翻 $r=0$ 的两分量结构。若我的论证意外地把 $r=0$ 也证成连通，那就是论证错了。
这是本 attempt 的主要 sanity check。

## 4. 允许使用的砖块（及其档位）

- FKP p.13 §2.6：广义自旋结构定义；$\overline{\mathcal S}_{g,n_{NS},n_R}$ 是光滑固有 DM 叠
  （引 Jarvis [22],[23]）。**L1 页图逐字已核**。`rigorous`。
- FKP p.47 Prop 7.8(ii)：边界 $\Delta=\Delta_{NS}+\Delta_R$ 是有效 Cartier 除子；且在任一点
  $[X_0]$ 附近存在平展邻域 $B$ 与**光滑态射** $(t_1,\dots,t_k):B\to\mathbb A^k$，使 $\Delta$ 的理想
  由 $t_1\cdots t_k$ 生成。**L1 页图逐字已核**。`rigorous`。（用于 (C3) 的稠密性。）
- Mumford 1971 的 $h^0(L)\bmod2$ 不变性（仅 $L^2\cong\omega_C$，**不带扭转**）。标准，`rigorous`。
- Johnson 1980：自旋结构 ↔ $\mathbb Z/2$ 二次型 $q$，$q(x+y)=q(x)+q(y)+x\cdot y$。标准，`rigorous`。
- Birman 正合列与点推（point-pushing）子群；$\Gamma_{g,m}\twoheadrightarrow Sp(2g,\mathbb Z/2)$。
  标准，`rigorous`。
- Abel–Jacobi $\pi_1(C)\twoheadrightarrow H_1(C;\mathbb Z)$；平方映射
  $\mathrm{sq}:\mathrm{Pic}^{d}\to\mathrm{Pic}^{2d}$ 是 $J[2]$-Galois 覆叠。标准，`rigorous`。
- 论文引理 5.1（玻色截断）。该论文自身结果，`rigorous`（已过两轮对抗审查）。

**不使用**：Wang（`physical-argument`）、Donagi–Ott、FKP §9.3（原文逐字只是猜想）、任何 Ramond
节点处的粘接。这几条都会把结论压到 `conjecture` 或继承低档天花板。

## 5. 记号陷阱登记（引用 FKP 前必读）

1. FKP p.13 的定义句里 $L^2\simeq\omega_C(r_1+\ldots+r_n)$ 中的 $n$ 是 **Ramond 穿孔数**，
   与本文件的 $n$（NS 穿孔数）**含义相反**。
2. FKP p.47 Prop 7.8 里的 $r$ 是 **NS 节点的个数**；§2.6 里的 $r$ 是 "$r$-spin" 的旋量指标
   （$r=2$）；本文件的 $r$ 是 **Ramond 穿孔对数**。三者互不相同。
3. FKP 的 $m$ 有三重含义（已由上一轮 attempt 登记）：(8.11)/§8.4 是 NS 穿孔数；Lemma 9.1/9.3 是
   $\omega$ 的幂次；Lemma 7.10 证明里是除 $q$ 外的节点数。
4. FKP §7.5 起的分号记号 $\overline{\mathcal S}_{g;m,n}$ 与 §1/§5 的逗号记号
   $\overline{\mathcal S}_{g,n_{NS},n_R}$，原文**从未声明相等**。本 attempt 不依赖二者相等：
   所有断言都在 §1 自建的记号 $S_{g;n,2r}$ 下陈述，外部只取 FKP 的两条（§2.6 定义、Prop 7.8(ii)），
   这两条都不涉及该记号歧义。

## 6. 已知外部缺口对本 attempt 的影响

`[GAP-FKP-RAMOND]`：FKP §8.4–§9.1 整条链只对 NS 穿孔陈述。**本 attempt 不走那条链**
（不用 (9.6)、不用 Theorem C、不用 Example 8.9、不用 Lemma 8.7/Cor 8.8），故不受影响。
本 attempt 只用 FKP 的 §2.6 定义与 Prop 7.8(ii) 两条，两条都与 NS/Ramond 对称地陈述。

## 7. 攻法（开工时的计划，最终以 proof.md 为准）

两条独立路线，互为交叉检验：

- **路线 A（代数，主线）**：$S_{g;n,2r}\to M_{g,n+2r}$ 是次数 $2^{2g}$ 的有限平展覆叠，纤维是
  $\Theta_R=\mathrm{sq}^{-1}(\omega_C(R))$，一个 $J[2]$-torsor。连通 $\iff$ 单值群在纤维上传递。
  关键观察：$r\ge1$ 时，把 $\rho_1$ 沿 $C$ 中的闭路 $\alpha$ 推一圈，**除子本身变了**，
  $\omega_C(\rho_1(t)+\cdots)$ 在 $\mathrm{Pic}$ 里绕一个类为 $[\alpha]$ 的圈；平方覆叠的单值就是
  平移 $[\alpha]\bmod2$。$\pi_1(C\smallsetminus\{\text{其余标记点}\})\twoheadrightarrow
  H_1(C;\mathbb Z/2)$ 满，故仅"点推"就已传递。$r=0$ 时除子不依赖穿孔，这个单值**恒等于零**——
  恰好复现 Mumford 不变性。
- **路线 B（拓扑，给出概念性理由）**：$L|_{C\smallsetminus R}$ 是带孔曲面上的自旋结构 = Johnson
  二次型 $q$；交形式的根基由孔圈 $\gamma_j$ 张成，$q$ 在根基上线性 $\Rightarrow\sum_j q(\gamma_j)=0$
  （Ramond 孔 $q(\gamma_j)=1$ $\Rightarrow$ Ramond 穿孔数必偶，独立重现 FKP 的 "necessarily even"）。
  $q$ 能下降到闭曲面（从而有 Arf 不变量）当且仅当所有 $q(\gamma_j)=0$，即当且仅当 $r=0$。
- **路线 C（紧化）**：由 FKP Prop 7.8(ii) 的局部形式得 $S$ 在 $\overline S$ 中稠密，故分量不增不减。

计划的显式验证：$g=1,2r=2$（点推生成 $E[2]$）；$g=2,2r=2$（显式写出 $h^0(L)\bmod2$ 跳变的轨迹，
即 (C5) 的"不可修复"的具体见证）。

## 8. 本 attempt **不**断言的事

- 不断言任何"分裂 / 可投影"的正面方向。
- 不断言 $\overline{\mathfrak S}_{g;n,2r}$ 的**不可约性**（连通 + 光滑 $\Rightarrow$ 不可约，
  但只在确认光滑性的范围内；见 proof.md 对应处的讨论）。
- 不碰 Ramond 节点处的粘接（FKP §9.3 只是猜想）。
- 不修改 `research/papers/**`、`graph/**`、`formal/**`、`literature/**` 或任何其它 attempt 目录。
