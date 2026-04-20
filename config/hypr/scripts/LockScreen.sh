#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
set -euo pipefail

# Ensure weather cache is up-to-date before locking (Waybar/lockscreen readers)
bash "$HOME/.config/hypr/UserScripts/WeatherWrap.sh" >/dev/null 2>&1 || true

# Prefer launching hyprlock directly because loginctl lock-session can be a no-op
# in some desktop/session setups. Fall back to logind lock if needed.
if ! pidof hyprlock >/dev/null 2>&1; then
  hyprlock >/dev/null 2>&1 &
  disown || true
fi

loginctl lock-session >/dev/null 2>&1 || true
