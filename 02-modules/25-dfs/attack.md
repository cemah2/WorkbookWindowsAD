# Attack — Abus des partages de fichiers

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1135 (Network Share Discovery), T1039 (Data from Network Shares),
  T1486 (Data Encrypted for Impact — rançongiciel), T1021.002 (SMB).
- **Outils** : `netexec --shares`, PowerView (`Find-DomainShare`, `Find-InterestingDomainShareFile`).

## Déroulé
1. **Découverte des partages** et de ceux lisibles :
   ```bash
   netexec smb 10.10.0.10 -u jon.snow -p '***' --shares
   ```
2. **Recherche de données sensibles** (mots de passe, clés) sur les partages ouverts.
3. **Impact via réplication** : un partage **répliqué** en écriture → une altération/chiffrement
   se propage à tous les réplicas (scénario rançongiciel).

## Ancrage réel
Les partages trop ouverts sont une source majeure de fuite (identifiants dans des scripts, exports).
Les rançongiciels ciblent les partages pour maximiser l'impact ; la réplication peut aggraver la propagation.

## Résultat attendu
Identifier les partages à risque de CORP — corrigés par `defend.md`.
