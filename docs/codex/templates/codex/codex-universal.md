###############################################################################
# CODEX.md — Universal Codex Work Order Template
# Purpose: Per-sprint work order, task breakdown, and acceptance criteria for
#          Codex-driven projects. Regenerate for each unique project or sprint.
###############################################################################

## 0. SCOPE & CONTEXT

> Codex must **ONLY** act on the files and directories named in this work order.
> Any operation beyond this scope requires explicit new approval and update of
> this file.

* Repository:         <REPO-URL>
* Branch:             <feature/sprint-branch>
* Reference date:     <YYYY-MM-DD>
* Exclusions:         (policy, CI/CD, etc as needed)

---

## 1. ENVIRONMENT BOOTSTRAP

```bash
# Clone, branch, set up venv and core dependencies.
git clone <repo-url> <project-dir>
cd <project-dir>
git checkout -b <feature/sprint-branch>
python -m venv .venv
source .venv/bin/activate
pip install -U pip wheel ruff black pytest pytest-cov
````

---

## 2. DELIVERABLE MATRIX

| ID | Deliverable    | Acceptance Test / What Codex Must Validate |
| -- | -------------- | ------------------------------------------ |
| D1 | <Concise desc> | \<How will Codex or reviewer check?>       |
| D2 | ...            | ...                                        |

*All acceptance criteria must be listed. Codex must block merge if any fail.*

---

## 3. TASK BREAKDOWN

> List tasks A, B, … with **step-by-step explicit shell commands or script stubs**.
> Codex executes in order, commits after each deliverable or atomic group.

### A. <First Task Name>

```bash
# Example: Rename core module
git mv old_core.py new_core.py
# Update imports
sed -i 's/old_core/new_core/g' *.py
```

### B. <Second Task Name>

...

---

## 4. CODING & TESTING RULES

* **Python**: PEP 8, black, ruff. All scripts: --help/--dry-run if mutating.
* **Shell**: POSIX, shellcheck, shfmt.
* **No TODO/placeholder code** may be present in final PR.
* **pytest** or equivalent, coverage ≥ 85% on changed files.
* Commit: `feat:`, `fix:`, `test:`, `docs:`, `chore:`, etc.
* Run `./0-tests/codex-merge-clean.sh` on all files before each commit.

---

## 5. MERGE & REVIEW PROTOCOL

* PR body must enumerate tasks completed, coverage delta, and function/LOC diffs.
* Reviewer must run:

  * `pre-commit run --all-files`
  * `./0-tests/codex-merge-clean.sh $(git diff --name-only main..HEAD)`
* No PR may be merged if acceptance tests or code standards fail.

---

## 6. TIMELINE & HANDOVER

| Day | AM                        | PM          |
| --- | ------------------------- | ----------- |
| 1   | Tasks A + B               | Tasks C + D |
| 2   | Docs + Final review/tests | Merge       |

---

## 7. FAILURE HANDLING

* Codex must output failed command + stderr and block pipeline on first failure.
* Partial deliverables must remain in Draft PR.

---

## 8. POST-SPRINT (OPTIONAL/FUTURE)

* CI/CD, policy filters, Dockerfile, new features, etc.

---

# End of Universal CODEX.md Template

\###############################################################################
