###############################################################################
# AGENTS.md — Universal Codex Agent Manifest
# Purpose:
#   • Defines operational guardrails and quality requirements for *all* agent-
#     mediated projects using OpenAI Codex, regardless of repo or scope.
#
# File Hierarchy:
#   - AGENTS.md         # This file (root manifest, never project-specific)
#   - CODEX.md          # Project-specific work order, regenerated per sprint
#   - 0-tests/          # Utility scripts, hooks, tests, changelogs
#
# --------------------------------------------------------------------------- #
# UNIVERSAL RULES FOR ALL CODEX OPERATIONS
# --------------------------------------------------------------------------- #
#
# Coding Standards:
#   • Python: PEP 8, auto-format with black (88 cols), lint with ruff (all fixes).
#   • Shell:  POSIX-sh, strict mode (set -euo pipefail), passes shellcheck -x,
#     shfmt -i 2 -ci -sr.
#   • All code and doc changes must pass pre-commit and merge-clean before PR.
#
# Repository Hygiene:
#   • No editor swap files, core dumps, or binaries may be committed.
#   • All runtime artefacts and logs must be ignored or placed under var/, tmp/,
#     or $XDG_*_HOME subdirs.
#   • All scripts that mutate files must implement --help and --dry-run.
#
# Merge Protocol:
#   • All PRs must include function count, line count, and coverage delta.
#   • Every staged file must be scrubbed with codex-merge-clean.sh before commit.
#   • PRs must pass all acceptance criteria listed in the current CODEX.md.
#   • If any acceptance test fails, Codex must block merge and print the failing step.
#
# Testing:
#   • pytest or equivalent coverage: ≥85% for all core modules.
#   • At least one test for every CLI, script, or generator added in the sprint.
#   • Reviewer may request a test for any logic, at any time.
#
# XDG Compliance:
#   • Place config in ${XDG_CONFIG_HOME:-$HOME/.config}/<project>
#   • Place runtime files in ${XDG_DATA_HOME:-$HOME/.local/share}/<project>
#   • Place cache in ${XDG_CACHE_HOME:-$HOME/.cache}/<project>
#
# Authorization Guardrails:
#   • Only operate on files/directories explicitly named in the current work order.
#   • Never relax linter, dry-run, or test requirements without explicit approval.
#
# Documentation:
#   • Every repository must have an up-to-date README.md summarizing purpose,
#     installation, quick-start, and contributing.
#   • CODEX.md and AGENTS.md must always be present at root.
#   • Scripts must have top-of-file comments with purpose, usage, and author/date.
#
# End of AGENTS.md (Universal Template)
###############################################################################
