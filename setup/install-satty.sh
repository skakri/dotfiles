#!/usr/bin/env bash
set -euo pipefail

if command -v satty >/dev/null 2>&1; then
  exit 0
fi

api_url='https://api.github.com/repos/gabm/Satty/releases/latest'
asset_url="$(curl -fsSL "$api_url" | jq -r '.assets[] | select(.name | test("x86_64.*(linux|gnu)|linux.*x86_64|tar.gz$")) | .browser_download_url' | head -n1)"

if [ -z "$asset_url" ] || [ "$asset_url" = "null" ]; then
  echo "Unable to locate a Satty x86_64 release asset" >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

asset_name="$(basename "$asset_url")"
curl -fsSL "$asset_url" -o "$tmpdir/$asset_name"

case "$asset_name" in
  *.tar.gz|*.tgz)
    tar -xf "$tmpdir/$asset_name" -C "$tmpdir"
    ;;
  *.zip)
    unzip -o "$tmpdir/$asset_name" -d "$tmpdir" >/dev/null
    ;;
  *)
    echo "Unsupported Satty asset format: $asset_name" >&2
    exit 1
    ;;
esac

satty_bin="$(find "$tmpdir" -type f -name satty | head -n1)"
if [ -z "$satty_bin" ]; then
  echo "Satty binary not found in extracted asset" >&2
  exit 1
fi

sudo install -m 0755 "$satty_bin" /usr/local/bin/satty
