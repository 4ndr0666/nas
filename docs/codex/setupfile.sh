#!/usr/bin/env bash
# Author: 4ndr0666
set -euo pipefail
IFS=$'\n\t'
# ================== // CODEX SETUP SCRIPT //
## Description: Idempotent, repo-agnostic: ensures Python(venv), 
#               shell, CLI, Node, Docker, Go, Rust, lint, doc, 
#               and QA tools are present for any modern 
#               AI/dev workflow.
# -----------------------------------------------------------

# Global Constants & Exports

PYTHON_VERSION="${PYTHON_VERSION:-3.11.12}"
VENV_DIR="${VENV_DIR:-.venv-codex}"
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
export PATH="$PYENV_ROOT/bin:$PATH"
PM="" ; SUDO=""
command_exists() { command -v "$1" &>/dev/null; }
has_sudo() { command_exists sudo && SUDO="sudo"; }
has_sudo

# Package Manager

detect_pm() {
  if command_exists apt-get;   then PM="apt-get"
  elif command_exists dnf;     then PM="dnf"
  elif command_exists yum;     then PM="yum"
  elif command_exists brew;    then PM="brew"
  elif command_exists pacman;  then PM="pacman"
  else echo "No supported package manager found."; exit 1; fi
}
detect_pm

# Python Environment Setup

if command_exists pyenv; then
  eval "$(pyenv init --path 2>/dev/null || true)"
  eval "$(pyenv init - 2>/dev/null || true)"
  if ! pyenv versions --bare | grep -qxF "$PYTHON_VERSION"; then
    echo "Installing Python $PYTHON_VERSION with pyenv..."
    pyenv install "$PYTHON_VERSION"
  fi
  pyenv global "$PYTHON_VERSION"
  pyenv rehash
fi

if ! command_exists python3 && ! command_exists python; then
  echo "Python not found. Installing..."
  $SUDO $PM install -y python3 python3-venv python3-pip || true
fi

PYTHON_BIN="python"
command_exists python3 && PYTHON_BIN="python3"
if command_exists pyenv; then
  PYTHON_BIN="python"
fi

if [ ! -d "$VENV_DIR" ]; then
  echo "Creating Python virtual environment ($VENV_DIR)..."
  $PYTHON_BIN -m venv "$VENV_DIR"
fi
# shellcheck disable=SC1090
source "$VENV_DIR/bin/activate"
echo "Upgrading pip..."
python -m pip install --upgrade pip

PYTHON_TOOLS=(black ruff pyright flake8 isort mypy pytest pipx mdformat proselint pre-commit)
for pkg in "${PYTHON_TOOLS[@]}"; do
  python -m pip show "$pkg" &>/dev/null || python -m pip install "$pkg"
done
command_exists pipx && pipx ensurepath
command_exists yq || pipx install yq

# Shell/Bash Tooling

for util in shellcheck shfmt; do
  command_exists "$util" || { $SUDO $PM install -y "$util" || true; }
done
if ! command_exists bats; then
  echo "Installing bats-core..."
  git clone --depth 1 https://github.com/bats-core/bats-core.git /tmp/bats-core
  $SUDO /tmp/bats-core/install.sh /usr/local
  rm -rf /tmp/bats-core
fi

# CLI Utilities

CLI_UTILS=(jq fd-find ripgrep fzf yamllint universal-ctags)
for util in "${CLI_UTILS[@]}"; do
  command_exists "${util%%-*}" || { $SUDO $PM install -y "$util" || true; }
done
if command_exists fd-find && ! command_exists fd; then
  $SUDO ln -sf "$(command -v fd-find)" /usr/local/bin/fd
fi

# Markdown, YAML, Doc QA

if command_exists npm; then
  NODE_GLOBALS=(bash-language-server remark-cli remark-lint write-good npm-check-updates markdownlint-cli yaml-lint editorconfig-checker)
  for pkg in "${NODE_GLOBALS[@]}"; do
    npm list -g --depth=0 "$pkg" &>/dev/null || npm install -g "$pkg"
  done
fi

# Docker Tools 

if command_exists docker; then
  command_exists hadolint || { $SUDO $PM install -y hadolint || true; }
  command_exists docker-compose || { $SUDO $PM install -y docker-compose-plugin || true; }
fi

# EditorConfig

if command_exists npm; then
  command_exists editorconfig-checker || npm install -g editorconfig-checker
fi

# Node/JS/TS Tools

if command_exists npm; then
  NPM_TOOLS=(prettier eslint typescript ts-node)
  for tool in "${NPM_TOOLS[@]}"; do
    npm list -g --depth=0 "$tool" &>/dev/null || npm install -g "$tool"
  done
fi

# Go Tools

if command_exists go; then
  command_exists golint  || go install golang.org/x/lint/golint@latest
  command_exists gocyclo || go install github.com/fzipp/gocyclo/cmd/gocyclo@latest
fi

# Rust Tools

if command_exists cargo; then
  cargo install --list | grep -q cargo-audit || cargo install --locked cargo-audit
  cargo install --list | grep -q cargo-edit  || cargo install --locked cargo-edit
fi

cat <<EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✔ Universal Codex Project Environment Setup Complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# PYTHON

Python venv:    $VENV_DIR
Python version: $PYTHON_VERSION (via pyenv if present)
Python tools:   black, ruff, pyright, flake8, isort, mypy, pytest, pipx, mdformat, proselint, pre-commit, yq

# SHELL/BASH

Shell tools:    shellcheck, shfmt, bats-core

# CLI Utilities

CLI tools:      jq, fd, ripgrep, fzf, yamllint, universal-ctags

# DOC/QA

Doc/QA tools:   mdformat, proselint, write-good, markdownlint-cli, remark-cli, remark-lint

# LINT

Lint:           yamllint, shellcheck, shfmt, hadolint (if Docker), editorconfig-checker

# NODE/JS/TS

Node tools:     prettier, eslint, typescript, ts-node, npm-check-updates (if npm)

# DOCKER

Docker tools:   hadolint, docker-compose (if Docker)

# GO

Go tools:       golint, gocyclo (if Go)

# RUST

Rust tools:     cargo-audit, cargo-edit (if Rust)

Activate your Python venv in your shell:
    source $VENV_DIR/bin/activate

EOF
exit 0
