# 杠杆分析：形式化哪张卡收益最大？

本文档是船长最初一次性脚本分析的可复现版本。**每一个数字都由 `uv run stringgraph
hitting-set` / `uv run stringgraph roots` / `uv run stringgraph counterfactual` 生成**，
复现命令写在每一节里；实现见 `tools/stringgraph/report.py`
（`bottleneck_roots` / `is_self_capped` / `force_rigorous` / `counterfactual_report` /
`greedy_root_cover` / `hitting_set_report`），测试见 `tests/test_graph.py`
（"leverage analysis" 一节）。

生成时的 HEAD：`3424943`（在 `fb28d4a` "formal: merge the N=6 eleven-shape occupation
classification" 之后）。船长原分析基于 `120ac3d`；两次提交之间发生了若干合并（含一次桥接卡
v2 换代与 N=6 无鬼定理相关的形式化工作），所以下面部分数字与船长原表有小幅漂移——每一处漂移
都在"与基线的偏差"一节里列出并解释了原因，没有为了对齐基线而调整算法或选择性汇报。

## 结论先行

1. **弦论的严格性缺口不是几个大猜想，而是几百个从未被严格写下来的推导步骤。**
   全图只有 **31 张卡**的有效状态是 conjecture/open（真正的"猜想"），其中最大的一张也只
   钉住 4 张下游卡。但**低于 rigorous 的活卡有 383 张**（占 595 张活卡的 64%），
   它们的瓶颈根（bottleneck root）**86.9% 是卡自己的推导状态**，不是上游猜想。
2. **把 188 个瓶颈根全部形式化成 rigorous，也只能救出 14 张卡**（383 张里的 3.7%，
   四舍五入约 4%）。杠杆几乎不存在集中效应：贪心覆盖曲线接近线性
   （25% 的弱卡需要 26 个根，50% 需要 55 个，75% 需要 103 个，90% 需要 147 个，
   全部需要 188 个）。
3. **例外是 worldsheet 区域的一个局部瓶颈**：单独把
   `worldsheet.ddf-contour-equals-mode-sum` 或贪心 top-26 个根形式化，会把里程碑
   `ms.no-ghost-theorem`（Goddard–Thorn 无鬼定理）从 physical-argument 直接推到
   rigorous，外加 3–6 张相邻卡。这是全图目前唯一"形式化一小撮卡就能拿下一个里程碑"的
   地方。
4. **thin zone（holography / swampland / math）的价值是卡本身，不是级联**：
   这三个区域的平均瓶颈根集合只有 1.1–1.3 个（多数卡的瓶颈根就是它自己），形式化它们
   几乎不解锁任何其他卡（holography 的两张示例卡强制为 rigorous 后，解锁数 = 0）。
   如果要为 thin zone 卡辩护，理由只能是"这个结果本身值得严格化"，不能是"这样能带动一片"。

## 1. 全图规模：活卡、弱卡、瓶颈根

复现：`uv run stringgraph hitting-set`

```
active=595 weak(<rigorous)=383 distinct_roots=188
root-set size: median=5.0 max=64
```

- **活卡（active，`superseded_by` 为空）**：595 张。
- **弱卡（weak，活 且 有效状态 < rigorous）**：383 张，占活卡的 64.4%。
- **瓶颈根（bottleneck root）**：对每张弱卡，沿着它的最佳推导（或定义/公理的 `uses`）
  递归下降，只往"和自己一样弱或更弱"的依赖里走，直到走不下去为止，叶子集合就是这张卡
  的瓶颈根（算法见 `tools/stringgraph/report.py:bottleneck_roots`，与 `why_report` 的
  瓶颈树同构，返回叶子集合而非树）。383 张弱卡一共只挂在 **188 个不同的瓶颈根**上，
  每张卡平均挂 5 个根（中位数），最多的一张（某个 branes 卡）挂了 64 个根。

单卡查询：`uv run stringgraph roots <id>`，例如：

```
$ uv run stringgraph roots worldsheet.ddf-contour-equals-mode-sum
worldsheet.ddf-contour-equals-mode-sum: 1 bottleneck root(s)
  worldsheet.ddf-contour-equals-mode-sum
```

（这张卡自己就是自己的瓶颈根。）

> 🔴 **2026-09-19 lead 订正。** 本节初稿把这个结果的**理由**写成「它没有推导，`kind: proposition`
> 且 `best_derivation is None`」。**那是错的**，且在本文自己声明的 HEAD `3424943` 上就已经是错的：
> 这张卡当时已经有**两条**推导，两条都早于 `3424943`（实测 `git merge-base --is-ancestor`：
> `940ec47` 2026-09-11 建 `--via-laurent-coefficient-extraction`，`d62829f` 2026-09-18
> 最后一次改 `--via-voa-residue`，两者均为 `3424943` 的祖先）。
>
> **结论不变，机制完全不同，而且更有意思**：
>
> | 推导 | own | effective | 瓶颈在哪 |
> |---|---|---|---|
> | `--via-laurent-coefficient-extraction` | physical-argument | physical-argument | **自封顶**（它自己的 status） |
> | `--via-voa-residue` | rigorous | physical-argument | **桥卡** `worldsheet.physical-exponential-equals-voa-vertex-operator-v2` |
>
> `--via-laurent-coefficient-extraction` 的三条依赖（`ddf-operators-v6`、
> `exponential-vertex-operator-modes`、`momentum-tower-fock-space`）**全部是 `formalized`**
> ——所以沿这条推导下降时，这张卡确实纯粹自封顶，`roots` 返回它自己是对的。
>
> ⚠ **但这掩盖了一半事实。** 两条推导的 effective **打平**在 physical-argument，
> `bottleneck_roots` 只沿 `best_derivation` 下降，平局时只跟其中一条，于是
> `roots worldsheet.ddf-contour-equals-mode-sum` 完全**看不见**另一条推导的瓶颈是桥卡。
> 这对第 2 节的反事实数字没有影响（`counterfactual` 是真强制+重算，不走 `roots`），
> 但它意味着：**`roots` 的输出在「一张卡挂多条 effective 打平的推导」时是不完整的**，
> 只讲了一个故事。读第 3–5 节的贪心/自封顶统计时要记住这条限制——那些统计全部建立在
> `bottleneck_roots` 上。
>
> ✅ **工具侧已修（2026-09-19）**：`roots` 与 `why` 现在会在原输出之后**追加**打平的其它推导
> 及它们各自的瓶颈根，并明确标出哪一条才是喂给统计的那条。`report` 列出全图处于此状态的卡。
> 🔴 **统计口径刻意未改**（全部以新增函数实现，未动 `bottleneck_roots` /
> `hitting_set_report` / `greedy_root_cover` / `is_self_capped` 任何既有函数体），
> `hitting-set` 输出经 diff 验证与修改前**逐字节相同**——本文第 1、3、4、5 节的数字
> 全部继续有效，无需重测。
>
> ⚠ **实测发现：全图有 20 张 active proposition 处于"多条推导 effective 打平"状态**（673 张中约 3%）。
> 也就是说，除了本节这张卡之外**还有 19 张卡的隐藏瓶颈从未被看过**。本文的统计对它们
> 同样只讲了一个故事。逐张查看：`uv run stringgraph report` 的 `tied effective derivations` 段，
> 再对每个 id 跑 `uv run stringgraph roots <id>`。**这 19 张是一份现成的待查清单**，
> 本文未逐张核查，不宜假定它们的隐藏瓶颈都无关紧要——这张卡的隐藏瓶颈恰恰是
> 整条无鬼定理关键路径的真实障碍。
>
> ✅ **这 19 张已于 2026-09-19 逐张核查完毕（graph-reviewer，19/19，无遗漏）；结论见第 9 节。
> 简短版：没有第二例。** 上面这段警告是对的（不该假定无关紧要），但实测答案是良性的。

> **这条订正的实质后果**（🔴 比订正本身重要）：本文「结论先行」第 3 条把这张卡称为全图唯一的
> 真级联点，据此建议优先形式化它。但按上表，沿 `--via-voa-residue` 这条**已经 own=rigorous**
> 的路走时，真正的障碍是桥卡，而桥卡的瓶颈是 `[GAP-anchor]`——按
> `research/attempts/physical-exponential-equals-lattice-voa/status.yaml`，
> (H-anchor-1) 在图现状下**不可能成为定理**（X^μ(z) 含 ln z 与 x^μ，不是塔上良定义的形式
> 洛朗级数；`formal/StringFormal/NoGhost/DDF.lean` 的「What is NOT here」第 3 条逐字：x^μ 不是算子）。
> ⇒ **全图唯一的级联点，挂在一个当前图结构下无法兑现的前提上。**
> 已派 graph-reviewer 专门核查「该依赖是承重还是可消」，**裁决：承重**（2026-09-19）。
> 关键证据不是推导里的某条边，而是**目标卡陈述正文本身**：
> `ddf-contour-equals-mode-sum` 的【文献侧的对象】段逐字抄了 goddard-2008 (5.1)–(5.3)，
> 左端的 `V(n k_0, z) = :exp{i α·Q(z)}:` 里 `Q^μ(z) = q^μ − i p^μ log z + …` **含 q^μ 与 log z**。
> 而 `ms.no-ghost-theorem` 的 `canonical_text` (1)(b) 又把等距同构的靶空间定义成
> 「由 24 个横向 DDF 算子 A^i_{−n} 生成」的 Fock 空间——A^i_n 正是由那个围道积分定义的。
> ⇒ 这条翻译**位于被审计的链条内部**，不是链条旁边的解释性边。
> 把依赖边改指一张只承载 track (iii) 已证数学命题 (A′-a) 的新卡**不可行**：那只会把
> (H-anchor) 从一条显式依赖边挪进推导里一处未列出的隐含步骤，比
> `graph/CLAUDE.md` 判例里的 `inferred` 误用更隐蔽（inferred 至少在 validate/report 里留痕）。
>
> **⚠ 但"永远不可能"这个说法要收窄**（lead 2026-09-19，与 reviewer 的措辞有别）：
> 准确的陈述是「在**图与 Lean 当前的塔构造**下不可能」——`DDF.lean` 是**刻意**不把 x^μ 作为算子的。
> 这不是数学上的不可能：格点 VOA 的标准处理恰恰能容纳 e^{ikx}（群代数移位算子）与 z^{p}，
> track (iii) 的 (A′-a)(A′-b)(A′-c) 已经是这个方向上的真定理。
> 所以这是一条**成本与范围**的判断，不是一堵墙：兑现它等价于重做
> `formal/StringFormal/NoGhost` 的基础对象。把它记成"不可能"会让未来的 agent 停止思考，
> 记成"很贵"才是如实的。
>
> **对本文行动建议的后果**：「结论先行」第 3 条的**测量结果**（强制该卡 ⟹ +4 卡 + 命中里程碑）
> 完全不受影响，那是真实的反事实。但它的**行动含义**必须改写：这不是一个
> 「啃一小撮卡就拿下里程碑」的便宜目标，而是全图最贵的目标之一。
> 🔴 **⇒ 在当前图结构下，`ms.no-ghost-theorem` 达到 rigorous 的路径尚未打通，且不便宜。
> 这是一个需要船长裁决的范围问题，不是可以由 agent 顺手推进的工程任务。**

## 2. 反事实：形式化哪张卡收益最大？

**关键陷阱**：把 `statement.status` 设成 `rigorous` 对命题（proposition）不够——它的有效
状态仍然是它现有推导的 `min`。正确做法（`force_rigorous`，见
`tools/stringgraph/report.py`）是**整个替换掉命题现有的推导**，换成一条
`depends_on: []` 的 `rigorous` 证明；对定义/公理，`status` 才真的驱动它的有效状态，
直接改 `status` 并清空 `uses` 即可。`counterfactual_report` 强制这些卡之后重算全图，
和原图 diff，**排除被强制的卡本身**（否则就是在算自己），并单独标出命中的里程碑。

复现：`uv run stringgraph counterfactual <id> [<id> ...]`

| 场景 | 强制的卡 | 解锁的其他活卡 | 命中里程碑 |
|---|---:|---:|---|
| OPE 单独 | `worldsheet.operator-product-expansion` | **+0** | 无 |
| CFT 基础四卡（本文选取，见下） | 4 张 | **+1** | 无 |
| 贪心 top-10 根 | 10 张 | **+1** | 无 |
| 贪心 top-26 根 | 26 张 | **+7** | `ms.no-ghost-theorem` |
| 全部 188 个根 | 188 张 | **+14**（383 张弱卡的 3.7%） | `ms.no-ghost-theorem` |
| `worldsheet.ddf-contour-equals-mode-sum` 单独 | 1 张 | **+4** | `ms.no-ghost-theorem` |
| holography thin zone 两卡 | 2 张 | **+0** | 无 |
| 已经 rigorous 的卡（no-op 校验） | `math.locality-ope-equivalences-v2` | **+0** | 无 |

逐条命令与输出（节选）：

```
$ uv run stringgraph counterfactual worldsheet.operator-product-expansion
forced (1): worldsheet.operator-product-expansion
moved (0 other active cards):

$ uv run stringgraph counterfactual worldsheet.ddf-contour-equals-mode-sum
forced (1): worldsheet.ddf-contour-equals-mode-sum
moved (4 other active cards):
  worldsheet.critical-dimension-old-covariant-v3: physical-argument -> rigorous
  worldsheet.ddf-spanning-hypothesis: physical-argument -> rigorous
  worldsheet.no-ghost-theorem-conditional-on-ddf-spanning: physical-argument -> rigorous
  worldsheet.no-ghost-theorem-v4: physical-argument -> rigorous
milestones hit (1):
  *** ms.no-ghost-theorem (worldsheet.no-ghost-theorem-v4): physical-argument -> rigorous

$ uv run stringgraph counterfactual holography.dvv-dyon-index-generating-function holography.phi10-wall-crossing-poles
forced (2): holography.dvv-dyon-index-generating-function, holography.phi10-wall-crossing-poles
moved (0 other active cards):
```

top-10 / top-26 / 全 188 个根的具体 id 列表由
`uv run stringgraph hitting-set --target 1.0` 的输出按顺序取前 N 个得到（该命令按贪心
频率序打印全部 188 个根，见第 3 节）；"CFT 基础四卡"是本文自选的一组（任务只给出
"CFT-foundation four cards"的描述，没有给出船长原始选用的确切 id，选取原则见下），
选的是 `math.locality-ope-equivalences-v2`（已 rigorous，兼作 no-op 校验的替代样本）、
`worldsheet.primary-field-v2`、`worldsheet.state-operator-isomorphism`、
`cft.tensor-two-and-three-point-functions`——CFT 最基本的四块砖：局域性/OPE 等价、
primary 场定义、态-算子同构、二三点函数张量结构。

## 3. 贪心命中集：形式化多少个根能救出多少弱卡

复现：`uv run stringgraph hitting-set`（全表）或
`uv run stringgraph hitting-set --target 0.5`（只要某个阈值对应的根列表）。

算法（`greedy_root_cover`）：把 188 个根按"出现在多少张弱卡的瓶颈根集合里"降序排序
（静态频率，只算一次，不是每挑一个根就重算）；一张弱卡只有在它的瓶颈根集合**整个**
被选中的根集合覆盖时才算"解锁"（AND 语义——只解锁瓶颈根集合的一部分不足以让它的有效
状态真正提升，因为传播公式取的是 `min`）。这是一个便宜的、不需要真的重算全图的诊断
代理，不等于第 2 节那种"真的强制+重算"的反事实；两者在 top-10/top-26/全 188 上给出的
解锁数吻合（分别是 +1、+7、+14），说明这个代理在当前图上是可信的。

```
greedy root-cover checkpoints (roots needed -> weak cards fully resolved):
   25%  -> 26 roots
   50%  -> 55 roots
   75%  -> 103 roots
   90%  -> 147 roots
  100%  -> 188 roots
```

这条曲线**接近线性**：前 25% 的根只需要 26 个（14% 的根量），但后 25%（90%→100%）需要
再加 41 个根（22% 的根量）——没有哪一小撮根占了大头。换句话说，不存在"形式化这十张卡就能
解决大半个图"的捷径。

## 4. 为什么：自封顶（self-capping）

一张弱卡的瓶颈可能来自"它自己的推导状态"，也可能纯粹来自"上游依赖比它弱"。
`is_self_capped` 判断前者：命题看它最佳推导自身的 `status`，定义/公理看它自己的
`status`，跟它的有效状态比——相等（或没有任何可指责的上游依赖）就是自封顶。

复现：`uv run stringgraph hitting-set`

```
self-capped: 333/383 = 86.9%
```

**86.9% 的弱卡，瓶颈就是它自己的推导从未被写严格**，不是因为它依赖了某个更弱的上游。
这是第一节"结论先行"里"上游脚手架不是承重墙"这句话的数字依据：把上游全部形式化
（第 2、3 节的全 188 根反事实），也只能救出 14/383 = 3.7% 的卡，恰好因为
82%+ 的卡的问题根本不在上游。

按区域分解（复现同上，`hitting-set` 输出的 "self-capped by area"）：

| 区域 | 弱卡数 | 自封顶比例 |
|---|---:|---:|
| cft | 3 | 100.0% |
| susy | 4 | 100.0% |
| swampland | 29 | 100.0% |
| spectrum | 38 | 94.7% |
| consistency | 20 | 90.0% |
| branes | 19 | 89.5% |
| compact | 23 | 87.0% |
| duality | 7 | 85.7% |
| worldsheet | 205 | 84.9% |
| holography | 16 | 75.0% |
| math | 19 | 73.7% |

holography 和 math 的自封顶比例最低（75.0%、73.7%），说明这两个区域"卡自己没写严格，
但也确实在等上游"的情况相对更多；但即便如此，也不代表形式化上游能带来级联收益——见
第 5 节的 thin zone 讨论。

## 5. 厚区域 vs 薄区域：瓶颈根集合的大小

复现：`uv run stringgraph hitting-set`（"root-set size by area"）

| 区域 | 弱卡数 | 平均瓶颈根数 | 最大瓶颈根数 |
|---|---:|---:|---:|
| branes | 19 | 41.2 | 64 |
| spectrum | 38 | 16.7 | 27 |
| susy | 4 | 16.5 | 63 |
| worldsheet | 205 | 10.3 | 60 |
| compact | 23 | 7.0 | 35 |
| duality | 7 | 6.6 | 10 |
| cft | 3 | 5.0 | 7 |
| math | 19 | 1.3 | 5 |
| holography | 16 | 1.2 | 2 |
| swampland | 29 | 1.1 | 4 |

**厚区域**（branes、spectrum、susy、worldsheet）：一张弱卡平均挂在 10–41 个瓶颈根上，
说明这些区域的推导链又长又纠缠——形式化任何单一的根，大概率救不了一张卡（它还挂着别的
弱根）。这与第 3 节贪心曲线的近乎线性吻合：厚区域的卡需要"凑齐一整组根"才能解锁，
天然抗集中。

**薄区域**（math、holography、swampland）：平均瓶颈根数只有 1.1–1.3，多数卡**就是自己
的瓶颈根**（自成一派，没有牵连别的弱卡）。这类卡形式化起来"干净"（不需要先啃掉一串
上游），但正因为它们孤立，形式化它们也不会带动别的卡——这就是第 2 节 holography thin
zone 反事实给出 +0 的结构性原因，不是这两张示例卡碰巧选得不好。

## 6. 与船长基线（`120ac3d`）的偏差

以下每一条都是**如实测量**的结果，没有为了对齐船长的数字而调整算法。大多数数字精确吻合
（活卡 595、弱卡 383、根数 188、median 5 / max 64、OPE 单独 +0、
`ddf-contour-equals-mode-sum` 单独 +4 +里程碑、top-10 +1、top-26 +7 +里程碑、
全 188 根 +14、holography thin zone +0、真猜想/open 卡数 31——全部精确匹配）。
有分歧的地方：

1. **贪心 50% 检查点**：本文测得 55 个根，船长基线是 56 个（其余检查点 26/103/147/188
   全部吻合）。差 1，量级上完全在"两次提交之间图有变化"的合理范围内，不深究。
2. **自封顶总比例**：本文测得 333/383 = 86.9%，船长基线是 329/382 = 86%。
   分母的 383 vs 382 是刻意的——见第 7 节"缺失的一张卡"，船长的原分类脚本漏判了
   `swampland.wgc-sharp-form-i`，本文的 `is_self_capped` 显式修了这个洞。
   分区数字里 consistency（90.0% vs 89.5%）、worldsheet（84.9% vs 84.7%）有 <1 个百分点
   的漂移，其余七个区域精确吻合，同样归为图漂移。
3. **"CFT 基础四卡"反事实**：本文测得 +1（解锁
   `worldsheet.radial-hermitian-conjugation`），船长基线是 +0。这条**不是漂移**，是
   选卡差异——任务书没有给出船长当时选的确切四张卡 id，只有"CFT foundation four cards"
   这个描述，本文按自己的理解选了一组（见第 2 节），测出的 +1 是这组卡在当前图上的真实
   反事实结果。不排除船长当时选的是另外四张、恰好互相之间没有形成这张
   `radial-hermitian-conjugation` 卡的完整依赖闭包。
4. **"最大的单张猜想/open 卡"**：这是本文与基线**最实质性的分歧**，单独成节说明。

### 6.1 全图最大杠杆的猜想/open 卡：不再是 AdS/CFT

船长基线称"全图只有 31 张真正的猜想/open 卡，最大的一张（`holography.ads5-cft4-duality-v2`，
Maldacena 猜想）也只钉住 4 张下游卡"。**卡数 31 精确吻合**
（复现：对全部 595 张活卡逐一算有效状态，筛 `effective in {conjecture, open}`）。
但在当前 HEAD 上，`holography.ads5-cft4-duality-v2` 单独强制为 rigorous 只解锁
**0** 张下游卡：

```
$ uv run stringgraph counterfactual holography.ads5-cft4-duality-v2
forced (1): holography.ads5-cft4-duality-v2
moved (0 other active cards):
```

对全部 31 张猜想/open 卡逐一跑真实反事实（强制+重算，不是代理频率），当前最大的一张是
`worldsheet.ddf-spanning-rank-inequality`（N=6 无鬼定理证明分支里的一个 `open` 命题，
"(B-26) 的秩不等式改写"），单独强制解锁 **4** 张下游卡，且命中里程碑
`ms.no-ghost-theorem`：

```
$ uv run stringgraph counterfactual worldsheet.ddf-spanning-rank-inequality
forced (1): worldsheet.ddf-spanning-rank-inequality
moved (4 other active cards): ...
milestones hit (1):
  *** ms.no-ghost-theorem ...
```

**真实原因**（🔴 **2026-09-19 lead 订正：本节初稿把原因归给"图在两次提交之间往前走了"，
那是错的；实测否定，改写如下**）：

本文初稿称该卡是 N=6 形式化线在 `120ac3d` **之后**才落地、才被接上无鬼临界路径的。
lead 逐条实测，四项全部否定这个解释：

- 建卡提交是 `fe17d48`（2026-09-12，"add ddf-spanning-rank-inequality card (B26 as an
  open Prop, SliceRank PR1)"），`git merge-base --is-ancestor fe17d48 120ac3d` 为真
  ——该卡**早于**基线六天就存在；
- 现在引用它的 10 个 derivation 文件，在 `120ac3d` 上**逐个都已存在**（含
  `no-ghost-theorem-v4--via-goddard-thorn.yaml`），依赖结构未变；
- 该卡在基线上 `kind: proposition`、无任何 derivation 指向它；现在仍是零 derivation；
- 故 `own_status = effective = open` 在两个提交上相同。

⇒ 依赖结构、卡状态、下游集合在基线与 HEAD 上**完全一致**，这条 +4 在 `120ac3d` 上就成立。
**分歧的来源不是图漂移，是船长基线分析本身漏了这张卡**（漏判的机制与第 7 节
`swampland.wgc-sharp-form-i` 同类：基线脚本按 statement 级 `status: conjecture` 筛选，
`open` 这一档没被扫进来）。本文的结论正确，本节初稿给出的**理由**不正确。

保留下来的实质结论有两条，且比初稿写的更强：
1. 全图最大杠杆的猜想/open 卡是 `worldsheet.ddf-spanning-rank-inequality`，不是 AdS/CFT；
   这一点在船长基线那一刻就已经为真，不是新发生的事。
2. "最大也只钉住 4 张"这个**量级**结论不受影响（4 张，精确复现）——换了主角，没换数量级。

⚠ 方法论教训（比结论本身重要）：一个用 `counterfactual` 实跑得到的数字推翻了一个凭
**卡的知名度**形成的直觉（"最大的猜想当然是 Maldacena"）。`stringgraph counterfactual`
存在的理由正是这个：杠杆是拓扑性质，与命题有多出名无关。

## 7. 缺失的一张卡：`swampland.wgc-sharp-form-i`

船长的自封顶分类脚本对 383 张弱卡只分类出了 382 张——恰好一张卡落进了两个分支之间的缝隙：
它的own状态不低、也没有弱依赖，但有效状态却低于 rigorous。这张卡是
**`swampland.wgc-sharp-form-i`**，全图目前唯一一张 `effective = refuted` 的卡。

**机制**：`propagate.py` 的传播公式是 `effective = min(own, deps 的下界)`，但**反驳
（refutation）推导是这条公式的显式例外**——一条 `kind: refutation` 的推导，只要它自己
算出来的 own 严格度达到 `physical-argument` 以上，就会把目标**直接强制成 `refuted`**，
不管 `min(own, deps)` 算出来是多少（`docs/STATUS_LEVELS.md`、`propagate.py:_proposition`
里的 `refutations` 分支）。`swampland.wgc-sharp-form-i` 的反驳推导除了一条卷入到
`_combine_deps` 时被过滤掉的 convention 依赖之外，没有任何陈述级别的依赖——`dep_ids`
是空的。

一个朴素的自封顶分类器（"own 推导的 status 等于有效状态就算自封顶，否则看有没有弱依赖"）
在这张卡上两头落空：它的反驳推导自身 status 是 `physical-argument`（level 3），但
overridden 之后的有效状态是 `refuted`（level 0），`3 != 0`，第一支不成立；`dep_ids`
是空集，没有"弱依赖"可言，第二支也不成立。本文的 `is_self_capped`（见
`tools/stringgraph/report.py`）加了一条显式早退：**`dep_ids` 为空直接判自封顶**
（没有任何上游依赖可以指责，责任只能在自己身上）——这条规则对这张卡是对的，但要注意它的
正确性来自"这张卡恰好是反驳导致的例外"，而不是来自"没有依赖的卡在一般意义上都该算自封顶"
这个更强的（也更可疑的）断言。

**这既是分类边界情形，也是（轻微的）传播语义特例，两者都成立，不是二选一**：
- 从分类脚本的角度看，这是一个可以通过加一条早退规则修好的边界情形（已修，见上）。
- 从传播语义的角度看，这确实是 `effective` 脱离 `min(own, deps)` 通用公式的唯一路径——
  对任何**非**被反驳强制的节点，`eff <= own` 恒成立（`min` 的定义），所以
  `own == eff` 判定自封顶在那些节点上永远不会漏判；这个洞只可能由"反驳推导把目标砸到
  `refuted`"触发，而当前图里这样的节点只有这一张。换句话说，只要图里不再新增第二张
  `refuted` 卡，这个洞就不会再扩大，但只要还有，它就会一直存在，因为它是传播公式本身
  的设计（"反驳覆盖 min 公式"是故意的，不是 bug）。

复现：

```
$ uv run stringgraph status swampland.wgc-sharp-form-i
...
effective: refuted
```

（`stringgraph roots swampland.wgc-sharp-form-i` 返回它自己——空依赖集直接判自身为瓶颈根，
与 `is_self_capped` 的早退逻辑一致。）

## 8. 对项目本身的含义

`docs/VISION.md` 开篇承诺精确回答"某条结论到底建立在多少条猜想之上"。这个分析**反转**了
那个框架的默认预期：如果答案是"建立在少数几个大猜想上"，那么把这几个猜想攻克掉就能大幅
提升全图的严格度上限——但本文测得的现实是，**全图只有 31 张卡是真正的猜想/open**，其中
最大的一张也只钉住 4 张下游卡（第 6.1 节），而**低于 rigorous 的活卡有 383 张**，其中
86.9% 的瓶颈根本不在猜想上，而在"这张卡自己的推导从来没有人写严格"。

换句话说：弦论的严格性缺口，主体不是"压在几块大石头下面"，而是**铺在几百级从未被严格
论证的台阶上**。把 188 个瓶颈根全部形式化，也只能救出 14 张卡（3.7%）——因为剩下 82%+
的问题不在这 188 个根身上，而在每一张卡自己身上。这对"挑选形式化目标"这件事的含义是：
**指望靠攻克几个关键节点带来大范围级联收益，在当前图的结构下基本不成立**；`formal/` 的
目标选择更应该按"这个结果本身的独立价值 + 证明的可行性"来定，而不是按"下游能带飞多少张卡"
来定——第 5 节的厚/薄区域分布进一步说明，薄区域（math/holography/swampland）的卡正是
"独立价值高、级联收益为零"的典型（第 2 节 holography thin zone 反事实 = 0），厚区域
（branes/spectrum/susy/worldsheet）虽然瓶颈根集合大，但因为需要凑齐一整组根才能解锁
（第 3 节 AND 语义），单点攻克同样很难带来级联——第 6.1 节的
`worldsheet.ddf-spanning-rank-inequality` 是目前已知的唯一反例：厚区域（worldsheet）
里存在这样一个节点，形式化它能直接拿下一个里程碑。

## 9. 19 张打平推导卡的逐张核查结果（2026-09-19）

第 1 节的订正块留下一份待查清单：除 `worldsheet.ddf-contour-equals-mode-sum` 外，全图还有
**19 张 active proposition** 的多条推导 effective 打平，其隐藏瓶颈从未被看过。
graph-reviewer 已逐张核查（19/19，无遗漏），lead 对其两条可执行结论做了独立复核。

### 9.1 结论：没有第二例 ddf-contour 模式

ddf-contour 那一例的要害**不是**"有隐藏瓶颈"，而是三件事叠加：被使用的推导自封顶（看上去无解），
隐藏推导 own=rigorous（看上去有解），而真正封顶它的是一张**此前未登记、无源、藏在 `inferred`
边里**的桥接命题——这件事当时在图上、在文档里、在任何 gaps 段落里都不可见。

19 张里**没有一张复现这个组合**。具体分布：

| 类别 | 张数 | 说明 |
|---|---:|---|
| 两条推导 root 完全相同（多为自封顶） | 6 | 完全无遮蔽 |
| root 相同、own 不同（一条 Lean 一条非 Lean） | 2 | 不是遮蔽，只是"这里已有 Lean 版本"被聚合视图吞掉 |
| root 是子集/超集但同一状态层级 | 8 | `roots`/`why` 少讲一条平行路径，无更严重内容 |
| **own 更高且 root 确实不同** | **3** | 唯一值得记录的一类，见 9.2 |

关键区别（也是为什么严重度低得多）：那 3 张的差异**在各自 derivation YAML 的 gaps/notes 里
已经逐字写明了**——
`math.anomaly-twelve-form-factorization--via-lean` 的 gaps 写"有效状态仍是 physical-argument，
瓶颈经 tr-f6-coefficient-vanishing 落到 so-usp-adjoint-fundamental-trace-identities"；
`swampland.wgc-sharp-form-iii--via-form-ii` 的 gaps 写"推导本身严格，但不改变 (III) 的有效状态"；
`math.e8-adjoint-trace-identities--via-root-power-sums` 的 notes 写"工具取最强推导，两条并存"。
⇒ 这是**聚合报告工具看不见**，不是**数据本身把问题藏起来**。性质上比 ddf-contour 轻得多。

另外两条否定结论：**未发现 `inferred: true` 误用**（抽查的关键边全部 `inferred: false` 且有具体来源）；
**19 张无一落在任何里程碑的关键路径上**（5 个里程碑全部围绕无鬼定理/临界维数/DDF 主题）。

### 9.2 实质发现：`math.so-usp-adjoint-fundamental-trace-identities` 是一个此前未列出的 +3 杠杆

reviewer 的两条可执行建议，lead 已用 `roots` + `counterfactual` **独立复核，两条都成立**：

```
$ uv run stringgraph roots math.anomaly-twelve-form-factorization
  [BEST, used above] ...--via-direct-expansion
    roots: math.e8-adjoint-trace-identities, math.so-usp-adjoint-fundamental-trace-identities
  [tied, NOT used above] ...--via-lean
    roots: math.so-usp-adjoint-fundamental-trace-identities
```
⇒ 走 `--via-lean` 这条（own 已是 **formalized**）只需要修好 `so-usp` **一张**，
**不需要**连带修 `e8-adjoint-trace-identities`。聚合视图把这条捷径完全吞掉了。

```
$ uv run stringgraph roots swampland.wgc-sharp-form-iii
  [BEST, used above] ...--via-heterotic-lattice   roots: swampland.wgc-sharp-form-iii（自封顶）
  [tied, NOT used above] ...--via-form-ii          roots: swampland.wgc-sharp-form-ii
```
⇒ (III) 的真实升级路径绑定在 `swampland.wgc-sharp-form-ii`（经一条 own=rigorous 的严格蕴含），
**不是**四份独立启发式证据里最强的那份。

🔴 **lead 补测（reviewer 未做，是本节最实质的一条）**：把这两个根各自单独强制为 rigorous，
真实反事实（强制+重算，非代理频率）给出——

```
$ uv run stringgraph counterfactual math.so-usp-adjoint-fundamental-trace-identities
moved (3 other active cards):
  math.anomaly-twelve-form-factorization: physical-argument -> rigorous
  math.mixed-anomaly-trace-conditions-n32: physical-argument -> rigorous
  math.tr-f6-coefficient-vanishing:        physical-argument -> rigorous
milestones hit (0):

$ uv run stringgraph counterfactual swampland.wgc-sharp-form-ii
moved (1 other active cards):
  swampland.wgc-sharp-form-iii: conjecture -> rigorous
```

**`so-usp` 单卡 +3，是全图已知第二大的单卡杠杆**（仅次于 `ddf-contour-equals-mode-sum` 的 +4
与 `ddf-spanning-rank-inequality` 的 +4，两者都命中里程碑）。它**从未出现在第 2 节的反事实表里**。

⚠ 三点限定，避免这条被读成"便宜的捷径"：
1. **它不命中任何里程碑**（+3 全部落在 `math.*` 反常区）。按第 8 节的框架，它的价值是
   "这三个结果本身值得严格化"，不是"能带动关键路径"。
2. **这 +3 与打平发现无关**——`counterfactual` 是真强制+重算，不走 `bottleneck_roots`，
   所以这条杠杆**一直就在那里**，只是本文第 2 节的表没列它。打平发现补的是另一件事：
   `anomaly-twelve` 的**路由**（走 `--via-lean` 不需要 e8）。
3. `so-usp` 自身 `own_status = effective = physical-argument`、单条推导、无猜想依赖，
   即**自封顶**。它是否**便宜**取决于 so(N)/usp(N) 伴随迹恒等式在 Mathlib 里的可达性
   （`Math/E8Roots.lean` 的 E₈ 侧之所以做得成，是因为 240 个根可以显式列出；
   一般 N 的 so/usp 没有这个便利）。**本节不对成本下结论**，已另派 scout 评估。
   ⇒ **成本裁决已回，见 §9.4。**

### 9.3 reviewer 自报的保留事项（照录，不代为消化）

- 只对 root 有实质差异的 3 张打开了 derivation YAML 全文读 gaps/notes；其余 16 张只看
  `roots`/`status` 输出，未逐一读 YAML 全文。
- **未做来源忠实性审查**（`sources.loc` 是否真对应原文）——本轮范围限定在"隐藏瓶颈"。
- 里程碑相关性判断用的是 grep 字面匹配 + 读 `canonical_text`，**没有**对每张卡跑
  `stringgraph why <里程碑 statement id>` 反向确认它不在瓶颈树里。reviewer 判断
  area 明显不交叉故 grep 足够可靠，但严格说这不是穷尽式验证。

复现：
```bash
uv run stringgraph report            # "tied effective derivations" 段给出这 20 张的清单
uv run stringgraph roots <id>        # 现在会追加打平的其它推导及各自的瓶颈根
uv run stringgraph counterfactual <id>
```

### 9.4 `so-usp` 的成本裁决：MODERATE（2026-09-19，闭合 §9.2 第 3 条）

全文见 **`docs/frontier-scouting/so-usp-adjoint-trace-lean-route.md`**。要点：

- **约 400–700 行 Lean，不是「新造无穷秩根系理论」。** 存在一条自足路线：
  `D := F⊗1 + 1⊗F` 在 `V⊗V` 上二项展开，配 `tr(A⊗B) = tr A·tr B` 与
  `tr((A⊗B)∘swap) = tr(AB)`，投到 `½(1∓swap)` 得
  `Tr(Λ²F)^k = ½[Σ_m C(k,m)tr(F^m)tr(F^{k−m}) ∓ 2^k tr(F^k)]`。
  **组合结构与 N 无关**（`N` 只经 `tr(1)` 进来），故**完全绕开根系与 Chevalley 限制**。
  奇次迹消失在 so 与 usp 两支各由一行转置/共轭技巧给出，⇒ **本路线覆盖 usp(N)**，
  而卡面 note 记的 antonelli-2015 那条恰恰未核实是否覆盖 usp。
- 🔴 **lead 已数值验证 scout 唯一未 derisk 的那一步**（「抽象 Λ² 公式 = 李代数上的
  `Tr(ad F)^k`」这道基匹配桥）：`docs/frontier-scouting/so-usp-adjoint-trace-check.py`，
  精确整数运算，在显式基上组装 `ad(F)` 矩阵直接比较——
  **so(N) N=3..8 与 sp(2n) N=2,4,6,8，k=2,4,6，60 项检查全部精确相等，0 例外。**
  ⇒ 剩下的是纯 Lean 工程量，不是未知数学。（边界：验的是小 `N` 实例，不是一般 `N` 的证明。）
- 🔴 **lead 实测 Mathlib 接口**（该文件 §2.5），**两轮，第二轮推翻了第一轮**：
  `LieAlgebra.Orthogonal.so` / `LieAlgebra.Symplectic.sp`（注意：`Classical` 只是文件名，
  不是命名空间）都是 `LieSubalgebra R (Matrix n n R)`，括号即环 commutator，
  **`ad(F)(X) = F*X − X*F` 经 Lean 探针实测是 `rfl`**。
  lead 第一轮靠 grep 得出「Mathlib 没给 so/sp 基 ⇒ 目标陈述写不出来」并据此上调到 650–1100，
  **该论断已被一个 10 行 `lake env lean` 探针零错误证伪并撤回**：本卡系数含 `½` ⇒ 底环是**域**，
  而域上 `finiteDimensional_submodule` 是 instance、向量空间的 `Module.Free` 自动，
  **两个实例白送，无需造基**。
  ⇒ **估工时回到 scout 原本的 400–700 行**；650–1100 是错的，不要再引用。
  ⚠ **方法论**：lead 本轮正确纠了 scout 一次（下面 E₈ 那条），又**自己犯了同类错误**——
  **对 Lean 的断言要用 Lean 验，不要用 grep 验**；探针成本远低于它挡掉的返工。
- ⚠ **裁决不含派工。** 这 +3 **不命中任何里程碑**，投不投 400–700 行是船长的资源判断。
  若决定投，建议**先派 researcher** 做该文件 §5 最后一条（是否存在覆盖两支的一般 N
  完整证明）——那是清单里唯一能把「自己发明证明」降成「照抄大纲」的一条。
- ⚠ **另一条方法论发现**（详见该文件 §4）：E₈ 那张卡暴露了自封顶的一个**误用**形态——
  把推导的 **own status** 调低去反映**依赖弱**，而非反映该步自身论证的松紧。
  这既重复计账（依赖的弱已由 `min(own, deps)` 传播过一次），又**让 `counterfactual` 失明**
  （实测强制 `math.chevalley-restriction-theorem` 移动 0 张卡，而它确实是真实待办）。
  与 §9.1 的打平盲点**不是同一件事**：打平盲点的解药正是 `counterfactual`，
  本形态把解药也挡住了。**未修**，属 curator + reviewer 领域。
  ⚠ **E₈ 并不是本形态的实例——已由 curator（`e8statusfix`）裁定并合并**：
  lead 的假设（own 镜像弱依赖）与 scout 的假设（Cartan→一般 F 延拓藏在 own 里）**都错**。
  `--via-casimir-structure` 一条陈述依赖都没有，无从镜像；Chevalley 的机制住在它自己那条推导里。
  **真实理由是第三条**：`--via-root-power-sums` 第 (2) 步把 Φ(𝔢₈,𝔥) 认同为 Humphreys 的
  240 元列表，需要 Serre 存在定理 + ADE 唯一性，而**本图没有节点承载这个前提**
  （`math.e8-root-system:28` 逐字「本卡不断言 (b)」，lead 已复核）。
  ⇒ **一般机制的描述仍成立，但要另找实例**；E₈ 的 own 是诚实的。
- ⭐ **本轮最该留下的区分**（该文件 §3.1）：两条路线都"缺一步"，但**缺的种类不同**——
  根系路线缺的是**定理**（Chevalley 限制，Mathlib 没有），做完也只能停在 physical-argument；
  Λ² 路线缺的是**计算**（无特殊轨迹，对任意交换环任意矩阵一致成立），做完能正当升到
  rigorous/formalized。**值得投的理由是后者能升 status，不是它更短。**

## 命令一览

```bash
uv run stringgraph hitting-set                    # 全图规模 + 自封顶 + 贪心覆盖曲线（第 1、3、4、5 节）
uv run stringgraph hitting-set --target 0.5       # 只要 50% 检查点对应的根列表
uv run stringgraph roots <id>                     # 单卡的瓶颈根集合
uv run stringgraph counterfactual <id> [<id> ...] # 强制若干卡为 rigorous，报告解锁的其他卡与命中的里程碑
```

