# Attack — Entra Connect comme pont d'attaque

> ⚠️ Lab/tenant de test uniquement. Détails au module 63.

## Techniques
- **MITRE ATT&CK** : T1003 (credentials), T1550.001, T1078.004, T1556 (ADFS/Golden SAML).
- **Pourquoi** : le serveur Connect relie on-prem ET cloud → sa compromission porte dans les deux mondes.

## Vecteurs
1. **Serveur Entra Connect compromis** → extraire les creds de synchro (outils type AADInternals
   `Get-AADIntSyncCredentials`) → le compte `MSOL_*` a des droits de **réplication** (DCSync on-prem),
   et le compte de synchro cloud peut modifier des objets Entra.
2. **AZUREADSSOACC$** (Seamless SSO) : son hash permet de forger des **Silver Tickets** vers le cloud.
3. **PTA agent** compromis → intercepter les mots de passe validés.
4. **ADFS** : vol de la clé de signature token → **Golden SAML** (forger n'importe quel token cloud).

## Ancrage réel
La compromission d'Entra Connect / ADFS est un pivot hybride documenté (ex. campagnes d'État : vol de
clés ADFS → Golden SAML). Le serveur Connect est un actif Tier 0 critique.

## Résultat attendu
Comprendre que le pont hybride doit être traité en Tier 0 — détail des pivots au module 63.
