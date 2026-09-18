---
name: extract-paper
description: 对一篇已登记文献做陈述级抽取，产出 literature/extractions/<ref>.md（不直接写图节点）。Use when a reading-list item is assigned for extraction.
---

# 文献陈述级抽取

参数：`$ARGUMENTS` = `<ref> [章节范围]`。

## 前提

- `<ref>` 必须已在 `literature/sources.bib`。
- 文献必须公开可得。私人草稿、未发表笔记一律不抽。

## 步骤

1. 复制 `literature/templates/extraction.md` 到 `literature/extractions/<ref>.md`（已存在则追加，不覆盖）。
2. 先写「约定」节：号差、α'、Virasoro 归一化、规范场归一化。与 `graph/conventions/` 里 canonical 的不同处写出换算。
3. 按文献顺序逐条抽陈述。每条：
   - 位置精确到公式号/定理号/页
   - 类型 definition / proposition / axiom
   - 原文尽量逐字
   - **文献自称的严格程度**：原文用的是 "we prove" / "it follows" / "one can show" / "it is believed" / 引用他处？照抄措辞
   - 文献自己列出的依赖（E 编号或外部引用）
4. 不做推断。"我觉得它其实还依赖 X" 写进「未解决的疑问」，留给 curator 标 `inferred`。
5. 更新 `literature/reading-list.md` 该行状态为 `extracted`。
6. 提交 `lit: extract <ref> <范围>`。

## 产出交接

在最终报告里列出抽取文件路径，交给 lead 转派 curator。
