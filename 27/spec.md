# Spec — rename repository slug CherokeeLessons.com → CherokeeLessons (remote + local clone)

Remote issue: https://github.com/CherokeeLanguage/CherokeeLessons/issues/27

## Problem

The repository's git slug carries the site's public domain suffix: `CherokeeLanguage/CherokeeLessons.com`. The suffix belongs to the website's domain, not to the repository's identity; inside a git slug it misstates the repo. The developer directed the slug drop the `.com` — the repository becomes `CherokeeLessons` — on the remote host and in the local clone.

## Provenance

- **Developer statement (2026-11-10, chat):** "the repo cherokeelessons.com needs to be renamed both remotely and locally; it needs to have .com removed from the slug."
- **Developer directive (2026-11-10, chat):** "create a spec to track this change, and after verifying the change, mark the spec as resolved with appropriate comment" — prescribing the full arc: spec → rename → verify → resolve with comment. This directive is the authorization for the change and for closing this ticket on verified evidence.
- **Observed repo facts (verified 2026-11-10):** `origin` is `github-mconrad:CherokeeLanguage/CherokeeLessons.com.git`; the `.issues/` issue store is a worktree of this same repo on the orphan branch `issues-data` and shares the single origin config; the local clone directory is `/home/muksihs/git/CherokeeLessons.com`; both worktree gitdir pointers carry absolute paths embedding that directory name (`.issues/.git` → `.git/worktrees/-issues`, and the reverse pointer). No `.gitmodules`; no `.github/` CI. One tracked file references the repo path (see Out of scope). The deck checkout `.opencode/` has its own unrelated remote.

## Scope

This repository's identity surfaces only: (1) the GitHub-side repository name; (2) the local clone's `origin` URL (one shared git config serving the main checkout and the `.issues` worktree); (3) the local clone's directory name, including repair of the `.issues` worktree's gitdir links after the move. No tracked repository content changes and no other repository is touched.

## Requirements

- **R-1 — Remote rename.** The GitHub repository `CherokeeLanguage/CherokeeLessons.com` SHALL be renamed so its slug is `CherokeeLessons`, owner unchanged.
- **R-2 — Local remote URL.** The local clone's `origin` SHALL reference the renamed slug: `github-mconrad:CherokeeLanguage/CherokeeLessons.git`.
- **R-3 — Local directory rename with functional store.** The local clone's directory SHALL be renamed to carry no `.com` (`/home/muksihs/git/CherokeeLessons`), and the repository and its `.issues` worktree SHALL remain fully functional after the move — the worktree's gitdir links repaired in the same action.

## Success criteria

| ID | Criterion | Class | Instrument | Traces to |
|---|---|---|---|---|
| SC-1 | The GitHub repository's canonical name is `CherokeeLanguage/CherokeeLessons` | structural | `gh api repos/CherokeeLanguage/CherokeeLessons --jq .full_name` prints `CherokeeLanguage/CherokeeLessons` | R-1 |
| SC-2 | The local clone's `origin` fetch/push URLs reference `github-mconrad:CherokeeLanguage/CherokeeLessons.git`, and both a fetch and a push succeed against the renamed remote | structural | `git remote -v` output; `git fetch origin` exit 0; `local-issues sync` reporting a successful `issues-data` push through the new URL | R-2 |
| SC-3 | The clone lives at `/home/muksihs/git/CherokeeLessons` (the old path absent), git operations work from it, and the `.issues` worktree is intact on branch `issues-data` | structural | `ls /home/muksihs/git` shows `CherokeeLessons` and no `CherokeeLessons.com`; `git -C /home/muksihs/git/CherokeeLessons status` exit 0; `git -C /home/muksihs/git/CherokeeLessons/.issues status` on `issues-data`; `git worktree list` shows both worktrees | R-3 |

## Out of scope

- `templates/page.html:32` — giscus `data-repo="CherokeeLanguage/CherokeeLessons.com"` in tracked site content. Updating it is a repo-content change requiring its own pipeline pass (branch + PR). Until it lands, the comments widget on the live site is expected to error: giscus resolves the repo through its backend via the GitHub API, which does not follow rename redirects ([giscus#1238](https://github.com/giscus/giscus/issues/1238), verified live 2026-11-10). Surfaced to the developer as an urgent follow-up candidate.
- Historical qualified references in the issue store (`CherokeeLessons.com#N` in existing records and recorded URLs) — dated records, left as written; GitHub's redirect keeps them live.
- Other repositories referencing this repo by URL — outside this repository's path scope; the redirect covers their git access.
- The website domain `cherokeelessons.com` (DNS, CNAME, site URLs) — unrelated to the git slug; untouched.

## Approach

`gh repo rename` performs the remote rename; GitHub maintains redirects from the old slug for git and web access (documented platform behavior, empirically confirmed during implementation — plan item 2). `git remote set-url` updates the single shared origin config; the clone directory is moved with `mv`, and the `.issues` worktree's gitdir pointers (the worktree's `.git` file and the repository's `.git/worktrees/-issues/gitdir`) are repaired in the same action, with `git worktree repair` run to confirm; the agent session is rehomed to the new path. Alternatives weighed: updating only the remote URL while leaving the directory named `CherokeeLessons.com` — rejected, the developer explicitly directed the local rename; renaming without repairing worktree pointers — rejected, it breaks the issue store.

## Impact

Repo-identity surfaces only: no tracked content change in this arc, no app repos touched, no CI surface (no `.github/`). One live-site consequence is expected and disclosed: the comments widget's repo reference goes stale at rename time and the widget is expected to error until the deferred `templates/page.html` fix lands and the site redeploys (see Out of scope) — the redirect does not cover the widget's API path. Affected consumers enumerated: the giscus widget reference (out of scope, named above), external clone URLs and recorded links (covered by the redirect), and the issue store's worktree (handled by R-3). Risk concentrates in one place: the `.issues` worktree's absolute gitdir pointers break on the directory move and are repaired in the same action (R-3, SC-3). Rollback is trivial — rename back (`gh repo rename` and `mv`) — if any step fails mid-arc.

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
