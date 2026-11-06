# Attack — Dump & réutilisation de credentials (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1003 (OS Credential Dumping) et sous-techniques : .001 LSASS, .002 SAM,
  .003 NTDS, .004 LSA, .006 DCSync ; T1550 (PtH/PtT).
- **Outils** : impacket secretsdump, Mimikatz, lsassy, NetExec, SharpDPAPI.

## Déroulé
1. Accès admin local → dump **LSASS** → hash/ticket → **PtH/PtT** vers une autre machine.
2. Escalade jusqu'à des droits de réplication → **DCSync** → krbtgt + tous les hashes.
3. krbtgt → persistance (Golden Ticket, module 57).

## Ancrage réel
Le dump LSASS (Mimikatz) et le DCSync sont parmi les techniques les plus emblématiques et détectées
des intrusions AD. krbtgt via DCSync = objectif récurrent des opérateurs.

## Résultat attendu
Hashes/tickets réutilisés + krbtgt obtenu → bascule vers la persistance (module 57), puis neutralisation.
