# Build — Observer LSASS & DPAPI (lab), côté défense

## Pré-requis
- VM Windows de lab. (Dump réel = module 56 ; ici on observe et on durcit.)

## Étape 1 — État des protections LSASS
```powershell
# WDigest (doit être 0 / absent)
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" -Name UseLogonCredential -ErrorAction SilentlyContinue
# RunAsPPL (LSASS en PPL) — 1 attendu
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL -ErrorAction SilentlyContinue
# Credential Guard (via msinfo32 / Device Guard properties)
Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard |
  Select SecurityServicesConfigured, SecurityServicesRunning
```

## Étape 2 — Activer les protections (durcissement)
```powershell
# WDigest off (pas de mot de passe en clair)
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" -Name UseLogonCredential -Value 0
# LSASS en PPL
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL -Value 1
# Credential Guard : activer via GPO/Device Guard (VBS) -> redémarrage
```

## Étape 3 — Observer DPAPI
```powershell
# Localisation des master keys de l'utilisateur
Get-ChildItem "$env:APPDATA\Microsoft\Protect\" -Recurse -Force -ErrorAction SilentlyContinue
```
(La domain backup key est détenue par les DC — à protéger, pas à extraire ici.)

## Étape 4 — Valider la détection d'accès LSASS (Sysmon 10)
Depuis le lab offensif (module 56), tenter un accès à LSASS → vérifier le **Sysmon 10** correspondant.

## Étape 5 — Vérifier l'effet de PPL/Credential Guard
Avec PPL/CG actifs, un dump classique échoue ou ne livre pas de secrets exploitables.

## Vérification
```powershell
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL   # 1
Get-CimInstance Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard | Select SecurityServicesRunning
```

## Pièges courants
- Activer RunAsPPL avec un driver/AV incompatible → problèmes (tester).
- Croire que Credential Guard protège DPAPI (ce sont des mécanismes distincts).
