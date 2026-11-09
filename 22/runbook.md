# Runbook — create the itch.io page for Cherokee Language Animals (then the agent pushes the builds)

Goal: `https://cherokee-language.itch.io/cherokee-language-animals` exists, published, priced "Name your own price", cover art uploaded — ready for the butler channel pushes (win-linux-mac, android) that the agent runs via the Animals repo's `itch-push.sh`.

Verified preconditions (2026-11-09, this machine):
- butler v15.32.0 vendored at `Animals/.tools/butler/butler`; `butler login` reports credentials valid.
- `itch.conf` filled and pointing at the staged artifacts (`dist/Animals-5.12.jar`, `dist/Animals-5.12-release.apk`); REPLACE_ME guard preflight passes.
- Cover art staged: `/home/muksihs/git/Animals/Artwork.Source/itch-io-CherokeeAnimals-promo.png` (630×500 — itch's exact cover size).
- The page itself: HTTP 404 — the only missing piece.

## Steps (dashboard — your itch.io login, ~2 minutes)

1. Open <https://itch.io/dashboard> → click **Create new project** (or go straight to <https://itch.io/game/new>).
2. **Title**: `Cherokee Language Animals`
   The **URL** field auto-fills — it must read `cherokee-language-animals`. If it doesn't, correct it by hand; the push target and the paired spec bind to this exact slug.
3. **Kind of project**: `Downloadable`
   (The jar and apk are download files; do NOT pick HTML.)
4. **Uploads**: leave empty — skip "Upload your game files". The butler pushes create the `win-linux-mac` and `android` download files themselves; a manual upload here would fight butler's channel structure.
5. **Cover image**: upload `/home/muksihs/git/Animals/Artwork.Source/itch-io-CherokeeAnimals-promo.png`
6. **Short description / description**: paste the description block below (derived from the site page's prose per CherokeeLessons.com#22 R-3 — no claims beyond it).
7. **Genre**: pick `Educational` if the dropdown offers it; if the current form's genre list doesn't carry it, leave genre unset and tell me what it offered (spec R-1's classification clause — decision recorded either way).
8. **Community**: leave the default (not spec-bound).
9. **Save & view page**, then set the project's visibility to **Published** (Edit game → the Draft/Restricted/Published selector next to Save) → **Save**.
10. **Pricing** (Edit game → Pricing): Payment settings → **$0 or donate** ("name your own price": free download, donations enabled) → Save. This is R-2; nothing paid, no minimum.

## Description (paste verbatim)

```text
Cherokee Language Animals teaches you to recognize the Cherokee names for more than 40 animals.

Animals include deer, skunk, leech, beaver, terrapin (turtle), snail, mink, camel, dog, crow, bobcat, raccoon, turkey, snake, badger, butterfly, and many more.

Version 5.12 features:

* 79 challenges spread across 9 levels!
* Common plurals as well as singulars
* Improved audio (Tacotron TTS generated)
* Accuracy percents calculated per completed level
* Training screen with a "skip" button, and training can be disabled
* Better pause/resume support
* Challenge display in Syllabary, Latin, or none
* New options volume control for challenges and effects
* Android-TV support with remote or gamepad (beta)
* Much improved load time
```

## After the page exists — say "page is up" (or anything meaning that)

The agent then runs, unattended:
1. `./itch-push.sh` from `/home/muksihs/git/Animals` — pushes `dist/Animals-5.12.jar` → `cherokee-language/cherokee-language-animals:win-linux-mac` and `dist/Animals-5.12-release.apk` → `:android`, with `butler status` receipts. No version labels (auto-numbering).
2. Verifies the live page against CherokeeLessons.com#22's SCs (page 200 + title, channel files listed with the right names/sizes, payment setting, description provenance).

## Rollback / undo

- Any field mis-set: Edit game → fix → Save (all spec'd fields are editable post-publish).
- Whole page wrong: Edit game → **Delete project** (bottom of the edit form) → recreate. Butler pushes are idempotent — re-running `itch-push.sh` after any recreate re-establishes both channels.
- A push to a wrong channel: pushes are per-channel; delete the offending file dashboard-side (Edit game → upload slot's trash icon) and re-push.
