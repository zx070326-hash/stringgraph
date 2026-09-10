#!/usr/bin/env bash
# Pre-commit hook: refuse commits that break graph validation or tests.
# Installed by scripts/install-hooks.sh (copies to .git/hooks/pre-commit).
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

changed="$(git diff --cached --name-only)"

if echo "$changed" | grep -qE '^(graph/|literature/sources\.bib|tools/|tests/)'; then
  echo "[pre-commit] stringgraph validate"
  uv run stringgraph validate
  echo "[pre-commit] pytest"
  uv run pytest -q
fi

lean_files="$(echo "$changed" | grep -E '^formal/.*\.lean$' || true)"
if [ -n "$lean_files" ]; then
  echo "[pre-commit] sorry check (comments ignored)"
  # shellcheck disable=SC2086
  python scripts/check_sorry.py $lean_files
fi
