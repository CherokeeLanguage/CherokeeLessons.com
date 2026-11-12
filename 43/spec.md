## Problem

The two oversized book PDFs' free-ebook download channel is dead on the live site across three successive configurations:

1. The prior serving VPS was lost — the site-relative `/pdf-downloads/…` links died with it (git evidence: the Volume I link was site-relative at commit `8b3e63f`, pre-stand-up).
2. CherokeeLessons#31 (commit `994bc0c`, PR #38 merged 2026-11-12) relocated the two tracked PDFs out of the Workers-served tree into `book-sources/pdf-downloads/` and re-pointed the two book pages at `https://files.cherokeelessons.org/pdf-downloads/…` — an agent-derived R2 bucket delivery recorded at #31 plan time, never discussed with the developer, and rejected as the ruling of record (CherokeeLessons AGENTS.md, 2026-11-12: "the R2 delivery plan for the oversized book PDFs (spec #31 R-8) was never discussed with the developer and is rejected — R2 is not a valid delivery path for this repo's work and must not be re-proposed"). The hostname carries no DNS record (verified 2026-11-12) and will not be created (developer, this session).
3. No replacement delivery path is documented (#42 R-2). Current state (2026-11-12): the files survive only as git-tracked sources of record — `book-sources/pdf-downloads/Cherokee-Language-Lessons-Volume-I-embedded-cover.pdf` (38,272,619 bytes) and `book-sources/pdf-downloads/Na_Kanoheda_Kwiti_Jisdu-embedded-cover.pdf` (73,509,989 bytes) — while the live pages `content/books/ꮳꮃꭹ-ꭶꮼꮒꭿꮝꮧ-ꮧꮥꮆꮖꮝꮧ-1.md` (link at line 23) and `content/books/ꮎ-ꭷꮓꭾꮣ-ꮘꮨ-ꮵꮝꮪ.md` (line 21) carry dead targets, and the README still carries the rejected R2 bucket step (line 37; removal pending in the open #42).

Developer decision of record (2026-11-12, chat): **archive.org hosting via an agent-managed `ia` CLI is the approach for the CherokeeLessons ebooks, and the needed operator runbook lives in the CherokeeLessons wiki.**

## Scope

Create the operator-usage runbook in the CherokeeLessons wiki documenting the archive.org ebook delivery path as decided of record. Deliverable surface: the CherokeeLessons wiki (one new page, `Ebook delivery runbook`); the spec and records live in this repository's issue store. Single-repo scope: CherokeeLessons only.

## Requirements

- **R-1** — The wiki page `Ebook delivery runbook` SHALL document the delivery operation set, agent-managed via the `ia` CLI, with these element sets, each checkable:
  1. **Prerequisites** — an archive.org account; IA S3 keys generated at the account's settings page; credential custody — keys installed in the CLI's local config (`~/.config/ia.ini`), never committed to the repo or echoed into transcripts.
  2. **Item stand-up** — per-book items carrying tracked item-definition metadata files beside the PDFs in `book-sources/pdf-downloads/`; upload via `ia upload <identifier> <pdf> --metadata=<file>`; collection **Community Texts**; identifier rules (5–80 chars, unique across archive.org, lowercase letters/numbers/dashes/underscores, no special characters — collisions append year-month and the identifier is permanent in the URL).
  3. **Recurring operations** — file replacement, metadata edit, and file add/delete through `ia` commands, each operation naming its commands; metadata edits go through the CLI (the uploading-tips constraint that non-ASCII typed into upload forms breaks the item's XML is cited), each operation closing with its verification line.
  4. **Account model and shared maintenance** — the account model of record: a single dedicated account for the ebook items (the IA-recognized organization pattern — Community Webs guidance "one account per org: simple setup/maintenance"); item-level administration is the uploading account's (no per-item member grants on free accounts); collection-level **multiple admins** exist for custom collections only (nominated by email to IA; admins gain edit rights over **all items** in that collection), and a custom collection is requestable at a **50-item minimum** — until that scale, items sit in Community Texts where no shareable admin rights exist; shared maintenance before that scale is key custody on the dedicated account; IA's Vault (paid repository product with account administration) is named as the separate paid product class outside this path.
- **R-2** — The runbook SHALL state the disposition of record and its boundaries: archive.org via agent-managed `ia` CLI is the cherokeelessons ebook delivery path; delivery URLs take the form `https://archive.org/download/<identifier>/<file>`; the artifacts ship unchanged from the tracked sources (`book-sources/pdf-downloads/` is the source of record); R2 and the `files.cherokeelessons.org` subdomain are permanently excluded per the ruling of record (AGENTS.md cross-reference).
- **R-3** — The runbook SHALL record the Cherokee-syllabary metadata handling: syllabary/Osage text in title/description goes through the CLI's UTF-8 metadata path; the first item's rendered metadata and download are inspected before the pattern is reused for further items; IA's derive timing is noted as IA-side (item-page surfaces refresh at IA's pace; the direct-download file serves once upload completes — verified by the verification set, not assumed).

## Success criteria

| ID | Criterion | Class | Instrument |
|---|---|---|---|
| SC-1 | The wiki carries the runbook page `Ebook delivery runbook` | structural | wiki checkout: `git -C <wiki-checkout> ls-files \| grep "Ebook delivery runbook"` finds the page file |
| SC-2 | R-1.1's prerequisite and custody elements are present | content | structured read: page grep finds the account element, the S3-keys element, and both custody rules (local config file; never committed/echoed) |
| SC-3 | R-1.2's stand-up elements are present | content | structured read: the stand-up section finds the tracked item-definition files, the `ia upload --metadata` command form, Community Texts, and the identifier rules incl. the permanence note |
| SC-4 | R-1.3's recurring-operation elements are present, each closing with a verification line | content | structured read: replacement, metadata edit, and add/delete each name their commands and a verification line; the metadata-via-CLI note with the form-hazard citation is present |
| SC-5 | R-1.4's account-model and shared-maintenance elements are present | content | structured read: the page finds the single-dedicated-account pattern, the item-admin fact, the collection multiple-admins mechanism with its 50-item threshold, and the key-custody-shared-maintenance statement |
| SC-6 | R-3's syllabary handling and first-item inspection are present | content | structured read: the CLI UTF-8 path, the first-item render/download inspection, and the derive-timing note (verified, not assumed) are found |
| SC-7 | R-2's disposition and boundary statements are present | content | structured read: the disposition section finds the delivery-URL form, the unchanged-artifact statement, and the AGENTS.md ruling cross-reference for R2/files.cherokeelessons.org |

## Out of scope

- Executing the delivery: creating the IA items, uploading the PDFs, editing the two book pages' links — separate work needing its own authorization and live-verified criteria; this spec's deliverable is the runbook document.
- Removing the README's R2 step — governed by the open remediation #42.
- Any other wiki surface — no other wiki page changes.

## Approach

Author the page in the CherokeeLessons wiki (GitHub wiki, `hasWikiEnabled` = true verified 2026-11-12; current pages: `Home.md` only). Wiki mechanics per the wiki-operations discipline: checkout, sync before edit, verify-before-push (a wiki push is direct-publish), publish after edit. The runbook's operational content restates the IA facts verified live 2026-11-12 against the IA help center (Uploading — A Basic Guide; Uploading — Tips; Books and Texts — A Basic Guide; How to delete or add files to an existing item; Rights) and the `ia` CLI's documented home (internetarchive.readthedocs.io). First execution of the documented procedure is the delivery work's own verification, separate from this document's criteria.

## Impact

- Consumers: human operators running the ebook operations (the runbook's readers); future spec/plan artifacts referencing the runbook; future runbooks listed under the sibling policy spec (CherokeeLessons.com#44).
- Risk: the wiki is direct-publish (no PR gate) — mitigated by verify-before-push. The page states a delivery path not yet executed — its criteria verify content, and first real execution is separately authorized work (named out of scope), so no delivered state is implied anywhere.
- Blast radius: one new wiki page; no repo-tree file changes.

## Provenance

Developer statements (2026-11-12, chat, this session):

- "this is the approach needed for cherokeelessons ebooks; file a spec with cherokeelessons to create the needed runbook in the wiki" — the IA + agent-managed-CLI disposition and the wiki runbook home.
- "the sub-domain does not exist and will not be created."
- "book access is already dead right now due to loss of prior VPS."
- "assume agent managed CLI is the goal."

Sources verified 2026-11-12:

- CherokeeLessons AGENTS.md — the R2 ruling of record; the agent-disposition SoP (surface decisions are the developer's, agent-derived dispositions are invalid work).
- CherokeeLessons#31 store spec (`.issues/31/spec.md`), plan (`.issues/31/plan.md`) — R-8 relocation; plan-time `files.cherokeelessons.org` recording; commit `994bc0c` / PR #38 merge.
- CherokeeLessons#42 store spec — open, `needs-approval`; R-2 ("no replacement delivery path is documented in its place").
- Live tree: `ls -la book-sources/pdf-downloads/` (both files + sizes); link greps on the two book pages; README line 37 (R2 step present).
- Git: `git log -S files.cherokeelessons.org -- content/books/` → `994bc0c` (single introducing commit); `8b3e63f` pre-stand-up site-relative form.
- IA help center, fetched live: help.archive.org/help/uploading-a-basic-guide/ (account, identifier rules, metadata form fields, ia CLI bulk note); /help/uploading-tips/ (1 TB hard / 1000-files-500 GB recommended item limits, add-files flow, derive timing "seconds, hours or sometimes days", non-ASCII-in-forms XML hazard); /help/books-and-texts-a-basic-guide/ (PDF easiest format, Community Texts, file-name rules <100 chars ASCII, language field, 50-item custom-collection minimum); /help/how-to-delete-or-add-files-to-an-existing-item/ (item-admin file add/rename/delete, derive ~15 min after edits, system files non-removable); /help/rights/ (uploader-declared license, copyright-policy removal, "free storage, and free bandwidth, forever, for free"); /help/collections-tips-troubleshooting/ (collections can have multiple admins — email nomination, admin edit rights over all items in the collection; public collections incl. Community Texts have no admin rights; collection moves via info@archive.org); Community Webs — Archive.org Collections Webinar, Mar 2024 (archive.org/details/building_digital_collections_on_archiveorg_2024 — "one account vs. multiple accounts for collection uploading", "one account per org benefits: simple setup/maintenance"); Vault (archive.org/details/vault-admin-page — IA's paid repository product with account administration); ia CLI home: internetarchive.readthedocs.io.
- DNS: `dig +short files.cherokeelessons.org A` and CNAME → empty (2026-11-12).
- GitHub: `gh repo view CherokeeLanguage/CherokeeLessons --json hasWikiEnabled` → true; `.wiki.git` HEAD exists; clone lists `Home.md` only (default welcome text).

> Full spec and plan artifacts: https://github.com/CherokeeLanguage/CherokeeLessons/tree/issues-data/43/

> Agent-facing artifacts pointer: `repos/CherokeeLessons.com/.issues/43/` (devops workspace-relative)

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
