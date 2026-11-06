# Drills — Objets AD

> Exercices courts sur un domaine de lab (snapshot avant si tu veux rejouer).

## Drill 1 — SID et RID bien connus (10 min)
- **Étapes** :
  ```powershell
  Get-ADUser Administrator | Select SID
  Get-ADGroup "Domain Admins" | Select SID
  ```
  Repère le suffixe `-500` (Administrator) et `-512` (Domain Admins).
- **Pourquoi** : les RID fixes identifient les comptes sensibles indépendamment du nom.

## Drill 2 — Portée de groupe en pratique (10 min)
- **Étapes** : tente d'ajouter un groupe **global** d'un autre (futur) domaine dans un groupe
  global local → échec ; refais avec un **domain local** → ok.
- **Observer** : les règles d'imbrication par portée.
- **Pourquoi** : comprendre AGDLP par l'erreur.

## Drill 3 — Recherche LDAP ciblée (10 min)
- **Étapes** :
  ```powershell
  Get-ADUser -Filter {Enabled -eq $true} -Properties lastLogonDate | Select Name,lastLogonDate
  Get-ADUser -LDAPFilter "(servicePrincipalName=*)" | Select Name   # comptes avec SPN
  ```
- **Observer** : les comptes avec SPN = futures cibles Kerberoasting (P5).

## Drill 4 — Créer 10 utilisateurs en boucle (10 min)
- **Étapes** : génère 10 comptes de test via une boucle `foreach` + `New-ADUser`.
- **Pourquoi** : premier pas vers l'automatisation d'administration (Phase 3).

## Drill break-fix — Compte verrouillé / désactivé (10 min)
- **Casse** : désactive `jon.snow` et/ou provoque un verrouillage (mauvais mots de passe).
- **Diagnostique** : `Get-ADUser jon.snow -Properties Enabled,LockedOut,LastBadPasswordAttempt`.
- **Répare** : `Enable-ADAccount` / `Unlock-ADAccount`, et vérifie.
