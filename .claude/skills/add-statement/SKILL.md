---
name: add-statement
description: 向图中新增一条陈述及其推导的标准流程：查重、登记文献、写 YAML、校验、提交。Use when adding a new node to graph/.
---

# 新增图节点

按顺序执行，不跳步。

## 1. 查重

```bash
uv run stringgraph search <两三个关键词>
```

有相近节点：优先给它加一条新的 derivation，而不是新建 statement。表述不兼容：不要新建，在报告里向 lead 提规范化请求（由 auditor 处理）。

## 2. 登记文献

`ref` 不在 `literature/sources.bib` 里就先加条目。key 格式 `<firstauthor>-<year>[-<suffix>]`。

## 3. 写 statement

路径 `graph/statements/<area>/<slug>.yaml`，`id: <area>.<slug>`。`area` 必须在 `graph/schema/areas.yaml`。

- `kind: proposition` 不填 `status`。
- `kind: definition|axiom` 必填 `status`（自身严格程度）和 `uses`（定义用到的节点）。
- 公式必须声明 `uses_conventions`。
- `sources[].loc` 精确到章节/定理号/公式号。

## 4. 写 derivation（proposition 必须至少一条）

路径 `graph/derivations/<area>/<slug>--via-<method>.yaml`。

- `kind` 与 `status` 的配对：`proof`↔`rigorous|formalized`，`physical-argument`↔`physical-argument`，`conjecture-support`↔`conjecture|speculation`，`refutation`↔任意。
- 每条 `depends_on` 要在 `sources.loc` 找得到，否则 `inferred: true` + `note`。
- 已知不严格的步骤写进 `gaps`。

## 5. 校验与提交

```bash
uv run stringgraph validate
uv run stringgraph status <new-id>
git add graph/ literature/
git commit -m "graph: add <slug> (<area>)"
```

`validate` 有 error 不许提交。
