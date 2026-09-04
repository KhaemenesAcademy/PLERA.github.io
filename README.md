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

See `PUBLIC_BOUNDARY.md` for the formal public/sovereign boundary.

## Phase 1 status

- Milestone A · File Organization Consolidated · SEALED
- Milestone B · Admin Authority Consolidated · SEALED
- PLERA Phase 1 repository content · CERTIFIED
- GitHub Pages publication · DEPLOYMENT VERIFIED
- PLERA Phase 1 public edge · COMMISSIONED

Public URL: `https://khaemenesacademy.github.io/PLERA.github.io/`

## Phase 1 public surfaces

- `index.html` — public doorway
- `continuity.html` — public continuity guidance
- `404.html` — safe static fallback
- `status.json` — sanitized commissioning metadata
- `PUBLIC_BOUNDARY.md` — formal public/sovereign boundary
- `PHASE1_CERTIFICATION.json` — Phase 1 certification manifest
- `.nojekyll` — static publishing marker

## Design constraints

- static-first;
- no external runtime dependency required for the landing page;
- no embedded secrets or private endpoints;
- no direct exposure of the local STOS Gateway;
- public content only;
- simple, accessible, responsive HTML/CSS.

## Public status data

`status.json` contains deliberately sanitized public commissioning state only. It is not a live internal health feed and must not be treated as an operational monitoring API.

## Publication certification

GitHub Pages successfully built and deployed the Phase 1 public artifact from `main`. The deployed artifact was independently inspected for file inventory and public-boundary integrity before Phase 1 was marked commissioned. This certification does not make GitHub or PLERA the sovereign operational source of truth; PLERA remains a static public edge only.
