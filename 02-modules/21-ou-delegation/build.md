# Build — Déléguer proprement l'administration (dans CORP)

## Pré-requis
- Structure d'OU (module 14) : OU géographiques + groupes de rôle.

## Étape 1 — Créer le groupe de délégation
```powershell
$base = "DC=corp,DC=meridian,DC=com"
New-ADGroup -Name "T2_EMEA_Support" -GroupScope Global -GroupCategory Security `
  -Path "OU=Roles,OU=Groups,$base" -Description "Support postes/users EMEA (Tier 2)"
```

## Étape 2 — Déléguer "réinitialiser le mot de passe" (GUI)
Dans **ADUC** : clic droit sur `OU=EMEA,OU=Employees` → **Delegate Control** → ajoute
`T2_EMEA_Support` → tâche "Reset user passwords and force password change".

## Étape 3 — La même délégation en ligne de commande (dsacls)
```cmd
dsacls "OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com" /I:S ^
  /G "CORP\T2_EMEA_Support:CA;Reset Password;user"
:: /I:S = hérité par les objets de ce type ; CA = Control Access (droit étendu)
```
Déléguer aussi l'écriture de pwdLastSet/unlock si besoin (lockoutTime) selon la tâche.

## Étape 4 — Vérifier la délégation
```powershell
# Lister les ACE non héritées sur l'OU
(Get-Acl "AD:OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com").Access |
  Where-Object { -not $_.IsInherited } |
  Select IdentityReference, ActiveDirectoryRights, ObjectType, AccessControlType
```
Teste concrètement : connecte-toi avec un membre de `T2_EMEA_Support`, réinitialise le mot de
passe d'un user EMEA (OK) puis tente sur un user AMER (refusé) et sur un admin (refusé).

## Étape 5 — Nettoyer une délégation
```powershell
dsacls "OU=EMEA,OU=Employees,DC=corp,DC=meridian,DC=com" /R "CORP\T2_EMEA_Support"
```

## Vérification
- Un membre du groupe peut faire **uniquement** la tâche déléguée, **uniquement** sur l'OU visée.

## Pièges courants
- Déléguer "Full Control" au lieu d'une tâche précise → sur-privilège massif.
- Déléguer sur une OU qui contient aussi des comptes sensibles.
- Oublier que SDProp annulera toute ACL posée sur les comptes protégés.
