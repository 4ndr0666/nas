#!/usr/bin/env python3
"""
Universal CODEX.md Work Order Generator — Versatile, Multi-Context
Author: <your-team>
Usage: python generate_codex_md.py > CODEX.md
"""

def ask(prompt, default=None, multiline=False):
    if not multiline:
        val = input(f"{prompt} " + (f"[{default}] " if default else ""))
        return val if val else default
    else:
        print(f"{prompt} (End with a single '.')")
        lines = []
        while True:
            l = input()
            if l.strip() == ".":
                break
            lines.append(l)
        return "\n".join(lines)

print("#" * 75)
print("# CODEX.md — Universal Work Order (Generated Skeleton)")
print("# Status: 🔴 OPEN")
print("#")
print(f"# Project/Sprint Name: {ask('Project or Sprint name?')}")
print(f"# Repo: {ask('Repo URL or short name?')}")
print(f"# Branch: {ask('Branch (feature/main/dev...)?')}")
print("#")
print(f"# Objective(s):\n# {ask('High-level objective (1-2 lines):', multiline=True)}")
print("#" * 75)
print()

print("## 0 ▪︎ Contributors & Roles")
contribs = []
while True:
    c = ask("Contributor (name/role, leave blank to finish):")
    if not c: break
    contribs.append(c)
if contribs:
    for c in contribs:
        print(f"- {c}")
    print()
else:
    print("- TBD\n")

print("## 1 ▪︎ Prerequisites / Setup")
print(f"```bash\ngit checkout -b {ask('Branch name again?')}\n./0-tests/codex-merge-clean.sh $(git ls-files '*.py' '*.sh')\nruff --fix . && black .\npytest -q\n# (Add any other setup commands below)\n```\n")

print("## 2 ▪︎ Deliverable Matrix")
print("| ID | Output / Path | Owner | Acceptance Tests |")
print("|----|---------------|-------|------------------|")
for i in range(1, 10):
    d = ask(f"Deliverable {i} (leave blank to finish):")
    if not d: break
    o = ask(f"Owner for {d}:")
    a = ask(f"Acceptance criteria for {d}:")
    print(f"| D{i} | {d} | {o or '-'} | {a} |")
print()

print("## 3 ▪︎ Task Breakdown (Actionable, Assignable)")
tasks = []
while True:
    t = ask("Next actionable task (leave blank to finish):")
    if not t: break
    owner = ask(f"Owner for this task:")
    tasks.append((t, owner))
for idx, (t, owner) in enumerate(tasks, 1):
    print(f"- [ ] {t} (owner: {owner or '-'})")

print()

print("## 4 ▪︎ API / CLI / UI / Data Interfaces")
intfs = []
while True:
    i = ask("API/CLI/UI endpoint or data contract (leave blank to finish):")
    if not i: break
    idesc = ask(f"Describe {i}:")
    intfs.append((i, idesc))
if intfs:
    print("| Interface | Description |")
    print("|-----------|-------------|")
    for i, idesc in intfs:
        print(f"| {i} | {idesc} |")
    print()

print("## 5 ▪︎ Automation / CI / CD / Tooling")
auto = ask("List automation, pre-commit, CI/CD, or tooling needs:", multiline=True)
print(auto or "-\n")

print("## 6 ▪︎ Testing / Audit / Compliance")
test = ask("Testing or audit requirements (unit, integration, manual, audit log, security, compliance, data privacy, etc):", multiline=True)
print(test or "-\n")

print("## 7 ▪︎ Acceptance Checklist (for reviewers)")
acs = []
while True:
    ac = ask("Acceptance criterion (leave blank to finish):")
    if not ac: break
    acs.append(ac)
for ac in acs:
    print(f"- [ ] {ac}")
if not acs:
    print("- [ ] All deliverables completed and verified.")

print()

print("## 8 ▪︎ Timeline / Milestones / Phases")
timeline = ask("Describe timeline, milestones, or phase breakdown:", multiline=True)
print(timeline or "-\n")

print("## 9 ▪︎ Nonnegotiables / Guardrails")
nonneg = ask("List nonnegotiable rules, guardrails, constraints (legal, ethical, regulatory, org-specific, etc):", multiline=True)
print(nonneg or "-\n")

print("## 10 ▪︎ Legal / Privacy / Compliance (if applicable)")
legal = ask("Describe any legal, privacy, data handling, or compliance obligations:", multiline=True)
print(legal or "-\n")

print("## 11 ▪︎ Audit Log / Exceptions (append as found)")
print("> _Append any audit exceptions, unmapped data, or unresolved issues here for team review._\n")

print("## 12 ▪︎ Expansion / Future Enhancements / Backlog")
future = ask("Describe planned future expansion, deferred features, technical debt, etc:", multiline=True)
print(future or "-\n")

print("# END CODEX.md")
