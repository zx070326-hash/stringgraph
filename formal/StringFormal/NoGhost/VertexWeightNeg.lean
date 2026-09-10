/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/

import StringFormal.NoGhost.VertexWeight

/-!
# 顶点算子的共形权：`m < 0` 的一半

对应图节点：`worldsheet.ddf-operators`（`formal/TODO.md` 项 `ddf-operators` 的 (3f)）。
约定与 `NoGhost/VertexWeight.lean`、`NoGhost/Sugawara.lean` 相同。

`VertexWeight.lean` 证了共形权恒等式的 `m ≥ 1` 一半。那里能归约到真空，靠的是
`m ≥ 1` 时 `L_m^{(a)} |k⟩ = 0`（`Fock.Lop_apply_one_of_pos`）。`m < 0` 时这条不成立：
`L_m^{(a)} |k⟩` 是一个真正含产生算子的向量，于是真空上的等式形如

`L_m^{(a+b)} Φ_J = c(m, J) · Φ_{J-m} + V_J (L_m^{(a)} |k⟩)`，

右边第二项不是 `Φ_*` 的标量倍。本文件的目标就是把这一项算清楚。

## 本文件已证

（本轮逐条填写；未完成的定理不写陈述。）

## 尚缺

* `lie_Lop_vertexOsc_of_neg` —— 一般态上的 `m < 0` 恒等式。
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

end Fock

end StringFormal.NoGhost
