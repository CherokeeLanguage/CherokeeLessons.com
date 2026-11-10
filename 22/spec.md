# Spec — itch.io page for Cherokee Language Animals: create the page and deploy the published artifacts (itch migration, phase 1)
Paired spec: **CherokeeLanguage/Animals#11** — the Animals repo's side of this app's migration (its deploy-target conversion). This spec owns the cherokeelessons.com side: the itch page and the initial deployment of the currently-published artifacts.


## Problem

The Cherokee Language Animals app is downloadable only through site-hosted binaries and store links of unknown validity. The migration makes itch.io the app download channel; this app has no itch presence, so the phase-2 landing-page edit for its site page will have no itch URL to point at.

## Scope

Phase 1 of the two-phase migration, for this app: create its itch.io project page and deploy this repo's currently-published Animals artifacts to it. Site-repo changes are limited to the repeatable push tooling; the site's app pages are not modified in this phase (phase 2 owns those edits).

## Requirements

- **R-1 — itch project page.** A itch.io project is created under the `cherokee-language` account, titled "Cherokee Language Animals" (slug `cherokee-language-animals`, page `https://cherokee-language.itch.io/cherokee-language-animals`), published, classified Educational, with the developer-created itch cover (`Artwork.Source/itch-io-CherokeeAnimals-promo.png` in the Animals repo, 630×500) as cover art — revised in place 2026-11-09 from the site page's featured image (`static/images/CherokeeAnimals-promo.jpg`): the developer created the itch-specific cover during the migration and the page shipped with it (og:image verified 630×500). Project creation is a developer dashboard step — butler has no project-creation path (it pushes to existing projects), matching the Bound Pronouns precedent.
- **R-2 — Pricing mirrors Bound Pronouns.** The page's payment setting is "Name your own price" (free download, donations enabled) — the developer's "download/donate page" direction and the live Bound Pronouns page's configuration.
- **R-3 — Description derives from the site page.** The page's description text is adapted from `content/apps/animals/index.md`'s existing prose, with no factual claim absent from that prose (BoundPronouns#59 is the form precedent). Cover image is the developer-created itch cover (R-1, revised 2026-11-09).
- **R-4 — Butler deployment of existing artifacts.** The page's download channels carry this repo's currently-published Animals artifacts per the channel table, pushed with butler. Pushes carry no version claims (no `--userversion`; butler's auto-numbering stands). Artifacts deploy as opaque files under their existing filenames — metadata (tags, filename versions, page dates) is not trusted, so no version label is verified or asserted as truth.
- **R-5 — Repeatable push tooling.** The repo-local push script plus gitignored `itch.conf` (mirroring the BoundPronouns pattern: butler resolution PATH→vendored `.tools/butler/`, `REPLACE_ME` config guard, per-channel pushes) encode this app's channel-table rows. No secrets in the repo — butler credentials live in butler's own store.
- **R-7 — Ordering.** The dashboard project creation precedes the butler pushes; platform tags follow butler's channel-naming rules (`win-linux-mac` and `android` auto-tag).

### Channel table

| App | itch project (slug) | Channel | Source artifact (this repo) |
|---|---|---|---|
| Animals | `cherokee-language-animals` | `win-linux-mac` | **restored 2026-11-09** (Animals#13; **display fix redeployed 2026-11-09, Animals#15** — the instructions-screen overflow fix, hotfix/5.12 commit 2afef8e): content-complete `Animals-5.12.jar` rebuilt from the `hotfix/5.12` line (commit 36720a1 — the packaging fix; originally struck 2026-11-09 as defective: engine-only, the 71MB assets were never packaged) — deployed and verified live (56 MB display ≈ 59,642,525 B after the #15 redeploy, win/linux/mac icons) |
| Animals | `cherokee-language-animals` | `android` | `content/apps/animals/Animals-5.12-release.apk` — deployed and verified live |

## Success criteria

| ID | Criterion | Class | Instrument | Traces to |
|---|---|---|---|---|
| SC-1 | The itch URL serves the published game page | behavioral | HTTP GET of the URL returns the game page (HTTP 200 + expected game title) | R-1 |
| SC-2 | The page's download section lists its channels' files with filenames matching the channel table's source artifacts, and each displayed file size consistent with its source artifact's size at the page's displayed granularity | behavioral | Page fetch; compare listed filenames against the source files' names, and each displayed size against the source file's byte size rounded the same way the page displays it | R-4 |
| SC-3 | The page's payment setting reads "Name your own price" | behavioral | Page fetch text | R-2 |
| SC-4 | The page's description derives from the site page's prose with no factual claim absent from that prose | content | Side-by-side read of the itch description against the site page source | R-3 |
| SC-5 | The repo-local push script + gitignored `itch.conf` exist, carry the BoundPronouns-pattern guards (REPLACE_ME, butler resolution), and encode this app's channel-table rows | structural | Read the script and config | R-5 |
| SC-6 | The pushes carry no version claims | structural | Script read (`--userversion` absent); butler push output shows auto-numbered builds only | R-4 |

Traceability note: R-7 is a procedural requirement whose satisfaction is verified by the work's own record (ordering of steps taken); it carries no standalone SC. The site-pages boundary is carried by this spec's Scope section.

## Approach

Mirror the proven BoundPronouns pattern: the developer creates and configures the itch project dashboard-side (one-time prerequisites: `butler` install + `butler login`, project creation with the R-1/R-2 settings), the agent supplies description text adapted from the site page and executes the butler pushes through the repo-local tooling, then verifies the live page against the SCs.

Alternatives weighed (2026-11-09): CI-driven pushes — rejected, this is a one-time deployment of existing artifacts, and CI enters later at the binary-repo deploy-pipeline conversion; API-driven project creation — rejected, no documented butler/API path creates projects.

## Out of scope

- The phase-2 edit of `content/apps/animals/index.md` (landing-page conversion) — separate spec.
- The `CherokeeLanguage/Animals` repo's deploy-target conversion ticket — filed in that repo.
- Any artifact rebuild — only the existing site-repo copies deploy; Animals' Godot version is explicitly not deployable yet (developer statement, 2026-11-09).

## Impact

One public itch.io page appears under the `cherokee-language` account. No site page content changes; the Animals repo is untouched; other apps unaffected. Risk is low: new external state only, no destructive operation (a mis-configured page can be edited or deleted dashboard-side; butler pushes to a channel are idempotent and re-pushable).

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)

> Full spec and plan artifacts: https://github.com/CherokeeLanguage/CherokeeLessons.com/tree/issues-data/22/
>
> AI-facing artifacts pointer: `.issues/22/`
