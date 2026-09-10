---
name: audit-milestone
description: 对一个里程碑做回译审计（先只看 YAML 翻回自然语言，再与原文比对），填写 audit.back_translation 并置 back-translated。Use when a milestone is in draft and needs audit before captain approval.
---

# 里程碑回译审计

参数：`$ARGUMENTS` = 里程碑 id（如 `ms.no-ghost-theorem`）。

## 顺序不可调换

1. 打开 `graph/milestones/<slug>.yaml`，只记下 `statement_id`。**不要读 `canonical_text`。**
2. 打开 `graph/statements/<statement_id>.yaml`，只读 `statement`、`formal_statement`、`uses_conventions`。若有 `formal.lean_file`，读对应 Lean 声明。
3. 用自己的话写一段完整的自然语言陈述（含所有量词、条件、约定），这就是回译。
4. 现在读 `canonical_text` 和 `canonical_source` 指向的文献原文。
5. 逐项比对：
   - 量词（任意/存在）
   - 前提条件（D、a、号差、归一化）
   - 结论强度（等价/蕴含/半正定/正定）
   - 边界情形（D<26、D=26、D>26 分别说了什么）
6. 裁定 `faithful` / `drift` / `wrong`，差异写 `diff_notes`。
7. 写回 YAML：

```yaml
audit:
  status: back-translated
  back_translation:
    by: <你的 agent 名>
    text: |
      <回译文本>
    verdict: faithful
    diff_notes: |
      <差异，没有就写"无">
```

8. `uv run stringgraph validate`，提交 `graph: back-translate <ms-id>`。

`approved` 只能由人类船长填写，并附 `captain` 与 `approved_on`。
