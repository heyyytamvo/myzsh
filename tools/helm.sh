#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

if command -v helm &>/dev/null; then
  echo "Helm already installed: $(helm version --short)"
  exit 0
fi

echo "Installing Helm ($OS_NAME/$ARCH_NAME)..."

HELM_VERSION="$(curl -fsSL https://api.github.com/repos/helm/helm/releases/latest | jq -r '.tag_name')"
curl -fsSLo /tmp/helm.tar.gz \
  "https://get.helm.sh/helm-${HELM_VERSION}-${OS_NAME}-${ARCH_NAME}.tar.gz"
tar -xzf /tmp/helm.tar.gz -C /tmp/
sudo mv "/tmp/${OS_NAME}-${ARCH_NAME}/helm" /usr/local/bin/helm
rm -rf /tmp/helm.tar.gz "/tmp/${OS_NAME}-${ARCH_NAME}"

echo "-------------------------"
echo "Done. $(helm version --short)"
