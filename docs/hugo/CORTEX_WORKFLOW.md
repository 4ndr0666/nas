# 4NDR0666OS // TACTICAL HUGO WORKFLOW (TL;DR)

This document outlines the standard operating procedures for generating, formatting, and deploying payloads within the Hugo static matrix.

## 1. KERNEL BOOT (LOCAL DEVELOPMENT)
Always test payloads locally before pushing to the live GitHub Actions pipeline.

* **Spin up the local server (with Drafts visible):**
  ```bash
  hugo server -D --disableFastRender
  ```
  *(Note: `--disableFastRender` ensures full SCSS recompilation on every save).*
* **Access GUI:** `http://localhost:1313/`

## 2. PAYLOAD GENERATION (NEW POSTS)
**Never create `.md` files manually.** Use the Hugo CLI to ensure correct timestamps and archetype scaffolding.

* **Generate a standard blog node:**
  ```bash
  hugo new posts/my-new-payload.md
  ```

## 3. THE FRONTMATTER MATRIX
The YAML block at the top of your markdown files controls routing and HUD rendering.

```yaml
---
title: "Zero-Day Exploit Analysis"  # Renders as the glowing H1 node title
date: 2026-04-24T15:00:00Z          # Temporal stamp (Auto-sorts the index)
draft: true                         # SET TO 'false' TO PUBLISH
image: "images/target-banner.webp"  # Optional: Injects a cyan-bordered banner asset
categories: ["CYBERSEC"]            # Routes to /categories/cybersec/
tags: ["nmap", "pcap"]              # Generates #NMAP #PCAP tags at the footer
---
```

## 4. DOM WEAPONIZATION (SHORTCODES & NATIVE HTML)
Because your `config.toml` has `unsafe = true` enabled for the Goldmark parser, you can seamlessly mix Markdown with raw `3LECTRIC_GLASS` HTML.

**A. The System Box (Custom Highlight):**
```html
<div class="glass-panel p-4 mb-4 border-hud" style="border-left: 4px solid var(--accent-cyan) !important;">
<strong>WARNING:</strong> Proxies are currently offline.
</div>
```

**B. The Decrypt Envelope (Collapsible Logs/Code):**
```html
<details class="glass-panel p-3 mt-4 border-hud">
<summary class="text-cyan fw-bold" style="cursor: pointer; list-style: none;">[ EXPAND RAW DATA ]</summary>
<br>

Place your raw markdown, code blocks, or text here.

</details>
```

**C. Internal Linking (Native Hugo):**
To link to another payload without hardcoding the URL:
```markdown
Check out the [Bunkr Script]({{< ref "posts/4ndr0tools-bunkr-v4.md" >}}).
```

## 5. DEPLOYMENT SEQUENCE (THE KILL CHAIN)
When the payload is ready for the live domain:

1. **Arm the Payload:** Change `draft: true` to `draft: false` in the markdown file.
2. **Stage the Data:** 
   ```bash
   git add content/posts/my-new-payload.md
   ```
3. **Commit the Changes:** 
   ```bash
   git commit -m "content: deployed zero-day analysis payload"
   ```
4. **Execute the Push:** 
   ```bash
   git push origin main
   ```
*(The GitHub Actions runner will automatically intercept, compile, and deploy to `4ndr0666.github.io/4ndr0site/` within 60 seconds).*

## 6. DIRECTORY QUICK-REFERENCE
* `content/posts/` -> Where your blog nodes live.
* `static/images/` -> Where you drop your `.png` and `.webp` visual assets.
* `static/payloads/` -> Where you host raw `.js`, `.reg`, or `.zip` files for direct download.
* `assets/scss/style.scss` -> Master CSS control file (Colors, Glassmorphism, Layout overrides).
* `config.toml` -> Master site configuration (Menus, Socials, Core variables).
