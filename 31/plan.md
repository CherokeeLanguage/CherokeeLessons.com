# Plan — stand up cherokeelessons.org on Cloudflare Workers (Static Assets)

Source spec: `.issues/31/spec.md` (validated: round-15 PASS). Single repo — this one. Work runs on `feature/31-cloudflare-workers-standup` off the verified trunk tip (`2cda34b`); the Cloudflare-side ops sequence at the bottom changes no repo files and is developer-executed. No test files are authored — every instrument below is a direct command (ephemeral observation); the repo has no test suite and no heavy tiers arise.

## Plan-time records (values the spec delegates to plan time)

- **R2 delivery (R-8's "recorded at plan time"):** bucket `cherokeelessons-downloads`, public delivery via the bucket custom domain `files.cherokeelessons.org` (same Cloudflare zone — the zone of record). Delivery URLs: `https://files.cherokeelessons.org/pdf-downloads/<basename>.pdf`. The `pub-<hash>.r2.dev` form cannot be known before bucket creation, so the deterministic custom-domain form is what makes plan-time recording possible.
- **Non-served relocation target (R-8):** `book-sources/pdf-downloads/` — a top-level tracked directory; zola serves only `static/`, `content/`, and theme assets, so nothing top-level outside them ships.
- **Wrangler pin (R-7):** the exact latest wrangler version at execution time (`npm view wrangler version` when item 3 runs).
- **`compatibility_date` (R-1):** the execution date, `YYYY-MM-DD`.
- **CSP origin set (R-5's plan-time derivation, from the built tree at trunk):** resource-loading origins are `'self'`; `giscus.app` (comment script + frame, `templates/page.html`); `fonts.googleapis.com` (stylesheet) + `fonts.gstatic.com` (font files) — the built default theme `superhero.css` @imports the stylesheet, and six further font-importing Zulma variants are visitor-selectable (`zulma_allow_theme_selection = true`); `www.youtube.com` (embed frames — two pages already embed via the shortcode, and #30 adds the rest). All other `http*` origins in the built HTML (wikipedia, lulu, amazon, smashwords, dictionary sites, …) are hyperlink navigation, not resource loads, and take no CSP origin.
- **Inline-execution requirement (same derivation):** the built tree carries 81 zola-generated alias stub pages (`templates/internal/alias.html` rendered from front-matter `aliases` — the binary-embedded template, not overridable: site templates load before `tera.extend(&ZOLA_TERA)` in zola 0.22.1, so a same-named site template is overwritten by the builtin; only `robots.txt` gets the after-extend re-add). Each stub's redirect is an inline `location.replace` script (with a `<noscript>` meta-refresh fallback) targeting the page's canonical URL. A CSP without an inline-script provision blocks all 81 legacy-URL redirects. **Decision (owned here):** `script-src` carries `'unsafe-inline'` alongside `'self'` and `https://giscus.app` — the inline scripts are first-party zola output on a fully static, developer-authored site (no user-generated HTML; giscus runs in its own isolated-origin iframe), so the provision costs negligible protection while the alternatives carry silent-drift traps: 81 script hashes baked into the tracked `_headers` break on every content or zola-pin change, and path-scoped relaxed rules (≈11: splats for `tags`/`categories`/`authors` plus singleton paths) must track future alias changes with no automatic detection. `style-src` already needs `'unsafe-inline'` (the audio shortcode's `style=` attribute).

## Items

### Item 1 — SC-16: the tracked jars leave tracking
- **Deliverable:** `static/downloads/CLL1-1.72.jar` and `static/downloads/Syllabary-3.24.jar` removed from tracking (`git rm`); the directory's tracked `.gitignore` untouched (this spec does not touch it — #30 deletes it).
- **RED:** `git ls-files '*.jar'` lists exactly those two paths.
- **GREEN:** `git rm static/downloads/CLL1-1.72.jar static/downloads/Syllabary-3.24.jar` (git history preserves them).
- **Instrument:** `git ls-files '*.jar'` is empty.

### Item 2 — SC-1: the assets-only deploy manifest
- **Deliverable:** tracked `wrangler.jsonc` carrying exactly: `"name": "cherokeelessons-org"`, `"compatibility_date"` (plan-time record), `"assets": { "directory": "./public", "not_found_handling": "404-page" }`, `"previews": {}` — no Worker script entry, no bindings.
- **RED:** `git ls-files wrangler.jsonc` is empty.
- **GREEN:** create the manifest in the repo root.
- **Instrument:** SC-1's grep set — the five required keys each present exactly, `"main"` and `bindings` absent.
- **Note:** re-verify the `previews {}` requirement against the wrangler version actually pinned (R-1's re-verify-at-implementation clause; the sibling observed the hard-error on wrangler 4.153.0, 2026-10-27).

### Item 3 — SC-7: wrangler pinned in package.json
- **Deliverable:** tracked `package.json` with a `devDependencies` entry `"wrangler": "<exact version>"` (the plan-time record's `npm view wrangler version` value at execution).
- **RED:** `git ls-files package.json` is empty.
- **GREEN:** create it (minimal manifest: name `cherokeelessons-site`, private, the pin).
- **Instrument:** SC-7's grep — `grep -cE '"wrangler": "[0-9]' package.json` = 1.

### Item 4 — SC-2: branch-aware build.sh
- **Deliverable:** `build.sh` gains branch/base-url resolution before the zola build invocation; the pin-download core (ZOLA_VERSION fetch/verify, `"$ZOLA" --version`, `"$ZOLA" build`) is unchanged except the build line gains the resolved `--base-url`.
- **RED:** `grep -c "WORKERS_CI_BRANCH" build.sh` = 0; a trunk build bakes `https://www.cherokeelessons.com/` into `public/atom.xml`.
- **GREEN:** resolution order: (1) explicit `SITE_BASE_URL` wins in every mode; (2) branch = `WORKERS_CI_BRANCH` when set, else the checkout's branch via `git symbolic-ref --short HEAD` (fallback when that fails — detached HEAD — is production-safe per the sibling precedent); (3) branch `master` → `--base-url https://cherokeelessons.org/`; any other branch → `--base-url /` (domain-neutral previews).
- **Instrument:** SC-2's grep set (`WORKERS_CI_BRANCH`, `master`, `base-url`, `ZOLA_VERSION` each ≥ 1) plus item 10's behavioral matrix.
- **Test tier:** none authored — the instrument is the SC's direct commands.

### Item 5 — SC-3: the base URL of record
- **Deliverable:** `config.toml` `base_url = "https://cherokeelessons.org/"`.
- **RED:** `grep -n "^base_url" config.toml` shows `https://www.cherokeelessons.com/`.
- **GREEN:** edit the one line.
- **Instrument:** the grep; the behavioral half (`atom.xml`/`sitemap.xml` greps) runs in item 10.

### Item 6 — SC-4: the lemmatizer redirect
- **Deliverable:** tracked `static/_redirects` carrying exactly one non-comment entry, in the documented unquoted form: `/CherokeeLemmatizerGwt* https://cherokeedictionary.net/CherokeeAnalyzer/#!Analyzer 302`.
- **RED:** `test -f static/_redirects` fails.
- **GREEN:** create it (comments only as `#` lines).
- **Instrument:** SC-4's anchored full-line match (= 1) + non-comment entry count (= 1); the behavioral `curl -I` half runs at deploy verification.

### Item 7 — SC-5: the security headers
- **Deliverable:** tracked `static/_headers` setting `X-Content-Type-Options: nosniff`, `X-Frame-Options: DENY`, `Referrer-Policy: strict-origin-when-cross-origin`, and the CSP derived from the plan-time origin set + inline-execution decision. Draft CSP (every origin observed in the built tree or spec-sanctioned; the final form is owned by item 10, case (f)): `default-src 'self'; script-src 'self' 'unsafe-inline' https://giscus.app; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; frame-src https://giscus.app https://www.youtube.com; connect-src https://giscus.app; frame-ancestors 'none'; base-uri 'self'; form-action 'self'` — `'unsafe-inline'` in style-src is observed-necessary (the audio shortcode renders a `style="…"` attribute); in script-src it is the plan-time inline-execution decision (the 81 zola alias stubs); `data:` and `i.ytimg.com` are absent from the built tree and carry no origin. Cross-spec ripple recorded: when #30's itch-backed pages land with widget embeds (its plan-level choice), the CSP gains `itch.io` in `frame-src` — caught by the same deploy-time browser verification.
- **RED:** `test -f static/_headers` fails.
- **GREEN:** create it (a `/*` wildcard rule carrying the headers).
- **Instrument:** SC-5's grep set — four headers + CSP lines carrying giscus.app, youtube, fonts.googleapis.com, fonts.gstatic.com; hyvor/vimeo absent.

### Item 8 — SC-11: the stale lemmatizer copy retired
- **Deliverable:** `static/CherokeeLemmatizerGwt/` (194 tracked files, 30 MB) deleted.
- **RED:** `git ls-files static/CherokeeLemmatizerGwt | wc -l` = 194.
- **GREEN:** `git rm -r static/CherokeeLemmatizerGwt` (after item 6 — the redirect serves the retired paths).
- **Instrument:** `git ls-files static/CherokeeLemmatizerGwt` empty; `test -d static/CherokeeLemmatizerGwt` fails.

### Item 9 — SC-6: the Apache-era publish path retired, docs truthful
- **Deliverable:** `publish.sh` and `content/.htaccess` deleted; `README.md`'s build-and-publish section rewritten — the Workers deploy path (merge to `master` → Workers Builds → `npx wrangler deploy`; PR previews via `npx wrangler preview`) and the full ops sequence (GitHub App connection; Worker creation with the manifest's name `cherokeelessons-org`; build command `./build.sh`; production-branch selection `master`; custom-domain attachment for apex and www; R2 bucket + public delivery), the stale publish.sh paragraph gone; `AGENTS.md`'s publish paragraph replaced with the Workers deploy path (one-line pointer to README for the ops detail).
- **RED:** `git ls-files publish.sh content/.htaccess` lists both; `grep -c "publish.sh" README.md` ≥ 1; `grep -c "publish.sh" AGENTS.md` ≥ 1.
- **GREEN:** `git rm publish.sh content/.htaccess`; rewrite the two docs.
- **Instrument:** SC-6's grep set — both files absent; `publish.sh` count = 0 in both docs; every enumerated element present in README (`cherokeelessons-org`, `build command`, `npx wrangler deploy`, `wrangler preview`, `Workers Builds`, worker creation, `GitHub App`, `custom domain`, `R2`, `master`).

### Item 10 — SC-9, SC-3 (behavioral half), SC-12, SC-13, SC-14, SC-15: the fresh-clone build matrix
- **Deliverable:** executed verification matrix in a scratch `git clone --depth 1` of the branch (runs after items 1–9 and 12 — the tree state it verifies is the final one).
- **RED:** on trunk, a fresh clone's `./build.sh` bakes `https://www.cherokeelessons.com/` into `public/atom.xml` (≥ 1 occurrence) and no branch behavior exists to vary it.
- **GREEN:** run the matrix: (a) `WORKERS_CI_BRANCH=master ./build.sh` → exit 0 (SC-9) and `grep -c "cherokeelessons.org" public/atom.xml` ≥ 1, same for `sitemap.xml` (SC-3 behavioral) — production mode pinned explicitly because a scratch clone of the branch checks out a non-`master` branch and would otherwise exercise preview mode (discovered at execution; amendment recorded in the validation record); (b) `WORKERS_CI_BRANCH=feature-x ./build.sh` → both counts = 0 (SC-12, domain-neutral); (c) (b) + `SITE_BASE_URL=https://example.com` → `grep -c "https://example.com" public/atom.xml` ≥ 1 (SC-13); (d) `WORKERS_CI_BRANCH=master SITE_BASE_URL=https://example.com ./build.sh` → ≥ 1 (SC-14); (e) `git checkout --detach HEAD` then `./build.sh` → `grep -c "https://cherokeelessons.org" public/atom.xml` ≥ 1 (SC-15, production-safe); (f) **CSP final form (owns item 7's draft):** re-derive the resource-load origin set AND the inline-execution requirement from the built tree (`grep` the built HTML for `src=`/`href=` resource attributes and for inline `<script>` occurrences), reconcile `static/_headers` against the derivation if it differs, and re-run SC-5's grep set on the final `_headers`.
- **Instrument:** the executed commands and their greps, per SC; case (f)'s reconciliation is evidenced by the diff (or the verified no-diff) between the draft and the derived CSP.

### Item 11 — SC-10: the deploy unit validates
- **Deliverable:** `npx wrangler deploy --dry-run` executed in the item-10 fresh clone; exit 0 with the assets directory accepted.
- **RED:** on trunk the command fails — no manifest exists to validate.
- **GREEN:** run it after item 10 (node via the repo's ensure-node tooling; wrangler comes from the item-3 pin).
- **Instrument:** the executed dry-run's exit status and its assets-directory acceptance line.

### Item 12 — SC-8: the oversized PDFs out of the assets surface, book pages relinked
- **Deliverable:** `git mv static/pdf-downloads/Na_Kanoheda_Kwiti_Jisdu-embedded-cover.pdf static/pdf-downloads/Cherokee-Language-Lessons-Volume-I-embedded-cover.pdf` → `book-sources/pdf-downloads/` (both stay tracked); the two linking pages' download links re-pointed to the plan-time R2 delivery URLs — `content/books/ꮳꮃꭹ-ꭶꮼꮒꭿꮝꮧ-ꮧꮥꮆꮖꮝꮧ-1.md` (Volume I) and `content/books/ꮎ-ꭷꮓꭾꮣ-ꮘꮨ-ꮵꮝꮪ.md` (Na Kanoheda Kwiti Jisdu) — the only two pages referencing the oversized PDFs (verified against the tree; other book pages link small PDFs that stay served).
- **RED:** post-build `find public -type f -size +25M` lists the two PDFs; both pages carry `](/pdf-downloads/<name>.pdf)` links.
- **GREEN:** the moves and the two link edits.
- **Instrument:** SC-8's set — post-build `find public -type f -size +25M` empty; `git -c core.quotepath=off ls-files '*embedded-cover.pdf'` finds both at their new paths; each page's link grep finds the R2 delivery URL.
- **Depends on ops (re-sequenced per developer direction, 2026-11-12):** the R2 bucket and upload happen at the developer's worker-setup time, AFTER the merge ("I will setup the worker after the PR is merged with the needed configs") — nothing manual blocks the PR. This PR carries the relocation and the relinks; the two book links 404 on the deployed site until the upload lands, inside the developer's stated acceptance ("even with internal broken links"). The upload is two objects, one-time — dashboard drag-and-drop or two `wrangler r2 object put` commands at setup time.

## Ordering

1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → 10 → 11 → 12 (post-merge; the PR carries items 1–11 verified). Items 1–9 are independent file changes verified in place; item 12's relocation + relinks land in this PR — the relocation is what makes the deploy unit valid — but its R2 upload prerequisite is the developer's post-merge worker-setup step, so the book links serve 404 until then (accepted). Item 10 then 11 close the behavioral set; item 11's dry-run re-runs after item 12's relocation (the deploy unit shrinks) so its final execution is on the tree the PR carries. No cycles: every item's RED runs against the state its predecessors produced.

## Cloudflare-side ops sequence (developer-executed; no repo files change)

1. **R2 (at worker-setup time, post-merge — unblocks the book links):** dashboard → R2 → create bucket `cherokeelessons-downloads` → enable public access via custom domain `files.cherokeelessons.org` → upload both PDFs at keys `pdf-downloads/Na_Kanoheda_Kwiti_Jisdu-embedded-cover.pdf` and `pdf-downloads/Cherokee-Language-Lessons-Volume-I-embedded-cover.pdf` (equivalently: two `wrangler r2 object put` commands from the repo root). The book pages' links (this PR) go live the moment this lands.
2. **Workers Builds connection:** Workers & Pages → connect GitHub (the App) → repository `CherokeeLanguage/CherokeeLessons`.
3. **Worker creation:** name exactly `cherokeelessons-org` (a name mismatch is a builds-fail condition).
4. **Build command:** `./build.sh` (unset means no build runs and the Wrangler config is not consulted for it).
5. **Production branch:** `master` (the builds default is `main` — this repo's branch of record is `master`).
6. **Deploy command:** `npx wrangler deploy` (the builds default) — confirm it reads the pinned wrangler from `package.json`.
7. **Custom domains:** attach `cherokeelessons.org` (apex) and `www.cherokeelessons.org` after the first deploy — the existing zone rules (`.com`→`.org` path-preserving, `www.org`→apex) stay untouched.## Verify-it-is-serving (post-merge; agent-executed)

- `curl -I https://cherokeelessons.org/` → 200 (the apex resolves and serves).
- `curl -I https://www.cherokeelessons.org/` → 301 → apex; `curl -I https://www.cherokeelessons.com/…` → 301 → .org path-preserving (existing rules light up).
- `curl -I https://cherokeelessons.org/CherokeeLemmatizerGwt/anything` → 302 with `Location` carrying `#!Analyzer` (SC-4's behavioral half).
- A bogus path → the built 404 page (`not_found_handling`).
- `_headers` visible on a response; giscus + theme fonts load without CSP console violations (browser check — playwright session against the live site).
- `curl -I` one R2 delivery URL → 200, and the relinked book pages' links resolve.

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
