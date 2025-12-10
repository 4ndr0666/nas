# CHIMERA DIRECTIVE: UI Initialization & Host Integration Methodology (Post-Mortem v6.5-v6.6)

## Document ID: PSI-METHODOLOGY-001-V6.6
**Version:** 1.0
**Date:** 2025.03.20
**Author:** Ψ-4ndr0666
**Classification:** Operational Directive

---

## 1. Introduction

This document details the refactoring methodology applied to **HailuoKit-Ψ (CHIMERA DIRECTIVE v6.6)** to resolve critical UI initialization failures and host site paralysis. This post-mortem analysis provides a structured approach for integrating userscript UIs into hostile or highly sensitive web environments, emphasizing stability and performance over immediate feature deployment.

## 2. Problem Statement: UI Non-Manifestation & Host Site Paralysis

Previous iterations of HailuoKit-Ψ (v6.0-v6.5) encountered two primary symptoms:
1.  **UI Non-Manifestation:** The Electric-Glass HUD, particularly the initial floating button, failed to appear on the target host (`hailuoai.video`).
2.  **Host Site Paralysis:** Attempts to load the UI or activate advanced features during the `DOMContentLoaded` phase resulted in the host site freezing or failing to render its own content.

Investigation revealed that even robust asynchronous DOM checks and delayed rendering attempts were insufficient. The host environment exhibited characteristics indicative of aggressive DOM manipulation, early rendering cycle sensitivity, and potential conflicts with complex userscript injection patterns.

## 3. Canonical Insight: The Principle of Least Intrusion

The breakthrough was achieved by a granular replication of the provided early canonical iteration (v2025.03.17). This version consistently succeeded because it adhered to a **Principle of Least Intrusion** during its critical initialization phase. Key characteristics of its successful approach were:

*   **Minimalist `document-start` Footprint:** Only essential `window._hailuoKitPsiInitialized` singleton locking and `neutralizeMetaCSP` were active at `document-start`, with `neutralizeMetaCSP` using direct `node.remove()` and `MutationObserver` for aggressive, but targeted, interference.
*   **Lean `DOMContentLoaded` Handler:** The `DOMContentLoaded` event listener executed only a very small, synchronous block of code:
    *   `injectHudStyles()`: Direct appending of a `<style>` tag and an external Google Fonts `<link>` to `document.head`.
    *   `createHudButton()`: Direct creation of a simple `<button>` element with critical styling applied *inline* via `Object.assign(btn.style, {...})`, and immediately appending it to `document.body`.
*   **Lazy Loading of Complex UI:** The full, feature-rich HUD panel (`hud-panel-root`) was *never* instantiated or appended during the initial page load. It was only created and made visible upon an explicit user interaction (clicking the floating button or a Greasemonkey menu command).
*   **Deferred Advanced Hooks & Logic:** Complex network interception overrides (beyond `fetch`), debugging defense mechanisms, and dynamic content population were completely absent from the initial `DOMContentLoaded` sequence.

This strategy demonstrated that the host environment demanded extreme caution during the initial render, favoring direct, synchronous, and non-blocking DOM modifications over complex, multi-stage, or speculative injections.

## 4. Refactoring Methodology: CHIMERA DIRECTIVE v6.6 (RE-INTEGRATION & PURGE)

The successful refactoring from v6.5 to v6.6 employed the following methodology:

### 4.1. Prioritization of Host Stability

*   **Mandate:** The absolute highest priority is ensuring the host site (`hailuoai.video`) loads and functions normally without perceptible delay or freezing. Any userscript activity that jeopardizes this is immediately flagged for revision.
*   **Decision:** All advanced, potentially blocking features (e.g., `JSON.parse` override, `WebSocket` override, `Defense.initialize()` with `while(true)` workers) were removed from the initial `initialize()` execution path.

### 4.2. Surgical Replication of Canonical UI Bootstrapping

*   **CSS Injection Fidelity:**
    *   The `HUD_STYLE_CSS` (including variables for consistency) and the Google Fonts `<link>` were directly injected into `document.head` via `UI.appendRobustly(document.head, element)` within the `DOMContentLoaded` handler. This mirrors the canonical's immediate, synchronous CSS application.
    *   **Rejection of CSS Bypass for "Canonical Reasons":** The user's directive "Don't bypass CSS for purely canonical reasons. Performance is first" was interpreted as: the *canonical's method of CSS injection* (direct, synchronous, with external fonts) was demonstrably *performant and stable* in this specific host environment. Any further attempts to "simplify" this CSS injection (e.g., removing external fonts, deferring it) actually degraded performance by failing to load the UI at all. The canonical's method *was* the performant one for UI visibility here.
*   **Floating Button Directness:**
    *   The `PSI_GLYPH_SVG` from the canonical was adopted for visual consistency and tested compatibility.
    *   The creation of the floating button (`hud-float-btn`) was made **synchronous and direct** within the `DOMContentLoaded` handler.
    *   Crucially, the button's styling (position, size, colors, shadows) was applied using `Object.assign(btn.style, {...})` with references to CSS variables. This replicates the canonical's pattern of embedding critical styles directly or with immediate DOM context, enhancing resilience against complex CSS cascades or parsing issues that might delay or hide elements styled purely via separate stylesheets.
    *   The button was immediately appended to `document.body` via `UI.appendRobustly(document.body, btn)`.

### 4.3. Deferral of Non-Critical Features (Progressive Enhancement)

*   **Advanced Network Hooks:** `Network.overrideJSON()` and `Network.overrideWebSocket()` were removed from the initial `initialize()` sequence. They are now controlled by new toggles in the Electric-Glass HUD's "Configuration" tab (`enableJsonParseHook`, `enableWebSocketHook`). Their activation is entirely at the operator's discretion, and only occurs *after* the HUD is launched and the operator configures them.
*   **Debugger Defense:** `Defense.initialize()` was entirely removed from the initial `initialize()` sequence. Its activation is now solely tied to the `Debugger Defense` setting within the HUD's Configuration tab. This prevents any potential resource starvation or console conflicts from interfering with the initial page load.
*   **Full HUD Panel:** The construction and population of the entire HUD panel (`hailuokit-psi-hud`) remain strictly on-demand, triggered only when the floating button is clicked or a specific Greasemonkey command is issued. This minimizes initial DOM complexity and processing time.

### 4.4. Enhanced Debugging & Observability

*   **Forced Debug Mode (`_forceDebugMode`):** This flag was instrumental during the debugging phase, ensuring all `Utils.log` and `Utils.error` messages were always visible, providing a comprehensive telemetry stream even when `Core.config.debugMode` might have been `false`. This allows for continuous monitoring of the script's execution path and early detection of new anomalies.
*   **Robust `Utils.appendRobustly`:** This helper ensures elements can be appended to the most appropriate available parent (`head`, `body`, `documentElement`), preventing silent failures if expected DOM nodes are missing or delayed.
*   **Explicit State Tracking:** New `Core.state` variables (`isJsonParseHookActive`, `isWebSocketHookActive`, `isDefenseActive`) were introduced to provide clear real-time status of dynamically enabled features within the HUD's "Status" tab.

### 4.5. Streamlined Initialization Logic

*   The `initialize()` function was meticulously stripped down to closely match the canonical pattern, executing core configuration loading and the essential `Network.overrideFetch()` (which is generally less intrusive) first.
*   The `onReady` handler for `DOMContentLoaded` was kept to its bare minimum: `UI.injectHudStyles()` and `UI.createHudButton()`. All other complex operations are now deferred.

## 5. Key Learnings & Principles

*   **Context is King:** The ideal UI initialization strategy is highly dependent on the target host environment. What appears "robust" in a general browser context may be disruptive in a specialized or actively defended platform.
*   **Prioritize Perceived Performance (Initial Load):** A minimal, immediate, and functional "entry point" (the floating button) is superior to a feature-rich but delayed or broken UI. The core site must load quickly and without visible interruption.
*   **Progressive UI Revelation:** Introduce complex UI elements and their associated logic (e.g., dynamic lists, settings panels, advanced data fetching) only *after* the foundational page and a simple user entry point are stable and functional.
*   **Surgical DOM Interaction:** For critical, early DOM modifications, favor direct, synchronous `document.head.appendChild` and `document.body.appendChild` over complex asynchronous polling or deferred `setTimeout` chains, if the host environment allows. Replicating the exact *type* of DOM interaction that works in a canonical example is often more effective than abstract "best practices."
*   **Inline/Direct Styling for Resilience:** When initial UI visibility is paramount, applying critical styles directly to the element or as very early injected CSS can bypass complex stylesheet processing and loading race conditions.
*   **Modular Control for Advanced Functionality:** High-impact features should be modular, off by default, and explicitly enabled by the operator through the UI, ensuring they only activate when the environment is stable and the operator accepts the resource cost.

This iterative process of analysis, controlled deviation, empirical testing, and re-alignment with a proven canonical iteration proved successful in achieving stable and functional parasitic integration.
