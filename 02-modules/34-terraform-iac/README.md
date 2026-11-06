# Module 34 — Terraform (IaC) (Phase 3)
Provisionner les VM Proxmox en déclaratif (l'infra comme du code).
## Contenu
fiche (provider/resource/state, plan/apply/destroy, Terraform vs Ansible/DSC, cloud-init) · drills
(plan, apply/destroy, for_each, state, break-fix dérive) · build (provider bpg/proxmox, VM depuis
template, for_each, hand-off Ansible) · automate (`providers.tf`, `variables.tf`, `dc.tf`,
`terraform.tfvars.example`) · attack/defend (state/token = clés → ne pas committer + remote state
+ scan secrets).
## Definition of Done
- [ ] `plan`/`apply`/`destroy` fonctionnels contre Proxmox ; une VM créée depuis template
- [ ] `for_each` pour plusieurs VM ; outputs exportables vers Ansible
- [ ] state/secrets protégés (.gitignore vérifié) · drills faits (dont break-fix dérive)
- [ ] ≥ 1 contrôle de détection (scan secrets) · prérequis : Phase 0, module 33. Suite : `35`.
