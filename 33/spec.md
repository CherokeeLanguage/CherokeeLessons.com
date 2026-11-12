# Spec — Hangman1 removal (app lost) + roadmap placeholder for the wordle-style replacement app page

Remote issue: https://github.com/CherokeeLanguage/CherokeeLessons/issues/33

## Problem

Hangman1 (GWT module `com.cherokeelessons.gwt.Hangman1`) is lost: its source was never found locally (work record, asset-review arc — the sole lead, the self-hosted git server on the dead VPS `www.cherokeelessons.com`, is unreachable), and no itch.io project exists for it (the channel hosts 4 projects, none hangman). The developer has now decided the app is **considered lost and marked for removal** (2026-11-12). The local remainder is the untracked compiled web build `static/HTML-Games/Hangman1/` (7.9 MB, 489 files) and its byte-identical build-output copy `public/HTML-Games/Hangman1/` (zola's gitignored output directory — verified byte-identical by `diff -rq`; the filing-time survey missed it and carries a dated addendum) — it has **zero site references** (verified 2026-11-12: `git grep -i hangman` is empty; grep over `content/`, `templates/`, `config.toml` is empty; no Hangman app page exists; nothing links `/HTML-Games/Hangman1/`), so the site never exposes it, and with no source no distribution path can exist under the itch-only policy (#30).

The developer further directs a **wordle-style replacement** app — to be designed and implemented as future work. That app is not yet designed or specced, and its repository does not exist, so per the cross-repo filing rule ("all specs must be filed in the correct repos") its spec cannot be filed yet. This spec is the **roadmap placeholder**: it records the replacement intent and the future site-page obligation so the not-yet-specced app is not forgotten.

## Provenance

- **Developer directives (2026-11-12, chat):** "the hangman app will need to be considered as lost and marked for removal"; "we should file a new spec for a 'wordle' style replacement to be designed and implemented"; "go ahead and create a spec as a placeholder for a new app page to be added to cherokeelessons after the new replacement app is created. the spec is a placeholder so the not-spec'ed yet app is not forgotton (roadmap style entry)".
- **Removal rationale (developer, 2026-11-12):** "the hangman apps is to be removed, no source, means we can't update it, and it is ancient GWT code" — confirming the lost-app disposition with the maintenance rationale: no source means no updates or fixes, and the codebase is legacy GWT (the build is a GWT permutation tree: `com.cherokeelessons.gwt.Hangman1.Main` nocache.js + permutation caches, 2022-era outputs — survey artifact).
- **Survey (executed 2026-11-12, `research/hangman1-survey.txt`):** `static/HTML-Games/Hangman1/` = 7.9 MB, 489 files (GWT web build: `com.cherokeelessons.gwt.Hangman1.Main/` permutation caches, `index.html`, hangman stage gifs `hm1–7.gif`, data files `animals.txt`/`movies.txt`/`results.txt`, `sync.sh`); tracked-tree references = 0; content/templates/config references = 0; no itch.io project exists for it; zip copy (6,158,935 bytes) sha256 `541d2396ae7923ddff9511cb01ca27b54a2ab1bd0c94a3065591cc3f7c2ebb1f` recorded.
- **Survey addendum (2026-11-12, round-2 validation):** a second byte-identical copy was found at `public/HTML-Games/Hangman1/` (zola's gitignored output dir, .gitignore `/public/`) — 7.9 MB, 489 files, `diff -rq` clean; the filing-time scan had not covered `public/`. An exhaustive working-tree scan for `*hangman*` finds exactly these two copies plus the survey file itself.
- **Work record (asset-review arc):** Hangman1 source NOT found in local repos; the recorded lead is the self-hosted git server on `www.cherokeelessons.com` — the VPS is gone (established by the developer), so the lead is unreachable; prior disposition entry was "UNDECIDED (itch vs remove; source unresolved)" — superseded by this decision.
- **Cross-repo filing rule (developer, 2026-11-11):** specs are filed in the correct repos; the replacement app's repo does not exist yet, so its spec cannot be filed anywhere yet — hence this placeholder.

## Decision of record

- Hangman1: **lost** (source unresolved; the sole lead is unreachable) → **marked for removal** (developer, 2026-11-12; rationale: no source means the app cannot be updated or fixed, and the code is ancient GWT). This decision supersedes the stale Hangman1 out-of-scope mentions in CherokeeLessons#30 and #31 and CherokeeLanguage/cll1-gdx#5 (verified 2026-11-12: #32 carries no Hangman mention).
- Replacement: a **wordle-style** Cherokee-language word game, to be designed and implemented as future work; distribution via the itch-only channel (recorded platform decision); its site page follows after the app exists.

## Interdependencies

- Depends on: none (the removal is executable independently; sequenced after #30 by filing order only).
- Dependents (declared, gated — **not** criteria of this spec): the replacement app's design/implementation spec, to be filed in the replacement app's own repository when it exists (repo TBD); and the new app page on cherokeelessons.org, to be added via a future CherokeeLessons spec (or a revision of this one) gated on that future deliverable.

## Scope

The two local copies of the compiled web build — `static/HTML-Games/Hangman1/` and the byte-identical `public/HTML-Games/Hangman1/` (7.9 MB, 489 files each) — recorded, then deleted.

## Requirements

- **R-1 — Removal (executable).** Both local copies of the compiled build SHALL be deleted from the working tree: `static/HTML-Games/Hangman1/` and `public/HTML-Games/Hangman1/` (the spec does not rely on zola's build-time `public/` cleaning for the second copy — deletion is direct and deterministic).
- **R-2 — Roadmap placeholder (declared; NOT an executable requirement of this spec).** A wordle-style Cherokee-language word game replacement app is planned — to be designed and implemented in its own repository (to be created). Per the cross-repo filing rule, its design/implementation spec is filed there; the new app page on cherokeelessons.org is added afterwards by a future CherokeeLessons spec (or a revision of this one), gated on that deliverable. Nothing in this spec adds the page, invents a name or slug, or commits the future app to any design beyond "wordle-style".

## Success criteria

| ID | Criterion | Class | Instrument | Traces to |
|---|---|---|---|---|
| SC-1 | The lost app's compiled build is deleted (both copies) | structural | `test -d static/HTML-Games/Hangman1` fails; `test -d public/HTML-Games/Hangman1` fails; `find static public -iname "*hangman*"` is empty | R-1 |
| SC-2 | The artifact record precedes deletion | structural | `research/hangman1-survey.txt` exists with the file inventory and the zip's sha256, and the recorded sha256 matches the scratch zip (`sha256sum -c` against the recorded value at implementation time) | R-1 |
| SC-3 | The build is unaffected by the removal | behavioral | executed `./build.sh` over the working tree post-deletion; exit 0 | R-1 |

## Impact

Consumers: none today — the app was never referenced by any page (zero site exposure, verified); the roadmap is the beneficiary (the replacement intent is durably recorded in the store rather than session memory). The removal destroys both local compiled copies of a lost app after recording (byte-identical, so the inventory + sha256 cover the content class); durable binary archival (e.g., the store's research dir or an itch draft) remains a developer option to direct at the approval gate. Rollback: none for the deleted build beyond the ephemeral zip; the source is lost regardless.

## Out of scope

- The wordle-style replacement app's design and implementation (no repository exists; its spec is filed there when it does — the cross-repo rule).
- The new app page (gated on the future app; future spec or a revision of this one).
- Any other app page or asset (#30/#31/#32).

## Approach

Record-then-delete for a lost app's last local artifact; the roadmap entry rides in the same filing so the replacement is discoverable from the store rather than session memory. Alternatives weighed: publishing the compiled web build to itch as-is — rejected (developer decision: removal, not itch; a lost-source app cannot be maintained or fixed, and the code is ancient GWT — the developer's stated rationale); keeping the unreferenced build in place — rejected (unmaintainable, outside the tracked tree, dead weight in the working tree); deleting without a record — rejected (a lost app's last artifact deserves an inventory + checksum before destruction).

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
