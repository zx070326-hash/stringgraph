# stringgraph

弦论结果的机器可读依赖图，带认识论状态传播，以及在此之上的 Lean 形式化岛。

- 项目动机与范围：`docs/VISION.md`
- 方法论来源：`docs/METHODOLOGY.md`
- 状态等级与传播规则：`docs/STATUS_LEVELS.md`
- 路线图：`docs/ROADMAP.md`
- 给 AI agent 与协作者的工作规则：`CLAUDE.md`

## 快速开始

```bash
uv sync
bash scripts/install-hooks.sh
uv run stringgraph validate
uv run stringgraph report
```

Lean 部分（可选，首次需拉 Mathlib 缓存）：

```bash
cd formal && lake exe cache get && lake build
```

## 布局

```
graph/        数据本体（YAML）：statements / derivations / milestones / conventions
tools/        Python 工具 stringgraph
formal/       Lean 4 形式化
literature/   文献登记与抽取记录
docs/         设计文档
tests/        工具测试
.claude/      agent 角色、skill、项目设置
```
