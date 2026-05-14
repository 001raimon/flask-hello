#!/usr/bin/env bash
# Runs the standard pre-commit checks for this project.
# Exit codes: 0 = all passed, 1 = a check failed.

set -uo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
if [[ -z "$PROJECT_ROOT" ]]; then
  echo "ERROR: not inside a git repository"
  exit 1
fi
cd "$PROJECT_ROOT"

FAIL=0

echo "=== Syntax check ==="
PY_FILES=$(git ls-files '*.py')
if [[ -z "$PY_FILES" ]]; then
  echo "  no Python files tracked — skipped"
else
  if python -m py_compile $PY_FILES 2>&1; then
    echo "  PASS"
  else
    echo "  FAIL"
    FAIL=1
  fi
fi

echo ""
echo "=== Ruff lint ==="
if command -v ruff >/dev/null 2>&1; then
  if ruff check .; then
    echo "  PASS"
  else
    echo "  FAIL"
    FAIL=1
  fi
else
  echo "  ruff not installed — run: pip install ruff"
fi

echo ""
echo "=== Pytest ==="
if [[ -d tests ]] || [[ -f pytest.ini ]] || [[ -f pyproject.toml ]]; then
  if command -v pytest >/dev/null 2>&1; then
    if pytest -q; then
      echo "  PASS"
    else
      echo "  FAIL"
      FAIL=1
    fi
  else
    echo "  pytest not installed — run: pip install pytest"
  fi
else
  echo "  no tests/ folder or pytest config — skipped"
fi

echo ""
if [[ $FAIL -eq 0 ]]; then
  echo "All checks passed."
  exit 0
else
  echo "One or more checks failed."
  exit 1
fi
