# Defend — Baseline de durcissement initial & détection

> Objectif : réduire la surface vue dans `attack.md` et savoir **détecter** les accès
> d'administration. Baseline minimale ; le durcissement AD complet arrive en Phase 2.

## Durcissement initial

1. **Signature SMB obligatoire** (bloque une large classe de relais NTLM) :
   ```powershell
   Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
   ```
2. **RDP avec NLA** (Network Level Authentication) activé, et accès restreint :
   ```powershell
   Set-ItemProperty "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" `
     -Name UserAuthentication -Value 1
   ```
   Limiter RDP/WinRM aux seuls réseaux/postes d'administration (pare-feu Windows + segmentation).
3. **Pare-feu** : n'exposer que le strict nécessaire ; tout le reste refusé par défaut.
4. **Comptes** : renommer/désactiver les comptes inutiles ; mot de passe admin local fort
   (sera géré par LAPS en Phase 2).
5. **Baselines** : appliquer les *Microsoft Security Baselines* / **CIS** (via GPO en Phase 2).

> Note versioning : en **Server 2025**, NTLM est déprécié — privilégier Kerberos et planifier
> l'audit/réduction NTLM dès maintenant.

## Détection

| Événement | Log | Event ID |
|---|---|---|
| Ouverture de session (succès/échec) | Security | 4624 / 4625 |
| Session RDP (logon type 10) | Security | 4624 (LogonType=10) |
| Activité WinRM / PowerShell distant | Microsoft-Windows-WinRM/Operational | — |
| Modification de service | System | 7045 (nouveau service) |

### Règle Sigma — échecs de connexion répétés (spray naissant)
```yaml
title: Multiples échecs d'authentification (spray possible) sur serveur
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4625
  timeframe: 5m
  condition: selection | count() by TargetUserName > 5
level: medium
tags:
  - attack.credential_access
  - attack.t1110
```

## Preuve de détection (purple team)
Rejoue le *spraying* / scan de `attack.md` (ou un test Atomic Red Team T1110) contre le serveur,
puis vérifie l'apparition des 4625 et le déclenchement de la règle Sigma dans ton futur SIEM (P7).

## Rejouer contre le serveur durci
Relance `netexec smb 10.10.0.10` après avoir imposé la signature SMB : observe que la posture
change (signature requise), ce qui fermera la porte au relais NTLM du module 54.
