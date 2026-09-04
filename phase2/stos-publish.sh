#!/bin/sh
# PLERA Phase 2 · one-way STOS public continuity publisher
# Publishes only phase2/public-continuity.json. No secret or authority material is read.

set -u

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SNAPSHOT="$ROOT/phase2/public-continuity.json"
VALIDATOR="$ROOT/phase2/validate-public-continuity.mjs"
HEALTH_URL="http://127.0.0.1:9844/health"

fail() {
  printf '%s\n' "$1" >&2
  return 1
}

main() {
  cd "$ROOT" || return 1

  DIRTY=$(git status --porcelain --untracked-files=no | grep -v '^.. phase2/public-continuity.json$' || true)
  if [ -n "$DIRTY" ]; then
    echo "HOLD: unrelated tracked changes are present"
    printf '%s\n' "$DIRTY"
    return 1
  fi

  git pull --ff-only origin main || return 1

  HEALTH=$(curl -fsS --max-time 3 "$HEALTH_URL" 2>/dev/null || true)
  NOW=$(date -u '+%Y-%m-%dT%H:%M:%SZ')

  if printf '%s' "$HEALTH" | node -e '
let s="";process.stdin.on("data",d=>s+=d);process.stdin.on("end",()=>{try{const j=JSON.parse(s);process.exit(j && j.ok===true ? 0 : 1)}catch{process.exit(1)}});
'; then
    STATE="available"
    CONTINUITY="nominal"
    MESSAGE="Sovereign STOS continuity service is reachable."
  else
    STATE="unknown"
    CONTINUITY="unknown"
    MESSAGE="Sovereign STOS continuity state is currently unavailable."
  fi

  node --input-type=module - "$SNAPSHOT" "$NOW" "$STATE" "$CONTINUITY" "$MESSAGE" <<'NODE'
import fs from 'node:fs';
const [, , file, generated_at, state, continuity, public_message] = process.argv;
const snapshot = {
  schema_version: '1.0',
  generated_at,
  state,
  continuity,
  freshness: 'current',
  public_message,
  source_class: 'sanitized-static-projection',
  authoritative: false
};
fs.writeFileSync(file, JSON.stringify(snapshot, null, 2) + '\n');
NODE

  node "$VALIDATOR" "$SNAPSHOT" || return 1

  git add -- phase2/public-continuity.json
  STAGED=$(git diff --cached --name-only)
  if [ "$STAGED" != "phase2/public-continuity.json" ]; then
    echo "HOLD: staged scope is not exactly phase2/public-continuity.json"
    git reset -- phase2/public-continuity.json >/dev/null 2>&1 || true
    return 1
  fi

  git -c user.name='PLERA STOS Publisher' -c user.email='plera-stos@users.noreply.github.com' \
    commit -m "STOS: publish sanitized continuity snapshot" || return 1

  git push origin HEAD:main || {
    echo "HOLD: push failed; local commit preserved"
    return 1
  }

  echo "PASS: sanitized STOS continuity snapshot published"
}

main "$@"
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
  fail "HOLD: PLERA publication did not complete" || true
fi
exit "$STATUS"
