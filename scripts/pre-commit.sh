#!/usr/bin/env bash
# Pre-commit hook: refuse commits that break graph validation or tests.
# Installed by scripts/install-hooks.sh (copies to .git/hooks/pre-commit).
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

changed="$(git diff --cached --name-only)"

# validate: 图数据的完整性检查，改图就跑（秒级）。
if echo "$changed" | grep -qE '^(graph/|literature/sources\.bib|tools/|tests/)'; then
  echo "[pre-commit] stringgraph validate"
  uv run stringgraph validate
fi

# pytest: 只测工具代码，用的是 tmp_path 合成图，**不读真实图数据**。
# 所以纯图数据提交不跑它——那是 35 秒的纯等待，而规则要求「每张卡立刻 commit」，
# 这笔税会乘以卡数。改了 tools/ 或 tests/ 才跑。
if echo "$changed" | grep -qE '^(tools/|tests/)'; then
  echo "[pre-commit] pytest"
  uv run pytest -q
fi

lean_files="$(echo "$changed" | grep -E '^formal/.*\.lean$' || true)"
if [ -n "$lean_files" ]; then
  echo "[pre-commit] sorry check (comments ignored)"
  # shellcheck disable=SC2086
  python scripts/check_sorry.py $lean_files
fi
