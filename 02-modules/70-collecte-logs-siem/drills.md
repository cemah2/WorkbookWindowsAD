# Drills — Collecte & SIEM

## Drill 1 — Vérifier l'audit policy (10 min)
- **Étapes** : `auditpol /get /category:*` sur un DC.
- **Observer** : quelles catégories sont activées.
- **Pourquoi** : sans audit, pas d'événement.

## Drill 2 — Générer puis retrouver un événement (10 min)
- **Étapes** : provoque un 4625 (mauvais mot de passe), retrouve-le dans le SIEM.
- **Pourquoi** : valider le pipeline de bout en bout.

## Drill 3 — Alerte 1102 (10 min)
- **Étapes** : efface le journal Security (VM jetable), vérifie l'alerte 1102.
- **Pourquoi** : détecter l'anti-forensics.

## Drill 4 — Dashboard minimal (15 min)
- **Étapes** : crée un tableau de bord (logons, échecs, 4688) dans le SIEM.
- **Pourquoi** : visualiser l'activité.

## Drill break-fix — Agent qui ne remonte plus (10 min)
- **Casse** : stoppe l'agent / coupe le réseau.
- **Diagnostique** : absence d'événements récents ; état de l'agent.
- **Répare** : relance l'agent/connectivité, re-vérifie l'ingestion.
