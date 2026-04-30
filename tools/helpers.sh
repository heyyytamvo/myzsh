#!/usr/bin/env bash
# Sourced by setup.sh and tool scripts — do not execute directly.

# ── OS / arch detection ───────────────────────────────────────────────────────
detect_platform() {
  local os arch

  case "$(uname -s)" in
    Darwin) os="darwin" ;;
    Linux)  os="linux"  ;;
    *) echo "Unsupported OS: $(uname -s)"; return 1 ;;
  esac

  case "$(uname -m)" in
    arm64|aarch64) arch="arm64" ;;
    x86_64|amd64)  arch="amd64" ;;
    *) echo "Unsupported architecture: $(uname -m)"; return 1 ;;
  esac

  OS_NAME="$os"
  ARCH_NAME="$arch"
  echo "Detected: $OS_NAME/$ARCH_NAME"
}

# ── oh-my-zsh plugin installer ────────────────────────────────────────────────
clone_plugin() {
  local repo="$1" name="$2"
  local dest="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$name"
  if [[ ! -d "$dest" ]]; then
    echo "Installing plugin: $name"
    git clone --depth=1 "$repo" "$dest"
  fi
}
