# Plan — CherokeeLessons.com#46 (email routing setup · tracked Worker source)

## Items

### Item 1 — R-3's tracked source of record (the repository deliverable)
- **Deliverable:** the `email-forwarder/` directory — `worker.py` (the developer-provided Python source, verbatim per the spec's Approach), `wrangler.jsonc` (`main: worker.py`, `compatibility_flags: ["python_workers"]`, name `ia-forwarder` per the scaffold ground truth, compatibility date of record), `pyproject.toml` (dev group `workers-py` + `workers-runtime-sdk` per the scaffold), `.python-version`, `.gitignore`, `README.md` (operation rules incl. the no-dashboard-paste and name-match rules).
- **RED:** no tracked source exists anywhere in the repo (pre-state: the directory is absent).
- **GREEN:** the files exist on the feature branch; `worker.py` is byte-identical to the Approach source; `wrangler.jsonc` carries the flag and main.
- **Instrument:** an executed identity comparison of `worker.py` against the Approach source, plus file greps for the config facts.

### Item 2 — the executed-state evidence capture (SC-1/SC-2 partial + attestations)
- **Deliverable:** the off-box dig capture archived at `.issues/46/research/email-routing-dig-2026-11-12.md`; the operator attestations (destinations verified; Worker deployed) recorded in the store.
- **Instrument:** the archived capture's content vs the doc-specified checks; the store comment record.

### Item 3 — push + PR
- **Deliverable:** branch `feature/46-email-forwarder` pushed; the PR (base `master`) carrying the tracked source; body per the PR contract.
- **Instrument:** the push's remote ref; the created PR's URL.

## Dependencies
None — single-repo change; the cloud-side steps are operator-executed (attested).

## Traceability
Item 1 ↔ R-3/SC-3 (structural half); Item 2 ↔ R-1/R-2 evidence states + SC-1/SC-2 partials; Item 3 ↔ SC-3 (the deployed observable is operator-attested) and the PR gate.

## Documentation sources
Spec `.issues/46/spec.md` (validated) and its cited sources (Cloudflare Python Workers + Email Service pages; scaffold ground truth produced via create-cloudflare with `--lang=python --type=hello-world-python`).

## Enforcement gate
Fresh-context verify PASS before PR creation (git-workflow-pr §2(c)).

## Cost frame
One directory, six files, one commit.

## Edge cases
- The deployed Worker's name is unknown to the agent: `wrangler.jsonc` carries `ia-forwarder`; the PR body flags the reviewer to confirm the name matches the deployment (one-line fix if not).
- Dashboard-visible states (Locked view, Verified view, rule state) are operator-side instruments, recorded as attested/captured.

## Not included
Cloud-side execution (operator per directive); the end-to-end receipts (pending operator test); any site-build change.
