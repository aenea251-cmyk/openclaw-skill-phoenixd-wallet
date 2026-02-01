#!/usr/bin/env bash
set -euo pipefail

# Download a phoenixd release zip and extract phoenixd + phoenix-cli into ./bin
#
# Usage:
#   ./download_phoenixd.sh 0.7.2 linux-x64
#   ./download_phoenixd.sh 0.7.2 linux-arm64

VERSION="${1:-0.7.2}"
TARGET="${2:-linux-x64}"

ZIP="phoenixd-${VERSION}-${TARGET}.zip"
URL="https://github.com/ACINQ/phoenixd/releases/download/v${VERSION}/${ZIP}"

mkdir -p bin

if command -v wget >/dev/null 2>&1; then
  wget -O "${ZIP}" "${URL}"
elif command -v curl >/dev/null 2>&1; then
  curl -L -o "${ZIP}" "${URL}"
else
  echo "Need wget or curl" >&2
  exit 1
fi

if ! command -v unzip >/dev/null 2>&1; then
  echo "Need unzip" >&2
  exit 1
fi

# -j: junk paths, keep only filenames
unzip -o -j "${ZIP}" -d bin
chmod +x bin/phoenixd bin/phoenix-cli || true

echo "Extracted to ./bin"
ls -la bin | sed -n '1,50p'
