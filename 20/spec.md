# Spec — Add the itch.io listing to the Bound Pronouns app page

CherokeeLessons.com#20 · local-authoritative · sibling of BoundPronouns#59

## Provenance

- **Developer statements (2026-11-05/06, chat):** "the app should also be listed in ../CherokeeLessons.com"; "the app is now only available via itch.io" (2026-11-06 — the page's Play/Apple/Amazon listing entries are superseded and itch.io is the sole current channel).
- **Observed repo facts (verified 2026-11-06):** the site already hosts a Bound Pronouns app page at `content/apps/bound-pronouns/index.md` (Zola page, zulma theme, `title = "Bound Pronouns App"`): description, feature prose, support URL (github.com/CherokeeLanguage/BoundPronouns/issues), store links (Google Play, Apple, Amazon), and **direct-download links to stale artifacts shipped inside the repo** (`BoundPronouns-3.41.jar`, `BoundPronouns-3.41-release.apk`; repo also holds 3.40 and 3.30 APKs), last app-update note "(App updated 2022-07-18)". **No itch.io link exists anywhere on the page** — searched across `content/`; only pre-existing per-app page references.
- ** itch.io facts (verified 2026-11-05, BoundPronouns#55):** the itch page (https://cherokee-language.itch.io/cherokee-bound-pronouns) is live with `win-linux-mac` and `android` channels carrying the current release; itch serves both store-style downloads and direct APK/jar downloads from the same page.

## Problem

The app's own website listing predates the itch.io page and does not mention it: a visitor to cherokeelessons.com has no way to learn the itch page exists, and the site's direct-download links point at stale 2022 artifacts (3.41) while the current release ships on itch.

## Scope

This repository (CherokeeLessons.com): the Bound Pronouns app page `content/apps/bound-pronouns/index.md` gains the itch.io listing. The requirement's files live in this repo, so the spec is filed here — the sibling BoundPronouns#59 spec owns the itch description text and never touches this repo.

## Requirements

- **R-1 — itch.io listing.** The `### App Stores` section is updated so itch.io is the listing it names — the Play / Apple / Amazon entries are superseded by the developer's 2026-11-06 statement that the app is now only available via itch.io, so they are removed (or the section carries a single itch.io entry naming the four platforms — Windows, macOS, Linux, Android — in the section's phrasing pattern), pointing at https://cherokee-language.itch.io/cherokee-bound-pronouns.
- **R-2 — Direct-download pointer.** The `### Direct Download` section points the downloadable builds at the itch page (replacing the stale in-page 3.41 jar/APK links), so a visitor finds the current builds in one place.
- **R-3 — No invention.** No new factual claims about the app beyond what the page already states, the itch URL itself, and the developer's 2026-11-06 availability statement ("the app is now only available via itch.io"). The itch description text itself is owned by BoundPronouns#59 and is not a deliverable here.
- **R-4 — Zola-conformant edit.** The change stays inside the page's existing Tera-compatible body content (no front-matter restructuring, no new image dependency).

## Out of scope

- Removing the stale 3.41 jar/APK **binary files** from the repo's content tree — this spec supersedes their *links* on the page, but the files' disposition is separate.
- The itch description text (BoundPronouns#59's deliverable).
- Page redesign, featured image, tags/front-matter.
- Other app pages (Cherokee Numbers Maze, Animals, Syllabary).

## Approach

Two additive lines in the page's existing sections (App Stores, Direct Download), both pointing at the itch page URL. Zola build sanity-check (`zola build`) after the edit.

## Success criteria

| ID | Criterion | Class | Instrument |
|----|-----------|-------|------------|
| SC-1 | The App Stores section names itch.io (labeled to cover the four platforms) and no longer lists Play/Apple/Amazon as current sources | structural | section text read |
| SC-2 | The Direct Download section points the downloadable builds at the itch page, not the stale in-page 3.41 jar/APK files | structural | section text read; stale 3.41 links absent |
| SC-3 | No factual claim added beyond the existing page content and the itch URL | content | diff read |
| SC-4 | The edited page builds under the site's Zola build without template errors | behavioral | executed `zola build` output, clean exit |

## Impact

One file, additive plus superseded-link removal. Risk: low — static content; no runtime surface. The page's broader staleness (changelog, update-date line) remains flag-worthy beyond this spec.

---

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
