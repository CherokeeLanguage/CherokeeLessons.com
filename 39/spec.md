# Spec — URI-decodable asset paths for the Workers deploy (fix error 10304)

## Problem

The first Workers Builds production build of `master` (`3a9e81b`, 2026-11-12T05:04Z) completed `./build.sh` cleanly (zola 0.22.1; wrangler read 1,876 assets) but `npx wrangler deploy` failed at the asset-upload step:

```
✘ [ERROR] A request to the Cloudflare API (/accounts/…/workers/scripts/cherokeelessons-org/assets-upload-session) failed.
  Invalid manifest: Manifest path must be URI encoded.: invalid manifest file - check the request details and try again. [code: 10304]
```

Diagnosis (researched and source-verified, 2026-11-12):

- Wrangler `4.160.1` sends the assets-upload manifest with **raw filesystem paths** as keys — the upload code contains no URI-encoding step (`packages/deploy-helpers/src/deploy/helpers/assets.ts` at tag `wrangler@4.160.1`; the manifest object is POSTed verbatim to `assets-upload-session`).
- The API's error text is misleading. Per the Cloudflare maintainer on the tracking issue ([workers-sdk#14461](https://github.com/cloudflare/workers-sdk/issues/14461)): *"the problem is that the URI cannot be decoded (despite what the error message says)"* — the validator rejects manifest paths whose percent-decoding fails.
- In this site's built tree, exactly **3 file paths** fail percent-decoding — all derivatives of the single tracked source `content/virtual-classrooms/Cherokee-Language-101/ebook-cover-25%.png`, whose `%` is followed by `.` (a malformed escape):
  - `public/virtual-classrooms/Cherokee-Language-101/ebook-cover-25%.png` (colocated copy)
  - `public/processed_images/ebook-cover-25%.<hash>.png` × 2 (zola imageproc derivatives)
- Every other path decodes cleanly and serves correctly: a full `decodeURIComponent` sweep over all 1,876 built entries (1,351 files + 525 directories) throws on exactly the 3 paths above — the built tree's syllabary/Osage-named and space-bearing paths (hundreds of entries, e.g. `public/books/ꮳꮃꭹ-…/index.html`, `public/processed_images/Dictation 11-02.<hash>.jpg`) and every other entry decode without error. The asset router's design (verified in `packages/workers-shared/asset-worker/src/handler.ts` at the same tag) is **decode-before-match**: *"Decode incoming path… Match decoded path to manifest… Re-encode the path and redirect if the re-encoded path is different from the original path"* — raw-Unicode filenames are the configuration it serves correctly, while a filename that is itself percent-encoded text is reachable only at its double-encoded URL.

## Provenance

- Bug report: the developer's paste of the failing Workers Builds log, 2026-11-12 (this session). Triage verdict: actionable — a deploy-blocking defect in the #31 stand-up's delivered surface; cause identified with source-level and issue-tracker evidence. Converted in place into this governing spec (the issues card's work-entry conversion); the record reads as the spec on every surface (local store `.issues/39/`, remote tracker #39).
- Authorization: the standing directive of 2026-11-12 ("we need to work through setting up cloudflare, having merged into this repo the needed deploy files, and to verify it is serving") — this fix unblocks that arc's deploy-and-serve goal; the PR merge remains the developer's human gate.
- External evidence: workers-sdk#14461 (tracking issue: maintainer statements, closed-unmerged client fix #14467, gated server-side rollout with per-account enablement); npm registry — `4.160.1` still `latest` on 2026-11-12, so no client-side fix exists to pin.

## Scope

Single repository (this one). Surfaces:

| Surface | Change |
|---|---|
| `build.sh` | gains a post-build guard: fail the build naming any built path with a malformed percent-escape |
| `content/virtual-classrooms/Cherokee-Language-101/ebook-cover-25%.png` | renamed — no malformed escape in the tracked name |
| `content/virtual-classrooms/Cherokee-Language-101/index.md` | the `featured_image` front-matter reference follows the rename |

## Requirements

- **R-1:** Every path in the built deploy unit (files and directories) SHALL percent-decode cleanly (the assets API's rejection predicate, `decodeURIComponent` semantics — the serve-time router's own per-segment decoder). `build.sh` SHALL, after the zola build, exit non-zero naming each offending path when any built path contains either (a) a malformed percent-escape — a `%` not followed by two hexadecimal digits — or (b) an escape run that fails `decodeURIComponent`: each maximal run of consecutive escapes must decode as valid UTF-8, and a multi-byte lead escape interrupted by a literal character throws. The guard uses only tools already present in the build environments (find/sed/grep/printf/iconv) and adds no new package dependency.
- **R-2:** The source asset `ebook-cover-25%.png` SHALL be renamed so neither its tracked name nor any built derivative contains a malformed percent-escape; the single `featured_image` front-matter reference in `content/virtual-classrooms/Cherokee-Language-101/index.md` SHALL name the renamed file; the page's featured image SHALL remain the same image content.
- **R-3:** The Workers asset upload SHALL complete (the 10304 rejection gone) — evidenced first on this fix's PR preview build check, then on the post-merge `master` build.

## Success criteria

| ID | Criterion | Class | Instrument |
|---|---|---|---|
| SC-1 | The guard is present in `build.sh` and behaves per R-1: run against a production build of the pre-fix base tree (`3a9e81b`) it flags exactly the 3 malformed paths; run within the fixed tree's `./build.sh` the build exits 0 with no guard output | structural | fresh clone of each tree; run the guard's find/sed/grep pipeline on the base build's `public/` (expect exactly 3 hits), then `WORKERS_CI_BRANCH=master ./build.sh` on the fixed tree (expect exit 0, no guard output) |
| SC-2 | No tracked path contains a percent-escape that fails `decodeURIComponent`; the renamed source exists at its new tracked path with identical blob content; the front-matter line names it; a fresh production build emits the renamed image's paths and no `ebook-cover-25%` path | structural | the guard's predicate over `git ls-files` (= empty); blob-hash identity across the rename (`git cat-file -p 3a9e81b:<old path> \| sha256sum` = `sha256sum` of the new file); front-matter grep (= 1 hit, new name, 0 old); fresh `WORKERS_CI_BRANCH=master ./build.sh` exit 0; `find public -name '*ebook-cover-25%*'` (= 0); new-name grep in `public/` (≥ 1) |
| SC-3 | The Workers asset upload completes for this fix's branch, and again for post-merge `master` | behavioral | `gh pr checks <pr>` — the Workers Builds check green on the PR head (the preview build runs the same manifest upload); post-merge, the master build green |

## Out of scope

- No slugification or renaming of syllabary/Osage URLs — they decode and serve correctly under the router's decode-before-match design and are the site's canonical URLs.
- No percent-encoding of filenames at build time — refuted: encoded manifest keys serve only at double-encoded URLs, which would break every natural URL for the affected pages.
- No Cloudflare support engagement for the gated server-side fix (workers-sdk#14461) — removing the 3 malformed names eliminates this site's entire failure class; the tracking issue's residual %-name redirect quirks do not apply to a %-free tree.
- The R2 upload and the serving-verification sequence remain the post-merge steps recorded in `.issues/31/plan.md` — untouched by this fix.

## Approach

1. `git mv content/virtual-classrooms/Cherokee-Language-101/ebook-cover-25%.png` → `ebook-cover-25-pct.png` (the name keeps its meaning — "25%" marked a display scale — while shedding the malformed escape).
2. Update the single `featured_image` front-matter reference to the new name.
3. Add the guard to `build.sh` after the zola build, over every built path (files and directories), with `LC_ALL=C` exported for the guard's tools — the bracket ranges in the sed/grep patterns are locale-collation-sensitive (under UTF-8 locales glibc collation places `é`/`ç`/`æ` inside `[a-f]` and `É` inside `[A-F]`, so `%2é`-shaped fragments would be stripped or matched as escapes that `decodeURIComponent` rejects; the C locale restores byte-exact classes — demonstrated divergence under `en_US.UTF-8`, zero divergence under `LC_ALL=C`): (a) strip valid escapes with `sed 's/%[0-9A-Fa-f][0-9A-Fa-f]//g'` — any surviving `%` is a malformed escape; (b) extract each **maximal run of consecutive escapes** with `grep -oE '(%[0-9A-Fa-f]{2})+'` and validate each run independently: (i) **range rejection** — normalize the run's hex bytes to upper case and fail the run when any byte is `F5`, `F6`, or `F7`, or when `F4` is followed by a byte ≥ `0x90` (code points above U+10FFFF: `decodeURIComponent` rejects them, glibc `iconv` accepts them); (ii) emit the run's bytes via `printf '\xNN'` and require valid UTF-8 through `iconv -f UTF-8 -t UTF-8` (overlong forms, surrogates, and truncated sequences fail there). Run-wise validation with the range rejection reproduces `decodeURIComponent`'s throw surface exactly: within a run the decoder consumes escapes contiguously as one UTF-8 sequence (`%E1%8E%A3` passes; `%C3%41` fails — `0x41` is not a continuation byte), a literal character between escapes splits the run so a dangling lead (`%C3x%A9` → runs `%C3`, `%A9`) fails its run's validation, and the above-U+10FFFF class fails the range check. Valid escapes (`%25`) pass. The guard's sensitivity across all branches — including `F5 80 80 80`, `F4 90 80 80`, and a `%2é`-shaped collation case — is checked once in a scratch tree (ephemeral observation, not committed).
4. Verify in fresh clones: SC-1 (guard RED on base, GREEN on the fix), SC-2 (greps + fresh production build).
5. Open the PR; the Workers Builds preview check on the PR head exercises the real upload path (SC-3 pre-merge); merge; the `master` build deploys.

## Impact

- Unblocks the cherokeelessons.org go-live: this deploy failure is the current blocker between the merged stand-up (#31) and the arc's serving verification.
- Visible change: one image's URLs change (`ebook-cover-25%.png` → `ebook-cover-25-pct.png` and its two processed derivatives) on one page — the theme's featured-image renders (the Zulma theme consumes `featured_image` in `templates/page.html` as a 450×450 in-article image and in `templates/post_macros.html` as 150×150 listing thumbnails; the site generates no og/twitter meta). No other content, layout, or URL-structure change.
- Risk: guard false-positives on valid escapes — bounded by the predicate equivalence in R-1/Approach; the built tree contains no valid-escape filenames today (census 2026-11-12: exactly 3 `%`-bearing paths, all malformed).

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
