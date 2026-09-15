"""Tests for the captain-queue scan and its formatting.

The scanner reads two independent trees directly from disk -- research/attempts/*/status.yaml
and graph/milestones/*.yaml -- so these tests build a synthetic project root in tmp_path
instead of depending on the real (and changing) queue contents.
"""
from __future__ import annotations

import textwrap
from pathlib import Path

from stringgraph.report import captain_queue, format_captain_queue


def _write(root: Path, rel: str, body: str) -> None:
    p = root / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(textwrap.dedent(body).lstrip(), encoding="utf-8")


def _attempt(root: Path, slug: str, body: str) -> None:
    _write(root, f"research/attempts/{slug}/status.yaml", body)


def _milestone(root: Path, name: str, body: str) -> None:
    _write(root, f"graph/milestones/{name}.yaml", body)


# ---------------------------------------------------------------- pending items


def test_lists_verified_unconfirmed_attempt_and_non_approved_milestone(tmp_path: Path) -> None:
    _attempt(tmp_path, "alpha", """
        state: verified
        captain_confirmed: false
        verdict: |
          first line of the verdict
          second line, should not appear in the summary
    """)
    _milestone(tmp_path, "some-ms", """
        id: ms.some
        audit:
          status: back-translated
    """)

    q = captain_queue(tmp_path)

    assert [a["slug"] for a in q["research"]] == ["alpha"]
    a = q["research"][0]
    assert a["state"] == "verified"
    assert a["captain_confirmed"] is False
    assert a["verdict_summary"] == "first line of the verdict"
    assert Path(a["path"]) == tmp_path / "research" / "attempts" / "alpha" / "status.yaml"

    assert [m["id"] for m in q["milestones"]] == ["ms.some"]
    assert q["milestones"][0]["audit_status"] == "back-translated"


def test_approved_milestone_and_confirmed_attempt_are_not_pending(tmp_path: Path) -> None:
    _attempt(tmp_path, "done", """
        state: verified
        captain_confirmed: true
        verdict: shipped
    """)
    _milestone(tmp_path, "signed", """
        id: ms.signed
        audit:
          status: approved
    """)

    q = captain_queue(tmp_path)

    assert q["research"] == []
    assert q["milestones"] == []


def test_non_verified_attempt_is_not_pending(tmp_path: Path) -> None:
    # A draft that has not been verified is not the captain's call yet.
    _attempt(tmp_path, "wip", """
        state: draft
        captain_confirmed: false
        verdict: still working
    """)

    q = captain_queue(tmp_path)

    assert q["research"] == []


# ---------------------------------------------------------------- empty queue


def test_empty_queue_when_nothing_on_disk(tmp_path: Path) -> None:
    q = captain_queue(tmp_path)

    assert q == {"research": [], "milestones": []}
    out = format_captain_queue(q)
    assert out.count("(无待办)") == 2


def test_format_reports_counts_and_paths(tmp_path: Path) -> None:
    _attempt(tmp_path, "alpha", """
        state: verified
        captain_confirmed: false
        verdict: hello
    """)
    q = captain_queue(tmp_path)
    out = format_captain_queue(q)

    assert "待船长确认（research 尝试）: 1 条" in out
    assert "待船长审计（里程碑）: 0 条" in out
    assert "alpha" in out
    assert "alpha/status.yaml" in out or "alpha\\status.yaml" in out


# ---------------------------------------------------------------- missing fields


def test_attempt_missing_captain_confirmed_counts_as_pending(tmp_path: Path) -> None:
    # No captain_confirmed key at all (falsy by absence) with state verified -> pending.
    _attempt(tmp_path, "nokey", """
        state: verified
        verdict: no confirmation key
    """)

    q = captain_queue(tmp_path)

    assert [a["slug"] for a in q["research"]] == ["nokey"]
    assert q["research"][0]["captain_confirmed"] is False


def test_attempt_missing_verdict_falls_back_to_placeholder(tmp_path: Path) -> None:
    _attempt(tmp_path, "noverdict", """
        state: verified
        captain_confirmed: false
    """)

    q = captain_queue(tmp_path)

    assert q["research"][0]["verdict_summary"] == "(no verdict)"


def test_attempt_missing_state_is_not_pending(tmp_path: Path) -> None:
    _attempt(tmp_path, "nostate", """
        captain_confirmed: false
        verdict: no state key
    """)

    q = captain_queue(tmp_path)

    assert q["research"] == []


def test_milestone_missing_audit_is_pending_with_placeholder(tmp_path: Path) -> None:
    _milestone(tmp_path, "bare", """
        id: ms.bare
    """)

    q = captain_queue(tmp_path)

    assert [m["id"] for m in q["milestones"]] == ["ms.bare"]
    assert q["milestones"][0]["audit_status"] == "(missing)"


def test_milestone_missing_status_key_is_pending_with_placeholder(tmp_path: Path) -> None:
    _milestone(tmp_path, "audit-no-status", """
        id: ms.auditnostatus
        audit:
          back_translation:
            by: physics-auditor
    """)

    q = captain_queue(tmp_path)

    assert q["milestones"][0]["audit_status"] == "(missing)"


def test_unreadable_status_file_is_skipped_not_fatal(tmp_path: Path) -> None:
    # A malformed YAML file must not crash the whole queue scan.
    _write(tmp_path, "research/attempts/broken/status.yaml", "state: [unclosed\n")
    _attempt(tmp_path, "ok", """
        state: verified
        captain_confirmed: false
        verdict: fine
    """)

    q = captain_queue(tmp_path)

    assert [a["slug"] for a in q["research"]] == ["ok"]
