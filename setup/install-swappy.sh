#!/usr/bin/env bash
set -euo pipefail

if command -v swappy >/dev/null 2>&1; then
  exit 0
fi

sudo apt install -y \
  gettext \
  libcairo2-dev \
  libglib2.0-dev \
  libgtk-3-dev \
  libpango1.0-dev \
  meson \
  ninja-build \
  scdoc

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

git clone --depth=1 https://github.com/jtheoof/swappy.git "$tmpdir/swappy"
cd "$tmpdir/swappy"
meson setup build
ninja -C build
sudo ninja -C build install
