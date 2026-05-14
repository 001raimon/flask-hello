---
name: python-checks
description: Runs quality checks on Python code before commit and helps draft a commit message. Use this skill whenever the user is about to commit Python changes, asks to "check the code", "lint", "format", "prepare for commit", or "write a commit message". Also use proactively after any non-trivial Python edit. Make sure to invoke it whenever Python files have been modified.
allowed-tools: Bash, Read, Write
---

# Python pre-commit checks

This skill enforces code quality and commit hygiene before changes go into git.

## Workflow

1. Run the bundled check script: `bash .claude/skills/python-checks/scripts/run_checks.sh`
2. Report results to the user in 3 lines max.
3. If any check failed, **stop**. Do not proceed to commit. Surface the exact failure to the user.
4. If all checks passed, ask the user if they want help writing a commit message. If yes, go to step 5.
5. Read `.claude/skills/python-checks/references/commit_conventions.md` for the rules.
6. Read `.claude/skills/python-checks/assets/commit_message_template.txt` as the starting structure.
7. Inspect the staged diff (`git diff --cached`) to understand what changed.
8. Fill the template based on the diff and the conventions. Show the result to the user before committing.

## Reporting format

After running checks, output exactly three lines:

    Syntax: PASS/FAIL
    Ruff:   PASS/FAIL/skipped
    Pytest: PASS/FAIL/skipped

Then either "Safe to commit" or "Blocked: <reason>".

## Boundaries

- Do not auto-commit. Always show the message and wait for user confirmation.
- Do not modify code to make ruff pass without telling the user first.
- If `tests/` doesn't exist, suggest creating it (don't error out).
