# Plan — CherokeeLessons#28 (pin zola to 0.22.1)

Derives entirely from `.issues/28/spec.md` (validation round 3: PASS). No submodules in this repo; surfaces are plain tracked files. Languages/tools: bash scripts, TOML config, Markdown. Test tiers: SC-2/SC-3 are behavioral, executed via real `./build.sh` runs (network fetch of the pinned release); the rest are structural greps/diffs run in-session (ephemeral observation, not authored tests).

## Item 1 — Schema migration (R-4) → SC-6, SC-9 (partial)

- **Deliverable:** `config.toml` — `generate_rss = true` → `generate_feeds = true`; remove the `[markdown] highlight_code = true` key. Delete the dead `insert_anchorLinks` line from exactly the 10 content files listed in `research/anchor-typo-files.txt`.
- **RED:** `grep -nE "generate_rss|highlight_code" config.toml` currently finds both keys; `grep -rl insert_anchorLinks content` currently lists 10 files — both instruments fail today.
- **GREEN:** apply the two config edits; delete the dead-key line in each of the 10 files (behavior-neutral — key never functioned; not renamed, per Out of scope).
- **Instrument:** SC-6 greps now find nothing; diff of config.toml and each content file shows only the declared edits.

## Item 2 — Pin + build mechanism (R-1, R-2) → SC-1, SC-2, SC-3, SC-5

- **Deliverable:** tracked `ZOLA_VERSION` containing exactly `0.22.1`; tracked `build.sh` that format-checks `ZOLA_VERSION` (`MAJOR.MINOR.PATCH`), reuses `./zola` when its `--version` contains the pin, else downloads `https://github.com/getzola/zola/releases/download/v0.22.1/zola-v0.22.1-x86_64-unknown-linux-gnu.tar.gz` and extracts `./zola` (executable), prints `./zola --version`, then runs `./zola build`. `.gitignore` gains `/zola`.
- **RED:** `ZOLA_VERSION`/`build.sh` absent (`git ls-files ZOLA_VERSION` empty) — SC-1 fails today; SC-5's `git check-ignore ./zola` finds nothing today.
- **GREEN:** add the files and the ignore rule.
- **Instrument:** SC-1 structural greps; SC-2 = executed fresh-clone `./build.sh` run in `/tmp` (network fetch, exit 0, `public/index.html` exists, log shows download + `zola 0.22.1`); SC-3 = second run, no download line, pinned version reported; SC-5 = `git check-ignore ./zola` matches, `git ls-files zola` empty.

## Item 3 — Publish through the pin (R-3) → SC-4, SC-8

- **Deliverable:** `publish.sh` build step replaced by `./build.sh`; nothing else in the file changes (hostname gate, `rm -rf public`, `.htaccess` copy, rsync untouched).
- **RED:** `grep -n "zola build" publish.sh` currently matches — SC-4's negative conjunct fails today.
- **GREEN:** single-line edit of the build invocation.
- **Instrument:** SC-4 both greps; SC-8 targeted greps for the four preserved lines + diff shows publish.sh differing only in the build-step line.

## Item 4 — Documentation (R-5) → SC-7

- **Deliverable:** `README.md` documents `ZOLA_VERSION`, `./build.sh`, `./publish.sh` (additive edit).
- **RED:** `grep -n "ZOLA_VERSION" README.md` finds nothing today.
- **GREEN:** add a short build/publish section.
- **Instrument:** the three SC-7 greps each find matches.

## Item 5 — Diff-minimality closeout (R-3, R-4) → SC-9

- **Deliverable:** whole-tree diff audit against the pre-change tree (a3662da).
- **Instrument:** `git diff a3662da --stat` shows exactly: `config.toml`, the 10 content files, `ZOLA_VERSION` (new), `build.sh` (new), `.gitignore`, `publish.sh`, `README.md` — no other tracked file modified; per-file diffs match Items 1–4's declared edits.

Dependency order: Item 1 first (migration is the precondition the pin presumes), then 2 (pin + behavioral proof), 3, 4, 5 (closeout). SC-2/SC-3 evidence is the executed-run logs; structural evidence is executed grep/diff output captured in the verification record.
