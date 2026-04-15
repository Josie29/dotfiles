# Global Claude Code Settings

Rules that apply across all projects. Project-level CLAUDE.md adds to or overrides these.

## Communication

- Do not use emojis in messages or code unless explicitly asked

## Working Approach

- Before implementing anything non-trivial, flag ambiguities and potential failure modes first — don't just start writing code. Consider: dependencies, edge cases, config, backwards compatibility, observability, and security. Ask a short, pointed question rather than assuming.
- After delivering a working-but-messy fix, proactively offer the cleaner alternative ("knowing everything now, here's the elegant approach").
- When asked to review, challenge the approach skeptically — don't just validate it.
- When a preference or convention surfaces in conversation that isn't already in a CLAUDE.md, suggest adding it — recommend global if it's a personal working style (formatting, merge strategy, code style) or project-level if it's specific to the stack or codebase

## Code Quality

- Write production-level code: prioritize readability, maintainability, clear naming, and appropriate abstraction. Match existing patterns and style.
- Validate inputs and handle missing or malformed data. Use try/except only where you can handle or meaningfully report the failure. Prefer specific exception types; avoid bare `except`. Log errors with enough context to debug.

### Type Hints

- Use type hints liberally — all function signatures (params and return), class attributes, and any variable where the type isn't obvious from the assignment. Prefer `X | None` over `Optional[X]`.

### Docstrings

- Every function gets a Google-style docstring unless it's trivially simple (e.g., one-line getters/setters with a clear name).
- Include `Args`, `Returns`, and `Raises` sections as applicable — always document `Raises` when a function can throw.
- In non-Python languages, apply the same spirit: JSDoc for TypeScript/JavaScript, `///` doc comments for Rust, etc.

## Commit Messages

- Always run `git diff --staged` before drafting a commit message
- The title and body must reflect ALL staged changes — not just the files that prompted the task
- If there are changes beyond the immediate task, include them in the body as bullet points
- Do not add AI attribution or Co-Authored-By lines to commit messages

## Code Style
- Use enums (Python `Enum`/`StrEnum`) instead of string literals for any fixed option set — especially values shared across module boundaries or between layers. Suggest migrating bare string comparisons to enums when encountered.
- Add inline comments for moderately rare operations (e.g., floor division `//`, modulo `%` for field extraction, bitwise ops, set comprehensions for lookup optimization) — anything a reader might need to pause and parse.

## Pull Requests

- Do not add "Generated with Claude Code" or any AI attribution footer to PR descriptions
- Default to squash merge — suggest it when merging PRs unless the user specifies otherwise
- Structure PR descriptions with `## Added`, `## Modified`, and `## Removed` sections (omit any that are empty) rather than a generic `## Summary`
