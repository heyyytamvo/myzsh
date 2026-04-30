#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
detect_platform

if command -v terraform &>/dev/null; then
  echo "Terraform already installed: $(terraform version | head -1)"
  exit 0
fi

echo "Installing Terraform ($OS_NAME/$ARCH_NAME)..."

TERRAFORM_VERSION="$(curl -fsSL https://checkpoint-api.hashicorp.com/v1/check/terraform | grep -o '"current_version":"[^"]*"' | cut -d'"' -f4)"
URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OS_NAME}_${ARCH_NAME}.zip"

curl -fsSLo /tmp/terraform.zip "$URL"
unzip -q /tmp/terraform.zip -d /tmp/
sudo mv /tmp/terraform /usr/local/bin/terraform
rm /tmp/terraform.zip

echo "-------------------------"
echo "Done. $(terraform version | head -1)"
