# Build — Déployer DHCP (dans CORP)

## Pré-requis
- `corp.meridian.com` opérationnel. On installe DHCP sur `PAR-DC-01` (lab) ou un serveur dédié.

## Étape 1 — Installer le rôle
```powershell
Install-WindowsFeature DHCP -IncludeManagementTools
```

## Étape 2 — Autoriser dans AD (indispensable)
```powershell
Add-DhcpServerInDC -DnsName "par-dc-01.corp.meridian.com" -IPAddress 10.10.0.10
# Marquer la post-install comme terminée
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12" -Name ConfigurationState -Value 2
```

## Étape 3 — Créer une étendue EMEA
```powershell
Add-DhcpServerv4Scope -Name "EMEA-Clients" -StartRange 10.10.10.100 -EndRange 10.10.10.200 `
  -SubnetMask 255.255.0.0 -State Active
Set-DhcpServerv4OptionValue -ScopeId 10.10.10.0 -Router 10.10.0.1 `
  -DnsServer 10.10.0.10 -DnsDomain "corp.meridian.com"
```

## Étape 4 — Réservation (ex. une imprimante)
```powershell
Add-DhcpServerv4Reservation -ScopeId 10.10.10.0 -IPAddress 10.10.10.150 `
  -ClientId "aa-bb-cc-dd-ee-ff" -Name "PRN-EMEA-01"
```

## Étape 5 — (option) Failover avec un 2e serveur
```powershell
Add-DhcpServerv4Failover -Name "EMEA-FO" -PartnerServer "par-srv-02.corp.meridian.com" `
  -ScopeId 10.10.10.0 -LoadBalancePercent 50
```

## Vérification
```powershell
Get-DhcpServerInDC
Get-DhcpServerv4Scope
Get-DhcpServerv4OptionValue -ScopeId 10.10.10.0
# Côté client : ipconfig /renew puis ipconfig /all
```

## Pièges courants
- Oublier l'**autorisation AD** → le serveur ne distribue rien.
- Masque/plage incohérents avec le plan d'adressage (`architecture.md`).
