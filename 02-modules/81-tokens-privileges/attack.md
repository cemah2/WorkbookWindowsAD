# Attack — Abus de tokens & privilèges (compréhension défensive)

> ⚠️ Lab isolé. On explique ce que ces techniques exploitent pour mieux les détecter, sans fournir
> d'outil clé en main.

## Techniques
- **MITRE ATT&CK** : T1134 (Access Token Manipulation), T1068 (Exploitation for Priv Esc),
  T1543 (services), T1003 (via SeDebug/SeBackup).
- **Exemples** :
  - **SeImpersonate → SYSTEM** : famille « Potato » (JuicyPotato/RoguePotato/PrintSpoofer) — un service
    emprunte un token SYSTEM.
  - **SeDebug → dump LSASS** (module 56).
  - **SeBackup/SeRestore → SAM/NTDS** (contourner les ACL).
  - **SeLoadDriver → BYOVD** (kernel).

## Déroulé (principe)
1. Identifier les privilèges du compte (whoami /priv).
2. Selon le privilège, un chemin d'escalade local existe (ex. service web avec SeImpersonate → SYSTEM).

## Ancrage réel
Les escalades locales via SeImpersonate (comptes de service IIS/SQL) sont extrêmement courantes en
intrusion. Les comprendre permet de les détecter et de réduire les privilèges.

## Résultat attendu
Savoir, pour un compte, quel privilège ouvre quelle escalade → le retirer/surveiller (`defend.md`).
