1. On any /processing poll:
   1. Parse JSON, enumerate all chunks (by batchID, chunkID, status, error code)
   2. For each completed asset, push to asset HUD
   3. For each failed chunk, log with error code/message (map from MiniMax table)
   4. Expose “auto-poll”/“force-complete” controls in HUD

2. On prompt send:
   1. Apply all selected obfuscation steps in order:
      [dedupe-in-brackets] → [homoglyph] → [ZWSP] → [custom/invisible]
   2. Show preview in HUD

3. On /meerkat-reporter call:
   1. If block: Respond 200, no-op.
   2. If fuzz: Generate plausible but useless JSON (configurable in HUD)

4. HUD Panels:
   1. [Captured Assets]: Full list, chunk IDs, status, error code (with explanation)
   2. [Active Jobs]: Show all known active/completed jobs and progress bars
   3. [Obfuscation Config]: Checkboxes/order for all mutation steps
   4. [Reporter Policy]: [Block All] / [Fuzz] / [Pass-Through]

5. Advanced: Add quick links to docs (MiniMax, error codes) and API explorer.
