## Problem

The operator-runbook set filed this session (CherokeeLessons.com#43, #44) covers the ebook delivery path and its wiki-home policy, but the account behind it needs an email identity: a Cloudflare Email Workers setup forwarding two destinations to an address on cherokeedictionary.net — address of record `ia@cherokeedictionary.net` (2026-11-12, developer, quoted below), superseding the `archive@` local-part of the directive's original phrasing, which is quoted verbatim as stated. Developer directive of record (2026-11-12, chat): "add a runbook to use cloudflare email workers to setup an account with cherokeedictionary.net as 'archive@cherokeedictionary.net' being forwarded to m.conrad.202@gmail.com + standtrooper@gmail.com; it is assumed the built-in auto-dns configuration for inbound email will be used and that manual DNS set up will not be used."

Assumptions of record: the built-in automatic DNS configuration for inbound Email Routing is used; manual DNS setup is not used.

## Scope

One new wiki page in the CherokeeLessons wiki (`Archive email runbook`) documenting the Cloudflare Email Routing setup procedure; the spec and records live in this repository's issue store. The Cloudflare zone (`cherokeedictionary.net`) facts are cited from the devops workspace's DNS record of record, never copied. Single-repo scope: CherokeeLessons only (the deliverable is the wiki page; executing the zone setup is not in scope).

## Requirements

- **R-1** — The wiki page `Archive email runbook` SHALL document the Cloudflare Email Routing setup for the cherokeedictionary.net zone using the built-in automatic DNS configuration, with these element sets, each checkable:
  1. **Prerequisites** — the zone serves from Cloudflare DNS (satisfied: the DNS record of record names `louis.ns.cloudflare.com` / `serena.ns.cloudflare.com` as the serving NS set); the dashboard path is **Compute > Email Service > Email Routing**; the zone's record set of record (Cloudflare export 2026-11-02T18:58:37Z) carries no MX and no SPF records, so onboarding is the clean path (no external-MX error, no SPF merge).
  2. **Domain onboarding** — **Onboard Domain** → select `cherokeedictionary.net` → review the DNS records Cloudflare adds automatically to the root domain (MX routing incoming email to Cloudflare; SPF TXT authorizing routing; DKIM TXT at `cf2024-1._domainkey`) → Done. The records arrive **Locked** (Email-Service-managed); nothing is entered into DNS manually. Propagation note per the docs: up to 24 h globally, usually 5–15 min on Cloudflare DNS.
  3. **Destinations** — `m.conrad.202+ia@gmail.com` and `standtrooper+ia@gmail.com` (the +ia-tagged Gmail forms of record — deliver to the same inboxes, filterable by tag) added under **Destination Addresses** (account-level, reusable across domains) and each verified by the **Verify email address** click Cloudflare mails to it; destinations are added and verified before the routing rule (a routing rule pointing at an unverified destination stays disabled).
  4. **Forwarding path** — a minimal email-handler Worker deployed to the account whose handler forwards each message to **both** verified destinations (one `forward()` per destination — the dashboard routing rule carries a single destination, so the two-recipient fan-out is the Worker route); the routing rule created under **Routing Rules** with Email pattern `ia` on `cherokeedictionary.net`, Action **Send to a Worker** → the forwarding Worker; only one rule for the pattern (duplicate patterns: only the first-listed rule processes).
  5. **Verification set** — Email Routing > Settings > DNS records shows the three auto-added records (MX, SPF, DKIM at `cf2024-1._domainkey`) with **Locked** status; `dig MX cherokeedictionary.net`, `dig TXT cherokeedictionary.net | grep spf`, and `dig TXT cf2024-1._domainkey.cherokeedictionary.net` resolve per the domain-configuration doc's own checks; a test message sent from an external account (different from the destinations) to `ia@cherokeedictionary.net` arrives at **both** destinations (spam-folder check if delayed); routing activity is observable in the dashboard.
- **R-3** — The delivered wiki state SHALL have the `Runbooks` index page (CherokeeLessons.com#44's deliverable surface) listing `[[Archive email runbook]]` — the index whose policy promisingly lists new operator-usage runbooks carries the line this spec's page earns. Implementation note: where #44's `Runbooks` page exists at this spec's implementation, the listing is added by this spec's change; where it does not yet exist, #44's R-2 (which lists operator-usage runbooks generally) delivers the index with the listing included, and SC-7's check runs against the composed state — both routes converge on the same delivered outcome.
- **R-2** — The runbook SHALL state the boundary statements: manual DNS setup is not used — the automatic configuration of record (records are unlockable only for provider migration, out of scope); no catch-all rule is part of this runbook (address-specific rule only); once the MX records point to Cloudflare, mail to unmatched addresses is rejected ("Address does not exist" behavior) — the zone carries no prior email addresses (no MX in the pre-state export), so no existing mail flow is at risk; Email Sending (outbound, the separate `cf-bounce` surface) is not touched by this runbook.

## Success criteria

| ID | Criterion | Class | Instrument |
|---|---|---|---|
| SC-1 | The wiki carries the runbook page `Archive email runbook` | structural | wiki checkout: `git -C <wiki-checkout> ls-files \| grep "Archive.email.runbook"` finds the page file (gollum canonicalizes spaces to hyphens in wiki filenames, so the pattern matches both forms) |
| SC-2 | R-1.1/.2's prerequisite and onboarding elements are present | content | structured read: every R-1.1/.2 element — the Cloudflare-DNS prerequisite; the clean-path pre-state (2026-11-02 export citation); the dashboard path (Compute > Email Service > Email Routing); the Onboard Domain flow; the three auto-added record classes; the Locked status; the no-manual-DNS statement; and the propagation note (up to 24 h generally, usually 5–15 min on Cloudflare DNS) |
| SC-3 | R-1.3's destination elements are present | content | structured read: every R-1.3 element — both destination addresses named; the Destination Addresses placement; account-level management (reusable across domains); the verification click; and the destinations-before-rule ordering with the stays-disabled fact |
| SC-4 | R-1.4's forwarding elements are present | content | structured read: every R-1.4 element — the minimal forwarding Worker (one forward per destination, both named); the fan-out justification (the dashboard rule carries a single destination, so the two-recipient route is the Worker); the routing rule created under Routing Rules (pattern `ia`, domain, Send to a Worker); and the single-rule-per-pattern note with the duplicate-pattern fact |
| SC-5 | R-1.5's verification set is present | content | structured read: every R-1.5 element — the Settings DNS-records Locked check; the three dig commands; the external-sender dual-destination test incl. the spam-folder note; and the routing-activity observability statement |
| SC-6 | R-2's boundary statements are present | content | structured read: no-manual-DNS with the unlock-is-provider-migration note, the no-catch-all statement, the unmatched-address rejection with the no-prior-email pre-state fact, and the Email Sending exclusion |
| SC-7 | The `Runbooks` index page lists the archive email runbook | content | checked after both this spec's and CherokeeLessons.com#44's deliverables have landed: structured read of the `Runbooks` page finds the `[[Archive email runbook]]` listing |

## Out of scope

- Executing the setup: the dashboard onboarding, destination verifications, Worker deployment, and rule creation — separate work under its own authorization; this spec's deliverable is the runbook document.
- Email Sending (outbound) configuration — a separate product surface.
- Any catch-all rule or any other zone DNS change; manual DNS setup (excluded by the directive of record).
- The ebook delivery execution (CherokeeLessons.com#43's out-of-scope item) and any other wiki page beyond this new one and the one index line it gains on `Runbooks` (R-3).

## Approach

Author the page in the CherokeeLessons wiki (wiki-operations discipline: checkout, sync before edit, verify-before-push, publish). The operational content restates the Cloudflare Email Service facts verified live 2026-11-12 (the Route emails, Email routing rules and addresses, and Domain configuration pages — the docs' own last-updated dates carry: Jun 9, 2026 / Oct 15, 2026 / Oct 30, 2026). The zone pre-state facts cite the devops workspace's DNS record (linked, not copied). The runbook joins the operator-runbook set indexed by CherokeeLessons.com#44's `Runbooks` page — the index line for this runbook is owned by R-3.

## Impact

- Consumers: operators performing the archive-email setup; the future IA archive account (the address is its identity surface); the operator-runbook set (indexed page).
- Risk: the runbook documents future zone mutation — executed only under separate authorization; the automatic-DNS path is the failure-resistant default (records land Locked and managed). The Worker is minimal (forward-only); its deployment details are plan-stage work.
- Blast radius: one new wiki page plus one index line on `Runbooks` (R-3); no repo-tree file changes; zone changes happen only when the documented procedure is executed under later authorization.

## Provenance

Developer statements (2026-11-12, chat, this session):

- "add a runbook to use cloudflare email workers to setup an account with cherokeedictionary.net as 'archive@cherokeedictionary.net' being forwarded to m.conrad.202@gmail.com + standtrooper@gmail.com; it is assumed the built-in auto-dns configuration for inbound email will be used and that manual DNS set up will not be used." — the address, both destinations, the Email Workers mechanism, and both assumptions.
- "ia@cherokeedictionary.net" (2026-11-12, chat) — the address of record; the local-part supersedes `archive@` from the directive's original phrasing above.
- the Python Worker source (2026-11-12, chat) — the forwarded destinations of record are the +ia-tagged forms `m.conrad.202+ia@gmail.com` / `standtrooper+ia@gmail.com`, superseding the untagged forms in the directive's original phrasing; the Worker's Python `WorkerEntrypoint` form with `asyncio.gather` over two `forward()` calls is recorded as the artifact of record (the execution spec, CherokeeLessons.com#46, carries it verbatim).

Sources verified 2026-11-12:

- Cloudflare Email Service docs, fetched live: developers.cloudflare.com/email-service/get-started/route-emails/ (Onboard Domain flow with the auto-added root-domain records MX/SPF/DKIM; destination-address add-verify flow; routing-rule creation; single-destination rule; Worker action and `forward()` example; test-from-an-external-account guidance incl. spam note); /email-service/configuration/email-routing-addresses/ (destinations account-level and reusable; unverified destination keeps the rule disabled; rule actions; duplicate-pattern first-listed behavior; catch-all forwards to a single destination); /email-service/configuration/domains/ (automatic DNS configuration; routing records land Locked on the root domain: MX, SPF `v=spf1 include:_spf.mx.cloudflare.net ~all`, DKIM `cf2024-1._domainkey`; SPF merge guidance only when a pre-existing SPF exists; unmatched-address rejection on enabled routing; clean-onboard vs error-2008 move-provider path; Email Sending as the separate `cf-bounce` surface; unlock path as provider migration).
- Zone pre-state: docs/infrastructure/dns-cherokeedictionary-net.md — the record set of record (Cloudflare export 2026-11-02T18:58:37Z): no MX, no SPF/DKIM rows; serving NS set `louis`/`serena.ns.cloudflare.com` (the Cloudflare-DNS prerequisite of the Email Service note).
- Sibling specs: CherokeeLessons.com#43 (ebook delivery runbook), #44 (operator-runbook wiki policy — the index home).

> Full spec and plan artifacts: https://github.com/CherokeeLanguage/CherokeeLessons/tree/issues-data/45/

> Agent-facing artifacts pointer: `repos/CherokeeLessons.com/.issues/45/` (devops workspace-relative)

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
