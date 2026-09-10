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
- `definition`：定义，不需要论证。有效状态等同于其依赖的最低等级。
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
worldsheet.no-ghost-theorem-v3
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
