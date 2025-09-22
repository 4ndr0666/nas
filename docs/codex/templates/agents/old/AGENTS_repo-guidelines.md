# Repository Guidelines

## Project Structure & Module Organization
- App source lives in `src/` (TypeScript + Tailwind). Entry points are under `src/` and bundled via Webpack.
- Built artifacts output to `dist/`.
- Configuration lives at the repo root: `webpack.*.js`, `postcss.config.js`, `tailwind.config.js`, `tsconfig.json`, and `manifest.json`.
- Node dependencies are in `node_modules/`.

## Build, Test, and Development Commands
- `npm install` — install dependencies.
- `npm run dev` — start the Webpack dev server with live rebuilds.
- `npm run build` — production build to `dist/` using `webpack.prod.js`.
- `npm run clean` (if present) — remove previous builds. Otherwise, remove `dist/` manually.

## Coding Style & Naming Conventions
- Language: TypeScript. Prefer explicit types on public exports; allow inference for locals.
- Indentation: 2 spaces; keep lines focused and small, avoid long chains.
- Imports: use relative paths within `src/`. Group std/libs, third‑party, then local.
- CSS: use Tailwind utility classes; keep custom CSS minimal and colocated when needed.
- Filenames: kebab-case for assets, PascalCase for React-like components (if any), and camelCase for utilities.

## Testing Guidelines
- If adding tests, colocate under `src/` using `*.test.ts` naming. Keep tests fast and focused.
- Aim for unit tests on helpers and DOM-less logic. Avoid relying on network or filesystem.
- Run tests with `npm test` (add a script if not present) or a lightweight runner such as `vitest`/`jest` if introduced.

## Commit & Pull Request Guidelines
- Commits: use clear, imperative messages (e.g., "fix: handle empty state"). Squash small fix-ups.
- PRs: include a concise description, screenshots/GIFs for UI changes, and link related issues. Note any build or config updates.
- Keep changes scoped; avoid unrelated refactors. Update README or comments when behavior changes.

## Security & Configuration Tips
- Do not commit secrets. Use environment variables or local `.env` files (not tracked).
- Validate inputs; avoid dynamic `eval` or untrusted HTML injection.
- Production bundles should be minified and free of debug logs.

## Agent-Specific Notes
- This repository is a web extension/frontend bundle. There is no Rust workspace here; ignore rust/codex-rs conventions.
- When automating, prefer running `npm run build` to verify changes. If adding a test runner, document it in `README.md` and update scripts.

