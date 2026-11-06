# Module 35 — CORP en une commande (Phase 3, capstone)
Assembler Terraform + Ansible + DSC pour déployer/détruire tout CORP par un point d'entrée unique.
## Contenu
fiche (pipeline Packer→Terraform→Ansible→DSC, séquencement, idempotence, secrets, Ludus) · drills
(destroy→deploy, hand-off TF→Ansible, idempotence globale, évolution par le code, break-fix
séquencement) · build (arborescence, orchestration, ordre DC→membres→structure) · automate
(`deploy-corp.sh`, `destroy-corp.sh`, `gen_inventory.py`) · attack/defend (pipeline = cible ultime
→ Tier 0 + secrets chiffrés + intégrité + traçabilité).
## Definition of Done
- [ ] `deploy-corp.sh` reconstruit CORP de zéro ; `destroy-corp.sh` le détruit
- [ ] Cycle **destroy → deploy** reproductible à l'identique ; idempotence globale vérifiée
- [ ] Secrets hors dépôt (Vault/tfstate) ; versions épinglées ; runs journalisés
- [ ] Drills faits (dont break-fix séquencement) · **Fin de la Phase 3** (Automatisation)
- [ ] Prérequis : modules 32, 33, 34 (+ Phase 0). Suite : Phase 4 (PKI / AD CS).
