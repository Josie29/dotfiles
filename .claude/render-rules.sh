#!/usr/bin/env bash
# Regenerates CLAUDE.rendered.md by inlining @-imports from CLAUDE.md into a
# single, flattened, human-readable view of the effective global ruleset.
#
# The output is NOT ingested by Claude Code (only files named CLAUDE.md are,
# plus anything reached via @-import — and nothing imports the rendered file).
# It exists purely for visibility. Do not edit the output; edit CLAUDE.md or
# the files under rules/ instead.
set -euo pipefail

CLAUDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$CLAUDE_DIR/CLAUDE.md"
OUT="$CLAUDE_DIR/CLAUDE.rendered.md"

# Recursively inline lines that are a bare @<path>.md import. Paths resolve
# relative to CLAUDE_DIR, matching how Claude Code resolves @-imports.
render() {
  local file="$1"
  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^@([A-Za-z0-9._/-]+\.md)[[:space:]]*$ ]]; then
      local import="$CLAUDE_DIR/${BASH_REMATCH[1]}"
      if [[ -f "$import" ]]; then
        render "$import"
        printf '\n'
      else
        # Leave an unresolved import visible rather than silently dropping it.
        printf '%s\n' "$line"
      fi
    else
      printf '%s\n' "$line"
    fi
  done < "$file"
}

{
  printf '<!--\n'
  printf '  GENERATED FILE — DO NOT EDIT, AND DO NOT @-IMPORT THIS FILE.\n'
  printf '  Flattened, human-readable view of the effective global ruleset.\n'
  printf '  Source: CLAUDE.md + rules/. Regenerate with .claude/render-rules.sh\n'
  printf '  (this also runs automatically via the pre-commit hook).\n'
  printf -- '-->\n\n'
  render "$SRC"
} > "$OUT"

echo "Rendered $OUT"
