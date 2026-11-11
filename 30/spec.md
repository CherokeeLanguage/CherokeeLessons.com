# Spec — content distribution & asset policy for the cherokeelessons.org stand-up

Remote issue: https://github.com/CherokeeLanguage/CherokeeLessons/issues/30

## Problem

The site carries ~3.49 GB of untracked-but-site-required assets, and its distribution model is changing by developer decision (session 2026-11-11): app/game distribution moves to the itch.io channel (`cherokee-language.itch.io` — 4 projects live, verified from the public profile), and lesson media is already mirrored on the developer's YouTube channel (`@-cherokeelanguage7554` — all 21 dictation videos, 23 CLL-1 tracks, and 9 animal-names tracks verified there by title/duration evidence, `research/youtube-video-id-map.txt`). Three page-less direct-URL surfaces from the private Language-Preservation-Technologies repos are slated for removal, the TTS demo audio and book TeX sources are untracked (so a fresh-clone build is incomplete), and the Google verification file is untracked. An executed stand-up gate (2026-11-11, shallow clone + pinned-zola build: 1,547 files / 0.48 GiB, exit 0) shows the fresh-clone build omits every untracked asset class; the same gate shows the planned Cloudflare Workers deployment (separate spec) is blocked by four tracked files over the platform's 25 MiB/file limit — two app jars this spec removes, two book PDFs the hosting spec dispositions.

## Provenance

- **Developer directives (2026-11-11, chat, in order):** "we are moving to itch-io for publishing apps etc."; factor in the YouTube channel overlap; "the unpublished apps that do not have real pages on the cherokeelessons.com site for language preservation technologies need to be re-scoped for removal from the site"; "track the tts demo audio — … determine what the text sources are for or contain"; "track them" (the tex sources); "file specs as needed to make the needed edits so that cherokeelessons.org becomes the new proper site".
- **itch.io channel (fetched live 2026-11-11):** `cherokee-language.itch.io` hosts `cherokee-numbers-maze` (play-in-browser), `cherokee-syllabary`, `cherokee-language-animals`, `cherokee-bound-pronouns` (each downloadable, Win/macOS/Linux/Android).
- **YouTube overlap (verified live 2026-11-11):** 69 videos on the channel; the 53 consumed here match local media by title verbatim (`track-info.json` titles = YouTube titles) and by a systematic ~5 s duration offset (local 13:45/18:22/46:58 ↔ YT 13:50/18:27/47:03).
- **LPT sources (local repos, verified 2026-11-11):** `intro_to_animals` export presets name the site artifacts exactly (`export/html5/index.html`, `export/Mac-OSX/animals-say-and-see.zip`, `export/Win-x64/…exe`, `export/linux-x64/…x86_64`); the VN is `mi_ma_ale_mo_uniyo_wesa` (Ren'Py 7.3.5.606 build; `options.rpy` title byte-identical to the site's page title). Both repos private (GitHub 404 unauthenticated).
- **Zero internal references** to the three LPT surfaces (built-HTML reference resolution over all 428 pages + source greps — `research/` of the asset-review, summarized in the work record).
- **Wrong links verified on the NumbersMaze page:** Apple link → Bound Pronouns app id `966667496`; Amazon link → BP ASIN `B00TCP955U`.
- **Stand-up gate (executed 2026-11-11):** shallow clone of trunk `789a7f8` + `./build.sh` → exit 0, 1,547 files / 0.48 GiB; over the 25 MiB/file Workers limit: `Syllabary-3.24.jar` (32.9), `CLL1-1.72.jar` (48.8), `Cherokee-Language-Lessons-Volume-I-embedded-cover.pdf` (36.5), `Na_Kanoheda_Kwiti_Jisdu-embedded-cover.pdf` (70.1). Log: `research/standup-gate-build.log`.
- **Text sources for the TTS demos (verified 2026-11-11):** generation text lives in public repos (`CherokeeLanguage/Cherokee-TTS` archived: `data/tests/animals/animals-game-mco.txt`; `CherokeeLanguage/cherokee-audio-data` active: `ced-mco.txt`, `ims-toucan-*.txt`, generators) or the tracked pages themselves (the Update-3 stories are printed in full in `index.md`) — tracking the audio completes reproducibility with no further text work.

## Scope

| Surface | Change |
|---|---|
| `content/apps/{animals,bound-pronouns,cherokee-numbers-maze…,syllabary-app.md}` (4 pages) | itch.io targets replace self-hosted binary links; wrong NumbersMaze store links removed |
| `static/downloads/{CLL1-1.72.jar,Syllabary-3.24.jar}` (tracked) | deleted; their page links removed |
| 14 Syllabary-Dictation pages, CLL-1 audio page, animal-names audio page | `{{audio}}` → `{{ youtube(id=…) }}` per the verified mapping |
| `static/Visual-Novels/mi-ma-mo-uniyo-wesa/`, `static/HTML-Games/LPT-IntroToAnimals/`, `static/downloads/animals-say-and-see/` (untracked) | deleted from the working tree |
| `static/Visual-Novels/.gitignore`, `static/downloads/.gitignore` (tracked) | deleted (vestigial) |
| 3 per-dir `.gitignore` files in the TTS demo dirs | `!*.mp3` negation (repo's own pattern); 45 mp3s tracked (~210 MB) |
| 3 `tex-source/.gitignore` files | rules removed; 3 `.tex` + 3 `.md` tracked (~1.6 MB) |
| `content/.gitignore` | google verification rules removed; file tracked |
| untracked mp3/mp4 working-tree files of the migrated classes | deleted from the working tree (no repo change) |

No hosting/CDN/Workers changes (separate spec); no theme changes; no itch.io project creation (ops).

## Requirements

- **R-1 — App distribution via itch.io.** The four itch-backed app pages SHALL reference their itch.io project URLs as the distribution target, replacing self-hosted absolute binary links; the `/HTML-Games/NumbersMaze/` link is replaced by the itch target; the wrong NumbersMaze store links SHALL be removed; the two tracked desktop jars SHALL be deleted with their page links removed (Syllabary's page gains its itch link; the CLL-1 page drops only its desktop link and keeps its store links — its itch project does not exist yet).
- **R-2 — Lesson media via YouTube embeds.** The 14 dictation pages, the CLL-1 audio page, and the animal-names audio page SHALL switch from `{{audio(file=…)}}` to `{{ youtube(id=…) }}` using the verified mapping (`research/youtube-video-id-map.txt`); page→video assignment derives from each page's current media references; the untracked mp3/mp4 sources of these classes are deleted from the working tree.
- **R-3 — LPT surfaces removed.** The three untracked directories SHALL be deleted from the working tree; the two vestigial tracked ignore artifacts SHALL be deleted.
- **R-4 — Track the TTS demo audio.** The 45 untracked demo mp3s (24 + 9 + 8 TTS, plus the 4 espeak clips — same demo-page class, inclusion flagged to the developer in session) SHALL be tracked via per-dir `.gitignore` negation (`!*.mp3`); the tracked `Animals*.mp3` rule in the first dir is replaced. Both 2021-05 generations of the animal TTS set are kept (the tracked `exercises.txt` references the 05-29 set while `index.md` embeds 05-31 — a recorded drift this spec preserves rather than resolves).
- **R-5 — Track the book TeX sources.** The 3 `.tex` files and their 3 `.md` conversions SHALL be tracked by removing the `tex-source/.gitignore` rules.
- **R-6 — Track the Google verification file.** `content/google593a568777046d5c.html` SHALL be tracked (the `content/.gitignore` google rules removed) — required for Search Console verification on the new host and consistent with R-4/R-5's reproducibility intent.

## Success criteria

| ID | Criterion | Class | Instrument | Traces to |
|---|---|---|---|---|
| SC-1 | The four itch-backed app pages reference their itch project slugs; no self-hosted absolute binary URLs remain in `content/apps/` | structural | `grep -rl "itch.io" content/apps` finds all four; `grep -rnE "cherokeelessons\.com/apps/.*\.(apk\|jar)" content` is empty | R-1 |
| SC-2 | The tracked desktop jars are deleted | structural | `git ls-files static/downloads` is empty | R-1 |
| SC-3 | The wrong NumbersMaze store links are gone | structural | `grep -rn "id966667496\|B00TCP955U" content/apps` is empty | R-1 |
| SC-4 | The migrated media pages use `{{ youtube(id=…) }}` with IDs from the archived mapping; their `{{audio}}` embeds are gone; other `{{audio}}` users (espeak page, TTS demo pages) are untouched | structural | per-page greps: `youtube(id=` present, `audio (file=` absent on migrated pages; IDs ∈ `research/youtube-video-id-map.txt`; espeak page `audio (file=` count unchanged (100) | R-2 |
| SC-5 | The three LPT directories are absent from the working tree; the two vestigial ignore artifacts are removed | structural | `test -d` fails for all three; `git ls-files static/Visual-Novels` and `git ls-files static/downloads/.gitignore` are empty | R-3 |
| SC-6 | 45 demo mp3s tracked with per-dir negations | structural | `git -c core.quotepath=off ls-files 'content/content/*.mp3'` counts 141 total (96 espeak + 45 newly tracked); the three dirs' `.gitignore` carry `!*.mp3` | R-4 |
| SC-7 | The 3 tex + 3 md companions are tracked | structural | `git -c core.quotepath=off ls-files '*tex-source/*'` finds the 6 content files | R-5 |
| SC-8 | The Google verification file is tracked | structural | `git ls-files content/google593a568777046d5c.html` lists it; `grep -c google content/.gitignore` = 0 | R-6 |
| SC-9 | Fresh shallow-clone build succeeds post-change | behavioral | executed `git clone --depth 1` + `./build.sh`; exit 0 | all |
| SC-10 | Post-change fresh-clone `public/` contains exactly 2 files over 25 MiB (the two book PDFs) | structural | `find public -type f -size +25M \| wc -l` = 2 in the SC-9 build | R-1 |
| SC-11 | No content references the removed LPT surfaces | structural | `grep -rnE "mi-ma-mo-uniyo-wesa\|LPT-IntroToAnimals\|animals-say-and-see" content templates config.toml` is empty | R-3 |

## Out of scope

- The Cloudflare Workers hosting stand-up (separate spec, filed next) — including the lemmatizer retirement + `_redirects` rule (kept whole there: the redirect exists only on the new platform) and the R2 disposition for the two oversized PDFs (both are live "FREE eBook" links with no smaller variants — verified).
- Hangman1 (source unresolved; itch-vs-remove undecided).
- CLL-1 itch.io project creation (ops prerequisite; its page rewrite follows when it exists).
- The `cll1-v3-audio.zip` bundle decision (250 MB; untracked; irrelevant to CI builds).
- Widget-embed vs plain-link presentation on the itch-backed pages (plan-level within R-1).
- The store-link retention policy beyond removing the verified-wrong links.

## Approach

Follow the developer's distribution decisions of record: itch.io for apps, YouTube for the mirrored lesson media (embeds via the existing `{{ youtube() }}` shortcode, in use since 2020), removal for the page-less LPT surfaces, tracking for site-required sources. Alternatives weighed: converting the legacy `.htaccess` rules — rejected (developer: legacy redirects discarded); keeping self-hosted app binaries alongside itch — rejected (the migration's purpose is retiring self-hosted distribution, and the platform's 25 MiB limit makes two of them un-deployable regardless); re-encoding the lesson media locally instead of YouTube embeds — rejected (the developer's own channel already hosts all 53 items verbatim).

## Impact

Consumers: the site build (a fresh-clone/CI build becomes complete for all retained surfaces — the executed gate's omissions disappear); app-page visitors (itch.io becomes the distribution target; correct store links retained); the books pages (unchanged — the PDFs stay on-site); the local working tree (shrinks ~2.6 GB of removed media). The tracked tree grows ~212 MB (audio + tex + google file). Downstream: the hosting spec's over-limit set drops from 4 files to 2 (the book PDFs — R2). Rollback: revert the commit set; untracked-file deletions are irreversible locally but re-obtainable from the private LPT repos, the TTS generation pipelines, and the YouTube channel.

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
