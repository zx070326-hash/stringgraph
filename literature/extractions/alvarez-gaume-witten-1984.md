# 抽取记录：alvarez-gaume-witten-1984

- 文献：L. Alvarez-Gaumé and E. Witten, "Gravitational anomalies", *Nuclear Physics B* **234** (1984) 269–330. 预印本 HUTP-83/A039。Received 7 October 1983.
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文 62 页（journal p.269–330），逐页读图，无遗漏**
- 目标 area：`consistency`
- 派工来源：`extractions/green-schwarz-1984.md` **Q2 / Q3**（GS 1984 把常数 `c`、(20) 的三个系数、(22) 的相对归一化全部外包给本文的 **eq. (63)**）

---

## 0. 获取途径与证据等级

### 0.1 证据等级

沿用 `extractions/primary-sources-round2.md` §0 的 L0–L4 五级制（与 `green-schwarz-1984.md` §0.1 同）：

| 级 | 含义 |
|---|---|
| L1 | 逐页读了原文（扫描件/正文 PDF），可照抄措辞 |
| L2 | 出版方权威元数据或期刊逐字摘要 |
| L3 | 可溯源二手陈述 |
| L4 | 检索后端中介读取，非逐字 |
| L0 | 未能核实 |

### 0.2 ★ 本轮结果：**全文取到，等级 L1**

**成功路线（新路线，与 GS 1984 的 archive.org 路线不同，已写入 `reading-list.md`）：**

1. `https://inspirehep.net/api/literature?q=t%20gravitational%20anomalies%20and%20a%20Alvarez-Gaume&fields=titles,publication_info,control_number,report_numbers`
   → INSPIRE recid **192309**；report number **HUTP-83/A039**；DOI `10.1016/0550-3213(84)90066-X`；
   `external_system_identifiers` 含 **KEKSCAN `84-02-145`**、SPIRES-1107917、MSNET 736803。
   **`documents` 与 `urls` 字段均为空**（INSPIRE 侧无全文）。
2. WebSearch → **McGill 大学 PHYS 675 课程页挂了原刊逐页扫描件**：
   `https://www.physics.mcgill.ca/~keshav/675/gaumewitten.pdf`（3.2 MB，62 页 = 期刊 p.269–330）。
3. WebFetch 该 URL（PDF 自动落盘并打印本地路径），再用 `Read` 带 `pages` 逐页读图。
   扫描质量高：分数线、下标、求和/求积上下限基本清晰；仅个别处需靠上下文判读（见 §3）。

> **合规性说明（对应 `literature/CLAUDE.md` 规则 1）**：这是**已正式出版的期刊论文**在大学公开课程页上的副本，
> 与 `green-schwarz-1984` 用的 archive.org 公开扫描件同一性质，不是未发表草稿、也非私下材料。
> 本记录所有式号与页码都精确到期刊页，便于持有 Elsevier 版者逐条复核。
> 若船长口径更严，可按 §0.5 的重印本线索（*Current Algebra and Anomalies*, Princeton UP 1985, **pp. 451–514**）复核。

### 0.3 ★ 年份问题：GS 的「1983」不是 GS 的误印

- **本文印刷页眉逐字为：`Nuclear Physics B234 (1983) 269–330` / `© North-Holland Publishing Company`**（journal p.269 顶端）。
- 同页 `Received 7 October 1983`。
- 但 Elsevier DOI 元数据、INSPIRE `publication_info.year`、通行引法都作 **1984**（该期出版日 1984-04-02）。
- ⇒ **`green-schwarz-1984.md` §3.5 的判定应修正**：GS 参考文献 [3] 写「(1983)」是**忠实照抄本文自己的页眉**，
  不是 GS 的排印错误。bib 仍按通行引法登记 1984，但 note 必须写明页眉印 1983。

### 0.4 页码映射

PDF 第 `k` 页 = 期刊第 `268 + k` 页（PDF p.1 = journal p.269，PDF p.62 = journal p.330）。已在多处页眉直接核对，**非推论**。
下文一律用「journal p.NNN（PDF p.k）」。

### 0.5 失败/未采用的路线（记录以免重复消耗额度）

| 路线 | 结果 |
|---|---|
| archive.org `currentalgebraan0000unse`（*Current Algebra and Anomalies*, Treiman–Jackiw–Zumino–Witten eds., Princeton UP 1985；本文重印于 **pp. 451–514**） | **`fulltext/inside.php` 在两台服务器（ia800400 / ia600400）都返回 HTTP 403**。该 item 属 `printdisabled` + `internetarchivebooks` 借阅制，`access-restricted-item: true`。→ **GS 用的 archive.org BookReader 路线对借阅制 item 不适用**（这是对该路线适用边界的新认识） |
| archive.org `modern-kaluza-klein-theories`（GS 1984 所在文集） | 全文检索 `"gravitational anomalies"` 的 8 处命中**全部落在 GS 那篇之内**（leaf 611/612/614/616）⇒ **该文集不含 AGW** |
| INSPIRE `documents` / `urls` | 两字段皆空 |
| KEK 扫描件 `https://lib-extopc.kek.jp/preprints/PDF/1984/8402/8402145.pdf`（由 KEKSCAN `84-02-145` 推出的 URL） | **两次均 `socket hang up`**。未能判定是 URL 猜错还是域名被拦；因 McGill 路线已成功，未继续追。**KEKSCAN id → URL 的映射规则本身仍未验证** |
| 重印文集 *Supergravities in Diverse Dimensions*（Salam–Sezgin eds., 1989；即 INSPIRE `parent_record` 287655） | archive.org 无此书 |

### 0.6 本轮使用的交叉核验来源（**不得与 AGW 原文混为一谈**）

| 代号 | 来源 | 等级 | 用途 |
|---|---|---|---|
| **[Âroof]** | Harvard Math 272b (Spring 2005) 课程讲义 *The Â class*（`A-roof.nb`，Mathematica notebook 打印稿，无署名作者），`https://abel.math.harvard.edu/archive/272b_spring_05/handouts/A-roof/A-roof.pdf` | **L1**（6 页 PDF 落盘，pp.1–3 逐页读图） | 独立核对 AGW (82)(119)(120) 的 Â-genus 系数。见 §5.4 |

---

## 1. 约定（全部 L1）

### 1.1 AGW 自述的约定

| 项 | AGW 的取法 | 位置 |
|---|---|---|
| 号差 | **`(+ − − − ⋯ −)`**，逐字「Our signature is (+ − − − ⋯).」 | journal p.283；p.296 又一次「(The minus sign reflects a (+ − − − − − ⋯) signature.)」 |
| 维数记号 | `n` 或 `N = 4k+2` 为时空维数，`2n` 在 §11 表示流形维数（**同一字母 `n` 在 §6–§9 与 §11 含义不同，见 §3.3**） | 全文 |
| 计算所在空间 | 反常本身在 Minkowski 定义，实际求迹一律**转到欧氏空间** | p.293（(27) 前）、p.298、p.321 |
| `γ₅` | `4k` 维时 `(γ₅)² = −1`；**`4k+2` 维时 `γ₅² = +1`**，这是 `4k+2` 维才有手征反常的原因 | p.283 |
| 规范生成元归一 | 4 维例子里 `Tr λ^a λ^b = 2δ^{ab}`，`A_μ = ½Σλ^a A^a_μ`；**高维部分改用抽象生成元 `T^a_L`（左手费米子所在表示），未再声明归一** | p.273（(1) 后）；p.305 (57)(58) |
| `S Tr` | **对称化迹**，(109) 逐字定义：`S Tr T^{a_1}⋯T^{a_n} = (1/n!) ∑_perm Tr(T^{a_{i_1}}⋯T^{a_{i_n}})` | p.324 (109) |
| `x_i` | 曲率二形式矩阵 `R` 的**斜特征值**（(115) 给出 `R` 的 2×2 块形式），`i = 1…2k+1` | p.326 (115) |
| Pontryagin 类 | 由 `det(1 − R/2π) = ∑_{n≥0} p_n/(2π)^{2n}` 定义；`p₀=1, p₁=∑x_i², p₂=∑_{i<j}x_i²x_j², p₃=∑_{i<j<k}x_i²x_j²x_k²` | p.326 (116)；p.315 (83) |
| **「modified / 带撇的」Pontryagin 类 `p′_i`** | = (83) 的 `p_i` 但作替换 `R_{ab} → R_{ab} + D_aη_b − D_bη_a`（`η` 是无穷小坐标变换参数） | p.317（(90) 前）、p.319（(98) 后） |
| 线性化约定 | (89)(98)(105)(112) 只在**领头项**意义下成立：`R_{μναβ} = ∂²_{μα}h_{νβ} + ∂²_{να}h_{μβ} − ∂²_{νa}h_{μβ} − ∂²_{νa}h_{μβ}`（原文如此，见 §3.4）、`F^a_{μν} = ∂_μA^a_ν − ∂_νA^a_μ`；非领头项须靠 Wess–Zumino 相容条件补 | p.315、p.325 |

### 1.2 ★ 与 GS 1984 的接口（转图节点前必读）

| 项 | AGW | GS 1984 | 关系 |
|---|---|---|---|
| 曲率迹 | `p₁, p₂, p₃`（(83)(116)） | `tr R²`, `tr R⁴`, `tr R⁶`（GS (11)、(20)） | **由 (83) 一一换算**，见 §2 的 E7 与 §5.1。两边的 `R` 是同一对象（切空间 `SO` 的矩阵值曲率二形式） |
| 反常多项式整体归一 | (114) 明说「**apart from a factor common to the three cases**」——本文**从不固定**整体归一 | GS (20) 有确定系数 | 抽取者复算：**GS (20) = −48 × [由 AGW (119) 组合出的十二形式]**，五个系数全部一致。见 §5.1。**「−48」正是 AGW 留空的那个 common factor 在 GS 约定下的取值** |
| 混合规范–引力反常 | 生成函数 (63)（图式）与 (110)/(112)（Fujikawa 式）**都给了**，但**十维展开式没写** | GS (22) 是显式的十二形式 | **GS (22) 不在 AGW 里**。AGW p.325 只留了配方：「Explicit expressions for the combined anomalies can be obtained by combining (112) with the expression for Â(M) in (82)–(84).」；p.328 末句更明确：「**We will not explore here the phenomenological consequences of mixed gauge–gravitational anomalies.**」 |
| 常数 `c`（GS (17)(18)(21)(23) 的公共系数） | **全文不出现**，AGW 从不固定整体归一 | GS 说「can be deduced from refs. [3,9]」 | **`c` 的数值不在 AGW**。GS 的措辞是「deduced from」不是「given in」，与本次核实一致 |
| Chern–Simons 形式 / 下降方程 | **AGW 不建立下降方程**。全文唯一提到 Chern–Simons 的是 p.309 一段散文（`Q_α` 是 `4k−1` 维的次级特征类、在宇称下为奇、系数须量子化），**没有 `ω⁰_{2n+1}`、`ω¹_{2n}`、`δω⁰ = −dω¹` 这类式子** | GS (5)(6)(7)(8)(14)(15)(16) 全套下降方程 | ★ **AGW 不是 GS 那套 CS 记号与符号约定的源头。** 源头是 GS ref [9] = Zumino–Wu–Zee（在 AGW 参考文献 [7] 里还是「Univ. Washington preprint, 1983」）。**这直接回答 `green-schwarz-1984.md` 的 Q6：`H` 的符号约定不能溯到 AGW** |

### 1.3 与 `graph/conventions/` 的对照

本次抽取**未**改动、也未核对 `graph/conventions/` 下任何 canonical 节点（researcher 不写 `graph/`）。给 curator 的提示：

- AGW 的号差 `(+ − − ⋯)` 是**显式声明**的（journal p.283 逐字），可以放心挂 convention 节点 —— 这与 `green-schwarz-1984`（号差未声明、只能标 `inferred`）不同。
- AGW 没有 `α'`、没有世界面，纯四维/高维场论，无弦论约定需求。
- **`p_i` ↔ `tr R^{2k}` 的换算必须显式建成一条 convention 或引理节点**，否则 GS (20) 与 AGW (119) 看上去是两套毫无关系的数。

---

## 2. 陈述

> 除另有标注外，本节所有「位置 / 原文陈述 / 措辞」均为 **L1（逐页读图）**。
> 「文献自称的严格程度」栏一律**照抄原文动词**。

### E1 论文自我定位与结论范围（摘要）
- 位置：journal p.269（PDF p.1），摘要
- 类型：proposition（元陈述）
- 原文（逐字）："It is shown that in certain parity-violating theories in 4k + 2 dimensions, general covariance is spoiled by anomalies at the one-loop level. This occurs when Weyl fermions of spin-½ or -3/2 or self-dual antisymmetric tensor fields are coupled to gravity. (For Dirac fermions there is no trouble.) The conditions for anomaly cancellation between fields of different spin is investigated. In six dimensions this occurs in certain theories with a fairly elaborate field content. In ten dimensions there is a unique theory with anomaly cancellation between fields of different spin. It is the chiral n = 2 supergravity theory, which is the low-energy limit of one of the superstring theories. Beyond ten dimensions there is no way to cancel anomalies between fields of different spin."
- 文献自称的严格程度：**"It is shown that"**（摘要）；正文里对具体计算用 "we will calculate" / "the final result is"
- 备注：**摘要里"十维唯一理论"指的是 IIB（chiral n=2）超引力，不是 N=1 SUGRA+SYM**。这一点决定了 AGW 与 GS 的关系，见 E15/E16。

### E2 ★ AGW 对 type I 的判断（**GS 1984 后来推翻的那句**）
- 位置：journal p.271–272（PDF p.3–4），引言
- 类型：proposition
- 原文（逐字）："The 'type (I)' superstring theories reduce at low energy to n = 1 supergravity in ten dimensions. They are presumably anomalous. (**Introduction of a gauge group cannot remove the gravitational anomaly, as one may see from formulae of sect. 12.** On the contrary [7] it introduces new anomalies.) The 'type (II)' theories of closed superstrings only reduce at low energies to n = 2 supergravity in ten dimensions. They appear to be free of hexagon anomalies."
- 文献自称的严格程度：**"presumably anomalous"** / **"as one may see from formulae of sect. 12"**
- ★ 备注（**这是本次抽取最有价值的历史/逻辑点，转节点务必保留**）：
  1. AGW **在同一篇文章里预言了 type I / N=1 SUGRA+SYM 有不可消的引力反常**。GS 1984 正是推翻这句话的文章。
  2. **这不是 AGW 算错。** AGW 全篇的框架是「不同自旋的场之间相消」（摘要逐字："anomaly cancellation **between fields of different spin**"）。在这个框架里判断确实成立 —— 抽取者用 AGW (119) 复算：只用 `Î_{1/2}` 与 `Î_{3/2}`（N=1 无自对偶张量）要求三个系数同时为零，分别给 `n = 496`、`n = 1664/44 ≈ 37.8`、`n = 256/31 ≈ 8.26`，**互相矛盾，无解**。
  3. GS 的出路完全在 AGW 的框架**之外**：加**局域抵消项**（`S₁+S₂+S₃`），让残留的 `(tr R²)³` 与 `tr R² tr R⁴` 被树图抵消。AGW 全文**从未考虑过**用局域反项抵消（他们只在 p.276、p.309 讨论「加动量多项式/局域泛函」的自由度，且是在论证反常*不可*被消除的意义上）。
  4. ⇒ 图里若有「AGW 预言 type I 反常」与「GS 证明 type I 反常抵消」两个节点，**它们不是矛盾**，而是「同一命题在两套不同的可用操作集下」的两个结论。必须在 note 里写清楚这层限定，否则回译审计会判为冲突。

### E3 反常只出现在 `4k+2` 维
- 位置：journal p.282–283（PDF p.14–15），§4
- 类型：proposition
- 原文（逐字）："But O(n) has complex representations only if n = 4k + 2 for some integer k, so it is only in 4k + 2 dimensions that the effective action may violate general covariance."
- 又（p.288，PDF p.20）："The restriction to 4k + 2 dimensions emerges, in this context, because the index of the Dirac operator always vanishes except in 4k dimensions."
- 文献自称的严格程度：论证式，无编号定理
- 依赖：§2 关于「只有虚部会有反常」的一般论证（p.274）

### E4 ★ 自旋 ½ Weyl 费米子的纯引力反常生成函数
- 位置：journal p.294（PDF p.26），eq. **(32)**
- 类型：proposition
- 原文（逐字转录）：
  `I_{1/2} = −i (1/(2π)^{2k+1}) R(ε^{(i)}, p^{(j)}) ∏_{i=1}^{2k+1} (½x_i / sinh ½x_i)`
- 紧随其后的使用说明（逐字）："In interpreting this formula, it is to be understood that (32) is regarded as a function of `F_{μν}` via eq. (28), and that `F_{μν}` is to be expressed in terms of the `ε^{(i)}_μ` and `p^{(j)}_ν` by a formula given earlier. The product on the right-hand side of (32) is to be expanded, extracting terms linear in each `ε^{(i)}` and `p^{(j)}`."
- 文献自称的严格程度：由 §6 的图式计算 (24)–(31) 推出，**作者称为 "we have finally for the anomaly due to a complex spin-½ Weyl fermion"**
- 备注：`R(ε^{(i)}, p^{(j)})` 是 (25) 定义的运动学因子（`ε` 与动量与 Levi-Civita 的缩并），**不是曲率**。同一字母 `R` 在本文里有三义（标量曲率、曲率二形式矩阵、运动学因子），见 §3.3。

### E5 自旋 3/2 场的纯引力反常生成函数
- 位置：journal p.297（PDF p.29），eq. **(38)**
- 类型：proposition
- 原文（逐字转录）：
  `I_{3/2} = −i (1/(2π)^{2k+1}) R(ε^{(i)}, p^{(j)}) × (∏_{i=1}^{2k+1} (½x_i / sinh(½x_i))) (∑_{j=0}^{2k+1} 2 cosh x_j − 1)`
  ⚠ **求和下限印作 `j=0`，判定为原文误排，正确为 `j=1`，见 §3.1**
- 上下文（逐字）："Evaluating (37) by analogy with the treatment of (27), and remembering to subtract the contribution of a spin-½ ghost, the anomaly for the spin-3/2 field is"
- 文献自称的严格程度：陈述式
- 依赖：E4；§7 的 Faddeev–Popov 鬼计数（p.295 逐字："one needs two ghosts of the same chirality as `ψ_μ` and one of opposite chirality"，净效果 = 减去一个同手征自旋 ½ 鬼)

### E6 自对偶反对称张量场的纯引力反常生成函数
- 位置：journal p.303（PDF p.35），eq. **(55)(56)**
- 类型：proposition
- 原文（逐字转录）：
  - (55) `I = +¼i (1/(2π)^{2k+1}) R(ε^{(i)}, p^{(j)}) 2^{2k+1} ∏_{i=1}^{2k+1} (½x_i / sinh(½x_i)) cosh(½x_i)`
  - (56) `I = ⅛i (1/(2π)^{2k+1}) R(ε^{(i)}, p^{(j)}) ∏_{i=1}^{2k+1} (x_i / tanh x_i)`
    （"which, as always, is to be expanded to order 2k+2 in the x_i. As far as the term of order 2k+2 is concerned, (55) is equivalent to (56)."）
- 文献自称的严格程度：陈述式；本节自陈方法论薄弱 —— p.298 逐字："there are covariant field theories containing the self-dual field, these theories have no covariant lagrangian… **we will have to be pragmatic and invent suitable Feynman rules.**"
- ★ 备注（转节点时必须压低状态）：自对偶张量这一支**没有协变拉氏量**，AGW 是「发明费曼规则」+ 事后自洽检验（p.303 用二维玻色化对 `k=0` 做了一致性检查；p.322 (105) 用 Fujikawa 法独立复得 (56)）。**这是全文严格程度最低的一支。**

### E7 ★ Pontryagin 类与 `Tr R^{2k}` 的换算（GS ↔ AGW 的接口）
- 位置：journal p.315（PDF p.47），eq. **(83)**
- 类型：definition
- 原文（逐字转录）：
  - `det(1 − (1/2π)R) = 1 + (1/(2π)²)p₁ + (1/(2π)⁴)p₂ + (1/(2π)⁶)p₃ + ⋯`
  - `p₁(M) ≡ ∑_α ω_α² = −½ Tr R²`
  - `p₂(M) ≡ ∑_{α<β} ω_α²ω_β² = −¼ Tr R⁴ + ⅛(Tr R²)²`
  - `p₃(M) ≡ ∑_{α<β<γ} ω_α²ω_β²ω_γ² = −⅙ Tr R⁶ + ⅛ Tr R² Tr R⁴ − (1/48)(Tr R²)³`
- 引导句（逐字）："the `p_i(M)` are known as Pontryagin classes and are defined by:"
- 文献自称的严格程度：**定义式，无证明**
- 抽取者复算（**纯代数，已验证**）：设 `a_m = ∑_i x_i^{2m}`，则 `Tr R² = −2a₁`、`Tr R⁴ = 2a₂`、`Tr R⁶ = −2a₃`（`R` 由 (115) 的 2×2 斜块给出）。代入牛顿恒等式 `e₁=a₁`、`e₂=(a₁²−a₂)/2`、`e₃=(a₁³−3a₁a₂+2a₃)/6`，三条全部复现 (83)。✓
- ★ 备注：**这是把 AGW 的 `Î` 翻译成 GS 的 `Ω₁₂` 的唯一桥梁**，`green-schwarz-1984.md` 的 Q3 就靠它闭合。

### E8 ★★★ **eq. (63)** —— GS 1984 指名要的那一条
- 位置：journal p.306（PDF p.38），eq. **(63)**
- 类型：proposition
- **逐字转录（该页已单独重渲染二次核对）**：

  > `I_{1/2} = −S Tr (T_L^{a_1} ⋯ T_L^{a_r}) (i / (2π)^{n/2}) R(ε^{(i)}, p^{(j)}) ∏_{i=1}^{n/2} (½x_i / sinh ½x_i)`

- 引导句（逐字，紧接 (62)）："and the anomaly (since nothing else changes in the derivation of (32)) is"
- 紧随其后的使用说明（**journal p.307 首句，逐字**）："**Eq. (63) is to be expanded to order ½(n + 2) − r in the x_i, and expressed in terms of ε^{(i)} and p^{(j)} by rules explained in sect. 6.**"
- 上下文（同一推导链，逐字转录）：
  - (57) 胶子顶点因子 `−iγ^μ T^a_L`，"where `T^a_L` is the relevant group generator in the representation furnished by the left-handed fermions"
  - (58) 群论因子 `Tr T^{a_1}_L T^{a_2}_L ⋯ T^{a_r}_L`
  - (59) 引力子顶点 `−¼iγ_μ(p + p′)_ν`
  - (60) `[i/(p²−M²)](−i)[i/(p²−M²)] = (∂/∂M²)[i/(p²−M²)]`
  - (61) `Z′ = −S Tr T^{a_1}_L ⋯ T^{a_r}_L (∂/∂M²)^r ∫₀^∞ (ds/s) ∏ [½x_i /(4π sinh(½x_i s))] exp(−sM²)`（求积上下限见 §3.2）
  - (62) `Z′ = −S Tr (T^{a_1}_L ⋯ T^{a_r}_L) (1/(4π)^{2k+1}) (1/M²) ∏_{i=1}^{n/2} (½x_i / sinh ½x_i)`
- 关键的推理步（逐字，p.305）："Now, recall that to deal with the graviton vertices our first step was to carry out the gamma matrix algebra. This depends only on the `γ_μ` factor in (59). Since that factor appears also in (57), the gamma matrix algebra goes through in the same way whether the external particles are gluons or gravitons. **So all diagrams receive the same kinematic factor `R(ε^{(i)}, p^{(j)})` discussed in sect. 5.**"
- 文献自称的严格程度：**"since nothing else changes in the derivation of (32)"** —— 明说是 (32) 的平行推导，无独立证明
- 依赖：E4（(32)）、(57)–(62)
- ★★ **对 GS 的意义（`green-schwarz-1984.md` Q2 的答案）**：
  - GS (17) 后写「The **numerical constant `c`** can be deduced from refs. [3,9]」，GS (22) 前写「The **relative normalization of all the anomalies** can be deduced from eq. (63) of ref. [3]」。
  - **(63) 确实是一条能同时产出纯规范、纯引力、混合三类反常的单一生成公式**（`r` = 外胶子数，`½(n+2)−r` = 展开阶数）：`r = 6, n = 10` 给纯规范六边形反常；`r = 0` 退回 (32) 给纯引力；中间的 `r` 给混合。三者共用同一个前置因子 `−S Tr(⋯)·i/(2π)^{n/2}·R(ε,p)`，**所以"相对归一化"确实完全由 (63) 决定**。GS 的措辞在本次核实下是准确的。
  - **但 (63) 里没有 `c` 这个数，也没有 GS (22) 那个十二形式。** AGW 从不固定整体归一（见 E14 的「apart from a factor common to the three cases」）。GS 说的是 "**deduced from**"，不是 "given in" —— 措辞也准确。
  - ⇒ **GS 反常链的数值系数层，其一手依据是 AGW (63) + (83)（+ GS 自己做的展开），不是 AGW 里现成的公式。** 转节点时 GS (22) 与常数 `c` 的 source 只能标 AGW 为**方法来源**，并把「GS 自己做了这步展开、AGW 未做」写进 note。

### E9 纯规范反常的相消条件
- 位置：journal p.307（PDF p.39），eq. **(64)**
- 类型：proposition
- 原文（逐字）："Since (63) is even in each of the `x_i`, we see there is an anomaly only if `½(n+2) − r` is even. There is potential trouble if the number `r` of external gluons is `r = ½n+1, ½n−1, ½n−3, ⋯`. The condition for cancellation of anomalies (assuming only spin-½ fields are considered) is"
  - (64) `S Tr T^{a_1}_L T^{a_2}_L ⋯ T^{a_r}_L = 0`
  "for all such `r` and all `a_1 ⋯ a_r`. For large `n`, (64) is very restrictive, since many values of `r` must be considered. For `r = ½n+1`, this result was obtained in ref. [7]."
- 文献自称的严格程度：陈述式；`r = ½n+1` 那一支明确归给 ref [7]
- 备注：`n = 10` 时 `r = 6`，即六边形。**这正是 GS (12c) 里 `tr F⁶` 项须消失的条件的 AGW 版本**，但 AGW 没做任何群论分析（不出现 SO(32)、E₈）。

### E10 自旋 3/2 的混合反常
- 位置：journal p.307（PDF p.39），eq. **(65)**
- 类型：proposition
- 原文（逐字转录）：
  `I_{3/2} = −S Tr (T̃^{a_1}_L T̃^{a_2}_L ⋯ T̃^{a_r}_L) (i/(2π)^{n/2}) R(ε^{(i)}, p^{(j)}) × ∏_{i=1}^{n/2} (½x_i / sinh ½x_i) × (∑_{j=1}^{n/2} 2 cosh x_j − 1)`
  "where now `T̃^a_L` are the group generators for left-handed fields of spin-3/2."
- 引导句（逐字）："In general, we must also include the contribution of possible charged fields of spin-3/2. **No new features arise in generalizing the conditions of sect. 7**, and we get"
- 文献自称的严格程度：**"No new features arise"** —— 无独立推导
- 备注：**此处求和下限印作 `j=1`**，与 (38) 的 `j=0` 冲突，是 §3.1 判定的第二条证据。

### E11 Fujikawa 路线：Â 多项式的出现
- 位置：journal p.314（PDF p.46），eq. **(81)(82)**
- 类型：proposition
- 原文（逐字转录）：
  - (81) `(Tr ρ) = ∫_{M_{2n}} (∏_α (x_α/4π) / sinh(x_α/4π))_Vol`
  - 引导句："The function of the `x_α` appearing in (81) is the index density for the Dirac operator, and it is known in the mathematical literature as the **Dirac genus, or Â polynomial [6]**. Its expansion in terms of the `x_α` is"
  - (82) `A(M_{2n}) = 1 − (1/24)p₁(M) + (1/5760)(7p₁² − 4p₂) + (1/(2⁶·15120))(−16p₃ + 44p₁p₂ − 31p₁³) + ⋯`
- 文献自称的严格程度：把 Â 多项式**外包给数学文献**（ref [6] 含 T. Eguchi, P.B. Gilkey and A.J. Hanson, Phys. Reports **66** (1980) 213）
- ★ 备注：`2⁶ · 15120 = 967680`。**这一条可由独立数学来源核实，见 §5.4。**

### E12 十维各自旋的反常（Fujikawa 路线的显式结果）
- 位置：journal p.317、p.319、p.322（PDF p.49、51、54）
- 类型：proposition
- 原文（逐字转录）：
  - **(92)** 自旋 ½，十维：「Finally, in ten dimensions the anomaly is contained in」 `+ (i/(2⁶·15120))(−16p′₃ + 44p′₁p′₂ − 31p′₁³)`
  - **(101)** 自旋 3/2，十维：`A_{3/2}(d=10) = −(i/((2π)⁵·2⁶))((5/336)p′₁³ − (3/28)p′₁p′₂ + (11/21)p′₃)`
  - **(106)** 自对偶张量，十维：`A(d=10) = (i/(967680(2π)⁵))(−256p′₁³ + 1664p′₁p′₂ − 7936p′₃)`
  - 配套的低维：**(90)** `d=2` 自旋 ½ 的 `(1/24)ip′₁`；**(91)** `d=6` 的 `−(1/5760)i(7p′₁² − 4p′₂)`；**(99)** `A_{3/2}(d=2) = −(23i/48π)p′₁`；**(100)** `A_{3/2}(d=6) = −(i/(2π)³)(1/16)((55/72)p′₁² − (49/18)p′₂)`；**(106)** 的 `d=2`、`d=6` 两行
- 文献自称的严格程度：p.317 逐字自陈 **"It is now a tedious exercise in elementary algebra to insert (82) in (89) and expand to the appropriate order"**；致谢里说这些幂级数是 **P. Ginsparg 写计算机程序生成的**（见 E17）
- ★ 抽取者复算（**(101) 的最后一个系数原读作 `11/24`，经与 (119) 交叉核对改判为 `11/21`**）：
  `(119)` 的 `Î_{3/2}` 系数除以 `15120` 应等于 `(101)` 的括号内系数：
  `225/15120 = 5/336` ✓、`1620/15120 = 3/28` ✓、`7920/15120 = **11/21**` ✓（`11/24 = 0.4583` 对不上，`11/21 = 0.5238` 对得上）。
  同法验 (100)：`(1/16)(55/72) = 55/1152 = 275/5760` ✓、`(1/16)(49/18) = 49/288 = 980/5760` ✓。
  ⇒ **(99)–(101) 与 (117)–(119) 内部完全一致。**

### E13 ★ Fujikawa 路线的混合规范–引力生成公式（(63) 的等价重述）
- 位置：journal p.324–325（PDF p.56–57），eq. **(110)(112)**
- 类型：proposition
- 原文（逐字转录）：
  - (110) `(i^n/(2π)^n) ∫(dψ₀) Tr exp(½iψ₀^i ψ₀^j F^α_{ij} T^α) ∏_r (½ix_r / sinh(½ix_r))`
    引导句（逐字）："If we also want to include the gravitational contribution to the anomaly, we just include the **Â(M) polynomial (82)** in the integrand of (108) as follows from the arguments of the first part of this section. Thus the combined gauge and gravitational contribution to the axial anomaly in `2n` dimensions is given by"
  - (112) `lim_{β→0} Tr γ₅ iη_α(c^*T^α c) e^{−βH} = (i^n/(2π)^n) ∫(dψ₀)(Tr e^{i(F^α+η^α)T^α}) Â(M)`，`F^α = ½F^α_{ij}ψ₀^iψ₀^j`
- ★ **journal p.325 首句（逐字，本次抽取最关键的"配方句"之一）**："**Explicit expressions for the combined anomalies can be obtained by combining (112) with the expression for Â(M) in (82)–(84).**"
- 文献自称的严格程度：配方式陈述；紧接着的限定句（逐字）："We would like to remind the reader again that formulae (89), (98), (105), and (112) should be understood in terms of the leading term… Non-leading terms should be obtained through application of the Wess–Zumino consistency conditions."
- ★ 备注：**(110)/(112) 就是现代记号里的 `ch(F) · Â(R)`。** 它与 (63) 内容相同、路线不同（(63) 图式，(112) Fujikawa）。GS 引的是 (63)，但要真做十维展开，(112)+(82) 是更直接的入口。**转节点时建议把 (63) 与 (112) 建成同一命题的两条独立推导。**

### E14 ★★ 三种自旋的反常生成函数（十维相消的直接输入）
- 位置：journal p.325（PDF p.57），eq. **(114)**
- 类型：proposition
- 引导句（逐字）："We have seen that in `4k + 2` dimensions, the gravitational anomalies are conveniently written as polynomials of order `2k+2` in certain quantities `x_i`, `i = 1 ⋯ 2k+1`. The spin-½, spin-3/2, and antisymmetric tensor anomalies are (**apart from a factor common to the three cases**)*"
- 原文（逐字转录）：
  - `Î_{1/2} = ∏_{i=1}^{2k+1} (½x_i / sinh ½x_i)`
  - `Î_{3/2} = (∏_{i=1}^{2k+1} (½x_i / sinh ½x_i))(−1 + ∑_{j=1}^{2k+1} 2 cosh x_j)`
  - `Î_A = −⅛ ∏_{i=1}^{2k+1} (x_i / tanh x_i)`
  "In `4k+2` dimensions, one is to expand these formulae in powers of the `x_i`, keeping only the terms of order `2k+2`."
- ★ **脚注（逐字，转节点必须一并带上，否则会算错场的计数）**："By `I_{1/2}` and `I_{3/2}` we mean the anomalies of **positive chirality complex** Weyl fields. **For a real Weyl field (possible in 8k or 8k+2 dimensions) one must divide by two.** `I_A` is the anomaly for a *self-dual* **real** antisymmetric tensor field. By a self-dual (rather than anti-self-dual) tensor we mean the representation that arises in combining two positive chirality spinors. **For a complex self-dual tensor one must multiply `I_A` by two.** The minus sign in `I_A` arises from the Bose (rather than Fermi) regulator loop; the factor of ⅛ has a more complicated origin, which was explained in sects. 9 and 10."
  ⚠ 末句的「sects. 9 and 10」与本文自身的节标题对不上，见 §3.5。
- 文献自称的严格程度：汇总式，指回 (32)(38)(56)
- ★ 备注：**「apart from a factor common to the three cases」是本文与 GS 接口处最重要的一句话** —— AGW 明确放弃固定整体归一，所以 GS 的 `c` 与整体系数**在原理上就不可能**从 AGW 直接读出，只能由 GS 自己定。

### E15 ★★★ **十维的三条反常多项式（GS (20) 的真正来源）**
- 位置：journal p.327（PDF p.59），eq. **(119)**（该页已单独重渲染二次核对）
- 类型：proposition
- 引导句（逐字）："Turning now to ten dimensions, we find by power series expansion of (114)"
- 原文（逐字转录）：
  - `Î_{1/2} = (1/967680)(−31p₁³ + 44p₁p₂ − 16p₃)`
  - `Î_{3/2} = (1/967680)(225p₁³ − 1620p₁p₂ + 7920p₃)`
  - `Î_A   = (1/967680)(−256p₁³ + 1664p₁p₂ − 7936p₃)`
- 原文（逐字，结论）："Since there are three fields and three linearly independent anomalies, one would not *a priori* expect non-trivial calculation of gravitational anomalies to be possible in ten dimensions. But now we meet a real surprise, which is by far the most striking result of this paper. **The expressions for `Î_{1/2}`, `Î_{3/2}`, and `Î_A` in (119) are linearly dependent. In addition, the minimal solution is remarkably simple: `−Î_{1/2} + Î_{3/2} + Î_A = 0`.** Thus, a ten-dimensional theory with one (complex) negative chirality spin-½ field, one (complex) positive chirality spin-3/2 field, and one (real) self-dual antisymmetric tensor is free of anomalies. What is more, modulo fields that do not contribute anomalies, this is precisely the field content of the chiral `n = 2` supergravity theory in ten dimensions [11], which is the naive low-energy limit of one of the ten-dimensional supersymmetric string theories [12]. Since this theory cannot be coupled to supersymmetric matter multiplets, and cannot be extended to a theory with `n > 2` supersymmetry (Nahm, ref. [11]), **it appears to be the unique theory in ten dimensions with non-trivial cancellation of gravitational anomalies.**"
- 文献自称的严格程度：**"we find by power series expansion of (114)"**；结论句用 **"it appears to be"**（不是"我们证明"）
- 抽取者复算（**纯算术，已验证**）：`−Î_{1/2} + Î_{3/2} + Î_A` 的三个系数
  - `p₁³`：`+31 + 225 − 256 = 0` ✓
  - `p₁p₂`：`−44 − 1620 + 1664 = 0` ✓
  - `p₃`：`+16 + 7920 − 7936 = 0` ✓
- ★★ 备注：**这是 GS (20) 的唯一一手来源。** 见 §5.1 的完整复算。

### E16 六维与十四维
- 位置：journal p.327、p.328（PDF p.59、60），eq. **(118)(120)**
- 类型：proposition
- 原文（逐字转录）：
  - (118)（六维）：`Î_{1/2} = (1/5760)(7p₁² − 4p₂)`，`Î_{3/2} = (1/5760)(275p₁² − 980p₂)`，`Î_A = (1/5760)(16p₁² − 112p₂)`
    结论（逐字）："The simplest non-trivial solution is `21Î_{1/2} − Î_{3/2} + 8Î_A = 0`. Thus a six-dimensional theory with 21 positive chirality spin-½ fields, one negative chirality gravitino, and eight self-dual antisymmetric tensor fields is free of anomalies."
  - (120)（十四维）：
    `Î_{1/2} = (1/464486400)[381p₁⁴ − 904p₁²p₂ + 512p₁p₃ + 208p₂² − 192p₄]`
    `Î_{3/2} = (1/464486400)[6393p₁⁴ − 42472p₁²p₂ − 70144p₁p₃ + 102544p₂² − 94656p₄]`
    `Î_A = (1/464486400)[12288p₁⁴ − 90112p₁²p₂ + 290816p₁p₃ + 77824p₂² − 1560576p₄]`
    结论（逐字）："These expressions are linearly independent, so non-trivial anomaly cancellations are impossible in fourteen dimensions."
  - 全文结论（逐字，p.328）："In conclusion, in any number of dimensions non-trivial cancellation of gravitational anomalies requires massless spin-3/2 fields and hence supergravity. In six dimensions there are various theories with such non-trivial cancellation of gravitational anomalies. They require a fairly elaborate field content, but may be of interest. In ten dimensions the unique theory with such non-trivial cancellation is the chiral `n = 2` supergravity theory which is the low-energy limit of one of the superstring theories. Beyond ten dimensions non-trivial cancellations of gravitational anomalies does not occur. **We will not explore here the phenomenological consequences of mixed gauge–gravitational anomalies.**"
- 抽取者复算：
  - 六维 `21Î_{1/2} − Î_{3/2} + 8Î_A`：`p₁²`：`21·7 − 275 + 8·16 = 147 − 275 + 128 = 0` ✓；`p₂`：`21·(−4) + 980 + 8·(−112) = −84 + 980 − 896 = 0` ✓
  - 十四维线性无关：抽取者取 `(p₁⁴, p₁²p₂, p₁p₃)` 三列作 3×3 子式，手算得 `≈ −4.68 × 10¹²`（非零）⇒ 秩为 3 ⇒ 线性无关 ✓。**这是抽取者的手工大数乘法，原文未给计算；建议由 Lean/`norm_num` 复核。**
- ★★ 备注（**最容易被误引的一条**）：**AGW 的「十维唯一」是关于「不同自旋的场之间相消（`Î` 的线性组合为零）」的唯一性，不是关于规范群的唯一性。** 与 `green-schwarz-1984.md` E20/Q1 的「SO(32) / E₈×E₈ 唯一性」是完全不同的命题，**绝不能混挂到同一个节点**。

### E17 ★ 数值系数的实际来源与作者自陈的可靠性
- 位置：journal p.326 脚注（PDF p.58）与 p.328 致谢（PDF p.60）
- 类型：proposition（元陈述）
- 原文（逐字，p.326 §12 首页脚注）："**We are grateful to P. Ginsparg for correcting a variety of numerical errors in an earlier version of this section.**"
- 原文（逐字，致谢）："We wish to thank M.F. Atiyah for valuable comments that helped motivate this work, and **P. Ginsparg for useful discussions and for writing a computer program to generate the complicated power series expansions in sects. 11 and 12.** We wish to thank J. Bagger, P. Frampton, D.J. Gross, J. Schwarz, and A. Zee for supergravity discussions. We also thank R. Jackiw for discussions of global anomalies, and for drawing our attention to ref. [36], where an anomalous commutator closely related to our discussion in sect. 5 is evaluated."
- ★ 备注（**转节点时的认识论意义，很重要**）：
  1. **§11 与 §12 的全部幂级数系数（含 (82)(92)(99)–(101)(106)(117)–(120)）是计算机代数生成的**，作者自己说的。
  2. **发表前有过一版数值错误，由第三人（Ginsparg）改正。** 这不降低发表版的可信度，但说明这些数**不是手工可验证的推导产物，而是 CAS 输出**。
  3. ⇒ 这恰好使它们成为**理想的 Lean 形式化目标**：它们是纯粹的多项式代数事实，且历史上已经出过错。见 §5。
  4. 独立核验已完成两条：**(a) 内部**（(99)–(101)/(106) 与 (117)–(119) 互洽，见 E12）；**(b) 外部**（Â 多项式与数学文献一致，见 §5.4）。

### E18 全局引力反常（与 GS 无关，但图里可能需要）
- 位置：journal p.307–310（PDF p.39–42），§10
- 类型：proposition
- 原文（逐字，结论）："We conclude, therefore, that in `8k` or `8k+1` dimensions it is inconsistent to couple to gravity an odd number of Majorana fermions of spin-½. We do not know if there is a similar problem for spin-3/2 fields, or whether, if so, spin-½ anomalies can be cancelled by spin-3/2 anomalies."
- 依据（逐字）：基于 Hitchin 的结果 —— "Is there in `8k` or `8k+1` dimensions a disconnected coordinate transformation under which `√det iD̸` changes sign? Remarkably enough this question has already been answered by Hitchin [27] who proved the existence of such a transformation (this reference was pointed out by M. Atiyah)."
- 文献自称的严格程度：**"We conclude"**，但结尾自陈两处未知（"We do not know if…"）
- 备注：`[27] N. Hitchin, Adv. Math. **14** (1974) 1`。**十维 `= 8·1+2`，不是 `8k` 或 `8k+1`，所以这一条对 GS 的链条不适用。**

### E19 AGW 自陈的方法论限制（转节点时须压低下游状态）
- 位置：journal p.315（PDF p.47），§11
- 类型：proposition（元陈述）
- 原文（逐字）："In applying Fujikawa's method to the gravitational or mixed anomalies, care must be taken in interpreting the results. **As it stands, this procedure does not generate the complete solution to the Wess–Zumino consistency conditions.** The regulator we will use explicitly violates Bose symmetry because the gravitons have `V − A` couplings with the matter fields, not vectorial couplings which appear in `iD̸`. However, if we only look for the leading term in the anomaly (the `n+1` polygon in `2n` dimensions), i.e. the term with the highest number of external momenta, the results that will be obtained are correct **up to a factor of `1/(n+1)`** required to restore Bose symmetry as explained thoroughly in sects. 2 and 6. **The subleading terms could in principle be obtained using the Wess–Zumino consistency conditions.**"
- 另一处（逐字，p.291）："the Bose symmetric amplitude would have; it is equal, in each channel, to `1/(2k+2)` times the anomaly we will calculate in one channel."
- 文献自称的严格程度：**明确的自我限定**
- ★ 备注：**AGW 计算的是「领头多边形」的系数，不是完整的 Wess–Zumino 相容反常。** 这一点对 GS 无害（GS 也只用领头多边形 + 相容条件补全，GS (11) 后逐字说 "Their form can be deduced by implementing the Wess–Zumino consistency conditions [8]"），但转节点时应把「完整相容反常」与「领头多边形系数」区分开。

### E20 AGW 引用的关键外部依赖
- 位置：journal p.329–330（PDF p.61–62），References
- 类型：definition（书目）
- 与本项目相关的条目（逐字转录）：
  - `[6]` 含 `T. Eguchi, P.B. Gilkey and A.J. Hanson, Phys. Reports **66** (1980) 213` —— **Â 多项式的出处**
  - `[7]` 含 `P.H. Frampton and T.W. Kephart, Phys. Rev. Lett. **50** (1983) 1343, 1347`；`P.K. Townsend and G. Sierra, Nucl. Phys. **B222** (1983) 493`；**`B. Zumino, W. Yong-Shi and A. Zee (Univ. Washington preprint, 1983)`**；`Y. Matsuki and Y. Matsuki and A. Hill, OSU preprints, 1983`
  - `[11]` 含 `W. Nahm, Nucl. Phys. **B135** (1978) 149`；`M.B. Green and J.H. Schwarz, Phys. Lett. **109B** (1982) 444; **122B** (1983) 143`；`J. Schwarz and P. West, Phys. Lett. **126B** (1983) 301`；`P.S. Howe and P. West, King's College preprint (1983)`
  - `[12]` 含 `M.B. Green and J.H. Schwarz, Nucl. Phys. **B181** (1981) 502; **B198** (1982) 252, 441; Phys. Lett. **109B** (1982) 444`；`J.H. Schwarz, Phys. Reports **89** (1982) 223`
  - `[22]` `M.F. Atiyah and I.M. Singer, Ann. of Math. **87** (1968) 485, 546; **93** (1971) 1, 119, 139; M.F. Atiyah and G.B. Segal, Ann. of Math. **87** (1968) 531`
  - `[27]` `N. Hitchin, Adv. Math. **14** (1974) 1`
  - `[28]` `K. Fujikawa, Phys. Rev. Lett. **42** (1979) 1195; **44** (1980) 1733; Phys. Rev. **D21** (1980) 2848; **D22** (1980) 1499 (E); **D23** (1981) 2262`
  - `[30]` `E. Witten, Nucl. Phys. **B202** (1982) 253`
  - `[31]` `L. Alvarez-Gaumé, Harvard preprints HUTP-82/A029 and A035`
- ★ **对 `green-schwarz-1984.md` Q6 的关键发现**：AGW `[7]` 里的 **`B. Zumino, W. Yong-Shi and A. Zee (Univ. Washington preprint, 1983)`** 就是 GS 的 `[9]` = Zumino–Wu–Zee, Nucl. Phys. **B239** (1984) 477（AGW 写作时还是预印本；`W. Yong-Shi` 是 `Wu Yong-Shi` = Y.-S. Wu 的错排）。
  ⇒ **下降方程 `ω⁰_{2n+1}` / `ω¹_{2n}` 与 Chern–Simons 符号约定的一手来源是 Zumino–Wu–Zee，不是 AGW。** 见 §4 的 Q-A3。

---

## 3. 未核实式号 / 读图不确定处

> 本节列出**即使拿到 L1 扫描件仍不能 100% 确定**的地方。转图节点时凡涉及这几处，必须保留标记。

### 3.1 ★ (38) 的求和下限：`j=0` 还是 `j=1`
- (38)（journal p.297，PDF p.29，**已单独重渲染**）印作 `(∑_{j=0}^{2k+1} 2 cosh x_j − 1)`，下限读作 **0**。
- **但同一页 (38) 上方三行的无编号显示式印作 `∑_{j=1}^{2k+1} 2 cosh x_j`（下限 1）**，那正是被代进 (38) 的自旋迹。
- 且 **(65) 印作 `∑_{j=1}^{n/2}`**，**(114) 印作 `∑_{j=1}^{2k+1}`**。
- 语义检验：矢量表示有 `n = 2(2k+1)` 个分量，`tr exp` 应给 `∑_{j=1}^{2k+1} 2cosh x_j`（共 `2(2k+1) = n` 项）。若下限为 0 则得 `n+2` 项，错。
- **判定：(38) 的 `j=0` 是原文误排（或扫描字形误读），正确为 `j=1`。** 三处独立的同文证据 + 一条语义检验。转节点时按 `j=1` 写，并 note 指向本条。

### 3.2 (61) 的求积指标
- (61)（journal p.306，PDF p.38，**已单独重渲染**）的求积印作 `∏_{k=1}^{2k+1}`，**求积指标与上限用了同一个字母 `k`**，而被乘的对象带下标 `i`（`½x_i / (4π sinh(½x_i s))`）。
- 对照 (30)（`∏_{i=1}^{2k+1}`）与 (62)（`∏_{i=1}^{n/2}`），**(61) 的下限应为 `i=1`**。
- **判定为原文排印疏忽（或扫描误读）；不影响任何结论。**

### 3.3 (61) 之后那句的展开阶数：`½(n+2) − k` 还是 `− r`
- journal p.306 (61) 后一句读作 "which now is to be expanded to order `½(n+2) − k` in the `x_i`"。
- 但 **journal p.307 首句清晰印作 "Eq. (63) is to be expanded to order `½(n+2) − r` in the `x_i`"**，且语义上必须是 `r`（外胶子数），因为每个胶子吃掉一阶。
- **判定：p.306 那句应为 `− r`**；p.307 的 `− r` 是可放心引用的那一处。

### 3.4 (89)/(112) 前的线性化黎曼张量表达式
- journal p.315 与 p.325 两处都写 `R_{μναβ} = ∂²_{μα}h_{νβ} + ∂²_{να}h_{μβ} − ∂²_{νa}h_{μβ} − ∂²_{νa}h_{μβ}`（p.325 的形式），**四项中有两项在扫描件上看起来相同**，显然至少一个下标被印错/读错。
- 正确的线性化式应为 `R_{μναβ} = ½(∂_μ∂_α h_{νβ} + ∂_ν∂_β h_{μα} − ∂_ν∂_α h_{μβ} − ∂_μ∂_β h_{να})`（对称化），AGW 省了 `½`。
- **判定：该式在本记录中不作为可引内容。** 它对 GS 的链条无影响（GS 用协变的 `R = dω + ω²`）。

### 3.5 (114) 脚注末句的节号
- 脚注末句读作 "the factor of ⅛ has a more complicated origin, which was explained in **sects. 9 and 10**"。
- 但本文 §9 = "Mixed anomalies"、§10 = "Global gravitational anomalies"，**都不含 ⅛ 的来历**。
- `⅛` 实际出现在 **(56)（§8，自对偶张量）** 与 **(105)（§11）**。
- **判定：脚注的节号疑似错误，应为「sects. 8 and 11」。** 不排除是抽取者读图错误（数字小）。**引用该脚注时不要转引节号。**

### 3.6 编号 (104) 与 (113) 未出现
- 通读全文未见 **(104)** 与 **(113)**：p.321 是 (102)(103)，p.322 直接跳到 (105)(106)；p.324 是 (112)，p.325 直接是 (114)。
- **可能是原文跳号，也可能是抽取者漏看**（两处都在页面转换处）。**引用时不要假设 (104)/(113) 存在。**

### 3.7 (114) 后一句的自引编号
- journal p.325 (114) 后读作 "We observe that the formulas in **(1)** are invariant under permutations of the `x_i`…"，语义上必须是 **(114)**。
- **判定：原文自引编号排印错误（或扫描丢字），应为 (114)。**

### 3.8 (83) 中 `p_i` 的 `(2π)` 归一 vs (90)–(106) 中 `p′_i` 的用法
- (83)/(116) 把 `(2π)^{-2n}` 显式提在 `p_n` 之外；但 (90)–(92) 的「the anomaly is contained in `(1/24)ip′₁`」这类陈述**没有写出 `(2π)` 幂**，而 (99)–(101)(106) 又写了。
- 这不是错误，而是 AGW 在「反常包含在这个特征类里」与「反常等于这个具体表达式」两种说法间来回切换。
- **后果：(90)(91)(92) 三条不能单独用作定量来源；定量结论一律引 (99)–(101)(106)(117)–(120)。**

---

## 4. 未解决的疑问（留给 curator / auditor）

**Q-A1（`c` 的数值）** —— GS (17) 的常数 `c` **不在 AGW 里**（AGW 全文不固定整体归一，(114) 明说 "apart from a factor common to the three cases"）。
GS 说 `c` "can be deduced from refs. [3,9]"，即需要 AGW (63) **加上** Zumino–Wu–Zee 的下降方程归一才能定出。
**建议**：`c` 相关的节点标 `physical-argument`，sources 同时列 `alvarez-gaume-witten-1984`（(63)）与 `zumino-wu-zee-1984`（未抽取），并在 note 里写明「两篇都不直接给出 `c`，GS 自己做了这步推导且未给中间步骤」。
`zumino-wu-zee-1984` 因此升级为**下一个 P0 抽取目标**。

**Q-A2（GS (22) 混合反常十二形式）** —— **不在 AGW 里**（p.328 末句逐字："We will not explore here the phenomenological consequences of mixed gauge–gravitational anomalies."）。
AGW 只给配方（p.325："combining (112) with the expression for Â(M) in (82)–(84)"）。
**建议**：GS (22) 的节点 status 定为 `physical-argument`，note 写明「AGW 提供生成函数与 Â 展开，十维混合十二形式的展开是 GS 自己做的，GS 未给中间步骤，本项目未复算」。
**这是 GS 链上仍然未闭合的最后一处**（与 (20) 不同 —— (20) 已在本轮完全闭合，见 §5.1）。

**Q-A3（`H` 的 Chern–Simons 符号，即 `green-schwarz-1984.md` 的 Q6）** —— **AGW 不是源头，本轮可以结案一半。**
AGW 全文没有下降方程、没有 `ω⁰_{2n+1}` / `ω¹_{2n}`；唯一提 Chern–Simons 的是 p.309 一段散文。
源头是 **Zumino–Wu–Zee**（AGW ref [7] 的 "Univ. Washington preprint, 1983" = GS ref [9] = Nucl. Phys. B239 (1984) 477）。
**建议**：`H` 符号约定的 convention 节点，其来源应指向 `zumino-wu-zee-1984`，**不要**指向 AGW。

**Q-A4（AGW「type I 必反常」vs GS「type I 反常抵消」）** —— 见 E2。
**两条不是矛盾**，因为 AGW 的框架只允许「不同自旋的场之间相消」，GS 引入了框架外的局域抵消项。
**建议**：建两个节点并用一条 note 显式说明这个范围差；**不要**把 AGW 标成 `refuted`，也**不要**在 GS 节点上把 AGW 列成"被推翻的依赖"。
这是全图里少见的「同一物理问题、两个都对但适用范围不同的结论」的样本，值得做成方法论示例。

**Q-A5（自对偶张量支的严格程度）** —— AGW 自陈无协变拉氏量、"we will have to be pragmatic and invent suitable Feynman rules"（p.298）。
`Î_A` 因此是三支里最弱的一支。但 **GS 1984 的链条完全不用 `Î_A`**（N=1 SUGRA+SYM 没有自对偶张量），所以这条不污染 GS 分支。
**建议**：`Î_A` 相关节点标 `physical-argument`，且**不要**让它成为 GS 分支的祖先。

**Q-A6（Bose 对称性因子 `1/(n+1)`）** —— 见 E19。AGW 的计算给的是"单通道领头多边形"，完整的 Bose 对称相容反常需要额外因子与相容条件补全。
**这是所有下游数值系数的一个共同的、AGW 自己声明的、未在本文闭合的步骤。**
**建议**：建一条 `inferred: true` 的边或一个显式的 gap，不要静默吞掉。

**Q-A7（十四维线性无关）** —— AGW 只写 "These expressions are linearly independent"，**没有给计算**。
抽取者手算 3×3 子式约 `−4.68 × 10¹²`（非零），结论成立，但**是手工大数乘法，未经机器复核**。
**建议**：列为 Lean 目标（§5.3 的 B4），复核后再把该节点从 `physical-argument` 提到 `rigorous`。

**Q-A8（`p′_i` 的定义在 §12 是否仍生效）** —— §11 的结果全用带撇的 `p′_i`（含 `D_aη_b − D_bη_a` 替换），但 **§12 的 (117)–(120) 一律用不带撇的 `p_i`**，且 (115)(116) 重新定义了 `p_i`。
两者在「反常多项式」层面是同一批系数（E12 的交叉核对证明了这一点），但**记号切换没有在原文里说明**。
**建议**：转节点时统一用 (115)(116) 的 `p_i`（无撇），并在 note 里记这次记号切换。

---

## 5. ★ 纯代数命题清单（Phase 2 Lean 岛候选）

本节把 §2 里**不依赖任何物理输入、可完全在 Lean 里陈述与验证**的部分单独列出。
判据同 `green-schwarz-1984.md` §5：只涉及多项式代数与有理数算术，不涉及指标定理、费米子谱、路径积分测度。

**这批命题的特殊价值**：由 E17，它们在历史上是 **CAS 生成的、且发表前出过错的**数值系数，同时又是整条 Green–Schwarz 反常抵消链的数值地基。它们是本项目"可机检的物理结论"的教科书式样本。

### 5.1 ★★★ B1 —— **GS (20) 从 AGW (119) + (83) 的机械导出（首选目标，`green-schwarz-1984.md` Q3 的完整闭合）**

> **命题。** 在 `ℚ[n, T₂, T₄, T₆]` 上定义
> `p₁ := −½T₂`，`p₂ := −¼T₄ + ⅛T₂²`，`p₃ := −⅙T₆ + ⅛T₂T₄ − (1/48)T₂³`  （= AGW (83)）
> `Î_{1/2} := (1/967680)(−31p₁³ + 44p₁p₂ − 16p₃)`
> `Î_{3/2} := (1/967680)(225p₁³ − 1620p₁p₂ + 7920p₃)`  （= AGW (119)）
> 则
> **`Î_{3/2} + (n − 1)·Î_{1/2} = −(1/48) · { −[1/32 + (n−496)/13824]·T₂³ − [1/8 + (n−496)/5760]·T₂T₄ − [(n−496)/7560]·T₆ }`**
> 其中大括号内正是 **GS 1984 eq. (20)**（`T₂ = tr R²`, `T₄ = tr R⁴`, `T₆ = tr R⁶`）。
> 等价说法：**GS (20) = −48 × [一个左手引力微子 + 一个反手自旋 ½ + `n` 个左手自旋 ½ 的 AGW 反常之和]**。

- 来源：AGW (119)(83)（L1）+ GS 1984 (20)（L1，见 `green-schwarz-1984.md` E13）
- 严格性：**两篇原文都没有写出这条等式**；AGW 没做 N=1 的场内容组合，GS 没写从 AGW 到 (20) 的中间步骤。**这条等式是抽取者复算出来的，是两篇文献之间缺失的那一步。**
- 抽取者复算（完整过程，可逐行复核）：
  - 场内容（GS (20) 逐字）："one left-handed spin 3/2 gravitino and one right-handed spin ½ field from the supergravity sector and `n` left-handed spin ½ fields from the matter sector"
    ⇒ 组合 = `Î_{3/2} − Î_{1/2} + n·Î_{1/2} = Î_{3/2} + (n−1)Î_{1/2}`
  - 令 `m := n − 496`。在 `p` 基下：
    - `p₁³` 系数：`225 + (n−1)(−31) = 256 − 31n = −15120 − 31m`
    - `p₁p₂` 系数：`−1620 + (n−1)(44) = 44n − 1664 = 20160 + 44m`
    - `p₃` 系数：`7920 + (n−1)(−16) = 7936 − 16n = −16m`
    ⇒ **`m = 0`（即 `n = 496`）时 `p₃` 系数恰为零** —— 这就是 GS 那句 "496 left-handed spin ½ fields are needed"。✓
  - 代入 (83)（`p₁³ = −⅛T₂³`；`p₁p₂ = −(1/16)T₂³ + ⅛T₂T₄`；`p₃ = −(1/48)T₂³ + ⅛T₂T₄ − ⅙T₆`），除以 967680：
    - `T₂³`：`(630 + 35m/24)/967680 = 1/1536 + m/663552`
    - `T₂T₄`：`(2520 + 7m/2)/967680 = 1/384 + m/276480`
    - `T₆`：`(8m/3)/967680 = m/362880`
  - 与 GS (20) 的五个系数逐一取比：
    | 项 | GS (20) 系数 | AGW 组合系数 | 比值 |
    |---|---|---|---|
    | `T₂³` 常数部 | `−1/32` | `1/1536` | **−48** |
    | `T₂³` 的 `m` 部 | `−1/13824` | `1/663552` | **−48**（`663552/13824 = 48`） |
    | `T₂T₄` 常数部 | `−1/8` | `1/384` | **−48** |
    | `T₂T₄` 的 `m` 部 | `−1/5760` | `1/276480` | **−48**（`276480/5760 = 48`） |
    | `T₆` 的 `m` 部 | `−1/7560` | `1/362880` | **−48**（`362880/7560 = 48`） |
  - **五项全部给同一个比值 −48**，即两式只差一个整体常数。✓✓
- ★ **意义**：
  1. `green-schwarz-1984.md` **Q3 至此完全闭合**：GS (20) 的三个系数（含 `n` 依赖）**全部**可由 AGW (119)+(83) 机械导出，无任何自由参数。
  2. 整体因子 **−48** 就是 AGW (114) 里那个 "factor common to the three cases"，在 GS 的 `Ω_{4n} = Tr F^{2n}` 归一下的取值。
  3. **`n = 496` 不再是"GS 断言的"，而是"`p₃` 系数 `7936 − 16n` 的唯一零点"** —— 一个完全可机检的算术事实。
- Lean 化形态：在 `ℚ` 上取多项式环 `ℚ[n, T₂, T₄, T₆]`，按上面定义展开，`ring` 一行。**难度极低。**
- ⚠ **一个必须写进 note 的限定**：GS 在 Minkowski 号差下用实反对称 `SO(9,1)` 值曲率，AGW 在欧氏化后计算，两者的 `R` 之间可能差 `i` 的幂次。
  **但这只能影响整体常数**（由五项同比 −48 直接证明），而 GS 声称的正是"relative normalization"。**故本命题作为「相对归一化」的验证是完全的；作为「绝对归一化」的验证则不是。**

### 5.2 B2 —— AGW 自己的三条相消关系

> `d = 2`：`Î_{1/2} = Î_A = −(1/24)p₁`，`Î_{3/2} = (23/24)p₁`  （(117)）
> `d = 6`：`21Î_{1/2} − Î_{3/2} + 8Î_A = 0`  （(118)）
> `d = 10`：`−Î_{1/2} + Î_{3/2} + Î_A = 0`  （(119)）

- 来源：AGW (117)(118)(119)（L1）
- 严格性：AGW 直接断言（"the minimal solution is remarkably simple"），**未给验算**
- 抽取者已复算全部三条（见 E15、E16）✓
- Lean 化形态：`ℚ` 上的线性组合，`norm_num` / `decide` 即可。**难度极低。**
- 价值：**`d = 10` 那条是 IIB 超引力反常自由的全部数值内容**，也是本文摘要里"十维唯一"的算术核心。

### 5.3 B3 / B4 —— 其余可机检项

- **B3（`n = 496` 的唯一性）**：`7936 − 16n = 0 ⟺ n = 496`，且 `256 − 31n = 0` 与 `44n − 1664 = 0` 在整数上无解（`n = 256/31`、`n = 1664/44 = 416/11`）。
  ⇒ **仅靠场内容无法让 N=1 SUGRA+SYM 的引力反常整体为零**（这正是 E2 里 AGW 判断的算术依据），**必须**有 GS 的局域抵消项。`omega` / `norm_num` 一行。
  ★ 这一条把 E2 那个「AGW 与 GS 不矛盾」的历史论点变成了可机检的命题，**建议优先做**。
- **B4（十四维线性无关）**：(120) 的三个五元系数向量秩为 3。取 `(p₁⁴, p₁²p₂, p₁p₃)` 子式，`norm_num` 验其非零。
  抽取者手算得 `≈ −4.68 × 10¹²`，**待机器复核**（见 Q-A7）。
- **B5（(99)–(101)/(106) ↔ (117)–(119) 的一致性）**：如 E12 所示，六条有理数等式，`norm_num`。价值中等，但能把 AGW 的两条独立计算路线（图式 §6–§9 与 Fujikawa §11）的一致性变成机检事实。

### 5.4 ★ 外部独立核验：Â 多项式（**已完成**）

AGW (82)/(92)/(119)/(120) 的自旋 ½ 系数就是 Hirzebruch 的 Â-genus。本轮取到一份**独立的数学侧来源**核对：

- 来源 **[Âroof]**：Harvard Math 272b (Spring 2005) 讲义 *The Â class*（`A-roof.nb` 的打印稿，Mathematica notebook，**无署名作者**），
  `https://abel.math.harvard.edu/archive/272b_spring_05/handouts/A-roof/A-roof.pdf`（6 页，**L1，pp.1–3 逐页读图**）。
  其定义与 AGW 完全同一个归一：`Â(X) = ∏ (√y_i/2) / sinh(√y_i/2)`（p.1），单变量级数
  `1 − y/24 + 7y²/5760 − 31y³/967680 + 127y⁴/154828800 − 73y⁵/3503554560 + 1414477y⁶/2678117105664000`（p.2）。

| | AGW | [Âroof]（p.3，逐字） | 一致？ |
|---|---|---|---|
| Â₁ | (82) `−(1/24)p₁` | `Â₁ = −p₁/24` | ✓ |
| Â₂ | (82) `(1/5760)(7p₁² − 4p₂)`；(118) `Î_{1/2}` | `Â₂ = (7p₁² − 4p₂)/5760` | ✓ |
| Â₃ | (82) `(1/(2⁶·15120))(−16p₃+44p₁p₂−31p₁³)`；(92)；(119) `Î_{1/2}` | `Â₃ = (−31p₁³ + 44p₁p₂ − 16p₃)/967680` | ✓（`2⁶·15120 = 967680`） |
| Â₄ | (120) `Î_{1/2} = (1/464486400)[381p₁⁴ − 904p₁²p₂ + 512p₁p₃ + 208p₂² − 192p₄]` | `Â₄ = (381p₁⁴ − 904p₁²p₂ + 208p₂² + 512p₁p₃ − 192p₄)/464486400` | ✓（五个系数与分母全同） |

- ⇒ **AGW 的自旋 ½ 支（也就是 GS (20) 里 `n` 依赖的那部分）已被一个完全独立的、数学侧的来源逐系数确认。**
- ⚠ **等级说明**：[Âroof] 是**匿名课程讲义 + CAS 输出**，权威性低于 Hirzebruch 原书。
  它足以作为「两个独立来源给出同一组数」的旁证，**但不适合作为图节点的 canonical 数学来源**。
  **建议**：若要给「Â-genus 的 Pontryagin 展开」建节点，canonical source 应是 **Hirzebruch, *Topological Methods in Algebraic Geometry*（Â-sequence）**，本轮**未获取该书，标 L0**，列为下一轮候选。
- ⚠ 自旋 3/2 支（`Î_{3/2}`）与自对偶张量支（`Î_A`）**没有**这样现成的数学侧对照（它们分别是 `Â·(tr e^R − 1)` 与 Hirzebruch `L`-genus 的变体），本轮**未做外部核验**。

### 5.5 **不是**纯代数、明确排除的部分

- (32)(38)(55)(56)(63)(65)(110)(112) 本身 —— 依赖 Pauli–Villars 正规化、Fujikawa 测度、"发明的"费曼规则
- 从 (114) 的生成函数**展开出** (117)–(120) —— 原则上可机械化（形式幂级数 + 对称函数），但需要 `x/sinh x` 的形式幂级数与初等对称多项式的 Mathlib 基础设施，**难度远高于 B1–B5**。建议**把 (117)–(120) 当作公理化输入**（引 AGW + [Âroof]），只形式化其**下游的线性代数**。
- §10 全局反常（依赖 Hitchin 的微分几何结果）
- Bose 对称性因子 `1/(n+1)`（E19，AGW 自己未闭合）

---

## 6. 建议的 `sources.bib` 改动

| key | 动作 | 内容 |
|---|---|---|
| `alvarez-gaume-witten-1984` | **新增**（本轮已加） | 见 `sources.bib`。注意 note 里记了页眉印 1983 这件事 |
| `green-schwarz-1984` | **改 note**（本轮已加） | 原判定「GS 把年份误印成 1983」应改为「GS 照抄了 AGW 页眉的 1983；通行引法 1984」 |
| `zumino-wu-zee-1984` | 待新增（**升级为 P0**） | B. Zumino, Y.-S. Wu and A. Zee, Nucl. Phys. **B239** (1984) 477。GS ref [9] = AGW ref [7] 的 "Univ. Washington preprint, 1983"。**下降方程 / CS 符号约定的一手来源；`c` 的另一半依赖**（Q-A1、Q-A3） |
| `eguchi-gilkey-hanson-1980` | 待新增 | T. Eguchi, P.B. Gilkey, A.J. Hanson, Phys. Reports **66** (1980) 213。AGW ref [6]，Â 多项式的来源 |
| `hirzebruch-1966` | 待新增（低优先） | Hirzebruch, *Topological Methods in Algebraic Geometry*。§5.4 建议的 Â-genus canonical 数学来源，**本轮未获取** |
| `treiman-1985-current-algebra` | 待新增（仅当要引重印页码） | S.B. Treiman, R. Jackiw, B. Zumino, E. Witten (eds.), *Current Algebra and Anomalies*, Princeton UP / World Scientific 1985。AGW 重印于 Princeton 版 **pp. 451–514** |

---

## 7. 交接摘要（给 curator）

**闭合了什么：**
- `green-schwarz-1984.md` **Q3 完全闭合**。GS (20) 的全部五个系数 = −48 × [AGW (119) 的 N=1 场内容组合]，机械可验，见 §5.1。
- `green-schwarz-1984.md` **Q6 闭合一半**：**AGW 不是 CS 符号约定的源头**，源头是 Zumino–Wu–Zee。
- `green-schwarz-1984.md` **§3.5 的年份判定需修正**：1983 是 AGW 页眉自己印的，GS 没错。

**仍未闭合：**
- **Q2（`c` 与 GS (22)）只闭合了一半**。AGW 给出生成公式 (63)/(110)/(112) 与 Â 展开 (82)，**但既没有 `c`，也没有十维混合十二形式**（p.328 明确说不做）。剩下那步是 GS 自己做的且未给中间步骤。
  ⇒ **下一个 P0 是 `zumino-wu-zee-1984`**；做完它，`c` 才有可能定出来。

**可直接建节点、状态 `formalization-target` 的**：B1（§5.1，首选）、B2、B3（§5.2–5.3）。
**状态应为 `rigorous` 的**：(83) 的 `p_i ↔ Tr R^{2k}` 换算（纯代数，抽取者已复算）。
**状态应为 `physical-argument` 的**：E4/E5/E13（(32)(38)(63)(110)(112)，依赖 PV 正规化与 Fujikawa 测度）、E12、E15、E16 的系数（CAS 生成，见 E17）。
**状态应更低（`physical-argument` 且不得进入 GS 分支）的**：E6（自对偶张量，AGW 自陈"invent suitable Feynman rules"）。
**不要建的**：
- 任何把 AGW 的「十维唯一」与 GS 的「SO(32)/E₈×E₈」挂在一起的节点（E16 备注）。
- 任何把 AGW 标成 `refuted` 的节点（E2 / Q-A4：AGW 与 GS 的结论范围不同，不是矛盾）。
**必须显式建的 gap**：Bose 对称因子 `1/(n+1)`（E19 / Q-A6），AGW 自己声明未闭合。
