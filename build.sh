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

# >>> guard_uri_decodable_paths >>>
# Guard: every built path must percent-decode cleanly (decodeURIComponent
# semantics). Cloudflare's assets API rejects manifest keys whose URI
# decoding fails — observed live as Workers Builds error 10304, 2026-11-12
# (issue #39). A path fails when it contains a % not followed by two hex
# digits, or when a maximal run of consecutive escapes fails the decoder:
# the run's bytes must be valid UTF-8, leads F5/F6/F7 and F4 followed by a
# byte >= 0x90 are above U+10FFFF (iconv accepts them, the decoder does
# not), and a literal character between escapes splits the run so a
# dangling lead fails its run's validation. LC_ALL=C is exported inside the
# function because the bracket ranges are locale-collation-sensitive: under
# UTF-8 locales glibc collation places é/ç/æ inside [a-f], so %-hex-non-ASCII
# fragments would be stripped or matched as escapes the decoder rejects.
guard_uri_decodable_paths() (
    export LC_ALL=C
    while IFS= read -r p; do
        case "$p" in *%*) ;; *) continue ;; esac
        if printf '%s\n' "$p" | sed 's/%[0-9A-Fa-f][0-9A-Fa-f]//g' | grep -q '%'; then
            printf '%s\n' "$p"
            continue
        fi
        while IFS= read -r run; do
            [ -z "$run" ] && continue
            hex="$(printf '%s' "$run" | tr -d '%' | tr '[:lower:]' '[:upper:]')"
            bad=0
            for ((i = 0; i < ${#hex}; i += 2)); do
                b="${hex:$i:2}"
                case "$b" in
                    F5 | F6 | F7)
                        bad=1
                        break
                        ;;
                    F4)
                        n="${hex:$((i + 2)):2}"
                        if [[ "$n" =~ ^9[0-9A-F]$ || "$n" =~ ^[AB][0-9A-F]$ ]]; then
                            bad=1
                        fi
                        ;;
                esac
                if [ "$bad" = 1 ]; then
                    break
                fi
            done
            if [ "$bad" = 1 ]; then
                printf '%s\n' "$p"
                continue 2
            fi
            fmt="$(printf '%s' "$hex" | sed 's/../\\x&/g')"
            if ! printf "$fmt" | iconv -f UTF-8 -t UTF-8 >/dev/null 2>&1; then
                printf '%s\n' "$p"
                continue 2
            fi
        done < <(printf '%s\n' "$p" | grep -oE '(%[0-9A-Fa-f]{2})+')
    done
    return 0
)
# <<< guard_uri_decodable_paths <<<

bad_paths="$(find public -mindepth 1 | guard_uri_decodable_paths)"
if [ -n "$bad_paths" ]; then
    echo "ERROR: built paths whose URI decoding fails — the Cloudflare assets" >&2
    echo "API rejects such manifest keys (Workers Builds error 10304):" >&2
    printf '%s\n' "$bad_paths" >&2
    exit 1
fi
