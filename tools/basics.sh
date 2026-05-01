#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

PACKAGES=(curl tar unzip zip git wget jq)

if [[ "$OS_NAME" == "darwin" ]]; then
  for pkg in "${PACKAGES[@]}"; do
    if ! command -v "$pkg" &>/dev/null; then
      echo "Installing $pkg..."
      brew install "$pkg"
    fi
  done

elif [[ "$OS_NAME" == "linux" ]]; then
  if command -v apt-get &>/dev/null; then
    sudo apt-get update -qq
    sudo apt-get install -y "${PACKAGES[@]}"
  elif command -v yum &>/dev/null; then
    sudo yum install -y "${PACKAGES[@]}"
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y "${PACKAGES[@]}"
  else
    echo "No supported package manager found (apt/yum/dnf)"
    exit 1
  fi
fi

echo "-------------------------"
echo "Done. Basic packages installed"
