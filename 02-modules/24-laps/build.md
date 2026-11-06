# Build — Déployer Windows LAPS (dans CORP)

## Pré-requis
- AD opérationnel ; machines sous Windows récent (LAPS intégré). Droits d'admin de schéma (Tier 0).

## Étape 1 — Étendre le schéma (une fois par forêt)
```powershell
Import-Module LAPS
Update-LapsADSchema
```

## Étape 2 — Autoriser les machines à écrire + un groupe à lire
```powershell
$ou = "OU=Workstations,DC=corp,DC=meridian,DC=com"
# Les ordinateurs de l'OU peuvent écrire leur mot de passe LAPS
Set-LapsADComputerSelfPermission -Identity $ou
# Un groupe d'admin (ex. T2_Admins) peut lire le mot de passe
Set-LapsADReadPasswordPermission -Identity $ou -AllowedPrincipals "CORP\T2_Admins"
```

## Étape 3 — GPO de politique LAPS
Crée une GPO liée à l'OU des machines :
*Computer Configuration → Policies → Administrative Templates → System → LAPS* →
- Configure *Password backup directory* = **Active Directory** (ou Azure AD/Entra en P6).
- Longueur (ex. 20), complexité, âge (ex. 30 j), **activer le chiffrement** et désigner le groupe
  autorisé à déchiffrer.
- Rotation après lecture (optionnel mais recommandé).

## Étape 4 — Appliquer et vérifier la remontée
```powershell
# Sur une machine cible :
gpupdate /force
Invoke-LapsPolicyProcessing     # force le traitement LAPS

# Récupérer le mot de passe (depuis un poste d'admin autorisé) :
Get-LapsADPassword -Identity "PAR-WS-01" -AsPlainText
```

## Étape 5 — Forcer une rotation
```powershell
Reset-LapsPassword              # sur la machine, force un nouveau mot de passe
```

## Vérification
```powershell
Get-LapsADPassword -Identity "PAR-WS-01" | Select Account, PasswordExpirationTimestamp
```

## Pièges courants
- Oublier d'étendre le schéma / de donner le self-permission aux machines → pas de remontée.
- Donner la lecture à un groupe trop large (tout le monde lit les mots de passe locaux).
- Confondre Legacy LAPS et Windows LAPS (attributs/ADMX différents).
