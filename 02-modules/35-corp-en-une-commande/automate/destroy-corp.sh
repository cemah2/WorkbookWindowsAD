#!/usr/bin/env bash
# Détruit l'infrastructure CORP (Terraform). Lab. Snapshots conseillés avant.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd "$ROOT/terraform" >/dev/null
terraform destroy -auto-approve
popd >/dev/null
echo "CORP détruit."
