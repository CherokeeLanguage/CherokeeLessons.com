# Spec — itch.io page for Cherokee Language Lessons 1: create the page and deploy the published artifact (itch migration, phase 1)

## Problem

The Cherokee Language Lessons 1 app is downloadable only through a site-hosted binary and store links of unknown validity. The migration makes itch.io the app download channel; this app has no itch presence, so the phase-2 landing-page edit for its site page will have no itch URL to point at.

## Scope

Phase 1 of the two-phase migration, for this app: create its itch.io project page and deploy this repo's currently-published Cherokee Language Lessons 1 artifact to it. Site-repo changes are limited to the repeatable push tooling; the site's app pages are not modified in this phase (phase 2 owns those edits).

## Requirements

- **R-1 — itch project page.** A itch.io project is created under the `cherokee-language` account, titled "Cherokee Language Lessons 1" (slug `cherokee-language-lessons-1`, page `https://cherokee-language.itch.io/cherokee-language-lessons-1`), published, classified Educational, with the site page's featured image (`static/images/cll1-gdx.png`) as cover art. Project creation is a developer dashboard step — butler has no project-creation path (it pushes to existing projects), matching the Bound Pronouns precedent.
- **R-2 — Pricing mirrors Bound Pronouns.** The page's payment setting is "Name your own price" (free download, donations enabled) — the developer's "download/donate page" direction and the live Bound Pronouns page's configuration.
- **R-3 — Description derives from the site page.** The page's description text is adapted from `content/apps/cherokee-language-lessons-1.md`'s existing prose, with no factual claim absent from that prose (BoundPronouns#59 is the form precedent). Cover image comes from `static/images/cll1-gdx.png`, the file the site page's front matter references.
- **R-4 — Butler deployment of the existing artifact.** The page's download channel carries this repo's currently-published Cherokee Language Lessons 1 artifact per the channel table, pushed with butler. Pushes carry no version claims (no `--userversion`; butler's auto-numbering stands). The artifact deploys as an opaque file under its existing filename — metadata (tags, filename versions, page dates) is not trusted, so no version label is verified or asserted as truth.
- **R-5 — Repeatable push tooling.** The repo-local push script plus gitignored `itch.conf` (mirroring the BoundPronouns pattern: butler resolution PATH→vendored `.tools/butler/`, `REPLACE_ME` config guard, per-channel pushes) encode this app's channel-table row. No secrets in the repo — butler credentials live in butler's own store.
- **R-7 — Ordering.** The dashboard project creation precedes the butler pushes; platform tags follow butler's channel-naming rules (`win-linux-mac` auto-tags all three desktop platforms).

### Channel table

| App | itch project (slug) | Channel | Source artifact (this repo) |
|---|---|---|---|
| CLL1 | `cherokee-language-lessons-1` | `win-linux-mac` | `static/downloads/CLL1-1.72.jar` |

Desktop-channel-only launch: the site never hosted a CLL1 APK (its Android builds went through the stores), and no store-era APK artifact is in evidence in this repo.

## Success criteria

| ID | Criterion | Class | Instrument | Traces to |
|---|---|---|---|---|
| SC-1 | The itch URL serves the published game page | behavioral | HTTP GET of the URL returns the game page (HTTP 200 + expected game title) | R-1 |
| SC-2 | The page's download section lists its channel's file with filename matching the channel table's source artifact, and its displayed size consistent with the source artifact's size at the page's displayed granularity | behavioral | Page fetch; compare the listed filename against the source file's name, and the displayed size against the source file's byte size rounded the same way the page displays it | R-4 |
| SC-3 | The page's payment setting reads "Name your own price" | behavioral | Page fetch text | R-2 |
| SC-4 | The page's description derives from the site page's prose with no factual claim absent from that prose | content | Side-by-side read of the itch description against the site page source | R-3 |
| SC-5 | The repo-local push script + gitignored `itch.conf` exist, carry the BoundPronouns-pattern guards (REPLACE_ME, butler resolution), and encode this app's channel-table row | structural | Read the script and config | R-5 |
| SC-6 | The pushes carry no version claims | structural | Script read (`--userversion` absent); butler push output shows auto-numbered builds only | R-4 |

Traceability note: R-7 and R-8 are procedural/boundary requirements whose satisfaction is verified by the work's own record (ordering of steps taken) and the diff scope respectively; they carry no standalone SC.

## Approach

Mirror the proven BoundPronouns pattern: the developer creates and configures the itch project dashboard-side (one-time prerequisites: `butler` install + `butler login`, project creation with the R-1/R-2 settings), the agent supplies description text adapted from the site page and executes the butler pushes through the repo-local tooling, then verifies the live page against the SCs.

Alternatives weighed (2026-11-09): CI-driven pushes — rejected, this is a one-time deployment of an existing artifact, and CI enters later at the binary-repo deploy-pipeline conversion; API-driven project creation — rejected, no documented butler/API path creates projects; an Android channel — rejected for now, no APK artifact is in evidence to deploy.

## Out of scope

- The phase-2 edit of `content/apps/cherokee-language-lessons-1.md` (landing-page conversion) — separate spec.
- The `CherokeeLanguage/cll1-gdx` repo's deploy-target conversion ticket — filed in that repo.
- Any artifact rebuild — only the existing site-repo copy deploys.

## Impact

One public itch.io page appears under the `cherokee-language` account. No site page content changes; the cll1-gdx repo is untouched; other apps unaffected. Risk is low: new external state only, no destructive operation (a mis-configured page can be edited or deleted dashboard-side; butler pushes to a channel are idempotent and re-pushable).

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
