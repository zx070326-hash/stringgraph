# 设计蓝图：构造 Λ^∞_* 鬼场 Fock 模，把 c^g = −26 从条件式升为无条件

- 作者：formalizer
- 日期：2026-09-14
- 状态：**设计/可行性分析，不是实现**。文中所有 Lean 代码块都是**草图（未编译）**，仅示意签名与证明骨架，不得当作可 `lake build` 的代码。
- 目标读者：lead（排期决策）、后续接手形式化的 formalizer。
- 关联节点：
  - 陈述 `worldsheet.bc-ghost-central-charge-lambda-two`
  - 推导 `...--via-lean`（status: formalized，lean_decl `StringFormal.NoGhost.Ghost.lie_Lop_Lop`）
  - 推导 `...--via-fgz-ghost-representation`（status: rigorous，FGZ Prop 2.1）
- 关键文件：`formal/StringFormal/NoGhost/Ghost.lean`（条件定理）、`formal/StringFormal/NoGhost/Fock.lean`（玻色侧样板）、`formal/StringFormal/NoGhost/Sugawara.lean`（`lsumLocFin`）。
- 所有 Mathlib API 事实均在 **Mathlib v4.33.1**（`lean-toolchain: leanprover/lean4:v4.33.1`）源码里核对过，见每处标注的文件与行号；**没有一处是猜的**。

---

## 0. TL;DR（给赶时间的 lead）

- **推荐路线**：用 Mathlib 的 `ExteriorAlgebra R V`（= `CliffordAlgebra (0 : QuadraticForm R M)`）作为鬼场 Fock 空间，产生算符 = 楔乘 `LinearMap.mulLeft R (ι R e)`，湮灭算符 = 内乘 `CliffordAlgebra.contractLeft d`。**三条反对易关系（`IsBCSystem`）几乎白拿**——它们分别就是 Mathlib 已证的 `contractLeft_ι_mul`、`ExteriorAlgebra.ι_add_mul_swap`、`contractLeft_comm`。
- **最难的一块**：`IsRestricted`（单边有限性）——需要证「对固定 `v`，除有限多个模式外的 `contractLeft` 都杀掉 `v`」。这要一个"`v` 只支撑在有限多个生成元上"的引理，靠 `CliffordAlgebra.left_induction` 归纳。这是唯一有真实体量的证明。
- **非零**：白拿。`instance [Nontrivial R] : Nontrivial (ExteriorAlgebra R M)`（ExteriorAlgebra/Basic.lean:398），真空 `1 ≠ 0`。
- **图后果**：`--via-fgz-ghost-representation` **不退役**（它承载 FGZ 的具体模与文献来源；本工作是独立第二证据）。本工作把 `--via-lean` 的第一条 gap（"无非零模，M=0 平凡满足"）关掉，届时 BRST 路线成为全图**唯一**端到端机检的 D=26 链。
- **LocFin 重构**：**建议与本工作解绑，先单独做或不做**。它是共享基础改动（会重编 NoGhost 子树），且本工作无论走哪条路线都仍然需要 `lsumLocFin`。不要把它塞进同一个 PR。
- **成本量级**：**中等偏大，约 3–5 个 PR、~600–1000 行 Lean**。风险集中在 `IsRestricted` 的支撑集引理和内乘/楔乘指标簿记。

---

## 1. 缺口的精确陈述，及与玻色侧的对称性

### 1.1 现状

`Ghost.lean` 里的主定理 `lie_Lop_Lop`（Ghost.lean:698）是**条件式**：

```lean
-- 已编译（Ghost.lean:698），此处仅抄签名
theorem lie_Lop_Lop (hbc : IsBCSystem b c) (hres : IsRestricted b c) (m n : ℤ) :
    ⁅Lop hres m, Lop hres n⁆
      = ((m - n : ℤ) : R) • Lop hres (m + n)
        + (if m + n = 0 then algebraMap ℚ R (-26 / 12) * ((m ^ 3 - m : ℤ) : R) else 0)
          • (1 : Module.End R M)
```

设定：`[CommRing R] [Algebra ℚ R]`，任意 `R`-模 `M`，`b c : ℤ → Module.End R M`，前件

- `IsBCSystem b c`：`{b_m,c_n}=δ_{m+n,0}`、`{b_m,b_n}={c_m,c_n}=0`；
- `IsRestricted b c`：`∀ v, ∃ N, ∀ n > N, b_n v = 0 ∧ c_n v = 0`（**单边**，auditor 注记 B 的正确写法）。

**缺口**（`--via-lean` 的 gaps 第 1 条，`bc-ghost-central-charge-lambda-two.yaml` 的 2026-09-14 formalizer 注记）：Lean 里**没有构造任何非零的 bc 受限模**。前件是可满足的，但**唯一被机检过可满足的例子是 `M = 0`**（`b = c = 0` 平凡满足 `IsBCSystem`、`IsRestricted`）。于是主定理严格来说证的是"给定这样一个模则……"，存在"空真"（vacuous）风险：如果 `IsBCSystem + IsRestricted + M≠0` 其实不可满足，定理就没内容。

### 1.2 与玻色侧的对称性——这正是要补齐的对称缺口

玻色侧不是条件式：`Fock.lean` 真的**构造了非零的 Fock 空间** `Fock D R := MvPolynomial (Osc D) R`（Fock.lean:112，`Osc D := Fin D × ℕ+`，Fock.lean:107），真空 = 常数 `1`，产生算符 `creation R μ n = LinearMap.mulLeft R (X (μ,n))`（Fock.lean:173），湮灭算符 `annihilation η μ n = oscWeight η (μ,n) • pderiv (μ,n)`（Fock.lean:193），并在其上放了 `c = D`（`free-boson-central-charge-d--via-lean`，formalized）。玻色侧的中心荷是**在具体非零模上**的定理。

鬼场侧要达到同一地位，缺的就是**费米（Clifford）对应物**：一个非零的 `M`、一对 `b c : ℤ → Module.End R M`，机检它们满足 `IsBCSystem + IsRestricted`，然后把 `lie_Lop_Lop` 实例化上去，得到

> **存在**一个非零 `R`-模与其上的 `(b,c)`，使 `IsBCSystem`、`IsRestricted` 成立且 Virasoro 关系带 `c^g = −26`。

这就是 FGZ 1986 Prop 2.1 里的半无穷楔形 `Λ^∞_*`（PNAS 公告体裁，无印出证明，故文献侧只是 rigorous）。本工作把它形式化，得到独立于 FGZ 的第二条严格证据。

### 1.3 与 Ghost.lean 已定死的 SL(2,C) 正规序的一致性约束（**硬约束**）

构造**必须**与 Ghost.lean 里已经定死的正规序一致，否则 `IsBCSystem` 虽满足、但真空/湮灭清单对不上，`lie_Lop_Lop` 实例化出来的 `c^g` 可能不是 −26（把 χ 换成 1−χ 机检会变成 +26，见 `--via-lean` 的 reviewer 注记）。定死点：

```lean
-- Ghost.lean:60
def chi (p : ℤ) : ℤ := if -1 ≤ p then 1 else 0
-- Ghost.lean:230
def nord (p q : ℤ) : Module.End R M := if p ≤ -2 then b p * c q else -(c q * b p)
```

即 `χ(p) = [p ≥ −1]` 是"`b_p` 是湮灭算符"的指示函数。翻译成真空/产生/湮灭清单：

| 算符 | 湮灭真空当 | 产生算符当 |
|---|---|---|
| `b_p` | `p ≥ −1`（`χ(p)=1`） | `p ≤ −2` |
| `c_q` | `q ≥ 2` | `q ≤ 1` |

鬼场真空 `|0⟩`（SL(2,C) 真空）满足 `b_p|0⟩=0 (p≥−1)`、`c_q|0⟩=0 (q≥2)`。Fock 空间由产生算符 `b_p (p≤−2)` 与 `c_q (q≤1)` 作用在 `|0⟩` 上生成，费米性 ⇒ 每个产生算符至多用一次。**基 = 一对有限子集 `S ⊆ {p:p≤−2}`、`T ⊆ {q:q≤1}`**（选中的 b-产生模与 c-产生模）。

---

## 2. 严格的数学构造（与 chi 一致）

### 2.1 单粒子空间与 bc = CAR 的对应

bc 系统就是 CAR（正则反对易关系）代数。把全部生成元 `{b_m}∪{c_n}` 张成的空间 `W` 配上由反对易子给出的对称双线性型 `B(b_m,c_n)=δ_{m+n,0}`、`B(b,b)=B(c,c)=0`（一个分裂/双曲型），bc 系统 = `Cl(W,B)`。Fock 表示 = 选一个极大迷向子空间（极化 = 湮灭算符张成的 Lagrangian）后的旋量/Fock 模。

**极化**：湮灭算符 = `{b_p:p≥−1}∪{c_q:q≥2}`（SL(2,C) 序，见 §1.3）；产生算符 = `{b_p:p≤−2}∪{c_q:q≤1}`。Fock 模 = 产生空间的外代数 `Λ(创生空间)`。

**单粒子（创生）空间** `V`：两族基向量

- B 族：`{β_m : m ≤ −2}`，产生算符 `b_m` = 楔乘 `β_m`；
- C 族：`{γ_q : q ≤ 1}`，产生算符 `c_q` = 楔乘 `γ_q`。

湮灭算符 = 对偶基上的内乘（缩并）：

- `b_p (p ≥ −1)` = 内乘 `γ*_{-p}`（因 `{b_p,c_n}=δ_{p+n,0}` ⇒ `b_p` 去掉 `γ_{-p}` 因子；`-p ≤ 1` 故 `γ_{-p}` 是合法 C 族生成元）；
- `c_q (q ≥ 2)` = 内乘 `β*_{-q}`（`-q ≤ −2` 故 `β_{-q}` 合法）。

### 2.2 反对易关系逐条验证（数学层面，先不管 Lean）

用 CAR 事实：楔乘 `e∧` 与内乘 `ι_d`（对偶 `d`）满足 `{ι_d, e∧} = d(e)·id`，`{e∧,e'∧}=0`，`{ι_d, ι_{d'}}=0`。

- `{b_m,b_n}=0`：
  - 两个都是产生（楔）→ `{β_m∧, β_n∧}=0` ✓；
  - 两个都是湮灭（内乘）→ `{ι_{γ*_{-m}}, ι_{γ*_{-n}}}=0` ✓；
  - 一产生一湮灭（`m≤−2` 楔 `β_m`，`n≥−1` 内乘 `γ*_{-n}`）→ `{β_m∧, ι_{γ*_{-n}}} = γ*_{-n}(β_m) = 0`（β 与 γ 异族）✓。
- `{c_m,c_n}=0`：同理 ✓。
- `{b_m,c_n}=δ_{m+n,0}`：
  - 都产生（`m≤−2` 楔 β，`n≤1` 楔 γ）：`{β_m∧,γ_n∧}=0`；且 `m+n=0` 要 `n=−m≥2` 与 `n≤1` 矛盾，δ=0 ✓；
  - 都湮灭（`m≥−1`,`n≥2`）：内乘反对易 =0；`m+n≥1>0` 故 δ=0 ✓；
  - `b_m` 产生（`m≤−2`，楔 `β_m`）、`c_n` 湮灭（`n≥2`，内乘 `β*_{-n}`）：`{β_m∧, ι_{β*_{-n}}} = β*_{-n}(β_m) = [m=−n] = δ_{m+n,0}` ✓；
  - `b_m` 湮灭（`m≥−1`，内乘 `γ*_{-m}`）、`c_n` 产生（`n≤1`，楔 `γ_n`）：`{ι_{γ*_{-m}}, γ_n∧} = γ*_{-m}(γ_n) = [−m=n] = δ_{m+n,0}` ✓。

**结论：外代数 + 楔乘/内乘的构造精确实现 bc 系统，且与 §1.3 的 SL(2,C) 序一致。** 费米 Koszul 符号被 Mathlib 的内乘定义自动处理（`contractLeft` 是 degree −1 的分次导子）。

### 2.3 真空与 `IsRestricted` 的数学理由

真空 = `1 ∈ Λ(V)`。任何 `v ∈ Λ(V)` 是有限多个楔单项式的有限线性组合，故只涉及有限多个生成元指标；记这个有限指标集为 `F(v)`。对充分大的 `n`，`b_n`、`c_n` 都是湮灭算符（内乘），且它们内乘的方向 `γ*_{-n}`、`β*_{-n}` 对应的生成元 `γ_{-n}`、`β_{-n}` 不在 `F(v)` 里 ⇒ 内乘杀掉 `v`。故 `IsRestricted` 成立，`N(v)` 由 `F(v)` 里指标的界给出。**这是单边条件（只需大 `n`），与 auditor 注记 B 一致。**

---

## 3. 两条 Lean 建模路线的对比与推荐

### 路线 (a)：占据函数式自由模（照抄 Fock.lean 的味道）

Fock 空间取 `FermFock R := (Finset BCcre) →₀ R`，其中 `BCcre` 是产生模指标的无交并（`{p:p≤−2}` 的 b-产生 ⊔ `{q:q≤1}` 的 c-产生），并在 `BCcre` 上固定一个线性序。基元 = 一个有限子集 `S`（选中的产生模），系数在 `R`。楔乘/内乘**手写**，带显式 Koszul 符号 `(−1)^{插入点之前的元素个数}`。

- 优点：`IsRestricted` **平凡**（`v` 的支撑是有限多个有限子集，涉及的模式有限，`N(v)` 直接读出）；非零平凡（真空 `Finsupp.single ∅ 1 ≠ 0`）；与 `lsumLocFin` 的对接自然（`b : M → Finset ι` 直接由支撑给出）。
- 缺点：**三条反对易关系全靠手写符号簿记证明**——经典的 Koszul 符号组合地狱。`{b_m,c_n}=δ` 的插入/删除符号对齐是这条路线的全部难度所在，且极易在符号上翻车（正是 `--via-lean` 的 reviewer 提醒"χ↔1−χ 会翻成 +26"的同类风险）。玻色侧没有这个问题（玻色是对称的，`MvPolynomial` + `pderiv` 白拿对易关系），费米侧没有等价的现成设施。

### 路线 (b)：Mathlib `ExteriorAlgebra` + `contractLeft`（**推荐**）

**已核实的 Mathlib v4.33.1 事实**（逐条给出文件:行号）：

- `ExteriorAlgebra R M := CliffordAlgebra (0 : QuadraticForm R M)`（ExteriorAlgebra/Basic.lean:60）；`ι R : M →ₗ[R] ExteriorAlgebra R M`（同上:69）。
- 楔乘做产生：`LinearMap.mulLeft R (a : A) : A →ₗ[R] A`，`mulLeft_apply : mulLeft R a b = a*b`（Algebra/Module/LinearMap/Defs.lean:1024、1029）——**正是 `Fock.lean:175` 用的同一个构造**。
- 内乘做湮灭：`CliffordAlgebra.contractLeft : Module.Dual R M →ₗ[R] CliffordAlgebra Q →ₗ[R] CliffordAlgebra Q`（CliffordAlgebra/Contraction.lean:84）。`Module.Dual R M = M →ₗ[R] R`。
- **CAR 关系白拿**（三条前件几乎直接对应 Mathlib 已证引理）：
  - `CliffordAlgebra.contractLeft_ι_mul (a : M) (b) : d⌋(ι Q a * b) = d a • b − ι Q a * (d⌋b)`（Contraction.lean:125）。移项即 `contractLeft d ∘ mulLeft (ι a) + mulLeft (ι a) ∘ contractLeft d = (d a) • id`，就是 `{湮灭, 产生} = d(产生方向)`。→ 给 `{b_m,c_n}=δ` 的混合情形。
  - `ExteriorAlgebra.ι_add_mul_swap (x y : M) : ι R x * ι R y + ι R y * ι R x = 0`（ExteriorAlgebra/Basic.lean:247）。→ 给 `{产生,产生}=0`。
  - `CliffordAlgebra.contractLeft_comm (x) : d⌋(d'⌋x) = −(d'⌋(d⌋x))`（Contraction.lean:200）。→ 给 `{湮灭,湮灭}=0`。
  - 注：以上对一般 `Q` 成立，对 `Q=0`（外代数）里 `Q v • fx` 项自动为 0（`contractLeftAux_contractLeftAux`，Contraction.lean:70–72）。
- **非零白拿**：`instance [Nontrivial R] : Nontrivial (ExteriorAlgebra R M)`（ExteriorAlgebra/Basic.lean:398）。真空 `1 ≠ 0`。
- **对偶基现成**：`Finsupp.basisSingleOne : Basis ι R (ι →₀ R)`（Finsupp/VectorSpace.lean:121），`Basis.coord i : M →ₗ[R] R`（Basis/Defs.lean:670）。取 `V := BCcre →₀ R`，则 `β*/γ*` = `(Finsupp.basisSingleOne).coord i`，正好是 `Module.Dual`。
- **归纳原理现成**：`CliffordAlgebra.left_induction`（CliffordAlgebra/Fold.lean:148）、`CliffordAlgebra.induction`（Basic.lean:201），用于支撑集引理。

- 优点：**三条 `IsBCSystem` 关系几乎白拿**（见 §4），费米符号由 Mathlib 内乘定义托管，避免手写 Koszul。非零白拿。这是决定性优势——费米符号是路线 (a) 的死穴，而 (b) 把它外包给了 Mathlib 已验证的代码。
- 缺点：**`IsRestricted` 需要一个支撑集引理**（"`v` 只支撑在有限多个生成元上，故大 `n` 的内乘杀 `v`"）——这是唯一有真实体量的证明，需 `left_induction` 归纳（见 §4.2）。

### 推荐

**走路线 (b)（Mathlib ExteriorAlgebra + contractLeft）。** 理由一句话：费米反对易符号是整个工作最危险的地方，路线 (b) 把它外包给 Mathlib 已证的 `contractLeft_ι_mul`/`ι_add_mul_swap`/`contractLeft_comm`，只把体量集中到一个可控的 `IsRestricted` 支撑集引理上；路线 (a) 反过来，把风险集中在最危险的符号簿记上。

---

## 4. 验证 `IsBCSystem` + `IsRestricted` + 非零；最难的引理

### 4.0 单粒子空间与算符定义（草图，未编译）

```lean
-- 草图，未编译 —— 仅示意
-- 产生模指标：b 侧 p ≤ -2，c 侧 q ≤ 1
inductive BCcre where
  | bcre (p : ℤ) (h : p ≤ -2)    -- β_p，产生 b_p
  | ccre (q : ℤ) (h : q ≤ 1)     -- γ_q，产生 c_q

abbrev GV (R) [CommRing R] := BCcre →₀ R          -- 单粒子创生空间
abbrev GFock (R) [CommRing R] := ExteriorAlgebra R (GV R)   -- 鬼场 Fock 空间

noncomputable def bGen (R) [CommRing R] (p : ℤ) (h : p ≤ -2) : GV R :=
  Finsupp.single (BCcre.bcre p h) 1
noncomputable def cGen (R) [CommRing R] (q : ℤ) (h : q ≤ 1) : GV R :=
  Finsupp.single (BCcre.ccre q h) 1
-- 对偶：Finsupp.basisSingleOne.coord (BCcre.bcre ..) 等

open CliffordAlgebra in
noncomputable def bOp (R) [CommRing R] (m : ℤ) : Module.End R (GFock R) :=
  if h : m ≤ -2 then LinearMap.mulLeft R (ExteriorAlgebra.ι R (bGen R m h))
  else contractLeft (Finsupp.basisSingleOne.coord (BCcre.ccre (-m) (by omega)))
  -- m ≥ -1 ⇒ -m ≤ 1 ⇒ γ_{-m} 合法；内乘去掉 γ_{-m}

open CliffordAlgebra in
noncomputable def cOp (R) [CommRing R] (q : ℤ) : Module.End R (GFock R) :=
  if h : q ≤ 1 then LinearMap.mulLeft R (ExteriorAlgebra.ι R (cGen R q h))
  else contractLeft (Finsupp.basisSingleOne.coord (BCcre.bcre (-q) (by omega)))
  -- q ≥ 2 ⇒ -q ≤ -2 ⇒ β_{-q} 合法
```

（`omega` 在 `if` 的 `else` 分支里能拿到 `¬ m ≤ -2` 即 `m ≥ -1`，推出 `-m ≤ 1`；`dite` 依赖类型是让 `h` 可用的关键。索引的边界证明是簿记但不难。）

### 4.1 `IsBCSystem`（几乎白拿，但要分情形）

对 `{b_m,c_n}=δ_{m+n,0}` 要按 `(m≤−2?, n≤1?)` 四象限展开（§2.2 的四种情形），每种情形化简到一条 Mathlib 引理：

```lean
-- 草图，未编译
theorem isBC : IsBCSystem (bOp R) (cOp R) where
  anticomm_bc m n := by
    -- 四象限：dsimp bOp/cOp 的 dite，按 m≤-2 与 n≤1 分情形
    -- 产生×湮灭：LinearMap.ext + contractLeft_ι_mul，配对方向的 coord 求值给 δ
    -- 湮灭×湮灭 / 产生×产生：coord 求值给 0，且 m+n≠0
    sorry
  anticomm_bb m n := by
    -- 楔×楔：ι_add_mul_swap；内乘×内乘：contractLeft_comm；混合：异族 coord=0
    sorry
  anticomm_cc m n := by sorry
```

难点不在数学而在**把 Mathlib 的 `contractLeft_ι_mul`（它是关于 `d⌋(ι a * b)` 的等式，即 `contractLeft d (mulLeft (ι a) x)`）与我们要的算符复合 `bOp*cOp + cOp*bOp = ...` 对齐**。因为 `IsBCSystem.anticomm_bc` 写成 `b m * c n + c n * b m = if m+n=0 then 1 else 0`（`Module.End` 的乘法 = 复合），而 `contractLeft_ι_mul` 给的是逐点 `x` 的等式。要 `LinearMap.ext fun x =>` 展开成逐点，再用 `Module.End.mul_apply`。这是纯技术活，无数学风险。**关键正确性检查**：`coord (BCcre.ccre (-m) _) (bGen ..)` 与 `coord (BCcre.bcre (-n) _) (cGen ..)` 的求值必须给出 `if m+n=0 then 1 else 0`——用 `Finsupp.basisSingleOne` + `Basis.coord_apply` + `Finsupp.single_apply` 化简，`BCcre` 的构造子相等 ⇔ 指标相等 ⇔ `m+n=0`。

### 4.2 `IsRestricted`（**最难，唯一有体量的证明**）

要证：`∀ v : GFock R, ∃ N, ∀ n, N < n → bOp R n v = 0 ∧ cOp R n v = 0`。

对大 `n`（`n ≥ 某界`），`bOp n = contractLeft (coord (ccre (-n) _))`、`cOp n = contractLeft (coord (bcre (-n) _))`。所以只需一条**支撑集引理**：

> **引理（cre-support）**：对任意 `v : ExteriorAlgebra R (GV R)`，存在有限集 `F : Finset BCcre`，使得对任意 `i ∉ F`，`contractLeft (Finsupp.basisSingleOne.coord i) v = 0`。

证明骨架（`CliffordAlgebra.left_induction`，Fold.lean:148）：

```lean
-- 草图，未编译
theorem contractLeft_coord_eq_zero_of_large (v : ExteriorAlgebra R (GV R)) :
    ∃ F : Finset BCcre, ∀ i ∉ F,
      CliffordAlgebra.contractLeft (Finsupp.basisSingleOne.coord i) v = 0 := by
  induction v using CliffordAlgebra.left_induction with
  | algebraMap r =>
      -- contractLeft d (algebraMap r) = 0（contractLeft_algebraMap, Contraction.lean:168）
      exact ⟨∅, by simp [CliffordAlgebra.contractLeft_algebraMap]⟩
  | add x y hx hy =>
      -- 取 F = Fx ∪ Fy
      obtain ⟨Fx, hFx⟩ := hx; obtain ⟨Fy, hFy⟩ := hy
      exact ⟨Fx ∪ Fy, by intro i hi; simp_all [Finset.not_mem_union] ⟩ -- map_add
  | ι_mul a x hx =>
      -- a : GV R = BCcre →₀ R，其支撑 a.support 有限
      -- contractLeft d (ι a * x) = d a • x − ι a * (contractLeft d x)  (contractLeft_ι_mul)
      -- 取 F = a.support ∪ Fx；i ∉ F ⇒ d=coord i 在 a 上为 0（i ∉ a.support）
      --   且 contractLeft (coord i) x = 0（i ∉ Fx）⇒ 两项皆 0
      obtain ⟨Fx, hFx⟩ := hx
      refine ⟨a.support ∪ Fx, ?_⟩
      intro i hi
      rw [Finset.not_mem_union] at hi
      rw [CliffordAlgebra.contractLeft_ι_mul, hFx i hi.2, mul_zero, sub_zero]
      -- coord i a = 0 因为 i ∉ a.support
      have : Finsupp.basisSingleOne.coord i a = 0 := by
        simp [Basis.coord_apply, Finsupp.basisSingleOne, Finsupp.not_mem_support_iff.mp hi.1]
      rw [this, zero_smul]
```

有了 cre-support 引理，`IsRestricted` 的 `N(v)`：由 `F(v)` 里所有 `bcre p`/`ccre q` 的指标取一个界。对 `n` 大于该界，`-n` 对应的生成元 `ccre(-n)`、`bcre(-n)` 不在 `F(v)` ⇒ 两个 `contractLeft` 都杀 `v`。**注意**：还要保证"大 `n` 时 `bOp n`、`cOp n` 确实走 `else`（湮灭）分支"——`n > N ≥ 0 > −2` 保证 `bOp n` 走内乘、`n ≥ 2` 保证 `cOp n` 走内乘，`omega` 关掉。

这条引理的体量：中等。`left_induction` 三分支，`ι_mul` 分支要用 `contractLeft_ι_mul` + `Finsupp.support` 簿记。**这是整个工作的重心。**

### 4.3 非零

```lean
-- 草图，未编译
instance [Nontrivial R] : Nontrivial (GFock R) := inferInstance  -- 来自 ExteriorAlgebra/Basic.lean:398
-- 真空 (1 : GFock R) ≠ 0；更强的"表示非平凡"可选：产生算符作用真空得非零，或 bOp/cOp 非零
```

真空 `1 ≠ 0` 已足够关掉"M=0 空真"缺口。**可选加强**（推荐加，让审查更信服）：证 `bOp R (-2) (1 : GFock R) = ι R (bGen ..) ≠ 0`，即产生算符在真空上确实造出非零态——这体现"表示非平凡"，不只是"模非零"。

### 最难的一两条引理小结

1. **`contractLeft_coord_eq_zero_of_large`（cre-support 引理，§4.2）** —— 唯一有真实证明体量的东西，`left_induction` + Finsupp 支撑簿记。
2. **`isBC` 的 `anticomm_bc` 四象限对齐（§4.1）** —— 数学白拿，但把 `contractLeft_ι_mul` 的逐点等式对齐到 `Module.End` 复合、并让 `coord` 求值给出 `δ_{m+n,0}`，是密集的技术簿记，符号方向易错。

---

## 5. 实例化 `lie_Lop_Lop` 与图上的挂接

### 5.1 实例化

`lie_Lop_Lop` 的前件是 `IsBCSystem b c`（`isBC`）与 `IsRestricted b c`（§4.2）。设 `R := ℚ`（或任意 `[CommRing R] [Algebra ℚ R] [Nontrivial R]`）：

```lean
-- 草图，未编译 —— 最终定理
open StringFormal.NoGhost.Ghost in
theorem exists_ghost_rep_central_charge_neg26 :
    ∃ (M : Type) (_ : AddCommGroup M) (_ : Module ℚ M) (_ : Nontrivial M)
      (b c : ℤ → Module.End ℚ M) (hbc : IsBCSystem b c) (hres : IsRestricted b c),
      ∀ m n : ℤ, ⁅Lop hres m, Lop hres n⁆
        = ((m - n : ℤ) : ℚ) • Lop hres (m + n)
          + (if m + n = 0 then algebraMap ℚ ℚ (-26/12) * ((m^3 - m : ℤ) : ℚ) else 0)
            • (1 : Module.End ℚ M) := by
  refine ⟨GFock ℚ, _, _, inferInstance, bOp ℚ, cOp ℚ, isBC, isRestricted, ?_⟩
  intro m n; exact lie_Lop_Lop isBC isRestricted m n
```

这就把条件定理喂进具体非零模，得到**无条件的存在性**：确有一个非零鬼场表示带 `c^g = −26`。

放哪：新文件 `StringFormal/NoGhost/GhostFock.lean`（`import StringFormal.NoGhost.Ghost`），命名空间 `StringFormal.NoGhost.Ghost`（或子命名空间 `.Fock`）。**不改 Ghost.lean 本体**（它是已 formalized 的共享定理，改它要通知 lead）。

### 5.2 公理检查

对 `exists_ghost_rep_central_charge_neg26`、`isBC`、`isRestricted`、`contractLeft_coord_eq_zero_of_large` 跑 `#print axioms`，须只出 `[propext, Classical.choice, Quot.sound]`。风险点：`ExteriorAlgebra`/`CliffordAlgebra` 的 `Quot.sound`（商代数，预期出现，允许）；不应引入其他公理。`BCcre` 用 `inductive` + 结构化证明，无 `Classical` 之外的东西。

### 5.3 图上的挂接（**关键：`--via-fgz` 不退役**）

- **`--via-fgz-ghost-representation` 不退役。** 它承载的是 FGZ 的**具体构造** `Λ^∞_*` 与文献来源（PNAS Prop 2.1），status rigorous。本工作是**独立的第二条证据**：我们自己在 Lean 里从头造了一个（数学上等价的）非零鬼场表示，不引用 FGZ。两者覆盖对象不同（FGZ 是 `Λ^∞_*` 半无穷楔形；我们是 `ExteriorAlgebra ℚ (BCcre →₀ ℚ)`，同构但独立构造），应并存。
- **新建一条推导 `--via-lean-fock`（或把本存在性并入 `--via-lean` 的更新）**，指向 `worldsheet.bc-ghost-central-charge-lambda-two`，status `formalized`，lean_decl `exists_ghost_rep_central_charge_neg26`，depends_on 现有 `--via-lean` 的机检定理。**倾向新建独立推导**，因为它证的是不同的东西（存在非零模 vs 条件式），符合"陈述/推导分离"。
- **更新 `--via-lean` 的 gaps 第 1 条**：从"Lean 里没有构造任何非零 bc 受限模"改为"已构造 `GFock`（外代数），非平凡可满足性已机检；见 `--via-lean-fock`"。
- **陈述卡 `bc-ghost-central-charge-lambda-two` 的 notes** 追加一条 formalizer 注记（statement 正文一字不动）：记录非零模已形式化。
- 跑 `uv run stringgraph validate` + `uv run stringgraph check-axioms`（后者需先 `lake build`）。
- **这一步的图论意义**：BRST 路线（`critical-dimension-brst-v2` 依赖本卡）届时成为全图**唯一**端到端机检、且底层模非平凡的 D=26 链——玻色侧 `c=D` 与费米侧 `c^g=−26` 都坐在具体非零模上。

**注意**：本工作**不**改变 `--via-fgz` 的 gap（FGZ 无印出证明仍然成立，那是文献体裁问题，不是我们能补的），也**不**触及一般 λ 公式、态-算子同构、能级序等（见 `--via-lean` gaps 第 4、5 条）。它只关"非零模存在性"这一个缺口。

---

## 6. 与 `lsumLocFin` / LocFin 重构的关系

### 现状

`Lop`（Ghost.lean:329）用 `lsumLocFin`（Sugawara.lean:128，命名空间 `StringFormal.NoGhost`，非 `.Fock`）实现无穷模式和的局部有限化。Ghost.lean `import StringFormal.NoGhost.Sugawara` 的**唯一**用途就是取 `lsumLocFin`/`lsumLocFin_apply`（Ghost.lean:32–33、330、337）。这使 Ghost.lean 形式上依赖玻色岛（Sugawara → Fock → MvPolynomial）。

### 本工作是否需要它？

**需要，无论走哪条路线**。§5.1 的 `Lop hres m` 就是 `lsumLocFin`。本工作实例化 `Lop`，因此依然经 Ghost.lean 间接依赖 `lsumLocFin`。本工作**不改变** `lsumLocFin` 的用法。

### 是否与本工作打包？

**不打包。建议解绑，单独排期或暂不做。** 理由：

1. **正交**：LocFin 重构是"把 `lsumLocFin`/`lsumLocFin_apply`/`sum_apply_congr_of_eq_zero` 抽到 `StringFormal/NoGhost/LocFin.lean`（命名空间不变，声明名不变）"，纯粹是解耦 Ghost.lean 与玻色岛的依赖，与"造非零模"没有逻辑关系。
2. **共享基础改动、要 lead 排期**：`lsumLocFin` 在 `StringFormal.NoGhost`，Sugawara.lean 被 Ghost、LightConeResolution、PhysicalStates、VertexOperator 四个文件 import。把定义搬走后 Sugawara.lean 源码变动 ⇒ 传递重编整个 NoGhost 子树（`--via-lean` gaps 第 6 条已明记"会触发整个 NoGhost 树重编，属共享基础改动，需 lead 排期"）。把它塞进本 PR 会让本 PR 的编译面和风险面无谓地放大。
3. **本工作反而先加深了对 Sugawara 的依赖**（`exists_...` 经 Ghost 用 `lsumLocFin`）。若将来做 LocFin 重构，届时把 Ghost.lean 与新 `GhostFock.lean` 的 import 一起从 `Sugawara` 改到 `LocFin` 即可，是干净的后续。

**结论给 lead**：LocFin 重构单独立一个 TODO 项、单独一个 PR，且它本身不阻塞本工作。若要做，建议顺序是"先本工作（造非零模），后 LocFin 重构"，或两者独立并行（它们只在 import 行相遇，冲突面极小）。

---

## 7. 成本估计与 PR 拆分

### 成本量级

**中等偏大**：约 **3–5 个 PR、~600–1000 行 Lean**（含注释与草图转正）。绝大部分体量在 §4.1 的四象限簿记与 §4.2 的支撑集引理；`lie_Lop_Lop` 本身白拿（已编译）。

### 建议 PR 拆分（一 PR 一 TODO 项，每个都能独立 `lake build` + `check-axioms` 通过）

1. **PR-1：单粒子空间与算符定义 + `IsBCSystem`。** 新文件 `GhostFock.lean`，定义 `BCcre`/`GV`/`GFock`/`bOp`/`cOp`，证 `isBC`（四象限）。这是最容易翻符号车的一步，先独立过 `#print axioms`。**风险点**：`contractLeft_ι_mul` 逐点等式↔`Module.End` 复合的对齐；`coord` 求值给 `δ`；`dite` 分支里索引边界的 `omega`。
2. **PR-2：`IsRestricted` + 支撑集引理。** 证 `contractLeft_coord_eq_zero_of_large`（`left_induction`），再导出 `isRestricted`。**风险点**：`left_induction` 的 `ι_mul` 分支的 Finsupp 支撑簿记；"大 n 走 else 分支"的边界。
3. **PR-3：实例化 + 非零 + 图挂接。** 证 `exists_ghost_rep_central_charge_neg26`，加 `Nontrivial` 与可选的"产生算符造非零态"，跑 `#print axioms`；新建/更新推导 YAML，`validate` + `check-axioms`。
4. **（可选）PR-4：LocFin 重构** —— 仅在 lead 排期后，与本工作解绑（见 §6）。

### 主要风险点汇总

- **符号（Koszul/χ）翻车** → 走路线 (b) 已把符号外包给 Mathlib，最大程度降低此风险；但 `bOp`/`cOp` 的产生/湮灭分支与 `-m`/`-q` 的对应必须与 §1.3 表逐字一致，否则 `lie_Lop_Lop` 实例化出来可能不是 −26。**建议 PR-1 里加一条 sanity check**（如 `bOp`/`cOp` 在真空上的作用、或某个小 `m` 的 `anticomm_bc` 用 `decide`/显式化简复核），对齐 §1.3 表。
- **支撑集引理体量** → PR-2 独立成 PR，留足预算。
- **`Module.Dual` 与 `Basis.coord` 的 `Finsupp` 化简** → `Basis.coord_apply` + `Finsupp.basisSingleOne` 的 `simp` 引理链需要摸熟，可能要手动 `Finsupp.single_apply` 展开。
- **`check-axioms`** → `ExteriorAlgebra`/`CliffordAlgebra` 走商代数，`Quot.sound` 预期出现（允许）；确认无其他公理泄漏。

### 判断（写进图节点的建议）

- **数学上没有额外假设**：路线 (b) 的构造对任意 `[CommRing R] [Nontrivial R]` 给出非零 bc 受限模；`c^g=−26` 那一步仍只需 `[Algebra ℚ R]`（除 12），与 `lie_Lop_Lop` 一致。不需要 `CharZero`、不需要整环、`M` 上无内积/正定性假设。
- **`--via-fgz` 与本工作是两条独立证据，应并存**（一条文献 rigorous、一条机检 formalized，覆盖不同对象）。这条判断应写进 `--via-lean-fock` 的 notes 与 `--via-fgz` 的 notes 互指。
