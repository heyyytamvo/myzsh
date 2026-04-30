#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

if ! command -v kubectl &>/dev/null; then
  echo "Installing kubectl ($OS_NAME/$ARCH_NAME)..."
  KUBECTL_VERSION="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"
  curl -fsSLo /tmp/kubectl \
    "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${OS_NAME}/${ARCH_NAME}/kubectl"
  chmod +x /tmp/kubectl
  sudo mv /tmp/kubectl /usr/local/bin/kubectl
  echo "kubectl $KUBECTL_VERSION installed"
fi

if ! command -v kubectx &>/dev/null; then
  echo "Installing kubectx ($OS_NAME/$ARCH_NAME)..."
  KUBECTX_VERSION="$(curl -fsSL https://api.github.com/repos/ahmetb/kubectx/releases/latest | grep -o '"tag_name":"[^"]*"' | cut -d'"' -f4)"
  curl -fsSLo /tmp/kubectx \
    "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx_${KUBECTX_VERSION}_${OS_NAME}_${ARCH_NAME}.tar.gz"
  tar -xzf /tmp/kubectx -C /tmp/ kubectx
  sudo mv /tmp/kubectx /usr/local/bin/kubectx
  rm /tmp/kubectx* 2>/dev/null || true
  echo "kubectx $KUBECTX_VERSION installed"
fi

if ! command -v kubens &>/dev/null; then
  echo "Installing kubens ($OS_NAME/$ARCH_NAME)..."
  KUBENS_VERSION="$(curl -fsSL https://api.github.com/repos/ahmetb/kubectx/releases/latest | grep -o '"tag_name":"[^"]*"' | cut -d'"' -f4)"
  curl -fsSLo /tmp/kubens.tar.gz \
    "https://github.com/ahmetb/kubectx/releases/download/${KUBENS_VERSION}/kubens_${KUBENS_VERSION}_${OS_NAME}_${ARCH_NAME}.tar.gz"
  tar -xzf /tmp/kubens.tar.gz -C /tmp/ kubens
  sudo mv /tmp/kubens /usr/local/bin/kubens
  rm /tmp/kubens.tar.gz
  echo "kubens $KUBENS_VERSION installed"
fi

if ! command -v k9s &>/dev/null; then
  echo "Installing k9s ($OS_NAME/$ARCH_NAME)..."
  K9S_VERSION="$(curl -fsSL https://api.github.com/repos/derailed/k9s/releases/latest | grep -o '"tag_name":"[^"]*"' | cut -d'"' -f4)"
  # k9s uses capitalized OS in filenames: Darwin, Linux
  case "$OS_NAME" in
    darwin) K9S_OS="Darwin" ;;
    linux)  K9S_OS="Linux"  ;;
  esac
  curl -fsSLo /tmp/k9s.tar.gz \
    "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_${K9S_OS}_${ARCH_NAME}.tar.gz"
  tar -xzf /tmp/k9s.tar.gz -C /tmp/ k9s
  sudo mv /tmp/k9s /usr/local/bin/k9s
  rm /tmp/k9s.tar.gz
  echo "k9s $K9S_VERSION installed"
fi
