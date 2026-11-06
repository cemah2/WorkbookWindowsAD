# Attack — Internals exploités (panorama défensif)

> ⚠️ Lab isolé. Vue d'ensemble ; chaque technique a son module dédié (81-84). Objectif : comprendre
> pour détecter, pas produire d'outils offensifs.

## Catégories (et où c'est traité)
- **Token manipulation** (module 81) : vol/impersonation de token, abus de privilèges (SeDebug...).
- **Memory / LSASS** (module 82) : dump de secrets.
- **ETW/AMSI evasion** (module 83) : aveugler la télémétrie.
- **Process injection / sideloading** : Sysmon 7/8 (détection).
- **BYOVD** (Bring Your Own Vulnerable Driver) : charger un driver vulnérable pour atteindre le kernel.

## MITRE ATT&CK (transversal)
- T1055 (Process Injection), T1134 (Token Manipulation), T1003 (Credential Dumping),
  T1562 (Impair Defenses), T1068 (Exploitation for Priv Esc).

## Ancrage réel
Les malwares/EDR-evasion modernes (cf. *Evasive Malware*, *Evading EDR*) s'appuient sur ces internals.
Les comprendre côté défense permet d'écrire des détections robustes.

## Résultat attendu
Une carte mentale « mécanisme interne → technique → détection » pour aborder les modules 81-84.
