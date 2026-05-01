# myzsh

My personal shell setup for macOS and Linux. One command to bootstrap a new device.

## Setup

```bash
bash setup.sh
```

This installs everything and writes `~/.zshrc` automatically.

> **Linux:** Run as a non-root user (e.g. `ubuntu`), not `root` — scripts use `sudo` internally where needed. After setup, run `exec zsh` to switch shell (do not `source ~/.zshrc` from bash).

## What gets installed

| Tool | macOS | Linux |
|---|---|---|
| Homebrew | ✅ | — |
| Basic packages (curl, tar, unzip, zip, git, wget, jq) | ✅ | ✅ |
| zsh | built-in | ✅ |
| oh-my-zsh + plugins | ✅ | ✅ |
| kube-ps1 | bundled in omz | bundled in omz |
| kubectl + kubectx + kubens + k9s | ✅ | ✅ |
| AWS CLI | ✅ | ✅ |
| Terraform | ✅ | ✅ |
| Docker | — (manual) | ✅ |
| Go 1.24.3 | ✅ | ✅ |
| Helm | ✅ | ✅ |
| fzf (fuzzy search) | ✅ | ✅ |

## Files

- `setup.sh` — main entry point
- `alias.sh` — shell aliases (kubectl, ssh, git, aws, terraform, helm, etc.), sourced into shell config
- `functions.sh` — `get_cluster_short()` and kube-ps1 config, sourced into shell config
- `myzsh.sh` — reference zshrc (not touched by setup)
- `tools/` — individual install scripts, each runnable standalone
- `tools/helpers.sh` — shared `detect_platform()` and `clone_plugin()` functions

## Run a single installer

```bash
bash tools/basics.sh
bash tools/zsh.sh
bash tools/kubectl.sh
bash tools/aws.sh
bash tools/terraform.sh
bash tools/golang.sh
bash tools/helm.sh
bash tools/fzf.sh
```
