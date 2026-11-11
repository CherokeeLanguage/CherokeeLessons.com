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
"$ZOLA" build
