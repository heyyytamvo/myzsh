#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$REPO_DIR/tools/helpers.sh"
detect_platform

# ── Homebrew (macOS only) ─────────────────────────────────────────────────────
[[ "$OS_NAME" == "darwin" ]] && bash "$REPO_DIR/tools/brew.sh"

# ── Basic packages ────────────────────────────────────────────────────────────
bash "$REPO_DIR/tools/basics.sh"

# ── zsh (Linux only) ─────────────────────────────────────────────────────────
[[ "$OS_NAME" == "linux" ]] && bash "$REPO_DIR/tools/zsh.sh"

# ── oh-my-zsh + plugins ───────────────────────────────────────────────────────
bash "$REPO_DIR/tools/oh-my-zsh.sh"
clone_plugin https://github.com/zsh-users/zsh-autosuggestions       zsh-autosuggestions
clone_plugin https://github.com/zsh-users/zsh-syntax-highlighting    zsh-syntax-highlighting
clone_plugin https://github.com/fdellwing/zsh-bat                    zsh-bat
# kube-ps1 is bundled with oh-my-zsh, no clone needed

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

# ── Helm ──────────────────────────────────────────────────────────────────────
bash "$REPO_DIR/tools/helm.sh"

# ── fzf ───────────────────────────────────────────────────────────────────────
bash "$REPO_DIR/tools/fzf.sh"

# ── shell config (.zshrc on both platforms) ───────────────────────────────────
SHELL_RC="$HOME/.zshrc"

if [[ -f "$SHELL_RC" && ! -L "$SHELL_RC" ]]; then
  cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%s)"
  echo "Backed up existing $SHELL_RC"
fi

cat > "$SHELL_RC" <<EOF
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="gnzh"
plugins=(git zsh-autosuggestions zsh-bat zsh-syntax-highlighting kube-ps1)
source "\$ZSH/oh-my-zsh.sh"
PROMPT='\$(kube_ps1)'\$PROMPT

source "$REPO_DIR/alias.sh"
source "$REPO_DIR/functions.sh"
[ -f "\$HOME/.fzf.zsh" ] && source "\$HOME/.fzf.zsh"
export PATH="/usr/local/go/bin:\$PATH"
EOF

echo ""
echo "Done. Start a new shell: exec zsh"
