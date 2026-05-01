#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

if command -v docker &>/dev/null; then
  echo "Docker already installed"
  exit 0
fi

if [[ "$OS_NAME" == "linux" ]]; then
  echo "Installing Docker ($OS_NAME/$ARCH_NAME)..."
  curl -fsSL https://get.docker.com | sh
fi

echo "-------------------------"
echo "Done. Docker installed"
