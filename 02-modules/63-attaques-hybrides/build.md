# Build — Rejouer des pivots hybrides (lab/tenant de test)

> ⚠️ Tenant **de test** + lab isolé uniquement. Jamais sur un tenant de production.

## Pré-requis
- CORP + Entra Connect (modules 61-62). Outils : AADInternals, ROADtools/roadtx, Microsoft.Graph.

## Étape 1 — On-prem → cloud via creds de synchro (principe)
```powershell
# Sur le serveur Entra Connect compromis (lab) :
Import-Module AADInternals
$creds = Get-AADIntSyncCredentials      # extrait les creds de synchro (lab)
# -> montre le compte de synchro cloud (souvent très privilégié) + MSOL_ on-prem (DCSync-like)
```

## Étape 2 — AZUREADSSOACC$ → Silver Ticket cloud (principe)
Avec le hash d'AZUREADSSOACC$ (dump on-prem), forger un ticket Kerberos accepté par Seamless SSO →
token cloud. (Outils AADInternals.)

## Étape 3 — Pass-the-PRT (poste HAADJ, lab)
```bash
# Extraire le PRT + session key (si TPM absent) puis obtenir des tokens
roadtx browserprtauth       # exemples ROADtools (lab)
# -> access token Graph en tant que la victime
```

## Étape 4 — Illicit consent grant (app malveillante)
```powershell
# Créer une app demandant des scopes Graph élevés, pousser le consent à une victime (lab),
# puis utiliser le refresh token pour accéder aux données.
```

## Étape 5 — Cloud → on-prem (Intune)
Si Intune/Endpoint Manager est compromis (rôle cloud) : pousser un script/app aux machines gérées →
exécution on-prem. (Démontrer le principe en lab.)

## Étape 6 — Détecter + durcir
Pour chaque pivot, observer les logs Entra (sign-in/audit) et appliquer le durcissement (module 64 +
defend.md), puis re-tester.

## Vérification
- Au moins un pivot hybride démontré (lab) et sa trace identifiée dans les logs.

## Pièges courants
- Jouer ça sur un **tenant de prod** (interdit).
- Oublier que le serveur Connect et ADFS sont Tier 0 (les protéger = couper la plupart des pivots).
