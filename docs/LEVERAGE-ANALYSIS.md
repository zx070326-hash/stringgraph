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

## 命令一览

```bash
uv run stringgraph hitting-set                    # 全图规模 + 自封顶 + 贪心覆盖曲线（第 1、3、4、5 节）
uv run stringgraph hitting-set --target 0.5       # 只要 50% 检查点对应的根列表
uv run stringgraph roots <id>                     # 单卡的瓶颈根集合
uv run stringgraph counterfactual <id> [<id> ...] # 强制若干卡为 rigorous，报告解锁的其他卡与命中的里程碑
```
