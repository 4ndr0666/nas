#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# ==================== // CODEX SETUP SCRIPT // ====================
## Universal, idempotent development environment setup for CODEX project containers.
## Installs Python, shell, Node, lint, QA, and doc tools if missing.
# ------------------------------------------------------------------

## --------- Global Constants and Utilities ----------
PM="apt-get"
SUDO="sudo"

command_exists() { command -v "$1" &>/dev/null; }

## --------- Python Environment ---------
PYTHON_VERSION="3.11.12"
VENV_DIR=".codex-venv"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

if ! pyenv versions --bare | grep -q "^${PYTHON_VERSION}$"; then
    echo "Installing Python ${PYTHON_VERSION}..."
    pyenv install "${PYTHON_VERSION}"
fi
pyenv global "${PYTHON_VERSION}"
pyenv rehash

if [ ! -d "${VENV_DIR}" ]; then
    echo "Creating Python virtual environment..."
    python -m venv "${VENV_DIR}"
fi
# shellcheck disable=SC1090
source "${VENV_DIR}/bin/activate"

echo "Upgrading pip..."
python -m pip install --upgrade pip

PYTHON_TOOLS=(black pyright flake8 isort mypy pytest pipx mdformat proselint pre-commit)
for pkg in "${PYTHON_TOOLS[@]}"; do
    if ! python -m pip show "$pkg" &>/dev/null; then
        echo "Installing Python tool: $pkg"
        python -m pip install "$pkg"
    fi
done

# Ensure pipx PATH
if command_exists pipx; then
    pipx ensurepath
fi

# yq (modern YAML CLI, via pipx for isolation)
if ! command_exists yq; then
    echo "Installing yq (YAML CLI via pipx)..."
    pipx install yq
fi

## --------- Shell/Bash Tooling ---------
# Install shellcheck, shfmt, bats-core only if missing
if ! command_exists shellcheck; then
    $SUDO $PM update -y || true
    $SUDO $PM install -y shellcheck || true
fi
if ! command_exists shfmt; then
    $SUDO $PM install -y shfmt || true
fi
if ! command_exists bats; then
    echo "Installing bats-core (Bash test framework)..."
    git clone --depth 1 https://github.com/bats-core/bats-core.git /tmp/bats-core
    $SUDO /tmp/bats-core/install.sh /usr/local
    rm -rf /tmp/bats-core
fi

## --------- Modern CLI Utilities ---------
# jq, fd, ripgrep, fzf, yamllint, universal-ctags
for util in jq fd-find ripgrep fzf yamllint universal-ctags; do
    if ! command_exists "${util%%-*}"; then
        $SUDO $PM install -y "$util" || true
    fi
done

# fd alias for Ubuntu/Debian ("fd-find" -> "fd")
if command_exists fd-find && ! command_exists fd; then
    $SUDO ln -sf "$(command -v fd-find)" /usr/local/bin/fd
fi

## --------- Markdown, YAML, Doc QA ---------
if command_exists npm; then
    NODE_GLOBALS=(
        bash-language-server
        remark-cli
        remark-lint
        write-good
        npm-check-updates
        markdownlint-cli
        yaml-lint
        editorconfig-checker
    )
    for pkg in "${NODE_GLOBALS[@]}"; do
        if ! npm list -g --depth=0 "$pkg" &>/dev/null; then
            npm install -g "$pkg"
        fi
    done
fi

# proselint already installed via pip above

## --------- Docker Tools ---------
if command_exists docker; then
    if ! command_exists hadolint; then
        $SUDO $PM install -y hadolint || true
    fi
    if ! command_exists docker-compose; then
        $SUDO $PM install -y docker-compose-plugin || true
    fi
fi

## --------- EditorConfig ---------
if command_exists npm; then
    if ! command_exists editorconfig-checker; then
        npm install -g editorconfig-checker
    fi
fi

## --------- Node/JS/TS Tools (optional) ---------
if command_exists npm; then
    NPM_TOOLS=(prettier eslint typescript ts-node)
    for tool in "${NPM_TOOLS[@]}"; do
        if ! npm list -g --depth=0 "$tool" &>/dev/null; then
            npm install -g "$tool"
        fi
    done
fi

## --------- Go Tools (optional) ---------
if command_exists go; then
    if ! command_exists golint; then
        go install golang.org/x/lint/golint@latest
    fi
    if ! command_exists gocyclo; then
        go install github.com/fzipp/gocyclo/cmd/gocyclo@latest
    fi
fi

## --------- Rust Tools (optional) ---------
if command_exists cargo; then
    if ! cargo install --list | grep -q cargo-audit; then
        cargo install --locked --root "$HOME/.cargo" cargo-audit || true
    fi
    if ! cargo install --list | grep -q cargo-edit; then
        cargo install --locked --root "$HOME/.cargo" cargo-edit || true
    fi
fi

## --------- Print Summary ---------
cat <<EOF

Setup complete!

# ---- PYTHON ----
  venv: $VENV_DIR
  Python version: $PYTHON_VERSION
  Installed: black, pyright, flake8, isort, mypy, pytest, pipx, mdformat, proselint, pre-commit, yq

# ---- SHELL/BASH ----
  Installed: shellcheck, shfmt, bats-core

# ---- CLI Utilities ----
  Installed: jq, yq, fd, ripgrep, fzf, yamllint, universal-ctags

# ---- DOC/QA ----
  Installed: mdformat, proselint, write-good, markdownlint-cli, remark-cli, remark-lint

# ---- LINT ----
  Installed: yamllint, shellcheck, shfmt, hadolint (if Docker), editorconfig-checker

# ---- NODE/JS/TS ----
  Installed: prettier, eslint, typescript, ts-node, npm-check-updates (if npm available)

# ---- DOCKER ----
  Installed: hadolint, docker-compose (if Docker available)

# ---- GO ----
  Installed: golint, gocyclo (if Go present)

# ---- RUST ----
  Installed: cargo-audit, cargo-edit (if Rust present)

To activate Python venv in your shell:
    source $VENV_DIR/bin/activate

All installs are idempotent; nothing is reinstalled unless missing.

EOF
