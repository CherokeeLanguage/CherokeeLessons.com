# Spec — itch migration phase 1 umbrella: one paired spec set per app

## Recomposition grounds

This issue was filed as a single phase-1 spec covering all four apps and reached a zero-finding validation PASS (round 4, `.issues/21/audit/validation.yaml`). The developer directed the split on 2026-11-09: "it should be one spec per app" and "(or paired specs as cherokeelessons.com needs separate specs from the app repo specific specs)". Recomposed per the issues card's recomposition protocol into four paired spec sets — the recomposition occurred during the spec phase, before any implementation or PR authorization, so no authorization is void.

## Problem

cherokeelessons.com's app pages offer downloads through site-hosted binaries and store links; the migration makes itch.io the app download channel. Each app needs its itch page created and its currently-published artifacts deployed (the cherokeelessons.com side), and its own repo's release pipeline converted to itch.io as its deploy target (the app-repo side) — two repos, two specs, one job per app.

## Parts

Four paired spec sets, one per app:

| App | cherokeelessons.com side (itch page + initial artifact deployment) | app-repo side (deploy-target conversion) |
|---|---|---|
| Cherokee Language Animals | CherokeeLessons.com#22 | CherokeeLanguage/Animals#11 |
| Syllabary | CherokeeLessons.com#23 | CherokeeLanguage/Syllabary#2 |
| Cherokee Language Lessons 1 | CherokeeLessons.com#24 | CherokeeLanguage/cll1-gdx#4 |
| Cherokee Numbers Maze | CherokeeLessons.com#25 | CherokeeLanguage/NumbersMaze.godot#3 |

Each part's spec reads standalone and carries its own requirements, success criteria, and provenance. The app-repo specs' full specs live in their remote tracker records. `CherokeeLanguage/Animals` holds its own local issue store (maintained from Animals-repo sessions; not reachable through this workspace's store tooling): mirroring `CherokeeLanguage/Animals#11` there is left to an Animals-repo session per the mirror-repair rule; the other three repos hold no local stores.

## Seams

- **URL canonicity.** Each cherokeelessons.com-side spec binds the itch page URL its dashboard step creates (`https://cherokee-language.itch.io/<slug>`); the paired app-repo spec tracks that same URL in its itch config (`ITCH_URL`) and README. The site-side URL is canonical.
- **Initial deployment vs future releases.** The cherokeelessons.com side deploys the currently-published artifacts (this repo's copies) to the page's channels; the app-repo side converts the repo's release pipeline for future releases and performs no production push — a conversion-verification push would replace a published channel artifact.
- **Shared push tooling (cherokeelessons.com side).** One repo-local push script plus gitignored `itch.conf` serve all four cherokeelessons.com-side specs; each spec's tooling criterion scopes to its own channel-table rows.
- **Shared conventions.** All eight specs mirror the BoundPronouns precedent: "Name your own price" pricing; descriptions adapted from the site pages' prose with no new factual claims; no version claims (metadata is not trusted — butler auto-numbering stands); the BoundPronouns tooling pattern (butler resolution PATH→vendored, `REPLACE_ME` guard, gitignored `itch.conf`, no secrets in repos).
- **Ordering.** Each app's dashboard project creation precedes its butler pushes; app-repo conversion work proceeds independently (no production push involved).

## Closure order

Each part closes by its own delivered work or triage verdict; this umbrella closes only after every part has closed.

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
