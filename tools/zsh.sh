#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

if [[ "$OS_NAME" != "linux" ]]; then
  echo "zsh install via this script is Linux only (macOS has zsh built-in)"
  exit 0
fi

if command -v zsh &>/dev/null; then
  echo "zsh already installed: $(zsh --version)"
  exit 0
fi

echo "Installing zsh..."

if command -v apt-get &>/dev/null; then
  sudo apt-get update -qq
  sudo apt-get install -y zsh
elif command -v yum &>/dev/null; then
  sudo yum install -y zsh
elif command -v dnf &>/dev/null; then
  sudo dnf install -y zsh
else
  echo "No supported package manager found (apt/yum/dnf)"
  exit 1
fi

# Set zsh as default shell
chsh -s "$(which zsh)"

echo "-------------------------"
echo "Done. $(zsh --version)"
echo "Re-login to start using zsh"
