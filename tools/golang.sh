#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

GO_VERSION="1.24.3"

if command -v go &>/dev/null; then
  echo "Go already installed: $(go version)"
  exit 0
fi

echo "Installing Go $GO_VERSION ($OS_NAME/$ARCH_NAME)..."

URL="https://go.dev/dl/go${GO_VERSION}.${OS_NAME}-${ARCH_NAME}.tar.gz"

curl -fsSLo /tmp/go.tar.gz "$URL"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz

# Add to PATH for current session
export PATH="/usr/local/go/bin:$PATH"

echo "-------------------------"
echo "Done. $(go version)"
echo "Add to your shell config: export PATH=\"/usr/local/go/bin:\$PATH\""
