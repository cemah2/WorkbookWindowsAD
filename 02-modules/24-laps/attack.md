# Attack — Abus de mots de passe locaux (avec/sans LAPS)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1003 (Credential Dumping), T1550.002 (Pass-the-Hash), T1078.
- **Outils** : Mimikatz/impacket (P5), lecture d'attributs AD.

## Déroulé
### Sans LAPS (ou LAPS mal configuré)
1. Compromission d'un poste → dump du hash admin local (SAM).
2. **Mot de passe local partagé** → Pass-the-Hash vers tous les autres postes = propagation.

### Legacy LAPS mal délégué
1. Un compte compromis ayant l'ACL lit `ms-Mcs-AdmPwd` en clair dans l'annuaire :
   ```powershell
   Get-ADComputer PAR-WS-01 -Properties ms-Mcs-AdmPwd | Select ms-Mcs-AdmPwd
   ```
2. → admin local de la cible sans effort.

## Ancrage réel
Le mot de passe admin local partagé est l'un des plus vieux et plus efficaces vecteurs de
propagation (nombreuses campagnes de rançongiciels). LAPS est la contre-mesure directe.

## Résultat attendu
Comprendre pourquoi LAPS (+ chiffrement + ACL stricte) ferme ce vecteur — validé par `defend.md`.
