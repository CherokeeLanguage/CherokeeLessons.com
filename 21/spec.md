# Spec — Create the itch.io app pages and deploy the site-published app artifacts (itch migration, phase 1)

## Provenance — developer statements (2026-11-09, session)

- "there are multiple apps made available for download for this currently not-published site. we are migrating to have the apps available via itch.io; ../BoundPronouns is one such app that has already been re-deployed from the existing app artifacts."
- "the pages need to be landing pages that use itch.io app page as the location to redirect users to when they want to download. (the download links need to be adjusted to point to the proper itch.io download/donate page); this includes for boundpronouns, that part will need separate specs. the repos for the actual binaries need to have issue tickets added for conversion to itch.io as their deploy targets using standard itch.io deployment."
- "this work will need to be split into two separate phases, individual specs for the itch.io page setup, then follow up spec(s) in cherokeelessons.com for the actual site edits."
- "the animals app is not ready for godot version to be deployed. we need to deploy what the cherokeelessons.com repo currently shows as the latest published versions"
- "assume metadata can't be trusted"
- "the cherokeelessons.com pages need to be the same as much as is possible as they are the main pages. we need to however create a spec to go ahead and create the needed itch.io app pages for deployment."

## Observed facts (verified 2026-11-09)

- **Site repo artifact inventory** (sha256 verified on disk; paths authoritative, version labels untrusted decoration):
  - `content/apps/animals/Animals-5.12.jar` — `b635efd6ce9eb46e0e3bd262464c5bcd6f89180b47fe4b687c59d2503fd780d4`
  - `content/apps/animals/Animals-5.12-release.apk` — `0315bed8925924b4bdd78ead426ed69bfbfcbb8094cdc709c0c12b64984e9490`
  - `static/downloads/Syllabary-3.24.jar` — `07a31d9184f744e9b8048b8834b69c9c367c4f90a940fda273367a3d08cf33e1`
  - `static/downloads/CLL1-1.72.jar` — `364f4e876672a17311f709747ad32d981aa5cccc31642efa97d8a18e858c894c`
  - `content/apps/cherokee-numbers-maze---ᏣᎳᎩ-ᏗᏎᏍᏗ-ᏚᎴᎾᎯᎯ/NumbersMaze.x86_64` — `487b64bb2e9e76b9dd78a144ec024ae652a175952057a59a6b1c495f789950d6`
  - `content/apps/cherokee-numbers-maze---ᏣᎳᎩ-ᏗᏎᏍᏗ-ᏚᎴᎾᎯᎯ/NumbersMaze-x86_64.exe` — `be6e478f5aea1e2a036c7b6d97b9209f1a99fa788ebeca2dc08c0e6b1e6b19fd`
  - `content/apps/cherokee-numbers-maze---ᏣᎳᎩ-ᏗᏎᏍᏗ-ᏚᎴᎾᎯᎯ/NumbersMaze-mac.zip` — `c75e64b4fb08d228011fd0a529b7b5c8512c36c33739bfa122646b5d898c8317`
- **HTML5 build present:** `static/HTML-Games/NumbersMaze/` (Godot wasm export: `index.html`, `index.wasm`, `index.pck`, worklet js) — the site's currently-published web version.
- **Four site app pages** under `content/apps/`: Animals, Syllabary, Cherokee Language Lessons 1, Cherokee Numbers Maze — each with descriptive prose and a featured image present in `static/images/`.
- **Bound Pronouns precedent (live, verified 2026-11-09):** `https://cherokee-language.itch.io/cherokee-bound-pronouns` — "Download Now / Name your own price", platforms Windows/macOS/Linux/Android, files listed without version claims (butler auto-numbers, "Version 1"), description adapted from the site page's prose (BoundPronouns#59, merged as PR #61); repo-local `itch-push.sh` + gitignored `itch.conf` push pattern.
- **itch.io mechanics (butler manual + API overview, fetched 2026-11-09):** butler pushes target existing projects (`user/game:channel`; a push to a new channel creates its file); channel names containing `win`/`windows`/`linux`/`mac`/`osx`/`android` auto-tag the platform; HTML5 playability is flagged from the Edit-game page after the first push and the page kind set to HTML; by default the backend auto-numbers builds (no `--userversion` needed); the documented server-side API surface offers queries and changes — no butler or API path creates a project, so project creation is a dashboard step (consistent with the Bound Pronouns precedent).
- **Sibling binary repos** (surveyed 2026-11-09): Animals (tag `5.12` precedes `prep-for-conversion-to-godot`; Godot version not deployable), Syllabary (no tags), cll1-gdx (tags 1.08–1.82, 1.72 present), NumbersMaze.godot (no tags, unpushed local work). Per the developer's statement, none of these metadata corroborate or replace the site repo's artifacts — the site repo's copies are the deployment source.

## Problem

Four published apps are downloadable only through site-hosted binaries and store links of unknown validity. The migration makes itch.io the app download channel: Bound Pronouns proves the pattern, but the other four apps have no itch presence, so phase 2's landing-page edits have no itch URLs to point at.

## Intent

Each of the four remaining apps gets an itch.io project page carrying its currently-published artifacts — deployed as opaque files from this repo's copies via butler — configured to mirror the Bound Pronouns page's conventions (pricing, classification, description sourcing). The site's app pages stay as they are in this phase.

## Requirements

- **R-1 — Four itch project pages.** Four itch.io projects are created under the `cherokee-language` account, titles mirroring the site pages: Cherokee Language Animals (`cherokee-language-animals`), Syllabary (`cherokee-syllabary`), Cherokee Language Lessons 1 (`cherokee-language-lessons-1`), Cherokee Numbers Maze (`cherokee-numbers-maze`), each published, classified Educational, with the site page's featured image as cover art. Project creation is a developer dashboard step (no butler/API creation path exists). *Traces to: "create the needed itch.io app pages"; "the cherokeelessons.com pages … are the main pages" (mirroring); Bound Pronouns precedent.*
- **R-2 — Pricing mirrors Bound Pronouns.** Each page's payment setting is "Name your own price" (free download, donations enabled). *Traces to: "download/donate page" (2026-11-09); live BP page configuration.*
- **R-3 — Descriptions derive from the site pages.** Each itch page's description text is adapted from its site page's existing prose, with no factual claim absent from that prose (BoundPronouns#59 is the form precedent). Cover/feature images come from the `static/images/` copies the site pages reference. *Traces to: "the cherokeelessons.com pages need to be the same as much as is possible"; "assume metadata can't be trusted" (no new claims invented).*
- **R-4 — Butler deployment of existing artifacts.** Each page's download channels carry this repo's currently-published artifacts per the channel table, pushed with butler. Pushes carry no version claims (no `--userversion`); butler's auto-numbering stands. Artifacts deploy as opaque files under their existing filenames — no tag, filename-version, or page-date label is verified or asserted as truth. *Traces to: "deploy what the cherokeelessons.com repo currently shows as the latest published versions"; "assume metadata can't be trusted."*
- **R-5 — Repeatable push tooling.** A repo-local push script plus gitignored `itch.conf` mirror the BoundPronouns pattern (butler resolution PATH→vendored `.tools/butler/`, `REPLACE_ME` config guard, per-channel pushes) and encode the channel table. No secrets in the repo — butler credentials live in butler's own store (`butler login`). *Traces to: "standard itch.io deployment"; BoundPronouns pattern as the established standard.*
- **R-6 — Numbers Maze playable build.** The Cherokee Numbers Maze page offers the playable browser build from `static/HTML-Games/NumbersMaze/` (zipped push to an `html` channel, then flagged playable dashboard-side per the butler manual) in addition to the desktop downloads. *Traces to: "deploy what the cherokeelessons.com repo currently shows" — the playable web build is part of the site's currently-published Numbers Maze offering (`/HTML-Games/NumbersMaze/index.html`).*
- **R-7 — Ordering.** Dashboard project creation precedes the butler pushes; platform tags follow butler's channel-naming rules. *Traces to: butler mechanics (verified 2026-11-09).*
- **R-8 — Site pages untouched in this phase.** No file under `content/apps/` is modified by this phase's repo work; the only site-repo change is the R-5 tooling. *Traces to: "individual specs for the itch.io page setup, then follow up spec(s) in cherokeelessons.com for the actual site edits."*

### Channel table

| App | itch project (slug) | Channel | Source artifact (this repo) |
|---|---|---|---|
| Animals | `cherokee-language-animals` | `win-linux-mac` | `content/apps/animals/Animals-5.12.jar` |
| Animals | `cherokee-language-animals` | `android` | `content/apps/animals/Animals-5.12-release.apk` |
| Syllabary | `cherokee-syllabary` | `win-linux-mac` | `static/downloads/Syllabary-3.24.jar` |
| CLL1 | `cherokee-language-lessons-1` | `win-linux-mac` | `static/downloads/CLL1-1.72.jar` |
| Numbers Maze | `cherokee-numbers-maze` | `linux` | `content/apps/cherokee-numbers-maze---ᏣᎳᎩ-ᏗᏎᏍᏗ-ᏚᎴᎾᎯᎯ/NumbersMaze.x86_64` |
| Numbers Maze | `cherokee-numbers-maze` | `windows` | `content/apps/cherokee-numbers-maze---ᏣᎳᎩ-ᏗᏎᏍᏗ-ᏚᎴᎾᎯᎯ/NumbersMaze-x86_64.exe` |
| Numbers Maze | `cherokee-numbers-maze` | `mac` | `content/apps/cherokee-numbers-maze---ᏣᎳᎩ-ᏗᏎᏍᏗ-ᏚᎴᎾᎯᎯ/NumbersMaze-mac.zip` |
| Numbers Maze | `cherokee-numbers-maze` | `html` | `static/HTML-Games/NumbersMaze/` (zipped) |

Syllabary and CLL1 launch desktop-channel-only: the site never hosted APKs for them (their Android builds went through the stores), and no store-era APK artifact is in evidence in this repo.

## Success criteria

| ID | Criterion | Class | Instrument | Traces to |
|---|---|---|---|---|
| SC-1 | Each of the four itch URLs serves its published game page | behavioral | HTTP GET of each URL returns the game page (HTTP 200 + expected game title) | R-1 |
| SC-2 | Each page's download section lists its channels' files with filenames and byte sizes matching the source artifacts on disk | behavioral | Page fetch; compare listed filenames/sizes against the source files | R-4 |
| SC-3 | Each page's payment setting reads "Name your own price" | behavioral | Page fetch text | R-2 |
| SC-4 | Each page's description derives from its site page's prose with no factual claim absent from that prose | content | Side-by-side read of the itch description against the site page source | R-3 |
| SC-5 | The repo-local push script + gitignored `itch.conf` exist, carry the BoundPronouns-pattern guards (REPLACE_ME, butler resolution), and encode the channel table | structural | Read the script and config | R-5 |
| SC-6 | The pushes carry no version claims | structural | Script read (`--userversion` absent); butler push output shows auto-numbered builds only | R-4 |
| SC-7 | The Cherokee Numbers Maze page offers the playable browser build | behavioral | Page fetch shows the HTML5 playable embed | R-6 |

Traceability note: R-7 and R-8 are procedural/boundary requirements whose satisfaction is verified by the work's own record (ordering of steps taken) and the diff scope respectively; they carry no standalone SC.

## Approach

Mirror the proven BoundPronouns pattern end to end: the developer creates and configures the four itch projects dashboard-side (one-time prerequisites: `butler` install + `butler login`, project creation with the R-1/R-2 settings), the agent supplies description text adapted from the site pages and executes the butler pushes through the repo-local tooling, then verifies the live pages against the SCs.

Alternatives weighed (2026-11-09): CI-driven pushes — rejected, these are one-time deployments of existing artifacts, and CI enters later at the binary-repo deploy-pipeline conversion; a single bundled desktop channel for Numbers Maze — rejected, platform-specific Godot binaries need per-platform channels for correct auto-tagging; API-driven project creation — rejected, no documented butler/API path creates projects.

## Out of scope

- Phase-2 site-page link edits — separate specs, one per app page (`.issues/20` is the Bound Pronouns template).
- Binary-repo deploy-target conversion tickets (`CherokeeLanguage/Animals`, `Syllabary`, `cll1-gdx`, `NumbersMaze.godot`) — filed separately in their own repos.
- Any artifact rebuild — only existing site-repo copies deploy; Animals' Godot version is explicitly not deployable yet (developer statement, 2026-11-09).
- Stale-artifact cleanup in this repo, orphaned downloads (e.g. unreferenced `static/downloads/animals-say-and-see/`), store-link removal — phase-2 content work.

## Impact

Four public itch.io pages appear under the `cherokee-language` account. No site page content changes; the binary repos are untouched; Bound Pronouns is unaffected. Risk is low: new external state only, no destructive operation (a mis-configured page can be edited or deleted dashboard-side; butler pushes to a channel are idempotent and re-pushable).

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
