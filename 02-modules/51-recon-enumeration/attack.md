# Attack — Reconnaissance (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1087 (Account Discovery), T1069 (Groups), T1018 (Remote Systems),
  T1482 (Domain Trust), T1046 (Network Service Discovery).
- **Outils** : BloodHound/SharpHound, PowerView, NetExec, ldapsearch, Kerbrute.

## Déroulé
1. Énumération large (users/groups/shares/pass-pol) via NetExec.
2. Collecte BloodHound → **shortest path to Domain Admins**.
3. Ciblage des attributs à risque (SPN, no-preauth, RBCD, KeyCredentialLink, ACL).
4. Priorisation : quel vecteur donne l'escalade la plus directe (Kerberoasting ? ESC ? ACL ?).

## Ancrage réel
La recon via BloodHound est systématique chez les opérateurs réels : elle transforme un AD opaque en
carte d'autoroutes vers DA. La quasi-totalité des intrusions AD commence par là.

## Résultat attendu
Une cartographie priorisée des vecteurs — point d'entrée des modules 52-58.
