#!/usr/bin/env bash
set -euo pipefail

# Safely pay a BOLT11 invoice ONLY if the decoded amount matches exactly.
#
# Usage:
#   ./pay_if_amount_matches.sh "<bolt11>" 10
#
# Notes:
# - This prevents overpaying when someone claims "10 sats" but posts a higher-amount invoice.
# - Requires phoenix-cli in the current directory (or adjust PHOENIX_CLI).

INVOICE="${1:-}"
EXPECTED_SATS="${2:-}"
PHOENIX_CLI="${PHOENIX_CLI:-./phoenix-cli}"

if [[ -z "${INVOICE}" || -z "${EXPECTED_SATS}" ]]; then
  echo "Usage: $0 \"<bolt11>\" <expected_sats>" >&2
  exit 2
fi

DECODE_JSON="$(${PHOENIX_CLI} decodeinvoice --invoice "${INVOICE}")"

ACTUAL_SATS=$(DECODE_JSON="$DECODE_JSON" python3 - <<'PY'
import json, os, sys
j=json.loads(os.environ['DECODE_JSON'])
# phoenix-cli decodeinvoice currently returns `amount` in millisatoshis.
# Other implementations may use amountSat/amountMsat.
if 'amountSat' in j and j['amountSat'] is not None:
    print(int(j['amountSat']))
    sys.exit(0)
if 'amountMsat' in j and j['amountMsat'] is not None:
    print(int(int(j['amountMsat'])/1000))
    sys.exit(0)
if 'amount' in j and j['amount'] is not None:
    # amount is msat
    print(int(int(j['amount'])/1000))
    sys.exit(0)
print('')
PY
)

if [[ -z "${ACTUAL_SATS}" ]]; then
  echo "Could not determine amount from invoice decode output" >&2
  echo "Decode output was: ${DECODE_JSON}" >&2
  exit 1
fi

if [[ "${ACTUAL_SATS}" != "${EXPECTED_SATS}" ]]; then
  echo "Refusing to pay: invoice amountSat=${ACTUAL_SATS} does not match expected=${EXPECTED_SATS}" >&2
  exit 3
fi

echo "Paying invoice for ${ACTUAL_SATS} sats" >&2
${PHOENIX_CLI} payinvoice --invoice "${INVOICE}" --amountSat "${EXPECTED_SATS}"
