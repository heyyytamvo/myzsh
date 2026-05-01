#!/usr/bin/env bash

# Get my private IP
alias whatismyip='curl ipecho.net/plain'

# SSH without knowing hosts
alias tssh="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

# Alias for kubectl
if command -v kubectl &>/dev/null && command -v kubectx &>/dev/null && command -v kubens &>/dev/null; then
  alias k="kubectl"
  alias kg="kubectl get"
  alias ke="kubectl edit"

  # ctx / ns
  alias kx='kubectx'
  alias kn='kubens'

  # get
  alias kgn="kubectl get nodes"
  alias ks="kubectl get svc"
  alias kd="kubectl get deployment"
  alias kp="kubectl get pods"
  alias kpl="kubectl get pods -l"
  alias kpa="kubectl get pods --all-namespaces"

  # describe
  alias dsn="kubectl describe node"
  alias dss="kubectl describe svc"
  alias dsd="kubectl describe deployment"
  alias dsp="kubectl describe pod"

  # delete
  alias ddd="kubectl delete deployment"
  alias dds="kubectl delete svc"
  alias ddp="kubectl delete pod"

  alias kex="kubectl exec"
  alias klf="kubectl logs --tail=50 --follow"

  xx() {
    kubectl exec -it "${1}" -- "${@:2}"
  }
fi

# Alias for aws
if command -v aws &>/dev/null; then
  alias awsid="aws sts get-caller-identity"
  alias awskube="aws eks update-kubeconfig --name"
fi

# Alias for git
if command -v git &>/dev/null; then
  alias g="git"
  alias gss="git status"
  alias ga="git add"
  alias gd="git diff"
  alias gco="git checkout"
  alias gb="git branch"

  # commit
  alias gcm="git commit -m"
  alias gca="git commit --amend"
  alias gcane="git commit --amend --no-edit"

  # push
  alias gp="git push origin"
  alias gpf="git push --force-with-lease origin"

  # pull
  alias gpull="git pull"
  alias gpor="git pull --rebase"

  # merge
  alias gm="git merge"

  # stash
  alias gst="git stash"
  alias gstp="git stash pop"

  # log
  alias gl="git log --oneline --graph --decorate"
fi
