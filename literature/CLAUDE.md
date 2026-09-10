# literature/ — 文献登记与抽取

## 文件

- `sources.bib`：唯一的文献登记表。图中所有 `sources[].ref` 必须是这里的 key。key 格式 `<firstauthor>-<year>[-<suffix>]`，例如 `polchinski-1998-v1`、`goddard-thorn-1972`。
- `extractions/<ref>.md`：对一篇文献做的陈述级抽取记录，按 `templates/extraction.md` 模板。抽取记录是**中间产物**，图节点是最终产物；先写抽取记录，再由 curator 转成节点。
- `reading-list.md`：待抽取队列，带优先级与负责 agent。

## 规则

1. 只登记公开可获取的文献（arXiv、出版书籍、公开讲义）。**不使用任何未发表草稿或私下获得的材料**。
2. 抽取时逐条记录：陈述原文位置、文献自己声称的严格程度、文献自己列出的依赖。不在抽取阶段做"我觉得它其实依赖 X"的推断，那留给 curator 并标 `inferred`。
3. 一篇文献一个抽取文件，可以多次追加，不覆盖已有条目。
4. researcher agent 只写本目录，不写 `graph/`。

## 默认参照

Polchinski, *String Theory* Vol. 1–2 (1998) 是约定与陈述编号的默认参照。Green–Schwarz–Witten (1987)、Blumenhagen–Lüst–Theisen (2013) 为补充。

- bib key 规范 `<firstauthor>-<year>`：无出版年的讲义/网页用 `<firstauthor>-<slug>`（例 `milicic-riemann-surfaces`），note 里写明"无年份"。（lead 裁决 2026-09-11）
