# PLERA Public / Sovereign Boundary

PLERA is the public static edge for STOS continuity and discoverability.

It is intentionally **non-authoritative**.

## Public material allowed here

PLERA may contain:

- public landing pages;
- public continuity guidance;
- public recovery guidance that contains no private procedure or credential;
- sanitized milestone/status metadata;
- public documentation intended for broad distribution;
- static fallback pages;
- public references to sealed milestones without private seal contents.

## Material prohibited here

PLERA must not contain or expose:

- Admin passcodes or passcode verifiers;
- Root Secret values;
- control-plane secret values;
- browser session cookies or reusable session material;
- terminal tickets or terminal-control credentials;
- local environment files or secret-bearing configuration;
- private repository payloads;
- private STOS filesystem material;
- local Unix-socket control authority;
- private runtime-control endpoints;
- raw security evidence;
- unsanitized host diagnostics;
- private recovery capsules, receipts, or sealed recovery archives.

## Authority rule

A public copy is not the sovereign source of truth merely because it is continuously reachable.

PLERA provides continuity of **reference**, not continuity of **authority**.

Operational trust, authorization, execution, materialization, supervision, recovery credentials, and protected repository state remain outside the public edge.

## Failure behavior

If a requested public resource is missing, PLERA must fail safely to a static public page. It must never fall through or redirect to a private STOS service, local loopback endpoint, Unix socket, terminal service, or protected repository interface.

## Status rule

Any public status document is sanitized commissioning metadata only. It is not a live internal health API and must not disclose whether a private host, terminal, socket, repository, or protected service is presently online.

## Phase 1 boundary

Phase 1 establishes a minimal public surface only:

1. `index.html` — public doorway;
2. `continuity.html` — public continuity guidance;
3. `404.html` — safe static fallback;
4. `status.json` — sanitized commissioning metadata;
5. `README.md` — repository role and constraints;
6. `.nojekyll` — static publishing behavior.

Expansion beyond this boundary requires a separate review for public suitability.
