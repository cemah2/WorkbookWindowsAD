# Drills — NTLM

## Drill 1 — Kerberos vs NTLM par le cache (10 min)
- **Étapes** : `klist purge`, accède par **nom** (`\\par-dc-01\sysvol`) → `klist` (ST présent) ;
  puis par **IP** (`\\10.10.0.10\sysvol`) → `klist` (pas de nouveau ST).
- **Observer** : l'accès par IP bascule en NTLM.
- **Pourquoi** : comprendre *quand* NTLM est déclenché.

## Drill 2 — Capturer un NetNTLMv2 (15 min)
- **Étapes** (lab) : lance Responder sur le poste attaquant, provoque une connexion SMB d'un
  client vers un nom inexistant → capture d'un hash NetNTLMv2.
- **Observer** : la structure du hash capturé (crackable hors-ligne).
- **Pourquoi** : visualiser la capture avant le cassage/relais (Phase 5).

## Drill 3 — Signature SMB on/off (10 min)
- **Étapes** : `Get-SmbServerConfiguration | Select RequireSecuritySignature` ; bascule et teste
  `netexec smb <ip>` depuis l'attaquant.
- **Observer** : l'état "signing required" change la posture (anti-relais).

## Drill 4 — Lire l'audit NTLM (10 min)
- **Étapes** : après l'étape d'audit (build), liste les événements NTLM/Operational.
- **Pourquoi** : identifier quels comptes/apps utilisent encore NTLM avant de le restreindre.

## Drill break-fix — Blocage NTLM trop agressif (10 min)
- **Casse** : passe *Restrict NTLM* en "Deny all" dans le domaine.
- **Diagnostique** : une app/un accès hérité échoue ; événements 8004.
- **Répare** : repasse en audit + exceptions ciblées ; comprends la démarche progressive.
