#!/usr/bin/env bash
set -euo pipefail

STAMP="${STAMP:-$(date +%Y%m%d-%H%M%S)}"
BACKUP_ROOT="${BACKUP_ROOT:-$HOME/.local/state/dotfiles-backups/$STAMP}"

backup_target() {
  local target="$1"

  if [ -e "$target" ] || [ -L "$target" ]; then
    mkdir -p "$BACKUP_ROOT$(dirname "$target")"
    mv "$target" "$BACKUP_ROOT$target"
  fi
}
