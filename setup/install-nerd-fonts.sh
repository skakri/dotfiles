#!/usr/bin/env bash
set -euo pipefail

if fc-list | grep -qi 'JetBrainsMono Nerd Font'; then
  exit 0
fi

sudo apt install -y fontconfig unzip

api_url='https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest'
asset='JetBrainsMono.zip'
asset_url="$(curl -fsSL "$api_url" | jq -r --arg asset "$asset" '.assets[] | select(.name == $asset) | .browser_download_url' | head -n1)"

if [ -z "$asset_url" ] || [ "$asset_url" = "null" ]; then
  echo "Unable to locate Nerd Fonts release asset: $asset" >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

curl -fsSL "$asset_url" -o "$tmpdir/$asset"
mkdir -p "$HOME/.local/share/fonts/JetBrainsMonoNerd"
unzip -o "$tmpdir/$asset" -d "$HOME/.local/share/fonts/JetBrainsMonoNerd" >/dev/null
fc-cache -fv "$HOME/.local/share/fonts/JetBrainsMonoNerd"
