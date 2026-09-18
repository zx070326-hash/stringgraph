# lead 复核：桥卡 `physical-exponential-equals-voa-vertex-operator` 的指标移位缺陷

- 日期：2026-09-18
- 复核者：lead（主会话），独立读卡 + 读 Lean 源码，未依赖 agent 报告的转述
- 触发：`agent/prover/physical-exponential-equals-lattice-voa` 在写 `claim.md` 过程中报告目标卡断言 (2)
  的字面表述不成立
- 涉及节点：
  - `graph/statements/worldsheet/physical-exponential-equals-voa-vertex-operator.yaml`（下称**桥卡**）
  - `graph/statements/worldsheet/ddf-operators-v6.yaml`（`formalized`）
  - `graph/derivations/worldsheet/physical-exponential-equals-voa-vertex-operator--via-cocycle-triviality.yaml`
  - `formal/StringFormal/NoGhost/DDF.lean :: StringFormal.NoGhost.towerVertex`

---

## 裁定摘要

| # | agent 的断言 | lead 独立裁定 |
|---|---|---|
| 1 | 桥卡断言 (2) 的括注定义 `V^{(n)}_K` 缺了洛朗指标移位，与 `ddf-operators-v6` / Lean 不一致 | **CONFIRMED** |
| 2 | 该卡唯一推导的 summary 内部不自洽（同一个因子既被算成 1 又被用作 `z^n`） | **CONFIRMED（实质成立）**，但 agent 的佐证句有一处错，见下 |
| 3 | 对 `prior-art.md` §3 的理由细化（闭合 cocycle 缺口的是「秩 1 + 偶」，类光性的真正作用在别处） | **未复核**，留待后续；不影响 §3 原结论（它对一般偶格/Leech 完全正确） |

---

## 1. 指标移位（CONFIRMED）

桥卡 `statement:` 里断言 (2) 的括注**逐字**为：

> 其中左端按 z^K-系数约定展开为 Σ_K V^{(n)}_K z^K（V^{(n)}_K = 零模移位 ∘
> worldsheet.exponential-vertex-operator-modes 的 V^{(b)}_K，b = (2α')^{1/2} n k_0）

即 `V^{(n)}_K = S_n ∘ V^{(b)}_K`，**无指标移位**。

而 `formal/StringFormal/NoGhost/DDF.lean` 的定义**逐字**为：

```lean
noncomputable def towerVertex (η b : Fin D → R) (n : ℤ) (K : ℤ) :
    Module.End R (TowerFock D R) :=
  towerShift D R n ∘ₗ towerDiag fun _ => Fock.vertexOsc η (vertexMomentum b n) (K - n)
```

即 `V^{(n)}_K = S_n ∘ V^{(b)}_{K−n}`，**带指标移位**。该文件的文档注释还逐字说明了移位的来历：
"with Laurent index shifted by the monodromy exponent `n` (`z^{2α' n k_0·p} = z^n` under the DDF
normalisation `2α' k_0·p = 1`, which by `dotVec_towerMomentum_right_of_isotropic` is the *same*
integer on every rung)"。`ddf-operators-v6.yaml` 第 149 行与第 216 行两处转抄该定义，**均带移位**。

**结论**：两张卡对同一个符号 `V^{(n)}_K` 给出了两个不同的算子，相差因子 `z^{nν}`（DDF 归一化下
`ν = 2α'k_0·p = 1`，故相差 `z^n`）。对一切 `n ≠ 0` 两者不等。**桥卡的括注是错的，`ddf-operators-v6`
与 Lean 是对的**（后者有机检背书，且移位的物理来历——塔上每一层的单值指数相同——在注释里写清楚了）。

⚠ **这不是本次原创尝试的产物，而是图内一处此前未被发现的活缺陷**，与轨道 (iii) 成败无关。
它此前未被 `validate` 捕获是意料之中的：校验管道查 id 解析、环、约定一致性，**不查两张卡对同一
符号的定义是否一致**——那需要人读。

## 2. 推导 summary 的内部不自洽（CONFIRMED，但 agent 的佐证有一处错）

`--via-cocycle-triviality` 的 summary 在**同一份文本里**先后说了两件互相矛盾的话：

- 第 1 段：`(3.10) 里的 x^{⟨α,β⟩} = x^0 = 1`（因 `⟨α,β⟩ = mn⟨k,k⟩ = 0`）。
- 第 2 段：`x^{⟨α,β⟩} 对应物理侧的单值因子 z^{2α' n k_0·(p+Nk_0)}（由 k_0² = 0 与整性条件 (I) 等于 z^n）`。

同一个因子在第 1 段被算成恒等于 1，在第 2 段被用来匹配一个 `n ≠ 0` 时非平凡的 `z^n`。**两段不能同时为真。**

agent 指出的正确出处是对的：塔上的单值因子来自 `Δ̄(α, ±x)` 里的**零模算子** `x^{α(0)}`——它在
第 `N` 层的本征值是 `⟨α, p + Nk_0⟩ = nν ≠ 0`——而**不是**两个格元之间的常数 `x^{⟨α,β⟩}`。
正因为 `⟨k,k⟩ = 0`，后者才恒为 1，也才不可能承载 `z^n`。

🔴 **但 agent 的佐证句「那条 summary 从未提 `Δ̄`」是错的**：summary 第 2 段逐字写了
"Li–Wang (3.10) 里的 `E^-(−α, x)` 与 `Δ̄(α, ±x)` 正对应物理侧的两半"。`Δ̄` 是被提到的。
真正的缺陷不是"漏提 `Δ̄`"，而是**把单值因子错误地归给了 `x^{⟨α,β⟩}` 而不是 `Δ̄` 里的 `x^{α(0)}`**，
从而与第 1 段自相矛盾。裁定按后者记录。

## 3. 处置（本轮**不**施工，留作下一轮入口）

桥卡的错误括注在 `statement:` 正文内。按 CLAUDE.md 原则 1（陈述是不可变卡片，改陈述文本
等于新建节点并标记 `superseded_by`）与 2026-09-18 的新判例（title 与 statement 同等受原则 1
约束），**不得就地编辑**，必须换代为 `-v2`。这涉及下游边重指（至少
`ddf-contour-equals-mode-sum--via-voa-residue` 一条非 inferred 依赖）与推导 summary 的订正，
是一件完整的 curator 工作，不适合在收官轮匆忙动手。

**下一轮的第一件事**（按此顺序）：
1. 立 `physical-exponential-equals-voa-vertex-operator-v2`，括注改为
   `V^{(n)}_K = S_n ∘ V^{(b)}_{K−nν}`，`ν := 2α'(k_0·p)`；旧卡标 `superseded_by`。
2. 订正 `--via-cocycle-triviality` 的 summary 第 2 段：单值因子的 VOA 出处是 `Δ̄` 里的
   `x^{α(0)}`（本征值 `⟨α, p+Nk_0⟩`），不是 `x^{⟨α,β⟩}`（后者在本设定下恒为 1）。
3. 下游边重指到 v2。
4. ⚠ **状态不变**：修的是记号错误，断言 (2) 的实质缺口（两侧独立构造之间的识别无来源）
   分毫未动，v2 仍是 `physical-argument`，整条无鬼链仍被它压着。**不要因为"修了一个 bug"
   就顺手抬状态。**
