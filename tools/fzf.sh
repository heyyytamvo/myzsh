#!/usr/bin/env bash
set -euo pipefail

if command -v fzf &>/dev/null; then
  echo "fzf already installed: $(fzf --version)"
  exit 0
fi

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --all --no-update-rc

echo "-------------------------"
echo "Done. fzf $(fzf --version) installed"
