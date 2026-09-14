# graph/ — 图数据本体

这里只放数据（YAML），不放代码。工具在 `tools/stringgraph/`。

## 目录

| 目录 | 一文件一节点 | 内容 |
|---|---|---|
| `statements/<area>/<slug>.yaml` | 是 | 陈述节点：定义、命题、公理 |
| `derivations/<area>/<slug>.yaml` | 是 | 推导节点：把一组依赖连到一条陈述，并给出来源与状态 |
| `milestones/<slug>.yaml` | 是 | 里程碑：经人审计的规范陈述，指向一个 statement id |
| `conventions/<slug>.yaml` | 是 | 约定节点 |
| `build/` | 生成物，不提交 | dot/svg/报告 |

## id 规则

- `area.slug`，全小写，连字符。area 取自 `schema/areas.yaml`。
- statement 与 derivation 各自独立命名空间；derivation id 写成 `<statement-id>--via-<method>`。
- id 一旦提交不得更改。要改陈述文本，新建节点并在旧节点写 `superseded_by`。

## 最小陈述示例

```yaml
id: worldsheet.virasoro-algebra
kind: definition            # definition | proposition | axiom
status: rigorous            # 仅 definition/axiom 填；proposition 禁止填，由推导计算
title: Virasoro 代数
statement: |
  Virasoro 代数是由 {L_n : n ∈ Z} 与中心元 c 张成的李代数，满足
  [L_m, L_n] = (m-n) L_{m+n} + (c/12) m(m^2-1) δ_{m+n,0}，[L_n, c] = 0。
uses: []                    # 定义直接用到的其他 statement id
uses_conventions: [conv.virasoro-standard]
sources:
  - ref: polchinski-1998-v1
    loc: "§2.6, eq. (2.6.19)"
tags: [cft, algebra]
```

约定节点多一个 `family` 字段（如 `metric`、`alpha-prime`），同 family 互斥，恰好一个 `canonical: true`。

## 最小推导示例

```yaml
id: worldsheet.no-ghost-theorem-v2--via-goddard-thorn
target: worldsheet.no-ghost-theorem-v2
kind: proof                 # proof | physical-argument | conjecture-support | refutation
status: rigorous            # 见 docs/STATUS_LEVELS.md
depends_on:
  - id: worldsheet.virasoro-algebra
  - id: worldsheet.ddf-operators-v2
    inferred: false
sources:
  - ref: goddard-thorn-1972
    loc: "无编号定理；摘要末句 'absence of ghosts for d ⩽ 26'（正文未获取）"   # 不确定编号时照实写，不要编 "Theorem 1"
summary: |
  用 DDF 算子构造物理态空间，证明 D=26 且 a=1 时物理态内积半正定。
author: seed
```

## 验证

```bash
uv run stringgraph validate          # 提交前必跑
uv run stringgraph search <keyword>  # 新增前必跑
```

校验内容：schema、id 唯一、引用可解析、无环、约定一致、每条边有来源或 `inferred: true`、里程碑指向的 statement 存在且 `audit.status == approved` 时必须有回译记录。

## 写节点时的判断标准

- **一个节点一个命题**。"D=26 且 a=1"是一个节点；"D=26"和"a=1"如果在文献中分别被推导，拆成两个。
- **status 写自身论证的严格程度**，不写"公认程度"。不确定时选低的那级。
- **来源定位到章节或公式号**，不只写书名。
- 需要新 area 时先改 `schema/areas.yaml`，单独提交。

## 换代时陈述正文内嵌 id 的处理（lead 裁决，2026-09-12）

陈述文本不可变（原则 1）也适用于正文里写的其他节点 id：换代某卡后，**不**就地改别的卡 statement 里对它的字面引用；依赖边（`uses` / `depends_on`）必须改指新 id，正文指针留待那张卡下次实质换代时同步。理由：指针不改变命题内容，而就地改字会让"statement 不可变"失去可核性。zumino 分支曾就地改过三处，属例外，不再发生。

- **`formalization-ruled-out` 标签**（2026-09-11）：`report` 的 "formalization frontier" 只是「依赖全 formalized、自身未 formalized」的候选名单，**不是待办**。若 lead 裁定某卡不做形式化（典型：卡断言的比任何计划中的 Lean 陈述多，且已有更窄的 formalized 拆卡，如 `ocq-level-two-scalar-norm` ↔ `-closed-form`），在 tags 加 `formalization-ruled-out` 并在 notes 写裁决；report 即隐藏它。已两次有 agent 据该名单误接线。

## `inferred: true` 不是"降级开关"（lead + graph-reviewer 裁决，2026-09-15）

`inferred: true` **不压低传播的有效状态**：`tools/stringgraph/propagate.py` 的 `_combine_deps` 只按依赖的 **effective level** 取下界，**根本不读 `inferred` 字段**。该 flag 只出现在 validate 的「每条边要有来源」检查与 `report` 的 inferred-edge 清单里。后果：一条 `inferred` 边若两端都是 rigorous，它对状态传播、对 `why` 瓶颈树、对 `status` 的 conjectures 集合**零影响**——命题既承重又隐形，造成 status 虚高。

- **`inferred: true` 的唯一正确用法**：标「这条**边的论证**在来源里找不到，但被依赖的**命题本身**是图内已有节点」。
- **若那条边实际携带一条"图外的、尚无节点的实质命题"**：必须把那条命题**立成节点**并给它诚实 status，让它正常沿图传播；**不得**塞进 flag 蒙混。
- 判据：问「这条边如果去掉 inferred，它指向的节点是否就完整承载了我需要的那句话？」若否（我需要的话比那个节点多），就是在用 flag 藏命题，立卡。
- 判例：`worldsheet.ddf-contour-equals-mode-sum--via-voa-residue` 首版（2026-09-15）把「物理 :e^{ink₀X}: = VOA 𝒴(e^{nk})」这条无源实质识别藏进一条指向 free-boson-tower 的 inferred 边（该卡边界 N6 恰恰逐字拒绝这句话），标 rigorous 使目标卡虚高到 rigorous。修正：提成显式节点 `worldsheet.physical-exponential-equals-voa-vertex-operator`（physical-argument），目标卡 effective 诚实回到 physical-argument。
