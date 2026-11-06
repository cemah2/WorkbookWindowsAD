# Build — Inspecter et comprendre les tokens (lab)

## Pré-requis
- VM Windows de lab. (Certaines observations nécessitent un compte de service / admin.)

## Étape 1 — Lire son token
```powershell
whoami /all          # SID, groupes, privilèges, integrity level
whoami /priv         # privilèges et état (enabled/disabled)
```

## Étape 2 — Repérer les privilèges sensibles
Chercher dans la sortie : `SeDebugPrivilege`, `SeImpersonatePrivilege`, `SeBackupPrivilege`,
`SeRestorePrivilege`, `SeLoadDriverPrivilege`, `SeTakeOwnershipPrivilege`.

## Étape 3 — Observer un token dans Process Explorer
- Ouvrir un process → **Properties > Security** : SID, groupes, privilèges, integrity level.
- Comparer un process utilisateur (Medium) et un process SYSTEM (System integrity).

## Étape 4 — Comprendre l'impersonation (concept + observation)
- Les services qui ont **SeImpersonate** peuvent emprunter un token plus privilégié → base des « Potato ».
- (Compréhension défensive : ne pas produire l'exploit, mais savoir ce qu'il exploite et détecter 4672.)

## Étape 5 — Voir où les privilèges sont accordés (GPO)
- User Rights Assignment (GPO, module 20) : qui reçoit quels privilèges → relier au tiering.

## Vérification
```powershell
# Sur un compte de service : SeImpersonatePrivilege présent ? -> surface "Potato"
whoami /priv | findstr /i "Impersonate Debug Backup Restore LoadDriver"
```

## Pièges courants
- Croire qu'un privilège « disabled » est inoffensif (il peut être activé par le process).
- Accorder SeImpersonate/SeDebug trop largement via GPO.
