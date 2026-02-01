#!/usr/bin/env bash
set -euo pipefail

# Generate a QR-code image URL for a BOLT11 invoice.
#
# Usage:
#   ./invoice_qr_url.sh "<bolt11>" [size]
#
# Example:
#   ./invoice_qr_url.sh "lnbc..." 300

INVOICE="${1:-}"
SIZE="${2:-300}"

if [[ -z "${INVOICE}" ]]; then
  echo "Usage: $0 \"<bolt11>\" [size]" >&2
  exit 1
fi

# NOTE: This uses a 3rd-party service (api.qrserver.com). Do not use if you can't share the invoice.
python3 - <<PY
import urllib.parse
inv = ${INVOICE!r}
size = int(${SIZE})
print(f"https://api.qrserver.com/v1/create-qr-code/?size={size}x{size}&data={urllib.parse.quote(inv, safe='')}")
PY
