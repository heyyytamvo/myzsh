#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

if command -v aws &>/dev/null; then
  echo "AWS CLI already installed: $(aws --version)"
  exit 0
fi

echo "Installing AWS CLI ($OS_NAME/$ARCH_NAME)..."

if [[ "$OS_NAME" == "darwin" ]]; then
  # Universal pkg works for both arm64 and amd64
  curl -fsSLo /tmp/AWSCLIV2.pkg https://awscli.amazonaws.com/AWSCLIV2.pkg
  sudo installer -pkg /tmp/AWSCLIV2.pkg -target /
  rm /tmp/AWSCLIV2.pkg

elif [[ "$OS_NAME" == "linux" ]]; then
  if [[ "$ARCH_NAME" == "arm64" ]]; then
    URL="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
  else
    URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
  fi

  curl -fsSLo /tmp/awscliv2.zip "$URL"
  unzip -q /tmp/awscliv2.zip -d /tmp/
  sudo /tmp/aws/install
  rm -rf /tmp/awscliv2.zip /tmp/aws
fi

echo "-------------------------"
echo "Done. $(aws --version)"
