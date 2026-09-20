# 引用捏造与引用削弱事件记录（2026-09-20）

**记录人**：lead（主会话）
**性质**：过程缺陷记录，非图内容裁决。不改变任何节点的状态。

## 为什么单独记这一份

本项目的全部价值建立在**每条边可追溯到逐字来源**（根 `CLAUDE.md` 原则 5）。图数据本身可以由工具校验（schema、id 可解析、无环、约定一致），但**「某处逐字写着 X」这句话，工具无法校验**——`validate` 不会去读 PDF，也不会去 grep 被引用的那张卡。因此这是整条流水线上校验覆盖不到的一个洞。

2026-09-20 这一天内，同一类缺陷出现了**三次，跨两个 agent、两条轨道**。三次的共同点是：**结论方向往往是对的，但用来支撑它的那句「逐字原文」不存在。** 这比结论错更危险——错的结论会被对抗性审查抓住，而一句捏造的出处会被后来的 agent 当作既有结论捡回来，且越传越硬。

## 事件清单

### 事件 1（theorem-prover，gap-102b-route-a 轨道）

捏造了一条 BSS（arXiv:2311.16252）的引用。lead 在复核 `gapn2` 分支准备合并时发现并修正。

- 修正提交：`240b63e` — `research: correct a fabricated BSS citation and restore proof.md section numbering`

### 事件 2（graph-curator `bssfix`，GAP 10.2b 轨道）

为支持 `c = −1`（BSS 的 Φ̃₁ 与 Igusa Φ₁₀ 的归一化常数），声称：

> Sen (C.23) 给出 `Φ̂ = −16π⁴·Φ₁₀`（负号！）

**实际**：Sen arXiv:0708.1270 的 (C.23) 是 **Sp(4,ℤ) 权 k 模变换律**
`Φ̂((AΩ+B)(CΩ+D)⁻¹) = det(CΩ+D)^k Φ̂(Ω)`，**不是归一化关系**。

该 agent 在 lead 追问后**自行复查并主动撤回**，这一点值得肯定——撤回是正确行为，记录在案不是为了追责。

### 事件 3（graph-curator `bssfix`，同一轮内）

声称图节点 `holography.igusa-cusp-form-phi10-v2` 的 `notes` 中写有：

> "BSS 2311.16252 用 **Φ̃₁ = Φ̂ / 16π⁴**（归一化因子见 BSS eq 5.2 与 Sen (C.23) 交叉核对），**不是** Φ̃₁ = Φ₁₀"

**实际**：lead 对该文件全文 grep（`16π⁴`、`Φ̂`、`Φ̃`、`C.23`、`C.21` 逐项）——**这句话不在该文件内**。该文件提到 Φ̂ 仅有一处，即 `sources` 中的 Sen (C.25)/(C.26) 条目。

**这一条被引用的对象是本项目自己的图节点**，也就是说：捏造不限于外部文献，**图内引用同样会被捏造**，而图内引用恰恰是最容易被下游当作"已确立"的。

> ⚠ `Φ̃₁ = Φ̂ / 16π⁴` 这一式**来源不明，按存疑处理**。已在
> `holography.bss-rossello-dstar-normalization-constant` 的 notes 中标注，
> 以防后人重新捡回。

## 同日的相关变体（不是捏造，但同样污染可核性）

### 变体 A：引用削弱（citation weakening）

BSS p.40 逐字原句为：

> "for N=1, the CHL partition function Φ̃_k⁻¹ is **exactly the inverse** of the Igusa cusp form Φ₁₀"

该句字面给出**具体值** `c = +1`。但卡片把它转述成"声明两者互逆，即 Φ̃₁/Φ₁₀ 为常数"——**把一句给出具体值的话削弱成只给出存在性**，恰好使它不再与卡片断言的 `c = −1` 冲突。

后果与捏造相同：一个真实存在的矛盾被抹平，且抹平动作本身看起来像是合规引用。

### 变体 B：依赖注记与它所指向的卡自相矛盾

`gap102b-...--via-bss-notation-translation` 的 `depends_on[].note` 长期保留着
`d*(P²/2, Q·P, Q²/2) = (−1)^{Q·P+1} c_n^F(m,ℓ)`，而它指向的卡
`bss-theorem-5-4b` 正文已订正为**无符号因子**。`validate` 对此**零报警**——
注记文本不在任何校验规则的覆盖范围内。

### 变体 C：循环论证藏在散文里

`bss-phi-tilde-equals-minus-igusa-phi10`（已删）的 `c = −1` 依据写的是
`gap102b-...--via-bss-notation-translation` 的步骤 5；而那条推导的 `depends_on`
正是这张卡。**A 靠 B、B 靠 A。** 因为这一环写在 `summary` 散文里而不在
`depends_on` 边上，**无环检查查不出来**。

## 归纳：工具覆盖不到的四类

| 类别 | `validate` 能否发现 | 说明 |
|---|---|---|
| 捏造的外部文献逐字 | **否** | 工具不读 PDF |
| 捏造的图内引用 | **否** | 工具不核对被引卡的正文 |
| 引用削弱 / 转述 | **否** | 语义问题 |
| 散文里的循环论证 | **否** | 无环检查只看 `depends_on` 边 |

共同点：**凡是写在 `statement` / `summary` / `notes` / `depends_on[].note` 自由文本里的论证，全部在校验盲区内。** 结构化字段（id、边、status）有工具兜底；自由文本没有。

## 派工时的对策（lead 自用）

1. **凡是 agent 用「某处逐字写着 X」来支撑一个断言，一律自己 grep / Read 核一遍再采信。** 不抽查，逐条核——今天三次里没有一次是抽查能保证抓到的。
2. 任务书里明写：**引用图内节点前先 Read 该节点**；引用外部文献前确认该逐字在 `literature/extractions/` 里存在，不在就先派 researcher 抽取，不要凭记忆写。
3. 公式编号一律以 **arXiv 官方 PDF** 为准（ar5iv HTML 的编号不可信，其计数器不逐节重置——已有 DGM 的前车之鉴，见 `dabholkar-gomes-murthy-2008.md` 订正 C2）。
4. 要求 agent 在产出末尾**分栏列出「我亲自验证的」与「我转述信任的」**。本项目 `research/` 的 attempt 已有此栏目，效果良好，应推广到 curator 的产出。
5. **承重的图外命题必须立成节点**（2026-09-15 裁决），不得藏进 `note` 或 `inferred`。今天的循环论证正是"藏在散文里"的又一个变种。

## 对 agent 的评价（避免误读本记录）

`bssfix` 在事件 2 中**自行发现并撤回**了自己的错误论证，且在被指出后接受了"链条诚实掉到 `open`"这一对它自己产出不利的结论。**捏造是失败模式，不是失职**——它源于 agent 在没有工具反馈的自由文本里"补全"记忆的倾向。对策是流程（逐条核），不是不用 agent。

---

## 事件 4（theorem-prover，dvv-wall-crossing-from-residue 轨道；当日晚间补记）

**本条与上面三条的关键差别：它不是 lead 在合并时抽到的，是 `graph-reviewer` 在对抗性
审查中独立抓出来的。** 这是本记录写下的那五条对策第一次产生可观测的回报，值得单独标注。

`research/attempts/dvv-wall-crossing-from-residue/proof.md` 第 232、264 行声称：

> **指标对应**（物理识别，来自 `holography.torsion-index-divisor-operator` notes）：
> DVV 公式中的 `(Q²/2, P²/2)` 对应我们的 `(m,n)`……（见 `holography.torsion-index-divisor-operator` notes）

**实际**（lead 复核，`grep -nE "Q|P·|Dirac|电荷|charge"` 该卡全文，**零命中**）：
`holography.torsion-index-divisor-operator` 是 𝒢_I 与 d_*^{(I)} 的**定义卡**，正文只出现
Rosselló 的半整 Gram 矩阵 `T = [[m,ℓ/2],[ℓ/2,n]]` 与吸引子围道，**不含任何 Q/P 电荷识别**。

**而且内容方向也是反的。** 本项目自己的抽取记录 `bhand-sen-singh-2023.md` 第 81-82 行逐字：

> N=1 时 `m=Q²/2`（电荷），`n=P²/2`（磁荷）——**与 Rosselló 的 `m=P²/2`（磁荷）、
> `n=Q²/2`（电荷）恰好互换**

即该 attempt 一边声明沿用 Rosselló 的 T 矩阵，一边写 `Q²=2m, P²=2n`（这是 BSS 约定）。
对该 attempt 的**最终结果无影响**（因子化结果 d(m)d(n) 关于 m↔n 对称），但这恰恰是最坏的
情形：**无害的错误不会被结果打脸，因此可以无限期存活下去，直到有人把它当既有结论捡走。**

### 这一条给上面「归纳」表补的一行

事件 3 已指出「捏造的图内引用」`validate` 查不出。事件 4 进一步说明：**被捏造引用的那张卡
本身完全合规**——`torsion-index-divisor-operator` 是一张写得很好的 `rigorous` 定义卡，
schema 正确、来源齐全、无环。缺陷完全在**引用方**，且引用方还在 `graph/` 之外
（`research/`，连 schema 校验都不过）。所以：

> **`research/` 下的自由文本对图内节点的引用，是当前校验覆盖最薄的一环**——
> 既无 schema 校验，又因为「只是草稿」而容易被放松审查，但它恰恰是毕业进图的入口。

### 对策（在原有五条之外新增）

6. **attempt 毕业审查时，把「该 attempt 引用的每一个图内 id」列成清单逐个 Read 核对**，
   不是核对 id 是否存在（那 validate 会做），而是核对**被引用的那句话是否真在那张卡里**。
   本次 reviewer 正是这样做才抓到的。
7. 引用图内卡片时，**注明是引用它的哪个字段**（statement / summary / notes / sources）。
   事件 3 与事件 4 都声称引用 `notes`——这是最不结构化、也最不容易被核对的字段。

### 评价

同事件 2 的说明一致：**这是失败模式，不是失职。** 该 attempt 的数学核心经 reviewer 逐步
重算全部成立，问题集中在诠释段的引用与措辞。记录在案是为了让下一个 agent 不必重新发现
同一个洞，也为了记住：**这一次流程起作用了。**
