# Defend — Sécuriser DSC

## Durcissement
1. **Pull server / dépôt de MOF = Tier 0** : accès strict, intégrité vérifiée.
2. **Chiffrer les secrets** dans les MOF (certificats) ; jamais de mot de passe en clair.
3. **Signer** les configurations/modules ; contrôler les ressources DSC installées.
4. Surveiller les **changements de configuration** et le mode du LCM.
5. Versionner les configs (revue de code) et limiter qui peut les modifier.

## Détection
| Événement | Source | ID |
|---|---|---|
| Application/échec DSC | Microsoft-Windows-DSC/Operational | — |
| Changement du LCM | DSC/Operational | — |
| Modif d'un MOF / module DSC | Sysmon (file create) | 11 |

### Règle Sigma — modification d'un fichier MOF de configuration
```yaml
title: Modification d'un fichier de configuration DSC (.mof)
logsource:
  product: windows
  category: file_event
detection:
  selection:
    TargetFilename|endswith: '.mof'
    TargetFilename|contains: '\Configuration\'
  condition: selection
level: medium
tags:
  - attack.persistence
  - attack.t1072
```

## Preuve de détection (purple team)
Modifie un MOF de test et vérifie l'événement Sysmon 11 + la règle ; observe l'auto-correction du
LCM (et pourquoi une persistance DSC survit à un nettoyage naïf).

## Rejouer contre CORP durci
Avec Pull server protégé, MOF signés/chiffrés et surveillance, une config malveillante ne se
distribue pas silencieusement.
