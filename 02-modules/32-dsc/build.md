# Build — Configurer une machine avec DSC (dans CORP)

> On refait, en **déclaratif**, une partie de ce qu'on a fait à la main : installer/garantir un rôle
> et un service, puis garantir un réglage.

## Pré-requis
- PowerShell 5.1 disponible (pour les ressources AD historiques). Accès admin.

## Étape 1 — Installer des ressources DSC
```powershell
Install-Module ActiveDirectoryDsc, xDnsServer, NetworkingDsc, ComputerManagementDsc -Force
```

## Étape 2 — Écrire une configuration simple (rôle + service + registre)
```powershell
Configuration BaseServer {
  Import-DscResource -ModuleName PSDesiredStateConfiguration
  Node "localhost" {
    WindowsFeature DNS { Name = "DNS"; Ensure = "Present" }
    Service DnsRunning { Name = "DNS"; State = "Running"; DependsOn = "[WindowsFeature]DNS" }
    Registry Banner {
      Key = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
      ValueName = "legalnoticecaption"; ValueData = "Acces reserve"; ValueType = "String"; Ensure = "Present"
    }
  }
}
BaseServer -OutputPath .\mof     # compile -> .\mof\localhost.mof
```

## Étape 3 — Appliquer et vérifier
```powershell
Start-DscConfiguration -Path .\mof -Wait -Verbose -Force
Test-DscConfiguration            # True si conforme
Get-DscConfiguration             # état actuel selon DSC
```

## Étape 4 — Démontrer l'anti-dérive
```powershell
# Casser le réglage à la main...
Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" legalnoticecaption "HACKED"
Test-DscConfiguration            # -> False (dérive détectée)
Start-DscConfiguration -Path .\mof -Wait -Force   # DSC corrige
```

## Étape 5 — Configurer le LCM en auto-correction (option)
```powershell
[DSCLocalConfigurationManager()]
Configuration LcmAuto { Node "localhost" { Settings { ConfigurationMode = "ApplyAndAutoCorrect" } } }
LcmAuto -OutputPath .\lcm
Set-DscLocalConfigurationManager -Path .\lcm
```

## Vérification
```powershell
Test-DscConfiguration -Detailed | Select -ExpandProperty ResourcesNotInDesiredState
Get-DscLocalConfigurationManager | Select ConfigurationMode
```

## Pièges courants
- Ressources AD nécessitant 5.1 lancées en 7.x → erreurs (vérifier l'édition).
- Mettre des secrets en clair dans la config (utiliser le chiffrement par certificat).
