#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT:-$HOME/dotfiles}"
DRY_RUN="${DRY_RUN:-0}"

. "$ROOT/setup/backup.sh"

link_target() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$source" ]; then
    return 0
  fi

  if [ "$DRY_RUN" = "1" ]; then
    printf 'would link %s -> %s\n' "$target" "$source"
    return 0
  fi

  backup_target "$target"
  mkdir -p "$(dirname "$target")"
  ln -sfn "$source" "$target"
}

link_target "$ROOT/lessfilter" "$HOME/.lessfilter"
link_target "$ROOT/zshrc" "$HOME/.zshrc"
link_target "$ROOT/vimrc" "$HOME/.vimrc"

for name in \
  autocompletion hypr waybar rofi swaync wlogout wallust kitty ghostty \
  fastfetch qt5ct qt6ct ags tig editor
do
  link_target "$ROOT/config/$name" "$HOME/.config/$name"
done

link_target "$ROOT/config/starship.toml" "$HOME/.config/starship.toml"

host_cfg="$ROOT/config/hypr/hosts/$(hostname).conf"
local_monitor_cfg="$ROOT/config/hypr/monitors.local.conf"

if [ -f "$host_cfg" ]; then
  ln -sfn "hosts/$(hostname).conf" "$local_monitor_cfg"
else
  printf '# No host-specific monitor override for %s\n' "$(hostname)" > "$local_monitor_cfg"
fi
