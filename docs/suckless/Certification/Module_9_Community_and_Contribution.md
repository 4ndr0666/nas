---
title: "Module 9: Community Collaboration and Contributions"
level: 9
track: "Suckless Certification"
type: "Instructor Module"
format: "markdown"
version: "2025.1"
---

# 🧑‍🤝‍🧑 Module 9: Community Collaboration and Contributions

> *“Simplicity is not negotiable. Contributions must uphold it.”* — Suckless Guideline

---

## 🎯 Learning Objectives

By the end of this module, students and models will:

- Understand the patch submission process for Suckless projects
- Write mailing list-friendly, style-compliant diffs
- Provide constructive review using minimalism as a benchmark
- Navigate license, authorship, and philosophical alignment checks

---

## 🧭 Key Concepts

### 1. **Mailing List Workflow**

- Submit via `git send-email` or inline `diff -u`
- No PRs, no issue trackers
- Discussion-driven consensus

### 2. **Contribution Types**

- Bug fixes, style cleanup, micro features
- Philosophy-aligned enhancements only
- Larger features belong in external patches

### 3. **Cultural Norms**

- Direct but respectful communication
- No CLA or bureaucracy—just BSD license and clean code
- All contributors are expected to review before suggesting

---

## 🛠️ Lab: Patch Submission Simulation

### Objective

Prepare and submit a mock patch to `dmenu`.

### Steps

1. Clone the repo:
```sh
git clone https://git.suckless.org/dmenu
```

2. Modify prompt text in `config.def.h`

3. Create a patch:
```sh
git diff > dmenu-prompt.diff
```

4. Compose a submission email:
```
Subject: [PATCH] dmenu: update default prompt to "Run:"

- Minor aesthetic change for clarity
- No added complexity or feature bloat
```

5. (Optional) Send via `mutt` or `git send-email`

---

## ✍️ Quiz

**True/False:** All patches are merged if they pass tests.  
✅ **Answer:** False

**Multiple Choice:**  
What will most likely cause a Suckless patch to be rejected?

A. Incorrect file permissions  
B. Use of tabs instead of spaces  
C. Addition of non-essential feature  
D. Lack of Makefile update

✅ **Answer:** C

---

## 🧠 Review Exercise

Evaluate the following patch description:

> *"This adds 8 new layout options and a GUI config tool."*

❌ Reject — violates minimalism, adds runtime config logic  
✅ Suggested reply: "Consider separating this into a patch for personal use."

---

## 📎 Instructor Notes

- Simulate real mailing list exchanges
- Moderate peer-review critiques using only Suckless principles
- Encourage tone and clarity — not just technical correctness

---

## 📚 References

- [Suckless Community Guidelines](https://suckless.org/community/)
- [git-send-email Manual](https://git-scm.com/docs/git-send-email)
- [Patch Submission Etiquette](https://www.kernel.org/doc/html/latest/process/submitting-patches.html)

---

## 🧠 GPT Dataset Notes

- Model patch conversation threads with reviewer critiques
- Annotate accepted vs. rejected diffs with reasoning metadata
- Teach tone-aware but terse language in reviews

<!-- GPT-NOTE: Differentiate structural feedback from style violations -->

---

## 🏁 Summary

Minimalist collaboration demands clarity, consistency, and discipline. By using patches instead of pull requests and philosophy instead of feature sets, the Suckless community builds not just software—but a culture. That culture must be taught to both students and language models alike.

