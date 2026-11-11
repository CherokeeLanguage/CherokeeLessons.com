# Plan — rename repository slug CherokeeLessons.com → CherokeeLessons

Implements CherokeeLessons.com#27. Source: `spec.md` in this issue folder. Authorization: developer directive 2026-11-10 (spec → rename → verify → resolve with comment). All items are administration/platform operations with no code path to test — every item is GREEN-only, verified by its stated instrument; no RED state exists to manufacture.

## Preconditions (verified 2026-11-10)

1. Admin permission on the repo: `gh api ... --jq '.permissions'` → `admin: true`. ✓
2. Target slug free: `gh api repos/CherokeeLanguage/CherokeeLessons` → 404. ✓
3. Reverse worktree pointer read: `.git/worktrees/-issues/gitdir` = `/home/muksihs/git/CherokeeLessons.com/.issues/.git` — confirmed as the second pointer needing repair. ✓

## Items

| # | Item | Type | Verify (GREEN) |
|---|---|---|---|
| 1 | Remote rename: `gh repo rename CherokeeLessons -R CherokeeLanguage/CherokeeLessons.com --yes` | GREEN-only (platform op) | SC-1 instrument |
| 2 | Redirect check: `gh api -i repos/CherokeeLanguage/CherokeeLessons.com` reports 301 to the new location | GREEN-only | backs the redirect claims in spec Approach/Out-of-scope |
| 3 | Local origin update: `git remote set-url origin github-mconrad:CherokeeLanguage/CherokeeLessons.git` | GREEN-only | `git remote -v` (SC-2) |
| 4 | Directory move: `mv /home/muksihs/git/CherokeeLessons.com /home/muksihs/git/CherokeeLessons`; repair both worktree pointers (`.issues/.git` and `.git/worktrees/-issues/gitdir`) by path substitution; `git worktree repair` to confirm | GREEN-only | SC-3 instruments |
| 5 | Session rehome: agent session moved to `/home/muksihs/git/CherokeeLessons` | GREEN-only | session CWD resolves; `git fetch origin` exit 0 (SC-2) |
| 6 | Closure: evidence comment (local, `local-issues comment`) + `local-issues close --reason completed`; remote reconcile: `gh issue close` carrying the same evidence | GREEN-only | SC evidence recorded; tracker state reconciled |

## Dependencies

Preconditions → 1 → {2, 3} → 4 → 5 → 6. The remote rename precedes all local changes so every recorded URL after item 1 names the renamed repo.

## Traceability

Item 1 → R-1/SC-1 · item 3 → R-2/SC-2 · items 4–5 → R-3/SC-3 · item 2 → approach-claim verification · item 6 → closure directive.

## Edge cases

- Rename fails (permission or slug taken): report with evidence and halt; no local change is made before item 1 succeeds.
- Worktree repair fails: the two pointers are plain text files; the manual fix is the path substitution stated in item 4, then re-run `git worktree repair`.
- Verification failure after the move: rollback is `mv` back + `gh repo rename` back, then diagnose.

## Not included

Everything in the spec's Out of scope (page.html giscus pointer, historical store references, external repos, website domain).
