# Attack — Contourner CA/PIM mal configurés

> ⚠️ Tenant de test uniquement. Ici on montre les TROUS, pour les combler.

## Techniques
- **MITRE ATT&CK** : T1078.004, T1556, T1621 (MFA fatigue), T1550.001.
- **Vecteurs de contournement** :
  - **Legacy auth non bloquée** → password spray sans MFA (IMAP/POP/SMTP, EWS…).
  - **Exclusions CA trop larges** (groupes, apps, « trusted locations » permissifs).
  - **MFA fatigue** : spammer les notifications jusqu'à acceptation.
  - **PIM permanent résiduel** : rôle Global Admin encore permanent → cible.
  - **Token theft** contourne le MFA (le token porte la session) → d'où token protection.

## Déroulé (principe)
1. Énumérer les politiques CA (si accès) et chercher les exclusions/legacy.
2. Exploiter le trou (spray via legacy, app exclue, MFA fatigue).
3. Si un rôle permanent subsiste → le viser directement.

## Ancrage réel
Le MFA fatigue et l'abus de legacy auth ont permis plusieurs intrusions notables. Les exclusions CA
« temporaires » oubliées sont un classique d'audit.

## Résultat attendu
Lister les trous CA/PIM du tenant → les combler (`defend.md`).
