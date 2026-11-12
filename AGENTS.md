# AGENTS.md — CherokeeLessons

Static site (Zola) for CherokeeLessons.com — content and media, no application
code. Agent-behavior governance lives in the `.opencode/` deck (floor.md);
this file holds repo operational facts only.

## Build & verification

- `./build.sh` is the only sanctioned build path: it fetches the zola release
  pinned in `ZOLA_VERSION` on first use (needs network once; cached as
  `./zola`, gitignored) and builds into `public/` (gitignored). Do not use a
  system zola — the pin was chosen for vendored-Zulma compatibility (README).
- There is no test suite and no CI. A clean `./build.sh` (exit 0) is the
  verification gate for content and config changes.
- Deployment is Cloudflare Workers Static Assets: a merge to `master` triggers
  a Workers Builds build and `npx wrangler deploy` automatically; PR branches
  get preview builds. The one-time dashboard setup (GitHub App connection,
  Worker name, build command, production branch, custom domains, R2 bucket)
  is documented in README's Deployment section.

## Content facts

- `templates/shortcodes/` ships `{{ video(video=…) }}`, `{{ audio(file=…) }}`,
  and `{{ youtube(id=…) }}`. Legacy `video` embeds reference colocated mp4s
  that are untracked, so those embeds are dead in any fresh build; `audio`
  embeds are mixed — pages whose referenced mp3s are tracked stay live (122
  tracked mp3s across four page dirs), while several lesson-audio and TTS
  pages embed untracked mp3s and are dead in fresh builds. Lesson media is
  mirrored on the developer's YouTube channel (see the issue store) — prefer
  `{{ youtube(id=…) }}` for new embeds; a local-media embed ships only if its
  media is tracked (see the ignore rules below).
- Content filenames use Cherokee syllabary and Osage script (e.g.
  `content/books/ꮳꮃꭹ-…-1.md`). Use `git -c core.quotepath=off` for readable
  git output and quote paths in shell commands.
- `.gitignore` globally ignores `*.mp3`, `*.mp4`, and `/static/HTML-Games/`.
  Media is nevertheless tracked where it matters (122 tracked mp3s — tracked
  files override ignore rules), and
  `content/content/tacotron2-and-cherokee-tts/.gitignore` re-includes new
  mp3s with `!*.mp3`. A plain `git add` of ignored media is a silent no-op —
  confirm with `git status` / `git check-ignore` after adding media.
- Scaffold new content pages with `content/new_page.py --title "…"
  --folder <section-dir>`. It is a bash/python polyglot that activates the
  `cherokee-lessons` conda env; `environment.yml` is that env's export
  (refreshed by `export-env.sh`).

## Workspace artifacts — never commit

- `.opencode/` is a gitignored, read-only deck checkout.
- `.issues/` is a linked git worktree on the orphan `issues-data` branch (the
  local issue store) and `.tools/` holds vendored agent tooling — both are
  untracked machinery. Never `git add -A` / commit them, and `issues-data` is
  never a branch-management or cleanup candidate.
