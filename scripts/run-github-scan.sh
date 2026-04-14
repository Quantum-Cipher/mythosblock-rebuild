#!/bin/bash
# FILE: ~/mythosblock-rebuild/scripts/run-github-scan.sh
# PURPOSE: Scan candidate local repos/folders for rebuild-relevant deployment signals
# MODE: Read-only, planning-phase

set -Eeuo pipefail

BASE_DIR="${HOME}/mythosblock-rebuild"
OUT_DIR="${BASE_DIR}/scan-output"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
RUN_DIR="${OUT_DIR}/scan_${TIMESTAMP}"

mkdir -p "${RUN_DIR}"

scan_target() {
  local target="$1"
  local safe_name
  safe_name="$(basename "$target" | tr ' /:' '___')"
  local target_dir="${RUN_DIR}/${safe_name}"

  mkdir -p "${target_dir}"

  echo "[INFO] Scanning: ${target}"

  find "$target" -type f \( \
    -name 'Dockerfile' -o \
    -name 'docker-compose.yml' -o \
    -name 'docker-compose.yaml' -o \
    -name 'cloudbuild.yaml' -o \
    -name 'cloudbuild.yml' -o \
    -name '*.tf' -o \
    -path '*/.github/workflows/*' -o \
    -name 'package.json' -o \
    -name 'requirements.txt' -o \
    -name 'pyproject.toml' -o \
    -name 'go.mod' -o \
    -name '*.sh' -o \
    -name '.env.example' -o \
    -name '.env.sample' \
  \) > "${target_dir}/file_hits.txt" 2>/dev/null || true

  grep -RInE \
    'gcloud run deploy|gcloud builds submit|artifactregistry|docker.pkg.dev|gcr.io|cloudfunctions|firestore|bigquery|pubsub|eventarc|scheduler|secretmanager|workload identity|oidc|binary authorization|cosign|kms|PROJECT_ID|GOOGLE_CLOUD_PROJECT' \
    "$target" > "${target_dir}/keyword_hits.txt" 2>/dev/null || true

  echo "[INFO] Done: ${target}"
}

for target in "$@"; do
  if [ -d "$target" ]; then
    scan_target "$target"
  else
    echo "[WARN] Skipping missing target: $target"
  fi
done

echo "[INFO] Scan output written to: ${RUN_DIR}"
