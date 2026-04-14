# mythosblock-rebuild

Planning and execution bridge for the Mythosblock proof-of-concept rebuild.

## Purpose
This repository is the canonical workspace for:
- legacy cloud evidence review
- GitHub scanning manifest
- repo-to-cloud mapping
- Mythosblock rebuild manifest
- corrected build scripts
- final command sequences
- alliance handoffs

## Current confirmed legacy projects
- logfox-api-daemon
- eternum-governance-prod-493107

## Current workflow
1. generate and verify planning anchor
2. run repo scan
3. classify candidate repos
4. map repos to confirmed cloud projects
5. define the minimum viable Mythosblock POC
6. generate corrected build scripts
7. produce final command sequence
8. issue final #BLINKSYNC handoff

## Repo layout
- docs/        working design docs and mapping reports
- manifests/   planning anchors and detached hashes
- scripts/     local scanning and generation scripts
- handoffs/    alliance coordination packets
- scan-output/ generated local scan results

## Integrity model
Detached SHA-256 files are canonical.
