## Problem

Operator-usage runbook documentation for CherokeeLessons surfaces has no standing home. Recurring operational procedures risk landing ad hoc: the README currently carries the site's operational stand-up section — including the rejected R2 bucket step (line 37, removal pending in open #42) — while the CherokeeLessons wiki stands empty but for its default `Home.md` welcome. The developer directive of record (2026-11-12, chat): "in fact, create additional specs or add SCs as needed so that all runbooks for operator usage need to be in the wiki. for CherokeeLessons specific items."

## Scope

CherokeeLessons repository surfaces only: the CherokeeLessons wiki (one new policy/index page `Runbooks` + one link line in `Home.md`) and this spec's record in the issue store. No README or content-tree changes.

## Requirements

- **R-1** — The wiki page `Runbooks` SHALL carry the runbook policy and index stating:
  1. the policy: recurring operator-usage runbooks for CherokeeLessons items (site operations, ebook/IA item operations, future properties' operations) are created in and live in the CherokeeLessons wiki;
  2. the boundary: one-time setup/stand-up procedures are not recurring runbooks — the README is the home of record for the site stand-up procedure per the direction recorded in CherokeeLessons#42; revising that boundary is the developer's call;
  3. the new-runbook rule: new operator-usage runbooks are created in the wiki, and this index lists them.
- **R-2** — The page SHALL list the operator-usage runbooks, starting with the ebook delivery runbook (sibling spec CherokeeLessons.com#43's deliverable, `[[Ebook delivery runbook]]`).
- **R-3** — The wiki `Home.md` SHALL link to the policy/index page (the wiki's discoverability surface).
- **R-4** — The inventory of record SHALL be recorded in this spec (census below, dated 2026-11-12), each surface dispositioned against the policy.

Census (2026-11-12):

| Surface | Observation | Disposition |
|---|---|---|
| `README.md` | Deployment section (line 19) incl. the R2 stand-up step (line 37; remediation open in #42) | One-time setup class — README, per #42's direction of record |
| `AGENTS.md` | Agent-facing operational facts | Out of policy scope (agent surface, not operator) |
| `content/**`, `build.sh`, `ZOLA_VERSION` | Site content and one-time build conventions | Not operator runbooks |
| CherokeeLessons wiki | `Home.md` only (default welcome; no `_Sidebar`) | No existing runbook pages; the index is net-new |
| `Ebook delivery runbook` (wiki) | Introduced by sibling spec CherokeeLessons.com#43 | Wiki per policy; indexed per R-2 |

## Success criteria

| ID | Criterion | Class | Instrument |
|---|---|---|---|
| SC-1 | The wiki carries the policy/index page `Runbooks` | structural | wiki checkout: `git -C <wiki-checkout> ls-files \| grep "Runbooks.md"` finds the page file |
| SC-2 | R-1's three elements (policy, boundary, new-runbook rule) are stated on the page | content | structured read: the page states each element, the boundary citing CherokeeLessons#42 as home of record |
| SC-3 | The index lists the ebook delivery runbook | content | structured read: the page carries the `[[Ebook delivery runbook]]` link |
| SC-4 | The wiki `Home.md` links to the policy/index page | structural | `Home.md` grep finds the `[[Runbooks]]` link |
| SC-5 | The page's inventory matches this spec's census dispositions, and no recurring operator-usage runbook surface outside the wiki survives undispositioned | content | structured read of the page's inventory section against the census table above |

## Out of scope

- Migrating or editing README content (the stand-up procedure's home is decided in open #42; this spec's boundary cites that direction rather than re-deciding it).
- Creating the runbook itself (sibling spec CherokeeLessons.com#43's deliverable).
- The ebook delivery execution (out of scope in #43; unchanged here).
- Editing any wiki page beyond the new `Runbooks` page and the one `Home.md` link line.

## Approach

Wiki-operations flow (checkout, sync before edit, verify-before-push — a wiki push is direct-publish — publish after edit): create `Runbooks` per gollum conventions, add the one `[[Runbooks]]` line to `Home.md`, publish. The policy text extracts from the developer's directive of record; the boundary reconciles it with the standing #42 direction, both cited on the page so the reconciliation's sources are visible to the reader.

## Impact

- Consumers: operators (wiki readers); future runbook authors (the policy determines where their docs go); the ebook delivery runbook's discoverability.
- Risk: direct-publish wiki posture — mitigated by verify-before-push. The policy constrains future documentation placement for CherokeeLessons items; its boundary statement keeps the standing README stand-up home intact so no existing directive is silently overturned — the developer revises the boundary by editing the policy of record.
- Blast radius: one new wiki page + one link line in `Home.md`; no repo-tree file changes.

## Provenance

Developer statements (2026-11-12, chat, this session):

- "file a spec with cherokeelessons to create the needed runbook in the wiki. in fact, create additional specs or add SCs as needed so that all runbooks for operator usage need to be in the wiki. for CherokeeLessons specific items." — this spec's policy mandate.

Sources verified 2026-11-12:

- CherokeeLessons#42 store spec (open, `needs-approval`) — the README stand-up home direction ("the README-in-repo home … proposed and not taken") and R-2's no-replacement statement; README line 37 observed in tree.
- CherokeeLessons AGENTS.md — the agent-disposition SoP; the R2 ruling of record.
- Live census: `README.md` (45 lines; Deployment at line 19; R2 at 37); repo root markdown = `AGENTS.md`, `README.md` only; no `docs/` directory; wiki clone (2026-11-12) lists `Home.md` only.

> Full spec and plan artifacts: https://github.com/CherokeeLanguage/CherokeeLessons/tree/issues-data/44/

> Agent-facing artifacts pointer: `repos/CherokeeLessons.com/.issues/44/` (devops workspace-relative)

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
