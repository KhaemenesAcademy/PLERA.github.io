import fs from 'node:fs';

const file = process.argv[2] || 'phase2/public-continuity.json';
const raw = fs.readFileSync(file, 'utf8');
let value;
try {
  value = JSON.parse(raw);
} catch (error) {
  console.error(`INVALID_JSON ${file}: ${error.message}`);
  process.exit(1);
}

const required = [
  'schema_version',
  'generated_at',
  'state',
  'continuity',
  'freshness',
  'public_message',
  'source_class',
  'authoritative'
];

const actual = Object.keys(value).sort();
const expected = [...required].sort();
if (JSON.stringify(actual) !== JSON.stringify(expected)) {
  console.error(`INVALID_FIELDS expected=${expected.join(',')} actual=${actual.join(',')}`);
  process.exit(1);
}

const allowed = {
  state: new Set(['available', 'degraded', 'maintenance', 'unknown']),
  continuity: new Set(['nominal', 'recovering', 'maintenance', 'unknown']),
  freshness: new Set(['current', 'stale', 'unknown'])
};

if (value.schema_version !== '1.0') throw new Error('schema_version must be 1.0');
if (!Number.isFinite(Date.parse(value.generated_at))) throw new Error('generated_at must be an ISO date-time');
if (!allowed.state.has(value.state)) throw new Error('invalid state');
if (!allowed.continuity.has(value.continuity)) throw new Error('invalid continuity');
if (!allowed.freshness.has(value.freshness)) throw new Error('invalid freshness');
if (typeof value.public_message !== 'string' || value.public_message.length < 1 || value.public_message.length > 333) throw new Error('public_message length must be 1..333');
if (value.source_class !== 'sanitized-static-projection') throw new Error('source_class must be sanitized-static-projection');
if (value.authoritative !== false) throw new Error('authoritative must be false');

const forbidden = [
  /127\.0\.0\.1/i,
  /\blocalhost\b/i,
  /\b10\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/,
  /\b192\.168\.\d{1,3}\.\d{1,3}\b/,
  /\b172\.(?:1[6-9]|2\d|3[01])\.\d{1,3}\.\d{1,3}\b/,
  /\/v1\/(?:admin|operator|control)/i,
  /\bBearer\b/i,
  /STOS_ADMIN_TOKEN/i,
  /\bROOT[_ -]?SECRET\b/i,
  /\bpasscode\b/i,
  /\.sock\b/i,
  /\/Users\//,
  /\/home\//,
  /\bsession[_ -]?(?:id|token|cookie)?\b/i,
  /\bpid\b/i,
  /\bport\s*[:=]?\s*\d+/i
];

for (const pattern of forbidden) {
  if (pattern.test(raw)) {
    console.error(`FORBIDDEN_PUBLIC_CONTENT pattern=${pattern}`);
    process.exit(1);
  }
}

console.log(`PASS ${file} strict_fields=8 authoritative=false`);
