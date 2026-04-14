---
title: Mythosblock GitHub Scanning Manifest
version: 1.0.1
generated_at: 2026-04-14T03:41:34Z
manifest_uid: 450a7bc3-61d6-4cf7-a6f1-d3162b770ca4
status: draft-for-rebuild-mapping
source_of_truth:
  - confirmed_gcp_inventory
  - github_repositories
  - local_project_folders
  - manual_secret_reconstruction
target_org: mythosblock
operator: drake@mythosblock.com
integrity_model: detached_sha256
---

# Mythosblock GitHub Scanning Manifest

## 1. Mission
This manifest maps legacy cloud evidence and local/GitHub repositories into a clean Mythosblock rebuild plan.

This is a planning artifact.
It does not provision infrastructure.
It does not assert that all security controls are already enforced.
It defines what must be scanned, mapped, kept, rebuilt, or discarded.

## 2. Confirmed Legacy Cloud Projects
These are the currently confirmed high-signal projects from the old environment:

| Legacy Project ID | Status | Evidence |
|---|---|---|
| `logfox-api-daemon` | Confirmed | Cloud Build buckets, Cloud Run source bucket, Cloud Functions source/upload buckets, metadata bucket |
| `eternum-governance-prod-493107` | Confirmed | Cloud Run services, Cloud Build trigger, Firestore, BigQuery, knowledge-base buckets |

## 3. Legacy Project Notes
### logfox-api-daemon
- Treat as a real deployment lineage source
- Secret Manager and Artifact Registry visibility blocked by billing
- Buckets provide strong lineage evidence
- Rebuild should be based on repo mapping, bucket lineage, service accounts, and IAM shape

### eternum-governance-prod-493107
- Treat as a central governance project
- Confirmed Cloud Run, Firestore, BigQuery, GitHub-linked Cloud Build trigger
- BigQuery and Firestore naming should be preserved where intentional
- Secret reconstruction must be manual and deliberate

## 4. Repository Mapping Table
Fill this from the GitHub scan and local repo audit.

| Source Repo / Folder | Destination Repo (Mythosblock) | Legacy Project Link | Runtime | Security Tier | Keep / Archive / Rebuild | Notes |
|---|---|---|---|---|---|---|
| daemonic-codex-infrastructure | codex-archive | reference-only | infra | Tier 3 | Archive | Legacy reference only |
| eternum-governance-infrastructure | eternum-governance | eternum-governance-prod-493107 | Cloud Run / GCP | Tier 1 | Rebuild | High-signal governance path |
| logfox-api-daemon | mythosblock-logfox-core | logfox-api-daemon | Cloud Run / Functions | Tier 1 | Rebuild | Confirmed deployment lineage |
| eternum-liquidity-nexus | liquidity-nexus-l0 | unconfirmed cloud mapping | app / protocol | Tier 2 | Review | Confirm repo linkage first |
| mythosblock_core_migration | mythosblock-rebuild | target-state only | infra | Tier 1 | Rebuild | Candidate orchestration repo |
| Mythosblock_POC_Infrastructure | mythosblock-infra-archive | mixed | infra | Tier 3 | Review | Likely partial reference material |

## 5. Required Scan Targets
For each candidate repo or local folder, capture:

1. Dockerfiles
2. cloudbuild.yaml / cloudbuild.yml
3. Terraform files
4. GitHub Actions workflows
5. Cloud Run deploy commands
6. GCP project IDs embedded in code
7. Artifact Registry or Container Registry references
8. Secret names / env var names only
9. Firestore / BigQuery / bucket references
10. Service account names
11. Pub/Sub / Eventarc / Scheduler references
12. Binary Authorization / signing / provenance references if any

## 6. Security Targets for the New Mythosblock Build
These are target controls for the rebuild, not assumed current facts.

- dedicated service accounts only
- no default compute service account dependency
- signed commits required
- OIDC / Workload Identity Federation for GitHub
- provenance-oriented build pipeline
- Artifact Registry as canonical image store
- optional Binary Authorization and signing once the core deployment path is stable

## 7. Manual Secret Reconstruction Rule
Legacy Secret Manager state is incomplete due billing restrictions.
Therefore:
- do not treat empty legacy `secrets.json` files as proof of no secrets
- reconstruct secrets from GitHub references, local env references, deployment files, and operator memory
- rotate or recreate every secret in Mythosblock
- never copy old secret assumptions blindly

## 8. Immediate Next Outputs
After this manifest is generated and reviewed, the next outputs will be:

1. repo scanning command set
2. repo-to-cloud mapping report
3. Mythosblock rebuild manifest
4. corrected new-codex scripts
5. final command sequence
6. final #BLINKSYNC alliance handoff

## 9. Manifest Integrity
- Manifest UID: 450a7bc3-61d6-4cf7-a6f1-d3162b770ca4
- Generated At: 2026-04-14T03:41:34Z
- Canonical SHA-256: stored in detached file `github-scanning-manifest.md.sha256`
