# Attack — Pivots hybrides (lab/tenant de test)

> ⚠️ Tenant de test + lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1556 (Golden SAML), T1550.001 (tokens), T1528 (steal app token),
  T1098.001/.003 (cloud creds/roles), T1621 (MFA fatigue), T1078.004.
- **Outils** : AADInternals, ROADtools/roadtx, TokenTactics, GraphRunner, Microsoft Graph.

## Chaînes phares
1. **On-prem → cloud** : Entra Connect compromis → creds de synchro → actions cloud ; ou ADFS →
   Golden SAML ; ou AZUREADSSOACC$ → ticket cloud.
2. **Poste → cloud** : Pass-the-PRT → tokens → accès M365/Graph.
3. **Cloud pur** : illicit consent / SP abuse → persistance cloud.
4. **Cloud → on-prem** : Intune push / password writeback.

## Ancrage réel
Les intrusions hybrides majeures (ex. campagnes d'État) ont combiné Golden SAML (ADFS) et abus de
service principals pour un accès persistant au cloud. Le vol de tokens contourne le MFA.

## Résultat attendu
Démontrer un pivot bidirectionnel (lab) et le relier à sa détection/durcissement (module 64 + defend).
