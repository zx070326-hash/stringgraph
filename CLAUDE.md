# stringgraph — 弦论结果依赖图与形式化

## 项目是什么

把弦论五十年的结果整理成一张**机器可读的有向无环图**：每个节点是一条精确陈述（定义、约定、或命题），每条边是"这条结果的某个推导依赖那条结果"。每个节点带**认识论状态**（已形式化 / 严格证明 / 物理论证 / 猜想 / 已反驳），状态沿图向上传播，使我们第一次能精确回答"某条结论到底建立在多少条猜想之上"。在此之上，挑选已有严格数学基础的"岛"做 Lean 形式化。

核心论证见 `docs/VISION.md`，方法论来源（Prove2Me / FLT / Navier-Stokes 项目的经验）见 `docs/METHODOLOGY.md`。

## 子项目地图

| 目录 | 内容 | 有自己的 CLAUDE.md |
|---|---|---|
| `graph/` | 图数据本体：陈述、推导、里程碑、约定（YAML） | 是 |
| `tools/stringgraph/` | Python 工具：校验、状态传播、报告、渲染 | 是 |
| `formal/` | Lean 4 + Mathlib 形式化岛 | 是 |
| `literature/` | 文献登记、抽取记录、模板 | 是 |
| `research/` | 原创证明尝试草稿，未毕业前与 `graph/` 物理隔离 | 是 |
| `docs/` | 愿景、方法论、状态定义、路线图 | 否 |
| `tests/` | 工具的 pytest | 否 |
| `.claude/agents/` | 本项目专用 agent 角色 | 否 |
| `.claude/skills/` | 本项目工作流 skill | 否 |

进入某个子目录工作前，**先读该目录的 CLAUDE.md**。

## 不可违背的原则

1. **陈述与推导分离**。一条陈述是不可变的卡片，可以挂多个独立推导。改陈述文本等于新建节点并标记旧节点 `superseded_by`。
2. **状态只能实话实说**。`status` 是该节点本身论证的严格程度，不是"大家都相信"。物理学家式的推导就写 `physical-argument`，对偶就写 `conjecture`。有效状态由工具计算，不手写。
3. **审计面固定在里程碑**。只有 `graph/milestones/` 里的陈述需要人类（船长）逐条确认，且必须通过回译审计。其余节点由 agent 自由添加，靠工具校验和 reviewer 把关。
4. **先搜索再新增**。新增节点前用 `uv run stringgraph search <关键词>` 查重。发现同一引理的不兼容表述，不要新建，而是提交到里程碑流程做规范化。
5. **每条边都要有来源**。`depends_on` 里的每个依赖要能在 `sources` 指向的文献位置找到对应论证。找不到就标 `inferred: true` 并留 note。
6. **约定显式化**。度规号差、α' 归一化、规范场归一化等由 `graph/conventions/` 统一定义，每条涉及公式的陈述声明使用哪套约定。
7. **提交前必须过校验**。`uv run stringgraph validate` 不通过的改动不得提交；pre-commit hook 会强制执行。

## 原创证明轨道（research/）

本项目默认做法是整理+形式化**已发表**结果。但当图的审计发现某个关键命题**在任何公开文献里都找不到证明**（不是"我们没读到"，是"确认查无此证明"）时，可以在 `research/` 下开一条原创证明尝试，目标是把它变成真正新的数学/物理结果，而不只是记账。规则见 `research/CLAUDE.md`：草稿与已发表结果图物理隔离，未经 `graph-reviewer` 审查并（理想情况下）船长确认之前，不得进入 `graph/` 或被任何节点依赖。发起这条轨道前，必须先确认真的无源可查——不要在"其实有人证明过、只是没读到"的情况下重复造轮子。

## 多 agent 协作（agent teams / 子 agent）

本项目会并行运行多个 agent。规则：

### Agora 协调总线
- 会话开始时调用 `agora_join`，`role` 与 `priority` 按下表，不得临时改动：

| role | priority | 谁 | 职责 |
|---|---|---|---|
| `lead` | 80 | 主会话 | 分派任务、合并分支、维护里程碑 |
| `auditor` | 60 | physics-auditor agent | 回译审计、里程碑确认；可抢占 curator 对 milestones 的写入 |
| `curator` | 50 | graph-curator agent | 从文献抽取陈述与推导 |
| `formalizer` | 50 | lean-formalizer agent | Lean 形式化 |
| `prover` | 50 | theorem-prover agent | 原创证明尝试，只写 `research/**` |
| `reviewer` | 40 | graph-reviewer agent | 对抗性审查，只读 |
| `researcher` | 30 | researcher agent | 文献检索，只写 `literature/` |

- 动手改文件前 `agora_claim`，路径粒度是子目录或单文件，例如 `graph/statements/worldsheet/**`、`formal/StringFormal/Virasoro/**`。
- 长任务中定期 `agora_inbox`。结束时 `agora_release` 并 `agora_leave`。
- **已知缺陷：同一会话派生的所有子 agent 在总线上共享一个身份**（2026-09-10 两次实测）。后果：`agora_release` 不带 `claim_id` 会释放别人的 claim；`agora_leave` 没有 claim_id 参数，**必然**释放该身份的全部 claim 并把别人标为 left。因此：
  - `agora_release` 必须带 `claim_id`。
  - 子 agent **不要调用 `agora_leave`**，只 release 自己的 claim；`agora_leave` 由 lead 在整批任务结束时调用一次。
  - 被连带释放后不要慌：文件没被动，重新 `agora_claim` 即可。
  - **2026-09-11 实测更严重的表现**：claim 常被记到别的角色名下（甚至自己刚 claim 的 #134 也释放不了）。处理：`agora_release` 报 "No matching held claim" 时先重新 `agora_join(role=...)` 再试一次；仍失败就在报告里写明，由 lead 收尾时统一清理。**不要**因此重复 claim 或调用 `agora_leave`。
  - 真正的隔离（每个 worktree 独立 bus id）待总线支持后再启用。
- 冲突优先 `agora_send` 沟通，`agora_preempt` 只用于 auditor 阻止错误进入里程碑。

### Git 纪律
- **API 故障韧性**（2026-09-10/11 两次证书错误各杀死 6–10 个 agent）：所有子 agent **每完成一张卡/一个声明立刻 validate+commit**，不攒；worktree 上无提交会被自动删除，未提交的工作全部丢失。lead 在 agent 死亡后先查 `.claude/worktrees/<id>` 是否仍在、`git status` 是否有可 validate 的残留，能过校验就代为提交（提交信息注明「lead committed on behalf of … after API outage」），再重新派工。
- 主分支 `main`。每个 agent 任务在自己的 worktree 上开分支：`agent/<role>/<slug>`，worktree 放在 `.claude/worktrees/`（已 gitignore）。
- 只由 `lead` 合并到 `main`。合并前跑 `uv run stringgraph validate` 和 `uv run pytest`；含 `formal/` 改动的分支还要 `lake build` 与 `uv run stringgraph check-axioms`。
- 禁止 `push --force`、`reset --hard`、改写历史。
- 提交信息格式：`<scope>: <动词开头的一句话>`，scope 取 `graph|tools|formal|lit|docs|claude`。例：`graph: add no-ghost theorem chain (worldsheet)`。
- 每个提交只做一件事。图数据改动和工具改动分开提交。

### 子项目 `.claude/` 与 CLAUDE.md
- 根目录 `.claude/` 是唯一的 agent/skill/settings 位置，子目录不再放 `.claude/`，避免 agent 在 worktree 里读到不一致的配置。
- 子目录 CLAUDE.md 只写该目录的**局部规则**（文件格式、命名、验证命令），不重复本文件内容。

## 常用命令

```bash
uv sync                               # 安装工具依赖
uv run stringgraph validate           # 校验全图（schema、id 解析、无环、约定一致）
uv run stringgraph validate --hide-history   # 只看活问题（隐藏已换代卡的预期历史痕迹；汇总行仍报 K history）
uv run stringgraph status <node-id>   # 某节点的有效状态、每条推导的 own/effective、依赖的猜想集合
uv run stringgraph why <node-id>      # 该节点有效状态被哪条链压低（瓶颈树）
uv run stringgraph report             # 全图统计 + 每个里程碑的猜想依赖
uv run stringgraph search <keyword>   # 新增前查重
uv run stringgraph dot > graph/build/graph.dot   # 导出 Graphviz
uv run pytest                         # 工具测试
cd formal && lake build               # 构建 Lean 形式化
uv run stringgraph check-axioms       # 全图 lean_decl 的公理检查（需先 lake build；合并 formal 分支前必跑）
```

## 当前阶段

见 `docs/ROADMAP.md` 顶部「当前活跃」。两条线并行（细节全在 ROADMAP，本文件不复述）：
- **形式化线**（Phase 1 世界面子图 + `formal/`）：第一形式化目标 Goddard–Thorn 无鬼定理（`worldsheet.no-ghost-theorem-v4`）。
- **黑洞 / 原创线**（Phase 3 全息与黑洞 + `research/` 原创证明轨道）：N=4 挠 dyon 免死指标正性等原创结果正在 `research/attempts/` 推进与毕业。
