#!/usr/bin/env bash
# Install repo-managed git hooks. Run once after clone:  bash scripts/install-hooks.sh
set -euo pipefail
root="$(git rev-parse --show-toplevel)"
cp "$root/scripts/pre-commit.sh" "$root/.git/hooks/pre-commit"
chmod +x "$root/.git/hooks/pre-commit"
echo "installed .git/hooks/pre-commit"
