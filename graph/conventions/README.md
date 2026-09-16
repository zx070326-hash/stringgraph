# graph/conventions — Convention Nodes

This directory contains 24 convention nodes defining notational and normalization choices used throughout the graph.

## Families

Convention nodes are grouped by `family`. Within each family, nodes are mutually exclusive, and exactly one must be marked `canonical: true`.

### Current Families

- **metric**: Metric signature (mostly-plus vs mostly-minus)
- **alpha-prime**: α' normalization conventions
- **coordinates**: Worldsheet coordinate conventions (Euclidean vs Lorentzian, complex vs real)
- **gauge-normalization**: Trace normalizations for gauge fields
- **ghost-fields**: bc ghost system conventions (normal ordering, λ parameter)
- **virasoro**: Virasoro algebra conventions (central charge normalization)
- **intercept**: Normal ordering constant sign convention

## Key Convention Files

| File | Family | Canonical | Used By |
|------|--------|-----------|---------|
| `metric-mostly-minus.yaml` | metric | Yes | Most worldsheet calculations |
| `alpha-prime-regge.yaml` | alpha-prime | Yes | Standard Regge slope |
| `virasoro-standard.yaml` | virasoro | Yes | Most CFT statements |
| `worldsheet-euclidean.yaml` | coordinates | Yes | Euclidean worldsheet |
| `ghost-normal-ordering-sl2c.yaml` | ghost-fields | Yes | SL(2,C) ordering for bc ghosts |

## How Statements Reference Conventions

In statement YAML:
```yaml
uses_conventions:
  - metric-mostly-minus
  - alpha-prime-regge
  - virasoro-standard
```

The validator checks that:
1. All referenced conventions exist
2. No two conventions from the same family are used together
3. Formula-bearing statements declare which conventions they use

## Adding a New Convention

1. Choose or create a family
2. Set `canonical: true` for the default choice
3. Write `convention_text` explaining the choice
4. List `alternatives` pointing to competing conventions in the same family
