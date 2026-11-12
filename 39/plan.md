# Plan — URI-decodable asset paths for the Workers deploy (#39)

Source spec: `.issues/39/spec.md` (validated: round-7 PASS). Single repo — this one. Work runs on `feature/39-uri-decodable-assets` off the verified trunk tip (`3a9e81b`); no test files are authored — every instrument below is a direct command; the repo has no test suite and no heavy tiers arise. The guard mechanism is the spec Approach step 3 as written (its equivalence to `decodeURIComponent` was simulation-verified across independent batteries this session, including a 67,477-case reviewer battery — zero divergence).

## Items

### Item 1 — SC-2: the rename and its reference
- **Deliverable:** `git mv "content/virtual-classrooms/Cherokee-Language-101/ebook-cover-25%.png" "content/virtual-classrooms/Cherokee-Language-101/ebook-cover-25-pct.png"`; `content/virtual-classrooms/Cherokee-Language-101/index.md` line 14's `featured_image` value updated to the new name.
- **RED:** `git ls-files | grep '%'` lists exactly that source (1 hit); the front-matter line names `ebook-cover-25%.png`.
- **GREEN:** the move and the edit.
- **Instrument (in place):** the guard's predicate over `git ls-files` is empty; blob-hash identity holds (`git cat-file -p 3a9e81b:"content/virtual-classrooms/Cherokee-Language-101/ebook-cover-25%.png" | sha256sum` equals `sha256sum` of the renamed file — content preserved across the rename); the front-matter grep finds exactly 1 new-name hit and 0 old-name hits.
- **Test tier:** none authored — the instrument is the SC's direct commands.

### Item 2 — SC-1: the build-time guard
- **Deliverable:** the guard block in `build.sh`, after the `"$ZOLA" build` line, exactly per spec Approach step 3: `LC_ALL=C` exported with the collation rationale in a comment; over every built path (`find public -mindepth 1`): (a) the malformed-escape check (sed-strip; a surviving `%` fails the path); (b) per maximal consecutive escape run (`grep -oE '(%[0-9A-Fa-f]{2})+'`): the range rejection (upper-cased hex; `F5`/`F6`/`F7` bytes, or `F4` followed by a byte ≥ `0x90`) and the UTF-8 validation (`printf '\xNN'` bytes through `iconv -f UTF-8 -t UTF-8`); any failing path is collected, and non-empty collection prints the paths to stderr and exits 1.
- **RED:** the RED of record is the executed deploy failure (the Workers Builds log's 10304 on the 3 malformed paths) plus the demonstrated local detection (the decode sweep's 3 throwers; `git ls-files` predicate = 1 tracked source). The falsifying integration run: a base-tree clone (`3a9e81b`) with only `build.sh` replaced by the fixed version, `WORKERS_CI_BRANCH=master ./build.sh` → the guard fires, exit non-zero, exactly the 3 paths named.
- **GREEN:** the guard block, wired after the zola build over `public/`.
- **Instrument:** SC-1's three legs — (integration-RED) the run described above (expect non-zero exit naming exactly the 3 paths); (integration-GREEN) a fresh clone of the fix branch, `WORKERS_CI_BRANCH=master ./build.sh` → exit 0, no guard output; (branch coverage) the seeded-case battery — the guard's verdicts equal a `decodeURIComponent` oracle's across the spec's case list (`%25`; `%.`; `%FF`; `%C3`; `%C3x%A9`; `F5 80 80 80`; `F4 90 80 80`; `F4 8F BF BF`; `%2é` under a non-C locale) with the verdict table recorded as evidence in the work record and PR body. The integration-GREEN build also discharges SC-2's build-side greps (`find public -name '*ebook-cover-25%'` = 0; new-name grep in `public/` ≥ 1).
- **Test tier:** none authored — the battery's verdict table is recorded execution evidence, not a committed test file; scratch observation stays out of test files.

### Item 3 — SC-3: the deploy behavior
- **Deliverable:** the PR carrying items 1–2; the Workers Builds preview build completing its asset upload.
- **RED:** the RED of record is the master build's 10304 failure (the observed log). The falsifying run: `gh pr checks <pr>` on the new PR — the preview build runs the same manifest upload path.
- **GREEN:** open the PR after items 1–2 are green; the preview check runs.
- **Instrument:** `gh pr checks <pr>` green on the PR head; post-merge, the `master` build green (developer-visible; also observable as the serving arc's precondition).
- **Test tier:** none authored.

## Ordering

1 → 2 → 3. Item 1's rename is the precondition for item 2's integration-GREEN leg (the fixed tree must be %-free or the guard fires there too); item 3 consumes the verified tree. No cycles: each item's RED runs against the state its predecessors produced.

## Post-merge

The `master` build deploys (SC-3's second half); then the serving-verification sequence recorded in `.issues/31/plan.md` completes the stand-up arc — unchanged by this fix.

🤖 Co-authored with AI: OpenCode (huggingface/zai-org/GLM-5.3-Flash)
