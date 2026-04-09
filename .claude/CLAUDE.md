# Global Claude Code Settings

Rules that apply across all projects. Project-level CLAUDE.md adds to or overrides these.

## Claude Behavior Guidelines
- Before implementing anything non-trivial, flag ambiguities and potential failure modes first — don't just start writing code
- After delivering a working-but-messy fix, proactively offer the cleaner alternative ("knowing everything now, here's the elegant approach")
- When asked to review, challenge the approach skeptically — don't just validate it

## Commit Messages
- Always run `git diff --staged` before drafting a commit message
- The title and body must reflect ALL staged changes — not just the files that prompted the task
- If there are changes beyond the immediate task, include them in the body as bullet points

## Pull Requests
- Do not add "Generated with Claude Code" or any AI attribution footer to PR descriptions
