# Drills — Délégations / RBCD

## Drill 1 — Inventaire des délégations (10 min)
- **Étapes** : `findDelegation` + BloodHound (edges de délégation).
- **Observer** : unconstrained/constrained/RBCD présents dans GOAD.
- **Pourquoi** : repérer le vecteur.

## Drill 2 — MachineAccountQuota (5 min)
- **Étapes** : lis `ms-DS-MachineAccountQuota` du domaine.
- **Observer** : souvent 10 (un user peut créer des comptes machine !).
- **Pourquoi** : prérequis courant de RBCD.

## Drill 3 — RBCD complet (15 min)
- **Étapes** : addcomputer → rbcd write → getST -impersonate → psexec.
- **Pourquoi** : la chaîne moderne d'escalade par délégation.

## Drill 4 — Nettoyage (5 min)
- **Étapes** : retire l'attribut RBCD (`rbcd -action remove`), supprime le compte machine.
- **Pourquoi** : hygiène de lab + comprendre la remédiation.

## Drill break-fix — getST échoue (10 min)
- **Casse** : mauvais SPN / horloge décalée.
- **Diagnostique** : erreur Kerberos ; vérifie SPN et heure.
- **Répare** : corrige, relance.
