# Build — Explorer les internals avec Sysinternals (lab)

## Pré-requis
- Une VM Windows de lab. Suite **Sysinternals** (Process Explorer, Procmon, Autoruns, WinObj).

## Étape 1 — Process Explorer : lineage & handles
- Ouvrir **Process Explorer** ; observer l'arbre des process (parent/enfant).
- Sélectionner `lsass.exe` → **View > Lower Pane > Handles** : voir les objets ouverts.
- Repérer un process et ses **DLL** chargées (évasion = DLL inattendue).

## Étape 2 — Procmon : activité en temps réel
- **Process Monitor** : filtrer sur un process, observer accès fichiers/registre/réseau.
- Utile pour comprendre ce qu'une action fait réellement au système.

## Étape 3 — Observer un token
```powershell
whoami /all          # SID, groupes, privilèges du token courant
```
(approfondi au module 81)

## Étape 4 — Autoruns : points de persistance
- **Autoruns** : lister les points de démarrage automatique (services, run keys, tâches…) → base pour
  comprendre la persistance (module 57) côté détection.

## Étape 5 — WinObj : l'Object Manager
- Explorer l'espace de noms des objets (devices, sessions) pour visualiser « tout est objet ».

## Étape 6 — Relier à la détection
Associer chaque observation à un Event Sysmon : lineage → Sysmon 1 ; DLL → 7 ; handle LSASS → 10.

## Vérification
- Savoir expliquer, pour un process donné : son parent, son token, ses DLL, et quel Sysmon le
  journaliserait.

## Pièges courants
- Confondre un comportement légitime et une anomalie sans **baseline**.
- Oublier que certaines observations nécessitent des privilèges (admin/PPL).
