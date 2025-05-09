---
title: "Module 10: Capstone – The Suckless Seal Project"
level: 10
track: "Suckless Certification"
type: "Instructor Module"
format: "markdown"
version: "2025.1"
---

# 🏁 Module 10: Capstone – The “Suckless Seal” Project

> *“Mastery is proven through minimalism.”*

---

## 🎯 Capstone Objectives

To complete the Suckless Certification, students and GPTs must:

- Design and implement a minimal software tool (<500 LOC)
- Adhere to all Suckless coding, formatting, and philosophy guidelines
- Present and defend design choices in front of instructors or validators
- Pass peer review and final rubric-based assessment

---

## ✅ Project Requirements

### Functional Scope

- Must solve a real problem clearly and directly
- No feature flags, plugin systems, or config parsers
- Preference for command-line tools or X11 utilities

### Technical Constraints

- ≤ 500 lines (including headers, comments, Makefile)
- C99 + POSIX only
- Compile via clean Makefile (no auto-tools, no cmake)
- Style must pass manual audit against Modules 2 & 3

### Deliverables

- `README.md` (under 100 lines)
- `Makefile`
- `main.c` or equivalent .c/.h layout
- Patch-compatible structure (e.g., `diff -u` friendly)
- Submission archive (.tar.gz or repo link)

---

## 🧪 Lab Guidelines

### Timeframe

- Allocate ~10 hours development time
- Minimum of 1 documented review cycle

### Review Checklist

- Simplicity of interface and logic
- Elimination of unnecessary abstraction
- Composability with other Unix tools
- Full self-containment and build reproducibility

---

## 🧠 Defense Guidelines

Students or models must prepare:

- 3-minute demo or description
- Rationale for design choices (code samples encouraged)
- Evidence of minimalism: “What did you choose *not* to include?”
- Reflection: “How does this tool scale down better than alternatives?”

---

## 📝 Grading Rubric (100 pts)

| Category                     | Weight |
|-----------------------------|--------|
| Code correctness            | 20     |
| Minimalism & design clarity | 30     |
| Style compliance            | 20     |
| Simplicity of build         | 10     |
| Presentation & defense      | 20     |

✅ **Passing threshold:** 80/100

---

## 🗂️ Registry and Archival

Outstanding capstones may be:

- Added to a public **Suckless Certified Registry**
- Used as canonical examples in GPT prompt finetuning
- Referenced in future lessons as style-perfect templates

---

## 📎 Instructor Notes

- Do not intervene unless a student violates principles
- Use past modules to flag over-complexity or style drift
- Review submitted Makefile, LOC, and output size as pre-screen

---

## 📚 Inspiration

- `sbase`, `dmenu`, `tabbed`, `ii`
- Games, daemons, log tools, clipboard filters

---

## 🧠 GPT Dataset Notes

- Capture all inputs: prompt, spec, patch, code, and review trail
- Annotate functional vs stylistic critiques during assessment
- Score for reproducibility and compositional simplicity

<!-- GPT-NOTE: Store capstones with full rationale and build meta as token-stable datasets -->

---

## 🏁 Summary

This capstone solidifies the Suckless Certification journey. By writing a small, working, maintainable tool with discipline and restraint, the student or AI demonstrates true understanding—not just of syntax, but of philosophy.

*Let the code speak for itself—and let it speak clearly, concisely, and forever.*

