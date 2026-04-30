# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal shell setup repo — bootstraps a new macOS (zsh) or Linux (bash) device with one command: `bash setup.sh`.

## Architecture

`setup.sh` is the orchestrator. It sources `tools/helpers.sh` to get `detect_platform()` (sets `$OS_NAME` and `$ARCH_NAME`), then calls each tool installer as a bash subprocess. At the end it writes a shell config file (`.zshrc` on Mac, `.bashrc` on Linux) that sources `alias.sh` and `functions.sh` from this repo.

Individual scripts in `tools/` are self-contained and runnable standalone — they each source `helpers.sh` themselves.

`myzsh.sh` is a reference zshrc only — it is never sourced or modified by any script.

## Key files

- `tools/helpers.sh` — shared functions: `detect_platform()` sets `$OS_NAME`/`$ARCH_NAME`; `clone_plugin()` clones oh-my-zsh custom plugins
- `alias.sh` — kubectl/ssh aliases; uses `command -v` (bash+zsh compatible); guards all kubectl aliases behind a single `if command -v kubectl && kubectx && kubens`
- `functions.sh` — `get_cluster_short()` for kube-ps1 prompt, plus kube-ps1 env vars
- `tools/kubectl.sh` — installs kubectl, kubectx, kubens, k9s; note k9s uses capitalized OS in release filenames (`Darwin`/`Linux`) unlike the others

## Conventions

- All scripts use `#!/usr/bin/env bash` — runs bash on both Mac and Linux regardless of login shell
- OS/arch detection always goes through `detect_platform()` from `helpers.sh` — never call `uname` directly in tool scripts
- Tool scripts skip installation if the binary already exists (`command -v` check at top)
- Docker is Linux/amd64 only — on Mac it is installed manually
- oh-my-zsh and its plugins are Mac-only; kube-ps1 is cloned separately on Linux to `~/.kube-ps1`
