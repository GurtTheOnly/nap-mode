#!/bin/bash
# uninstall.sh — remove the Nap Mode console install
set -o pipefail

PREFIX=/usr/local
ETC=/etc/nap-mode
SNIPPET_DIR="$HOME/.config/nap-mode"
SNIPPET="$SNIPPET_DIR/bash_profile-nap.sh"
SUDOERS=/etc/sudoers.d/nap-mode

if [[ $(id -u) -ne 0 ]]; then
  echo "uninstall.sh: run as root — sudo ./uninstall.sh" >&2
  exit 1
fi

echo "Removing Nap Mode install..."
rm -f "$PREFIX/bin/nap-console-style" "$PREFIX/bin/nap-mode"
rm -rf "$ETC" "$PREFIX/share/nap-mode"

if [[ -f "$SNIPPET" ]]; then
  echo "Removing login hook snippet..."
  rm -f "$SNIPPET"
  rmdir "$SNIPPET_DIR" 2>/dev/null || true
fi

if [[ -f "$SUDOERS" ]]; then
  echo "Removing sudoers rule..."
  rm -f "$SUDOERS"
fi

echo "Uninstalled. Reboot to fully clear the old palette on all VTs."