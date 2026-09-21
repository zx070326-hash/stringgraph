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

## 默认自由（本节优先于下面全部规则，冲突时以本节为准）

**这个项目的规则是用来让「图」可信的，不是用来管「思考」的。规则漏进思考里就是 bug。**
判据很简单：一条规则如果让你在「该不该试」上犹豫，它已经用错地方了。

**规则只在一个地方生效：把东西放进 `graph/`、`formal/`，或者对外的时候。膜之内自由，膜之上严格。**

倾向要求（对 lead 和所有 agent，这是要求，不是许可）：

- **想到就试。** 探索不需要批准、不需要先立卡、不需要先查重、不需要先确认无人做过。试完发现错了、是已知的、是死路——**都算正常产出**，写一行结论就够，不必写 `docs/reviews/` 文档。
- **宁可做可能失败的事，不做一定能做完的事。** 本项目已被实测的失败模式：有活干时倾向选边界清晰、一定做得完、做完能写一段漂亮记录的事——那往往就是审计。前沿项长期无人认领，真实原因是**它们可能失败**。这个倾向要反过来。
- **不确定就往前走，不要停下来请示。** 需要判断的地方自己判断，把假设写清楚，继续。只有三件事停下来问：对外声称、里程碑签字、会毁掉已有工作的动作。
- **允许在猜想上施工。** 从 `conjecture` / `physical-argument` 节点出发推东西是正当研究，不是污染——`propagate.py` 会自动把结论的 `effective` 压到该有的档位，**不需要你额外自律**。唯一禁止的是把结论**标高**。
- **草稿可以是错的、脏的、半途而废的。** `research/sandbox/` 无任何规则：不校验、不需要 `claim.md`、不需要 `status.yaml`、不需要 reviewer、不进生命周期。乱写。
- **失败的尝试不欠解释。** 放弃一条路只需一行「此路不通，因为 X」。不需要 post-mortem，不需要写进 ROADMAP。

**探索阶段的具体豁免（这些是放宽，不是建议违反）**：
- **立卡前不要求查重。** `uv run stringgraph search` 的到期点是**要进 graph/ 或要对外**的时候，不是想到一个命题的时候。先算，立卡时再查。
- **`research/sandbox/` 真正零规则。** 想开 attempt 前在这儿乱算是推荐做法：一个 .md 想到哪写到哪、能跑就跑的代码片段、"此路不通因为 X"一句话——都行。不需要 claim.md、status.yaml、reviewer、不进生命周期。毕业标准：有一个能立成图节点的命题。
- **来源/约定/uses 可以晚补，validate 只 warn。** 见下面 validate 调整的四条。到期点统一是：**进 `graph/milestones/` 或被里程碑依赖**。

## 不可违背的原则

（在 `graph/` / `formal/` / 对外的范围内生效；`research/sandbox/` 一律不适用）

1. **陈述与推导分离**。一条陈述是一张卡，可以挂多个独立推导。
   **不可变性只在卡被「用起来」之后才生效**——满足下列任一条时，改文本才需要新建节点 + `superseded_by`：(a) 已被别的节点 `uses` / `depends_on`；(b) 已进 `graph/milestones/`；(c) 已标 `formalized`。
   **三条都不满足的卡直接就地改**，不换代、不留 superseded 尾巴。理由：换代成本本该用来保护「建立在这张卡上的东西」；没人建立在它上面时还收这笔税，只会攒版本垃圾（现存 79 个 superseded 节点，多数从未被依赖）。
2. **状态只能实话实说**。`status` 是该节点本身论证的严格程度，不是"大家都相信"。物理学家式的推导就写 `physical-argument`，对偶就写 `conjecture`。有效状态由工具计算，不手写。**这条是项目的全部价值所在，不放宽。**
3. **审计面固定在里程碑**。只有 `graph/milestones/` 里的陈述需要人类（船长）逐条确认，且必须通过回译审计。其余节点由 agent 自由添加。
4. **正式立卡时查重**。`uv run stringgraph search <关键词>`。**探索阶段不要求**——先算，要立卡时再查。
5. **每条边都要有来源**。`depends_on` 里的每个依赖要能在 `sources` 指向的文献位置找到对应论证。找不到就标 `inferred: true` 并留 note。
6. **约定显式化**。度规号差、α' 归一化、规范场归一化等由 `graph/conventions/` 统一定义，每条涉及公式的陈述声明使用哪套约定。
7. **提交前必须过校验**。`uv run stringgraph validate` 不通过的改动不得提交；pre-commit hook 会强制执行（只对 `graph/` / `tools/` / `tests/` 触发，`research/` 与 `literature/` 不拦）。
8. **审计由后果触发，不由存在触发**。判据只有一条、而且可机检：**这次审查或改动会不会移动任何节点的 `effective`？**
   - **不会移动** → 最多顺手改 `notes`。**不得为它派 agent、不得为它写 `docs/reviews/` 文档、不得占用一轮。** 诚实值当然要写对，但把一个零影响的字段写对是顺手的事，不是一轮工作的目标。
   - **会移动**，或属下列四种之一 → 该审，且不许省：(a) 卡要标 `formalized`（机检背书是对外声称，写错等于超额声称）；(b) 卡进 `graph/milestones/`；(c) 结果要对外（投稿、公开）；(d) 有人**即将**在它之上施工。
   - 四种之外**默认放行**。默认放行是本项目的正常状态，**不是懈怠**。一条卡以诚实的低档位躺着，不欠任何人交代。
   - **判例（2026-09-20，lead 自己踩的）**：ℓ=0 线两张卡的推导升 `rigorous`，lead 事前用 `status` 命令确认了 `effective` 不变、`why` 瓶颈树不变、下游零影响，**然后仍然派了复审、写了记录、占掉一轮**，还把「零影响」写成诚实的证据。正确读法：**零影响就是停手信号**。

## 原创证明轨道（research/）

图的审计常会发现某个关键命题在公开文献里找不到证明。这时在 `research/` 下开一条原创证明尝试，目标是做出真正新的数学/物理结果。

- **先做，后查。** prior-art 检索**不再是开工前提**。它的到期点是**结论要进 `graph/` 或要对外**的时候。理由：把无界的文献检索当开工门槛，挡住的是开工，不挡重复劳动；而「试完发现有人做过」的成本（几小时 + 一条负面记录）远低于「门槛太高所以没开始」的成本。
- **膜仍然在**：草稿与已发表结果图物理隔离，未经 `graph-reviewer` 审查不得进入 `graph/` 或被任何节点依赖。这条是图可信度的来源，不放宽。
- **`research/sandbox/` 在膜之外的膜之外**：无规则、无生命周期、无校验。想开 attempt 前先在这儿乱算是推荐做法，不是偷懒。


## 图是仪器，不是产品

图的价值在于**被用**，不在于被擦亮。这条是对上面全部审计机制的约束条件，冲突时它优先。

- **研究轨道优先。** 每一轮的默认问题是「**这一轮要推进哪个前沿**」，不是「哪里还能再审一遍」。审计是为了让前沿有地面可站，不是目的本身。
- **不得在高杠杆前沿项无人认领时，开新的审计线程。** 当前三项（随进展更新，位置在 `docs/ROADMAP.md` 顶部）：
  1. `worldsheet.ddf-contour-equals-mode-sum` —— **整条 Goddard–Thorn 无鬼定理的全部缺口收敛到的唯一节点**，且其依赖已全部 `formalized`。攻下它 = 一条 1972 年的定理完全机器验证，是可对外发表的成果。
  2. DGM 0803.2692 的 eq(51)/(52) 矛盾 —— 解决它 = `holography.torsion-immortal-positivity` 从 `physical-argument` 升 `rigorous`，本项目第一个真正升档的黑洞熵结果。
  3. `d10-anomaly-full-classification` 写成论文投出去 —— 已完整、已 `captain_confirmed`、有明确的先例错误（antonelli-2015 迹系数算错）可对照。**目前对外产出为零。**
- **`verified` 之后默认结项。** 一个 attempt 判 `verified` 后，除非上面四种"必须审"的情形出现，否则**不再回头复审**。想继续投入就去开新命题，不要在已判定的结论上加轮次。现状是 10 个 `verified` 里 7 个既没结项也没被建设，这是要修的对象。
- **`captain_confirmed` 只在两处是真门**：`graph/milestones/**` 的签字，以及**对外发表**。其余位置它是记录、不是阻塞——`verified` 的 attempt 无需等它就可以毕业进图、可以被建设。（`research/CLAUDE.md` 第 4 条原写「最好 `captain_confirmed: true`」，语义含混，以本条为准。）
- **负面结果与"已知结论的新推导路径"算产出，但要标清楚。** 不得包装成新物理，也不必因此贬低——但**不构成开下一轮的理由**。

## 多 agent 协作（agent teams / 子 agent）

本项目会并行运行多个 agent。规则：

### 角色与写入范围

| 角色 | 谁 | 职责 | 允许写入的路径 |
|---|---|---|---|
| lead | 主会话 | 分派任务、合并分支、维护里程碑 | 全部（但尽量只做合并与收尾） |
| auditor | physics-auditor agent | 回译审计、里程碑确认 | `graph/milestones/**`、`docs/reviews/**` |
| curator | graph-curator agent | 从文献抽取陈述与推导 | `graph/statements/**`、`graph/derivations/**`、`graph/conventions/**` |
| formalizer | lean-formalizer agent | Lean 形式化 | `formal/**`，以及图节点的 `formal:` 字段 |
| prover | theorem-prover agent | 原创证明尝试 | `research/**` |
| reviewer | graph-reviewer agent | 对抗性审查 | 只读，不写 |
| researcher | researcher agent | 文献检索与逐字抽取 | `literature/**` |

**协调方式：无协调总线，靠分工不重叠 + worktree 隔离。**
- lead 派工时写明该 agent 允许写入的路径。**粒度按任务性质给**：要进 `graph/` / `formal/` 的任务写到子目录或单文件；**探索型任务给宽范围就行**（例如整个 `research/sandbox/**` 或整个 attempt 目录），不必细到单文件——细粒度是为了防止两个 agent 互相覆盖，不是为了限制 agent 思考。
- 两个并行 agent 的写入路径**不得相交**。有交集就串行派，或者把交集部分留给 lead 自己收尾。这条是防真实破坏，不放宽。
- **派探索任务时不要在任务书里替 agent 决定结论或方法。** 只给问题和边界，让它自己找路。（反面判例：`docs/reviews/reviewer-contamination-borcherds-2026-09-20.md`——lead 在任务书里写出了上一轮的结论，结果收到的"独立佐证"只是自己的回声。）
- agent 之间不直接通信；有跨任务的发现写进自己的 `status.yaml` / 报告，由 lead 转达。
- 里程碑（`graph/milestones/**`）只有 auditor 和 lead 能写；curator 发现里程碑需要改动时只提建议，不动手。

### Git 纪律
- **API 故障韧性**（2026-09-10/11 两次证书错误各杀死 6–10 个 agent）：所有子 agent **每完成一张卡/一个声明立刻 validate+commit**，不攒；worktree 上无提交会被自动删除，未提交的工作全部丢失。lead 在 agent 死亡后先查 `.claude/worktrees/<id>` 是否仍在、`git status` 是否有可 validate 的残留，能过校验就代为提交（提交信息注明「lead committed on behalf of … after API outage」），再重新派工。
- 主分支 `main`。每个 agent 任务在自己的 worktree 上开分支：`agent/<role>/<slug>`，worktree 放在 `.claude/worktrees/`（已 gitignore）。
- **写手 agent 必须在自己的独立 worktree 里工作，绝不在主工作树 `D:/physics/string` 上 `git checkout -b` 或直接改文件**（实测 graph-curator / general-purpose 有此行为，会挡住 lead 在主树的 merge/checkout）。派工时用 Agent 的 `isolation: "worktree"`；lead 在动任何 `git checkout` / `merge` 前先 `git status` 确认当前在 `main` 且无 sub 残留改动，有则等 sub 返回再动。
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
