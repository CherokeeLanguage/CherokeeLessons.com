# Spec — Add the itch.io listing to the Bound Pronouns app page

CherokeeLessons.com#20 · local-authoritative · sibling of BoundPronouns#59

## Provenance

- **Developer statements (2026-11-05/06, chat):** "the app should also be listed in ../CherokeeLessons.com" — in the context of the itch.io publication just landed (BoundPronouns#55: channels live, page published) and the itch store-description work (BoundPronouns#59, split here per the single-repo scope rule).
- **Observed repo facts (verified 2026-11-06):** the site already hosts a Bound Pronouns app page at `content/apps/bound-pronouns/index.md` (Zola page, zulma theme, `title = "Bound Pronouns App"`): description, feature prose, support URL (github.com/CherokeeLanguage/BoundPronouns/issues), store links (Google Play, Apple, Amazon), and **direct-download links to stale artifacts shipped inside the repo** (`BoundPronouns-3.41.jar`, `BoundPronouns-3.41-release.apk`; repo also holds 3.40 and 3.30 APKs), last app-update note "(App updated 2022-07-18)". **No itch.io link exists anywhere on the page** — searched across `content/`; only pre-existing per-app page references.
- ** itch.io facts (verified 2026-11-05, BoundPronouns#55):** the itch page (https://cherokee-language.itch.io/cherokee-bound-pronouns) is live with `win-linux-mac` and `android` channels carrying the current release; itch serves both store-style downloads and direct APK/jar downloads from the same page.

## Problem

The app's own website listing predates the itch.io page and does not mention it: a visitor to cherokeelessons.com has no way to learn the itch page exists, and the site's direct-download links point at stale 2022 artifacts (3.41) while the current release ships on itch.

## Scope

This repository (CherokeeLessons.com): the Bound Pronouns app page `content/apps/bound-pronouns/index.md` gains the itch.io listing. The requirement's files live in this repo, so the spec is filed here — the sibling BoundPronouns#59 spec owns the itch description text and never touches this repo.

## Requirements

- **R-1 — itch.io listing.** The page's `### App Stores` section gains an itch.io link (label: `Windows/MacOS/Linux/Android App via itch.io` or equivalent naming the four platforms, matching the section's existing phrasing pattern) pointing at https://cherokee-language.itch.io/cherokee-bound-pronouns.
- **R-2 — Direct-download pointer.** The `### Direct Download` section gains an itch.io line stating the downloadable jar/APK also live on the itch page (e.g. `Desktop and Android Apps via itch.io` with the same URL), so a visitor finds the current builds even if the repo's own stale jar links remain.
- **R-3 — No invention.** No new factual claims about the app beyond what the page already states plus the itch URL itself; the itch description text itself is owned by BoundPronouns#59 and is not a deliverable here.
- **R-4 — Zola-conformant edit.** The change stays inside the page's existing Tera-compatible body content (no front-matter restructuring, no new image dependency).

## Out of scope

- Refreshing the stale artifacts or changelog (3.41 jars, update-date line) — the page needs a wider update pass than "itch listed"; if wanted, separate spec.
- The itch description text (BoundPronouns#59's deliverable).
- Page redesign, featured image, tags/front-matter.
- Other app pages (Cherokee Numbers Maze, Animals, Syllabary).

## Approach

Two additive lines in the page's existing sections (App Stores, Direct Download), both pointing at the itch page URL. Zola build sanity-check (`zola build`) after the edit.

## Success criteria

| ID | Criterion | Class | Instrument |
|----|-----------|-------|------------|
| SC-1 | The page's App Stores section contains an itch.io link labeled to name the four platforms, URL correct | structural | link present + URL read |
| SC-2 | The Direct Download section contains an itch.io line covering the site's downloadable builds | structural | line present + URL read |
| SC-3 | No factual claim added beyond the existing page content and the itch URL | content | diff read |
| SC-4 | The edited page builds under the site's Zola build without template errors | behavioral | executed `zola build` output, clean exit |

## Impact

One file, two additive lines. Risk: low — static content; no runtime surface. The stale-artifact question is flagged to the developer as follow-up work.

---

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
