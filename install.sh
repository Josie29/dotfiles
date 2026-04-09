#!/bin/bash

# Claude Code
mkdir -p ~/.claude
ln -sf ~/dotfiles/.claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/.claude/statusline-command.sh ~/.claude/statusline-command.sh
ln -sf ~/dotfiles/.claude/CLAUDE.md ~/.claude/CLAUDE.md
# Remove existing commands dir/symlink before linking
rm -rf ~/.claude/commands
ln -sf ~/dotfiles/.claude/commands ~/.claude/commands

