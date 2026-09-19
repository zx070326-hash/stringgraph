# Φ₁₀ 重数订正：v1 保留决策记录

**curator**：graph-curator，2026-09-20
**任务**：按 physics-auditor 的判据（`docs/reviews/phi10-multiplicity-normalization-2026-09-20.md` §2）
为 9 个"可以暂留 v1"的文件添加 notes，明确说明为何不重定向到 v2。

## 判据摘要（来自审计报告）

该引用的论证是否**实际用到**了"重数=1 还是=2"这一具体数值？
- **否**（只用 Φ₁₀ 的存在性/模性/偶权/Fourier 展开等与重数无关的性质）→ 留在 v1
- **是**（真正消费重数/极点阶数）→ 必须重定向到 v2

## 处理清单（9 个留在 v1）

| 文件 | 消费的性质 | 决策 |
|---|---|---|
| `graph/statements/holography/torsion-index-divisor-operator.yaml` | 𝒢:=−1/Φ₁₀ 的定义，只用 Φ₁₀ 存在与 Fourier 结构 | 留 v1 |
| `graph/derivations/holography/attractor-contour-covariance--via-adjoint-covariance.yaml` | 周期性 F(Ω+S)=F(Ω) 来自 Fourier 展开只含半整 T，与重数无关 | 留 v1 |
| `graph/derivations/holography/dgm-torsion-divisor-sum--via-dgm-duality-argument.yaml` | 重标 ρ→s²ρ,v→sv 合法性依赖 Sp(4,ℤ) 模性，非重数 | 留 v1 |
| `graph/derivations/holography/dstar-sduality-invariant--via-contour-covariance.yaml` | GL(2,ℤ) 不变性依赖 Sp(4,ℤ) 模性 + 偶权，非重数 | 留 v1 |
| `graph/derivations/holography/mock-jacobi-coefficient-positivity--via-bringmann-murthy-rossello.yaml` | 推广步依赖 Sp(4,ℤ) 权 10 + 偶权，非重数 | 留 v1 |
| `graph/derivations/holography/dmz-mock-jacobi-decomposition--via-dmz-theorem.yaml` | 极点结构仅指极点在有理格点，DMZ 定理假设阶数≤2（已容纳二重） | 留 v1 |
| `graph/statements/holography/dmz-mock-jacobi-decomposition.yaml` | 同上；statement 已写"阶数 ≤ 2"，与二重极点相容 | 留 v1 |
| `graph/statements/holography/dvv-dyon-index-generating-function.yaml` | DVV 识别①，只用 1/Φ₁₀ Fourier 展开存在性，不涉及重数 | 留 v1 |
| `graph/derivations/holography/dvv-dyon-index-generating-function--via-dvv-proposal.yaml` | 同上 | 留 v1 |

## 执行记录

为每个文件在 `notes` 字段开头添加一段：

```yaml
notes: |
  【2026-09-20 Φ₁₀ 重数订正：本边刻意留在 v1，不重定向】
  本<推导|陈述>依赖 holography.igusa-cusp-form-phi10（v1）而不是 v2 的理由：<具体消费的性质>，
  完全不依赖零点重数的具体数值（重数=1 还是=2）。v1 卡关于<该性质>的断言是正确的
  （订正只涉及重数那一句），故本边留在 v1 是逻辑正确的选择。
  详见 docs/reviews/phi10-multiplicity-normalization-2026-09-20.md §2（9 个可留 v1 的判据）。

  <原有 notes 内容>
```

### 已完成（9/9）

1. ✓ `graph/derivations/holography/attractor-contour-covariance--via-adjoint-covariance.yaml` (commit c522236)
2. ✓ `graph/derivations/holography/dgm-torsion-divisor-sum--via-dgm-duality-argument.yaml` (commit 71fd15b)
3. ✓ `graph/derivations/holography/dmz-mock-jacobi-decomposition--via-dmz-theorem.yaml` (commit 0221d1b)
4. ✓ `graph/derivations/holography/dstar-sduality-invariant--via-contour-covariance.yaml` (commit e7ab9d2)
5. ✓ `graph/derivations/holography/dvv-dyon-index-generating-function--via-dvv-proposal.yaml` (commit 679b660)
6. ✓ `graph/derivations/holography/mock-jacobi-coefficient-positivity--via-bringmann-murthy-rossello.yaml` (commit 0c28b26)
7. ✓ `graph/statements/holography/dmz-mock-jacobi-decomposition.yaml` (commit 60d8530)
8. ✓ `graph/statements/holography/dvv-dyon-index-generating-function.yaml` (commit 000f52d)
9. ✓ `graph/statements/holography/torsion-index-divisor-operator.yaml` (commit 41a5d28)

## 验收结果

- `uv run stringgraph validate`: **0 errors, 93 warnings (25 history)** ✓
- `uv run pytest`: **86 passed** ✓
- 统计不变：691 statements, 580 derivations（未新增或删除节点，只追加 notes）
- warnings 数量不变：93（Φ₁₀ v1 告警仍在，符合预期——本任务是添加"刻意保留"说明，不是消除告警）

## 说明

所有 9 个文件的 `depends on superseded statement 'holography.igusa-cusp-form-phi10'` 告警**刻意保留**，因为这些边的论证逻辑上正确地只消费 v1 的有效内容（模性/偶权/Fourier 结构），不消费被订正的重数断言。每个文件的 notes 已明确记录判据与理由，防止后续误改。
