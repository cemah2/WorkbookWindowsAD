# Drills — CA & PIM

## Drill 1 — Bloquer la legacy auth (10 min)
- **Étapes** : crée la CA "Block legacy authentication" en report-only puis enabled ; teste.
- **Pourquoi** : c'est la mesure anti-spray la plus rentable.

## Drill 2 — MFA admins (10 min)
- **Étapes** : CA exigeant MFA pour les rôles à privilèges ; teste une connexion admin.
- **Pourquoi** : protéger les comptes les plus sensibles.

## Drill 3 — PIM activation (15 min)
- **Étapes** : rends un rôle éligible, active-le via PIM (MFA + justification).
- **Observer** : élévation temporaire, trace d'audit.
- **Pourquoi** : supprimer les privilèges permanents.

## Drill 4 — Break-glass (10 min)
- **Étapes** : vérifie que les comptes d'urgence sont exclus des CA et alertés.
- **Pourquoi** : éviter le verrouillage + surveiller l'usage.

## Drill break-fix — Verrouillage CA (10 min)
- **Casse** : applique une CA trop large sans exclusion.
- **Diagnostique** : plus d'accès ; utilise un **break-glass** pour entrer.
- **Répare** : corrige la CA (report-only d'abord !). Leçon : toujours break-glass + report-only.
