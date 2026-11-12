# email-forwarder

The ia@cherokeedictionary.net forwarding Worker — CherokeeLessons#46's tracked
source of record. Forwards each inbound message for the Internet Archive
account's email identity to the two verified destinations (the `+ia`-tagged
forms):

- `m.conrad.202+ia@gmail.com`
- `standtrooper+ia@gmail.com`

The routing rule for this Worker lives on the `cherokeedictionary.net` zone
(Cloudflare Email Routing > Routing Rules): pattern `ia`, action
**Send to a Worker** → this Worker. The Dashboard rule carries a single
destination, so the two-recipient fan-out is this Worker's `asyncio.gather`
over two `forward()` calls.

## Operation

Setup and deploy per the docs (Python Workers require `uv` + `pywrangler`;
the `python_workers` compatibility flag is already set in `wrangler.jsonc`):

```sh
uv run pywrangler dev      # local iteration
uv run pywrangler deploy   # deploy
```

## Rules of record

- The tracked `worker.py` is the artifact of record — the deployed Worker
  comes from these files, never from dashboard pastes (CherokeeLessons.com#46).
- Metadata edits / item ops never go through the web forms for non-ASCII
  content (the XML-breaking hazard) — see the wiki runbook
  (`Ebook delivery runbook`, `Archive email runbook`).
- Wrangler config name (`ia-forwarder`) must match the deployed Worker's
  name for later `pywrangler deploy` reconciliation.

Full procedure and verification set: CherokeeLessons.com#46 and the wiki
runbooks.
