# Build — Orchestrer le déploiement complet de CORP

> On assemble les briques des modules 32-34 en un pipeline. Objectif : `./deploy-corp.sh` crée et
> configure CORP ; `./destroy-corp.sh` le détruit.

## Pré-requis
- Phase 0 (Proxmox, templates Packer, réseau/VLAN, Ludus optionnel).
- Modules 32-34 compris (DSC, Ansible, Terraform).
- Secrets prêts : token API Proxmox (tfvars), Vault Ansible.

## Étape 1 — Arborescence du pipeline
```
corp-iac/
├── terraform/           # VM (module 34) : providers.tf, variables.tf, *.tf, terraform.tfvars (NON commité)
├── ansible/             # config (module 33) : inventory (généré), playbooks, roles/, group_vars/ (vault)
├── dsc/                 # configs DSC (module 32)
├── deploy-corp.sh       # orchestration
└── destroy-corp.sh
```

## Étape 2 — Terraform provisionne, puis exporte l'inventaire
```bash
cd terraform
terraform init && terraform apply -auto-approve
terraform output -json > ../ansible/tf_outputs.json   # IPs/noms pour l'inventaire
```

## Étape 3 — Générer l'inventaire Ansible depuis les outputs
Un petit script (ou `terraform output`) alimente `ansible/inventory.yml` avec les hôtes créés
(DC d'abord, puis membres).

## Étape 4 — Ansible : promouvoir + configurer dans l'ordre
```bash
cd ../ansible
# 1) Promotion du premier DC (microsoft.ad.domain), attente de dispo
ansible-playbook -i inventory.yml 01-dc.yml --ask-vault-pass
# 2) Jonction des membres + DC additionnels
ansible-playbook -i inventory.yml 02-members.yml --ask-vault-pass
# 3) Structure : OU, groupes AGDLP, tiering, GPO, LAPS, DFS
ansible-playbook -i inventory.yml 03-structure.yml --ask-vault-pass
```

## Étape 5 — DSC prend le relais (anti-dérive)
Appliquer les configurations DSC (push ou pull) pour maintenir l'état durci.

## Étape 6 — Le point d'entrée unique
`deploy-corp.sh` (extrait) :
```bash
#!/usr/bin/env bash
set -euo pipefail
pushd terraform && terraform apply -auto-approve && terraform output -json > ../ansible/tf_outputs.json && popd
python3 scripts/gen_inventory.py ansible/tf_outputs.json > ansible/inventory.yml
pushd ansible
for pb in 01-dc.yml 02-members.yml 03-structure.yml; do
  ansible-playbook -i inventory.yml "$pb" --vault-password-file ~/.corp-vault
done
popd
echo "CORP déployé."
```

## Étape 7 — Détruire proprement
`destroy-corp.sh` : `cd terraform && terraform destroy -auto-approve`.

## Vérification
```bash
# Après deploy : le domaine répond, les objets existent
ansible -i ansible/inventory.yml domaincontrollers -m ansible.windows.win_shell -a "dcdiag /q"
```
Teste le cycle complet **destroy → deploy** : CORP doit revenir à l'identique.

## Pièges courants
- **Séquencement** : configurer un membre avant que le DC soit prêt (ajouter attentes/retries).
- Secrets committés (token/tfstate/vault) → .gitignore + scan.
- Versions non épinglées → rebuild non reproductible.
