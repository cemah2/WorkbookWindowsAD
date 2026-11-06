# Build — Configurer sites, subnets et réplication (dans CORP)

## Pré-requis
- Au moins 2 DC sur 2 sites prévus (EMEA + AMER ; voir architecture.md). Module `ActiveDirectory`.

## Étape 1 — Créer les sites
```powershell
New-ADReplicationSite -Name "EMEA"
New-ADReplicationSite -Name "AMER"
New-ADReplicationSite -Name "APAC"
# (Le site par défaut peut être renommé en EMEA selon ton choix.)
```

## Étape 2 — Associer les subnets
```powershell
New-ADReplicationSubnet -Name "10.10.0.0/16" -Site "EMEA"
New-ADReplicationSubnet -Name "10.20.0.0/16" -Site "AMER"
New-ADReplicationSubnet -Name "10.30.0.0/16" -Site "APAC"
```

## Étape 3 — Déplacer les DC dans leur site
```powershell
Move-ADDirectoryServer -Identity "PAR-DC-01" -Site "EMEA"
Move-ADDirectoryServer -Identity "NYC-DC-01" -Site "AMER"
```

## Étape 4 — Site links (coût & intervalle)
```powershell
# Lien EMEA-AMER : coût 100, réplication toutes les 15 min
New-ADReplicationSiteLink -Name "EMEA-AMER" -SitesIncluded "EMEA","AMER" `
  -Cost 100 -ReplicationFrequencyInMinutes 15
New-ADReplicationSiteLink -Name "EMEA-APAC" -SitesIncluded "EMEA","APAC" `
  -Cost 300 -ReplicationFrequencyInMinutes 60
```

## Étape 5 — Forcer/observer la réplication
```powershell
repadmin /replsummary
repadmin /showrepl
repadmin /syncall /AdeP        # forcer une synchro complète (prudence en prod)
Get-ADReplicationPartnerMetadata -Target "PAR-DC-01" | Select Partner,LastReplicationSuccess
```

## Vérification
```powershell
dcdiag /test:replications
Get-ADReplicationSite -Filter * | Select Name
nltest /dsgetdc:corp.meridian.com   # vérifier la localisation de DC par site
```

## Pièges courants
- Oublier d'associer un **subnet** → clients "sans site" → authentification sur un DC distant.
- Coûts de site links incohérents → chemins de réplication sous-optimaux.
- `repadmin /syncall` agressif en prod.
