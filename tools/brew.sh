#!/usr/bin/env bash
set -euo pipefail

# Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
  else
    eval "$(/usr/local/bin/brew shellenv)"       # Intel
  fi
fi

echo "-------------------------"
echo "Done. Homebrew installed"
