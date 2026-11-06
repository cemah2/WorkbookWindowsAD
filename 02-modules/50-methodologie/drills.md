# Drills — Méthodologie

## Drill 1 — Mapper une action à ATT&CK (10 min)
- **Étapes** : prends une commande (ex. GetUserSPNs) et retrouve sa technique/sous-technique ATT&CK.
- **Pourquoi** : réflexe de documentation.

## Drill 2 — Journal de bord (10 min)
- **Étapes** : réalise une action simple (nxc smb), consigne-la (commande, résultat, heure).
- **Pourquoi** : tracer pour la détection et le rapport.

## Drill 3 — kinit / klist (10 min)
- **Étapes** : obtiens un TGT avec `kinit`, inspecte-le (`klist`), utilise un outil `-k`.
- **Pourquoi** : base de tous les outils Kerberos.

## Drill 4 — Snapshot/rollback offensif (10 min)
- **Étapes** : snapshot, casse quelque chose, rollback.
- **Pourquoi** : rejouer les attaques depuis un état propre.
