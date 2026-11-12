## Problem

The archive email runbook (CherokeeLessons.com#45; its validation record shows the destination-revised text carrying a round-5 validation PASS as of this revision) documents the Cloudflare Email Routing setup; the setup itself has not been executed. The developer's directive of record (2026-11-12, chat): "email routing setup." The Worker source of record (2026-11-12, chat, carried verbatim in Approach) and the ia@ address of record make every execution input concrete. This spec carries the execution.

## Scope

Execute the documented procedure against the `cherokeedictionary.net` Cloudflare zone (per CherokeeLessons.com#45's validated content): domain onboarding, destination verification, Worker deployment from the tracked source, the routing rule, and the verification set — with the change's evidence (dig outputs, rule/destination/Worker states, receipts) captured as artifacts in the issue store. The Worker's source lives as tracked files in the CherokeeLessons repository (one new directory). Single-repo scope: CherokeeLessons (the zone is platform surface; its facts cite the devops DNS record, never copied).

## Requirements

- **R-1** — The zone is onboarded to Cloudflare Email Routing via **Onboard Domain** using the automatic DNS configuration (no manual DNS): Email Routing > Settings shows the three routing records (MX at the apex; SPF TXT; DKIM at `cf2024-1._domainkey`) with **Locked** status, and the off-box checks return the Cloudflare values: `dig MX cherokeedictionary.net` (route1/2/3.mx.cloudflare.net), `dig TXT cherokeedictionary.net | grep spf` (`v=spf1 include:_spf.mx.cloudflare.net ~all`), `dig TXT cf2024-1._domainkey.cherokeedictionary.net` (DKIM record) — all outputs captured as artifacts.
- **R-2** — The two destination addresses of record — `m.conrad.202+ia@gmail.com` and `standtrooper+ia@gmail.com` — are added under **Destination Addresses** (account level) and each verified by the confirmation click Cloudflare mails to it; both show **Verified** status. The verification clicks are destination-owner actions (the agent holds no Gmail access; where instructed explicitly, the developer-side destination is checkable via the email-ops subagent).
- **R-3** — The forwarding Worker of record is deployed to the Cloudflare account from its **tracked source home** in the CherokeeLessons repository: one new top-level directory `email-forwarder/` carrying (a) `worker.py` — the developer-provided Python source, verbatim as recorded in Approach — (b) the wrangler configuration carrying the `python_workers` compatibility flag, and (c) the pyproject for `pywrangler` (the Python Workers CLI, per the Python Workers docs: init creates the config; `pywrangler deploy` deploys). The tracked files are committed on the repository's feature branch per its flow; the deployed Worker is observable via the dashboard/API.
- **R-4** — The routing rule exists and is active: created under **Routing Rules** with Email pattern `ia` on `cherokeedictionary.net`, Action **Send to a Worker** → the forwarding Worker; exactly one rule for the pattern (duplicate patterns process first-listed only); no catch-all rule enabled.
- **R-5** — The verification set is executed and captured as artifacts: the Settings DNS-records Locked view; the three dig outputs; the routing-rule state (single `ia` rule, Active, destination the forwarding Worker; catch-all absent); and the end-to-end delivery observable — a test message from an external account (different from the destinations) to `ia@cherokeedictionary.net` that arrives at **both** destinations (spam-folder check if delayed), confirmed per destination and recorded in the issue store.

## Success criteria

| ID | Criterion | Class | Instrument |
|---|---|---|---|
| SC-1 | Email Routing is active on the zone; the three routing records are auto-added and Locked | behavioral | the Email Routing Settings DNS-records view (dashboard or API) showing MX/SPF/DKIM Locked, plus the captured dig outputs returning the Cloudflare values on all three checks |
| SC-2 | Both destination addresses are added and Verified | behavioral | the Destination Addresses view (dashboard or API) showing `m.conrad.202+ia@gmail.com` and `standtrooper+ia@gmail.com` with Verified status |
| SC-3 | The forwarding Worker is deployed from the tracked source of record | behavioral + structural | structural: the tracked `email-forwarder/` files exist in the CherokeeLessons repo carrying the verbatim source; behavioral: the deployed Worker is observable (dashboard/pywrangler/API) |
| SC-4 | The `ia@` routing rule exists, Active, pointing at the forwarding Worker; single rule; no catch-all | behavioral | the Routing Rules view (dashboard or API): exactly one `ia` rule, Active, destination the forwarding Worker; catch-all not enabled |
| SC-5 | End-to-end delivery from an external account reaches both destinations | behavioral | the captured dig outputs; both receipts confirmed and recorded in the issue store (developer-side destination observable via email-ops under explicit instruction; standtrooper's via its owner's confirmation) |

## Out of scope

- The IA account creation and the ebook delivery (items, uploads, book-page link re-pointing) — separate work under separate authorization.
- Email Sending (outbound, the `cf-bounce` surface); any catch-all rule; any manual DNS records; any other zone surface or DNS change.
- The runbook and policy wiki pages (CherokeeLessons.com#43, #44, #45 deliverables).
- The email-ops access to the developer's Gmail without explicit per-action instruction.

## Approach

Execute the procedure CherokeeLessons.com#45's validated content documents. The Worker source of record (verbatim, the developer's 2026-11-12 statement):

```python
import asyncio
from workers import WorkerEntrypoint

class Default(WorkerEntrypoint):
    async def email(self, message, env, ctx):
        await asyncio.gather(
            message.forward("m.conrad.202+ia@gmail.com"),
            message.forward("standtrooper+ia@gmail.com"),
        )
```

Worker home weighed: a tracked directory in the CherokeeLessons repository (primary — reproducible, reviewable, deploys via `pywrangler deploy`, consistent with the agent-managed posture of record for this account's ops) versus a dashboard-embedded Worker (rejected — not tracked, not reproducible, not agent-managed). Access path weighed: a developer-provisioned Cloudflare API token (scoped Workers + the zone's email-routing) driving the wrangler/API steps, versus the operator executing the dashboard steps per the runbook with the agent running the off-box checks — the success criteria are outcome-based under either; the dashboard's destination-verification clicks are destination-owner actions in both cases (or email-ops under explicit instruction for the developer-side destination). Platform facts per the fetched live docs (Python Workers — `python_workers` flag required, `pywrangler deploy`; Email Service — Onboard Domain, destinations, rules; last-updated dates Sep 17 / Jun 9 / Oct 15 / Oct 30, 2026).

## Impact

- Consumers: the IA archive account (its email identity); its two maintainers (the destination inboxes); the operator-runbook set (the runbook's procedure now executed and evidenced).
- Risk: live zone mutation — the automatic-DNS path is the managed default (records land Locked); the unmatched-address rejection ("Address does not exist") carries no mail-flow risk on a zone with no prior MX (pre-state: the 2026-11-02 export); the Worker is forward-only; direct-publish posture does not apply (no wiki page in this spec).
- Blast radius: one new repository directory (tracked); zone records added under the managed default; two destination addresses verified at account level.

## Provenance

Developer statements (2026-11-12, chat, this session):

- "email routing setup" — the execution directive.
- The Python Worker source (carried verbatim in Approach) — the Worker of record and the +ia-tagged destinations of record (`m.conrad.202+ia@gmail.com` / `standtrooper+ia@gmail.com`), superseding the untagged forms in the original directive phrasing (preserved verbatim in CherokeeLessons.com#45's provenance).

Sources verified 2026-11-12:

- CherokeeLessons.com#45 — the documented procedure this execution follows; its validation record (repos/CherokeeLessons.com/.issues/45/audit/validation.yaml) shows the destination-revised text carrying the round-5 validation PASS as of this revision (session ses_e2e95fdddffeEnCIA6n611OpJS); its platform-fact sources govern (Cloudflare Email Service pages, fetched live; zone pre-state: docs/infrastructure/dns-cherokeedictionary-net.md export 2026-11-02T18:58:37Z — no MX, no SPF/DKIM rows).
- Cloudflare Python Workers, fetched live: developers.cloudflare.com/workers/languages/python/ — `python_workers` compatibility flag required; `pywrangler` (workers-py) init/dev/deploy via uv; last-updated Sep 17, 2026.
- Cloudflare Workers API — the Python `WorkerEntrypoint` email-handler form and `forward()` verified (last-updated Oct 30, 2026).
- CherokeeLessons AGENTS.md — the developer-decision SoP; the R2 ruling of record (excluded paths).

> Full spec and plan artifacts: https://github.com/CherokeeLanguage/CherokeeLessons/tree/issues-data/46/

> Agent-facing artifacts pointer: `repos/CherokeeLessons.com/.issues/46/` (devops workspace-relative)

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
