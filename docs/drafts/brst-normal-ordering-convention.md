# 草案：鬼场正规序约定卡（`conv.ghost-normal-ordering-*`）

**起草**：physics-auditor，2026-09-12，分支 `agent/auditor/brst-milestone-r1`
**交给**：curator（建卡）/ lead（裁决 family 与 canonical 归属）
**触发**：`ms.critical-dimension-brst-nilpotency` 第一轮回译审计 R1-3（verdict drift）；
reviewer 复算 `docs/reviews/brst-nilpotency-recompute-2026-09-12.md` 的 F2。
**状态**：草案。本文件**不是**图数据，`stringgraph validate` 不读它。建卡由 curator 执行。

---

## 1. 问题（一句话）

图中两张卡把 λ = 2 鬼场的 Virasoro 模式写成**同一个字符串**，但为使各自的断言为真，
两张卡的 `: :` 必须取**互斥**的两套正规序；两张卡都没有定义 `: :`。

| 卡 | 写的 `L^g` | 它断言的东西 | 强制的 `: :` |
|---|---|---|---|
| `worldsheet.brst-quantization-v2` | `L^g_n = Σ_m (2n − m) : b_m c_{n−m} :` | `L_n = L^m_n + L^g_n + a^g δ_{n,0}` 在 (m³−m) 形式下中心荷 = `c^m + c^g` | **能级序（L 序）** |
| `worldsheet.bc-ghost-central-charge-lambda-two` | `L^g_m = Σ_n (m − n) : b_{m+n} c_{−n} :` | `[L^g_m, L^g_n] = (m−n)L^g_{m+n} + (−26/12) m(m²−1) δ`（纯 (m³−m)，无 m 线性项） | **SL(2,C) 序（S 序）** |

两式换指标（前者取 `m = n + j`）后**逐字相同**。

**两套序的定义**（沿用复算文档 §2 的记号）：

- **S 序（SL(2,C) 序）**：湮灭算符 = `b_n (n ≥ −1)`、`c_n (n ≥ 2)`，即零化 SL(2,C) 不变真空
  `|0⟩` 的那些模式（`b(z)|0⟩`、`c(z)|0⟩` 在 z → 0 正则的条件，与权 (2, −1) 相容）。
- **L 序（能级序）**：湮灭算符 = `b_n (n ≥ 0)`、`c_n (n ≥ 1)`，即零化鬼场基态
  `|↓⟩ = c_1|0⟩` 的那些模式（`|↓⟩` 是被全部正模零化的那个态）。

**差别**：`L^g_0` 相差 1——`L^{g,S}_0 |↓⟩ = −|↓⟩` 而 `L^{g,L}_0 |↓⟩ = 0`，即 `L^{g,L}_n = L^{g,S}_n + δ_{n,0}`。
`m ≠ 0` 的模一致。

**后果（m 线性项差 2m）**：一般地，若 `L′_n = L_n + α δ_{n,0}`，则

    [L′_m, L′_{−m}] = [L_m, L_{−m}] = 2m L_0 + C(m) = 2m L′_0 + C(m) − 2mα ,

即把 `L_0` 平移 α 会给中心项添一个 m 线性项 `−2mα`。取 α = 1（S → L）得：L 序下 bc 系统的
中心项是 `(−26/12)(m³ − m) − 2m`，**不是**纯 (m³ − m) 形式。
⇒ 逐字拼接上表两卡的公式会把 m 线性项算错 `2m`。
（auditor 独立推导，与复算文档 F2 一致。）

**与 `a^g` 的耦合（这一条是本草案存在的真正理由）**：复算文档 §4 证明

    Q_B = A + B_S + (1 + a^g) c_0 ,   其中 B_S − B_L = −c_0 ,

即 **`a^g` 与正规序规定是成对的**：L 序配 `a^g = −1`、S 序配 `a^g = 0`，两种写法给出**同一个**算子 `Q_B`。
所以「`a^g = −1`」不是一条可与序分离的独立约定；只写 `a^g = −1` 而不写序，等于只写了一半。
`worldsheet.critical-dimension-brst-v2` 正文那句「(m³ − m) 的形式来自把 a^g = −1 吸收进 L_0」
是目前图里唯一能把序反推出来的线索，但它太隐晦，且已经在下游丢失
（`ms.critical-dimension-brst-nilpotency` 的 canonical_text 把它删了 ⇒ R1-3）。

**当前没有可用的 family**：`graph/conventions/` 的 22 张卡里，唯一名字相关的是
`conv.intercept-sign-a`（family `normal-ordering-constant`），但那是**截距记号的符号约定**（a 对 A），
不是算符排序约定，不能复用。

---

## 2. 方案 A（推荐）：新 family `ghost-normal-ordering`，两张卡，S 序为 canonical

理由：S 序是共形/数学侧的标准（FGZ 的半无穷楔形正规序、Polchinski §2.7 的共形正规序都在这一侧），
它使 bc 的 Virasoro 关系取 `conv.virasoro-standard` 的纯 (m³ − m) 形式，因而与图里已有的
`conv.virasoro-standard` 相容；L 序则必须额外声明，正好强迫任何用 `a^g = −1` 的卡把序写出来。

```yaml
# graph/conventions/ghost-normal-ordering-sl2.yaml
id: conv.ghost-normal-ordering-sl2
family: ghost-normal-ordering
title: bc 鬼场正规序：SL(2,C) 序（相对 SL(2,C) 不变真空）
definition: |
  权 (λ, 1−λ) = (2, −1) 的 bc 系统，模式 b_n、c_n（{b_m, c_n} = δ_{m+n,0}）。
  `: X Y :` 表示把**湮灭算符**移到右边并按费米置换奇偶配符号，其中湮灭算符规定为
    b_n (n ≥ −1),  c_n (n ≥ 2),
  即零化 SL(2,C) 不变真空 |0⟩ 的那些模式（等价地：使 b(z)|0⟩、c(z)|0⟩ 在 z → 0 正则）。
  在本约定下
    L^g_m = Σ_n (m − n) : b_{m+n} c_{−n} :
  满足 conv.virasoro-standard 的纯 (m³ − m) 形式，中心荷 c^g = −26，无 m 线性项；
  且 L^g_0 |↓⟩ = −|↓⟩，其中 |↓⟩ = c_1|0⟩。
canonical: true
sources:
  - ref: fgz-1986
    loc: "Proposition 2.1(ii), p.8444 右栏：ρ(L_m) = Σ_n (n−m) :c_{−n} b_{m+n}:（半无穷楔形正规序）"
  - ref: polchinski-1998-v1
    loc: "§2.7（共形正规序与产生–湮灭正规序的区分）；§2.5 eq. (2.5.12), p.51（λ 一般的鬼场中心荷）"
```

```yaml
# graph/conventions/ghost-normal-ordering-level.yaml
id: conv.ghost-normal-ordering-level
family: ghost-normal-ordering
title: bc 鬼场正规序：能级序（相对鬼场基态 |↓⟩）
definition: |
  同上的 bc 系统。`: X Y :` 的湮灭算符规定为
    b_n (n ≥ 0),  c_n (n ≥ 1),
  即零化鬼场基态 |↓⟩ = c_1|0⟩ 的那些模式（|↓⟩ 是被全部正模零化的态）。
  与 conv.ghost-normal-ordering-sl2 的关系：L^{g,level}_n = L^{g,SL2}_n + δ_{n,0}，
  故 L^{g,level}_0 |↓⟩ = 0，而 [L^{g,level}_m, L^{g,level}_{−m}] 的中心项是
    (−26/12)(m³ − m) − 2m，**不是**纯 (m³ − m) 形式。
  ⚠ 采用本约定的卡，若要把总 Virasoro 写成无中心/(m³−m) 形式，必须显式加回 a^g δ_{n,0}，
  且 a^g = −1 与本约定**成对**（在 conv.ghost-normal-ordering-sl2 下对应 a^g = 0，
  两种写法给出同一个 Q_B；见 docs/reviews/brst-nilpotency-recompute-2026-09-12.md §4）。
canonical: false
sources:
  - ref: polchinski-1998-v1
    loc: "§4.3, eq. (4.3.7)（Q_B 模式展开末项 a^B(c_0 + c̃_0)）、(4.3.8)（{Q_B, b_0} = L^m_0 + L^g_0，原书据此定 a^B = a^g = −1）"
```

### 方案 A 的代价（必须让 lead 知道）

`worldsheet.brst-quantization-v2` 用的是 **L 序**（非 canonical）。这与 auditor 角色守则
「里程碑陈述必须只用 `canonical: true` 的约定」冲突：`ms.critical-dimension-brst-nilpotency`
的陈述经 brst-quantization-v2 使用 L 序。两条出路，**请 lead 裁决**：

1. **改 canonical 归属**：把 L 序定为 canonical（因为图里 BRST 一侧都用它），S 序为非 canonical。
   代价：与 `conv.virasoro-standard` 的纯 (m³ − m) 形式不再自动相容，
   `bc-ghost-central-charge-lambda-two`（FGZ 来源、拟形式化目标）要改声明非 canonical 约定。
2. **保持 S 序为 canonical，并把里程碑陈述改写到 S 序**：即 `a^g = 0`、Q_B 不带 c_0 项
   （复算文档 §4 的 `Q_B = A + B_S`）。这是**同一个** Q_B 的另一种写法，命题不变，但
   要换代 `brst-quantization-v2` v3 与 `critical-dimension-brst-v2` v3，改动面大。
3. **判定「里程碑只用 canonical 约定」这条守则在此不适用**：因为这里两张卡描述的是同一个算子，
   序的选择只是书写方式，不是物理内容的分叉（与度规号差那种真分叉不同）。若 lead 采此路，
   建议在约定卡 notes 里逐字记下该裁决。

auditor 的意见：**先走 (1)**（L 序为 canonical）。理由是图里需要 `a^g = −1` 的卡更多
（`brst-quantization-v2`、`bc-ghost-normal-ordering-constant`、`critical-dimension-brst-v2`
及其两条推导、`brst-charge-on-ghost-ground-state`），而只有 `bc-ghost-central-charge-lambda-two`
一张卡在 S 序一侧，改动面最小；且 (1) 不要求任何陈述换代，只要求两张卡在下次换代时
各自加一行 `uses_conventions`。

---

## 3. 方案 B（更省事，但更弱）：不建 conv. 卡，只在陈述卡换代时写死 `: :`

即在 `brst-quantization-v2` v3 与 `bc-ghost-central-charge-lambda-two` v2 的 statement 正文里
各加一句规定，不引入新 family。

- **优点**：不触碰「每个 family 恰好一个 canonical」的机制，不需要 lead 裁决 canonical 归属；
  符合 reviewer F2 给的第一个建议（「定义卡换代（v3）时把 `: :` 的规定写进 statement」）。
- **缺点**：`: :` 是**跨卡复用**的记号（`graph/statements/worldsheet/` 里粗略 grep `: b_` / `:b_`
  命中 9 张卡：`bc-ghost-central-charge-lambda-two`、`bc-ghost-hermitian-conjugation`、
  `brst-anticommutator-b-mode`、`brst-cohomology-equals-ocq-physical`、`brst-cohomology-low-levels`、
  `brst-preserves-relative-complex`、`brst-quantization-v2`、`brst-quantization`（已换代）、
  `no-ghost-theorem-brst`；**本轮只逐字核过前两张与 brst-quantization-v2，其余未核**，
  curator 落地时须逐张确认各自需要哪套序），逐卡重写会再次分叉；
  且约定不进 `uses_conventions`，`validate` 的约定一致性检查看不见它——正是本次事故的成因。
- auditor 的意见：B 可作为 A 落地前的**止血**，但不应作为终局。

---

## 4. 落地清单（无论走 A 还是 B）

1. 新建约定卡（方案 A）或在换代时写死正文（方案 B）。
2. `worldsheet.brst-quantization-v2` → v3：`: :` 写明 / 加 `uses_conventions`；
   同时把 statement 里「Q_B^2 = 0 的条件见 worldsheet.critical-dimension-brst」的指针
   按 graph/CLAUDE.md 的换代规则更新到 `-v2`（那是本次换代的顺带项，不单独换代）。
3. `worldsheet.bc-ghost-central-charge-lambda-two` → v2：`: :` 写明；
   **同时修「受限模」的括号 gloss**（见该卡 auditor 注记 (B)：现文「被除有限多个模式外的
   b_n、c_n 零化」按字面只被平凡模满足，应改成单边的「存在 N(v) 使 n > N 的模式零化」）。
4. `worldsheet.critical-dimension-brst-v2` → v3（可与上面同批）：把线性无关从「断言」改成「前提」，
   并把序写明（见该卡 auditor 注记）。
5. `ms.critical-dimension-brst-nilpotency` 的 canonical_text 按第一轮 diff_notes 的
   R1-1 / R1-2 / R1-3 / R1-4 修订，然后请 auditor 跑第二轮回译。
6. 形式化提醒：`bc-ghost-central-charge-lambda-two` 是候选 Lean 目标，
   `: :` 不定死则 Lean 声明读不成卡面陈述——这一条在该卡 notes 已记。

## 5. 已核对、不必重复的事实

- 两卡的 `L^g` 公式换指标后逐字相同（auditor 本轮核）。
- c^g 的**取值** −26 与序无关（序只改 m 线性项，不改 (m³ − m) 的系数），
  故经依赖边搬运 −26 到 BRST 幂零推导是正确的；`--via-mode-computation` 的复算未逐字拼接两卡公式，
  其 −26 是自算的（复算文档 §6.4 的有限窗求和），**不受本问题影响**。
- 因此 `worldsheet.critical-dimension-brst-v2` 的 **effective: rigorous 不受本问题影响**，
  本草案不主张任何降级。这是陈述**欠定**的问题，不是论证错误的问题。
