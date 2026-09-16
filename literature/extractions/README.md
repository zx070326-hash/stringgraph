# literature/extractions — Paper Extraction Records

This directory contains 57 extraction files: statement-level records of what was found in each paper, following the template in `../templates/extraction.md`.

## Purpose

Extraction files are **intermediate products** between literature and graph nodes:
1. Researcher agent reads paper → writes extraction file here
2. Graph curator reads extraction file → creates nodes in `../../graph/`

## Format

Each `<ref>.md` corresponds to a BibTeX key in `../sources.bib` and contains:
- Paper metadata and access info
- Extracted statements with exact locations (chapter, equation, page)
- What the paper claims about rigor level
- What dependencies the paper lists
- Verbatim quotes for key formulas

## Key Extraction Files

### Foundational Papers
- `goddard-thorn-1972.md` — No-ghost theorem original paper
- `polchinski-1998-v1.md` / `polchinski-1998-v2.md` — Standard textbook reference
- `green-schwarz-witten-1987-v1.md` / `-v2.md` — GSW textbook

### Specialized Topics
- `borcherds-1992.md` — Vertex operator algebras
- `frenkel-lepowsky-meurman-1988.md` — Moonshine module construction
- `dijkgraaf-verlinde-verlinde-1991.md` — Topological field theory

### Recent Work
- `sen-1995.md` — D-brane tension calculations
- `arkani-hamed-2006.md` — Swampland program

## Extraction Discipline

1. **Record verbatim**: Copy formulas exactly as written, note any ambiguities
2. **Note gaps**: If paper says "it is easy to show" without showing, record that
3. **Cross-check**: Flag inconsistent notation between sections
4. **Do not infer**: Don't add dependencies the paper didn't mention (curator can mark those `inferred: true`)
5. **One file per paper**: Append to existing file rather than creating duplicates

## Workflow

```
reading-list.md → researcher agent → extractions/<ref>.md → graph-curator agent → graph/statements/ + graph/derivations/
```

See `../reading-list.md` for the current extraction queue.
