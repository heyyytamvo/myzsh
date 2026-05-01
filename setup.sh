#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$REPO_DIR/tools/helpers.sh"
detect_platform

# ── Homebrew (macOS only) ─────────────────────────────────────────────────────
[[ "$OS_NAME" == "darwin" ]] && bash "$REPO_DIR/tools/brew.sh"

# ── Basic packages ────────────────────────────────────────────────────────────
bash "$REPO_DIR/tools/basics.sh"

# ── oh-my-zsh + plugins (macOS only) ─────────────────────────────────────────
if [[ "$OS_NAME" == "darwin" ]]; then
  bash "$REPO_DIR/tools/oh-my-zsh.sh"
  clone_plugin https://github.com/zsh-users/zsh-autosuggestions       zsh-autosuggestions
  clone_plugin https://github.com/zsh-users/zsh-syntax-highlighting    zsh-syntax-highlighting
  clone_plugin https://github.com/fdellwing/zsh-bat                    zsh-bat
  # kube-ps1 is bundled with oh-my-zsh, no clone needed
fi

# ── kube-ps1 (Linux only) ────────────────────────────────────────────────────
if [[ "$OS_NAME" == "linux" ]] && [[ ! -d "$HOME/.kube-ps1" ]]; then
  git clone --depth=1 https://github.com/jonmosco/kube-ps1 "$HOME/.kube-ps1"
fi

# ── kubectl kubectx kubens k9s ───────────────────────────────────────────────
bash "$REPO_DIR/tools/kubectl.sh"

# ── AWS CLI ───────────────────────────────────────────────────────────────────
bash "$REPO_DIR/tools/aws.sh"

# ── Terraform ─────────────────────────────────────────────────────────────────
bash "$REPO_DIR/tools/terraform.sh"

# ── Docker (Linux only) ───────────────────────────────────────────────────────
[[ "$OS_NAME" == "linux" ]] && bash "$REPO_DIR/tools/docker.sh"

# ── Go ────────────────────────────────────────────────────────────────────────
bash "$REPO_DIR/tools/golang.sh"

# ── fzf ───────────────────────────────────────────────────────────────────────
bash "$REPO_DIR/tools/fzf.sh"

# ── shell config ──────────────────────────────────────────────────────────────
if [[ "$OS_NAME" == "darwin" ]]; then
  SHELL_RC="$HOME/.zshrc"
else
  SHELL_RC="$HOME/.bashrc"
fi

if [[ -f "$SHELL_RC" && ! -L "$SHELL_RC" ]]; then
  cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%s)"
  echo "Backed up existing $SHELL_RC"
fi

if [[ "$OS_NAME" == "linux" ]]; then
cat > "$SHELL_RC" <<EOF
source "$REPO_DIR/alias.sh"
source "$REPO_DIR/functions.sh"
source "\$HOME/.kube-ps1/kube-ps1.sh"
[ -f "\$HOME/.fzf.bash" ] && source "\$HOME/.fzf.bash"
export PATH="/usr/local/go/bin:\$PATH"
EOF
else
cat > "$SHELL_RC" <<EOF
source "$REPO_DIR/alias.sh"
source "$REPO_DIR/functions.sh"
[ -f "\$HOME/.fzf.zsh" ] && source "\$HOME/.fzf.zsh"
export PATH="/usr/local/go/bin:\$PATH"
EOF
fi

echo ""
echo "Done. Start a new shell"
