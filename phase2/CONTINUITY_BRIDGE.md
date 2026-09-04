# PLERA Phase 2 · Continuity Bridge Contract

Status: **DESIGN BASELINE · NO LIVE BRIDGE ENABLED**

PLERA remains a static, non-authoritative public edge. Phase 2 defines how continuity information may eventually cross from sovereign STOS/KCE systems into PLERA without giving PLERA any operational authority.

## Governing direction

```text
SOVEREIGN STOS / CONTINUITY PROVIDER
              │
              │ local/private evaluation
              ▼
      SANITIZATION / PROJECTION
              │
              │ one-way public snapshot
              ▼
            PLERA
      static public presentation
```

There is no reverse command path in this contract.

## Mandatory invariants

1. **One way only.** PLERA may receive a sanitized public snapshot. PLERA must never send control commands into STOS, KCE, KhaePod, terminal services, or a private repository.
2. **Projection before publication.** Private continuity state is transformed into a small public schema before it crosses the public boundary.
3. **No browser access to private endpoints.** Public JavaScript must not fetch loopback, LAN, VPN, private host, Unix-socket, Gateway Admin, operator, or control-plane endpoints.
4. **No authority material.** The public snapshot must never contain secrets, passcodes, session material, terminal tickets, bearer credentials, node credentials, signing private keys, recovery material, or private repository payloads.
5. **No internal topology disclosure.** Do not publish private hostnames, IP addresses, ports, node identifiers, membership rosters, lease epochs, raw heartbeat times, battery telemetry, process IDs, service lists, filesystem paths, or raw error traces.
6. **Fail closed to UNKNOWN.** If the sovereign producer cannot prove a fresh public projection, PLERA publishes `unknown` or `stale`; it never guesses that the system is healthy.
7. **Static by design.** Publication is a bounded snapshot, not a live control API, reverse tunnel, websocket, or streaming health feed.
8. **No GitHub control-plane dependency.** GitHub Pages may host the public snapshot, but GitHub must not become quorum authority, lease authority, runtime authority, or the only recovery path.
9. **Sovereign producer owns truth.** PLERA displays a public projection only. It never determines primary ownership, failover, quorum, lease validity, recovery, or runtime state.
10. **Independent certification required.** Any future publisher that creates these snapshots must be separately audited before being allowed to publish automatically.

## Public continuity fields

The Phase 2 public schema is intentionally small:

- `schema_version`
- `generated_at`
- `state`
- `continuity`
- `freshness`
- `public_message`
- `source_class`
- `authoritative`

Allowed values are defined in `public-continuity.schema.json`.

## Deliberately excluded fields

The public projection does **not** expose:

- current primary node identity;
- node membership;
- lease epoch or fencing token;
- exact lease expiry;
- heartbeat timestamps;
- device power/battery details;
- replication targets;
- private service-health details;
- private failover event logs;
- administrative or recovery actions.

Those belong inside the sovereign control surface, not PLERA.

## Current commissioning state

Phase 2 currently establishes the boundary and data contract only.

**NO LIVE KCE/STOS CONNECTION IS ENABLED.**

Before automatic publication is commissioned, the sovereign-side producer must pass a separate audit for authentication, bounded output, fail-closed behavior, replay/staleness handling, atomic publication, and secret/topology exclusion.
