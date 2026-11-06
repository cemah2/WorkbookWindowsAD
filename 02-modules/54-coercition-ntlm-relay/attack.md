# Attack — Coercition + relais (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1557.001 (LLMNR/NBT-NS & NTLM relay), T1187 (Forced Authentication), T1649 (certs).
- **Outils** : ntlmrelayx, PetitPotam, Coercer, PrinterBug, Responder, NetExec, certipy.

## Chaînes phares
1. **ESC8** : ntlmrelayx --adcs + PetitPotam(DC) → certificat DC → certipy auth → DCSync.
   (write-up complet : `04-solutions/ESC8-petitpotam-relay.md`)
2. **LDAP relay → RBCD** : ntlmrelayx -t ldap --delegate-access + coercition → RBCD → getST → admin.
3. **SMB relay** : vers une cible sans signing → exécution.

## Ancrage réel
PetitPotam + relais vers AD CS a été l'une des chaînes les plus médiatisées (compromission de domaine
sans credential). Les relais NTLM restent un pilier des intrusions internes.

## Résultat attendu
Un accès/certificat du compte machine coercé → compromission → neutralisé par la signature (`defend.md`).
