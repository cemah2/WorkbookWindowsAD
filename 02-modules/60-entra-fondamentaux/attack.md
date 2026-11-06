# Attack — Surface d'attaque Entra (vue d'ensemble)

> ⚠️ Lab/tenant de test uniquement. Exploitation détaillée au module 63.

## Pourquoi Entra change la donne
- Pas de Kerberos/NTLM : tout repose sur des **tokens** OAuth2 → le vol de token = accès.
- Les **applications** (service principals) peuvent détenir des droits très élevés (Graph).
- La frontière réseau disparaît : l'identité **est** le périmètre.

## Catégories (détail module 63)
- **MITRE ATT&CK (cloud)** : T1078.004 (Cloud Accounts), T1528 (Steal Application Access Token),
  T1550.001 (Application Access Token), T1098.001/.003 (Additional Cloud Credentials / Roles).
- Vol de **PRT/tokens**, **illicit consent grant**, **device code phishing**, abus de **service
  principals**, rôles mal attribués, pivots hybrides (modules 62-63).

## Ancrage réel
De nombreuses intrusions récentes passent par le cloud : consent grants malveillants, vol de tokens,
abus d'applications à permissions Graph élevées. L'identité cloud est devenue une cible de premier plan.

## Résultat attendu
Comprendre la nouvelle surface (tokens/apps/rôles) avant d'étudier les attaques hybrides (63).
