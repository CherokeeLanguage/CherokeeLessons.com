# Spec — standing app-announcement workflow: itch.io promotion format for Mastodon announcements (all apps going forward)

Remote issue: https://github.com/CherokeeLanguage/CherokeeLessons.com/issues/26

## Problem

The itch migration made itch.io the app download channel, but the workflow carries no announcement step: nothing records how app announcements are posted on Mastodon. itch.io's own guidance defines the format that lets the @itchio account find and boost promotion posts about itch projects — a toot about an itch.io project should include a direct itch.io link, some image/video, and a mention of @itchio ([itchio@mastodon.gamedev.place, 2022-11-07](https://mastodon.gamedev.place/@itchio/109304068236703627), text fetched and verified 2026-11-10: "Please make toots for your itch.io projects: include a direct itch.io link, some image/video, and mention @itchio so we can find your posts to boost!").

## Provenance

- **Developer statement (2026-11-10, chat):** "add this in as a spec to add this into the workflow for all apps going forwards" — with the itchio toot link above as the format source. Follow-ups: "not applicable right now" (2026-11-10) declining to bind the poster account, trigger, and retroactivity; "file a draft spec" (2026-11-10) authorizing this filing.
- **Observed repo facts (verified 2026-11-10):** no Mastodon/announcement step exists anywhere in the workflow — no announcement CI step in the app repos, no social links in `config.toml`, no announcement content in the issue store. The itch migration's phase-1 umbrella (#21) and per-app specs (#20, #22–#25) govern page creation and deployment only; phase-2 site-page specs are unfiled.

## Scope

This repository (CherokeeLessons.com): one new documentation file, `docs/app-announcement-workflow.md`, defining the standing announcement step for **all apps going forward**. The file is repo content — versioned, PR-governed, readable by any future session implementing an announcement. The announcement content format is the deliverable; the toot-posting mechanics are out of scope until the developer binds them.

## Requirements

- **R-1 — Standing workflow doc.** The repo gains `docs/app-announcement-workflow.md`, defining the announcement step for app announcements and stating that it applies to all apps going forward.
- **R-2 — The three mandatory elements.** The doc mandates that every app announcement post (a Mastodon post promoting an app's itch.io presence) includes all three elements:
  1. a direct itch.io page link — `https://cherokee-language.itch.io/<slug>`;
  2. at least one image or video;
  3. a mention of @itchio — canonical handle `https://mastodon.gamedev.place/@itchio` (full form `@itchio@mastodon.gamedev.place` when the post originates from another instance).
- **R-3 — No invention.** The doc states only what the linked itchio toot (2022-11-07) and the developer's 2026-11-10 direction carry: no claims about boost guarantees or likelihood, no account identities beyond the canonical handle, no invented cadence, trigger, or posting ownership.

## Success criteria

| ID | Criterion | Class | Instrument | Traces to |
|---|---|---|---|---|
| SC-1 | `docs/app-announcement-workflow.md` exists, states its applicability to all apps going forward, and names all three mandatory elements | structural | Read the file; check the three elements and the applicability statement are present | R-1, R-2 |
| SC-2 | The doc binds the canonical @itchio handle URL and the itch.io page URL pattern, matching this spec's R-2 values exactly | content | Read the file against R-2's bound values | R-2 |
| SC-3 | The doc carries no factual claim beyond the linked itchio toot and the developer's direction | structural | Side-by-side read against the toot text recorded in this spec's Problem section | R-3 |

## Out of scope

- Which account posts the toots, and on which Mastodon instance — developer decision, declined 2026-11-10 ("not applicable right now"); the doc records the format only.
- Announcement trigger and cadence (initial launch, per-release push, or both) — not yet bound.
- Retroactive announcements for already-live apps (Bound Pronouns, Animals — the two pages with verified live state in the store; see Provenance and the correction recorded in the issue-store history of #22).
- Phase-2 site-page work (unfiled specs) and the app repos' pipelines — untouched.
- The itchio account's actual boost behavior — the doc cites the toot's guidance, it does not assert outcomes.

## Approach

A single repo-tree document is the only repo-owned, PR-governed surface for a standing workflow step: the issue store mirrors work artifacts rather than carrying workflow conventions, and the agent deck under `.opencode/` is a read-only checkout. Alternatives weighed (2026-11-10): amending umbrella #21's shared-conventions seam — rejected, that umbrella is phase-1-specific and closes when its parts close; a store-level convention record — rejected, issue-store data is not repo content that future implementation work executes against.

## Impact

One new documentation file; no code, site content, or build surface changes; no app repos touched. Risk is minimal: the doc binds future announcement work and constrains nothing already deployed. Approval gate: this spec waits for the developer's approval before plan; the open scope points (poster account, trigger, retroactivity) are the developer's to bind or leave for a follow-up spec.

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
