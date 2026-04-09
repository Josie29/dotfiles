# dotfiles

Personal machine config — Claude Code setup and git/SSH credentials.

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

## Git & SSH

### Config files

| File | Purpose |
|---|---|
| `.gitconfig` | Global git config — defaults to work (Deloitte) account |
| `.gitconfig-personal` | Personal git identity, auto-applied under `~/Desktop/Projects/Other/` |
| `.ssh/config` | SSH host aliases for work (`github-work`) and personal (`github-personal`) |

### SSH host aliases

| Alias | Account | Key |
|---|---|---|
| `github-work` | jmachalek@deloitte.com | `~/.ssh/id_ed25519_work` |
| `github-personal` | Josie29 (01josie@gmail.com) | `~/.ssh/id_ed25519_personal` |

Use the alias instead of `github.com` in remote URLs:
```bash
git remote add origin git@github-personal:Josie29/my-repo.git
```

---

## Setup on a new machine

**Prerequisites:** Claude Code installed, `~/.claude` directory exists.

```bash
git clone git@github-personal:Josie29/dotfiles.git ~/dotfiles
mkdir -p ~/.claude
~/dotfiles/install.sh
```

> SSH uses the `github-personal` host alias — make sure `~/.ssh/config` has that entry and `~/.ssh/id_ed25519_personal` exists before cloning.

### SSH keys (not committed — handle manually)

**Option A: Generate new keys**
```bash
ssh-keygen -t ed25519 -C "jmachalek@deloitte.com" -f ~/.ssh/id_ed25519_work
ssh-keygen -t ed25519 -C "01josie@gmail.com" -f ~/.ssh/id_ed25519_personal
```
Add each `.pub` file to the respective GitHub account under Settings → SSH Keys.

**Option B: Copy from old machine**
```bash
scp ~/.ssh/id_ed25519_work user@newmachine:~/.ssh/
scp ~/.ssh/id_ed25519_personal user@newmachine:~/.ssh/
chmod 600 ~/.ssh/id_ed25519_work ~/.ssh/id_ed25519_personal
```

**Verify:**
```bash
ssh -T git@github-work
ssh -T git@github-personal
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
- **Per-machine overrides** — `machines/` folder with machine-specific settings `install.sh` detects and applies
