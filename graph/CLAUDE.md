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
    loc: "Theorem 1"
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
