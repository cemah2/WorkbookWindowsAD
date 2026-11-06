# Build — Déployer un RODC (agence Lyon) dans CORP

## Pré-requis
- Forêt opérationnelle ; un serveur préparé `LYO-RODC-01` (module 10) sur le site/VLAN Lyon (40).
- Site "Lyon" + subnet créés (module 26).

## Étape 1 — (option) Site Lyon
```powershell
New-ADReplicationSite -Name "Lyon"
New-ADReplicationSubnet -Name "10.40.0.0/16" -Site "Lyon"
New-ADReplicationSiteLink -Name "EMEA-Lyon" -SitesIncluded "EMEA","Lyon" -Cost 500 -ReplicationFrequencyInMinutes 60
```

## Étape 2 — Promouvoir en RODC
```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
$dsrm = Read-Host -AsSecureString "Mot de passe DSRM"
Install-ADDSDomainController -DomainName "corp.meridian.com" -ReadOnlyReplica `
  -SiteName "Lyon" -InstallDns -SafeModeAdministratorPassword $dsrm -Force
```

## Étape 3 — Configurer la PRP (qui peut être mis en cache)
```powershell
# Autoriser la mise en cache des utilisateurs de l'agence Lyon uniquement
Add-ADGroupMember -Identity "Allowed RODC Password Replication Group" -Members "R_Lyon_Users"
# S'assurer que les comptes sensibles sont EXPLICITEMENT refusés (déjà le cas par défaut)
Get-ADGroupMember "Denied RODC Password Replication Group"
```

## Étape 4 — Vérifier les comptes révélés / en cache
```powershell
# Comptes dont le secret est actuellement mis en cache sur le RODC
Get-ADDomainControllerPasswordReplicationPolicyUsage -Identity "LYO-RODC-01" -RevealedAccounts
# Politique effective
Get-ADDomainControllerPasswordReplicationPolicy -Identity "LYO-RODC-01" -Allowed
Get-ADDomainControllerPasswordReplicationPolicy -Identity "LYO-RODC-01" -Denied
```

## Vérification
```powershell
Get-ADDomainController -Identity "LYO-RODC-01" | Select Name, IsReadOnly, Site
# Un utilisateur Lyon s'authentifie localement ; un compte sensible n'est jamais mis en cache
```

## Pièges courants
- PRP "Allowed" trop large (ne jamais autoriser les comptes Tier 0/sensibles).
- Oublier que le RODC a son propre krbtgt.
- Placer le RODC dans le mauvais site → pas de localité.
