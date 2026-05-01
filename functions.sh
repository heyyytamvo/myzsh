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
