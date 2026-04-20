#!/usr/bin/env bash
set -euo pipefail

if command -v fastfetch >/dev/null 2>&1; then
  exit 0
fi

arch="$(dpkg --print-architecture)"
case "$arch" in
  amd64) asset='fastfetch-linux-amd64.deb' ;;
  arm64) asset='fastfetch-linux-aarch64.deb' ;;
  *)
    echo "Unsupported architecture for fastfetch helper: $arch" >&2
    exit 1
    ;;
esac

api_url='https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest'
asset_url="$(curl -fsSL "$api_url" | jq -r --arg asset "$asset" '.assets[] | select(.name == $asset) | .browser_download_url' | head -n1)"

if [ -z "$asset_url" ] || [ "$asset_url" = "null" ]; then
  echo "Unable to locate fastfetch release asset: $asset" >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

curl -fsSL "$asset_url" -o "$tmpdir/$asset"
sudo apt install -y "$tmpdir/$asset"
