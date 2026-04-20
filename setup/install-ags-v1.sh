#!/usr/bin/env bash
set -euo pipefail

sudo apt install -y \
  build-essential \
  gir1.2-gtk-4.0 \
  gir1.2-gtklayershell-0.1 \
  gjs \
  gobject-introspection \
  libadwaita-1-dev \
  libdbusmenu-gtk3-dev \
  libgirepository1.0-dev \
  libgjs-dev \
  libgtk-3-dev \
  libgtk-layer-shell-dev \
  libpam0g-dev \
  libpulse-dev \
  libsoup-3.0-dev \
  meson \
  ninja-build \
  node-typescript \
  npm \
  pkg-config

cd /tmp
rm -rf ags_v1.9.0
git clone --depth=1 https://github.com/JaKooLit/ags_v1.9.0.git
cd ags_v1.9.0
npm install
export PATH="$PWD/node_modules/.bin:$PATH"
meson setup build
sudo env PATH="$PATH" meson install -C build
