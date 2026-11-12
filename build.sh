#!/bin/bash

# Pinned zola build. The pin of record lives in ZOLA_VERSION; the matching
# release binary is fetched on first use and cached as ./zola (gitignored).

set -e
set -o pipefail

cd "$(dirname "$0")"

PIN="$(cat ZOLA_VERSION)"
if ! echo "$PIN" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    echo "ZOLA_VERSION is not MAJOR.MINOR.PATCH: '$PIN'" >&2
    exit 1
fi

ZOLA="./zola"
if [ ! -x "$ZOLA" ] || ! "$ZOLA" --version 2>/dev/null | grep -q "$PIN"; then
    echo "Fetching zola v$PIN..."
    URL="https://github.com/getzola/zola/releases/download/v${PIN}/zola-v${PIN}-x86_64-unknown-linux-gnu.tar.gz"
    curl -fL "$URL" | tar -xz
    chmod +x "$ZOLA"
fi

"$ZOLA" --version

# Branch-aware base URL (Cloudflare Workers Builds):
#   - SITE_BASE_URL wins in every mode when set.
#   - The branch of record (master) builds with the base_url of record
#     (https://cherokeelessons.org/); any other branch builds domain-neutral
#     (--base-url /) so a preview hostname serves correctly.
#   - WORKERS_CI_BRANCH (set by Workers Builds) takes precedence over the git
#     fallback; a detached HEAD (no symbolic ref) resolves production-safe.
BRANCH="${WORKERS_CI_BRANCH:-}"
if [ -z "$BRANCH" ]; then
    BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null || echo master)"
fi
if [ -n "${SITE_BASE_URL:-}" ]; then
    BASE_URL_ARGS=(--base-url "$SITE_BASE_URL")
elif [ "$BRANCH" = "master" ]; then
    BASE_URL_ARGS=(--base-url "https://cherokeelessons.org/")
else
    BASE_URL_ARGS=(--base-url "/")
fi

"$ZOLA" build "${BASE_URL_ARGS[@]}"
