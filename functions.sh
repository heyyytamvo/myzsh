#!/usr/bin/env bash

# kube-ps1
KUBE_PS1_PREFIX=""
KUBE_PS1_SUFFIX=""
KUBE_PS1_COLOR=""

function get_cluster_short() {
  local arn="$1"
  local region=$(echo "$arn" | cut -d ':' -f4)
  local cluster_name=$(echo "$arn" | cut -d '/' -f2)
  echo "$region:$cluster_name"
}

export KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short

# Generate private.pem and public.pub in current directory
function genkey() {
  local name="${1:-private}"
  ssh-keygen -t ed25519 -f "${name}.pem" -N ""
  mv "${name}.pem.pub" "${name}.pub"
  echo "Generated: ${name}.pem and ${name}.pub"
}