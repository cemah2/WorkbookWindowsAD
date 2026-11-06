# Attack — Cross-forest (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1134.005 (SID History), T1482 (Domain Trust Discovery), T1558 (Kerberos).
- **Outils** : PowerView, impacket (ticketer, getST), Mimikatz, netdom.

## Déroulé (scénario M&A)
1. Compromettre la forêt la moins sûre (Nimbus) — assumed breach.
2. Énumérer le trust vers CORP ; vérifier le **SID filtering**.
3. Si filtering faible : dump de la **trust key** → ticket inter-realm avec **extra-sid** privilégié
   (ex. Enterprise Admins de CORP) → pivot vers CORP.
4. Accès aux ressources CORP.

## Ancrage réel
Les trusts hérités de fusions-acquisitions, souvent bidirectionnels et sans SID filtering, sont une
voie d'escalade inter-forêt bien connue. La forêt « oubliée » devient la porte d'entrée.

## Résultat attendu
Pivot cross-forest réussi (filtering off) → à bloquer par SID filtering/Selective Auth (`defend.md`).
