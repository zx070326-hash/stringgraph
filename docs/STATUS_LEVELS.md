# 认识论状态等级

每个陈述节点有一个 `status` 字段，表示**该节点自身论证**的严格程度。工具据此计算 `effective_status`。

## 等级（从高到低）

| 等级 | 值 | 含义 | 判据 |
|---|---|---|---|
| 5 | `formalized` | Lean 已验证 | `formal.lean_decl` 指向的声明在 `formal/` 中无 sorry 编译通过 |
| 4 | `rigorous` | 严格数学证明，未形式化 | 有发表的、数学界接受的完整证明；来源必须是数学文献或数学物理文献。**例外（lead 裁决 2026-09-10）**：陈述的前提已完整写出、证明是有限步初等计算（线性代数、变量替换、有限维变分）且 reviewer 已独立复核的，可标 rigorous，但推导节点必须在 `notes` 写 `reviewer-verified: <agent>, <date>`；缺此记录或前提不完整（如未限定微分同胚保定向、边界映到边界）的一律 physical-argument |
| 3 | `physical-argument` | 物理学家式论证 | 路径积分操作、非严格渐近、形式操作、"标准推导" |
| 2 | `conjecture` | 猜想 | 有非平凡检验但无证明；对偶默认在此 |
| 1 | `speculation` | 猜测 | 无系统检验 |
| 0 | `refuted` | 已反驳 | 存在被接受的反例 |

不参与传播的类型：
- `definition`：定义，不需要论证。自身 `status` 表示该定义卡本身的地位（`formalized` = 有 Lean 声明逐句对应；`rigorous` = 数学上精确但未形式化；`physical-argument` = 依赖路径积分等未定义对象），有效状态 = min(自身 status, 依赖的最低等级)。一张 `rigorous` 的定义卡会把依赖它的 `formalized` 命题压到 `rigorous`——这是有意的：Lean 证明用的对象若与卡片定义不逐句一致（如缺质量壳条件），命题就不该显示为 formalized；正确做法是拆卡，让 Lean 对应的那一半成为 formalized 定义卡。
- `convention`：约定（号差、归一化）。永远不降级任何东西。
- `axiom`：本项目明确接受为出发点的假设（如"存在自洽的二维 CFT"）。有效状态记为 `assumed`，并在报告中单列。

## 有效状态

```
effective(n) = min( status(n), min over d in deps(n) of effective(d) )
```

其中 `convention` 节点不计入 min，`axiom` 节点使有效状态带上 `assumes: [...]` 集合。

一个节点若有多条推导（derivations），取**最强的那条推导**的有效状态。这允许"物理论证的旧推导"与"严格新推导"并存，工具自动取高者。

## 报告输出示例

```
worldsheet.no-ghost-theorem-v4
  status: rigorous
  effective: rigorous
  assumes: []
  conjectures-depended-on: []

holography.black-hole-entropy-strominger-vafa
  status: physical-argument
  effective: conjecture
  assumes: []
  conjectures-depended-on: [duality.ads-cft, duality.u-duality]
```

## 状态变更规则

- 升级需要给出新的 derivation 并指明来源；`formalized` 升级由工具从 Lean 构建结果自动写入，不手改。
- 降级到 `refuted` 需要一条 `kind: refutation` 的 derivation。
- 不允许在没有新 derivation 的情况下手改 `status`。

## 里程碑 `approved` 的含义（lead 裁决 2026-09-11，依 auditor 第五轮建议）

`audit.status: approved` 断言的是**陈述忠实性**（canonical_text 与 statement 经回译比对无漂移、无物理错误），**不**断言任何有效状态等级。推导严格程度由工具计算的 `effective` 单独承载并在 `stringgraph report` 逐里程碑列出。船长批准时应同时看到 effective 与瓶颈链（`stringgraph why`），但 effective = physical-argument 不阻止 approved。把 approved 绑到 effective ≥ rigorous 会制造"不拆定义卡以免降级"的反向激励。

## "断言 + 骨架"的档位（lead 裁决 2026-09-11，依 reviewer-ch5 建议）

来源给出论证骨架但关键步骤只有断言（如 Polchinski "a little thought shows"、"it is straightforward to"），标 **physical-argument**，`gaps` 逐条写明断言处；**不**标 conjecture。`conjecture` 保留给来源本身把它当猜想提出、或结论真伪在文献中未定的命题（对偶、沼泽地等）。理由："论证不完整"与"结论可能为假"是两个不同的轴，前者用 gaps 记录；把无争议的断言压成 conjecture 会让 `conjectures-depended-on` 报告失去含义。

## 旧推导的去留（lead 裁决，2026-09-11）

陈述换代（`superseded_by`）后，指向旧陈述的推导**保留不删**：它们是旧卡论证的不可变记录，且回译审计的 history 会引用它们。`validate` 对"target 已 superseded"报 warning 是提醒不是错误；处理规则：
- 新陈述必须有自己的推导（通常是旧推导的改名/改边版本，`git mv` 后 target 改指新 id）。
- 旧推导不再更新 notes；若旧推导的某条 depends_on 也被换代，不追改（warning 保留作历史痕迹）。
- 报告与 `why` 只沿新陈述走，旧推导不参与有效状态。

