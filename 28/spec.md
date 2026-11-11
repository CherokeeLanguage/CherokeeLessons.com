# Spec — pin zola to the latest theme-compatible release (v0.22.1)

Remote issue: https://github.com/CherokeeLanguage/CherokeeLessons/issues/28

## Problem

The repository has no zola version pin. Builds and publishes run whatever `zola` the invoking machine has on `PATH`: `publish.sh` calls bare `zola build` on the publish host (`omen-desktop`-gated rsync flow), and nothing in the repo states which zola version is the version of record. Observed 2026-11-10: the locally installed zola 0.23.6 cannot build the repo at all — `generate_rss` is a removed config key (renamed `generate_feeds` in zola 0.19) — while the theme's declared `min_version = "0.6.0"` (vendored Zulma, dormant upstream) is vacuous as a compatibility ceiling. Consequences: a publish is unreproducible from a fresh clone, a toolchain update on the publish machine can silently break or alter the site, and the compatibility question "which zola works with this site's theme" has no recorded answer.

## Provenance

- **Developer statement (2026-11-10, chat):** "create a spec to pin zola for this repo to the latest compatible with the theme." — the request defining this spec's scope.
- **Developer directive (2026-11-10, chat):** "compare zola version with ../michael-conrad.com" — the comparison evidence below (pin-file + exact-release `build.sh` precedent running the same Zulma theme at zola 0.22.1).
- **Observed failures (executed builds 2026-11-10, logs in `research/`):**
  - Fresh-clone build of this repo as tracked: zola 0.23.6, 0.22.1, 0.21.0, 0.20.0, 0.19.2 all FAIL at config parse (`generate_rss` unknown field, error names `generate_feeds`); zola 0.18.0 and 0.17.2 BUILD OK. → as-is build ceiling: **0.18.0**.
  - With only the three mechanical key edits applied (see R-4), zola 0.22.1 BUILD OK on this repo's own vendored Zulma copy (1292 tracked files); zola 0.23.6 FAILS **in the theme**: `Zulma/templates/taxonomy_single.html:3` — `Unknown tag: {% import "post_macros.html" as post_macros %}` (Tera removed `{% import %}`). → theme compatibility ceiling: **0.22.1**; the latest release compatible with the theme.
  - The 9 files carrying the dead `insert_anchorLinks` front-matter key are listed in `research/anchor-typo-files.txt`; old zola ignored the unknown key (it never functioned), 0.19+ hard-errors on it.
  - The last published build (`public/`, June 2023) emitted **no** feed artifact — no `rss.xml`, no `atom.xml`, no feed `<link rel="alternate">` tags — so the `generate_feeds` migration introduces a new surface rather than breaking an existing one.
- **Live-sourced facts:** zola release list via GitHub API (2026-11-10): latest stable v0.23.6 (2026-09-12); v0.22.1 (2026-01-22). Zulma upstream `Worble/Zulma`: last push 2024-04-22, not archived, `min_version = "0.6.0"`. Zola ≥ 0.20 embeds the giallo highlighting engine (`giallo-0.2.2` confirmed in the 0.22.1 binary) — syntect theme names such as `base16-ocean-dark` no longer exist, so the old default highlighting rendering is not preservable.
- **Sibling comparison (verified 2026-11-10, ../michael-conrad.com):** `ZOLA_VERSION` = `0.22.1` (unprefixed; the script inserts `v` into the release URL); `build.sh` downloads exactly that release, extracts `./zola` (gitignored), runs `./zola build`; `config.toml` uses the current key schema (`generate_feeds = true`, no `highlight_code`); theme = Zulma; `public/` built 2026-10-27 with `atom.xml`. Its vendored Zulma differs from this repo's copy only in `templates/index.html` (a sibling-local patch), screenshots, and JS source maps.

## Scope

This repository's zola toolchain surfaces only:

| Surface | Change |
|---|---|
| `ZOLA_VERSION` (new, tracked) | the pin of record: `0.22.1` |
| `build.sh` (new, tracked) | pinned-binary download + `./zola build` |
| `publish.sh` (edit) | build step routed through the pin |
| `.gitignore` (edit) | `/zola` ignored |
| `config.toml` (edit) | `generate_rss` → `generate_feeds`; `highlight_code` removed |
| 9 content files (edit) | dead `insert_anchorLinks` key deleted |
| `README.md` (edit) | pin + build/publish documentation |

No theme changes, no CI (none exists — verified: no `.github/`), no publish-host, rsync, `.htaccess`, or URL changes.

## Requirements

- **R-1 — Pin of record.** A tracked root file `ZOLA_VERSION` SHALL carry exactly `0.22.1` — the latest zola release compatible with the vendored Zulma theme.
- **R-2 — Pinned build mechanism.** A tracked `build.sh` SHALL: read `ZOLA_VERSION` (format-checked as `MAJOR.MINOR.PATCH`); when `./zola` is absent or its `--version` output does not contain the pin, download exactly `https://github.com/getzola/zola/releases/download/v<PIN>/zola-v<PIN>-x86_64-unknown-linux-gnu.tar.gz` and extract it as `./zola` (executable); then run `./zola build`. The `./zola` binary SHALL NOT be tracked in git — the pin travels, the binary is re-fetched reproducibly.
- **R-3 — Publish through the pin.** `publish.sh` SHALL build via the pinned binary (its bare `zola build` invocation replaced by the pinned path — via `./build.sh` or `./zola` directly; the exact wiring is plan-level). Its hostname gate, `rm -rf public`, `.htaccess` copy step, and rsync behavior stay untouched.
- **R-4 — Minimal schema migration to the pinned version.** Config/content SHALL carry exactly the mechanical edits 0.22.1 requires:
  1. `config.toml`: `generate_rss = true` → `generate_feeds = true`;
  2. `config.toml`: the `[markdown] highlight_code = true` key removed (highlighting unconfigured, matching the sibling's proven shape; the one affected file's fences render uncolored);
  3. the dead `insert_anchorLinks` front-matter key deleted from all 9 files carrying it — deletion preserves published behavior; renaming it to `insert_anchor_links` would activate heading anchors, which is out of scope.
- **R-5 — Documentation.** `README.md` SHALL document the pin and the build/publish path (`ZOLA_VERSION`, `./build.sh`, `./publish.sh`).

## Success criteria

| ID | Criterion | Class | Instrument | Traces to |
|---|---|---|---|---|
| SC-1 | `ZOLA_VERSION` is tracked and contains exactly `0.22.1` | structural | `git ls-files ZOLA_VERSION` lists the file; `cat ZOLA_VERSION` prints `0.22.1` | R-1 |
| SC-2 | On a fresh clone with no `./zola`, `./build.sh` downloads the pinned release, reports `zola 0.22.1`, builds with exit 0, and `public/index.html` exists | behavioral | executed `./build.sh` run in a fresh `/tmp` clone; log shows the download line and the version line | R-2 |
| SC-3 | With `./zola` already at the pin, `./build.sh` re-runs without re-downloading and still reports the pinned version | behavioral | second executed `./build.sh` run; log shows no download line and the `zola 0.22.1` line | R-2 |
| SC-4 | `publish.sh` contains no bare `zola` invocation; its build step routes through the pinned binary | structural | `grep -n zola publish.sh` shows only pinned-path invocations | R-3 |
| SC-5 | The `./zola` binary is not tracked | structural | `git check-ignore ./zola` matches; `git ls-files zola` is empty | R-2 |
| SC-6 | No legacy keys remain: `generate_rss` and `highlight_code` absent from `config.toml`; `insert_anchorLinks` absent from all content | structural | `grep -nE "generate_rss\|highlight_code" config.toml` is empty; `grep -rl insert_anchorLinks content` is empty | R-4 |
| SC-7 | The migrated tree builds cleanly on the pinned version from a fresh clone | behavioral | executed `./zola build` (pinned binary) in a fresh clone; exit 0 | R-4 |
| SC-8 | The pinned build emits the feed surface the migration enables: `public/atom.xml` exists | structural | `test -f public/atom.xml` after the SC-7 build | R-4.1 |
| SC-9 | README documents the pin and the build/publish path | structural | `grep -nE "ZOLA_VERSION\|build\.sh" README.md` finds both | R-5 |

## Out of scope

- Migrating to zola 0.19–0.21 or 0.23.x — 0.23+ is theme-incompatible (Tera `{% import %}` removed; failure recorded in `research/min-0.23.6.log`), and 0.19–0.21 sit below the proven 0.22.1.
- Any Zulma theme upgrade or replacement — upstream dormant (last push 2024-04-22) and unverified against modern zola; large scope, unrequested.
- Activating `insert_anchor_links` — the dead keys are deleted behavior-neutrally; activation is a separate content decision.
- Configuring a replacement highlighting theme for the one affected file (remedy exists — 0.22 accepts `[markdown.highlighting]` with a giallo theme name — but the theme choice is a visual decision not stated by the developer).
- The untracked-published-assets review conducted in this session (separate work, its own ticket if authorized).
- CI (none exists), publish-host or rsync changes, `.htaccess` changes (no legacy feed URL needs a redirect — the old site published no feed).

## Approach

Follow the sibling precedent (`michael-conrad.com`): same theme (Zulma), same pin-file + exact-release-download `build.sh` shape, proven at 0.22.1 with the current feed key. This repo's `build.sh` keeps only the download-and-build core — no Cloudflare/branch-aware base-url logic (no CI, no preview concept; `publish.sh` rsyncs from the fixed publish host). Alternatives weighed:

- **Pin 0.18.0 with zero content edits** — the as-is build ceiling; rejected: it is not the latest theme-compatible release, and the three key edits are mechanical, sibling-proven, and required to reach the theme's actual ceiling.
- **Pin 0.23.6 (latest stable)** — rejected: Zulma templates fail on it (Tera `{% import %}` removed); reaching it would require patching the vendored theme (dormant upstream) — a materially larger change than the request.
- **Upgrade/replace the Zulma theme** — out of scope as above.

## Impact

Consumers of the changed surfaces: the publish host (`publish.sh`'s only caller; the hostname gate keeps it omen-desktop-only and is preserved), any agent or machine building the site (becomes reproducible from a fresh clone), and the published site itself through two disclosed trades:

1. `generate_feeds` makes builds emit `public/atom.xml` — a **new** surface (the previously published site emitted no feed artifact; nothing existing breaks).
2. Removing `highlight_code` drops syntax-highlight coloring for the single content file with fenced code blocks (`content/content/cherokee-tts-update--2--ims-toucan-/index.md`); the old syntect theme name is not preservable under the giallo engine.

Risk concentrates in R-4: the 9 front-matter deletions are behavior-neutral (the keys never functioned), verified by the executed 0.22.1 build producing the full site. Rollback: revert the commit set — the pin file and script are additive, and the migrated keys revert cleanly.

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
