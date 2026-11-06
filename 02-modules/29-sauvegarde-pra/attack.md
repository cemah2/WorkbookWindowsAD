# Attack — Cibler la récupération

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1485 (Data Destruction), T1490 (Inhibit System Recovery),
  T1486 (Data Encrypted for Impact), T1078.
- **Principe** : les attaquants évolués détruisent les sauvegardes/clichés pour empêcher la reprise.

## Déroulé (principe)
1. Suppression massive d'objets AD (DoS d'annuaire) ou chiffrement des DC/partages (rançongiciel).
2. **Destruction des sauvegardes** accessibles (VSS, volumes de backup en ligne) pour bloquer la reprise.
3. Sans sauvegardes hors-ligne, la victime est contrainte (paiement / reconstruction complète).

## Ancrage réel
L'étape "détruire les sauvegardes avant de chiffrer" est systématique dans les attaques de
rançongiciel modernes, d'où l'importance des sauvegardes **immuables/hors-ligne** et testées.

## Résultat attendu
Comprendre pourquoi les sauvegardes doivent être isolées et testées — traité dans `defend.md`.
