#!/bin/bash

# Resolve this repo's location so the script works wherever it's cloned
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Claude Code
mkdir -p ~/.claude
# Note: ~/.claude/settings.json is intentionally NOT symlinked — it's a local,
# untracked file (API keys, machine-specific config). Create it by hand; see README.
ln -sf "$DOTFILES_DIR/.claude/statusline-command.sh" ~/.claude/statusline-command.sh
ln -sf "$DOTFILES_DIR/.claude/CLAUDE.md" ~/.claude/CLAUDE.md
# Remove existing commands dir/symlink before linking
rm -rf ~/.claude/commands
ln -sf "$DOTFILES_DIR/.claude/commands" ~/.claude/commands
