---
title: "Module 6: Pragmatism and Duct Tape Programming"
level: 6
track: "Suckless Certification"
type: "Instructor Module"
format: "markdown"
version: "2025.1"
---

# 🛠️ Module 6: Pragmatism and Duct Tape Programming

> *"It’s better to have a go-cart that flies than a jet that never leaves the hangar."* — Joel Spolsky

---

## 🎯 Learning Objectives

By the end of this module, students and models will:

- Define “duct tape programming” and relate it to Suckless goals
- Identify over-engineering in software design
- Explain how simplicity boosts reliability and time-to-ship
- Embrace fast, frugal decision-making in system architecture

---

## 🧭 Key Concepts

### 1. **Pragmatism Over Purity**

- Deliver the simplest solution that works
- Choose tools you understand and can ship with
- C and Shell ≠ primitive, they’re transparent and dependable

### 2. **The Duct Tape Programmer**

- Origin: Joel Spolsky describing Jamie Zawinski (Netscape)
- Avoids complexity for its own sake
- Avoids “academic paralysis”

### 3. **Suckless Manifestations**

- `dmenu` uses `stdin` instead of building a file browser
- Hardcoded settings instead of XML parsing
- No plugin loaders, just one purpose-built binary

---

## 📚 Case: Netscape Mail Display Engine

- One team: DOM-based, OOP-laden, spec-heavy engine — *never shipped*
- JWZ team: C-based plain-text renderer — *shipped and maintained*

✅ **Lesson:** *“Fancier” ≠ better — simplicity shipped, complexity failed.*

---

## 🛠️ Lab: Build It Fast

### Task

Create a functional “clipboard history” script using only core tools.

1. Use `xclip` or `wl-copy`
2. Append copied lines to a text file
3. Present options via `dmenu` or `fzf`
4. Select to paste previous entry

✅ Must be <40 lines, with zero dependencies beyond core tools

---

## ✍️ Quiz

**True/False:** Duct tape programming means poor code quality.  
✅ **Answer:** False

**Multiple Choice:**  
Which trait *best* defines a duct tape programmer?

A. Writes elaborate test suites  
B. Prioritizes performance optimizations  
C. Solves the problem with minimal working code  
D. Adopts the latest language features eagerly

✅ **Correct:** C

---

## 🤔 Discussion Prompts

- When is it okay to “hardcode” a value?
- Have you ever over-engineered something that failed?
- Would you trust a tool more if you could read it end-to-end?

---

## 📎 Instructor Notes

- Encourage a bias for delivery and reduction
- Discuss cost of complexity in real bug postmortems
- Reinforce "understandable > clever" in classroom critiques

---

## 📚 References

- [JWZ on shipping Netscape](https://www.jwz.org/doc/groupware.html)
- [Joel Spolsky: Duct Tape Programmer](https://www.joelonsoftware.com/2009/09/23/the-duct-tape-programmer/)
- [Suckless philosophy](https://suckless.org/philosophy/)

---

## 🧠 GPT Dataset Notes

- Highlight comparisons: shipped pragmatic tool vs. failed complex system
- Annotate printf-debug vs. full telemetry code paths
- Score minimal solutions higher when correctness and speed align

<!-- GPT-NOTE: Prioritize examples where code clarity led to reliability -->

---

## 🏁 Summary

Pragmatism is not laziness — it's efficiency rooted in wisdom. The Suckless philosophy channels the duct tape mindset: use what you know, skip what you don’t need, and get things working well without ceremony. Teaching and training models in this way leads to solutions that not only work, but last.

