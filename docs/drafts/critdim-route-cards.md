# 草案：ms.critical-dimension-bosonic 四条路线的严格化卡片

> auditor（physics-auditor）起草，2026-09-12，分支 `agent/auditor/critdim-routes`。
> **本文件不是图数据**，不参与 `stringgraph validate`。裁决与理由见 `docs/ROADMAP.md`
> §「auditor 裁决（2026-09-12，critdim-routes）」。lead 确认后派 curator / formalizer 落地。
>
> 规则：陈述卡不可变（根 CLAUDE.md 原则 1），故凡涉及新陈述文本的一律写在这里，不写进 `graph/`。
> 本轮 auditor 已就地落实的只有 notes/gaps/sources 级改动（见分支提交）。

---

## 落地顺序（依赖关系）

```
A（新卡 + 新推导）  ──→  C（brst-v2 新推导，需 reviewer 复算）──→  E（新里程碑）
       │
       └──→  B（三处 bc 边改指）

D（(I) 删两条非承载边）  独立，可先做
F（(V) 单点化）          独立，(F1) 是工具改动、(F2) 是新卡
```

---

## A. 新卡 + 新推导：λ = 2 的 bc 鬼场中心荷（rigorous）

**为什么必须新建窄卡而不是给 `worldsheet.bc-ghost-central-charge` 加一条推导**：
那张卡断言的是**一般 λ** 的公式 `c = −3(2λ−1)² + 1`，而 FGZ 只覆盖 λ = 2。
给它挂一条只覆盖 λ = 2 的 rigorous 推导，工具会把「一般 λ 公式」算成 rigorous —— 状态谎报。
旧卡**保留不换代**：`bc-ghost-bosonization`、`beta-gamma-central-charge`、
`superconformal-ghost-central-charge` 三处确实要一般 λ。

### A1. `graph/statements/worldsheet/bc-ghost-central-charge-lambda-two.yaml`

```yaml
id: worldsheet.bc-ghost-central-charge-lambda-two
kind: proposition
title: λ = 2 的 bc 鬼场系统中心荷 c^g = −26（模式代数形式，不含一般 λ 公式）
statement: |
  设 b_m、c_n (m, n ∈ Z) 满足反对易关系
    {b_m, c_n} = δ_{m+n,0},  {b_m, b_n} = {c_m, c_n} = 0,
  并设 V 是它们的一个**受限模**（每个 v ∈ V 被除有限多个模式外的 b_n、c_n 零化）。
  在 V 上定义权 λ = 2 的 bc 系统的 Virasoro 模式
    L^g_m = Σ_{n∈Z} (m − n) : b_{m+n} c_{−n} :
  （等价写法 L^g_m = Σ_{n∈Z} (n − m) : c_{−n} b_{m+n} :，两者逐项相差一个由反对易造成的符号）。
  则 {L^g_m} 满足 conv.virasoro-standard 归一化下的 Virasoro 关系，中心荷取值
    c^g = −26,
  即 [L^g_m, L^g_n] = (m − n) L^g_{m+n} + (−26/12) m(m² − 1) δ_{m+n,0}。

  【本命题到此为止】本卡**不**断言一般 λ 的公式 c = −3(2λ−1)² + 1
  （那是 worldsheet.bc-ghost-central-charge，其唯一推导走 OPE，physical-argument），
  **不**断言这组模式就是 Polyakov 路径积分的 Faddeev–Popov 鬼场
  （那一步由 worldsheet.faddeev-popov-ghost-action 承载，physical-argument），
  也**不**断言任何关于物质中心荷或 D 的事。
uses_conventions: [conv.virasoro-standard, conv.worldsheet-complex-coords]
sources:
  - ref: fgz-1986
    loc: "Proposition 2.1, p.8444 右栏：(i) `ρ(c) = −26 Id_{Λ^∞_*}`；(ii) `ρ(L_m) = Σ_n (n−m) :c_{−n} b_{m+n}:`"
    note: |
      **L1，全文五页逐页读毕**（literature/extractions/brst-cohomology-sources.md §1.2 与 §1.4 的
      编号表第 11 行）。逐字转录见该抽取记录。本卡的两条内容**分别**对应 (i) 与 (ii)：
      (ii) 是鬼场 Virasoro 模式的显式表达式，(i) 是它的中心荷取值。
      ⚠ **FGZ 是 PNAS 公告体裁，Proposition 2.1 没有印出证明。** 按 lead 2026-09-12
      （small-backlog-8 / small-backlog-10(c)）的统一口径——「逐字核实的编号命题 + 明写输入 +
      gaps 记无印出证明」判 rigorous——本卡的推导取 rigorous，缺口写进 gaps。
      ⚠ FGZ 的 26 与「D = 26」无关：紧接 Prop 2.1 的正文逐字
      「from this point on we will assume that π(c) = 26 Id_V」，即**物质**中心荷 26 在 FGZ 里是假设。
  - ref: polchinski-1998-v1
    loc: "§2.5, eq. (2.5.12), p.51（一般 λ 的鬼场中心荷公式，λ = 2 给 −26；式号经 schrans-2020 目录逐字核实）"
    note: |
      **只作旁证，不承载本推导**：原书那里走的是 OPE，且给的是一般 λ 公式。
      本卡的论证由 fgz-1986 Prop 2.1 承载。
tags: [cft, central-charge, ghosts, bc-system, brst, critical-dimension]
notes: |
  **本卡是 worldsheet.bc-ghost-central-charge 的窄化拆分，不是换代。** 两张卡并存：
    · 一般 λ 公式（旧卡，--via-ope，physical-argument）——bosonization / βγ / 超共形鬼场三处要它；
    · λ = 2 的模式代数形式（本卡，--via-fgz-ghost-representation，rigorous）——
      BRST 与 Weyl 反常两条 D = 26 路线只要它。
  依据 docs/STATUS_LEVELS.md 的「拆卡」原则（「正确做法是拆卡，让 Lean 对应的那一半成为
  formalized 定义卡」）的同型处理。

  **Lean 可行性（给 formalizer 的备注，不属本卡断言）**：图中已有 formalized 的
  worldsheet.virasoro-algebra-v2、worldsheet.fock-space-virasoro-representation 与
  worldsheet.free-boson-central-charge-d（--via-lean）。本卡是它们的 Clifford（费米）对应物，
  中心项同样是一个有限和；若形式化成功，本卡可升 formalized，届时 BRST 路线成为本图
  **唯一**端到端机检的 D = 26 路线。
author: TODO(curator)
created: "2026-09-1X"
```

### A2. `graph/derivations/worldsheet/bc-ghost-central-charge-lambda-two--via-fgz-ghost-representation.yaml`

```yaml
id: worldsheet.bc-ghost-central-charge-lambda-two--via-fgz-ghost-representation
target: worldsheet.bc-ghost-central-charge-lambda-two
kind: proof
status: rigorous
depends_on:
  - id: worldsheet.virasoro-algebra-v2
    note: "提供 conv.virasoro-standard 归一化下中心荷的读法（m(m²−1)/12 的系数）。该卡 formalized。"
  - id: worldsheet.bc-ghost-cft
    inferred: true
    note: |
      ⚠ **只作记号接口，且必须标 inferred**：本推导的论证完全在模式代数里（FGZ 的半无穷形式表示），
      **不**经过 bc 系统的 OPE 定义。挂这条边只是为了让「b、c 是权 (2, −1) 的一阶系统」这句
      在图上有落点。**若 lead 认为这条边会把本推导压回 physical-argument
      （bc-ghost-cft 的 effective 是 physical-argument），则应当直接删掉它**——
      本卡的 statement 已把反对易关系与 L^g_m 的表达式**逐字写出**，不需要从别处取。
      auditor 建议：**删掉这条边**，理由同 2026-09-12「接口边」裁决的后半句
      （只提供语境而不承担论证的边不得存在），并在 sources 里用 loc 定位即可。
sources:
  - ref: fgz-1986
    loc: "Proposition 2.1(i)(ii), p.8444 右栏"
    note: |
      L1，逐字见 literature/extractions/brst-cohomology-sources.md §1.2：
        `(i) ρ(c) = −26 Id_{Λ^∞_*}`，`(ii) ρ(L_m) = Σ_n (n−m) :c_{−n} b_{m+n}:`。
      ρ 是 Virasoro 代数 ℒ 在半无穷形式空间 Λ^∞_* 上的鬼场表示。
summary: |
  论证由来源直接给出，本图只做一步记号对齐（auditor 已复核，见下）：
  (1) FGZ Prop 2.1(ii) 给出鬼场表示里的 Virasoro 模式 ρ(L_m) = Σ_n (n − m) : c_{−n} b_{m+n} :。
  (2) FGZ Prop 2.1(i) 给出该表示上中心元的取值 ρ(c) = −26 Id。
  (3) 记号对齐：: c_{−n} b_{m+n} : = − : b_{m+n} c_{−n} :（反对易），故
      Σ_n (n − m) : c_{−n} b_{m+n} : = Σ_n (m − n) : b_{m+n} c_{−n} :，
      后者正是本图 λ = 2 的 bc 系统 Virasoro 模式的标准写法
      L^g_m = Σ_n (m(λ−1) − n) : b_{m+n} c_{−n} : 在 λ = 2 处的值。
      **这一步由 auditor 于 2026-09-12 逐项复核**（一行符号翻转，无其他内容）。
  (4) 半无穷形式空间 Λ^∞_* 与本卡所说的 bc 受限模是同一个对象的两种写法：
      两者都是由 {b_m, c_n} = δ_{m+n,0} 生成的 Clifford 代数的、带局部截断的模。
      FGZ §2.1 紧接 Prop 2.1 的正文把该复形称为「physics literature 里的 BRST operator」
      并指向 ref. 5 = Kato–Ogawa 1983，即来源本人做了这个对应。
gaps:
  - "**FGZ 是 PNAS 公告体裁，Proposition 2.1 没有印出证明。** 按 lead 2026-09-12（small-backlog-8、small-backlog-10(c)）对该体裁的统一口径判 rigorous（先例：worldsheet.no-ghost-theorem-brst--via-fgz、worldsheet.brst-nilpotent-at-c26--via-fgz）。本项目未逐行复核该中心项的计算。**若 lead 收紧该口径，本推导应随同降级。**"
  - "**Λ^∞_* ↔ bc 受限模 的字典是本图的对应，不是 FGZ 的定理**。FGZ 自己在 §2.1 正文里指认该复形就是物理文献的 BRST 复形（ref. 5 = Kato–Ogawa），但没有编号命题陈述这个字典。auditor 复核的只有 summary (3) 那一步符号翻转。"
  - "本推导**不**覆盖一般 λ 的公式 c = −3(2λ−1)² + 1；那条仍只有 worldsheet.bc-ghost-central-charge--via-ope（physical-argument）。"
  - "本推导**不**断言这组模式就是 Polyakov 路径积分的 FP 鬼场。该识别由 worldsheet.faddeev-popov-ghost-action（physical-argument）承载，且它**在 Weyl 反常路线里仍然是瓶颈**——改边只绕开了中心荷这一步，没有绕开 FP 手续。"
notes: |
  reviewer-verified: TODO（若 lead 要求，请 reviewer 独立复核 summary (3) 的符号翻转与
  「Λ^∞_* 上 Prop 2.1(i) 的 −26 与 conv.virasoro-standard 的 c 是同一个归一化」这一点）。
author: TODO(curator)
created: "2026-09-1X"
```

---

## B. 三处 bc 边改指窄卡（边改动，不新建）

把下面三条 `depends_on` 的 `id` 由 `worldsheet.bc-ghost-central-charge`
改为 `worldsheet.bc-ghost-central-charge-lambda-two`（三处用的都只是 λ = 2 的值 −26）：

| 文件 | 现状 | 备注 |
|---|---|---|
| `graph/derivations/worldsheet/critical-dimension-brst-v2--via-nilpotency.yaml` | `inferred: true` | 改指后 **inferred 维持**（Polchinski §4.3 不在原地论证 c^g；理由不变） |
| `graph/derivations/worldsheet/critical-dimension-weyl-anomaly-v2--via-anomaly-cancellation.yaml` | 非 inferred | 改指后**须改 sources 的 loc**：现挂 §2.5 (2.5.12)（一般 λ，OPE），窄卡的来源是 FGZ Prop 2.1(i) |
| `graph/derivations/worldsheet/critical-dimension-bosonic-v3--via-four-routes.yaml` | 非 inferred | 同上；note 里「c^g = −26 是 (III)(IV) 的公共输入」一句不变 |

⚠ **三处推导的 note 正文里还有多处字面写 `worldsheet.bc-ghost-central-charge`**（记账文字）。
按 graph/CLAUDE.md「换代时陈述正文内嵌 id 的处理」的精神，**边改指、正文字面不动**，
下次实质换代时同步。**但 `--via-four-routes` 与 brst/weyl 两张路线卡的 statement 里
也点名了 `worldsheet.bc-ghost-central-charge`**，同理不动（陈述不可变）。

**不改的地方**：`bc-ghost-bosonization--via-…`、`beta-gamma-central-charge--via-statistics-flip`、
`superconformal-ghost-central-charge--via-first-order-systems`、
`brst-current-primary-iff-total-central-charge-zero--via-ope`、
`bc-ghost-torus-partition-function-v2--via-zero-mode-insertion` —— 这些要一般 λ 或走 OPE 层。

---

## C. 新推导：`worldsheet.critical-dimension-brst-v2--via-mode-computation`（rigorous，**条件性**）

> ⚠ **未经 reviewer 独立复算，不得标 rigorous。** 先以 `status: physical-argument` 建卡、
> 复算通过后再由 lead 批准升级，或干脆等复算完成再建。

```yaml
id: worldsheet.critical-dimension-brst-v2--via-mode-computation
target: worldsheet.critical-dimension-brst-v2
kind: proof
status: rigorous          # 见上：复算前写 physical-argument
depends_on:
  - id: worldsheet.brst-quantization-v2
    note: "提供 Q_B 的模式定义、bc 反对易关系、L^g_n 与受限模条件。该卡 kind: definition，status rigorous。"
  - id: worldsheet.virasoro-algebra-v2
    note: "物质 Virasoro 关系与 conv.virasoro-standard 归一化。该卡 formalized。"
  - id: worldsheet.bc-ghost-central-charge-lambda-two
    note: |
      供给 {Q_B, Q_B} 表达式里那个 26（= −c^g）。**本条改指窄卡后不再标 inferred**：
      窄卡的陈述正是 λ = 2 的模式代数结论，与本推导同处模式代数层，来源是 FGZ Prop 2.1(i)。
      （旧推导 --via-nilpotency 的同名边标 inferred，理由是它挂的是走 OPE 的一般 λ 卡，
      且 Polchinski §4.3 不在原地论证 c^g；那条边与理由保持不动。）
sources:
  - ref: polchinski-1998-v1
    loc: "§4.3, eq. (4.3.5)（Q_B 的模式展开）、(4.3.7)（a^B = a^g = −1）、**(4.3.9)**（`{Q_B, Q_B} = 0` only if `c^m = 26`）、(4.3.10)（j_B j_B 的 OPE，单极点给 when 方向）；最短路线是习题 4.3 的 Jacobi 恒等式"
    note: |
      **本条只提供被计算的表达式与结论的对照，不提供严格证明**：原书那里是教科书式形式模式计算
      （未声明受限模、未论证无穷模式和重排的合法性、未写出 ⟹ 方向所需的线性无关前提），
      且原书 p.133 对一般约束代数逐字写「We have neglected central charge terms; these need to be
      checked by hand」。本推导标 rigorous 的依据**不是**这条来源，而是 docs/STATUS_LEVELS.md 的
      「初等可复核」例外条款（前提完整 + 有限步初等计算 + reviewer 独立复核）。
  - ref: kato-ogawa-1983
    loc: "全文；摘要（L2，逐字见 critical-dimension-brst-v2 的 sources）"
    note: "原始来源，方向 ⟹（逐字 `are required by the nilpotency`）。正文未获取，定理编号未核实，不承载本推导。"
summary: |
  在 worldsheet.brst-quantization-v2 定义的受限模 V 上做有限步计算（每个 v ∈ V 上只有有限多项非零）：
  (1) 用 {b_k, c_n} = δ_{k+n,0} 与物质 Virasoro 关系展开 {Q_B, Q_B}；
  (2) 三次鬼场项与物质项的交叉贡献相消，只剩正比于总中心荷的项
      {Q_B, Q_B} = Σ_{m∈Z} ((c^m − 26)/12)(m³ − m) c_{−m} c_m，其中 26 = −c^g 由依赖边供给；
  (3) ⟸ 方向：c^m = 26 时每一项为零，故 Q_B² = 0（该方向另有独立节点
      worldsheet.brst-nilpotent-at-c26，FGZ Prop 1.2，已 rigorous）；
  (4) ⟹ 方向：诸 c_{−m} c_m 在忠实的 Fock 型受限模上线性无关（陈述里的前提），
      故 Q_B² = 0 迫使每个系数为零，取 m = 2 即得 c^m = 26。
  前提在目标陈述里已完整写出（受限模、线性无关、a^g = −1、λ = 2），
  符合 docs/STATUS_LEVELS.md 的 rigorous 例外条款第一项。
gaps:
  - "**没有任何数学文献印出这条判据。** 已逐一核实并排除：fgz-1986（Prop 1.2 是一般分次李代数的 d²=0，不含 26；26 只在 Prop 2.1(i) 的鬼场一侧）、lian-zuckerman-1991（Prop 1.11(i) 的 d²=0 无条件成立且不含 26；26 只在 Prop 3.3(iii) 且是单向 if）、lian-zuckerman-1989（是 RNS 超弦）。kato-ogawa-1983 正文未获取（ScienceDirect 403）。⇒ **本推导的 rigorous 完全依赖 reviewer 复算**，不依赖任何印出的证明。"
  - "⟸ 与 ⟹ 两个方向的文献可追溯性不对称（⟹ 有 KO 摘要 L2 + IMNU 1986 的 L1 转述；⟸ 只有 Polchinski 的形式计算 + brst-nilpotent-at-c26）。这一不对称与本推导的状态无关（本推导的两个方向都靠复算），但下游引用时须知。"
  - "本推导只定出 c^m = 26，不定 D = 26（须再加 worldsheet.free-boson-central-charge-d，formalized），也不定截距 a。"
  - "无穷模式和的重排合法性由受限模条件保证，这一点在任何来源里都没有被陈述；它是本图（陈述卡）的增补。"
notes: |
  reviewer-verified: **TODO —— 本推导的全部 rigorous 依据。** 请 reviewer 独立重算
  {Q_B, Q_B} 的模式和（尤其是 (m³ − m) 系数与 a^g = −1 被吸收进 L_0 的那一步），
  并在此处按格式留 `reviewer-verified: <agent>, <date>`。缺此记录不得标 rigorous
  （docs/STATUS_LEVELS.md 等级 4 的例外条款）。

  **旧推导 --via-nilpotency 保留不动**（它是 2026-09-10/11 两轮来源核实的不可变记录，
  且 gaps 里登记了「当且仅当为什么不拆成两条推导」的裁决）。工具取最强的一条，
  本推导落地后 worldsheet.critical-dimension-brst-v2 的 effective 变 rigorous。
author: TODO(curator)
created: "2026-09-1X"
```

---

## D. 路线 (I)：删两条非承载边（**只删边，不动任何陈述**）

文件：`graph/derivations/worldsheet/critical-dimension-light-cone-v2--via-lorentz-algebra.yaml`

删去这两条 `depends_on`：

1. `worldsheet.light-cone-normal-ordering-constant` —— **该边自己的 note 已逐字写明它不承载**：
   「本边**不是**目标陈述的前提，删掉它不会削弱 summary 第一段的论证，也不改变目标陈述的内容」。
   它只服务于 summary 第二段（Polchinski 把 ζ 值代入的那种形状）。
2. `worldsheet.open-string-mass-shell` —— 该边的 note 写它用于「把 Δ_n = 0 的解读成谱条件」；
   目标卡 `worldsheet.critical-dimension-light-cone-v2` 的 statement 里**没有任何质量公式**。

同时 summary 第二段（ζ 形状那一段）改为不再作断言，或整段移入 notes；gaps 相应加一条（下）。

**必须同时加的 gaps 条目（auditor 要求，缺它则删边等于把物理藏进定义层）：**

```yaml
  - "**本推导链上不出现正则量子化那一步，这是有意的，但必须点名。** 删去上述两条非承载边后，本推导的唯一依赖是 worldsheet.light-cone-quantization（kind: definition，status rigorous）。那张定义卡把横向振子对易关系 [α^i_m, α^j_n] = m δ^{ij} δ_{m+n,0} 与质量壳 α'm² = N − a **直接写出**，其 notes 逐字说明为何不把它们加进 uses：「那会把纯代数的定义层拉低到 physical-argument」。因此本推导断言的是**被定义的那个光锥代数系统**的性质；「该系统就是 Nambu–Goto 弦的量子化」这一物理识别由 worldsheet.transverse-oscillator-commutators（physical-argument，--via-canonical-quantization）、worldsheet.light-cone-gauge-lagrangian（physical-argument）与 worldsheet.polyakov-nambu-goto-classical-equivalence（physical-argument）承载，**它们不在本推导的链上**。任何把本条读成「关于物理弦的 D = 26」的下游用法，必须另外取得这三张卡。"
```

**效果**（auditor 2026-09-12 本地模拟，已回滚）：
`uv run stringgraph why worldsheet.critical-dimension-bosonic-v3` 里 (I) 一支塌成两行：

```
worldsheet.critical-dimension-light-cone-v2 [physical-argument]  via ...--via-lorentz-algebra
  ↳ own status physical-argument
```

**不改 effective**（仍 physical-argument），只把审计面从 8 个物理节点压到 1 个。

### D-附：`--via-lorentz-algebra` 能否 rigorous

只有一条路：按 STATUS_LEVELS 的「初等可复核」例外条款，由 reviewer 独立复算 [J^{i−}, J^{j−}]。
代价高于 C（三次式、无穷模式重排），收益低（路线 (I) 即使 rigorous 也抬不动里程碑，见 ROADMAP R0），
**auditor 不建议本阶段做**。若日后要做，唯一可核实到公式级的来源是 `bering-2011` (7.1)
（加框、两段带 □ 的证明），但它引入自创正规化参数 κ 并取 κ → 1，且原文措辞是
「precisely vanishes for」而非 iff —— 引用纪律见 `literature/sources.bib` 的 `bering-2011` note。

---

## E. 新里程碑草案：`ms.critical-dimension-brst-nilpotency`

> 前置条件：A、B、C 全部落地且 `worldsheet.critical-dimension-brst-v2` 的 effective 变 rigorous。

```yaml
id: ms.critical-dimension-brst-nilpotency
statement_id: worldsheet.critical-dimension-brst-v2
canonical_text: |
  【本里程碑断言什么】
  设 Q_B 是权 λ = 2 的 bc 鬼场系统、鬼场正规序常数 a^g = −1、物质中心荷 c^m 的 BRST 荷，
  作用在受限模 V 上（每个向量被除有限多个模式外的 L^m_n、b_n、c_n 零化），
  且诸 c_{−m} c_m 在 V 上线性无关（忠实的 Fock 型受限模满足）。则
    Q_B² = (1/2) Σ_{m∈Z} ((c^m − 26)/12)(m³ − m) c_{−m} c_m,
  故 Q_B² = 0 ⟺ c^m = 26 ⟺ c^m + c^g = 0。

  【本里程碑不断言什么】
  (1) **不**断言 D = 26。由 c^m = 26 到 D = 26 需要一步 c^m = D
      （worldsheet.free-boson-central-charge-d，**effective = formalized**），
      该步只在物质部门取 D 个平坦自由玻色子时成立；紧化背景与非几何背景是 c^m = 26 而 D ≠ 26 的解。
  (2) **不**断言截距 a = 1。本路线完全不涉及 a。
  (3) **不**断言 BRST 上同调与旧协变物理态空间的同构
      （那是 worldsheet.brst-cohomology-equals-ocq-physical，已 rigorous，本里程碑不使用）。
  (4) **不**断言这组鬼场模式就是 Polyakov 路径积分的 FP 鬼场。

  【严格性的确切位置】
  · c^g = −26：fgz-1986 Proposition 2.1(i)（L1 逐字，PNAS 公告体裁，无印出证明）；
  · Virasoro 关系与归一化：worldsheet.virasoro-algebra-v2（formalized）；
  · {Q_B, Q_B} 的模式恒等式：无任何文献印出证明，靠 reviewer 独立复算
    （docs/STATUS_LEVELS.md 等级 4 的例外条款）；
  · ⟸ 半边另有独立的 rigorous 节点 worldsheet.brst-nilpotent-at-c26（fgz-1986 Prop 1.2）。
canonical_source:
  - ref: polchinski-1998-v1
    loc: "§4.3, eq. (4.3.9), p.131–132（**全书唯一逐字写出 `c^m = 26` 而非 D = 26 的位置**）"
  - ref: kato-ogawa-1983
    loc: "全文；摘要（L2）。正文未获取，定理编号未核实"
  - ref: fgz-1986
    loc: "Proposition 2.1(i), p.8444"
audit:
  status: draft
phase: 1
```

**为什么值得单立一张里程碑**：船长手上会同时有
「四条路线的合取」（physical-argument，审计面 = 四个点名的物理节点）与
「BRST 判据」（rigorous，且是本图唯一有望端到端机检的 D = 26 路线）。
两张都诚实，且第二张不需要任何物理公理。

---

## F. 路线 (V)：把物理压到一个点（**不改 effective**）

### F1（工具，一行）

`tools/stringgraph/propagate.py:125` 的 `if best is None or e.level > best.level`
在**同档位**时先到先得（= 按 derivation id 的字母序）。
于是 `worldsheet.open-string-intercept-v2` 的 `why` 走
`--via-light-cone-representation`（依赖 open-string-mass-shell → 整条 ζ 链），
而不是 `--via-null-state-decoupling`（三条依赖 **全部 formalized**：
old-covariant-physical-states、virasoro-algebra-v2、open-string-l0-equals-level-plus-mass）。
建议：同档位时改取「压低依赖更少 / 依赖档位更高」的那条。
这是**显示**问题不是状态问题，但它直接决定船长看到的审计面大小。
⚠ 属 `tools/` 改动，与图数据分开提交（根 CLAUDE.md）。

### F2（新卡，可选）

```yaml
id: worldsheet.level-one-spurious-physical-iff-intercept-one
kind: proposition
title: 第一级伪态同时满足物理态条件当且仅当 a = 1（纯 Fock 代数，无一致性假设）
statement: |
  在开弦 Fock 模上，取 k ≠ 0 与 α' k² = 0，考虑第一级伪态
    |s⟩ = L_{−1} |0; k⟩ ∝ (2α')^{1/2} k·α_{−1} |0; k⟩。
  则下列两条等价：
    (a) |s⟩ 满足旧协变物理态条件 (L_0 − a)|s⟩ = 0 与 L_n |s⟩ = 0 (n > 0)；
    (b) a = 1。
  【不断言】本卡**不**断言「一致性要求 (a) 成立」，也**不**断言 a = 1 是物理的取值；
  那一步是 worldsheet.open-string-intercept-v2 的内容，其两条推导都是 physical-argument。
  本卡只断言上面这条 Fock 模上的代数等价。
```

推导 `--via-l0-level-form`：`kind: proof`，依赖
`worldsheet.old-covariant-physical-states`（formalized）、
`worldsheet.virasoro-algebra-v2`（formalized）、
`worldsheet.open-string-l0-equals-level-plus-mass`（formalized）；
预计 **rigorous**，且 Lean 侧已有 `Fock.sub_intercept_apply_of_mem_levelSubmodule`
（见 `open-string-intercept-v2--via-null-state-decoupling` 那条边的 note），有望直接 **formalized**。

落地后 `worldsheet.open-string-intercept-v2--via-null-state-decoupling` 改挂本卡，
(V) 剩下的物理内容只剩一句「一致性要求伪态解耦」，落在 `open-string-intercept-v2` 自身。

---

## 不做的事（auditor 明确不建议）

| 提议 | 为什么不做 |
|---|---|
| 给 `worldsheet.bc-ghost-central-charge`（一般 λ）加 FGZ 推导 | FGZ 只覆盖 λ = 2；会让一般 λ 公式被算成 rigorous（状态谎报） |
| 把 `worldsheet.zeta-regularized-sum-of-integers` 改成 convention | 该卡 notes 已逐条论证过为何不能（convention 永不降级 ⇒ ζ 路线会显示为完全严格）。原书 p.73 逐字自陈那是 "a useful mnemonic"，支持维持 physical-argument |
| 给 `light-cone-normal-ordering-constant` 加「诚实路线」推导（Polchinski p.73 的三条） | 三条里能落到本图的是 Virasoro 代数路线与态-算子路线，两者在本图都要经 `cylinder-plane-l0-shift`（Schwarzian → OPE，physical）或 OPE 层。**换不出严格性**，只是把一个物理节点换成另一个 |
| 为 (IV) Weyl 路线找严格化路径 | 它就是路径积分测度的 Weyl 变分 + FP 手续 + 「有反常 ⇒ 理论不一致」。本图没有被构造的测度对象，不是「还没做」而是「没有对象」 |
| 为提升里程碑 effective 而换代 v4、删掉合取里的弱项 | 会把「四条路线各自成立」这个真实内容换成一个更窄的命题来换状态数字。要那个更窄的命题，正确做法是另立里程碑（E），不是换代 v3 |
