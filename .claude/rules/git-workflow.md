# Commit Messages

- Always run `git diff --staged` before drafting a commit message
- The title and body must reflect ALL staged changes — not just the files that prompted the task
- If there are changes beyond the immediate task, include them in the body as bullet points
- Do not add AI attribution or Co-Authored-By lines to commit messages

# Pull Requests

- Do not add "Generated with Claude Code" or any AI attribution footer to PR descriptions
- Default to squash merge — suggest it when merging PRs unless the user specifies otherwise
- Structure PR descriptions with `## Added`, `## Modified`, and `## Removed` sections (omit any that are empty) rather than a generic `## Summary`
