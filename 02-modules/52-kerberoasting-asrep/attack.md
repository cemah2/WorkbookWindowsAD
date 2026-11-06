# Attack — Kerberoasting & AS-REP (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1558.003 (Kerberoasting), T1558.004 (AS-REP Roasting).
- **Outils** : impacket (GetUserSPNs/GetNPUsers), Rubeus, hashcat.

## Déroulé
1. (Recon, module 51) repérer comptes à SPN et comptes no-preauth.
2. Kerberoasting : `GetUserSPNs -request` → `hashcat -m 13100`.
3. AS-REP : `GetNPUsers -no-pass` → `hashcat -m 18200`.
4. Réutiliser le(s) mot(s) de passe cassé(s) → accès au service / escalade.

## Ancrage réel
Kerberoasting est l'une des techniques les plus utilisées en intrusion AD (comptes de service SQL,
etc. avec mots de passe faibles). Documentée dans d'innombrables rapports d'incident et campagnes.

## Résultat attendu
Au moins un credential de service obtenu → valoriser dans le chemin d'attaque ; puis le neutraliser
(`defend.md`).
