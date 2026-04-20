#!/usr/bin/env bash
set -euo pipefail

if command -v wallust >/dev/null 2>&1; then
  exit 0
fi

sudo apt install -y build-essential curl pkg-config libssl-dev

if ! command -v cargo >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# shellcheck disable=SC1091
source "$HOME/.cargo/env"
cargo install wallust
sudo install -m 0755 "$HOME/.cargo/bin/wallust" /usr/local/bin/wallust
