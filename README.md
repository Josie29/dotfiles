# dotfiles

Personal machine config — Claude Code setup and Homebrew packages, shared across devices.

Git and SSH configs are managed locally per device (not in this repo).

---

## Claude Code

### Settings

| File | Purpose |
|---|---|
| `.claude/CLAUDE.md` | Global instructions — behavior rules, commit style, PR preferences |
| `.claude/settings.json` | Global settings — statusline config, preferences (**not tracked — see below**) |
| `.claude/statusline-command.sh` | Custom status line: dir, branch, model, context, token burn, timestamp |

### settings.json (not tracked)

`.claude/settings.json` contains API keys and machine-specific config, so it's gitignored and **not symlinked** by `install.sh`. Create it manually on each device:

```bash
cat > ~/.claude/settings.json << 'EOF'
{
  "env": {
    "ANTHROPIC_API_KEY": "<your-api-key>",
    "ANTHROPIC_BASE_URL": "<your-base-url>"
  },
  "statusLine": {
    "type": "command",
    "command": "bash \"$HOME/.claude/statusline-command.sh\""
  }
}
EOF
```

Adjust env vars as needed for your setup (omit the `env` block entirely if you authenticate via subscription).

### Slash Commands

Run these inside any Claude Code session. Most enforce better prompting habits; some are research utilities.

| Command | When to use | What it does |
|---|---|---|
| `/spec` | Before writing any code | Walks through goal, constraints, edge cases, then challenges the spec before touching files |
| `/review` | After writing code, before a PR | Grills you on correctness, security, side effects — gives a pass/fail verdict |
| `/elegant` | After a working-but-messy fix | Scraps the current approach and rewrites it cleanly |
| `/compare <component>` | Choosing between tools/libraries | Web-searches the current landscape, outputs a comparison table, then recommends one scoped to your use case |

---

## How symlinks work

`install.sh` creates symlinks from `~/.claude/` to the files in this repo. The symlinked files are not copies — they point directly to the repo files. That means:

- **Edits are instant.** Changing `~/Projects/dotfiles/.claude/CLAUDE.md` (or `~/.claude/CLAUDE.md` — same file) takes effect immediately. No re-linking needed.
- **`git pull` updates everything.** Pulling new changes on another device updates the repo files, and the symlinks already point there. Nothing else to do.
- **No need to re-run `install.sh`** unless you add a new file to the repo that needs a new symlink.

`settings.json` is the exception — it's a real, untracked file, not a symlink (see above).

---

## Homebrew packages

Package installs are declared in Homebrew Bundle files — the manifest is the source of truth, and one command installs everything it lists.

| File | Purpose |
|---|---|
| `Brewfile` | CLI tools, cross-platform (git, gh, node, ripgrep, jq, …) |
| `Brewfile.mac` | GUI apps, Mac-only casks (Docker, VS Code, iTerm2) |
| `Brewfile.optional` | Situational CLI, cross-platform — installed on demand, not by default (railway, …) |

### Adding new tools

- CLI tool that works everywhere → add to `Brewfile`
- Mac GUI app (cask) → add to `Brewfile.mac`
- Situational CLI you don't want on every machine → add to `Brewfile.optional`
- Verify a machine has everything installed: `brew bundle check --file=Brewfile`

Find package names at [formulae.brew.sh](https://formulae.brew.sh) — formulae and casks are searched separately.

---

## Setup on a new machine

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Skip if it's already installed.

### 2. SSH key for personal GitHub

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

### 3. Clone the repo

Clone anywhere — `install.sh` resolves its own location, so the path isn't fixed:

```bash
git clone git@github-other:Josie29/dotfiles.git ~/Projects/dotfiles
```

### 4. Install packages

```bash
brew bundle --file=~/Projects/dotfiles/Brewfile      # CLI tools (Mac + Linux)
brew bundle --file=~/Projects/dotfiles/Brewfile.mac  # GUI apps (Mac only)
```

On Linux, run only the first — casks aren't supported. Situational tools live in `Brewfile.optional`; install them per-machine when needed with `brew bundle --file=~/Projects/dotfiles/Brewfile.optional`.

### 5. Symlink Claude Code config

```bash
bash ~/Projects/dotfiles/install.sh
```

Then create `~/.claude/settings.json` by hand — it's untracked, so `install.sh` doesn't manage it (see [settings.json](#settingsjson-not-tracked) above).

### 6. Git config (per device)

Create `~/.gitconfig` and `~/.gitconfig-personal` locally — these are **not** in this repo since work email/paths differ per device.

```ini
# ~/.gitconfig
[user]
    name = Josie Machalek
    email = your-work-email@company.com
[core]
    editor = nano

# Use personal identity for specific dirs
[includeIf "gitdir:~/Projects/dotfiles/"]
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

1. Move the file into the repo (`~/Projects/dotfiles/`)
2. Add a symlink line to `install.sh`
3. Commit and push

To add a new slash command, just add a `.md` file to `.claude/commands/` — no `install.sh` change needed since the whole directory is symlinked.

---

## Ideas for extending this

- **Shell config** — `.zshrc`, `.vimrc` using the same move + symlink pattern
- **CLAUDE.md templates** — boilerplate for new project types (FastAPI, React, etc.) to copy when starting a project
- **Bootstrap script** — `bootstrap.sh` that runs the whole new-machine runbook (Homebrew, clone, packages, symlinks) end to end
