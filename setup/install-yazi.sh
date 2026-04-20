#!/usr/bin/env bash
set -euo pipefail

if command -v yazi >/dev/null 2>&1; then
  exit 0
fi

if ! command -v snap >/dev/null 2>&1; then
  echo "snap is not available; skipping yazi install" >&2
  exit 0
fi

sudo snap install yazi --classic
