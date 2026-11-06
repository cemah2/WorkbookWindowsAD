# Solution GOAD — BadSuccessor : escalade via dMSA (Server 2025)

> Amélioration proposée à GOAD (PROJECT.md §10) : ajouter un DC **Windows Server 2025** pour couvrir les
> **dMSA** et l'escalade **BadSuccessor** (2025). Write-up : mise en place, exploitation, détection,
> remédiation. Lab isolé uniquement.

## 1. Résumé
Sur un domaine avec au moins un DC **Windows Server 2025**, un attaquant disposant du droit de **créer**
un objet **dMSA** (delegated Managed Service Account) dans une OU — ou d'écrire ses attributs de
succession — peut désigner ce dMSA comme **successeur** d'un compte **privilégié** (ex. Domain Admin).
Le KDC accorde alors au dMSA le **contexte d'authentification** du compte ciblé → escalade vers Domain
Admin **sans compromettre** directement ce compte. C'est **BadSuccessor** (publié par Akamai en 2025).

## 2. Pourquoi l'ajouter à GOAD
GOAD cible des versions antérieures : il ne couvre pas les dMSA. Ajouter un DC 2025 (ou une extension)
permet de pratiquer une **escalade récente et à fort impact**, et d'illustrer « nouvelle feature =
nouvelle surface ».

## 3. Pré-requis (côté cible)
- Au moins un DC **Windows Server 2025** (les dMSA en dépendent).
- Un principal avec **CreateChild** pour la classe `msDS-DelegatedManagedServiceAccount` sur une OU, ou
  **GenericAll/WriteDacl** permettant d'écrire les attributs du dMSA.

## 4. Cause racine
- **ACL trop permissive** permettant à un non-admin de créer/configurer un dMSA, combinée au mécanisme de
  **succession** des dMSA qui transfère le contexte d'authentification du compte « précédé ».

## 5. Exploitation (principe, lab isolé)
1. Recon : trouver une OU où l'on peut créer un dMSA (`Find-DmsaRisk.ps1`, module 91 ; ou outils publiés).
2. Créer un dMSA dans cette OU.
3. Écrire l'attribut de succession (`msDS-ManagedAccountPrecededByLink`) pointant vers un compte
   privilégié (ex. Administrator).
4. S'authentifier en tant que le dMSA → obtenir un TGT/contexte du compte ciblé → Domain Admin.

## 6. Impact
Escalade vers Domain Admin depuis des droits relativement modestes (écriture sur une OU) → compromission
du domaine.

## 7. Détection
| Étape | Signal | Source |
|---|---|---|
| Création du dMSA | nouvel objet dMSA | Security 5137 / 4741 |
| Lien de succession écrit | msDS-ManagedAccountPrecededByLink | Security 5136 |
| Auth du dMSA | TGT/TGS pour le dMSA | Security 4768/4769 |

Règle Sigma : voir `02-modules/91-server-2025-nouveautes/defend.md`.

## 8. Remédiation
1. **Restreindre la création de dMSA** : auditer/limiter CreateChild `msDS-DelegatedManagedServiceAccount`
   sur toutes les OU ; traiter ce droit comme **Tier 0**.
2. **ACL propres** (pas de GenericAll/WriteDacl non justifié) — module 21.
3. **Surveiller** les attributs de succession ; appliquer les **correctifs** Microsoft.
4. Revue régulière (BloodHound/PingCastle intègrent progressivement ce vecteur).

## 9. Validation (boucle purple team)
Après remédiation : re-tenter → la création/écriture du dMSA échoue pour un non-admin ; confirmer
l'absence de 5137/5136 et l'échec de l'escalade.

## 10. Pour aller plus loin
Recherche BadSuccessor (Akamai, Tarlogic), MS Learn Server 2025. Modules liés :
`91-server-2025-nouveautes`, `21-ou-delegation`, `23-groupes-agdlp`.
