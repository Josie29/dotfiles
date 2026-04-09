# dotfiles

Personal machine config, currently focused on Claude Code setup.

## What's in here

| File | Purpose |
|---|---|
| `.claude/settings.json` | Claude Code global settings (statusline, preferences) |
| `.claude/statusline-command.sh` | Custom status line script |
| `install.sh` | Symlinks everything to the right places |

## Setup on a new machine

**Prerequisites:** Claude Code installed, `~/.claude` directory exists.

```bash
git clone git@github-personal:Josie29/dotfiles.git ~/dotfiles
mkdir -p ~/.claude
~/dotfiles/install.sh
```

> Note: SSH uses the `github-personal` host alias. Make sure `~/.ssh/config` has that entry and `~/.ssh/id_ed25519_personal` exists on the new machine.

## Adding new dotfiles

1. Move the file into `~/dotfiles/`
2. Add a symlink line to `install.sh`
3. Commit and push

## Ideas for extending this

- **Shell config** — add `.zshrc`, `.gitconfig`, `.vimrc` using the same move + symlink pattern
- **CLAUDE.md templates** — boilerplate for new project types (FastAPI, React, etc.) to copy when starting a project
- **Bootstrap script** — a `bootstrap.sh` that installs Homebrew, Claude Code, and other tools on a fresh Mac so you go from zero to ready in one command
- **Per-machine overrides** — a `machines/` folder with machine-specific settings that `install.sh` detects and applies
- **Secrets documentation** — a `.env.example` pattern to document what env vars are needed without committing real values
