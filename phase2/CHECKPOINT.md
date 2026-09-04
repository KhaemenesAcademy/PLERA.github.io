# PLERA Phase 2 · Checkpoint

Status: **GITHUB SIDE READY · LOCAL STOS PUSH AUTH PENDING**

## Installed in PLERA

- `phase2/public-continuity.schema.json` — strict 8-field public contract.
- `phase2/public-continuity.json` — fail-closed placeholder snapshot.
- `phase2/validate-public-continuity.mjs` — strict field/value and forbidden-content gate.
- `phase2/stos-publish.sh` — one-way local publisher; reads only STOS `/health`, projects to the public schema, validates, stages only the snapshot, then pushes.
- `phase2/index.html` — same-origin public viewer; treats snapshots older than 15 minutes as stale.
- `.github/workflows/plera-continuity-gate.yml` — GitHub validation on snapshot/schema changes.

## Authority boundary

PLERA remains non-authoritative. No Admin Passcode, Root Secret, control-plane secret, browser session, terminal ticket, private repository payload, private recovery artifact, private topology, or raw STOS health payload is published.

The publication direction is one way:

`STOS local health → local sanitization → strict snapshot → PLERA`

There is no PLERA-to-STOS command path.

## Verified

The first GitHub continuity-gate workflow completed successfully on commit `136011514c88e4ac8c0612c769f31d3e07cbb990`.

## Next step

Create and authorize a dedicated PLERA publication SSH key on the STOS host, then clone this public repository into a clean publisher working directory and run `phase2/stos-publish.sh` once. Do not reuse general GitHub account credentials or place secrets in PLERA.
