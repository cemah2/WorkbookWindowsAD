# Drills — FSMO

## Drill 1 — Cartographier les 5 rôles (5 min)
- **Étapes** : `netdom query fsmo` + `Get-ADForest`/`Get-ADDomain`.
- **Observer** : quel DC détient quoi.
- **Pourquoi** : réflexe de base avant tout dépannage.

## Drill 2 — Transfert aller-retour (10 min)
- **Étapes** : transfère le PDC Emulator vers un autre DC, vérifie, puis reviens.
- **Pourquoi** : maîtriser le transfert propre.

## Drill 3 — Le PDC et le temps (10 min)
- **Étapes** : `w32tm /query /status` sur le PDC et un autre DC ; identifie la source NTP.
- **Pourquoi** : comprendre le rôle du PDC dans la synchro horaire (critique pour Kerberos).

## Drill 4 — Saisie simulée (15 min)
- **Étapes** : éteins un DC détenteur (lab), saisis son rôle avec -Force, fais le metadata cleanup,
  **ne rallume pas** l'ancien.
- **Pourquoi** : procédure de récupération réelle.

## Drill break-fix — RID pool épuisé (10 min)
- **Casse** : rends le RID Master indisponible et épuise le pool local d'un DC (créations massives).
- **Diagnostique** : échec de création d'objets ; `dcdiag /test:RidManager`.
- **Répare** : rétablis le RID Master (ou transfère/saisis), re-teste.
