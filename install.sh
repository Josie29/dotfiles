#!/bin/bash

# Claude Code
mkdir -p ~/.claude
ln -sf ~/dotfiles/.claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/.claude/statusline-command.sh ~/.claude/statusline-command.sh

# Git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitconfig-personal ~/.gitconfig-personal

# SSH
mkdir -p ~/.ssh
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config
chmod 700 ~/.ssh
chmod 600 ~/dotfiles/.ssh/config
