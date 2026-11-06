# Drills — LSASS & DPAPI

## Drill 1 — État des protections (10 min)
- **Étapes** : vérifie WDigest, RunAsPPL, Credential Guard.
- **Pourquoi** : connaître sa posture avant toute chose.

## Drill 2 — Sysmon 10 sur accès LSASS (10 min)
- **Étapes** : déclenche un accès LSASS (lab, module 56), repère le Sysmon 10 + GrantedAccess.
- **Pourquoi** : la détection de référence du dump de creds.

## Drill 3 — Master keys DPAPI (10 min)
- **Étapes** : localise les master keys de l'utilisateur ; comprends le rôle de la domain backup key.
- **Pourquoi** : saisir la portée de DPAPI.

## Drill 4 — Effet de PPL (10 min)
- **Étapes** : active RunAsPPL, retente un accès LSASS non-PPL → bloqué.
- **Pourquoi** : mesurer le durcissement.

## Drill break-fix — PPL casse un outil (10 min)
- **Casse** : un outil légitime non-PPL ne peut plus accéder à LSASS après RunAsPPL.
- **Diagnostique** : erreur d'accès ; comprendre PPL.
- **Répare** : adapter l'outil / exception maîtrisée ; peser sécurité vs compatibilité.
