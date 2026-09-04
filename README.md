# PLERA

PLERA is the public static edge for the STOS ecosystem.

Its Phase 1 role is intentionally narrow:

- provide an always-findable public doorway;
- publish public-facing continuity and recovery guidance;
- publish carefully sanitized status information;
- publish documentation intended for public consumption;
- remain static and non-authoritative.

## Authority boundary

PLERA is **not** the STOS operational authority plane.

The repository must never contain or expose:

- Admin passcodes;
- Root Secrets;
- control-plane secrets;
- browser session cookies;
- terminal tickets;
- private repository payloads;
- private STOS filesystem material;
- local Unix-socket authority;
- runtime control credentials;
- raw private security evidence;
- unsanitized host diagnostics.

Operational authority remains sovereign and private behind STOS trust, authorization, execution, materialization, and supervision layers.

## Phase 1 status

- Milestone A · File Organization Consolidated · SEALED
- Milestone B · Admin Authority Consolidated · SEALED
- PLERA Phase 1 · PUBLIC EDGE COMMISSIONING

## Design constraints

- static-first;
- no external runtime dependency required for the landing page;
- no embedded secrets or private endpoints;
- no direct exposure of the local STOS Gateway;
- public content only;
- simple, accessible, responsive HTML/CSS.

## Public status data

`status.json` contains deliberately sanitized public commissioning state only. It is not a live internal health feed and must not be treated as an operational monitoring API.
