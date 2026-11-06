# Attack — Abus de la réplication (DCSync / DCShadow)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Introduction ; exploitation complète en Phase 5 (57).

## Techniques
- **MITRE ATT&CK** : T1003.006 (DCSync), T1207 (DCShadow).
- **Outils** : Mimikatz (`lsadump::dcsync`, `lsadump::dcshadow`), impacket `secretsdump`.

## Déroulé (principe)
1. **DCSync** : avec les droits *Replicating Directory Changes (All)*, demander la réplication des
   secrets d'un compte (ex. `krbtgt`, `Administrator`) — comme le ferait un vrai DC :
   ```
   secretsdump.py 'corp/adm@10.10.0.10' -just-dc-user krbtgt
   ```
   → récupération des hashes sans toucher au DC (c'est "légitime" du point de vue réplication).
2. **DCShadow** : enregistrer temporairement un **faux DC** et pousser des changements via la
   réplication (ex. ajouter un SID history) en contournant une partie de la journalisation.

## Ancrage réel
DCSync est un pilier de la post-exploitation AD (extraction de krbtgt → Golden Ticket). DCShadow
est plus furtif et a servi à de la persistance avancée. Les deux abusent du mécanisme de réplication.

## Résultat attendu
Comprendre que les **droits de réplication** sont critiques (Tier 0) — durcissement dans `defend.md`.
