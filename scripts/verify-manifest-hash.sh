#!/bin/bash
set -Eeuo pipefail

MANIFEST="${1:-$HOME/mythosblock-rebuild/manifests/github-scanning-manifest.md}"
HASH_FILE="${MANIFEST}.sha256"

echo "Manifest:"
echo "  ${MANIFEST}"
echo "Hash file:"
echo "  ${HASH_FILE}"
echo

echo "Detached hash:"
cat "${HASH_FILE}"
echo

echo "Current file hash:"
shasum -a 256 "${MANIFEST}"
