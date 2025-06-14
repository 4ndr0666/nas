# AGENTS.md — [ REPO-NAME HERE ]
# Repository Root: <repo>/        (branch: main)
#
# Purpose
# ───────
# [ WRITE DESCRIPTION HERE ]  
#
# Directory Summary
# ──────────────────
# ├── 0-tests
# │   └── codex-merge-clean.sh  # merge-artifact scrubber (must run pre-commit)
# ├── AGENTS.md                 # General initialization directives.
# ├── example1                  # example
# │   ├── example
# │   └── example.py
# ├── example2
# │   ├── example2.py
# │   └── slotlist2.py
# ├── example3
# │   ├── example3.py
# │   └── slotlist3.py
# ├── CODEX.md                    # Project specific instructions
#
# General Best Practices
# ──────────────────
# - Eliminate the potential for error by removing the human aspect; ensure the tasks you need done are handled via one-liners, functions or scripts and not by manual human input. 
# - Never use placeholders, half-measures, or omitted code lines. Provide all functional logic end-to-end.
# - Prioritize local scoping, strict error handling, and complete path resolution.
# - Always lint using ShellCheck where applicable. Adhere to XDG Base Directory Specification for file paths.
# - Automation must minimize user intervention while safeguarding system integrity.
# - All files must be cleaned of CODEX merge artifacts before any commit or pull request merge.
# - Use the utility: `0-tests/codex-merge-clean.sh <file ...>` to ensure no `<<<<<<<<<<<<<<<<<<<CODEX_`, `=========================`, or `>>>>>>>>>>>>>>>>>Main` blocks remain.
# - Run this tool after CODEX-assisted merges, and before lint, test, or commit stages.
#
# Canonical Workflow
# ──────────────────
#   git checkout -b feature/<task>
#   ./codex-merge-clean.sh $(git ls-files '*.sh' '*.py')
#   ruff --fix . && black .
#   pytest -q && pytest --cov=promptlib_redteam -q
#   git add -u && git commit -m "<type>: <message>"
#   pre-commit run --all-files
#
# Coding & Lint Standards
# ───────────────────────
# To ensure long-term maintainability, clarity, and correctness, all contributions and AI-assisted edits must ensure compliance with the following:
# - Use `printf` over `echo`, support non-interactive and piped use.
# - For scripts that modify system state, enforce `sudo` validation and log actions to `$XDG_DATA_HOME/logs/`.
# - All newly generated scripts must live in the appropriate category folder and be prefixed clearly (e.g., `ffx-*`, `exo-*`, `git-*`).
# - Avoid `&>` redirection. Use `>file 2>&1` consistently.
# - Validate all exports.
# - Avoid unbound or arbitrary variables—concretely assign all values.
# * Python 3.10+, PEP 8 via **ruff** auto-fix + **black** (88 cols).
# * Shell scripts: POSIX-sh, `set -euo pipefail`, pass **shellcheck** & **shfmt**.
# * Always implement `--help` & `--dry-run` in scripts affecting filesystem.
# * Log-files under `$XDG_DATA_HOME/redteam/logs/` or `var/prompt_logs/`.
# * No placeholders / truncated logic (see CODEX.md for merge policy).
# * Execute `codex-merge-clean.sh` on every changed file pre-commit.
#
# Validation Requirements
# ───────────────────────
# Ensure all functions explicitly check:
# - Return status of critical commands
# - Input/output validations
# - File existence and permission conditions
#
# Ensure all functions are:
# - **Well-defined and fully implemented**
# - **Idempotent** and **accessible**
# - **Logically isolated** with explicit error capture
# - **Variable declarations separate from assignments**
# - **Free from ambiguity, newlines, extraneous input, or bad splitting**
# - **Free of cyclomatic complexity**, using clear flow constructs
#
# XDG Compliance
# ──────────────
#   CONFIG ➜   ${XDG_CONFIG_HOME:-$HOME/.config}/redteam-prompts/
#   DATA   ➜   ${XDG_DATA_HOME:-$HOME/.local/share}/redteam-prompts/
#   CACHE  ➜   ${XDG_CACHE_HOME:-$HOME/.cache}/redteam-prompts/
#
# Required Tests (minimum)
# ────────────────────────
# 1. Slot-list non-empty & deduped.
# 2. 50 random prompts per category contain no placeholders.
# 3. CLI `--dry-run` returns 0.
# 4. Plugin loader picks up new YAML on runtime.
# 5. Prompts1 corpus lines are reachable (full subset).
# 6. Use `bats` or inline test harnesses where feasible.
# 7. Mock destructive commands in dry-run mode.
# 8. Ensure to execute the following pre-commit hook before a PR:
#
# ```bash
# #!/usr/bin/env bash
# set -e
# for f in $(git diff --cached --name-only); do
#     [ -f "$f" ] && 0-tests/codex-merge-clean.sh "$f"
# done
# git add .
# ```
#
# Merge & Review Protocol
# ───────────────────────
# 1. Disclose *function count* + *line count* for every revised script in PR body.
# 2. Attach coverage delta (`pytest-cov` output).
# 3. Reviewer runs:
#      pre-commit run --all-files
#      ./codex-merge-clean.sh $(git diff --name-only main..HEAD)
# 4. If merge artifacts remain, reject PR.
#
# Changelogs
# ──────────
# * Add entry to `0-tests/CHANGELOG.md` for multi-file changes.
# * Summarise outcome in `0-tests/task_outcome.md` post-merge.
#
# Authorization Guardrails
# ────────────────────────
# • Only operate on files/directories explicitly named in a work order.
# • Never bypass lint, dry-run, or coverage thresholds without written exception.
#
# End of AGENTS.md
