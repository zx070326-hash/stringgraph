"""Load the YAML graph from disk into a Graph object.

Loading is deliberately lenient: schema/semantic problems are reported by
validate.py, not here. Only unreadable YAML or missing required keys needed
to build an id are recorded as load_errors.
"""
from __future__ import annotations

import re
from pathlib import Path
from typing import Any

import yaml

from .model import Convention, Dep, Derivation, Graph, Milestone, Source, Statement

BIB_KEY_RE = re.compile(r"^@\w+\{\s*([^,\s]+)\s*,", re.MULTILINE)


def find_project_root(start: Path | None = None) -> Path:
    """Walk up from start (default cwd) until a directory containing graph/schema is found."""
    p = (start or Path.cwd()).resolve()
    for candidate in (p, *p.parents):
        if (candidate / "graph" / "schema").is_dir():
            return candidate
    raise FileNotFoundError("cannot find project root (directory containing graph/schema)")


def _read_yaml(path: Path) -> Any:
    with path.open("r", encoding="utf-8") as f:
        return yaml.safe_load(f)


def _sources(items: Any) -> list[Source]:
    out: list[Source] = []
    for s in items or []:
        if isinstance(s, dict):
            out.append(Source(ref=str(s.get("ref", "")), loc=s.get("loc"), note=s.get("note")))
    return out


def _deps(items: Any) -> list[Dep]:
    out: list[Dep] = []
    for d in items or []:
        if isinstance(d, dict):
            out.append(
                Dep(
                    id=str(d.get("id", "")),
                    inferred=bool(d.get("inferred", False)),
                    note=d.get("note"),
                    convention_map=d.get("convention_map"),
                )
            )
        elif isinstance(d, str):
            out.append(Dep(id=d))
    return out


def load_graph(root: Path | None = None) -> Graph:
    root = root or find_project_root()
    gdir = root / "graph"
    g = Graph(root=root)

    areas_file = gdir / "schema" / "areas.yaml"
    if areas_file.exists():
        data = _read_yaml(areas_file) or {}
        g.areas = {str(k): str(v) for k, v in (data.get("areas") or {}).items()}

    bib = root / "literature" / "sources.bib"
    if bib.exists():
        g.bib_keys = set(BIB_KEY_RE.findall(bib.read_text(encoding="utf-8")))

    for path in sorted((gdir / "statements").rglob("*.yaml")):
        try:
            raw = _read_yaml(path) or {}
            st = Statement(
                id=str(raw["id"]),
                kind=str(raw.get("kind", "")),
                title=str(raw.get("title", "")),
                statement=str(raw.get("statement", "")),
                sources=_sources(raw.get("sources")),
                path=path,
                status=raw.get("status"),
                uses=list(raw.get("uses") or []),
                uses_conventions=list(raw.get("uses_conventions") or []),
                tags=list(raw.get("tags") or []),
                notes=raw.get("notes"),
                superseded_by=raw.get("superseded_by"),
                formal=raw.get("formal"),
                author=raw.get("author"),
                created=str(raw["created"]) if raw.get("created") is not None else None,
                raw=raw,
            )
            if st.id in g.statements:
                g.load_errors.append(f"{path}: duplicate statement id {st.id} (also {g.statements[st.id].path})")
            g.statements[st.id] = st
        except Exception as e:  # noqa: BLE001
            g.load_errors.append(f"{path}: {e}")

    for path in sorted((gdir / "derivations").rglob("*.yaml")):
        try:
            raw = _read_yaml(path) or {}
            d = Derivation(
                id=str(raw["id"]),
                target=str(raw.get("target", "")),
                kind=str(raw.get("kind", "")),
                status=str(raw.get("status", "")),
                depends_on=_deps(raw.get("depends_on")),
                sources=_sources(raw.get("sources")),
                summary=str(raw.get("summary", "")),
                path=path,
                gaps=list(raw.get("gaps") or []),
                author=raw.get("author"),
                created=str(raw["created"]) if raw.get("created") is not None else None,
                raw=raw,
            )
            if d.id in g.derivations:
                g.load_errors.append(f"{path}: duplicate derivation id {d.id}")
            g.derivations[d.id] = d
        except Exception as e:  # noqa: BLE001
            g.load_errors.append(f"{path}: {e}")

    for path in sorted((gdir / "milestones").glob("*.yaml")):
        try:
            raw = _read_yaml(path) or {}
            m = Milestone(
                id=str(raw["id"]),
                statement_id=str(raw.get("statement_id", "")),
                canonical_text=str(raw.get("canonical_text", "")),
                audit=dict(raw.get("audit") or {}),
                path=path,
                canonical_source=raw.get("canonical_source"),
                phase=raw.get("phase"),
                raw=raw,
            )
            g.milestones[m.id] = m
        except Exception as e:  # noqa: BLE001
            g.load_errors.append(f"{path}: {e}")

    for path in sorted((gdir / "conventions").glob("*.yaml")):
        try:
            raw = _read_yaml(path) or {}
            c = Convention(
                id=str(raw["id"]),
                family=str(raw.get("family", "")),
                title=str(raw.get("title", "")),
                definition=str(raw.get("definition", "")),
                sources=_sources(raw.get("sources")),
                path=path,
                canonical=bool(raw.get("canonical", False)),
                notes=raw.get("notes"),
                raw=raw,
            )
            g.conventions[c.id] = c
        except Exception as e:  # noqa: BLE001
            g.load_errors.append(f"{path}: {e}")

    return g
