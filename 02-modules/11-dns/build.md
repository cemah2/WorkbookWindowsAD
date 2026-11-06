# Build — Configurer et fiabiliser le DNS (dans CORP)

> Le rôle DNS a été posé avec le premier DC (module 13). Ici on l'approfondit : zone inverse,
> forwarders, mises à jour sécurisées, nettoyage, et vérifs.

## Pré-requis
- `PAR-DC-01` promu, zone `corp.meridian.com` existante (module 13).
- Module PowerShell `DnsServer` disponible (`Install-WindowsFeature RSAT-DNS-Server` si besoin).

## Étape 1 — Vérifier la zone directe
```powershell
Get-DnsServerZone
Get-DnsServerResourceRecord -ZoneName "corp.meridian.com" -RRType A | Select HostName,RecordData
```

## Étape 2 — Créer la zone inverse (PTR)
```powershell
# Pour le sous-réseau EMEA 10.10.0.0/16 (ajuste selon ton plan d'adressage)
Add-DnsServerPrimaryZone -NetworkId "10.10.0.0/16" -ReplicationScope "Domain" -DynamicUpdate Secure
# Enregistrer le PTR du DC
Add-DnsServerResourceRecordPtr -ZoneName "0.10.10.in-addr.arpa" -Name "10" `
  -PtrDomainName "par-dc-01.corp.meridian.com"   # adapte selon la découpe de zone inverse
```

## Étape 3 — Forwarders (résolution externe)
```powershell
# Vers OPNsense ou un résolveur autorisé dans le lab
Set-DnsServerForwarder -IPAddress 10.10.0.1 -UseRootHint $true
```

## Étape 4 — Mises à jour dynamiques SÉCURISÉES uniquement
```powershell
Set-DnsServerPrimaryZone -Name "corp.meridian.com" -DynamicUpdate "Secure"
```

## Étape 5 — Aging / Scavenging (nettoyage)
```powershell
Set-DnsServerScavenging -ScavengingState $true -RefreshInterval 7.00:00:00 `
  -NoRefreshInterval 7.00:00:00 -ApplyOnAllZones
```

## Étape 6 — Conditional forwarder (préparation trusts, Phase 5)
```powershell
# Exemple pour la future forêt M&A nimbus.local
Add-DnsServerConditionalForwarderZone -Name "nimbus.local" -MasterServers 10.60.0.10 `
  -ReplicationScope "Forest"
```

## Vérification
```powershell
Resolve-DnsName par-dc-01.corp.meridian.com
Resolve-DnsName -Type PTR 10.10.0.10
Resolve-DnsName -Type SRV _kerberos._tcp.corp.meridian.com
Resolve-DnsName microsoft.com          # test du forwarder
dcdiag /test:DNS /v
```

## Pièges courants
- Mises à jour dynamiques laissées sur "Nonsecure and secure" → risque d'usurpation.
- Oublier la zone inverse → certains outils/dépannages deviennent pénibles.
- Forwarder vers un résolveur non joignable → résolution externe cassée.
