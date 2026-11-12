
## Problem

The README's stand-up documentation (the ops-depth record #31 delivered) is mostly useless for standing the site up: it carries a six-line dashboard checklist with no prerequisites, no ordering rationale, no per-step verification, no troubleshooting, and a stub R2 step. The developer's assessment (2026-11-12): "the stand up docs for the cherokeelessons.org is mostly useless. it doesn't properly describe the setup procedure and the requirements thereof." Directives: no R2 (the R2 step is removed, end of discussion); the procedure's home is the README itself.

## Requirements

- R-1: the README's Deployment section becomes a stand-up procedure carrying, at minimum:
  1. a prerequisites section — the Cloudflare account and zone state the setup presumes, the GitHub App authorization and its scope, and the access required;
  2. the ordered steps with their dependencies stated, each step carrying its verification (the observable that confirms it succeeded — build logs location, `wrangler deployments`, the site serving);
  3. the builds-failure modes (worker-name mismatch `cherokeelessons-org`, unset build command `./build.sh`, wrong production branch) with their symptoms;
  4. local verification (./build.sh and its branch/base-url behavior; preview inspection);
  5. the DNS state to expect after setup, dated (apex serves; www.cherokeelessons.org NXDOMAIN as of 2026-11-12 — the attachment state may change).
- R-2: the R2 step is removed — no R2 content remains in the README; no replacement delivery path is documented in its place (developer directive: "no fucking R2. end of discussion"; the oversized-PDF delivery handling is out of scope).
- R-3: the README remains the ops-depth record the devops workspace's Worker-served properties record points at — no change needed there (verified by inspection at implementation time).

## Success criteria

| ID | Criterion | Class | Instrument |
|---|---|---|---|
| SC-1 | The prerequisites section carries the account/zone, GitHub App, and access elements | content | structured read against R-1.1's element list |
| SC-2 | The ordered steps each state dependencies and a verification observable | content | structured read: every step carries "verify" content; order rationale present |
| SC-3 | The failure modes, local verification, and DNS expectations are documented | content | structured read against R-1.3–5 |
| SC-4 | No R2 content remains | content | grep the README for `R2` and `files.cherokeelessons.org` → 0 |
| SC-5 | The devops properties record's README pointer remains valid | structural | inspection: the pointer's description still matches the README's content |

## Provenance

Developer statements (2026-11-12, chat): the complaint quoted above; "no fucking R2. end of discussion"; the README-in-repo home (the devops-runbook alternative was proposed and not taken). Account-side specifics the agent cannot verify from outside (zone state, App grants, dashboard build configuration) are written as per-step "verify at the dashboard" checks, never invented facts.

> Full spec and plan artifacts: https://github.com/CherokeeLanguage/CherokeeLessons/tree/issues-data/70/
>
> Agent-facing artifacts pointer: `repos/CherokeeLessons.com/.issues/70/` (devops workspace-relative)

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
