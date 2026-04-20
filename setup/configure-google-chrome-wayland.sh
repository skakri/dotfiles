#!/usr/bin/env bash
set -euo pipefail

if ! command -v google-chrome-stable >/dev/null 2>&1; then
  exit 0
fi

mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications"

cat > "$HOME/.local/bin/google-chrome-wayland" <<'EOF'
#!/usr/bin/env bash
exec /usr/bin/google-chrome-stable \
  --enable-features=UseOzonePlatform \
  --ozone-platform=wayland \
  "$@"
EOF
chmod +x "$HOME/.local/bin/google-chrome-wayland"

if [ -f /usr/share/applications/google-chrome.desktop ]; then
  sed -E 's|^Exec=/usr/bin/google-chrome-stable(.*)$|Exec='"$HOME"'/.local/bin/google-chrome-wayland\1|' \
    /usr/share/applications/google-chrome.desktop \
    > "$HOME/.local/share/applications/google-chrome.desktop"
fi

command -v update-desktop-database >/dev/null 2>&1 && \
  update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true
