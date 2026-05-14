# Commit message conventions

After checks pass, suggest a commit message following these rules.

## Format

A commit message has a type, a colon, a subject, and an optional body:

    <type>: <subject>

    <optional body>

## Types

- **feat**: new user-facing feature
- **fix**: bug fix
- **refactor**: code change that neither adds a feature nor fixes a bug
- **docs**: documentation only
- **test**: adding or correcting tests
- **chore**: tooling, dependencies, build config

## Subject rules

- Imperative mood ("Add login" not "Added login" or "Adds login")
- No trailing period
- Max 72 characters
- Lowercase after the colon

## Examples

- feat: add /api/count endpoint with in-memory counter
- fix: handle empty Category column without crashing
- refactor: extract validation logic to validate_row()
- chore: pin flask to 3.1.1

## Body (optional)

Use when *why* isn't obvious from the diff. Wrap at 72 chars. Reference issues with `Closes #123`.
