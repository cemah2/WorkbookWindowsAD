# Drills — Server 2025 & dMSA

## Drill 1 — Niveau fonctionnel (10 min)
- **Étapes** : lis ForestMode/DomainMode ; comprends ce que 2025 débloque (dMSA...).
- **Pourquoi** : relier version et fonctionnalités.

## Drill 2 — Créer/observer un dMSA (15 min)
- **Étapes** : crée un dMSA, inspecte ses attributs (msDS-DelegatedMSAState...).
- **Pourquoi** : comprendre l'objet et sa surface.

## Drill 3 — Qui peut créer un dMSA ? (15 min)
- **Étapes** : audite les ACL des OU (droit CreateChild sur msDS-DelegatedManagedServiceAccount).
- **Observer** : tout principal avec ce droit = risque BadSuccessor.
- **Pourquoi** : identifier le prérequis de l'attaque.

## Drill 4 — Réduction NTLM (10 min)
- **Étapes** : compare l'usage NTLM avant/après (audit module 17) en contexte 2025.
- **Pourquoi** : voir l'évolution de la surface.

## Drill break-fix — dMSA mal délégué (10 min)
- **Casse** : accorde CreateChild dMSA sur une OU à un groupe non-admin.
- **Diagnostique** : BadSuccessor possible ; audite l'ACL.
- **Répare** : retire le droit ; re-vérifie.
