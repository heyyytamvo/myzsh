# myzsh

My personal shell setup for macOS (zsh) and Linux (bash). One command to bootstrap a new device.

## Setup

```bash
bash setup.sh
```

This installs everything and writes the shell config automatically.

## What gets installed

| Tool | macOS | Linux |
|---|---|---|
| Homebrew | ✅ | — |
| oh-my-zsh + plugins | ✅ | — |
| kube-ps1 | bundled in omz | ✅ cloned |
| kubectl + kubectx + kubens + k9s | ✅ | ✅ |
| AWS CLI | ✅ | ✅ |
| Terraform | ✅ | ✅ |
| Docker | — (manual) | ✅ amd64 only |
| Go 1.24.3 | ✅ | ✅ |

## Files

- `setup.sh` — main entry point
- `alias.sh` — shell aliases (kubectl, ssh, etc.), sourced into shell config
- `functions.sh` — `get_cluster_short()` and kube-ps1 config, sourced into shell config
- `myzsh.sh` — reference zshrc (not touched by setup)
- `tools/` — individual install scripts, each runnable standalone
- `tools/helpers.sh` — shared `detect_platform()` and `clone_plugin()` functions

## Run a single installer

```bash
bash tools/kubectl.sh
bash tools/aws.sh
bash tools/terraform.sh
bash tools/golang.sh
```
