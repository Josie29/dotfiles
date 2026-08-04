Create project-scoped subagents tailored to this codebase, then act as the orchestrator that drives them against outstanding work: $ARGUMENTS

1. Read whatever project context exists — brief/spec, CLAUDE.md, GitHub issues, and any existing code — to understand the intended (or actual) backend stack, frontend stack, and testing setup.
2. Write three subagent definitions into this project's `.claude/agents/` directory (create it if missing), using Claude Code's subagent frontmatter (`name`, `description`, `tools`, `model: sonnet`). Keep each one concise and reference this project's real stack/tools by name rather than staying generic:
   - `backend-implementor` — given a GitHub issue number, implements its backend requirements using this project's actual stack and conventions, writes tests per this project's testing setup, then comments on and closes the issue.
   - `frontend-implementor` — same, scoped to frontend work.
   - `po-verifier` — given a GitHub issue number, checks the implementation against the issue's stated requirements and reports PASS/FAIL with specifics; does not edit code or the issue's state itself.
3. Run `gh issue list --state open` for outstanding issues. For each one, invoke the matching implementor agent yourself via the Agent tool to do the work, then invoke `po-verifier` to check it before moving to the next issue.

You are the orchestrator throughout: the subagents you create do the implementation and verification, you dispatch them and track overall progress.
