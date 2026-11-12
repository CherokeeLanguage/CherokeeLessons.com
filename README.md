# CherokeeLessons.com

The new and improved CherokeeLessons.com using the Zola static site generator.

![Screenshot](screenshot.png)

## Building and deploying

The zola version is pinned in `ZOLA_VERSION` (currently 0.22.1 — the latest
release compatible with the vendored Zulma theme).

- `./build.sh` downloads the pinned zola release binary on first use (cached
  as `./zola`, gitignored), reports its version, and builds the site into
  `public/`. The branch decides the base URL: `master` builds with
  `https://cherokeelessons.org/`; any other branch builds domain-neutral
  (`--base-url /`) so a preview hostname serves; `SITE_BASE_URL` overrides
  both.

## Deployment (Cloudflare Workers Static Assets)

The site deploys through **Workers Builds**: a merge to `master` triggers a
build + `npx wrangler deploy` automatically; PR branches get preview builds
(inspect one with `npx wrangler preview`). The deploy unit is the assets-only
`wrangler.jsonc` manifest — no Worker script, no bindings — and wrangler is
pinned in `package.json`.

One-time setup (Cloudflare dashboard):

1. Connect the GitHub App to this repository.
2. Worker creation with the exact name `cherokeelessons-org` — a name mismatch
   is a builds-fail condition.
3. The build command: `./build.sh` (unset means no build runs and the Wrangler
   config is not consulted for it).
4. Production branch: `master` (the builds default is `main`).
5. Attach the custom domain names `cherokeelessons.org` and
   `www.cherokeelessons.org`.
6. R2 bucket with public delivery (`files.cherokeelessons.org`) for the two
   oversized book PDFs the asset limit excludes.

## Notes

postWeight=$(("$(date +%s)" / 10 * 10))
postDate="$(TZ=UTC date -u --iso-8601=seconds|cut -f 1 -d '+')Z"
echo "post weight: $postWeight"
echo "post date: $postDate"
