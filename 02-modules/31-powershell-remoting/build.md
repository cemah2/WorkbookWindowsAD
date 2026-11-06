# Build — Administrer à l'échelle avec le remoting (dans CORP)

## Pré-requis
- Remoting activé sur les cibles (`Enable-PSRemoting`, ou GPO). Compte d'admin adapté au tier.

## Étape 1 — Activer le remoting à l'échelle (GPO)
GPO liée aux serveurs : *Windows Remote Management (WinRM)* → *Allow remote server management
through WinRM*, service WinRM en démarrage automatique, règle pare-feu WinRM. (Évite d'ouvrir WinRM
partout : cible les OU de serveurs.)

## Étape 2 — Exécution ponctuelle (fan-out)
```powershell
$servers = "PAR-FS-01","NYC-FS-01"
Invoke-Command -ComputerName $servers -ScriptBlock {
  Get-Service -Name Spooler | Select-Object MachineName, Status
}
```

## Étape 3 — Sessions persistantes (plus efficace pour plusieurs actions)
```powershell
$sessions = New-PSSession -ComputerName $servers
Invoke-Command -Session $sessions { $env:COMPUTERNAME; (Get-CimInstance Win32_OperatingSystem).Caption }
# ... autres commandes réutilisant $sessions ...
Remove-PSSession $sessions
```

## Étape 4 — JEA : déléguer sans donner l'admin
```powershell
# Capabilities : définir les cmdlets autorisées (fichier .psrc)
New-PSRoleCapabilityFile -Path .\OpsRole.psrc -VisibleCmdlets 'Restart-Service','Get-Service'
# Session config (fichier .pssc) qui mappe un groupe à ce rôle
New-PSSessionConfigurationFile -Path .\JEA.pssc -SessionType RestrictedRemoteServer `
  -RunAsVirtualAccount -RoleDefinitions @{ 'CORP\T1_Ops' = @{ RoleCapabilities='OpsRole' } }
Register-PSSessionConfiguration -Name "JEA_Ops" -Path .\JEA.pssc -Force
# L'utilisateur se connecte à l'endpoint restreint :
# Enter-PSSession -ComputerName PAR-FS-01 -ConfigurationName JEA_Ops
```

## Étape 5 — Gérer le double-hop proprement
Préférer la **délégation Kerberos contrainte / resource-based** (module 53 en P5 pour l'abus ;
ici l'usage légitime) plutôt que CredSSP.

## Vérification
```powershell
Test-WSMan -ComputerName PAR-FS-01
Invoke-Command -ComputerName PAR-FS-01 { $PSSenderInfo.ConnectedUser }   # qui suis-je côté cible
Get-PSSessionConfiguration | Select Name, Permission
```

## Pièges courants
- Ouvrir WinRM à tout le monde (segmenter, limiter aux postes d'admin).
- Utiliser **CredSSP** par facilité (expose les credentials) au lieu de la délégation contrainte.
- Oublier le respect du **tiering** (un compte T0 ne fait pas de remoting vers du T2, etc.).
