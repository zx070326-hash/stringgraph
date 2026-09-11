# 抽取记录：polchinski-1998-v2，**§10.8「Divergences of type I theory」**（单节深读）

- 文献：J. Polchinski, *String Theory. Vol. 2: Superstring Theory and Beyond*, Cambridge University Press, 1998.
  **实际读的是 Cambridge Books Online 数字化本（© 2001, 2005），即 2005 平装本，已含 1999/2000 两次 "with corrections"。**
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**第 10 章 §10.8「Divergences of type I theory」，书页 pp. 37–42**
  （起点在 p.37 中段的小标题，终点在 p.42 末段；另核实了 pp.43–44 的习题页与 p.31 的前向引用）
- 与 `extractions/polchinski-1998-v2.md` 的关系：
  **本文件不覆盖该文件任何条目。** 该文件的 **E48** 把整个 §10.8 压成一条「要点」条目；
  本文件把 §10.8 拆成逐条陈述，**E 编号续该文件（该文件止于 E63，本文件从 E64 起）**。
  引用本文件的条目写 `polchinski-1998-v2-sec10-8.md#E<n>`。
  **本轮对 E48 有一处订正与若干补充，集中列在 §3.2。**
- 派工目的（lead，2026-09-11）：为图卡 `spectrum.type-i-tadpole-cancellation-so32` 找**真来源**。
  Vol.1 ch.7 §7.4 (7.4.24) 只给玻色弦的 `SO(8192)`，`SO(32)` 在那里只是一句前向指路
  （见 `extractions/polchinski-1998-v1-ch7.md` E38 / Q4 / §5-B2）。**本轮结论：Vol.2 §10.8 就是那个真来源。**

---

## 0. 获取路线与证据等级

### 0.1 本轮实际做了什么

| 步 | 做法 | 结果 |
|---|---|---|
| 1 | 由 `polchinski-1998-v2.md` §3.3 的 item hash 表直接取 ch.10 = `E69C35DC077FD0BAD6B39479144D4A12`，页范围 1–44 | 无需再 fetch 书目页 |
| 2 | 文件名按规则推出：`9780511618123c1_p1-44_CBO.pdf` | **一次命中** |
| 3 | `WebFetch` → 总结器以版权为由拒绝概括，但 **PDF 落盘 607.5 KB / 44 页**（≈ 13.8 KB/页，与 Polchinski 体积基准吻合） | 成功 |
| 4 | `Read(pages=36-44)` 一次读完 §10.8 全部正文 + 习题页 | 成功 |
| 5 | **关键页单页重渲染**：PDF p.38（(10.8.2)–(10.8.6)）、p.41（(10.8.9)–(10.8.14) + 脚注 8）、p.42（(10.8.15)–(10.8.19) + 结论段） | 三页复核，读数只在一处改变判断，见 §0.4 |
| 6 | **额外的一次跨节定点核对**：PDF p.31（§10.6 末段），为核对「§10.8 将给出 superconformal anomaly」这句前向承诺 | 成功，见 **E75** |

**PDF 落盘路径（本次会话内有效）**
`C:\Users\charles\.claude-apexin\projects\D--physics-string\c626835a-9cb2-486b-bf93-f345125de513\tool-results\webfetch-1789081727527-hjcsxw.pdf`

**PDF 页 ↔ 印刷页的换算：ch.10 起于书页 1，故 `印刷页 = PDF 页`（一一对应）。**

### 0.2 版本锚定（必须随引用带上）

页脚逐字：
`Downloaded from https://www.cambridge.org/core. … Cambridge Books Online © Cambridge University Press, 2010 …
subject to the Cambridge Core terms of use, available at https://www.cambridge.org/core/terms.
https://doi.org/10.1017/CBO9780511618123.004`

⇒ 与 `polchinski-1998-v2.md` §0.1 读到的是同一版。**引用写「Cambridge Books Online 数字化本（2005 平装）」。**

### 0.3 证据等级

- **本文件 §2 的全部条目一律 `L1（原书页图逐字）`**，除非条目内另标。
- 凡标「**逐字**」的引文是从页图上抄下来的英文原文；其余是抽取者的中文忠实转述。
- 本节**不需要**任何二手源（[H] Headrick 手册对 §10.8 无题可解，见 §3.1 第 5 条）。

### 0.4 ★ 两次独立算术交叉核验（方法论留痕，本轮最重要的两条工序）

**(a) `(n ∓ 32)²` 的复算 —— 页图读数得到确认。**
把三个面的 R–R 发散按本节给出的系数相加：

- 圆柱：`Z_{C₂,1} = −Z_{C₂,0} = −i·n²·K`（(10.8.2b)+(10.8.4)）
- Klein 瓶：`Z_{K₂,1} = −Z_{K₂,0} = −i·2¹⁰·K`（(10.8.11)）
- Möbius：`Z_{M₂,1} = ±2i·n·2⁵·K`（(10.8.18)，上号为 `SO(n)`）

其中 `K ≡ (V₁₀/(8π(8π²α')⁵))∫₀^∞ ds[16 + O(exp(−2s))]` 是三者的**公因子**。相加：

`−i·K·[n² + 2¹⁰ ∓ 2·32·n] = −i·K·(n ∓ 32)²`，因为 `2¹⁰ = 32²`。

⇒ **恰好是 (10.8.19)，且上号（`n − 32`）确实对应 `SO(n)`**，与 (10.8.18) 的「the upper sign is for `SO(n)`」自洽。
**这条复算同时独立验证了 (10.8.2)/(10.8.11)/(10.8.18)/(10.8.19) 四式的系数彼此自洽，以及 `2¹⁰` 与 `2⁵` 两个读数。**

**(b) ⚠ `α'` 的幂次 —— 页图读数与复算冲突，本轮唯一一处。**
页图上**七处**（(10.8.4) 两行、(10.8.11) 两行、(10.8.18) 两行、(10.8.19) 一处）的分母都**看起来**是
`8π(8π²α′²)⁵`；而同一批公式的 `t` 形式（(10.8.2a,b)、(10.8.11) 首行、(10.8.18) 首行）清楚地是
`(8π²α′t)^{−5}` 与 `(4π²α′t)^{−5}`，**只有一撇、没有平方**。

抽取者**未改读数，改为独立复算**（同 ch.7 §0.4 的手法）。以圆柱为例，`s = π/t`：

- `∫₀^∞ dt/(8t) → ∫₀^∞ ds/(8s)`；
- `(8π²α't)^{−5} = s⁵/(8π³α')⁵`；
- `η(it)^{−8} = η(iπ/s)^{−8} = (π/s)⁴ η(is/π)^{−8}`（用 (10.8.3)）；
- 合并：`(1/8s)·s⁵/(8π³α')⁵·π⁴/s⁴ = π⁴/(8(8π³α')⁵) = 1/(262144 π¹¹ α'⁵)`，`s` 恰好抵消 ✓；
- 而 `1/(8π(8π²α')⁵) = 1/(8π·32768π¹⁰α'⁵) = 1/(262144 π¹¹ α'⁵)` ✓**完全相等**；
- 若取 `(8π²α'²)⁵` 则差一个 `α'⁵`，且量纲不对（`V₁₀` 需要 `length¹⁰`，`(8π²α')⁵` 正好给 `length¹⁰`）。

Klein 瓶（`s = π/2t`，`(4π²α't)^{−5}`）复算同样给出 `2¹⁰/(8π(8π²α')⁵)` ✓。

⇒ **正确的量是 `(8π²α')⁵`。** 页图上多出来的那个上标要么是渲染中 prime 的假象，要么是原书的排印错误
（Vol.1 的对应式 (7.4.3)/(7.4.19)/(7.4.23) 用的是 `(8π²α')¹³`，与此一致）。
**⚠ `polchinski-1998-v2.md` E48 沿用了页图读数写成 `(8π²α'²)⁵`，应按本条订正。**
**但请注意：这个前缀是三个面的公因子，`(n ∓ 32)²` 与 `SO(32)` 结论完全不受影响。**

---

## 1. 约定（§10.8 内实际用到的）

§10.8 不引入新约定。用到的、且**在别处定义**的记号：

| 项 | 取法 | 定义位置 |
|---|---|---|
| `Z^α_β(τ)` | `Tr_α[q^H exp(πiβQ)] = ϑ[α/2, β/2](0,τ)/η(τ)`，**且「these traces are for a *pair* of dimensions」** | §10.7 (10.7.7a–c)、(10.7.8a–d)（= `polchinski-1998-v2.md` E47） |
| 费米迹 | `Z_ψ^±(τ) = ½[Z⁰₀⁴ − Z⁰₁⁴ − Z¹₀⁴ ∓ Z¹₁⁴]`，8 个横向费米子 = 4 对 ⇒ 幂次为 4 | §10.7 (10.7.9) |
| `n` | Chan–Paton 自由度数；**`Sp(k)` 在本书记号下对应 `n = 2k`** | Vol.1 §7.4 p.228（本节经 (7.4.22) 继承） |
| `s` ↔ `t` | **`s = π/t`（圆柱）、`π/4t`（Möbius）、`π/2t`（Klein 瓶）**，逐字见 p.40 | §10.8 p.40 |
| `α'`、度规号差 | 沿用全书 | — |

**与 `graph/conventions/` 的关系：本节没有出现与 canonical 约定冲突的东西，无需换算。**

⚠ 一条**必须显式带上**的归一化约定（p.38 逐字）：
「**Note that the GSO and Ω projection operators each contribute a factor of ½.**」
——这是 Vol.2 的 `dt/8t` 相对 Vol.1 (7.4.1) 的 `dt/2t` 多出两个 ½ 的来源。

---

## 2. 陈述（E64 起）

### E64 §10.8 的纲领句：tadpole 相消**取代**模群的角色 ★★
- 位置：**§10.8 开头段，p. 37**（小标题下第一段）`[L1 原书]`
- 类型：（纲领性陈述）
- **原文逐字**：
  > 「The cylinder, Möbius strip, and Klein bottle have no direct analog of the modular group, but **the condition that the tadpole divergences cancel among these three graphs plays a similar role in restricting the possible consistent theories.** The cancellation is very similar to what we have already seen in the bosonic theory in chapter 7. The main new issue is the inclusion of the various sectors in the fermionic path integral, and in particular the separate contributions of closed string NS–NS and R–R tadpoles.」
- 文献自称的严格程度：纲领声明（"plays a similar role"）
- 文献列出的依赖：**Vol.1 第 7 章**（明写）；§10.7 的模不变性讨论（对照）
- 备注：★★ 这句给出了本节在本书论证体系中的**认识论地位**：
  它**不是**从某条更基本的原理推出的一致性条件，而是与「闭弦要模不变」平行的、**另一条被假定的一致性要求**。
  → curator 若建 tadpole 相消节点，statement 里应写明「作者把它类比为模不变性的角色」，
  且注意 Vol.1 §7.1（ch.7 E3）逐字说过圆柱「**Unlike the torus there is no modular group**」——两处口径一致。

### E65 圆柱振幅：由玻色结果 + 费米迹拼出来，并按 `exp(πiF)` 分成两项 ★
- 位置：**§10.8「The cylinder」，(10.8.1)、(10.8.2a,b)，pp. 37–38** `[L1 原书]`
- 类型：proposition
- **原文逐字（构造方式）**：
  > 「Consider first the cylinder, shown in figure 10.1(a). **One can immediately write down the amplitude by combining the bosonic result (7.4.1), converted to ten dimensions, with the fermionic trace (10.7.9) from one side of the type II string.** We write it as a sum of two terms,」
- **公式（逐字）**：
  - `Z_{C₂} = Z_{C₂,0} + Z_{C₂,1}`（**10.8.1**）
  - `Z_{C₂,0} = iV₁₀n² ∫₀^∞ (dt/8t)(8π²α't)^{−5} η(it)^{−8} [ Z⁰₀(it)⁴ − Z¹₀(it)⁴ ]`（**10.8.2a**）
  - `Z_{C₂,1} = iV₁₀n² ∫₀^∞ (dt/8t)(8π²α't)^{−5} η(it)^{−8} [ −Z⁰₁(it)⁴ − Z¹₁(it)⁴ ]`（**10.8.2b**）
- **物理解释（逐字）**：
  > 「Note that the GSO and Ω projection operators each contribute a factor of ½. We have separated the terms according to whether `exp(πiF)` appears in the trace. In `Z_{C₂,0}` it does not, and so the `ψ^μ` are antiperiodic in the `σ²` direction. In `Z_{C₂,1}` it does appear and the `ψ^μ` are periodic. We can also regard the cylinder as a closed string appearing from and returning to the vacuum as in figure 10.1(b); we have used this idea in chapters 7 and 8. **The periodicities of the `ψ^μ` mean that in terms of the closed string exchange, the part `Z_{C₂,0}` comes from NS–NS strings and the part `Z_{C₂,1}` from R–R strings.**」
- 文献自称的严格程度：「**One can immediately write down**」——**不推导，直接拼装**
- 文献列出的依赖：**Vol.1 (7.4.1)**（明写）、**(10.7.9)**（明写）
- 备注：★ 「哪一项是 NS–NS 交换、哪一项是 R–R 交换」这个**识别**是靠世界面费米子的周期性论证，
  它是后面全部「NS–NS 与 R–R tadpole 必须分别为零」讨论的技术前提。

### E66 超对称 ⇒ 两项等值反号；模变换与发散的提取 ★
- 位置：**§10.8，(10.8.3)、(10.8.4)，p. 38** `[L1 原书]`
- 类型：proposition
- **原文逐字**：
  > 「**We know from the previous section that the total fermionic partition function vanishes by supersymmetry, so that `Z_{C₂,1} = −Z_{C₂,0}`;** we concentrate then on `Z_{C₂,0}`. Using the modular transformations」
- **公式（逐字）**：
  - `η(it) = t^{−1/2}η(i/t)` ,  `Z^α_β(it) = Z^β_{−α}(i/t)`（**10.8.3**）
  - 「and defining `s = π/t` this becomes」
    `Z_{C₂,0} = i (V₁₀n²/(8π(8π²α')⁵)) ∫₀^∞ ds η(is/π)^{−8}[Z⁰₀(is/π)⁴ − Z⁰₁(is/π)⁴]`
    `        = i (V₁₀n²/(8π(8π²α')⁵)) ∫₀^∞ ds [16 + O(exp(−2s))]`（**10.8.4**）
    ⚠ 前缀的 `α'` 幂次见 §0.4(b)。
- **发散的诊断（逐字）**：
  > 「The divergence as `s → ∞` is due to a massless closed string tadpole, which as noted must be an NS–NS state. Thus we identify this as a dilaton plus graviton interaction `(−G)^{1/2}e^{−Φ}` coming from the disk, as in the bosonic string.」
- 文献自称的严格程度：计算（模变换是机械的）；`Z_{C₂,1} = −Z_{C₂,0}` **归约到 §10.7 的超对称论证**
- 文献列出的依赖：**§10.7**（明写）；(10.8.2)
- 备注：`[16 + O(exp(−2s))]` 的 `16` 是十维无质量态计数（对照 Vol.1 (7.4.4) 的 `24`）。
  ⚠ 注意 (10.8.3) 的第二式 `Z^α_β(it) = Z^β_{−α}(i/t)` 是 §10.7 (10.7.14) 的特例，
  而 (10.7.14) 在原书里**明确带有「naive」的限定**（`polchinski-1998-v2.md` E47 逐字：
  「The reason these modular transformations are naive is that there is no diff-invariant way to define the phase
  of the path integral for purely left-moving fermions」）。§10.8 直接使用而**不重述这个限定**。

### E67 ★★ 悖论与其「猜出来的」解决：10-form 势 `C₁₀`
- 位置：**§10.8，(10.8.5)、(10.8.6)，pp. 38–39** `[L1 原书]`
- 类型：proposition（含大段物理论证）
- **悖论（逐字）**：
  > 「However, **there is a paradox here**: the `d = 10`, `N = 1` supersymmetry algebra does not allow such a term. Even more puzzling, `Z_{C₂,1}` has an equal and opposite divergence which must be from a tadpole of an R–R state, but the only massless R–R state is the rank 2 tensor which cannot have a Lorentz-invariant tadpole.」
- **解决（逐字，注意开头的强度词）**：
  > 「**One can guess the resolution of this as follows.** The type IIB string has rank `n` potentials for all even `n`, with `n` and `8 − n` equivalent by Poincaré duality. The Ω projection removes `n = 0` and its equivalent `n = 8`, as well as `n = 4`: all the multiples of four. This leaves `n = 2`, its equivalent `n = 6` — and `n = 10`. **A 10-form potential `C₁₀` can exist in ten dimensions but its 11-form field strength `dC₁₀` is identically zero.** The integral of the potential over spacetime」
  - `μ₁₀ ∫ C₁₀`（**10.8.5**）
  > 「is invariant under `δC₁₀ = dχ₉` and so can appear in the action. Since there is no kinetic term the propagator for this field is `1/0`, and the effect of the tadpole is a divergence」
  - `μ₁₀² / 0`（**10.8.6**）
  > 「**This must be the origin of the divergence in `Z_{C₂,1}`, as indeed a more detailed analysis does show.** The equation of motion from varying `C₁₀` is just `μ₁₀ = 0`, so unlike the divergences encountered previously **this one cannot be removed by a correction to the background fields. It represents an actual inconsistency.**」
- 文献自称的严格程度（**逐字**）：「**One can guess the resolution**」＋「**as indeed a more detailed analysis does show**」
  ——**那个 "more detailed analysis" 本书不给、不引文献。**
- 文献列出的依赖：type IIB 的 R–R 谱（§10.6，E42 的 (10.6.8b)）；Ω 投影（§10.6，E45）
- 备注：★★ 这是本节**最弱的一环**，且它承载着整节的关键结论——
  「R–R 发散代表**真正的不一致**（而不是像别处那样可以靠修正背景场吸收）」这一判断，
  完全建立在一个 "guess" + 一个未给出的 "more detailed analysis" 上。
  → 若图里要建「type I 的 R–R tadpole 是不可去除的不一致」这条**独立命题**，
  `status` 不得高于 `physical-argument`，且 note 必须抄这两句强度词。

### E68 三个面的 tadpole 求和结构，与「NS–NS 与 R–R 必须分别为零」★★
- 位置：**§10.8「The Klein bottle」开头两段 + 脚注 7，pp. 39–40** `[L1 原书]`
- 类型：proposition
- **原文逐字**：
  > 「We know from the study of the bosonic string divergences that there is still the possibility of canceling this tadpole as shown in figure 10.2. **The cylinder, Möbius strip, and Klein bottle each have divergences from the massless closed string states, the total being proportional to square of the sum of the disk and `RP₂` tadpoles.**[sic：原文如此，"proportional to square of" 缺冠词] **The relative size of the two tadpoles depends on the Chan–Paton factors, and cancels for a particular gauge group.**⁷」
- **几何/变量的统一（逐字）**：
  > 「The relation of the Möbius strip and Klein bottle as depicted in figure 10.2 to the twisted-strip and twisted-cylinder pictures was developed in **section 7.4**, and is shown in figure 10.3. In order to sum as in figure 10.2, one must rescale the surfaces so that the circumference in the `σ²` direction and length in the `σ¹` directions are uniform; we have taken these to be `2π` and `s` respectively. From figures 10.1 and 10.3 it follows that **`s` is related to the usual modulus `t` for these surfaces by `s = π/t`, `π/4t`, and `π/2t` for the cylinder, Möbius strip, and Klein bottle respectively.**」
- **★ 脚注 7（p. 39，逐字，本节最容易被漏掉的技术要点）**：
  > 「In the vacuum amplitude **the sum of the NS–NS and R–R divergences is zero for each topology separately** because the trace vanishes by supersymmetry. **This is not sufficient**, because they will no longer cancel when vertex operators are added near one end of each surface. **The NS–NS and R–R tadpoles must vanish separately when summed over topologies.**」
- 文献自称的严格程度：正文是构造性描述；**脚注 7 的「must vanish separately」是断言**（给了理由但无计算）
- 文献列出的依赖：**Vol.1 §7.4**（明写）；E66
- 备注：★★ **这条决定了 `SO(32)` 结论的逻辑形式**：
  条件不是「真空振幅有限」（那由超对称对每个拓扑自动成立），
  而是「**NS–NS tadpole 与 R–R tadpole 分别在拓扑求和后为零**」。
  → 转节点时必须把这个限定写进 statement，否则该卡是错的。

### E69 Klein 瓶：边界条件、扇区归属与振幅 ★
- 位置：**§10.8，(10.8.7)–(10.8.11) 与脚注 8，pp. 40–41** `[L1 原书]`
- 类型：proposition
- **公式（逐字）**：
  - GSO 投影算符（Klein 瓶上）：`[(1 + exp(πiF))/2] · [(1 + exp(πiF̃))/2]`（**10.8.7**）
  - 「With `R = Ω exp(πiβF + πiβ̃F̃)` in the trace, the path integral boundary conditions are」
    `ψ(w + 2πit) = −Rψ(w)R^{−1} = −exp(πiβ) ψ̃(w̄)`（**10.8.8a**）
    `ψ̃(w̄ + 2πit) = −Rψ̃(w̄)R^{−1} = −exp(πiβ̃) ψ(w)`（**10.8.8b**）
    「with the usual extra sign for fermionic fields.」
  - 「As indicated by the arrows in figure 10.3, these imply that」
    `ψ(w + 4πit) = exp[πi(β + β̃)] ψ(w)`（**10.8.9**）
  - 「The NS–NS exchange, from the sectors antiperiodic under `σ² → σ² + 4πt`, then comes from traces weighted by
    `Ω exp(πiF)` or `Ω exp(πiF̃)`; further, **these two traces are equal**. Both NS–NS and R–R states contribute to the traces,
    making the separate contributions⁸」
    NS–NS:  `q^{−1/3} ∏_{m=1}^∞ (1 + q^{2m−1})⁸ = Z⁰₀(2it)⁴`（**10.8.10a**）
    R–R:   `−16 q^{2/3} ∏_{m=1}^∞ (1 + q^{2m})⁸ = −Z¹₀(2it)⁴`（**10.8.10b**）
    「where `q = exp(−2πt)`.」
  - 「The full Klein bottle contribution to the NS–NS exchange is then」
    `Z_{K₂,0} = iV₁₀ ∫₀^∞ (dt/8t)(4π²α't)^{−5} η(2it)^{−8}[Z⁰₀(2it)⁴ − Z¹₀(2it)⁴]`
    `        = i (2¹⁰V₁₀/(8π(8π²α')⁵)) ∫₀^∞ ds η(is/π)^{−8}[Z⁰₀(is/π)⁴ − Z⁰₁(is/π)⁴]`
    `        = i (2¹⁰V₁₀/(8π(8π²α')⁵)) ∫₀^∞ ds [16 + O(exp(−2s))]`（**10.8.11**）
  - 「and `Z_{K₂,1} = −Z_{K₂,0}`. **The bosonic part is (7.4.15) converted to `D = 10`.**」
- **★ 脚注 8（p. 41，逐字，一条重要的认识论线索）**：
  > 「In evaluating these, note that only states with identical `ψ` and `ψ̃` excitations contribute to traces containing `Ω`. The signs from `exp(πiF)` or `exp(πiF̃)` just cancel the signs from anticommuting `ψ`s past `ψ̃`s, so that all terms in each trace have the same sign. **The overall sign in the NS–NS trace (positive) can be determined from the graviton, and the overall sign in the R–R trace (negative) from the argument (10.6.17).**」
- 文献自称的严格程度：计算，但**两个整体符号不是算出来的**（脚注 8 逐字：一个由引力子定、一个由 (10.6.17) 的论证定）
- 文献列出的依赖：**Vol.1 (7.4.15)**（明写）、**(10.6.17)**（明写，即 `polchinski-1998-v2.md` E45 的 `Ṽ_{s'}V_s = −V_sṼ_{s'}`）
- 备注：★ `2¹⁰` 这个数与 Vol.1 (7.4.19) 的 `2²⁶` 对应（见 **E74**）。
  ⚠ 脚注 8 对图很有用：**整体符号靠物理输入而非计算**，这是「实话实说」原则下必须记的一处。

### E70 ★★ Ω 在开超弦上的作用与 `Ω² = exp(πiF)`
- 位置：**§10.8「The Möbius strip」，(10.8.12)–(10.8.15)，pp. 41–42** `[L1 原书]`
- 类型：proposition / definition
- **公式（逐字）**：
  - 「In the open string `Ω` acts as」
    `Ω ψ^μ(w) Ω^{−1} = ψ̃^μ(π − w̄) = ψ^μ(w − π)`（**10.8.12**）
    「**using the doubling trick (10.2.15)**.」
  - 「In terms of the modes this is」
    `Ω ψ_r^μ Ω^{−1} = exp(−πir) ψ_r^μ`（**10.8.13**）
  - 「**The phase is imaginary in the NS sector and squares to `−1`.** Thus」
    `Ω² = exp(πiF)`（**10.8.14**）
  - 「Since `exp(πiF) = 1` by the GSO projection, this is physically the same as squaring to the identity, but **the combined `Ω` and GSO projections require a single projection operator**」
    `(1 + Ω + Ω² + Ω³)/4`（**10.8.15**）
- 文献自称的严格程度：直接计算（`r ∈ Z + ½` 在 NS 扇区 ⇒ `exp(−πir)` 为纯虚 ⇒ 平方得 `−1`）
- 文献列出的依赖：**(10.2.15)**（明写，doubling trick = `polchinski-1998-v2.md` E20）；GSO 投影（E42）
- 备注：★★ **这是本项目里 `Ω² = exp(πiF)` 的一手带式号来源**。
  三点值得进节点：
  1. **`Ω` 在开超弦上的平方不是恒等，而是世界面费米数算符**——这是超弦相对玻色弦的真正新结构；
  2. 因此无取向投影算符是 **`(1+Ω+Ω²+Ω³)/4`（四项）**，不是玻色弦的 `(1+Ω)/2`；
  3. Polchinski 自己指出「physically the same as squaring to the identity」（因为 GSO 已投掉 `exp(πiF) = −1`），
     **即 `Z₄` 结构在物理谱上塌回 `Z₂`**——转节点时这个限定要带上。
  ⚠ `polchinski-1998-v2.md` E48 记了 (10.8.13)/(10.8.14)/(10.8.15) 三式，但**漏了 (10.8.12) 与「doubling trick (10.2.15)」这条明写依赖**。

### E71 Möbius 带振幅 ★
- 位置：**§10.8，(10.8.16)–(10.8.18)，p. 42** `[L1 原书]`
- 类型：proposition
- **公式（逐字）**：
  - 「With `R = Ω exp(πiβF)` in the trace, the fields have the periodicities」
    `ψ^μ(w + 4πit) = −exp(πiβ)ψ^μ(w + 2πit − π) = ψ^μ(w − 2π)`（**10.8.16**）
  - 「**It follows that in the R sector of the trace the fields are periodic in the `σ²`-direction, corresponding to the R–R exchange, while the NS sector of the trace gives the NS–NS exchange.**」
    ⚠ **注意这与圆柱（E65）相反**：圆柱上是「迹里有 `exp(πiF)`」对应 R–R，这里是「迹的 R 扇区」对应 R–R。
  - 「It is slightly easier to focus on the R–R exchange, where the traces with `Ω` and `Ω exp(πiF)` sum to」
    `−16q^{1/3} ∏_{m=1}^∞ [1 + (−1)^m q^m]⁸ − (1 − 1)⁴ q^{1/3} ∏_{m=1}^∞ [1 − (−1)^m q^m]⁸`
    `= Z⁰₁(2it)⁴ Z¹₀(2it)⁴`（**10.8.17**）
    ⚠ **`(1 − 1)⁴` 是页图上的读数（已单页重渲染复核），它等于零**；抽取者理解为「两个迹在该结构上逐对相消」的显式写法
    （8 个横向费米子 = 4 对，每对给一个 `(1 − 1)`）。**这是抽取者的解读，原书不解释。** 见 **Q3**。
  - 「The full Möbius amplitude, **rewriting the bosonic part slightly**, is」
    `Z_{M₂,1} = ±inV₁₀ ∫₀^∞ (dt/8t)(8π²α't)^{−5} · [Z⁰₁(2it)⁴Z¹₀(2it)⁴] / [η(2it)⁸ Z⁰₀(2it)⁴]`
    `        = ±2in (2⁵V₁₀/(8π(8π²α')⁵)) ∫₀^∞ ds [Z⁰₁(2is/π)⁴Z¹₀(2is/π)⁴] / [η(2is/π)⁸ Z⁰₀(2is/π)⁴]`
    `        = ±2in (2⁵V₁₀/(8π(8π²α')⁵)) ∫₀^∞ ds [16 + O(exp(−2s))]`（**10.8.18**）
  - 「**where the upper sign is for `SO(n)`. We have used (7.4.22) in `D = 10`.**」
- 文献自称的严格程度：计算；「rewriting the bosonic part slightly」是记号整理
- 文献列出的依赖：**Vol.1 (7.4.22)**（明写）；E70（投影算符）
- 备注：`2⁵ = 32` 在这里**第一次以 `2⁵` 的形式出现**，对应 Vol.1 (7.4.23) 的 `2¹³`。见 **E74**。
  抽取者核对：分母 `η(2it)⁸Z⁰₀(2it)⁴` 正是 Vol.1 (7.4.21) 的 `ϑ₀₀η` 组合在 `D = 10` 下的形式
  （8 个横向玻色子 ⇒ `[ϑ₀₀η]^{−4} = Z⁰₀^{−4}η^{−8}`，因 `Z⁰₀ = ϑ₀₀/η`）——**与「We have used (7.4.22) in D = 10」自洽**。

### E72 ★★★ 总 R–R 发散与 `SO(32)`（本节的主结论）
- 位置：**§10.8，(10.8.19) 与其后的收尾段，p. 42**（本条已**单页重渲染复核**，并做过独立算术交叉核验，见 §0.4a）`[L1 原书]`
- 类型：proposition
- **原文逐字（(10.8.19) 与整个收尾段，一字不漏）**：
  > 「The total divergence from R–R exchange is
  >
  > `Z₁ = −i(n ∓ 32)² · V₁₀/(8π(8π²α')⁵) · ∫₀^∞ ds [16 + O(exp(−2s))]` .  (**10.8.19**)
  >
  > **The R–R tadpole vanishes only for the gauge group `SO(32)`.** For each world-sheet topology the NS–NS divergence is the negative of the R–R divergence, **so the dilaton–graviton tadpole also vanishes for `SO(32)`**. **This calculation does not determine the sign of the tadpole, but it should be `n ∓ 32`.** That is, changing from a symplectic to orthogonal projection changes the sign of `RP₂`, not of the disk. This is necessary for unitarity: the number of cross-caps is conserved mod 2 when a surface is cut open, so the sign is not determined by unitarity; this is not the case for the number of boundaries.」
- **文献自称的严格程度（逐层拆解，本条的关键）**：
  1. **(10.8.19) 本身是一次直接求和**，可机械复算；本轮**已独立复算通过**（§0.4a）。
  2. **主结论的动词是 "vanishes only for"**（不是 "we prove"、也不是 "one can show"），**是陈述语气的硬结论**。
  3. ★ **作者明确承认一处缺口**：「**This calculation does not determine the sign of the tadpole, but it should be `n ∓ 32`.**」
     —— 强度词是 **"should be"**，随后给的是一个**幺正性 + cross-cap 计数的定性论证**，不是计算。
  4. **候选集只有 `SO(n)` 与辛群**（无取向 type I 的 Chan–Paton 群；`U(n)` 属取向理论，已在 §10.6 排除）。
     取下号（辛）得 `(n + 32)²`，**对任何正整数 `n` 都不为零** ⇒ 辛支根本不给解。
     **本书不写 `USp(32)`，也不讨论它**（见 §3.1 第 3 条）。
- 文献列出的依赖：E65/E66（圆柱）、E69（Klein 瓶）、E71（Möbius）、E68（相消的判据形式）
- 备注（**curator 必读**）：
  1. ★★★ **这就是 `spectrum.type-i-tadpole-cancellation-so32` 的真来源**，
     结束 `polchinski-1998-v1-ch7.md` §5-B2 提出的「Vol.1 不能当来源」问题。
  2. **与 Vol.1 (7.4.24) 的强度差别很大**：Vol.1 对玻色弦的 `SO(8192)` 亲口判 "**probably has no special significance**"；
     **§10.8 对 `SO(32)` 没有任何类似的贬抑限定**，反而在 §10.6 p.31 被当作三个一致理论之一的依据（E75）。
     → 两个节点的 statement 必须各自带上各自的作者判词，**不要互相污染**。
  3. **本节自始至终不出现 "anomaly"**，与六边形反常没有原文级连接。见 **E75** 与 §3.1。

### E73 «符号未定» 的补充论证：cross-cap 数 mod 2 守恒
- 位置：**§10.8，p. 42 末三句**（并入 E72 的引文，此处单列以便建卡）`[L1 原书]`
- 类型：proposition（辅助论证）
- 原文陈述（转述 + 关键逐字）：整体 tadpole 符号不由本计算定出；作者主张它「**should be `n ∓ 32`**」，
  理由是「changing from a **symplectic to orthogonal projection changes the sign of `RP₂`, not of the disk**」，
  而这一点「is necessary for unitarity: **the number of cross-caps is conserved mod 2 when a surface is cut open,
  so the sign is not determined by unitarity; this is not the case for the number of boundaries.**」
- 文献自称的严格程度：定性论证，无计算
- 备注：⚠ **这段话内部有一处表面张力**：开头说这个符号安排「is necessary for unitarity」，
  末尾又说 cross-cap 的「sign is **not** determined by unitarity」。
  抽取者的读法是：**边界数**不 mod 2 守恒 ⇒ 圆盘符号被幺正性定死；**cross-cap 数** mod 2 守恒 ⇒ `RP₂` 符号幺正性管不着，
  故只有 `RP₂` 的符号可以随投影翻转。**这是抽取者的解读，原书没有把这层意思写全。** 见 **Q4**。
  → 若 curator 要给「tadpole 符号 = `n ∓ 32`」单独建卡，`status` 只能是 `physical-argument`，
  并逐字带上 "This calculation does not determine the sign of the tadpole"。

### E74 ★★ §10.8 与 Vol.1 §7.4 的**逐式对应**：Q4（`32 = 2^{10/2}` vs `8192 = 2^{26/2}`）的裁决
- 位置：**§10.8 内三处明写的跨卷引用**，pp. 37、41、42 `[L1 原书]`
- 类型：（元陈述 / 跨文献对应）
- **三条逐字引用**：
  1. p. 37（圆柱）：「combining **the bosonic result (7.4.1), converted to ten dimensions**, with the fermionic trace (10.7.9)」
  2. p. 41（Klein 瓶）：「**The bosonic part is (7.4.15) converted to `D = 10`.**」
  3. p. 42（Möbius）：「**We have used (7.4.22) in `D = 10`.**」
- **由此得到的对应表**（左列取自 `polchinski-1998-v1-ch7.md` E29/E36/E37/E38，均 L1）：

  | 面 | Vol.1 玻色弦（`D = 26`） | Vol.2 type I（`D = 10`） |
  |---|---|---|
  | 圆柱 | (7.4.3)：`V₂₆n²/(2π(8π²α')¹³)` | (10.8.4)：`V₁₀n²/(8π(8π²α')⁵)` |
  | Klein 瓶 | (7.4.19)：`**2²⁶** V₂₆/(4π(8π²α')¹³)` | (10.8.11)：`**2¹⁰** V₁₀/(8π(8π²α')⁵)` |
  | Möbius | (7.4.23)：`±2n·**2¹³** V₂₆/(4π(8π²α')¹³)` | (10.8.18)：`±2n·**2⁵** V₁₀/(8π(8π²α')⁵)` |
  | 总和 | (7.4.24)：`∝ (2¹³ ∓ n)²`，`24` 个无质量态 | (10.8.19)：`∝ (n ∓ 32)²`，`16` 个无质量态 |

  即 **Klein 瓶带 `2^D`、Möbius 带 `2^{D/2}`、总和是 `(2^{D/2} ∓ n)²`**；`D = 26 → 2¹³ = 8192`，`D = 10 → 2⁵ = 32`。
- **Q4 的裁决（分两层，务必分开引用）**：
  - **(i) 有原文级支持的部分**：Polchinski **明写**三个面的玻色部分就是 Vol.1 的 (7.4.1)/(7.4.15)/(7.4.22)
    「converted to `D = 10`」。⇒ **`8192` 与 `32` 出自同一组公式在不同 `D` 下取值，这一点现在有原文背书**，
    不再只是 `polchinski-1998-v1-ch7.md` Q4 里的抽取者推断。
  - **(ii) 仍是抽取者推断的部分**：Polchinski **从不写符号形式 `2^{D/2}`**，也从不把两个数并列比较，
    更没有说这个 `2^{D/2}` 与 **GSW §10.2 六边形「奇数条扭转线的分布数」`Σ_{k odd} C(6,k) = 2⁵`** 是同一个 32。
    ⇒ **「`32 = 2^{10/2}` 与 GSW 的 `32` 同源」仍然没有任何文献支持，不得写进节点。**
- 备注：★★ 现在本项目手上有**三个各自独立出处的 `2⁵ = 32`**：
  (a) 本节的世界面几何计数（Klein/Möbius 的重标度，`2^{D/2}`）；
  (b) GSW (10.2.36) 的**积分变量替换** `√z_r → z_r` 给的 2⁵；
  (c) GSW 的**六边形奇数扭转分布数** `Σ_{k odd} C(6,k) = 2⁵`
  （(b)(c) 见 `graph/statements/consistency/type-i-hexagon-so32-iff.yaml` notes 第 1 条）。
  **没有任何一本书解释这三者为什么相等。** 这是一条很干净的开放问题，见 **Q5**。

### E75 ★★ §10.6 的前向承诺 vs §10.8 的实际交付：「superconformal anomaly」没有兑现
- 位置：**§10.6 末段，p. 31**（跨节定点核对）与 **§10.8 全节，pp. 37–42** `[L1 原书]`
- 类型：（元陈述 / 缺口登记）
- **§10.6 p. 31 逐字（本轮重新核实，与 `polchinski-1998-v2.md` E46 一致）**：
  > 「There is a further inconsistency in all but the `SO(32)` theory. **We will see in section 10.8 that for all other groups, as well as the purely closed unoriented theory, there is a one-loop divergence and superconformal anomaly.** We will also see, **in chapter 12**, that the spacetime gauge and coordinate symmetries have an anomaly at one loop for all but the `SO(32)` theory.
  > Thus we have found precisely three tachyon-free and nonanomalous string theories in this chapter: type IIA, type IIB, and type I `SO(32)`.」
- **§10.8 实际交付的（本轮逐页核实）**：
  - **只有 "one-loop divergence"**（(10.8.4)/(10.8.11)/(10.8.18)/(10.8.19)）；
  - **"superconformal anomaly" 在 §10.8 里一次都没有出现**；本节全文**不含 "anomaly" 一词**（见 §3.1 第 1 条）；
  - **"purely closed unoriented theory"（即 `n = 0`）的情形本节不单独讨论**，只能由 (10.8.19) 取 `n = 0` 读出
    `Z₁ ∝ −i·32² ≠ 0`——**这一步是抽取者做的，原书没写**。
- 备注：★★ 对图的两条后果：
  1. **`type I 只有 SO(32)` 这条链的真实证据只有 tadpole 发散一支**；
     §10.6 承诺的「superconformal anomaly」在本书里**没有兑现**（至少不在 §10.8）。
     → 若有人从 E46 那句「precisely three tachyon-free and **nonanomalous** string theories」建卡，
     必须注明「其中 nonanomalous 的两个支撑分别在 §10.8（只给发散，未给超共形反常）与 ch.12（时空反常，低能场论路线）」。
  2. **§10.8 与时空反常（六边形）的连接是 §10.6 p.31 明确并列的两件事，不是一件事**：
     原文用「There is a further inconsistency …」与「**We will also see, in chapter 12** …」把它们分开叙述。
  另一条**同书的正面佐证**（不是本轮读的，来自本项目已有 L1 记录）：
  `extractions/polchinski-1998-v2-ch12.md` **E19**（§12.2, p. 102，无式号）逐字：
  「In the heterotic string, the gauge group was determined by the requirement of **modular invariance**.
  In the type I string it was determined by **cancellation of tadpole divergences**.」
  ⇒ **Polchinski 本人明说：type I 的规范群是被 tadpole 相消（即本节）定下来的，不是被反常定下来的。**

---

## 3. 否定结论与未核实清单

### 3.1 §10.8 **没有**出现的东西（逐条都是通读 pp.37–42 后的否定观察，写在这里以免后人反复找）

1. **本节没有出现 "anomaly" 一词**，也没有 "hexagon"、"Green–Schwarz"、"GS mechanism"。
   ⇒ **§10.8 与 `green-schwarz-1985-hexagon` / GSW ch.10 / `consistency.type-i-hexagon-so32-iff` 之间没有任何原文级连接。**
2. **本节一个文献引用都没有**（无 "(Author, year)"、无编号引文）。这与 Polchinski 全书体例一致
   （参考文献集中在 pp.467–487，本项目仍未取）。⇒ **不能用 §10.8 去补 GS 1985 的引用链。**
3. **本节没有出现 "USp(32)" 或 "Sp(32)"**。辛群只以「a symplectic … projection」的形式出现在 p.42 一句里，
   且 (10.8.19) 的下号 `(n + 32)²` **对任何 `n` 都不为零** ⇒ 辛支不是解。
   ⚠ 文献中著名的 `USp(32)` type I′ 模型（Sugimoto 1999 型的破缺超对称构造）**不在本书本节**，勿张冠李戴。
4. **本节没有出现 "orientifold" / "O-plane" / "D-brane"**（`Ω` 投影有，名字没有；D-brane 是 ch.13）。
   也没有把 `μ₁₀` 与 D9-brane 荷联系起来——那是 ch.13 的语言。
5. **§10.8 没有任何习题。** 本轮核实 pp.43–44 的 Exercises 10.1–10.15：
   10.1–10.14 对应 §10.1–§10.5，10.15 对应 §10.7（Thirring / 有理半径）。
   ⇒ **§10.8 是第 10 章里少数「正文把计算做完、一步都不推给读者」的节**，
   这与 `polchinski-1998-v2.md` E49 列出的大片「推给习题」形成对比，**对本节的强度评估是正面的**。
6. **[H]（Headrick 解答手册）对 §10.8 无题可解**（因为本节无习题），本轮未使用二手源。

### 3.2 对 `polchinski-1998-v2.md` **E48** 的订正与补充

E48 是上一轮把整个 §10.8 压成一条的「要点」条目。本轮逐页核实后：

| # | E48 的写法 | 本轮核实结果 |
|---|---|---|
| 1 | 前缀写作 `8π(8π²α'²)⁵`（多处） | ⚠ **应为 `8π(8π²α')⁵`**。页图确实看起来有多余的上标，但两次独立变量代换与量纲都要求 `α'` 的一次方，见 **§0.4(b)**。**不影响 `(n ∓ 32)²` 与 `SO(32)`（公因子）。** |
| 2 | 「Möbius 带：`Ωψ_r^μΩ^{−1} = exp(−πir)ψ_r^μ`（(10.8.13)）」 | 正确，但**漏了 (10.8.12)** `Ωψ^μ(w)Ω^{−1} = ψ̃^μ(π−w̄) = ψ^μ(w−π)` 与其明写依赖「**doubling trick (10.2.15)**」。见 **E70**。 |
| 3 | 「Klein 瓶：(10.8.7)–(10.8.11)」（未展开） | 本轮补齐 (10.8.7)/(10.8.8a,b)/(10.8.9)/(10.8.10a,b) 的逐字内容，**并补上脚注 8**（整体符号由引力子与 (10.6.17) 定，不是算出来的）。见 **E69**。 |
| 4 | 未记 (10.8.16)、(10.8.17) | 本轮补上。(10.8.17) 含一个**页图读作 `(1 − 1)⁴` 的零系数项**，见 **E71** 与 **Q3**。 |
| 5 | 未记 `s` 与 `t` 的三个换算关系 | 本轮补上：`s = π/t`（圆柱）、`π/4t`（Möbius）、`π/2t`（Klein 瓶），逐字见 **E68**。 |
| 6 | 未记三条「converted to `D = 10`」的跨卷明写引用 | 本轮补上，**这是 Q4 裁决的关键证据**。见 **E74**。 |
| 7 | 未记「§10.8 无习题」 | 本轮补上，见 §3.1 第 5 条。 |

**E48 的其余内容（(10.8.1)(10.8.2)(10.8.4)(10.8.5)(10.8.6)(10.8.11)(10.8.13)(10.8.14)(10.8.15)(10.8.18)(10.8.19)
的式号与主要逐字句、脚注 7）本轮全部复核无误。** 特别是 (10.8.19) 与其后收尾段的逐字文本，两轮读数完全一致。

### 3.3 本节引用、但本轮**未翻页核对**的外部式号

| 被引式号 | §10.8 在哪里引它 | 本项目是否已 L1 核过 |
|---|---|---|
| **(7.4.1)** | E65（圆柱） | ✅ `polchinski-1998-v1-ch7.md` E29（L1） |
| **(7.4.15)** | E69（Klein 瓶） | ✅ 同上 E36（L1） |
| **(7.4.22)** | E71（Möbius） | ✅ 同上 E37（L1） |
| **(10.7.9)** | E65 | ✅ `polchinski-1998-v2.md` E47（L1） |
| **(10.2.15)** | E70（doubling trick） | ✅ `polchinski-1998-v2.md` E20（L1） |
| **(10.6.17)** | E69 脚注 8 | ✅ `polchinski-1998-v2.md` E45（L1） |
| **figure 10.1 / 10.2 / 10.3** | 全节 | **本轮读到了图本身（p.37 fig.10.1、p.39 fig.10.2、p.40 fig.10.3）与图注**，但图注之外的几何细节未逐一验证 |

⇒ **§10.8 引用的全部外部式号在本项目里都已 L1 核过，本节没有悬空的外部依赖。**（这在本项目里很少见。）

---

## 4. 未解决的疑问

### Q1 ⚠ `(8π²α')⁵` vs `(8π²α'²)⁵`：页图读数与复算冲突
- 页图上七处一致地看起来是 `α'²`；两次独立变量代换 + 量纲分析一致地要求 `α'`（§0.4b）。
- **可能性**：(a) PDF 渲染中 prime 的假象；(b) 原书的系统性排印错误（同一个 macro 用了七次）。
- **处理**：`(n ∓ 32)²` 与 `SO(32)` 结论不受影响（公因子）。
  **curator 若要把 (10.8.4)/(10.8.11)/(10.8.18)/(10.8.19) 的完整前缀写进节点，先由人复核 pp.38/41/42 一次。**
  官方勘误表本项目取不到（`polchinski-1998-v2.md` §3.3 记 KITP errata 页 404）。
- **✅ 2026-09-11 第二轮已复核并裁决（追加行，上面各行原状保留）**：**判为页图渲染假象，不是原书排印错误**；
  原书印的与数学内容都取 `8π(8π²α')⁵`。「先由人复核 pp.38/41/42 一次」这个前置条件**已解除**。
  证据链（跨卷控制组 + 「假象位置 ↔ 分式分母」100% 相关）见本文件 **§6「Q1 复核」**。

### Q2 「superconformal anomaly」在本书里到底在哪？
- §10.6 p.31 逐字承诺「We will see **in section 10.8** that … there is a one-loop divergence **and superconformal anomaly**」，
  但 **§10.8 全节不含 "anomaly" 一词**（E75、§3.1）。
- **可能性**：(a) 作者把「1/0 型 tadpole 发散」本身在别处称作超共形反常（Fischler–Susskind 机制的语言）；
  (b) 这句承诺指向的其实是 ch.9 或 ch.13 的讨论；(c) 单纯的笔误。
- **本轮不裁决。** 建议由后续读 ch.9 / ch.13 的人顺手核一次「dilaton tadpole ↔ Weyl/超共形反常」的措辞。
- ⚠ **在裁决之前，图里不得写「Polchinski §10.8 证明了非 `SO(32)` 理论有超共形反常」。**

### Q3 (10.8.17) 里的 `(1 − 1)⁴`
- 页图（已单页重渲染）读作 `− (1 − 1)⁴ q^{1/3} ∏[1 − (−1)^m q^m]⁸`，其值为零。
- 抽取者的解读：8 个横向费米子分成 4 对，`Ω` 与 `Ω exp(πiF)` 两个迹在该结构上逐对相消，故系数 `(1−1)⁴`。
  **原书不解释为何要把一个恒为零的项写出来。**
- **处理**：这一式**不进任何节点**；(10.8.18) 的结果不依赖它（它是零）。

### Q4 E73 那段「幺正性」论证的内部张力
- 同一段里既说这个符号安排「is necessary for unitarity」，又说 cross-cap 的「sign is **not** determined by unitarity」。
- 抽取者的读法见 E73 备注（边界数不 mod 2 守恒 ⇒ 圆盘符号定死；cross-cap 数 mod 2 守恒 ⇒ `RP₂` 符号自由）。
- **这是抽取者的补全，原书没写全。** 若要建「tadpole 符号」的卡，必须标 `inferred: true`。

### Q5 ★ 三个独立出处的 `2⁵ = 32`，无人解释它们为何相等
- (a) **本节**：Klein 瓶 `2^D` / Möbius `2^{D/2}` 的**世界面重标度**计数（E74）；
- (b) **GSW (10.2.36)**：六边形振幅里 `√z_r → z_r` 的**积分变量替换**，5 个变量各出一个 2；
- (c) **GSW 同页**：六边形内线上**奇数条扭转**的分布数 `Σ_{k odd} C(6,k) = 2⁵`。
- Polchinski 只说 Vol.1 与 Vol.2 之间是 "analogous"；GSW 对 (b)(c) 的相等**不作解释**
  （见 `graph/statements/consistency/type-i-hexagon-so32-iff.yaml` notes 第 1 条）。
- **这是一条干净的开放问题**：三条计数是否有共同的结构性来源？
  是则「32 的普适性」有一个真正的解释；否则它是三次巧合。**本项目不应擅自合并这三条。**

### Q6 `n = 0`（纯闭弦无取向理论）的不一致，本节未单独论证
- §10.6 p.31 说「for all other groups, **as well as the purely closed unoriented theory**」都不一致，
  但 §10.8 全节没有单独讨论 `n = 0`；只能由 (10.8.19) 代入 `n = 0` 得 `Z₁ ∝ −i·1024 ≠ 0`。
- **这一步是抽取者做的**（且需要先接受「`n = 0` 时 Möbius 与圆柱都消失、只剩 Klein 瓶」）。
- **若图里要建「纯闭弦无取向 type I 不一致」的节点，必须标 `inferred: true`。**

---

## 5. 对图的建议

> researcher 不写 `graph/`。以下全部是**给 curator 的建议**，每条都注明证据等级与该不该标 `inferred`。
> 本轮已用 grep 确认：**`graph/` 全目录 "tadpole" 零命中** ⇒ `spectrum.type-i-tadpole-cancellation-so32`
> **目前不存在，是新节点**（`spectrum.bosonic-unoriented-tadpole-cancellation-so8192` 同样不存在）。

### 5-A 建议新建的节点

| 建议 id | kind | statement 要点 | 来源 loc | 备注 |
|---|---|---|---|---|
| **`spectrum.type-i-tadpole-cancellation-so32`** | proposition | 见 5-A1 | 见 5-A1 | ★★★ 本轮的主产出 |
| `spectrum.type-i-rr-tadpole-is-genuine-inconsistency` | proposition | R–R tadpole 不能被背景场修正吸收，`C₁₀` 的运动方程直接给 `μ₁₀ = 0` ⇒ 真正的不一致 | `Vol.2 §10.8, eqs. (10.8.5)(10.8.6), pp. 38–39` | **E67。status 不高于 `physical-argument`**：作者逐字「One can **guess** the resolution」+「as indeed **a more detailed analysis does show**」（该分析不给） |
| `worldsheet.omega-squared-is-worldsheet-fermion-number` | proposition | 开超弦上 `Ω² = exp(πiF)`；故无取向 + GSO 的联合投影算符是 `(1+Ω+Ω²+Ω³)/4`；因 GSO 已令 `exp(πiF)=1`，物理上等价于 `Ω²=1` | `Vol.2 §10.8, eqs. (10.8.12)–(10.8.15), pp. 41–42` | **E70。** 这是本项目里该式的**唯一一手带式号来源**；推导是直接计算，可给较高 status |
| `spectrum.bosonic-unoriented-tadpole-cancellation-so8192` | proposition | （**沿用 `polchinski-1998-v1-ch7.md` §5-A 的建议，未变**）玻色弦无取向：`∝ (2¹³ ∓ n)²`，对 `SO(8192)` 消失 | `Vol.1 §7.4, eq. (7.4.24), p. 229` | **必须带上作者亲口的 "probably has no special significance"**，与上面的 `SO(32)` 卡**分开** |

#### 5-A1 `spectrum.type-i-tadpole-cancellation-so32` 的具体建议

- **kind**：`proposition`
- **推导的 `status`**：**`physical-argument`**（不要更高）。理由**逐条有原文依据**：
  1. 整体符号未定：「**This calculation does not determine the sign of the tadpole, but it should be `n ∓ 32`.**」（E72/E73）；
  2. R–R 发散的来源是猜出来的：「**One can guess the resolution** … as indeed **a more detailed analysis does show**」，
     而该分析不给、不引（E67）；
  3. 两个迹的整体符号靠物理输入（引力子）与 (10.6.17)，不是算出来的（E69 脚注 8）；
  4. 「NS–NS 与 R–R tadpole 必须分别在拓扑求和后为零」是断言（E68 脚注 7）；
  5. 用到的模变换 (10.8.3) 继承自 §10.7，而原书在那里对它加了 "naive" 的限定，§10.8 不重述（E66）。
  **反过来，有两条正面因素应写进 note**：(a) **本节没有把任何一步推给习题**（§3.1 第 5 条）；
  (b) **(10.8.19) 的系数已被抽取者独立复算通过**（§0.4a）。
- **`sources[].loc` 建议逐字写**：
  `"§10.8, eq. (10.8.19), p. 42，及其后逐字句「The R–R tadpole vanishes only for the gauge group SO(32).」；
  三个面的分振幅见 (10.8.4) p.38（圆柱）、(10.8.11) p.41（Klein 瓶）、(10.8.18) p.42（Möbius，上号为 SO(n)）；
  判据的形式见脚注 7, p.39"`
- **statement 里必须写进去的四条限定**（否则该卡是错的）：
  1. **候选集**：无取向 type I 的 Chan–Paton 群，即 `SO(n)` 与辛群（`Sp(k) ↔ n = 2k`）。
     `U(n)` 不在候选集（取向理论，§10.6 已排除）。**辛支给 `(n+32)²`，对任何 `n` 都不为零。**
  2. **判据不是「真空振幅有限」**，而是「**NS–NS 与 R–R tadpole 分别在拓扑求和后为零**」（E68 脚注 7）；
     对每个拓扑单独看，两者本来就因超对称相消，**那是不够的**。
  3. **整体符号 `n ∓ 32` 不是本计算定出的**（E72 第 3 点）。
  4. 与 Vol.1 (7.4.24) 的玻色弦 `SO(8192)` 是**同一组公式在不同 `D`** 下的结果（E74），
     但**作者对两者的判词相反**（玻色弦那条被判 "probably has no special significance"）。
- **`depends_on` 建议**：`spectrum.chan-paton-gauge-group`（或等价卡）、type I 的谱（`polchinski-1998-v2.md` E45/E46 对应卡）、
  §10.7 的费米迹 (10.7.9) 对应卡。**Vol.1 的圆柱/Klein/Möbius 三条真空振幅卡若已建，这三条边可以建实**
  （原文明写 "converted to `D = 10`"，**不必标 `inferred`**）。

### 5-B ★★ 关于与 `consistency.type-i-hexagon-so32-iff` 的边：**建议不建 `depends_on` 边**

派工单问「两者是否原文相连、边能否建实」。**本轮的结论是：不能建实，且不建议建。**

**证据（三条，全部 L1）：**
1. **§10.8 全节不含 "anomaly" 一词，不引 GS，不提六边形**（§3.1 第 1、2 条）。
2. **§10.6 p.31 把两者明确并列为两件不同的事**（E75 逐字）：
   「There is a **further** inconsistency …（→ §10.8 的发散）」／「We will **also** see, **in chapter 12**, that the spacetime
   gauge and coordinate symmetries have an anomaly …（→ 低能场论的反常）」。
3. **Polchinski 本人在 §12.2 p.102 逐字否定了「反常决定规范群」这条读法**
   （`polchinski-1998-v2-ch12.md` E19）：「In the type I string it was determined by **cancellation of tadpole divergences**.」

**建议的处理：**
- **两个节点是同一个 `SO(32)` 的两条互不依赖的路线**（弦论单圈发散 vs 单圈六边形反常）。
  在图里保持**平行**，`depends_on` 两个方向都不要连。
- 若 lead 希望记录这个「两条路线撞到同一个群」的事实，**正确的载体是 milestone 或双方的 `notes` 交叉引用**，
  而不是一条推导边——否则会把两条独立证据伪装成一条链，正是本项目要避免的。
- 顺带：`type-i-hexagon-so32-iff` 的 notes 第 1 条已经登记了「两个独立的 32」。
  **建议在那里追加第三条**：Polchinski Vol.2 §10.8 的 `2⁵`（世界面重标度，`2^{D/2}`），并指向本文件 **E74 / Q5**。
  ⚠ 追加时必须写明「三者相等在任何文献里都没有解释」——**不得写成同一机制**。
- 另一条可以建实的**弱连接**：`consistency.type-i-hexagon-so32-iff` 的 statement 里
  「(e) SO(32) 单圈**发散**的抵消（§10.4）」明确说本卡不覆盖发散，且引 GSW 自评
  「This argument for the finiteness of the `SO(32)` theory given above is **not entirely rigorous**」。
  **Polchinski §10.8 正是那件事的另一本书的版本** ⇒ 建议在该卡的 notes 里加一句指路，**只作交叉引用，不加 source、不加边**。

### 5-C 对**现有节点/记录**的修改建议

**C1 —— `literature/extractions/polchinski-1998-v2.md` 的 E48**
- 按 §3.2 的七条订正/补充。**本 researcher 遵守「一篇文献一个抽取文件、只追加不覆盖」的规则，未改动该文件**；
  本文件即是它的 §10.8 展开版。建议 lead 只在该文件 E48 下追加一行指路：
  「**§10.8 的逐条抽取见 `polchinski-1998-v2-sec10-8.md`（E64–E75），其中含一处对本条前缀 `α'` 幂次的订正。**」

**C2 —— `polchinski-1998-v1-ch7.md` 的 Q4 与 §5-B2**
- **Q4 现在可以关闭**（部分）：见本文件 **E74**。裁决是分层的：
  「同一组公式在不同 `D`」**有原文背书**；「与 GSW 的六边形 32 同源」**仍无任何支持**。
- **§5-B2 的结论已被本轮兑现**：`spectrum.type-i-tadpole-cancellation-so32` 的 Polchinski 来源
  **就是 Vol.2 §10.8 (10.8.19)**，不是 Vol.1 ch.7。

**C3 —— `sources.bib` 的 `polchinski-1998-v2`**
- 已在本轮追加：抽取记录清单里补上本文件，并补一条使用限制（`α'` 幂次的疑似排印/渲染问题）。

**C4 —— `reading-list.md`**
- 已在本轮把 §10.8 那一行从「待分派」改为 `extracted`，并写明 Q4 的裁决与遗留的 Q1/Q2/Q5。

### 5-D 本轮给 reading-list 的新增建议

1. **`polchinski-1998-v2` ch.13「D-branes」（pp.136–177，item hash `67EE13E32046F0D121B589DC02989698`）**
   —— §10.8 的 `μ₁₀`、`C₁₀`、`RP₂` tadpole 在 ch.13 会被重述为 D9-brane 与 O9-plane 的荷相消。
   **那是「`SO(32)` = 32 个 D9-brane」这一现代说法的出处**，而本项目完全没有这一支。
   顺带可望回答 **Q2**（超共形反常的措辞）与 **Q6**（`n = 0` 的情形）。
2. **`polchinski-1998-v1` §9（pp.283–328）或 ch.7 §7.4 之后关于 Fischler–Susskind 的讨论**
   —— 若「dilaton tadpole ↔ 超共形/Weyl 反常」的措辞在本书里存在，最可能在那里。这是 **Q2** 的另一条线索。
3. **（维持 `polchinski-1998-v1-ch7.md` §5-D 的第 2 条）`polchinski-1998-v1` 书末 References**
   —— 与本节无关，但仍是性价比最高的未清项。

---

## 6. ★ Q1 复核（2026-09-11 第二轮，researcher）——裁决：**不是原书排印错误，是页图渲染假象**

> 派工（lead，2026-09-11）：用 Cambridge Core ch.10 单章高分辨页图人工复核印刷 pp.38/41/42 的
> (10.8.4)/(10.8.11)/(10.8.18)/(10.8.19) 前缀究竟印 `(8π²α′)⁵` 还是 `(8π²α′²)⁵`；
> **若页图确实印 α′²，按 `(13.3.12)` 的先例判为原书排印错误并列证据。**
>
> **本轮结论：判为读图/渲染假象，不判排印错误。** 决定性理由是 §6.3 的**「假象位置 ↔ 分式分母」100% 相关**
> 与 §6.2 的**跨卷控制组**。本节只追加，不改本文件 §0.4(b)、§3.2、§4 Q1 的任何一行。

### 6.1 本轮实际做了什么

| 步 | 做法 | 结果 |
|---|---|---|
| 1 | 重取 ch.10 PDF：`…/content/view/E69C35DC077FD0BAD6B39479144D4A12/9780511618123c1_p1-44_CBO.pdf` | **607.4 KB / 44 页**，与上一轮（607.5 KB / 44 页）为同一文件 |
| 2 | `Read(pages=38)`、`Read(pages=41)`、`Read(pages=42)` —— **三次独立调用，每次只渲染一页**（本工具链可得的最高分辨率） | 三页各重渲染一次 |
| 3 | ★ **跨卷控制组（本轮新增，是裁决的关键）**：取 Vol.1 ch.7 PDF（item hash `1FCFE9B5026DE1E5210F0F62514336B0`，`9780511816079c7_p206-230_CBO.pdf`，**264.2 KB / 25 页**，文件名一次命中），单页读 **PDF p.19 = 印刷 p.224**（含 (7.4.2)–(7.4.6)）与 **PDF p.24 = 印刷 p.229**（含 (7.4.24)） | 成功 |

**Vol.1 ch.7 页脚逐字（版本锚定，L1）**：
`Downloaded from https://www.cambridge.org/core. Zhejiang University, on 11 Sep 2026 at 08:13:10, subject to the
Cambridge Core terms of use … https://doi.org/10.1017/CBO9780511816079.010`
（Vol.2 ch.10 页脚仍是 `…/CBO9780511618123.004`，与 §0.2 一致。两卷同一次机构订阅下载。）

### 6.2 ★★ 跨卷控制组：同一个字形在 Vol.1 上**必然**是单撇 `α′`

Vol.1 §7.4 与 Vol.2 §10.8 是**同一套排版宏、同一处公式结构**——原书自己明写 Vol.2 三个面的玻色部分就是
(7.4.1)/(7.4.15)/(7.4.22)「converted to `D = 10`」（见 **E74** 的三条逐字引用）。本轮读到的 Vol.1 两式：

- **(7.4.3)（印刷 p.224）**：`Z_{C₂} = i · V₂₆n²/(2π(8π²α′)¹³) · ∫₀^∞ ds η(is/π)^{−24}`
- **(7.4.24)（印刷 p.229）**：`i · 24V₂₆/(4π(8π²α′)¹³) · (2¹³ ∓ n)² · ∫₀^∞ ds`

这两式的 `α′` 幂次**被量纲锁死**：`V₂₆` 需要 `length²⁶`，只有 `(α′)¹³` 给得出（`(α′²)¹³ = α′²⁶ → length⁵²`，差 26 个数量级的量纲）。
而 `polchinski-1998-v1-ch7.md`（L1，**另一位 agent、另一轮**）把这两式**转录为单撇 `(8π²α′)¹³`**，
且该文件 §0.4 明记对 **PDF p.24 做过单页重渲染、「读数未改」**。

⇒ **同一个字形，Vol.1 的读图者读作 `α′`，Vol.2 的读图者读作 `α′²`。**
本轮抽取者重渲染 Vol.1 这两页时，**同样觉得 `α′` 之后似乎多了一个极小的上标记号**
——也就是说 **Vol.1 与 Vol.2 的页图字形没有可分辨的差别，差别全在读图者**。
⇒ 「Vol.2 印错了七处」这个假设要成立，就必须同时接受「Vol.1 (7.4.3)/(7.4.24) 也印错了」，
而 Vol.1 那两式从来没有人怀疑过，且量纲把它们钉死在 `α′¹³`。

### 6.3 ★★★ 判定性证据：读出「α′²」的位置与「分式分母」**完全相关**

把本项目手上全部相关读数按**排版语境**分类（Vol.1 ch.7 + Vol.2 ch.10 + Vol.2 ch.13）：

| 出现的写法 | 位置 | 排版语境 | 历轮读数 |
|---|---|---|---|
| `(8π²α′t)^{−5}` | (10.8.2a,b) p.38；(10.8.18) **首行** p.42 | **全字号**（displaystyle 行内），`α′` 后跟基线上的 `t` | **单撇，清晰，两轮零争议** |
| `(4π²α′t)^{−5}` | (10.8.11) **首行** p.41；(7.4.15) | 同上 | **单撇，清晰** |
| `(4π²α′t)^{−d/2}` | (7.4.14) | 同上 | **单撇，清晰** |
| `(8π²α′)⁵` | (10.8.4) p.38；(10.8.11) **第 2/3 行** p.41；(10.8.18) **第 2/3 行** p.42；(10.8.19) p.42 | **全部落在分式分母里**（`\frac{…V₁₀…}{8π(8π²α′)⁵}`），被降为 `\scriptstyle` 小字号 | 上一轮七处均读作 `α′²`；**本轮 p.41 与 p.42（含主结论 (10.8.19) 本身）读作单撇 `α′`**，p.38 仍偏向「多一个小记号」 |
| `(8π²α′)¹³` | (7.4.3) p.224；(7.4.24) p.229 | **同样落在分式分母里** | Vol.1 抽取者读作单撇；**本轮抽取者觉得多一个小记号** |

**相关性是完美的**：凡读出「α′²」的，**无一例外落在分式分母（小字号）**；凡以全字号出现的 `α′`，**无一例外读得干干净净**。
机制解释：`\scriptstyle` 下 prime 只剩一两个像素宽，栅格化后形似一个上标 `2`。

**反过来看「排印错误」假设要付出的代价**：`α′` 这个宏本身没坏——**同一页、甚至同一条公式的首行**
（(10.8.11) 首行、(10.8.18) 首行）里的 `α′t` 完全正常。所以排印错误必须是
**横跨 Vol.1 ch.7、Vol.2 ch.10、Vol.2 ch.13（(13.3.1)，见本文件 §3 末「2026-09-11 追加」第 1 条）
三章、两卷、至少九处，逐处手工多打一个 `²`，而且恰好只在分式分母里多打**。
这不是一个可信的排印错误模式。

### 6.4 ⚠ 本轮同时推翻了 Q1 原文里的一条**事实陈述**

Q1 写的是「页图上**七处一致**地看起来是 `α′²`」。**本轮的单页重渲染不支持「一致」**：
p.41 的 (10.8.11) 与 p.42 的 (10.8.18)/(10.8.19)——**包括本节主结论 (10.8.19) 本身**——本轮读作单撇 `(8π²α′)⁵`。

⇒ 这个读数**在两个 agent、两轮渲染之间不可复现**。不可复现本身就证明它处在本工具链的分辨率极限上，
**不能拿来当「原书如此」的证据**。（对照：`(13.3.12)` 那一处之所以判书错，是因为读数可复现且有三条独立旁证，
见 [[lit-dedekind-eta-and-polchinski-13-3-12-misprint]] 一类记录——两处性质不同，**不要类比援引**。）

### 6.5 裁决与对图的后果

- **数学内容**（不变，本轮再次确认）：Vol.2 是 `8π(8π²α′)⁵`，Vol.1 是 `(8π²α′)¹³`。
  依据仍是 §0.4(b) 的量纲 + 两次独立变量代换（`s = π/t`、`π/2t`），复算逐字给出
  `π⁴/(8(8π³α′)⁵) = 1/(262144π¹¹α′⁵) = 1/(8π(8π²α′)⁵)`。
- **原书印的是什么**：**判为 `(8π²α′)⁵`**。页图上的 `α′²` 是**渲染假象**，**不判为原书排印错误**。
- **对 curator**：(10.8.4)/(10.8.11)/(10.8.18)/(10.8.19) 的完整前缀**现在可以直接按 `8π(8π²α′)⁵` 写进节点**，
  **§4 Q1 里那句「先由人复核 pp.38/41/42 一次」的前置条件已解除**。
  建议 `sources[].loc` 仍保留一句：「前缀的 `α′` 幂次经量纲、变量代换与跨卷控制组三重复核，见
  `polchinski-1998-v2-sec10-8.md` §0.4(b) 与 §6」。
- **不影响面（重申）**：该前缀是三个面的**公因子**，`(n ∓ 32)²` 与 `SO(32)` 结论与它无关。
- **残余不确定性（诚实登记，不因此降级）**：本轮仍然只用了**同一条成像管线**
  （Cambridge Core PDF → `Read` 页图渲染），没有引入第二条独立的成像路径；
  官方勘误表仍取不到（`polchinski-1998-v2.md` §3.3 记 KITP errata 页 404，且本会话 WebSearch 预算已被父会话耗尽，无法再检索镜像）。
  **要 100% 关闭，唯一彻底的办法是人在 PDF 阅读器里把 p.38 放大一次**——10 秒的事。

### 6.6 ★ 副产品：一条可复用的通用规则

**Polchinski 两卷电子书里，凡是落在分式分母中的 `α′`，页图上都可能被读成 `α′²`。**
以后在两卷任何地方遇到「分母里的 `α′^k`」，**一律按量纲判定，不要照抄页图读数**；
反之，全字号出现的 `α′`（如 `(8π²α′t)^{−5}`）读数可信。
这条规则同时解释了本项目此前在 ch.10、ch.13 两处遇到的同一现象，
并把「页图与复算冲突」这一类事故从「未裁决的双读数」降为「已知的已解释伪影」。

### 6.7 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| Vol.2 ch.10 PDF | `www.cambridge.org/core/services/aop-cambridge-core/content/view/E69C35DC077FD0BAD6B39479144D4A12/9780511618123c1_p1-44_CBO.pdf`（**尾部 `/<标题 slug>.pdf` 可省略**） | ✅ 607.4 KB / 44 页 |
| Vol.1 ch.7 PDF | `…/content/view/1FCFE9B5026DE1E5210F0F62514336B0/9780511816079c7_p206-230_CBO.pdf`（同样省略尾部 slug） | ✅ 264.2 KB / 25 页，文件名规则第八次命中 |
| Polchinski 官方勘误表镜像 | `WebSearch` | ❌ **本会话 WebSearch 预算（200/200）已被父会话耗尽**，无法检索 |


---

## 7. ★★ (10.8.17) 复核（2026-09-11 第三轮，researcher）——裁决：**转录无误，原书确印 `−16`；该式如印内部不自洽，判为排印错误**

**触发**：reviewer-batch27 用解析 + 数值两条路给出「按 (10.7.7b)/(10.7.8) 的定义，
`Z⁰₁(2it)⁴Z¹₀(2it)⁴ = +16 q^{1/3}∏[1+(−1)^m q^m]⁸`」，与 E71 转录的 `−16` 差一个整体符号。
**问题**：是原书印 `−16`，还是上一轮页图读错？

### 7.1 页图重读结果（L1，印刷 p.42，独立取件、独立渲染）

**取件**：同一份 ch.10 章级 PDF（`9780511618123c1_p1-44_CBO.pdf`，607.4 KB / 44 页，**PDF 页 = 书页**），
本轮**单页 `Read(pages=42)`**，与第一轮不是同一次渲染。

**逐字（含符号与位置，一字不改）**：

> 「It is slightly easier to focus on the R–R exchange, where the traces with `Ω` and `Ω exp(πiF)` sum to」
>
> `−16q^{1/3} ∏_{m=1}^{∞} [1 + (−1)^m q^m]^8 − (1 − 1)^4 q^{1/3} ∏_{m=1}^{∞} [1 − (−1)^m q^m]^8`
> `= Z^0_1(2it)^4 Z^1_0(2it)^4 .`　　(10.8.17)

**⇒ 结论 1：E71 的转录逐字无误。** `−16` 的负号是**显示式首项的全字号负号**（不是上下标、不在分母里，
不适用 §6.6 的「分母里 `α′` 被读成 `α′²`」那类渲染伪影）；`(1 − 1)^4` 项**带前置减号，位于第二项**，
两轮独立渲染读数一致。**不是转录读错。**

### 7.2 抽取者的独立复算（**本小节是 researcher 的推算，不是原书文字**）

由 **(10.7.7b)**（`polchinski-1998-v2.md` §5.2 已 L1 逐字）：
`Z^α_β(τ) = q_τ^{(3α²−1)/24} exp(πiαβ/2) ∏_{m≥1}[1+e^{πiβ}q_τ^{m−(1−α)/2}][1+e^{−πiβ}q_τ^{m−(1+α)/2}]`，
其中 `q_τ = exp(2πiτ)`。取 `τ = 2it` ⇒ `q_τ = e^{−4πt}`。**记 `q ≡ e^{−2πt}`，则 `q_τ = q²`。**

- `Z^0_1(2it) = q_τ^{−1/24}∏(1−q_τ^{m−1/2})² = q^{−1/12}∏_{m≥1}(1−q^{2m−1})²`
  ⇒ `Z^0_1(2it)^4 = q^{−1/3}∏(1−q^{2m−1})^8`
- `Z^1_0(2it) = q_τ^{1/12}∏[1+q_τ^m][1+q_τ^{m−1}] = 2 q^{1/6}∏_{m≥1}(1+q^{2m})²`
  （**因子 2 来自 `m=1` 的 `[1+q_τ^0]`，即 R 扇区零模**）
  ⇒ `Z^1_0(2it)^4 = 16 q^{2/3}∏(1+q^{2m})^8`
- **乘积**：`Z^0_1(2it)^4 Z^1_0(2it)^4 = 16 q^{1/3} ∏_{m≥1}(1−q^{2m−1})^8(1+q^{2m})^8`
  `= +16 q^{1/3} ∏_{m≥1}[1+(−1)^m q^m]^8`（奇 `m` 给 `−`、偶 `m` 给 `+`，与印刷的 `[1+(−1)^m q^m]` 逐项吻合）

**与 reviewer-batch27 的结果完全一致（独立复现）。**

**★ 顺带解决 Q3（`(1−1)^4` 是什么）**：同法算
`Z^0_0(2it)^4 = q^{−1/3}∏(1+q^{2m−1})^8`，`Z^1_1(2it)^4 = q^{2/3}(1−1)^4∏(1−q^{2m})^8`（`i^4 = 1`），
⇒ `Z^0_0(2it)^4 Z^1_1(2it)^4 = (1−1)^4 q^{1/3}∏_{m≥1}[1−(−1)^m q^m]^8`，
**逐项等于 (10.8.17) 印刷的第二项**（含 `∏[1−(−1)^m q^m]^8` 这个奇/偶反过来的结构）。
⇒ **Q3 的「抽取者解读：4 对费米子各给一个 (1−1)」应当撤回并改写**：
`(1−1)^4` 的真正来源是 **`Z^1_1` 的 R 扇区零模因子 `[1+e^{−iπ}q_τ^0] = (1−1)`，四次方来自 `Z^1_1` 的四次方**，
与「8 个横向费米子分 4 对」无关。这与 `polchinski-1998-v2.md` §5.3 记的原书解释
（`Z^1_1` vanishes **due to cancellation between the two R sector ground states**）一致。

⚠ **一个必须声明的推断**：原书没说 (10.8.17) 里的 `q` 是哪一个。上面取 `q = e^{−2πt}`（而非 `q_τ = e^{−4πt}`）
**不是假设，而是被印刷形式反推出来的**：只有这个取法才同时给出印刷的指数 `q^{1/3}` 与印刷的乘积结构
`∏[1±(−1)^m q^m]^8`；取 `q = q_τ` 会得到 `16q_τ^{1/6}∏(1−q_τ^{m−1/2})^8(1+q_τ^m)^8`，与印刷形式不同型。

### 7.3 ★ 裁决：**判为排印错误**（按 `dedekind-eta-and-polchinski-13-3-12-misprint` 的同一套证据门槛）

判「书错」的门槛是「**读数可复现 + 独立旁证**」。两条都满足：

| 证据 | 内容 |
|---|---|
| (a) 读数可复现 | 两轮独立渲染、两个 agent 分别读页图，都读到 `−16` 与 `− (1−1)^4`；负号是全字号，不在分母/上下标 |
| (b) 正负性矛盾（**最硬的一条**） | 对 `0 < q < 1`，`Z^0_1(2it)` 与 `Z^1_0(2it)` 按 (10.7.7b) **都是正实数**（前者 `∏(1−q^{2m−1})²` 是平方，后者含因子 2 与 `∏(1+q^{2m})²`），故印刷的**右端恒为正**；而印刷的**左端恒为负**（第二项为零）。**如印的 (10.8.17) 不可能成立。** |
| (c) 其余部分全对 | 指数 `1/3`、两个乘积的奇偶结构、第二项的 `(1−1)^4`——**逐项与 (10.7.7b) 复算吻合**。⇒ 误差恰好是**一个整体符号**，不是更深的计算错误 |
| (d) 独立旁证 | reviewer-batch27 的解析 + 数值结果与本轮复算独立一致 |

**⚠ 不能判定错在哪一端（p.42 单页不足以裁决）。两种同样经济的修法各差一个符号：**
1. **左端首项应为 `+16`** ⇒ 左端 `= Z^0_1^4Z^1_0^4 − Z^0_0^4Z^1_1^4`，第二项为零，故等于印刷的右端。右端如印无误。
2. **右端应为 `−Z^0_1(2it)^4 Z^1_0(2it)^4`** ⇒ 左端如印（两项都带负号）`= −[Z^0_1^4Z^1_0^4 + Z^0_0^4Z^1_1^4]`。左端如印无误。

**⚠ 下游也裁决不了**：(10.8.18) 用的是右端的形式 `Z⁰₁⁴Z¹₀⁴/(η⁸Z⁰₀⁴)`，前因子写成 `±in`
（「upper sign is for `SO(n)`」）；而 (10.8.19) 的收尾段原书**明写**
「**This calculation does not determine the sign of the tadpole, but it should be `n ∓ 32`.**」（E72 已逐字）
⇒ 作者自己声明这条链上的整体符号不由本计算定死，故 (10.8.18)/(10.8.19) 无法反推 (10.8.17) 的符号归属。
**抽取者做的一致性检查（仅供参考，非原书）**：把 (10.8.4) 的 `n²`、(10.8.11) 的 `2^10`、(10.8.18) 的 `±2n·2^5`
代入 `Z_1 = −i(n∓32)²(…)` 展开 `n² ∓ 64n + 1024`，三项系数与符号**全部对上** ⇒
(10.8.18)↔(10.8.19) 内部自洽，**矛盾被隔离在 (10.8.17) 这一式之内，没有传播到主结论 `SO(32)`**。

### 7.4 对图的影响（researcher 不改 `graph/`）

- **`SO(32)` 主结论不受影响**：E72 的 (10.8.19) 与 E74 的计数链都不经过 (10.8.17) 的整体符号（见 §7.3 末）。
- **(10.8.17) 一律不进节点**（Q3 原来的处置「这一式不进任何节点」维持不变，但理由要换成本节的）。
- 若将来有节点要引「Möbius 带 R–R 迹的显式 `q` 展开」，**必须在 note 里写明本节的排印错误**，
  并且**只引右端 `Z⁰₁(2it)⁴Z¹₀(2it)⁴`（配 §7.2 的 `+16` 复算），不引左端的印刷符号**。
- **Q3 改写**：把「4 对费米子各给一个 `(1−1)`」这条抽取者解读标为**已被 §7.2 推翻**，换成
  「`(1−1)^4` = `Z^1_1(2it)^4` 的 R 零模因子的四次方」。

### 7.5 访问日志与遗留

| 目标 | 手法 | 结果 |
|---|---|---|
| p.42 高分辨重读 | 同一份 ch.10 PDF，**单页** `Read(pages=42)` | ✅ L1，`−16` 与 `−(1−1)^4` 两处符号确认 |

- **Q7.1**：错在左端还是右端，需**官方勘误表**才能关闭；勘误表本项目仍未取得（§6.5 记 KITP errata 页 404）。
- **Q7.2**：本节 §7.2 的复算全部是 researcher 手算，**建议 auditor 用数值（取 `q = 0.1`）复核一次**，
  reviewer-batch27 说已做过数值，但两方数值未互相比对过具体数字。
