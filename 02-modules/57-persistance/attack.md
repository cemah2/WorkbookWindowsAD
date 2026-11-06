# Attack — Persistance & dominance (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1558.001 (Golden), T1558.002 (Silver), T1134.005 (SID History),
  T1098/T1207 (AdminSDHolder/DCShadow), T1649 (certs).
- **Outils** : impacket ticketer, Mimikatz (kerberos::golden), Rubeus, certipy.

## Déroulé
1. krbtgt (module 56) → **Golden Ticket** → accès arbitraire.
2. Alternatives furtives : **Silver**, **Diamond/Sapphire**.
3. Persistance « hors Kerberos » : **certificat** d'auth (survit au mdp), **AdminSDHolder** (ACL),
   **sIDHistory**, **DCShadow**.

## Ancrage réel
Le Golden Ticket (krbtgt) est la persistance AD emblématique ; les attaquants avancés combinent
plusieurs mécanismes (certs + ACL) pour survivre à une remédiation partielle.

## Résultat attendu
Comprendre pourquoi une éradication **complète** (krbtgt x2 + certs + ACL) est nécessaire (`defend.md`).
