# Build — Déployer Sysmon avec une bonne config (lab)

## Pré-requis
- Endpoints/DC Windows ; SIEM qui ingère `Microsoft-Windows-Sysmon/Operational` (module 70).

## Étape 1 — Récupérer Sysmon + une config éprouvée
```powershell
# Sysmon (Sysinternals) + une config (SwiftOnSecurity ou Olaf Hartong)
# Déposer sysmon.exe et sysmonconfig.xml sur la cible (lab)
```

## Étape 2 — Installer
```cmd
sysmon.exe -accepteula -i sysmonconfig.xml
```

## Étape 3 — Vérifier
```powershell
Get-Service Sysmon*                     # service en cours
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 10 | Select Id, TimeCreated
```

## Étape 4 — Mettre à jour la config (sans réinstaller)
```cmd
sysmon.exe -c sysmonconfig.xml
```

## Étape 5 — Déployer à l'échelle
- GPO (startup script) / Ansible (`win_copy` + `win_command`) / DSC. Centraliser la config + sa mise à jour.
- Forwarder le canal vers le SIEM (module 70).

## Étape 6 — Valider la détection LSASS
Depuis le lab offensif, tente un accès à LSASS (module 56) → vérifier le **Sysmon 10** correspondant.

## Vérification
```powershell
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -FilterXPath "*[System[EventID=10]]" -MaxEvents 5
# Events Sysmon présents et forwardés vers le SIEM
```

## Pièges courants
- Sysmon **sans config** (bruit inexploitable).
- Config non versionnée / non mise à jour.
- Canal non forwardé → invisible dans le SIEM.
