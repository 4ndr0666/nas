- On any /processing poll:
  - Parse JSON, enumerate all chunks (by batchID, chunkID, status, error code)
  - For each completed asset, push to asset HUD
  - For each failed chunk, log with error code/message (map from MiniMax table)
  - Expose “auto-poll”/“force-complete” controls in HUD

- On prompt send:
  - Apply all selected obfuscation steps in order:
    [dedupe-in-brackets] → [homoglyph] → [ZWSP] → [custom/invisible]
  - Show preview in HUD

- On /meerkat-reporter call:
  - If block: Respond 200, no-op.
  - If fuzz: Generate plausible but useless JSON (configurable in HUD)

- HUD Panels:
  - [Captured Assets]: Full list, chunk IDs, status, error code (with explanation)
  - [Active Jobs]: Show all known active/completed jobs and progress bars
  - [Obfuscation Config]: Checkboxes/order for all mutation steps
  - [Reporter Policy]: [Block All] / [Fuzz] / [Pass-Through]

- Advanced: Add quick links to docs (MiniMax, error codes) and API explorer.
