# Plan — CherokeeLessons#42

Spec: `.issues/42/spec.md` (validated, round-2 PASS).
Authorization: "both" (2026-11-12) — through implementation; the PR boundary
keeps its own token.

## Derivation guard

| Item | SC |
|---|---|
| P-1 (R-1.1) | SC-1 |
| P-2 (R-1.2–5) | SC-2, SC-3 |
| P-3 (R-2) | SC-4 |
| P-4 (R-3) | SC-5 |

Items:
- **P-1** — the prerequisites section (SC-1).
- **P-2** — the ordered verified procedure (SC-2, SC-3).
- **P-3** — the R2 removal (SC-4).
- **P-4** — the pointer-validity inspection (SC-5, read-only gate).

Every SC covered; no item lacks a trace. This is a single-file documentation
rewrite: the items are content sections of one deliverable, sequenced
author-then-check rather than independently committable units; verification
runs per item's instrument against the same file state.

## Items

### P-1 — prerequisites (SC-1)

- **Deliverable:** a "Prerequisites" section in the README before the
  procedure: the Cloudflare account presumptions (an account with the
  `cherokeelessons.org` zone; a user/team with Workers and DNS edit rights
  on it), the GitHub App authorization (the Workers Builds GitHub App
  connection and the repository access it needs), and who performs what.
  Facts the agent cannot verify from outside are instructions to verify at
  the dashboard, not invented values.
- **RED:** the README carries no Prerequisites section (grep → 0).
- **GREEN:** author the section from the spec's R-1.1 element list; the
  dashboard-side specifics render as "verify at the dashboard" checks.
- **Instrument:** structured read of the section against R-1.1's elements
  (account/zone, GitHub App + scope, access/who).

### P-2 — the ordered procedure (SC-2, SC-3)

- **Deliverable:** the Deployment section's numbered steps restated as an
  ordered procedure where each step names what it depends on, what it does,
  and its verification observable (build logs location; `npx wrangler
  deployments`; the URL serving), plus a failure-modes subsection (worker
  name mismatch `cherokeelessons-org`; unset build command `./build.sh`;
  wrong production branch — the builds default `main` vs this repo's
  `master`), a local-verification subsection (./build.sh's branch/base-url
  behavior; preview inspection), and dated DNS expectations (apex serves;
  www.cherokeelessons.org NXDOMAIN as of 2026-11-12 — may change).
- **RED:** the current steps carry no verification observables (read).
- **GREEN:** rewrite per R-1.2–5, keeping every existing-README fact (the
  GitHub App connection, worker name, build command, production branch,
  custom domains) and adding the procedure around them; no invented
  account-side values.
- **Instrument:** structured read — every step carries dependencies +
  verification; the three failure modes, local verification, and dated DNS
  expectations present (SC-2/SC-3).

### P-3 — R2 removal (SC-4)

- **Deliverable:** the R2 step deleted; no `R2` or `files.cherokeelessons.org`
  token remains anywhere in the README; no replacement delivery path is
  documented (developer directive — closed topic).
- **RED:** grep README for `R2|files.cherokeelessons.org` → ≥1 (step 6).
- **GREEN:** delete the step (and any residual token).
- **Instrument:** the grep → 0.

### P-4 — pointer validity (SC-5, read-only)

- **Deliverable:** confirmation that the devops workspace's
  `docs/worker-served-properties/worker-served-properties.md` pointer to
  this README remains accurate post-rewrite (its description — "deploy path
  and full ops sequence, authoritative at ops depth" — matches the new
  content; the rewrite strengthens it; no edit needed there).
- **RED/Gate:** read the pointer's description against the rewritten
  README.
- **Instrument:** the devops repo's record inspection (grep its line, read
  both sides).

## Validation

Writer's duty-of-care pass, then one fresh-context validation dispatch per
the plan card; record at `.issues/42/audit/validation.yaml` (plan rounds).
