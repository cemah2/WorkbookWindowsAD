# Module 64 — Conditional Access & PIM (Phase 6, fin)
Les deux piliers défensifs de l'identité cloud (Entra ID P2).
## Contenu
fiche (CA signaux/contrôles, PIM éligible vs actif, token protection) · drills (bloquer legacy, MFA
admins, activation PIM, break-glass, break-fix verrouillage) · build (break-glass d'abord, CA de base
en report-only, PIM éligible, access reviews) · automate (`Get-CaInventory.ps1`) · attack (contourner
legacy/MFA fatigue/PIM permanent) · defend (CA robustes + PIM sans permanent + détection KQL).
## Definition of Done
- [ ] Comptes **break-glass** créés et exclus ; legacy auth bloquée ; MFA admins + utilisateurs
- [ ] Rôles sensibles passés en **éligibles** (PIM, MFA+approbation) ; access reviews configurées
- [ ] `Get-CaInventory.ps1` rejoué (pas de trou) · drills faits (dont break-fix verrouillage)
- [ ] ≥ 1 détection (KQL break-glass) · **Fin de la Phase 6.** Prérequis : modules 60-63. Suite : Phase 7.
