#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

if [[ "$ARCH_NAME" != "amd64" ]]; then
  echo "Docker install only supported on amd64 (detected: $ARCH_NAME)"
  exit 1
fi

if command -v docker &>/dev/null; then
  echo "Docker already installed"
  exit 0
fi

echo "Installing Docker ($OS_NAME/amd64)..."

if [[ "$OS_NAME" == "linux" ]]; then
  curl -fsSL https://get.docker.com | sh
fi

echo "-------------------------"
echo "Done. Docker installed"
