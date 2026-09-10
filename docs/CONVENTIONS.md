# 约定管理

弦论文献约定不统一是整合的最大障碍之一。本项目把约定作为**一等节点**放在 `graph/conventions/`。

## 规则

1. 每条涉及公式的陈述在 `uses_conventions` 中列出所用约定 id。
2. 两条陈述若约定不同，它们之间的依赖边必须带 `convention_map`，说明如何换算，否则校验失败。
3. 里程碑陈述必须使用 `conventions/canonical.yaml` 里的规范约定。

## 初始规范约定（`conventions/canonical.yaml`）

- 度规号差：mostly-plus `(-,+,+,...,+)`
- 弦长：`alpha'`，Regge 斜率；闭弦张力 `T = 1/(2π α')`
- 世界面：欧氏号差用于 CFT 陈述，洛伦兹号差用于光锥量子化陈述，各自显式标注
- Virasoro 代数：`[L_m, L_n] = (m-n) L_{m+n} + (c/12) m (m^2-1) δ_{m+n,0}`
- 规范场归一化：`Tr` 取基本表示，`F = dA + A∧A`
- 单位：`ħ = c = 1`

以 Polchinski《String Theory》第一卷为默认参照，偏离时在节点上显式声明。
