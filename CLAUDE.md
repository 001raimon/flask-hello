# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run the app
python app.py                   # starts dev server at http://localhost:5000

# Activate the venv first
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt
pip install -r requirements-dev.txt   # ruff (linting)

# Lint
ruff check .
```

No test suite exists yet. `tests/` can be created and pytest added to `requirements-dev.txt` when needed.

## Architecture

Single-file Flask app (`app.py`) with three JSON endpoints and one HTML route:

- `GET /` — renders `templates/index.html`
- `GET /api/hi` — returns `{"message": "Hi!"}`
- `GET /api/time` — returns current UTC time as ISO 8601
- `GET /api/count` — increments and returns an in-memory counter (resets on restart)

The frontend (`templates/index.html`) calls the JSON endpoints via `fetch` and displays the raw response in a `#output` div. Styles live in `static/styles.css`.

## Linting

`ruff.toml` excludes `get-pip.py`. The check script at `.claude/skills/python-checks/scripts/run_checks.sh` uses `python` (not `python3`) — run the syntax check directly with `python3 -m py_compile` on this system.
