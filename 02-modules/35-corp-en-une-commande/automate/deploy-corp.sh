#!/usr/bin/env bash
# Orchestration CORP : Terraform (VM) -> inventaire -> Ansible (promotion+config). Lab.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[1/3] Terraform : provisionnement des VM..."
pushd "$ROOT/terraform" >/dev/null
terraform init -input=false
terraform apply -auto-approve
terraform output -json > "$ROOT/ansible/tf_outputs.json"
popd >/dev/null

echo "[2/3] Génération de l'inventaire Ansible..."
python3 "$ROOT/scripts/gen_inventory.py" "$ROOT/ansible/tf_outputs.json" > "$ROOT/ansible/inventory.yml"

echo "[3/3] Ansible : promotion DC + configuration (dans l'ordre)..."
pushd "$ROOT/ansible" >/dev/null
for pb in 01-dc.yml 02-members.yml 03-structure.yml; do
  echo "  -> $pb"
  ansible-playbook -i inventory.yml "$pb" --vault-password-file "${CORP_VAULT:-$HOME/.corp-vault}"
done
popd >/dev/null

echo "CORP déployé. Vérifie : ansible -i ansible/inventory.yml domaincontrollers -m ansible.windows.win_shell -a 'dcdiag /q'"
