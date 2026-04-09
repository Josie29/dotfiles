# dotfiles

Personal machine config — Claude Code setup, shared across devices.

Git and SSH configs are managed locally per device (not in this repo).

---

## Claude Code

### Settings

| File | Purpose |
|---|---|
| `.claude/CLAUDE.md` | Global instructions — behavior rules, commit style, PR preferences |
| `.claude/settings.json` | Global settings — statusline config, preferences |
| `.claude/statusline-command.sh` | Custom status line: dir, branch, model, context, token burn, timestamp |

### Slash Commands

Run these inside any Claude Code session. They enforce better prompting habits.

| Command | When to use | What it does |
|---|---|---|
| `/spec` | Before writing any code | Walks through goal, constraints, edge cases, then challenges the spec before touching files |
| `/review` | After writing code, before a PR | Grills you on correctness, security, side effects — gives a pass/fail verdict |
| `/elegant` | After a working-but-messy fix | Scraps the current approach and rewrites it cleanly |

---

## How symlinks work

`install.sh` creates symlinks from `~/.claude/` to the files in this repo. The symlinked files are not copies — they point directly to the repo files. That means:

- **Edits are instant.** Changing `~/dotfiles/.claude/settings.json` (or `~/.claude/settings.json` — same file) takes effect immediately. No re-linking needed.
- **`git pull` updates everything.** Pulling new changes on another device updates the repo files, and the symlinks already point there. Nothing else to do.
- **No need to re-run `install.sh`** unless you add a new file to the repo that needs a new symlink.

---

## Setup on a new machine

### 1. SSH key for personal GitHub

Generate or copy your personal SSH key:

```bash
ssh-keygen -t ed25519 -C "01josie@gmail.com" -f ~/.ssh/id_ed25519_josie29
```

Add the public key to GitHub (Settings → SSH Keys), then configure `~/.ssh/config`:

```
Host github-other
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_josie29
```

Verify: `ssh -T git@github-other`

### 2. Clone and install

```bash
git clone git@github-other:Josie29/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

### 3. Git config (per device)

Create `~/.gitconfig` and `~/.gitconfig-personal` locally — these are **not** in this repo since work email/paths differ per device.

```ini
# ~/.gitconfig
[user]
    name = Josie Machalek
    email = your-work-email@company.com
[core]
    editor = nano

# Use personal identity for specific dirs
[includeIf "gitdir:~/dotfiles/"]
    path = ~/.gitconfig-personal
```

```ini
# ~/.gitconfig-personal
[user]
    name = josie29
    email = 01josie@gmail.com
```

---

## Adding new dotfiles

1. Move the file into `~/dotfiles/`
2. Add a symlink line to `install.sh`
3. Commit and push

To add a new slash command, just add a `.md` file to `.claude/commands/` — no `install.sh` change needed since the whole directory is symlinked.

---

## Ideas for extending this

- **Shell config** — `.zshrc`, `.vimrc` using the same move + symlink pattern
- **CLAUDE.md templates** — boilerplate for new project types (FastAPI, React, etc.) to copy when starting a project
- **Bootstrap script** — `bootstrap.sh` that installs Homebrew, Claude Code, and tools on a fresh Mac
