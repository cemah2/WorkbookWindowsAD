# Drills — Kerberos

## Drill 1 — Cycle de vie d'un ticket (10 min)
- **Étapes** : `klist purge` → accéder à un partage → `klist`.
- **Observer** : apparition du TGT puis d'un ST `cifs/...`.
- **Pourquoi** : visualiser AS puis TGS concrètement.

## Drill 2 — Capturer AS-REQ/AS-REP (15 min)
- **Étapes** : Wireshark filtre `kerberos`, ouvre une session, observe AS-REQ/AS-REP/TGS-REQ/TGS-REP.
- **Observer** : la pré-auth, les tickets chiffrés.
- **Pourquoi** : relier la théorie (fiche) au trafic réel.

## Drill 3 — Effet du skew horaire (10 min)
- **Étapes** : décale l'heure du client de +10 min, tente une auth Kerberos.
- **Observer** : échec (KRB_AP_ERR_SKEW) ; `w32tm /resync` répare.
- **Pourquoi** : comprendre pourquoi l'heure est critique.

## Drill 4 — AES vs RC4 (10 min)
- **Étapes** : inspecte `msDS-SupportedEncryptionTypes` d'un compte, force AES, réobserve 4769
  (type de chiffrement du ticket).
- **Pourquoi** : RC4 facilite le Kerberoasting (P5) ; AES durcit.

## Drill break-fix — SPN en double / manquant (10 min)
- **Casse** : crée un SPN en double (`setspn -S` qui refuse) ou supprime un SPN attendu.
- **Diagnostique** : l'accès retombe en NTLM ou échoue ; `setspn -L`, `setspn -Q`.
- **Répare** : corrige le SPN ; l'authentification Kerberos reprend.
