#!/usr/bin/env bash
set -euo pipefail

. /etc/os-release

# Ubuntu 24.04 can end up with stale libwayland runtime packages from older PPAs
# while only stock Noble libwayland-dev is available. Normalize them first so
# the rofi-wayland build dependencies can resolve cleanly.
if [ "${VERSION_ID:-}" = "24.04" ]; then
  noble_wayland_ver='1.22.0-2.1build1'
  installed_wayland_ver="$(dpkg-query -W -f='${Version}' libwayland-client0 2>/dev/null || true)"
  if [ -n "$installed_wayland_ver" ] && [ "$installed_wayland_ver" != "$noble_wayland_ver" ]; then
    sudo apt install -y --allow-downgrades \
      "libwayland-client0=$noble_wayland_ver" \
      "libwayland-cursor0=$noble_wayland_ver" \
      "libwayland-egl1=$noble_wayland_ver" \
      "libwayland-server0=$noble_wayland_ver" \
      "libwayland-bin=$noble_wayland_ver" \
      "libwayland-dev=$noble_wayland_ver"
  fi
fi

sudo apt install -y \
  bison \
  cppcheck \
  doxygen \
  flex \
  imagemagick \
  libcairo-5c-dev \
  libcairo2-dev \
  libgdk-pixbuf-2.0-dev \
  libmpdclient-dev \
  libnl-3-dev \
  libasound2-dev \
  libpango1.0-dev \
  libstartup-notification0-dev \
  libwayland-client++1 \
  libwayland-client0 \
  libwayland-dev \
  libxcb-cursor-dev \
  libxcb-ewmh-dev \
  libxcb-icccm4-dev \
  libxcb-keysyms1-dev \
  libxcb-randr0-dev \
  libxcb-render-util0-dev \
  libxcb-util-dev \
  libxcb-xinerama0-dev \
  libxcb-xkb-dev \
  libxkbcommon-dev \
  libxkbcommon-x11-dev \
  meson \
  ninja-build \
  ohcount \
  pandoc \
  wget

cd /tmp
rm -rf rofi-1.7.8+wayland1 rofi-1.7.8+wayland1.tar.gz
wget https://github.com/lbonn/rofi/releases/download/1.7.8%2Bwayland1/rofi-1.7.8+wayland1.tar.gz
tar xf rofi-1.7.8+wayland1.tar.gz
cd rofi-1.7.8+wayland1
meson setup build
ninja -C build
sudo ninja -C build install
