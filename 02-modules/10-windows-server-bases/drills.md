# Drills — Windows Server bases

> Exercices courts (5-15 min). Setup minimal : une VM Windows Server jetable suffit.

## Drill 1 — GUI vs ligne de commande (10 min)
- **Objectif** : faire le même geste des deux façons.
- **Étapes** : renomme l'hôte via **Server Manager** (GUI), annule (rollback snapshot), puis
  refais-le avec `Rename-Computer`.
- **Observer** : le résultat est identique ; la commande est rejouable et scriptable.
- **Pourquoi** : c'est le fil conducteur du workbook (manuel → automatisé).

## Drill 2 — L'heure et Kerberos (5 min)
- **Objectif** : comprendre pourquoi l'horloge compte.
- **Étapes** : décale volontairement l'heure de +10 min (`Set-Date`), observe, puis `w32tm /resync`.
- **Observer** : note que Kerberos (vu plus tard) refuse un écart > 5 min.
- **Pourquoi** : 80 % des « ça marchait hier » en AD viennent de l'heure ou du DNS.

## Drill 3 — Lister et ajouter une fonctionnalité (10 min)
- **Objectif** : manipuler les rôles/fonctionnalités.
- **Étapes** :
  ```powershell
  Get-WindowsFeature | Where-Object Installed
  Install-WindowsFeature -Name RSAT-AD-PowerShell   # outils AD (sans promouvoir)
  ```
- **Observer** : un rôle/outil s'ajoute sans redémarrage ici.
- **Pourquoi** : `Install-WindowsFeature` est la brique de toute automatisation serveur.

## Drill 4 — Server Core à l'aveugle (15 min)
- **Objectif** : survivre sans GUI.
- **Étapes** : sur une VM **Core**, utilise `sconfig` puis PowerShell pour nommer + adresser la machine.
- **Observer** : tout est faisable sans interface — c'est le mode de prod.
- **Pourquoi** : réduire la surface d'attaque des DC.

## Drill break-fix — IP en double / mauvais DNS (10 min)
- **Casse** : règle le DNS client sur `127.0.0.1` alors qu'aucun service DNS ne tourne encore.
- **Diagnostique** : `Resolve-DnsName microsoft.com` échoue → `Get-DnsClientServerAddress`.
- **Répare** : repointe le DNS vers une résolution valide ; la résolution repart.
