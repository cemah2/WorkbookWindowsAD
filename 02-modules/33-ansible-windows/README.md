# Module 33 — Ansible pour Windows (Phase 3)
Orchestrer la configuration du parc depuis Linux, sans agent.
## Contenu
fiche (inventaire/playbook/rôles, collections microsoft.ad, Ansible vs DSC, Vault) · drills
(win_ping, idempotence, microsoft.ad, Vault, break-fix auth) · build (install, inventaire,
playbook rôles+AD, Vault, idempotence) · automate (`inventory.yml`, `site.yml`) · attack/defend
(contrôleur = cible → Tier 0 + Vault fort + Kerberos + détection rafale WinRM).
## Definition of Done
- [ ] win_ping OK ; playbook idempotent (changed=0 à la 2e exécution)
- [ ] OU/user gérés via `microsoft.ad` ; secrets en Vault
- [ ] `inventory.yml`/`site.yml` rejoués · drills faits (dont break-fix auth) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 31, 32. Suite : `34-terraform-iac`.
