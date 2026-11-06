# Module 24 — Windows LAPS (Phase 2)
Mots de passe admin locaux uniques et gérés : casse le rebond latéral.
## Contenu
fiche (Windows LAPS vs Legacy, attributs msLAPS-*, chiffrement) · drills (récupérer, rotation,
qui peut lire, chiffrement, break-fix remontée) · build (schéma, self/read permission, GPO,
récupération) · automate (`Set-LapsBaseline.ps1`) · attack/defend (mot de passe local partagé /
Legacy mal délégué → Windows LAPS chiffré + ACL par tier + détection 4662).
## Definition of Done
- [ ] Schéma étendu, machines écrivent, groupe autorisé lit (ACL par tier)
- [ ] GPO LAPS (longueur/âge/chiffrement) appliquée ; récupération & rotation testées
- [ ] `Set-LapsBaseline.ps1` rejoué · drills faits (dont break-fix) · ≥ 1 règle Sigma
- [ ] Prérequis : modules 20, 22. Suite : `25-dfs`.
