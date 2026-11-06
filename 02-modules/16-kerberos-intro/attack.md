# Attack — Aperçu des attaques Kerberos

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Introduction conceptuelle : l'exploitation complète
> (outils, pas-à-pas) est développée en Phase 5 (modules 52+). Ici, on relie chaque attaque au
> mécanisme vu dans `fiche.md`.

## Panorama
| Attaque | Principe | MITRE |
|---|---|---|
| **Kerberoasting** | Demander un ST pour un compte à SPN, casser le ST hors-ligne (RC4 facilite) | T1558.003 |
| **AS-REP roasting** | Compte sans pré-auth → AS-REP cassable hors-ligne | T1558.004 |
| **Golden Ticket** | Clé krbtgt volée → forger des TGT arbitraires | T1558.001 |
| **Silver Ticket** | Clé d'un service → forger un ST pour ce service | T1558.002 |
| **Overpass-the-Hash** | Hash NTLM → obtenir un TGT | T1550.002 |

## Démonstration minimale (observation, non destructive)
Lister les comptes Kerberoastables (lecture seule, déjà « la moitié » de l'attaque) :
```powershell
Get-ADUser -LDAPFilter "(servicePrincipalName=*)" -Properties servicePrincipalName
```
> Le vol/cassage de ticket proprement dit se fait en Phase 5 avec Rubeus/impacket, dans GOAD-X.

## Ancrage réel
Le Kerberoasting et le Golden Ticket sont emblématiques des intrusions AD (nombreux rapports
d'incidents et d'APT). Leur popularité vient du fait qu'ils exploitent le fonctionnement **normal**
de Kerberos, d'où l'importance de la détection.

## Résultat attendu
Comprendre quelle brique du protocole chaque attaque exploite — base des contre-mesures `defend.md`.
